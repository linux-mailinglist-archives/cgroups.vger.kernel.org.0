Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D970F33E2E8
	for <lists+cgroups@lfdr.de>; Wed, 17 Mar 2021 01:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbhCQAhH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Mar 2021 20:37:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45377 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229955AbhCQAgc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Mar 2021 20:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615941387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=q+WBXT2Z0GX5Wb5Zd+rdqHW22JpjwdirbYKXvw2UcrI=;
        b=jJYLiV9lg09U1snUyWiFs9AFQFaWMnGh2yNKjSqD8BmLjywzi4hr/D5K7wOVavHtdWoboH
        c/lhV1XBb1XHOVI0pRS+zr+7jpQ3LZ8VeiHgExXvAeSj3PYeM11JwKW2+n3PNH1T1SE1XA
        25qVOt7BRqw9nhN8EgTk2HLYXaCUWnM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-tQh8DwWuOwOKSt4ZJMGVhw-1; Tue, 16 Mar 2021 20:36:23 -0400
X-MC-Unique: tQh8DwWuOwOKSt4ZJMGVhw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B44378030D7;
        Wed, 17 Mar 2021 00:36:20 +0000 (UTC)
Received: from rtux.redhat.com (unknown [10.33.36.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B02F6C32E;
        Wed, 17 Mar 2021 00:36:17 +0000 (UTC)
From:   Alexey Klimov <aklimov@redhat.com>
To:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Cc:     peterz@infradead.org, yury.norov@gmail.com,
        daniel.m.jordan@oracle.com, tglx@linutronix.de, jobaker@redhat.com,
        audralmitchel@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        rafael@kernel.org, tj@kernel.org, qais.yousef@arm.com,
        hannes@cmpxchg.org, klimov.linux@gmail.com
Subject: [PATCH v3] cpu/hotplug: wait for cpuset_hotplug_work to finish on cpu onlining
Date:   Wed, 17 Mar 2021 00:36:16 +0000
Message-Id: <20210317003616.2817418-1-aklimov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When a CPU offlined and onlined via device_offline() and device_online()
the userspace gets uevent notification. If, after receiving "online" uevent,
userspace executes sched_setaffinity() on some task trying to move it
to a recently onlined CPU, then it sometimes fails with -EINVAL. Userspace
needs to wait around 5..30 ms before sched_setaffinity() will succeed for
recently onlined CPU after receiving uevent.

If in_mask argument for sched_setaffinity() has only recently onlined CPU,
it could fail with such flow:

  sched_setaffinity()
    cpuset_cpus_allowed()
      guarantee_online_cpus()   <-- cs->effective_cpus mask does not
                                        contain recently onlined cpu
    cpumask_and()               <-- final new_mask is empty
    __set_cpus_allowed_ptr()
      cpumask_any_and_distribute() <-- returns dest_cpu equal to nr_cpu_ids
      returns -EINVAL

Cpusets used in guarantee_online_cpus() are updated using workqueue from
cpuset_update_active_cpus() which in its turn is called from cpu hotplug callback
sched_cpu_activate() hence it may not be observable by sched_setaffinity() if
it is called immediately after uevent.

Out of line uevent can be avoided if we will ensure that cpuset_hotplug_work
has run to completion using cpuset_wait_for_hotplug() after onlining the
cpu in cpu_device_up() and in cpuhp_smt_enable().

Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
Reviewed-by: Qais Yousef <qais.yousef@arm.com>
Co-analyzed-by: Joshua Baker <jobaker@redhat.com>
Signed-off-by: Alexey Klimov <aklimov@redhat.com>
---

Changes since v2:
	- restore cpuhp_{online,offline}_cpu_device back and move it out
		of cpu maps lock;
	- use Reviewed-by from Qais;
	- minor corrections in commit message and in comment in code.

Changes since v1:
	- cpuset_wait_for_hotplug() moved to cpu_device_up();
	- corrections in comments;
	- removed cpuhp_{online,offline}_cpu_device.

Changes since RFC:
	- cpuset_wait_for_hotplug() used in cpuhp_smt_enable().

Previous patches and discussion are:
RFC patch: https://lore.kernel.org/lkml/20201203171431.256675-1-aklimov@redhat.com/
v1 patch:  https://lore.kernel.org/lkml/20210204010157.1823669-1-aklimov@redhat.com/
v2 patch: https://lore.kernel.org/lkml/20210212003032.2037750-1-aklimov@redhat.com/

The commit a49e4629b5ed "cpuset: Make cpuset hotplug synchronous"
would also get rid of the early uevent but it was reverted (deadlocks).

The nature of this bug is also described here (with different consequences):
https://lore.kernel.org/lkml/20200211141554.24181-1-qais.yousef@arm.com/

Reproducer: https://gitlab.com/0xeafffffe/xlam

Currently with such changes the reproducer code continues to work without issues.
The idea is to avoid the situation when userspace receives the event about
onlined CPU which is not ready to take tasks for a while after uevent.

 kernel/cpu.c | 74 +++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 56 insertions(+), 18 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 1b6302ecbabe..9b091d8a8811 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -15,6 +15,7 @@
 #include <linux/sched/smt.h>
 #include <linux/unistd.h>
 #include <linux/cpu.h>
+#include <linux/cpuset.h>
 #include <linux/oom.h>
 #include <linux/rcupdate.h>
 #include <linux/export.h>
@@ -1301,7 +1302,17 @@ static int cpu_up(unsigned int cpu, enum cpuhp_state target)
  */
 int cpu_device_up(struct device *dev)
 {
-	return cpu_up(dev->id, CPUHP_ONLINE);
+	int err;
+
+	err = cpu_up(dev->id, CPUHP_ONLINE);
+	/*
+	 * Wait for cpuset updates to cpumasks to finish.  Later on this path
+	 * may generate uevents whose consumers rely on the updates.
+	 */
+	if (!err)
+		cpuset_wait_for_hotplug();
+
+	return err;
 }
 
 int add_cpu(unsigned int cpu)
@@ -2084,8 +2095,13 @@ static void cpuhp_online_cpu_device(unsigned int cpu)
 
 int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 {
-	int cpu, ret = 0;
+	cpumask_var_t mask;
+	int cpu, ret;
 
+	if (!zalloc_cpumask_var(&mask, GFP_KERNEL))
+		return -ENOMEM;
+
+	ret = 0;
 	cpu_maps_update_begin();
 	for_each_online_cpu(cpu) {
 		if (topology_is_primary_thread(cpu))
@@ -2093,31 +2109,42 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 		ret = cpu_down_maps_locked(cpu, CPUHP_OFFLINE);
 		if (ret)
 			break;
-		/*
-		 * As this needs to hold the cpu maps lock it's impossible
-		 * to call device_offline() because that ends up calling
-		 * cpu_down() which takes cpu maps lock. cpu maps lock
-		 * needs to be held as this might race against in kernel
-		 * abusers of the hotplug machinery (thermal management).
-		 *
-		 * So nothing would update device:offline state. That would
-		 * leave the sysfs entry stale and prevent onlining after
-		 * smt control has been changed to 'off' again. This is
-		 * called under the sysfs hotplug lock, so it is properly
-		 * serialized against the regular offline usage.
-		 */
-		cpuhp_offline_cpu_device(cpu);
+
+		cpumask_set_cpu(cpu, mask);
 	}
 	if (!ret)
 		cpu_smt_control = ctrlval;
 	cpu_maps_update_done();
+
+	/*
+	 * When the cpu maps lock was taken above it was impossible
+	 * to call device_offline() because that ends up calling
+	 * cpu_down() which takes cpu maps lock. cpu maps lock
+	 * needed to be held as this might race against in-kernel
+	 * abusers of the hotplug machinery (thermal management).
+	 *
+	 * So nothing would update device:offline state. That would
+	 * leave the sysfs entry stale and prevent onlining after
+	 * smt control has been changed to 'off' again. This is
+	 * called under the sysfs hotplug lock, so it is properly
+	 * serialized against the regular offline usage.
+	 */
+	for_each_cpu(cpu, mask)
+		cpuhp_offline_cpu_device(cpu);
+
+	free_cpumask_var(mask);
 	return ret;
 }
 
 int cpuhp_smt_enable(void)
 {
-	int cpu, ret = 0;
+	cpumask_var_t mask;
+	int cpu, ret;
+
+	if (!zalloc_cpumask_var(&mask, GFP_KERNEL))
+		return -ENOMEM;
 
+	ret = 0;
 	cpu_maps_update_begin();
 	cpu_smt_control = CPU_SMT_ENABLED;
 	for_each_present_cpu(cpu) {
@@ -2128,9 +2155,20 @@ int cpuhp_smt_enable(void)
 		if (ret)
 			break;
 		/* See comment in cpuhp_smt_disable() */
-		cpuhp_online_cpu_device(cpu);
+		cpumask_set_cpu(cpu, mask);
 	}
 	cpu_maps_update_done();
+
+	/*
+	 * Wait for cpuset updates to cpumasks to finish.  Later on this path
+	 * may generate uevents whose consumers rely on the updates.
+	 */
+	cpuset_wait_for_hotplug();
+
+	for_each_cpu(cpu, mask)
+		cpuhp_online_cpu_device(cpu);
+
+	free_cpumask_var(mask);
 	return ret;
 }
 #endif
-- 
2.31.0


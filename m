Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E250730E91C
	for <lists+cgroups@lfdr.de>; Thu,  4 Feb 2021 02:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbhBDBDg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 3 Feb 2021 20:03:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54345 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233947AbhBDBDc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 3 Feb 2021 20:03:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612400525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZAkXTLCQatITvM0DWGh6kbF0oAf7mL4HuXS0UNtLhwE=;
        b=NiU+0emwcXPYLWUe/PZUq4Bm2SxEeL+YJH1O2iyOVfTMoqvZyB6YKHqWPXAXt1w4K2k4Cs
        Pzu05ss3E7Yc7ClhfhttllrdfOmOjyW0zbxaf3ibReR8LMIH3Ln1/OQ8bqig6tYHX7AAsH
        fZ5nm8NmxPL0KeSG1TKxzngtewBIdyk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-1k45HRQEPvWzPMc1PSl6Hg-1; Wed, 03 Feb 2021 20:02:04 -0500
X-MC-Unique: 1k45HRQEPvWzPMc1PSl6Hg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 666E515725;
        Thu,  4 Feb 2021 01:02:01 +0000 (UTC)
Received: from rtux.redhat.com (unknown [10.33.36.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA040779DB;
        Thu,  4 Feb 2021 01:01:57 +0000 (UTC)
From:   Alexey Klimov <aklimov@redhat.com>
To:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Cc:     peterz@infradead.org, yury.norov@gmail.com,
        daniel.m.jordan@oracle.com, tglx@linutronix.de, jobaker@redhat.com,
        audralmitchel@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        rafael@kernel.org, tj@kernel.org, lizefan@huawei.com,
        qais.yousef@arm.com, hannes@cmpxchg.org, klimov.linux@gmail.com
Subject: [PATCH] cpu/hotplug: wait for cpuset_hotplug_work to finish on cpu onlining
Date:   Thu,  4 Feb 2021 01:01:57 +0000
Message-Id: <20210204010157.1823669-1-aklimov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When a CPU offlined and onlined via device_offline() and device_online()
the userspace gets uevent notification. If, after receiving "online" uevent,
userspace executes sched_setaffinity() on some task trying to move it
to a recently onlined CPU, then it often fails with -EINVAL. Userspace needs
to wait around 5..30 ms before sched_setaffinity() will succeed for the recently
onlined CPU after receiving uevent.

If in_mask argument for sched_setaffinity() has only recently onlined CPU,
it often fails with such flow:

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
cpu in cpu_up() and in cpuhp_smt_enable().

Co-analyzed-by: Joshua Baker <jobaker@redhat.com>
Signed-off-by: Alexey Klimov <aklimov@redhat.com>
---

Previous RFC patch and discussion is here:
https://lore.kernel.org/lkml/20201203171431.256675-1-aklimov@redhat.com/

The commit a49e4629b5ed "cpuset: Make cpuset hotplug synchronous"
would also get rid of the early uevent but it was reverted (deadlocks).

The nature of this bug is also described here (with different consequences):
https://lore.kernel.org/lkml/20200211141554.24181-1-qais.yousef@arm.com/

Reproducer: https://gitlab.com/0xeafffffe/xlam

Currently with such changes the reproducer code continues to work without issues.
The idea is to avoid the situation when userspace receives the event about
onlined CPU which is not ready to take tasks for a while after uevent.


 kernel/cpu.c | 47 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 4e11e91010e1..ea728e75a74d 100644
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
@@ -1281,6 +1282,11 @@ static int cpu_up(unsigned int cpu, enum cpuhp_state target)
 	err = _cpu_up(cpu, 0, target);
 out:
 	cpu_maps_update_done();
+
+	/* To avoid out of line uevent */
+	if (!err)
+		cpuset_wait_for_hotplug();
+
 	return err;
 }
 
@@ -2062,8 +2068,6 @@ static void cpuhp_offline_cpu_device(unsigned int cpu)
 	struct device *dev = get_cpu_device(cpu);
 
 	dev->offline = true;
-	/* Tell user space about the state change */
-	kobject_uevent(&dev->kobj, KOBJ_OFFLINE);
 }
 
 static void cpuhp_online_cpu_device(unsigned int cpu)
@@ -2071,14 +2075,18 @@ static void cpuhp_online_cpu_device(unsigned int cpu)
 	struct device *dev = get_cpu_device(cpu);
 
 	dev->offline = false;
-	/* Tell user space about the state change */
-	kobject_uevent(&dev->kobj, KOBJ_ONLINE);
 }
 
 int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 {
-	int cpu, ret = 0;
+	struct device *dev;
+	cpumask_var_t mask;
+	int cpu, ret;
+
+	if (!zalloc_cpumask_var(&mask, GFP_KERNEL))
+                return -ENOMEM;
 
+	ret = 0;
 	cpu_maps_update_begin();
 	for_each_online_cpu(cpu) {
 		if (topology_is_primary_thread(cpu))
@@ -2100,17 +2108,32 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 		 * serialized against the regular offline usage.
 		 */
 		cpuhp_offline_cpu_device(cpu);
+		cpumask_set_cpu(cpu, mask);
 	}
 	if (!ret)
 		cpu_smt_control = ctrlval;
 	cpu_maps_update_done();
+
+	/* Tell user space about the state changes */
+	for_each_cpu(cpu, mask) {
+		dev = get_cpu_device(cpu);
+		kobject_uevent(&dev->kobj, KOBJ_OFFLINE);
+	}
+
+	free_cpumask_var(mask);
 	return ret;
 }
 
 int cpuhp_smt_enable(void)
 {
-	int cpu, ret = 0;
+	struct device *dev;
+	cpumask_var_t mask;
+	int cpu, ret;
 
+	if (!zalloc_cpumask_var(&mask, GFP_KERNEL))
+                return -ENOMEM;
+
+	ret = 0;
 	cpu_maps_update_begin();
 	cpu_smt_control = CPU_SMT_ENABLED;
 	for_each_present_cpu(cpu) {
@@ -2122,8 +2145,20 @@ int cpuhp_smt_enable(void)
 			break;
 		/* See comment in cpuhp_smt_disable() */
 		cpuhp_online_cpu_device(cpu);
+		cpumask_set_cpu(cpu, mask);
 	}
 	cpu_maps_update_done();
+
+	/* To avoid out of line uevents */
+	cpuset_wait_for_hotplug();
+
+	/* Tell user space about the state changes */
+	for_each_cpu(cpu, mask) {
+		dev = get_cpu_device(cpu);
+		kobject_uevent(&dev->kobj, KOBJ_ONLINE);
+	}
+
+	free_cpumask_var(mask);
 	return ret;
 }
 #endif
-- 
2.30.0


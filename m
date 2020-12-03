Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D902CDC2B
	for <lists+cgroups@lfdr.de>; Thu,  3 Dec 2020 18:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgLCRQH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Dec 2020 12:16:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40523 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726299AbgLCRQH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Dec 2020 12:16:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607015681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3iwcG8+s5F+FEk/BmczMtBbT8rfaBFSaW5JqYcJIHRE=;
        b=eLsF3hDwmWhWNXBSb3hILCzFIxIFy60dPBnzlTQkaCoDmmLEN15jFD2sFO1m0J48yu3XPM
        FH7IgdvLRtR/EJEWPedZ2AYIQ++kw8ZEFYevo7szFZdt8Y7+rZJSVBbvohqYFDFh4ndVj/
        NafepwG4RsV7UVH83cU0fxbiyB5gQH4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-tNDDupLyM1a6eS7RCtlSKA-1; Thu, 03 Dec 2020 12:14:39 -0500
X-MC-Unique: tNDDupLyM1a6eS7RCtlSKA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B33CAFA88;
        Thu,  3 Dec 2020 17:14:36 +0000 (UTC)
Received: from rtux.redhat.com (unknown [10.40.196.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DCBC260BFA;
        Thu,  3 Dec 2020 17:14:32 +0000 (UTC)
From:   Alexey Klimov <aklimov@redhat.com>
To:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Cc:     peterz@infradead.org, yury.norov@gmail.com, tglx@linutronix.de,
        jobaker@redhat.com, audralmitchel@gmail.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, rafael@kernel.org, tj@kernel.org,
        lizefan@huawei.com, qais.yousef@arm.com, hannes@cmpxchg.org,
        klimov.linux@gmail.com
Subject: [RFC][PATCH] cpu/hotplug: wait for cpuset_hotplug_work to finish on cpu online
Date:   Thu,  3 Dec 2020 17:14:31 +0000
Message-Id: <20201203171431.256675-1-aklimov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When a CPU offlined and onlined via device_offline() and device_online()
the userspace gets uevent notification. If, after receiving uevent,
userspace executes sched_setaffinity() on some task trying to move it
to a recently onlined CPU, then it will fail with -EINVAL. Userspace needs
to wait around 5..30 ms before sched_setaffinity() will succeed for
recently onlined CPU after receiving uevent.

If in_mask for sched_setaffinity() has only recently onlined CPU, it
quickly fails with such flow:

  sched_setaffinity()
    cpuset_cpus_allowed()
      guarantee_online_cpus()   <-- cs->effective_cpus mask does not
                                        contain recently onlined cpu
    cpumask_and()               <-- final new_mask is empty
    __set_cpus_allowed_ptr()
      cpumask_any_and_distribute() <-- returns dest_cpu equal to nr_cpu_ids
      returns -EINVAL

Cpusets are updated using workqueue from cpuset_update_active_cpus() which
in its turn is called from cpu hotplug callback sched_cpu_activate() hence
the delay observable by sched_setaffinity().
Out of line uevent can be avoided if we will ensure that cpuset_hotplug_work
has run to completion using cpuset_wait_for_hotplug() after onlining the
cpu in cpu_up(). Unfortunately, the execution time of
echo 1 > /sys/devices/system/cpu/cpuX/online roughly doubled with this
change (on my test machine).

Co-analyzed-by: Joshua Baker <jobaker@redhat.com>
Signed-off-by: Alexey Klimov <aklimov@redhat.com>
---

The commit "cpuset: Make cpuset hotplug synchronous" would also get rid of the
early uevent but it was reverted.

The nature of this bug is also described here (with different consequences):
https://lore.kernel.org/lkml/20200211141554.24181-1-qais.yousef@arm.com/

Reproducer: https://gitlab.com/0xeafffffe/xlam

It could be that I missed the correct place for cpuset synchronisation and it should
be done in cpu_device_up() instead.
I also in doubts if we need cpuset_wait_for_hotplug() in cpuhp_online_cpu_device()
since an online uevent is sent there too.
Currently with such change the reproducer code continues to work without issues.
The idea is to avoid the situation when userspace receives the event about
onlined CPU which is not ready to take tasks for a while after uevent.


 kernel/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6ff2578ecf17..f39a27a7f24b 100644
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
@@ -1275,6 +1276,8 @@ static int cpu_up(unsigned int cpu, enum cpuhp_state target)
 	}
 
 	err = _cpu_up(cpu, 0, target);
+	if (!err)
+		cpuset_wait_for_hotplug();
 out:
 	cpu_maps_update_done();
 	return err;
-- 
2.26.2


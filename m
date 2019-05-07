Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3EF16CE8
	for <lists+cgroups@lfdr.de>; Tue,  7 May 2019 23:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfEGVNe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 May 2019 17:13:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbfEGVNe (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 7 May 2019 17:13:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3BD52330279;
        Tue,  7 May 2019 21:13:34 +0000 (UTC)
Received: from jsavitz.bos.com (dhcp-17-161.bos.redhat.com [10.18.17.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D6884122;
        Tue,  7 May 2019 21:12:55 +0000 (UTC)
From:   Joel Savitz <jsavitz@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Savitz <jsavitz@redhat.com>, Li Zefan <lizefan@huawei.com>,
        Phil Auld <pauld@redhat.com>, Waiman Long <longman@redhat.com>,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org
Subject: [RESEND PATCH v2] cpuset: restore sanity to cpuset_cpus_allowed_fallback()
Date:   Tue,  7 May 2019 17:12:45 -0400
Message-Id: <1557263565-17589-1-git-send-email-jsavitz@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 07 May 2019 21:13:34 +0000 (UTC)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

If a process is limited by taskset (i.e. cpuset) to only be allowed to
run on cpu N, and then cpu N is offlined via hotplug, the process will
be assigned the current value of its cpuset cgroup's effective_cpus field
in a call to do_set_cpus_allowed() in cpuset_cpus_allowed_fallback().
This argument's value does not makes sense for this case, because
task_cs(tsk)->effective_cpus is modified by cpuset_hotplug_workfn()
to reflect the new value of cpu_active_mask after cpu N is removed from
the mask. While this may make sense for the cgroup affinity mask, it
does not make sense on a per-task basis, as a task that was previously
limited to only be run on cpu N will be limited to every cpu _except_ for
cpu N after it is offlined/onlined via hotplug.

Pre-patch behavior:

        $ grep Cpus /proc/$$/status
        Cpus_allowed:   ff
        Cpus_allowed_list:      0-7

        $ taskset -p 4 $$
        pid 19202's current affinity mask: f
        pid 19202's new affinity mask: 4

        $ grep Cpus /proc/self/status
        Cpus_allowed:   04
        Cpus_allowed_list:      2

        # echo off > /sys/devices/system/cpu/cpu2/online
        $ grep Cpus /proc/$$/status
        Cpus_allowed:   0b
        Cpus_allowed_list:      0-1,3

        # echo on > /sys/devices/system/cpu/cpu2/online
        $ grep Cpus /proc/$$/status
        Cpus_allowed:   0b
        Cpus_allowed_list:      0-1,3

On a patched system, the final grep produces the following
output instead:

        $ grep Cpus /proc/$$/status
        Cpus_allowed:   ff
        Cpus_allowed_list:      0-7

This patch changes the above behavior by instead resetting the mask to
task_cs(tsk)->cpus_allowed by default, and cpu_possible mask in legacy
mode.

This fallback mechanism is only triggered if _every_ other valid avenue
has been traveled, and it is the last resort before calling BUG().

Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 Makefile               |  2 +-
 kernel/cgroup/cpuset.c | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 6a1942ed781c..515525ff1cfd 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3254,10 +3254,23 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
 	spin_unlock_irqrestore(&callback_lock, flags);
 }
 
+/**
+ * cpuset_cpus_allowed_fallback - final fallback before complete catastrophe.
+ * @tsk: pointer to task_struct with which the scheduler is struggling
+ *
+ * Description: In the case that the scheduler cannot find an allowed cpu in
+ * tsk->cpus_allowed, we fall back to task_cs(tsk)->cpus_allowed. In legacy
+ * mode however, this value is the same as task_cs(tsk)->effective_cpus,
+ * which will not contain a sane cpumask during cases such as cpu hotplugging.
+ * This is the absolute last resort for the scheduler and it is only used if
+ * _every_ other avenue has been traveled.
+ **/
+
 void cpuset_cpus_allowed_fallback(struct task_struct *tsk)
 {
 	rcu_read_lock();
-	do_set_cpus_allowed(tsk, task_cs(tsk)->effective_cpus);
+	do_set_cpus_allowed(tsk, is_in_v2_mode() ?
+		task_cs(tsk)->cpus_allowed : cpu_possible_mask);
 	rcu_read_unlock();
 
 	/*
-- 
2.18.1


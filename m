Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DAD58858C
	for <lists+cgroups@lfdr.de>; Wed,  3 Aug 2022 03:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbiHCBzX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 2 Aug 2022 21:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbiHCBzW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 2 Aug 2022 21:55:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C71919C08
        for <cgroups@vger.kernel.org>; Tue,  2 Aug 2022 18:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659491720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=HX8NATpwjkTcDpmelYUXYRI0qsy6slg8qubTweG5yEM=;
        b=MtYcmS8hwGBR9Qc+VzevvsNJlo7e077sbHA6qFsrSlIRkEQ7RUquI6dMVrzXKPM7oBCtDw
        ndHaUCDvD8ryxOGY0ig4rqlWKr2pmS79eh0Pkp/PxBOHrd1dnK+QMFCj9MAqxTtTCNDBPz
        2j7Mxb3qMd4wcl25pIvsa5DpecUK0Ow=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-130-xp1F_XonMSCfCRwzY6-3vQ-1; Tue, 02 Aug 2022 21:55:16 -0400
X-MC-Unique: xp1F_XonMSCfCRwzY6-3vQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE7413806703;
        Wed,  3 Aug 2022 01:55:14 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 88DD92166B26;
        Wed,  3 Aug 2022 01:55:13 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] sched, cpuset: Fix dl_cpu_busy() panic due to empty cs->cpus_allowed
Date:   Tue,  2 Aug 2022 21:54:51 -0400
Message-Id: <20220803015451.2219567-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

With cgroup v2, the cpuset's cpus_allowed mask can be empty indicating
that the cpuset will just use the effective cpus of its parent. So
cpuset_can_attach() can call task_can_attach() with an empty mask.
This can lead to cpumask_any_and() returns nr_cpu_ids causing the call
to dl_bw_of() to crash due to percpu value access of an out of bound
cpu value. For example,

[80468.182258] BUG: unable to handle page fault for address: ffffffff8b6648b0
  :
[80468.191019] RIP: 0010:dl_cpu_busy+0x30/0x2b0
  :
[80468.207946] Call Trace:
[80468.208947]  cpuset_can_attach+0xa0/0x140
[80468.209953]  cgroup_migrate_execute+0x8c/0x490
[80468.210931]  cgroup_update_dfl_csses+0x254/0x270
[80468.211898]  cgroup_subtree_control_write+0x322/0x400
[80468.212854]  kernfs_fop_write_iter+0x11c/0x1b0
[80468.213777]  new_sync_write+0x11f/0x1b0
[80468.214689]  vfs_write+0x1eb/0x280
[80468.215592]  ksys_write+0x5f/0xe0
[80468.216463]  do_syscall_64+0x5c/0x80
[80468.224287]  entry_SYSCALL_64_after_hwframe+0x44/0xae

Fix that by using effective_cpus instead. For cgroup v1, effective_cpus
is the same as cpus_allowed. For v2, effective_cpus is the real cpumask
to be used by tasks within the cpuset anyway.

Also update task_can_attach()'s 2nd argument name to cs_effective_cpus to
reflect the change. In addition, a check is added to task_can_attach()
to guard against the possibility that cpumask_any_and() may return a
value >= nr_cpu_ids.

Fixes: 7f51412a415d ("sched/deadline: Fix bandwidth check/update when migrating tasks between exclusive cpusets")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/sched.h  | 2 +-
 kernel/cgroup/cpuset.c | 2 +-
 kernel/sched/core.c    | 8 +++++---
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 88b8817b827d..6a060160f0db 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1813,7 +1813,7 @@ current_restore_flags(unsigned long orig_flags, unsigned long flags)
 }
 
 extern int cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
-extern int task_can_attach(struct task_struct *p, const struct cpumask *cs_cpus_allowed);
+extern int task_can_attach(struct task_struct *p, const struct cpumask *cs_effective_cpus);
 #ifdef CONFIG_SMP
 extern void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask);
 extern int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask);
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 71a418858a5e..58aadfda9b8b 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2239,7 +2239,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 		goto out_unlock;
 
 	cgroup_taskset_for_each(task, css, tset) {
-		ret = task_can_attach(task, cs->cpus_allowed);
+		ret = task_can_attach(task, cs->effective_cpus);
 		if (ret)
 			goto out_unlock;
 		ret = security_task_setscheduler(task);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5555e49c4e12..addc3c2d2122 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8980,7 +8980,7 @@ int cpuset_cpumask_can_shrink(const struct cpumask *cur,
 }
 
 int task_can_attach(struct task_struct *p,
-		    const struct cpumask *cs_cpus_allowed)
+		    const struct cpumask *cs_effective_cpus)
 {
 	int ret = 0;
 
@@ -8999,9 +8999,11 @@ int task_can_attach(struct task_struct *p,
 	}
 
 	if (dl_task(p) && !cpumask_intersects(task_rq(p)->rd->span,
-					      cs_cpus_allowed)) {
-		int cpu = cpumask_any_and(cpu_active_mask, cs_cpus_allowed);
+					      cs_effective_cpus)) {
+		int cpu = cpumask_any_and(cpu_active_mask, cs_effective_cpus);
 
+		if (unlikely(cpu >= nr_cpu_ids))
+			return -EINVAL;
 		ret = dl_cpu_busy(cpu, p);
 	}
 
-- 
2.31.1


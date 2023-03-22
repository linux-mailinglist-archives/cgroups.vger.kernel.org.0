Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03486C4CA8
	for <lists+cgroups@lfdr.de>; Wed, 22 Mar 2023 15:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjCVOAT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Mar 2023 10:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjCVOAQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Mar 2023 10:00:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BAF885FE6;
        Wed, 22 Mar 2023 07:00:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8590315A1;
        Wed, 22 Mar 2023 07:00:58 -0700 (PDT)
Received: from e125579.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EF77B3F71E;
        Wed, 22 Mar 2023 07:00:11 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Qais Yousef <qyousef@layalina.io>, Wei Wang <wvw@google.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [RFC PATCH 2/2] cgroup/cpuset: Free DL BW in case can_attach() fails
Date:   Wed, 22 Mar 2023 14:59:59 +0100
Message-Id: <20230322135959.1998790-3-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230322135959.1998790-1-dietmar.eggemann@arm.com>
References: <20230322135959.1998790-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

cpuset_can_attach() can fail. Postpone DL BW allocation until all task
have been checked. DL BW is not allocated per-task but as a sum over
all DL tasks migrating.

If multiple controllers are attached to the cgroup next to cuset a
non-cpuset can_attach() can fail. In this case free DL BW in
cpuset_cancel_attach().

Finally, update cpuset DL task count (nr_deadline_tasks) only in
cpuset_attach().

Suggested-by: Waiman Long <longman@redhat.com>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 include/linux/sched.h  |  2 +-
 kernel/cgroup/cpuset.c | 55 ++++++++++++++++++++++++++++++++++++++----
 kernel/sched/core.c    | 17 ++-----------
 3 files changed, 53 insertions(+), 21 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 658e997ba057..675ec74469d7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1846,7 +1846,7 @@ current_restore_flags(unsigned long orig_flags, unsigned long flags)
 }
 
 extern int cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
-extern int task_can_attach(struct task_struct *p, const struct cpumask *cs_effective_cpus);
+extern int task_can_attach(struct task_struct *p);
 extern int dl_bw_alloc(int cpu, u64 dl_bw);
 extern void dl_bw_free(int cpu, u64 dl_bw);
 #ifdef CONFIG_SMP
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index f46192d2e97e..fdc476eefbed 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -198,6 +198,8 @@ struct cpuset {
 	 * know when to rebuild associated root domain bandwidth information.
 	 */
 	int nr_deadline_tasks;
+	int nr_migrate_dl_tasks;
+	u64 sum_migrate_dl_bw;
 
 	/* Invalid partition error code, not lock protected */
 	enum prs_errcode prs_err;
@@ -2462,16 +2464,23 @@ static int fmeter_getrate(struct fmeter *fmp)
 
 static struct cpuset *cpuset_attach_old_cs;
 
+static void reset_migrate_dl_data(struct cpuset *cs)
+{
+	cs->nr_migrate_dl_tasks = 0;
+	cs->sum_migrate_dl_bw = 0;
+}
+
 /* Called by cgroups to determine if a cpuset is usable; cpuset_mutex held */
 static int cpuset_can_attach(struct cgroup_taskset *tset)
 {
 	struct cgroup_subsys_state *css;
-	struct cpuset *cs;
+	struct cpuset *cs, *oldcs;
 	struct task_struct *task;
 	int ret;
 
 	/* used later by cpuset_attach() */
 	cpuset_attach_old_cs = task_cs(cgroup_taskset_first(tset, &css));
+	oldcs = cpuset_attach_old_cs;
 	cs = css_cs(css);
 
 	mutex_lock(&cpuset_mutex);
@@ -2489,7 +2498,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 		goto out_unlock;
 
 	cgroup_taskset_for_each(task, css, tset) {
-		ret = task_can_attach(task, cs->effective_cpus);
+		ret = task_can_attach(task);
 		if (ret)
 			goto out_unlock;
 		ret = security_task_setscheduler(task);
@@ -2497,11 +2506,31 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 			goto out_unlock;
 
 		if (dl_task(task)) {
-			cs->nr_deadline_tasks++;
-			cpuset_attach_old_cs->nr_deadline_tasks--;
+			cs->nr_migrate_dl_tasks++;
+			cs->sum_migrate_dl_bw += task->dl.dl_bw;
+		}
+	}
+
+	if (!cs->nr_migrate_dl_tasks)
+		goto out_succes;
+
+	if (!cpumask_intersects(oldcs->effective_cpus, cs->effective_cpus)) {
+		int cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
+
+		if (unlikely(cpu >= nr_cpu_ids)) {
+			reset_migrate_dl_data(cs);
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+
+		ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
+		if (ret) {
+			reset_migrate_dl_data(cs);
+			goto out_unlock;
 		}
 	}
 
+out_succes:
 	/*
 	 * Mark attach is in progress.  This makes validate_change() fail
 	 * changes which zero cpus/mems_allowed.
@@ -2516,11 +2545,21 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 static void cpuset_cancel_attach(struct cgroup_taskset *tset)
 {
 	struct cgroup_subsys_state *css;
+	struct cpuset *cs;
 
 	cgroup_taskset_first(tset, &css);
+	cs = css_cs(css);
 
 	mutex_lock(&cpuset_mutex);
-	css_cs(css)->attach_in_progress--;
+	cs->attach_in_progress--;
+
+	if (cs->nr_migrate_dl_tasks) {
+		int cpu = cpumask_any(cs->effective_cpus);
+
+		dl_bw_free(cpu, cs->sum_migrate_dl_bw);
+		reset_migrate_dl_data(cs);
+	}
+
 	mutex_unlock(&cpuset_mutex);
 }
 
@@ -2615,6 +2654,12 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 out:
 	cs->old_mems_allowed = cpuset_attach_nodemask_to;
 
+	if (cs->nr_migrate_dl_tasks) {
+		cs->nr_deadline_tasks += cs->nr_migrate_dl_tasks;
+		oldcs->nr_deadline_tasks -= cs->nr_migrate_dl_tasks;
+		reset_migrate_dl_data(cs);
+	}
+
 	cs->attach_in_progress--;
 	if (!cs->attach_in_progress)
 		wake_up(&cpuset_attach_wq);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2f07aecb7434..4fb058b72886 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9201,8 +9201,7 @@ int cpuset_cpumask_can_shrink(const struct cpumask *cur,
 	return ret;
 }
 
-int task_can_attach(struct task_struct *p,
-		    const struct cpumask *cs_effective_cpus)
+int task_can_attach(struct task_struct *p)
 {
 	int ret = 0;
 
@@ -9215,21 +9214,9 @@ int task_can_attach(struct task_struct *p,
 	 * success of set_cpus_allowed_ptr() on all attached tasks
 	 * before cpus_mask may be changed.
 	 */
-	if (p->flags & PF_NO_SETAFFINITY) {
+	if (p->flags & PF_NO_SETAFFINITY)
 		ret = -EINVAL;
-		goto out;
-	}
-
-	if (dl_task(p) && !cpumask_intersects(task_rq(p)->rd->span,
-					      cs_effective_cpus)) {
-		int cpu = cpumask_any_and(cpu_active_mask, cs_effective_cpus);
 
-		if (unlikely(cpu >= nr_cpu_ids))
-			return -EINVAL;
-		ret = dl_bw_alloc(cpu, p->dl.dl_bw);
-	}
-
-out:
 	return ret;
 }
 
-- 
2.25.1


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4B54E16A
	for <lists+cgroups@lfdr.de>; Fri, 21 Jun 2019 09:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfFUHyH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Jun 2019 03:54:07 -0400
Received: from mail2.tencent.com ([163.177.67.195]:57794 "EHLO
        mail2.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfFUHyE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Jun 2019 03:54:04 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Jun 2019 03:54:02 EDT
Received: from EXHUB-SZMail01.tencent.com (unknown [10.14.6.21])
        by mail2.tencent.com (Postfix) with ESMTP id 285C78E7E2;
        Fri, 21 Jun 2019 15:47:24 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.22.120.143) by
 EXHUB-SZMail01.tencent.com (10.14.6.21) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 21 Jun 2019 15:47:23 +0800
From:   <xiaoggchen@tencent.com>
To:     <jasperwang@tencent.com>, <heddchen@tencent.com>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, <tj@kernel.org>,
        <lizefan@huawei.com>, <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>, chen xiaoguang <xiaoggchen@tencent.com>,
        Newton Gao <newtongao@tencent.com>,
        Shook Liu <shookliu@tencent.com>,
        Zhiguang Peng <zgpeng@tencent.com>
Subject: [PATCH 4/5] sched/BT: account the cpu time for BT scheduling class
Date:   Fri, 21 Jun 2019 15:45:56 +0800
Message-ID: <1561103157-11246-5-git-send-email-xiaoggchen@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561103157-11246-1-git-send-email-xiaoggchen@tencent.com>
References: <1561103157-11246-1-git-send-email-xiaoggchen@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.22.120.143]
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: chen xiaoguang <xiaoggchen@tencent.com>

Signed-off-by: Newton Gao <newtongao@tencent.com>
Signed-off-by: Shook Liu <shookliu@tencent.com>
Signed-off-by: Zhiguang Peng <zgpeng@tencent.com>
Signed-off-by: Xiaoguang Chen <xiaoggchen@tencent.com>
---
 fs/proc/base.c                 |  3 ++-
 kernel/delayacct.c             |  2 +-
 kernel/exit.c                  |  3 ++-
 kernel/sched/core.c            | 30 +++++++++++++++++++++++-------
 kernel/sched/cputime.c         |  7 ++++---
 kernel/sched/fair.c            | 27 +++++++++++++++++----------
 kernel/sched/loadavg.c         |  5 +++--
 kernel/time/posix-cpu-timers.c |  2 +-
 8 files changed, 53 insertions(+), 26 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 9c8ca6c..356f2e8 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -459,7 +459,8 @@ static int proc_pid_schedstat(struct seq_file *m, struct pid_namespace *ns,
 		seq_puts(m, "0 0 0\n");
 	else
 		seq_printf(m, "%llu %llu %lu\n",
-		   (unsigned long long)task->se.sum_exec_runtime,
+		   (unsigned long long)task->se.sum_exec_runtime +
+		   (unsigned long long)task->bt.sum_exec_runtime,
 		   (unsigned long long)task->sched_info.run_delay,
 		   task->sched_info.pcount);
 
diff --git a/kernel/delayacct.c b/kernel/delayacct.c
index 27725754..c8bb8f6 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -106,7 +106,7 @@ int __delayacct_add_tsk(struct taskstats *d, struct task_struct *tsk)
 	 */
 	t1 = tsk->sched_info.pcount;
 	t2 = tsk->sched_info.run_delay;
-	t3 = tsk->se.sum_exec_runtime;
+	t3 = tsk->se.sum_exec_runtime + tsk->bt.sum_exec_runtime;
 
 	d->cpu_count += t1;
 
diff --git a/kernel/exit.c b/kernel/exit.c
index 1803efb..ee5ef46 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -152,7 +152,8 @@ static void __exit_signal(struct task_struct *tsk)
 	sig->inblock += task_io_get_inblock(tsk);
 	sig->oublock += task_io_get_oublock(tsk);
 	task_io_accounting_add(&sig->ioac, &tsk->ioac);
-	sig->sum_sched_runtime += tsk->se.sum_exec_runtime;
+	sig->sum_sched_runtime += (tsk->se.sum_exec_runtime +
+				   tsk->bt.sum_exec_runtime);
 	sig->nr_threads--;
 	__unhash_process(tsk, group_dead);
 	write_sequnlock(&sig->stats_lock);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b542c17..e8fbd9e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -789,9 +789,13 @@ static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 
 void activate_task(struct rq *rq, struct task_struct *p, int flags)
 {
-	if (task_contributes_to_load(p))
+	if (task_contributes_to_load(p)) {
 		rq->nr_uninterruptible--;
 
+		if (unlikely(p->sched_class == &bt_sched_class))
+			rq->bt.nr_uninterruptible--;
+	}
+
 	enqueue_task(rq, p, flags);
 
 	p->on_rq = TASK_ON_RQ_QUEUED;
@@ -801,9 +805,13 @@ void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
 {
 	p->on_rq = (flags & DEQUEUE_SLEEP) ? 0 : TASK_ON_RQ_MIGRATING;
 
-	if (task_contributes_to_load(p))
+	if (task_contributes_to_load(p)) {
 		rq->nr_uninterruptible++;
 
+		if (unlikely(p->sched_class == &bt_sched_class))
+			rq->bt.nr_uninterruptible++;
+	}
+
 	dequeue_task(rq, p, flags);
 }
 
@@ -1727,9 +1735,13 @@ static void ttwu_do_wakeup(struct rq *rq, struct task_struct *p, int wake_flags,
 	lockdep_assert_held(&rq->lock);
 
 #ifdef CONFIG_SMP
-	if (p->sched_contributes_to_load)
+	if (p->sched_contributes_to_load) {
 		rq->nr_uninterruptible--;
 
+		if (unlikely(p->sched_class == &bt_sched_class))
+			rq->bt.nr_uninterruptible--;
+	}
+
 	if (wake_flags & WF_MIGRATED)
 		en_flags |= ENQUEUE_MIGRATED;
 #endif
@@ -3007,7 +3019,7 @@ unsigned long long task_sched_runtime(struct task_struct *p)
 	 * been accounted, so we're correct here as well.
 	 */
 	if (!p->on_cpu || !task_on_rq_queued(p))
-		return p->se.sum_exec_runtime;
+		return p->se.sum_exec_runtime + p->bt.sum_exec_runtime;
 #endif
 
 	rq = task_rq_lock(p, &rf);
@@ -3021,7 +3033,7 @@ unsigned long long task_sched_runtime(struct task_struct *p)
 		update_rq_clock(rq);
 		p->sched_class->update_curr(rq);
 	}
-	ns = p->se.sum_exec_runtime;
+	ns = p->se.sum_exec_runtime + p->bt.sum_exec_runtime;
 	task_rq_unlock(rq, p, &rf);
 
 	return ns;
@@ -4003,7 +4015,7 @@ int idle_cpu(int cpu)
 	if (rq->curr != rq->idle && !bt_prio(rq->curr->prio))
 		return 0;
 
-	if (rq->nr_running)
+	if (rq->nr_running - rq->bt.bt_nr_running)
 		return 0;
 
 #ifdef CONFIG_SMP
@@ -5383,9 +5395,13 @@ void init_idle(struct task_struct *idle, int cpu)
 
 	__sched_fork(0, idle);
 	idle->state = TASK_RUNNING;
-	idle->se.exec_start = sched_clock();
+	idle->se.exec_start = idle->bt.exec_start = sched_clock();
 	idle->flags |= PF_IDLE;
 
+#if defined(CONFIG_SCHEDSTATS) || defined(CONFIG_LATENCYTOP)
+	idle->bt.statistics = &idle->se.statistics;
+#endif
+
 	kasan_unpoison_task_stack(idle);
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index ca26a04..4cba3f2 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -283,7 +283,7 @@ static inline u64 account_other_time(u64 max)
 #ifdef CONFIG_64BIT
 static inline u64 read_sum_exec_runtime(struct task_struct *t)
 {
-	return t->se.sum_exec_runtime;
+	return t->se.sum_exec_runtime + t->bt.sum_exec_runtime;
 }
 #else
 static u64 read_sum_exec_runtime(struct task_struct *t)
@@ -293,7 +293,7 @@ static u64 read_sum_exec_runtime(struct task_struct *t)
 	struct rq *rq;
 
 	rq = task_rq_lock(t, &rf);
-	ns = t->se.sum_exec_runtime;
+	ns = t->se.sum_exec_runtime + t->bt.sum_exec_runtime;
 	task_rq_unlock(rq, t, &rf);
 
 	return ns;
@@ -677,7 +677,8 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
 void task_cputime_adjusted(struct task_struct *p, u64 *ut, u64 *st)
 {
 	struct task_cputime cputime = {
-		.sum_exec_runtime = p->se.sum_exec_runtime,
+		.sum_exec_runtime = p->se.sum_exec_runtime +
+				p->bt.sum_exec_runtime,
 	};
 
 	task_cputime(p, &cputime.utime, &cputime.stime);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5299ce8..ca08107 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7137,7 +7137,7 @@ static void yield_task_fair(struct rq *rq)
 	/*
 	 * Are we the only task in the tree?
 	 */
-	if (unlikely(rq->nr_running == 1))
+	if (unlikely((rq->nr_running - rq->bt.bt_nr_running) == 1))
 		return;
 
 	clear_buddies(cfs_rq, se);
@@ -7357,7 +7357,9 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
 	/*
 	 * Buddy candidates are cache hot:
 	 */
-	if (sched_feat(CACHE_HOT_BUDDY) && env->dst_rq->nr_running &&
+	if (sched_feat(CACHE_HOT_BUDDY) &&
+		(env->dst_rq->nr_running -
+			env->dst_rq->bt.bt_nr_running) &&
 			(&p->se == cfs_rq_of(&p->se)->next ||
 			 &p->se == cfs_rq_of(&p->se)->last))
 		return 1;
@@ -7398,7 +7400,8 @@ static int migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
 
 	/* Migrating away from the preferred node is always bad. */
 	if (src_nid == p->numa_preferred_nid) {
-		if (env->src_rq->nr_running > env->src_rq->nr_preferred_running)
+		if ((env->src_rq->nr_running - env->src_rq->bt.bt_nr_running) >
+		     env->src_rq->nr_preferred_running)
 			return 1;
 		else
 			return -1;
@@ -7580,7 +7583,9 @@ static int detach_tasks(struct lb_env *env)
 		 * We don't want to steal all, otherwise we may be treated likewise,
 		 * which could at worst lead to a livelock crash.
 		 */
-		if (env->idle != CPU_NOT_IDLE && env->src_rq->nr_running <= 1)
+		if (env->idle != CPU_NOT_IDLE &&
+		   (env->src_rq->nr_running -
+			env->src_rq->bt.bt_nr_running) <= 1)
 			break;
 
 		p = list_last_entry(tasks, struct task_struct, se.group_node);
@@ -8272,7 +8277,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		sgs->group_util += cpu_util(i);
 		sgs->sum_nr_running += rq->cfs.h_nr_running;
 
-		nr_running = rq->nr_running;
+		nr_running = rq->nr_running - rq->bt.bt_nr_running;
 		if (nr_running > 1)
 			*sg_status |= SG_OVERLOAD;
 
@@ -9080,7 +9085,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 	env.src_rq = busiest;
 
 	ld_moved = 0;
-	if (busiest->nr_running > 1) {
+	if (busiest->nr_running - busiest->bt.bt_nr_running > 1) {
 		/*
 		 * Attempt to move tasks. If find_busiest_group has found
 		 * an imbalance but busiest->nr_running <= 1, the group is
@@ -9088,7 +9093,8 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 		 * correctly treated as an imbalance.
 		 */
 		env.flags |= LBF_ALL_PINNED;
-		env.loop_max  = min(sysctl_sched_nr_migrate, busiest->nr_running);
+		env.loop_max  = min(sysctl_sched_nr_migrate,
+			busiest->nr_running - busiest->bt.bt_nr_running);
 
 more_balance:
 		rq_lock_irqsave(busiest, &rf);
@@ -9359,7 +9365,7 @@ static int active_load_balance_cpu_stop(void *data)
 		goto out_unlock;
 
 	/* Is there any task to move? */
-	if (busiest_rq->nr_running <= 1)
+	if (busiest_rq->nr_running - busiest_rq->bt.bt_nr_running <= 1)
 		goto out_unlock;
 
 	/*
@@ -9628,7 +9634,7 @@ static void nohz_balancer_kick(struct rq *rq)
 	if (time_before(now, nohz.next_balance))
 		goto out;
 
-	if (rq->nr_running >= 2) {
+	if (rq->nr_running - rq->bt.bt_nr_running >= 2) {
 		flags = NOHZ_KICK_MASK;
 		goto out;
 	}
@@ -10075,7 +10081,8 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
 		 * Stop searching for tasks to pull if there are
 		 * now runnable tasks on this rq.
 		 */
-		if (pulled_task || this_rq->nr_running > 0)
+		if (pulled_task || this_rq->nr_running -
+			this_rq->bt.bt_nr_running > 0)
 			break;
 	}
 	rcu_read_unlock();
diff --git a/kernel/sched/loadavg.c b/kernel/sched/loadavg.c
index 28a5165..6810e59 100644
--- a/kernel/sched/loadavg.c
+++ b/kernel/sched/loadavg.c
@@ -80,8 +80,9 @@ long calc_load_fold_active(struct rq *this_rq, long adjust)
 {
 	long nr_active, delta = 0;
 
-	nr_active = this_rq->nr_running - adjust;
-	nr_active += (long)this_rq->nr_uninterruptible;
+	nr_active = this_rq->nr_running - this_rq->bt.bt_nr_running - adjust;
+	nr_active += (long)this_rq->nr_uninterruptible -
+		     (long)this_rq->bt.nr_uninterruptible;
 
 	if (nr_active != this_rq->calc_load_active) {
 		delta = nr_active - this_rq->calc_load_active;
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 0a426f4..db54c82 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -829,7 +829,7 @@ static void check_thread_timers(struct task_struct *tsk,
 	tsk_expires->virt_exp = expires;
 
 	tsk_expires->sched_exp = check_timers_list(++timers, firing,
-						   tsk->se.sum_exec_runtime);
+			   tsk->se.sum_exec_runtime + tsk->bt.sum_exec_runtime);
 
 	/*
 	 * Check for the special case thread timers.
-- 
1.8.3.1


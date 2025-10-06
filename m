Return-Path: <cgroups+bounces-10553-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C62BBDC04
	for <lists+cgroups@lfdr.de>; Mon, 06 Oct 2025 12:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D8823B966E
	for <lists+cgroups@lfdr.de>; Mon,  6 Oct 2025 10:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0882226C39F;
	Mon,  6 Oct 2025 10:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mmgpuF7Y"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73DA261B71;
	Mon,  6 Oct 2025 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759747562; cv=none; b=JMp0NETFi69RqOs5G6d+FAwNjYpKsr6qNZXMHC6EX5iJJepAb1G+0zVMp4eVPgBylExAXBrb4mxxni8kQSAosWzU7DgUND/UzJgB7xwz7Rtzqt/qiw8Q9QQKXDUZFC6GHwcRiyQkTLNuvHKsUSXLzh18atXU4cT4n32jgK9dfto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759747562; c=relaxed/simple;
	bh=v72Sl8acF1wtEVNJ5ebk6hAwHuSQbIfFFkRhsGxBvgI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Ykt1gF+Q57lzkgDtM1PDaIsx7JHbauD76C5merEdNy4pHiPAOJoz9/BxbvBGF/9qaLq2Yxpr8w2ududHaoVQ8PBcEu+GA0VrKEcqoYwwfRs16pwexQoE7oWTI9J/IuUd2bGj+agBF5WPvVTrno7ZsQyRFelI3lt/2G7dF3w/8yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mmgpuF7Y; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=SWO9rCAVqQzNfjdIyJT3efkTH2n23/SbcKVjKjVsQhc=; b=mmgpuF7Y+CdYAETXpaF1WWwwtO
	SWj+B1ct3Dep/hjCrWKm/EAuvGvjP4oeHifUnFWg+rdWH8waC67/Q+BQPL3jaF/9Oggg5YRZqhK8E
	H9jU/OO9m/TM/vIQRs9JOaEW10LvjPDJrUbN9bsh6BqZysQhTmUvBEq3eGpUWbBw8zQKOsr57Mcao
	lzYwsQ9kNx6g+BLfWsE7ClDNsfjYP2CTLqt7WCLAy0xbCiEsRw9tzdzm7Ju3J8/DV9uby5kzb+xqC
	l6AcGNAz5FJfD/QcDyn6tbAyWMh9IuazHLQ1l5ZpAGyc5CRdBy7oSOUgnOhEwARHbGMq0zZiJ/VXR
	Ze8udoWQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5iix-00000009ydB-3kfB;
	Mon, 06 Oct 2025 10:45:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id E5606303031; Mon, 06 Oct 2025 12:45:47 +0200 (CEST)
Message-ID: <20251006104527.694841522@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 06 Oct 2025 12:44:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tj@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 mingo@kernel.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 longman@redhat.com,
 hannes@cmpxchg.org,
 mkoutny@suse.com,
 void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 cgroups@vger.kernel.org,
 sched-ext@lists.linux.dev,
 liuwenfang@honor.com,
 tglx@linutronix.de
Subject: [PATCH 10/12] sched: Add locking comments to sched_class methods
References: <20251006104402.946760805@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

'Document' the locking context the various sched_class methods are
called under.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c  |    6 +-
 kernel/sched/sched.h |  106 ++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 103 insertions(+), 9 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -583,8 +583,8 @@ EXPORT_SYMBOL(__trace_set_current_state)
  *
  * p->on_rq <- { 0, 1 = TASK_ON_RQ_QUEUED, 2 = TASK_ON_RQ_MIGRATING }:
  *
- *   is set by activate_task() and cleared by deactivate_task(), under
- *   rq->lock. Non-zero indicates the task is runnable, the special
+ *   is set by activate_task() and cleared by deactivate_task()/block_task(),
+ *   under rq->lock. Non-zero indicates the task is runnable, the special
  *   ON_RQ_MIGRATING state is used for migration without holding both
  *   rq->locks. It indicates task_cpu() is not stable, see task_rq_lock().
  *
@@ -4162,7 +4162,7 @@ int try_to_wake_up(struct task_struct *p
 		 * __schedule().  See the comment for smp_mb__after_spinlock().
 		 *
 		 * Form a control-dep-acquire with p->on_rq == 0 above, to ensure
-		 * schedule()'s deactivate_task() has 'happened' and p will no longer
+		 * schedule()'s block_task() has 'happened' and p will no longer
 		 * care about it's own p->state. See the comment in __schedule().
 		 */
 		smp_acquire__after_ctrl_dep();
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2345,8 +2345,7 @@ extern const u32		sched_prio_to_wmult[40
 /*
  * {de,en}queue flags:
  *
- * DEQUEUE_SLEEP  - task is no longer runnable
- * ENQUEUE_WAKEUP - task just became runnable
+ * SLEEP/WAKEUP - task is no-longer/just-became runnable
  *
  * SAVE/RESTORE - an otherwise spurious dequeue/enqueue, done to ensure tasks
  *                are in a known state which allows modification. Such pairs
@@ -2359,6 +2358,11 @@ extern const u32		sched_prio_to_wmult[40
  *
  * MIGRATION - p->on_rq == TASK_ON_RQ_MIGRATING (used for DEADLINE)
  *
+ * DELAYED - de/re-queue a sched_delayed task
+ *
+ * CLASS - going to update p->sched_class; makes sched_change call the
+ *         various switch methods.
+ *
  * ENQUEUE_HEAD      - place at front of runqueue (tail if not specified)
  * ENQUEUE_REPLENISH - CBS (replenish runtime and postpone deadline)
  * ENQUEUE_MIGRATED  - the task was migrated during wakeup
@@ -2409,14 +2413,50 @@ struct sched_class {
 	int uclamp_enabled;
 #endif
 
+	/*
+	 * move_queued_task/activate_task/enqueue_task: rq->lock
+	 * ttwu_do_activate/activate_task/enqueue_task: rq->lock
+	 * wake_up_new_task/activate_task/enqueue_task: task_rq_lock
+	 * ttwu_runnable/enqueue_task: task_rq_lock
+	 * proxy_task_current: rq->lock
+	 * sched_change_end
+	 */
 	void (*enqueue_task) (struct rq *rq, struct task_struct *p, int flags);
+	/*
+	 * move_queued_task/deactivate_task/dequeue_task: rq->lock
+	 * __schedule/block_task/dequeue_task: rq->lock
+	 * proxy_task_current: rq->lock
+	 * wait_task_inactive: task_rq_lock
+	 * sched_change_begin
+	 */
 	bool (*dequeue_task) (struct rq *rq, struct task_struct *p, int flags);
+
+	/*
+	 * do_sched_yield: rq->lock
+	 */
 	void (*yield_task)   (struct rq *rq);
+	/*
+	 * yield_to: rq->lock (double)
+	 */
 	bool (*yield_to_task)(struct rq *rq, struct task_struct *p);
 
+	/*
+	 * move_queued_task: rq->lock
+	 * __migrate_swap_task: rq->lock
+	 * ttwu_do_activate: rq->lock
+	 * ttwu_runnable: task_rq_lock
+	 * wake_up_new_task: task_rq_lock
+	 */
 	void (*wakeup_preempt)(struct rq *rq, struct task_struct *p, int flags);
 
+	/*
+	 * schedule/pick_next_task/prev_balance: rq->lock
+	 */
 	int (*balance)(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
+
+	/*
+	 * schedule/pick_next_task: rq->lock
+	 */
 	struct task_struct *(*pick_task)(struct rq *rq);
 	/*
 	 * Optional! When implemented pick_next_task() should be equivalent to:
@@ -2429,48 +2469,102 @@ struct sched_class {
 	 */
 	struct task_struct *(*pick_next_task)(struct rq *rq, struct task_struct *prev);
 
+	/*
+	 * sched_change:
+	 * __schedule: rq->lock
+	 */
 	void (*put_prev_task)(struct rq *rq, struct task_struct *p, struct task_struct *next);
 	void (*set_next_task)(struct rq *rq, struct task_struct *p, bool first);
 
+	/*
+	 * select_task_rq: p->pi_lock
+	 * sched_exec: p->pi_lock
+	 */
 	int  (*select_task_rq)(struct task_struct *p, int task_cpu, int flags);
 
+	/*
+	 * set_task_cpu: p->pi_lock || rq->lock (ttwu like)
+	 */
 	void (*migrate_task_rq)(struct task_struct *p, int new_cpu);
 
+	/*
+	 * ttwu_do_activate: rq->lock
+	 * wake_up_new_task: task_rq_lock
+	 */
 	void (*task_woken)(struct rq *this_rq, struct task_struct *task);
 
+	/*
+	 * do_set_cpus_allowed: task_rq_lock + sched_change
+	 */
 	void (*set_cpus_allowed)(struct task_struct *p, struct affinity_context *ctx);
 
+	/*
+	 * sched_set_rq_{on,off}line: rq->lock
+	 */
 	void (*rq_online)(struct rq *rq);
 	void (*rq_offline)(struct rq *rq);
 
+	/*
+	 * push_cpu_stop: p->pi_lock && rq->lock
+	 */
 	struct rq *(*find_lock_rq)(struct task_struct *p, struct rq *rq);
 
+	/*
+	 * hrtick: rq->lock
+	 * sched_tick: rq->lock
+	 * sched_tick_remote: rq->lock
+	 */
 	void (*task_tick)(struct rq *rq, struct task_struct *p, int queued);
+	/*
+	 * sched_cgroup_fork: p->pi_lock
+	 */
 	void (*task_fork)(struct task_struct *p);
+	/*
+	 * finish_task_switch: no locks
+	 */
 	void (*task_dead)(struct task_struct *p);
 
+	/*
+	 * sched_change
+	 */
 	void (*switching_from)(struct rq *this_rq, struct task_struct *task);
 	void (*switched_from) (struct rq *this_rq, struct task_struct *task);
 	void (*switching_to)  (struct rq *this_rq, struct task_struct *task);
 	void (*switched_to)   (struct rq *this_rq, struct task_struct *task);
-
-	void (*reweight_task)(struct rq *this_rq, struct task_struct *task,
-			      const struct load_weight *lw);
-
 	u64  (*get_prio)     (struct rq *this_rq, struct task_struct *task);
 	void (*prio_changed) (struct rq *this_rq, struct task_struct *task,
 			      u64 oldprio);
 
+	/*
+	 * set_load_weight: task_rq_lock + sched_change
+	 * __setscheduler_parms: task_rq_lock + sched_change
+	 */
+	void (*reweight_task)(struct rq *this_rq, struct task_struct *task,
+			      const struct load_weight *lw);
+
+	/*
+	 * sched_rr_get_interval: task_rq_lock
+	 */
 	unsigned int (*get_rr_interval)(struct rq *rq,
 					struct task_struct *task);
 
+	/*
+	 * task_sched_runtime: task_rq_lock
+	 */
 	void (*update_curr)(struct rq *rq);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
+	/*
+	 * sched_change_group: task_rq_lock + sched_change
+	 */
 	void (*task_change_group)(struct task_struct *p);
 #endif
 
 #ifdef CONFIG_SCHED_CORE
+	/*
+	 * pick_next_task: rq->lock
+	 * try_steal_cookie: rq->lock (double)
+	 */
 	int (*task_is_throttled)(struct task_struct *p, int cpu);
 #endif
 };




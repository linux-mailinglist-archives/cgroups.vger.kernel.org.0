Return-Path: <cgroups+bounces-9944-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8C8B51CD6
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 18:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796D31C86F61
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 16:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A991933EAE0;
	Wed, 10 Sep 2025 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bna4uYzo"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7CD3375AD;
	Wed, 10 Sep 2025 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520046; cv=none; b=GlG4Qx+bo/rAM3ejJDGC99dW8mzzL8WvrChQZGsyZlAhd7svI7oyK3++dTe2TQXPAsoLd3CZEdQnEHxQtAWZxUGXwHZdpK50AWkNYhq4mRGDZL4q5QJq3qXoUhCH1vAEZ6Jft4QDrSK0g72OzOEIS4ofrii7xhY/+oiKsBzTZkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520046; c=relaxed/simple;
	bh=KfepqktiJ/syjXebA141BLmjGiDQ3zjGf/IqCiTygCM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=OswDdvRGnz7sS/MVa1/JtdZE8+vFl4ipbKOHLmRQWEQ1R5mKic5GCh1U8LiGPD5cjYe5qALgAGrooYAXs5wYTTkdNeNBciFNTbdN0MVmO9UCJ+S99zZ9s14l9vBPBLRegDkA1JEBaZHb/7y5MnIqI35y5w90RMnznyY2CKCAaTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bna4uYzo; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=hM4Arz3ECp2TB6CkTXCrwFeiKmOj4WOQ4RjqWcON0XU=; b=bna4uYzo5OJEogGWmcdOKqMFi/
	bOn5jIcSb9kpFz7I130r+/uZY9DI/COA37AH4BR2f9fKYSlzwBp4XCjdAZ5lcIfYiy4S/4bhpNAHV
	aLWSZos61eEuuf+m+uf3iPZnPCeZC1f/CK3vYdXvpUTFy8C7HQCGc4eWYICtnQmua4oOXjFONskBp
	zajxWi//oI4eM++3/Vm5D+5K0RjX3fQgGraJ3KMunrQBl3Upw7eT92lZv5xrMjN6RwV8tqIc9pjyp
	5IRxP1w881ZXUzW2L/MzfXib6Hb/Li/INPEp+mL3lUlkz0GRki+/SpHt7XoFH1iMEVR62JWveSUaG
	DnvcBD1Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwNFG-00000005ufJ-3LN1;
	Wed, 10 Sep 2025 16:00:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id A0117302F5F; Wed, 10 Sep 2025 18:00:28 +0200 (CEST)
Message-ID: <20250910155809.456383178@infradead.org>
User-Agent: quilt/0.68
Date: Wed, 10 Sep 2025 17:44:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tj@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 mingo@redhat.com,
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
Subject: [PATCH 10/14] sched: Add locking comments to sched_class methods
References: <20250910154409.446470175@infradead.org>
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
@@ -581,8 +581,8 @@ EXPORT_SYMBOL(__trace_set_current_state)
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
@@ -4193,7 +4193,7 @@ int try_to_wake_up(struct task_struct *p
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
@@ -2320,8 +2320,7 @@ extern const u32		sched_prio_to_wmult[40
 /*
  * {de,en}queue flags:
  *
- * DEQUEUE_SLEEP  - task is no longer runnable
- * ENQUEUE_WAKEUP - task just became runnable
+ * SLEEP/WAKEUP - task is no-longer/just-became runnable
  *
  * SAVE/RESTORE - an otherwise spurious dequeue/enqueue, done to ensure tasks
  *                are in a known state which allows modification. Such pairs
@@ -2334,6 +2333,11 @@ extern const u32		sched_prio_to_wmult[40
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
@@ -2384,14 +2388,50 @@ struct sched_class {
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
@@ -2404,48 +2444,102 @@ struct sched_class {
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




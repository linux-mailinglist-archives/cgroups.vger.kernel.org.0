Return-Path: <cgroups+bounces-9935-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B81DB51CC3
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 18:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1778A017A1
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 16:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5DF334731;
	Wed, 10 Sep 2025 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oigPxxPB"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AD732C331;
	Wed, 10 Sep 2025 16:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520043; cv=none; b=AyWRd8TIDRfN4aX6EwVNa3jTbMCPwbPGq7Yu8c0nSgy6luOWOQFPo8T0VeZxvI3U7BD5/mjqNeBavwItvumJKvVw+Bpc2qnW/Fi0FaU+9+z9C/hwty8WZbEynnCd2O0EIs5oD0y2l5ximUvfxuf6q3mhWRl5wwF55OrqIyAH+xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520043; c=relaxed/simple;
	bh=HgpktHzVEl6mwka7+8MYjghT2mNOVlEJcpiW5DPBMyQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=jJG7S/f7WcgAl+I3ClfUxrnGO2UyEhBxIFseafFsFGF4A+6WoAXIlDijpQ9npSJChWiEvOHoZTKfTCkQgiK6EnHd5SU2lcDLd8TdCs8xsmXfhtFWkEB5dwgEi2DpjiQcRpdMwIoSnFZmZxChLIkEyucRm+cxykSfAxv2n3NjR7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oigPxxPB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=3pWhl54VJy6L23J3isnwQ/vKOpFfhFiPeN8RMgmrECE=; b=oigPxxPBxHQpMeZ/AhD24TQPzs
	0Pgu5bodTFf6vwhnNOm0F//F8vBFS2S2frn4MCfkCS3YS9R4khugpqonOwD7Ee7308nh1OtVecuqO
	4YcbHasyKjZgJhML4Uj9Z7S9umvCCR82z19J76cZmWffugW7idDf4CAx83iuQDU5AeKhmBshH85LN
	WXJiz9xxcr7V8xKHHgnIfr3IouDwHIkSPW37ZRjbGFCRwIV3/VlwMQhj7ohX1w7FlVc0Tf/oJBmED
	VSXw9g6sYMeu+Isj0thWinXecu/vAuZnLU4Td05xDIl/R3S96d9APHtlA/Vb5CprI6v/0t49EO6W/
	WgW/WMew==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwNFF-0000000BXor-3wnc;
	Wed, 10 Sep 2025 16:00:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 7A92930050D; Wed, 10 Sep 2025 18:00:28 +0200 (CEST)
Message-ID: <20250910155808.415580225@infradead.org>
User-Agent: quilt/0.68
Date: Wed, 10 Sep 2025 17:44:10 +0200
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
Subject: [PATCH 01/14] sched: Employ sched_change guards
References: <20250910154409.446470175@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

As proposed a long while ago -- and half done by scx -- wrap the
scheduler's 'change' pattern in a guard helper.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/cleanup.h |    5 +
 kernel/sched/core.c     |  156 +++++++++++++++++-------------------------------
 kernel/sched/ext.c      |   39 +++++-------
 kernel/sched/sched.h    |   21 +++---
 kernel/sched/syscalls.c |   65 +++++++-------------
 5 files changed, 114 insertions(+), 172 deletions(-)

--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -340,6 +340,11 @@ _label:
 #define __DEFINE_CLASS_IS_CONDITIONAL(_name, _is_cond)	\
 static __maybe_unused const bool class_##_name##_is_conditional = _is_cond
 
+#define DEFINE_CLASS_IS_UNCONDITIONAL(_name)		\
+	__DEFINE_CLASS_IS_CONDITIONAL(_name, false);	\
+	static inline void * class_##_name##_lock_ptr(class_##_name##_t *_T) \
+	{ return (void *)1; }
+
 #define __GUARD_IS_ERR(_ptr)                                       \
 	({                                                         \
 		unsigned long _rc = (__force unsigned long)(_ptr); \
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7361,7 +7361,7 @@ void rt_mutex_post_schedule(void)
  */
 void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 {
-	int prio, oldprio, queued, running, queue_flag =
+	int prio, oldprio, queue_flag =
 		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
 	const struct sched_class *prev_class, *next_class;
 	struct rq_flags rf;
@@ -7426,52 +7426,42 @@ void rt_mutex_setprio(struct task_struct
 	if (prev_class != next_class && p->se.sched_delayed)
 		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
 
-	queued = task_on_rq_queued(p);
-	running = task_current_donor(rq, p);
-	if (queued)
-		dequeue_task(rq, p, queue_flag);
-	if (running)
-		put_prev_task(rq, p);
-
-	/*
-	 * Boosting condition are:
-	 * 1. -rt task is running and holds mutex A
-	 *      --> -dl task blocks on mutex A
-	 *
-	 * 2. -dl task is running and holds mutex A
-	 *      --> -dl task blocks on mutex A and could preempt the
-	 *          running task
-	 */
-	if (dl_prio(prio)) {
-		if (!dl_prio(p->normal_prio) ||
-		    (pi_task && dl_prio(pi_task->prio) &&
-		     dl_entity_preempt(&pi_task->dl, &p->dl))) {
-			p->dl.pi_se = pi_task->dl.pi_se;
-			queue_flag |= ENQUEUE_REPLENISH;
+	scoped_guard (sched_change, p, queue_flag) {
+		/*
+		 * Boosting condition are:
+		 * 1. -rt task is running and holds mutex A
+		 *      --> -dl task blocks on mutex A
+		 *
+		 * 2. -dl task is running and holds mutex A
+		 *      --> -dl task blocks on mutex A and could preempt the
+		 *          running task
+		 */
+		if (dl_prio(prio)) {
+			if (!dl_prio(p->normal_prio) ||
+			    (pi_task && dl_prio(pi_task->prio) &&
+			     dl_entity_preempt(&pi_task->dl, &p->dl))) {
+				p->dl.pi_se = pi_task->dl.pi_se;
+				scope->flags |= ENQUEUE_REPLENISH;
+			} else {
+				p->dl.pi_se = &p->dl;
+			}
+		} else if (rt_prio(prio)) {
+			if (dl_prio(oldprio))
+				p->dl.pi_se = &p->dl;
+			if (oldprio < prio)
+				scope->flags |= ENQUEUE_HEAD;
 		} else {
-			p->dl.pi_se = &p->dl;
+			if (dl_prio(oldprio))
+				p->dl.pi_se = &p->dl;
+			if (rt_prio(oldprio))
+				p->rt.timeout = 0;
 		}
-	} else if (rt_prio(prio)) {
-		if (dl_prio(oldprio))
-			p->dl.pi_se = &p->dl;
-		if (oldprio < prio)
-			queue_flag |= ENQUEUE_HEAD;
-	} else {
-		if (dl_prio(oldprio))
-			p->dl.pi_se = &p->dl;
-		if (rt_prio(oldprio))
-			p->rt.timeout = 0;
-	}
 
-	p->sched_class = next_class;
-	p->prio = prio;
+		p->sched_class = next_class;
+		p->prio = prio;
 
-	check_class_changing(rq, p, prev_class);
-
-	if (queued)
-		enqueue_task(rq, p, queue_flag);
-	if (running)
-		set_next_task(rq, p);
+		check_class_changing(rq, p, prev_class);
+	}
 
 	check_class_changed(rq, p, prev_class, oldprio);
 out_unlock:
@@ -8119,26 +8109,9 @@ int migrate_task_to(struct task_struct *
  */
 void sched_setnuma(struct task_struct *p, int nid)
 {
-	bool queued, running;
-	struct rq_flags rf;
-	struct rq *rq;
-
-	rq = task_rq_lock(p, &rf);
-	queued = task_on_rq_queued(p);
-	running = task_current_donor(rq, p);
-
-	if (queued)
-		dequeue_task(rq, p, DEQUEUE_SAVE);
-	if (running)
-		put_prev_task(rq, p);
-
-	p->numa_preferred_nid = nid;
-
-	if (queued)
-		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
-	if (running)
-		set_next_task(rq, p);
-	task_rq_unlock(rq, p, &rf);
+	guard(task_rq_lock)(p);
+	scoped_guard (sched_change, p, DEQUEUE_SAVE)
+		p->numa_preferred_nid = nid;
 }
 #endif /* CONFIG_NUMA_BALANCING */
 
@@ -9240,8 +9213,9 @@ static void sched_change_group(struct ta
  */
 void sched_move_task(struct task_struct *tsk, bool for_autogroup)
 {
-	int queued, running, queue_flags =
+	unsigned int queue_flags =
 		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
+	bool resched = false;
 	struct rq *rq;
 
 	CLASS(task_rq_lock, rq_guard)(tsk);
@@ -9249,28 +9223,12 @@ void sched_move_task(struct task_struct
 
 	update_rq_clock(rq);
 
-	running = task_current_donor(rq, tsk);
-	queued = task_on_rq_queued(tsk);
-
-	if (queued)
-		dequeue_task(rq, tsk, queue_flags);
-	if (running)
-		put_prev_task(rq, tsk);
-
-	sched_change_group(tsk);
-	if (!for_autogroup)
-		scx_cgroup_move_task(tsk);
-
-	if (queued)
-		enqueue_task(rq, tsk, queue_flags);
-	if (running) {
-		set_next_task(rq, tsk);
-		/*
-		 * After changing group, the running task may have joined a
-		 * throttled one but it's still the running task. Trigger a
-		 * resched to make sure that task can still run.
-		 */
-		resched_curr(rq);
+	scoped_guard (sched_change, tsk, queue_flags) {
+		sched_change_group(tsk);
+		if (!for_autogroup)
+			scx_cgroup_move_task(tsk);
+		if (scope->running)
+			resched = true;
 	}
 }
 
@@ -10929,37 +10887,39 @@ void sched_mm_cid_fork(struct task_struc
 }
 #endif /* CONFIG_SCHED_MM_CID */
 
-#ifdef CONFIG_SCHED_CLASS_EXT
-void sched_deq_and_put_task(struct task_struct *p, int queue_flags,
-			    struct sched_enq_and_set_ctx *ctx)
+static DEFINE_PER_CPU(struct sched_change_ctx, sched_change_ctx);
+
+struct sched_change_ctx *sched_change_begin(struct task_struct *p, unsigned int flags)
 {
+	struct sched_change_ctx *ctx = this_cpu_ptr(&sched_change_ctx);
 	struct rq *rq = task_rq(p);
 
 	lockdep_assert_rq_held(rq);
 
-	*ctx = (struct sched_enq_and_set_ctx){
+	*ctx = (struct sched_change_ctx){
 		.p = p,
-		.queue_flags = queue_flags,
+		.flags = flags,
 		.queued = task_on_rq_queued(p),
 		.running = task_current(rq, p),
 	};
 
-	update_rq_clock(rq);
 	if (ctx->queued)
-		dequeue_task(rq, p, queue_flags | DEQUEUE_NOCLOCK);
+		dequeue_task(rq, p, flags);
 	if (ctx->running)
 		put_prev_task(rq, p);
+
+	return ctx;
 }
 
-void sched_enq_and_set_task(struct sched_enq_and_set_ctx *ctx)
+void sched_change_end(struct sched_change_ctx *ctx)
 {
-	struct rq *rq = task_rq(ctx->p);
+	struct task_struct *p = ctx->p;
+	struct rq *rq = task_rq(p);
 
 	lockdep_assert_rq_held(rq);
 
 	if (ctx->queued)
-		enqueue_task(rq, ctx->p, ctx->queue_flags | ENQUEUE_NOCLOCK);
+		enqueue_task(rq, p, ctx->flags | ENQUEUE_NOCLOCK);
 	if (ctx->running)
-		set_next_task(rq, ctx->p);
+		set_next_task(rq, p);
 }
-#endif /* CONFIG_SCHED_CLASS_EXT */
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4867,11 +4867,10 @@ static void scx_bypass(bool bypass)
 		 */
 		list_for_each_entry_safe_reverse(p, n, &rq->scx.runnable_list,
 						 scx.runnable_node) {
-			struct sched_enq_and_set_ctx ctx;
-
 			/* cycling deq/enq is enough, see the function comment */
-			sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
-			sched_enq_and_set_task(&ctx);
+			scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+				/* nothing */ ;
+			}
 		}
 
 		/* resched to restore ticks and idle state */
@@ -5003,17 +5002,16 @@ static void scx_disable_workfn(struct kt
 		const struct sched_class *old_class = p->sched_class;
 		const struct sched_class *new_class =
 			__setscheduler_class(p->policy, p->prio);
-		struct sched_enq_and_set_ctx ctx;
-
-		if (old_class != new_class && p->se.sched_delayed)
-			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
 
-		sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
+		update_rq_clock(task_rq(p));
 
-		p->sched_class = new_class;
-		check_class_changing(task_rq(p), p, old_class);
+		if (old_class != new_class && p->se.sched_delayed)
+			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
 
-		sched_enq_and_set_task(&ctx);
+		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK) {
+			p->sched_class = new_class;
+			check_class_changing(task_rq(p), p, old_class);
+		}
 
 		check_class_changed(task_rq(p), p, old_class, p->prio);
 		scx_exit_task(p);
@@ -5747,21 +5745,20 @@ static int scx_enable(struct sched_ext_o
 		const struct sched_class *old_class = p->sched_class;
 		const struct sched_class *new_class =
 			__setscheduler_class(p->policy, p->prio);
-		struct sched_enq_and_set_ctx ctx;
 
 		if (!tryget_task_struct(p))
 			continue;
 
-		if (old_class != new_class && p->se.sched_delayed)
-			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
-
-		sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
+		update_rq_clock(task_rq(p));
 
-		p->scx.slice = SCX_SLICE_DFL;
-		p->sched_class = new_class;
-		check_class_changing(task_rq(p), p, old_class);
+		if (old_class != new_class && p->se.sched_delayed)
+			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
 
-		sched_enq_and_set_task(&ctx);
+		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK) {
+			p->scx.slice = SCX_SLICE_DFL;
+			p->sched_class = new_class;
+			check_class_changing(task_rq(p), p, old_class);
+		}
 
 		check_class_changed(task_rq(p), p, old_class, p->prio);
 		put_task_struct(p);
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3860,23 +3860,22 @@ extern void check_class_changed(struct r
 extern struct balance_callback *splice_balance_callbacks(struct rq *rq);
 extern void balance_callbacks(struct rq *rq, struct balance_callback *head);
 
-#ifdef CONFIG_SCHED_CLASS_EXT
-/*
- * Used by SCX in the enable/disable paths to move tasks between sched_classes
- * and establish invariants.
- */
-struct sched_enq_and_set_ctx {
+struct sched_change_ctx {
 	struct task_struct	*p;
-	int			queue_flags;
+	int			flags;
 	bool			queued;
 	bool			running;
 };
 
-void sched_deq_and_put_task(struct task_struct *p, int queue_flags,
-			    struct sched_enq_and_set_ctx *ctx);
-void sched_enq_and_set_task(struct sched_enq_and_set_ctx *ctx);
+struct sched_change_ctx *sched_change_begin(struct task_struct *p, unsigned int flags);
+void sched_change_end(struct sched_change_ctx *ctx);
 
-#endif /* CONFIG_SCHED_CLASS_EXT */
+DEFINE_CLASS(sched_change, struct sched_change_ctx *,
+	     sched_change_end(_T),
+	     sched_change_begin(p, flags),
+	     struct task_struct *p, unsigned int flags)
+
+DEFINE_CLASS_IS_UNCONDITIONAL(sched_change)
 
 #include "ext.h"
 
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -64,7 +64,6 @@ static int effective_prio(struct task_st
 
 void set_user_nice(struct task_struct *p, long nice)
 {
-	bool queued, running;
 	struct rq *rq;
 	int old_prio;
 
@@ -90,22 +89,12 @@ void set_user_nice(struct task_struct *p
 		return;
 	}
 
-	queued = task_on_rq_queued(p);
-	running = task_current_donor(rq, p);
-	if (queued)
-		dequeue_task(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK);
-	if (running)
-		put_prev_task(rq, p);
-
-	p->static_prio = NICE_TO_PRIO(nice);
-	set_load_weight(p, true);
-	old_prio = p->prio;
-	p->prio = effective_prio(p);
-
-	if (queued)
-		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
-	if (running)
-		set_next_task(rq, p);
+	scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK) {
+		p->static_prio = NICE_TO_PRIO(nice);
+		set_load_weight(p, true);
+		old_prio = p->prio;
+		p->prio = effective_prio(p);
+	}
 
 	/*
 	 * If the task increased its priority or is running and
@@ -515,7 +504,7 @@ int __sched_setscheduler(struct task_str
 			 bool user, bool pi)
 {
 	int oldpolicy = -1, policy = attr->sched_policy;
-	int retval, oldprio, newprio, queued, running;
+	int retval, oldprio, newprio;
 	const struct sched_class *prev_class, *next_class;
 	struct balance_callback *head;
 	struct rq_flags rf;
@@ -698,33 +687,25 @@ int __sched_setscheduler(struct task_str
 	if (prev_class != next_class && p->se.sched_delayed)
 		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
 
-	queued = task_on_rq_queued(p);
-	running = task_current_donor(rq, p);
-	if (queued)
-		dequeue_task(rq, p, queue_flags);
-	if (running)
-		put_prev_task(rq, p);
-
-	if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)) {
-		__setscheduler_params(p, attr);
-		p->sched_class = next_class;
-		p->prio = newprio;
-	}
-	__setscheduler_uclamp(p, attr);
-	check_class_changing(rq, p, prev_class);
+	scoped_guard (sched_change, p, queue_flags) {
 
-	if (queued) {
-		/*
-		 * We enqueue to tail when the priority of a task is
-		 * increased (user space view).
-		 */
-		if (oldprio < p->prio)
-			queue_flags |= ENQUEUE_HEAD;
+		if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)) {
+			__setscheduler_params(p, attr);
+			p->sched_class = next_class;
+			p->prio = newprio;
+		}
+		__setscheduler_uclamp(p, attr);
+		check_class_changing(rq, p, prev_class);
 
-		enqueue_task(rq, p, queue_flags);
+		if (scope->queued) {
+			/*
+			 * We enqueue to tail when the priority of a task is
+			 * increased (user space view).
+			 */
+			if (oldprio < p->prio)
+				scope->flags |= ENQUEUE_HEAD;
+		}
 	}
-	if (running)
-		set_next_task(rq, p);
 
 	check_class_changed(rq, p, prev_class, oldprio);
 




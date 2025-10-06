Return-Path: <cgroups+bounces-10561-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2327FBBDC31
	for <lists+cgroups@lfdr.de>; Mon, 06 Oct 2025 12:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDD0C18978FB
	for <lists+cgroups@lfdr.de>; Mon,  6 Oct 2025 10:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EBD2749D5;
	Mon,  6 Oct 2025 10:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fYHMvtbw"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A80126A0DB;
	Mon,  6 Oct 2025 10:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759747565; cv=none; b=sGCeZvRhAEUQ2FbawQCr+1idX8QyOhoMmGv5Xuu3Le7nDEpI1teJu8pRYzF/SPxm1ZcXvDAnr9SADDi/J0eBCljqWBWW20AVpKDHulKkf7HU7LiFXdNBQGCorbRlSYYGAO/Ma3htFxY91YIf4+clXOTapu0ABhK5wg5BFit2DC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759747565; c=relaxed/simple;
	bh=w1lYh1YiRq6E0f553ouGsiKs7QHfZQxW7NSyJYfO3JA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=dcbPWJPzKLDH+8pamyfjFCu4/J644JPhlNL/c2lNImAsA3I+BeccSuKK8NH8fF7BAgrZPVNnIYRHQUStYE65fzFDhhgW9ibrt4BgnDKx8uCfscnDf3oVnUqWIIeYU3WR4lbmA4Z4YYAeR2U2ksuugQPGywrFhIrU1nPruEEtU08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fYHMvtbw; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=YzWW/tZ1HJVm0W1ykNrIHLrqdF6e6lEYaxKV/jPwKXw=; b=fYHMvtbwSxynWQrsh+uxfOW5ct
	LlWJ8GYDV/Ck2nyg6CKlMDhT4+V6S6qieNfz+O+oGw53jkZ48uLU7me8uWfWs8EWbYEKPN/4ufqYh
	yMiYyrT5XGVmcT0+dh3HEoGibJytA3zse7vOPUr/P1u0VgOnOaukn3D1fwroUB/44WA3D47iknesJ
	6uKLJxOUkhcKsyuUHM0SplJ3M5oxnLu13FVZ3+VycCRvILCQmPzlu2cQP6oy3qF86DG7q47qx6ZAn
	LI6OgKWqI9+DEsNi2V1CKAwiJ+CcOiUkgupHfUgqELqGvo2YqRsVUKS4Sa+YTJx6VtrEgNOYzszu5
	FJgXmzuA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5iiz-0000000Grdy-35eW;
	Mon, 06 Oct 2025 10:45:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id EDFF8303033; Mon, 06 Oct 2025 12:45:47 +0200 (CEST)
Message-ID: <20251006104527.928947651@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 06 Oct 2025 12:44:14 +0200
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
 tglx@linutronix.de,
 K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH 12/12] sched: Cleanup the sched_change NOCLOCK usage
References: <20251006104402.946760805@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Teach the sched_change pattern how to do update_rq_clock(); this
allows for some simplifications / cleanups.

Suggested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c     |   33 +++++++++++----------------------
 kernel/sched/ext.c      |    8 ++------
 kernel/sched/syscalls.c |    8 ++------
 3 files changed, 15 insertions(+), 34 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2346,10 +2346,8 @@ static void migrate_disable_switch(struc
 	if (p->cpus_ptr != &p->cpus_mask)
 		return;
 
-	scoped_guard (task_rq_lock, p) {
-		update_rq_clock(scope.rq);
+	scoped_guard (task_rq_lock, p)
 		do_set_cpus_allowed(p, &ac);
-	}
 }
 
 void ___migrate_enable(void)
@@ -2666,9 +2664,7 @@ void set_cpus_allowed_common(struct task
 static void
 do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
 {
-	u32 flags = DEQUEUE_SAVE | DEQUEUE_NOCLOCK;
-
-	scoped_guard (sched_change, p, flags) {
+	scoped_guard (sched_change, p, DEQUEUE_SAVE) {
 		p->sched_class->set_cpus_allowed(p, ctx);
 		mm_set_cpus_allowed(p->mm, ctx->new_mask);
 	}
@@ -2690,10 +2686,8 @@ void set_cpus_allowed_force(struct task_
 		struct rcu_head rcu;
 	};
 
-	scoped_guard (__task_rq_lock, p) {
-		update_rq_clock(scope.rq);
+	scoped_guard (__task_rq_lock, p)
 		do_set_cpus_allowed(p, &ac);
-	}
 
 	/*
 	 * Because this is called with p->pi_lock held, it is not possible
@@ -9110,16 +9104,13 @@ static void sched_change_group(struct ta
  */
 void sched_move_task(struct task_struct *tsk, bool for_autogroup)
 {
-	unsigned int queue_flags =
-		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
+	unsigned int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE;
 	bool resched = false;
 	struct rq *rq;
 
 	CLASS(task_rq_lock, rq_guard)(tsk);
 	rq = rq_guard.rq;
 
-	update_rq_clock(rq);
-
 	scoped_guard (sched_change, tsk, queue_flags) {
 		sched_change_group(tsk);
 		if (!for_autogroup)
@@ -10794,19 +10785,17 @@ struct sched_change_ctx *sched_change_be
 
 	lockdep_assert_rq_held(rq);
 
+	if (!(flags & DEQUEUE_NOCLOCK)) {
+		update_rq_clock(rq);
+		flags |= DEQUEUE_NOCLOCK;
+	}
+
 	if (flags & DEQUEUE_CLASS) {
 		if (WARN_ON_ONCE(flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)))
 			flags &= ~(DEQUEUE_SAVE | DEQUEUE_MOVE);
 
-		if (p->sched_class->switching_from) {
-			/*
-			 * switching_from_fair() assumes CLASS implies NOCLOCK;
-			 * fixing this assumption would mean switching_from()
-			 * would need to be able to change flags.
-			 */
-			WARN_ON(!(flags & DEQUEUE_NOCLOCK));
+		if (p->sched_class->switching_from)
 			p->sched_class->switching_from(rq, p);
-		}
 	}
 
 	*ctx = (struct sched_change_ctx){
@@ -10845,7 +10834,7 @@ void sched_change_end(struct sched_chang
 		p->sched_class->switching_to(rq, p);
 
 	if (ctx->queued)
-		enqueue_task(rq, p, ctx->flags | ENQUEUE_NOCLOCK);
+		enqueue_task(rq, p, ctx->flags);
 	if (ctx->running)
 		set_next_task(rq, p);
 
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3912,13 +3912,11 @@ static void scx_disable_workfn(struct kt
 
 	scx_task_iter_start(&sti);
 	while ((p = scx_task_iter_next_locked(&sti))) {
-		unsigned int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
+		unsigned int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE;
 		const struct sched_class *old_class = p->sched_class;
 		const struct sched_class *new_class =
 			__setscheduler_class(p->policy, p->prio);
 
-		update_rq_clock(task_rq(p));
-
 		if (old_class != new_class) {
 			queue_flags |= DEQUEUE_CLASS;
 			queue_flags &= ~(DEQUEUE_SAVE | DEQUEUE_MOVE);
@@ -4656,7 +4654,7 @@ static int scx_enable(struct sched_ext_o
 	percpu_down_write(&scx_fork_rwsem);
 	scx_task_iter_start(&sti);
 	while ((p = scx_task_iter_next_locked(&sti))) {
-		unsigned int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
+		unsigned int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE;
 		const struct sched_class *old_class = p->sched_class;
 		const struct sched_class *new_class =
 			__setscheduler_class(p->policy, p->prio);
@@ -4664,8 +4662,6 @@ static int scx_enable(struct sched_ext_o
 		if (!tryget_task_struct(p))
 			continue;
 
-		update_rq_clock(task_rq(p));
-
 		if (old_class != new_class) {
 			queue_flags |= DEQUEUE_CLASS;
 			queue_flags &= ~(DEQUEUE_SAVE | DEQUEUE_MOVE);
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -64,7 +64,6 @@ static int effective_prio(struct task_st
 
 void set_user_nice(struct task_struct *p, long nice)
 {
-	struct rq *rq;
 	int old_prio;
 
 	if (task_nice(p) == nice || nice < MIN_NICE || nice > MAX_NICE)
@@ -73,10 +72,7 @@ void set_user_nice(struct task_struct *p
 	 * We have to be careful, if called from sys_setpriority(),
 	 * the task might be in the middle of scheduling on another CPU.
 	 */
-	CLASS(task_rq_lock, rq_guard)(p);
-	rq = rq_guard.rq;
-
-	update_rq_clock(rq);
+	guard(task_rq_lock)(p);
 
 	/*
 	 * The RT priorities are set via sched_setscheduler(), but we still
@@ -89,7 +85,7 @@ void set_user_nice(struct task_struct *p
 		return;
 	}
 
-	scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK) {
+	scoped_guard (sched_change, p, DEQUEUE_SAVE) {
 		p->static_prio = NICE_TO_PRIO(nice);
 		set_load_weight(p, true);
 		old_prio = p->prio;




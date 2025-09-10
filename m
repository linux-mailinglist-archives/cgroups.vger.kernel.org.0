Return-Path: <cgroups+bounces-9932-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18486B51CC0
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 18:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12854A0184C
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 16:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8680533436A;
	Wed, 10 Sep 2025 16:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bXB8xur8"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8955B311944;
	Wed, 10 Sep 2025 16:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520042; cv=none; b=htHLjC/NC5poxxTvq3AxNjbexkg8rArmLRoARIHAi2j+9BEq/hlSeexBmM8ttD7QnGrZKhplG5kBdi9cdScPxpsUJ/9syzOTS7M3QIFBtTnS/JCWBO2k/aqiNOqS/OCsFjNImBJTNp61AU+YIPkExEdMlCTMw/Viz0deiGwZBbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520042; c=relaxed/simple;
	bh=B8aSuqbTgLfmYBfvMd3xIXOwLf3sM4eWPpCxmqmLkIQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=k8zzmAVDmECy4CilUs083QFtOllZziJdLRozwppCoeZl1YY1NWBQwMuxcWu4RA6FTgAXan6boNDdQ7C/PScLeV5k9tN5qfCfij8ihLBRx9QV66DciUKLBOOCy71Pe69bCtmJAtmOQ0/vjL/BdFz4WGTI/R9Eluezekb09qgFfu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bXB8xur8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=3J8eOg/7mOqS6yso4behIDB9wj7wsh81tlPZ1LgWgX0=; b=bXB8xur8nanb7DTbYIt3SOumzk
	xSBhQsb3nTy4o72SqqQg/MM/7IQv00zUznLJzLPpwOaZgLtDh5zGAmsIT6uK58pCm/D4uMTjU9rZq
	Seu2jiqOgyGqFea/67h4Z6rjJua5pgxwf8/CbLW0LzFA3BPffS9BLAc5npaEjN6lUaZO1HHxXwMGv
	oYs2Aokjf/jZHtglqKhA30xekNR0uB8x8zT67qmjjAIcZdUjdkR4SMHy2p6rK/xv9FP+P9uoOrAut
	rfpm89RPoYf+XfmjprUZIguLKMNPdRRRlea6iMfAlfdL+WRAp3vx/FrKvm5n++YY0a92JKCIdw2Tc
	EUpRf3XA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwNFH-0000000BXpK-0cXS;
	Wed, 10 Sep 2025 16:00:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id B0097302FFC; Wed, 10 Sep 2025 18:00:28 +0200 (CEST)
Message-ID: <20250910155809.916720757@infradead.org>
User-Agent: quilt/0.68
Date: Wed, 10 Sep 2025 17:44:23 +0200
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
Subject: [PATCH 14/14] sched/ext: Implement p->srq_lock support
References: <20250910154409.446470175@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Have enqueue set p->srq_lock to &dsq->lock and have dequeue clear it,
when dst is non-local.

When enqueue sees ENQUEUE_LOCKED, it must lock dsq->lock (since
p->srq_lock will be NULL on entry) but must not unlock on exit when it
sets p->srq_lock.

When dequeue sees DEQUEUE_LOCKED, it must not lock dsq->lock when
p->srq_lock is set (instead it must verify they are the same), but it
must unlock on exit, since it will have cleared p->srq_lock.

For DEQUEUE_SAVE/ENQUEUE_RESTORE it can retain p->srq_lock, since
the extra unlock+lock cycle is pointless.

Note: set_next_task_scx() relies on LOCKED to avoid self-recursion on
dsq->lock in the enqueue_task/set_next_task case.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/ext.c |   68 ++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 21 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1952,13 +1952,16 @@ static void dispatch_enqueue(struct scx_
 			     struct task_struct *p, u64 enq_flags)
 {
 	bool is_local = dsq->id == SCX_DSQ_LOCAL;
+	bool locked = enq_flags & ENQUEUE_LOCKED;
+	bool restore = enq_flags & ENQUEUE_RESTORE;
 
 	WARN_ON_ONCE(p->scx.dsq || !list_empty(&p->scx.dsq_list.node));
 	WARN_ON_ONCE((p->scx.dsq_flags & SCX_TASK_DSQ_ON_PRIQ) ||
 		     !RB_EMPTY_NODE(&p->scx.dsq_priq));
 
 	if (!is_local) {
-		raw_spin_lock(&dsq->lock);
+		if (!locked || !p->srq_lock)
+			raw_spin_lock(&dsq->lock);
 		if (unlikely(dsq->id == SCX_DSQ_INVALID)) {
 			scx_error(sch, "attempting to dispatch to a destroyed dsq");
 			/* fall back to the global dsq */
@@ -2028,6 +2031,10 @@ static void dispatch_enqueue(struct scx_
 
 	dsq_mod_nr(dsq, 1);
 	p->scx.dsq = dsq;
+	if (!is_local) {
+		WARN_ON_ONCE(locked && restore && p->srq_lock && p->srq_lock != &dsq->lock);
+		p->srq_lock = &dsq->lock;
+	}
 
 	/*
 	 * scx.ddsp_dsq_id and scx.ddsp_enq_flags are only relevant on the
@@ -2059,13 +2066,17 @@ static void dispatch_enqueue(struct scx_
 						 rq->curr->sched_class))
 			resched_curr(rq);
 	} else {
-		raw_spin_unlock(&dsq->lock);
+		if (!locked)
+			raw_spin_unlock(&dsq->lock);
 	}
 }
 
 static void task_unlink_from_dsq(struct task_struct *p,
-				 struct scx_dispatch_q *dsq)
+				 struct scx_dispatch_q *dsq,
+				 int deq_flags)
 {
+	bool save = deq_flags & DEQUEUE_SAVE;
+
 	WARN_ON_ONCE(list_empty(&p->scx.dsq_list.node));
 
 	if (p->scx.dsq_flags & SCX_TASK_DSQ_ON_PRIQ) {
@@ -2076,12 +2087,15 @@ static void task_unlink_from_dsq(struct
 
 	list_del_init(&p->scx.dsq_list.node);
 	dsq_mod_nr(dsq, -1);
+	if (!save)
+		p->srq_lock = NULL;
 }
 
-static void dispatch_dequeue(struct rq *rq, struct task_struct *p)
+static void dispatch_dequeue(struct rq *rq, struct task_struct *p, int deq_flags)
 {
 	struct scx_dispatch_q *dsq = p->scx.dsq;
 	bool is_local = dsq == &rq->scx.local_dsq;
+	bool locked = deq_flags & DEQUEUE_LOCKED;
 
 	if (!dsq) {
 		/*
@@ -2103,8 +2117,10 @@ static void dispatch_dequeue(struct rq *
 		return;
 	}
 
-	if (!is_local)
-		raw_spin_lock(&dsq->lock);
+	if (!is_local) {
+		if (!locked)
+			raw_spin_lock(&dsq->lock);
+	}
 
 	/*
 	 * Now that we hold @dsq->lock, @p->holding_cpu and @p->scx.dsq_* can't
@@ -2112,7 +2128,8 @@ static void dispatch_dequeue(struct rq *
 	*/
 	if (p->scx.holding_cpu < 0) {
 		/* @p must still be on @dsq, dequeue */
-		task_unlink_from_dsq(p, dsq);
+		WARN_ON_ONCE(!is_local && !p->srq_lock);
+		task_unlink_from_dsq(p, dsq, deq_flags);
 	} else {
 		/*
 		 * We're racing against dispatch_to_local_dsq() which already
@@ -2125,8 +2142,10 @@ static void dispatch_dequeue(struct rq *
 	}
 	p->scx.dsq = NULL;
 
-	if (!is_local)
-		raw_spin_unlock(&dsq->lock);
+	if (!is_local) {
+		if (!locked || !p->srq_lock)
+			raw_spin_unlock(&dsq->lock);
+	}
 }
 
 static struct scx_dispatch_q *find_dsq_for_dispatch(struct scx_sched *sch,
@@ -2372,7 +2391,7 @@ static void clr_task_runnable(struct tas
 		p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;
 }
 
-static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first);
+static void __set_next_task_scx(struct rq *rq, struct task_struct *p, u32 qf);
 
 static void enqueue_task_scx(struct rq *rq, struct task_struct *p, u32 enq_flags)
 {
@@ -2421,7 +2440,7 @@ static void enqueue_task_scx(struct rq *
 		__scx_add_event(sch, SCX_EV_SELECT_CPU_FALLBACK, 1);
 
 	if (enq_flags & ENQUEUE_CURR)
-		set_next_task_scx(rq, p, false);
+		__set_next_task_scx(rq, p, enq_flags);
 }
 
 static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
@@ -2516,7 +2535,7 @@ static bool dequeue_task_scx(struct rq *
 	rq->scx.nr_running--;
 	sub_nr_running(rq, 1);
 
-	dispatch_dequeue(rq, p);
+	dispatch_dequeue(rq, p, deq_flags);
 
 out:
 	if (deq_flags & DEQUEUE_CURR)
@@ -2710,7 +2729,7 @@ static bool unlink_dsq_and_lock_src_rq(s
 	lockdep_assert_held(&dsq->lock);
 
 	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
-	task_unlink_from_dsq(p, dsq);
+	task_unlink_from_dsq(p, dsq, 0);
 	p->scx.holding_cpu = cpu;
 
 	raw_spin_unlock(&dsq->lock);
@@ -2782,7 +2801,7 @@ static struct rq *move_task_between_dsqs
 	if (dst_dsq->id == SCX_DSQ_LOCAL) {
 		/* @p is going from a non-local DSQ to a local DSQ */
 		if (src_rq == dst_rq) {
-			task_unlink_from_dsq(p, src_dsq);
+			task_unlink_from_dsq(p, src_dsq, 0);
 			move_local_task_to_local_dsq(p, enq_flags,
 						     src_dsq, dst_rq);
 			raw_spin_unlock(&src_dsq->lock);
@@ -2796,7 +2815,7 @@ static struct rq *move_task_between_dsqs
 		 * @p is going from a non-local DSQ to a non-local DSQ. As
 		 * $src_dsq is already locked, do an abbreviated dequeue.
 		 */
-		task_unlink_from_dsq(p, src_dsq);
+		task_unlink_from_dsq(p, src_dsq, 0);
 		p->scx.dsq = NULL;
 		raw_spin_unlock(&src_dsq->lock);
 
@@ -2862,7 +2881,7 @@ static bool consume_dispatch_q(struct sc
 		struct rq *task_rq = task_rq(p);
 
 		if (rq == task_rq) {
-			task_unlink_from_dsq(p, dsq);
+			task_unlink_from_dsq(p, dsq, 0);
 			move_local_task_to_local_dsq(p, 0, dsq, rq);
 			raw_spin_unlock(&dsq->lock);
 			return true;
@@ -3256,7 +3275,7 @@ static void process_ddsp_deferred_locals
 	}
 }
 
-static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
+static void __set_next_task_scx(struct rq *rq, struct task_struct *p, u32 qf)
 {
 	struct scx_sched *sch = scx_root;
 
@@ -3266,7 +3285,7 @@ static void set_next_task_scx(struct rq
 		 * dispatched. Call ops_dequeue() to notify the BPF scheduler.
 		 */
 		ops_dequeue(rq, p, SCX_DEQ_CORE_SCHED_EXEC);
-		dispatch_dequeue(rq, p);
+		dispatch_dequeue(rq, p, qf);
 	}
 
 	p->se.exec_start = rq_clock_task(rq);
@@ -3300,6 +3319,11 @@ static void set_next_task_scx(struct rq
 	}
 }
 
+static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
+{
+	__set_next_task_scx(rq, p, 0);
+}
+
 static enum scx_cpu_preempt_reason
 preempt_reason_from_class(const struct sched_class *class)
 {
@@ -5012,7 +5036,8 @@ static void scx_disable_workfn(struct kt
 
 	scx_task_iter_start(&sti);
 	while ((p = scx_task_iter_next_locked(&sti))) {
-		unsigned int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
+		unsigned int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE |
+					   DEQUEUE_NOCLOCK | DEQUEUE_LOCKED;
 		const struct sched_class *old_class = p->sched_class;
 		const struct sched_class *new_class =
 			__setscheduler_class(p->policy, p->prio);
@@ -5756,7 +5781,8 @@ static int scx_enable(struct sched_ext_o
 	percpu_down_write(&scx_fork_rwsem);
 	scx_task_iter_start(&sti);
 	while ((p = scx_task_iter_next_locked(&sti))) {
-		unsigned int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
+		unsigned int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE |
+					   DEQUEUE_NOCLOCK | DEQUEUE_LOCKED;
 		const struct sched_class *old_class = p->sched_class;
 		const struct sched_class *new_class =
 			__setscheduler_class(p->policy, p->prio);
@@ -6808,7 +6834,7 @@ __bpf_kfunc u32 scx_bpf_reenqueue_local(
 		if (p->migration_pending || is_migration_disabled(p) || p->nr_cpus_allowed == 1)
 			continue;
 
-		dispatch_dequeue(rq, p);
+		dispatch_dequeue(rq, p, 0);
 		list_add_tail(&p->scx.dsq_list.node, &tasks);
 	}
 




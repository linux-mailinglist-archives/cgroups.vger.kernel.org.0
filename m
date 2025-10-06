Return-Path: <cgroups+bounces-10564-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D8FBBDD0A
	for <lists+cgroups@lfdr.de>; Mon, 06 Oct 2025 12:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C7963AB653
	for <lists+cgroups@lfdr.de>; Mon,  6 Oct 2025 10:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC5F269806;
	Mon,  6 Oct 2025 10:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IWTTWG7H"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBAE260590;
	Mon,  6 Oct 2025 10:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759748232; cv=none; b=mXanGQJJU4gENOiLWbE21ThxyKKN/Wu9siEconfgB8DCS9G0IvZrg9qIcJH6peXP7YtOgwZ3HIvjQmtr/wdNT13w8tZpNq6i2YJjlPuKXKW9W9t4Sw7dfD+Fv1uIkUzYoEIrFNLEMSZPMJE4j1i6HwlIn2TtICW/npkmFfVRjPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759748232; c=relaxed/simple;
	bh=vyaUnMdaOtXeKrezU9V9CDGlAt+GFGGC6ePt8MPN0kQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=m4EMRVkryk7GB3cFH/5ZIVdxdzNAzyFB1Hi7oOyS9/l+CPw76h7pJVvAdGEZBO4Z/QqMvlEkQ2a3cyAPM/gssBDKxJgRV/Vgti+Tie9uu96GFcprYDcp4ZUhv9VcWomS6EAI2Q42z+TpGt2SUyWE5Ws44hOcpu61Y35Gb9LDRWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IWTTWG7H; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=eRhxKTeuHgwgyCO6J7vkEdd6ETjweUfiuf4s5wTK13Y=; b=IWTTWG7HNuq7QsUnKs3FwCyLRK
	lf69/Skb+fADkPvzhMwFmQOO7TvSvT6NXolLQXC7s9tGeKuP0b7UnaR+Q+6kM06sEE2nFHAhWb6sM
	bQ3RR/JIqOHuv8ydN3yeTheWRzCC6HaOy03Qeqa0ANi8Qp+f+AeNEQC59ZBdd86JeWrJPEZwE0RpW
	WlHk+JlucG2Hrr8WWLnm49aSP+Ufhn+fJ5AUbdPPCu1lbdEIowpGodfLhKwP2ncCA/WB7iFgstsn6
	3L8W4HieLYSaUhdE9tg1d4db6sB4cyR5rFG5aZPbiJtl5+5emZBHdZcUAzAlW7u1Vud/HedQs3SMK
	3xJreQKw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5ito-0000000GrzH-3ZfR;
	Mon, 06 Oct 2025 10:57:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 6C51C300754; Mon, 06 Oct 2025 12:57:00 +0200 (CEST)
Message-ID: <20251006105453.769281377@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 06 Oct 2025 12:46:55 +0200
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
Subject: [RFC][PATCH 3/3] sched/ext: Fold balance_scx() into pick_task_scx()
References: <20251006104652.630431579@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

With pick_task() having an rf argument, it is possible to do the
lock-break there, get rid of the weird balance/pick_task hack.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c  |   13 --------
 kernel/sched/ext.c   |   78 +++++++--------------------------------------------
 kernel/sched/sched.h |    1 
 3 files changed, 12 insertions(+), 80 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5845,19 +5845,6 @@ static void prev_balance(struct rq *rq,
 	const struct sched_class *start_class = prev->sched_class;
 	const struct sched_class *class;
 
-#ifdef CONFIG_SCHED_CLASS_EXT
-	/*
-	 * SCX requires a balance() call before every pick_task() including when
-	 * waking up from SCHED_IDLE. If @start_class is below SCX, start from
-	 * SCX instead. Also, set a flag to detect missing balance() call.
-	 */
-	if (scx_enabled()) {
-		rq->scx.flags |= SCX_RQ_BAL_PENDING;
-		if (sched_class_above(&ext_sched_class, start_class))
-			start_class = &ext_sched_class;
-	}
-#endif
-
 	/*
 	 * We must do the balancing pass before put_prev_task(), such
 	 * that when we release the rq->lock the task is in the same
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2013,7 +2013,7 @@ static int balance_one(struct rq *rq, st
 
 	lockdep_assert_rq_held(rq);
 	rq->scx.flags |= SCX_RQ_IN_BALANCE;
-	rq->scx.flags &= ~(SCX_RQ_BAL_PENDING | SCX_RQ_BAL_KEEP);
+	rq->scx.flags &= ~SCX_RQ_BAL_KEEP;
 
 	if ((sch->ops.flags & SCX_OPS_HAS_CPU_PREEMPT) &&
 	    unlikely(rq->scx.cpu_released)) {
@@ -2119,40 +2119,6 @@ static int balance_one(struct rq *rq, st
 	return true;
 }
 
-static int balance_scx(struct rq *rq, struct task_struct *prev,
-		       struct rq_flags *rf)
-{
-	int ret;
-
-	rq_unpin_lock(rq, rf);
-
-	ret = balance_one(rq, prev);
-
-#ifdef CONFIG_SCHED_SMT
-	/*
-	 * When core-sched is enabled, this ops.balance() call will be followed
-	 * by pick_task_scx() on this CPU and the SMT siblings. Balance the
-	 * siblings too.
-	 */
-	if (sched_core_enabled(rq)) {
-		const struct cpumask *smt_mask = cpu_smt_mask(cpu_of(rq));
-		int scpu;
-
-		for_each_cpu_andnot(scpu, smt_mask, cpumask_of(cpu_of(rq))) {
-			struct rq *srq = cpu_rq(scpu);
-			struct task_struct *sprev = srq->curr;
-
-			WARN_ON_ONCE(__rq_lockp(rq) != __rq_lockp(srq));
-			update_rq_clock(srq);
-			balance_one(srq, sprev);
-		}
-	}
-#endif
-	rq_repin_lock(rq, rf);
-
-	return ret;
-}
-
 static void process_ddsp_deferred_locals(struct rq *rq)
 {
 	struct task_struct *p;
@@ -2335,38 +2301,19 @@ static struct task_struct *first_local_t
 static struct task_struct *pick_task_scx(struct rq *rq, struct rq_flags *rf)
 {
 	struct task_struct *prev = rq->curr;
+	bool keep_prev, kick_idle = false;
 	struct task_struct *p;
-	bool keep_prev = rq->scx.flags & SCX_RQ_BAL_KEEP;
-	bool kick_idle = false;
 
-	/*
-	 * WORKAROUND:
-	 *
-	 * %SCX_RQ_BAL_KEEP should be set iff $prev is on SCX as it must just
-	 * have gone through balance_scx(). Unfortunately, there currently is a
-	 * bug where fair could say yes on balance() but no on pick_task(),
-	 * which then ends up calling pick_task_scx() without preceding
-	 * balance_scx().
-	 *
-	 * Keep running @prev if possible and avoid stalling from entering idle
-	 * without balancing.
-	 *
-	 * Once fair is fixed, remove the workaround and trigger WARN_ON_ONCE()
-	 * if pick_task_scx() is called without preceding balance_scx().
-	 */
-	if (unlikely(rq->scx.flags & SCX_RQ_BAL_PENDING)) {
-		if (prev->scx.flags & SCX_TASK_QUEUED) {
-			keep_prev = true;
-		} else {
-			keep_prev = false;
-			kick_idle = true;
-		}
-	} else if (unlikely(keep_prev &&
-			    prev->sched_class != &ext_sched_class)) {
-		/*
-		 * Can happen while enabling as SCX_RQ_BAL_PENDING assertion is
-		 * conditional on scx_enabled() and may have been skipped.
-		 */
+	rq->queue_mask = 0;
+	rq_unpin_lock(rq, rf);
+	balance_one(rq, prev);
+	rq_repin_lock(rq, rf);
+	if (rq->queue_mask & ~((ext_sched_class.queue_mask << 1)-1))
+		return RETRY_TASK;
+
+	keep_prev = rq->scx.flags & SCX_RQ_BAL_KEEP;
+	if (unlikely(keep_prev &&
+		     prev->sched_class != &ext_sched_class)) {
 		WARN_ON_ONCE(scx_enable_state() == SCX_ENABLED);
 		keep_prev = false;
 	}
@@ -3243,7 +3190,6 @@ DEFINE_SCHED_CLASS(ext) = {
 
 	.wakeup_preempt		= wakeup_preempt_scx,
 
-	.balance		= balance_scx,
 	.pick_task		= pick_task_scx,
 
 	.put_prev_task		= put_prev_task_scx,
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -779,7 +779,6 @@ enum scx_rq_flags {
 	 */
 	SCX_RQ_ONLINE		= 1 << 0,
 	SCX_RQ_CAN_STOP_TICK	= 1 << 1,
-	SCX_RQ_BAL_PENDING	= 1 << 2, /* balance hasn't run yet */
 	SCX_RQ_BAL_KEEP		= 1 << 3, /* balance decided to keep current */
 	SCX_RQ_BYPASSING	= 1 << 4,
 	SCX_RQ_CLK_VALID	= 1 << 5, /* RQ clock is fresh and valid */




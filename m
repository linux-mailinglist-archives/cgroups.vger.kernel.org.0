Return-Path: <cgroups+bounces-9931-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF389B51CBE
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 18:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B23B11C81CB0
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 16:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F14032ED55;
	Wed, 10 Sep 2025 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SXt8fcWT"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB40926B75C;
	Wed, 10 Sep 2025 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520041; cv=none; b=WnyNrYTCGbITH3wjexACjJkXTVmIuJtvojVbnMGaV0tOH/YI57vCbz3NKcRmmAmtZSmLSSWIMfzFnXdbNWDmIytpghUVN3lO3x74BzKdJUJFuhzb2ZnPkcT4Fg2c+j4GOxoms3bgUqELC8hUHBJbKleFEDfu1IW2PtNZESk+tTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520041; c=relaxed/simple;
	bh=v/Iu70dxRzbGDCv8MSQ/4Ric2NCqoqB/0rR4wmEUtFU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=l39jzq5GmhQ+73ObXnF8wAGUCk2y5FCdqf83xvAbS7BoEMJN7yYH69FLnzLO6aQgyZ3c4xXuKensR6vwRmiQsDtqSlRqR06LqLEb+RLuK82yrwPTyhR24qk+Fi0oHGNcj4T+jw8bssuWM+opdmXMZ9rzRU1jt3mOreuaFJ4zQPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SXt8fcWT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=5odGo3alJRTX8gNydTE0XZfL6eVbL5R2OiB+CAHbetE=; b=SXt8fcWTTp6l1Z/JZkZuUcRAZL
	bjrlm97YT27B/8/d9gHCTxDXjFU6+/7ECshmtbp2PxsPidaGdmWMK1ipDbp8vr4ptbGCp6jF18tAl
	+ZldycbT1OxQL6rdp1QGWkdcvleFsT2eR4urMobeRYY+6zdtqWF4nRZlnCm0dgIFUfqzCEZGdQjgv
	ts/NnmMKBVb45T/dRaVseY1EHhmkfNopU5VfDR4R+c+O+/Kev+oJ5yoYhBUVSzELLStYjfWl90tVd
	Utd2PvSBImiOCspMAL/vJrZ6X45YLk7RZ9T1FNbqsPrPtA5QxtWW8/VT0f1PSnuMtauYAKSwOg3Ci
	Nhp4jaZw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwNFH-0000000BXpI-0Wsj;
	Wed, 10 Sep 2025 16:00:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id A82F8302FD7; Wed, 10 Sep 2025 18:00:28 +0200 (CEST)
Message-ID: <20250910155809.684653538@infradead.org>
User-Agent: quilt/0.68
Date: Wed, 10 Sep 2025 17:44:21 +0200
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
Subject: [PATCH 12/14] sched: Add shared runqueue locking to __task_rq_lock()
References: <20250910154409.446470175@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

In order to fix the whole SCHED_EXT balance/pick mess, and avoid
further complicating all this, make the regular:

  p->pi_lock
    rq->lock
      dsq->lock

order work. Notably, while sched_class::pick_task() is called with
rq->lock held, and pick_task_scx() takes dsq->lock, and while the
normal sched_change pattern goes into dequeue/enqueue and thus takes
dsq->lock, various other things like task_call_func() /
sched_setaffinity() do not necessarily do so.

Therefore, add a per task spinlock pointer that can be set to
reference the shared runqueue lock where appropriate and teach
__task_rq_lock() to take this long along with rq->lock.

This ensures all 'normal' scheduling operations serialize against the
shared lock.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h |    2 +-
 kernel/sched/core.c   |   27 ++++++++++++++++++++++-----
 kernel/sched/sched.h  |   10 ++++++----
 kernel/sched/stats.h  |    2 +-
 4 files changed, 30 insertions(+), 11 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1225,8 +1225,8 @@ struct task_struct {
 	/* Protection against (de-)allocation: mm, files, fs, tty, keyrings, mems_allowed, mempolicy: */
 	spinlock_t			alloc_lock;
 
-	/* Protection of the PI data structures: */
 	raw_spinlock_t			pi_lock;
+	raw_spinlock_t			*srq_lock;
 
 	struct wake_q_node		wake_q;
 
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -703,17 +703,24 @@ void double_rq_lock(struct rq *rq1, stru
 struct rq *__task_rq_lock(struct task_struct *p, struct rq_flags *rf)
 	__acquires(rq->lock)
 {
+	raw_spinlock_t *slock;
 	struct rq *rq;
 
 	lockdep_assert_held(&p->pi_lock);
 
 	for (;;) {
 		rq = task_rq(p);
+		slock = p->srq_lock;
 		raw_spin_rq_lock(rq);
-		if (likely(rq == task_rq(p) && !task_on_rq_migrating(p))) {
+		if (slock)
+			raw_spin_lock(slock);
+		if (likely(rq == task_rq(p) && !task_on_rq_migrating(p) &&
+			   (!slock || p->srq_lock == slock))) {
 			rq_pin_lock(rq, rf);
 			return rq;
 		}
+		if (slock)
+			raw_spin_unlock(slock);
 		raw_spin_rq_unlock(rq);
 
 		while (unlikely(task_on_rq_migrating(p)))
@@ -728,12 +735,16 @@ struct rq *task_rq_lock(struct task_stru
 	__acquires(p->pi_lock)
 	__acquires(rq->lock)
 {
+	raw_spinlock_t *slock;
 	struct rq *rq;
 
 	for (;;) {
 		raw_spin_lock_irqsave(&p->pi_lock, rf->flags);
 		rq = task_rq(p);
+		slock = p->srq_lock;
 		raw_spin_rq_lock(rq);
+		if (slock)
+			raw_spin_lock(slock);
 		/*
 		 *	move_queued_task()		task_rq_lock()
 		 *
@@ -751,10 +762,14 @@ struct rq *task_rq_lock(struct task_stru
 		 * dependency headed by '[L] rq = task_rq()' and the acquire
 		 * will pair with the WMB to ensure we then also see migrating.
 		 */
-		if (likely(rq == task_rq(p) && !task_on_rq_migrating(p))) {
+		if (likely(rq == task_rq(p) && !task_on_rq_migrating(p) &&
+			   (!slock || p->srq_lock == slock))) {
 			rq_pin_lock(rq, rf);
 			return rq;
 		}
+
+		if (slock)
+			raw_spin_unlock(slock);
 		raw_spin_rq_unlock(rq);
 		raw_spin_unlock_irqrestore(&p->pi_lock, rf->flags);
 
@@ -2617,7 +2632,8 @@ static int migration_cpu_stop(void *data
 		 */
 		WARN_ON_ONCE(!pending->stop_pending);
 		preempt_disable();
-		task_rq_unlock(rq, p, &rf);
+		rq_unlock(rq, &rf);
+		raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
 		stop_one_cpu_nowait(task_cpu(p), migration_cpu_stop,
 				    &pending->arg, &pending->stop_work);
 		preempt_enable();
@@ -2626,7 +2642,8 @@ static int migration_cpu_stop(void *data
 out:
 	if (pending)
 		pending->stop_pending = false;
-	task_rq_unlock(rq, p, &rf);
+	rq_unlock(rq, &rf);
+	raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
 
 	if (complete)
 		complete_all(&pending->done);
@@ -3743,7 +3760,7 @@ static int ttwu_runnable(struct task_str
 		ttwu_do_wakeup(p);
 		ret = 1;
 	}
-	__task_rq_unlock(rq, &rf);
+	__task_rq_unlock(rq, p, &rf);
 
 	return ret;
 }
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1800,10 +1800,13 @@ struct rq *task_rq_lock(struct task_stru
 	__acquires(p->pi_lock)
 	__acquires(rq->lock);
 
-static inline void __task_rq_unlock(struct rq *rq, struct rq_flags *rf)
+static inline void
+__task_rq_unlock(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
 	__releases(rq->lock)
 {
 	rq_unpin_lock(rq, rf);
+	if (p->srq_lock)
+		raw_spin_unlock(p->srq_lock);
 	raw_spin_rq_unlock(rq);
 }
 
@@ -1812,8 +1815,7 @@ task_rq_unlock(struct rq *rq, struct tas
 	__releases(rq->lock)
 	__releases(p->pi_lock)
 {
-	rq_unpin_lock(rq, rf);
-	raw_spin_rq_unlock(rq);
+	__task_rq_unlock(rq, p, rf);
 	raw_spin_unlock_irqrestore(&p->pi_lock, rf->flags);
 }
 
@@ -1824,7 +1826,7 @@ DEFINE_LOCK_GUARD_1(task_rq_lock, struct
 
 DEFINE_LOCK_GUARD_1(__task_rq_lock, struct task_struct,
 		    _T->rq = __task_rq_lock(_T->lock, &_T->rf),
-		    __task_rq_unlock(_T->rq, &_T->rf),
+		    __task_rq_unlock(_T->rq, _T->lock, &_T->rf),
 		    struct rq *rq; struct rq_flags rf)
 
 static inline void rq_lock_irqsave(struct rq *rq, struct rq_flags *rf)
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -206,7 +206,7 @@ static inline void psi_ttwu_dequeue(stru
 
 		rq = __task_rq_lock(p, &rf);
 		psi_task_change(p, p->psi_flags, 0);
-		__task_rq_unlock(rq, &rf);
+		__task_rq_unlock(rq, p, &rf);
 	}
 }
 




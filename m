Return-Path: <cgroups+bounces-10556-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A374BBDC13
	for <lists+cgroups@lfdr.de>; Mon, 06 Oct 2025 12:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FC4B3BB8AE
	for <lists+cgroups@lfdr.de>; Mon,  6 Oct 2025 10:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6102701DA;
	Mon,  6 Oct 2025 10:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G09lvud0"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A25926A08F;
	Mon,  6 Oct 2025 10:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759747564; cv=none; b=VQ9L5/unNwCy0pVtsO9/sIyiHqXY5lNAXGWvcS5vJokt6a5bxxobk23dS2yeDYrtMFyBoxgJXCWX8J/gczY/DgaGWF9QiRBP2t71eCnclxkLDlwxRmHzSLni10PKn3CwpUyCqWomUE53ZRKtDRAUpki1tr4bFvQloRvkkfetgTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759747564; c=relaxed/simple;
	bh=F1C+9QHNtIdrMXPFJNmdK9DTUeQQgH/b3wgeCQqewdw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=USQMkNwSMFBfYB3pa40E9HB1IhmwaS85GVxToumOpkd/RNtGfUiqZs70HvZrxL/8Z4o0tw949GXk5yM2PaPZJBhCUBAyTcrWq4moJzt0N2jr0VlqrfbX264H8FFWiZuydKiOuCN5EFrCy7lkzd5yXvyVFnsltUC5wAgjpx2eaWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=G09lvud0; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=M59h4os1VP7Nr1E0HNWCErqmH/RtIRWZRp8A3WSdowA=; b=G09lvud0qqJNIfTPOJw5icFoKr
	6tGZ6DJtcursvko8i3sH/LXuRTykAPBIGcVG8FJNuoKWczPV2SluqBesOJgXrsxUrgRJ7Itr2pVoS
	HWmdhNkS6RiPG4LmRVLdFruQ5EYVhU85sqNQe+Sq7m5Cx/y+xfSCyp8Aw/trgLsUS9xGsF+gTciee
	xZvordzYv8W/rqKeps+5B2FcR//PHppoQxvAF4mGICJR52eW8BQoszy4NkT0+xI3cfp46XsYWAoVd
	1CBTceQ5OKg2SerE6HxfG9pO9+tHt6jhk64hPjRGuae7FCBMgAtZiUW9aa2YcuFWCtAu8FAdsLT8Z
	BT4qSpKA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5iiz-0000000Grdp-0C9f;
	Mon, 06 Oct 2025 10:45:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id D9D21302186; Mon, 06 Oct 2025 12:45:47 +0200 (CEST)
Message-ID: <20251006104527.331463972@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 06 Oct 2025 12:44:09 +0200
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
Subject: [PATCH 07/12] sched: Fix do_set_cpus_allowed() locking
References: <20251006104402.946760805@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

All callers of do_set_cpus_allowed() only take p->pi_lock, which is
not sufficient to actually change the cpumask. Again, this is mostly
ok in these cases, but it results in unnecessarily complicated
reasoning.

Furthermore, there is no reason what so ever to not just take all the
required locks, so do just that.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/kthread.c     |   15 +++++----------
 kernel/sched/core.c  |   21 +++++++--------------
 kernel/sched/sched.h |    5 +++++
 3 files changed, 17 insertions(+), 24 deletions(-)

--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -593,18 +593,16 @@ EXPORT_SYMBOL(kthread_create_on_node);
 
 static void __kthread_bind_mask(struct task_struct *p, const struct cpumask *mask, unsigned int state)
 {
-	unsigned long flags;
-
 	if (!wait_task_inactive(p, state)) {
 		WARN_ON(1);
 		return;
 	}
 
+	scoped_guard (raw_spinlock_irqsave, &p->pi_lock)
+		do_set_cpus_allowed(p, mask);
+
 	/* It's safe because the task is inactive. */
-	raw_spin_lock_irqsave(&p->pi_lock, flags);
-	do_set_cpus_allowed(p, mask);
 	p->flags |= PF_NO_SETAFFINITY;
-	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
 }
 
 static void __kthread_bind(struct task_struct *p, unsigned int cpu, unsigned int state)
@@ -857,7 +855,6 @@ int kthread_affine_preferred(struct task
 {
 	struct kthread *kthread = to_kthread(p);
 	cpumask_var_t affinity;
-	unsigned long flags;
 	int ret = 0;
 
 	if (!wait_task_inactive(p, TASK_UNINTERRUPTIBLE) || kthread->started) {
@@ -882,10 +879,8 @@ int kthread_affine_preferred(struct task
 	list_add_tail(&kthread->hotplug_node, &kthreads_hotplug);
 	kthread_fetch_affinity(kthread, affinity);
 
-	/* It's safe because the task is inactive. */
-	raw_spin_lock_irqsave(&p->pi_lock, flags);
-	do_set_cpus_allowed(p, affinity);
-	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+	scoped_guard (raw_spinlock_irqsave, &p->pi_lock)
+		do_set_cpus_allowed(p, affinity);
 
 	mutex_unlock(&kthreads_hotplug_lock);
 out:
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2668,18 +2668,14 @@ __do_set_cpus_allowed(struct task_struct
 	bool queued, running;
 
 	lockdep_assert_held(&p->pi_lock);
+	lockdep_assert_rq_held(rq);
 
 	queued = task_on_rq_queued(p);
 	running = task_current_donor(rq, p);
 
-	if (queued) {
-		/*
-		 * Because __kthread_bind() calls this on blocked tasks without
-		 * holding rq->lock.
-		 */
-		lockdep_assert_rq_held(rq);
+	if (queued)
 		dequeue_task(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK);
-	}
+
 	if (running)
 		put_prev_task(rq, p);
 
@@ -2708,7 +2704,10 @@ void do_set_cpus_allowed(struct task_str
 		struct rcu_head rcu;
 	};
 
-	__do_set_cpus_allowed(p, &ac);
+	scoped_guard (__task_rq_lock, p) {
+		update_rq_clock(scope.rq);
+		__do_set_cpus_allowed(p, &ac);
+	}
 
 	/*
 	 * Because this is called with p->pi_lock held, it is not possible
@@ -3483,12 +3482,6 @@ static int select_fallback_rq(int cpu, s
 			}
 			fallthrough;
 		case possible:
-			/*
-			 * XXX When called from select_task_rq() we only
-			 * hold p->pi_lock and again violate locking order.
-			 *
-			 * More yuck to audit.
-			 */
 			do_set_cpus_allowed(p, task_cpu_fallback_mask(p));
 			state = fail;
 			break;
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1847,6 +1847,11 @@ DEFINE_LOCK_GUARD_1(task_rq_lock, struct
 		    task_rq_unlock(_T->rq, _T->lock, &_T->rf),
 		    struct rq *rq; struct rq_flags rf)
 
+DEFINE_LOCK_GUARD_1(__task_rq_lock, struct task_struct,
+		    _T->rq = __task_rq_lock(_T->lock, &_T->rf),
+		    __task_rq_unlock(_T->rq, &_T->rf),
+		    struct rq *rq; struct rq_flags rf)
+
 static inline void rq_lock_irqsave(struct rq *rq, struct rq_flags *rf)
 	__acquires(rq->lock)
 {




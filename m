Return-Path: <cgroups+bounces-9943-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAE6B51CDB
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 18:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B49D77BA63D
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 16:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7384A33CE9C;
	Wed, 10 Sep 2025 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g2YPGlwc"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEDE334394;
	Wed, 10 Sep 2025 16:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520046; cv=none; b=C65sSjnsZaBdiDwO9hhaiZg3gYhM+86TFMHVzve7/dgPdMXjMjNmL/t0gxWvmOe4SHXlflV8WCmIg0A+oS5eT/E76ArfJpfP5pr+2p/5prG3LeLWr1KTeZAK5RChVXs68n90aN4Uq9gHYWyovv7r5CYfpX90lw4cGyBVScvQQCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520046; c=relaxed/simple;
	bh=c5T0jUWnLXQTc3r4WHSJJ8qpcfmmo29c845DsrXaOyw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=W6JoqCiKi+xR06i6uzAox+AegvW3Dvui5SpNCEwhIrKpQE+PTRs5uYg34vCPeSCbssBxFP/g2vvVPacYP6284EMQPNp95xo5cPNU0k8ruikSaP7ZPFF6LZQjhAFKaQX7Az2dkn5LhY/FF1XeGe512sXD2KdfXatGtSIP3bmbUn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g2YPGlwc; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=Ld6FtW1Fo6RjyE9mTvnA50fxy0ZwQbJgnqO54sTZjlQ=; b=g2YPGlwciMVnKROglpWKYgBr1Q
	3MLhkJYLKXDmkIBBwR4N77vDsVvGha0lLT3eP41ptsoNLRsVCulyzuG0r6QE7eW8xhL3AQ6S+xzus
	tgXH/pxJIRsdVk5caXDF/RLCPTXojdq0Q9+zJEpcJ3mKISpPTxXFd/gOSMJpoaDt6UeDg7dtf1zuU
	rqPd+2rT4s2WqtGKtsqtI1oB9h8H1PuFjkOWV0BU/tXbLlIJd5l/dGi7aw7S5swZlpermwkuKgMaV
	mIKDAf8hj48srXW8WND1sZw3a0/MnOmzFjwp8xmzoYq6jH/TWoNXFxtcJHRYvCPd2uzNGj28hRZnJ
	WvIGR4EQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwNFG-00000005ufF-34LG;
	Wed, 10 Sep 2025 16:00:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 93F2B302F27; Wed, 10 Sep 2025 18:00:28 +0200 (CEST)
Message-ID: <20250910155809.103475671@infradead.org>
User-Agent: quilt/0.68
Date: Wed, 10 Sep 2025 17:44:16 +0200
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
Subject: [PATCH 07/14] sched: Fix do_set_cpus_allowed() locking
References: <20250910154409.446470175@infradead.org>
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
@@ -2703,18 +2703,14 @@ __do_set_cpus_allowed(struct task_struct
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
 
@@ -2743,7 +2739,10 @@ void do_set_cpus_allowed(struct task_str
 		struct rcu_head rcu;
 	};
 
-	__do_set_cpus_allowed(p, &ac);
+	scoped_guard (__task_rq_lock, p) {
+		update_rq_clock(scope.rq);
+		__do_set_cpus_allowed(p, &ac);
+	}
 
 	/*
 	 * Because this is called with p->pi_lock held, it is not possible
@@ -3518,12 +3517,6 @@ static int select_fallback_rq(int cpu, s
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
@@ -1822,6 +1822,11 @@ DEFINE_LOCK_GUARD_1(task_rq_lock, struct
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




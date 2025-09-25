Return-Path: <cgroups+bounces-10450-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3418B9F70B
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 15:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77B3A386991
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 13:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B252C1B4244;
	Thu, 25 Sep 2025 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Him9QCta"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96131C8611;
	Thu, 25 Sep 2025 13:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805839; cv=none; b=IPAsaFnL0/0dYoLsswJpL9RO0DYkkejMW15n2cXUyvYPVd0ZnOXvsjdh6wTX0LLJDhRmGrAbekQaU/WTNm3jw6BKgHq08WXg0eIfAVR6TV3eY1sdB1W2plwfHsqiXpYJhs1qmpJJ2K3vAogK/p5CCBqrP0Ag7zKQpL9IkLA1Q2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805839; c=relaxed/simple;
	bh=VybQroaUrHBuCd5yUTzgUINLCLHwybQTewjv/v0YJvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIEO5L2CXBTm3VxgNwlUqOaEYrozyGLc39uPBnJ5FrV77IwtZhejE8s2EMv4swBt2zbWObiNMkzO9OWbDiZSxdqxjcGNlLA9bU60HgefiZmASpGkWHXgFOv6AZrOhHFWdhCRYSuau1hizW5D5NTrxDQcAMevwv7shQCJ8jLElOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Him9QCta; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1bzY29OP7Rd/KL/PbvCwoEj8UUM7p2Z/euhhEhj9SBI=; b=Him9QCtaskfcH7FE4llgFnwC2w
	/lxvnFjEyx5ZEQ+nFl5I0IpWuYSe+8uF7N1NA7K6LXptQQmZLIUGu7IkgiB67uKFZINey6u9onAs5
	n3cC6RgXWvWw1VWCVZzrXMdlA2evhPqCXpQn+KH0axdKJZy2t4fVexjChF3F/giAUfgYbksubW0gl
	NJP1Kb20hvftc+YFfECCkcOI4CFS4ZXgmN6nWFqUXjKZT8S4RUmkpIzURxourjRfJjgr4SfOu6Egb
	28qtC8rL6QcgtR59cytBScHkJpDXRjMcxE7uPnXv+8JsLXT0wV1z6fdoJ+voMnjr/EnUuuQaMv+oA
	+zXA+fhw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1lju-000000098lm-22kS;
	Thu, 25 Sep 2025 13:10:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 54798300220; Thu, 25 Sep 2025 15:10:25 +0200 (CEST)
Date: Thu, 25 Sep 2025 15:10:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 13/14] sched: Add {DE,EN}QUEUE_LOCKED
Message-ID: <20250925131025.GA4067720@noisy.programming.kicks-ass.net>
References: <20250910154409.446470175@infradead.org>
 <20250910155809.800554594@infradead.org>
 <aMItk3c5H6Z2CD4X@slm.duckdns.org>
 <20250911094240.GW3289052@noisy.programming.kicks-ass.net>
 <aMMzpnyx__ZgZGRc@slm.duckdns.org>
 <20250912141904.GA3289052@noisy.programming.kicks-ass.net>
 <aMRLIEtmcWc0XNmg@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMRLIEtmcWc0XNmg@slm.duckdns.org>

On Fri, Sep 12, 2025 at 06:32:32AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Fri, Sep 12, 2025 at 04:19:04PM +0200, Peter Zijlstra wrote:
> ...
> > Ah, but I think we *have* to change it :/ The thing is that with the new
> > pick you can change 'rq' without holding the source rq->lock. So we
> > can't maintain this list.
> > 
> > Could something like so work?
> > 
> > 	scoped_guard (rcu) for_each_process_thread(g, p) {
> > 		if (p->flags & PF_EXITING || p->sched_class != ext_sched_class)
> > 			continue;
> > 
> > 		guard(task_rq_lock)(p);
> > 		scoped_guard (sched_change, p) {
> > 			/* no-op */
> > 		}
> > 	}	
> 
> Yeah, or I can make scx_tasks iteration smarter so that it can skip through
> the list for tasks which aren't runnable. As long as it doesn't do lock ops
> on every task, it should be fine. I think this is solvable one way or
> another. Let's continue in the other subthread.

Well, either this or scx_tasks iterator will result in lock ops for
every task, this is unavoidable if we want the normal p->pi_lock,
rq->lock (dsq->lock) taken for every sched_change caller.

I have the below which I would like to include in the series such that I
can clean up all that DEQUEUE_LOCKED stuff a bit, this being the only
sched_change that's 'weird'.

Added 'bonus' is of course one less user of the runnable_list.

(also, I have to note, for_each_cpu with preemption disabled is asking
for trouble, the enormous core count machines are no longer super
esoteric)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4817,6 +4817,7 @@ static void scx_bypass(bool bypass)
 {
 	static DEFINE_RAW_SPINLOCK(bypass_lock);
 	static unsigned long bypass_timestamp;
+	struct task_struct *g, *p;
 	struct scx_sched *sch;
 	unsigned long flags;
 	int cpu;
@@ -4849,16 +4850,16 @@ static void scx_bypass(bool bypass)
 	 * queued tasks are re-queued according to the new scx_rq_bypassing()
 	 * state. As an optimization, walk each rq's runnable_list instead of
 	 * the scx_tasks list.
-	 *
-	 * This function can't trust the scheduler and thus can't use
-	 * cpus_read_lock(). Walk all possible CPUs instead of online.
+	 */
+
+	/*
+	 * XXX online_mask is stable due to !preempt (per bypass_lock)
+	 * so could this be for_each_online_cpu() ?
 	 */
 	for_each_possible_cpu(cpu) {
 		struct rq *rq = cpu_rq(cpu);
-		struct task_struct *p, *n;
 
 		raw_spin_rq_lock(rq);
-
 		if (bypass) {
 			WARN_ON_ONCE(rq->scx.flags & SCX_RQ_BYPASSING);
 			rq->scx.flags |= SCX_RQ_BYPASSING;
@@ -4866,36 +4867,33 @@ static void scx_bypass(bool bypass)
 			WARN_ON_ONCE(!(rq->scx.flags & SCX_RQ_BYPASSING));
 			rq->scx.flags &= ~SCX_RQ_BYPASSING;
 		}
+		raw_spin_rq_unlock(rq);
+	}
+
+	/* implicit RCU section due to bypass_lock */
+	for_each_process_thread(g, p) {
+		unsigned int state;
 
-		/*
-		 * We need to guarantee that no tasks are on the BPF scheduler
-		 * while bypassing. Either we see enabled or the enable path
-		 * sees scx_rq_bypassing() before moving tasks to SCX.
-		 */
-		if (!scx_enabled()) {
-			raw_spin_rq_unlock(rq);
+		guard(raw_spinlock)(&p->pi_lock);
+		if (p->flags & PF_EXITING || p->sched_class != &ext_sched_class)
+			continue;
+
+		state = READ_ONCE(p->__state);
+		if (state != TASK_RUNNING && state != TASK_WAKING)
 			continue;
-		}
 
-		/*
-		 * The use of list_for_each_entry_safe_reverse() is required
-		 * because each task is going to be removed from and added back
-		 * to the runnable_list during iteration. Because they're added
-		 * to the tail of the list, safe reverse iteration can still
-		 * visit all nodes.
-		 */
-		list_for_each_entry_safe_reverse(p, n, &rq->scx.runnable_list,
-						 scx.runnable_node) {
-			/* cycling deq/enq is enough, see the function comment */
-			scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
-				/* nothing */ ;
-			}
+		guard(__task_rq_lock)(p);
+		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+			/* nothing */ ;
 		}
+	}
 
-		/* resched to restore ticks and idle state */
-		if (cpu_online(cpu) || cpu == smp_processor_id())
-			resched_curr(rq);
+	/* implicit !preempt section due to bypass_lock */
+	for_each_online_cpu(cpu) {
+		struct rq *rq = cpu_rq(cpu);
 
+		raw_spin_rq_lock(rq);
+		resched_curr(cpu_rq(cpu));
 		raw_spin_rq_unlock(rq);
 	}
 


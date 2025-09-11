Return-Path: <cgroups+bounces-9989-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF99AB52E0B
	for <lists+cgroups@lfdr.de>; Thu, 11 Sep 2025 12:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0071B16C39F
	for <lists+cgroups@lfdr.de>; Thu, 11 Sep 2025 10:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5383930F93E;
	Thu, 11 Sep 2025 10:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p6nrKG9E"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E5630EF6F;
	Thu, 11 Sep 2025 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757585421; cv=none; b=MV/Fa0I3ZRIDs1YpuBLs/wsa41dIFWYfskGRofSthwmm63k5N/XUOxnpu2xhhpK0Bt4wko/b7jQHTMka2QYVCisUMP7Wds4HDqfxRy6G7kRJdtuN52wQgRJlpjU7459sRqML+Olnb53Bdirm8tctb96k9qInvufDgEETJ5A+2Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757585421; c=relaxed/simple;
	bh=zmpuIHZkUuqtiHYn099f2IuJg8i44bL3Onk1kF2dAc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPCqd30zM6UrvMe/JgRSBe0GKI9yzQ/UkyiU7cke+4JlIRUlJBsdQ7/k35LurpQ3yZAildKmyCrePJ/qAXIjiv4dZWjFldmOxRo6JC4p2zZiWEMgLxu+Hl45kgOTfHZmWKAsQsz/pRaDnH6p4VPFNw9B9R16jBFfyDY/VtX2IU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p6nrKG9E; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jvf1x5YrMTbIpnWtcSik1tZyeviHXtZShk8nY6/psHg=; b=p6nrKG9Ez/eYouHFX4c2UGOvAR
	xfr3+sNSm3jV8dR1Zf2kHPegzreM/rWoxSMkXYYAJr9n2K+1uUkjm+5fPsai+V8yDFXLHKpE4Yjsw
	wsyO2Apjr/+ee0ZSGb+gnIaIxFQyNOQWCaGxc7MuWegd05slOHxkINvS8cHmBwSsNhrqcja3Gwz3K
	GSr4UlCajaZssjNSzT8d8T2107zyaQUz8KHkFwxr8z9QYyJ9fBZqt9w8fSugkC3ybEqAwzKZ48+DG
	tQ28akGaO9/g3QUFJX6WvAuYVwR3zdqSJ7Lvo1tY9uAryQencYGfcSnYrA033v3OeeNgzOyB56/Nf
	2bTXaJVg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uweFl-00000008qZv-0X0t;
	Thu, 11 Sep 2025 10:10:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AC07A300342; Thu, 11 Sep 2025 12:10:08 +0200 (CEST)
Date: Thu, 11 Sep 2025 12:10:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, longman@redhat.com,
	hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com,
	arighi@nvidia.com, changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 01/14] sched: Employ sched_change guards
Message-ID: <20250911101008.GD1386988@noisy.programming.kicks-ass.net>
References: <20250910154409.446470175@infradead.org>
 <20250910155808.415580225@infradead.org>
 <c4955d95-8d23-49da-9214-da481f28f797@amd.com>
 <20250911095523.GX3289052@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911095523.GX3289052@noisy.programming.kicks-ass.net>

On Thu, Sep 11, 2025 at 11:55:23AM +0200, Peter Zijlstra wrote:
> On Thu, Sep 11, 2025 at 02:36:21PM +0530, K Prateek Nayak wrote:
> > Hello Peter,
> > 
> > On 9/10/2025 9:14 PM, Peter Zijlstra wrote:
> > > @@ -9240,8 +9213,9 @@ static void sched_change_group(struct ta
> > >   */
> > >  void sched_move_task(struct task_struct *tsk, bool for_autogroup)
> > >  {
> > > -	int queued, running, queue_flags =
> > > +	unsigned int queue_flags =
> > >  		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
> > 
> > nit.
> > 
> > Since we don't do a complete dequeue for delayed task in
> > sched_move_task(), can we get rid of that DEQUEUE_NOCLOCK and ...
> > 
> > > +	bool resched = false;
> > >  	struct rq *rq;
> > >  
> > >  	CLASS(task_rq_lock, rq_guard)(tsk);
> > > @@ -9249,28 +9223,12 @@ void sched_move_task(struct task_struct
> > >  
> > >  	update_rq_clock(rq);
> > 
> > ... this clock update and instead rely on sched_change_begin() to
> > handle it within the guard?
> 
> Yeah, I suppose we could. But let me try and do that in a later patch,
> on-top of all this.

Something like so?

---
 core.c     |   33 +++++++++++----------------------
 ext.c      |   12 ++++--------
 syscalls.c |    4 +---
 3 files changed, 16 insertions(+), 33 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2359,10 +2359,8 @@ static void migrate_disable_switch(struc
 	if (p->cpus_ptr != &p->cpus_mask)
 		return;
 
-	scoped_guard (task_rq_lock, p) {
-		update_rq_clock(scope.rq);
+	scoped_guard (task_rq_lock, p)
 		do_set_cpus_allowed(p, &ac);
-	}
 }
 
 void migrate_disable(void)
@@ -2716,9 +2714,7 @@ void set_cpus_allowed_common(struct task
 static void
 do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
 {
-	u32 flags = DEQUEUE_SAVE | DEQUEUE_NOCLOCK | DEQUEUE_LOCKED;
-
-	scoped_guard (sched_change, p, flags) {
+	scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_LOCKED) {
 		p->sched_class->set_cpus_allowed(p, ctx);
 		mm_set_cpus_allowed(p->mm, ctx->new_mask);
 	}
@@ -2740,10 +2736,8 @@ void set_cpus_allowed_force(struct task_
 		struct rcu_head rcu;
 	};
 
-	scoped_guard (__task_rq_lock, p) {
-		update_rq_clock(scope.rq);
+	scoped_guard (__task_rq_lock, p)
 		do_set_cpus_allowed(p, &ac);
-	}
 
 	/*
 	 * Because this is called with p->pi_lock held, it is not possible
@@ -9159,16 +9153,13 @@ static void sched_change_group(struct ta
  */
 void sched_move_task(struct task_struct *tsk, bool for_autogroup)
 {
-	unsigned int queue_flags =
-		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK | DEQUEUE_LOCKED;
+	unsigned int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_LOCKED;
 	bool resched = false;
 	struct rq *rq;
 
 	CLASS(task_rq_lock, rq_guard)(tsk);
 	rq = rq_guard.rq;
 
-	update_rq_clock(rq);
-
 	scoped_guard (sched_change, tsk, queue_flags) {
 		sched_change_group(tsk);
 		if (!for_autogroup)
@@ -10852,19 +10843,17 @@ struct sched_change_ctx *sched_change_be
 	}
 #endif
 
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
@@ -10915,7 +10904,7 @@ void sched_change_end(struct sched_chang
 		p->sched_class->switching_to(rq, p);
 
 	if (ctx->queued)
-		enqueue_task(rq, p, ctx->flags | ENQUEUE_NOCLOCK);
+		enqueue_task(rq, p, ctx->flags);
 	if (ctx->running)
 		set_next_task(rq, p, ctx->flags);
 
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5018,14 +5018,12 @@ static void scx_disable_workfn(struct kt
 
 	scx_task_iter_start(&sti);
 	while ((p = scx_task_iter_next_locked(&sti))) {
-		unsigned int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE |
-					   DEQUEUE_NOCLOCK | DEQUEUE_LOCKED;
+		unsigned int queue_flags =
+			DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_LOCKED;
 		const struct sched_class *old_class = p->sched_class;
 		const struct sched_class *new_class =
 			__setscheduler_class(p->policy, p->prio);
 
-		update_rq_clock(task_rq(p));
-
 		if (old_class != new_class) {
 			queue_flags |= DEQUEUE_CLASS;
 			queue_flags &= ~(DEQUEUE_SAVE | DEQUEUE_MOVE);
@@ -5763,8 +5761,8 @@ static int scx_enable(struct sched_ext_o
 	percpu_down_write(&scx_fork_rwsem);
 	scx_task_iter_start(&sti);
 	while ((p = scx_task_iter_next_locked(&sti))) {
-		unsigned int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE |
-					   DEQUEUE_NOCLOCK | DEQUEUE_LOCKED;
+		unsigned int queue_flags =
+			DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_LOCKED;
 		const struct sched_class *old_class = p->sched_class;
 		const struct sched_class *new_class =
 			__setscheduler_class(p->policy, p->prio);
@@ -5772,8 +5770,6 @@ static int scx_enable(struct sched_ext_o
 		if (!tryget_task_struct(p))
 			continue;
 
-		update_rq_clock(task_rq(p));
-
 		if (old_class != new_class) {
 			queue_flags |= DEQUEUE_CLASS;
 			queue_flags &= ~(DEQUEUE_SAVE | DEQUEUE_MOVE);
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -76,8 +76,6 @@ void set_user_nice(struct task_struct *p
 	CLASS(task_rq_lock, rq_guard)(p);
 	rq = rq_guard.rq;
 
-	update_rq_clock(rq);
-
 	/*
 	 * The RT priorities are set via sched_setscheduler(), but we still
 	 * allow the 'normal' nice value to be set - but as expected
@@ -89,7 +87,7 @@ void set_user_nice(struct task_struct *p
 		return;
 	}
 
-	scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK | DEQUEUE_LOCKED) {
+	scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_LOCKED) {
 		p->static_prio = NICE_TO_PRIO(nice);
 		set_load_weight(p, true);
 		old_prio = p->prio;


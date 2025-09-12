Return-Path: <cgroups+bounces-10030-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05908B54C5D
	for <lists+cgroups@lfdr.de>; Fri, 12 Sep 2025 14:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1ACF17BA5C
	for <lists+cgroups@lfdr.de>; Fri, 12 Sep 2025 12:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB8B3064BB;
	Fri, 12 Sep 2025 11:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DdI/5owh"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDDD305E18;
	Fri, 12 Sep 2025 11:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678116; cv=none; b=coWteZQsJzGYnH/2Eza7XWyp7+i9ZHUmsP6481qDTB9NiErxlGHk40c1bDfLO7186ily1h626zpbrbB9X35hMbYfweCa8iKrgI0s1cJhBgNBPjqTyq2HMPvBBUu8q7MbbYV4us/cJTlG21ji/QNQeRpDY+6SMfbxvIpHBZCtec8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678116; c=relaxed/simple;
	bh=OiQ8SyM9G4y6zAiNJBkbk8M1wMKgM7E09VklZ/S/SWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c502bzDq+KQKBsKOK/gAgIhi7sXMQbhKFn3rOMKoGpW6naT64CJIIHB1yknV9zlRY+AWkdYVNjS7skaohSFezen8M5VO/YCJxJ+gaa+vys45kmIsdqvJFqCoxKRKiOjXTTK52oYn6ZIfhlCA3dMf0pXPCxUkIokFA4X2JOScOdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DdI/5owh; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oDG8dtRhhrV2tNzEwtCOQFio9vNLrGfgxupBP89t1G0=; b=DdI/5owhkl0FndydRJYM35RfUn
	jPclTmuaFOH51f56kgqhyCHfnx5e5l2EsJfiqzxZLCStS1i9a4DPsfl0qCflW0Y3aS35AurZFYjxc
	KlG2K04iYLMbE/pQH9Tmk2NvjLj4qvCxbBJqAbPR06dctiQP+iPIugq39jh7jdC1HD3yD3npnRn7Q
	k1ptanAQnk6zK5Hu7FJPbL0gOjL4In4aKaNCQ1ZNEQkYg0a1VN3Z6Zq4jJWc9YqtuCYMvpnOdnTec
	p0LNxdgdUwnjG34M/424rwyROB+rvXV0lrJefcubIAOxb/9FNR4ZnHIk8vBzKRd6yJd1metn62opr
	yHehfYvw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ux2Mn-00000006M9J-1ikE;
	Fri, 12 Sep 2025 11:55:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EA81A300579; Fri, 12 Sep 2025 13:54:59 +0200 (CEST)
Date: Fri, 12 Sep 2025 13:54:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 12/14] sched: Add shared runqueue locking to
 __task_rq_lock()
Message-ID: <20250912115459.GZ3289052@noisy.programming.kicks-ass.net>
References: <20250910154409.446470175@infradead.org>
 <20250910155809.684653538@infradead.org>
 <aMNnLenCytO_KEKg@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMNnLenCytO_KEKg@slm.duckdns.org>

On Thu, Sep 11, 2025 at 02:19:57PM -1000, Tejun Heo wrote:
> Hello,
> 
> On Wed, Sep 10, 2025 at 05:44:21PM +0200, Peter Zijlstra wrote:
> > @@ -703,17 +703,24 @@ void double_rq_lock(struct rq *rq1, stru
> >  struct rq *__task_rq_lock(struct task_struct *p, struct rq_flags *rf)
> >  	__acquires(rq->lock)
> >  {
> > +	raw_spinlock_t *slock;
> >  	struct rq *rq;
> >  
> >  	lockdep_assert_held(&p->pi_lock);
> >  
> >  	for (;;) {
> >  		rq = task_rq(p);
> > +		slock = p->srq_lock;
> >  		raw_spin_rq_lock(rq);
> > -		if (likely(rq == task_rq(p) && !task_on_rq_migrating(p))) {
> > +		if (slock)
> > +			raw_spin_lock(slock);
> > +		if (likely(rq == task_rq(p) && !task_on_rq_migrating(p) &&
> > +			   (!slock || p->srq_lock == slock))) {
> >  			rq_pin_lock(rq, rf);
> >  			return rq;
> >  		}

Yeah, I think that needs to change a little. Perhaps something like:

	slock2 = p->srq_lock;
	if (... && (!slock2 || slock2 == slock))

> With the !slock condition, the following scenario is possible:
> 
>   __task_rq_lock()
>      slock = p->srq_lock; /* NULL */
>                                                 dispatch_enqueue()
>                                                   p->srq_lock = &dsq->lock;
>                                                 enqueue finishes
>      raw_spin_rq_lock(rq);
>      rq is the same, $slock is NULL, return
>   do something assuming p is locked down        p gets dispatched to another rq
> 
> I'm unclear on when p->srq_lock would be safe to set and clear, so the goal
> is that whoever does [__]task_rq_lock() ends up waiting on the dsq lock that
> the task is queued on, and if we can exclude other sched operations that
> way, we don't have to hold source rq lock when moving the task to another rq
> for execution, right?

Indeed. If !p->srq_lock then task_rq(p)->lock must be sufficient.

So for enqueue, which sets p->srq_lock, this must be done while holding
task_rq(p)->lock.

So the above example should be serialized on task_rq(p)->lock, since
__task_rq_lock() holds it, enqueue cannot happen. Conversely, if enqueue
holds task_rq(p)->lock, then __task_rq_lock() will have to wait for
that, and then observe the newly set p->srq_lock and cycle to take that.

> In the last patch, it's set on dispatch_enqueue() and cleared when the task
> leaves the DSQ. Let's consider a simple scenario where a task gets enqueued,
> gets put on a non-local DSQ and then dispatched to a local DSQ, Assuming
> everything works out and we don't have to lock the source rq for migration,
> we'd be depending on task_rq_lock() reliably hitting p->srq_lock to avoid
> races, but I'm not sure how this would work. Let's say p is currently
> associated with CPU1 on a non-local DSQ w/ p->srq_lock set to its source
> DSQ.
> 
>   pick_task_ext() on CPU0               task property change on CPU1
>     locks the DSQ
>     picks p      
>     task_unlink_from_dsq()              task_rq_lock();
>       p->srq_lock = NULL;                 lock rq on CPU1
>     p is moved to local DSQ               sees p->src_lock == NULL
>                                           return
>   p starts running
>   anything can happen
>                                         proceed with property change

Hmm, the thinking was that if !p->srq_lock then task_rq(p)->lock should
be sufficient.

We must do set_task_cpu(0) before task_unlink_from_dsq() (and I got this
order wrong in yesterday's email).

  pick_task_ext() on CPU0		
    lock DSQ
    pick p
    set_task_cpu(0)			task_rq_lock()
    task_unlink_from_dsq()		  if !p->srq_lock, then task_rq(p) == 0
      p->srq_lock = NULL;
    p is moved to local DSQ

Perhaps the p->srq_lock store should be store-release, so that the cpu
store is before.

Then if we observe p->srq_lock, we'll serialize against DSQ and all is
well, if we observe !p->srq_lock then we must also observe task_rq(p) ==
0 and then we'll serialize on rq->lock.


Now let me see if there isn't an ABA issue here, consider:

pre: task_cpu(p) != 2, p->srq_lock = NULL

  CPU0				CPU1				CPU2

  __task_rq_lock()		enqueue_task_scx() 		pick_task_scx()

				rq = task_rq(p);
				LOCK rq->lock
  rq = task_rq(p)
  LOCK rq->lock
    .. waits
				LOCK dsq->lock
				enqueue on dsq
				p->srq_lock = &dsq->lock	
				UNLOCK dsq->lock
								LOCK dsq->lock
								pick p
				UNLOCK rq->lock
								set_task_cpu(2)
								task_unlink_from_dsq()
								  p->srq_lock = NULL;
								UNLOCK dsq->lock
    .. resumes
 
At this point our CPU0's __task_rq_lock():

  - if it observes p->srq_lock, it will cycle taking that, only to then
    find out p->srq_lock is no longer set, but then it must also see
    task_rq() has changed, so the next cycle will block on CPU2's
    rq->lock.

  - if it observes !p->srq_lock, then it cannot be the initial NULL,
    since the initial task_rq(p)->lock ordering prohibits this. So it
    must be the second NULL, which then also mandates we see the CPU
    change and we'll cycle to take CPU2's rq->lock.

That is, I _think_ we're okay :-)



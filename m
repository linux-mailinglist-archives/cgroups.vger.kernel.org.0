Return-Path: <cgroups+bounces-10050-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BD7B555AC
	for <lists+cgroups@lfdr.de>; Fri, 12 Sep 2025 19:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B637516E523
	for <lists+cgroups@lfdr.de>; Fri, 12 Sep 2025 17:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60857329F18;
	Fri, 12 Sep 2025 17:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vu6WbWU+"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1249E30DED0;
	Fri, 12 Sep 2025 17:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757699783; cv=none; b=VYeX3XP0EhvG/J/QOSmGbA3vZf5mqEe7ajRcCjFf8R04wXV0BiFbgv/x41HxaM2UNYEVOYI1olzR0gumn6EBhbWt7PV6cVysTjKyKlUhZVc7h6Vm+Toz7aZ/RdJmEwbwEHenWPlJOBscVEmJ2d5C0PBJs/U/wdEf9gIrX1uBorI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757699783; c=relaxed/simple;
	bh=O9bXMwjUlQo5/SicSx7JPS4mQ/8+leXxtDyAH0EpT3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZDHSvAa3t1qM+KWxE4ryzOyYC5wFC5OvOuFqLl4V+7C5D+gdtVd3FK+/v7WrZriN3IFN1SrCAnM23jhnurNlxUUvznDcmJgA2FrsUdaO2y25Re5SZ0fTKFD11d5CTm5Sryt+YtZym0SY7IZ54ezQVRLzTtrQt2niWLUcUt8woU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vu6WbWU+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7361CC4CEF1;
	Fri, 12 Sep 2025 17:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757699782;
	bh=O9bXMwjUlQo5/SicSx7JPS4mQ/8+leXxtDyAH0EpT3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vu6WbWU+5egES1jPtO6cDbl+3cTY79KcPDN4QNyRRGmLej8HJnsFFod9/dKhtTzvN
	 oLjoeNNq0AVwLKZ0kWD14aql2SuU/2FHliWe/CUApcKK3sGBXjufa/BORinbUtNF3P
	 PvggamGxCivlBJjMv0u+Vjhi5P9XciW87songtxufXBRG4QlnvzXk6GkUvZc64qHYi
	 ACArId1cWEwmXh9U+NivMYdXElY1B1ECZDsXTNOe+Z24qZL0YX35aVvO60vNXtmfac
	 Rg5fPiCIlnrsIVAVxJne6LKuxLj3uCC1dqXLbBD83raaN40+X/9Y9mq4xEnIUjBvMW
	 1RPYPKHMdnhXw==
Date: Fri, 12 Sep 2025 07:56:21 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 12/14] sched: Add shared runqueue locking to
 __task_rq_lock()
Message-ID: <aMRexZ_SIUVgkIpZ@slm.duckdns.org>
References: <20250910154409.446470175@infradead.org>
 <20250910155809.684653538@infradead.org>
 <aMNnLenCytO_KEKg@slm.duckdns.org>
 <20250912115459.GZ3289052@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912115459.GZ3289052@noisy.programming.kicks-ass.net>

Hello,

On Fri, Sep 12, 2025 at 01:54:59PM +0200, Peter Zijlstra wrote:
> > With the !slock condition, the following scenario is possible:
> > 
> >   __task_rq_lock()
> >      slock = p->srq_lock; /* NULL */
> >                                                 dispatch_enqueue()
> >                                                   p->srq_lock = &dsq->lock;
> >                                                 enqueue finishes
> >      raw_spin_rq_lock(rq);
> >      rq is the same, $slock is NULL, return
> >   do something assuming p is locked down        p gets dispatched to another rq
> > 
> > I'm unclear on when p->srq_lock would be safe to set and clear, so the goal
> > is that whoever does [__]task_rq_lock() ends up waiting on the dsq lock that
> > the task is queued on, and if we can exclude other sched operations that
> > way, we don't have to hold source rq lock when moving the task to another rq
> > for execution, right?
> 
> Indeed. If !p->srq_lock then task_rq(p)->lock must be sufficient.
> 
> So for enqueue, which sets p->srq_lock, this must be done while holding
> task_rq(p)->lock.
> 
> So the above example should be serialized on task_rq(p)->lock, since
> __task_rq_lock() holds it, enqueue cannot happen. Conversely, if enqueue
> holds task_rq(p)->lock, then __task_rq_lock() will have to wait for
> that, and then observe the newly set p->srq_lock and cycle to take that.

For that to work, [__]task_rq_lock() would have to read p->srq_lock while
holdling rq_lock. Simple reordering, but yeah it'd help to have
setter/getter for explicit locking rules.

...
> We must do set_task_cpu(0) before task_unlink_from_dsq() (and I got this
> order wrong in yesterday's email).
> 
>   pick_task_ext() on CPU0		
>     lock DSQ
>     pick p
>     set_task_cpu(0)			task_rq_lock()
>     task_unlink_from_dsq()		  if !p->srq_lock, then task_rq(p) == 0
>       p->srq_lock = NULL;
>     p is moved to local DSQ
> 
> Perhaps the p->srq_lock store should be store-release, so that the cpu
> store is before.
> 
> Then if we observe p->srq_lock, we'll serialize against DSQ and all is
> well, if we observe !p->srq_lock then we must also observe task_rq(p) ==
> 0 and then we'll serialize on rq->lock.

I see, so the interlocking is between task_rq(p) and p->srq_lock - either
one sees the updated CPU or non-NULL srq_lock. As long as the one that
clears ->srq_lock has both the destination rq and DSQ locked, task_rq_lock()
either ends up waiting on ->srq_lock or sees updated CPU and has to loop
over and wait on the destination rq.

> Now let me see if there isn't an ABA issue here, consider:
> 
> pre: task_cpu(p) != 2, p->srq_lock = NULL
> 
>   CPU0				CPU1				CPU2
> 
>   __task_rq_lock()		enqueue_task_scx() 		pick_task_scx()
> 
> 				rq = task_rq(p);
> 				LOCK rq->lock
>   rq = task_rq(p)
>   LOCK rq->lock
>     .. waits
> 				LOCK dsq->lock
> 				enqueue on dsq
> 				p->srq_lock = &dsq->lock	
> 				UNLOCK dsq->lock
> 								LOCK dsq->lock
> 								pick p
> 				UNLOCK rq->lock
> 								set_task_cpu(2)
> 								task_unlink_from_dsq()
> 								  p->srq_lock = NULL;
> 								UNLOCK dsq->lock
>     .. resumes
>  
> At this point our CPU0's __task_rq_lock():
> 
>   - if it observes p->srq_lock, it will cycle taking that, only to then
>     find out p->srq_lock is no longer set, but then it must also see
>     task_rq() has changed, so the next cycle will block on CPU2's
>     rq->lock.
> 
>   - if it observes !p->srq_lock, then it cannot be the initial NULL,
>     since the initial task_rq(p)->lock ordering prohibits this. So it
>     must be the second NULL, which then also mandates we see the CPU
>     change and we'll cycle to take CPU2's rq->lock.
> 
> That is, I _think_ we're okay :-)

It *seems* that way to me. There are two other scenarios tho.

- A task can move from a non-local DSQ to another non-local DSQ at any time
  while queued. As this doesn't cause rq migration, we can probably just
  overwrite p->srq_lock to the new one. Need to think about it a bit more.

- A task can be queued on a BPF data structure and thus may not be on any
  DSQ. I think this can be handled by adding a raw_spinlock to task_struct
  and treating the task as if it's on its own DSQ by pointing to that one,
  and grabbing that lock when transferring that task from BPF side.

So, it *seems* solvable but I'm afraid it's becoming too subtle. How about
doing something simpler and just add a per-task lock which nests inside rq
lock which is always grabbed by [__]task_rq_lock() and optionally grabbed by
sched classes that want to migrate tasks without grabbing the source rq
lock? That way, we don't need to the lock pointer dancing while achieving
about the same result. From sched_ext's POV, grabbing that per-task lock is
likely going to be cheaper than doing the rq lock switching, so it's way
simpler and nothing gets worse.

Thanks.

-- 
tejun


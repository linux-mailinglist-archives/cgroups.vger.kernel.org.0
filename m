Return-Path: <cgroups+bounces-10491-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2523FBA8D09
	for <lists+cgroups@lfdr.de>; Mon, 29 Sep 2025 12:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A7283A2932
	for <lists+cgroups@lfdr.de>; Mon, 29 Sep 2025 10:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187142FA0E9;
	Mon, 29 Sep 2025 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DxiHbAxQ"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104BE2E8B86;
	Mon, 29 Sep 2025 10:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759140435; cv=none; b=ZUArcJYYQvhx9RVW6r2cXxjwTI2dTCOYFk9Yh3Eq1mIQbnDvbs47FT/Lf/qJLgMwsWqDKJhzvVZFrcoO2iBwwSor6Fm0iGlZdPV9n/Yz/QbdVDqoKmRXr9fuk4UTtgFVTbVKPjXbFMaxF5NoG5gTJGP48XhcDvSYVIri8vyjVQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759140435; c=relaxed/simple;
	bh=nt1BCNEJq7BMv2psjfunALasd4EkjDFiwlD+qEdCY1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnmJy0zwqzIVk6VdS67VGD+Y80iwK9QkBz21HDmnjtn3lBHpQEKuRLoCmviNMtMspSxvKYed7mIM1NGiK1xkm5vSQslxetCGBgM9IJ7d+STklvB7CL9hGNdriX+4dRH+TJL7IBtwXqlF/1AvGG6xPQbXkEYcidVuH6FL19fzn2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DxiHbAxQ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7NB+0C2qsyWHPYK8tQ50R2KyFBHMFnn21/53LdWy8FM=; b=DxiHbAxQzjS899koaklun1rtdA
	wBnJAkNMb05Ys/MBopFnN9zBTXmGGAn1vSoM5XNG8Q5gUNHMMbKjy33JutUnkky0ehM43+7DFXpPE
	hnPhNwowkmZp5GmZ2oulV9BuM/eXkfSCj/6InuGP2SraQGROpeUBC3ksic1wnJBu+AN7EWavkXbvS
	zFLWINcKG2+Fp4FcS0KL9merzbBniNFwgTe+gbMC00UzKv05OlJ0ZG7eyfx/qI1yeTwiBtg9IJkfD
	NVVvpp8Wz49nXgJm9eqk8z8b8TxGpVIHaHbPMsZyg0oNI2FnpTGFVs3NL0iilS6jbZ20OIWnkIC5S
	Xc2jxtWA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3Ama-0000000Byz0-1Xx5;
	Mon, 29 Sep 2025 10:07:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C60A5300359; Mon, 29 Sep 2025 12:06:58 +0200 (CEST)
Date: Mon, 29 Sep 2025 12:06:58 +0200
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
Message-ID: <20250929100658.GC3245006@noisy.programming.kicks-ass.net>
References: <aMNnLenCytO_KEKg@slm.duckdns.org>
 <20250912115459.GZ3289052@noisy.programming.kicks-ass.net>
 <aMRexZ_SIUVgkIpZ@slm.duckdns.org>
 <20250915083815.GB3289052@noisy.programming.kicks-ass.net>
 <aMnk5Wcdr2q6BWqR@slm.duckdns.org>
 <aMnnslT_mUfAtytN@slm.duckdns.org>
 <20250925083533.GW4067720@noisy.programming.kicks-ass.net>
 <aNW3du48v3PvwPbq@slm.duckdns.org>
 <20250926103628.GE4067720@noisy.programming.kicks-ass.net>
 <aNcICdscrYDUMKiU@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNcICdscrYDUMKiU@slm.duckdns.org>

On Fri, Sep 26, 2025 at 11:39:21AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Fri, Sep 26, 2025 at 12:36:28PM +0200, Peter Zijlstra wrote:
> > On Thu, Sep 25, 2025 at 11:43:18AM -1000, Tejun Heo wrote:
> > > Yes, I was on a similar train of thought. The only reasonable way that I can
> > > think of for solving this for BPF managed tasks is giving each task its own
> > > inner sched lock, which makes sense as all sched operations (except for
> > > things like watchdog) are per-task and we don't really need wider scope
> > > locking.
> > 
> > Like I've said before; I really don't understand how that would be
> > helpful at all.
> > 
> > How can you migrate a task by holding a per-task lock?
> 
> Let's see whether I'm completely confused. Let's say we have p->sub_lock
> which is optionally grabbed by task_rq_lock() if requested by the current
> sched class (maybe it's a sched_class flag). Then, whoever is holding the
> sub_lock would exclude property and other changes to the task.
> 
> In sched_ext, let's say p->sub_lock nests inside dsq locks. Also, right now,
> we're piggy backing on rq lock for local DSQs. We'd need to make local DSQs
> use their own locks like user DSQs. Then,
> 
> - If a task needs to be migrated either during enqueue through
>   process_ddsp_deferred_locals() or during dispatch from BPF through
>   finish_dispatch(): Leave rq locks alone. Grab sub_lock inside
>   dispatch_to_local_dsq() after grabbing the target DSQ's lock.
> 
> - scx_bpf_dsq_move_to_local() from dispatch: This is a bit tricky as we need
>   to scan the tasks on the source DSQ to find the task to dispatch. However,
>   there's a patch being worked on to add rcu protected pointer to the first
>   task which would be the task to be consumed in vast majority of cases, so
>   the fast path wouldn't be complicated - grab sub_lock, do the moving. If
>   the first task isn't a good candidate, we'd have to grab DSQ lock, iterate
>   looking for the right candidate, unlock DSQ and grab sub_lock (or
>   trylock), and see if the task is still on the DSQ and then relock and
>   remove.
> 
> - scx_bpf_dsq_move() during BPF iteration: DSQ is unlocked during each
>   iteration visit, so this is straightforward. Grab sub-lock and do the rest
>   the same.
> 
> Wouldn't something like the above provide equivalent synchronization as the
> dynamic lock approach? Whoever is holding sub_lock would be guaranteed that
> the task won't be migrating while the lock is held.
> 
> However, thinking more about it. I'm unsure how e.g. the actual migration
> would work. The actual migration is done by: deactivate_task() ->
> set_task_cpu() -> switch rq locks -> activate_task(). Enqueueing/dequeueing
> steps have operations that depend on rq lock - psi updates, uclamp updates
> and so on. How would they work?

Suppose __task_rq_lock() will take rq->lock and p->sub_lock, in that
order, such that task_rq_lock() will take p->pi_lock, rq->lock and
p->sub_lock.

Then something like:

  guard(task_rq_lock)(p);
  scoped_guard (sched_change, p, ...) {
      // change me
  }

Will end up doing something like:

  // task_rq_lock
  IRQ-DISABLE
  LOCK pi->lock
1:
  rq = task_rq(p);
  LOCK rq->lock;
  if (rq != task_rq(p)) {
    UNLOCK rq->lock
    goto 1;
  }
  LOCK p->sub_lock

  // sched_change
  dequeue_task() := dequeue_task_scx()
    LOCK dsq->lock

While at the same time, above you argued p->sub_lock should be inside
dsq->lock. Because:

__schedule()
  rq = this_rq();
  LOCK rq->lock
  next = pick_next() := pick_next_scx()
    LOCK dsq->lock
    p = find_task(dsq);
    LOCK p->sub_lock
    dequeue(dsq, p);
    UNLOCK dsq->lock

Because if you did something like:

__schedule()
  rq = this_rq();
  LOCK rq->lock
  next = pick_next() := pick_next_scx()
    LOCK dsq->lock (or RCU, doesn't matter)
    p = find_task(dsq);
    UNLOCK dsq->lock
				migrate:
				LOCK p->pi_lock
				rq = task_rq(p)
				LOCK rq->lock
				(verify bla bla)
				LOCK p->sub_lock
				LOCK dsq->lock
				dequeue(dsq, p)
				UNLOCK dsq->lock
				set_task_cpu(n);
				UNLOCK rq->lock
				rq = cpu_rq(n);
				LOCK rq->lock (inversion vs p->sub_lock)
				LOCK dsq2->lock
				enqueue(dsq2, p)
				UNLOCK dsq2->lock

    LOCK p->sub_lock
    LOCK dsq->lock   (whoopsie, p is on dsq2)
    dequeue(dsq, p)
    set_task_cpu(here);
    UNLOCK dsq->lock


That is, either way around: dsq->lock outside, p->sub_lock inside, or
the other way around, I emd up with inversions and race conditions that
are not fun.

Also, if you do put p->sub_lock inside dsq->lock, this means
__task_rq_lock() cannot take it and it needs to be pushed deep into scx
(possibly into bpf ?) and that means I'm not sure how to do the change
pattern sanely.

Having __task_rq_lock() take p->dsq->lock solves all these problems,
except for that one weird case where BPF wants to do things their own
way. The longer I'm thinking about it, the more I dislike that. I just
don't see *ANY* upside from allowing BPF to do this while it is making
everything else quite awkward.

The easy fix is to have these BPF managed things have a single global
lock. That works and is correct. Then if they want something better,
they can use DSQs :-)

Fundamentally, we need the DSQ->lock to cover all CPUs that will pick
from it, there is no wiggle room there. Also note that while we change
only the attributes of a single task with the change pattern, that
affects the whole RQ, since a runqueue is an aggregate of all tasks.
This is very much why dequeue/enqueue around the change pattern, to keep
the runqueue aggregates updated.

Use the BPF thing to play with scheduling policies, but leave the
locking to the core code.


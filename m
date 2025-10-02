Return-Path: <cgroups+bounces-10527-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7052FBB59C4
	for <lists+cgroups@lfdr.de>; Fri, 03 Oct 2025 01:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 195643C5B22
	for <lists+cgroups@lfdr.de>; Thu,  2 Oct 2025 23:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16132285412;
	Thu,  2 Oct 2025 23:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWRbmzP8"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF67E149C6F;
	Thu,  2 Oct 2025 23:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759447972; cv=none; b=BGAabpomq2r6B9Ma9l90EFC38xuLSPNY5mhRj564o6wrA/m2RLgWqL3v+2I5PnVET7Zj5H/AcAGfGme144gsKYaAElfEqCxxx/DUYnsk+fqvfikWiX8+bD7YG/7GH8nJYM1/clnHBggtWAV7hd+NYRnhLmplJP4kwQlMZHtTeDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759447972; c=relaxed/simple;
	bh=hRJYW8Iu7+yMe4zvVWJf1rQethvfcfXjB9iEYKX/wyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiPioyjvk9o6NGKHC1kLz55KCLZvQU4NbhNVomT3mez8ciagRItvgq+9l3Q6+c+g/WgzK2XDctmjeI7dLLTeUqnMwyt6IkPQTWXWa1bXCROrLUJy2wD6LG6yi4DRxCiFg6MNpwNSeKfEFuWHQQDKDHpRCQEHEqb8vaNyndMNL4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWRbmzP8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B150C4CEF4;
	Thu,  2 Oct 2025 23:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759447972;
	bh=hRJYW8Iu7+yMe4zvVWJf1rQethvfcfXjB9iEYKX/wyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uWRbmzP82m9BS30te5ASCkQe2LeUqZsyxSIKze74B9jffQ3tG+0HqK7xpkRLbfarr
	 Snl5mZXVNLzavqhpotwUcnZqgUQbxTatDE34zU1PUiEjLNlZFUrbgmbW0yKjINCJFW
	 nbma3QxHv384pNOTBzaLCKMpNV3pxb/MNF5t4kHUs0f0iRyFMljxOA7XmxpIEATlid
	 3ZZeHzttd+pSUtQld3UU46TybdSl/B2UsBjfdAXaV1JJLECG3vdiHMWAHqTy+n9Nrl
	 scuS5hyH3ciKx0/CrMiE9uXpD8H2bZ089Ywz6hIL9SrAfOy7iBvy0M8TF1T+BYeP31
	 54WARftrJPYOg==
Date: Thu, 2 Oct 2025 13:32:51 -1000
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
Message-ID: <aN8Lowa5SlHZpCR7@slm.duckdns.org>
References: <20250915083815.GB3289052@noisy.programming.kicks-ass.net>
 <aMnk5Wcdr2q6BWqR@slm.duckdns.org>
 <aMnnslT_mUfAtytN@slm.duckdns.org>
 <20250925083533.GW4067720@noisy.programming.kicks-ass.net>
 <aNW3du48v3PvwPbq@slm.duckdns.org>
 <20250926103628.GE4067720@noisy.programming.kicks-ass.net>
 <aNcICdscrYDUMKiU@slm.duckdns.org>
 <20250929100658.GC3245006@noisy.programming.kicks-ass.net>
 <aNxseDZ9bJbKQ36-@slm.duckdns.org>
 <20251001115452.GN3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001115452.GN3245006@noisy.programming.kicks-ass.net>

Hello,

On Wed, Oct 01, 2025 at 01:54:52PM +0200, Peter Zijlstra wrote:
...
> So I don't mind complicated per-se. There is some definitely non-trivial
> code in the scheduler already, some needed TLA+ to be proven correct.
> The srq_lock thing doesn't come close to that.
> 
> OTOH I see absolutely no future in allowing BPF to have any say what so
> ever in the locking -- that's just not sane.

We for sure don't want BPF locking to be intertwined with kernel locking.
Whatever happens in BPF happens in BPF. The kernel should track the task
states and keep its own locking so that whatever happens in BPF doesn't
affect kernel's integrity or overly complicate what kernel side needs to do.
The goal isn't prescribing what BPF can or cannot do but ensuring that there
is proper isolation and protection.

> > I'm not quite following why task_rq_lock() wouldn't be able to take it.
> > Whether p->sub_lock nests under or over DSQ locks should only matter to
> > sched_ext proper. From core's POV, the only thing that matters is that as
> > long as p->sub_lock is held, the task won't be migrating and is safe to
> > change states for (more on this later).
> 
> The change pattern does dequeue+enqueue, both require dsq->lock. 
> 
> If you want __task_rq_lock() to take p->sub_lock, the only possible
> order is p->sub_lock outside of dsq->lock. But that has definite
> problems elsewhere -- picking a task comes to mind.

Yeah, I need to think more about this but this isn't going to be completely
straightforward regardless of the nesting order. However, the picking side,
the fast path can snoop the first task, which is usually the task to be
picked anyway, locklessly, so DSQ locks nesting inside p->sub_lock likely is
more straightforward although it'd require some lock dancing when the first
task isn't suitable (only happens in global DSQs which are used for
fallbacks anyway).

> If you want p->sub_lock inside dsq->lock, then dequeue must take the
> lock (and enqueue release it).
> 
> But this has problems when you're switching dsq, since you cannot do:
> 
> 	LOCK dsq1->lock
> 	LOCK p->sub_lock
> 	UNLOCK dsq1->lock
> 
> 	LOCK dsq2->lock
> 	UNLOCK p->sub_lock
> 	UNLOCK dsq2->lock

Yeah, this is nastier. I'd have to double lock DSQ locks and then grab the
sub_lock when migrating.

> Again, no matter which way around it I flip this, its not nice. Worse,
> if you want to allow BPF to manage the dsq->lock, you then also have to
> have BPF manage the p->sub_lock. This means all of the kernel's
> scheduler locking is going to depend on BPF and I really, as in *REALLY*
> object to that.

I wonder whether this is where disagreement is coming from. BPF side has no
need and is not going to have any control over p->sub_lock just like it
currently doesn't have any control over rq locks or DSQ locks. This will all
kernel side synchronization.

> > I'm failing to see the problems you're seeing and have to disagree that
> > allowing more capabilities on BPF side doesn't bring any upsides. DSQs are
> > useful but it quickly becomes too restrictive - e.g. people often want to
> > put the same task on multiple queues and other data structures, which is a
> > lot more straightforward to do if the data structure and locking are managed
> > in BPF. In general, I don't think it's a good direction to be prescriptive
> > about how schedulers should be implemented or behave. Even if we might not
> > be able to think up something neat right now, someone will.
> 
> Once they do, they can come and work through the locking. We're not
> going to do insane things just in case. Seriously, stop this nonsense.

I don't think any of the ideas being discussed were particularly more or
less insane than others. Which part is so insane?

> You cannot have one task on multiple queues without serialization. Every
> enqueue,dequeue,pick will have to lock all those runqueues. The moment
> you *have* implemented the required locking such that it is both correct
> and faster than a single larger runqueue we can talk.

Yes, that's exactly what the BPF arena spinlock can be used for. The point
is that the kernel shouldn't have to worry about what BPF side is doing as
long as they don't clearly misbehave in terms of scheduling decisions.

> Up to that point, its vapourware.

The ability to queue a task on multiple data structures is something which
has been requested from early on. We tried that with BPF managed data
structures - bpf_list and bpf_rbtree - but it turned out too restricted and
finicky to use. Now with BPF arena, implementing complex data structures is
becoming feasible. This is still in early development but the following is
queueing structure implemented in BPF arena proper:

  https://github.com/sched-ext/scx/blob/main/lib/atq.bpf.c

It doesn't do anything fancy yet but provides the flexibility necessary for
managing a task in multiple data structures. While it's not used widely
right now, it's definitely more than vapor.

> And no, BPF is not the only possible way to test-drive crazy ideas. You
> can implement such things in userspace just fine. We did most of the
> qspinlock development in userspace.

Of course, there are multiple ways to do anything, but, here, my point is
that we don't want to restrict what sched_ext BPF schedulers can do if
reasonbly possible.

> > I have two questions:
> > 
> > - Let's say something works, whether that's holding dsq->lock or
> >   p->sub_lock. I still don't understand how things would be safe w.r.t.
> >   things like PSI and uclamp updates. How would they cope with
> >   set_task_cpu() happening without the rq locked?
> 
> I'm not quite sure what the psi problem is; but uclamp update -- like
> all updates -- is done with task_rq_lock(). Nobody is proposing to ever
> do set_task_cpu() without rq locks held, that would be broken.
...

Everything upto this point makes sense to me.

> while pick_task_scx() based migration is like:
> 
>   __schedule()
>     rq_lock();
>     ...
>     next = pick_task() := pick_task_scx()
>       raw_spin_lock(&dsq->lock);
>       p = dsq_pick(dsq);
>       set_task_cpu(p, here);
>       raw_spin_unlock(&dsq->lock);
>     ...
>     rq_unlock();
> 
> Yes, there is a little bit of tricky in __task_rq_lock(), but that is
> entirely manageable.
> 
> This is all nicely serialized.

This is where I am confused, so the above is doing set_task_cpu() while only
holding the destination rq lock, but this doesn't dequeue the task from the
previous CPU. dequeue_task() calls psi_dequeue() and uclamp_rq_dec(). Both
mechanisms track per-CPU states which are protected by the task's current rq
lock. When a task moves from one CPU to another, the task should discount
itself from the previous CPU and add itself into the new CPU. This also
applies to sched_core_dequeue() and sched_info_dequeue().

> So you're asking me to puke all over the core code for maybes and
> mights -- I'm not having it.

This is an exaggeration. There are two hooks on discussion in this thread:

- balance() promotion. All it does is ensuring that balance() is always
  called before pick_task() for sched_ext. What we want to add for DL
  support is doing the same promotion for DL server. Whether to promote or
  not can be packaged on the sched_ext side, so that it doesn't make the
  code messier than now.

- An additional hook to tell sched_ext the next picked task. We had this in
  v6.12 when sched_ext was merged. During the refactoring of sched_class
  switch ops afterwards, it was incorrectly moved into sched_ext's switch
  ops, which I failed to notice.

Sure, they aren't the prettiest things but they're contained and don't have
significant impact in terms of performance or readability. If the dedicated
hooks are bothersome, we can generalize them too.

I'm not against making it prettier but let's not make up an emergency.

> Here are the options:
> 
>  - push rf into pick_task; delete that balance hack and you do all
>    the lock dancing in pick_task_scx() and return RETRY_TASK on races.
>    This allows your BPF managed vapourware to do whatever, the price is
>    you get to deal with the races in pick_task_scx().
> 
>  - do the p->srq_lock thing; delete that balance hack and have
>    pick_task_scx() be nice and simple. This means a single global lock
>    for BPF managed nonsense (or just delete that option entirely).
> 
>  - have some do a detailed analysis of all cases and present a coherent
>    alternative -- no handwaving, no maybes.
> 
> You didn't much like the first option, so I invested time in an
> alternative, which is the second option. At which point you pulled out
> the might and maybes and BPF needs to do its own locking nonsense.

While I appreciate your effort, this is an unfair representation of how the
thread developed. This isn't a productive way to discuss anything. Let's
take a step back and see where we're diverging:

- As much as possible, I don't want to put restrictions on what BPF
  schedulers can do. I don't see why this should be a point of fundamental
  disagreement as long as locking issues are resolved in kernel proper.

- Whether it's RETRY_TASK, p->srq_lock or p->sub_lock, I still don't see how
  it would work w.r.t. [un]charging per-cpu states. You tried to explain but
  I still don't see how this could work. What am I missing?

Thanks.

-- 
tejun


Return-Path: <cgroups+bounces-10507-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67444BB03FC
	for <lists+cgroups@lfdr.de>; Wed, 01 Oct 2025 13:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B32FE3C2C9A
	for <lists+cgroups@lfdr.de>; Wed,  1 Oct 2025 11:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB3D2E611B;
	Wed,  1 Oct 2025 11:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TwTKgvBR"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300A82E5B19;
	Wed,  1 Oct 2025 11:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759319710; cv=none; b=EyR/LqUgzDe0D0fWn5sYpxhdpekWipSbAMwaXRgWw7YMDYpJqgxuUACFn1qiWz7YpxJ5Iy7vTh34BD9E73YyrqkFQS/w59gzGdJo3q09PwJfgKcJc/9Q4zCoqsQoxZPrw2HxeSYSmi1NLrULcHa9H2G7zMrAwjKa6lvAIMRXJOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759319710; c=relaxed/simple;
	bh=ocqArF2qlYf+QoekOl/JWbgDmyjlb568Vza/HO5kklM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0bUI0nsEMBBw2gasGX/aqaXkKdifA60V5zPoLPvVAUqgw/TZIFg7q4iIU0QABQ0OYn8AdCkh22rB6EG/z2vMJiufTUr7z5utiDDNkxTtJZBym35PAg9YuF6MjxfRwj7yc6rHyrmW1NqSE69ErJPR1O5piMJcrL4DuKYbknUf98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TwTKgvBR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VwdCuyt5nxKVhGK29b+MQ9B6NcdiGvezetikw0ROeYQ=; b=TwTKgvBROvNtcSYPjLBMQLVFRO
	/KRjB67PpWIuvMUFCenbNpB8asMgr1K5wDMrl1eR1lsBllREHKveJGM0ftp7O3cX/ad77tdXs/mJh
	niWAFvISrS+5EuUl6/FmPc2wWvDs/gH8NrQtMeW/lozy3IBw1IpNprHtLqCUHPkw9v1ThAHPxYtIT
	nkxpmKquQebRdXTu6KmWPt1VVFDZfk+i/MsHghpt72R9WjMSO0DJc2hj+2H21Qt/yd7PvTcq4cFNJ
	bjwztkkVans2h4cialMqMo29KzhLvegtTz7mWfzS8NXmL+FT4mXkNIJ6eGSRQ5NVafo1QHM9Pb7gr
	b32oxihQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3vQ4-0000000GvF4-2Yqz;
	Wed, 01 Oct 2025 11:54:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C3E70300328; Wed, 01 Oct 2025 13:54:52 +0200 (CEST)
Date: Wed, 1 Oct 2025 13:54:52 +0200
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
Message-ID: <20251001115452.GN3245006@noisy.programming.kicks-ass.net>
References: <aMRexZ_SIUVgkIpZ@slm.duckdns.org>
 <20250915083815.GB3289052@noisy.programming.kicks-ass.net>
 <aMnk5Wcdr2q6BWqR@slm.duckdns.org>
 <aMnnslT_mUfAtytN@slm.duckdns.org>
 <20250925083533.GW4067720@noisy.programming.kicks-ass.net>
 <aNW3du48v3PvwPbq@slm.duckdns.org>
 <20250926103628.GE4067720@noisy.programming.kicks-ass.net>
 <aNcICdscrYDUMKiU@slm.duckdns.org>
 <20250929100658.GC3245006@noisy.programming.kicks-ass.net>
 <aNxseDZ9bJbKQ36-@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNxseDZ9bJbKQ36-@slm.duckdns.org>

On Tue, Sep 30, 2025 at 01:49:12PM -1000, Tejun Heo wrote:

> > That is, either way around: dsq->lock outside, p->sub_lock inside, or
> > the other way around, I emd up with inversions and race conditions that
> > are not fun.
> 
> It's not straightforward for sure but none of these approaches are. They are
> all complicated in some areas. From sched_ext POV, I think what matter most
> are providing as much latitude as possible to BPF scheduler implementations
> and having lower likelihood of really subtle issues.

So I don't mind complicated per-se. There is some definitely non-trivial
code in the scheduler already, some needed TLA+ to be proven correct.
The srq_lock thing doesn't come close to that.

OTOH I see absolutely no future in allowing BPF to have any say what so
ever in the locking -- that's just not sane.

> > Also, if you do put p->sub_lock inside dsq->lock, this means
> > __task_rq_lock() cannot take it and it needs to be pushed deep into scx
> > (possibly into bpf ?) and that means I'm not sure how to do the change
> > pattern sanely.
> 
> I'm not quite following why task_rq_lock() wouldn't be able to take it.
> Whether p->sub_lock nests under or over DSQ locks should only matter to
> sched_ext proper. From core's POV, the only thing that matters is that as
> long as p->sub_lock is held, the task won't be migrating and is safe to
> change states for (more on this later).

The change pattern does dequeue+enqueue, both require dsq->lock. 

If you want __task_rq_lock() to take p->sub_lock, the only possible
order is p->sub_lock outside of dsq->lock. But that has definite
problems elsewhere -- picking a task comes to mind.

If you want p->sub_lock inside dsq->lock, then dequeue must take the
lock (and enqueue release it).

But this has problems when you're switching dsq, since you cannot do:

	LOCK dsq1->lock
	LOCK p->sub_lock
	UNLOCK dsq1->lock

	LOCK dsq2->lock
	UNLOCK p->sub_lock
	UNLOCK dsq2->lock

Again, no matter which way around it I flip this, its not nice. Worse,
if you want to allow BPF to manage the dsq->lock, you then also have to
have BPF manage the p->sub_lock. This means all of the kernel's
scheduler locking is going to depend on BPF and I really, as in *REALLY*
object to that.

> > Having __task_rq_lock() take p->dsq->lock solves all these problems,
> > except for that one weird case where BPF wants to do things their own
> > way. The longer I'm thinking about it, the more I dislike that. I just
> > don't see *ANY* upside from allowing BPF to do this while it is making
> > everything else quite awkward.
> 
> I'm failing to see the problems you're seeing and have to disagree that
> allowing more capabilities on BPF side doesn't bring any upsides. DSQs are
> useful but it quickly becomes too restrictive - e.g. people often want to
> put the same task on multiple queues and other data structures, which is a
> lot more straightforward to do if the data structure and locking are managed
> in BPF. In general, I don't think it's a good direction to be prescriptive
> about how schedulers should be implemented or behave. Even if we might not
> be able to think up something neat right now, someone will.

Once they do, they can come and work through the locking. We're not
going to do insane things just in case. Seriously, stop this nonsense.

You cannot have one task on multiple queues without serialization. Every
enqueue,dequeue,pick will have to lock all those runqueues. The moment
you *have* implemented the required locking such that it is both correct
and faster than a single larger runqueue we can talk.

Up to that point, its vapourware.

And no, BPF is not the only possible way to test-drive crazy ideas. You
can implement such things in userspace just fine. We did most of the
qspinlock development in userspace.

> > The easy fix is to have these BPF managed things have a single global
> > lock. That works and is correct. Then if they want something better,
> > they can use DSQs :-)
> > 
> > Fundamentally, we need the DSQ->lock to cover all CPUs that will pick
> > from it, there is no wiggle room there. Also note that while we change
> > only the attributes of a single task with the change pattern, that
> > affects the whole RQ, since a runqueue is an aggregate of all tasks.
> > This is very much why dequeue/enqueue around the change pattern, to keep
> > the runqueue aggregates updated.
> > 
> > Use the BPF thing to play with scheduling policies, but leave the
> > locking to the core code.
> 
> I have two questions:
> 
> - Let's say something works, whether that's holding dsq->lock or
>   p->sub_lock. I still don't understand how things would be safe w.r.t.
>   things like PSI and uclamp updates. How would they cope with
>   set_task_cpu() happening without the rq locked?

I'm not quite sure what the psi problem is; but uclamp update -- like
all updates -- is done with task_rq_lock(). Nobody is proposing to ever
do set_task_cpu() without rq locks held, that would be broken.

So with my proposal updates (task_rq_lock) would:

 LOCK p->pi_lock
 LOCK rq->lock
 LOCK *p->srq_lock (== &p->scx.dsq->lock)

Taking pi->lock serializes against the task getting woken up.
Taking rq->lock serializes against schedule(), it pins the task if it is
current.
Taking rq->lock serializes the local runqueue.
Taking *p->srq_lock serializes the non-local runqueue.

The constraint is that *p->srq_lock/dsq->lock must fully serialize the
non-local state (eg. scx.runnable_list is out).

Any migration would need to take rq->lock and (optionally, when
relevant) *p->srq_lock to dequeue the task before doing set_next_cpu().
This is both explicit migration and pick based migration. It is
therefore properly serialized against updates.

To be specific, normal migration does:

  rq = __task_rq_lock(p); 	// aquires rq->lock and dsq->lock
  p->on_rq = MIGRATING;
  dequeue_task(p, LOCK);
    p->scx.dsq = NULL;
    task_rq_set_shared(p, NULL);
    raw_spin_unlock(&dsq->lock);
  set_task_cpu(new);
  rq_unlock(rq);

  rq = cpu_rq(new);
  rq_lock(rq);
  enqueue_task(p, LOCK);
    raw_spin_lock(&dsq->lock);
    p->scx.dsq = dsq;
    task_rq_set_shared(p, &dsq->loc);
  p->on_rq = QUEUED;
  __task_rq_unlock(rq, p);	// release dsq->lock and rq->lock


while pick_task_scx() based migration is like:

  __schedule()
    rq_lock();
    ...
    next = pick_task() := pick_task_scx()
      raw_spin_lock(&dsq->lock);
      p = dsq_pick(dsq);
      set_task_cpu(p, here);
      raw_spin_unlock(&dsq->lock);
    ...
    rq_unlock();

Yes, there is a little bit of tricky in __task_rq_lock(), but that is
entirely manageable.

This is all nicely serialized.

> - This all started from two proposed core changes. One additional hook after
>   task pick regardless of the picked task's class (this is a regression that
>   I missed during the pick_task() conversion) and balance() call for
>   deadline server, which I think can be combined with existing special case
>   for sched_ext. While it'd be nice to be able to migrate without holding rq
>   locks, that path seems very invasive and to have a lot of proposed
>   capability impacts. This doesn't seem like a particularly productive
>   direection to me.

So you're asking me to puke all over the core code for maybes and
mights -- I'm not having it.

Here are the options:

 - push rf into pick_task; delete that balance hack and you do all
   the lock dancing in pick_task_scx() and return RETRY_TASK on races.
   This allows your BPF managed vapourware to do whatever, the price is
   you get to deal with the races in pick_task_scx().

 - do the p->srq_lock thing; delete that balance hack and have
   pick_task_scx() be nice and simple. This means a single global lock
   for BPF managed nonsense (or just delete that option entirely).

 - have some do a detailed analysis of all cases and present a coherent
   alternative -- no handwaving, no maybes.

You didn't much like the first option, so I invested time in an
alternative, which is the second option. At which point you pulled out
the might and maybes and BPF needs to do its own locking nonsense.

What is not an option is sprinkling on more hacks.


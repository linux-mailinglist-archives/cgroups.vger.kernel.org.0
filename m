Return-Path: <cgroups+bounces-10504-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0606BAECD9
	for <lists+cgroups@lfdr.de>; Wed, 01 Oct 2025 01:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6527A4A2DD8
	for <lists+cgroups@lfdr.de>; Tue, 30 Sep 2025 23:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E1A257828;
	Tue, 30 Sep 2025 23:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmd0Svoj"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D91258CDC;
	Tue, 30 Sep 2025 23:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759276154; cv=none; b=dmSDB+AZr5BKq76bNSOIMlbIvyQKfJHJtSVwEOgeJwR30lGAA1KGN0GUHmQMUMoR7FESpgOBFkWHerGinLb3ovuPyXYzxQUpIsaSJKO/38F71BbFrCYG49rjUY/an0YR9jPVMI7Saxv7PVz2JKCJslTbzu0qgCH6JklnrTPDilE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759276154; c=relaxed/simple;
	bh=7VAol8rQRsLQd4lbBp1qCT4rhceiGs6eyik3FbiRdyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwaOjit81y+Kv0q7KgiEn+LDQAUv6r/8PdF/eKoqpw0CbV31q82ACjTZXT4V7OAGejK0WsbnL8gcu1WLQix5i/CqqttsV/av38vNT0Tm3n1zwzLvjAnlOlE13QHCvQYhJkiL0fgqKM5jFwz0jxDNq5bDe7dS4MMxSsady+Zn+24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmd0Svoj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADFDC4CEF0;
	Tue, 30 Sep 2025 23:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759276154;
	bh=7VAol8rQRsLQd4lbBp1qCT4rhceiGs6eyik3FbiRdyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lmd0Svoj7Pee3uBFZtW8KHm67+M5ATQAdOhX0uWJxMXalU3c4ApycHGnnXrbdJwhm
	 Cre0ZgRZLQuY61U5uikz9ccsPJ5/ymErxRiYVHWLQrC/+jvPgMHcZl993sKS8h4d25
	 pkfUMe9JWIRH+2l07dj22igHfNotMqwOiJAkh/g+WF54jCaEoQqEKPl0bSiE2ust4q
	 Gh2uPzbFu4ggKiHDDyAoQQTX91PiZvjIWZcwKrvsnUIh7O6X/5x3BIyBI6eQSasfIb
	 tGMwsxdOLMghyRBFaHxplrg6l5udPhZr/BM9LdpWdvm4+QzgyksmPP9vH2o9IFtPO1
	 MNWaSBJ5SmUlg==
Date: Tue, 30 Sep 2025 13:49:12 -1000
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
Message-ID: <aNxseDZ9bJbKQ36-@slm.duckdns.org>
References: <20250912115459.GZ3289052@noisy.programming.kicks-ass.net>
 <aMRexZ_SIUVgkIpZ@slm.duckdns.org>
 <20250915083815.GB3289052@noisy.programming.kicks-ass.net>
 <aMnk5Wcdr2q6BWqR@slm.duckdns.org>
 <aMnnslT_mUfAtytN@slm.duckdns.org>
 <20250925083533.GW4067720@noisy.programming.kicks-ass.net>
 <aNW3du48v3PvwPbq@slm.duckdns.org>
 <20250926103628.GE4067720@noisy.programming.kicks-ass.net>
 <aNcICdscrYDUMKiU@slm.duckdns.org>
 <20250929100658.GC3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929100658.GC3245006@noisy.programming.kicks-ass.net>

Hello, Peter.

On Mon, Sep 29, 2025 at 12:06:58PM +0200, Peter Zijlstra wrote:
...
> > However, thinking more about it. I'm unsure how e.g. the actual migration
> > would work. The actual migration is done by: deactivate_task() ->
> > set_task_cpu() -> switch rq locks -> activate_task(). Enqueueing/dequeueing
> > steps have operations that depend on rq lock - psi updates, uclamp updates
> > and so on. How would they work?
> 
> Suppose __task_rq_lock() will take rq->lock and p->sub_lock, in that
> order, such that task_rq_lock() will take p->pi_lock, rq->lock and
> p->sub_lock.
> 
...
> While at the same time, above you argued p->sub_lock should be inside
> dsq->lock. Because:
> 
> __schedule()
>   rq = this_rq();
>   LOCK rq->lock
>   next = pick_next() := pick_next_scx()
>     LOCK dsq->lock
>     p = find_task(dsq);
>     LOCK p->sub_lock
>     dequeue(dsq, p);
>     UNLOCK dsq->lock

I was going back and forth with the locking order. Note that even if
sub_lock is nested outside DSQ locks, the hot path for the pick_task() path
wouldn't be that different - it just needs RCU protected first_task pointer
and the DSQ association needs to be verified after grabbing the sub_lock
(much like how task_rq_lock() needs to retry).

> Because if you did something like:
> 
> __schedule()
>   rq = this_rq();
>   LOCK rq->lock
>   next = pick_next() := pick_next_scx()
>     LOCK dsq->lock (or RCU, doesn't matter)
>     p = find_task(dsq);
>     UNLOCK dsq->lock
> 				migrate:
> 				LOCK p->pi_lock
> 				rq = task_rq(p)
> 				LOCK rq->lock
> 				(verify bla bla)
> 				LOCK p->sub_lock
> 				LOCK dsq->lock
> 				dequeue(dsq, p)
> 				UNLOCK dsq->lock
> 				set_task_cpu(n);
> 				UNLOCK rq->lock
> 				rq = cpu_rq(n);
> 				LOCK rq->lock (inversion vs p->sub_lock)
> 				LOCK dsq2->lock
> 				enqueue(dsq2, p)
> 				UNLOCK dsq2->lock
> 
>     LOCK p->sub_lock
>     LOCK dsq->lock   (whoopsie, p is on dsq2)
>     dequeue(dsq, p)
>     set_task_cpu(here);
>     UNLOCK dsq->lock

I suppose the above is showing that p->sub_lock is nested outside dsq->lock,
right? If so, the right sequence would be:

        LOCK p->sub_lock
        LOCK src_dsq->lock
        verify p is still on src_dsq, if not retry
        remove from src_dsq
        UNLOCK src_dsq->lock
        LOCK dst_dsq->lock
        insert into dst_dsq
        UNLOCK dst_dsq->lock
        UNLOCK p->sub_lock

> That is, either way around: dsq->lock outside, p->sub_lock inside, or
> the other way around, I emd up with inversions and race conditions that
> are not fun.

It's not straightforward for sure but none of these approaches are. They are
all complicated in some areas. From sched_ext POV, I think what matter most
are providing as much latitude as possible to BPF scheduler implementations
and having lower likelihood of really subtle issues.

> Also, if you do put p->sub_lock inside dsq->lock, this means
> __task_rq_lock() cannot take it and it needs to be pushed deep into scx
> (possibly into bpf ?) and that means I'm not sure how to do the change
> pattern sanely.

I'm not quite following why task_rq_lock() wouldn't be able to take it.
Whether p->sub_lock nests under or over DSQ locks should only matter to
sched_ext proper. From core's POV, the only thing that matters is that as
long as p->sub_lock is held, the task won't be migrating and is safe to
change states for (more on this later).

> Having __task_rq_lock() take p->dsq->lock solves all these problems,
> except for that one weird case where BPF wants to do things their own
> way. The longer I'm thinking about it, the more I dislike that. I just
> don't see *ANY* upside from allowing BPF to do this while it is making
> everything else quite awkward.

I'm failing to see the problems you're seeing and have to disagree that
allowing more capabilities on BPF side doesn't bring any upsides. DSQs are
useful but it quickly becomes too restrictive - e.g. people often want to
put the same task on multiple queues and other data structures, which is a
lot more straightforward to do if the data structure and locking are managed
in BPF. In general, I don't think it's a good direction to be prescriptive
about how schedulers should be implemented or behave. Even if we might not
be able to think up something neat right now, someone will.

> The easy fix is to have these BPF managed things have a single global
> lock. That works and is correct. Then if they want something better,
> they can use DSQs :-)
> 
> Fundamentally, we need the DSQ->lock to cover all CPUs that will pick
> from it, there is no wiggle room there. Also note that while we change
> only the attributes of a single task with the change pattern, that
> affects the whole RQ, since a runqueue is an aggregate of all tasks.
> This is very much why dequeue/enqueue around the change pattern, to keep
> the runqueue aggregates updated.
> 
> Use the BPF thing to play with scheduling policies, but leave the
> locking to the core code.

I have two questions:

- Let's say something works, whether that's holding dsq->lock or
  p->sub_lock. I still don't understand how things would be safe w.r.t.
  things like PSI and uclamp updates. How would they cope with
  set_task_cpu() happening without the rq locked?

- This all started from two proposed core changes. One additional hook after
  task pick regardless of the picked task's class (this is a regression that
  I missed during the pick_task() conversion) and balance() call for
  deadline server, which I think can be combined with existing special case
  for sched_ext. While it'd be nice to be able to migrate without holding rq
  locks, that path seems very invasive and to have a lot of proposed
  capability impacts. This doesn't seem like a particularly productive
  direection to me.

Thanks.

-- 
tejun


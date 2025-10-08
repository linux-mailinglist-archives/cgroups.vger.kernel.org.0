Return-Path: <cgroups+bounces-10612-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8668CBC6905
	for <lists+cgroups@lfdr.de>; Wed, 08 Oct 2025 22:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34F964EB875
	for <lists+cgroups@lfdr.de>; Wed,  8 Oct 2025 20:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53702857E9;
	Wed,  8 Oct 2025 20:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8chkTzt"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D5827814C;
	Wed,  8 Oct 2025 20:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759954911; cv=none; b=NznY9sb1mon4wCLsINOWEB1n+YJL2qsTN8qppVFDVvp46p6MBDyvRS3FXWkR7f+MI2tEhSw5FGIdeUCT/C2bBrE9WC+MT5gQcDtvHVvub0c6k1Rm+H4Q3aHN9JTHR3xUUQ4QlOI02mRhsd1sN6xmQwK+H+SLXc+s4wHMvF8Zd1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759954911; c=relaxed/simple;
	bh=tuurgTUMyuS9ME6OcK+LydMC1ElS2DSUj+9T7OEsCiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MW1H988elgbgnh8MgOYHkK4l0QLaCnlM6a2VRy8hRcCouI0wk0EqrkaUadt9ftoaA6/gpON1x9PjdBPS5UjTPMnTuu1cjJFloZFSqNtmbMrMA0tt4WJcmopa0UINN00IINi6uJ4Lu2uBcoXJOgEq24o6afd5Vw4aWWkC+HirzTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8chkTzt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8D2C4CEE7;
	Wed,  8 Oct 2025 20:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759954910;
	bh=tuurgTUMyuS9ME6OcK+LydMC1ElS2DSUj+9T7OEsCiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f8chkTztumBR8hHNwOeXDgnchHDfG33CtgWlmmr/FSbUnoL8hJtTBJeXv4QOiiPRS
	 aT2B1zaLvvTl4jwpsyeQb4ZTES7vgbyc89vOjQY4HPW7WrYtFCAbkC4OtLX1seaI+s
	 s+FHbAx7L2JqskocRudSCBvFyGrAauaBRfWMVF1xjRLAaCAQv/kOlcqtAg+StK+LI3
	 t41wj2H9gxt4LIcE6jCYsQasrDAKunwxVRAQAvIUomKIM2O0pDhgoi+R/ZNI4sWhu0
	 e1Uh8a3dcDatJnptqeroPqa3xoP93MgUkKScx4lcO3inq2NDv7vZSLQ3oD6VhuCpVg
	 8LfeP5kN+bLBg==
Date: Wed, 8 Oct 2025 10:21:49 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de,
	alexei.starovoitov@gmail.com
Subject: Re: [RFC][PATCH 0/3] sched/ext: Cleanup pick_task_scx()
Message-ID: <aObH3RNKbRX1FXNn@slm.duckdns.org>
References: <20251006104652.630431579@infradead.org>
 <aOWKn6f0OtegV1q0@slm.duckdns.org>
 <20251008091151.GS4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008091151.GS4067720@noisy.programming.kicks-ass.net>

Hello,

On Wed, Oct 08, 2025 at 11:11:51AM +0200, Peter Zijlstra wrote:
...
> Possibly. But lets stick that on a todo list :-) I was also looking to
> get rid of sched_class::pick_next_task() -- the only reason that
> currently still exists is because of that fair cgroup nonsense.
> 
> I was looking at bringing back Rik's flatten series (easier now that the
> cfs bandwidth throttle thing is fixed). That should get rid of that
> hierarchical pick; and thus obviate that whole mess in
> pick_next_task_fair().

Yeah, that'd be great. IIRC, the blocking issue was dealing with thundering
herds. ISTR Rik discussing a way to resolve that.

> Now, I do have a few questions from staring at this ext stuff for a
> while:
> 
>  - So the 'RT' problem with balance_one() is due to:
> 
>     o rq-lock-break allowing higher prio task to come in
>     o placing a task on the local dsq
> 
>    which results in that local-dsq getting 'starved'. The patches want
>    to call switch_class(), which I suppose will work, this is something
>    like:
> 
>    if (rq_modified_above(rq, &ext_sched_class)) {
>       /*
>        * We don't have a next task at this point, but can guess at its
>        * class based on the highest set bit in the queue_mask.
>        */
>       scx_cpu_release(reason_from_mask(rq->queue_mask), NULL);
>       return RETRY_TASK;
>    }
> 
>    But I was thinking that we could also just stick that task back onto
>    some global dsq, right? (presumably the one we just pulled it from is
>    a good target). This would effectively 'undo' the balance_one().

From ops.cpu_release(), the BPF scheduler can call scx_bpf_reenqueue_local()
which runs the enqueue path again for the queued tasks so that the scheduler
can decide on what to do with these tasks including sticking it into a
global DSQ or putting it back to the source DSQ. Yeah, it may make sense to
make some bulit-in actions available through ops flags.

>  - finish_dispatch() -- one of the problems that I ran into with the
>    shared rq lock implementation is that pick_task_scx() will in fact
>    try and enqueue on a non-local dsq.
> 
>    The callchain is something like:
> 
>      pick_task_scx()
>        bpf__sched_ext_ops_dispatch()
>          scx_bpf_dsq_move_to_local()
> 	   flush_dispatch_buf()
> 	     dispatch_enqueue() // dsq->id != SCX_DSQ_LOCAL
>  
>    And this completely messes up the locking -- I'm not sure how to fix
>    this yet. But adding this flush to do random other things to various
>    code paths really complicates things. Per the function what we really
>    want to do is move-to-local, but then we end up doing random other
>    things instead :/

Hmm... this is deferred execution of tasks being dispatched to non-local
DSQs. The reason why they're deferred is to avoid entanglement with BPF side
synchronization, although BPF side locking developed in a different way than
we were thinking back then, so we may be able to remove the deferred
operations. Need to think more about that.

However, I'm not sure that would change much w.r.t. how it interacts with
core locking. While deferred, it's deferred within ops.dispatch(). ie.
ops.dispatch() is allowed to move any task to any DSQ. Whether that's
deferred or not within ops.dispatch() shouldn't make much difference.

>  - finish_dispatch() -- per the above problem I read this function and
>    found that:
> 
>      "the BPF scheduler is allowed to dispatch tasks spuriously"
> 
>    and I had to go and buy a new WTF'o'meter again :/ Why would you
>    allow such a thing? Detect the case because the BPF thing is
>    untrusted and can do crazy things, sure. But then kill it dead; don't
>    try and excuse badness.

This came to be because the BPF data structures that we were playing with
earlier didn't easily support arbitrary element removals. The kernel side
needs to be able to reliably detect whether the dispatch attempt is allowed
or not anyway, so, as a workaround, instead of aborting the scheduler, I
just made it ignore spurious attempts. With new arena based data structures,
this shouldn't be a problem anymore, and it'd make sense to make this
stricter.

>  - scx_bpf_dsq_move_to_local() found per the above problem, but per its
>    comment it is possible BPF calls this with its own locks held. This
>    then results in:
> 
>    CPU1 
> 
>    try_to_wake_up()
>      rq_lock();
>      enqueue_task() := enqueue_task_scx()
>        bpf__sched_ext_ops_something_or_other()
>          your bpf area lock thing
> 
>    // rq->lock
>    // bpf area lock
> 
>    CPU2
>      bpf__sched_ext_whatever()
>        bpf area lock
>          scx_bpf_move_to_local()
> 	   rq_lock()
> 
>    // bpf area lock
>    // rq->lock
> 
>   and we have a deadlock -- I thought BPF was supposed to be safe? And
>   while the recent rqspinlock has a timeout, and there the bpf validator
>   knows a spinlock exists and can prohibit kernel helper calls, this
>   bpf area lock you have has no such things (afaict) and BPF can
>   completely mess up the kernel. How is this okay?

BPF arena locks are not allowed to spin indefinitely. It will break out of
spinning and fail the locking attempt. Right now, such failures need to be
handled manually, but, once the BPF program abort support is merged, we
should be able to auto-abort schedulers.

Thanks.

-- 
tejun


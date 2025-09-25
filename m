Return-Path: <cgroups+bounces-10454-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9080BA0790
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 17:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059CB1BC74B9
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 15:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B233019C1;
	Thu, 25 Sep 2025 15:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GtP6dX0G"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390DA35940;
	Thu, 25 Sep 2025 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758815621; cv=none; b=A2xmxtORRjVAXk6NsV2VX1vpv8LwntqZCmI36vVHzikN6izIXu0Vpyon1nNTNoaocSeC5lGHf2mReeDL9jiw1g8YHCrohugx3j8D9GB/ZxFPOINQz2Qu6gkn67AuHQI6z1kjZdlPbqljAVI5mztaY7b8XshIqQKzf8OlKfwefuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758815621; c=relaxed/simple;
	bh=7r4YX+EwNs0f4KtHUAVJL2oOzBh1ngpDFQ60fS+Vazs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yqxu9FBrdfKzYXEe7Ox4qRPt8dwp0Yl63aQsx+K6a4Mt+Ngh1P4J9y8sQ+autWgYgTYXM34x+pzEEEhdMozo3OM1entQtHBb2vZvgbzMZ7JCm8FNpkx93x0KitxnpcAIIxqFoUnviEboD/f8wQk0dDqLLwWmfCEzsGJ0cEcRMSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GtP6dX0G; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MMx5s09rqPCKG6svRYSmgtBLmBHp+w5VQ97ldsLvR0U=; b=GtP6dX0Gv3660wO3k6FzHs6r4+
	tJuoK9xVGSumJn8MlwWUjW0uW84xkJGuKqWzVSxPhB9YaGocw5mjEff3BPQRSztGHK5ola0l31E2+
	HER3L0WCC2wgubjaC8+nmAjcReKvnyzxSuyMMiT1qajDXPDVy8AVldF7E4t9RNoYrUK+F4EumCCyp
	/Suv+FzyMY21hLO5uOwHRFP1JUfHsEB9yHyl3Q0o/ghUS3i9XROdyv4P9dfMMYYvR0miltwY3JbfI
	i0bK8nyISIco6fik+FbD7ZEBuuA/SjiwWJn5rk6qORPUJfreFcw9XKzBkBgHIv/cWZ4hCVfmAHKPM
	jSwQt/uw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1oHc-00000009Jz4-2atj;
	Thu, 25 Sep 2025 15:53:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 63248300579; Thu, 25 Sep 2025 17:53:23 +0200 (CEST)
Date: Thu, 25 Sep 2025 17:53:23 +0200
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
Message-ID: <20250925155323.GB4067720@noisy.programming.kicks-ass.net>
References: <20250910154409.446470175@infradead.org>
 <20250910155809.800554594@infradead.org>
 <aMItk3c5H6Z2CD4X@slm.duckdns.org>
 <20250911094240.GW3289052@noisy.programming.kicks-ass.net>
 <aMMzpnyx__ZgZGRc@slm.duckdns.org>
 <20250912141904.GA3289052@noisy.programming.kicks-ass.net>
 <aMRLIEtmcWc0XNmg@slm.duckdns.org>
 <20250925131025.GA4067720@noisy.programming.kicks-ass.net>
 <aNVia1u-GVByUJtC@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNVia1u-GVByUJtC@slm.duckdns.org>

On Thu, Sep 25, 2025 at 05:40:27AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Thu, Sep 25, 2025 at 03:10:25PM +0200, Peter Zijlstra wrote:
> ...
> > Well, either this or scx_tasks iterator will result in lock ops for
> > every task, this is unavoidable if we want the normal p->pi_lock,
> > rq->lock (dsq->lock) taken for every sched_change caller.
> > 
> > I have the below which I would like to include in the series such that I
> > can clean up all that DEQUEUE_LOCKED stuff a bit, this being the only
> > sched_change that's 'weird'.
> > 
> > Added 'bonus' is of course one less user of the runnable_list.
> > 
> > (also, I have to note, for_each_cpu with preemption disabled is asking
> > for trouble, the enormous core count machines are no longer super
> > esoteric)
> 
> Oh yeah, we can break up every N CPUs. There's no cross-CPU atomicity
> requirement.

Right.

> > +	/*
> > +	 * XXX online_mask is stable due to !preempt (per bypass_lock)
> > +	 * so could this be for_each_online_cpu() ?
> >  	 */
> 
> CPUs can go on and offline while CPUs are being bypassed. We can handle that
> in hotplug ops but I'm not sure the complexity is justified in this case.

Well, not in the current code, since the CPU running this has IRQs and
preemption disabled (per bypass_lock) and thus stop_machine, as used in
hotplug can't make progress.

That is; disabling preemption serializes against hotplug. This is
something that the scheduler relies on in quite a few places.

> >  	for_each_possible_cpu(cpu) {
> >  		struct rq *rq = cpu_rq(cpu);
> > -		struct task_struct *p, *n;
> >  
> >  		raw_spin_rq_lock(rq);
> > -
> >  		if (bypass) {
> >  			WARN_ON_ONCE(rq->scx.flags & SCX_RQ_BYPASSING);
> >  			rq->scx.flags |= SCX_RQ_BYPASSING;
> > @@ -4866,36 +4867,33 @@ static void scx_bypass(bool bypass)
> >  			WARN_ON_ONCE(!(rq->scx.flags & SCX_RQ_BYPASSING));
> >  			rq->scx.flags &= ~SCX_RQ_BYPASSING;
> 
> I may be using BYPASSING being set as all tasks having been cycled. Will
> check. We may need an extra state to note that bypass switching is complete.
> Hmm... the switching is not synchronized against scheduling operations
> anymore - ie. we can end up mixing regular op and bypassed operation for the
> same scheduling event (e.g. enqueue vs. task state transitions), which can
> lead subtle state inconsistencies on the BPF scheduler side. Either the
> bypassing state should become per-task, which likely has system
> recoverability issues under lock storm conditions, or maybe we can just
> shift it to the scheduling path - e.g. decide whether to bypass or not at
> the beginning of enqueue path and then stick to it until the whole operation
> is finished.

Makes sense.

> >  		}
> > +		raw_spin_rq_unlock(rq);
> > +	}
> > +
> > +	/* implicit RCU section due to bypass_lock */
> > +	for_each_process_thread(g, p) {
> 
> I don't think this is safe. p->tasks is unlinked from __unhash_process() but
> tasks can schedule between being unhashed and the final preemt_disable() in
> do_exit() and thus the above iteration can miss tasks which may currently be
> runnable.

Bah, you're quite right :/

> > +		unsigned int state;
> >  
> > +		guard(raw_spinlock)(&p->pi_lock);
> > +		if (p->flags & PF_EXITING || p->sched_class != &ext_sched_class)
> > +			continue;
> > +
> > +		state = READ_ONCE(p->__state);
> > +		if (state != TASK_RUNNING && state != TASK_WAKING)
> >  			continue;
> >  
> > +		guard(__task_rq_lock)(p);
> > +		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
> > +			/* nothing */ ;
> >  		}
> > +	}
> 
> This is significantly more expensive. On large systems, the number of
> threads can easily reach six digits. Iterating all of them while doing
> locking ops on each of them might become problematic depending on what the
> rest of the system is doing (unfortunately, it's not too difficult to cause
> meltdowns on some NUMA systems with cross-node traffic). I don't think
> p->tasks iterations can be broken up either.

I thought to have understood that bypass isn't something that happens
when the system is happy. As long as it completes at some point all this
should be fine right?

I mean, yeah, it'll take a while, but meh.

Also, we could run the thing at fair or FIFO-1 or something, to be
outside of ext itself. Possibly we can freeze all the ext tasks on
return to user to limit the amount of noise they generate.

> The change guard cleanups make sense
> regardless of how the rest develops. Would it make sense to land them first?
> Once we know what to do with the core scheduling locking, I'm sure we can
> find a way to make this work accordingly.

Yeah, definitely. Thing is, if we can get all sched_change users to be
the same, that all cleans up better.

But if cleaning this up gets to be too vexing, we can postpone that.





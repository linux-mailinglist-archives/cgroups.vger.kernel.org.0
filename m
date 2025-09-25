Return-Path: <cgroups+bounces-10453-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6F1BA0652
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 17:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD1232A67FD
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 15:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9BA2F0C7C;
	Thu, 25 Sep 2025 15:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gL4nSZAG"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752191DE4E0;
	Thu, 25 Sep 2025 15:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758814828; cv=none; b=uN+QYQOAEHFNilO/Qp+7YX7fBbhrpf4xzDUjKeDXTrnSZNfHUcRpYI+Fjlyg2oCBaXMaGdekjS+sjiKck1ZcidLY1JZxfYpMdJd3pu1oDBsHpauqzSan2KipxaBR+E1pHATKq5mE5BgUk4kpzKclQ9QivVNmzlP2M53Q2Y4HBCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758814828; c=relaxed/simple;
	bh=P4FiONYBncg3DGvvDQnxjY4VJKbaCaoVbnyZ6Yba09k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/Q0LQxf14VZdzYg5hofiAUKH28iITh3NYI3eKf/wjfNP53uw1G/mERTKM1ubzF3LHncnn1Ke05/EIu6suvzRi9KWOcWL+lIQGoD3iEm5KvLizxLvVAA0krcSvLsawaa95Hb8V6Xqwj7y3O1TG8OoZEy60AoQDUlZOAZQ98d2Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gL4nSZAG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37627C4CEF0;
	Thu, 25 Sep 2025 15:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758814828;
	bh=P4FiONYBncg3DGvvDQnxjY4VJKbaCaoVbnyZ6Yba09k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gL4nSZAGvBRpr05w0W7S1rJJv5LP31cmFnZ80BzfbR+cCIKTaLFvIMQWWbh+RgjsD
	 wP3h9wi8ce/WXwhs8O/UQBhN2eKnSWK+QvhvuzF6TR5WoW/zMOb5qaAQbs5XZyd0wP
	 yP4bTgWBmuRtJI0rIY7l/esgrJt23turww5rQ554tAR6N8dHE1FkaPgWquwpWPujUg
	 dn+yHSTYgoo6Kkm4NyiEvyRkAbCWvGZ5cfdb1Lsi33VfB3sv3HCFfO6EflBTEtGeDm
	 A4hKJSZ+kCi88hY3fF2wRgvgYiWDki0aE4AT4ONsc+HyWLu/dzYXhpIgXsTeXvY7q/
	 KU2MrXIB0qDwg==
Date: Thu, 25 Sep 2025 05:40:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 13/14] sched: Add {DE,EN}QUEUE_LOCKED
Message-ID: <aNVia1u-GVByUJtC@slm.duckdns.org>
References: <20250910154409.446470175@infradead.org>
 <20250910155809.800554594@infradead.org>
 <aMItk3c5H6Z2CD4X@slm.duckdns.org>
 <20250911094240.GW3289052@noisy.programming.kicks-ass.net>
 <aMMzpnyx__ZgZGRc@slm.duckdns.org>
 <20250912141904.GA3289052@noisy.programming.kicks-ass.net>
 <aMRLIEtmcWc0XNmg@slm.duckdns.org>
 <20250925131025.GA4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925131025.GA4067720@noisy.programming.kicks-ass.net>

Hello,

On Thu, Sep 25, 2025 at 03:10:25PM +0200, Peter Zijlstra wrote:
...
> Well, either this or scx_tasks iterator will result in lock ops for
> every task, this is unavoidable if we want the normal p->pi_lock,
> rq->lock (dsq->lock) taken for every sched_change caller.
> 
> I have the below which I would like to include in the series such that I
> can clean up all that DEQUEUE_LOCKED stuff a bit, this being the only
> sched_change that's 'weird'.
> 
> Added 'bonus' is of course one less user of the runnable_list.
> 
> (also, I have to note, for_each_cpu with preemption disabled is asking
> for trouble, the enormous core count machines are no longer super
> esoteric)

Oh yeah, we can break up every N CPUs. There's no cross-CPU atomicity
requirement.

> +	/*
> +	 * XXX online_mask is stable due to !preempt (per bypass_lock)
> +	 * so could this be for_each_online_cpu() ?
>  	 */

CPUs can go on and offline while CPUs are being bypassed. We can handle that
in hotplug ops but I'm not sure the complexity is justified in this case.

>  	for_each_possible_cpu(cpu) {
>  		struct rq *rq = cpu_rq(cpu);
> -		struct task_struct *p, *n;
>  
>  		raw_spin_rq_lock(rq);
> -
>  		if (bypass) {
>  			WARN_ON_ONCE(rq->scx.flags & SCX_RQ_BYPASSING);
>  			rq->scx.flags |= SCX_RQ_BYPASSING;
> @@ -4866,36 +4867,33 @@ static void scx_bypass(bool bypass)
>  			WARN_ON_ONCE(!(rq->scx.flags & SCX_RQ_BYPASSING));
>  			rq->scx.flags &= ~SCX_RQ_BYPASSING;

I may be using BYPASSING being set as all tasks having been cycled. Will
check. We may need an extra state to note that bypass switching is complete.
Hmm... the switching is not synchronized against scheduling operations
anymore - ie. we can end up mixing regular op and bypassed operation for the
same scheduling event (e.g. enqueue vs. task state transitions), which can
lead subtle state inconsistencies on the BPF scheduler side. Either the
bypassing state should become per-task, which likely has system
recoverability issues under lock storm conditions, or maybe we can just
shift it to the scheduling path - e.g. decide whether to bypass or not at
the beginning of enqueue path and then stick to it until the whole operation
is finished.

>  		}
> +		raw_spin_rq_unlock(rq);
> +	}
> +
> +	/* implicit RCU section due to bypass_lock */
> +	for_each_process_thread(g, p) {

I don't think this is safe. p->tasks is unlinked from __unhash_process() but
tasks can schedule between being unhashed and the final preemt_disable() in
do_exit() and thus the above iteration can miss tasks which may currently be
runnable.

> +		unsigned int state;
>  
> +		guard(raw_spinlock)(&p->pi_lock);
> +		if (p->flags & PF_EXITING || p->sched_class != &ext_sched_class)
> +			continue;
> +
> +		state = READ_ONCE(p->__state);
> +		if (state != TASK_RUNNING && state != TASK_WAKING)
>  			continue;
>  
> +		guard(__task_rq_lock)(p);
> +		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
> +			/* nothing */ ;
>  		}
> +	}

This is significantly more expensive. On large systems, the number of
threads can easily reach six digits. Iterating all of them while doing
locking ops on each of them might become problematic depending on what the
rest of the system is doing (unfortunately, it's not too difficult to cause
meltdowns on some NUMA systems with cross-node traffic). I don't think
p->tasks iterations can be broken up either.

I'm sure there's a solution for all these. Maybe once bypass is set and the
per-task iteration can be broken up, this is no longer a problem, ok maybe
there's some other way to maintain runnable list in a way that's decoupled
from rq lock. The interlocking requirement is relaxed on the removal side.
There must be a way to visit all runnable tasks but visiting some tasks
spuriously is not a problem, so there's some leeway too.

As with everything, this part is a bit tricky and will need non-trivial
amount of testing to verify that it can recover the system from BPF
scheduler induced death sprials (e.g. migrating tasks too frequently across
NUMA boundaries on some systems). The change guard cleanups make sense
regardless of how the rest develops. Would it make sense to land them first?
Once we know what to do with the core scheduling locking, I'm sure we can
find a way to make this work accordingly.

Thanks.

-- 
tejun


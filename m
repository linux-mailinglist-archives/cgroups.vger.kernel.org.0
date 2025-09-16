Return-Path: <cgroups+bounces-10174-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BC0B7E09D
	for <lists+cgroups@lfdr.de>; Wed, 17 Sep 2025 14:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C20763AF17E
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 22:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE1732B4B1;
	Tue, 16 Sep 2025 22:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/O/NeCg"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ABF329505;
	Tue, 16 Sep 2025 22:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061798; cv=none; b=LIPnLcrrD01puM6M0ZIrLj9elzAHz7IpNwPzIiEwwHX+Dw4qOdoNoItEnOtuq2+8FDqf6SMdnF+jxTlZ+KPTY3MM8ULy60nqvhdvij5+bzs4OtoGA0aFJAJr+u/gjTDpZe6rGk4YrsJ5De4XvJR9cWJk/A9XfWgjEzjgRjSrV8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061798; c=relaxed/simple;
	bh=sEec13Mbx+SxIexwpu14BHrpJdUoMGzVVxqGMEicV34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzjE9M3v2Y8IcgmGCXj+76ywgPJ1BJffio+IMQYVop29ZvRtByD8RyGq71uNQDB5iBvY/Nwa9ho3c1TjdBjQD9Rqd9NuJFWvTYKeZFEZ2xNl4AzOJOowQFCseTI0Goy8/rvcPJKC/UakZnaEA4+WyNJg/fOkOt5iqG1Pqx8un4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/O/NeCg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340DFC4CEEB;
	Tue, 16 Sep 2025 22:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758061798;
	bh=sEec13Mbx+SxIexwpu14BHrpJdUoMGzVVxqGMEicV34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E/O/NeCgg+iFJNCbBs0fvuYeCDPoJoHoTf0XDNE97Kp1E+ajnFQgiizN9oR801rOT
	 oJ/C/wluoMU4qmS4em+FQzwFl+C/8wCBT6XRKE/ZtrQY4gZ4F43b6v05yWy3atehRR
	 2xvhhYY2sG2zrheBqry1KcBaWK8cDa7FpEUfjVWZpOaP3QntC8D13uaToWIrzcNhk1
	 kJExXfw8W7exK75h6HBdYLAaa6fNJhleP78Z4zwxXY7eQdppVJ0DKK2Uw3wxO634tA
	 Ocw4rylFAsfa6tvcug3pqZq/Tp2NYPwjvNRFjO7NigezZNiAFvS5WrjMUxXr+PlBSm
	 sRkcqrCjWbijA==
Date: Tue, 16 Sep 2025 12:29:57 -1000
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
Message-ID: <aMnk5Wcdr2q6BWqR@slm.duckdns.org>
References: <20250910154409.446470175@infradead.org>
 <20250910155809.684653538@infradead.org>
 <aMNnLenCytO_KEKg@slm.duckdns.org>
 <20250912115459.GZ3289052@noisy.programming.kicks-ass.net>
 <aMRexZ_SIUVgkIpZ@slm.duckdns.org>
 <20250915083815.GB3289052@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915083815.GB3289052@noisy.programming.kicks-ass.net>

Hello,

On Mon, Sep 15, 2025 at 10:38:15AM +0200, Peter Zijlstra wrote:
> On Fri, Sep 12, 2025 at 07:56:21AM -1000, Tejun Heo wrote:
> > It *seems* that way to me. There are two other scenarios tho.
> > 
> > - A task can move from a non-local DSQ to another non-local DSQ at any time
> >   while queued. As this doesn't cause rq migration, we can probably just
> >   overwrite p->srq_lock to the new one. Need to think about it a bit more.
> 
> It can use task_on_rq_migrating(), exactly like 'normal' rq-to-rq
> migration:
> 
> 	LOCK src_dsq->lock
> 	p->on_rq = TASK_ON_RQ_MIGRATING;
> 	task_unlink_from_dsq();
> 	UNLOCK src_dsq->lock
> 
> 	LOCK dst_dsq->lock
> 	dispatch_enqueue()
> 	p->on_rq = TASK_ON_RQ_QUEUED;
> 	UNLOCK dst_dsq->lock
> 
> Same reasoning as for the pick_task_scx() migration, if it observes
> !p->srq_lock, then it must observe MIGRATING and we'll spin-wait until
> QUEUED. At which point we'll see the new srq_lock.

I see.

> > - A task can be queued on a BPF data structure and thus may not be on any
> >   DSQ. I think this can be handled by adding a raw_spinlock to task_struct
> >   and treating the task as if it's on its own DSQ by pointing to that one,
> >   and grabbing that lock when transferring that task from BPF side.
> 
> Hmm, and BPF data structures cannot have a lock associated with them?
> I'm thinking they must, something is serializing all that.
> 
> > So, it *seems* solvable but I'm afraid it's becoming too subtle. How about
> > doing something simpler and just add a per-task lock which nests inside rq
> > lock which is always grabbed by [__]task_rq_lock() and optionally grabbed by
> > sched classes that want to migrate tasks without grabbing the source rq
> > lock? That way, we don't need to the lock pointer dancing while achieving
> > about the same result. From sched_ext's POV, grabbing that per-task lock is
> > likely going to be cheaper than doing the rq lock switching, so it's way
> > simpler and nothing gets worse.
> 
> I *really* don't like that. Fundamentally a runqueue is 'rich' data
> structure. It has a container (list, tree, whatever) but also a pile of
> statistics (time, vtime, counts, load-sums, averages). Adding/removing a
> task from a runqueue needs all that serialized. A per-task lock simply
> cannot do this.
> 
> If you've hidden this lock inside BPF such that C cannot access it, then
> your abstraction needs fixing. Surely it is possible to have a C DSQ to
> mirror whatever the BPF thing does. Add a few helpers for BPF to
> create/destroy DSQs (IDs) and a callback to map a task to a DSQ. Then
> the C part can use the DSQ lock, and hold it while calling into whatever
> BPF.

Most current schedulers (except for scx_qmap which is there just to demo how
to use BPF side queueing) use use DSQs to handle tasks the way you're
describing. However, BPF arena is becoming more accessible and gaining wider
usage, paired with purely BPF side synchronization constructs (spinlock or
some lockless data structure).

Long term, I think maintaining flexibility is of higher importance for
sched_ext than e.g. small performance improvements or even design or
implementation aesthetics. The primary purpose is enabling trying out new,
sometimes wild, things after all. As such, I don't think it'd be a good idea
to put strict restrictions on how the BPF side operates unless it affects
the ability to recover the system from a malfunctioning BPF scheduler, of
course.

> Additionally, it can sanity check the BPF thing, tasks cannot go
> 'missing' without C knowing wtf they went -- which is that bypass
> problem, no?

They are orthogonal. Even if all tasks are on DSQs, the scheduler may still
fail to dispatch some DSQs for too long, mess up the ordering inside, cause
excessive bouncing across them, and what not. So, the kernel side still
needs to be able to detect and contain failures. The only difference between
a task being on a DSQ or BPF side is that there needs to be extra per-task
state tracking to ensure that tasks only transit states in orderly fashion
(ie. don't dispatch the same task twice).

Thanks.

-- 
tejun


Return-Path: <cgroups+bounces-10461-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E59BA1A5F
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 23:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 318DC1890B56
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 21:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C8F3218D8;
	Thu, 25 Sep 2025 21:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oszln/cX"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2072773EC;
	Thu, 25 Sep 2025 21:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836599; cv=none; b=luZtJj5Y3qyjc0IrzU0g/6/s9SbN6IbvJjCP5WsPMNWNycqCYw97N7Fx9ZUG6qD1U0fDsjFe0J89x25R8ONrJEhuxdpvvoM/2lGD5/spWkPZWoGGuAH/fO920OxrIHPXi9yuPlPP629zb0UDAPH5npWUdnaZzHcImcF2OFbt6ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836599; c=relaxed/simple;
	bh=gdEba6O7Rkj4Pxz78PvQgjCgq2dwOxxwF1B/7bT/c50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmdxzJ53glOE0660DmxtYE093P/hZvpErnBR9uDo6+fl/N47zcW93XZ0J+VZg++EhifUR88oIg0C9XihUw0Z55u0c1tVSu76ias8kXzmcI2mvA2gFN5yUfx/zbCPP8EuABIZgkc4LcS1YM94Xnqn7fPklk/qVIr79CyjdRGyDog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oszln/cX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F44DC4CEF0;
	Thu, 25 Sep 2025 21:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758836599;
	bh=gdEba6O7Rkj4Pxz78PvQgjCgq2dwOxxwF1B/7bT/c50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oszln/cXXf2dVcyESeQCNaJyBGnArXoYvcYS7y7SijkmGGq4xfF98OGhpi1Nq+uD6
	 L5gaDuBqswD/b+8ZBONJXolKJSkqMGtAsPev977nepwtwEbsECZCGQAcRqCC+kWDgA
	 zpU9HVG0Xs4w637xkeMVQXm26wYalWMn3PoM+H5v5GFp30qERJ2xFB76cOxmSfpc8e
	 Jpqw1PIGOM+NdpbRbB3uf+8eBMd83P5r0E/L38B7Kr7ouJzym9MJqzVU/iNoy5UYuD
	 SfAl3UwSJLFfJr/b8kiqldu1Y00YGZPGi/yxX0HnrEFPhlH1jS1943q/Q8GhAX9mjF
	 zW/AaJS1eiP1Q==
Date: Thu, 25 Sep 2025 11:43:18 -1000
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
Message-ID: <aNW3du48v3PvwPbq@slm.duckdns.org>
References: <20250910154409.446470175@infradead.org>
 <20250910155809.684653538@infradead.org>
 <aMNnLenCytO_KEKg@slm.duckdns.org>
 <20250912115459.GZ3289052@noisy.programming.kicks-ass.net>
 <aMRexZ_SIUVgkIpZ@slm.duckdns.org>
 <20250915083815.GB3289052@noisy.programming.kicks-ass.net>
 <aMnk5Wcdr2q6BWqR@slm.duckdns.org>
 <aMnnslT_mUfAtytN@slm.duckdns.org>
 <20250925083533.GW4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925083533.GW4067720@noisy.programming.kicks-ass.net>

Hello,

On Thu, Sep 25, 2025 at 10:35:33AM +0200, Peter Zijlstra wrote:
> > sched_ext is an oddball in that it may want to hot-migrate tasks at the last
> > minute because who knows what the BPF side wants to do. However, this just
> > boils down to having to always call balance() before any pick_task()
> > attempts (including DL server case). Yeah, it's a niggle, especially as
> > there needs to be a secondary hook to handle losing the race between
> > balance() and pick_task(), but it's pretty contained conceptually and not a
> > lot of code.
> 
> Status quo isn't sufficient; there is that guy that wants to fix some RT
> interaction, and there is that dl_server series.

Can you point me to the RT interaction issue?

Just for context, from sched_ext side, the two pending issues are:

- An extra hook after the next task to run is picked regardless of sched
  class to fix ops.cpu_acquire/release().

- Invoking sched_ext's balance() if its DL server is going to run. This will
  be the same place as the balance() calling for pick_task() and it
  shouldn't be too difficult to package them together so that they're a bit
  less crufty.

Both can be addressed in a neater way if we can pick_task() atomically, and
that will likely make other things easier too. However, it also isn't like
the benefits are overwhelming depending on how the overall tradeoff comes
out to be.

> The only viable option other than overhauling the locking, is pushing rf
> into pick_task() and have that do all the lock dancing. This gets rid of
> that balance abuse (which is needed for dl_server) and also allows
> fixing that rt thing.
> 
> It just makes a giant mess of pick_task_scx() which might have to drop
> locks and retry/abort -- which you weren't very keen on, but yeah, it
> should work.

It does feel really fragile tho. Introducing an extra inner locking layer
makes sense to me. I feel nervous about interlocking around dynamic lock
pointer. It feels too easy to make subtle mistakes in terms of update and
visibility rules. It seems too smart to me. I'd much prefer it to be a bit
dumber.

> As to letting BPF do wild experiments; that's fine of course, but not
> exposing the actual locking requirements is like denying reality. You
> can't do lock-break in pick_task_scx() and then claim lockless or
> advanced locking -- that's just not true.
> 
> Also, you cannot claim bpf-sched author is clever enough to implement
> advanced locking, but then somehow not clever enough to deal with a
> simple interface to express locking to the core code. That feels
> disingenuous.

It's not about cleverness but more about the gap between the two execution
environments. For example, the following is pure BPF spinlock implementation
that some started using:

 https://github.com/sched-ext/scx/blob/main/scheds/include/scx/bpf_arena_spin_lock.h

Kernel isn't involved in any way. It's BPF code doing atomic ops, managing
waiters and also giving up if reasonable forward progress can't be made.
It's all on BPF arena memory, which is not only readable but also writable
from userspace too. All of this is completely opaque to the kernel. It is
all safe from BPF side, but I don't see how we could interlock with
something like this from kernel side, and we do want BPF to be able to do
things like this.

> For all the DSQ based schedulers, this new locking really is an
> improvement, but if you don't want to constrain bpf-sched authors to
> reality, then perhaps only do the lock break dance for them?

Yes, I was on a similar train of thought. The only reasonable way that I can
think of for solving this for BPF managed tasks is giving each task its own
inner sched lock, which makes sense as all sched operations (except for
things like watchdog) are per-task and we don't really need wider scope
locking.

So, let's say we do that for BPF tasks. Then, why not do the same thing for
DSQ tasks too? It will provide all the necessary synchronization guarantees.
The only downside for tasks on DSQ is that we'll grab one more lock instead
of piggy-backing on the DSQ locks. However, going back to my queasiness
about dynamic lock pointers, I'd rather go for the dumber thing even if it's
slightly less efficient and I'm really doubtful that we'd notice the extra
lock overhead in any practical way.

Thank you.

-- 
tejun


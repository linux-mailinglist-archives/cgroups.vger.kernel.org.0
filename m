Return-Path: <cgroups+bounces-10458-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C1FBA10ED
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 20:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65E946C067E
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 18:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEF231A576;
	Thu, 25 Sep 2025 18:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Glyl2FJF"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1937A944;
	Thu, 25 Sep 2025 18:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758825888; cv=none; b=HyYIQGspnKrKLrm1aGgxnkFYBAyC4/pVW9Rdd4we31xV82brujwWZQiv7XmY+ZvHC+iGrFxaskZzP3x1MHtVEr8T1Z47dxrwpGrdnzHxUjc8yHK0/C7t/PzgAMWWMM8tBeYeO7vsIu+cJGrbw4erhip5YEaCq+5FIW5gvbQDiJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758825888; c=relaxed/simple;
	bh=qJTsFN+NMiecxZ3QgmYLy1DuN17fW0HKCF/cQjGPdMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHLs+S+wqrT2JuSWq6Lgcl2JZ1a36b2PYjvcqDUVPDcadydT1WAw6tX5TlIhFLEsGDuUMuoRXzjhuiOmnCfui+5I8uxanVTAY7ib6jnCmORSYzDMuHorvxYfla1Nl7Ls5tWwAdMHa0z9NFCzBasrqsTf263Al43AAJCFH/bOIys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Glyl2FJF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1974AC4CEF0;
	Thu, 25 Sep 2025 18:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758825888;
	bh=qJTsFN+NMiecxZ3QgmYLy1DuN17fW0HKCF/cQjGPdMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Glyl2FJFzOw0GOQFMgT2fWb9WOe7WSotw2ecFWejyCFjSoQs50JlF44DcSk9AEoat
	 W/k/2rtjcXl1HFx0QdTVW0MCWAENrI+ZVYXaZfwPXSQTub7jZCWTXrRCUKjdAlF4dr
	 TXNTJdbc2d3rrfL8N2CAoClTcUYtxnUycvn/ga7y2CGJeb+5Uq08lW0QncbEVRXYBp
	 gTdux8/qf22YzYs+y+T74DFzPfzcQRd/nw4z4ihJRgIwCCafrvY70QQQCbgdQF0UJm
	 L/pUvNukrbYVZmeQdG3EP2CAhO49DejeTsMjAkhuqEGNQkBnAyekeQWaYe0x4mlK3x
	 uOHTxuFfNWX1A==
Date: Thu, 25 Sep 2025 08:44:47 -1000
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
Message-ID: <aNWNn4qj3UYmL0Q_@slm.duckdns.org>
References: <20250910154409.446470175@infradead.org>
 <20250910155809.800554594@infradead.org>
 <aMItk3c5H6Z2CD4X@slm.duckdns.org>
 <20250911094240.GW3289052@noisy.programming.kicks-ass.net>
 <aMMzpnyx__ZgZGRc@slm.duckdns.org>
 <20250912141904.GA3289052@noisy.programming.kicks-ass.net>
 <aMRLIEtmcWc0XNmg@slm.duckdns.org>
 <20250925131025.GA4067720@noisy.programming.kicks-ass.net>
 <aNVia1u-GVByUJtC@slm.duckdns.org>
 <20250925155323.GB4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925155323.GB4067720@noisy.programming.kicks-ass.net>

Hello,

On Thu, Sep 25, 2025 at 05:53:23PM +0200, Peter Zijlstra wrote:
> > CPUs can go on and offline while CPUs are being bypassed. We can handle that
> > in hotplug ops but I'm not sure the complexity is justified in this case.
> 
> Well, not in the current code, since the CPU running this has IRQs and
> preemption disabled (per bypass_lock) and thus stop_machine, as used in
> hotplug can't make progress.
> 
> That is; disabling preemption serializes against hotplug. This is
> something that the scheduler relies on in quite a few places.

Oh, I meant something like:

                                                        CPU X goes down

        scx_bypass(true);

        stuff happening in bypass mode.
        tasks are scheduling, sleeping and              CPU X comes up
        everything.

        scx_bypass(false);

When CPU X comes up, it should come up in bypass mode, which can easily be
done in online callback, but it's just a bit simpler to keep them always in
sync.

> > This is significantly more expensive. On large systems, the number of
> > threads can easily reach six digits. Iterating all of them while doing
> > locking ops on each of them might become problematic depending on what the
> > rest of the system is doing (unfortunately, it's not too difficult to cause
> > meltdowns on some NUMA systems with cross-node traffic). I don't think
> > p->tasks iterations can be broken up either.
> 
> I thought to have understood that bypass isn't something that happens
> when the system is happy. As long as it completes at some point all this
> should be fine right?
> 
> I mean, yeah, it'll take a while, but meh.
> 
> Also, we could run the thing at fair or FIFO-1 or something, to be
> outside of ext itself. Possibly we can freeze all the ext tasks on
> return to user to limit the amount of noise they generate.

One problem scenario that we saw with sapphire rapids multi socket machines
is that when there are a lot of cross-socket locking operations (same locks
getting hammered on from two sockets), forward progress slows down to the
point where hard lockup triggers really easily. We saw two problems in such
scenarios - the total throughput of locking operations was low and the
distribution of successes across CPUs was pretty skewed. Combining the two
factors, the slowest CPU on sapphire rapids ran about two orders of
magnitude slower than a similarly sized AMD machine doing the smae thing.
The benchmark became a part of stress-ng, the --flipflop.

Anyways, what this comes down to is that on some machines, scx_bypass(true)
has to be pretty careful to avoid these hard lockup scenarios as that's
what's expected to recover the system when such situations develop.

> > The change guard cleanups make sense
> > regardless of how the rest develops. Would it make sense to land them first?
> > Once we know what to do with the core scheduling locking, I'm sure we can
> > find a way to make this work accordingly.
> 
> Yeah, definitely. Thing is, if we can get all sched_change users to be
> the same, that all cleans up better.
> 
> But if cleaning this up gets to be too vexing, we can postpone that.

Yeah, I think it's just going to be a bit more involved and it'd be easier
if we don't make it block other stuff.

Thanks.

-- 
tejun


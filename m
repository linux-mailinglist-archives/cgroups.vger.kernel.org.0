Return-Path: <cgroups+bounces-8163-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AABAAAB5407
	for <lists+cgroups@lfdr.de>; Tue, 13 May 2025 13:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 385A91881723
	for <lists+cgroups@lfdr.de>; Tue, 13 May 2025 11:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F96028D8DF;
	Tue, 13 May 2025 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u+zoIWHe"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A139C28851A;
	Tue, 13 May 2025 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747136499; cv=none; b=S5MNcsDX7iufJyQ6LbGw6KuZ/0l0pIgXcW1c4a2PIvzSthT+910LOkSR3u8r440QXmRLyOCpP5gFW78TpkgHyV9LqoEWiw9t3B+FLofz2LD9Yg/F4fys+GoJGfAMRZPogxu0U06fHSzEZWXPrxNQ9yIIwfy9eUwBtOMcZC0VlOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747136499; c=relaxed/simple;
	bh=uFX2rO3cWJmwi6vvHQkw3PfdS9uLgLh/X0Ve8XYCvpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmRroCf4CMqNZ9Y9NrkGSAslFobnmcY2Wwpu9gQ3FL9zcJA8nE171mdzUfQxCCmB35OLGvUSLPS7ECYij/HRxZ8CRzf/1JQ8gz+3WQa5zwzYJkPOYw3JnN/rRiwWHM4HVtSjkAeYOK6x2rJiWZbNeqJmcnALKsJMB9z0pA9Mhv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=u+zoIWHe; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BLCbEb2NTTzv4/ODVyjqYAPhHDxBZDeZKEtBF7viCvw=; b=u+zoIWHef6JFSMGtTvvxGch/iJ
	awCg/a3tBJSi76YIT0JHmabu6gBZHE7JjSzk5Qvmnfm59gMkRP7Lo0ZTpQEPeDijYGq10YWfM7onf
	IFSBjnUnhDQbdr+dld3GHJB3G/OiA5UQD8uUwLjwfB1E8gXVDaVFZUc/iIo4bkYI/f4ezMiYW4BXh
	aGzQ3SocmH5QgN5qnFGoZdjDtZnbbs82Gi845Bghn0Fiwa/BVdoCA9RfXBparJWErWzNgmq5NCmFr
	PVzj+37HcJq3ak06M7Qyn35+jMadKBfgIr6GGvPg9DJV6b9pYRAZdpCjxsFLmmT9sSpcz8YDSgRuu
	NfKBM76g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEo0k-0000000ArbM-31WB;
	Tue, 13 May 2025 11:41:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2ABD930066A; Tue, 13 May 2025 13:41:26 +0200 (CEST)
Date: Tue, 13 May 2025 13:41:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 0/4] memcg: nmi-safe kmem charging
Message-ID: <20250513114125.GE25763@noisy.programming.kicks-ass.net>
References: <20250509232859.657525-1-shakeel.butt@linux.dev>
 <2e2f0568-3687-4574-836d-c23d09614bce@suse.cz>
 <mzrsx4x5xluljyxy5h5ha6kijcno3ormac3sobc3k7bkj5wepr@cuz2fluc5m5d>
 <07e4e8d9-2588-41bf-89d4-328ca6afd263@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07e4e8d9-2588-41bf-89d4-328ca6afd263@suse.cz>

On Tue, May 13, 2025 at 09:15:23AM +0200, Vlastimil Babka wrote:

> >> > The initial prototype tried to make memcg charging infra for kernel
> >> > memory re-entrant against irq and nmi. However upon realizing that
> >> > this_cpu_* operations are not safe on all architectures (Tejun), this
> >> 
> >> I assume it was an off-list discussion?
> >> Could we avoid this for the architectures where these are safe, which should
> >> be the major ones I hope?

IIRC Power64 has issues here, 'funnily' their local_t is NMI safe.
Perhaps we could do the same for their this_cpu_*(), but ideally someone
with actual power hardware should do this ;-)

> > Yes it was an off-list discussion. The discussion was more about the
> > this_cpu_* ops vs atomic_* ops as on x86 this_cpu_* does not have lock
> > prefix and how I should prefer this_cpu_* over atomic_* for my series on
> > objcg charging without disabling irqs. Tejun pointed out this_cpu_* are
> > not nmi safe for some archs and it would be better to handle nmi context
> > separately. So, I am not that worried about optimizing for NMI context
> 
> Well, we're introducing in_nmi() check and different execution paths to all
> charging. This could be e.g. compiled out for architectures where this_cpu*
> is NMI safe or they don't have NMIs in the first place.

Very few architectures one would care about do not have NMIs. Risc-V
seems to be the exception here ?!?

> > but your next comment on generic_atomic64_* ops is giving me headache.
> > 
> >> 
> >> > series took a different approach targeting only nmi context. Since the
> >> > number of stats that are updated in kernel memory charging path are 3,
> >> > this series added special handling of those stats in nmi context rather
> >> > than making all >100 memcg stats nmi safe.
> >> 
> >> Hmm so from patches 2 and 3 I see this relies on atomic64_add().
> >> But AFAIU lib/atomic64.c has the generic fallback implementation for
> >> architectures that don't know better, and that would be using the "void
> >> generic_atomic64_##op" macro, which AFAICS is doing:
> >> 
> >>         local_irq_save(flags);                                          \
> >>         arch_spin_lock(lock);                                           \
> >>         v->counter c_op a;                                              \
> >>         arch_spin_unlock(lock);                                         \
> >>         local_irq_restore(flags);                                       \
> >> 
> >> so in case of a nmi hitting after the spin_lock this can still deadlock?
> >> 
> >> Hm or is there some assumption that we only use these paths when already
> >> in_nmi() and then another nmi can't come in that context?
> >> 
> >> But even then, flush_nmi_stats() in patch 1 isn't done in_nmi() and uses
> >> atomic64_xchg() which in generic_atomic64_xchg() implementation also has the
> >> irq_save+spin_lock. So can't we deadlock there?
> > 
> > I was actually assuming that atomic_* ops are safe against nmis for all
> > archs.

We have HAVE_NMI_SAFE_CMPXCHG for this -- there are architectures where
this is not the case -- but again, those are typically oddball archs you
don't much care about.

But yes, *64 on 32bit archs is generally not NMI safe.

> I looked at atomic_* ops in include/asm-generic/atomic.h and it
> > is using arch_cmpxchg() for CONFIG_SMP and it seems like for archs with
> > cmpxchg should be fine against nmi. I am not sure why atomic64_* are not
> > using arch_cmpxchg() instead. I will dig more.

Not many 32bit architectures have 64bit cmpxchg. We're only now dropping
support for x86 chips without CMPXCHG8b.

> Yeah I've found https://docs.kernel.org/core-api/local_ops.html and since it
> listed Mathieu we discussed on IRC and he mentioned the same thing that
> atomic_ ops are fine, but the later added 64bit variant isn't, which PeterZ
> (who added it) acknowledged.
> 
> But there could be way out if we could somehow compile-time assert that
> either is true:
> - CONFIG_HAVE_NMI=n - we can compile out all the nmi code

Note that in_nmi() is not depending on HAVE_NMI -- nor can it be. Many
architectures treat various traps as NMI-like, even though they might
not have real NMIs.

> - this_cpu is safe on that arch - we can also compile out the nmi code

There is no config symbol for this presently.

> - (if the above leaves any 64bit arch) its 64bit atomics implementation is safe

True, only because HPPA does not in fact have NMIs.

> - (if there are any 32bit applicable arch left) 32bit atomics should be
> enough for the nmi counters even with >4GB memory as we flush them? and we
> know the 32bit ops are safe

Older ARM might qualify here.


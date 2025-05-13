Return-Path: <cgroups+bounces-8171-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83951AB5F33
	for <lists+cgroups@lfdr.de>; Wed, 14 May 2025 00:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F5F9467FB4
	for <lists+cgroups@lfdr.de>; Tue, 13 May 2025 22:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A6820B215;
	Tue, 13 May 2025 22:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wx9K/XDN"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7151F03D9;
	Tue, 13 May 2025 22:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747174633; cv=none; b=ZsAM248C3OY+56z/IK3xnht1rWLfHxzOXo0VoqgI9yszB8Xgw3+zTRZp31WFf9Ef2VPxDyo9izneS7G6Fx+LtyrhWz2CSckxLN4Wl8lNtF5GdWirUchf+3FmUcEF2FARJy2TvuvY1lTVYhOahqCObKRvt3SLcGHGGSXFOM0wbKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747174633; c=relaxed/simple;
	bh=yNLqlPWASut9p1xEAFv4YgaFRmFtpdfW1XyDhbCPf5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nj5M4QkMFEAOPSUlLwbgPic1s8/F3v8tpmQiv/ApaMAIR0baEX3BSDP/+b9l8KlBh0kmOlIZVXOY1drv+9tQwZmub3oVV4P78LATqTBowfmpBFrLDHhfpm/vOyw8UYvbFszoLkTDcT2lNAXHzJMvuMUPxRoeAvcU8NHDkfTN/8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wx9K/XDN; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 13 May 2025 15:17:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747174626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rahQYu1hjcaoMkOQ2Z62DrFUneDFZMeqj32rynYl3Ak=;
	b=wx9K/XDNsqu6pyfaRN9KPelr685TgwkIZ1xr5mFHW+x3b9xZQLu1VZrf/0N2qg1XVpfB9O
	0Hf3zWfQM3ZlD4p5dlaRY6pGJFUrKBK+9vQaQJjTOPRT8PivyYeNxB1GUui0ARnNei+Os6
	I8+Ybr+04GBOUr87R0gPSswu14rvZx4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 0/4] memcg: nmi-safe kmem charging
Message-ID: <ct2h2eyuepa2g2ltl5fucfegwyuqspvz6d4uugcs4szxwnggdc@6m4ks3hp3tjj>
References: <20250509232859.657525-1-shakeel.butt@linux.dev>
 <2e2f0568-3687-4574-836d-c23d09614bce@suse.cz>
 <mzrsx4x5xluljyxy5h5ha6kijcno3ormac3sobc3k7bkj5wepr@cuz2fluc5m5d>
 <07e4e8d9-2588-41bf-89d4-328ca6afd263@suse.cz>
 <20250513114125.GE25763@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513114125.GE25763@noisy.programming.kicks-ass.net>
X-Migadu-Flow: FLOW_OUT

On Tue, May 13, 2025 at 01:41:25PM +0200, Peter Zijlstra wrote:
> On Tue, May 13, 2025 at 09:15:23AM +0200, Vlastimil Babka wrote:
> 
> > >> > The initial prototype tried to make memcg charging infra for kernel
> > >> > memory re-entrant against irq and nmi. However upon realizing that
> > >> > this_cpu_* operations are not safe on all architectures (Tejun), this
> > >> 
> > >> I assume it was an off-list discussion?
> > >> Could we avoid this for the architectures where these are safe, which should
> > >> be the major ones I hope?
> 
> IIRC Power64 has issues here, 'funnily' their local_t is NMI safe.
> Perhaps we could do the same for their this_cpu_*(), but ideally someone
> with actual power hardware should do this ;-)
> 

Is CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS the right config to
differentiate between such archs? I see Power64 does not have that
enabled.

> > > Yes it was an off-list discussion. The discussion was more about the
> > > this_cpu_* ops vs atomic_* ops as on x86 this_cpu_* does not have lock
> > > prefix and how I should prefer this_cpu_* over atomic_* for my series on
> > > objcg charging without disabling irqs. Tejun pointed out this_cpu_* are
> > > not nmi safe for some archs and it would be better to handle nmi context
> > > separately. So, I am not that worried about optimizing for NMI context
> > 
> > Well, we're introducing in_nmi() check and different execution paths to all
> > charging. This could be e.g. compiled out for architectures where this_cpu*
> > is NMI safe or they don't have NMIs in the first place.
> 
> Very few architectures one would care about do not have NMIs. Risc-V
> seems to be the exception here ?!?
> 
> > > but your next comment on generic_atomic64_* ops is giving me headache.
> > > 
> > >> 
> > >> > series took a different approach targeting only nmi context. Since the
> > >> > number of stats that are updated in kernel memory charging path are 3,
> > >> > this series added special handling of those stats in nmi context rather
> > >> > than making all >100 memcg stats nmi safe.
> > >> 
> > >> Hmm so from patches 2 and 3 I see this relies on atomic64_add().
> > >> But AFAIU lib/atomic64.c has the generic fallback implementation for
> > >> architectures that don't know better, and that would be using the "void
> > >> generic_atomic64_##op" macro, which AFAICS is doing:
> > >> 
> > >>         local_irq_save(flags);                                          \
> > >>         arch_spin_lock(lock);                                           \
> > >>         v->counter c_op a;                                              \
> > >>         arch_spin_unlock(lock);                                         \
> > >>         local_irq_restore(flags);                                       \
> > >> 
> > >> so in case of a nmi hitting after the spin_lock this can still deadlock?
> > >> 
> > >> Hm or is there some assumption that we only use these paths when already
> > >> in_nmi() and then another nmi can't come in that context?
> > >> 
> > >> But even then, flush_nmi_stats() in patch 1 isn't done in_nmi() and uses
> > >> atomic64_xchg() which in generic_atomic64_xchg() implementation also has the
> > >> irq_save+spin_lock. So can't we deadlock there?
> > > 
> > > I was actually assuming that atomic_* ops are safe against nmis for all
> > > archs.
> 
> We have HAVE_NMI_SAFE_CMPXCHG for this -- there are architectures where
> this is not the case -- but again, those are typically oddball archs you
> don't much care about.
> 
> But yes, *64 on 32bit archs is generally not NMI safe.
> 
> > I looked at atomic_* ops in include/asm-generic/atomic.h and it
> > > is using arch_cmpxchg() for CONFIG_SMP and it seems like for archs with
> > > cmpxchg should be fine against nmi. I am not sure why atomic64_* are not
> > > using arch_cmpxchg() instead. I will dig more.
> 
> Not many 32bit architectures have 64bit cmpxchg. We're only now dropping
> support for x86 chips without CMPXCHG8b.
> 

As Vlastimil pointed out (last point), I don't think I will need 64bit
cmpxchg, 32bit cmpxchg will be fine.

> > Yeah I've found https://docs.kernel.org/core-api/local_ops.html and since it
> > listed Mathieu we discussed on IRC and he mentioned the same thing that
> > atomic_ ops are fine, but the later added 64bit variant isn't, which PeterZ
> > (who added it) acknowledged.
> > 
> > But there could be way out if we could somehow compile-time assert that
> > either is true:
> > - CONFIG_HAVE_NMI=n - we can compile out all the nmi code
> 
> Note that in_nmi() is not depending on HAVE_NMI -- nor can it be. Many
> architectures treat various traps as NMI-like, even though they might
> not have real NMIs.
> 
> > - this_cpu is safe on that arch - we can also compile out the nmi code
> 
> There is no config symbol for this presently.

Hmm what about CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS?

> 
> > - (if the above leaves any 64bit arch) its 64bit atomics implementation is safe
> 
> True, only because HPPA does not in fact have NMIs.

What is HPPA?

> 
> > - (if there are any 32bit applicable arch left) 32bit atomics should be
> > enough for the nmi counters even with >4GB memory as we flush them? and we
> > know the 32bit ops are safe
> 
> Older ARM might qualify here.

Thanks a lot Vlastimil & Peter for the suggestions. Let me summarize
what I plan to do and please point out if I am doing something wrong:


#if defined(CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS) || !defined(CONFIG_HAVE_NMI)

// Do normal this_cpu* ops

#elif defined(ARCH_HAVE_NMI_SAFE_CMPXCHG)

// Do 32 bit atomic ops with in_nmi() checks

#else

// Build error or ignore nmi stats??

#endif


WDYT?

(BTW Vlastimil, I might rebase send out the irq-safe series before this
nmi one.)

thanks,
Shakeel


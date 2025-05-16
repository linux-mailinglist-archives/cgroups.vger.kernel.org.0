Return-Path: <cgroups+bounces-8235-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1386ABA001
	for <lists+cgroups@lfdr.de>; Fri, 16 May 2025 17:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FD547B89DB
	for <lists+cgroups@lfdr.de>; Fri, 16 May 2025 15:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE37E1BF33F;
	Fri, 16 May 2025 15:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zi62pArT"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18DD149C64;
	Fri, 16 May 2025 15:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747409854; cv=none; b=DC2oajlcwdGnDGwHqjGyryOus2xpNenfMYUOlXEXtT2Twg0f6BoKGuW/bApPvBzY2+eBuy4HcECOuIsh0X0K9jo6JQv4wt7ZX44dSwg6cML9eECDqBFxg3GMCaBuBeI7p36+RHLQKzbqSZv6ka1lS+jDWT2q3+IogdKTvUZmRh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747409854; c=relaxed/simple;
	bh=HtWde3TpgiWAD605YmTLF4fS54hGTe1sdeYFh/LhoE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxTU+QVup5OQQ6e179QXjROgZM+LzFL1xhBKRJYj3dbkrNVdMCzwwUMUyBFCuAg1kwBtXNWzwivVgtnM32o+d8J308uQN1BXqORiIoVhmNvVw2MslfBf2CXITV9/IrCwQHOGAu1t/rnHz504PyCM5fAI7IaY+fpRzPZxg22qMm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zi62pArT; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 16 May 2025 08:37:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747409850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GUmB6MysdwfVDrB19QMncGfwBZNU3SIATJ4OxtHukM8=;
	b=Zi62pArTD9nQONyMVoTOTkWzLtXfSpFp1vYJssLs+SioqtfVLUfCo5UPKpokDCEIRHJ7V7
	MkjHQSHV01HKIeXg6u3ofnddU32/7s5zv5PrTQE4G2sgZBxxA3wxVfw3XPyZCJncMHcPwF
	67ljLHnnIhccyilTXh9PP/QLo7HiSOQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 1/5] memcg: disable kmem charging in nmi for unsupported
 arch
Message-ID: <ukn75zvkgbyjmrhmy7rmt6dx24r47vy6npfdvjx6wxiduxeqnm@kkjoam7gft4v>
References: <20250516064912.1515065-1-shakeel.butt@linux.dev>
 <20250516064912.1515065-2-shakeel.butt@linux.dev>
 <050484a9-c08c-40d2-b431-76903a639222@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <050484a9-c08c-40d2-b431-76903a639222@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Fri, May 16, 2025 at 11:30:17AM +0200, Vlastimil Babka wrote:
> On 5/16/25 08:49, Shakeel Butt wrote:
> > The memcg accounting and stats uses this_cpu* and atomic* ops. There are
> > archs which define CONFIG_HAVE_NMI but does not define
> > CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS and ARCH_HAVE_NMI_SAFE_CMPXCHG, so
> > memcg accounting for such archs in nmi context is not possible to
> > support. Let's just disable memcg accounting in nmi context for such
> > archs.
> > 
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > ---
> >  include/linux/memcontrol.h |  5 +++++
> >  mm/memcontrol.c            | 15 +++++++++++++++
> >  2 files changed, 20 insertions(+)
> > 
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index f7848f73f41c..53920528821f 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -62,6 +62,11 @@ struct mem_cgroup_reclaim_cookie {
> >  
> >  #ifdef CONFIG_MEMCG
> >  
> > +#if defined(CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS) || \
> > +	!defined(CONFIG_HAVE_NMI) || defined(ARCH_HAVE_NMI_SAFE_CMPXCHG)
> > +#define MEMCG_SUPPORTS_NMI_CHARGING
> > +#endif
> > +
> >  #define MEM_CGROUP_ID_SHIFT	16
> >  
> >  struct mem_cgroup_id {
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index e17b698f6243..dface07f69bb 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -2647,11 +2647,26 @@ static struct obj_cgroup *current_objcg_update(void)
> >  	return objcg;
> >  }
> >  
> > +#ifdef MEMCG_SUPPORTS_NMI_CHARGING
> > +static inline bool nmi_charging_allowed(void)
> > +{
> > +	return true;
> > +}
> > +#else
> > +static inline bool nmi_charging_allowed(void)
> > +{
> > +	return false;
> > +}
> > +#endif
> > +
> >  __always_inline struct obj_cgroup *current_obj_cgroup(void)
> >  {
> >  	struct mem_cgroup *memcg;
> >  	struct obj_cgroup *objcg;
> >  
> > +	if (in_nmi() && !nmi_charging_allowed())
> 
> Exchange the two as the latter is compile-time constant, so it can shortcut
> the in_nmi() check away in all the good cases?
> 

Oh I thought compiler would figure that out but now that I think about
it, it can only do so if the first condition does not have any
side-effects and though in_nmi() does not, I am not sure if compiler can
extract that information.

I will fix this and make sure that compiler is doing the right thing.


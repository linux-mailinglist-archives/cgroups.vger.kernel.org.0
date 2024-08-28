Return-Path: <cgroups+bounces-4546-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E966C963197
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 22:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 278611C21EA4
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 20:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA0E1AC44D;
	Wed, 28 Aug 2024 20:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UA8NPRLH"
X-Original-To: cgroups@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D594B1ABED1
	for <cgroups@vger.kernel.org>; Wed, 28 Aug 2024 20:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724876188; cv=none; b=IxGKtln047wgjB/axRWEkkgN9HGqUf3PiuIj0s6gjXgHFfWsaQnrDtxEmc/oCI1g8dnUT/KJuSrQo19/EpEFI8/dNLGkn6YN81ilQSv6672owYy01+K+9CXQx8AxG8tVBwUvYczEokfR2TezridBpNknVD6MgOQ2P4khx7PZiA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724876188; c=relaxed/simple;
	bh=az5JLCJKZVd7MrP8d/pxlwJo5FDQJdNjsMiec+ZSnEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcgApaVnWalaYZ8CJHeN6FDzBrwOVu+/51y9TS+/obvghS+DSCwBkxqyLtzCe2AH4cqAienJwJ1EZcZYLEYj/bM+FCSVGDl2EDpbfZ+9rEcNJAnXKsaLLEGW/y98w9m8eU/1PdlsnsLQYGE6vaLuBNXLUmbA7F0TPpWXiDqHFek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UA8NPRLH; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 28 Aug 2024 13:16:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724876183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TcFJMtnoZx/3smatfAG72v8CqCQxeneyOqoZqcBXEJ4=;
	b=UA8NPRLHJk8sJ2BgEWshSbomfpPfoUBD1kFcgir+M5ur3KcuRfOPjB7A2f2BlRBseINxqv
	HhHMR6llKGwdYydRhGqyBns7E2u9qHvc/4pRMbhiEmxIwHvQJA4leZgR+BGuxL9hhusIOD
	4baQO6VbhPbCE3d6lu4DwEUEd1ErM1U=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2] memcg: add charging of already allocated slab objects
Message-ID: <zjvmhbfzxpv4ujc5v7c4aojpsecmaqrznyd34lukst57kx5h43@2necqcieafy5>
References: <20240827235228.1591842-1-shakeel.butt@linux.dev>
 <CAJD7tkawaUoTBQLW1tUfFc06uBacjJH7d6iUFE+fzM5+jgOBig@mail.gmail.com>
 <pq2zzjvxxzxcqtnf2eabp3whooysr7qbh75ts6fyzhipmtxjwf@q2jw57d5qkir>
 <CAJD7tka_OKPisXGDO56WMb6sRnYxHe2UDAh14d6VX1BW2E3usA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tka_OKPisXGDO56WMb6sRnYxHe2UDAh14d6VX1BW2E3usA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 28, 2024 at 12:42:02PM GMT, Yosry Ahmed wrote:
> On Wed, Aug 28, 2024 at 12:14 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Tue, Aug 27, 2024 at 05:34:24PM GMT, Yosry Ahmed wrote:
> > > On Tue, Aug 27, 2024 at 4:52 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > [...]
> > > > +
> > > > +#define KMALLOC_TYPE (SLAB_KMALLOC | SLAB_CACHE_DMA | \
> > > > +                     SLAB_ACCOUNT | SLAB_RECLAIM_ACCOUNT)
> > > > +
> > > > +static __fastpath_inline
> > > > +bool memcg_slab_post_charge(void *p, gfp_t flags)
> > > > +{
> > > > +       struct slabobj_ext *slab_exts;
> > > > +       struct kmem_cache *s;
> > > > +       struct folio *folio;
> > > > +       struct slab *slab;
> > > > +       unsigned long off;
> > > > +
> > > > +       folio = virt_to_folio(p);
> > > > +       if (!folio_test_slab(folio)) {
> > > > +               return __memcg_kmem_charge_page(folio_page(folio, 0), flags,
> > > > +                                               folio_order(folio)) == 0;
> > >
> > > Will this charge the folio again if it was already charged? It seems
> > > like we avoid this for already charged slab objects below but not
> > > here.
> > >
> >
> > Thanks for catchig this. It's an easy fix and will do in v3.
> >
> > > > +       }
> > > > +
> > > > +       slab = folio_slab(folio);
> > > > +       s = slab->slab_cache;
> > > > +
> > > > +       /* Ignore KMALLOC_NORMAL cache to avoid circular dependency. */
> > > > +       if ((s->flags & KMALLOC_TYPE) == SLAB_KMALLOC)
> > > > +               return true;
> > >
> > > Would it be clearer to check if the slab cache is one of
> > > kmalloc_caches[KMALLOC_NORMAL]? This should be doable by comparing the
> > > address of the slab cache with the addresses of
> > > kmalloc_cache[KMALLOC_NORMAL] (perhaps in a helper). I need to refer
> > > to your reply to Roman to understand why this works.
> > >
> >
> > Do you mean looping over kmalloc_caches[KMALLOC_NORMAL] and comparing
> > the given slab cache address? Nah man why do long loop of pointer
> > comparisons when we can simply check the flag of the given kmem cache.
> > Also this array will increase with the recent proposed random kmalloc
> > caches.
> 
> Oh I thought kmalloc_caches[KMALLOC_NORMAL] is an array of the actual
> struct kmem_cache objects, so I thought we can just check if:
> s >= kmalloc_caches[KMALLOC_NORMAL][0] &&
> s >= kmalloc_caches[KMALLOC_NORMAL][LAST_INDEX]
> 
> I just realized it's an array of pointers, so we would need to loop
> and compare them.
> 
> I still find the flags comparisons unclear and not very future-proof
> tbh. I think we can just store the type in struct kmem_cache? I think
> there are multiple holes there.

Do you mean adding a new SLAB_KMALLOC_NORMAL? I will wait for SLAB
maintainers for their opinion on that. BTW this kind of checks are in
the kernel particularly for gfp flags.


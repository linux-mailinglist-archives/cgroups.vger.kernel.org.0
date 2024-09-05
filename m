Return-Path: <cgroups+bounces-4723-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B98596E23A
	for <lists+cgroups@lfdr.de>; Thu,  5 Sep 2024 20:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B46AC1F26ED4
	for <lists+cgroups@lfdr.de>; Thu,  5 Sep 2024 18:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B3A188A0B;
	Thu,  5 Sep 2024 18:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lHnrRcFs"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386EE183CB7;
	Thu,  5 Sep 2024 18:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725562108; cv=none; b=AkW0zktkzKBjUitrUHqnlmRcFsdR+bFdg/KrwoT+rqfd0I1eFaOgeq1eZv/QDMLmfp4pD8X7rbXXGqDoFy43MQGOub6EWnmnyEitl4oGqLKM6moEesfr6lPDcNUL9VSZ1cXWPhcpZPs/Zb6/CQ4+TMHuYDxDaqaUQmNoGhZlxHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725562108; c=relaxed/simple;
	bh=1QmnQHQRfzIATDtjh91SmiBQjutqyby/XWada8DuMfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDOVdYNsfhr8aFEy4qRJtgkwU9bTFbPbRq01fAikmuhkdoRHQoHPnGQifVsBnPrkxQjwruVY0WYFupgp+KjRR1i8Uv4T32sxeSzv16jvhvvFY7rXOoXlsgF7rRLQwLbCmNKi1nDiaTL5epJnFUKRVwYT5patv8fKHz53vKmcepM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lHnrRcFs; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 5 Sep 2024 11:48:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725562104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DPVvvGxX6KnyYMnY+Bb1uv8l52/JsFo3bCWRW8e8nIU=;
	b=lHnrRcFsdOTKs93Ljwr8n62qkKUbVwQFwQ9rCI9qgw+2lGQY9AtbmVkN0Fc4sCvOfuRVXO
	5upeiVt2jc84iD+ezeTC8bCjuXwJCiSmuZd+H4s1nLj4P7iBbkCjqCeJMzfvU9Nk2//9j3
	1HrOVQiH68x5q4JQKb4mmsW8zr7y3dY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, David Rientjes <rientjes@google.com>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4] memcg: add charging of already allocated slab objects
Message-ID: <qk3437v2as6pz2zxu4uaniqfhpxqd3qzop52zkbxwbnzgssi5v@br2hglnirrgx>
References: <20240905173422.1565480-1-shakeel.butt@linux.dev>
 <CAJD7tkbWLYG7-G9G7MNkcA98gmGDHd3DgS38uF6r5o60H293rQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkbWLYG7-G9G7MNkcA98gmGDHd3DgS38uF6r5o60H293rQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Sep 05, 2024 at 10:48:50AM GMT, Yosry Ahmed wrote:
> On Thu, Sep 5, 2024 at 10:34 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > At the moment, the slab objects are charged to the memcg at the
> > allocation time. However there are cases where slab objects are
> > allocated at the time where the right target memcg to charge it to is
> > not known. One such case is the network sockets for the incoming
> > connection which are allocated in the softirq context.
> >
> > Couple hundred thousand connections are very normal on large loaded
> > server and almost all of those sockets underlying those connections get
> > allocated in the softirq context and thus not charged to any memcg.
> > However later at the accept() time we know the right target memcg to
> > charge. Let's add new API to charge already allocated objects, so we can
> > have better accounting of the memory usage.
> >
> > To measure the performance impact of this change, tcp_crr is used from
> > the neper [1] performance suite. Basically it is a network ping pong
> > test with new connection for each ping pong.
> >
> > The server and the client are run inside 3 level of cgroup hierarchy
> > using the following commands:
> >
> > Server:
> >  $ tcp_crr -6
> >
> > Client:
> >  $ tcp_crr -6 -c -H ${server_ip}
> >
> > If the client and server run on different machines with 50 GBPS NIC,
> > there is no visible impact of the change.
> >
> > For the same machine experiment with v6.11-rc5 as base.
> >
> >           base (throughput)     with-patch
> > tcp_crr   14545 (+- 80)         14463 (+- 56)
> >
> > It seems like the performance impact is within the noise.
> >
> > Link: https://github.com/google/neper [1]
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
> 
> LGTM from an MM perspective with a few nits below. FWIW:
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

Thanks.

> 
> > ---
> > v3: https://lore.kernel.org/all/20240829175339.2424521-1-shakeel.butt@linux.dev/
> > Changes since v3:
> > - Add kernel doc for kmem_cache_charge.
> >
> > v2: https://lore.kernel.org/all/20240827235228.1591842-1-shakeel.butt@linux.dev/
> > Change since v2:
> > - Add handling of already charged large kmalloc objects.
> > - Move the normal kmalloc cache check into a function.
> >
> > v1: https://lore.kernel.org/all/20240826232908.4076417-1-shakeel.butt@linux.dev/
> > Changes since v1:
> > - Correctly handle large allocations which bypass slab
> > - Rearrange code to avoid compilation errors for !CONFIG_MEMCG builds
> >
> > RFC: https://lore.kernel.org/all/20240824010139.1293051-1-shakeel.butt@linux.dev/
> > Changes since the RFC:
> > - Added check for already charged slab objects.
> > - Added performance results from neper's tcp_crr
> >
> >
> >  include/linux/slab.h            | 20 ++++++++++++++
> >  mm/slab.h                       |  7 +++++
> >  mm/slub.c                       | 49 +++++++++++++++++++++++++++++++++
> >  net/ipv4/inet_connection_sock.c |  5 ++--
> >  4 files changed, 79 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index eb2bf4629157..68789c79a530 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -547,6 +547,26 @@ void *kmem_cache_alloc_lru_noprof(struct kmem_cache *s, struct list_lru *lru,
> >                             gfp_t gfpflags) __assume_slab_alignment __malloc;
> >  #define kmem_cache_alloc_lru(...)      alloc_hooks(kmem_cache_alloc_lru_noprof(__VA_ARGS__))
> >
> > +/**
> > + * kmem_cache_charge - memcg charge an already allocated slab memory
> > + * @objp: address of the slab object to memcg charge.
> > + * @gfpflags: describe the allocation context
> > + *
> > + * kmem_cache_charge is the normal method to charge a slab object to the current
> > + * memcg. The objp should be pointer returned by the slab allocator functions
> > + * like kmalloc or kmem_cache_alloc. The memcg charge behavior can be controller
> 
> s/controller/controlled

Thanks. Vlastimil please fix this when you pick this up.

> 
> > + * through gfpflags parameter.
> > + *
> > + * There are several cases where it will return true regardless. More
> > + * specifically:
> > + *
> > + * 1. For !CONFIG_MEMCG or cgroup_disable=memory systems.
> > + * 2. Already charged slab objects.
> > + * 3. For slab objects from KMALLOC_NORMAL caches.
> > + *
> > + * Return: true if charge was successful otherwise false.
> > + */
> > +bool kmem_cache_charge(void *objp, gfp_t gfpflags);
> >  void kmem_cache_free(struct kmem_cache *s, void *objp);
> >
> >  kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
> > diff --git a/mm/slab.h b/mm/slab.h
> > index dcdb56b8e7f5..9f907e930609 100644
> > --- a/mm/slab.h
> > +++ b/mm/slab.h
> > @@ -443,6 +443,13 @@ static inline bool is_kmalloc_cache(struct kmem_cache *s)
> >         return (s->flags & SLAB_KMALLOC);
> >  }
> >
> > +static inline bool is_kmalloc_normal(struct kmem_cache *s)
> > +{
> > +       if (!is_kmalloc_cache(s))
> > +               return false;
> > +       return !(s->flags & (SLAB_CACHE_DMA|SLAB_ACCOUNT|SLAB_RECLAIM_ACCOUNT));
> > +}
> > +
> >  /* Legal flag mask for kmem_cache_create(), for various configurations */
> >  #define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
> >                          SLAB_CACHE_DMA32 | SLAB_PANIC | \
> > diff --git a/mm/slub.c b/mm/slub.c
> > index c9d8a2497fd6..3f2a89f7a23a 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -2185,6 +2185,41 @@ void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
> >
> >         __memcg_slab_free_hook(s, slab, p, objects, obj_exts);
> >  }
> > +
> > +static __fastpath_inline
> > +bool memcg_slab_post_charge(void *p, gfp_t flags)
> > +{
> > +       struct slabobj_ext *slab_exts;
> > +       struct kmem_cache *s;
> > +       struct folio *folio;
> > +       struct slab *slab;
> > +       unsigned long off;
> > +
> > +       folio = virt_to_folio(p);
> > +       if (!folio_test_slab(folio)) {
> > +               return folio_memcg_kmem(folio) ||
> 
> If the folio is charged user memory, we will still double charge here,
> but that would be a bug. We can put a warning in this case or use
> folio_memcg() instead to avoid double charges in that case as well.
>

I don't think we need to do anything for such scenarios similar to how
other kmem function handles them. For example passing user memory to
kfree() will treat it similar to this and there is no warning as well.

> > +                       (__memcg_kmem_charge_page(folio_page(folio, 0), flags,
> > +                                                 folio_order(folio)) == 0);
> > +       }
> > +
> > +       slab = folio_slab(folio);
> > +       s = slab->slab_cache;
> > +
> > +       /* Ignore KMALLOC_NORMAL cache to avoid circular dependency. */
> 
> Is it possible to point to the commit that has the explanation here?
> The one you pointed me to before? Otherwise it's not really obvious
> where the circular dependency comes from (at least to me).
> 

Not sure about the commit reference. We can add more text here.
Vlastimil, how much detail do you prefer?

thanks,
Shakeel


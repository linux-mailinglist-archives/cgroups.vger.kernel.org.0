Return-Path: <cgroups+bounces-4511-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE55196155E
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 19:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E0091F2465E
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 17:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D88C1CFEBF;
	Tue, 27 Aug 2024 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YvWTLJtL"
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5EC1D0493
	for <cgroups@vger.kernel.org>; Tue, 27 Aug 2024 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724779411; cv=none; b=RwXekH2RGENDRK3CMckuVbR6BDuoVPBxYzQi0DbDRw0SrXBxUKUJ/GVWqx57MVBe1gvql0PNqyPD22Lg6kYN9bPe/8FXzHxIbdcwizUBReBmDDAnZizzFXwFhwdjAIj2CT4F+jM1TKoTk8iLIjDUu5vWrNB5C7civnNInYCHi1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724779411; c=relaxed/simple;
	bh=Iji74/Wur76Mg7NWFmNWWqnZThszaMsOGQyBMjnZc5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKTWGWBlKP5smSTR53G6gE2JKBTFl3VtdpNNfAbluutdEIky+sG6rOymwPpvK/q/D3eTdVpuwt78V9eqFTw6g6quI3H77O4AVDDGEn/sUvFDmjign5cuydgPQpP1+hMmLmN2t53eXg4QJmaajn0+R8rPTVv0l0nc+gXAR9ve8Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YvWTLJtL; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 27 Aug 2024 10:23:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724779406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s209v91OTMRFYwS0/Qp960kr7E7Ft0gsEXkxY27YQEU=;
	b=YvWTLJtLK1YggX2faAdZy2v+USXGrnbEA6Xjwmfmx1gu+DWMbR2eHihrA7ZpHciQwuiyva
	IgF1rcqMnw0zJqNMR9YHAFeCz0MrSqt01cRD0SxlCKJKCygTtf6Y60J3DRq226hEC54jQP
	3XS8p0GAU2wYXbeHHCo0jOulpGF3oNI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Vlastimil Babka <vbabka@suse.cz>, 
	David Rientjes <rientjes@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v1] memcg: add charging of already allocated slab objects
Message-ID: <yiyx4fh6dklqpexfstkzp3gf23hjpbjujci2o6gs7nb4sutzvb@b5korjrjio3m>
References: <20240826232908.4076417-1-shakeel.butt@linux.dev>
 <Zs1CuLa-SE88jRVx@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs1CuLa-SE88jRVx@google.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 27, 2024 at 03:06:32AM GMT, Roman Gushchin wrote:
> On Mon, Aug 26, 2024 at 04:29:08PM -0700, Shakeel Butt wrote:
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
> 
> Hi Shakeel,
> 
> I like the idea and performance numbers look good. However some comments on
> the implementation:
> 

Thanks for taking a look.

> > ---
> > 
> > Changes since the RFC:
> > - Added check for already charged slab objects.
> > - Added performance results from neper's tcp_crr
> > 
> >  include/linux/slab.h            |  1 +
> >  mm/slub.c                       | 54 +++++++++++++++++++++++++++++++++
> >  net/ipv4/inet_connection_sock.c |  5 +--
> >  3 files changed, 58 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index eb2bf4629157..05cfab107c72 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -547,6 +547,7 @@ void *kmem_cache_alloc_lru_noprof(struct kmem_cache *s, struct list_lru *lru,
> >  			    gfp_t gfpflags) __assume_slab_alignment __malloc;
> >  #define kmem_cache_alloc_lru(...)	alloc_hooks(kmem_cache_alloc_lru_noprof(__VA_ARGS__))
> >  
> > +bool kmem_cache_charge(void *objp, gfp_t gfpflags);
> >  void kmem_cache_free(struct kmem_cache *s, void *objp);
> >  
> >  kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
> > diff --git a/mm/slub.c b/mm/slub.c
> > index c9d8a2497fd6..580683597b5c 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -2185,6 +2185,16 @@ void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
> >  
> >  	__memcg_slab_free_hook(s, slab, p, objects, obj_exts);
> >  }
> > +
> > +static __fastpath_inline
> > +bool memcg_slab_post_charge(struct kmem_cache *s, void *p, gfp_t flags)
> > +{
> > +	if (likely(!memcg_kmem_online()))
> > +		return true;
> 
> We do have this check in kmem_cache_charge(), why do we need to check it again?
> 

I missed to remove this one. I am going to rearrange the code bit more
in these functions to avoid the build errors in non MEMCG builds.

> > +
> > +	return __memcg_slab_post_alloc_hook(s, NULL, flags, 1, &p);
> > +}
> > +
> >  #else /* CONFIG_MEMCG */
> >  static inline bool memcg_slab_post_alloc_hook(struct kmem_cache *s,
> >  					      struct list_lru *lru,
> > @@ -2198,6 +2208,13 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
> >  					void **p, int objects)
> >  {
> >  }
> > +
> > +static inline bool memcg_slab_post_charge(struct kmem_cache *s,
> > +					  void *p,
> > +					  gfp_t flags)
> > +{
> > +	return true;
> > +}
> >  #endif /* CONFIG_MEMCG */
> >  
> >  /*
> > @@ -4062,6 +4079,43 @@ void *kmem_cache_alloc_lru_noprof(struct kmem_cache *s, struct list_lru *lru,
> >  }
> >  EXPORT_SYMBOL(kmem_cache_alloc_lru_noprof);
> >  
> > +#define KMALLOC_TYPE (SLAB_KMALLOC | SLAB_CACHE_DMA | \
> > +		      SLAB_ACCOUNT | SLAB_RECLAIM_ACCOUNT)
> > +
> > +bool kmem_cache_charge(void *objp, gfp_t gfpflags)
> > +{
> > +	struct slabobj_ext *slab_exts;
> > +	struct kmem_cache *s;
> > +	struct folio *folio;
> > +	struct slab *slab;
> > +	unsigned long off;
> > +
> > +	if (!memcg_kmem_online())
> > +		return true;
> > +
> > +	folio = virt_to_folio(objp);
> > +	if (unlikely(!folio_test_slab(folio)))
> > +		return false;
> 
> Does it handle the case of a too-big-to-be-a-slab-object allocation?
> I think it's better to handle it properly. Also, why return false here?
> 

Yes I will fix the too-big-to-be-a-slab-object allocations. I presume I
should just follow the kfree() hanlding on !folio_test_slab() i.e. that
the given object is the large or too-big-to-be-a-slab-object.

> > +
> > +	slab = folio_slab(folio);
> > +	s = slab->slab_cache;
> > +
> > +	/* Ignore KMALLOC_NORMAL cache to avoid circular dependency. */
> > +	if ((s->flags & KMALLOC_TYPE) == SLAB_KMALLOC)
> > +		return true;
> 
> And true here? It seems to be a bit inconsistent.

Will be consistent after handling of the too-big-to-be-a-slab-object.

> Also, if we have this check here, it means your function won't handle kmallocs
> at all? Because !KMALLOC_NORMAL allocations won't get here.

The non-KMALLOC_NORMAL kmalloc caches should also have one of
SLAB_CACHE_DMA, SLAB_ACCOUNT and SLAB_RECLAIM_ACCOUNT flag, so the above
check will only be true for KMALLOC_NORMAL caches.

> 
> > +
> > +	/* Ignore already charged objects. */
> > +	slab_exts = slab_obj_exts(slab);
> > +	if (slab_exts) {
> > +		off = obj_to_index(s, slab, objp);
> > +		if (unlikely(slab_exts[off].objcg))
> > +			return true;
> > +	}
> > +
> > +	return memcg_slab_post_charge(s, objp, gfpflags);
> > +}
> > +EXPORT_SYMBOL(kmem_cache_charge);
> > +
> >  /**
> >   * kmem_cache_alloc_node - Allocate an object on the specified node
> >   * @s: The cache to allocate from.
> > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> > index 64d07b842e73..3c13ca8c11fb 100644
> > --- a/net/ipv4/inet_connection_sock.c
> > +++ b/net/ipv4/inet_connection_sock.c
> > @@ -715,6 +715,7 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
> >  	release_sock(sk);
> >  	if (newsk && mem_cgroup_sockets_enabled) {
> >  		int amt = 0;
> > +		gfp_t gfp = GFP_KERNEL | __GFP_NOFAIL;
> >  
> >  		/* atomically get the memory usage, set and charge the
> >  		 * newsk->sk_memcg.
> > @@ -731,8 +732,8 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
> >  		}
> >  
> >  		if (amt)
> > -			mem_cgroup_charge_skmem(newsk->sk_memcg, amt,
> > -						GFP_KERNEL | __GFP_NOFAIL);
> > +			mem_cgroup_charge_skmem(newsk->sk_memcg, amt, gfp);
> > +		kmem_cache_charge(newsk, gfp);
> 
> Wait, so we assume that newsk->sk_memcg === current memcg? Or we're ok with them being
> different?

We set newsk->sk_memcg in the same function (see call to
mem_cgroup_sk_alloc(newsk) couple of lines above). So, the
newsk->sk_memcg will be equal to the current memcg.

Thanks a lot of valuable feedback.
Shakeel


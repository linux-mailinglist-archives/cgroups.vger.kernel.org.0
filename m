Return-Path: <cgroups+bounces-16901-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8Op/LObtK2qtHwQAu9opvQ
	(envelope-from <cgroups+bounces-16901-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 13:30:46 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB49678FC7
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 13:30:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=mQ6XTXPT;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16901-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16901-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38B98315E878
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 11:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4733D7D94;
	Fri, 12 Jun 2026 11:30:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736B53A48E6
	for <cgroups@vger.kernel.org>; Fri, 12 Jun 2026 11:30:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781263835; cv=none; b=PIwUtqyUCUpbgUpGWEeABcMh0NGulk6/O60KHr0h//UjGJlY5W9ZsVZRpiLehQrkZd41dDNnEaHNd4nUhKWrLUKitMn/3Ceg5s1/djvnoBsIGFa3f7lU+WIOenZ4gDsYNQYz6SecHYVVtOIlMCj4Qx4XW2XQuWXSdXOWenFPG6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781263835; c=relaxed/simple;
	bh=A5EJ8jZC0OSHsS7S6F2G25aqbCTZsM25ARiRJkxN/kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCfW21uXC2dhqVI65gT0fHQFHrIzEffX7goMilAgrPKzLjBh859UziDj1mbrMHurlUdILw7q8rdc0WtJAZXAz2Fdbnqw9belIIw8TpSOuoA8vH0TmUpChd7LV/w7aRe+9y+UJQElmzJ4Yg2919vRN06kEJhkn84vEFoY8peK5Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mQ6XTXPT; arc=none smtp.client-ip=95.215.58.181
Date: Fri, 12 Jun 2026 19:29:43 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781263811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gnE76kx6sJHPObcY3xV2Cf2cd1QfYlcVg52Ay7ZMWeQ=;
	b=mQ6XTXPTqyo8DYGRO17jNXO1oaUsaQbgvh7wgElYYAOLo1NPZdxySPHZBJj6gST26n8jhW
	gKLRuBzRbgsGfenosc3DORszrEL7v8sUA02WF6feITnfb7RRTgkLEOndlUrsBSdP1IESFV
	snHja/j4piC9f4rYT0PTzP4dBLJQ/Mc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Harry Yoo <harry@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 15/16] mm/slab: remove __GFP_NO_OBJ_EXT usage from
 alloc_slab_obj_exts()
Message-ID: <aivpob0Zgnbc4AG4@fedora>
References: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
 <20260610-slab_alloc_flags-v2-15-7190909db118@kernel.org>
 <aiurbPx1SISBarBy@fedora>
 <49f1bf1e-fcaf-48fa-a7b1-f8ee78b19762@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49f1bf1e-fcaf-48fa-a7b1-f8ee78b19762@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:vbabka@kernel.org,m:harry@kernel.org,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:surenb@google.com,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[hao.li@linux.dev,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-16901-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hao.li@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,fedora:mid,linux.dev:dkim,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2AB49678FC7

On Fri, Jun 12, 2026 at 12:17:45PM +0200, Vlastimil Babka (SUSE) wrote:
> On 6/12/26 08:54, Hao Li wrote:
> > On Wed, Jun 10, 2026 at 05:40:17PM +0200, Vlastimil Babka (SUSE) wrote:
> >> __GFP_NO_OBJ_EXT has limited scope within the slab allocator itself and
> >> gfp flags are a scarce resource, unlike slab's alloc_flags.
> >> 
> >> Introduce SLAB_ALLOC_NO_RECURSE alloc flag that has the same intent as
> >> __GFP_NO_OBJ_EXT but a more generic name, meaning that a kmalloc()
> >> family function should not recurse into another kmalloc*() for the
> >> purposes of allocating auxiliary structures (obj_ext arrays or sheaves).
> >> 
> >> First, replace the __GFP_NO_OBJ_EXT for allocating obj_ext arrays in
> >> alloc_slab_obj_exts(). Make use of the newly added kmalloc_flags()
> >> function, where we can pass alloc_flags with SLAB_ALLOC_NO_RECURSE
> >> added. This will also pass through SLAB_ALLOC_TRYLOCK so we don't need
> >> to special case kmalloc_nolock() anymore.
> >> 
> >> Note that until now the kmalloc_nolock() ignored the incoming gfp flags
> >> and hardcoded __GFP_ZERO | __GFP_NO_OBJ_EXT. But it's correct to pass on
> >> the incoming gfp flags (only augmented with __GFP_ZERO), because if
> >> alloc_flags contain SLAB_ALLOC_TRYLOCK, the incoming gfp flags have to
> >> be also compatible with it.
> >> 
> >> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> >> ---
> >>  mm/slab.h |  1 +
> >>  mm/slub.c | 13 +++++--------
> >>  2 files changed, 6 insertions(+), 8 deletions(-)
> >> 
> >> diff --git a/mm/slab.h b/mm/slab.h
> >> index 45bfcfb35a9c..509f330654b8 100644
> >> --- a/mm/slab.h
> >> +++ b/mm/slab.h
> >> @@ -21,6 +21,7 @@
> >>  #define SLAB_ALLOC_DEFAULT	0x00 /* no flags */
> >>  #define SLAB_ALLOC_TRYLOCK	0x01 /* a kmalloc_nolock() allocation */
> >>  #define SLAB_ALLOC_NEW_SLAB	0x02 /* a flag for alloc_slab_obj_exts() */
> >> +#define SLAB_ALLOC_NO_RECURSE	0x04 /* prevent kmalloc() recursion */
> >>  
> >>  static inline bool alloc_flags_allow_spinning(const unsigned int alloc_flags)
> >>  {
> >> diff --git a/mm/slub.c b/mm/slub.c
> >> index cbb38bd01e46..7dfbd0251aa2 100644
> >> --- a/mm/slub.c
> >> +++ b/mm/slub.c
> >> @@ -2167,15 +2167,12 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> >>  
> >>  	gfp &= ~OBJCGS_CLEAR_MASK;
> >>  	/* Prevent recursive extension vector allocation */
> >> -	gfp |= __GFP_NO_OBJ_EXT;
> >> +	alloc_flags |= SLAB_ALLOC_NO_RECURSE;
> >>  
> >>  	sz = obj_exts_alloc_size(s, slab, gfp);
> >>  
> > 
> > For the original calls to kmalloc_nolock and kmalloc_node, I notice a difference:
> > 
> >> -	if (unlikely(!allow_spin))
> >> -		vec = kmalloc_nolock(sz, __GFP_ZERO | __GFP_NO_OBJ_EXT,
> >> -				     slab_nid(slab));
> > 
> > kmalloc_nolock completely discarded `gfp` flags.
> > 
> >> -	else
> >> -		vec = kmalloc_node(sz, gfp | __GFP_ZERO, slab_nid(slab));
> > 
> > while kmalloc_node preserved and passed it along.
> > 
> >> +	/* This will use kmalloc_nolock() if alloc_flags say so */
> >> +	vec = kmalloc_flags(sz, gfp | __GFP_ZERO, alloc_flags, slab_nid(slab));
> > 
> > Now both paths are merged into kmalloc_flags, the gfp flags are
> > unconditionally carried through. It seems this might carry some unwanted flags.
> > 
> > I traced the call path and found that ___slab_alloc sets the __GFP_THISNODE
> > for trynode_flags. If this flag propagates all the way into
> > kmalloc_flags->...->__kmalloc_nolock_noprof, it will trigger the
> > VM_WARN_ON_ONCE warning. Maybe we need to strip the original gfp if
> > `!allow_spin`.
>  
> Thanks. This should do the job in a more generic way I hope?
> 

Yeah, this is more elegant.

> diff --git a/mm/slub.c b/mm/slub.c
> index f9b8dc56bb57..0bf53f70c9be 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2047,12 +2047,15 @@ static inline void dec_slabs_node(struct kmem_cache *s, int node,
>  #endif /* CONFIG_SLUB_DEBUG */
>  
>  /*
> - * The allocated objcg pointers array is not accounted directly.
> + * The allocated objcg pointers array or sheaf is not accounted directly.
>   * Moreover, it should not come from DMA buffer and is not readily
> - * reclaimable. So those GFP bits should be masked off.
> + * reclaimable. Node restriction for the parent allocation also should
> + * not apply to the slab's internal objects.
> + * So those GFP bits should be masked off.
>   */
>  #define OBJCGS_CLEAR_MASK      (__GFP_DMA | __GFP_RECLAIMABLE | \
> -                               __GFP_ACCOUNT | __GFP_NOFAIL)
> +                               __GFP_ACCOUNT | __GFP_NOFAIL |
> +                               __GFP_THISNODE )

Good idea! Both code and comments make sense to me.

>  
>  #ifdef CONFIG_SLAB_OBJ_EXT
>  
> 

-- 
Thanks,
Hao


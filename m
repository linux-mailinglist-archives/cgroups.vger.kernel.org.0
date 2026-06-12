Return-Path: <cgroups+bounces-16886-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q9JBNciFK2oa/AMAu9opvQ
	(envelope-from <cgroups+bounces-16886-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 06:06:32 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA216768E9
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 06:06:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=hZG8lZYr;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16886-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16886-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68BE3305115E
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 04:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EC9305673;
	Fri, 12 Jun 2026 04:05:09 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164FC1F5821
	for <cgroups@vger.kernel.org>; Fri, 12 Jun 2026 04:05:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781237109; cv=none; b=krSLR6T8ZRFV+vQEVweEYErlGJllcNmGd9x/1+SqOUplNmxeomWa/aUyxtOgwn8Wf36Pu5QkOd+yAgwCatG+sc1AC+cJ4qjW6a2c/UffCF8S70VOkJ5Flu0Zao3nk7K321zdToOZ/vKLdBs8mhjrHPt3oxJjOiUpnhomRnEkJ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781237109; c=relaxed/simple;
	bh=Td7pJB1te00tkQiSnwUG1lGTWUyVRAml8w+NMYBPRHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvWWXdJ5+ZiirQ82ndTK8UckoLS7l/RxR7y8mJ2vxvXsPHIUIfolgkCLP0RliZ2g1vSy0sZ7ub3voK0TWWALfPca3ePGAhuBwv/60paW6hQ/jB7xIhkFwDo96c0jEidn+jI5YqUPMsJP2LohagVKa0J+2eDm8/eQ4ruwrGkD9rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hZG8lZYr; arc=none smtp.client-ip=91.218.175.181
Date: Fri, 12 Jun 2026 12:04:51 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781237106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dPSZ+ZJ1Dy/4TtgnmDEs7BipTTu6JauwKDrcxScrmls=;
	b=hZG8lZYrtItniCX26jc4WxdGTIy7oIO0tf3kSfNkI6V/OyY9l4lLYbb7u3liYzOPJdTb7T
	1b7/KrwS59kuh6Xywzsm3IQH/bttyApqTy7didmkBS86gdayidPajmb2Tkr46iPDvIdAn3
	DN/kmD+cG9dMPF7fPR784SB5czEouhM=
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
Subject: Re: [PATCH v2 07/16] mm/slab: replace struct partial_context with
 slab_alloc_context
Message-ID: <aiuCiXBBB64AfPjI@fedora>
References: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
 <20260610-slab_alloc_flags-v2-7-7190909db118@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610-slab_alloc_flags-v2-7-7190909db118@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[hao.li@linux.dev,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:vbabka@kernel.org,m:harry@kernel.org,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:surenb@google.com,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-16886-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:email,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2CA216768E9

On Wed, Jun 10, 2026 at 05:40:09PM +0200, Vlastimil Babka (SUSE) wrote:
> Refactor get_from_partial_node(), get_from_any_partial(),
> get_from_partial() and ___slab_alloc().
> 
> Remove struct partial_context, which used to be more substantial but
> shrank as part of the sheaves conversion. Instead pass gfp_flags and
> pointer to the new slab_alloc_context, which together is a superset of
> partial_context.
> 
> This means alloc_flags are now available and we can use them to
> determine if spinning is allowed, further reducing false positive "not
> allowed" in the slow path due to gfp flags lacking __GFP_RECLAIM.
> 
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---
>  mm/slub.c | 52 ++++++++++++++++++++++++----------------------------
>  1 file changed, 24 insertions(+), 28 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index ef745b37d063..98b79e5e7679 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -220,12 +220,6 @@ struct slab_alloc_context {
>  	unsigned int alloc_flags;
>  };
>  
> -/* Structure holding parameters for get_from_partial() call chain */
> -struct partial_context {
> -	gfp_t flags;
> -	unsigned int orig_size;
> -};
> -
>  /* Structure holding parameters for get_partial_node_bulk() */
>  struct partial_bulk_context {
>  	gfp_t flags;
> @@ -3826,7 +3820,8 @@ static bool get_partial_node_bulk(struct kmem_cache *s,
>   */
>  static void *get_from_partial_node(struct kmem_cache *s,
>  				   struct kmem_cache_node *n,
> -				   struct partial_context *pc)
> +				   gfp_t gfp_flags,
> +				   struct slab_alloc_context *ac)
>  {
>  	struct slab *slab, *slab2;
>  	unsigned long flags;
> @@ -3841,7 +3836,7 @@ static void *get_from_partial_node(struct kmem_cache *s,
>  	if (!n || !n->nr_partial)
>  		return NULL;
>  
> -	if (gfpflags_allow_spinning(pc->flags))
> +	if (alloc_flags_allow_spinning(ac->alloc_flags))
>  		spin_lock_irqsave(&n->list_lock, flags);
>  	else if (!spin_trylock_irqsave(&n->list_lock, flags))
>  		return NULL;
> @@ -3849,12 +3844,12 @@ static void *get_from_partial_node(struct kmem_cache *s,
>  
>  		struct freelist_counters old, new;
>  
> -		if (!pfmemalloc_match(slab, pc->flags))
> +		if (!pfmemalloc_match(slab, gfp_flags))
>  			continue;
>  
>  		if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
>  			object = alloc_single_from_partial(s, n, slab,
> -							pc->orig_size);
> +							ac->orig_size);
>  			if (object)
>  				break;
>  			continue;
> @@ -3888,15 +3883,16 @@ static void *get_from_partial_node(struct kmem_cache *s,
>  /*
>   * Get an object from somewhere. Search in increasing NUMA distances.
>   */
> -static void *get_from_any_partial(struct kmem_cache *s, struct partial_context *pc)
> +static void *get_from_any_partial(struct kmem_cache *s, gfp_t gfp_flags,
> +				  struct slab_alloc_context *ac)
>  {
>  #ifdef CONFIG_NUMA
>  	struct zonelist *zonelist;
>  	struct zoneref *z;
>  	struct zone *zone;
> -	enum zone_type highest_zoneidx = gfp_zone(pc->flags);
> +	enum zone_type highest_zoneidx = gfp_zone(gfp_flags);
>  	unsigned int cpuset_mems_cookie;
> -	bool allow_spin = gfpflags_allow_spinning(pc->flags);
> +	bool allow_spin = alloc_flags_allow_spinning(ac->alloc_flags);
>  
>  	/*
>  	 * The defrag ratio allows a configuration of the tradeoffs between
> @@ -3930,16 +3926,17 @@ static void *get_from_any_partial(struct kmem_cache *s, struct partial_context *
>  		if (allow_spin)
>  			cpuset_mems_cookie = read_mems_allowed_begin();
>  
> -		zonelist = node_zonelist(mempolicy_slab_node(), pc->flags);
> +		zonelist = node_zonelist(mempolicy_slab_node(), gfp_flags);
>  		for_each_zone_zonelist(zone, z, zonelist, highest_zoneidx) {
>  			struct kmem_cache_node *n;
>  
>  			n = get_node(s, zone_to_nid(zone));
>  
> -			if (n && cpuset_zone_allowed(zone, pc->flags) &&
> +			if (n && cpuset_zone_allowed(zone, gfp_flags) &&
>  					n->nr_partial > s->min_partial) {
>  
> -				void *object = get_from_partial_node(s, n, pc);
> +				void *object = get_from_partial_node(s, n,
> +								gfp_flags, ac);
>  
>  				if (object) {
>  					/*
> @@ -3961,8 +3958,8 @@ static void *get_from_any_partial(struct kmem_cache *s, struct partial_context *
>  /*
>   * Get an object from a partial slab
>   */
> -static void *get_from_partial(struct kmem_cache *s, int node,
> -			      struct partial_context *pc)
> +static void *get_from_partial(struct kmem_cache *s, int node, gfp_t flags,
> +			      struct slab_alloc_context *ac)
>  {
>  	int searchnode = node;
>  	void *object;
> @@ -3970,11 +3967,11 @@ static void *get_from_partial(struct kmem_cache *s, int node,
>  	if (node == NUMA_NO_NODE)
>  		searchnode = numa_mem_id();
>  
> -	object = get_from_partial_node(s, get_node(s, searchnode), pc);
> -	if (object || (node != NUMA_NO_NODE && (pc->flags & __GFP_THISNODE)))
> +	object = get_from_partial_node(s, get_node(s, searchnode), flags, ac);
> +	if (object || (node != NUMA_NO_NODE && (flags & __GFP_THISNODE)))
>  		return object;
>  
> -	return get_from_any_partial(s, pc);
> +	return get_from_any_partial(s, flags, ac);
>  }
>  
>  static bool has_pcs_used(int cpu, struct kmem_cache *s)
> @@ -4454,16 +4451,16 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  			   struct slab_alloc_context *ac)
>  {
>  	bool allow_spin = alloc_flags_allow_spinning(ac->alloc_flags);
> +	gfp_t trynode_flags;
>  	void *object;
>  	struct slab *slab;
> -	struct partial_context pc;
>  	bool try_thisnode = true;
>  
>  	stat(s, ALLOC_SLOWPATH);
>  
>  new_objects:
>  
> -	pc.flags = gfpflags;
> +	trynode_flags = gfpflags;
>  	/*
>  	 * When a preferred node is indicated but no __GFP_THISNODE
>  	 *
> @@ -4479,17 +4476,16 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  		     && try_thisnode)) {
>  		if (unlikely(!allow_spin))
>  			/* Do not upgrade gfp to NOWAIT from more restrictive mode */
> -			pc.flags = gfpflags | __GFP_THISNODE;
> +			trynode_flags = gfpflags | __GFP_THISNODE;
>  		else
> -			pc.flags = GFP_NOWAIT | __GFP_THISNODE;
> +			trynode_flags = GFP_NOWAIT | __GFP_THISNODE;

nit: the comment "__GFP_THISNODE in pc.flags" also needs to be updated to "trynode_flags"

otherwise, looks good to me.
Reviewed-by: Hao Li <hao.li@linux.dev>

-- 
Thanks,
Hao


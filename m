Return-Path: <cgroups+bounces-16880-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IsvPNr14K2ri+AMAu9opvQ
	(envelope-from <cgroups+bounces-16880-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 05:10:53 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3D8676658
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 05:10:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=RIJ2yqw7;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16880-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16880-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C94E330F0246
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 03:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD5A31B80E;
	Fri, 12 Jun 2026 03:10:15 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD8930DEB0
	for <cgroups@vger.kernel.org>; Fri, 12 Jun 2026 03:10:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781233815; cv=none; b=fGJIyqAl2NiPUsxZz6YiNCm8PaVuWo+06T8ZHhJ6Z8qJ5InKFXXbhZf0iGZk/hEadBIZJRtCp8rLKIIk1aeuYLT4hTths8eaGUxL+iu9Pxr98Irxfi58ez1uHAcB8dBLX50KbzSmIELTvvMGJbrcdR8fqpxvx7Cl9vyCfVTf99c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781233815; c=relaxed/simple;
	bh=xVbcbMvKvcyric7Q0WnwnWnU7Px7xPpZAc2Gq2U6URo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oO+w+Gi6g2jerU3H31xA/iamrsAsflwRcN8zHhFow6o3Dy8Of1yNsBdw6UrZDQ5adWd+escDYCb3LjXzbCaXwmew2Xw8U4XjmEWOV0r+abgrXsIMnaRaAy5BjHbT4qZ+eoRaCproMHsOCZGLOa6vhNR/zSyA1/6QQ+D/j7K7EPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RIJ2yqw7; arc=none smtp.client-ip=91.218.175.172
Date: Fri, 12 Jun 2026 11:10:01 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781233810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IMkiUvF10XGtojfJrLDBnh6aQ1RB3YPypzDrMb4ByLo=;
	b=RIJ2yqw7C7JmCfkoCrm+79dXdzarL0gHVRsSeKdkHVY50yMmJXibLzdraXpjNnt1T1MD/Q
	3DsdrWIOGKAHBLsFlhF86W3POJqa9ri2gSvT8aLm8k4Gl6IU05wpVLHaaKY6kSft1JvQ0A
	BRwDmFSFA41k3I49MPYpyvGMEz43n6Y=
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
Subject: Re: [PATCH v2 04/16] mm/slab: introduce slab_alloc_context
Message-ID: <ait21B7kqfT9XhOs@fedora>
References: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
 <20260610-slab_alloc_flags-v2-4-7190909db118@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610-slab_alloc_flags-v2-4-7190909db118@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-16880-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,fedora:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F3D8676658

On Wed, Jun 10, 2026 at 05:40:06PM +0200, Vlastimil Babka (SUSE) wrote:
> Similarly to page allocator's struct alloc_context, introduce a helper
> struct to hold a part of the allocation arguments. This will allow
> reducing the number of parameters in many functions of the
> implementation, and extend them easily if needed.
> 
> For now, make it hold the caller address and the originally requested
> allocation size.
> 
> Convert alloc_single_from_new_slab(), __slab_alloc_node() and
> ___slab_alloc(). No functional change intended.
> 
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---
>  mm/slub.c | 46 +++++++++++++++++++++++++++++++++-------------
>  1 file changed, 33 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 7b48c0d38404..a3cac7281cc6 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -213,6 +213,12 @@ DEFINE_STATIC_KEY_FALSE(slub_debug_enabled);
>  static DEFINE_STATIC_KEY_FALSE(strict_numa);
>  #endif
>  
> +/* Structure holding extra parameters for slab allocations */
> +struct slab_alloc_context {
> +	unsigned long caller_addr;
> +	unsigned long orig_size;
> +};
> +
>  /* Structure holding parameters for get_from_partial() call chain */
>  struct partial_context {
>  	gfp_t flags;
> @@ -3687,7 +3693,8 @@ static inline void init_slab_obj_iter(struct kmem_cache *s, struct slab *slab,
>   * and put the slab to the partial (or full) list.
>   */
>  static void *alloc_single_from_new_slab(struct kmem_cache *s, struct slab *slab,
> -					int orig_size, bool allow_spin)
> +					struct slab_alloc_context *ac,
> +					bool allow_spin)
>  {
>  	struct kmem_cache_node *n;
>  	struct slab_obj_iter iter;
> @@ -3705,7 +3712,7 @@ static void *alloc_single_from_new_slab(struct kmem_cache *s, struct slab *slab,
>  	/* alloc_debug_processing() always expects a valid freepointer */
>  	set_freepointer(s, object, slab->freelist);
>  
> -	if (!alloc_debug_processing(s, slab, object, orig_size)) {
> +	if (!alloc_debug_processing(s, slab, object, ac->orig_size)) {
>  		/*
>  		 * It's not really expected that this would fail on a
>  		 * freshly allocated slab, but a concurrent memory
> @@ -4443,7 +4450,7 @@ static unsigned int alloc_from_new_slab(struct kmem_cache *s, struct slab *slab,
>   * slab.
>   */
>  static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> -			   unsigned long addr, unsigned int orig_size)
> +			   struct slab_alloc_context *ac)
>  {
>  	bool allow_spin = gfpflags_allow_spinning(gfpflags);
>  	void *object;
> @@ -4476,7 +4483,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  			pc.flags = GFP_NOWAIT | __GFP_THISNODE;
>  	}
>  
> -	pc.orig_size = orig_size;
> +	pc.orig_size = ac->orig_size;
>  	object = get_from_partial(s, node, &pc);
>  	if (object)
>  		goto success;
> @@ -4496,7 +4503,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  	stat(s, ALLOC_SLAB);
>  
>  	if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
> -		object = alloc_single_from_new_slab(s, slab, orig_size, allow_spin);
> +		object = alloc_single_from_new_slab(s, slab, ac, allow_spin);
>  
>  		if (likely(object))
>  			goto success;
> @@ -4514,13 +4521,13 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  
>  success:
>  	if (kmem_cache_debug_flags(s, SLAB_STORE_USER))
> -		set_track(s, object, TRACK_ALLOC, addr, gfpflags);
> +		set_track(s, object, TRACK_ALLOC, ac->caller_addr, gfpflags);
>  
>  	return object;
>  }
>  
>  static void *__slab_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node,
> -			       unsigned long addr, size_t orig_size)
> +			       struct slab_alloc_context *ac)
>  {
>  	void *object;
>  
> @@ -4545,7 +4552,7 @@ static void *__slab_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node,
>  	}
>  #endif
>  
> -	object = ___slab_alloc(s, gfpflags, node, addr, orig_size);
> +	object = ___slab_alloc(s, gfpflags, node, ac);
>  
>  	return object;
>  }
> @@ -4923,8 +4930,13 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
>  
>  	object = alloc_from_pcs(s, gfpflags, node);
>  
> -	if (unlikely(!object))
> -		object = __slab_alloc_node(s, gfpflags, node, addr, orig_size);
> +	if (unlikely(!object)) {
> +		struct slab_alloc_context ac = {
> +			.caller_addr = addr,
> +			.orig_size = orig_size,
> +		};
> +		object = __slab_alloc_node(s, gfpflags, node, &ac);
> +	}
>  
>  	maybe_wipe_obj_freeptr(s, object);
>  
> @@ -5389,13 +5401,18 @@ void *_kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_flags, in
>  	if (ret)
>  		goto success;
>  
> +	struct slab_alloc_context ac = {
> +		.caller_addr = _RET_IP_,
> +		.orig_size = orig_size,
> +	};

It might be better to move this to the beginning of the function, to avoid
patch09 jump to `success` before ac is initialized.

> +
>  	/*
>  	 * Do not call slab_alloc_node(), since trylock mode isn't
>  	 * compatible with slab_pre_alloc_hook/should_failslab and
>  	 * kfence_alloc. Hence call __slab_alloc_node() (at most twice)
>  	 * and slab_post_alloc_hook() directly.
>  	 */
> -	ret = __slab_alloc_node(s, alloc_gfp, node, _RET_IP_, orig_size);
> +	ret = __slab_alloc_node(s, alloc_gfp, node, &ac);
>  
>  	/*
>  	 * It's possible we failed due to trylock as we preempted someone with
> @@ -7237,10 +7254,13 @@ static bool __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
>  	int i;
>  
>  	if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
> +		struct slab_alloc_context ac = {
> +			.caller_addr = _RET_IP_,
> +			.orig_size = s->object_size,
> +		};
>  		for (i = 0; i < size; i++) {
>  
> -			p[i] = ___slab_alloc(s, flags, NUMA_NO_NODE, _RET_IP_,
> -					     s->object_size);
> +			p[i] = ___slab_alloc(s, flags, NUMA_NO_NODE, &ac);
>  			if (unlikely(!p[i]))
>  				goto error;
>  
> 
> -- 
> 2.54.0
> 


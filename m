Return-Path: <cgroups+bounces-880-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEF2807DEB
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 02:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E622B2111C
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 01:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CA8111B;
	Thu,  7 Dec 2023 01:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrZmQc+w"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBA5D59;
	Wed,  6 Dec 2023 17:31:06 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1fb71880f12so310136fac.0;
        Wed, 06 Dec 2023 17:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701912665; x=1702517465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FC4kVPBMR3jCsCH7t301OXLH/yq0oHM2fZo2MjvGfcg=;
        b=mrZmQc+wrZI/ngYGDoSfheKhd0EwAIKKvyZIaFLIbECc8RDvB45TJ+Pt1XY0EO35qI
         eYdT1W/ixh6UAahRqa11vuNa4gf5z7NPIqPoJF3VMPeDI8HJ4XrZuMBjUE82GC63kboR
         Fx9yhdOdmNnSJNU0lvd+t73RGyAwDSKSkBpTX7hV+jPVFxp0EdMG5bIQn9kPmsIunppO
         DU82X8W72nXqGOx6zJTtGnO0XKz1ujIlM+mGg6EyMH9fGA0TyeefMdBIIi5GuIW+53mT
         jojgM59ymnvrct41Lfs7eZwtsaoxhmV0R+4/i4mzVYduy11e6lJYaSMPWrfI/ST+jzFx
         yT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701912665; x=1702517465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FC4kVPBMR3jCsCH7t301OXLH/yq0oHM2fZo2MjvGfcg=;
        b=wieRRBSCwbCPwgnS7dPzkssgSssfvL2V3DkN1DGBnGvV2mLl5dDNzT93VrbieYeZJm
         H6Z8+M24Lytf4iEueSHvO63EjwAHMgSXcXQdPNrb+47ZRo5Gbm0vf2wsJGOMyc8yzDpz
         6us3kejHpkB6ww51NNEqOLRJCcXd0HQgFziDa1mabyYHW8JRDdxUrpzB49PJL30DnwB+
         hbU9+IxkZ9D2ebVQz8MuVIszpME67FZwcNgdhl6AmGjHAfk72/gmnHgolUjeZw1HPG8f
         purXqmFoGcn3NGuwogoMX8BY/K9Edvi0ObJeTgDZ+/rC5DhJomvHMuJy8lYiFKkANtjq
         m1ww==
X-Gm-Message-State: AOJu0Yy+S8enQncZUIsUwlLOm11eBM9bxPBg7zAjCWCpvOgzUPz2Zj7R
	Glyof5L11lA8BuH3vPz4Cq8=
X-Google-Smtp-Source: AGHT+IFZ5wq0R88YYcSMswZ76r5mJtY195BOiWGDf+xrPaXU+/BjFAfNM0OZhocjkWwXQnNn88ggEQ==
X-Received: by 2002:a05:6870:9d9b:b0:1fb:75a:779d with SMTP id pv27-20020a0568709d9b00b001fb075a779dmr1959822oab.78.1701912665309;
        Wed, 06 Dec 2023 17:31:05 -0800 (PST)
Received: from localhost.localdomain ([1.245.180.67])
        by smtp.gmail.com with ESMTPSA id i16-20020a056a00005000b006cde2889213sm158443pfk.14.2023.12.06.17.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 17:31:04 -0800 (PST)
Date: Thu, 7 Dec 2023 10:30:57 +0900
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Marco Elver <elver@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 18/21] mm/slab: move kmalloc() functions from
 slab_common.c to slub.c
Message-ID: <ZXEgUVrUuIHlgsec@localhost.localdomain>
References: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
 <20231120-slab-remove-slab-v2-18-9c9c70177183@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120-slab-remove-slab-v2-18-9c9c70177183@suse.cz>

On Mon, Nov 20, 2023 at 07:34:29PM +0100, Vlastimil Babka wrote:
> This will eliminate a call between compilation units through
> __kmem_cache_alloc_node() and allow better inlining of the allocation
> fast path.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slab.h        |   3 --
>  mm/slab_common.c | 119 ----------------------------------------------------
>  mm/slub.c        | 126 +++++++++++++++++++++++++++++++++++++++++++++++++++----
>  3 files changed, 118 insertions(+), 130 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 7d7cc7af614e..54deeb0428c6 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -416,9 +416,6 @@ kmalloc_slab(size_t size, gfp_t flags, unsigned long caller)
>  	return kmalloc_caches[kmalloc_type(flags, caller)][index];
>  }
>  
> -void *__kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags,
> -			      int node, size_t orig_size,
> -			      unsigned long caller);
>  gfp_t kmalloc_fix_flags(gfp_t flags);
>  
>  /* Functions provided by the slab allocators */
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 31ade17a7ad9..238293b1dbe1 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -936,50 +936,6 @@ void __init create_kmalloc_caches(slab_flags_t flags)
>  	slab_state = UP;
>  }
>  
> -static void *__kmalloc_large_node(size_t size, gfp_t flags, int node);
> -static __always_inline
> -void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
> -{
> -	struct kmem_cache *s;
> -	void *ret;
> -
> -	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
> -		ret = __kmalloc_large_node(size, flags, node);
> -		trace_kmalloc(caller, ret, size,
> -			      PAGE_SIZE << get_order(size), flags, node);
> -		return ret;
> -	}
> -
> -	if (unlikely(!size))
> -		return ZERO_SIZE_PTR;
> -
> -	s = kmalloc_slab(size, flags, caller);
> -
> -	ret = __kmem_cache_alloc_node(s, flags, node, size, caller);
> -	ret = kasan_kmalloc(s, ret, size, flags);
> -	trace_kmalloc(caller, ret, size, s->size, flags, node);
> -	return ret;
> -}
> -
> -void *__kmalloc_node(size_t size, gfp_t flags, int node)
> -{
> -	return __do_kmalloc_node(size, flags, node, _RET_IP_);
> -}
> -EXPORT_SYMBOL(__kmalloc_node);
> -
> -void *__kmalloc(size_t size, gfp_t flags)
> -{
> -	return __do_kmalloc_node(size, flags, NUMA_NO_NODE, _RET_IP_);
> -}
> -EXPORT_SYMBOL(__kmalloc);
> -
> -void *__kmalloc_node_track_caller(size_t size, gfp_t flags,
> -				  int node, unsigned long caller)
> -{
> -	return __do_kmalloc_node(size, flags, node, caller);
> -}
> -EXPORT_SYMBOL(__kmalloc_node_track_caller);
> -
>  /**
>   * __ksize -- Report full size of underlying allocation
>   * @object: pointer to the object
> @@ -1016,30 +972,6 @@ size_t __ksize(const void *object)
>  	return slab_ksize(folio_slab(folio)->slab_cache);
>  }
>  
> -void *kmalloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
> -{
> -	void *ret = __kmem_cache_alloc_node(s, gfpflags, NUMA_NO_NODE,
> -					    size, _RET_IP_);
> -
> -	trace_kmalloc(_RET_IP_, ret, size, s->size, gfpflags, NUMA_NO_NODE);
> -
> -	ret = kasan_kmalloc(s, ret, size, gfpflags);
> -	return ret;
> -}
> -EXPORT_SYMBOL(kmalloc_trace);
> -
> -void *kmalloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
> -			 int node, size_t size)
> -{
> -	void *ret = __kmem_cache_alloc_node(s, gfpflags, node, size, _RET_IP_);
> -
> -	trace_kmalloc(_RET_IP_, ret, size, s->size, gfpflags, node);
> -
> -	ret = kasan_kmalloc(s, ret, size, gfpflags);
> -	return ret;
> -}
> -EXPORT_SYMBOL(kmalloc_node_trace);
> -
>  gfp_t kmalloc_fix_flags(gfp_t flags)
>  {
>  	gfp_t invalid_mask = flags & GFP_SLAB_BUG_MASK;
> @@ -1052,57 +984,6 @@ gfp_t kmalloc_fix_flags(gfp_t flags)
>  	return flags;
>  }
>  
> -/*
> - * To avoid unnecessary overhead, we pass through large allocation requests
> - * directly to the page allocator. We use __GFP_COMP, because we will need to
> - * know the allocation order to free the pages properly in kfree.
> - */
> -
> -static void *__kmalloc_large_node(size_t size, gfp_t flags, int node)
> -{
> -	struct page *page;
> -	void *ptr = NULL;
> -	unsigned int order = get_order(size);
> -
> -	if (unlikely(flags & GFP_SLAB_BUG_MASK))
> -		flags = kmalloc_fix_flags(flags);
> -
> -	flags |= __GFP_COMP;
> -	page = alloc_pages_node(node, flags, order);
> -	if (page) {
> -		ptr = page_address(page);
> -		mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B,
> -				      PAGE_SIZE << order);
> -	}
> -
> -	ptr = kasan_kmalloc_large(ptr, size, flags);
> -	/* As ptr might get tagged, call kmemleak hook after KASAN. */
> -	kmemleak_alloc(ptr, size, 1, flags);
> -	kmsan_kmalloc_large(ptr, size, flags);
> -
> -	return ptr;
> -}
> -
> -void *kmalloc_large(size_t size, gfp_t flags)
> -{
> -	void *ret = __kmalloc_large_node(size, flags, NUMA_NO_NODE);
> -
> -	trace_kmalloc(_RET_IP_, ret, size, PAGE_SIZE << get_order(size),
> -		      flags, NUMA_NO_NODE);
> -	return ret;
> -}
> -EXPORT_SYMBOL(kmalloc_large);
> -
> -void *kmalloc_large_node(size_t size, gfp_t flags, int node)
> -{
> -	void *ret = __kmalloc_large_node(size, flags, node);
> -
> -	trace_kmalloc(_RET_IP_, ret, size, PAGE_SIZE << get_order(size),
> -		      flags, node);
> -	return ret;
> -}
> -EXPORT_SYMBOL(kmalloc_large_node);
> -
>  #ifdef CONFIG_SLAB_FREELIST_RANDOM
>  /* Randomize a generic freelist */
>  static void freelist_randomize(unsigned int *list,
> diff --git a/mm/slub.c b/mm/slub.c
> index 2baa9e94d9df..d6bc15929d22 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3851,14 +3851,6 @@ void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
>  }
>  EXPORT_SYMBOL(kmem_cache_alloc_lru);
>  
> -void *__kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags,
> -			      int node, size_t orig_size,
> -			      unsigned long caller)
> -{
> -	return slab_alloc_node(s, NULL, gfpflags, node,
> -			       caller, orig_size);
> -}
> -
>  /**
>   * kmem_cache_alloc_node - Allocate an object on the specified node
>   * @s: The cache to allocate from.
> @@ -3882,6 +3874,124 @@ void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
>  }
>  EXPORT_SYMBOL(kmem_cache_alloc_node);
>  
> +/*
> + * To avoid unnecessary overhead, we pass through large allocation requests
> + * directly to the page allocator. We use __GFP_COMP, because we will need to
> + * know the allocation order to free the pages properly in kfree.
> + */
> +static void *__kmalloc_large_node(size_t size, gfp_t flags, int node)
> +{
> +	struct page *page;
> +	void *ptr = NULL;
> +	unsigned int order = get_order(size);
> +
> +	if (unlikely(flags & GFP_SLAB_BUG_MASK))
> +		flags = kmalloc_fix_flags(flags);
> +
> +	flags |= __GFP_COMP;
> +	page = alloc_pages_node(node, flags, order);
> +	if (page) {
> +		ptr = page_address(page);
> +		mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B,
> +				      PAGE_SIZE << order);
> +	}
> +
> +	ptr = kasan_kmalloc_large(ptr, size, flags);
> +	/* As ptr might get tagged, call kmemleak hook after KASAN. */
> +	kmemleak_alloc(ptr, size, 1, flags);
> +	kmsan_kmalloc_large(ptr, size, flags);
> +
> +	return ptr;
> +}
> +
> +void *kmalloc_large(size_t size, gfp_t flags)
> +{
> +	void *ret = __kmalloc_large_node(size, flags, NUMA_NO_NODE);
> +
> +	trace_kmalloc(_RET_IP_, ret, size, PAGE_SIZE << get_order(size),
> +		      flags, NUMA_NO_NODE);
> +	return ret;
> +}
> +EXPORT_SYMBOL(kmalloc_large);
> +
> +void *kmalloc_large_node(size_t size, gfp_t flags, int node)
> +{
> +	void *ret = __kmalloc_large_node(size, flags, node);
> +
> +	trace_kmalloc(_RET_IP_, ret, size, PAGE_SIZE << get_order(size),
> +		      flags, node);
> +	return ret;
> +}
> +EXPORT_SYMBOL(kmalloc_large_node);
> +
> +static __always_inline
> +void *__do_kmalloc_node(size_t size, gfp_t flags, int node,
> +			unsigned long caller)
> +{
> +	struct kmem_cache *s;
> +	void *ret;
> +
> +	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
> +		ret = __kmalloc_large_node(size, flags, node);
> +		trace_kmalloc(caller, ret, size,
> +			      PAGE_SIZE << get_order(size), flags, node);
> +		return ret;
> +	}
> +
> +	if (unlikely(!size))
> +		return ZERO_SIZE_PTR;
> +
> +	s = kmalloc_slab(size, flags, caller);
> +
> +	ret = slab_alloc_node(s, NULL, flags, node, caller, size);
> +	ret = kasan_kmalloc(s, ret, size, flags);
> +	trace_kmalloc(caller, ret, size, s->size, flags, node);
> +	return ret;
> +}
> +
> +void *__kmalloc_node(size_t size, gfp_t flags, int node)
> +{
> +	return __do_kmalloc_node(size, flags, node, _RET_IP_);
> +}
> +EXPORT_SYMBOL(__kmalloc_node);
> +
> +void *__kmalloc(size_t size, gfp_t flags)
> +{
> +	return __do_kmalloc_node(size, flags, NUMA_NO_NODE, _RET_IP_);
> +}
> +EXPORT_SYMBOL(__kmalloc);
> +
> +void *__kmalloc_node_track_caller(size_t size, gfp_t flags,
> +				  int node, unsigned long caller)
> +{
> +	return __do_kmalloc_node(size, flags, node, caller);
> +}
> +EXPORT_SYMBOL(__kmalloc_node_track_caller);
> +
> +void *kmalloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
> +{
> +	void *ret = slab_alloc_node(s, NULL, gfpflags, NUMA_NO_NODE,
> +					    _RET_IP_, size);
> +
> +	trace_kmalloc(_RET_IP_, ret, size, s->size, gfpflags, NUMA_NO_NODE);
> +
> +	ret = kasan_kmalloc(s, ret, size, gfpflags);
> +	return ret;
> +}
> +EXPORT_SYMBOL(kmalloc_trace);
> +
> +void *kmalloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
> +			 int node, size_t size)
> +{
> +	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, size);
> +
> +	trace_kmalloc(_RET_IP_, ret, size, s->size, gfpflags, node);
> +
> +	ret = kasan_kmalloc(s, ret, size, gfpflags);
> +	return ret;
> +}
> +EXPORT_SYMBOL(kmalloc_node_trace);
> +
>  static noinline void free_to_partial_list(
>  	struct kmem_cache *s, struct slab *slab,
>  	void *head, void *tail, int bulk_cnt,
> 
> -- 

Looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> 2.42.1
> 
> 


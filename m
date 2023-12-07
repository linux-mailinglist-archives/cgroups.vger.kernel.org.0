Return-Path: <cgroups+bounces-882-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EB2807E88
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 03:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60DFC1F21A7E
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 02:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA6B1868;
	Thu,  7 Dec 2023 02:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPOCQtJ1"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522E4D4B;
	Wed,  6 Dec 2023 18:32:37 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1f5bd86ceb3so307917fac.2;
        Wed, 06 Dec 2023 18:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701916356; x=1702521156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ETvtz3rEq8y5ZHvBBRevwO8n4qMHcpeDzavyr8b+04g=;
        b=NPOCQtJ130mVhb5Vy+YoeByJRP0B4YaFkCIU8yHpKMNZ9i4hPrWgDkVjRnfwol3iRr
         bM/d0Ro1VzZPEviNAfSs8dAb49jpGX9XeBQUjB/m0xIvBaziQ7asicPfIv3JUkbaNFQ6
         RjuOVZpDfmXbPJwpMxasG27x+UFjOnyeYPesXLANWbO/pqP++xjMN/M66wEmb7FAr8R3
         x+qBZ3khjQ5/PyZOTK4eaBD+GYnlcyvTmiitGqLTWKtyXJuQGXlkto0//G6nys4W8dF9
         5Ko6T/lUBIbqCwHJ6HMKZk9r5DugJrJ7Gm2vsNpuChVC97/y/Gj9869tAH7nMMQ7D7Sk
         /gfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701916356; x=1702521156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETvtz3rEq8y5ZHvBBRevwO8n4qMHcpeDzavyr8b+04g=;
        b=uFN9SQ+lF7drT8tfuUdY0g0NuXxpobeS2sVCAC95LrPlBVl4YVD0lLY149LkToR8/Y
         pyV5J0Nsv6Uqxbtqx91DuyL/z3d+0AfdP0P9/dOiw2b718XyosX5jk+dEfb+euCyv2si
         XeEfLOxjuqdrykQ/kq7aEJ/6hsOPw7I0nK2Jv66ur7azHnfwxlssk3PJ16GOLseCQR43
         WmhBeQnmBveu0f66KFhs5ProDuRMjqVy25XUwFYihMYa4heeFYSjgxtywqhHQ0b6OmhZ
         LbkisRkdmK8FNRdCATLMyG4DQ88a0jwuimXyZ9aAx6EFqNvjTA3EqUaag8BVfiBOFCAp
         kmeQ==
X-Gm-Message-State: AOJu0Yyst8CHg4jpMVsXLxcQMj2cX62CREuMkaWZ1CXDdbiEO1d5BM0C
	afzEkonuAERKrJ8g1jAg6e8=
X-Google-Smtp-Source: AGHT+IFhomdac9DZ2rxPUWMaIR1/wt3h2XJFmm+ErXjfJhRGagXQaC+OJI0pfIyYTN+084ixsrR/wQ==
X-Received: by 2002:a05:6870:d93:b0:1fb:75b:2fd1 with SMTP id mj19-20020a0568700d9300b001fb075b2fd1mr2039607oab.104.1701916356157;
        Wed, 06 Dec 2023 18:32:36 -0800 (PST)
Received: from localhost.localdomain ([1.245.180.67])
        by smtp.gmail.com with ESMTPSA id c192-20020a6335c9000000b005c60ad6c4absm168730pga.4.2023.12.06.18.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 18:32:35 -0800 (PST)
Date: Thu, 7 Dec 2023 11:32:12 +0900
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
Subject: Re: [PATCH v2 20/21] mm/slub: optimize alloc fastpath code layout
Message-ID: <ZXEurG+jk62uNgRK@localhost.localdomain>
References: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
 <20231120-slab-remove-slab-v2-20-9c9c70177183@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120-slab-remove-slab-v2-20-9c9c70177183@suse.cz>

On Mon, Nov 20, 2023 at 07:34:31PM +0100, Vlastimil Babka wrote:
> With allocation fastpaths no longer divided between two .c files, we
> have better inlining, however checking the disassembly of
> kmem_cache_alloc() reveals we can do better to make the fastpaths
> smaller and move the less common situations out of line or to separate
> functions, to reduce instruction cache pressure.
> 
> - split memcg pre/post alloc hooks to inlined checks that use likely()
>   to assume there will be no objcg handling necessary, and non-inline
>   functions doing the actual handling
> 
> - add some more likely/unlikely() to pre/post alloc hooks to indicate
>   which scenarios should be out of line
> 
> - change gfp_allowed_mask handling in slab_post_alloc_hook() so the
>   code can be optimized away when kasan/kmsan/kmemleak is configured out
> 
> bloat-o-meter shows:
> add/remove: 4/2 grow/shrink: 1/8 up/down: 521/-2924 (-2403)
> Function                                     old     new   delta
> __memcg_slab_post_alloc_hook                   -     461    +461
> kmem_cache_alloc_bulk                        775     791     +16
> __pfx_should_failslab.constprop                -      16     +16
> __pfx___memcg_slab_post_alloc_hook             -      16     +16
> should_failslab.constprop                      -      12     +12
> __pfx_memcg_slab_post_alloc_hook              16       -     -16
> kmem_cache_alloc_lru                        1295    1023    -272
> kmem_cache_alloc_node                       1118     817    -301
> kmem_cache_alloc                            1076     772    -304
> kmalloc_node_trace                          1149     838    -311
> kmalloc_trace                               1102     789    -313
> __kmalloc_node_track_caller                 1393    1080    -313
> __kmalloc_node                              1397    1082    -315
> __kmalloc                                   1374    1059    -315
> memcg_slab_post_alloc_hook                   464       -    -464
> 
> Note that gcc still decided to inline __memcg_pre_alloc_hook(), but the
> code is out of line. Forcing noinline did not improve the results. As a
> result the fastpaths are shorter and overal code size is reduced.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 89 ++++++++++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 54 insertions(+), 35 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 5683f1d02e4f..77d259f3d592 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1866,25 +1866,17 @@ static inline size_t obj_full_size(struct kmem_cache *s)
>  /*
>   * Returns false if the allocation should fail.
>   */
> -static inline bool memcg_slab_pre_alloc_hook(struct kmem_cache *s,
> -					     struct list_lru *lru,
> -					     struct obj_cgroup **objcgp,
> -					     size_t objects, gfp_t flags)
> +static bool __memcg_slab_pre_alloc_hook(struct kmem_cache *s,
> +					struct list_lru *lru,
> +					struct obj_cgroup **objcgp,
> +					size_t objects, gfp_t flags)
>  {
> -	struct obj_cgroup *objcg;
> -
> -	if (!memcg_kmem_online())
> -		return true;
> -
> -	if (!(flags & __GFP_ACCOUNT) && !(s->flags & SLAB_ACCOUNT))
> -		return true;
> -
>  	/*
>  	 * The obtained objcg pointer is safe to use within the current scope,
>  	 * defined by current task or set_active_memcg() pair.
>  	 * obj_cgroup_get() is used to get a permanent reference.
>  	 */
> -	objcg = current_obj_cgroup();
> +	struct obj_cgroup *objcg = current_obj_cgroup();
>  	if (!objcg)
>  		return true;
>  
> @@ -1907,17 +1899,34 @@ static inline bool memcg_slab_pre_alloc_hook(struct kmem_cache *s,
>  	return true;
>  }
>  
> -static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
> -					      struct obj_cgroup *objcg,
> -					      gfp_t flags, size_t size,
> -					      void **p)
> +/*
> + * Returns false if the allocation should fail.
> + */
> +static __fastpath_inline
> +bool memcg_slab_pre_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
> +			       struct obj_cgroup **objcgp, size_t objects,
> +			       gfp_t flags)
> +{
> +	if (!memcg_kmem_online())
> +		return true;
> +
> +	if (likely(!(flags & __GFP_ACCOUNT) && !(s->flags & SLAB_ACCOUNT)))
> +		return true;
> +
> +	return likely(__memcg_slab_pre_alloc_hook(s, lru, objcgp, objects,
> +						  flags));
> +}
> +
> +static void __memcg_slab_post_alloc_hook(struct kmem_cache *s,
> +					 struct obj_cgroup *objcg,
> +					 gfp_t flags, size_t size,
> +					 void **p)
>  {
>  	struct slab *slab;
>  	unsigned long off;
>  	size_t i;
>  
> -	if (!memcg_kmem_online() || !objcg)
> -		return;
> +	flags &= gfp_allowed_mask;
>  
>  	for (i = 0; i < size; i++) {
>  		if (likely(p[i])) {
> @@ -1940,6 +1949,16 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
>  	}
>  }
>  
> +static __fastpath_inline
> +void memcg_slab_post_alloc_hook(struct kmem_cache *s, struct obj_cgroup *objcg,
> +				gfp_t flags, size_t size, void **p)
> +{
> +	if (likely(!memcg_kmem_online() || !objcg))
> +		return;
> +
> +	return __memcg_slab_post_alloc_hook(s, objcg, flags, size, p);
> +}
> +
>  static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
>  					void **p, int objects)
>  {
> @@ -3709,34 +3728,34 @@ noinline int should_failslab(struct kmem_cache *s, gfp_t gfpflags)
>  }
>  ALLOW_ERROR_INJECTION(should_failslab, ERRNO);
>  
> -static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
> -						     struct list_lru *lru,
> -						     struct obj_cgroup **objcgp,
> -						     size_t size, gfp_t flags)
> +static __fastpath_inline
> +struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
> +				       struct list_lru *lru,
> +				       struct obj_cgroup **objcgp,
> +				       size_t size, gfp_t flags)
>  {
>  	flags &= gfp_allowed_mask;
>  
>  	might_alloc(flags);
>  
> -	if (should_failslab(s, flags))
> +	if (unlikely(should_failslab(s, flags)))
>  		return NULL;
>  
> -	if (!memcg_slab_pre_alloc_hook(s, lru, objcgp, size, flags))
> +	if (unlikely(!memcg_slab_pre_alloc_hook(s, lru, objcgp, size, flags)))
>  		return NULL;
>  
>  	return s;
>  }
>  
> -static inline void slab_post_alloc_hook(struct kmem_cache *s,
> -					struct obj_cgroup *objcg, gfp_t flags,
> -					size_t size, void **p, bool init,
> -					unsigned int orig_size)
> +static __fastpath_inline
> +void slab_post_alloc_hook(struct kmem_cache *s,	struct obj_cgroup *objcg,
> +			  gfp_t flags, size_t size, void **p, bool init,
> +			  unsigned int orig_size)
>  {
>  	unsigned int zero_size = s->object_size;
>  	bool kasan_init = init;
>  	size_t i;
> -
> -	flags &= gfp_allowed_mask;
> +	gfp_t init_flags = flags & gfp_allowed_mask;
>  
>  	/*
>  	 * For kmalloc object, the allocated memory size(object_size) is likely
> @@ -3769,13 +3788,13 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
>  	 * As p[i] might get tagged, memset and kmemleak hook come after KASAN.
>  	 */
>  	for (i = 0; i < size; i++) {
> -		p[i] = kasan_slab_alloc(s, p[i], flags, kasan_init);
> +		p[i] = kasan_slab_alloc(s, p[i], init_flags, kasan_init);
>  		if (p[i] && init && (!kasan_init ||
>  				     !kasan_has_integrated_init()))
>  			memset(p[i], 0, zero_size);
>  		kmemleak_alloc_recursive(p[i], s->object_size, 1,
> -					 s->flags, flags);
> -		kmsan_slab_alloc(s, p[i], flags);
> +					 s->flags, init_flags);
> +		kmsan_slab_alloc(s, p[i], init_flags);
>  	}
>  
>  	memcg_slab_post_alloc_hook(s, objcg, flags, size, p);
> @@ -3799,7 +3818,7 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
>  	bool init = false;
>  
>  	s = slab_pre_alloc_hook(s, lru, &objcg, 1, gfpflags);
> -	if (!s)
> +	if (unlikely(!s))
>  		return NULL;
>  
>  	object = kfence_alloc(s, orig_size, gfpflags);
> 
> -- 

Looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> 2.42.1
> 
> 


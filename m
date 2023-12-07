Return-Path: <cgroups+bounces-884-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C743E807EBA
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 03:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 616D328264C
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 02:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B8F62D;
	Thu,  7 Dec 2023 02:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgiFiSVI"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FFAD5E;
	Wed,  6 Dec 2023 18:40:15 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6ce6caedce6so147486b3a.3;
        Wed, 06 Dec 2023 18:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701916814; x=1702521614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CjGR+gix1XQRxaJ5p7IMY1S7CLbhofOgFFoOucSld8k=;
        b=FgiFiSVIWYuZAXOi9ywgWfJl2OcRi3OVnj4BY4f1INUoulTPxFtwsYLZAtx1oAhTPR
         CuFVDDHYus/RIP0/nDDMSjxWTVK+REDu5P+6fpicNdwLNMXawtje0+1d+xpztLNvVRjy
         58R2O0+9tW6G8SPCTE474skVXMOePlMbYV1LTR3yNQRpJtpbYELZAcycx+hgZNUu6ZoB
         LlV7PvdY/huazd3H1QUntLaanccCFLLLch9EhR39XBxszty5h7I8Vl00n/9H7q7/fFIY
         9ZEzt1WtuLPXdKZEYjXo6eoX6r8xUhh0J0HUYgHKHHmUUN2Rx6BDkFhQizx67xyYzIgK
         sVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701916814; x=1702521614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjGR+gix1XQRxaJ5p7IMY1S7CLbhofOgFFoOucSld8k=;
        b=Zq3pv92HmRtTvmdcmG8sxPDrVNz3CIxz6pUP//0IHWxyNuBvTskvenQAx58F9mYikE
         fiosgOuoiYGSH4wOUt97IC5/U2zrwZRhMwgJa3Wd2BnIr66GceuN9Epmj1c3IOgbMIzE
         KAY9agetFj9/2akjYrGPNx+TjTfmSAmUerXdDvKkZ+sEN4PQ94f/YBSYQSOavVIjsrxE
         L46+EA+LBhMRW4L6XxlvjX6Nh1lCTFIu+yS+vj0UPpXGruop44i7LTaAe2SvUQ+L1yWT
         vcfy3TIkOXFONq/4StWDQ1QduaOJsWReFyVwYnNTST86X9tWEhVti9mKGL4b3LiKaizf
         ojFw==
X-Gm-Message-State: AOJu0Yzj+/qc9U5M2LA6bArebTOH1uCSMnZqZuMmRHlRM2VrfhSoyYq8
	IOu+anD4bQJ6eQVsgMMEaew=
X-Google-Smtp-Source: AGHT+IG4OHX+SeQcJYhn0alXQOImary9hj1xbJZTveWssuMvLq90907J7Mp6IPQ+vyVQWr7sJuLFKw==
X-Received: by 2002:a05:6a20:1593:b0:18f:97c:4f3b with SMTP id h19-20020a056a20159300b0018f097c4f3bmr1673961pzj.71.1701916814237;
        Wed, 06 Dec 2023 18:40:14 -0800 (PST)
Received: from localhost.localdomain ([1.245.180.67])
        by smtp.gmail.com with ESMTPSA id pl16-20020a17090b269000b0028652f98978sm121526pjb.8.2023.12.06.18.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 18:40:13 -0800 (PST)
Date: Thu, 7 Dec 2023 11:40:05 +0900
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
Subject: Re: [PATCH v2 21/21] mm/slub: optimize free fast path code layout
Message-ID: <ZXEwhbDgESjPs/vh@localhost.localdomain>
References: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
 <20231120-slab-remove-slab-v2-21-9c9c70177183@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120-slab-remove-slab-v2-21-9c9c70177183@suse.cz>

On Mon, Nov 20, 2023 at 07:34:32PM +0100, Vlastimil Babka wrote:
> Inspection of kmem_cache_free() disassembly showed we could make the
> fast path smaller by providing few more hints to the compiler, and
> splitting the memcg_slab_free_hook() into an inline part that only
> checks if there's work to do, and an out of line part doing the actual
> uncharge.
> 
> bloat-o-meter results:
> add/remove: 2/0 grow/shrink: 0/3 up/down: 286/-554 (-268)
> Function                                     old     new   delta
> __memcg_slab_free_hook                         -     270    +270
> __pfx___memcg_slab_free_hook                   -      16     +16
> kfree                                        828     665    -163
> kmem_cache_free                             1116     948    -168
> kmem_cache_free_bulk.part                   1701    1478    -223
> 
> Checking kmem_cache_free() disassembly now shows the non-fastpath
> cases are handled out of line, which should reduce instruction cache
> usage.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 40 ++++++++++++++++++++++++----------------
>  1 file changed, 24 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 77d259f3d592..3f8b95757106 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1959,20 +1959,11 @@ void memcg_slab_post_alloc_hook(struct kmem_cache *s, struct obj_cgroup *objcg,
>  	return __memcg_slab_post_alloc_hook(s, objcg, flags, size, p);
>  }
>  
> -static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
> -					void **p, int objects)
> +static void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
> +				   void **p, int objects,
> +				   struct obj_cgroup **objcgs)
>  {
> -	struct obj_cgroup **objcgs;
> -	int i;
> -
> -	if (!memcg_kmem_online())
> -		return;
> -
> -	objcgs = slab_objcgs(slab);
> -	if (!objcgs)
> -		return;
> -
> -	for (i = 0; i < objects; i++) {
> +	for (int i = 0; i < objects; i++) {
>  		struct obj_cgroup *objcg;
>  		unsigned int off;
>  
> @@ -1988,6 +1979,22 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
>  		obj_cgroup_put(objcg);
>  	}
>  }
> +
> +static __fastpath_inline
> +void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
> +			  int objects)
> +{
> +	struct obj_cgroup **objcgs;
> +
> +	if (!memcg_kmem_online())
> +		return;
> +
> +	objcgs = slab_objcgs(slab);
> +	if (likely(!objcgs))
> +		return;
> +
> +	__memcg_slab_free_hook(s, slab, p, objects, objcgs);
> +}
>  #else /* CONFIG_MEMCG_KMEM */
>  static inline struct mem_cgroup *memcg_from_slab_obj(void *ptr)
>  {
> @@ -2047,7 +2054,7 @@ static __always_inline bool slab_free_hook(struct kmem_cache *s,
>  	 * The initialization memset's clear the object and the metadata,
>  	 * but don't touch the SLAB redzone.
>  	 */
> -	if (init) {
> +	if (unlikely(init)) {
>  		int rsize;
>  
>  		if (!kasan_has_integrated_init())
> @@ -2083,7 +2090,8 @@ static inline bool slab_free_freelist_hook(struct kmem_cache *s,
>  		next = get_freepointer(s, object);
>  
>  		/* If object's reuse doesn't have to be delayed */
> -		if (!slab_free_hook(s, object, slab_want_init_on_free(s))) {
> +		if (likely(!slab_free_hook(s, object,
> +					   slab_want_init_on_free(s)))) {
>  			/* Move object to the new freelist */
>  			set_freepointer(s, object, *head);
>  			*head = object;
> @@ -4282,7 +4290,7 @@ static __fastpath_inline void slab_free(struct kmem_cache *s, struct slab *slab,
>  	 * With KASAN enabled slab_free_freelist_hook modifies the freelist
>  	 * to remove objects, whose reuse must be delayed.
>  	 */
> -	if (slab_free_freelist_hook(s, &head, &tail, &cnt))
> +	if (likely(slab_free_freelist_hook(s, &head, &tail, &cnt)))
>  		do_slab_free(s, slab, head, tail, cnt, addr);
>  }
>  
> 
> -- 

Looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> 2.42.1
> 
> 


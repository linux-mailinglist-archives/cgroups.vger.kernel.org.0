Return-Path: <cgroups+bounces-877-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 395CC807D7C
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 02:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3756E1C211A3
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 01:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EDE7F3;
	Thu,  7 Dec 2023 01:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lINBcacf"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8934E12F;
	Wed,  6 Dec 2023 17:00:04 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1d0c4d84bf6so2810175ad.1;
        Wed, 06 Dec 2023 17:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701910804; x=1702515604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zsGIjCFU5lyJ4K017s44uK87gjwXDiMcgnBYCQQOfWs=;
        b=lINBcacfxnxuiWvWQXj0W+WxuwWJZcRS4E1pFDRFj9Rp2ffqxOLBhS5qUxFKBHdbaY
         9eJm5+FsWBIz+vwqFiLl2Ema5HUwgkacopsyYhgiSrB0TYVUxNG8/YdK0UXtyKPp327T
         HnnBOofRvNIwRYQjstN8JvfEXrOiBtAuORKGvYcDLLvB4rV4oC/x+cxyrfCQ/I2USKgx
         XWLazA9Koy7dJABRAIllCrTnCuTNxWHBeRJAH2O9FHkGtlZcFvcXxYZ2rPtiwaDg+0W4
         0LbKcfeBxQNL023NksaQnsrY4FJlpHUK1elsHfWQBPsFxni1SzuJJrGR3bW/vNYlV8ch
         skNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701910804; x=1702515604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsGIjCFU5lyJ4K017s44uK87gjwXDiMcgnBYCQQOfWs=;
        b=YSgJKDDHmDpRRjd40RGGjb+giaPvr2dD4e8RSzMb9HDpLqFAIR8lagEj0App4ldmx6
         aj+c2FL5gtw5dOK/EOFez+EMcvY1dG7puPxAWlUt0NBTUM0iwjUET+F/mM23XtKkQxz8
         QJlnyqOyGyt1uTcuBbD28+5PxXEAyYpf+2lsYYyBlxaJM8cbf2Q+absFrD4ynu96vSbV
         weCL1nb0JHkjsgIGydgZ+e6Cj7xWWtK51pCO2d73A56Lm8h7/0r9VKnWEmns/MK6FdZk
         0attlsLwKveQ9BEaTyzJt9lUHtZ+GOn3vr2ufjQdoNojcc0pS3GWHWi7TmZUof5H8cZ0
         GSwA==
X-Gm-Message-State: AOJu0YzfGGrRabTC6QBV+WBK8UQndYrFGpI8Dx97pU/EXp/0tGtKF/Jf
	2zpsWud+JyLllQ+vMY7PYSw=
X-Google-Smtp-Source: AGHT+IEYT0meh5v4+cOmVkY4VpOtcJCuZrKmOhAfrzrneCN6WNofRmsINq37W873FAiLxM6nhzFaGw==
X-Received: by 2002:a17:903:2642:b0:1d0:6ffd:f214 with SMTP id je2-20020a170903264200b001d06ffdf214mr1476793plb.106.1701910803148;
        Wed, 06 Dec 2023 17:00:03 -0800 (PST)
Received: from localhost.localdomain ([1.245.180.67])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902bd4600b001d0af279a1fsm70671plx.182.2023.12.06.16.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 17:00:02 -0800 (PST)
Date: Thu, 7 Dec 2023 09:59:46 +0900
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
	cgroups@vger.kernel.org, linux-hardening@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2 14/21] mm/slab: move memcg related functions from
 slab.h to slub.c
Message-ID: <ZXEZAnHBJpAi8Sdy@localhost.localdomain>
References: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
 <20231120-slab-remove-slab-v2-14-9c9c70177183@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120-slab-remove-slab-v2-14-9c9c70177183@suse.cz>

On Mon, Nov 20, 2023 at 07:34:25PM +0100, Vlastimil Babka wrote:
> We don't share those between SLAB and SLUB anymore, so most memcg
> related functions can be moved to slub.c proper.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slab.h | 206 --------------------------------------------------------------
>  mm/slub.c | 205 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 205 insertions(+), 206 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 65ebf86b3fe9..a81ef7c9282d 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -486,12 +486,6 @@ void slabinfo_show_stats(struct seq_file *m, struct kmem_cache *s);
>  ssize_t slabinfo_write(struct file *file, const char __user *buffer,
>  		       size_t count, loff_t *ppos);
>  
> -static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
> -{
> -	return (s->flags & SLAB_RECLAIM_ACCOUNT) ?
> -		NR_SLAB_RECLAIMABLE_B : NR_SLAB_UNRECLAIMABLE_B;
> -}
> -
>  #ifdef CONFIG_SLUB_DEBUG
>  #ifdef CONFIG_SLUB_DEBUG_ON
>  DECLARE_STATIC_KEY_TRUE(slub_debug_enabled);
> @@ -551,220 +545,20 @@ int memcg_alloc_slab_cgroups(struct slab *slab, struct kmem_cache *s,
>  				 gfp_t gfp, bool new_slab);
>  void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
>  		     enum node_stat_item idx, int nr);
> -
> -static inline void memcg_free_slab_cgroups(struct slab *slab)
> -{
> -	kfree(slab_objcgs(slab));
> -	slab->memcg_data = 0;
> -}
> -
> -static inline size_t obj_full_size(struct kmem_cache *s)
> -{
> -	/*
> -	 * For each accounted object there is an extra space which is used
> -	 * to store obj_cgroup membership. Charge it too.
> -	 */
> -	return s->size + sizeof(struct obj_cgroup *);
> -}
> -
> -/*
> - * Returns false if the allocation should fail.
> - */
> -static inline bool memcg_slab_pre_alloc_hook(struct kmem_cache *s,
> -					     struct list_lru *lru,
> -					     struct obj_cgroup **objcgp,
> -					     size_t objects, gfp_t flags)
> -{
> -	struct obj_cgroup *objcg;
> -
> -	if (!memcg_kmem_online())
> -		return true;
> -
> -	if (!(flags & __GFP_ACCOUNT) && !(s->flags & SLAB_ACCOUNT))
> -		return true;
> -
> -	/*
> -	 * The obtained objcg pointer is safe to use within the current scope,
> -	 * defined by current task or set_active_memcg() pair.
> -	 * obj_cgroup_get() is used to get a permanent reference.
> -	 */
> -	objcg = current_obj_cgroup();
> -	if (!objcg)
> -		return true;
> -
> -	if (lru) {
> -		int ret;
> -		struct mem_cgroup *memcg;
> -
> -		memcg = get_mem_cgroup_from_objcg(objcg);
> -		ret = memcg_list_lru_alloc(memcg, lru, flags);
> -		css_put(&memcg->css);
> -
> -		if (ret)
> -			return false;
> -	}
> -
> -	if (obj_cgroup_charge(objcg, flags, objects * obj_full_size(s)))
> -		return false;
> -
> -	*objcgp = objcg;
> -	return true;
> -}
> -
> -static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
> -					      struct obj_cgroup *objcg,
> -					      gfp_t flags, size_t size,
> -					      void **p)
> -{
> -	struct slab *slab;
> -	unsigned long off;
> -	size_t i;
> -
> -	if (!memcg_kmem_online() || !objcg)
> -		return;
> -
> -	for (i = 0; i < size; i++) {
> -		if (likely(p[i])) {
> -			slab = virt_to_slab(p[i]);
> -
> -			if (!slab_objcgs(slab) &&
> -			    memcg_alloc_slab_cgroups(slab, s, flags,
> -							 false)) {
> -				obj_cgroup_uncharge(objcg, obj_full_size(s));
> -				continue;
> -			}
> -
> -			off = obj_to_index(s, slab, p[i]);
> -			obj_cgroup_get(objcg);
> -			slab_objcgs(slab)[off] = objcg;
> -			mod_objcg_state(objcg, slab_pgdat(slab),
> -					cache_vmstat_idx(s), obj_full_size(s));
> -		} else {
> -			obj_cgroup_uncharge(objcg, obj_full_size(s));
> -		}
> -	}
> -}
> -
> -static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
> -					void **p, int objects)
> -{
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
> -		struct obj_cgroup *objcg;
> -		unsigned int off;
> -
> -		off = obj_to_index(s, slab, p[i]);
> -		objcg = objcgs[off];
> -		if (!objcg)
> -			continue;
> -
> -		objcgs[off] = NULL;
> -		obj_cgroup_uncharge(objcg, obj_full_size(s));
> -		mod_objcg_state(objcg, slab_pgdat(slab), cache_vmstat_idx(s),
> -				-obj_full_size(s));
> -		obj_cgroup_put(objcg);
> -	}
> -}
> -
>  #else /* CONFIG_MEMCG_KMEM */
>  static inline struct obj_cgroup **slab_objcgs(struct slab *slab)
>  {
>  	return NULL;
>  }
>  
> -static inline struct mem_cgroup *memcg_from_slab_obj(void *ptr)
> -{
> -	return NULL;
> -}
> -
>  static inline int memcg_alloc_slab_cgroups(struct slab *slab,
>  					       struct kmem_cache *s, gfp_t gfp,
>  					       bool new_slab)
>  {
>  	return 0;
>  }
> -
> -static inline void memcg_free_slab_cgroups(struct slab *slab)
> -{
> -}
> -
> -static inline bool memcg_slab_pre_alloc_hook(struct kmem_cache *s,
> -					     struct list_lru *lru,
> -					     struct obj_cgroup **objcgp,
> -					     size_t objects, gfp_t flags)
> -{
> -	return true;
> -}
> -
> -static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
> -					      struct obj_cgroup *objcg,
> -					      gfp_t flags, size_t size,
> -					      void **p)
> -{
> -}
> -
> -static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
> -					void **p, int objects)
> -{
> -}
>  #endif /* CONFIG_MEMCG_KMEM */
>  
> -static inline struct kmem_cache *virt_to_cache(const void *obj)
> -{
> -	struct slab *slab;
> -
> -	slab = virt_to_slab(obj);
> -	if (WARN_ONCE(!slab, "%s: Object is not a Slab page!\n",
> -					__func__))
> -		return NULL;
> -	return slab->slab_cache;
> -}
> -
> -static __always_inline void account_slab(struct slab *slab, int order,
> -					 struct kmem_cache *s, gfp_t gfp)
> -{
> -	if (memcg_kmem_online() && (s->flags & SLAB_ACCOUNT))
> -		memcg_alloc_slab_cgroups(slab, s, gfp, true);
> -
> -	mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
> -			    PAGE_SIZE << order);
> -}
> -
> -static __always_inline void unaccount_slab(struct slab *slab, int order,
> -					   struct kmem_cache *s)
> -{
> -	if (memcg_kmem_online())
> -		memcg_free_slab_cgroups(slab);
> -
> -	mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
> -			    -(PAGE_SIZE << order));
> -}
> -
> -static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
> -{
> -	struct kmem_cache *cachep;
> -
> -	if (!IS_ENABLED(CONFIG_SLAB_FREELIST_HARDENED) &&
> -	    !kmem_cache_debug_flags(s, SLAB_CONSISTENCY_CHECKS))
> -		return s;
> -
> -	cachep = virt_to_cache(x);
> -	if (WARN(cachep && cachep != s,
> -		  "%s: Wrong slab cache. %s but object is from %s\n",
> -		  __func__, s->name, cachep->name))
> -		print_tracking(cachep, x);
> -	return cachep;
> -}
> -
>  void free_large_kmalloc(struct folio *folio, void *object);
>  
>  size_t __ksize(const void *objp);
> diff --git a/mm/slub.c b/mm/slub.c
> index 9eb6508152c2..844e0beb84ee 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1814,6 +1814,165 @@ static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
>  #endif
>  #endif /* CONFIG_SLUB_DEBUG */
>  
> +static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
> +{
> +	return (s->flags & SLAB_RECLAIM_ACCOUNT) ?
> +		NR_SLAB_RECLAIMABLE_B : NR_SLAB_UNRECLAIMABLE_B;
> +}
> +
> +#ifdef CONFIG_MEMCG_KMEM
> +static inline void memcg_free_slab_cgroups(struct slab *slab)
> +{
> +	kfree(slab_objcgs(slab));
> +	slab->memcg_data = 0;
> +}
> +
> +static inline size_t obj_full_size(struct kmem_cache *s)
> +{
> +	/*
> +	 * For each accounted object there is an extra space which is used
> +	 * to store obj_cgroup membership. Charge it too.
> +	 */
> +	return s->size + sizeof(struct obj_cgroup *);
> +}
> +
> +/*
> + * Returns false if the allocation should fail.
> + */
> +static inline bool memcg_slab_pre_alloc_hook(struct kmem_cache *s,
> +					     struct list_lru *lru,
> +					     struct obj_cgroup **objcgp,
> +					     size_t objects, gfp_t flags)
> +{
> +	struct obj_cgroup *objcg;
> +
> +	if (!memcg_kmem_online())
> +		return true;
> +
> +	if (!(flags & __GFP_ACCOUNT) && !(s->flags & SLAB_ACCOUNT))
> +		return true;
> +
> +	/*
> +	 * The obtained objcg pointer is safe to use within the current scope,
> +	 * defined by current task or set_active_memcg() pair.
> +	 * obj_cgroup_get() is used to get a permanent reference.
> +	 */
> +	objcg = current_obj_cgroup();
> +	if (!objcg)
> +		return true;
> +
> +	if (lru) {
> +		int ret;
> +		struct mem_cgroup *memcg;
> +
> +		memcg = get_mem_cgroup_from_objcg(objcg);
> +		ret = memcg_list_lru_alloc(memcg, lru, flags);
> +		css_put(&memcg->css);
> +
> +		if (ret)
> +			return false;
> +	}
> +
> +	if (obj_cgroup_charge(objcg, flags, objects * obj_full_size(s)))
> +		return false;
> +
> +	*objcgp = objcg;
> +	return true;
> +}
> +
> +static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
> +					      struct obj_cgroup *objcg,
> +					      gfp_t flags, size_t size,
> +					      void **p)
> +{
> +	struct slab *slab;
> +	unsigned long off;
> +	size_t i;
> +
> +	if (!memcg_kmem_online() || !objcg)
> +		return;
> +
> +	for (i = 0; i < size; i++) {
> +		if (likely(p[i])) {
> +			slab = virt_to_slab(p[i]);
> +
> +			if (!slab_objcgs(slab) &&
> +			    memcg_alloc_slab_cgroups(slab, s, flags, false)) {
> +				obj_cgroup_uncharge(objcg, obj_full_size(s));
> +				continue;
> +			}
> +
> +			off = obj_to_index(s, slab, p[i]);
> +			obj_cgroup_get(objcg);
> +			slab_objcgs(slab)[off] = objcg;
> +			mod_objcg_state(objcg, slab_pgdat(slab),
> +					cache_vmstat_idx(s), obj_full_size(s));
> +		} else {
> +			obj_cgroup_uncharge(objcg, obj_full_size(s));
> +		}
> +	}
> +}
> +
> +static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
> +					void **p, int objects)
> +{
> +	struct obj_cgroup **objcgs;
> +	int i;
> +
> +	if (!memcg_kmem_online())
> +		return;
> +
> +	objcgs = slab_objcgs(slab);
> +	if (!objcgs)
> +		return;
> +
> +	for (i = 0; i < objects; i++) {
> +		struct obj_cgroup *objcg;
> +		unsigned int off;
> +
> +		off = obj_to_index(s, slab, p[i]);
> +		objcg = objcgs[off];
> +		if (!objcg)
> +			continue;
> +
> +		objcgs[off] = NULL;
> +		obj_cgroup_uncharge(objcg, obj_full_size(s));
> +		mod_objcg_state(objcg, slab_pgdat(slab), cache_vmstat_idx(s),
> +				-obj_full_size(s));
> +		obj_cgroup_put(objcg);
> +	}
> +}
> +#else /* CONFIG_MEMCG_KMEM */
> +static inline struct mem_cgroup *memcg_from_slab_obj(void *ptr)
> +{
> +	return NULL;
> +}
> +
> +static inline void memcg_free_slab_cgroups(struct slab *slab)
> +{
> +}
> +
> +static inline bool memcg_slab_pre_alloc_hook(struct kmem_cache *s,
> +					     struct list_lru *lru,
> +					     struct obj_cgroup **objcgp,
> +					     size_t objects, gfp_t flags)
> +{
> +	return true;
> +}
> +
> +static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
> +					      struct obj_cgroup *objcg,
> +					      gfp_t flags, size_t size,
> +					      void **p)
> +{
> +}
> +
> +static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
> +					void **p, int objects)
> +{
> +}
> +#endif /* CONFIG_MEMCG_KMEM */
> +
>  /*
>   * Hooks for other subsystems that check memory allocations. In a typical
>   * production configuration these hooks all should produce no code at all.
> @@ -2048,6 +2207,26 @@ static inline bool shuffle_freelist(struct kmem_cache *s, struct slab *slab)
>  }
>  #endif /* CONFIG_SLAB_FREELIST_RANDOM */
>  
> +static __always_inline void account_slab(struct slab *slab, int order,
> +					 struct kmem_cache *s, gfp_t gfp)
> +{
> +	if (memcg_kmem_online() && (s->flags & SLAB_ACCOUNT))
> +		memcg_alloc_slab_cgroups(slab, s, gfp, true);
> +
> +	mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
> +			    PAGE_SIZE << order);
> +}
> +
> +static __always_inline void unaccount_slab(struct slab *slab, int order,
> +					   struct kmem_cache *s)
> +{
> +	if (memcg_kmem_online())
> +		memcg_free_slab_cgroups(slab);
> +
> +	mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
> +			    -(PAGE_SIZE << order));
> +}
> +
>  static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
>  {
>  	struct slab *slab;
> @@ -3965,6 +4144,32 @@ void ___cache_free(struct kmem_cache *cache, void *x, unsigned long addr)
>  }
>  #endif
>  
> +static inline struct kmem_cache *virt_to_cache(const void *obj)
> +{
> +	struct slab *slab;
> +
> +	slab = virt_to_slab(obj);
> +	if (WARN_ONCE(!slab, "%s: Object is not a Slab page!\n", __func__))
> +		return NULL;
> +	return slab->slab_cache;
> +}
> +
> +static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
> +{
> +	struct kmem_cache *cachep;
> +
> +	if (!IS_ENABLED(CONFIG_SLAB_FREELIST_HARDENED) &&
> +	    !kmem_cache_debug_flags(s, SLAB_CONSISTENCY_CHECKS))
> +		return s;
> +
> +	cachep = virt_to_cache(x);
> +	if (WARN(cachep && cachep != s,
> +		 "%s: Wrong slab cache. %s but object is from %s\n",
> +		 __func__, s->name, cachep->name))
> +		print_tracking(cachep, x);
> +	return cachep;
> +}
> +
>  void __kmem_cache_free(struct kmem_cache *s, void *x, unsigned long caller)
>  {
>  	slab_free(s, virt_to_slab(x), x, NULL, &x, 1, caller);
> 
> -- 

Looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> 2.42.1
> 
> 


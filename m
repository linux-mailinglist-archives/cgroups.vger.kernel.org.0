Return-Path: <cgroups+bounces-12942-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D83CFE712
	for <lists+cgroups@lfdr.de>; Wed, 07 Jan 2026 16:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7C7B23000DEF
	for <lists+cgroups@lfdr.de>; Wed,  7 Jan 2026 15:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DF13587DC;
	Wed,  7 Jan 2026 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tD414w/m"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14D93563CC;
	Wed,  7 Jan 2026 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767797677; cv=none; b=Xmz+CCXstXjHR8EofwMMyhQGh79gXZfaXCs5NcIcXiKdefD/7yt9Zw9MMV6fuifvXsK8NQrkuvoZwuGvNLTx0IHIXu3KhNAb3Yn1MsOtbNrp+1bX1LMmJUYUkjF9kNRORUmDvnlQKXcPrbaE4Fe9Urr7eoE2/MW20YuEu8LkhzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767797677; c=relaxed/simple;
	bh=LrPPGdstqjlvIyHJ5YmeKiIMvP1LrF7p7ujAU4bQrbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O09zdnW2iIZLj87Wk2QHxU26AYAFnX0Pj71LL/sWYEl67p2I/sU+OoD1dr7jpRIy0SNagJihN4HccZ/N/a7INKqrHIufIYIEilNa9fVtKeQNYcr2BsG6fHueSMPwP1lio/aJhBSeVD3hM9eWPg101cnoDWQfYoltQnnpXTcJNzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tD414w/m; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 7 Jan 2026 22:53:48 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767797662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Y0xU9Dbp20DUGDHu2Ggngi6mIEuMC7eQW0YVbkY+7w=;
	b=tD414w/mIde6l3B72sBn4u7OfuoErrciHo7366jQ9OQiSZdPl7UYhn3CD3s3k6cl6jtL9F
	YoVuWbqKH/iaKAHu9nY01AndMcOJLJn1SJRu0Z6xhmp1jfly3LvY0h4tOVrqk8UbJBCZD3
	+SJhBnie44tYPvVxQQghl1mJkAtZCVM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, andreyknvl@gmail.com, 
	cl@gentwo.org, dvyukov@google.com, glider@google.com, hannes@cmpxchg.org, 
	linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev, rientjes@google.com, 
	roman.gushchin@linux.dev, ryabinin.a.a@gmail.com, shakeel.butt@linux.dev, 
	surenb@google.com, vincenzo.frascino@arm.com, yeoreum.yun@arm.com, tytso@mit.edu, 
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org
Subject: Re: [PATCH V5 4/8] mm/slab: abstract slabobj_ext access via new
 slab_obj_ext() helper
Message-ID: <n6kyluk3nahdxytwek4ijzy4en6mc6ps7fjjgftww4ith7llom@cijm4who24w2>
References: <20260105080230.13171-1-harry.yoo@oracle.com>
 <20260105080230.13171-5-harry.yoo@oracle.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105080230.13171-5-harry.yoo@oracle.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jan 05, 2026 at 05:02:26PM +0900, Harry Yoo wrote:
> Currently, the slab allocator assumes that slab->obj_exts is a pointer
> to an array of struct slabobj_ext objects. However, to support storage
> methods where struct slabobj_ext is embedded within objects, the slab
> allocator should not make this assumption. Instead of directly
> dereferencing the slabobj_exts array, abstract access to
> struct slabobj_ext via helper functions.
> 
> Introduce a new API slabobj_ext metadata access:
> 
>   slab_obj_ext(slab, obj_exts, index) - returns the pointer to
>   struct slabobj_ext element at the given index.
> 
> Directly dereferencing the return value of slab_obj_exts() is no longer
> allowed. Instead, slab_obj_ext() must always be used to access
> individual struct slabobj_ext objects.
> 
> Convert all users to use these APIs.
> No functional changes intended.
> 
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>  mm/memcontrol.c | 23 +++++++++++++++-------
>  mm/slab.h       | 43 +++++++++++++++++++++++++++++++++++------
>  mm/slub.c       | 51 ++++++++++++++++++++++++++++---------------------
>  3 files changed, 82 insertions(+), 35 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index be810c1fbfc3..fd9105a953b0 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2596,7 +2596,8 @@ struct mem_cgroup *mem_cgroup_from_obj_slab(struct slab *slab, void *p)
>  	 * Memcg membership data for each individual object is saved in
>  	 * slab->obj_exts.
>  	 */
> -	struct slabobj_ext *obj_exts;
> +	unsigned long obj_exts;
> +	struct slabobj_ext *obj_ext;
>  	unsigned int off;
>  
>  	obj_exts = slab_obj_exts(slab);
> @@ -2604,8 +2605,9 @@ struct mem_cgroup *mem_cgroup_from_obj_slab(struct slab *slab, void *p)
>  		return NULL;
>  
>  	off = obj_to_index(slab->slab_cache, slab, p);
> -	if (obj_exts[off].objcg)
> -		return obj_cgroup_memcg(obj_exts[off].objcg);
> +	obj_ext = slab_obj_ext(slab, obj_exts, off);
> +	if (obj_ext->objcg)
> +		return obj_cgroup_memcg(obj_ext->objcg);
>  
>  	return NULL;
>  }
> @@ -3191,6 +3193,9 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
>  	}
>  
>  	for (i = 0; i < size; i++) {
> +		unsigned long obj_exts;
> +		struct slabobj_ext *obj_ext;
> +
>  		slab = virt_to_slab(p[i]);
>  
>  		if (!slab_obj_exts(slab) &&
> @@ -3213,29 +3218,33 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
>  					slab_pgdat(slab), cache_vmstat_idx(s)))
>  			return false;
>  
> +		obj_exts = slab_obj_exts(slab);
>  		off = obj_to_index(s, slab, p[i]);
> +		obj_ext = slab_obj_ext(slab, obj_exts, off);
>  		obj_cgroup_get(objcg);
> -		slab_obj_exts(slab)[off].objcg = objcg;
> +		obj_ext->objcg = objcg;
>  	}
>  
>  	return true;
>  }
>  
>  void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
> -			    void **p, int objects, struct slabobj_ext *obj_exts)
> +			    void **p, int objects, unsigned long obj_exts)
>  {
>  	size_t obj_size = obj_full_size(s);
>  
>  	for (int i = 0; i < objects; i++) {
>  		struct obj_cgroup *objcg;
> +		struct slabobj_ext *obj_ext;
>  		unsigned int off;
>  
>  		off = obj_to_index(s, slab, p[i]);
> -		objcg = obj_exts[off].objcg;
> +		obj_ext = slab_obj_ext(slab, obj_exts, off);
> +		objcg = obj_ext->objcg;
>  		if (!objcg)
>  			continue;
>  
> -		obj_exts[off].objcg = NULL;
> +		obj_ext->objcg = NULL;
>  		refill_obj_stock(objcg, obj_size, true, -obj_size,
>  				 slab_pgdat(slab), cache_vmstat_idx(s));
>  		obj_cgroup_put(objcg);
> diff --git a/mm/slab.h b/mm/slab.h
> index e767aa7e91b0..6bd8e018117d 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -509,10 +509,12 @@ static inline bool slab_in_kunit_test(void) { return false; }
>   * associated with a slab.
>   * @slab: a pointer to the slab struct
>   *
> - * Returns a pointer to the object extension vector associated with the slab,
> - * or NULL if no such vector has been associated yet.
> + * Returns the address of the object extension vector associated with the slab,
> + * or zero if no such vector has been associated yet.
> + * Do not dereference the return value directly; use slab_obj_ext() to access
> + * its elements.
>   */
> -static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
> +static inline unsigned long slab_obj_exts(struct slab *slab)
>  {
>  	unsigned long obj_exts = READ_ONCE(slab->obj_exts);
>  
> @@ -525,7 +527,30 @@ static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
>  		       obj_exts != OBJEXTS_ALLOC_FAIL, slab_page(slab));
>  	VM_BUG_ON_PAGE(obj_exts & MEMCG_DATA_KMEM, slab_page(slab));
>  #endif
> -	return (struct slabobj_ext *)(obj_exts & ~OBJEXTS_FLAGS_MASK);
> +
> +	return obj_exts & ~OBJEXTS_FLAGS_MASK;
> +}
> +
> +/*
> + * slab_obj_ext - get the pointer to the slab object extension metadata
> + * associated with an object in a slab.
> + * @slab: a pointer to the slab struct
> + * @obj_exts: a pointer to the object extension vector
> + * @index: an index of the object
> + *
> + * Returns a pointer to the object extension associated with the object.
> + */
> +static inline struct slabobj_ext *slab_obj_ext(struct slab *slab,
> +					       unsigned long obj_exts,
> +					       unsigned int index)
> +{
> +	struct slabobj_ext *obj_ext;
> +
> +	VM_WARN_ON_ONCE(!slab_obj_exts(slab));
> +	VM_WARN_ON_ONCE(obj_exts != slab_obj_exts(slab));
> +
> +	obj_ext = (struct slabobj_ext *)obj_exts;
> +	return &obj_ext[index];
>  }
>  
>  int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> @@ -533,7 +558,13 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>  
>  #else /* CONFIG_SLAB_OBJ_EXT */
>  
> -static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
> +static inline unsigned long slab_obj_exts(struct slab *slab)
> +{
> +	return 0;
> +}
> +
> +static inline struct slabobj_ext *slab_obj_ext(struct slab *slab,
> +					       unsigned int index)

Hi Harry, just a small nit: the parameter list of slab_obj_ext() should
include `unsigned long obj_exts`.

-- 
Thanks,
Hao

>  {
>  	return NULL;
>  }
> @@ -550,7 +581,7 @@ static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
>  bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
>  				  gfp_t flags, size_t size, void **p);
>  void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
> -			    void **p, int objects, struct slabobj_ext *obj_exts);
> +			    void **p, int objects, unsigned long obj_exts);
>  #endif
>  
>  void kvfree_rcu_cb(struct rcu_head *head);
> diff --git a/mm/slub.c b/mm/slub.c
> index 0e32f6420a8a..84bd4f23dc4a 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2042,7 +2042,7 @@ static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
>  
>  static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
>  {
> -	struct slabobj_ext *slab_exts;
> +	unsigned long slab_exts;
>  	struct slab *obj_exts_slab;
>  
>  	obj_exts_slab = virt_to_slab(obj_exts);
> @@ -2050,13 +2050,15 @@ static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
>  	if (slab_exts) {
>  		unsigned int offs = obj_to_index(obj_exts_slab->slab_cache,
>  						 obj_exts_slab, obj_exts);
> +		struct slabobj_ext *ext = slab_obj_ext(obj_exts_slab,
> +						       slab_exts, offs);
>  
> -		if (unlikely(is_codetag_empty(&slab_exts[offs].ref)))
> +		if (unlikely(is_codetag_empty(ext->ref)))
>  			return;
>  
>  		/* codetag should be NULL here */
> -		WARN_ON(slab_exts[offs].ref.ct);
> -		set_codetag_empty(&slab_exts[offs].ref);
> +		WARN_ON(ext->ref.ct);
> +		set_codetag_empty(&ext->ref);
>  	}
>  }
>  
> @@ -2176,7 +2178,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>  
>  static inline void free_slab_obj_exts(struct slab *slab)
>  {
> -	struct slabobj_ext *obj_exts;
> +	unsigned long obj_exts;
>  
>  	obj_exts = slab_obj_exts(slab);
>  	if (!obj_exts) {
> @@ -2196,11 +2198,11 @@ static inline void free_slab_obj_exts(struct slab *slab)
>  	 * NULL, therefore replace NULL with CODETAG_EMPTY to indicate that
>  	 * the extension for obj_exts is expected to be NULL.
>  	 */
> -	mark_objexts_empty(obj_exts);
> +	mark_objexts_empty((struct slabobj_ext *)obj_exts);
>  	if (unlikely(READ_ONCE(slab->obj_exts) & OBJEXTS_NOSPIN_ALLOC))
> -		kfree_nolock(obj_exts);
> +		kfree_nolock((void *)obj_exts);
>  	else
> -		kfree(obj_exts);
> +		kfree((void *)obj_exts);
>  	slab->obj_exts = 0;
>  }
>  
> @@ -2225,26 +2227,29 @@ static inline void free_slab_obj_exts(struct slab *slab)
>  #ifdef CONFIG_MEM_ALLOC_PROFILING
>  
>  static inline struct slabobj_ext *
> -prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
> +prepare_slab_obj_ext_hook(struct kmem_cache *s, gfp_t flags, void *p)
>  {
>  	struct slab *slab;
> +	unsigned long obj_exts;
>  
>  	slab = virt_to_slab(p);
> -	if (!slab_obj_exts(slab) &&
> +	obj_exts = slab_obj_exts(slab);
> +	if (!obj_exts &&
>  	    alloc_slab_obj_exts(slab, s, flags, false)) {
>  		pr_warn_once("%s, %s: Failed to create slab extension vector!\n",
>  			     __func__, s->name);
>  		return NULL;
>  	}
>  
> -	return slab_obj_exts(slab) + obj_to_index(s, slab, p);
> +	obj_exts = slab_obj_exts(slab);
> +	return slab_obj_ext(slab, obj_exts, obj_to_index(s, slab, p));
>  }
>  
>  /* Should be called only if mem_alloc_profiling_enabled() */
>  static noinline void
>  __alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
>  {
> -	struct slabobj_ext *obj_exts;
> +	struct slabobj_ext *obj_ext;
>  
>  	if (!object)
>  		return;
> @@ -2255,14 +2260,14 @@ __alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
>  	if (flags & __GFP_NO_OBJ_EXT)
>  		return;
>  
> -	obj_exts = prepare_slab_obj_exts_hook(s, flags, object);
> +	obj_ext = prepare_slab_obj_ext_hook(s, flags, object);
>  	/*
>  	 * Currently obj_exts is used only for allocation profiling.
>  	 * If other users appear then mem_alloc_profiling_enabled()
>  	 * check should be added before alloc_tag_add().
>  	 */
> -	if (likely(obj_exts))
> -		alloc_tag_add(&obj_exts->ref, current->alloc_tag, s->size);
> +	if (likely(obj_ext))
> +		alloc_tag_add(&obj_ext->ref, current->alloc_tag, s->size);
>  	else
>  		alloc_tag_set_inaccurate(current->alloc_tag);
>  }
> @@ -2279,8 +2284,8 @@ static noinline void
>  __alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
>  			       int objects)
>  {
> -	struct slabobj_ext *obj_exts;
>  	int i;
> +	unsigned long obj_exts;
>  
>  	/* slab->obj_exts might not be NULL if it was created for MEMCG accounting. */
>  	if (s->flags & (SLAB_NO_OBJ_EXT | SLAB_NOLEAKTRACE))
> @@ -2293,7 +2298,7 @@ __alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p
>  	for (i = 0; i < objects; i++) {
>  		unsigned int off = obj_to_index(s, slab, p[i]);
>  
> -		alloc_tag_sub(&obj_exts[off].ref, s->size);
> +		alloc_tag_sub(&slab_obj_ext(slab, obj_exts, off)->ref, s->size);
>  	}
>  }
>  
> @@ -2352,7 +2357,7 @@ static __fastpath_inline
>  void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
>  			  int objects)
>  {
> -	struct slabobj_ext *obj_exts;
> +	unsigned long obj_exts;
>  
>  	if (!memcg_kmem_online())
>  		return;
> @@ -2367,7 +2372,8 @@ void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
>  static __fastpath_inline
>  bool memcg_slab_post_charge(void *p, gfp_t flags)
>  {
> -	struct slabobj_ext *slab_exts;
> +	unsigned long obj_exts;
> +	struct slabobj_ext *obj_ext;
>  	struct kmem_cache *s;
>  	struct page *page;
>  	struct slab *slab;
> @@ -2408,10 +2414,11 @@ bool memcg_slab_post_charge(void *p, gfp_t flags)
>  		return true;
>  
>  	/* Ignore already charged objects. */
> -	slab_exts = slab_obj_exts(slab);
> -	if (slab_exts) {
> +	obj_exts = slab_obj_exts(slab);
> +	if (obj_exts) {
>  		off = obj_to_index(s, slab, p);
> -		if (unlikely(slab_exts[off].objcg))
> +		obj_ext = slab_obj_ext(slab, obj_exts, off);
> +		if (unlikely(obj_ext->objcg))
>  			return true;
>  	}
>  
> -- 
> 2.43.0
> 


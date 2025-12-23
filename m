Return-Path: <cgroups+bounces-12608-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DD242CD9BD6
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 16:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 536583002B95
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 15:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E75828BA95;
	Tue, 23 Dec 2025 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ud8Ux0yC"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3242877DC
	for <cgroups@vger.kernel.org>; Tue, 23 Dec 2025 15:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766502555; cv=none; b=oNvbQfhfesVh7xY57j+knBNQ5axhnnHQSLEaeBwhp6N5ptyUaA3m/n4oBgt08PZsbw2fEkxL5Bsaf4YXD0GYDZ6LJyeWAvG/0PdP9QK5YWxDicwILfzdBr4x0/uwvI5g8c39yE9g+gA8Bfel9n60EdXKM/FI0xfvPhDX+viDEZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766502555; c=relaxed/simple;
	bh=0nWZKhvLvlsjo/0EzW55SNVzXhueERMWGKES5P1ossc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3hyqRImMlUddv3bl470IEohJ/Lz3ZXMHLsJry34TY1Vv3EePCv01cFYaaNa3ZB9RJMU5OZTO3Pq8sbHApI71zcEwrjyeJ3vb1QKh8ZZFAHVGzKJf6lv6IHdnNx3eFLaYy2cspDc3TnbhOyU5mA7MIQaYlGap2Ae30kxdyoZkKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ud8Ux0yC; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 23 Dec 2025 23:08:32 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766502537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bGEmBuIAlDpfKf1Ox8wdvb0ICd3r/4M1pyLit4d3Row=;
	b=Ud8Ux0yCoBLP5E6OpgaynfOPKbsI21180p37taLDe/7moDEyiMS7JGkLZwqYdgIplvix8e
	U+U7u/0ULmMVjzfg0xFoo5cZeq10s71ImKcAsLxVbp8iMkur+LlJ26yVuj+7GQrVCeirrG
	ZlBBjj+f+5JSFWRn8bdv6GKKpP0wzcU=
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
Subject: Re: [PATCH V4 7/8] mm/slab: save memory by allocating slabobj_ext
 array from leftover
Message-ID: <graryni6wadpi3ytfq7zimj2kbmm7dumxvhxtzmxndrv5s2y67@ju4cdnsmos6e>
References: <20251222110843.980347-1-harry.yoo@oracle.com>
 <20251222110843.980347-8-harry.yoo@oracle.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251222110843.980347-8-harry.yoo@oracle.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Dec 22, 2025 at 08:08:42PM +0900, Harry Yoo wrote:
> The leftover space in a slab is always smaller than s->size, and
> kmem caches for large objects that are not power-of-two sizes tend to have
> a greater amount of leftover space per slab. In some cases, the leftover
> space is larger than the size of the slabobj_ext array for the slab.
> 
> An excellent example of such a cache is ext4_inode_cache. On my system,
> the object size is 1144, with a preferred order of 3, 28 objects per slab,
> and 736 bytes of leftover space per slab.
> 
> Since the size of the slabobj_ext array is only 224 bytes (w/o mem
> profiling) or 448 bytes (w/ mem profiling) per slab, the entire array
> fits within the leftover space.
> 
> Allocate the slabobj_exts array from this unused space instead of using
> kcalloc() when it is large enough. The array is allocated from unused
> space only when creating new slabs, and it doesn't try to utilize unused
> space if alloc_slab_obj_exts() is called after slab creation because
> implementing lazy allocation involves more expensive synchronization.
> 
> The implementation and evaluation of lazy allocation from unused space
> is left as future-work. As pointed by Vlastimil Babka [1], it could be
> beneficial when a slab cache without SLAB_ACCOUNT can be created, and
> some of the allocations from the cache use __GFP_ACCOUNT. For example,
> xarray does that.
> 
> To avoid unnecessary overhead when MEMCG (with SLAB_ACCOUNT) and
> MEM_ALLOC_PROFILING are not used for the cache, allocate the slabobj_ext
> array only when either of them is enabled.
> 
> [ MEMCG=y, MEM_ALLOC_PROFILING=n ]
> 
> Before patch (creating ~2.64M directories on ext4):
>   Slab:            4747880 kB
>   SReclaimable:    4169652 kB
>   SUnreclaim:       578228 kB
> 
> After patch (creating ~2.64M directories on ext4):
>   Slab:            4724020 kB
>   SReclaimable:    4169188 kB
>   SUnreclaim:       554832 kB (-22.84 MiB)
> 
> Enjoy the memory savings!
> 
> Link: https://lore.kernel.org/linux-mm/48029aab-20ea-4d90-bfd1-255592b2018e@suse.cz [1]
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>  mm/slub.c | 156 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 151 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 39c381cc1b2c..3fc3d2ca42e7 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -886,6 +886,99 @@ static inline unsigned long get_orig_size(struct kmem_cache *s, void *object)
>  	return *(unsigned long *)p;
>  }
>  
> +#ifdef CONFIG_SLAB_OBJ_EXT
> +
> +/*
> + * Check if memory cgroup or memory allocation profiling is enabled.
> + * If enabled, SLUB tries to reduce memory overhead of accounting
> + * slab objects. If neither is enabled when this function is called,
> + * the optimization is simply skipped to avoid affecting caches that do not
> + * need slabobj_ext metadata.
> + *
> + * However, this may disable optimization when memory cgroup or memory
> + * allocation profiling is used, but slabs are created too early
> + * even before those subsystems are initialized.
> + */
> +static inline bool need_slab_obj_exts(struct kmem_cache *s)
> +{
> +	if (memcg_kmem_online() && (s->flags & SLAB_ACCOUNT))
> +		return true;
> +
> +	if (mem_alloc_profiling_enabled())
> +		return true;
> +
> +	return false;
> +}
> +
> +static inline unsigned int obj_exts_size_in_slab(struct slab *slab)
> +{
> +	return sizeof(struct slabobj_ext) * slab->objects;
> +}
> +
> +static inline unsigned long obj_exts_offset_in_slab(struct kmem_cache *s,
> +						    struct slab *slab)
> +{
> +	unsigned long objext_offset;
> +
> +	objext_offset = s->red_left_pad + s->size * slab->objects;

Hi Harry,

As s->size already includes s->red_left_pad, do we still need
s->red_left_pad here?

> +	objext_offset = ALIGN(objext_offset, sizeof(struct slabobj_ext));
> +	return objext_offset;
> +}
> +
> +static inline bool obj_exts_fit_within_slab_leftover(struct kmem_cache *s,
> +						     struct slab *slab)
> +{
> +	unsigned long objext_offset = obj_exts_offset_in_slab(s, slab);
> +	unsigned long objext_size = obj_exts_size_in_slab(slab);
> +
> +	return objext_offset + objext_size <= slab_size(slab);
> +}
> +
> +static inline bool obj_exts_in_slab(struct kmem_cache *s, struct slab *slab)
> +{
> +	unsigned long expected;
> +	unsigned long obj_exts;
> +
> +	obj_exts = slab_obj_exts(slab);
> +	if (!obj_exts)
> +		return false;
> +
> +	if (!obj_exts_fit_within_slab_leftover(s, slab))
> +		return false;
> +
> +	expected = (unsigned long)slab_address(slab);
> +	expected += obj_exts_offset_in_slab(s, slab);
> +	return obj_exts == expected;
> +}
> +#else
> +static inline bool need_slab_obj_exts(struct kmem_cache *s)
> +{
> +	return false;
> +}
> +
> +static inline unsigned int obj_exts_size_in_slab(struct slab *slab)
> +{
> +	return 0;
> +}
> +
> +static inline unsigned long obj_exts_offset_in_slab(struct kmem_cache *s,
> +						    struct slab *slab)
> +{
> +	return 0;
> +}
> +
> +static inline bool obj_exts_fit_within_slab_leftover(struct kmem_cache *s,
> +						     struct slab *slab)
> +{
> +	return false;
> +}
> +
> +static inline bool obj_exts_in_slab(struct kmem_cache *s, struct slab *slab)
> +{
> +	return false;
> +}
> +#endif
> +
>  #ifdef CONFIG_SLUB_DEBUG
>  
>  /*
> @@ -1405,7 +1498,15 @@ slab_pad_check(struct kmem_cache *s, struct slab *slab)
>  	start = slab_address(slab);
>  	length = slab_size(slab);
>  	end = start + length;
> -	remainder = length % s->size;
> +
> +	if (obj_exts_in_slab(s, slab)) {
> +		remainder = length;
> +		remainder -= obj_exts_offset_in_slab(s, slab);
> +		remainder -= obj_exts_size_in_slab(slab);
> +	} else {
> +		remainder = length % s->size;
> +	}
> +
>  	if (!remainder)
>  		return;
>  
> @@ -2179,6 +2280,11 @@ static inline void free_slab_obj_exts(struct slab *slab)
>  		return;
>  	}
>  
> +	if (obj_exts_in_slab(slab->slab_cache, slab)) {
> +		slab->obj_exts = 0;
> +		return;
> +	}
> +
>  	/*
>  	 * obj_exts was created with __GFP_NO_OBJ_EXT flag, therefore its
>  	 * corresponding extension will be NULL. alloc_tag_sub() will throw a
> @@ -2194,6 +2300,35 @@ static inline void free_slab_obj_exts(struct slab *slab)
>  	slab->obj_exts = 0;
>  }
>  
> +/*
> + * Try to allocate slabobj_ext array from unused space.
> + * This function must be called on a freshly allocated slab to prevent
> + * concurrency problems.
> + */
> +static void alloc_slab_obj_exts_early(struct kmem_cache *s, struct slab *slab)
> +{
> +	void *addr;
> +	unsigned long obj_exts;
> +
> +	if (!need_slab_obj_exts(s))
> +		return;
> +
> +	if (obj_exts_fit_within_slab_leftover(s, slab)) {
> +		addr = slab_address(slab) + obj_exts_offset_in_slab(s, slab);
> +		addr = kasan_reset_tag(addr);
> +		obj_exts = (unsigned long)addr;
> +
> +		get_slab_obj_exts(obj_exts);
> +		memset(addr, 0, obj_exts_size_in_slab(slab));
> +		put_slab_obj_exts(obj_exts);
> +
> +		if (IS_ENABLED(CONFIG_MEMCG))
> +			obj_exts |= MEMCG_DATA_OBJEXTS;
> +		slab->obj_exts = obj_exts;
> +		slab_set_stride(slab, sizeof(struct slabobj_ext));
> +	}
> +}
> +
>  #else /* CONFIG_SLAB_OBJ_EXT */
>  
>  static inline void init_slab_obj_exts(struct slab *slab)
> @@ -2210,6 +2345,11 @@ static inline void free_slab_obj_exts(struct slab *slab)
>  {
>  }
>  
> +static inline void alloc_slab_obj_exts_early(struct kmem_cache *s,
> +						       struct slab *slab)
> +{
> +}
> +
>  #endif /* CONFIG_SLAB_OBJ_EXT */
>  
>  #ifdef CONFIG_MEM_ALLOC_PROFILING
> @@ -3206,7 +3346,9 @@ static inline bool shuffle_freelist(struct kmem_cache *s, struct slab *slab)
>  static __always_inline void account_slab(struct slab *slab, int order,
>  					 struct kmem_cache *s, gfp_t gfp)
>  {
> -	if (memcg_kmem_online() && (s->flags & SLAB_ACCOUNT))
> +	if (memcg_kmem_online() &&
> +			(s->flags & SLAB_ACCOUNT) &&
> +			!slab_obj_exts(slab))
>  		alloc_slab_obj_exts(slab, s, gfp, true);
>  
>  	mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
> @@ -3270,9 +3412,6 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
>  	slab->objects = oo_objects(oo);
>  	slab->inuse = 0;
>  	slab->frozen = 0;
> -	init_slab_obj_exts(slab);
> -
> -	account_slab(slab, oo_order(oo), s, flags);
>  
>  	slab->slab_cache = s;
>  
> @@ -3281,6 +3420,13 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
>  	start = slab_address(slab);
>  
>  	setup_slab_debug(s, slab, start);
> +	init_slab_obj_exts(slab);
> +	/*
> +	 * Poison the slab before initializing the slabobj_ext array
> +	 * to prevent the array from being overwritten.
> +	 */
> +	alloc_slab_obj_exts_early(s, slab);
> +	account_slab(slab, oo_order(oo), s, flags);
>  
>  	shuffle = shuffle_freelist(s, slab);
>  
> -- 
> 2.43.0
> 


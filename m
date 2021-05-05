Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC16A373F2E
	for <lists+cgroups@lfdr.de>; Wed,  5 May 2021 18:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbhEEQHG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 May 2021 12:07:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:51582 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233677AbhEEQHG (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 5 May 2021 12:07:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A5D3AB0BD;
        Wed,  5 May 2021 16:06:08 +0000 (UTC)
To:     Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
References: <20210505154613.17214-1-longman@redhat.com>
 <20210505154613.17214-3-longman@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3 2/2] mm: memcg/slab: Create a new set of kmalloc-cg-<n>
 caches
Message-ID: <4c1a0436-2d46-d23a-2eef-d558e37373bf@suse.cz>
Date:   Wed, 5 May 2021 18:06:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210505154613.17214-3-longman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/5/21 5:46 PM, Waiman Long wrote:
> There are currently two problems in the way the objcg pointer array
> (memcg_data) in the page structure is being allocated and freed.
> 
> On its allocation, it is possible that the allocated objcg pointer
> array comes from the same slab that requires memory accounting. If this
> happens, the slab will never become empty again as there is at least
> one object left (the obj_cgroup array) in the slab.
> 
> When it is freed, the objcg pointer array object may be the last one
> in its slab and hence causes kfree() to be called again. With the
> right workload, the slab cache may be set up in a way that allows the
> recursive kfree() calling loop to nest deep enough to cause a kernel
> stack overflow and panic the system.
> 
> One way to solve this problem is to split the kmalloc-<n> caches
> (KMALLOC_NORMAL) into two separate sets - a new set of kmalloc-<n>
> (KMALLOC_NORMAL) caches for non-accounted objects only and a new set of
> kmalloc-cg-<n> (KMALLOC_CGROUP) caches for accounted objects only. All
> the other caches can still allow a mix of accounted and non-accounted
> objects.
> 
> With this change, all the objcg pointer array objects will come from
> KMALLOC_NORMAL caches which won't have their objcg pointer arrays. So
> both the recursive kfree() problem and non-freeable slab problem are
> gone. Since both the KMALLOC_NORMAL and KMALLOC_CGROUP caches no longer
> have mixed accounted and unaccounted objects, this will slightly reduce
> the number of objcg pointer arrays that need to be allocated and save
> a bit of memory.
> 
> The new KMALLOC_CGROUP is added between KMALLOC_NORMAL and
> KMALLOC_RECLAIM so that the first for loop in create_kmalloc_caches()
> will include the newly added caches without change.
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  include/linux/slab.h | 42 ++++++++++++++++++++++++++++++++++--------
>  mm/slab_common.c     | 23 +++++++++++++++--------
>  2 files changed, 49 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 0c97d788762c..f2d9ebc34f5c 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -305,9 +305,16 @@ static inline void __check_heap_object(const void *ptr, unsigned long n,
>  /*
>   * Whenever changing this, take care of that kmalloc_type() and
>   * create_kmalloc_caches() still work as intended.
> + *
> + * KMALLOC_NORMAL is for non-accounted objects only whereas KMALLOC_CGROUP
> + * is for accounted objects only. All the other kmem caches can have both
> + * accounted and non-accounted objects.
>   */
>  enum kmalloc_cache_type {
>  	KMALLOC_NORMAL = 0,
> +#ifdef CONFIG_MEMCG_KMEM
> +	KMALLOC_CGROUP,
> +#endif
>  	KMALLOC_RECLAIM,
>  #ifdef CONFIG_ZONE_DMA
>  	KMALLOC_DMA,
> @@ -315,28 +322,47 @@ enum kmalloc_cache_type {
>  	NR_KMALLOC_TYPES
>  };
>  
> +#ifndef CONFIG_MEMCG_KMEM
> +#define KMALLOC_CGROUP	KMALLOC_NORMAL
> +#endif
> +#ifndef CONFIG_ZONE_DMA
> +#define KMALLOC_DMA	KMALLOC_NORMAL
> +#endif

You could move this to the enum definition itself? E.g.:

#ifdef CONFIG_MEMCG_KMEM
	KMALLOC_CGROUP,
#else
	KMALLOC_CGROUP = KMALLOC_NORMAL,
#endif

> +
>  #ifndef CONFIG_SLOB
>  extern struct kmem_cache *
>  kmalloc_caches[NR_KMALLOC_TYPES][KMALLOC_SHIFT_HIGH + 1];
>  
> +/*
> + * Define gfp bits that should not be set for KMALLOC_NORMAL.
> + */
> +#define KMALLOC_NOT_NORMAL_BITS					\
> +	(__GFP_RECLAIMABLE |					\
> +	(IS_ENABLED(CONFIG_ZONE_DMA)   ? __GFP_DMA : 0) |	\
> +	(IS_ENABLED(CONFIG_MEMCG_KMEM) ? __GFP_ACCOUNT : 0))
> +
>  static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
>  {
> -#ifdef CONFIG_ZONE_DMA
>  	/*
>  	 * The most common case is KMALLOC_NORMAL, so test for it
>  	 * with a single branch for both flags.
Not "both flags" anymore. Something like "so test with a single branch that
there are none of the flags that would select a different type"

>  	 */
> -	if (likely((flags & (__GFP_DMA | __GFP_RECLAIMABLE)) == 0))
> +	if (likely((flags & KMALLOC_NOT_NORMAL_BITS) == 0))
>  		return KMALLOC_NORMAL;
>  
>  	/*
> -	 * At least one of the flags has to be set. If both are, __GFP_DMA
> -	 * is more important.
> +	 * At least one of the flags has to be set. Their priorities in
> +	 * decreasing order are:
> +	 *  1) __GFP_DMA
> +	 *  2) __GFP_RECLAIMABLE
> +	 *  3) __GFP_ACCOUNT
>  	 */
> -	return flags & __GFP_DMA ? KMALLOC_DMA : KMALLOC_RECLAIM;
> -#else
> -	return flags & __GFP_RECLAIMABLE ? KMALLOC_RECLAIM : KMALLOC_NORMAL;
> -#endif
> +	if (IS_ENABLED(CONFIG_ZONE_DMA) && (flags & __GFP_DMA))
> +		return KMALLOC_DMA;
> +	if (!IS_ENABLED(CONFIG_MEMCG_KMEM) || (flags & __GFP_RECLAIMABLE))
> +		return KMALLOC_RECLAIM;
> +	else
> +		return KMALLOC_CGROUP;
>  }

Works for me this way, thanks.

>  
>  /*
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index f8833d3e5d47..d750e3ba7af5 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -727,21 +727,25 @@ struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags)
>  }
>  
>  #ifdef CONFIG_ZONE_DMA
> -#define INIT_KMALLOC_INFO(__size, __short_size)			\
> -{								\
> -	.name[KMALLOC_NORMAL]  = "kmalloc-" #__short_size,	\
> -	.name[KMALLOC_RECLAIM] = "kmalloc-rcl-" #__short_size,	\
> -	.name[KMALLOC_DMA]     = "dma-kmalloc-" #__short_size,	\
> -	.size = __size,						\
> -}
> +#define KMALLOC_DMA_NAME(sz)	.name[KMALLOC_DMA] = "dma-kmalloc-" #sz,
> +#else
> +#define KMALLOC_DMA_NAME(sz)
> +#endif
> +
> +#ifdef CONFIG_MEMCG_KMEM
> +#define KMALLOC_CGROUP_NAME(sz)	.name[KMALLOC_CGROUP] = "kmalloc-cg-" #sz,
>  #else
> +#define KMALLOC_CGROUP_NAME(sz)
> +#endif
> +
>  #define INIT_KMALLOC_INFO(__size, __short_size)			\
>  {								\
>  	.name[KMALLOC_NORMAL]  = "kmalloc-" #__short_size,	\
>  	.name[KMALLOC_RECLAIM] = "kmalloc-rcl-" #__short_size,	\
> +	KMALLOC_CGROUP_NAME(__short_size)			\
> +	KMALLOC_DMA_NAME(__short_size)				\
>  	.size = __size,						\
>  }
> -#endif
>  
>  /*
>   * kmalloc_info[] is to make slub_debug=,kmalloc-xx option work at boot time.
> @@ -847,6 +851,9 @@ void __init create_kmalloc_caches(slab_flags_t flags)
>  	int i;
>  	enum kmalloc_cache_type type;
>  
> +	/*
> +	 * Including KMALLOC_CGROUP if CONFIG_MEMCG_KMEM defined
> +	 */
>  	for (type = KMALLOC_NORMAL; type <= KMALLOC_RECLAIM; type++) {
>  		for (i = KMALLOC_SHIFT_LOW; i <= KMALLOC_SHIFT_HIGH; i++) {
>  			if (!kmalloc_caches[type][i])
> 


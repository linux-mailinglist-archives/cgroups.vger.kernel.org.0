Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B67D35D84A
	for <lists+cgroups@lfdr.de>; Tue, 13 Apr 2021 08:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236942AbhDMG4z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Apr 2021 02:56:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:50828 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236840AbhDMG4v (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 13 Apr 2021 02:56:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618296989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q1Z+7IVaUM1A0at3Cu4SGuPR6txL6b+nssoJr2GCdOw=;
        b=sAVfIKDvhbmMeuJOtrJilVxfBGWOOf0j7lTfbYCVlZWSmtqnmZ+tEBHMaRlTaJspRuM6/E
        FoxmL9c+IiAxWmAjwqVHkhEnsP0T3VNDUDoQcZaxkm+lkKH5MRT7/R1l58RcNABcHB57XJ
        x7rKnm3CyXf/H6JDMG0u7HRqPeIr+9U=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9E54BADE2;
        Tue, 13 Apr 2021 06:56:29 +0000 (UTC)
Date:   Tue, 13 Apr 2021 08:56:26 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     ultrachin@163.com
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        hannes@cmpxchg.org, vdavydov.dev@gmail.com, linux-mm@kvack.org,
        cgroups@vger.kernel.org, Chen Xiaoguang <xiaoggchen@tencent.com>,
        Chen He <heddchen@tencent.com>
Subject: Re: [PATCH] mm: optimize memory allocation
Message-ID: <YHVAmuiER92rTGuz@dhcp22.suse.cz>
References: <1618213793-17741-1-git-send-email-ultrachin@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618213793-17741-1-git-send-email-ultrachin@163.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 12-04-21 15:49:53, ultrachin@163.com wrote:
> From: Chen Xiaoguang <xiaoggchen@tencent.com>
> 
> Check memory cgroup limit before allocating real memory. This may
> improve performance especially in slow path when memory allocation
> exceeds cgroup limitation.

I would be really curious about any actual numbers because I have really
hard times to see scenarios when this would lead to an improvement.
Effectitelly only non-oom allocations would benefit theoretically (e.g.
atomic or GFP_NORETRY etc). All others will trigger the memcg oom killer
to help forward progress.

Besides that I really dislike kmem and LRU pages to be handled
differently so for that reason
Nacked-by: Michal Hocko <mhocko@suse.com>

If the optimization really can be provent then the patch would require
to be much more invasive.

> Signed-off-by: Chen Xiaoguang <xiaoggchen@tencent.com>
> Signed-off-by: Chen He <heddchen@tencent.com>
> ---
>  include/linux/memcontrol.h | 30 ++++++++++++++++++++++--------
>  mm/memcontrol.c            | 34 ++++++++++++++++------------------
>  mm/page_alloc.c            | 24 +++++++++++++++++-------
>  3 files changed, 55 insertions(+), 33 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 0c04d39..59bb3ba 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1583,8 +1583,9 @@ static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
>  #endif
>  
>  #ifdef CONFIG_MEMCG_KMEM
> -int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order);
> -void __memcg_kmem_uncharge_page(struct page *page, int order);
> +int __memcg_kmem_charge_page(struct mem_cgroup *memcg, gfp_t gfp, int order);
> +void __memcg_kmem_uncharge_page(struct page *page, int order,
> +				struct mem_cgroup *memcg);
>  
>  struct obj_cgroup *get_obj_cgroup_from_current(void);
>  
> @@ -1610,18 +1611,30 @@ static inline bool memcg_kmem_enabled(void)
>  	return static_branch_likely(&memcg_kmem_enabled_key);
>  }
>  
> +extern struct mem_cgroup *get_mem_cgroup_from_current(void);
> +
>  static inline int memcg_kmem_charge_page(struct page *page, gfp_t gfp,
>  					 int order)
>  {
> -	if (memcg_kmem_enabled())
> -		return __memcg_kmem_charge_page(page, gfp, order);
> -	return 0;
> +	struct mem_cgroup *memcg;
> +	int ret = 0;
> +
> +	memcg = get_mem_cgroup_from_current();
> +	if (memcg && memcg_kmem_enabled() && !mem_cgroup_is_root(memcg)) {
> +		ret = __memcg_kmem_charge_page(memcg, gfp, order);
> +		if (!ret) {
> +			page->memcg_data = (unsigned long)memcg | MEMCG_DATA_KMEM;
> +			return 0;
> +		}
> +		css_put(&memcg->css);
> +	}
> +	return ret;
>  }
>  
>  static inline void memcg_kmem_uncharge_page(struct page *page, int order)
>  {
>  	if (memcg_kmem_enabled())
> -		__memcg_kmem_uncharge_page(page, order);
> +		__memcg_kmem_uncharge_page(page, order, NULL);
>  }
>  
>  /*
> @@ -1647,13 +1660,14 @@ static inline void memcg_kmem_uncharge_page(struct page *page, int order)
>  {
>  }
>  
> -static inline int __memcg_kmem_charge_page(struct page *page, gfp_t gfp,
> +static inline int __memcg_kmem_charge_page(struct mem_cgroup *memcg, gfp_t gfp,
>  					   int order)
>  {
>  	return 0;
>  }
>  
> -static inline void __memcg_kmem_uncharge_page(struct page *page, int order)
> +static inline void __memcg_kmem_uncharge_page(struct page *page, int order,
> +					    struct mem_cgroup *memcg)
>  {
>  }
>  
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e064ac0d..8df57b7 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1085,7 +1085,7 @@ static __always_inline bool memcg_kmem_bypass(void)
>  /**
>   * If active memcg is set, do not fallback to current->mm->memcg.
>   */
> -static __always_inline struct mem_cgroup *get_mem_cgroup_from_current(void)
> +struct mem_cgroup *get_mem_cgroup_from_current(void)
>  {
>  	if (memcg_kmem_bypass())
>  		return NULL;
> @@ -3113,21 +3113,11 @@ static void __memcg_kmem_uncharge(struct mem_cgroup *memcg, unsigned int nr_page
>   *
>   * Returns 0 on success, an error code on failure.
>   */
> -int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
> +int __memcg_kmem_charge_page(struct mem_cgroup *memcg, gfp_t gfp, int order)
>  {
> -	struct mem_cgroup *memcg;
> -	int ret = 0;
> +	int ret;
>  
> -	memcg = get_mem_cgroup_from_current();
> -	if (memcg && !mem_cgroup_is_root(memcg)) {
> -		ret = __memcg_kmem_charge(memcg, gfp, 1 << order);
> -		if (!ret) {
> -			page->memcg_data = (unsigned long)memcg |
> -				MEMCG_DATA_KMEM;
> -			return 0;
> -		}
> -		css_put(&memcg->css);
> -	}
> +	ret = __memcg_kmem_charge(memcg, gfp, 1 << order);
>  	return ret;
>  }
>  
> @@ -3136,17 +3126,25 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
>   * @page: page to uncharge
>   * @order: allocation order
>   */
> -void __memcg_kmem_uncharge_page(struct page *page, int order)
> +void __memcg_kmem_uncharge_page(struct page *page, int order,
> +		struct mem_cgroup *memcg_in)
>  {
> -	struct mem_cgroup *memcg = page_memcg(page);
> +	struct mem_cgroup *memcg;
>  	unsigned int nr_pages = 1 << order;
>  
> +	if (page)
> +		memcg = page_memcg(page);
> +	else
> +		memcg = memcg_in;
> +
>  	if (!memcg)
>  		return;
>  
> -	VM_BUG_ON_PAGE(mem_cgroup_is_root(memcg), page);
> +	if (page)
> +		VM_BUG_ON_PAGE(mem_cgroup_is_root(memcg), page);
>  	__memcg_kmem_uncharge(memcg, nr_pages);
> -	page->memcg_data = 0;
> +	if (page)
> +		page->memcg_data = 0;
>  	css_put(&memcg->css);
>  }
>  
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index cfc7287..c3d1d0c 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1230,7 +1230,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
>  		 * Untie memcg state and reset page's owner
>  		 */
>  		if (memcg_kmem_enabled() && PageMemcgKmem(page))
> -			__memcg_kmem_uncharge_page(page, order);
> +			__memcg_kmem_uncharge_page(page, order, NULL);
>  		reset_page_owner(page, order);
>  		return false;
>  	}
> @@ -1260,7 +1260,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
>  	if (PageMappingFlags(page))
>  		page->mapping = NULL;
>  	if (memcg_kmem_enabled() && PageMemcgKmem(page))
> -		__memcg_kmem_uncharge_page(page, order);
> +		__memcg_kmem_uncharge_page(page, order, NULL);
>  	if (check_free)
>  		bad += check_free_page(page);
>  	if (bad)
> @@ -4976,6 +4976,8 @@ struct page *
>  	unsigned int alloc_flags = ALLOC_WMARK_LOW;
>  	gfp_t alloc_mask; /* The gfp_t that was actually used for allocation */
>  	struct alloc_context ac = { };
> +	struct mem_cgroup *memcg;
> +	bool charged = false;
>  
>  	/*
>  	 * There are several places where we assume that the order value is sane
> @@ -4987,6 +4989,15 @@ struct page *
>  	}
>  
>  	gfp_mask &= gfp_allowed_mask;
> +	memcg = get_mem_cgroup_from_current();
> +	if (memcg && memcg_kmem_enabled() && (gfp_mask & __GFP_ACCOUNT) &&
> +	    !mem_cgroup_is_root(memcg)) {
> +		if (unlikely(__memcg_kmem_charge_page(memcg, gfp_mask, order) != 0)) {
> +			css_put(&memcg->css);
> +			return NULL;
> +		}
> +		charged = true;
> +	}
>  	alloc_mask = gfp_mask;
>  	if (!prepare_alloc_pages(gfp_mask, order, preferred_nid, nodemask, &ac, &alloc_mask, &alloc_flags))
>  		return NULL;
> @@ -5020,11 +5031,10 @@ struct page *
>  	page = __alloc_pages_slowpath(alloc_mask, order, &ac);
>  
>  out:
> -	if (memcg_kmem_enabled() && (gfp_mask & __GFP_ACCOUNT) && page &&
> -	    unlikely(__memcg_kmem_charge_page(page, gfp_mask, order) != 0)) {
> -		__free_pages(page, order);
> -		page = NULL;
> -	}
> +	if (page && charged)
> +		page->memcg_data = (unsigned long)memcg | MEMCG_DATA_KMEM;
> +	else if (charged)
> +		__memcg_kmem_uncharge_page(NULL, order, memcg);
>  
>  	trace_mm_page_alloc(page, order, alloc_mask, ac.migratetype);
>  
> -- 
> 1.8.3.1
> 

-- 
Michal Hocko
SUSE Labs

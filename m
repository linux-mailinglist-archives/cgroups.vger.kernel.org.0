Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8633142A520
	for <lists+cgroups@lfdr.de>; Tue, 12 Oct 2021 15:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbhJLNMy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Oct 2021 09:12:54 -0400
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:52733 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232851AbhJLNMx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 Oct 2021 09:12:53 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id F25A74202A
        for <cgroups@vger.kernel.org>; Tue, 12 Oct 2021 14:10:50 +0100 (IST)
Received: (qmail 24439 invoked from network); 12 Oct 2021 13:10:50 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Oct 2021 13:10:50 -0000
Date:   Tue, 12 Oct 2021 14:10:19 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel@openvz.org
Subject: Re: [PATCH mm v2] memcg: enable memory accounting in
 __alloc_pages_bulk
Message-ID: <20211012131019.GV3959@techsingularity.net>
References: <CALvZod7_fhgV39HXmmMApubW-39CjJ5t+WjmkyA_DNGF7b5O+w@mail.gmail.com>
 <2410e99a-087c-3f89-9bdf-b62a7d5df725@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <2410e99a-087c-3f89-9bdf-b62a7d5df725@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 12, 2021 at 01:18:39PM +0300, Vasily Averin wrote:
> Enable memory accounting for bulk page allocator.
> 
> Fixes: 387ba26fb1cb ("mm/page_alloc: add a bulk page allocator")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
> v2: modified according to Shakeel Butt's remarks
> ---
>  include/linux/memcontrol.h | 11 +++++++++
>  mm/memcontrol.c            | 48 +++++++++++++++++++++++++++++++++++++-
>  mm/page_alloc.c            | 14 ++++++++++-
>  3 files changed, 71 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 3096c9a0ee01..990acd70c846 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -810,6 +810,12 @@ static inline void obj_cgroup_put(struct obj_cgroup *objcg)
>  	percpu_ref_put(&objcg->refcnt);
>  }
>  
> +static inline void obj_cgroup_put_many(struct obj_cgroup *objcg,
> +				       unsigned long nr)
> +{
> +	percpu_ref_put_many(&objcg->refcnt, nr);
> +}
> +
>  static inline void mem_cgroup_put(struct mem_cgroup *memcg)
>  {
>  	if (memcg)
> @@ -1746,4 +1752,9 @@ static inline struct mem_cgroup *mem_cgroup_from_obj(void *p)
>  
>  #endif /* CONFIG_MEMCG_KMEM */
>  
> +bool memcg_bulk_pre_charge_hook(struct obj_cgroup **objcgp, gfp_t gfp,
> +				unsigned int nr_pages);
> +void memcg_bulk_charge_hook(struct obj_cgroup *objcgp, struct page *page);
> +void memcg_bulk_post_charge_hook(struct obj_cgroup *objcg,
> +				 unsigned int nr_pages);
>  #endif /* _LINUX_MEMCONTROL_H */
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 87e41c3cac10..16fe3384c12c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3239,7 +3239,53 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
>  	refill_obj_stock(objcg, size, true);
>  }
>  
> -#endif /* CONFIG_MEMCG_KMEM */
> +bool memcg_bulk_pre_charge_hook(struct obj_cgroup **objcgp, gfp_t gfp,
> +				unsigned int nr_pages)
> +{
> +	struct obj_cgroup *objcg = NULL;
> +
> +	if (!memcg_kmem_enabled() || !(gfp & __GFP_ACCOUNT))
> +		return true;
> +
> +	objcg = get_obj_cgroup_from_current();
> +
> +	if (objcg && obj_cgroup_charge_pages(objcg, gfp, nr_pages)) {
> +		obj_cgroup_put(objcg);
> +		return false;
> +	}
> +	obj_cgroup_get_many(objcg, nr_pages - 1);
> +	*objcgp = objcg;
> +	return true;
> +}
> +

This is probably a stupid question but why is it necessary to get many
references instead of taking one reference here and dropping it in
memcg_bulk_post_charge_hook?

> +void memcg_bulk_charge_hook(struct obj_cgroup *objcg, struct page *page)
> +{
> +	page->memcg_data = (unsigned long)objcg | MEMCG_DATA_KMEM;
> +}
> +
> +void memcg_bulk_post_charge_hook(struct obj_cgroup *objcg,
> +				 unsigned int nr_pages)
> +{
> +	obj_cgroup_uncharge_pages(objcg, nr_pages);
> +	obj_cgroup_put_many(objcg, nr_pages);
> +}

And are you sure obj_cgroup_uncharge_pages should be called here? I
thought the pages get uncharged on free.

> +#else /* !CONFIG_MEMCG_KMEM */
> +bool memcg_bulk_pre_charge_hook(struct obj_cgroup **objcgp, gfp_t gfp,
> +				unsigned int nr_pages)
> +{
> +	return true;
> +}
> +
> +void memcg_bulk_charge_hook(struct obj_cgroup *objcgp, struct page *page)
> +{
> +}
> +
> +void memcg_bulk_post_charge_hook(struct obj_cgroup *objcg,
> +				 unsigned int nr_pages)
> +{
> +}
> +#endif
> +
>  
>  /*
>   * Because page_memcg(head) is not set on tails, set it now.
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index b37435c274cf..eb37177bf507 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5207,6 +5207,8 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>  	gfp_t alloc_gfp;
>  	unsigned int alloc_flags = ALLOC_WMARK_LOW;
>  	int nr_populated = 0, nr_account = 0;
> +	unsigned int nr_pre_charge = 0;
> +	struct obj_cgroup *objcg = NULL;
>  
>  	/*
>  	 * Skip populated array elements to determine if any pages need
> @@ -5275,6 +5277,10 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>  	if (unlikely(!zone))
>  		goto failed;
>  
> +	nr_pre_charge = nr_pages - nr_populated;
> +	if (!memcg_bulk_pre_charge_hook(&objcg, gfp, nr_pre_charge))
> +		goto failed;
> +
>  	/* Attempt the batch allocation */
>  	local_lock_irqsave(&pagesets.lock, flags);
>  	pcp = this_cpu_ptr(zone->per_cpu_pageset);
> @@ -5299,6 +5305,9 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>  		nr_account++;
>  
>  		prep_new_page(page, 0, gfp, 0);
> +		if (objcg)
> +			memcg_bulk_charge_hook(objcg, page);
> +
>  		if (page_list)
>  			list_add(&page->lru, page_list);
>  		else
> @@ -5310,13 +5319,16 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>  
>  	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
>  	zone_statistics(ac.preferred_zoneref->zone, zone, nr_account);
> +	if (objcg)
> +		memcg_bulk_post_charge_hook(objcg, nr_pre_charge - nr_account);
>  
>  out:
>  	return nr_populated;
>  
>  failed_irq:
>  	local_unlock_irqrestore(&pagesets.lock, flags);
> -
> +	if (objcg)
> +		memcg_bulk_post_charge_hook(objcg, nr_pre_charge);
>  failed:
>  	page = __alloc_pages(gfp, 0, preferred_nid, nodemask);
>  	if (page) {
> -- 
> 2.31.1
> 

-- 
Mel Gorman
SUSE Labs

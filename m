Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73583C4EB5
	for <lists+cgroups@lfdr.de>; Mon, 12 Jul 2021 12:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344810AbhGLHUy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Jul 2021 03:20:54 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44726 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244696AbhGLHSC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Jul 2021 03:18:02 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2CEA5220B5;
        Mon, 12 Jul 2021 07:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626074113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nfjwK/c5toDCy+hVqPWw4iw9nu/0zDGXvy8gkOkPyNU=;
        b=WIcQAWDGS4Wj8T5V/94IuYtC1/UjmNZsz4tZ7w7G80jzqek6iOfqjCCPSujb5g8a3ZQ1a0
        gFrnshQwS8T1JJT9wfL055rd6swgDhnku8ic0icAB3l4BZWIWR0Ej4bBz9dSvgU8zHgVs1
        jKorAdrvSwkY/G/cDbJ3TJgFY3l/pyI=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E5812A4C84;
        Mon, 12 Jul 2021 07:15:12 +0000 (UTC)
Date:   Mon, 12 Jul 2021 09:15:12 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     tj@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        songmuchun@bytedance.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, vbabka@suse.cz, axboe@kernel.dk,
        iamjoonsoo.kim@lge.com, david@redhat.com, willy@infradead.org,
        apopple@nvidia.com, minchan@kernel.org, linmiaohe@huawei.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@android.com
Subject: Re: [PATCH v3 2/3] mm, memcg: inline mem_cgroup_{charge/uncharge} to
 improve disabled memcg config
Message-ID: <YOvsAG+F0n2U3c88@dhcp22.suse.cz>
References: <20210710003626.3549282-1-surenb@google.com>
 <20210710003626.3549282-2-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210710003626.3549282-2-surenb@google.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 09-07-21 17:36:25, Suren Baghdasaryan wrote:
> Inline mem_cgroup_{charge/uncharge} and mem_cgroup_uncharge_list functions
> functions to perform mem_cgroup_disabled static key check inline before
> calling the main body of the function. This minimizes the memcg overhead
> in the pagefault and exit_mmap paths when memcgs are disabled using
> cgroup_disable=memory command-line option.
> This change results in ~0.4% overhead reduction when running PFT test
> comparing {CONFIG_MEMCG=n} against {CONFIG_MEMCG=y, cgroup_disable=memory}
> configurationon on an 8-core ARM64 Android device.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

With doc updated as suggested by Muchun Song
Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  include/linux/memcontrol.h | 28 +++++++++++++++++++++++++---
>  mm/memcontrol.c            | 29 ++++++++++-------------------
>  2 files changed, 35 insertions(+), 22 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index bfe5c486f4ad..39fa88051a42 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -693,13 +693,35 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
>  		page_counter_read(&memcg->memory);
>  }
>  
> -int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask);
> +int __mem_cgroup_charge(struct page *page, struct mm_struct *mm,
> +			gfp_t gfp_mask);
> +static inline int mem_cgroup_charge(struct page *page, struct mm_struct *mm,
> +				    gfp_t gfp_mask)
> +{
> +	if (mem_cgroup_disabled())
> +		return 0;
> +	return __mem_cgroup_charge(page, mm, gfp_mask);
> +}
> +
>  int mem_cgroup_swapin_charge_page(struct page *page, struct mm_struct *mm,
>  				  gfp_t gfp, swp_entry_t entry);
>  void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry);
>  
> -void mem_cgroup_uncharge(struct page *page);
> -void mem_cgroup_uncharge_list(struct list_head *page_list);
> +void __mem_cgroup_uncharge(struct page *page);
> +static inline void mem_cgroup_uncharge(struct page *page)
> +{
> +	if (mem_cgroup_disabled())
> +		return;
> +	__mem_cgroup_uncharge(page);
> +}
> +
> +void __mem_cgroup_uncharge_list(struct list_head *page_list);
> +static inline void mem_cgroup_uncharge_list(struct list_head *page_list)
> +{
> +	if (mem_cgroup_disabled())
> +		return;
> +	__mem_cgroup_uncharge_list(page_list);
> +}
>  
>  void mem_cgroup_migrate(struct page *oldpage, struct page *newpage);
>  
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index a228cd51c4bd..cdaf7003b43d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6701,8 +6701,7 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
>  			atomic_long_read(&parent->memory.children_low_usage)));
>  }
>  
> -static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
> -			       gfp_t gfp)
> +static int charge_memcg(struct page *page, struct mem_cgroup *memcg, gfp_t gfp)
>  {
>  	unsigned int nr_pages = thp_nr_pages(page);
>  	int ret;
> @@ -6723,7 +6722,7 @@ static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
>  }
>  
>  /**
> - * mem_cgroup_charge - charge a newly allocated page to a cgroup
> + * __mem_cgroup_charge - charge a newly allocated page to a cgroup
>   * @page: page to charge
>   * @mm: mm context of the victim
>   * @gfp_mask: reclaim mode
> @@ -6736,16 +6735,14 @@ static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
>   *
>   * Returns 0 on success. Otherwise, an error code is returned.
>   */
> -int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
> +int __mem_cgroup_charge(struct page *page, struct mm_struct *mm,
> +			gfp_t gfp_mask)
>  {
>  	struct mem_cgroup *memcg;
>  	int ret;
>  
> -	if (mem_cgroup_disabled())
> -		return 0;
> -
>  	memcg = get_mem_cgroup_from_mm(mm);
> -	ret = __mem_cgroup_charge(page, memcg, gfp_mask);
> +	ret = charge_memcg(page, memcg, gfp_mask);
>  	css_put(&memcg->css);
>  
>  	return ret;
> @@ -6780,7 +6777,7 @@ int mem_cgroup_swapin_charge_page(struct page *page, struct mm_struct *mm,
>  		memcg = get_mem_cgroup_from_mm(mm);
>  	rcu_read_unlock();
>  
> -	ret = __mem_cgroup_charge(page, memcg, gfp);
> +	ret = charge_memcg(page, memcg, gfp);
>  
>  	css_put(&memcg->css);
>  	return ret;
> @@ -6916,18 +6913,15 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
>  }
>  
>  /**
> - * mem_cgroup_uncharge - uncharge a page
> + * __mem_cgroup_uncharge - uncharge a page
>   * @page: page to uncharge
>   *
>   * Uncharge a page previously charged with mem_cgroup_charge().
>   */
> -void mem_cgroup_uncharge(struct page *page)
> +void __mem_cgroup_uncharge(struct page *page)
>  {
>  	struct uncharge_gather ug;
>  
> -	if (mem_cgroup_disabled())
> -		return;
> -
>  	/* Don't touch page->lru of any random page, pre-check: */
>  	if (!page_memcg(page))
>  		return;
> @@ -6938,20 +6932,17 @@ void mem_cgroup_uncharge(struct page *page)
>  }
>  
>  /**
> - * mem_cgroup_uncharge_list - uncharge a list of page
> + * __mem_cgroup_uncharge_list - uncharge a list of page
>   * @page_list: list of pages to uncharge
>   *
>   * Uncharge a list of pages previously charged with
>   * mem_cgroup_charge().
>   */
> -void mem_cgroup_uncharge_list(struct list_head *page_list)
> +void __mem_cgroup_uncharge_list(struct list_head *page_list)
>  {
>  	struct uncharge_gather ug;
>  	struct page *page;
>  
> -	if (mem_cgroup_disabled())
> -		return;
> -
>  	uncharge_gather_clear(&ug);
>  	list_for_each_entry(page, page_list, lru)
>  		uncharge_page(page, &ug);
> -- 
> 2.32.0.93.g670b81a890-goog

-- 
Michal Hocko
SUSE Labs

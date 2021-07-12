Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985573C4ECE
	for <lists+cgroups@lfdr.de>; Mon, 12 Jul 2021 12:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239598AbhGLHVq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Jul 2021 03:21:46 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45140 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344104AbhGLHUU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Jul 2021 03:20:20 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6360D22026;
        Mon, 12 Jul 2021 07:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626074251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dQr5U6uTrxlJmaP7kyiD/rn9zOz10jfzz2Y8oU8q170=;
        b=HfTEafbGrX0NvVS4EMxjbtB1rdSfw6tAGaaExTyYqpS1NwNUB3eR9z8gDnA5KV+07yMMAj
        1lfCC2UfXdRVm0vrlF3T4mVAhdppwucZgP974G1uaqnv9Wb6mHj+thrxAr80aLh5uee4x6
        Ibv661pIwuwQyLLlomZjY193+28Yns8=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D719AA45A6;
        Mon, 12 Jul 2021 07:17:30 +0000 (UTC)
Date:   Mon, 12 Jul 2021 09:17:30 +0200
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
Subject: Re: [PATCH v3 3/3] mm, memcg: inline swap-related functions to
 improve disabled memcg config
Message-ID: <YOvsijKufJzjHuvd@dhcp22.suse.cz>
References: <20210710003626.3549282-1-surenb@google.com>
 <20210710003626.3549282-3-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210710003626.3549282-3-surenb@google.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 09-07-21 17:36:26, Suren Baghdasaryan wrote:
> Inline mem_cgroup_try_charge_swap, mem_cgroup_uncharge_swap and
> cgroup_throttle_swaprate functions to perform mem_cgroup_disabled static
> key check inline before calling the main body of the function. This
> minimizes the memcg overhead in the pagefault and exit_mmap paths when
> memcgs are disabled using cgroup_disable=memory command-line option.
> This change results in ~1% overhead reduction when running PFT test
> comparing {CONFIG_MEMCG=n} against {CONFIG_MEMCG=y, cgroup_disable=memory}
> configuration on an 8-core ARM64 Android device.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

I find it a bit surprising to see such a big difference over a function
call in a slow path like swap in/out.

Anyway the change makes sense.

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  include/linux/swap.h | 26 +++++++++++++++++++++++---
>  mm/memcontrol.c      | 14 ++++----------
>  mm/swapfile.c        |  5 +----
>  3 files changed, 28 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 6f5a43251593..f30d26b0f71d 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -721,7 +721,13 @@ static inline int mem_cgroup_swappiness(struct mem_cgroup *mem)
>  #endif
>  
>  #if defined(CONFIG_SWAP) && defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
> -extern void cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask);
> +extern void __cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask);
> +static inline  void cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask)
> +{
> +	if (mem_cgroup_disabled())
> +		return;
> +	__cgroup_throttle_swaprate(page, gfp_mask);
> +}
>  #else
>  static inline void cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask)
>  {
> @@ -730,8 +736,22 @@ static inline void cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask)
>  
>  #ifdef CONFIG_MEMCG_SWAP
>  extern void mem_cgroup_swapout(struct page *page, swp_entry_t entry);
> -extern int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry);
> -extern void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages);
> +extern int __mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry);
> +static inline int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
> +{
> +	if (mem_cgroup_disabled())
> +		return 0;
> +	return __mem_cgroup_try_charge_swap(page, entry);
> +}
> +
> +extern void __mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages);
> +static inline void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
> +{
> +	if (mem_cgroup_disabled())
> +		return;
> +	__mem_cgroup_uncharge_swap(entry, nr_pages);
> +}
> +
>  extern long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg);
>  extern bool mem_cgroup_swap_full(struct page *page);
>  #else
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index cdaf7003b43d..0b05322836ec 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -7234,7 +7234,7 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
>  }
>  
>  /**
> - * mem_cgroup_try_charge_swap - try charging swap space for a page
> + * __mem_cgroup_try_charge_swap - try charging swap space for a page
>   * @page: page being added to swap
>   * @entry: swap entry to charge
>   *
> @@ -7242,16 +7242,13 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
>   *
>   * Returns 0 on success, -ENOMEM on failure.
>   */
> -int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
> +int __mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
>  {
>  	unsigned int nr_pages = thp_nr_pages(page);
>  	struct page_counter *counter;
>  	struct mem_cgroup *memcg;
>  	unsigned short oldid;
>  
> -	if (mem_cgroup_disabled())
> -		return 0;
> -
>  	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
>  		return 0;
>  
> @@ -7287,18 +7284,15 @@ int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
>  }
>  
>  /**
> - * mem_cgroup_uncharge_swap - uncharge swap space
> + * __mem_cgroup_uncharge_swap - uncharge swap space
>   * @entry: swap entry to uncharge
>   * @nr_pages: the amount of swap space to uncharge
>   */
> -void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
> +void __mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
>  {
>  	struct mem_cgroup *memcg;
>  	unsigned short id;
>  
> -	if (mem_cgroup_disabled())
> -		return;
> -
>  	id = swap_cgroup_record(entry, 0, nr_pages);
>  	rcu_read_lock();
>  	memcg = mem_cgroup_from_id(id);
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 707fa0481bb4..04a0c83f1313 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3773,14 +3773,11 @@ static void free_swap_count_continuations(struct swap_info_struct *si)
>  }
>  
>  #if defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
> -void cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask)
> +void __cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask)
>  {
>  	struct swap_info_struct *si, *next;
>  	int nid = page_to_nid(page);
>  
> -	if (mem_cgroup_disabled())
> -		return;
> -
>  	if (!(gfp_mask & __GFP_IO))
>  		return;
>  
> -- 
> 2.32.0.93.g670b81a890-goog

-- 
Michal Hocko
SUSE Labs

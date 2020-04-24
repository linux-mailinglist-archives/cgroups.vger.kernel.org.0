Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140AA1B6A6D
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2020 02:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgDXAot (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Apr 2020 20:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728213AbgDXAot (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Apr 2020 20:44:49 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5260DC09B042;
        Thu, 23 Apr 2020 17:44:49 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id h11so3093693plr.11;
        Thu, 23 Apr 2020 17:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/IkJb/MMZUEA8Z1/RSpT7PeJDUHsZdmZCfXGjsvU/uc=;
        b=Fmu89ZUP5jfOOeCAiKzazV69FxgZwVwGUi4cL767wILw6nY8cuQ+xv/ACV5WBrfgqK
         no7paEzqbJa+YJbhXps7u/WW19Gfms7v5/j/Hu/aga2I6MU+SxEKAZ3E5LptUDcjTC8+
         K23v3P8rsFBqmySgjQUV7NoC9XYXbUQMW0fhCMQHvcFBcujc+4lB1tjY0GslSsnWG25E
         4Wk/k1/14NlV73UEi7hmVFzgYi7kmnMRNpMhCMNUxQtWRp2yGiW5PRO7Qcj/mAzd7fcz
         /XBrXRoKV58Is5VnCQuY0+XY503P3n35Shjp1MknNT4sgOrMF68nKkaUDgpq6A7IRWkT
         107g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/IkJb/MMZUEA8Z1/RSpT7PeJDUHsZdmZCfXGjsvU/uc=;
        b=oeePiJ3g3efEg5gwghh8UGJ66IO/eoqDbMjD97oLOSOpdCECH/1L0FknUZkQdRJNRR
         LaAskywz3b3XScQ0uT/Jm0P6rKZBLqR52ymh7Htiglv3K1aI86WEBU/q00G0sIIdfDjg
         d0eIxSi91u8ASo/SbkFhfve5/mwsdPADIR8CvdOlz2ucutFXE0opVlOgte1jNbLWZbLO
         JwlFQtsYa9cimlLwRPv6zXLvY6dCIBn26Yrs1N353HlUthic0ofnVp1JddI8HOzvRrfZ
         H3dIaYo3AlItp34LSCdN0NjjERGBF6MCB6hLaMTNQ5LQ8TdeIcZiFpu/NIhU3+L3gVzL
         n1Ow==
X-Gm-Message-State: AGi0PuaVO1ORQXaE+ZbhblhKU5g40+D4GAvL9W0iZma+JzdbDPvlrbNw
        kbzCz+GnkeBp67WawjcCqUw=
X-Google-Smtp-Source: APiQypJ2qyEhTXzxGYsORCKBFQKiFkFeE0bPOTZr0HeesOeiN9gN+sYakEB/zMk+O2aWJZIYOPVzUw==
X-Received: by 2002:a17:902:988e:: with SMTP id s14mr6380826plp.179.1587689088693;
        Thu, 23 Apr 2020 17:44:48 -0700 (PDT)
Received: from js1304-desktop ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id i14sm3145542pgh.47.2020.04.23.17.44.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 17:44:48 -0700 (PDT)
Date:   Fri, 24 Apr 2020 09:44:42 +0900
From:   Joonsoo Kim <js1304@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 16/18] mm: memcontrol: charge swapin pages on
 instantiation
Message-ID: <20200424004441.GF13929@js1304-desktop>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
 <20200420221126.341272-17-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420221126.341272-17-hannes@cmpxchg.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 20, 2020 at 06:11:24PM -0400, Johannes Weiner wrote:
> Right now, users that are otherwise memory controlled can easily
> escape their containment and allocate significant amounts of memory
> that they're not being charged for. That's because swap readahead
> pages are not being charged until somebody actually faults them into
> their page table. This can be exploited with MADV_WILLNEED, which
> triggers arbitrary readahead allocations without charging the pages.
> 
> There are additional problems with the delayed charging of swap pages:
> 
> 1. To implement refault/workingset detection for anonymous pages, we
>    need to have a target LRU available at swapin time, but the LRU is
>    not determinable until the page has been charged.
> 
> 2. To implement per-cgroup LRU locking, we need page->mem_cgroup to be
>    stable when the page is isolated from the LRU; otherwise, the locks
>    change under us. But swapcache gets charged after it's already on
>    the LRU, and even if we cannot isolate it ourselves (since charging
>    is not exactly optional).
> 
> The previous patch ensured we always maintain cgroup ownership records
> for swap pages. This patch moves the swapcache charging point from the
> fault handler to swapin time to fix all of the above problems.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/memory.c     | 15 ++++++---
>  mm/shmem.c      | 14 ++++----
>  mm/swap_state.c | 89 ++++++++++++++++++++++++++-----------------------
>  mm/swapfile.c   |  6 ----
>  4 files changed, 67 insertions(+), 57 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 3fa379d9b17d..5d266532fc40 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3127,9 +3127,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  			page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma,
>  							vmf->address);
>  			if (page) {
> +				int err;
> +
>  				__SetPageLocked(page);
>  				__SetPageSwapBacked(page);
>  				set_page_private(page, entry.val);
> +
> +				/* Tell memcg to use swap ownership records */
> +				SetPageSwapCache(page);
> +				err = mem_cgroup_charge(page, vma->vm_mm,
> +							GFP_KERNEL, false);
> +				ClearPageSwapCache(page);
> +				if (err)
> +					goto out_page;
> +
>  				lru_cache_add_anon(page);
>  				swap_readpage(page, true);
>  			}
> @@ -3191,10 +3202,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  		goto out_page;
>  	}
>  
> -	if (mem_cgroup_charge(page, vma->vm_mm, GFP_KERNEL, true)) {
> -		ret = VM_FAULT_OOM;
> -		goto out_page;
> -	}
>  	cgroup_throttle_swaprate(page, GFP_KERNEL);
>  
>  	/*
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 363bd11eba85..966f150a4823 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -623,13 +623,15 @@ static int shmem_add_to_page_cache(struct page *page,
>  	page->mapping = mapping;
>  	page->index = index;
>  
> -	error = mem_cgroup_charge(page, charge_mm, gfp, PageSwapCache(page));
> -	if (error) {
> -		if (!PageSwapCache(page) && PageTransHuge(page)) {
> -			count_vm_event(THP_FILE_FALLBACK);
> -			count_vm_event(THP_FILE_FALLBACK_CHARGE);
> +	if (!PageSwapCache(page)) {
> +		error = mem_cgroup_charge(page, charge_mm, gfp, false);
> +		if (error) {
> +			if (PageTransHuge(page)) {
> +				count_vm_event(THP_FILE_FALLBACK);
> +				count_vm_event(THP_FILE_FALLBACK_CHARGE);
> +			}
> +			goto error;
>  		}
> -		goto error;
>  	}
>  	cgroup_throttle_swaprate(page, gfp);
>  
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index ebed37bbf7a3..f3b9073bfff3 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -360,12 +360,13 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  			struct vm_area_struct *vma, unsigned long addr,
>  			bool *new_page_allocated)
>  {
> -	struct page *found_page = NULL, *new_page = NULL;
>  	struct swap_info_struct *si;
> -	int err;
> +	struct page *page;
> +
>  	*new_page_allocated = false;
>  
> -	do {
> +	for (;;) {
> +		int err;
>  		/*
>  		 * First check the swap cache.  Since this is normally
>  		 * called after lookup_swap_cache() failed, re-calling
> @@ -373,12 +374,12 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  		 */
>  		si = get_swap_device(entry);
>  		if (!si)
> -			break;
> -		found_page = find_get_page(swap_address_space(entry),
> -					   swp_offset(entry));
> +			return NULL;
> +		page = find_get_page(swap_address_space(entry),
> +				     swp_offset(entry));
>  		put_swap_device(si);
> -		if (found_page)
> -			break;
> +		if (page)
> +			return page;
>  
>  		/*
>  		 * Just skip read ahead for unused swap slot.
> @@ -389,21 +390,15 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  		 * else swap_off will be aborted if we return NULL.
>  		 */
>  		if (!__swp_swapcount(entry) && swap_slot_cache_enabled)
> -			break;
> -
> -		/*
> -		 * Get a new page to read into from swap.
> -		 */
> -		if (!new_page) {
> -			new_page = alloc_page_vma(gfp_mask, vma, addr);
> -			if (!new_page)
> -				break;		/* Out of memory */
> -		}
> +			return NULL;
>  
>  		/*
>  		 * Swap entry may have been freed since our caller observed it.
>  		 */
>  		err = swapcache_prepare(entry);
> +		if (!err)
> +			break;
> +
>  		if (err == -EEXIST) {
>  			/*
>  			 * We might race against get_swap_page() and stumble
> @@ -412,31 +407,43 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  			 */
>  			cond_resched();
>  			continue;
> -		} else if (err)		/* swp entry is obsolete ? */
> -			break;
> -
> -		/* May fail (-ENOMEM) if XArray node allocation failed. */
> -		__SetPageLocked(new_page);
> -		__SetPageSwapBacked(new_page);
> -		err = add_to_swap_cache(new_page, entry, gfp_mask & GFP_KERNEL);
> -		if (likely(!err)) {
> -			/* Initiate read into locked page */
> -			SetPageWorkingset(new_page);
> -			lru_cache_add_anon(new_page);
> -			*new_page_allocated = true;
> -			return new_page;
>  		}
> -		__ClearPageLocked(new_page);
> -		/*
> -		 * add_to_swap_cache() doesn't return -EEXIST, so we can safely
> -		 * clear SWAP_HAS_CACHE flag.
> -		 */
> -		put_swap_page(new_page, entry);
> -	} while (err != -ENOMEM);
> +		if (err)		/* swp entry is obsolete ? */
> +			return NULL;

"if (err)" is not needed since "!err" is already exiting the loop.

> +	}
> +
> +	/*
> +	 * The swap entry is ours to swap in. Prepare a new page.
> +	 */
> +
> +	page = alloc_page_vma(gfp_mask, vma, addr);
> +	if (!page)
> +		goto fail_free;
> +
> +	__SetPageLocked(page);
> +	__SetPageSwapBacked(page);
> +
> +	/* May fail (-ENOMEM) if XArray node allocation failed. */
> +	if (add_to_swap_cache(page, entry, gfp_mask & GFP_KERNEL))
> +		goto fail_unlock;
> +
> +	if (mem_cgroup_charge(page, NULL, gfp_mask & GFP_KERNEL, false))
> +		goto fail_delete;
> +

I think that following order of operations is better than yours.

1. page alloc
2. memcg charge
3. swapcache_prepare
4. add_to_swap_cache

Reason is that page allocation and memcg charging could take for a
long time due to reclaim and other tasks waiting this swapcache page
could be blocked inbetween swapcache_prepare() and add_to_swap_cache().

Thanks.

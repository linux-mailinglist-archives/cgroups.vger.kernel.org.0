Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C631F58C0
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2020 18:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgFJQKE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 Jun 2020 12:10:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37148 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgFJQKE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 10 Jun 2020 12:10:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id y20so2348861wmi.2;
        Wed, 10 Jun 2020 09:10:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rX41w7tldl0netq5kxFsaT++yOcKI42jONcWAMAnemY=;
        b=VDsK01lewmUpiQDQ1kiAL8n7ZN8N/NmHzriUGfvFpNHPWUzxpuYq5LQUlZ8Zogh9VF
         KlPmqnnK7fPjzVMauR00YMUfH3LVv8br1Q0d71KWaUfmthF3rP+F9xwHs6qgoyl+fUHk
         9bw5CyrtJab5aBwPTLMnc9glkyqimSxafrnNM0oHaLkhfBrNNSjXABzRJ45UywOWjuTM
         O1KdRNvb+oDUTjfCt6KLWY6WEAuUjI+Ol9Cn9T8K6+U6JIYZc5JoTnVH6F2CR+f3RArW
         Ti9IHkYVvHMJPfG/iHn5cUu4Xu6od2DLJb5UAqx90pqKqrR2T6OXKoj3n7CKUojpRQFn
         upFw==
X-Gm-Message-State: AOAM5325vvTQi/Xeu4rD6xtVkD6aw706grR4L6dmz3qwCc2mUd5IxwQH
        islE0f9Ck6WaSO0o233fDCU=
X-Google-Smtp-Source: ABdhPJwAQ8opsLePK385bCOFFgxs7LzTre/fAVst89ErMUx3xzjTRRDgDLIvCyZC/1ewtFGwe1QuzA==
X-Received: by 2002:a7b:c343:: with SMTP id l3mr3935781wmj.178.1591805401044;
        Wed, 10 Jun 2020 09:10:01 -0700 (PDT)
Received: from localhost (ip-37-188-155-130.eurotel.cz. [37.188.155.130])
        by smtp.gmail.com with ESMTPSA id h27sm439997wrb.18.2020.06.10.09.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 09:09:59 -0700 (PDT)
Date:   Wed, 10 Jun 2020 18:09:56 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Joonsoo Kim <js1304@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 05/19] mm: memcontrol: convert page cache to a new
 mem_cgroup_charge() API
Message-ID: <20200610160956.GD20204@dhcp22.suse.cz>
References: <20200508183105.225460-1-hannes@cmpxchg.org>
 <20200508183105.225460-6-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508183105.225460-6-hannes@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

[I am sorry to come here so late. The series has been already merged so I
am not going to add my acks to separate patches.]

On Fri 08-05-20 14:30:52, Johannes Weiner wrote:
> The try/commit/cancel protocol that memcg uses dates back to when
> pages used to be uncharged upon removal from the page cache, and thus
> couldn't be committed before the insertion had succeeded. Nowadays,
> pages are uncharged when they are physically freed; it doesn't matter
> whether the insertion was successful or not. For the page cache, the
> transaction dance has become unnecessary.
> 
> Introduce a mem_cgroup_charge() function that simply charges a newly
> allocated page to a cgroup and sets up page->mem_cgroup in one single
> step. If the insertion fails, the caller doesn't have to do anything
> but free/put the page.
> 
> Then switch the page cache over to this new API.
> 
> Subsequent patches will also convert anon pages, but it needs a bit
> more prep work. Right now, memcg depends on page->mapping being
> already set up at the time of charging, so that it can maintain its
> own MEMCG_CACHE and MEMCG_RSS counters. For anon, page->mapping is set
> under the same pte lock under which the page is publishd, so a single
> charge point that can block doesn't work there just yet.
> 
> The following prep patches will replace the private memcg counters
> with the generic vmstat counters, thus removing the page->mapping
> dependency, then complete the transition to the new single-point
> charge API and delete the old transactional scheme.
> 
> v2: leave shmem swapcache when charging fails to avoid double IO (Joonsoo)
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>

I have to say I like this very much. It simplifies the the charging API
for external users considerably!

> ---
>  include/linux/memcontrol.h | 10 +++++
>  mm/filemap.c               | 24 +++++------
>  mm/memcontrol.c            | 29 ++++++++++++-
>  mm/shmem.c                 | 88 ++++++++++++++++----------------------
>  4 files changed, 85 insertions(+), 66 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 30292d57c8af..57339514d960 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -379,6 +379,10 @@ int mem_cgroup_try_charge_delay(struct page *page, struct mm_struct *mm,
>  void mem_cgroup_commit_charge(struct page *page, struct mem_cgroup *memcg,
>  			      bool lrucare);
>  void mem_cgroup_cancel_charge(struct page *page, struct mem_cgroup *memcg);
> +
> +int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask,
> +		      bool lrucare);
> +
>  void mem_cgroup_uncharge(struct page *page);
>  void mem_cgroup_uncharge_list(struct list_head *page_list);
>  
> @@ -893,6 +897,12 @@ static inline void mem_cgroup_cancel_charge(struct page *page,
>  {
>  }
>  
> +static inline int mem_cgroup_charge(struct page *page, struct mm_struct *mm,
> +				    gfp_t gfp_mask, bool lrucare)
> +{
> +	return 0;
> +}
> +
>  static inline void mem_cgroup_uncharge(struct page *page)
>  {
>  }
> diff --git a/mm/filemap.c b/mm/filemap.c
> index ce200386736c..ee9882509566 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -832,7 +832,6 @@ static int __add_to_page_cache_locked(struct page *page,
>  {
>  	XA_STATE(xas, &mapping->i_pages, offset);
>  	int huge = PageHuge(page);
> -	struct mem_cgroup *memcg;
>  	int error;
>  	void *old;
>  
> @@ -840,17 +839,16 @@ static int __add_to_page_cache_locked(struct page *page,
>  	VM_BUG_ON_PAGE(PageSwapBacked(page), page);
>  	mapping_set_update(&xas, mapping);
>  
> -	if (!huge) {
> -		error = mem_cgroup_try_charge(page, current->mm,
> -					      gfp_mask, &memcg);
> -		if (error)
> -			return error;
> -	}
> -
>  	get_page(page);
>  	page->mapping = mapping;
>  	page->index = offset;
>  
> +	if (!huge) {
> +		error = mem_cgroup_charge(page, current->mm, gfp_mask, false);
> +		if (error)
> +			goto error;
> +	}
> +
>  	do {
>  		xas_lock_irq(&xas);
>  		old = xas_load(&xas);
> @@ -874,20 +872,18 @@ static int __add_to_page_cache_locked(struct page *page,
>  		xas_unlock_irq(&xas);
>  	} while (xas_nomem(&xas, gfp_mask & GFP_RECLAIM_MASK));
>  
> -	if (xas_error(&xas))
> +	if (xas_error(&xas)) {
> +		error = xas_error(&xas);
>  		goto error;
> +	}
>  
> -	if (!huge)
> -		mem_cgroup_commit_charge(page, memcg, false);
>  	trace_mm_filemap_add_to_page_cache(page);
>  	return 0;
>  error:
>  	page->mapping = NULL;
>  	/* Leave page->index set: truncation relies upon it */
> -	if (!huge)
> -		mem_cgroup_cancel_charge(page, memcg);
>  	put_page(page);
> -	return xas_error(&xas);
> +	return error;
>  }
>  ALLOW_ERROR_INJECTION(__add_to_page_cache_locked, ERRNO);
>  
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 8188d462d7ce..1d45a09b334f 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6578,6 +6578,33 @@ void mem_cgroup_cancel_charge(struct page *page, struct mem_cgroup *memcg)
>  	cancel_charge(memcg, nr_pages);
>  }
>  
> +/**
> + * mem_cgroup_charge - charge a newly allocated page to a cgroup
> + * @page: page to charge
> + * @mm: mm context of the victim
> + * @gfp_mask: reclaim mode
> + * @lrucare: page might be on the LRU already
> + *
> + * Try to charge @page to the memcg that @mm belongs to, reclaiming
> + * pages according to @gfp_mask if necessary.
> + *
> + * Returns 0 on success. Otherwise, an error code is returned.
> + */
> +int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask,
> +		      bool lrucare)
> +{
> +	struct mem_cgroup *memcg;
> +	int ret;
> +
> +	VM_BUG_ON_PAGE(!page->mapping, page);
> +
> +	ret = mem_cgroup_try_charge(page, mm, gfp_mask, &memcg);
> +	if (ret)
> +		return ret;
> +	mem_cgroup_commit_charge(page, memcg, lrucare);
> +	return 0;
> +}
> +
>  struct uncharge_gather {
>  	struct mem_cgroup *memcg;
>  	unsigned long pgpgout;
> @@ -6625,8 +6652,6 @@ static void uncharge_batch(const struct uncharge_gather *ug)
>  static void uncharge_page(struct page *page, struct uncharge_gather *ug)
>  {
>  	VM_BUG_ON_PAGE(PageLRU(page), page);
> -	VM_BUG_ON_PAGE(page_count(page) && !is_zone_device_page(page) &&
> -			!PageHWPoison(page) , page);
>  
>  	if (!page->mem_cgroup)
>  		return;
> diff --git a/mm/shmem.c b/mm/shmem.c
> index d505b6cce4ab..afd5a057ebb7 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -605,11 +605,13 @@ static inline bool is_huge_enabled(struct shmem_sb_info *sbinfo)
>   */
>  static int shmem_add_to_page_cache(struct page *page,
>  				   struct address_space *mapping,
> -				   pgoff_t index, void *expected, gfp_t gfp)
> +				   pgoff_t index, void *expected, gfp_t gfp,
> +				   struct mm_struct *charge_mm)
>  {
>  	XA_STATE_ORDER(xas, &mapping->i_pages, index, compound_order(page));
>  	unsigned long i = 0;
>  	unsigned long nr = compound_nr(page);
> +	int error;
>  
>  	VM_BUG_ON_PAGE(PageTail(page), page);
>  	VM_BUG_ON_PAGE(index != round_down(index, nr), page);
> @@ -621,12 +623,22 @@ static int shmem_add_to_page_cache(struct page *page,
>  	page->mapping = mapping;
>  	page->index = index;
>  
> +	error = mem_cgroup_charge(page, charge_mm, gfp, PageSwapCache(page));
> +	if (error) {
> +		if (!PageSwapCache(page) && PageTransHuge(page)) {
> +			count_vm_event(THP_FILE_FALLBACK);
> +			count_vm_event(THP_FILE_FALLBACK_CHARGE);
> +		}
> +		goto error;
> +	}
> +	cgroup_throttle_swaprate(page, gfp);
> +
>  	do {
>  		void *entry;
>  		xas_lock_irq(&xas);
>  		entry = xas_find_conflict(&xas);
>  		if (entry != expected)
> -			xas_set_err(&xas, -EEXIST);
> +			xas_set_err(&xas, expected ? -ENOENT : -EEXIST);
>  		xas_create_range(&xas);
>  		if (xas_error(&xas))
>  			goto unlock;
> @@ -648,12 +660,15 @@ static int shmem_add_to_page_cache(struct page *page,
>  	} while (xas_nomem(&xas, gfp));
>  
>  	if (xas_error(&xas)) {
> -		page->mapping = NULL;
> -		page_ref_sub(page, nr);
> -		return xas_error(&xas);
> +		error = xas_error(&xas);
> +		goto error;
>  	}
>  
>  	return 0;
> +error:
> +	page->mapping = NULL;
> +	page_ref_sub(page, nr);
> +	return error;
>  }
>  
>  /*
> @@ -1619,7 +1634,6 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
>  	struct address_space *mapping = inode->i_mapping;
>  	struct shmem_inode_info *info = SHMEM_I(inode);
>  	struct mm_struct *charge_mm = vma ? vma->vm_mm : current->mm;
> -	struct mem_cgroup *memcg;
>  	struct page *page;
>  	swp_entry_t swap;
>  	int error;
> @@ -1664,29 +1678,23 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
>  			goto failed;
>  	}
>  
> -	error = mem_cgroup_try_charge_delay(page, charge_mm, gfp, &memcg);
> -	if (!error) {
> -		error = shmem_add_to_page_cache(page, mapping, index,
> -						swp_to_radix_entry(swap), gfp);
> +	error = shmem_add_to_page_cache(page, mapping, index,
> +					swp_to_radix_entry(swap), gfp,
> +					charge_mm);
> +	if (error) {
>  		/*
> -		 * We already confirmed swap under page lock, and make
> -		 * no memory allocation here, so usually no possibility
> -		 * of error; but free_swap_and_cache() only trylocks a
> -		 * page, so it is just possible that the entry has been
> -		 * truncated or holepunched since swap was confirmed.
> +		 * We already confirmed swap under page lock, but
> +		 * free_swap_and_cache() only trylocks a page, so it
> +		 * is just possible that the entry has been truncated
> +		 * or holepunched since swap was confirmed.
>  		 * shmem_undo_range() will have done some of the
>  		 * unaccounting, now delete_from_swap_cache() will do
>  		 * the rest.
>  		 */
> -		if (error) {
> -			mem_cgroup_cancel_charge(page, memcg);
> +		if (error == -ENOENT)
>  			delete_from_swap_cache(page);
> -		}
> -	}
> -	if (error)
>  		goto failed;
> -
> -	mem_cgroup_commit_charge(page, memcg, true);
> +	}
>  
>  	spin_lock_irq(&info->lock);
>  	info->swapped--;
> @@ -1733,7 +1741,6 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
>  	struct shmem_inode_info *info = SHMEM_I(inode);
>  	struct shmem_sb_info *sbinfo;
>  	struct mm_struct *charge_mm;
> -	struct mem_cgroup *memcg;
>  	struct page *page;
>  	enum sgp_type sgp_huge = sgp;
>  	pgoff_t hindex = index;
> @@ -1858,21 +1865,11 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
>  	if (sgp == SGP_WRITE)
>  		__SetPageReferenced(page);
>  
> -	error = mem_cgroup_try_charge_delay(page, charge_mm, gfp, &memcg);
> -	if (error) {
> -		if (PageTransHuge(page)) {
> -			count_vm_event(THP_FILE_FALLBACK);
> -			count_vm_event(THP_FILE_FALLBACK_CHARGE);
> -		}
> -		goto unacct;
> -	}
>  	error = shmem_add_to_page_cache(page, mapping, hindex,
> -					NULL, gfp & GFP_RECLAIM_MASK);
> -	if (error) {
> -		mem_cgroup_cancel_charge(page, memcg);
> +					NULL, gfp & GFP_RECLAIM_MASK,
> +					charge_mm);
> +	if (error)
>  		goto unacct;
> -	}
> -	mem_cgroup_commit_charge(page, memcg, false);
>  	lru_cache_add_anon(page);
>  
>  	spin_lock_irq(&info->lock);
> @@ -2310,7 +2307,6 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
>  	struct address_space *mapping = inode->i_mapping;
>  	gfp_t gfp = mapping_gfp_mask(mapping);
>  	pgoff_t pgoff = linear_page_index(dst_vma, dst_addr);
> -	struct mem_cgroup *memcg;
>  	spinlock_t *ptl;
>  	void *page_kaddr;
>  	struct page *page;
> @@ -2360,16 +2356,10 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
>  	if (unlikely(offset >= max_off))
>  		goto out_release;
>  
> -	ret = mem_cgroup_try_charge_delay(page, dst_mm, gfp, &memcg);
> -	if (ret)
> -		goto out_release;
> -
>  	ret = shmem_add_to_page_cache(page, mapping, pgoff, NULL,
> -						gfp & GFP_RECLAIM_MASK);
> +				      gfp & GFP_RECLAIM_MASK, dst_mm);
>  	if (ret)
> -		goto out_release_uncharge;
> -
> -	mem_cgroup_commit_charge(page, memcg, false);
> +		goto out_release;
>  
>  	_dst_pte = mk_pte(page, dst_vma->vm_page_prot);
>  	if (dst_vma->vm_flags & VM_WRITE)
> @@ -2390,11 +2380,11 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
>  	ret = -EFAULT;
>  	max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
>  	if (unlikely(offset >= max_off))
> -		goto out_release_uncharge_unlock;
> +		goto out_release_unlock;
>  
>  	ret = -EEXIST;
>  	if (!pte_none(*dst_pte))
> -		goto out_release_uncharge_unlock;
> +		goto out_release_unlock;
>  
>  	lru_cache_add_anon(page);
>  
> @@ -2415,12 +2405,10 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
>  	ret = 0;
>  out:
>  	return ret;
> -out_release_uncharge_unlock:
> +out_release_unlock:
>  	pte_unmap_unlock(dst_pte, ptl);
>  	ClearPageDirty(page);
>  	delete_from_page_cache(page);
> -out_release_uncharge:
> -	mem_cgroup_cancel_charge(page, memcg);
>  out_release:
>  	unlock_page(page);
>  	put_page(page);
> -- 
> 2.26.2
> 

-- 
Michal Hocko
SUSE Labs

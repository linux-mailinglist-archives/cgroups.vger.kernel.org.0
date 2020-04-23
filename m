Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA181B542A
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2020 07:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgDWFZs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Apr 2020 01:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725854AbgDWFZs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Apr 2020 01:25:48 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BBAC03C1AB;
        Wed, 22 Apr 2020 22:25:48 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id y6so1957455pjc.4;
        Wed, 22 Apr 2020 22:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KOR+pkwGDNcYktV6CokI58/HFlTGZDwzUSv+j2FTvUE=;
        b=HrriKOxLAgPT1t39QMIoZmvkG/Pz29QKfYIy5TmvfFVuiNvyTTyYVdBdDHlhuxDQZB
         VHFWa+LrZv4OyEt841x7bq9b1enpcxrtL1h0PiI+t+/nsKRGkM9UeEj5AwHI57DZFfOv
         fKIYW/Qc1Cegl/BFNpuhQBpUUPGRulryKncva+XPCfPFdcSod1TV0Gl9PMnXQDJZASc7
         owG5dZYIUbTIhLRzW4mywA019yNGPBSijqdBrJT32updAR4nPL9t031SJar/qk8X2f+H
         dEWQ5iS/GO/z7oCFNPUvZ2SNAnTwSB/rmVFZ4QcTtsyF7dBWk4+t1lvLpccHxsgIvArb
         qcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KOR+pkwGDNcYktV6CokI58/HFlTGZDwzUSv+j2FTvUE=;
        b=m21+VyGdMWeNr0/9h5Ihtg6jGkVlmgwyoxUorgsbId2XG2NYDkk3eUJBI2Aeg4142M
         2GUl8iwQDqny5xSYzpxv3f3M6/o/uiC+zOuSqxbCrDpVh9E3/t2CzQN9oITHInBE0rK6
         z7F6swkmq3hUAugc9Zw4vGZM/qZM8me/kzf5VN6/US2r2kZildhLN/YaemllMpaVTFXF
         YeZH3O5NyVkpU+KPJuptmp+J0C/WDSVP7dTofTKrLVgzZeuto4P5e3kxe7ixG17YKR8t
         kMarrKhZmckYryUSJY77jLgSLiC/XhZhiO3pxJZRSXhWVviO+c1RqfNlDDwqcwsmc902
         ugQA==
X-Gm-Message-State: AGi0PubERYxTlIt9ksdNZepZJYvwzBsh/UsQQ0lp1RyUUpSojC9IVnhy
        sDaH0BKKxgnKsKGgAOBzhAw=
X-Google-Smtp-Source: APiQypLVlLX05sFGKRlANA1iymE4lkEN08gaD02wL+I9Z8khZjM9C5Zg08qyC13Kj8qi2ELiPYlpGA==
X-Received: by 2002:a17:90a:2170:: with SMTP id a103mr2453748pje.181.1587619547174;
        Wed, 22 Apr 2020 22:25:47 -0700 (PDT)
Received: from js1304-desktop ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id i185sm1299665pfg.14.2020.04.22.22.25.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2020 22:25:46 -0700 (PDT)
Date:   Thu, 23 Apr 2020 14:25:06 +0900
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
Subject: Re: [PATCH 05/18] mm: memcontrol: convert page cache to a new
 mem_cgroup_charge() API
Message-ID: <20200423052450.GA12538@js1304-desktop>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
 <20200420221126.341272-6-hannes@cmpxchg.org>
 <20200422064041.GE6780@js1304-desktop>
 <20200422120946.GA358439@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422120946.GA358439@cmpxchg.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 22, 2020 at 08:09:46AM -0400, Johannes Weiner wrote:
> On Wed, Apr 22, 2020 at 03:40:41PM +0900, Joonsoo Kim wrote:
> > On Mon, Apr 20, 2020 at 06:11:13PM -0400, Johannes Weiner wrote:
> > > The try/commit/cancel protocol that memcg uses dates back to when
> > > pages used to be uncharged upon removal from the page cache, and thus
> > > couldn't be committed before the insertion had succeeded. Nowadays,
> > > pages are uncharged when they are physically freed; it doesn't matter
> > > whether the insertion was successful or not. For the page cache, the
> > > transaction dance has become unnecessary.
> > > 
> > > Introduce a mem_cgroup_charge() function that simply charges a newly
> > > allocated page to a cgroup and sets up page->mem_cgroup in one single
> > > step. If the insertion fails, the caller doesn't have to do anything
> > > but free/put the page.
> > > 
> > > Then switch the page cache over to this new API.
> > > 
> > > Subsequent patches will also convert anon pages, but it needs a bit
> > > more prep work. Right now, memcg depends on page->mapping being
> > > already set up at the time of charging, so that it can maintain its
> > > own MEMCG_CACHE and MEMCG_RSS counters. For anon, page->mapping is set
> > > under the same pte lock under which the page is publishd, so a single
> > > charge point that can block doesn't work there just yet.
> > > 
> > > The following prep patches will replace the private memcg counters
> > > with the generic vmstat counters, thus removing the page->mapping
> > > dependency, then complete the transition to the new single-point
> > > charge API and delete the old transactional scheme.
> > > 
> > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > > ---
> > >  include/linux/memcontrol.h | 10 ++++
> > >  mm/filemap.c               | 24 ++++------
> > >  mm/memcontrol.c            | 27 +++++++++++
> > >  mm/shmem.c                 | 97 +++++++++++++++++---------------------
> > >  4 files changed, 89 insertions(+), 69 deletions(-)
> > > 
> > > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > > index c7875a48c8c1..5e8b0e38f145 100644
> > > --- a/include/linux/memcontrol.h
> > > +++ b/include/linux/memcontrol.h
> > > @@ -367,6 +367,10 @@ int mem_cgroup_try_charge_delay(struct page *page, struct mm_struct *mm,
> > >  void mem_cgroup_commit_charge(struct page *page, struct mem_cgroup *memcg,
> > >  			      bool lrucare);
> > >  void mem_cgroup_cancel_charge(struct page *page, struct mem_cgroup *memcg);
> > > +
> > > +int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask,
> > > +		      bool lrucare);
> > > +
> > >  void mem_cgroup_uncharge(struct page *page);
> > >  void mem_cgroup_uncharge_list(struct list_head *page_list);
> > >  
> > > @@ -872,6 +876,12 @@ static inline void mem_cgroup_cancel_charge(struct page *page,
> > >  {
> > >  }
> > >  
> > > +static inline int mem_cgroup_charge(struct page *page, struct mm_struct *mm,
> > > +				    gfp_t gfp_mask, bool lrucare)
> > > +{
> > > +	return 0;
> > > +}
> > > +
> > >  static inline void mem_cgroup_uncharge(struct page *page)
> > >  {
> > >  }
> > > diff --git a/mm/filemap.c b/mm/filemap.c
> > > index 5b31af9d5b1b..5bdbda965177 100644
> > > --- a/mm/filemap.c
> > > +++ b/mm/filemap.c
> > > @@ -832,7 +832,6 @@ static int __add_to_page_cache_locked(struct page *page,
> > >  {
> > >  	XA_STATE(xas, &mapping->i_pages, offset);
> > >  	int huge = PageHuge(page);
> > > -	struct mem_cgroup *memcg;
> > >  	int error;
> > >  	void *old;
> > >  
> > > @@ -840,17 +839,16 @@ static int __add_to_page_cache_locked(struct page *page,
> > >  	VM_BUG_ON_PAGE(PageSwapBacked(page), page);
> > >  	mapping_set_update(&xas, mapping);
> > >  
> > > -	if (!huge) {
> > > -		error = mem_cgroup_try_charge(page, current->mm,
> > > -					      gfp_mask, &memcg);
> > > -		if (error)
> > > -			return error;
> > > -	}
> > > -
> > >  	get_page(page);
> > >  	page->mapping = mapping;
> > >  	page->index = offset;
> > >  
> > > +	if (!huge) {
> > > +		error = mem_cgroup_charge(page, current->mm, gfp_mask, false);
> > > +		if (error)
> > > +			goto error;
> > > +	}
> > > +
> > >  	do {
> > >  		xas_lock_irq(&xas);
> > >  		old = xas_load(&xas);
> > > @@ -874,20 +872,18 @@ static int __add_to_page_cache_locked(struct page *page,
> > >  		xas_unlock_irq(&xas);
> > >  	} while (xas_nomem(&xas, gfp_mask & GFP_RECLAIM_MASK));
> > >  
> > > -	if (xas_error(&xas))
> > > +	if (xas_error(&xas)) {
> > > +		error = xas_error(&xas);
> > >  		goto error;
> > > +	}
> > >  
> > > -	if (!huge)
> > > -		mem_cgroup_commit_charge(page, memcg, false);
> > >  	trace_mm_filemap_add_to_page_cache(page);
> > >  	return 0;
> > >  error:
> > >  	page->mapping = NULL;
> > >  	/* Leave page->index set: truncation relies upon it */
> > > -	if (!huge)
> > > -		mem_cgroup_cancel_charge(page, memcg);
> > >  	put_page(page);
> > > -	return xas_error(&xas);
> > > +	return error;
> > >  }
> > >  ALLOW_ERROR_INJECTION(__add_to_page_cache_locked, ERRNO);
> > >  
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 711d6dd5cbb1..b38c0a672d26 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -6577,6 +6577,33 @@ void mem_cgroup_cancel_charge(struct page *page, struct mem_cgroup *memcg)
> > >  	cancel_charge(memcg, nr_pages);
> > >  }
> > >  
> > > +/**
> > > + * mem_cgroup_charge - charge a newly allocated page to a cgroup
> > > + * @page: page to charge
> > > + * @mm: mm context of the victim
> > > + * @gfp_mask: reclaim mode
> > > + * @lrucare: page might be on the LRU already
> > > + *
> > > + * Try to charge @page to the memcg that @mm belongs to, reclaiming
> > > + * pages according to @gfp_mask if necessary.
> > > + *
> > > + * Returns 0 on success. Otherwise, an error code is returned.
> > > + */
> > > +int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask,
> > > +		      bool lrucare)
> > > +{
> > > +	struct mem_cgroup *memcg;
> > > +	int ret;
> > > +
> > > +	VM_BUG_ON_PAGE(!page->mapping, page);
> > > +
> > > +	ret = mem_cgroup_try_charge(page, mm, gfp_mask, &memcg);
> > > +	if (ret)
> > > +		return ret;
> > > +	mem_cgroup_commit_charge(page, memcg, lrucare);
> > > +	return 0;
> > > +}
> > > +
> > >  struct uncharge_gather {
> > >  	struct mem_cgroup *memcg;
> > >  	unsigned long pgpgout;
> > > diff --git a/mm/shmem.c b/mm/shmem.c
> > > index 52c66801321e..2384f6c7ef71 100644
> > > --- a/mm/shmem.c
> > > +++ b/mm/shmem.c
> > > @@ -605,11 +605,13 @@ static inline bool is_huge_enabled(struct shmem_sb_info *sbinfo)
> > >   */
> > >  static int shmem_add_to_page_cache(struct page *page,
> > >  				   struct address_space *mapping,
> > > -				   pgoff_t index, void *expected, gfp_t gfp)
> > > +				   pgoff_t index, void *expected, gfp_t gfp,
> > > +				   struct mm_struct *charge_mm)
> > >  {
> > >  	XA_STATE_ORDER(xas, &mapping->i_pages, index, compound_order(page));
> > >  	unsigned long i = 0;
> > >  	unsigned long nr = compound_nr(page);
> > > +	int error;
> > >  
> > >  	VM_BUG_ON_PAGE(PageTail(page), page);
> > >  	VM_BUG_ON_PAGE(index != round_down(index, nr), page);
> > > @@ -621,6 +623,16 @@ static int shmem_add_to_page_cache(struct page *page,
> > >  	page->mapping = mapping;
> > >  	page->index = index;
> > >  
> > > +	error = mem_cgroup_charge(page, charge_mm, gfp, PageSwapCache(page));
> > > +	if (error) {
> > > +		if (!PageSwapCache(page) && PageTransHuge(page)) {
> > > +			count_vm_event(THP_FILE_FALLBACK);
> > > +			count_vm_event(THP_FILE_FALLBACK_CHARGE);
> > > +		}
> > > +		goto error;
> > > +	}
> > > +	cgroup_throttle_swaprate(page, gfp);
> > > +
> > >  	do {
> > >  		void *entry;
> > >  		xas_lock_irq(&xas);
> > > @@ -648,12 +660,15 @@ static int shmem_add_to_page_cache(struct page *page,
> > >  	} while (xas_nomem(&xas, gfp));
> > >  
> > >  	if (xas_error(&xas)) {
> > > -		page->mapping = NULL;
> > > -		page_ref_sub(page, nr);
> > > -		return xas_error(&xas);
> > > +		error = xas_error(&xas);
> > > +		goto error;
> > >  	}
> > >  
> > >  	return 0;
> > > +error:
> > > +	page->mapping = NULL;
> > > +	page_ref_sub(page, nr);
> > > +	return error;
> > >  }
> > >  
> > >  /*
> > > @@ -1619,7 +1634,6 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
> > >  	struct address_space *mapping = inode->i_mapping;
> > >  	struct shmem_inode_info *info = SHMEM_I(inode);
> > >  	struct mm_struct *charge_mm = vma ? vma->vm_mm : current->mm;
> > > -	struct mem_cgroup *memcg;
> > >  	struct page *page;
> > >  	swp_entry_t swap;
> > >  	int error;
> > > @@ -1664,29 +1678,22 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
> > >  			goto failed;
> > >  	}
> > >  
> > > -	error = mem_cgroup_try_charge_delay(page, charge_mm, gfp, &memcg);
> > > -	if (!error) {
> > > -		error = shmem_add_to_page_cache(page, mapping, index,
> > > -						swp_to_radix_entry(swap), gfp);
> > > -		/*
> > > -		 * We already confirmed swap under page lock, and make
> > > -		 * no memory allocation here, so usually no possibility
> > > -		 * of error; but free_swap_and_cache() only trylocks a
> > > -		 * page, so it is just possible that the entry has been
> > > -		 * truncated or holepunched since swap was confirmed.
> > > -		 * shmem_undo_range() will have done some of the
> > > -		 * unaccounting, now delete_from_swap_cache() will do
> > > -		 * the rest.
> > > -		 */
> > > -		if (error) {
> > > -			mem_cgroup_cancel_charge(page, memcg);
> > > -			delete_from_swap_cache(page);
> > > -		}
> > > -	}
> > > -	if (error)
> > > +	error = shmem_add_to_page_cache(page, mapping, index,
> > > +					swp_to_radix_entry(swap), gfp,
> > > +					charge_mm);
> > > +	/*
> > > +	 * We already confirmed swap under page lock, and make no
> > > +	 * memory allocation here, so usually no possibility of error;
> > > +	 * but free_swap_and_cache() only trylocks a page, so it is
> > > +	 * just possible that the entry has been truncated or
> > > +	 * holepunched since swap was confirmed.  shmem_undo_range()
> > > +	 * will have done some of the unaccounting, now
> > > +	 * delete_from_swap_cache() will do the rest.
> > > +	 */
> > > +	if (error) {
> > > +		delete_from_swap_cache(page);
> > >  		goto failed;
> > 
> > -EEXIST (from swap cache) and -ENOMEM (from memcg) should be handled
> > differently. delete_from_swap_cache() is for -EEXIST case.
> 
> Good catch, I accidentally changed things here.
> 
> I was just going to change it back, but now I'm trying to understand
> how it actually works.
> 
> Who is removing the page from swap cache if shmem_undo_range() races
> but we fail to charge the page?
> 
> Here is how this race is supposed to be handled: The page is in the
> swapcache, we have it locked and confirmed that the entry in i_pages
> is indeed a swap entry. We charge the page, then we try to replace the
> swap entry in i_pages with the actual page. If we determine, under
> tree lock now, that shmem_undo_range has raced with us, unaccounted
> the swap space, but must have failed to get the page lock, we remove
> the page from swap cache on our side, to free up swap slot and page.
> 
> But what if shmem_undo_range() raced with us, deleted the swap entry
> from i_pages while we had the page locked, but then we simply failed
> to charge? We unlock the page and return -EEXIST (shmem_confirm_swap
> at the exit). The page with its userdata is now in swapcache, but no
> corresponding swap entry in i_pages. shmem_getpage_gfp() sees the
> -EEXIST, retries, finds nothing in i_pages and allocates a new, empty
> page.
> 
> Aren't we leaking the swap slot and the page?

Yes, you're right! It seems that it's possible to leak the swap slot
and the page. Race could happen for all the places after lock_page()
and shmem_confirm_swap() are done. And, I think that it's not possible
to fix the problem in shmem_swapin_page() side since we can't know the
timing that trylock_page() is called. Maybe, solution would be,
instead of using free_swap_and_cache() in shmem_undo_range() that
calls trylock_page(), to use another function that calls lock_page().

Thanks.

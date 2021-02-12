Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F5A319C5A
	for <lists+cgroups@lfdr.de>; Fri, 12 Feb 2021 11:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhBLKHC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Feb 2021 05:07:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:40600 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230287AbhBLKGV (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 12 Feb 2021 05:06:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613124332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DCMU+SNVi9LrmGxlBwBdqGWjuIz/B/V9ZdK3fwnkJ4o=;
        b=E7NcXPfWBUJmcZoA0RwgIJRCJZBZ7N/EncAEAq6h0yU4Yav0ZaIvYQh0TQ/bFt6kvTRMRw
        pC51eOvinqYijIAjvrztJK5Obe4izKvquhhn+zffFuyip5lKGhhAzIusP7NOqOkBkBDNCE
        josfV6qx7+IuEosXWGrDazb+gfYwq4U=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 82BDBB141;
        Fri, 12 Feb 2021 10:05:32 +0000 (UTC)
Date:   Fri, 12 Feb 2021 11:05:31 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2] mm: page-writeback: simplify memcg handling in
 test_clear_page_writeback()
Message-ID: <YCZS6yKKsGCWZQj1@dhcp22.suse.cz>
References: <20210209214543.112655-1-hannes@cmpxchg.org>
 <alpine.LSU.2.11.2102092058290.7553@eggly.anvils>
 <alpine.LSU.2.11.2102100813050.8131@eggly.anvils>
 <YCQbYAWg4nvBFL6h@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCQbYAWg4nvBFL6h@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 10-02-21 12:44:00, Johannes Weiner wrote:
[...]
> >From 5bcc0f468460aa2670c40318bb657e8b08ef96d5 Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Tue, 9 Feb 2021 16:22:42 -0500
> Subject: [PATCH] mm: page-writeback: simplify memcg handling in
>  test_clear_page_writeback()
> 
> Page writeback doesn't hold a page reference, which allows truncate to
> free a page the second PageWriteback is cleared. This used to require
> special attention in test_clear_page_writeback(), where we had to be
> careful not to rely on the unstable page->memcg binding and look up
> all the necessary information before clearing the writeback flag.
> 
> Since commit 073861ed77b6 ("mm: fix VM_BUG_ON(PageTail) and
> BUG_ON(PageWriteback)") test_clear_page_writeback() is called with an
> explicit reference on the page, and this dance is no longer needed.
> 
> Use unlock_page_memcg() and dec_lruvec_page_state() directly.
> 
> This removes the last user of the lock_page_memcg() return value,
> change it to void. Touch up the comments in there as well. This also
> removes the last extern user of __unlock_page_memcg(), make it
> static. Further, it removes the last user of dec_lruvec_state(),
> delete it, along with a few other unused helpers.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Hugh Dickins <hughd@google.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  include/linux/memcontrol.h | 10 ++--------
>  include/linux/vmstat.h     | 24 +++---------------------
>  mm/memcontrol.c            | 36 +++++++++++-------------------------
>  mm/page-writeback.c        |  9 +++------
>  4 files changed, 19 insertions(+), 60 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index a44b2d51aecc..b17053af3287 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -874,8 +874,7 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg);
>  extern bool cgroup_memory_noswap;
>  #endif
>  
> -struct mem_cgroup *lock_page_memcg(struct page *page);
> -void __unlock_page_memcg(struct mem_cgroup *memcg);
> +void lock_page_memcg(struct page *page);
>  void unlock_page_memcg(struct page *page);
>  
>  void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val);
> @@ -1269,12 +1268,7 @@ mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
>  {
>  }
>  
> -static inline struct mem_cgroup *lock_page_memcg(struct page *page)
> -{
> -	return NULL;
> -}
> -
> -static inline void __unlock_page_memcg(struct mem_cgroup *memcg)
> +static inline void lock_page_memcg(struct page *page)
>  {
>  }
>  
> diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> index 506d625163a1..3299cd69e4ca 100644
> --- a/include/linux/vmstat.h
> +++ b/include/linux/vmstat.h
> @@ -512,16 +512,10 @@ static inline void mod_lruvec_page_state(struct page *page,
>  
>  #endif /* CONFIG_MEMCG */
>  
> -static inline void __inc_lruvec_state(struct lruvec *lruvec,
> -				      enum node_stat_item idx)
> -{
> -	__mod_lruvec_state(lruvec, idx, 1);
> -}
> -
> -static inline void __dec_lruvec_state(struct lruvec *lruvec,
> -				      enum node_stat_item idx)
> +static inline void inc_lruvec_state(struct lruvec *lruvec,
> +				    enum node_stat_item idx)
>  {
> -	__mod_lruvec_state(lruvec, idx, -1);
> +	mod_lruvec_state(lruvec, idx, 1);
>  }
>  
>  static inline void __inc_lruvec_page_state(struct page *page,
> @@ -536,18 +530,6 @@ static inline void __dec_lruvec_page_state(struct page *page,
>  	__mod_lruvec_page_state(page, idx, -1);
>  }
>  
> -static inline void inc_lruvec_state(struct lruvec *lruvec,
> -				    enum node_stat_item idx)
> -{
> -	mod_lruvec_state(lruvec, idx, 1);
> -}
> -
> -static inline void dec_lruvec_state(struct lruvec *lruvec,
> -				    enum node_stat_item idx)
> -{
> -	mod_lruvec_state(lruvec, idx, -1);
> -}
> -
>  static inline void inc_lruvec_page_state(struct page *page,
>  					 enum node_stat_item idx)
>  {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 9e455815fb7a..e29d3d64c27e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2124,11 +2124,10 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg)
>   * This function protects unlocked LRU pages from being moved to
>   * another cgroup.
>   *
> - * It ensures lifetime of the returned memcg. Caller is responsible
> - * for the lifetime of the page; __unlock_page_memcg() is available
> - * when @page might get freed inside the locked section.
> + * It ensures lifetime of the locked memcg. Caller is responsible
> + * for the lifetime of the page.
>   */
> -struct mem_cgroup *lock_page_memcg(struct page *page)
> +void lock_page_memcg(struct page *page)
>  {
>  	struct page *head = compound_head(page); /* rmap on tail pages */
>  	struct mem_cgroup *memcg;
> @@ -2138,21 +2137,15 @@ struct mem_cgroup *lock_page_memcg(struct page *page)
>  	 * The RCU lock is held throughout the transaction.  The fast
>  	 * path can get away without acquiring the memcg->move_lock
>  	 * because page moving starts with an RCU grace period.
> -	 *
> -	 * The RCU lock also protects the memcg from being freed when
> -	 * the page state that is going to change is the only thing
> -	 * preventing the page itself from being freed. E.g. writeback
> -	 * doesn't hold a page reference and relies on PG_writeback to
> -	 * keep off truncation, migration and so forth.
>           */
>  	rcu_read_lock();
>  
>  	if (mem_cgroup_disabled())
> -		return NULL;
> +		return;
>  again:
>  	memcg = page_memcg(head);
>  	if (unlikely(!memcg))
> -		return NULL;
> +		return;
>  
>  #ifdef CONFIG_PROVE_LOCKING
>  	local_irq_save(flags);
> @@ -2161,7 +2154,7 @@ struct mem_cgroup *lock_page_memcg(struct page *page)
>  #endif
>  
>  	if (atomic_read(&memcg->moving_account) <= 0)
> -		return memcg;
> +		return;
>  
>  	spin_lock_irqsave(&memcg->move_lock, flags);
>  	if (memcg != page_memcg(head)) {
> @@ -2170,24 +2163,17 @@ struct mem_cgroup *lock_page_memcg(struct page *page)
>  	}
>  
>  	/*
> -	 * When charge migration first begins, we can have locked and
> -	 * unlocked page stat updates happening concurrently.  Track
> -	 * the task who has the lock for unlock_page_memcg().
> +	 * When charge migration first begins, we can have multiple
> +	 * critical sections holding the fast-path RCU lock and one
> +	 * holding the slowpath move_lock. Track the task who has the
> +	 * move_lock for unlock_page_memcg().
>  	 */
>  	memcg->move_lock_task = current;
>  	memcg->move_lock_flags = flags;
> -
> -	return memcg;
>  }
>  EXPORT_SYMBOL(lock_page_memcg);
>  
> -/**
> - * __unlock_page_memcg - unlock and unpin a memcg
> - * @memcg: the memcg
> - *
> - * Unlock and unpin a memcg returned by lock_page_memcg().
> - */
> -void __unlock_page_memcg(struct mem_cgroup *memcg)
> +static void __unlock_page_memcg(struct mem_cgroup *memcg)
>  {
>  	if (memcg && memcg->move_lock_task == current) {
>  		unsigned long flags = memcg->move_lock_flags;
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index eb34d204d4ee..f6c2c3165d4d 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2722,12 +2722,9 @@ EXPORT_SYMBOL(clear_page_dirty_for_io);
>  int test_clear_page_writeback(struct page *page)
>  {
>  	struct address_space *mapping = page_mapping(page);
> -	struct mem_cgroup *memcg;
> -	struct lruvec *lruvec;
>  	int ret;
>  
> -	memcg = lock_page_memcg(page);
> -	lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
> +	lock_page_memcg(page);
>  	if (mapping && mapping_use_writeback_tags(mapping)) {
>  		struct inode *inode = mapping->host;
>  		struct backing_dev_info *bdi = inode_to_bdi(inode);
> @@ -2755,11 +2752,11 @@ int test_clear_page_writeback(struct page *page)
>  		ret = TestClearPageWriteback(page);
>  	}
>  	if (ret) {
> -		dec_lruvec_state(lruvec, NR_WRITEBACK);
> +		dec_lruvec_page_state(page, NR_WRITEBACK);
>  		dec_zone_page_state(page, NR_ZONE_WRITE_PENDING);
>  		inc_node_page_state(page, NR_WRITTEN);
>  	}
> -	__unlock_page_memcg(memcg);
> +	unlock_page_memcg(page);
>  	return ret;
>  }
>  
> -- 
> 2.30.0
> 

-- 
Michal Hocko
SUSE Labs

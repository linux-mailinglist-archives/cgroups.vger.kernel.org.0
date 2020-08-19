Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5872497C7
	for <lists+cgroups@lfdr.de>; Wed, 19 Aug 2020 09:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgHSHyl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Aug 2020 03:54:41 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:55191 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726342AbgHSHye (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Aug 2020 03:54:34 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0U6CdRlv_1597823666;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U6CdRlv_1597823666)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 19 Aug 2020 15:54:28 +0800
Subject: Re: [RFC PATCH v2 4/5] mm: Split release_pages work into 3 passes
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     yang.shi@linux.alibaba.com, lkp@intel.com, rong.a.chen@intel.com,
        khlebnikov@yandex-team.ru, kirill@shutemov.name, hughd@google.com,
        linux-kernel@vger.kernel.org, daniel.m.jordan@oracle.com,
        linux-mm@kvack.org, shakeelb@google.com, willy@infradead.org,
        hannes@cmpxchg.org, tj@kernel.org, cgroups@vger.kernel.org,
        akpm@linux-foundation.org, richard.weiyang@gmail.com,
        mgorman@techsingularity.net, iamjoonsoo.kim@lge.com
References: <20200819041852.23414.95939.stgit@localhost.localdomain>
 <20200819042730.23414.41309.stgit@localhost.localdomain>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <15edf807-ce03-83f7-407d-5929341b2b4e@linux.alibaba.com>
Date:   Wed, 19 Aug 2020 15:53:15 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200819042730.23414.41309.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/8/19 下午12:27, Alexander Duyck 写道:
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> The release_pages function has a number of paths that end up with the
> LRU lock having to be released and reacquired. Such an example would be the
> freeing of THP pages as it requires releasing the LRU lock so that it can
> be potentially reacquired by __put_compound_page.
> 
> In order to avoid that we can split the work into 3 passes, the first
> without the LRU lock to go through and sort out those pages that are not in
> the LRU so they can be freed immediately from those that can't. The second
> pass will then go through removing those pages from the LRU in batches as
> large as a pagevec can hold before freeing the LRU lock. Once the pages have
> been removed from the LRU we can then proceed to free the remaining pages
> without needing to worry about if they are in the LRU any further.
> 
> The general idea is to avoid bouncing the LRU lock between pages and to
> hopefully aggregate the lock for up to the full page vector worth of pages.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  mm/swap.c |  109 +++++++++++++++++++++++++++++++++++++------------------------
>  1 file changed, 67 insertions(+), 42 deletions(-)
> 
> diff --git a/mm/swap.c b/mm/swap.c
> index fe53449fa1b8..b405f81b2c60 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -795,6 +795,54 @@ void lru_add_drain_all(void)
>  }
>  #endif
>  
> +static void __release_page(struct page *page, struct list_head *pages_to_free)
> +{
> +	if (PageCompound(page)) {
> +		__put_compound_page(page);
> +	} else {
> +		/* Clear Active bit in case of parallel mark_page_accessed */
> +		__ClearPageActive(page);
> +		__ClearPageWaiters(page);
> +
> +		list_add(&page->lru, pages_to_free);
> +	}
> +}
> +
> +static void __release_lru_pages(struct pagevec *pvec,
> +				struct list_head *pages_to_free)
> +{
> +	struct lruvec *lruvec = NULL;
> +	unsigned long flags = 0;
> +	int i;
> +
> +	/*
> +	 * The pagevec at this point should contain a set of pages with
> +	 * their reference count at 0 and the LRU flag set. We will now
> +	 * need to pull the pages from their LRU lists.
> +	 *
> +	 * We walk the list backwards here since that way we are starting at
> +	 * the pages that should be warmest in the cache.
> +	 */
> +	for (i = pagevec_count(pvec); i--;) {
> +		struct page *page = pvec->pages[i];
> +
> +		lruvec = relock_page_lruvec_irqsave(page, lruvec, &flags);

the lock bounce is better with the patch, would you like to do further
like using add_lruvecs to reduce bounce more?

Thanks
Alex

> +		VM_BUG_ON_PAGE(!PageLRU(page), page);
> +		__ClearPageLRU(page);
> +		del_page_from_lru_list(page, lruvec, page_off_lru(page));
> +	}
> +
> +	unlock_page_lruvec_irqrestore(lruvec, flags);
> +
> +	/*
> +	 * A batch of pages are no longer on the LRU list. Go through and
> +	 * start the final process of returning the deferred pages to their
> +	 * appropriate freelists.
> +	 */
> +	for (i = pagevec_count(pvec); i--;)
> +		__release_page(pvec->pages[i], pages_to_free);
> +}
> +
>  /**
>   * release_pages - batched put_page()
>   * @pages: array of pages to release
> @@ -806,32 +854,24 @@ void lru_add_drain_all(void)
>  void release_pages(struct page **pages, int nr)
>  {
>  	int i;
> +	struct pagevec pvec;
>  	LIST_HEAD(pages_to_free);
> -	struct lruvec *lruvec = NULL;
> -	unsigned long flags;
> -	unsigned int lock_batch;
>  
> +	pagevec_init(&pvec);
> +
> +	/*
> +	 * We need to first walk through the list cleaning up the low hanging
> +	 * fruit and clearing those pages that either cannot be freed or that
> +	 * are non-LRU. We will store the LRU pages in a pagevec so that we
> +	 * can get to them in the next pass.
> +	 */
>  	for (i = 0; i < nr; i++) {
>  		struct page *page = pages[i];
>  
> -		/*
> -		 * Make sure the IRQ-safe lock-holding time does not get
> -		 * excessive with a continuous string of pages from the
> -		 * same lruvec. The lock is held only if lruvec != NULL.
> -		 */
> -		if (lruvec && ++lock_batch == SWAP_CLUSTER_MAX) {
> -			unlock_page_lruvec_irqrestore(lruvec, flags);
> -			lruvec = NULL;
> -		}
> -
>  		if (is_huge_zero_page(page))
>  			continue;
>  
>  		if (is_zone_device_page(page)) {
> -			if (lruvec) {
> -				unlock_page_lruvec_irqrestore(lruvec, flags);
> -				lruvec = NULL;
> -			}
>  			/*
>  			 * ZONE_DEVICE pages that return 'false' from
>  			 * put_devmap_managed_page() do not require special
> @@ -848,36 +888,21 @@ void release_pages(struct page **pages, int nr)
>  		if (!put_page_testzero(page))
>  			continue;
>  
> -		if (PageCompound(page)) {
> -			if (lruvec) {
> -				unlock_page_lruvec_irqrestore(lruvec, flags);
> -				lruvec = NULL;
> -			}
> -			__put_compound_page(page);
> +		if (!PageLRU(page)) {
> +			__release_page(page, &pages_to_free);
>  			continue;
>  		}
>  
> -		if (PageLRU(page)) {
> -			struct lruvec *prev_lruvec = lruvec;
> -
> -			lruvec = relock_page_lruvec_irqsave(page, lruvec,
> -									&flags);
> -			if (prev_lruvec != lruvec)
> -				lock_batch = 0;
> -
> -			VM_BUG_ON_PAGE(!PageLRU(page), page);
> -			__ClearPageLRU(page);
> -			del_page_from_lru_list(page, lruvec, page_off_lru(page));
> +		/* record page so we can get it in the next pass */
> +		if (!pagevec_add(&pvec, page)) {
> +			__release_lru_pages(&pvec, &pages_to_free);
> +			pagevec_reinit(&pvec);
>  		}
> -
> -		/* Clear Active bit in case of parallel mark_page_accessed */
> -		__ClearPageActive(page);
> -		__ClearPageWaiters(page);
> -
> -		list_add(&page->lru, &pages_to_free);
>  	}
> -	if (lruvec)
> -		unlock_page_lruvec_irqrestore(lruvec, flags);
> +
> +	/* flush any remaining LRU pages that need to be processed */
> +	if (pagevec_count(&pvec))
> +		__release_lru_pages(&pvec, &pages_to_free);
>  
>  	mem_cgroup_uncharge_list(&pages_to_free);
>  	free_unref_page_list(&pages_to_free);
> 

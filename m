Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF6E2497D8
	for <lists+cgroups@lfdr.de>; Wed, 19 Aug 2020 09:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgHSH6Q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Aug 2020 03:58:16 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:53076 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726570AbgHSH6L (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Aug 2020 03:58:11 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0U6D5.Xk_1597823875;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U6D5.Xk_1597823875)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 19 Aug 2020 15:57:57 +0800
Subject: Re: [RFC PATCH v2 5/5] mm: Split move_pages_to_lru into 3 separate
 passes
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     yang.shi@linux.alibaba.com, lkp@intel.com, rong.a.chen@intel.com,
        khlebnikov@yandex-team.ru, kirill@shutemov.name, hughd@google.com,
        linux-kernel@vger.kernel.org, daniel.m.jordan@oracle.com,
        linux-mm@kvack.org, shakeelb@google.com, willy@infradead.org,
        hannes@cmpxchg.org, tj@kernel.org, cgroups@vger.kernel.org,
        akpm@linux-foundation.org, richard.weiyang@gmail.com,
        mgorman@techsingularity.net, iamjoonsoo.kim@lge.com
References: <20200819041852.23414.95939.stgit@localhost.localdomain>
 <20200819042738.23414.60815.stgit@localhost.localdomain>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <084c58a7-7aac-820c-9606-19391c35b9b5@linux.alibaba.com>
Date:   Wed, 19 Aug 2020 15:56:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200819042738.23414.60815.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/8/19 下午12:27, Alexander Duyck 写道:
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> The current code for move_pages_to_lru is meant to release the LRU lock
> every time it encounters an unevictable page or a compound page that must
> be freed. This results in a fair amount of code bulk because the lruvec has
> to be reacquired every time the lock is released and reacquired.
> 
> Instead of doing this I believe we can break the code up into 3 passes. The
> first pass will identify the pages we can move to LRU and move those. In
> addition it will sort the list out leaving the unevictable pages in the
> list and moving those pages that have dropped to a reference count of 0 to
> pages_to_free. The second pass will return the unevictable pages to the
> LRU. The final pass will free any compound pages we have in the
> pages_to_free list before we merge it back with the original list and
> return from the function.
> 
> The advantage of doing it this way is that we only have to release the lock
> between pass 1 and 2, and then we reacquire the lock after pass 3 after we
> merge the pages_to_free back into the original list. As such we only have
> to release the lock at most once in an entire call instead of having to
> test to see if we need to relock with each page.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  mm/vmscan.c |   68 ++++++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 39 insertions(+), 29 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 3ebe3f9b653b..6a2bdbc1a9eb 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1850,22 +1850,21 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>  {
>  	int nr_pages, nr_moved = 0;
>  	LIST_HEAD(pages_to_free);
> -	struct page *page;
> -	struct lruvec *orig_lruvec = lruvec;
> +	struct page *page, *next;
>  	enum lru_list lru;
>  
> -	while (!list_empty(list)) {
> -		page = lru_to_page(list);
> +	list_for_each_entry_safe(page, next, list, lru) {
>  		VM_BUG_ON_PAGE(PageLRU(page), page);
> -		list_del(&page->lru);
> -		if (unlikely(!page_evictable(page))) {
> -			if (lruvec) {
> -				spin_unlock_irq(&lruvec->lru_lock);
> -				lruvec = NULL;
> -			}
> -			putback_lru_page(page);
> +
> +		/*
> +		 * if page is unevictable leave it on the list to be returned
> +		 * to the LRU after we have finished processing the other
> +		 * entries in the list.
> +		 */
> +		if (unlikely(!page_evictable(page)))
>  			continue;
> -		}
> +
> +		list_del(&page->lru);
>  
>  		/*
>  		 * The SetPageLRU needs to be kept here for list intergrity.
> @@ -1878,20 +1877,14 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>  		 *     list_add(&page->lru,)
>  		 *                                        list_add(&page->lru,)
>  		 */
> -		lruvec = relock_page_lruvec_irq(page, lruvec);

It's actually changed the meaning from current func. which I had seen a bug if no relock.
but after move to 5.9 kernel, I can not reprodce the bug any more. I am not sure if 5.9 fixed 
the problem, and we don't need relock here. 

For the rest of this patch. 
Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>


>  		SetPageLRU(page);
>  
>  		if (unlikely(put_page_testzero(page))) {
>  			__ClearPageLRU(page);
>  			__ClearPageActive(page);
>  
> -			if (unlikely(PageCompound(page))) {
> -				spin_unlock_irq(&lruvec->lru_lock);
> -				lruvec = NULL;
> -				destroy_compound_page(page);
> -			} else
> -				list_add(&page->lru, &pages_to_free);
> -
> +			/* defer freeing until we can release lru_lock */
> +			list_add(&page->lru, &pages_to_free);
>  			continue;
>  		}
>  
> @@ -1904,16 +1897,33 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>  		if (PageActive(page))
>  			workingset_age_nonresident(lruvec, nr_pages);
>  	}
> -	if (orig_lruvec != lruvec) {
> -		if (lruvec)
> -			spin_unlock_irq(&lruvec->lru_lock);
> -		spin_lock_irq(&orig_lruvec->lru_lock);
> -	}
>  
> -	/*
> -	 * To save our caller's stack, now use input list for pages to free.
> -	 */
> -	list_splice(&pages_to_free, list);
> +	if (unlikely(!list_empty(list) || !list_empty(&pages_to_free))) {
> +		spin_unlock_irq(&lruvec->lru_lock);
> +
> +		/* return any unevictable pages to the LRU list */
> +		while (!list_empty(list)) {
> +			page = lru_to_page(list);
> +			list_del(&page->lru);
> +			putback_lru_page(page);
> +		}
> +
> +		/*
> +		 * To save our caller's stack use input
> +		 * list for pages to free.
> +		 */
> +		list_splice(&pages_to_free, list);
> +
> +		/* free any compound pages we have in the list */
> +		list_for_each_entry_safe(page, next, list, lru) {
> +			if (likely(!PageCompound(page)))
> +				continue;
> +			list_del(&page->lru);
> +			destroy_compound_page(page);
> +		}
> +
> +		spin_lock_irq(&lruvec->lru_lock);
> +	}
>  
>  	return nr_moved;
>  }
> 

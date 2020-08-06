Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE2523D5DC
	for <lists+cgroups@lfdr.de>; Thu,  6 Aug 2020 05:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgHFDsT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Aug 2020 23:48:19 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:33989 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726026AbgHFDsT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Aug 2020 23:48:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0U4tH-Rl_1596685693;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U4tH-Rl_1596685693)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 06 Aug 2020 11:48:14 +0800
Subject: Re: [PATCH v17 01/21] mm/vmscan: remove unnecessary lruvec adding
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
 <1595681998-19193-2-git-send-email-alex.shi@linux.alibaba.com>
Message-ID: <d4eb6520-e1ee-9202-49d0-a9216a96a488@linux.alibaba.com>
Date:   Thu, 6 Aug 2020 11:47:53 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1595681998-19193-2-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/7/25 ÏÂÎç8:59, Alex Shi Ð´µÀ:
> We don't have to add a freeable page into lru and then remove from it.
> This change saves a couple of actions and makes the moving more clear.
> 
> The SetPageLRU needs to be kept here for list intergrity.
> Otherwise:
>  #0 mave_pages_to_lru              #1 release_pages
>                                    if (put_page_testzero())
>  if !put_page_testzero
>                                      !PageLRU //skip lru_lock
>                                        list_add(&page->lru,)
>    list_add(&page->lru,) //corrupt

The race comments should be corrected to this:
                /*
                 * The SetPageLRU needs to be kept here for list intergrity.
                 * Otherwise:
                 *   #0 mave_pages_to_lru             #1 release_pages
                 *   if !put_page_testzero
                 *                                    if (put_page_testzero())
                 *                                      !PageLRU //skip lru_lock
                 *     SetPageLRU()
                 *     list_add(&page->lru,)
                 *                                        list_add(&page->lru,)
                 */

> 
> [akpm@linux-foundation.org: coding style fixes]
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  mm/vmscan.c | 37 ++++++++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 749d239c62b2..ddb29d813d77 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1856,26 +1856,29 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>  	while (!list_empty(list)) {
>  		page = lru_to_page(list);
>  		VM_BUG_ON_PAGE(PageLRU(page), page);
> +		list_del(&page->lru);
>  		if (unlikely(!page_evictable(page))) {
> -			list_del(&page->lru);
>  			spin_unlock_irq(&pgdat->lru_lock);
>  			putback_lru_page(page);
>  			spin_lock_irq(&pgdat->lru_lock);
>  			continue;
>  		}
> -		lruvec = mem_cgroup_page_lruvec(page, pgdat);
>  
> +		/*
> +		 * The SetPageLRU needs to be kept here for list intergrity.
> +		 * Otherwise:
> +		 *   #0 mave_pages_to_lru             #1 release_pages
> +		 *				      if (put_page_testzero())
> +		 *   if !put_page_testzero
> +		 *				        !PageLRU //skip lru_lock
> +		 *                                        list_add(&page->lru,)
> +		 *     list_add(&page->lru,) //corrupt
> +		 */

                /*
                 * The SetPageLRU needs to be kept here for list intergrity.
                 * Otherwise:
                 *   #0 mave_pages_to_lru             #1 release_pages
                 *   if !put_page_testzero
                 *                                    if (put_page_testzero())
                 *                                      !PageLRU //skip lru_lock
                 *     SetPageLRU()
                 *     list_add(&page->lru,)
                 *                                        list_add(&page->lru,)
                 */

>  		SetPageLRU(page);
> -		lru = page_lru(page);
>  
> -		nr_pages = hpage_nr_pages(page);
> -		update_lru_size(lruvec, lru, page_zonenum(page), nr_pages);
> -		list_move(&page->lru, &lruvec->lists[lru]);
> -
> -		if (put_page_testzero(page)) {
> +		if (unlikely(put_page_testzero(page))) {
>  			__ClearPageLRU(page);
>  			__ClearPageActive(page);
> -			del_page_from_lru_list(page, lruvec, lru);
>  
>  			if (unlikely(PageCompound(page))) {
>  				spin_unlock_irq(&pgdat->lru_lock);
> @@ -1883,11 +1886,19 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>  				spin_lock_irq(&pgdat->lru_lock);
>  			} else
>  				list_add(&page->lru, &pages_to_free);
> -		} else {
> -			nr_moved += nr_pages;
> -			if (PageActive(page))
> -				workingset_age_nonresident(lruvec, nr_pages);
> +
> +			continue;
>  		}
> +
> +		lruvec = mem_cgroup_page_lruvec(page, pgdat);
> +		lru = page_lru(page);
> +		nr_pages = hpage_nr_pages(page);
> +
> +		update_lru_size(lruvec, lru, page_zonenum(page), nr_pages);
> +		list_add(&page->lru, &lruvec->lists[lru]);
> +		nr_moved += nr_pages;
> +		if (PageActive(page))
> +			workingset_age_nonresident(lruvec, nr_pages);
>  	}
>  
>  	/*
> 

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4485D279735
	for <lists+cgroups@lfdr.de>; Sat, 26 Sep 2020 08:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgIZGR1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 26 Sep 2020 02:17:27 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:42618 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725208AbgIZGR1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 26 Sep 2020 02:17:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0UA6-WTG_1601101037;
Received: from IT-FVFX43SYHV2H.lan(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UA6-WTG_1601101037)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 26 Sep 2020 14:17:19 +0800
Subject: Re: [PATCH v19 07/20] mm/vmscan: remove unnecessary lruvec adding
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com, kirill@shutemov.name,
        alexander.duyck@gmail.com, rong.a.chen@intel.com, mhocko@suse.com,
        vdavydov.dev@gmail.com, shy828301@gmail.com, aaron.lwe@gmail.com
References: <1600918115-22007-1-git-send-email-alex.shi@linux.alibaba.com>
 <1600918115-22007-8-git-send-email-alex.shi@linux.alibaba.com>
Message-ID: <30c65309-df19-b83b-5879-cce860ce55ef@linux.alibaba.com>
Date:   Sat, 26 Sep 2020 14:14:56 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1600918115-22007-8-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patch has some conflict on akpm. But since Yu Zhao ask for
revert his patch 'mm: use add_page_to_lru_list()/page_lru()/page_off_lru()'
we should not needs for rebase on it.

Thanks
Alex

ÔÚ 2020/9/24 ÉÏÎç11:28, Alex Shi Ð´µÀ:
> We don't have to add a freeable page into lru and then remove from it.
> This change saves a couple of actions and makes the moving more clear.
> 
> The SetPageLRU needs to be kept before put_page_testzero for list
> integrity, otherwise:
> 
>   #0 move_pages_to_lru             #1 release_pages
>   if !put_page_testzero
>      			           if (put_page_testzero())
>      			              !PageLRU //skip lru_lock
>      SetPageLRU()
>      list_add(&page->lru,)
>                                          list_add(&page->lru,)
> 
> [akpm@linux-foundation.org: coding style fixes]
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Acked-by: Hugh Dickins <hughd@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  mm/vmscan.c | 38 +++++++++++++++++++++++++-------------
>  1 file changed, 25 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 466fc3144fff..32102e5d354d 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1850,26 +1850,30 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
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
> +		 * The SetPageLRU needs to be kept here for list integrity.
> +		 * Otherwise:
> +		 *   #0 move_pages_to_lru             #1 release_pages
> +		 *   if !put_page_testzero
> +		 *				      if (put_page_testzero())
> +		 *				        !PageLRU //skip lru_lock
> +		 *     SetPageLRU()
> +		 *     list_add(&page->lru,)
> +		 *                                        list_add(&page->lru,)
> +		 */
>  		SetPageLRU(page);
> -		lru = page_lru(page);
>  
> -		nr_pages = thp_nr_pages(page);
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
> @@ -1877,11 +1881,19 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
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
> +		nr_pages = thp_nr_pages(page);
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

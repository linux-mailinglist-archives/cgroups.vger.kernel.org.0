Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02702AF247
	for <lists+cgroups@lfdr.de>; Wed, 11 Nov 2020 14:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgKKNgd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 Nov 2020 08:36:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:51348 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbgKKNgU (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 11 Nov 2020 08:36:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3461AAD77;
        Wed, 11 Nov 2020 13:36:19 +0000 (UTC)
To:     Alex Shi <alex.shi@linux.alibaba.com>, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com
Cc:     Michal Hocko <mhocko@kernel.org>
References: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com>
 <1604566549-62481-15-git-send-email-alex.shi@linux.alibaba.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v21 14/19] mm/lru: introduce TestClearPageLRU
Message-ID: <b4c08619-d365-bbaf-de08-9b2495a0a8d8@suse.cz>
Date:   Wed, 11 Nov 2020 14:36:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1604566549-62481-15-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/5/20 9:55 AM, Alex Shi wrote:
> Currently lru_lock still guards both lru list and page's lru bit, that's
> ok. but if we want to use specific lruvec lock on the page, we need to
> pin down the page's lruvec/memcg during locking. Just taking lruvec
> lock first may be undermined by the page's memcg charge/migration. To
> fix this problem, we will clear the lru bit out of locking and use
> it as pin down action to block the page isolation in memcg changing.
> 
> So now a standard steps of page isolation is following:
> 	1, get_page(); 	       #pin the page avoid to be free
> 	2, TestClearPageLRU(); #block other isolation like memcg change
> 	3, spin_lock on lru_lock; #serialize lru list access
> 	4, delete page from lru list;
> 
> This patch start with the first part: TestClearPageLRU, which combines
> PageLRU check and ClearPageLRU into a macro func TestClearPageLRU. This
> function will be used as page isolation precondition to prevent other
> isolations some where else. Then there are may !PageLRU page on lru
 > list, need to remove BUG() checking accordingly.

As there now may be !PageLRU pages on lru list, we need to ...

> 
> There 2 rules for lru bit now:
> 1, the lru bit still indicate if a page on lru list, just in some
>     temporary moment(isolating), the page may have no lru bit when
>     it's on lru list.  but the page still must be on lru list when the
>     lru bit set.
> 2, have to remove lru bit before delete it from lru list.

2. we have to remove the lru bit before deleting page from lru list

> 
> As Andrew Morton mentioned this change would dirty cacheline for page
> isn't on LRU. But the lost would be acceptable in Rong Chen
> <rong.a.chen@intel.com> report:
> https://lore.kernel.org/lkml/20200304090301.GB5972@shao2-debian/

AFAIK these places generally expect PageLRU to be true, and if it's false, it's 
because of a race, so that effect should be negligible?

> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Acked-by: Hugh Dickins <hughd@google.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---

...

> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1542,7 +1542,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>    */
>   int __isolate_lru_page(struct page *page, isolate_mode_t mode)
>   {
> -	int ret = -EINVAL;
> +	int ret = -EBUSY;
>   
>   	/* Only take pages on the LRU. */
>   	if (!PageLRU(page))
> @@ -1552,8 +1552,6 @@ int __isolate_lru_page(struct page *page, isolate_mode_t mode)
>   	if (PageUnevictable(page) && !(mode & ISOLATE_UNEVICTABLE))
>   		return ret;
>   
> -	ret = -EBUSY;

I'm not sure why this change is here, looks unrelated to the patch?

Oh I see, you want to prevent the BUG() in isolate_lru_pages().

But due to that, the PageUnevictable check was also affected unintentionally. 
But I don't think it's that important to BUG() when we run into PageUnevictable 
unexpectedly, so that's probably ok.

But with that, we can just make __isolate_lru_page() a bool function and remove 
the ugly switch in  isolate_lru_pages()?

> -
>   	/*
>   	 * To minimise LRU disruption, the caller can indicate that it only
>   	 * wants to isolate pages it will be able to operate on without
> @@ -1600,8 +1598,10 @@ int __isolate_lru_page(struct page *page, isolate_mode_t mode)
>   		 * sure the page is not being freed elsewhere -- the
>   		 * page release code relies on it.
>   		 */
> -		ClearPageLRU(page);
> -		ret = 0;
> +		if (TestClearPageLRU(page))
> +			ret = 0;
> +		else
> +			put_page(page);
>   	}
>   
>   	return ret;
> @@ -1667,8 +1667,6 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
>   		page = lru_to_page(src);
>   		prefetchw_prev_lru_page(page, src, flags);
>   
> -		VM_BUG_ON_PAGE(!PageLRU(page), page);
> -
>   		nr_pages = compound_nr(page);
>   		total_scan += nr_pages;
>   
> @@ -1765,21 +1763,18 @@ int isolate_lru_page(struct page *page)
>   	VM_BUG_ON_PAGE(!page_count(page), page);
>   	WARN_RATELIMIT(PageTail(page), "trying to isolate tail page");
>   
> -	if (PageLRU(page)) {
> +	if (TestClearPageLRU(page)) {
>   		pg_data_t *pgdat = page_pgdat(page);
>   		struct lruvec *lruvec;
>   
> -		spin_lock_irq(&pgdat->lru_lock);
> +		get_page(page);
>   		lruvec = mem_cgroup_page_lruvec(page, pgdat);
> -		if (PageLRU(page)) {
> -			int lru = page_lru(page);
> -			get_page(page);
> -			ClearPageLRU(page);
> -			del_page_from_lru_list(page, lruvec, lru);
> -			ret = 0;
> -		}
> +		spin_lock_irq(&pgdat->lru_lock);
> +		del_page_from_lru_list(page, lruvec, page_lru(page));
>   		spin_unlock_irq(&pgdat->lru_lock);
> +		ret = 0;
>   	}
> +
>   	return ret;
>   }
>   
> @@ -4293,6 +4288,10 @@ void check_move_unevictable_pages(struct pagevec *pvec)
>   		nr_pages = thp_nr_pages(page);
>   		pgscanned += nr_pages;
>   
> +		/* block memcg migration during page moving between lru */
> +		if (!TestClearPageLRU(page))
> +			continue;
> +
>   		if (pagepgdat != pgdat) {
>   			if (pgdat)
>   				spin_unlock_irq(&pgdat->lru_lock);
> @@ -4301,10 +4300,7 @@ void check_move_unevictable_pages(struct pagevec *pvec)
>   		}
>   		lruvec = mem_cgroup_page_lruvec(page, pgdat);
>   
> -		if (!PageLRU(page) || !PageUnevictable(page))
> -			continue;
> -
> -		if (page_evictable(page)) {
> +		if (page_evictable(page) && PageUnevictable(page)) {

Doing PageUnevictable() test first should be cheaper?

>   			enum lru_list lru = page_lru_base_type(page);
>   
>   			VM_BUG_ON_PAGE(PageActive(page), page);
> @@ -4313,12 +4309,15 @@ void check_move_unevictable_pages(struct pagevec *pvec)
>   			add_page_to_lru_list(page, lruvec, lru);
>   			pgrescued += nr_pages;
>   		}
> +		SetPageLRU(page);
>   	}
>   
>   	if (pgdat) {
>   		__count_vm_events(UNEVICTABLE_PGRESCUED, pgrescued);
>   		__count_vm_events(UNEVICTABLE_PGSCANNED, pgscanned);
>   		spin_unlock_irq(&pgdat->lru_lock);
> +	} else if (pgscanned) {
> +		count_vm_events(UNEVICTABLE_PGSCANNED, pgscanned);
>   	}
>   }
>   EXPORT_SYMBOL_GPL(check_move_unevictable_pages);
> 


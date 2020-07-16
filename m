Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9C16221F3D
	for <lists+cgroups@lfdr.de>; Thu, 16 Jul 2020 11:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgGPJAq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Jul 2020 05:00:46 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:46690 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725897AbgGPJAp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 Jul 2020 05:00:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0U2tKSNC_1594890039;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U2tKSNC_1594890039)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 Jul 2020 17:00:40 +0800
Subject: Re: [PATCH v16 05/22] mm/thp: move lru_add_page_tail func to
 huge_memory.c
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
 <1594429136-20002-6-git-send-email-alex.shi@linux.alibaba.com>
Message-ID: <924c187c-d4cb-4458-9a71-63f79e0a66c8@linux.alibaba.com>
Date:   Thu, 16 Jul 2020 16:59:48 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1594429136-20002-6-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Kirill & Matthew,

Is there any concern from for the THP involved patches?

Thanks
Alex


ÔÚ 2020/7/11 ÉÏÎç8:58, Alex Shi Ð´µÀ:
> The func is only used in huge_memory.c, defining it in other file with a
> CONFIG_TRANSPARENT_HUGEPAGE macro restrict just looks weird.
> 
> Let's move it THP. And make it static as Hugh Dickin suggested.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
>  include/linux/swap.h |  2 --
>  mm/huge_memory.c     | 30 ++++++++++++++++++++++++++++++
>  mm/swap.c            | 33 ---------------------------------
>  3 files changed, 30 insertions(+), 35 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 5b3216ba39a9..2c29399b29a0 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -339,8 +339,6 @@ extern void lru_note_cost(struct lruvec *lruvec, bool file,
>  			  unsigned int nr_pages);
>  extern void lru_note_cost_page(struct page *);
>  extern void lru_cache_add(struct page *);
> -extern void lru_add_page_tail(struct page *page, struct page *page_tail,
> -			 struct lruvec *lruvec, struct list_head *head);
>  extern void activate_page(struct page *);
>  extern void mark_page_accessed(struct page *);
>  extern void lru_add_drain(void);
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 78c84bee7e29..9e050b13f597 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2340,6 +2340,36 @@ static void remap_page(struct page *page)
>  	}
>  }
>  
> +static void lru_add_page_tail(struct page *page, struct page *page_tail,
> +				struct lruvec *lruvec, struct list_head *list)
> +{
> +	VM_BUG_ON_PAGE(!PageHead(page), page);
> +	VM_BUG_ON_PAGE(PageCompound(page_tail), page);
> +	VM_BUG_ON_PAGE(PageLRU(page_tail), page);
> +	lockdep_assert_held(&lruvec_pgdat(lruvec)->lru_lock);
> +
> +	if (!list)
> +		SetPageLRU(page_tail);
> +
> +	if (likely(PageLRU(page)))
> +		list_add_tail(&page_tail->lru, &page->lru);
> +	else if (list) {
> +		/* page reclaim is reclaiming a huge page */
> +		get_page(page_tail);
> +		list_add_tail(&page_tail->lru, list);
> +	} else {
> +		/*
> +		 * Head page has not yet been counted, as an hpage,
> +		 * so we must account for each subpage individually.
> +		 *
> +		 * Put page_tail on the list at the correct position
> +		 * so they all end up in order.
> +		 */
> +		add_page_to_lru_list_tail(page_tail, lruvec,
> +					  page_lru(page_tail));
> +	}
> +}
> +
>  static void __split_huge_page_tail(struct page *head, int tail,
>  		struct lruvec *lruvec, struct list_head *list)
>  {
> diff --git a/mm/swap.c b/mm/swap.c
> index a82efc33411f..7701d855873d 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -933,39 +933,6 @@ void __pagevec_release(struct pagevec *pvec)
>  }
>  EXPORT_SYMBOL(__pagevec_release);
>  
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -/* used by __split_huge_page_refcount() */
> -void lru_add_page_tail(struct page *page, struct page *page_tail,
> -		       struct lruvec *lruvec, struct list_head *list)
> -{
> -	VM_BUG_ON_PAGE(!PageHead(page), page);
> -	VM_BUG_ON_PAGE(PageCompound(page_tail), page);
> -	VM_BUG_ON_PAGE(PageLRU(page_tail), page);
> -	lockdep_assert_held(&lruvec_pgdat(lruvec)->lru_lock);
> -
> -	if (!list)
> -		SetPageLRU(page_tail);
> -
> -	if (likely(PageLRU(page)))
> -		list_add_tail(&page_tail->lru, &page->lru);
> -	else if (list) {
> -		/* page reclaim is reclaiming a huge page */
> -		get_page(page_tail);
> -		list_add_tail(&page_tail->lru, list);
> -	} else {
> -		/*
> -		 * Head page has not yet been counted, as an hpage,
> -		 * so we must account for each subpage individually.
> -		 *
> -		 * Put page_tail on the list at the correct position
> -		 * so they all end up in order.
> -		 */
> -		add_page_to_lru_list_tail(page_tail, lruvec,
> -					  page_lru(page_tail));
> -	}
> -}
> -#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> -
>  static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
>  				 void *arg)
>  {
> 

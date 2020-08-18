Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64AC6247EB4
	for <lists+cgroups@lfdr.de>; Tue, 18 Aug 2020 08:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgHRGvc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 18 Aug 2020 02:51:32 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:59555 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726228AbgHRGvb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 18 Aug 2020 02:51:31 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0U67H.h6_1597733485;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U67H.h6_1597733485)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 18 Aug 2020 14:51:26 +0800
Subject: Re: [RFC PATCH 2/3] mm: Drop use of test_and_set_skip in favor of
 just setting skip
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     yang.shi@linux.alibaba.com, lkp@intel.com, rong.a.chen@intel.com,
        khlebnikov@yandex-team.ru, kirill@shutemov.name, hughd@google.com,
        linux-kernel@vger.kernel.org, daniel.m.jordan@oracle.com,
        linux-mm@kvack.org, shakeelb@google.com, willy@infradead.org,
        hannes@cmpxchg.org, tj@kernel.org, cgroups@vger.kernel.org,
        akpm@linux-foundation.org, richard.weiyang@gmail.com,
        mgorman@techsingularity.net, iamjoonsoo.kim@lge.com
References: <20200813035100.13054.25671.stgit@localhost.localdomain>
 <20200813040232.13054.82417.stgit@localhost.localdomain>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <176fae1b-b95b-51c3-d8cc-4380f0972666@linux.alibaba.com>
Date:   Tue, 18 Aug 2020 14:50:25 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200813040232.13054.82417.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/8/13 下午12:02, Alexander Duyck 写道:
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> The only user of test_and_set_skip was isolate_migratepages_block and it
> was using it after a call that was testing and clearing the LRU flag. As
> such it really didn't need to be behind the LRU lock anymore as it wasn't
> really fulfilling its purpose.
> 
> With that being the case we can simply drop the bit and instead directly
> just call the set_pageblock_skip function if the page we are working on is
> the valid_page at the start of the pageblock. It shouldn't be possible for
> us to encounter the bit being set since we obtained the LRU flag for the
> first page in the pageblock which means we would have exclusive access to
> setting the skip bit. As such we don't need to worry about the abort case
> since no other thread will be able to call what used to be
> test_and_set_skip.
> 
> Since we have dropped the late abort case we can drop the code that was
> clearing the LRU flag and calling page_put since the abort case will now
> not be holding a reference to a page.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

After my false sharing remove on pageblock_flags, this patch looks fine with
a minor change

> ---
>  mm/compaction.c |   50 +++++++-------------------------------------------
>  1 file changed, 7 insertions(+), 43 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 5021a18ef722..c1e9918f9dd4 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -399,29 +399,6 @@ void reset_isolation_suitable(pg_data_t *pgdat)
>  	}
>  }
>  
> -/*
> - * Sets the pageblock skip bit if it was clear. Note that this is a hint as
> - * locks are not required for read/writers. Returns true if it was already set.
> - */
> -static bool test_and_set_skip(struct compact_control *cc, struct page *page,
> -							unsigned long pfn)
> -{
> -	bool skip;
> -
> -	/* Do no update if skip hint is being ignored */
> -	if (cc->ignore_skip_hint)
> -		return false;
> -
> -	if (!IS_ALIGNED(pfn, pageblock_nr_pages))
> -		return false;
> -
> -	skip = get_pageblock_skip(page);
> -	if (!skip && !cc->no_set_skip_hint)
> -		skip = !set_pageblock_skip(page);
> -
> -	return skip;
> -}
> -
>  static void update_cached_migrate(struct compact_control *cc, unsigned long pfn)
>  {
>  	struct zone *zone = cc->zone;
> @@ -480,12 +457,6 @@ static inline void update_pageblock_skip(struct compact_control *cc,
>  static void update_cached_migrate(struct compact_control *cc, unsigned long pfn)
>  {
>  }
> -
> -static bool test_and_set_skip(struct compact_control *cc, struct page *page,
> -							unsigned long pfn)
> -{
> -	return false;
> -}
>  #endif /* CONFIG_COMPACTION */
>  
>  /*
> @@ -895,7 +866,6 @@ static bool too_many_isolated(pg_data_t *pgdat)
>  		if (!valid_page && IS_ALIGNED(low_pfn, pageblock_nr_pages)) {
>  			if (!cc->ignore_skip_hint && get_pageblock_skip(page)) {
>  				low_pfn = end_pfn;
> -				page = NULL;
>  				goto isolate_abort;
>  			}
>  			valid_page = page;
> @@ -991,6 +961,13 @@ static bool too_many_isolated(pg_data_t *pgdat)
>  		if (!TestClearPageLRU(page))
>  			goto isolate_fail_put;
>  
> +		/* Indicate that we want exclusive access to this pageblock */
> +		if (page == valid_page) {
> +			skip_updated = true;
> +			if (!cc->ignore_skip_hint)

                        if (!cc->ignore_skip_hint && !cc->no_set_skip_hint)
no_set_skip_hint needs to add here.

Thanks
Alex

> +				set_pageblock_skip(page);
> +		}
> +
>  		/* If we already hold the lock, we can skip some rechecking */
>  		if (!lruvec || !lruvec_holds_page_lru_lock(page, lruvec)) {
>  			if (lruvec)
> @@ -1002,13 +979,6 @@ static bool too_many_isolated(pg_data_t *pgdat)
>  
>  			lruvec_memcg_debug(lruvec, page);
>  
> -			/* Try get exclusive access under lock */
> -			if (!skip_updated) {
> -				skip_updated = true;
> -				if (test_and_set_skip(cc, page, low_pfn))
> -					goto isolate_abort;
> -			}
> -
>  			/*
>  			 * Page become compound since the non-locked check,
>  			 * and it's on LRU. It can only be a THP so the order
> @@ -1094,15 +1064,9 @@ static bool too_many_isolated(pg_data_t *pgdat)
>  	if (unlikely(low_pfn > end_pfn))
>  		low_pfn = end_pfn;
>  
> -	page = NULL;
> -
>  isolate_abort:
>  	if (lruvec)
>  		unlock_page_lruvec_irqrestore(lruvec, flags);
> -	if (page) {
> -		SetPageLRU(page);
> -		put_page(page);
> -	}
>  
>  	/*
>  	 * Updated the cached scanner pfn once the pageblock has been scanned
> 

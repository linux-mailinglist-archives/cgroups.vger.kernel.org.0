Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC632736CC
	for <lists+cgroups@lfdr.de>; Tue, 22 Sep 2020 01:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgIUXtn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Sep 2020 19:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbgIUXtn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Sep 2020 19:49:43 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2049CC0613CF
        for <cgroups@vger.kernel.org>; Mon, 21 Sep 2020 16:49:43 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id u126so18973347oif.13
        for <cgroups@vger.kernel.org>; Mon, 21 Sep 2020 16:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=8oQpSQI8wvIpIER3mA+5Lt4f5fuUByXFTuElAIMrxcI=;
        b=ma0zWoCL6rzOYyWSY+cIZNt+OG/Pkpzhkrxk7+XUsZBArWxN+4ODulV6lkF/ejZ3wq
         sdqMdqNrnbCwZy7TGOOQjmktEWXJkmDwiTOfcEAy4S3ZPt6+ZAPZWl3cKaThR4AQqWEK
         luvgNfEnjUh8Ni1M0fXfbsp46OwRSYRo3AvZcPTkJ+bR30q9gbfeZvMwsQPjMp2MRtRk
         MPbnqEtZ1RgUKDL8zFjvTYHR/069rPbOGsCZs3WM7k1I0WJ4qFwTN+2XHEU+Qh+qTmgC
         dA+ZuhFoLY9PdE7Xkfs6KYGmYj1jhIhQeo1oezoGYkb0nQR5IOFTvIVNdcr6yzGwvlOW
         Moig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=8oQpSQI8wvIpIER3mA+5Lt4f5fuUByXFTuElAIMrxcI=;
        b=Nv9MggWNNn9iT5/a9jUxDU6Wdnx76sni+wPTHktVShHpAhBpUuw+tiYGQaXqsssUe7
         WuHmYSZyQ2fyh/Xni4yj9QB/uc7ogIz9UTLLrVBFw5bkwiiBULQhPxW7uq94SGsLqo+5
         e0r/19kDUUZm/JQGflcF+MGaDDmZJok3nnVyxz4eSuma2BWPjJx9NGNLBYZFvhrHnK+8
         5LHR/fQGHS7siaHbJTl6H8aYFlpoC2ZRBia8dxPp+av3CRdnGI4CBm8vnR76aD5G5Qvg
         rCW2MrHdKEVqvivxwmSFFYF3NIjCJlVmLpDs+snVQiRw7ux8K9VxMRoZrTL0fCu5KZrb
         Znfg==
X-Gm-Message-State: AOAM530pKuLD8uEP5mHpsm1pzxfbBe4KQsfOd0dJzxgY+5A8A1uQRqi+
        XWaa2fm7ge+dhYcNGsBBsJq1Xw==
X-Google-Smtp-Source: ABdhPJy5gdr+wGvmIXnwQJ0rjjfTSRyQJp8fGZHNIOuMCqPD+xBQdNZSHLEgLMmGAWAOU0s/ZxuQEg==
X-Received: by 2002:aca:f5cc:: with SMTP id t195mr1145600oih.10.1600732182000;
        Mon, 21 Sep 2020 16:49:42 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id f29sm1669221ook.44.2020.09.21.16.49.39
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 21 Sep 2020 16:49:40 -0700 (PDT)
Date:   Mon, 21 Sep 2020 16:49:38 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Alex Shi <alex.shi@linux.alibaba.com>
cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com, kirill@shutemov.name,
        alexander.duyck@gmail.com, rong.a.chen@intel.com, mhocko@suse.com,
        vdavydov.dev@gmail.com, shy828301@gmail.com
Subject: Re: [PATCH v18 17/32] mm/compaction: do page isolation first in
 compaction
In-Reply-To: <1598273705-69124-18-git-send-email-alex.shi@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.2009211617080.5214@eggly.anvils>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com> <1598273705-69124-18-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 24 Aug 2020, Alex Shi wrote:

> Currently, compaction would get the lru_lock and then do page isolation
> which works fine with pgdat->lru_lock, since any page isoltion would
> compete for the lru_lock. If we want to change to memcg lru_lock, we
> have to isolate the page before getting lru_lock, thus isoltion would
> block page's memcg change which relay on page isoltion too. Then we
> could safely use per memcg lru_lock later.
> 
> The new page isolation use previous introduced TestClearPageLRU() +
> pgdat lru locking which will be changed to memcg lru lock later.
> 
> Hugh Dickins <hughd@google.com> fixed following bugs in this patch's
> early version:
> 
> Fix lots of crashes under compaction load: isolate_migratepages_block()
> must clean up appropriately when rejecting a page, setting PageLRU again
> if it had been cleared; and a put_page() after get_page_unless_zero()
> cannot safely be done while holding locked_lruvec - it may turn out to
> be the final put_page(), which will take an lruvec lock when PageLRU.
> And move __isolate_lru_page_prepare back after get_page_unless_zero to
> make trylock_page() safe:
> trylock_page() is not safe to use at this time: its setting PG_locked
> can race with the page being freed or allocated ("Bad page"), and can
> also erase flags being set by one of those "sole owners" of a freshly
> allocated page who use non-atomic __SetPageFlag().
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>

Okay, whatever. I was about to say
Acked-by: Hugh Dickins <hughd@google.com>
With my signed-off-by there, someone will ask if it should say
"From: Hugh ..." at the top: no, it should not, this is Alex's patch,
but I proposed some fixes to it, as you already acknowledged.

A couple of comments below on the mm/vmscan.c part of it.

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
>  include/linux/swap.h |  2 +-
>  mm/compaction.c      | 42 +++++++++++++++++++++++++++++++++---------
>  mm/vmscan.c          | 46 ++++++++++++++++++++++++++--------------------
>  3 files changed, 60 insertions(+), 30 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 43e6b3458f58..550fdfdc3506 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -357,7 +357,7 @@ extern void lru_cache_add_inactive_or_unevictable(struct page *page,
>  extern unsigned long zone_reclaimable_pages(struct zone *zone);
>  extern unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
>  					gfp_t gfp_mask, nodemask_t *mask);
> -extern int __isolate_lru_page(struct page *page, isolate_mode_t mode);
> +extern int __isolate_lru_page_prepare(struct page *page, isolate_mode_t mode);
>  extern unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>  						  unsigned long nr_pages,
>  						  gfp_t gfp_mask,
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 4e2c66869041..253382d99969 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -887,6 +887,7 @@ static bool too_many_isolated(pg_data_t *pgdat)
>  		if (!valid_page && IS_ALIGNED(low_pfn, pageblock_nr_pages)) {
>  			if (!cc->ignore_skip_hint && get_pageblock_skip(page)) {
>  				low_pfn = end_pfn;
> +				page = NULL;
>  				goto isolate_abort;
>  			}
>  			valid_page = page;
> @@ -968,6 +969,21 @@ static bool too_many_isolated(pg_data_t *pgdat)
>  		if (!(cc->gfp_mask & __GFP_FS) && page_mapping(page))
>  			goto isolate_fail;
>  
> +		/*
> +		 * Be careful not to clear PageLRU until after we're
> +		 * sure the page is not being freed elsewhere -- the
> +		 * page release code relies on it.
> +		 */
> +		if (unlikely(!get_page_unless_zero(page)))
> +			goto isolate_fail;
> +
> +		if (__isolate_lru_page_prepare(page, isolate_mode) != 0)
> +			goto isolate_fail_put;
> +
> +		/* Try isolate the page */
> +		if (!TestClearPageLRU(page))
> +			goto isolate_fail_put;
> +
>  		/* If we already hold the lock, we can skip some rechecking */
>  		if (!locked) {
>  			locked = compact_lock_irqsave(&pgdat->lru_lock,
> @@ -980,10 +996,6 @@ static bool too_many_isolated(pg_data_t *pgdat)
>  					goto isolate_abort;
>  			}
>  
> -			/* Recheck PageLRU and PageCompound under lock */
> -			if (!PageLRU(page))
> -				goto isolate_fail;
> -
>  			/*
>  			 * Page become compound since the non-locked check,
>  			 * and it's on LRU. It can only be a THP so the order
> @@ -991,16 +1003,13 @@ static bool too_many_isolated(pg_data_t *pgdat)
>  			 */
>  			if (unlikely(PageCompound(page) && !cc->alloc_contig)) {
>  				low_pfn += compound_nr(page) - 1;
> -				goto isolate_fail;
> +				SetPageLRU(page);
> +				goto isolate_fail_put;
>  			}
>  		}
>  
>  		lruvec = mem_cgroup_page_lruvec(page, pgdat);
>  
> -		/* Try isolate the page */
> -		if (__isolate_lru_page(page, isolate_mode) != 0)
> -			goto isolate_fail;
> -
>  		/* The whole page is taken off the LRU; skip the tail pages. */
>  		if (PageCompound(page))
>  			low_pfn += compound_nr(page) - 1;
> @@ -1029,6 +1038,15 @@ static bool too_many_isolated(pg_data_t *pgdat)
>  		}
>  
>  		continue;
> +
> +isolate_fail_put:
> +		/* Avoid potential deadlock in freeing page under lru_lock */
> +		if (locked) {
> +			spin_unlock_irqrestore(&pgdat->lru_lock, flags);
> +			locked = false;
> +		}
> +		put_page(page);
> +
>  isolate_fail:
>  		if (!skip_on_failure)
>  			continue;
> @@ -1065,9 +1083,15 @@ static bool too_many_isolated(pg_data_t *pgdat)
>  	if (unlikely(low_pfn > end_pfn))
>  		low_pfn = end_pfn;
>  
> +	page = NULL;
> +
>  isolate_abort:
>  	if (locked)
>  		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
> +	if (page) {
> +		SetPageLRU(page);
> +		put_page(page);
> +	}
>  
>  	/*
>  	 * Updated the cached scanner pfn once the pageblock has been scanned
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 1b3e0eeaad64..48b50695f883 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1538,20 +1538,20 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>   *
>   * returns 0 on success, -ve errno on failure.
>   */
> -int __isolate_lru_page(struct page *page, isolate_mode_t mode)
> +int __isolate_lru_page_prepare(struct page *page, isolate_mode_t mode)
>  {
>  	int ret = -EINVAL;
>  
> -	/* Only take pages on the LRU. */
> -	if (!PageLRU(page))
> -		return ret;
> -
>  	/* Compaction should not handle unevictable pages but CMA can do so */
>  	if (PageUnevictable(page) && !(mode & ISOLATE_UNEVICTABLE))
>  		return ret;
>  
>  	ret = -EBUSY;
>  
> +	/* Only take pages on the LRU. */
> +	if (!PageLRU(page))
> +		return ret;
> +

So here you do deal with that BUG() issue.  But I'd prefer you to leave
it as I suggested in 16/32, just start with "int ret = -EBUSY;" and
don't rearrange the checks here at all.  I say that partly because
the !PageLRU check is very important (when called for compaction), and
the easier it is to find (at the very start), the less anxious I get!

>  	/*
>  	 * To minimise LRU disruption, the caller can indicate that it only
>  	 * wants to isolate pages it will be able to operate on without
> @@ -1592,20 +1592,9 @@ int __isolate_lru_page(struct page *page, isolate_mode_t mode)
>  	if ((mode & ISOLATE_UNMAPPED) && page_mapped(page))
>  		return ret;
>  
> -	if (likely(get_page_unless_zero(page))) {
> -		/*
> -		 * Be careful not to clear PageLRU until after we're
> -		 * sure the page is not being freed elsewhere -- the
> -		 * page release code relies on it.
> -		 */
> -		ClearPageLRU(page);
> -		ret = 0;
> -	}
> -
> -	return ret;
> +	return 0;
>  }
>  
> -
>  /*
>   * Update LRU sizes after isolating pages. The LRU size updates must
>   * be complete before mem_cgroup_update_lru_size due to a sanity check.
> @@ -1685,17 +1674,34 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
>  		 * only when the page is being freed somewhere else.
>  		 */
>  		scan += nr_pages;
> -		switch (__isolate_lru_page(page, mode)) {
> +		switch (__isolate_lru_page_prepare(page, mode)) {
>  		case 0:
> +			/*
> +			 * Be careful not to clear PageLRU until after we're
> +			 * sure the page is not being freed elsewhere -- the
> +			 * page release code relies on it.
> +			 */
> +			if (unlikely(!get_page_unless_zero(page)))
> +				goto busy;
> +
> +			if (!TestClearPageLRU(page)) {
> +				/*
> +				 * This page may in other isolation path,
> +				 * but we still hold lru_lock.
> +				 */
> +				put_page(page);
> +				goto busy;
> +			}
> +
>  			nr_taken += nr_pages;
>  			nr_zone_taken[page_zonenum(page)] += nr_pages;
>  			list_move(&page->lru, dst);
>  			break;
> -
> +busy:
>  		case -EBUSY:

It's a long time since I read a C manual. I had to try that out in a
little test program: and it does seem to do the right thing.  Maybe
I'm just very ignorant, and everybody else finds that natural: but I'd
feel more comfortable with the busy label on the line after the
"case -EBUSY:" - wouldn't you?

You could, of course, change that "case -EBUSY" to "default",
and delete the "default: BUG();" that follows: whatever you prefer.

>  			/* else it is being freed elsewhere */
>  			list_move(&page->lru, src);
> -			continue;
> +			break;

Aha. Yes, I like that change, I'm not going to throw a tantrum,
accusing you of sneaking in unrelated changes etc. You made me look
back at the history: it was "continue" from back in the days of
lumpy reclaim, when there was stuff after the switch statement
which needed to be skipped in the -EBUSY case.  "break" looks
more natural to me now.

>  
>  		default:
>  			BUG();
> -- 
> 1.8.3.1

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9E923C194
	for <lists+cgroups@lfdr.de>; Tue,  4 Aug 2020 23:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgHDVfj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Aug 2020 17:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgHDVfj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Aug 2020 17:35:39 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD4FC06174A;
        Tue,  4 Aug 2020 14:35:38 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id g14so6297435iom.0;
        Tue, 04 Aug 2020 14:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lIiAQymO5SiCLTvDBrxGf0tYJKgHszQcOVXFrDh6/HY=;
        b=ZsAVKnqcSum9Pch+dDnbayqsSt8UQiKsD6VpBuv/aEZKONnVGjqik2WUHwQ5+ADZkj
         YQl5IhBJYkjBdQ0Bwv6Ba0mAIq/JPGSwvPLbB8Mh+FdCvKSlAuOPeNeAXioD+VBNbPhv
         VMUUT/DKw98eTURZb30zTdoiEtPVyIrCxzXDf791lkNwE6i1YT8zMElX6Gai8I9dV3ll
         xkUyNhxXn+dRFplJ717wCrpAuZmBX0+G/Ucjfl3cFNNNdpdBH7CEmyrvjtjemw5L3o6x
         p1wbiM7CvYXUrK5uv0z08nF6KBVKACkioDbBAHLZNrNTY6s93kXMikuw8rYnvuBA3E7U
         7oIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lIiAQymO5SiCLTvDBrxGf0tYJKgHszQcOVXFrDh6/HY=;
        b=im+eoOXBSBHXOv86dkWewUxOMtKI+gnGZlBkImXy8ujU8vd1KN7UxM38rlSNXUFyoD
         mILq5i3RO8aNh4Z8vue6wJk5phyA/ee0HuROUhgasqk1nb/a2OLbEmQ8MBgNhjFEkCa6
         6X9TXl1bn479VLcv/Lap/yy4U6h5MRpGDKC5gtAik1r1i1fi2V7SU3TYB1STM/d4+eQ1
         26bnWdtA5skZo44xkWTuNmNHbchnAj99/CulrNrA7NLc5ucItxls7T+ezKq7PpWs8J6N
         VvRQ0t4gm+6Mjb+7IiHDHTSM1HjhGQKCVpdoTMUTM5YVtxl2JubvE2RE80KaZFg1KHuo
         tm/A==
X-Gm-Message-State: AOAM531NNq9KCaVyxpQqWiocyWL6R2UFjnpsKD7OmUMIBdhDUhCNTL2X
        v58fnmCTbSDYw+trxzjvmrSApJOPtW0MoeI56eQ4ycvRsJE=
X-Google-Smtp-Source: ABdhPJxAw8IesO2jde1iX08p2CE8bidlvWzOAuXXjEvjMENRCT25cmjHQ4D2DSD8FMnnamjG++KFAWinQEzWmV0ndFM=
X-Received: by 2002:a05:6602:2e83:: with SMTP id m3mr38281iow.38.1596576937556;
 Tue, 04 Aug 2020 14:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com> <1595681998-19193-15-git-send-email-alex.shi@linux.alibaba.com>
In-Reply-To: <1595681998-19193-15-git-send-email-alex.shi@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Tue, 4 Aug 2020 14:35:26 -0700
Message-ID: <CAKgT0Ud5Rqx+fm+9ZHMxARhShrDKR8F7djAGrjG7ZEbwY_2TcA@mail.gmail.com>
Subject: Re: [PATCH v17 14/21] mm/compaction: do page isolation first in compaction
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        kbuild test robot <lkp@intel.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Rong Chen <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jul 25, 2020 at 6:00 AM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>
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
> index 2c29399b29a0..6d23d3beeff7 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -358,7 +358,7 @@ extern void lru_cache_add_active_or_unevictable(struct page *page,
>  extern unsigned long zone_reclaimable_pages(struct zone *zone);
>  extern unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
>                                         gfp_t gfp_mask, nodemask_t *mask);
> -extern int __isolate_lru_page(struct page *page, isolate_mode_t mode);
> +extern int __isolate_lru_page_prepare(struct page *page, isolate_mode_t mode);
>  extern unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>                                                   unsigned long nr_pages,
>                                                   gfp_t gfp_mask,
> diff --git a/mm/compaction.c b/mm/compaction.c
> index f14780fc296a..2da2933fe56b 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -869,6 +869,7 @@ static bool too_many_isolated(pg_data_t *pgdat)
>                 if (!valid_page && IS_ALIGNED(low_pfn, pageblock_nr_pages)) {
>                         if (!cc->ignore_skip_hint && get_pageblock_skip(page)) {
>                                 low_pfn = end_pfn;
> +                               page = NULL;
>                                 goto isolate_abort;
>                         }
>                         valid_page = page;
> @@ -950,6 +951,21 @@ static bool too_many_isolated(pg_data_t *pgdat)
>                 if (!(cc->gfp_mask & __GFP_FS) && page_mapping(page))
>                         goto isolate_fail;
>
> +               /*
> +                * Be careful not to clear PageLRU until after we're
> +                * sure the page is not being freed elsewhere -- the
> +                * page release code relies on it.
> +                */
> +               if (unlikely(!get_page_unless_zero(page)))
> +                       goto isolate_fail;
> +
> +               if (__isolate_lru_page_prepare(page, isolate_mode) != 0)
> +                       goto isolate_fail_put;
> +
> +               /* Try isolate the page */
> +               if (!TestClearPageLRU(page))
> +                       goto isolate_fail_put;
> +
>                 /* If we already hold the lock, we can skip some rechecking */
>                 if (!locked) {
>                         locked = compact_lock_irqsave(&pgdat->lru_lock,

So the fact that this flow doesn't match what we have below in
isolate_lru_pages(). I went digging through the history and realize I
brought this up before and you referenced the following patch from
hugh:
https://lore.kernel.org/lkml/alpine.LSU.2.11.2006111529010.10801@eggly.anvils/

As such I am assuming this flow is needed because we aren't holding an
LRU lock, and the flow in mm/vmscan.c works because that is being
called while holding an LRU lock. I am wondering if we are
overcomplicating things by keeping the LRU check in
__isolate_lru_page_prepare(). If we were to pull it out then you could
just perform the get_page_unless_zero and TestClearPageLRU check
before you call the function and you could consolidate the code so
that it could be combined into a single function as below. So for
example you could combine them into:
static inline bool get_lru_page_unless_zero(struct page *page)
{
    /*
     * Be careful not to clear PageLRU until after we're
     * sure the page is not being freed elsewhere -- the
     * page release code relies on it.
     */
   if (unlikely(!get_page_unless_zero(page))
        return false;
    if(TestClearPageLRU(page))
        return true;
    put_page(page);
    return false;
}

Then the logic becomes that you have to either call
get_lru_page_unless_zero before calling __isolate_lru_page_prepare or
you have to be holding the LRU lock.

> @@ -962,10 +978,6 @@ static bool too_many_isolated(pg_data_t *pgdat)
>                                         goto isolate_abort;
>                         }
>
> -                       /* Recheck PageLRU and PageCompound under lock */
> -                       if (!PageLRU(page))
> -                               goto isolate_fail;
> -
>                         /*
>                          * Page become compound since the non-locked check,
>                          * and it's on LRU. It can only be a THP so the order
> @@ -973,16 +985,13 @@ static bool too_many_isolated(pg_data_t *pgdat)
>                          */
>                         if (unlikely(PageCompound(page) && !cc->alloc_contig)) {
>                                 low_pfn += compound_nr(page) - 1;
> -                               goto isolate_fail;
> +                               SetPageLRU(page);
> +                               goto isolate_fail_put;
>                         }
>                 }
>
>                 lruvec = mem_cgroup_page_lruvec(page, pgdat);
>
> -               /* Try isolate the page */
> -               if (__isolate_lru_page(page, isolate_mode) != 0)
> -                       goto isolate_fail;
> -
>                 /* The whole page is taken off the LRU; skip the tail pages. */
>                 if (PageCompound(page))
>                         low_pfn += compound_nr(page) - 1;
> @@ -1011,6 +1020,15 @@ static bool too_many_isolated(pg_data_t *pgdat)
>                 }
>
>                 continue;
> +
> +isolate_fail_put:
> +               /* Avoid potential deadlock in freeing page under lru_lock */
> +               if (locked) {
> +                       spin_unlock_irqrestore(&pgdat->lru_lock, flags);
> +                       locked = false;
> +               }
> +               put_page(page);
> +
>  isolate_fail:
>                 if (!skip_on_failure)
>                         continue;
> @@ -1047,9 +1065,15 @@ static bool too_many_isolated(pg_data_t *pgdat)
>         if (unlikely(low_pfn > end_pfn))
>                 low_pfn = end_pfn;
>
> +       page = NULL;
> +
>  isolate_abort:
>         if (locked)
>                 spin_unlock_irqrestore(&pgdat->lru_lock, flags);
> +       if (page) {
> +               SetPageLRU(page);
> +               put_page(page);
> +       }
>
>         /*
>          * Updated the cached scanner pfn once the pageblock has been scanned
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 4183ae6b54b5..f77748adc340 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1544,20 +1544,20 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>   *
>   * returns 0 on success, -ve errno on failure.
>   */
> -int __isolate_lru_page(struct page *page, isolate_mode_t mode)
> +int __isolate_lru_page_prepare(struct page *page, isolate_mode_t mode)
>  {
>         int ret = -EINVAL;
>
> -       /* Only take pages on the LRU. */
> -       if (!PageLRU(page))
> -               return ret;
> -
>         /* Compaction should not handle unevictable pages but CMA can do so */
>         if (PageUnevictable(page) && !(mode & ISOLATE_UNEVICTABLE))
>                 return ret;
>
>         ret = -EBUSY;
>
> +       /* Only take pages on the LRU. */
> +       if (!PageLRU(page))
> +               return ret;
> +
>         /*
>          * To minimise LRU disruption, the caller can indicate that it only
>          * wants to isolate pages it will be able to operate on without

So the question I would have is if we really need to be checking
PageLRU here? I wonder if this isn't another spot where we would be
better served by just assuming that PageLRU has been checked while
holding the lock, or tested and cleared while holding a page
reference. The original patch from Hugh referenced above mentions a
desire to do away with __isolate_lru_page_prepare entirely, so I
wonder if it wouldn't be good to be proactive and pull out the bits we
think we might need versus the ones we don't.

> @@ -1598,20 +1598,9 @@ int __isolate_lru_page(struct page *page, isolate_mode_t mode)
>         if ((mode & ISOLATE_UNMAPPED) && page_mapped(page))
>                 return ret;
>
> -       if (likely(get_page_unless_zero(page))) {
> -               /*
> -                * Be careful not to clear PageLRU until after we're
> -                * sure the page is not being freed elsewhere -- the
> -                * page release code relies on it.
> -                */
> -               ClearPageLRU(page);
> -               ret = 0;
> -       }
> -
> -       return ret;
> +       return 0;
>  }
>
> -
>  /*
>   * Update LRU sizes after isolating pages. The LRU size updates must
>   * be complete before mem_cgroup_update_lru_size due to a sanity check.
> @@ -1691,17 +1680,34 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
>                  * only when the page is being freed somewhere else.
>                  */
>                 scan += nr_pages;
> -               switch (__isolate_lru_page(page, mode)) {
> +               switch (__isolate_lru_page_prepare(page, mode)) {

So after looking through the code I realized that "mode" here will
always be either 0 or ISOLATE_UNMAPPED. I assume this is why we aren't
worried about the trylock_page call messing things up. With that said
it looks like the function just breaks down to three tests, first for
PageUnevictable(), then PageLRU(), and then possibly page_mapped(). As
such I believe dropping the PageLRU check from the function as I
suggested above should be safe since we are at risk for the test of it
racing anyway since it could be cleared out from under us, and the bit
isn't really protecting anything anyway since we are holding the LRU
lock and anyhow.

>                 case 0:
> +                       /*
> +                        * Be careful not to clear PageLRU until after we're
> +                        * sure the page is not being freed elsewhere -- the
> +                        * page release code relies on it.
> +                        */
> +                       if (unlikely(!get_page_unless_zero(page)))
> +                               goto busy;
> +
> +                       if (!TestClearPageLRU(page)) {
> +                               /*
> +                                * This page may in other isolation path,
> +                                * but we still hold lru_lock.
> +                                */
> +                               put_page(page);
> +                               goto busy;
> +                       }
> +

This piece could be consolidated via the single function I called out above.

>                         nr_taken += nr_pages;
>                         nr_zone_taken[page_zonenum(page)] += nr_pages;
>                         list_move(&page->lru, dst);
>                         break;
> -
> +busy:
>                 case -EBUSY:
>                         /* else it is being freed elsewhere */
>                         list_move(&page->lru, src);
> -                       continue;
> +                       break;
>                 default:
>                         BUG();
> --
> 1.8.3.1
>

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41139222DFF
	for <lists+cgroups@lfdr.de>; Thu, 16 Jul 2020 23:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgGPVcv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Jul 2020 17:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgGPVcv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 Jul 2020 17:32:51 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC5AC061755;
        Thu, 16 Jul 2020 14:32:51 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id f23so7691302iof.6;
        Thu, 16 Jul 2020 14:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WCPVcqFuiCdUoJYXeYbmBF6DGMw5rsz8t1arNpaHm/Q=;
        b=KrtuqfKLe1HresqYP0nYMAMlhSHrS4z3wZlak6tIf9Sc+8bZ+DnymZHD1TlFkkHIkt
         +eeUM9kjrXHgYezAodfxHYeNe/WyjTcrY7uEE8opCtb0olqS2Gdkvl781a2c0ddmyDuF
         EAh5aHgfGMI3ZoFLtdav2bTekuWibtY40jWTG7FKCgsxsTYnJmzcwtKPdveljQGwcBdh
         IW9qf1f/xdpBBhTRlSpnRW6SrhS+g53ccA+Vh5lgWBRk3Kki6o2gOq47FWGFoNBMuwoh
         qR8zfKq45Dea0rRqxfkQ/BGwu7pQ2fmDcOs5RGv5yKFMK/7cabijhHnGeOAhapjTJ4mt
         lAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WCPVcqFuiCdUoJYXeYbmBF6DGMw5rsz8t1arNpaHm/Q=;
        b=sborYYuzPi64LbO/JZPi8qICY5UJFfwIZ3JWY7mUNwKzLCYHYRCj0cKul8opX2Dexf
         48hh5rISYsv7v7BcIdqCgR9UF1bNVElFghybWWh1zU+nKq5lq4EoK0J2KEuNAfTFI6Ec
         JvZaC49Jm3MT0eOeh4+zBAKluwI5TFDI5Fkaf/Ve7AuOuTvzYZYnw/VvgI4lh4q7rOcG
         Y/bLDXmYFO8deqHmPkEeO86vBT7/soQkfVm16urdrjSbsvYs100f+jTYjvx77xyyETEV
         Urrl9om3G3JVke9r7Gvpb+ydaAHrRIm0mMZcmMgHWwFhEHZZEaUSSRfmi1vlkLgcxhtb
         HnmA==
X-Gm-Message-State: AOAM533fEFj92CQeN1jUqeeluKEJBv+0CrwyUgMLZclmPlwKV6tziLuu
        y9TFoh/QOu8fOmQP9+E4HqXO11cwq0iO4fyU54A=
X-Google-Smtp-Source: ABdhPJwlkKnjQKpDgnnAlSJD7m0HJKooPQCbYM4cllqOAxIG6bMA2HhR43hzrGc21eQRRx1kXzerU3wVAFR4p2nj8/Y=
X-Received: by 2002:a02:ce9a:: with SMTP id y26mr7535180jaq.121.1594935170180;
 Thu, 16 Jul 2020 14:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com> <1594429136-20002-16-git-send-email-alex.shi@linux.alibaba.com>
In-Reply-To: <1594429136-20002-16-git-send-email-alex.shi@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 16 Jul 2020 14:32:39 -0700
Message-ID: <CAKgT0Ue72SfAmxCS+tay1NjioW9WBOvVgrhwUtVPz2aDCrcHPQ@mail.gmail.com>
Subject: Re: [PATCH v16 15/22] mm/compaction: do page isolation first in compaction
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
        "Kirill A. Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jul 10, 2020 at 5:59 PM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>
> Johannes Weiner has suggested:
> "So here is a crazy idea that may be worth exploring:
>
> Right now, pgdat->lru_lock protects both PageLRU *and* the lruvec's
> linked list.
>
> Can we make PageLRU atomic and use it to stabilize the lru_lock
> instead, and then use the lru_lock only serialize list operations?
> ..."
>
> Yes, this patch is doing so on  __isolate_lru_page which is the core
> page isolation func in compaction and shrinking path.
> With this patch, the compaction will only deal the PageLRU set and now
> isolated pages to skip the just alloced page which no LRU bit. And the
> isolation could exclusive the other isolations in memcg move_account,
> page migrations and thp split_huge_page.
>
> As a side effect, PageLRU may be cleared during shrink_inactive_list
> path for isolation reason. If so, we can skip that page.
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
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
>  include/linux/swap.h |  2 +-
>  mm/compaction.c      | 42 +++++++++++++++++++++++++++++++++---------
>  mm/vmscan.c          | 38 ++++++++++++++++++++++----------------
>  3 files changed, 56 insertions(+), 26 deletions(-)
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

Why not do the __isolate_lru_page_prepare before getting the page?
That way you can avoid performing an extra atomic operation on non-LRU
pages.

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
> index 18986fefd49b..f77748adc340 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1544,7 +1544,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>   *
>   * returns 0 on success, -ve errno on failure.
>   */
> -int __isolate_lru_page(struct page *page, isolate_mode_t mode)
> +int __isolate_lru_page_prepare(struct page *page, isolate_mode_t mode)
>  {
>         int ret = -EINVAL;
>
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

I wonder if it wouldn't make sense to combine these two atomic ops
with tests and the put_page into a single inline function? Then it
could be possible to just do one check and if succeeds you do the
block of code below, otherwise you just fall-through into the -EBUSY
case.

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
>
>                 default:
>                         BUG();
> --
> 1.8.3.1
>
>

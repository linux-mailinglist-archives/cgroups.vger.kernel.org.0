Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02A3224537
	for <lists+cgroups@lfdr.de>; Fri, 17 Jul 2020 22:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgGQUbB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Jul 2020 16:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgGQUbA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Jul 2020 16:31:00 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9127EC0619D2;
        Fri, 17 Jul 2020 13:31:00 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id i18so8413620ilk.10;
        Fri, 17 Jul 2020 13:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fa0GcN94SAkMndYvc3rpkB4mYfViww4odBhNhRRf9p4=;
        b=b6CIPYc2VxBTb04tX/asXA0o9d0VrXp8fIGsmGa87N7hweYpBaZQSSRtQliAvy2SpA
         x1RVaFTjrFwbtpLQTVaabypRIwb+plt5beFUWUODt1NqHYc+NjmgMyN769sU6E77xUI7
         Z0mxC1qfRMX8tPq6m4bqljR5bhlcINhTUvT/+8xH0+CuJR3KvUxUld+cUoR+7Wpk4yRr
         UA1YkYlBLGuCr1sk5f+sEcuoBocb7aA0JsqpZbAb7xosNfdsr0c3UC3/H1TKcaNp6m/I
         v/bxxezggEE41VMfiDkyDDc499gkYAPpxOz7oGPGSbkSXR3RLPoM3y17FWmnbElWkvwd
         nqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fa0GcN94SAkMndYvc3rpkB4mYfViww4odBhNhRRf9p4=;
        b=EvbrON1M6wkQK3vy7mUAHFumMx3g1uLpsyFYqT+bxrFjNrtZ9snRLqz+NMfokqp8/q
         C5FN5frkf6sG+jGNDoto1vahcr+3HD1R37XERFsCRYsSw3LwXEQESkA353dlXXfJ/sPa
         OC9OViAuaaeQx3Fti61nC1JE7xU+VRPcgPUQ6TQc6NewcbXw655rLONvJ1y4VB72ytXt
         BsX42IwMpUhl63J2Vgm22RLu3GpPKLgFD0mVrt2NtX72NfPWPoY22raGo1wtJGCytIZw
         bQGjVrg0ChYb7CVjKaYfQN7MdHbcHZ1sj1xSPp6U4Ni/yYelSeJPl9UrsaSRmFVMOcVk
         VQgA==
X-Gm-Message-State: AOAM532CgOjpNymoP2Ob3e17r/sacvevnYbhCloab5esPDBAh4JVciSG
        XMtYg/XBVraemjdpOjE/Q18EKuuTY3iNd256jh8=
X-Google-Smtp-Source: ABdhPJwa13P8NrbQ/dNqsrcei2jQUP+iK4pzjDOkoi+cVp406kaWYHUtuX9XxJ8BQAYglTHtRZx0XoKXSHpSMbw3sEE=
X-Received: by 2002:a92:8544:: with SMTP id f65mr11605442ilh.42.1595017859659;
 Fri, 17 Jul 2020 13:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com> <1594429136-20002-17-git-send-email-alex.shi@linux.alibaba.com>
In-Reply-To: <1594429136-20002-17-git-send-email-alex.shi@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Fri, 17 Jul 2020 13:30:48 -0700
Message-ID: <CAKgT0Udcry01samXT54RkurNqFKnVmv-686ZFHF+iw4b+12T_A@mail.gmail.com>
Subject: Re: [PATCH v16 16/22] mm/mlock: reorder isolation sequence during munlock
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
> This patch reorder the isolation steps during munlock, move the lru lock
> to guard each pages, unfold __munlock_isolate_lru_page func, to do the
> preparation for lru lock change.
>
> __split_huge_page_refcount doesn't exist, but we still have to guard
> PageMlocked and PageLRU for tail page in __split_huge_page_tail.
>
> [lkp@intel.com: found a sleeping function bug ... at mm/rmap.c]
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Kirill A. Shutemov <kirill@shutemov.name>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  mm/mlock.c | 93 ++++++++++++++++++++++++++++++++++----------------------------
>  1 file changed, 51 insertions(+), 42 deletions(-)
>
> diff --git a/mm/mlock.c b/mm/mlock.c
> index 228ba5a8e0a5..0bdde88b4438 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -103,25 +103,6 @@ void mlock_vma_page(struct page *page)
>  }
>
>  /*
> - * Isolate a page from LRU with optional get_page() pin.
> - * Assumes lru_lock already held and page already pinned.
> - */
> -static bool __munlock_isolate_lru_page(struct page *page, bool getpage)
> -{
> -       if (TestClearPageLRU(page)) {
> -               struct lruvec *lruvec;
> -
> -               lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
> -               if (getpage)
> -                       get_page(page);
> -               del_page_from_lru_list(page, lruvec, page_lru(page));
> -               return true;
> -       }
> -
> -       return false;
> -}
> -
> -/*
>   * Finish munlock after successful page isolation
>   *
>   * Page must be locked. This is a wrapper for try_to_munlock()
> @@ -181,6 +162,7 @@ static void __munlock_isolation_failed(struct page *page)
>  unsigned int munlock_vma_page(struct page *page)
>  {
>         int nr_pages;
> +       bool clearlru = false;
>         pg_data_t *pgdat = page_pgdat(page);
>
>         /* For try_to_munlock() and to serialize with page migration */
> @@ -189,32 +171,42 @@ unsigned int munlock_vma_page(struct page *page)
>         VM_BUG_ON_PAGE(PageTail(page), page);
>
>         /*
> -        * Serialize with any parallel __split_huge_page_refcount() which
> +        * Serialize split tail pages in __split_huge_page_tail() which
>          * might otherwise copy PageMlocked to part of the tail pages before
>          * we clear it in the head page. It also stabilizes hpage_nr_pages().
>          */
> +       get_page(page);

I don't think this get_page() call needs to be up here. It could be
left down before we delete the page from the LRU list as it is really
needed to take a reference on the page before we call
__munlock_isolated_page(), or at least that is the way it looks to me.
By doing that you can avoid a bunch of cleanup in these exception
cases.

> +       clearlru = TestClearPageLRU(page);

I'm not sure I fully understand the reason for moving this here. By
clearing this flag before you clear Mlocked does this give you some
sort of extra protection? I don't see how since Mlocked doesn't
necessarily imply the page is on LRU.

>         spin_lock_irq(&pgdat->lru_lock);
>
>         if (!TestClearPageMlocked(page)) {
> -               /* Potentially, PTE-mapped THP: do not skip the rest PTEs */
> -               nr_pages = 1;
> -               goto unlock_out;
> +               if (clearlru)
> +                       SetPageLRU(page);
> +               /*
> +                * Potentially, PTE-mapped THP: do not skip the rest PTEs
> +                * Reuse lock as memory barrier for release_pages racing.
> +                */
> +               spin_unlock_irq(&pgdat->lru_lock);
> +               put_page(page);
> +               return 0;
>         }
>
>         nr_pages = hpage_nr_pages(page);
>         __mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
>
> -       if (__munlock_isolate_lru_page(page, true)) {
> +       if (clearlru) {
> +               struct lruvec *lruvec;
> +

You could just place the get_page() call here.

> +               lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
> +               del_page_from_lru_list(page, lruvec, page_lru(page));
>                 spin_unlock_irq(&pgdat->lru_lock);
>                 __munlock_isolated_page(page);
> -               goto out;
> +       } else {
> +               spin_unlock_irq(&pgdat->lru_lock);
> +               put_page(page);
> +               __munlock_isolation_failed(page);

If you move the get_page() as I suggested above there wouldn't be a
need for the put_page(). It then becomes possible to simplify the code
a bit by merging the unlock paths and doing an if/else with the
__munlock functions like so:
if (clearlru) {
    ...
    del_page_from_lru..
}

spin_unlock_irq()

if (clearlru)
    __munlock_isolated_page();
else
    __munlock_isolated_failed();

>         }
> -       __munlock_isolation_failed(page);
> -
> -unlock_out:
> -       spin_unlock_irq(&pgdat->lru_lock);
>
> -out:
>         return nr_pages - 1;
>  }
>
> @@ -297,34 +289,51 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
>         pagevec_init(&pvec_putback);
>
>         /* Phase 1: page isolation */
> -       spin_lock_irq(&zone->zone_pgdat->lru_lock);
>         for (i = 0; i < nr; i++) {
>                 struct page *page = pvec->pages[i];
> +               struct lruvec *lruvec;
> +               bool clearlru;
>
> -               if (TestClearPageMlocked(page)) {
> -                       /*
> -                        * We already have pin from follow_page_mask()
> -                        * so we can spare the get_page() here.
> -                        */
> -                       if (__munlock_isolate_lru_page(page, false))
> -                               continue;
> -                       else
> -                               __munlock_isolation_failed(page);
> -               } else {
> +               clearlru = TestClearPageLRU(page);
> +               spin_lock_irq(&zone->zone_pgdat->lru_lock);

I still don't see what you are gaining by moving the bit test up to
this point. Seems like it would be better left below with the lock
just being used to prevent a possible race while you are pulling the
page out of the LRU list.

> +
> +               if (!TestClearPageMlocked(page)) {
>                         delta_munlocked++;
> +                       if (clearlru)
> +                               SetPageLRU(page);
> +                       goto putback;
> +               }
> +
> +               if (!clearlru) {
> +                       __munlock_isolation_failed(page);
> +                       goto putback;
>                 }

With the other function you were processing this outside of the lock,
here you are doing it inside. It would probably make more sense here
to follow similar logic and take care of the del_page_from_lru_list
ifr clealru is set, unlock, and then if clearlru is set continue else
track the isolation failure. That way you can avoid having to use as
many jump labels.

>                 /*
> +                * Isolate this page.
> +                * We already have pin from follow_page_mask()
> +                * so we can spare the get_page() here.
> +                */
> +               lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
> +               del_page_from_lru_list(page, lruvec, page_lru(page));
> +               spin_unlock_irq(&zone->zone_pgdat->lru_lock);
> +               continue;
> +
> +               /*
>                  * We won't be munlocking this page in the next phase
>                  * but we still need to release the follow_page_mask()
>                  * pin. We cannot do it under lru_lock however. If it's
>                  * the last pin, __page_cache_release() would deadlock.
>                  */
> +putback:
> +               spin_unlock_irq(&zone->zone_pgdat->lru_lock);
>                 pagevec_add(&pvec_putback, pvec->pages[i]);
>                 pvec->pages[i] = NULL;
>         }
> +       /* tempary disable irq, will remove later */
> +       local_irq_disable();
>         __mod_zone_page_state(zone, NR_MLOCK, delta_munlocked);
> -       spin_unlock_irq(&zone->zone_pgdat->lru_lock);
> +       local_irq_enable();
>
>         /* Now we can release pins of pages that we are not munlocking */
>         pagevec_release(&pvec_putback);
> --
> 1.8.3.1
>
>

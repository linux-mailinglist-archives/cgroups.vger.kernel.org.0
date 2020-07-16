Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68372222D7B
	for <lists+cgroups@lfdr.de>; Thu, 16 Jul 2020 23:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgGPVNB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Jul 2020 17:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgGPVNA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 Jul 2020 17:13:00 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714FAC061755;
        Thu, 16 Jul 2020 14:13:00 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id v6so7618273iob.4;
        Thu, 16 Jul 2020 14:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j4p2o66Y8Hysfm2THt7ux8U8lQwZrSREMMrCnItGpgg=;
        b=ccywiF4g6bXn2B2vT3dj5M/n9xSMsRouUPOpvpLy4aLUj8oULfJ+c3FbDKouBUYVKC
         6TpkN+gnyni3ECTO2wClaBly+OGUtIrKmYI2IaAe0Rg9aQbwZN+tzWwHb+DawxaVBWUi
         ggedp06PekWUD/qNjCyO49Y32XnmyxnJL17iBDGBvGIA+V8PhZawlMaqvr2zY5KXBvYN
         2o8aoNvSQ055T42wbPYosoulyRO4OVhB2/9PSvbmCd119yC6Rcnmcs8rxO5TKvW3YNVX
         u0D9a89H+tJhZWCMAz+2qSXhjwFkSZFsOhDJO6xYc4DlpFfbbiFAcT6cCZfOlAmiuE+z
         Qlsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j4p2o66Y8Hysfm2THt7ux8U8lQwZrSREMMrCnItGpgg=;
        b=DaytrHgtK+nn2fR88vGCN2Q311H/iuXB0O2SXz5gjkikin/e3DZnO4SE3UCAnqtvVe
         IaaHQZzB62lNYZYK5hmr4GS9+zpZoHoxpV7bV3as7cFamqCf9j0exjBnLZ2CjvqrHOsn
         8LbPMl3QtfXfbTuQdjfY+d4FF9W0/j1ERSdCVRfWvsDTkV7tVJ5Zff5MFiC+7q0G/S7U
         9K0LxkRzAPqubb8OoBM1T44Ytrie3NYPW5q0U/WL9bbywkihoHC3HFjBHrpXcqKhgGeV
         mwg/Q20t11cezw17QZNAFY4+CC+YLWRZzcLXNEPYkeJd1GhVIFniCEPNymcHNb31CAFS
         0N4Q==
X-Gm-Message-State: AOAM5300bLDdvFlKk1QmH657e6R9dg737ueh5RIvmVMdocH2F4zpk7Xe
        nXOtHB6aFgTk+4mZCQCGdPcTVyhW/pLTPxLUvJ4=
X-Google-Smtp-Source: ABdhPJzIZWeboByU0xjr1seRgOGrHs5lVck5GyTNcpRf0diZ8LnyYlvJBjbgaRA+bW+cDFQMgHW73Le5EWxThU+YoJA=
X-Received: by 2002:a6b:1d7:: with SMTP id 206mr6406999iob.138.1594933979444;
 Thu, 16 Jul 2020 14:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com> <1594429136-20002-14-git-send-email-alex.shi@linux.alibaba.com>
In-Reply-To: <1594429136-20002-14-git-send-email-alex.shi@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 16 Jul 2020 14:12:48 -0700
Message-ID: <CAKgT0UfLbVRQ4+TOw-XnjuyZqoVmRmWb5_rbEZZ0povYv-n_Lg@mail.gmail.com>
Subject: Re: [PATCH v16 13/22] mm/lru: introduce TestClearPageLRU
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
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jul 10, 2020 at 5:59 PM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>
> Combine PageLRU check and ClearPageLRU into a function by new
> introduced func TestClearPageLRU. This function will be used as page
> isolation precondition to prevent other isolations some where else.
> Then there are may non PageLRU page on lru list, need to remove BUG
> checking accordingly.
>
> Hugh Dickins pointed that __page_cache_release and release_pages
> has no need to do atomic clear bit since no user on the page at that
> moment. and no need get_page() before lru bit clear in isolate_lru_page,
> since it '(1) Must be called with an elevated refcount on the page'.
>
> As Andrew Morton mentioned this change would dirty cacheline for page
> isn't on LRU. But the lost would be acceptable with Rong Chen
> <rong.a.chen@intel.com> report:
> https://lkml.org/lkml/2020/3/4/173
>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
>  include/linux/page-flags.h |  1 +
>  mm/mlock.c                 |  3 +--
>  mm/swap.c                  |  6 ++----
>  mm/vmscan.c                | 26 +++++++++++---------------
>  4 files changed, 15 insertions(+), 21 deletions(-)
>
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 6be1aa559b1e..9554ed1387dc 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -326,6 +326,7 @@ static inline void page_init_poison(struct page *page, size_t size)
>  PAGEFLAG(Dirty, dirty, PF_HEAD) TESTSCFLAG(Dirty, dirty, PF_HEAD)
>         __CLEARPAGEFLAG(Dirty, dirty, PF_HEAD)
>  PAGEFLAG(LRU, lru, PF_HEAD) __CLEARPAGEFLAG(LRU, lru, PF_HEAD)
> +       TESTCLEARFLAG(LRU, lru, PF_HEAD)
>  PAGEFLAG(Active, active, PF_HEAD) __CLEARPAGEFLAG(Active, active, PF_HEAD)
>         TESTCLEARFLAG(Active, active, PF_HEAD)
>  PAGEFLAG(Workingset, workingset, PF_HEAD)
> diff --git a/mm/mlock.c b/mm/mlock.c
> index f8736136fad7..228ba5a8e0a5 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -108,13 +108,12 @@ void mlock_vma_page(struct page *page)
>   */
>  static bool __munlock_isolate_lru_page(struct page *page, bool getpage)
>  {
> -       if (PageLRU(page)) {
> +       if (TestClearPageLRU(page)) {
>                 struct lruvec *lruvec;
>
>                 lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
>                 if (getpage)
>                         get_page(page);
> -               ClearPageLRU(page);
>                 del_page_from_lru_list(page, lruvec, page_lru(page));
>                 return true;
>         }
> diff --git a/mm/swap.c b/mm/swap.c
> index f645965fde0e..5092fe9c8c47 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -83,10 +83,9 @@ static void __page_cache_release(struct page *page)
>                 struct lruvec *lruvec;
>                 unsigned long flags;
>
> +               __ClearPageLRU(page);
>                 spin_lock_irqsave(&pgdat->lru_lock, flags);
>                 lruvec = mem_cgroup_page_lruvec(page, pgdat);
> -               VM_BUG_ON_PAGE(!PageLRU(page), page);
> -               __ClearPageLRU(page);
>                 del_page_from_lru_list(page, lruvec, page_off_lru(page));
>                 spin_unlock_irqrestore(&pgdat->lru_lock, flags);
>         }

So this piece doesn't make much sense to me. Why not use
TestClearPageLRU(page) here? Just a few lines above you are testing
for PageLRU(page) and it seems like if you are going to go for an
atomic test/clear and then remove the page from the LRU list you
should be using it here as well otherwise it seems like you could run
into a potential collision since you are testing here without clearing
the bit.

> @@ -878,9 +877,8 @@ void release_pages(struct page **pages, int nr)
>                                 spin_lock_irqsave(&locked_pgdat->lru_lock, flags);
>                         }
>
> -                       lruvec = mem_cgroup_page_lruvec(page, locked_pgdat);
> -                       VM_BUG_ON_PAGE(!PageLRU(page), page);
>                         __ClearPageLRU(page);
> +                       lruvec = mem_cgroup_page_lruvec(page, locked_pgdat);
>                         del_page_from_lru_list(page, lruvec, page_off_lru(page));
>                 }
>

Same here. You are just moving the flag clearing, but you didn't
combine it with the test. It seems like if you are expecting this to
be treated as an atomic operation. It should be a relatively low cost
to do since you already should own the cacheline as a result of
calling put_page_testzero so I am not sure why you are not combining
the two.

> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index c1c4259b4de5..18986fefd49b 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1548,16 +1548,16 @@ int __isolate_lru_page(struct page *page, isolate_mode_t mode)
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
> @@ -1671,8 +1671,6 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
>                 page = lru_to_page(src);
>                 prefetchw_prev_lru_page(page, src, flags);
>
> -               VM_BUG_ON_PAGE(!PageLRU(page), page);
> -
>                 nr_pages = compound_nr(page);
>                 total_scan += nr_pages;
>

So effectively the changes here are making it so that a !PageLRU page
will cycle to the start of the LRU list. Now if I understand correctly
we are guaranteed that if the flag is not set it cannot be set while
we are holding the lru_lock, however it can be cleared while we are
holding the lock, correct? Thus that is why isolate_lru_pages has to
call TestClearPageLRU after the earlier check in __isolate_lru_page.

It might make it more readable to pull in the later patch that
modifies isolate_lru_pages that has it using TestClearPageLRU.

> @@ -1769,21 +1767,19 @@ int isolate_lru_page(struct page *page)
>         VM_BUG_ON_PAGE(!page_count(page), page);
>         WARN_RATELIMIT(PageTail(page), "trying to isolate tail page");
>
> -       if (PageLRU(page)) {
> +       if (TestClearPageLRU(page)) {
>                 pg_data_t *pgdat = page_pgdat(page);
>                 struct lruvec *lruvec;
> +               int lru = page_lru(page);
>
> -               spin_lock_irq(&pgdat->lru_lock);
> +               get_page(page);
>                 lruvec = mem_cgroup_page_lruvec(page, pgdat);
> -               if (PageLRU(page)) {
> -                       int lru = page_lru(page);
> -                       get_page(page);
> -                       ClearPageLRU(page);
> -                       del_page_from_lru_list(page, lruvec, lru);
> -                       ret = 0;
> -               }
> +               spin_lock_irq(&pgdat->lru_lock);
> +               del_page_from_lru_list(page, lruvec, lru);
>                 spin_unlock_irq(&pgdat->lru_lock);
> +               ret = 0;
>         }
> +
>         return ret;
>  }
>
> --
> 1.8.3.1
>
>

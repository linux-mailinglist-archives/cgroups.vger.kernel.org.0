Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFFBB22461E
	for <lists+cgroups@lfdr.de>; Sat, 18 Jul 2020 00:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgGQWDg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Jul 2020 18:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbgGQWDg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Jul 2020 18:03:36 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCF5C0619D2;
        Fri, 17 Jul 2020 15:03:36 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id k6so8596378ili.6;
        Fri, 17 Jul 2020 15:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ADWTNLSTN/jx8R6eCOwpfUeeP1CfoDk/4v09jrg5Jzg=;
        b=MhfZenzKmMsq1FsLNsKxsMsxBoD4kD+lM8XSRF0h3RNY74+U/MflNagIwW1EwNOkoC
         a8ug25VoJ/znvH/8yjAIFBThfFR59BURUB1eQcWuqiGbC777vUF90JulYCdeiZrUviVn
         R/SE8aj7Dr0SuWXC2W0jRmWz0RlnHNj/+Sgs3kpqyalH3o7UgLhQkvRCwC85O5jrTmcW
         VaRhz7XMKxjEUOHHvqm/mWFAhISpTfB10Gf1YSUWE0KkZFc3rEREmlz9YqIAAfwj7IRM
         +kYwqmJZGS/MNl+1EBRKeKV7lJUtHh06TNK3Y7jRs2U8r+l7AxuwPONhwMNZLqUnv60h
         RFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ADWTNLSTN/jx8R6eCOwpfUeeP1CfoDk/4v09jrg5Jzg=;
        b=BIa++jegr10AGw+aq/45LkS4dT155zUK73t9IVQainSiyLBfS+zXIKxNRggS/O/QdR
         +aKXDz6NUxKy24leGTarBXJBQzJ/400fvKokQzAo20PS0vo5VRFBAIrVBvP715k6yRH6
         NO7SWwtiHyz6F/vlpqS5IEcoMqV2VIqxyc6m6dHrcZ6p6hZavyayAI+HuUBpH3PVVhKS
         lqTgmLXYs0rBG9qmb1YDt6qMAnc9Zy/vZm5FEn9Hk2VE09p4kzjKUI0ofXHad4FpGchn
         ngCGLRH+YaG+Q0DlI5pkaH5xivTs4vxqQ8LWDr2T75uCkxnEwpCRNVs3OSPdwcwL7gqT
         j3LQ==
X-Gm-Message-State: AOAM533QiMLaPUJTgu5xAgpzHvpnDFEsG4OD9hROk4kg0NX1HvqkImXK
        H5Mzw4TsNB++rA+fapAcz5aGrEnAPc0/FTF7gaK/np9N
X-Google-Smtp-Source: ABdhPJw6WOFurD5hVZHUMz8S4qU4WfpAG8+1gwGjbP59so/THz2RWrJ4uQWnxz9xnU2p266+mjwf3FPqKJ3zVuqul9c=
X-Received: by 2002:a92:5a05:: with SMTP id o5mr11918205ilb.237.1595023415104;
 Fri, 17 Jul 2020 15:03:35 -0700 (PDT)
MIME-Version: 1.0
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com> <1594429136-20002-20-git-send-email-alex.shi@linux.alibaba.com>
In-Reply-To: <1594429136-20002-20-git-send-email-alex.shi@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Fri, 17 Jul 2020 15:03:24 -0700
Message-ID: <CAKgT0UdL7ppCdszBNyY3O9d2stE0tCZ8vCzH7tBEnHG2ZwkZHg@mail.gmail.com>
Subject: Re: [PATCH v16 19/22] mm/lru: introduce the relock_page_lruvec function
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
        Thomas Gleixner <tglx@linutronix.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jul 10, 2020 at 5:59 PM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>
> Use this new function to replace repeated same code, no func change.
>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
>  mm/mlock.c  |  9 +--------
>  mm/swap.c   | 33 +++++++--------------------------
>  mm/vmscan.c |  8 +-------
>  3 files changed, 9 insertions(+), 41 deletions(-)
>
> diff --git a/mm/mlock.c b/mm/mlock.c
> index cb23a0c2cfbf..4f40fc091cf9 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -289,17 +289,10 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
>         /* Phase 1: page isolation */
>         for (i = 0; i < nr; i++) {
>                 struct page *page = pvec->pages[i];
> -               struct lruvec *new_lruvec;
>                 bool clearlru;
>
>                 clearlru = TestClearPageLRU(page);
> -
> -               new_lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
> -               if (new_lruvec != lruvec) {
> -                       if (lruvec)
> -                               unlock_page_lruvec_irq(lruvec);
> -                       lruvec = lock_page_lruvec_irq(page);
> -               }
> +               lruvec = relock_page_lruvec_irq(page, lruvec);
>
>                 if (!TestClearPageMlocked(page)) {
>                         delta_munlocked++;
> diff --git a/mm/swap.c b/mm/swap.c
> index 129c532357a4..9fb906fbaed5 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -209,19 +209,12 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
>
>         for (i = 0; i < pagevec_count(pvec); i++) {
>                 struct page *page = pvec->pages[i];
> -               struct lruvec *new_lruvec;
> -
> -               new_lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
> -               if (lruvec != new_lruvec) {
> -                       if (lruvec)
> -                               unlock_page_lruvec_irqrestore(lruvec, flags);
> -                       lruvec = lock_page_lruvec_irqsave(page, &flags);
> -               }
>
>                 /* block memcg migration during page moving between lru */
>                 if (!TestClearPageLRU(page))
>                         continue;
>
> +               lruvec = relock_page_lruvec_irqsave(page, lruvec, &flags);
>                 (*move_fn)(page, lruvec);
>
>                 SetPageLRU(page);

So looking at this I realize that patch 18 probably should have
ordered this the same way with the TestClearPageLRU happening before
you fetched the new_lruvec. Otherwise I think you are potentially
exposed to the original issue you were fixing the the previous patch
that added the call to TestClearPageLRU.

> @@ -866,17 +859,12 @@ void release_pages(struct page **pages, int nr)
>                 }
>
>                 if (PageLRU(page)) {
> -                       struct lruvec *new_lruvec;
> -
> -                       new_lruvec = mem_cgroup_page_lruvec(page,
> -                                                       page_pgdat(page));
> -                       if (new_lruvec != lruvec) {
> -                               if (lruvec)
> -                                       unlock_page_lruvec_irqrestore(lruvec,
> -                                                                       flags);
> +                       struct lruvec *pre_lruvec = lruvec;
> +
> +                       lruvec = relock_page_lruvec_irqsave(page, lruvec,
> +                                                                       &flags);
> +                       if (pre_lruvec != lruvec)

So this doesn't really read right. I suppose "pre_lruvec" should
probably be "prev_lruvec" since I assume you mean "previous" not
"before".

>                                 lock_batch = 0;
> -                               lruvec = lock_page_lruvec_irqsave(page, &flags);
> -                       }
>
>                         __ClearPageLRU(page);
>                         del_page_from_lru_list(page, lruvec, page_off_lru(page));
> @@ -982,15 +970,8 @@ void __pagevec_lru_add(struct pagevec *pvec)
>
>         for (i = 0; i < pagevec_count(pvec); i++) {
>                 struct page *page = pvec->pages[i];
> -               struct lruvec *new_lruvec;
> -
> -               new_lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
> -               if (lruvec != new_lruvec) {
> -                       if (lruvec)
> -                               unlock_page_lruvec_irqrestore(lruvec, flags);
> -                       lruvec = lock_page_lruvec_irqsave(page, &flags);
> -               }
>
> +               lruvec = relock_page_lruvec_irqsave(page, lruvec, &flags);
>                 __pagevec_lru_add_fn(page, lruvec);
>         }
>         if (lruvec)
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 168c1659e430..bdb53a678e7e 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4292,15 +4292,9 @@ void check_move_unevictable_pages(struct pagevec *pvec)
>
>         for (i = 0; i < pvec->nr; i++) {
>                 struct page *page = pvec->pages[i];
> -               struct lruvec *new_lruvec;
>
>                 pgscanned++;
> -               new_lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
> -               if (lruvec != new_lruvec) {
> -                       if (lruvec)
> -                               unlock_page_lruvec_irq(lruvec);
> -                       lruvec = lock_page_lruvec_irq(page);
> -               }
> +               lruvec = relock_page_lruvec_irq(page, lruvec);
>
>                 if (!PageLRU(page) || !PageUnevictable(page))
>                         continue;
> --
> 1.8.3.1
>
>

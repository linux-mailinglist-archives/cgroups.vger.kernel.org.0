Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D122245EF
	for <lists+cgroups@lfdr.de>; Fri, 17 Jul 2020 23:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgGQVo0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Jul 2020 17:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgGQVoZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Jul 2020 17:44:25 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760C2C0619D2;
        Fri, 17 Jul 2020 14:44:25 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id c16so11900639ioi.9;
        Fri, 17 Jul 2020 14:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Fd/5SIkVrVFZzPalYHXNTeKn+0gi9vnLo7/Yumj5M4=;
        b=bcKAE/Sf81eYZEfhBovzR8YAPYCTd4vV1lqFR9E9VoqmGNHRnfUkMDAduGb0PP8akQ
         sIlW/+OfHMBXiZosoLVNWKKIhZZ+lSCoSeecneDWd8o2XW60vFhgV379Zig5PvG5Uvwn
         FAYEykMn7Cm93tftDLUKMQicxkX74eQRjmgM+AJ0MfgC4qRz8mo8L379FYPq2kj/A3LY
         5EN8Cd8nRrLOiv6jwB1tAF8zlfSlmVAnyIzMIcrpfqZuoq0PMB4kH5NSnWFLfH+Z1Ik+
         fwM3jQYeDSTd8sllNRP5CAS3ccrRCFCNWwFvuh5/3k1slHFI8SbPsLoF4evxU2nHbRUH
         H1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Fd/5SIkVrVFZzPalYHXNTeKn+0gi9vnLo7/Yumj5M4=;
        b=Zbl2IE39+mC177PnqKt0zrZ8Q7rroY668P5hgJUTP3znsLYC56hMSxIImzw1f0qOCH
         fhSnwJcbUvKlGQhL4baOY04ONShOXlqJoX3t5d9h0xcDj9CHY7oPnAdGw7ayKPniBwC8
         ooBvieldsgf4TVOKPbToAiyg+g5JiAyQL0SdJWNdA5kT1tVpY9wzGtSszeuW6j0CsEnt
         L7d4ralzTdutU6yo/wJkoPNOJhLtOzWWyEu3vpFxuljTKLVUuWKI3Ad2Vy99bZnv1Y5n
         t1YSihWoND0MWqdBpPyIumMoy+jQA6I1fC4VM0E405g8dLxb5kK4G/kqMFWjQhw5Bi1/
         ViHA==
X-Gm-Message-State: AOAM532gnhzvSVCBXX38nPXffrR5/0F3Bp1IActqylcmhXZnSzUmZpml
        gKTX6TKtWrAvmIu1ogrX1ktP3R6OBDu96nTgWuc=
X-Google-Smtp-Source: ABdhPJytlgpn/i7PanH2EvX0H9E4zJ9p4z24bWhVnwVUVfqICVJrTSEyZxNvXpQlM77e59f7BvJaOv+pSzbqk/edfC4=
X-Received: by 2002:a6b:2b12:: with SMTP id r18mr11208398ior.88.1595022264835;
 Fri, 17 Jul 2020 14:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com> <1594429136-20002-21-git-send-email-alex.shi@linux.alibaba.com>
In-Reply-To: <1594429136-20002-21-git-send-email-alex.shi@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Fri, 17 Jul 2020 14:44:14 -0700
Message-ID: <CAKgT0Ufp2FsJd+Lz9U2c_w5Eeb121xRg4SJ5Xoj2=9qZnVKkrA@mail.gmail.com>
Subject: Re: [PATCH v16 20/22] mm/vmscan: use relock for move_pages_to_lru
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
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jul 10, 2020 at 5:59 PM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>
> From: Hugh Dickins <hughd@google.com>
>
> Use the relock function to replace relocking action. And try to save few
> lock times.
>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: cgroups@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
>  mm/vmscan.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index bdb53a678e7e..078a1640ec60 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1854,15 +1854,15 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>         enum lru_list lru;
>
>         while (!list_empty(list)) {
> -               struct lruvec *new_lruvec = NULL;
> -
>                 page = lru_to_page(list);
>                 VM_BUG_ON_PAGE(PageLRU(page), page);
>                 list_del(&page->lru);
>                 if (unlikely(!page_evictable(page))) {
> -                       spin_unlock_irq(&lruvec->lru_lock);
> +                       if (lruvec) {
> +                               spin_unlock_irq(&lruvec->lru_lock);
> +                               lruvec = NULL;
> +                       }
>                         putback_lru_page(page);
> -                       spin_lock_irq(&lruvec->lru_lock);
>                         continue;
>                 }
>
> @@ -1876,12 +1876,7 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>                  *                                        list_add(&page->lru,)
>                  *     list_add(&page->lru,) //corrupt
>                  */
> -               new_lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
> -               if (new_lruvec != lruvec) {
> -                       if (lruvec)
> -                               spin_unlock_irq(&lruvec->lru_lock);
> -                       lruvec = lock_page_lruvec_irq(page);
> -               }
> +               lruvec = relock_page_lruvec_irq(page, lruvec);
>                 SetPageLRU(page);
>
>                 if (unlikely(put_page_testzero(page))) {
> @@ -1890,8 +1885,8 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>
>                         if (unlikely(PageCompound(page))) {
>                                 spin_unlock_irq(&lruvec->lru_lock);
> +                               lruvec = NULL;
>                                 destroy_compound_page(page);
> -                               spin_lock_irq(&lruvec->lru_lock);
>                         } else
>                                 list_add(&page->lru, &pages_to_free);
>

It seems like this should just be rolled into patch 19. Otherwise if
you are wanting to consider it as a "further optimization" type patch
you might pull some of the optimizations you were pushing in patch 18
into this patch as well and just call it out as adding relocks where
there previously were none.

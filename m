Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3994F2323C2
	for <lists+cgroups@lfdr.de>; Wed, 29 Jul 2020 19:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgG2RwO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Jul 2020 13:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgG2RwN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Jul 2020 13:52:13 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CA8C061794;
        Wed, 29 Jul 2020 10:52:13 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id v6so10213540iow.11;
        Wed, 29 Jul 2020 10:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VBlR6JvMKpFF4I6cEiozKbbb6b38RhwCuKSXFCxjOBY=;
        b=BbAS+8cKgeQXImpsn8VUTIj5E9jS7pOeOZZuJs7yJcBS3WYt4zxTCXJncgw9qrRlKZ
         JSEao8c1IRX7/KzDmjLH1TZkcv9XjoBA5hZNqnzhpmh7J1fbNQB9iaZY+vuk6kaVu2o1
         D6w18a83AFD7Qea2KzU0Z4CfRQrwxMEAoxO0pU+iGD7Khq+imB/4kFtt+Cro8gVrfer6
         PxXgXA/ElnRARXP39gBsugGIMwsIUcmfeTxCqavE0tWKC+RTdTO07VvLaWAj2brGnxTh
         mbGLFtEii9t0scIc1deLu+4xGFiwO86SGDUVoq68nY9E9bPs+NOmcwbuhimgb8dROhlP
         or8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VBlR6JvMKpFF4I6cEiozKbbb6b38RhwCuKSXFCxjOBY=;
        b=NmLxsBf9E3s3S8rZI08/9VRNfFj6zyREjLt49uLg+KBTSImqL8gXWScO3vUZIqfdAE
         AAVHSSfm6sINMkV10evEDIZ444ktIVtxfjZUdjePjJ2SVs8sxwCYyXoHWWKocnvd4KmB
         OBj/Tv4pNK0AGGcTmQRNDRyMLqKv2UaSByWNQjU1KgTWFdJrfb5Eelpl7Jh2EuoKf02U
         qVYI2QsnEMSsKwm/YEUAI+aazsnWapPVEJHs88m/h3FzimM3f1uCMPAG5E/mUmloEulD
         2Dwg36YX+ZUWW65a3cwk7Dt5OL3WFkzyb08z/xkwGNo9UV2eYanGgHafyQZQZy/HL9NG
         2j9w==
X-Gm-Message-State: AOAM532W8XqFIETg4v5bRedsBMZh5UMDVHFzImA7jXD33aXBHyJRAaPT
        u+kZW7FTKq44GLyB8CcU44xUCUwlfqREAhEb1cY=
X-Google-Smtp-Source: ABdhPJy8ptUMPnNeTVvk544sb5TR8r+665OH7AZPqT7XUIQPGpVqzSqTZzmSG8WdDR+0ut5GmJTS9yod0augP8gi5tw=
X-Received: by 2002:a02:c842:: with SMTP id r2mr39394965jao.87.1596045133015;
 Wed, 29 Jul 2020 10:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com> <1595681998-19193-19-git-send-email-alex.shi@linux.alibaba.com>
In-Reply-To: <1595681998-19193-19-git-send-email-alex.shi@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 29 Jul 2020 10:52:01 -0700
Message-ID: <CAKgT0UdFDcz=CQ+6mzcjh-apwy3UyPqAuOozvYr+2PSCNQrENA@mail.gmail.com>
Subject: Re: [PATCH v17 18/21] mm/lru: introduce the relock_page_lruvec function
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
        Rong Chen <rong.a.chen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jul 25, 2020 at 6:00 AM Alex Shi <alex.shi@linux.alibaba.com> wrote:
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
>  include/linux/memcontrol.h | 40 ++++++++++++++++++++++++++++++++++++++++
>  mm/mlock.c                 |  9 +--------
>  mm/swap.c                  | 33 +++++++--------------------------
>  mm/vmscan.c                |  8 +-------
>  4 files changed, 49 insertions(+), 41 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 258901021c6c..6e670f991b42 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1313,6 +1313,46 @@ static inline void unlock_page_lruvec_irqrestore(struct lruvec *lruvec,
>         spin_unlock_irqrestore(&lruvec->lru_lock, flags);
>  }
>
> +/* Don't lock again iff page's lruvec locked */
> +static inline struct lruvec *relock_page_lruvec_irq(struct page *page,
> +               struct lruvec *locked_lruvec)
> +{
> +       struct pglist_data *pgdat = page_pgdat(page);
> +       bool locked;
> +
> +       rcu_read_lock();
> +       locked = mem_cgroup_page_lruvec(page, pgdat) == locked_lruvec;
> +       rcu_read_unlock();
> +
> +       if (locked)
> +               return locked_lruvec;
> +
> +       if (locked_lruvec)
> +               unlock_page_lruvec_irq(locked_lruvec);
> +
> +       return lock_page_lruvec_irq(page);
> +}
> +
> +/* Don't lock again iff page's lruvec locked */
> +static inline struct lruvec *relock_page_lruvec_irqsave(struct page *page,
> +               struct lruvec *locked_lruvec, unsigned long *flags)
> +{
> +       struct pglist_data *pgdat = page_pgdat(page);
> +       bool locked;
> +
> +       rcu_read_lock();
> +       locked = mem_cgroup_page_lruvec(page, pgdat) == locked_lruvec;
> +       rcu_read_unlock();
> +
> +       if (locked)
> +               return locked_lruvec;
> +
> +       if (locked_lruvec)
> +               unlock_page_lruvec_irqrestore(locked_lruvec, *flags);
> +
> +       return lock_page_lruvec_irqsave(page, flags);
> +}
> +

So looking these over they seem to be pretty inefficient for what they
do. Basically in worst case (locked_lruvec == NULL) you end up calling
mem_cgoup_page_lruvec and all the rcu_read_lock/unlock a couple times
for a single page. It might make more sense to structure this like:
if (locked_lruvec) {
    if (lruvec_holds_page_lru_lock(page, locked_lruvec))
        return locked_lruvec;

    unlock_page_lruvec_irqrestore(locked_lruvec, *flags);
}
return lock_page_lruvec_irqsave(page, flags);

The other piece that has me scratching my head is that I wonder if we
couldn't do this without needing the rcu_read_lock. For example, what
if we were to compare the page mem_cgroup pointer to the memcg back
pointer stored in the mem_cgroup_per_node? It seems like ordering
things this way would significantly reduce the overhead due to the
pointer chasing to see if the page is in the locked lruvec or not.

>  #ifdef CONFIG_CGROUP_WRITEBACK
>
>  struct wb_domain *mem_cgroup_wb_domain(struct bdi_writeback *wb);
> diff --git a/mm/mlock.c b/mm/mlock.c
> index 5d40d259a931..bc2fb3bfbe7a 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -303,17 +303,10 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
>         /* Phase 1: page isolation */
>         for (i = 0; i < nr; i++) {
>                 struct page *page = pvec->pages[i];
> -               struct lruvec *new_lruvec;
>
>                 /* block memcg change in mem_cgroup_move_account */
>                 lock_page_memcg(page);
> -               new_lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
> -               if (new_lruvec != lruvec) {
> -                       if (lruvec)
> -                               unlock_page_lruvec_irq(lruvec);
> -                       lruvec = lock_page_lruvec_irq(page);
> -               }
> -
> +               lruvec = relock_page_lruvec_irq(page, lruvec);
>                 if (TestClearPageMlocked(page)) {
>                         /*
>                          * We already have pin from follow_page_mask()
> diff --git a/mm/swap.c b/mm/swap.c
> index 09edac441eb6..6d9c7288f7de 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -209,19 +209,12 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
>
>         for (i = 0; i < pagevec_count(pvec); i++) {
>                 struct page *page = pvec->pages[i];
> -               struct lruvec *new_lruvec;
>
>                 /* block memcg migration during page moving between lru */
>                 if (!TestClearPageLRU(page))
>                         continue;
>
> -               new_lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
> -               if (lruvec != new_lruvec) {
> -                       if (lruvec)
> -                               unlock_page_lruvec_irqrestore(lruvec, flags);
> -                       lruvec = lock_page_lruvec_irqsave(page, &flags);
> -               }
> -
> +               lruvec = relock_page_lruvec_irqsave(page, lruvec, &flags);
>                 (*move_fn)(page, lruvec);
>
>                 SetPageLRU(page);
> @@ -864,17 +857,12 @@ void release_pages(struct page **pages, int nr)
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
> +                       struct lruvec *prev_lruvec = lruvec;
> +
> +                       lruvec = relock_page_lruvec_irqsave(page, lruvec,
> +                                                                       &flags);
> +                       if (prev_lruvec != lruvec)
>                                 lock_batch = 0;
> -                               lruvec = lock_page_lruvec_irqsave(page, &flags);
> -                       }
>
>                         __ClearPageLRU(page);
>                         del_page_from_lru_list(page, lruvec, page_off_lru(page));
> @@ -980,15 +968,8 @@ void __pagevec_lru_add(struct pagevec *pvec)
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

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2CE810451C
	for <lists+cgroups@lfdr.de>; Wed, 20 Nov 2019 21:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfKTUbT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Nov 2019 15:31:19 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46453 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfKTUbS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 Nov 2019 15:31:18 -0500
Received: by mail-ot1-f67.google.com with SMTP id n23so766951otr.13
        for <cgroups@vger.kernel.org>; Wed, 20 Nov 2019 12:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X0OJlrE1+QWweEuUz4AgcmM1aRkJ3jzARcx8RAKzako=;
        b=Ndx+KB7ZegK50h/NfgU1MvvbeXvK+rBt7ZlcjI7yrX0ZtgUI4xMUEz0g28oiBqwKz4
         bMHCJt/GNyOtwHLvcbCcjg5n9CjED1vPicfZUApcTkh1khkj3/Z5Acg9/bWhguiI120y
         AZ6ZHSf37WjRPFpchCpjweiHxvM5Axo4BKZkxRc0XOyd6hFVwOHXZspQkH24AQeFB0XM
         oMhKEr9VUNDJ0KgPnhKGJ3sjlFM/6ap+Be2GvdR2SS6k5BIXlInEdgZ1zqPswFVpzKNP
         HsL66tyP4lnnXcDbfExxp0xAdFK7wI2htk8CoNyPPs4SCJAxp5xU453xMu2Wst8UxANm
         8IOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X0OJlrE1+QWweEuUz4AgcmM1aRkJ3jzARcx8RAKzako=;
        b=n/05w/DzjhncTFNmiTgBdk1988vpOXIMwK+AgbNASZa7jNgEOiZkBNUwFentl/Efqk
         SHWtCxmyjlIQHjwKmEC1JHxeUrWD6Rlij3EChx9jwpmnIiEz1nSIZ+vu3eApOnIZ+GZH
         09mQGVFYD9mai+6cu09vlhhjKYcdDeqC/D3uU6TVKraIk5KvVVJz+zO9D194PM60Tu49
         zRyBSf/QUs9LsuB3vMTZlsdEF1WTbbpNPHg3TXuDBo8qmaujeG7fwFsSVXjgeCBbdFSX
         w0fMa8pxR+MYOA042Sur3ILjqo9fPPNtXs0Yt0frA0eMuTi7v5pdNtUo3a1Kt7dp7bSI
         g3Ww==
X-Gm-Message-State: APjAAAXXbB7zWv4Pk5rkqNnYpluBRlrbZFbPLKB1+XBy1wBTlIEgU0+8
        kNe+sf6w4+jKnHVNO7Gm2t+MCXwNDBv1+JivRSMNKA==
X-Google-Smtp-Source: APXvYqwiYKOOSWpVVXytuqOsyQflF6bdTH/D0YvMbj51WkAyl1Fpk/U5BuI9+35sSwou2eNGm6DbA2vGsnSdYHlnK/M=
X-Received: by 2002:a9d:66d9:: with SMTP id t25mr3790472otm.30.1574281876983;
 Wed, 20 Nov 2019 12:31:16 -0800 (PST)
MIME-Version: 1.0
References: <20191120165847.423540-1-hannes@cmpxchg.org>
In-Reply-To: <20191120165847.423540-1-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 20 Nov 2019 12:31:06 -0800
Message-ID: <CALvZod50AanTCNkTVSptU+Hg--69j6OuKdc04UPs4Vf64DkGiw@mail.gmail.com>
Subject: Re: [PATCH] mm: fix unsafe page -> lruvec lookups with cgroup charge migration
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 20, 2019 at 8:58 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> While reviewing the "per lruvec lru_lock for memcg" series, Hugh and I
> noticed two places in the existing code where the page -> memcg ->
> lruvec lookup can result in a use-after-free bug. This affects cgroup1
> setups that have charge migration enabled.
>
> To pin page->mem_cgroup, callers need to either have the page locked,
> an exclusive refcount (0), or hold the lru_lock and "own" PageLRU
> (either ensure it's set, or be the one to hold the page in isolation)
> to make cgroup migration fail the isolation step.

I think we should add the above para in the comments for better visibility.

> Failure to follow
> this can result in the page moving out of the memcg and freeing it,
> along with its lruvecs, while the observer is dereferencing them.
>
> 1. isolate_lru_page() calls mem_cgroup_page_lruvec() with the lru_lock
> held but before testing PageLRU. It doesn't dereference the returned
> lruvec before testing PageLRU, giving the impression that it might
> just be safe ordering after all - but mem_cgroup_page_lruvec() itself
> touches the lruvec to lazily initialize the pgdat back pointer. This
> one is easy to fix, just move the lookup into the PageLRU branch.
>
> 2. pagevec_lru_move_fn() conveniently looks up the lruvec for all the
> callbacks it might get invoked on. Unfortunately, it's the callbacks
> that first check PageLRU under the lru_lock, which makes this order
> equally unsafe as isolate_lru_page(). Remove the lruvec argument from
> the move callbacks and let them do it inside their PageLRU branches.
>
> Reported-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> ---
>  mm/swap.c   | 48 +++++++++++++++++++++++++++++-------------------
>  mm/vmscan.c |  8 ++++----
>  2 files changed, 33 insertions(+), 23 deletions(-)
>
> diff --git a/mm/swap.c b/mm/swap.c
> index 5341ae93861f..6b015e9532fb 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -188,12 +188,11 @@ int get_kernel_page(unsigned long start, int write, struct page **pages)
>  EXPORT_SYMBOL_GPL(get_kernel_page);
>
>  static void pagevec_lru_move_fn(struct pagevec *pvec,
> -       void (*move_fn)(struct page *page, struct lruvec *lruvec, void *arg),
> +       void (*move_fn)(struct page *page, void *arg),
>         void *arg)
>  {
>         int i;
>         struct pglist_data *pgdat = NULL;
> -       struct lruvec *lruvec;
>         unsigned long flags = 0;
>
>         for (i = 0; i < pagevec_count(pvec); i++) {
> @@ -207,8 +206,7 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
>                         spin_lock_irqsave(&pgdat->lru_lock, flags);
>                 }
>
> -               lruvec = mem_cgroup_page_lruvec(page, pgdat);
> -               (*move_fn)(page, lruvec, arg);
> +               (*move_fn)(page, arg);
>         }
>         if (pgdat)
>                 spin_unlock_irqrestore(&pgdat->lru_lock, flags);
> @@ -216,12 +214,14 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
>         pagevec_reinit(pvec);
>  }
>
> -static void pagevec_move_tail_fn(struct page *page, struct lruvec *lruvec,
> -                                void *arg)
> +static void pagevec_move_tail_fn(struct page *page, void *arg)
>  {
>         int *pgmoved = arg;
>
>         if (PageLRU(page) && !PageUnevictable(page)) {
> +               struct lruvec *lruvec;
> +
> +               lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
>                 del_page_from_lru_list(page, lruvec, page_lru(page));
>                 ClearPageActive(page);
>                 add_page_to_lru_list_tail(page, lruvec, page_lru(page));
> @@ -272,12 +272,14 @@ static void update_page_reclaim_stat(struct lruvec *lruvec,
>                 reclaim_stat->recent_rotated[file]++;
>  }
>
> -static void __activate_page(struct page *page, struct lruvec *lruvec,
> -                           void *arg)
> +static void __activate_page(struct page *page, void *arg)
>  {
>         if (PageLRU(page) && !PageActive(page) && !PageUnevictable(page)) {
>                 int file = page_is_file_cache(page);
>                 int lru = page_lru_base_type(page);
> +               struct lruvec *lruvec;
> +
> +               lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
>
>                 del_page_from_lru_list(page, lruvec, lru);
>                 SetPageActive(page);
> @@ -328,7 +330,7 @@ void activate_page(struct page *page)
>
>         page = compound_head(page);
>         spin_lock_irq(&pgdat->lru_lock);
> -       __activate_page(page, mem_cgroup_page_lruvec(page, pgdat), NULL);
> +       __activate_page(page, NULL);
>         spin_unlock_irq(&pgdat->lru_lock);
>  }
>  #endif
> @@ -498,9 +500,9 @@ void lru_cache_add_active_or_unevictable(struct page *page,
>   * be write it out by flusher threads as this is much more effective
>   * than the single-page writeout from reclaim.
>   */
> -static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
> -                             void *arg)
> +static void lru_deactivate_file_fn(struct page *page, void *arg)
>  {
> +       struct lruvec *lruvec;
>         int lru, file;
>         bool active;
>
> @@ -518,6 +520,8 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
>         file = page_is_file_cache(page);
>         lru = page_lru_base_type(page);
>
> +       lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
> +
>         del_page_from_lru_list(page, lruvec, lru + active);
>         ClearPageActive(page);
>         ClearPageReferenced(page);
> @@ -544,12 +548,14 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
>         update_page_reclaim_stat(lruvec, file, 0);
>  }
>
> -static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec,
> -                           void *arg)
> +static void lru_deactivate_fn(struct page *page, void *arg)
>  {
>         if (PageLRU(page) && PageActive(page) && !PageUnevictable(page)) {
>                 int file = page_is_file_cache(page);
>                 int lru = page_lru_base_type(page);
> +               struct lruvec *lruvec;
> +
> +               lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
>
>                 del_page_from_lru_list(page, lruvec, lru + LRU_ACTIVE);
>                 ClearPageActive(page);
> @@ -561,12 +567,14 @@ static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec,
>         }
>  }
>
> -static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec,
> -                           void *arg)
> +static void lru_lazyfree_fn(struct page *page, void *arg)
>  {
>         if (PageLRU(page) && PageAnon(page) && PageSwapBacked(page) &&
>             !PageSwapCache(page) && !PageUnevictable(page)) {
>                 bool active = PageActive(page);
> +               struct lruvec *lruvec;
> +
> +               lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
>
>                 del_page_from_lru_list(page, lruvec,
>                                        LRU_INACTIVE_ANON + active);
> @@ -921,15 +929,17 @@ void lru_add_page_tail(struct page *page, struct page *page_tail,
>  }
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>
> -static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
> -                                void *arg)
> +static void __pagevec_lru_add_fn(struct page *page, void *arg)
>  {
> -       enum lru_list lru;
>         int was_unevictable = TestClearPageUnevictable(page);
> +       struct lruvec *lruvec;
> +       enum lru_list lru;
>
>         VM_BUG_ON_PAGE(PageLRU(page), page);
> -
>         SetPageLRU(page);
> +
> +       lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
> +
>         /*
>          * Page becomes evictable in two ways:
>          * 1) Within LRU lock [munlock_vma_page() and __munlock_pagevec()].
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index df859b1d583c..3c8b81990146 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1767,15 +1767,15 @@ int isolate_lru_page(struct page *page)
>
>         if (PageLRU(page)) {
>                 pg_data_t *pgdat = page_pgdat(page);
> -               struct lruvec *lruvec;
>
>                 spin_lock_irq(&pgdat->lru_lock);
> -               lruvec = mem_cgroup_page_lruvec(page, pgdat);
>                 if (PageLRU(page)) {
> -                       int lru = page_lru(page);
> +                       struct lruvec *lruvec;
> +
> +                       lruvec = mem_cgroup_page_lruvec(page, pgdat);
>                         get_page(page);
>                         ClearPageLRU(page);
> -                       del_page_from_lru_list(page, lruvec, lru);
> +                       del_page_from_lru_list(page, lruvec, page_lru(page));
>                         ret = 0;
>                 }
>                 spin_unlock_irq(&pgdat->lru_lock);
> --
> 2.24.0
>

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A402FEB0E
	for <lists+cgroups@lfdr.de>; Sat, 16 Nov 2019 08:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfKPHD4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 16 Nov 2019 02:03:56 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40060 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfKPHD4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 16 Nov 2019 02:03:56 -0500
Received: by mail-oi1-f196.google.com with SMTP id d22so3779178oic.7
        for <cgroups@vger.kernel.org>; Fri, 15 Nov 2019 23:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/DU5oXgtd6RF3Yu++lbinIz05uCr/pqBeBR3jhx9WN8=;
        b=MRz7jgVnkON5+p1QnnS9kdO4qIDx7gRT67zPZ+80E7K+8Zl50hBAlfIWK9akzPmqX7
         gqHg8Ioy3acN4WZAaiyOTwzhAm2wEa37CndsjGPisp8FP5sfvmYMKRk6LYd82JXfgYK2
         XkYR2eBR5unPQIYZkWKb+F2MpmPOVFs/X0oBD2nRI9uxYtF1CyABqKUHJxEbal7tDPV/
         +BHZck3r/DWGiViTnrVXPr8reXWaMNvwFVv6dzxqTU//EUmRo+WKsxY6YNMQIUdWww0G
         wm+qtMjj3ESoKb9Wq0vJkqcp5fuFAxHnVwRx1Fl4l5PnmxkGdy81MVmHTdJq5u6yqDp1
         WBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/DU5oXgtd6RF3Yu++lbinIz05uCr/pqBeBR3jhx9WN8=;
        b=DsOGfvhev0k16pxazzswm51DlrsJC/Yqw23xCxl9n+BgNSCxkCVtOCotZWMpzLYymj
         CB1LBVKAbxjp87m9nDENcIWNgYs7EnQ2x1h6KoRJXYocAn2eMrEfWyXwNc9e2ie+frNO
         SII+r5jwapuvq//x0YRUwuuCt/VV/iHEFDUpjBdNOMHpH0RTHnpLv7ogRRrOmFyenoUw
         umEoihT7ef6uXFDmN6Y9GNS8R7wG7YLCzd7+9cAAInCPt2/mhJOeYqE/JBP9f5aZfZqK
         c/boG+9sBd9VEM96J120FGxG7zUkjdXv4kc4TiI1f/yVpOwfKjlxaTJnKJdSbhVFI6T4
         8cRQ==
X-Gm-Message-State: APjAAAXNPOkjFvNoUkxPOwx1ir8AnLfLqM4zacDqz6wymzX8z6BN+FLn
        xIBcZapjZP9YaUK6iEGFcOk5RMuAA9xIYiE1c2ZVRQ==
X-Google-Smtp-Source: APXvYqxJGj0CffH3qdiRGTgE3mBgrh5F9xEzZGwmUR7CrkmaOKjbzOkyU1fGFOTTIkhx/19H+o6TVqB5ynjosB2yFzU=
X-Received: by 2002:aca:f1c5:: with SMTP id p188mr10823124oih.125.1573887834665;
 Fri, 15 Nov 2019 23:03:54 -0800 (PST)
MIME-Version: 1.0
References: <1573874106-23802-1-git-send-email-alex.shi@linux.alibaba.com> <1573874106-23802-4-git-send-email-alex.shi@linux.alibaba.com>
In-Reply-To: <1573874106-23802-4-git-send-email-alex.shi@linux.alibaba.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 15 Nov 2019 23:03:42 -0800
Message-ID: <CALvZod7oUmUCk96ATrRwYvrROFNqL1gPGt7fy949M8TMwCQrWA@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] mm/lru: replace pgdat lru_lock with lruvec lock
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, Qian Cai <cai@lca.pw>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        swkhack <swkhack@gmail.com>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Colin Ian King <colin.king@canonical.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Nov 15, 2019 at 7:15 PM Alex Shi <alex.shi@linux.alibaba.com> wrote=
:
>
> This patchset move lru_lock into lruvec, give a lru_lock for each of
> lruvec, thus bring a lru_lock for each of memcg per node.
>
> This is the main patch to replace per node lru_lock with per memcg
> lruvec lock. It also fold the irqsave flags into lruvec.
>
> We introduce function lock_page_lruvec, it's same as vanilla pgdat lock
> when memory cgroup unset, w/o memcg, the function will keep repin the
> lruvec's lock to guard from page->mem_cgroup changes in page
> migrations between memcgs. (Thanks Hugh Dickins and Konstantin
> Khlebnikov reminder on this. Than the core logical is same as their
> previous patchs)
>
> According to Daniel Jordan's suggestion, I run 64 'dd' with on 32
> containers on my 2s* 8 core * HT box with the modefied case:
>   https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/=
tree/case-lru-file-readtwice
>
> With this and later patches, the dd performance is 144MB/s, the vanilla
> kernel performance is 123MB/s. 17% performance increased.
>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Chris Down <chris@chrisdown.name>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Cc: swkhack <swkhack@gmail.com>
> Cc: "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Colin Ian King <colin.king@canonical.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Nikolay Borisov <nborisov@suse.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
> Cc: Yafang Shao <laoar.shao@gmail.com>
> Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: cgroups@vger.kernel.org
> ---
>  include/linux/memcontrol.h | 23 ++++++++++++++
>  mm/compaction.c            | 62 ++++++++++++++++++++++++------------
>  mm/huge_memory.c           | 16 ++++------
>  mm/memcontrol.c            | 64 +++++++++++++++++++++++++++++--------
>  mm/mlock.c                 | 31 +++++++++---------
>  mm/page_idle.c             |  5 +--
>  mm/swap.c                  | 79 +++++++++++++++++++---------------------=
------
>  mm/vmscan.c                | 58 ++++++++++++++++------------------
>  8 files changed, 201 insertions(+), 137 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 5b86287fa069..0b32eadd0eda 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -418,6 +418,9 @@ static inline struct lruvec *mem_cgroup_lruvec(struct=
 mem_cgroup *memcg,
>
>  struct lruvec *mem_cgroup_page_lruvec(struct page *, struct pglist_data =
*);
>
> +struct lruvec *lock_page_lruvec_irq(struct page *, struct pglist_data *)=
;
> +struct lruvec *lock_page_lruvec_irqsave(struct page *, struct pglist_dat=
a *);
> +
>  struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p);
>
>  struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm);
> @@ -901,6 +904,26 @@ static inline struct lruvec *mem_cgroup_page_lruvec(=
struct page *page,
>         return &pgdat->__lruvec;
>  }
>
> +static inline struct lruvec *lock_page_lruvec_irq(struct page *page,
> +                                               struct pglist_data *pgdat=
)
> +{
> +       struct lruvec *lruvec =3D mem_cgroup_page_lruvec(page, pgdat);
> +
> +       spin_lock_irq(&lruvec->lru_lock);
> +
> +       return lruvec;
> +}
> +
> +static inline struct lruvec *lock_page_lruvec_irqsave(struct page *page,
> +                                               struct pglist_data *pgdat=
)
> +{
> +       struct lruvec *lruvec =3D mem_cgroup_page_lruvec(page, pgdat);
> +
> +       spin_lock_irqsave(&lruvec->lru_lock, lruvec->irqflags);
> +
> +       return lruvec;
> +}
> +
>  static inline bool mm_match_cgroup(struct mm_struct *mm,
>                 struct mem_cgroup *memcg)
>  {
> diff --git a/mm/compaction.c b/mm/compaction.c
> index d20816b21b55..eb1ad30c1bef 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -786,8 +786,7 @@ static bool too_many_isolated(pg_data_t *pgdat)
>         pg_data_t *pgdat =3D cc->zone->zone_pgdat;
>         unsigned long nr_scanned =3D 0, nr_isolated =3D 0;
>         struct lruvec *lruvec;
> -       unsigned long flags =3D 0;
> -       bool locked =3D false;
> +       struct lruvec *locked_lruvec =3D NULL;
>         struct page *page =3D NULL, *valid_page =3D NULL;
>         unsigned long start_pfn =3D low_pfn;
>         bool skip_on_failure =3D false;
> @@ -847,11 +846,21 @@ static bool too_many_isolated(pg_data_t *pgdat)
>                  * contention, to give chance to IRQs. Abort completely i=
f
>                  * a fatal signal is pending.
>                  */
> -               if (!(low_pfn % SWAP_CLUSTER_MAX)
> -                   && compact_unlock_should_abort(&pgdat->lru_lock,
> -                                           flags, &locked, cc)) {
> -                       low_pfn =3D 0;
> -                       goto fatal_pending;
> +               if (!(low_pfn % SWAP_CLUSTER_MAX)) {
> +                       if (locked_lruvec) {
> +                               spin_unlock_irqrestore(&locked_lruvec->lr=
u_lock,
> +                                               locked_lruvec->irqflags);
> +                               locked_lruvec =3D NULL;
> +                       }
> +
> +                       if (fatal_signal_pending(current)) {
> +                               cc->contended =3D true;
> +
> +                               low_pfn =3D 0;
> +                               goto fatal_pending;
> +                       }
> +
> +                       cond_resched();
>                 }
>
>                 if (!pfn_valid_within(low_pfn))
> @@ -920,10 +929,10 @@ static bool too_many_isolated(pg_data_t *pgdat)
>                          */
>                         if (unlikely(__PageMovable(page)) &&
>                                         !PageIsolated(page)) {
> -                               if (locked) {
> -                                       spin_unlock_irqrestore(&pgdat->lr=
u_lock,
> -                                                                       f=
lags);
> -                                       locked =3D false;
> +                               if (locked_lruvec) {
> +                                       spin_unlock_irqrestore(&locked_lr=
uvec->lru_lock,
> +                                                       locked_lruvec->ir=
qflags);
> +                                       locked_lruvec =3D NULL;
>                                 }
>
>                                 if (!isolate_movable_page(page, isolate_m=
ode))
> @@ -949,10 +958,22 @@ static bool too_many_isolated(pg_data_t *pgdat)
>                 if (!(cc->gfp_mask & __GFP_FS) && page_mapping(page))
>                         goto isolate_fail;
>
> +reget_lruvec:
> +               lruvec =3D mem_cgroup_page_lruvec(page, pgdat);
> +
>                 /* If we already hold the lock, we can skip some rechecki=
ng */
> -               if (!locked) {
> -                       locked =3D compact_lock_irqsave(&pgdat->lru_lock,
> -                                                               &flags, c=
c);
> +               if (lruvec !=3D locked_lruvec) {
> +                       if (locked_lruvec) {
> +                               spin_unlock_irqrestore(&locked_lruvec->lr=
u_lock,
> +                                               locked_lruvec->irqflags);
> +                               locked_lruvec =3D NULL;
> +                       }

What guarantees the lifetime of lruvec? You should read the comment on
mem_cgroup_page_lruvec(). Have you seen the patches Hugh had shared?
Please look at the  trylock_page_lruvec().

BTW have you tested Hugh's patches?

> +                       if (compact_lock_irqsave(&lruvec->lru_lock,
> +                                                       &lruvec->irqflags=
, cc))
> +                               locked_lruvec =3D lruvec;
> +
> +                       if (lruvec !=3D mem_cgroup_page_lruvec(page, pgda=
t))
> +                               goto reget_lruvec;
>
>                         /* Try get exclusive access under lock */
>                         if (!skip_updated) {
> @@ -976,7 +997,6 @@ static bool too_many_isolated(pg_data_t *pgdat)
>                         }
>                 }
>
> -               lruvec =3D mem_cgroup_page_lruvec(page, pgdat);
>
>                 /* Try isolate the page */
>                 if (__isolate_lru_page(page, isolate_mode) !=3D 0)
> @@ -1017,9 +1037,10 @@ static bool too_many_isolated(pg_data_t *pgdat)
>                  * page anyway.
>                  */
>                 if (nr_isolated) {
> -                       if (locked) {
> -                               spin_unlock_irqrestore(&pgdat->lru_lock, =
flags);
> -                               locked =3D false;
> +                       if (locked_lruvec) {
> +                               spin_unlock_irqrestore(&locked_lruvec->lr=
u_lock,
> +                                               locked_lruvec->irqflags);
> +                               locked_lruvec =3D NULL;
>                         }
>                         putback_movable_pages(&cc->migratepages);
>                         cc->nr_migratepages =3D 0;
> @@ -1044,8 +1065,9 @@ static bool too_many_isolated(pg_data_t *pgdat)
>                 low_pfn =3D end_pfn;
>
>  isolate_abort:
> -       if (locked)
> -               spin_unlock_irqrestore(&pgdat->lru_lock, flags);
> +       if (locked_lruvec)
> +               spin_unlock_irqrestore(&locked_lruvec->lru_lock,
> +                                               locked_lruvec->irqflags);
>
>         /*
>          * Updated the cached scanner pfn once the pageblock has been sca=
nned
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 13cc93785006..7e8bd6c700d2 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2495,17 +2495,13 @@ static void __split_huge_page_tail(struct page *h=
ead, int tail,
>  }
>
>  static void __split_huge_page(struct page *page, struct list_head *list,
> -               pgoff_t end, unsigned long flags)
> +                       struct lruvec *lruvec, pgoff_t end)
>  {
>         struct page *head =3D compound_head(page);
> -       pg_data_t *pgdat =3D page_pgdat(head);
> -       struct lruvec *lruvec;
>         struct address_space *swap_cache =3D NULL;
>         unsigned long offset =3D 0;
>         int i;
>
> -       lruvec =3D mem_cgroup_page_lruvec(head, pgdat);
> -
>         /* complete memcg works before add pages to LRU */
>         mem_cgroup_split_huge_fixup(head);
>
> @@ -2554,7 +2550,7 @@ static void __split_huge_page(struct page *page, st=
ruct list_head *list,
>                 xa_unlock(&head->mapping->i_pages);
>         }
>
> -       spin_unlock_irqrestore(&pgdat->lru_lock, flags);
> +       spin_unlock_irqrestore(&lruvec->lru_lock, lruvec->irqflags);
>
>         remap_page(head);
>
> @@ -2697,9 +2693,9 @@ int split_huge_page_to_list(struct page *page, stru=
ct list_head *list)
>         struct deferred_split *ds_queue =3D get_deferred_split_queue(page=
);
>         struct anon_vma *anon_vma =3D NULL;
>         struct address_space *mapping =3D NULL;
> +       struct lruvec *lruvec;
>         int count, mapcount, extra_pins, ret;
>         bool mlocked;
> -       unsigned long flags;
>         pgoff_t end;
>
>         VM_BUG_ON_PAGE(is_huge_zero_page(page), page);
> @@ -2766,7 +2762,7 @@ int split_huge_page_to_list(struct page *page, stru=
ct list_head *list)
>                 lru_add_drain();
>
>         /* prevent PageLRU to go away from under us, and freeze lru stats=
 */
> -       spin_lock_irqsave(&pgdata->lru_lock, flags);
> +       lruvec =3D lock_page_lruvec_irqsave(head, pgdata);
>
>         if (mapping) {
>                 XA_STATE(xas, &mapping->i_pages, page_index(head));
> @@ -2797,7 +2793,7 @@ int split_huge_page_to_list(struct page *page, stru=
ct list_head *list)
>                 }
>
>                 spin_unlock(&ds_queue->split_queue_lock);
> -               __split_huge_page(page, list, end, flags);
> +               __split_huge_page(page, list, lruvec, end);
>                 if (PageSwapCache(head)) {
>                         swp_entry_t entry =3D { .val =3D page_private(hea=
d) };
>
> @@ -2816,7 +2812,7 @@ int split_huge_page_to_list(struct page *page, stru=
ct list_head *list)
>                 spin_unlock(&ds_queue->split_queue_lock);
>  fail:          if (mapping)
>                         xa_unlock(&mapping->i_pages);
> -               spin_unlock_irqrestore(&pgdata->lru_lock, flags);
> +               spin_unlock_irqrestore(&lruvec->lru_lock, lruvec->irqflag=
s);
>                 remap_page(head);
>                 ret =3D -EBUSY;
>         }
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 62470325f9bc..cf274739e619 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1246,6 +1246,42 @@ struct lruvec *mem_cgroup_page_lruvec(struct page =
*page, struct pglist_data *pgd
>         return lruvec;
>  }
>
> +struct lruvec *lock_page_lruvec_irq(struct page *page,
> +                                       struct pglist_data *pgdat)
> +{
> +       struct lruvec *lruvec;
> +
> +again:
> +       lruvec =3D mem_cgroup_page_lruvec(page, pgdat);
> +       spin_lock_irq(&lruvec->lru_lock);
> +
> +       /* lruvec may changed in commit_charge() */
> +       if (lruvec !=3D mem_cgroup_page_lruvec(page, pgdat)) {
> +               spin_unlock_irq(&lruvec->lru_lock);
> +               goto again;
> +       }
> +
> +       return lruvec;
> +}
> +
> +struct lruvec *lock_page_lruvec_irqsave(struct page *page,
> +                                       struct pglist_data *pgdat)
> +{
> +       struct lruvec *lruvec;
> +
> +again:
> +       lruvec =3D mem_cgroup_page_lruvec(page, pgdat);
> +       spin_lock_irqsave(&lruvec->lru_lock, lruvec->irqflags);
> +
> +       /* lruvec may changed in commit_charge() */
> +       if (lruvec !=3D mem_cgroup_page_lruvec(page, pgdat)) {
> +               spin_unlock_irqrestore(&lruvec->lru_lock, lruvec->irqflag=
s);
> +               goto again;
> +       }
> +
> +       return lruvec;
> +}
> +
>  /**
>   * mem_cgroup_update_lru_size - account for adding or removing an lru pa=
ge
>   * @lruvec: mem_cgroup per zone lru vector
> @@ -2571,41 +2607,43 @@ static void cancel_charge(struct mem_cgroup *memc=
g, unsigned int nr_pages)
>         css_put_many(&memcg->css, nr_pages);
>  }
>
> -static void lock_page_lru(struct page *page, int *isolated)
> +static struct lruvec *lock_page_lru(struct page *page, int *isolated)
>  {
>         pg_data_t *pgdat =3D page_pgdat(page);
> +       struct lruvec *lruvec =3D lock_page_lruvec_irq(page, pgdat);
>
> -       spin_lock_irq(&pgdat->lru_lock);
>         if (PageLRU(page)) {
> -               struct lruvec *lruvec;
>
> -               lruvec =3D mem_cgroup_page_lruvec(page, pgdat);
>                 ClearPageLRU(page);
>                 del_page_from_lru_list(page, lruvec, page_lru(page));
>                 *isolated =3D 1;
>         } else
>                 *isolated =3D 0;
> +
> +       return lruvec;
>  }
>
> -static void unlock_page_lru(struct page *page, int isolated)
> +static void unlock_page_lru(struct page *page, int isolated,
> +                               struct lruvec *locked_lruvec)
>  {
> -       pg_data_t *pgdat =3D page_pgdat(page);
> +       struct lruvec *lruvec;
>
> -       if (isolated) {
> -               struct lruvec *lruvec;
> +       spin_unlock_irq(&locked_lruvec->lru_lock);
> +       lruvec =3D lock_page_lruvec_irq(page, page_pgdat(page));
>
> -               lruvec =3D mem_cgroup_page_lruvec(page, pgdat);
> +       if (isolated) {
>                 VM_BUG_ON_PAGE(PageLRU(page), page);
>                 SetPageLRU(page);
>                 add_page_to_lru_list(page, lruvec, page_lru(page));
>         }
> -       spin_unlock_irq(&pgdat->lru_lock);
> +       spin_unlock_irq(&lruvec->lru_lock);
>  }
>
>  static void commit_charge(struct page *page, struct mem_cgroup *memcg,
>                           bool lrucare)
>  {
>         int isolated;
> +       struct lruvec *lruvec;
>
>         VM_BUG_ON_PAGE(page->mem_cgroup, page);
>
> @@ -2614,7 +2652,7 @@ static void commit_charge(struct page *page, struct=
 mem_cgroup *memcg,
>          * may already be on some other mem_cgroup's LRU.  Take care of i=
t.
>          */
>         if (lrucare)
> -               lock_page_lru(page, &isolated);
> +               lruvec =3D lock_page_lru(page, &isolated);
>
>         /*
>          * Nobody should be changing or seriously looking at
> @@ -2633,7 +2671,7 @@ static void commit_charge(struct page *page, struct=
 mem_cgroup *memcg,
>         page->mem_cgroup =3D memcg;
>
>         if (lrucare)
> -               unlock_page_lru(page, isolated);
> +               unlock_page_lru(page, isolated, lruvec);
>  }
>
>  #ifdef CONFIG_MEMCG_KMEM
> @@ -2929,7 +2967,7 @@ void __memcg_kmem_uncharge(struct page *page, int o=
rder)
>
>  /*
>   * Because tail pages are not marked as "used", set it. We're under
> - * pgdat->lru_lock and migration entries setup in all page mappings.
> + * pgdat->lruvec.lru_lock and migration entries setup in all page mappin=
gs.
>   */
>  void mem_cgroup_split_huge_fixup(struct page *head)
>  {
> diff --git a/mm/mlock.c b/mm/mlock.c
> index a72c1eeded77..b509b80b8513 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -106,12 +106,10 @@ void mlock_vma_page(struct page *page)
>   * Isolate a page from LRU with optional get_page() pin.
>   * Assumes lru_lock already held and page already pinned.
>   */
> -static bool __munlock_isolate_lru_page(struct page *page, bool getpage)
> +static bool __munlock_isolate_lru_page(struct page *page,
> +                       struct lruvec *lruvec, bool getpage)
>  {
>         if (PageLRU(page)) {
> -               struct lruvec *lruvec;
> -
> -               lruvec =3D mem_cgroup_page_lruvec(page, page_pgdat(page))=
;
>                 if (getpage)
>                         get_page(page);
>                 ClearPageLRU(page);
> @@ -183,6 +181,7 @@ unsigned int munlock_vma_page(struct page *page)
>  {
>         int nr_pages;
>         pg_data_t *pgdat =3D page_pgdat(page);
> +       struct lruvec *lruvec;
>
>         /* For try_to_munlock() and to serialize with page migration */
>         BUG_ON(!PageLocked(page));
> @@ -194,7 +193,7 @@ unsigned int munlock_vma_page(struct page *page)
>          * might otherwise copy PageMlocked to part of the tail pages bef=
ore
>          * we clear it in the head page. It also stabilizes hpage_nr_page=
s().
>          */
> -       spin_lock_irq(&pgdat->lru_lock);
> +       lruvec =3D lock_page_lruvec_irq(page, pgdat);
>
>         if (!TestClearPageMlocked(page)) {
>                 /* Potentially, PTE-mapped THP: do not skip the rest PTEs=
 */
> @@ -205,15 +204,15 @@ unsigned int munlock_vma_page(struct page *page)
>         nr_pages =3D hpage_nr_pages(page);
>         __mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
>
> -       if (__munlock_isolate_lru_page(page, true)) {
> -               spin_unlock_irq(&pgdat->lru_lock);
> +       if (__munlock_isolate_lru_page(page, lruvec, true)) {
> +               spin_unlock_irq(&lruvec->lru_lock);
>                 __munlock_isolated_page(page);
>                 goto out;
>         }
>         __munlock_isolation_failed(page);
>
>  unlock_out:
> -       spin_unlock_irq(&pgdat->lru_lock);
> +       spin_unlock_irq(&lruvec->lru_lock);
>
>  out:
>         return nr_pages - 1;
> @@ -291,28 +290,29 @@ static void __munlock_pagevec(struct pagevec *pvec,=
 struct zone *zone)
>  {
>         int i;
>         int nr =3D pagevec_count(pvec);
> -       int delta_munlocked =3D -nr;
>         struct pagevec pvec_putback;
> +       struct lruvec *lruvec =3D NULL;
>         int pgrescued =3D 0;
>
>         pagevec_init(&pvec_putback);
>
>         /* Phase 1: page isolation */
> -       spin_lock_irq(&zone->zone_pgdat->lru_lock);
>         for (i =3D 0; i < nr; i++) {
>                 struct page *page =3D pvec->pages[i];
>
> +               lruvec =3D lock_page_lruvec_irq(page, page_pgdat(page));
> +
>                 if (TestClearPageMlocked(page)) {
>                         /*
>                          * We already have pin from follow_page_mask()
>                          * so we can spare the get_page() here.
>                          */
> -                       if (__munlock_isolate_lru_page(page, false))
> +                       if (__munlock_isolate_lru_page(page, lruvec, fals=
e)) {
> +                               __mod_zone_page_state(zone, NR_MLOCK,  -1=
);
> +                               spin_unlock_irq(&lruvec->lru_lock);
>                                 continue;
> -                       else
> +                       } else
>                                 __munlock_isolation_failed(page);
> -               } else {
> -                       delta_munlocked++;
>                 }
>
>                 /*
> @@ -323,9 +323,8 @@ static void __munlock_pagevec(struct pagevec *pvec, s=
truct zone *zone)
>                  */
>                 pagevec_add(&pvec_putback, pvec->pages[i]);
>                 pvec->pages[i] =3D NULL;
> +               spin_unlock_irq(&lruvec->lru_lock);
>         }
> -       __mod_zone_page_state(zone, NR_MLOCK, delta_munlocked);
> -       spin_unlock_irq(&zone->zone_pgdat->lru_lock);
>
>         /* Now we can release pins of pages that we are not munlocking */
>         pagevec_release(&pvec_putback);
> diff --git a/mm/page_idle.c b/mm/page_idle.c
> index 295512465065..25f4b1cf3e0f 100644
> --- a/mm/page_idle.c
> +++ b/mm/page_idle.c
> @@ -32,6 +32,7 @@ static struct page *page_idle_get_page(unsigned long pf=
n)
>  {
>         struct page *page;
>         pg_data_t *pgdat;
> +       struct lruvec *lruvec;
>
>         if (!pfn_valid(pfn))
>                 return NULL;
> @@ -42,12 +43,12 @@ static struct page *page_idle_get_page(unsigned long =
pfn)
>                 return NULL;
>
>         pgdat =3D page_pgdat(page);
> -       spin_lock_irq(&pgdat->lru_lock);
> +       lruvec =3D lock_page_lruvec_irq(page, pgdat);
>         if (unlikely(!PageLRU(page))) {
>                 put_page(page);
>                 page =3D NULL;
>         }
> -       spin_unlock_irq(&pgdat->lru_lock);
> +       spin_unlock_irq(&lruvec->lru_lock);
>         return page;
>  }
>
> diff --git a/mm/swap.c b/mm/swap.c
> index 5341ae93861f..60f04cb2b49e 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -62,14 +62,12 @@ static void __page_cache_release(struct page *page)
>         if (PageLRU(page)) {
>                 pg_data_t *pgdat =3D page_pgdat(page);
>                 struct lruvec *lruvec;
> -               unsigned long flags;
>
> -               spin_lock_irqsave(&pgdat->lru_lock, flags);
> -               lruvec =3D mem_cgroup_page_lruvec(page, pgdat);
> +               lruvec =3D lock_page_lruvec_irqsave(page, pgdat);
>                 VM_BUG_ON_PAGE(!PageLRU(page), page);
>                 __ClearPageLRU(page);
>                 del_page_from_lru_list(page, lruvec, page_off_lru(page));
> -               spin_unlock_irqrestore(&pgdat->lru_lock, flags);
> +               spin_unlock_irqrestore(&lruvec->lru_lock, lruvec->irqflag=
s);
>         }
>         __ClearPageWaiters(page);
>  }
> @@ -192,26 +190,17 @@ static void pagevec_lru_move_fn(struct pagevec *pve=
c,
>         void *arg)
>  {
>         int i;
> -       struct pglist_data *pgdat =3D NULL;
> -       struct lruvec *lruvec;
> -       unsigned long flags =3D 0;
> +       struct lruvec *lruvec =3D NULL;
>
>         for (i =3D 0; i < pagevec_count(pvec); i++) {
>                 struct page *page =3D pvec->pages[i];
> -               struct pglist_data *pagepgdat =3D page_pgdat(page);
>
> -               if (pagepgdat !=3D pgdat) {
> -                       if (pgdat)
> -                               spin_unlock_irqrestore(&pgdat->lru_lock, =
flags);
> -                       pgdat =3D pagepgdat;
> -                       spin_lock_irqsave(&pgdat->lru_lock, flags);
> -               }
> +               lruvec =3D lock_page_lruvec_irqsave(page, page_pgdat(page=
));
>
> -               lruvec =3D mem_cgroup_page_lruvec(page, pgdat);
>                 (*move_fn)(page, lruvec, arg);
> +               spin_unlock_irqrestore(&lruvec->lru_lock, lruvec->irqflag=
s);
>         }
> -       if (pgdat)
> -               spin_unlock_irqrestore(&pgdat->lru_lock, flags);
> +
>         release_pages(pvec->pages, pvec->nr);
>         pagevec_reinit(pvec);
>  }
> @@ -325,11 +314,12 @@ static inline void activate_page_drain(int cpu)
>  void activate_page(struct page *page)
>  {
>         pg_data_t *pgdat =3D page_pgdat(page);
> +       struct lruvec *lruvec;
>
>         page =3D compound_head(page);
> -       spin_lock_irq(&pgdat->lru_lock);
> -       __activate_page(page, mem_cgroup_page_lruvec(page, pgdat), NULL);
> -       spin_unlock_irq(&pgdat->lru_lock);
> +       lruvec =3D lock_page_lruvec_irq(page, pgdat);
> +       __activate_page(page, lruvec, NULL);
> +       spin_unlock_irq(&lruvec->lru_lock);
>  }
>  #endif
>
> @@ -780,9 +770,7 @@ void release_pages(struct page **pages, int nr)
>  {
>         int i;
>         LIST_HEAD(pages_to_free);
> -       struct pglist_data *locked_pgdat =3D NULL;
> -       struct lruvec *lruvec;
> -       unsigned long uninitialized_var(flags);
> +       struct lruvec *lruvec =3D NULL;
>         unsigned int uninitialized_var(lock_batch);
>
>         for (i =3D 0; i < nr; i++) {
> @@ -791,21 +779,22 @@ void release_pages(struct page **pages, int nr)
>                 /*
>                  * Make sure the IRQ-safe lock-holding time does not get
>                  * excessive with a continuous string of pages from the
> -                * same pgdat. The lock is held only if pgdat !=3D NULL.
> +                * same lruvec. The lock is held only if lruvec !=3D NULL=
.
>                  */
> -               if (locked_pgdat && ++lock_batch =3D=3D SWAP_CLUSTER_MAX)=
 {
> -                       spin_unlock_irqrestore(&locked_pgdat->lru_lock, f=
lags);
> -                       locked_pgdat =3D NULL;
> +               if (lruvec && ++lock_batch =3D=3D SWAP_CLUSTER_MAX) {
> +                       spin_unlock_irqrestore(&lruvec->lru_lock,
> +                                                       lruvec->irqflags)=
;
> +                       lruvec =3D NULL;
>                 }
>
>                 if (is_huge_zero_page(page))
>                         continue;
>
>                 if (is_zone_device_page(page)) {
> -                       if (locked_pgdat) {
> -                               spin_unlock_irqrestore(&locked_pgdat->lru=
_lock,
> -                                                      flags);
> -                               locked_pgdat =3D NULL;
> +                       if (lruvec) {
> +                               spin_unlock_irqrestore(&lruvec->lru_lock,
> +                                                      lruvec->irqflags);
> +                               lruvec =3D NULL;
>                         }
>                         /*
>                          * ZONE_DEVICE pages that return 'false' from
> @@ -822,27 +811,25 @@ void release_pages(struct page **pages, int nr)
>                         continue;
>
>                 if (PageCompound(page)) {
> -                       if (locked_pgdat) {
> -                               spin_unlock_irqrestore(&locked_pgdat->lru=
_lock, flags);
> -                               locked_pgdat =3D NULL;
> +                       if (lruvec) {
> +                               spin_unlock_irqrestore(&lruvec->lru_lock,
> +                                                               lruvec->i=
rqflags);
> +                               lruvec =3D NULL;
>                         }
>                         __put_compound_page(page);
>                         continue;
>                 }
>
>                 if (PageLRU(page)) {
> -                       struct pglist_data *pgdat =3D page_pgdat(page);
> +                       struct lruvec *new_lruvec =3D mem_cgroup_page_lru=
vec(page, page_pgdat(page));
>
> -                       if (pgdat !=3D locked_pgdat) {
> -                               if (locked_pgdat)
> -                                       spin_unlock_irqrestore(&locked_pg=
dat->lru_lock,
> -                                                                       f=
lags);
> +                       if (new_lruvec !=3D lruvec) {
> +                               if (lruvec)
> +                                       spin_unlock_irqrestore(&lruvec->l=
ru_lock, lruvec->irqflags);
>                                 lock_batch =3D 0;
> -                               locked_pgdat =3D pgdat;
> -                               spin_lock_irqsave(&locked_pgdat->lru_lock=
, flags);
> -                       }
> +                               lruvec =3D lock_page_lruvec_irqsave(page,=
 page_pgdat(page));
>
> -                       lruvec =3D mem_cgroup_page_lruvec(page, locked_pg=
dat);
> +                       }
>                         VM_BUG_ON_PAGE(!PageLRU(page), page);
>                         __ClearPageLRU(page);
>                         del_page_from_lru_list(page, lruvec, page_off_lru=
(page));
> @@ -854,8 +841,8 @@ void release_pages(struct page **pages, int nr)
>
>                 list_add(&page->lru, &pages_to_free);
>         }
> -       if (locked_pgdat)
> -               spin_unlock_irqrestore(&locked_pgdat->lru_lock, flags);
> +       if (lruvec)
> +               spin_unlock_irqrestore(&lruvec->lru_lock, lruvec->irqflag=
s);
>
>         mem_cgroup_uncharge_list(&pages_to_free);
>         free_unref_page_list(&pages_to_free);
> @@ -893,7 +880,7 @@ void lru_add_page_tail(struct page *page, struct page=
 *page_tail,
>         VM_BUG_ON_PAGE(!PageHead(page), page);
>         VM_BUG_ON_PAGE(PageCompound(page_tail), page);
>         VM_BUG_ON_PAGE(PageLRU(page_tail), page);
> -       lockdep_assert_held(&lruvec_pgdat(lruvec)->lru_lock);
> +       lockdep_assert_held(&lruvec->lru_lock);
>
>         if (!list)
>                 SetPageLRU(page_tail);
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index d97985262dda..3cdf343e7a27 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1755,8 +1755,7 @@ int isolate_lru_page(struct page *page)
>                 pg_data_t *pgdat =3D page_pgdat(page);
>                 struct lruvec *lruvec;
>
> -               spin_lock_irq(&pgdat->lru_lock);
> -               lruvec =3D mem_cgroup_page_lruvec(page, pgdat);
> +               lruvec =3D lock_page_lruvec_irq(page, pgdat);
>                 if (PageLRU(page)) {
>                         int lru =3D page_lru(page);
>                         get_page(page);
> @@ -1764,7 +1763,7 @@ int isolate_lru_page(struct page *page)
>                         del_page_from_lru_list(page, lruvec, lru);
>                         ret =3D 0;
>                 }
> -               spin_unlock_irq(&pgdat->lru_lock);
> +               spin_unlock_irq(&lruvec->lru_lock);
>         }
>         return ret;
>  }
> @@ -1829,7 +1828,6 @@ static int too_many_isolated(struct pglist_data *pg=
dat, int file,
>  static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruv=
ec,
>                                                      struct list_head *li=
st)
>  {
> -       struct pglist_data *pgdat =3D lruvec_pgdat(lruvec);
>         int nr_pages, nr_moved =3D 0;
>         LIST_HEAD(pages_to_free);
>         struct page *page;
> @@ -1840,12 +1838,11 @@ static unsigned noinline_for_stack move_pages_to_=
lru(struct lruvec *lruvec,
>                 VM_BUG_ON_PAGE(PageLRU(page), page);
>                 if (unlikely(!page_evictable(page))) {
>                         list_del(&page->lru);
> -                       spin_unlock_irq(&pgdat->lru_lock);
> +                       spin_unlock_irq(&lruvec->lru_lock);
>                         putback_lru_page(page);
> -                       spin_lock_irq(&pgdat->lru_lock);
> +                       spin_lock_irq(&lruvec->lru_lock);
>                         continue;
>                 }
> -               lruvec =3D mem_cgroup_page_lruvec(page, pgdat);
>
>                 SetPageLRU(page);
>                 lru =3D page_lru(page);
> @@ -1860,9 +1857,9 @@ static unsigned noinline_for_stack move_pages_to_lr=
u(struct lruvec *lruvec,
>                         del_page_from_lru_list(page, lruvec, lru);
>
>                         if (unlikely(PageCompound(page))) {
> -                               spin_unlock_irq(&pgdat->lru_lock);
> +                               spin_unlock_irq(&lruvec->lru_lock);
>                                 (*get_compound_page_dtor(page))(page);
> -                               spin_lock_irq(&pgdat->lru_lock);
> +                               spin_lock_irq(&lruvec->lru_lock);
>                         } else
>                                 list_add(&page->lru, &pages_to_free);
>                 } else {
> @@ -1925,7 +1922,7 @@ static int current_may_throttle(void)
>
>         lru_add_drain();
>
> -       spin_lock_irq(&pgdat->lru_lock);
> +       spin_lock_irq(&lruvec->lru_lock);
>
>         nr_taken =3D isolate_lru_pages(nr_to_scan, lruvec, &page_list,
>                                      &nr_scanned, sc, lru);
> @@ -1937,7 +1934,7 @@ static int current_may_throttle(void)
>         if (!cgroup_reclaim(sc))
>                 __count_vm_events(item, nr_scanned);
>         __count_memcg_events(lruvec_memcg(lruvec), item, nr_scanned);
> -       spin_unlock_irq(&pgdat->lru_lock);
> +       spin_unlock_irq(&lruvec->lru_lock);
>
>         if (nr_taken =3D=3D 0)
>                 return 0;
> @@ -1945,7 +1942,7 @@ static int current_may_throttle(void)
>         nr_reclaimed =3D shrink_page_list(&page_list, pgdat, sc, 0,
>                                 &stat, false);
>
> -       spin_lock_irq(&pgdat->lru_lock);
> +       spin_lock_irq(&lruvec->lru_lock);
>
>         item =3D current_is_kswapd() ? PGSTEAL_KSWAPD : PGSTEAL_DIRECT;
>         if (!cgroup_reclaim(sc))
> @@ -1958,7 +1955,7 @@ static int current_may_throttle(void)
>
>         __mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
>
> -       spin_unlock_irq(&pgdat->lru_lock);
> +       spin_unlock_irq(&lruvec->lru_lock);
>
>         mem_cgroup_uncharge_list(&page_list);
>         free_unref_page_list(&page_list);
> @@ -2011,7 +2008,7 @@ static void shrink_active_list(unsigned long nr_to_=
scan,
>
>         lru_add_drain();
>
> -       spin_lock_irq(&pgdat->lru_lock);
> +       spin_lock_irq(&lruvec->lru_lock);
>
>         nr_taken =3D isolate_lru_pages(nr_to_scan, lruvec, &l_hold,
>                                      &nr_scanned, sc, lru);
> @@ -2022,7 +2019,7 @@ static void shrink_active_list(unsigned long nr_to_=
scan,
>         __count_vm_events(PGREFILL, nr_scanned);
>         __count_memcg_events(lruvec_memcg(lruvec), PGREFILL, nr_scanned);
>
> -       spin_unlock_irq(&pgdat->lru_lock);
> +       spin_unlock_irq(&lruvec->lru_lock);
>
>         while (!list_empty(&l_hold)) {
>                 cond_resched();
> @@ -2068,7 +2065,7 @@ static void shrink_active_list(unsigned long nr_to_=
scan,
>         /*
>          * Move pages back to the lru list.
>          */
> -       spin_lock_irq(&pgdat->lru_lock);
> +       spin_lock_irq(&lruvec->lru_lock);
>         /*
>          * Count referenced pages from currently used mappings as rotated=
,
>          * even though only some of them are actually re-activated.  This
> @@ -2086,7 +2083,7 @@ static void shrink_active_list(unsigned long nr_to_=
scan,
>         __count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_deact=
ivate);
>
>         __mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
> -       spin_unlock_irq(&pgdat->lru_lock);
> +       spin_unlock_irq(&lruvec->lru_lock);
>
>         mem_cgroup_uncharge_list(&l_active);
>         free_unref_page_list(&l_active);
> @@ -2371,7 +2368,7 @@ static void get_scan_count(struct lruvec *lruvec, s=
truct scan_control *sc,
>         file  =3D lruvec_lru_size(lruvec, LRU_ACTIVE_FILE, MAX_NR_ZONES) =
+
>                 lruvec_lru_size(lruvec, LRU_INACTIVE_FILE, MAX_NR_ZONES);
>
> -       spin_lock_irq(&pgdat->lru_lock);
> +       spin_lock_irq(&lruvec->lru_lock);
>         if (unlikely(reclaim_stat->recent_scanned[0] > anon / 4)) {
>                 reclaim_stat->recent_scanned[0] /=3D 2;
>                 reclaim_stat->recent_rotated[0] /=3D 2;
> @@ -2392,7 +2389,7 @@ static void get_scan_count(struct lruvec *lruvec, s=
truct scan_control *sc,
>
>         fp =3D file_prio * (reclaim_stat->recent_scanned[1] + 1);
>         fp /=3D reclaim_stat->recent_rotated[1] + 1;
> -       spin_unlock_irq(&pgdat->lru_lock);
> +       spin_unlock_irq(&lruvec->lru_lock);
>
>         fraction[0] =3D ap;
>         fraction[1] =3D fp;
> @@ -4285,24 +4282,25 @@ int page_evictable(struct page *page)
>   */
>  void check_move_unevictable_pages(struct pagevec *pvec)
>  {
> -       struct lruvec *lruvec;
> -       struct pglist_data *pgdat =3D NULL;
> +       struct lruvec *lruvec =3D NULL;
>         int pgscanned =3D 0;
>         int pgrescued =3D 0;
>         int i;
>
>         for (i =3D 0; i < pvec->nr; i++) {
>                 struct page *page =3D pvec->pages[i];
> -               struct pglist_data *pagepgdat =3D page_pgdat(page);
> +               struct pglist_data *pgdat =3D page_pgdat(page);
> +               struct lruvec *new_lruvec =3D mem_cgroup_page_lruvec(page=
, pgdat);
> +
>
>                 pgscanned++;
> -               if (pagepgdat !=3D pgdat) {
> -                       if (pgdat)
> -                               spin_unlock_irq(&pgdat->lru_lock);
> -                       pgdat =3D pagepgdat;
> -                       spin_lock_irq(&pgdat->lru_lock);
> +
> +               if (lruvec !=3D new_lruvec) {
> +                       if (lruvec)
> +                               spin_unlock_irq(&lruvec->lru_lock);
> +                       lruvec =3D new_lruvec;
> +                       spin_lock_irq(&lruvec->lru_lock);
>                 }
> -               lruvec =3D mem_cgroup_page_lruvec(page, pgdat);
>
>                 if (!PageLRU(page) || !PageUnevictable(page))
>                         continue;
> @@ -4318,10 +4316,10 @@ void check_move_unevictable_pages(struct pagevec =
*pvec)
>                 }
>         }
>
> -       if (pgdat) {
> +       if (lruvec) {
>                 __count_vm_events(UNEVICTABLE_PGRESCUED, pgrescued);
>                 __count_vm_events(UNEVICTABLE_PGSCANNED, pgscanned);
> -               spin_unlock_irq(&pgdat->lru_lock);
> +               spin_unlock_irq(&lruvec->lru_lock);
>         }
>  }
>  EXPORT_SYMBOL_GPL(check_move_unevictable_pages);
> --
> 1.8.3.1
>

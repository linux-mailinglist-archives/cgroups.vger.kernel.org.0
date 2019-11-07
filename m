Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0BFF2593
	for <lists+cgroups@lfdr.de>; Thu,  7 Nov 2019 03:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733027AbfKGCvC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 6 Nov 2019 21:51:02 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33339 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732990AbfKGCvC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 6 Nov 2019 21:51:02 -0500
Received: by mail-ot1-f67.google.com with SMTP id u13so740832ote.0
        for <cgroups@vger.kernel.org>; Wed, 06 Nov 2019 18:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=srXzeN6zSyigYhNuWeb9PFhUGyu0G9M6CV2KGF40AVw=;
        b=pew1rgD87ZaI/spUbF18bIFhNfZCzl/lmrXyqx3XD33GQMy1NTRrBcDEBORBTtM0fG
         chp0XP6M6PS+rGJ1t2s/GhyUVIEjETRenL2dLY6BqP7fPdtQPVNHCFanNLXsOQdGbV+p
         AuxK0oWka7dzV+VRAIqOCc3pi0VUTOBzmKatk9s5cjhBbDgGzHpASdXp4dZiBU+L/6y/
         T18GBMdA/R6gQKxSUaoQTU9r3sUZoe86ho6wYzI8uut/hWqxegZUr2uEE5NPEgQG7eSq
         z3GSj8oI52tMO9J5zu648zrA8aMmiyE8POdFGAfIj9OXppWPhz1mAoQjEvzilrTVWt+v
         TMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=srXzeN6zSyigYhNuWeb9PFhUGyu0G9M6CV2KGF40AVw=;
        b=hv0Ik+tSGNTDOTUDPt9C2UPkyb2yxnvU1zGtzCxHpnVTXAq1CI+ca0bQWBnshTFYOJ
         5Oe3YgBFC9MkXqzC7j2SbpCIpjWmfauBx4oufRmyqdKo53zTxTwTiBbGc3I4d8FEIcmy
         1hpbHkIo4a3WUgN3RhfCBt5mWdYPWfFo42KX4XzIwSaHxTcWnYbZcREo6hlL+1qkSDxD
         zV+fHurQDc0ph+qHNIoqaoZwuMWGo0qT2e2hL12zSdQaw81RwLPU1Xge1c2rPpkSY+RU
         eZZ4dEAOprK+N0PheEpgvPfaBf9a9TO/Isd/A0mjZQMcZXqQSlBNlRb6bYz9OauW2Aou
         PaCg==
X-Gm-Message-State: APjAAAWFdbqFn2wS0W/rJ0KPQrRPjgu2QioQEPfM0px6/1bwL959LMrc
        vB6j6/xmwbTTbaeIUAoAWd9v4nZ7OQgr1QJriUb8PXX6
X-Google-Smtp-Source: APXvYqwq8GtOb42/vNn0kEpqNRamkE3UI0G4dO+NIpOK+9GgFfvDf8q5Un0kzNBt2z0ztUL616rTkL5uTH5fOYBhCfo=
X-Received: by 2002:a9d:3675:: with SMTP id w108mr868519otb.81.1573095060320;
 Wed, 06 Nov 2019 18:51:00 -0800 (PST)
MIME-Version: 1.0
References: <20190603210746.15800-1-hannes@cmpxchg.org> <20190603210746.15800-3-hannes@cmpxchg.org>
In-Reply-To: <20190603210746.15800-3-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 6 Nov 2019 18:50:49 -0800
Message-ID: <CALvZod69GXQt06Ro60nDoYpYqho+ZRvnyLSSuD8stxUTPv-Dpg@mail.gmail.com>
Subject: Re: [PATCH 02/11] mm: clean up and clarify lruvec lookup procedure
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jun 3, 2019 at 3:04 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> There is a per-memcg lruvec and a NUMA node lruvec. Which one is being
> used is somewhat confusing right now, and it's easy to make mistakes -
> especially when it comes to global reclaim.
>
> How it works: when memory cgroups are enabled, we always use the
> root_mem_cgroup's per-node lruvecs. When memory cgroups are not
> compiled in or disabled at runtime, we use pgdat->lruvec.
>
> Document that in a comment.
>
> Due to the way the reclaim code is generalized, all lookups use the
> mem_cgroup_lruvec() helper function, and nobody should have to find
> the right lruvec manually right now. But to avoid future mistakes,
> rename the pgdat->lruvec member to pgdat->__lruvec and delete the
> convenience wrapper that suggests it's a commonly accessed member.
>
> While in this area, swap the mem_cgroup_lruvec() argument order. The
> name suggests a memcg operation, yet it takes a pgdat first and a
> memcg second. I have to double

check

> take every time I call this. Fix that.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>


> ---
>  include/linux/memcontrol.h | 26 +++++++++++++-------------
>  include/linux/mmzone.h     | 15 ++++++++-------
>  mm/memcontrol.c            |  6 +++---
>  mm/page_alloc.c            |  2 +-
>  mm/vmscan.c                |  6 +++---
>  mm/workingset.c            |  8 ++++----
>  6 files changed, 32 insertions(+), 31 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index fa1e8cb1b3e2..fc32cfaebf32 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -382,22 +382,22 @@ mem_cgroup_nodeinfo(struct mem_cgroup *memcg, int nid)
>  }
>
>  /**
> - * mem_cgroup_lruvec - get the lru list vector for a node or a memcg zone
> - * @node: node of the wanted lruvec
> + * mem_cgroup_lruvec - get the lru list vector for a memcg & node
>   * @memcg: memcg of the wanted lruvec
> + * @node: node of the wanted lruvec
>   *
> - * Returns the lru list vector holding pages for a given @node or a given
> - * @memcg and @zone. This can be the node lruvec, if the memory controller
> - * is disabled.
> + * Returns the lru list vector holding pages for a given @memcg &
> + * @node combination. This can be the node lruvec, if the memory
> + * controller is disabled.
>   */
> -static inline struct lruvec *mem_cgroup_lruvec(struct pglist_data *pgdat,
> -                               struct mem_cgroup *memcg)
> +static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
> +                                              struct pglist_data *pgdat)
>  {
>         struct mem_cgroup_per_node *mz;
>         struct lruvec *lruvec;
>
>         if (mem_cgroup_disabled()) {
> -               lruvec = node_lruvec(pgdat);
> +               lruvec = &pgdat->__lruvec;
>                 goto out;
>         }
>
> @@ -716,7 +716,7 @@ static inline void __mod_lruvec_page_state(struct page *page,
>                 return;
>         }
>
> -       lruvec = mem_cgroup_lruvec(pgdat, page->mem_cgroup);
> +       lruvec = mem_cgroup_lruvec(page->mem_cgroup, pgdat);
>         __mod_lruvec_state(lruvec, idx, val);
>  }
>
> @@ -887,16 +887,16 @@ static inline void mem_cgroup_migrate(struct page *old, struct page *new)
>  {
>  }
>
> -static inline struct lruvec *mem_cgroup_lruvec(struct pglist_data *pgdat,
> -                               struct mem_cgroup *memcg)
> +static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
> +                                              struct pglist_data *pgdat)
>  {
> -       return node_lruvec(pgdat);
> +       return &pgdat->__lruvec;
>  }
>
>  static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page,
>                                                     struct pglist_data *pgdat)
>  {
> -       return &pgdat->lruvec;
> +       return &pgdat->__lruvec;
>  }
>
>  static inline bool mm_match_cgroup(struct mm_struct *mm,
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 427b79c39b3c..95d63a395f40 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -761,7 +761,13 @@ typedef struct pglist_data {
>  #endif
>
>         /* Fields commonly accessed by the page reclaim scanner */
> -       struct lruvec           lruvec;
> +
> +       /*
> +        * NOTE: THIS IS UNUSED IF MEMCG IS ENABLED.
> +        *
> +        * Use mem_cgroup_lruvec() to look up lruvecs.
> +        */
> +       struct lruvec           __lruvec;
>
>         unsigned long           flags;
>
> @@ -784,11 +790,6 @@ typedef struct pglist_data {
>  #define node_start_pfn(nid)    (NODE_DATA(nid)->node_start_pfn)
>  #define node_end_pfn(nid) pgdat_end_pfn(NODE_DATA(nid))
>
> -static inline struct lruvec *node_lruvec(struct pglist_data *pgdat)
> -{
> -       return &pgdat->lruvec;
> -}
> -
>  static inline unsigned long pgdat_end_pfn(pg_data_t *pgdat)
>  {
>         return pgdat->node_start_pfn + pgdat->node_spanned_pages;
> @@ -826,7 +827,7 @@ static inline struct pglist_data *lruvec_pgdat(struct lruvec *lruvec)
>  #ifdef CONFIG_MEMCG
>         return lruvec->pgdat;
>  #else
> -       return container_of(lruvec, struct pglist_data, lruvec);
> +       return container_of(lruvec, struct pglist_data, __lruvec);
>  #endif
>  }
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c193aef3ba9e..6de8ca735ee2 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1200,7 +1200,7 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgd
>         struct lruvec *lruvec;
>
>         if (mem_cgroup_disabled()) {
> -               lruvec = &pgdat->lruvec;
> +               lruvec = &pgdat->__lruvec;
>                 goto out;
>         }
>
> @@ -1518,7 +1518,7 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  static bool test_mem_cgroup_node_reclaimable(struct mem_cgroup *memcg,
>                 int nid, bool noswap)
>  {
> -       struct lruvec *lruvec = mem_cgroup_lruvec(NODE_DATA(nid), memcg);
> +       struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
>
>         if (lruvec_page_state(lruvec, NR_INACTIVE_FILE) ||
>             lruvec_page_state(lruvec, NR_ACTIVE_FILE))
> @@ -3406,7 +3406,7 @@ static int mem_cgroup_move_charge_write(struct cgroup_subsys_state *css,
>  static unsigned long mem_cgroup_node_nr_lru_pages(struct mem_cgroup *memcg,
>                                            int nid, unsigned int lru_mask)
>  {
> -       struct lruvec *lruvec = mem_cgroup_lruvec(NODE_DATA(nid), memcg);
> +       struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
>         unsigned long nr = 0;
>         enum lru_list lru;
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index a345418b548e..cd8e64e536f7 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6619,7 +6619,7 @@ static void __meminit pgdat_init_internals(struct pglist_data *pgdat)
>
>         pgdat_page_ext_init(pgdat);
>         spin_lock_init(&pgdat->lru_lock);
> -       lruvec_init(node_lruvec(pgdat));
> +       lruvec_init(&pgdat->__lruvec);
>  }
>
>  static void __meminit zone_init_internals(struct zone *zone, enum zone_type idx, int nid,
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index f396424850aa..853be16ee5e2 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2477,7 +2477,7 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
>  static void shrink_node_memcg(struct pglist_data *pgdat, struct mem_cgroup *memcg,
>                               struct scan_control *sc)
>  {
> -       struct lruvec *lruvec = mem_cgroup_lruvec(pgdat, memcg);
> +       struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
>         unsigned long nr[NR_LRU_LISTS];
>         unsigned long targets[NR_LRU_LISTS];
>         unsigned long nr_to_scan;
> @@ -2988,7 +2988,7 @@ static void snapshot_refaults(struct mem_cgroup *root_memcg, pg_data_t *pgdat)
>                 unsigned long refaults;
>                 struct lruvec *lruvec;
>
> -               lruvec = mem_cgroup_lruvec(pgdat, memcg);
> +               lruvec = mem_cgroup_lruvec(memcg, pgdat);
>                 refaults = lruvec_page_state_local(lruvec, WORKINGSET_ACTIVATE);
>                 lruvec->refaults = refaults;
>         } while ((memcg = mem_cgroup_iter(root_memcg, memcg, NULL)));
> @@ -3351,7 +3351,7 @@ static void age_active_anon(struct pglist_data *pgdat,
>
>         memcg = mem_cgroup_iter(NULL, NULL, NULL);
>         do {
> -               struct lruvec *lruvec = mem_cgroup_lruvec(pgdat, memcg);
> +               struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
>
>                 if (inactive_list_is_low(lruvec, false, sc, true))
>                         shrink_active_list(SWAP_CLUSTER_MAX, lruvec,
> diff --git a/mm/workingset.c b/mm/workingset.c
> index e0b4edcb88c8..2aaa70bea99c 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -233,7 +233,7 @@ void *workingset_eviction(struct page *page)
>         VM_BUG_ON_PAGE(page_count(page), page);
>         VM_BUG_ON_PAGE(!PageLocked(page), page);
>
> -       lruvec = mem_cgroup_lruvec(pgdat, memcg);
> +       lruvec = mem_cgroup_lruvec(memcg, pgdat);
>         eviction = atomic_long_inc_return(&lruvec->inactive_age);
>         return pack_shadow(memcgid, pgdat, eviction, PageWorkingset(page));
>  }
> @@ -280,7 +280,7 @@ void workingset_refault(struct page *page, void *shadow)
>         memcg = mem_cgroup_from_id(memcgid);
>         if (!mem_cgroup_disabled() && !memcg)
>                 goto out;
> -       lruvec = mem_cgroup_lruvec(pgdat, memcg);
> +       lruvec = mem_cgroup_lruvec(memcg, pgdat);
>         refault = atomic_long_read(&lruvec->inactive_age);
>         active_file = lruvec_lru_size(lruvec, LRU_ACTIVE_FILE, MAX_NR_ZONES);
>
> @@ -345,7 +345,7 @@ void workingset_activation(struct page *page)
>         memcg = page_memcg_rcu(page);
>         if (!mem_cgroup_disabled() && !memcg)
>                 goto out;
> -       lruvec = mem_cgroup_lruvec(page_pgdat(page), memcg);
> +       lruvec = mem_cgroup_lruvec(memcg, page_pgdat(page));
>         atomic_long_inc(&lruvec->inactive_age);
>  out:
>         rcu_read_unlock();
> @@ -428,7 +428,7 @@ static unsigned long count_shadow_nodes(struct shrinker *shrinker,
>                 struct lruvec *lruvec;
>                 int i;
>
> -               lruvec = mem_cgroup_lruvec(NODE_DATA(sc->nid), sc->memcg);
> +               lruvec = mem_cgroup_lruvec(sc->memcg, NODE_DATA(sc->nid));
>                 for (pages = 0, i = 0; i < NR_LRU_LISTS; i++)
>                         pages += lruvec_page_state_local(lruvec,
>                                                          NR_LRU_BASE + i);
> --
> 2.21.0
>

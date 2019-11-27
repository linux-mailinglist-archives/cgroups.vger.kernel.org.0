Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1942C10C017
	for <lists+cgroups@lfdr.de>; Wed, 27 Nov 2019 23:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfK0WQo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Nov 2019 17:16:44 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37446 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfK0WQn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Nov 2019 17:16:43 -0500
Received: by mail-oi1-f193.google.com with SMTP id 128so13473642oih.4
        for <cgroups@vger.kernel.org>; Wed, 27 Nov 2019 14:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lem1U5AcwxE30cM5ZAuxFykgfvrtAmfGta1E6+S/wG0=;
        b=I7f0LadNRduIYDKwLDjGidmPjeOttDnp4vhEN4R5CYb1tn6OsACjo5cxxQNlfs16rr
         Te+EOLFEZWgTOChGVZq3s9fwPr2fnkKazlQC2jfe6HY1M/9d+6mMdrlds1uEaqim8JI4
         5EYRkv48/JpLucyhZxvWwxCRKbCoarzzyl/xA3Yve4oviQnjvxb6mJaaRJzrxkJiK6do
         Y2V7rhNCbPIB7ohYl7o8d25xN2Q/O6fQuu51F2UO90aLHT8HRHrZ3qsKXEAn3cmsSw2K
         LVf23gpuBPFhB7if1M6LhuakPZKHq6vnixMaCWJfV08FGB8eYrduIhpMHNk9olU4dr05
         +n+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lem1U5AcwxE30cM5ZAuxFykgfvrtAmfGta1E6+S/wG0=;
        b=AL4RgBW+jP/U4hsMxN9MQaMbUQPdNfMkOeLh0h072ufSkOmjdkerVn5KgdUjwBh3nj
         WmjcdFBvF9KXW7uQOlLcBlJLijOLP6p14hxwSHZZLCuSrmiM+06SfpAF9U1X5ItTZVNr
         68sCcED5K1Y0AUDm5x6qQYzZfHZ3yJAfQUij1Rf+FX+xwloXstLW2/kvHDqsBdghABOv
         QjxETFmekiBj9HXcp3oR5s2XVDCM1txuGLgIkZUcojjB6/bK1AYLJVTx23enrkjxcKvm
         9E6qP3b4h8XUkDcXgGRm++o1e7/D/hu37G/PldI4LRCtGtDqeQ3zPIJOK4f+OfLbwB2G
         L9rw==
X-Gm-Message-State: APjAAAWHEtB93PH37KvobDkfwA6JPdNjNcU8KutnTEu9mCEuRnOiVnS3
        11E+KlglVupv4kw31xoqRorZQkXBpeN+MEhZUPBCPA==
X-Google-Smtp-Source: APXvYqz4icelaTmq2ZmsTJHULyUKcAvZwX3GlaXDrAQqHXycz+MDGhdMnOKRwkR1FpKU2VVYD4sv9ByAJvbVVXC4vG4=
X-Received: by 2002:aca:fc8d:: with SMTP id a135mr6283811oii.142.1574893000275;
 Wed, 27 Nov 2019 14:16:40 -0800 (PST)
MIME-Version: 1.0
References: <20191107205334.158354-1-hannes@cmpxchg.org> <20191107205334.158354-4-hannes@cmpxchg.org>
 <CALvZod4EX4xJkQpmB4UJZqA+bWOoK_5B4Eq-kQECTfzQG2cJJQ@mail.gmail.com>
In-Reply-To: <CALvZod4EX4xJkQpmB4UJZqA+bWOoK_5B4Eq-kQECTfzQG2cJJQ@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 27 Nov 2019 14:16:29 -0800
Message-ID: <CALvZod4pYjeDc97R=8C0UVOxi-hOcXznxy5OrX2e-ESm411DUg@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: vmscan: enforce inactive:active ratio at the
 reclaim root
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Nov 14, 2019 at 4:29 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Thu, Nov 7, 2019 at 12:53 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > We split the LRU lists into inactive and an active parts to maximize
> > workingset protection while allowing just enough inactive cache space
> > to faciltate readahead and writeback for one-off file accesses (e.g. a
> > linear scan through a file, or logging); or just enough inactive anon
> > to maintain recent reference information when reclaim needs to swap.
> >
> > With cgroups and their nested LRU lists, we currently don't do this
> > correctly. While recursive cgroup reclaim establishes a relative LRU
> > order among the pages of all involved cgroups, inactive:active size
> > decisions are done on a per-cgroup level. As a result, we'll reclaim a
> > cgroup's workingset when it doesn't have cold pages, even when one of
> > its siblings has plenty of it that should be reclaimed first.
> >
> > For example: workload A has 50M worth of hot cache but doesn't do any
> > one-off file accesses; meanwhile, parallel workload B scans files and
> > rarely accesses the same page twice.
> >
> > If these workloads were to run in an uncgrouped system, A would be
> > protected from the high rate of cache faults from B. But if they were
> > put in parallel cgroups for memory accounting purposes, B's fast cache
> > fault rate would push out the hot cache pages of A. This is unexpected
> > and undesirable - the "scan resistance" of the page cache is broken.
> >
> > This patch moves inactive:active size balancing decisions to the root
> > of reclaim - the same level where the LRU order is established.
> >
> > It does this by looking at the recursize size of the inactive and the
> > active file sets of the cgroup subtree at the beginning of the reclaim
> > cycle, and then making a decision - scan or skip active pages - that
> > applies throughout the entire run and to every cgroup involved.
>
> Oh ok, this answer my question on previous patch. The reclaim root
> looks at the full tree inactive and active count to make decisions and
> thus active list of some descendant cgroup will be protected from the
> inactive list of its sibling.
>
> >
> > With that in place, in the test above, the VM will recognize that
> > there are plenty of inactive pages in the combined cache set of
> > workloads A and B and prefer the one-off cache in B over the hot pages
> > in A. The scan resistance of the cache is restored.
> >
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Forgot to add:

Reviewed-by: Shakeel Butt <shakeelb@google.com>

>
> BTW no love for the anon memory? The whole "workingset" mechanism only
> works for file pages. Are there any plans to extend it for anon as
> well?
>
> > ---
> >  include/linux/mmzone.h |   4 +-
> >  mm/vmscan.c            | 185 ++++++++++++++++++++++++++---------------
> >  2 files changed, 118 insertions(+), 71 deletions(-)
> >
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index 7a09087e8c77..454a230ad417 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -229,12 +229,12 @@ enum lru_list {
> >
> >  #define for_each_evictable_lru(lru) for (lru = 0; lru <= LRU_ACTIVE_FILE; lru++)
> >
> > -static inline int is_file_lru(enum lru_list lru)
> > +static inline bool is_file_lru(enum lru_list lru)
> >  {
> >         return (lru == LRU_INACTIVE_FILE || lru == LRU_ACTIVE_FILE);
> >  }
> >
> > -static inline int is_active_lru(enum lru_list lru)
> > +static inline bool is_active_lru(enum lru_list lru)
> >  {
> >         return (lru == LRU_ACTIVE_ANON || lru == LRU_ACTIVE_FILE);
> >  }
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 527617ee9b73..df859b1d583c 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -79,6 +79,13 @@ struct scan_control {
> >          */
> >         struct mem_cgroup *target_mem_cgroup;
> >
> > +       /* Can active pages be deactivated as part of reclaim? */
> > +#define DEACTIVATE_ANON 1
> > +#define DEACTIVATE_FILE 2
> > +       unsigned int may_deactivate:2;
> > +       unsigned int force_deactivate:1;
> > +       unsigned int skipped_deactivate:1;
> > +
> >         /* Writepage batching in laptop mode; RECLAIM_WRITE */
> >         unsigned int may_writepage:1;
> >
> > @@ -101,6 +108,9 @@ struct scan_control {
> >         /* One of the zones is ready for compaction */
> >         unsigned int compaction_ready:1;
> >
> > +       /* There is easily reclaimable cold cache in the current node */
> > +       unsigned int cache_trim_mode:1;
> > +
> >         /* The file pages on the current node are dangerously low */
> >         unsigned int file_is_tiny:1;
> >
> > @@ -2154,6 +2164,20 @@ unsigned long reclaim_pages(struct list_head *page_list)
> >         return nr_reclaimed;
> >  }
> >
> > +static unsigned long shrink_list(enum lru_list lru, unsigned long nr_to_scan,
> > +                                struct lruvec *lruvec, struct scan_control *sc)
> > +{
> > +       if (is_active_lru(lru)) {
> > +               if (sc->may_deactivate & (1 << is_file_lru(lru)))
> > +                       shrink_active_list(nr_to_scan, lruvec, sc, lru);
> > +               else
> > +                       sc->skipped_deactivate = 1;
> > +               return 0;
> > +       }
> > +
> > +       return shrink_inactive_list(nr_to_scan, lruvec, sc, lru);
> > +}
> > +
> >  /*
> >   * The inactive anon list should be small enough that the VM never has
> >   * to do too much work.
> > @@ -2182,59 +2206,25 @@ unsigned long reclaim_pages(struct list_head *page_list)
> >   *    1TB     101        10GB
> >   *   10TB     320        32GB
> >   */
> > -static bool inactive_list_is_low(struct lruvec *lruvec, bool file,
> > -                                struct scan_control *sc, bool trace)
> > +static bool inactive_is_low(struct lruvec *lruvec, enum lru_list inactive_lru)
> >  {
> > -       enum lru_list active_lru = file * LRU_FILE + LRU_ACTIVE;
> > -       struct pglist_data *pgdat = lruvec_pgdat(lruvec);
> > -       enum lru_list inactive_lru = file * LRU_FILE;
> > +       enum lru_list active_lru = inactive_lru + LRU_ACTIVE;
> >         unsigned long inactive, active;
> >         unsigned long inactive_ratio;
> > -       struct lruvec *target_lruvec;
> > -       unsigned long refaults;
> >         unsigned long gb;
> >
> > -       inactive = lruvec_lru_size(lruvec, inactive_lru, sc->reclaim_idx);
> > -       active = lruvec_lru_size(lruvec, active_lru, sc->reclaim_idx);
> > +       inactive = lruvec_page_state(lruvec, inactive_lru);
> > +       active = lruvec_page_state(lruvec, active_lru);
> >
> > -       /*
> > -        * When refaults are being observed, it means a new workingset
> > -        * is being established. Disable active list protection to get
> > -        * rid of the stale workingset quickly.
> > -        */
> > -       target_lruvec = mem_cgroup_lruvec(sc->target_mem_cgroup, pgdat);
> > -       refaults = lruvec_page_state(target_lruvec, WORKINGSET_ACTIVATE);
> > -       if (file && target_lruvec->refaults != refaults) {
> > -               inactive_ratio = 0;
> > -       } else {
> > -               gb = (inactive + active) >> (30 - PAGE_SHIFT);
> > -               if (gb)
> > -                       inactive_ratio = int_sqrt(10 * gb);
> > -               else
> > -                       inactive_ratio = 1;
> > -       }
> > -
> > -       if (trace)
> > -               trace_mm_vmscan_inactive_list_is_low(pgdat->node_id, sc->reclaim_idx,
> > -                       lruvec_lru_size(lruvec, inactive_lru, MAX_NR_ZONES), inactive,
> > -                       lruvec_lru_size(lruvec, active_lru, MAX_NR_ZONES), active,
> > -                       inactive_ratio, file);
> > +       gb = (inactive + active) >> (30 - PAGE_SHIFT);
> > +       if (gb)
> > +               inactive_ratio = int_sqrt(10 * gb);
> > +       else
> > +               inactive_ratio = 1;
> >
> >         return inactive * inactive_ratio < active;
> >  }
> >
> > -static unsigned long shrink_list(enum lru_list lru, unsigned long nr_to_scan,
> > -                                struct lruvec *lruvec, struct scan_control *sc)
> > -{
> > -       if (is_active_lru(lru)) {
> > -               if (inactive_list_is_low(lruvec, is_file_lru(lru), sc, true))
> > -                       shrink_active_list(nr_to_scan, lruvec, sc, lru);
> > -               return 0;
> > -       }
> > -
> > -       return shrink_inactive_list(nr_to_scan, lruvec, sc, lru);
> > -}
> > -
> >  enum scan_balance {
> >         SCAN_EQUAL,
> >         SCAN_FRACT,
> > @@ -2296,28 +2286,17 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
> >
> >         /*
> >          * If the system is almost out of file pages, force-scan anon.
> > -        * But only if there are enough inactive anonymous pages on
> > -        * the LRU. Otherwise, the small LRU gets thrashed.
> >          */
> > -       if (sc->file_is_tiny &&
> > -           !inactive_list_is_low(lruvec, false, sc, false) &&
> > -           lruvec_lru_size(lruvec, LRU_INACTIVE_ANON,
> > -                           sc->reclaim_idx) >> sc->priority) {
> > +       if (sc->file_is_tiny) {
> >                 scan_balance = SCAN_ANON;
> >                 goto out;
> >         }
> >
> >         /*
> > -        * If there is enough inactive page cache, i.e. if the size of the
> > -        * inactive list is greater than that of the active list *and* the
> > -        * inactive list actually has some pages to scan on this priority, we
> > -        * do not reclaim anything from the anonymous working set right now.
> > -        * Without the second condition we could end up never scanning an
> > -        * lruvec even if it has plenty of old anonymous pages unless the
> > -        * system is under heavy pressure.
> > +        * If there is enough inactive page cache, we do not reclaim
> > +        * anything from the anonymous working right now.
> >          */
> > -       if (!inactive_list_is_low(lruvec, true, sc, false) &&
> > -           lruvec_lru_size(lruvec, LRU_INACTIVE_FILE, sc->reclaim_idx) >> sc->priority) {
> > +       if (sc->cache_trim_mode) {
> >                 scan_balance = SCAN_FILE;
> >                 goto out;
> >         }
> > @@ -2582,7 +2561,7 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
> >          * Even if we did not try to evict anon pages at all, we want to
> >          * rebalance the anon lru active/inactive ratio.
> >          */
> > -       if (total_swap_pages && inactive_list_is_low(lruvec, false, sc, true))
> > +       if (total_swap_pages && inactive_is_low(lruvec, LRU_INACTIVE_ANON))
> >                 shrink_active_list(SWAP_CLUSTER_MAX, lruvec,
> >                                    sc, LRU_ACTIVE_ANON);
> >  }
> > @@ -2722,6 +2701,7 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> >         unsigned long nr_reclaimed, nr_scanned;
> >         struct lruvec *target_lruvec;
> >         bool reclaimable = false;
> > +       unsigned long file;
> >
> >         target_lruvec = mem_cgroup_lruvec(sc->target_mem_cgroup, pgdat);
> >
> > @@ -2731,6 +2711,44 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> >         nr_reclaimed = sc->nr_reclaimed;
> >         nr_scanned = sc->nr_scanned;
> >
> > +       /*
> > +        * Target desirable inactive:active list ratios for the anon
> > +        * and file LRU lists.
> > +        */
> > +       if (!sc->force_deactivate) {
> > +               unsigned long refaults;
> > +
> > +               if (inactive_is_low(target_lruvec, LRU_INACTIVE_ANON))
> > +                       sc->may_deactivate |= DEACTIVATE_ANON;
> > +               else
> > +                       sc->may_deactivate &= ~DEACTIVATE_ANON;
> > +
> > +               /*
> > +                * When refaults are being observed, it means a new
> > +                * workingset is being established. Deactivate to get
> > +                * rid of any stale active pages quickly.
> > +                */
> > +               refaults = lruvec_page_state(target_lruvec,
> > +                                            WORKINGSET_ACTIVATE);
> > +               if (refaults != target_lruvec->refaults ||
> > +                   inactive_is_low(target_lruvec, LRU_INACTIVE_FILE))
> > +                       sc->may_deactivate |= DEACTIVATE_FILE;
> > +               else
> > +                       sc->may_deactivate &= ~DEACTIVATE_FILE;
> > +       } else
> > +               sc->may_deactivate = DEACTIVATE_ANON | DEACTIVATE_FILE;
> > +
> > +       /*
> > +        * If we have plenty of inactive file pages that aren't
> > +        * thrashing, try to reclaim those first before touching
> > +        * anonymous pages.
> > +        */
> > +       file = lruvec_page_state(target_lruvec, LRU_INACTIVE_FILE);
> > +       if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE))
> > +               sc->cache_trim_mode = 1;
> > +       else
> > +               sc->cache_trim_mode = 0;
> > +
> >         /*
> >          * Prevent the reclaimer from falling into the cache trap: as
> >          * cache pages start out inactive, every cache fault will tip
> > @@ -2741,10 +2759,9 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> >          * anon pages.  Try to detect this based on file LRU size.
> >          */
> >         if (!cgroup_reclaim(sc)) {
> > -               unsigned long file;
> > -               unsigned long free;
> > -               int z;
> >                 unsigned long total_high_wmark = 0;
> > +               unsigned long free, anon;
> > +               int z;
> >
> >                 free = sum_zone_node_page_state(pgdat->node_id, NR_FREE_PAGES);
> >                 file = node_page_state(pgdat, NR_ACTIVE_FILE) +
> > @@ -2758,7 +2775,17 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> >                         total_high_wmark += high_wmark_pages(zone);
> >                 }
> >
> > -               sc->file_is_tiny = file + free <= total_high_wmark;
> > +               /*
> > +                * Consider anon: if that's low too, this isn't a
> > +                * runaway file reclaim problem, but rather just
> > +                * extreme pressure. Reclaim as per usual then.
> > +                */
> > +               anon = node_page_state(pgdat, NR_INACTIVE_ANON);
> > +
> > +               sc->file_is_tiny =
> > +                       file + free <= total_high_wmark &&
> > +                       !(sc->may_deactivate & DEACTIVATE_ANON) &&
> > +                       anon >> sc->priority;
> >         }
> >
> >         shrink_node_memcgs(pgdat, sc);
> > @@ -3062,9 +3089,27 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
> >         if (sc->compaction_ready)
> >                 return 1;
> >
> > +       /*
> > +        * We make inactive:active ratio decisions based on the node's
> > +        * composition of memory, but a restrictive reclaim_idx or a
> > +        * memory.low cgroup setting can exempt large amounts of
> > +        * memory from reclaim. Neither of which are very common, so
> > +        * instead of doing costly eligibility calculations of the
> > +        * entire cgroup subtree up front, we assume the estimates are
> > +        * good, and retry with forcible deactivation if that fails.
> > +        */
> > +       if (sc->skipped_deactivate) {
> > +               sc->priority = initial_priority;
> > +               sc->force_deactivate = 1;
> > +               sc->skipped_deactivate = 0;
> > +               goto retry;
> > +       }
> > +
>
> Not really an objection but in the worst case this will double the
> cost of direct reclaim.
>
> >         /* Untapped cgroup reserves?  Don't OOM, retry. */
> >         if (sc->memcg_low_skipped) {
> >                 sc->priority = initial_priority;
> > +               sc->force_deactivate = 0;
> > +               sc->skipped_deactivate = 0;
> >                 sc->memcg_low_reclaim = 1;
> >                 sc->memcg_low_skipped = 0;
> >                 goto retry;
> > @@ -3347,18 +3392,20 @@ static void age_active_anon(struct pglist_data *pgdat,
> >                                 struct scan_control *sc)
> >  {
> >         struct mem_cgroup *memcg;
> > +       struct lruvec *lruvec;
> >
> >         if (!total_swap_pages)
> >                 return;
> >
> > +       lruvec = mem_cgroup_lruvec(NULL, pgdat);
> > +       if (!inactive_is_low(lruvec, LRU_INACTIVE_ANON))
> > +               return;
> > +
> >         memcg = mem_cgroup_iter(NULL, NULL, NULL);
> >         do {
> > -               struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
> > -
> > -               if (inactive_list_is_low(lruvec, false, sc, true))
> > -                       shrink_active_list(SWAP_CLUSTER_MAX, lruvec,
> > -                                          sc, LRU_ACTIVE_ANON);
> > -
> > +               lruvec = mem_cgroup_lruvec(memcg, pgdat);
> > +               shrink_active_list(SWAP_CLUSTER_MAX, lruvec,
> > +                                  sc, LRU_ACTIVE_ANON);
> >                 memcg = mem_cgroup_iter(NULL, memcg, NULL);
> >         } while (memcg);
> >  }
> > --
> > 2.24.0
> >

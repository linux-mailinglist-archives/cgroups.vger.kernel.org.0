Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2E6BF2598
	for <lists+cgroups@lfdr.de>; Thu,  7 Nov 2019 03:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733067AbfKGCv1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 6 Nov 2019 21:51:27 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34718 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732982AbfKGCv0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 6 Nov 2019 21:51:26 -0500
Received: by mail-oi1-f194.google.com with SMTP id l202so680435oig.1
        for <cgroups@vger.kernel.org>; Wed, 06 Nov 2019 18:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZJgjLii01IGGdUCsYrzd4gYjlTvDiWueI/o8CqoLYI4=;
        b=rlCeuEiCGh7lsXngMqUCH816OSSAwW5c+4c+hmAyE/ruz/i3CAd226pxUWdOkAwMV5
         Y2vPchFkJoWzr8dSiKPbmMnzTpqFNJbj/npNbC+nwyeUh+2na5zPYMcupa7V219gY5QQ
         n18znZB1l1X3eI473qpX5oK0eCLoYA1B+m8r/7RLgqyYxLeGsMSaAOjhI+N86Bf62IRp
         UOSmS6XrKL8AfEu3nxL5/D2WQILh4cipww7Lqj2buj1l4CStbh2qig/SIowcQlgTPawz
         SQDRqJ1/U/o4JxfoC54TRxE+NvVH3iM7YDzr9FAMUxVkuWmKtifVYfYytRvlQiN8++am
         c88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZJgjLii01IGGdUCsYrzd4gYjlTvDiWueI/o8CqoLYI4=;
        b=VqKohtbAC/GRfxmmfSxAbngCkl/nrTH8sZUiObkIFUlsRoLYuU+xA2L0AJtemvYilZ
         FPkFLtUGFWm/7dklxbKZ2lUwdHm3gi4ZANi3Pcn1rvJir2qGaUbMQoVQCbC8ADq0e2gi
         w9s25qzavZlahL5bewKXFMW66zdsJvxzw1M/N1XOTS7AwpwbvDU+MEU1XezeXn3EPiLz
         O759GZenAIUBD7gayWjzEdviGctInux92Z/F29SZ/vLNo2l94+bXiWrpGF3UytOrVqz7
         IiU9TwfA10vAoowh7Y2RYOrCgMf+Q/Ryg7pzjIZ6iGtp9Nmuj0Tm/SHarw80qtgvVwWr
         JLKA==
X-Gm-Message-State: APjAAAXn0ZFO7cz99n+1/ok0iySqdoGZqQheAMf2gWuI+WblTPPLfvIy
        ezDekPmGt5TwstKXLkq5EmKrM30CHjn9feLRuT7wJg==
X-Google-Smtp-Source: APXvYqxVb+X95mYEAd2Ugk1BumgEAruoupSYZRK2d7E+6AIUYLX4CVCCjXCrigXtcqjbBQQP/G/PAGC9+XuoVmpaskU=
X-Received: by 2002:aca:f506:: with SMTP id t6mr1159853oih.69.1573095085224;
 Wed, 06 Nov 2019 18:51:25 -0800 (PST)
MIME-Version: 1.0
References: <20190603210746.15800-1-hannes@cmpxchg.org> <20190603210746.15800-5-hannes@cmpxchg.org>
In-Reply-To: <20190603210746.15800-5-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 6 Nov 2019 18:51:14 -0800
Message-ID: <CALvZod4EyAX_Q-YdHkVOquL2dJYMYN7YNi3V0rZ0yDtB09SszQ@mail.gmail.com>
Subject: Re: [PATCH 04/11] mm: vmscan: naming fixes: cgroup_reclaim() and writeback_working()
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

On Mon, Jun 3, 2019 at 3:02 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Seven years after introducing the global_reclaim() function, I still
> have to double take when reading a callsite. I don't know how others
> do it. This is a terrible name.
>
> Invert the meaning and rename it to cgroup_reclaim().
>
> [ After all, "global reclaim" is just regular reclaim invoked from the
>   page allocator. It's reclaim on behalf of a cgroup limit that is a
>   special case of reclaim, and should be explicit - not the reverse. ]
>

Not really confusing for me at least but no objection on cgroup_reclaim().

> sane_reclaim() isn't very descriptive either: it tests whether we can
> use the regular writeback throttling - available during regular page
> reclaim or cgroup2 limit reclaim - or need to use the broken
> wait_on_page_writeback() method. Rename it to writeback_working().

Totally agree here.

>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>


> ---
>  mm/vmscan.c | 38 ++++++++++++++++++--------------------
>  1 file changed, 18 insertions(+), 20 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 69c4c82a9b5a..afd5e2432a8e 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -239,13 +239,13 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
>  #endif /* CONFIG_MEMCG_KMEM */
>
>  #ifdef CONFIG_MEMCG
> -static bool global_reclaim(struct scan_control *sc)
> +static bool cgroup_reclaim(struct scan_control *sc)
>  {
> -       return !sc->target_mem_cgroup;
> +       return sc->target_mem_cgroup;
>  }
>
>  /**
> - * sane_reclaim - is the usual dirty throttling mechanism operational?
> + * writeback_working - is the usual dirty throttling mechanism unavailable?
>   * @sc: scan_control in question
>   *
>   * The normal page dirty throttling mechanism in balance_dirty_pages() is
> @@ -257,11 +257,9 @@ static bool global_reclaim(struct scan_control *sc)
>   * This function tests whether the vmscan currently in progress can assume
>   * that the normal dirty throttling mechanism is operational.
>   */
> -static bool sane_reclaim(struct scan_control *sc)
> +static bool writeback_working(struct scan_control *sc)
>  {
> -       struct mem_cgroup *memcg = sc->target_mem_cgroup;
> -
> -       if (!memcg)
> +       if (!cgroup_reclaim(sc))
>                 return true;
>  #ifdef CONFIG_CGROUP_WRITEBACK
>         if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
> @@ -293,12 +291,12 @@ static bool memcg_congested(pg_data_t *pgdat,
>
>  }
>  #else
> -static bool global_reclaim(struct scan_control *sc)
> +static bool cgroup_reclaim(struct scan_control *sc)
>  {
> -       return true;
> +       return false;
>  }
>
> -static bool sane_reclaim(struct scan_control *sc)
> +static bool writeback_working(struct scan_control *sc)
>  {
>         return true;
>  }
> @@ -1211,7 +1209,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>                                 goto activate_locked;
>
>                         /* Case 2 above */
> -                       } else if (sane_reclaim(sc) ||
> +                       } else if (writeback_working(sc) ||
>                             !PageReclaim(page) || !may_enter_fs) {
>                                 /*
>                                  * This is slightly racy - end_page_writeback()
> @@ -1806,7 +1804,7 @@ static int too_many_isolated(struct pglist_data *pgdat, int file,
>         if (current_is_kswapd())
>                 return 0;
>
> -       if (!sane_reclaim(sc))
> +       if (!writeback_working(sc))
>                 return 0;
>
>         if (file) {
> @@ -1957,7 +1955,7 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
>         reclaim_stat->recent_scanned[file] += nr_taken;
>
>         item = current_is_kswapd() ? PGSCAN_KSWAPD : PGSCAN_DIRECT;
> -       if (global_reclaim(sc))
> +       if (!cgroup_reclaim(sc))
>                 __count_vm_events(item, nr_scanned);
>         __count_memcg_events(lruvec_memcg(lruvec), item, nr_scanned);
>         spin_unlock_irq(&pgdat->lru_lock);
> @@ -1971,7 +1969,7 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
>         spin_lock_irq(&pgdat->lru_lock);
>
>         item = current_is_kswapd() ? PGSTEAL_KSWAPD : PGSTEAL_DIRECT;
> -       if (global_reclaim(sc))
> +       if (!cgroup_reclaim(sc))
>                 __count_vm_events(item, nr_reclaimed);
>         __count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
>         reclaim_stat->recent_rotated[0] += stat.nr_activate[0];
> @@ -2239,7 +2237,7 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
>          * using the memory controller's swap limit feature would be
>          * too expensive.
>          */
> -       if (!global_reclaim(sc) && !swappiness) {
> +       if (cgroup_reclaim(sc) && !swappiness) {
>                 scan_balance = SCAN_FILE;
>                 goto out;
>         }
> @@ -2263,7 +2261,7 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
>          * thrashing file LRU becomes infinitely more attractive than
>          * anon pages.  Try to detect this based on file LRU size.
>          */
> -       if (global_reclaim(sc)) {
> +       if (!cgroup_reclaim(sc)) {
>                 unsigned long pgdatfile;
>                 unsigned long pgdatfree;
>                 int z;
> @@ -2494,7 +2492,7 @@ static void shrink_node_memcg(struct pglist_data *pgdat, struct mem_cgroup *memc
>          * abort proportional reclaim if either the file or anon lru has already
>          * dropped to zero at the first pass.
>          */
> -       scan_adjusted = (global_reclaim(sc) && !current_is_kswapd() &&
> +       scan_adjusted = (!cgroup_reclaim(sc) && !current_is_kswapd() &&
>                          sc->priority == DEF_PRIORITY);
>
>         blk_start_plug(&plug);
> @@ -2816,7 +2814,7 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>                  * Legacy memcg will stall in page writeback so avoid forcibly
>                  * stalling in wait_iff_congested().
>                  */
> -               if (!global_reclaim(sc) && sane_reclaim(sc) &&
> +               if (cgroup_reclaim(sc) && writeback_working(sc) &&
>                     sc->nr.dirty && sc->nr.dirty == sc->nr.congested)
>                         set_memcg_congestion(pgdat, root, true);
>
> @@ -2911,7 +2909,7 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
>                  * Take care memory controller reclaiming has small influence
>                  * to global LRU.
>                  */
> -               if (global_reclaim(sc)) {
> +               if (!cgroup_reclaim(sc)) {
>                         if (!cpuset_zone_allowed(zone,
>                                                  GFP_KERNEL | __GFP_HARDWALL))
>                                 continue;
> @@ -3011,7 +3009,7 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
>  retry:
>         delayacct_freepages_start();
>
> -       if (global_reclaim(sc))
> +       if (!cgroup_reclaim(sc))
>                 __count_zid_vm_events(ALLOCSTALL, sc->reclaim_idx, 1);
>
>         do {
> --
> 2.21.0
>

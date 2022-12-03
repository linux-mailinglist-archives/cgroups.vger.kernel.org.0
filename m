Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7346411FC
	for <lists+cgroups@lfdr.de>; Sat,  3 Dec 2022 01:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbiLCA0u (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Dec 2022 19:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbiLCA0p (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Dec 2022 19:26:45 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B98CD985
        for <cgroups@vger.kernel.org>; Fri,  2 Dec 2022 16:26:42 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id cg5so7472349qtb.12
        for <cgroups@vger.kernel.org>; Fri, 02 Dec 2022 16:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H6oyGA7JzpPsUWYTAA2/030qT9cSN6sDgncpoKJKE2Q=;
        b=T/LJJSaG/DQqkLUJQqoGkGenM5T0SxLC+y8PG0mxyXIbqMneGDZsXXtKhbUxZFNFdq
         Z/SOhxajUjNeQd2Rgk7LnQOuCraoycMgNxLaCAKgQOQ1z2C/Elnpe1X15FOoKm+TInrL
         ORj8fsMsRU+cxnX2dL1bwtIUPvYQghJhJ0PtMboqR5YAMAdQJm15FbQDwr96Nf22SVbm
         JzqdKhKWQeF58j5QH0XN9VfbbsLcP3OLxllwNSEarsReojQdu6jp9XlgUAsFph2vgDMI
         /q0RthXA4swaWpKFBkcdiQpIZOExhPzLsZiYMUJrQS6qSl2NdtHv3LM1jjlOQ+FfY0+J
         L8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H6oyGA7JzpPsUWYTAA2/030qT9cSN6sDgncpoKJKE2Q=;
        b=yjNq70K6m7oX1adj0/nrqJEZoTaHHSIZRYAp6ooEIdGR+ICIl8dI/7CEF2+Ynf4yWi
         1AbDMzEA5JXj/5iS4ricpdf0oJjLheDJM4gZWnROiLFImh0sONcRrXPfinKaDiSLTKcR
         Tx/zeM68UCUnFKmcuF26Tln4pI26OCaBTn/Q4NK88tG9jAjCRZC4cKTOizOH4LjfKxnd
         9qwqgUNY0ONw5AUWwbhlc7RAWiGodlZCWt6wdBC6M3zvPWNz6pp0SecHiIGmnMYjPefP
         irN1K4gVQXUMGeEbzyOjp8gGUxRhNPX6ux/jRUmnYW/cyatyC5BleqIwHcFVhsczMUjd
         8Njg==
X-Gm-Message-State: ANoB5pk81devLNIZdszQzjam1u3BMW9DBDQ1RiiGqI7JyC6xpUNJIQlG
        3kbKuRRTQk4E5FTbjxXVcfA4zOUc70pTUXGI8KnQIw==
X-Google-Smtp-Source: AA0mqf6epze0fKqzBEapqtULsddckDJB9LkpGiF4LjVms4jK3h6u+84RunBv9T7dWcM92U81yT95Vb6jTvm6IyzuSsQ=
X-Received: by 2002:a05:622a:6022:b0:398:5f25:649 with SMTP id
 he34-20020a05622a602200b003985f250649mr69017714qtb.673.1670027200882; Fri, 02
 Dec 2022 16:26:40 -0800 (PST)
MIME-Version: 1.0
References: <20221202031512.1365483-1-yosryahmed@google.com> <20221202031512.1365483-2-yosryahmed@google.com>
In-Reply-To: <20221202031512.1365483-2-yosryahmed@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 2 Dec 2022 16:26:05 -0800
Message-ID: <CAJD7tkZouk+r=Qk554AOk1-3eYy-gTC8KC+OJQY13ZkNZ9Qe+Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] mm: memcg: fix stale protection of reclaim target memcg
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, Yu Zhao <yuzhao@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Tejun Heo <tj@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Chris Down <chris@chrisdown.name>,
        David Rientjes <rientjes@google.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Andrew, does this need to be picked up by stable branches?

On Thu, Dec 1, 2022 at 7:15 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> During reclaim, mem_cgroup_calculate_protection() is used to determine
> the effective protection (emin and elow) values of a memcg. The
> protection of the reclaim target is ignored, but we cannot set their
> effective protection to 0 due to a limitation of the current
> implementation (see comment in mem_cgroup_protection()). Instead,
> we leave their effective protection values unchaged, and later ignore it
> in mem_cgroup_protection().
>
> However, mem_cgroup_protection() is called later in
> shrink_lruvec()->get_scan_count(), which is after the
> mem_cgroup_below_{min/low}() checks in shrink_node_memcgs(). As a
> result, the stale effective protection values of the target memcg may
> lead us to skip reclaiming from the target memcg entirely, before
> calling shrink_lruvec(). This can be even worse with recursive
> protection, where the stale target memcg protection can be higher than
> its standalone protection. See two examples below (a similar version of
> example (a) is added to test_memcontrol in a later patch).
>
> (a) A simple example with proactive reclaim is as follows. Consider the
> following hierarchy:
> ROOT
>  |
>  A
>  |
>  B (memory.min = 10M)
>
> Consider the following scenario:
> - B has memory.current = 10M.
> - The system undergoes global reclaim (or memcg reclaim in A).
> - In shrink_node_memcgs():
>   - mem_cgroup_calculate_protection() calculates the effective min (emin)
>     of B as 10M.
>   - mem_cgroup_below_min() returns true for B, we do not reclaim from B.
> - Now if we want to reclaim 5M from B using proactive reclaim
>   (memory.reclaim), we should be able to, as the protection of the
>   target memcg should be ignored.
> - In shrink_node_memcgs():
>   - mem_cgroup_calculate_protection() immediately returns for B without
>     doing anything, as B is the target memcg, relying on
>     mem_cgroup_protection() to ignore B's stale effective min (still 10M).
>   - mem_cgroup_below_min() reads the stale effective min for B and we
>     skip it instead of ignoring its protection as intended, as we never
>     reach mem_cgroup_protection().
>
> (b) An more complex example with recursive protection is as follows.
> Consider the following hierarchy with memory_recursiveprot:
> ROOT
>  |
>  A (memory.min = 50M)
>  |
>  B (memory.min = 10M, memory.high = 40M)
>
> Consider the following scenario:
> - B has memory.current = 35M.
> - The system undergoes global reclaim (target memcg is NULL).
> - B will have an effective min of 50M (all of A's unclaimed protection).
> - B will not be reclaimed from.
> - Now allocate 10M more memory in B, pushing it above it's high limit.
> - The system undergoes memcg reclaim from B (target memcg is B).
> - Like example (a), we do nothing in mem_cgroup_calculate_protection(),
>   then call mem_cgroup_below_min(), which will read the stale effective
>   min for B (50M) and skip it. In this case, it's even worse because we
>   are not just considering B's standalone protection (10M), but we are
>   reading a much higher stale protection (50M) which will cause us to not
>   reclaim from B at all.
>
> This is an artifact of commit 45c7f7e1ef17 ("mm, memcg: decouple
> e{low,min} state mutations from protection checks") which made
> mem_cgroup_calculate_protection() only change the state without
> returning any value. Before that commit, we used to return
> MEMCG_PROT_NONE for the target memcg, which would cause us to skip the
> mem_cgroup_below_{min/low}() checks. After that commit we do not return
> anything and we end up checking the min & low effective protections for
> the target memcg, which are stale.
>
> Update mem_cgroup_supports_protection() to also check if we are
> reclaiming from the target, and rename it to mem_cgroup_unprotected()
> (now returns true if we should not protect the memcg, much simpler logic).
>
> Fixes: 45c7f7e1ef17 ("mm, memcg: decouple e{low,min} state mutations from protection checks")
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  include/linux/memcontrol.h | 31 +++++++++++++++++++++----------
>  mm/vmscan.c                | 11 ++++++-----
>  2 files changed, 27 insertions(+), 15 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index e1644a24009c..d3c8203cab6c 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -615,28 +615,32 @@ static inline void mem_cgroup_protection(struct mem_cgroup *root,
>  void mem_cgroup_calculate_protection(struct mem_cgroup *root,
>                                      struct mem_cgroup *memcg);
>
> -static inline bool mem_cgroup_supports_protection(struct mem_cgroup *memcg)
> +static inline bool mem_cgroup_unprotected(struct mem_cgroup *target,
> +                                         struct mem_cgroup *memcg)
>  {
>         /*
>          * The root memcg doesn't account charges, and doesn't support
> -        * protection.
> +        * protection. The target memcg's protection is ignored, see
> +        * mem_cgroup_calculate_protection() and mem_cgroup_protection()
>          */
> -       return !mem_cgroup_disabled() && !mem_cgroup_is_root(memcg);
> -
> +       return mem_cgroup_disabled() || mem_cgroup_is_root(memcg) ||
> +               memcg == target;
>  }
>
> -static inline bool mem_cgroup_below_low(struct mem_cgroup *memcg)
> +static inline bool mem_cgroup_below_low(struct mem_cgroup *target,
> +                                       struct mem_cgroup *memcg)
>  {
> -       if (!mem_cgroup_supports_protection(memcg))
> +       if (mem_cgroup_unprotected(target, memcg))
>                 return false;
>
>         return READ_ONCE(memcg->memory.elow) >=
>                 page_counter_read(&memcg->memory);
>  }
>
> -static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
> +static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
> +                                       struct mem_cgroup *memcg)
>  {
> -       if (!mem_cgroup_supports_protection(memcg))
> +       if (mem_cgroup_unprotected(target, memcg))
>                 return false;
>
>         return READ_ONCE(memcg->memory.emin) >=
> @@ -1209,12 +1213,19 @@ static inline void mem_cgroup_calculate_protection(struct mem_cgroup *root,
>  {
>  }
>
> -static inline bool mem_cgroup_below_low(struct mem_cgroup *memcg)
> +static inline bool mem_cgroup_unprotected(struct mem_cgroup *target,
> +                                         struct mem_cgroup *memcg)
> +{
> +       return true;
> +}
> +static inline bool mem_cgroup_below_low(struct mem_cgroup *target,
> +                                       struct mem_cgroup *memcg)
>  {
>         return false;
>  }
>
> -static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
> +static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
> +                                       struct mem_cgroup *memcg)
>  {
>         return false;
>  }
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 04d8b88e5216..79ef0fe67518 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4486,7 +4486,7 @@ static bool age_lruvec(struct lruvec *lruvec, struct scan_control *sc, unsigned
>
>         mem_cgroup_calculate_protection(NULL, memcg);
>
> -       if (mem_cgroup_below_min(memcg))
> +       if (mem_cgroup_below_min(NULL, memcg))
>                 return false;
>
>         need_aging = should_run_aging(lruvec, max_seq, min_seq, sc, swappiness, &nr_to_scan);
> @@ -5047,8 +5047,9 @@ static unsigned long get_nr_to_scan(struct lruvec *lruvec, struct scan_control *
>         DEFINE_MAX_SEQ(lruvec);
>         DEFINE_MIN_SEQ(lruvec);
>
> -       if (mem_cgroup_below_min(memcg) ||
> -           (mem_cgroup_below_low(memcg) && !sc->memcg_low_reclaim))
> +       if (mem_cgroup_below_min(sc->target_mem_cgroup, memcg) ||
> +           (mem_cgroup_below_low(sc->target_mem_cgroup, memcg) &&
> +            !sc->memcg_low_reclaim))
>                 return 0;
>
>         *need_aging = should_run_aging(lruvec, max_seq, min_seq, sc, can_swap, &nr_to_scan);
> @@ -6048,13 +6049,13 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>
>                 mem_cgroup_calculate_protection(target_memcg, memcg);
>
> -               if (mem_cgroup_below_min(memcg)) {
> +               if (mem_cgroup_below_min(target_memcg, memcg)) {
>                         /*
>                          * Hard protection.
>                          * If there is no reclaimable memory, OOM.
>                          */
>                         continue;
> -               } else if (mem_cgroup_below_low(memcg)) {
> +               } else if (mem_cgroup_below_low(target_memcg, memcg)) {
>                         /*
>                          * Soft protection.
>                          * Respect the protection only as long as
> --
> 2.39.0.rc0.267.gcb52ba06e7-goog
>

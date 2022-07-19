Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4EB457A56C
	for <lists+cgroups@lfdr.de>; Tue, 19 Jul 2022 19:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239430AbiGSRdN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Jul 2022 13:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239403AbiGSRdM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Jul 2022 13:33:12 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792A552FDB
        for <cgroups@vger.kernel.org>; Tue, 19 Jul 2022 10:33:10 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id n12so9808342wrc.8
        for <cgroups@vger.kernel.org>; Tue, 19 Jul 2022 10:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=18UozrYQB3+N/uyawlirk943xVn88U5X+z32ZMLXCGo=;
        b=O5iei60WtGA9HTWVwtZvNrWdglW4/lET9ZfKnp/NKRE+Ss7KUkiJpz3chEr2sOXmDo
         mvqzxODAIjrA25ttIgg2+zbLWuVbs1ha4QI4cLZ7296BzblFTcWEDCRq6yvu9KN6UlVX
         zf1phKGy9cgE1gvZp9aXTYzwAg+KPn6oC8CMoYwhNVMfjGYaVo/sABFOdl+k0hwh6d8t
         qjrkoFGu7h7KIghlAS4nCjXudXOJXveK+aEw6DZBrB+7xiDuxZEQu3IdudzZ/Z89FBPa
         9lZUlunEwEOspocjjcIQFcEN/U1tIZdH2U/S5d04cckRvp6JXKho7daVCAWQCrF8wnAs
         2z5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=18UozrYQB3+N/uyawlirk943xVn88U5X+z32ZMLXCGo=;
        b=8BMKF4vM5HFsukhucZYFtr129m4urX6//Oz4zgfQIAw72CwG1f1FBBbjkMGdvBPO0E
         5wlzykf5xjiRdf3VtgkK5OAV5I6ht/h5JUCya/45oKT2oKU8JzSBXVdO6SyHWmc9FpW5
         8vMGYLBDh5DtOq0yWgyVogvcMaDopPF2OZQzrhLe9hQ8JZkxx2S+PI8Xb1QwZqni364f
         hSwvX1j7QdVihIWNaF04coYTenl/N2PoIkRgz3pFKEOT+EdGR6vgdd0+q7ANR4zdaqPm
         ZaOHh8+t3EqMwTkQGB2Ep2KUyg9htmghVtz2Yxa3fJF4g5YB3DqOcr9p0rUKlB47oc5e
         5+LQ==
X-Gm-Message-State: AJIora+2APU5748Iem+gWJ2LcX+h82nNsM39l5+7LHZl5iZADCCcYdxv
        r3QRHFOnYvJ+6vvIbUeZ0iIZhRL7oYrm0cj42TCuGg==
X-Google-Smtp-Source: AGRyM1uINnUq7krNCzysvu0xzE6CpKem20vT20SC69r/i7LbVibA62UnZPb5fm3KMV1KbD8z5K7s7sMk6Vi7JoCrGrA=
X-Received: by 2002:a05:6000:156f:b0:21d:887f:8ddf with SMTP id
 15-20020a056000156f00b0021d887f8ddfmr27447158wrz.534.1658251988810; Tue, 19
 Jul 2022 10:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220714064918.2576464-1-yosryahmed@google.com>
In-Reply-To: <20220714064918.2576464-1-yosryahmed@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 19 Jul 2022 10:32:32 -0700
Message-ID: <CAJD7tkZ1hrX0t_pNq=-LcK_ThX+jk0jRzbAedEyc1gYtw1LKHA@mail.gmail.com>
Subject: Re: [PATCH v4] mm: vmpressure: don't count proactive reclaim in vmpressure
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>, NeilBrown <neilb@suse.de>,
        Alistair Popple <apopple@nvidia.com>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Peter Xu <peterx@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
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

On Wed, Jul 13, 2022 at 11:49 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> vmpressure is used in cgroup v1 to notify userspace of reclaim
> efficiency events, and is also used in both cgroup v1 and v2 as a signal
> for memory pressure for networking, see
> mem_cgroup_under_socket_pressure().
>
> Proactive reclaim intends to probe memcgs for cold memory, without
> affecting their performance. Hence, reclaim caused by writing to
> memory.reclaim should not trigger vmpressure.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Acked-by: Shakeel Butt <shakeelb@google.com>
> ---
> Changes in v4:
> - Removed unneeded reclaim_options local variables (Andrew).
>
> Changes in v3:
> - Limited the vmpressure change to memory.reclaim, dropped psi changes,
>   updated changelog to reflect new behavior (Michal, Shakeel)
>
> Changes in v2:
> - Removed unnecessary initializations to zero (Andrew).
> - Separate declarations and initializations when it causes line wrapping
>   (Andrew).
>
> ---
>  include/linux/swap.h |  5 ++++-
>  mm/memcontrol.c      | 24 ++++++++++++++----------
>  mm/vmscan.c          | 27 +++++++++++++++++----------
>  3 files changed, 35 insertions(+), 21 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 0c0fed1b348f..f6e9eaa2339f 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -411,10 +411,13 @@ extern void lru_cache_add_inactive_or_unevictable(struct page *page,
>  extern unsigned long zone_reclaimable_pages(struct zone *zone);
>  extern unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
>                                         gfp_t gfp_mask, nodemask_t *mask);
> +
> +#define MEMCG_RECLAIM_MAY_SWAP (1 << 1)
> +#define MEMCG_RECLAIM_PROACTIVE (1 << 2)
>  extern unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>                                                   unsigned long nr_pages,
>                                                   gfp_t gfp_mask,
> -                                                 bool may_swap);
> +                                                 unsigned int reclaim_options);
>  extern unsigned long mem_cgroup_shrink_node(struct mem_cgroup *mem,
>                                                 gfp_t gfp_mask, bool noswap,
>                                                 pg_data_t *pgdat,
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index a550042d88c3..b668224142c7 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2331,7 +2331,8 @@ static unsigned long reclaim_high(struct mem_cgroup *memcg,
>
>                 psi_memstall_enter(&pflags);
>                 nr_reclaimed += try_to_free_mem_cgroup_pages(memcg, nr_pages,
> -                                                            gfp_mask, true);
> +                                                       gfp_mask,
> +                                                       MEMCG_RECLAIM_MAY_SWAP);
>                 psi_memstall_leave(&pflags);
>         } while ((memcg = parent_mem_cgroup(memcg)) &&
>                  !mem_cgroup_is_root(memcg));
> @@ -2576,7 +2577,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>         struct page_counter *counter;
>         unsigned long nr_reclaimed;
>         bool passed_oom = false;
> -       bool may_swap = true;
> +       unsigned int reclaim_options = MEMCG_RECLAIM_MAY_SWAP;
>         bool drained = false;
>         unsigned long pflags;
>
> @@ -2593,7 +2594,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>                 mem_over_limit = mem_cgroup_from_counter(counter, memory);
>         } else {
>                 mem_over_limit = mem_cgroup_from_counter(counter, memsw);
> -               may_swap = false;
> +               reclaim_options &= ~MEMCG_RECLAIM_MAY_SWAP;
>         }
>
>         if (batch > nr_pages) {
> @@ -2620,7 +2621,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>
>         psi_memstall_enter(&pflags);
>         nr_reclaimed = try_to_free_mem_cgroup_pages(mem_over_limit, nr_pages,
> -                                                   gfp_mask, may_swap);
> +                                                   gfp_mask, reclaim_options);
>         psi_memstall_leave(&pflags);
>
>         if (mem_cgroup_margin(mem_over_limit) >= nr_pages)
> @@ -3402,8 +3403,8 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
>                         continue;
>                 }
>
> -               if (!try_to_free_mem_cgroup_pages(memcg, 1,
> -                                       GFP_KERNEL, !memsw)) {
> +               if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
> +                                       memsw ? 0 : MEMCG_RECLAIM_MAY_SWAP)) {
>                         ret = -EBUSY;
>                         break;
>                 }
> @@ -3513,7 +3514,8 @@ static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
>                 if (signal_pending(current))
>                         return -EINTR;
>
> -               if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL, true))
> +               if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
> +                                                 MEMCG_RECLAIM_MAY_SWAP))
>                         nr_retries--;
>         }
>
> @@ -6248,7 +6250,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
>                 }
>
>                 reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
> -                                                        GFP_KERNEL, true);
> +                                       GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP);
>
>                 if (!reclaimed && !nr_retries--)
>                         break;
> @@ -6297,7 +6299,7 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
>
>                 if (nr_reclaims) {
>                         if (!try_to_free_mem_cgroup_pages(memcg, nr_pages - max,
> -                                                         GFP_KERNEL, true))
> +                                       GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP))
>                                 nr_reclaims--;
>                         continue;
>                 }
> @@ -6426,6 +6428,7 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
>         struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
>         unsigned int nr_retries = MAX_RECLAIM_RETRIES;
>         unsigned long nr_to_reclaim, nr_reclaimed = 0;
> +       unsigned int reclaim_options;
>         int err;
>
>         buf = strstrip(buf);
> @@ -6433,6 +6436,7 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
>         if (err)
>                 return err;
>
> +       reclaim_options = MEMCG_RECLAIM_MAY_SWAP | MEMCG_RECLAIM_PROACTIVE;
>         while (nr_reclaimed < nr_to_reclaim) {
>                 unsigned long reclaimed;
>
> @@ -6449,7 +6453,7 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
>
>                 reclaimed = try_to_free_mem_cgroup_pages(memcg,
>                                                 nr_to_reclaim - nr_reclaimed,
> -                                               GFP_KERNEL, true);
> +                                               GFP_KERNEL, reclaim_options);
>
>                 if (!reclaimed && !nr_retries--)
>                         return -EAGAIN;
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index f7d9a683e3a7..0969e6408a53 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -102,6 +102,9 @@ struct scan_control {
>         /* Can pages be swapped as part of reclaim? */
>         unsigned int may_swap:1;
>
> +       /* Proactive reclaim invoked by userspace through memory.reclaim */
> +       unsigned int proactive:1;
> +
>         /*
>          * Cgroup memory below memory.low is protected as long as we
>          * don't threaten to OOM. If any cgroup is reclaimed at
> @@ -3125,9 +3128,10 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>                             sc->priority);
>
>                 /* Record the group's reclaim efficiency */
> -               vmpressure(sc->gfp_mask, memcg, false,
> -                          sc->nr_scanned - scanned,
> -                          sc->nr_reclaimed - reclaimed);
> +               if (!sc->proactive)
> +                       vmpressure(sc->gfp_mask, memcg, false,
> +                                  sc->nr_scanned - scanned,
> +                                  sc->nr_reclaimed - reclaimed);
>
>         } while ((memcg = mem_cgroup_iter(target_memcg, memcg, NULL)));
>  }
> @@ -3250,9 +3254,10 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>         }
>
>         /* Record the subtree's reclaim efficiency */
> -       vmpressure(sc->gfp_mask, sc->target_mem_cgroup, true,
> -                  sc->nr_scanned - nr_scanned,
> -                  sc->nr_reclaimed - nr_reclaimed);
> +       if (!sc->proactive)
> +               vmpressure(sc->gfp_mask, sc->target_mem_cgroup, true,
> +                          sc->nr_scanned - nr_scanned,
> +                          sc->nr_reclaimed - nr_reclaimed);
>
>         if (sc->nr_reclaimed - nr_reclaimed)
>                 reclaimable = true;
> @@ -3534,8 +3539,9 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
>                 __count_zid_vm_events(ALLOCSTALL, sc->reclaim_idx, 1);
>
>         do {
> -               vmpressure_prio(sc->gfp_mask, sc->target_mem_cgroup,
> -                               sc->priority);
> +               if (!sc->proactive)
> +                       vmpressure_prio(sc->gfp_mask, sc->target_mem_cgroup,
> +                                       sc->priority);
>                 sc->nr_scanned = 0;
>                 shrink_zones(zonelist, sc);
>
> @@ -3825,7 +3831,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
>  unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>                                            unsigned long nr_pages,
>                                            gfp_t gfp_mask,
> -                                          bool may_swap)
> +                                          unsigned int reclaim_options)
>  {
>         unsigned long nr_reclaimed;
>         unsigned int noreclaim_flag;
> @@ -3838,7 +3844,8 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>                 .priority = DEF_PRIORITY,
>                 .may_writepage = !laptop_mode,
>                 .may_unmap = 1,
> -               .may_swap = may_swap,
> +               .may_swap = !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP),
> +               .proactive = !!(reclaim_options & MEMCG_RECLAIM_PROACTIVE),
>         };
>         /*
>          * Traverse the ZONELIST_FALLBACK zonelist of the current node to put
> --
> 2.37.0.144.g8ac04bfd2-goog
>

Hey Michal,

Any outstanding comments/thoughts on this version?

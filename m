Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15ED457D2A0
	for <lists+cgroups@lfdr.de>; Thu, 21 Jul 2022 19:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiGURgF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Jul 2022 13:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiGURgE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Jul 2022 13:36:04 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9FF1C908
        for <cgroups@vger.kernel.org>; Thu, 21 Jul 2022 10:36:03 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id n12so3259440wrc.8
        for <cgroups@vger.kernel.org>; Thu, 21 Jul 2022 10:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Na83GLwCB/Ikgx6Noh8+XTgmPbAsH902ujNlPIOcVGs=;
        b=r6ULngRB+8GAmdqDStkLE+KPIQ6jRlyj1kHUWzOqRLikp+af39s+28HNFK6dDMQg/I
         72xDl5Bprlr2S5ykroIVvAuow8pQjxyb1N8Xnbnoqr8Fpjq7vfWA511d0YjOMV9MHJ3j
         /SfIzlIk9Ut0A44FaVSQiBcOV1XHYaSCRC/MBdCR5sWHhBRzhCV1pntykTCz4jlEP8Zq
         n5X4JZ2T+l1/ZgalOKP5WmV9OV6hjUAuNhaarPzktnwEFjevhyQL1f9CUwiMX1U9Qm20
         w3LZ4D0CJ0xiE+OL0KE7lDX56XRVyswCLv5FyLNQDukLh1E/MELykLGtETtwyIaW9bwI
         LxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Na83GLwCB/Ikgx6Noh8+XTgmPbAsH902ujNlPIOcVGs=;
        b=FC37plJzbzsKyQ7YmVHnqPTI3w+PDiJ0VksQ3kuDrpJ8cNm1+KBUThVVJy64/qSp5C
         YkIHmrRLR9pBZzANro1GHh2DfuXeVvP4Hhy6fFlHfPV+j93hkvZ9GCKQe6yoxPH6/0rV
         1E5RpgjRQdYCK5mfx6twqgYAD+svW6Y84N5vqUy6mn5bSqrTPBlT/vMjupS9z9q/Npho
         w1dUPdWQH9R+hoX9Rbpe7HQYsD5TLV/K79EVMrty+zBGSdGL0cziKniUXA8Vbe1uruKC
         11WfqbrFJqOwucqP0GCPw/aL/vO5wdWV8WWKYadGuDNGLGXtdT21+a6dnFRIIy55Puw+
         g/jg==
X-Gm-Message-State: AJIora/MumQmyejOoY0yKLVPPSwyHXtc+6lHuzsbYZd0lh0B98Pn4V2O
        yScuAp8mRVAx4ChTS02OYbYL9UBis5aVGSmLlxm6XA==
X-Google-Smtp-Source: AGRyM1spHrv6wgWlCOZz1I6T529ESVH9ZZYU+172Xr0Hj54IzEpre5To0A/bUY3Mvwz1dWdPUfoUXP3S5unEM0GZGhE=
X-Received: by 2002:a05:6000:156f:b0:21d:887f:8ddf with SMTP id
 15-20020a056000156f00b0021d887f8ddfmr35382533wrz.534.1658424961533; Thu, 21
 Jul 2022 10:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220721173015.2643248-1-yosryahmed@google.com>
In-Reply-To: <20220721173015.2643248-1-yosryahmed@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 21 Jul 2022 10:35:25 -0700
Message-ID: <CAJD7tkZVZn4uUNXWSf+ABioUs53xX5VrLTpSPbboJtCJ8ie6_Q@mail.gmail.com>
Subject: Re: [PATCH v5] mm: vmpressure: don't count proactive reclaim in vmpressure
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>, NeilBrown <neilb@suse.de>,
        Alistair Popple <apopple@nvidia.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Peter Xu <peterx@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Ugh I forgot the changelog and Shakeel's Ack. Sorry Andrew.

On Thu, Jul 21, 2022 at 10:30 AM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> memory.reclaim is a cgroup v2 interface that allows users to
> proactively reclaim memory from a memcg, without real memory pressure.
> Reclaim operations invoke vmpressure, which is used:
> (a) To notify userspace of reclaim efficiency in cgroup v1, and
> (b) As a signal for a memcg being under memory pressure for networking
> (see mem_cgroup_under_socket_pressure()).
>
> For (a), vmpressure notifications in v1 are not affected by this change
> since memory.reclaim is a v2 feature.
>
> For (b), the effects of the vmpressure signal (according to Shakeel [1])
> are as follows:
> 1. Reducing send and receive buffers of the current socket.
> 2. May drop packets on the rx path.
> 3. May throttle current thread on the tx path.
>
> Since proactive reclaim is invoked directly by userspace, not by
> memory pressure, it makes sense not to throttle networking. Hence,
> this change makes sure that proactive reclaim caused by memory.reclaim
> does not trigger vmpressure.
>
> [1] https://lore.kernel.org/lkml/CALvZod68WdrXEmBpOkadhB5GPYmCXaDZzXH=yyGOCAjFRn4NDQ@mail.gmail.com/
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
---

Changes in v5:
- Rewrote commit log and added documentation of this (Michal).

Changes in v4:
- Removed unneeded reclaim_options local variables (Andrew).

Changes in v3:
- Limited the vmpressure change to memory.reclaim, dropped psi changes,
  updated changelog to reflect new behavior (Michal, Shakeel)

Changes in v2:
- Removed unnecessary initializations to zero (Andrew).
- Separate declarations and initializations when it causes line wrapping
  (Andrew).

> ---
>  Documentation/admin-guide/cgroup-v2.rst |  7 +++++++
>  include/linux/swap.h                    |  5 ++++-
>  mm/memcontrol.c                         | 24 +++++++++++++---------
>  mm/vmscan.c                             | 27 ++++++++++++++++---------
>  4 files changed, 42 insertions(+), 21 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 176298f2f4de..72847462c66d 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1229,6 +1229,13 @@ PAGE_SIZE multiple when read back.
>         the target cgroup. If less bytes are reclaimed than the
>         specified amount, -EAGAIN is returned.
>
> +       Please note that the proactive reclaim (triggered by this
> +       interface) is not meant to indicate memory pressure on the
> +       memory cgroup. Therefore socket memory balancing triggered by
> +       the memory reclaim normally is not exercised in this case.
> +       This means that the networking layer will not adapt based on
> +       reclaim induced by memory.reclaim.
> +
>    memory.peak
>         A read-only single value file which exists on non-root
>         cgroups.
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
> 2.37.1.359.gd136c6c3e2-goog
>

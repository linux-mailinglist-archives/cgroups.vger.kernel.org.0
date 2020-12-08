Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855572D3202
	for <lists+cgroups@lfdr.de>; Tue,  8 Dec 2020 19:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730948AbgLHSVS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Dec 2020 13:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730468AbgLHSVS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Dec 2020 13:21:18 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994C7C0613D6
        for <cgroups@vger.kernel.org>; Tue,  8 Dec 2020 10:20:37 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id f11so8865428ljm.8
        for <cgroups@vger.kernel.org>; Tue, 08 Dec 2020 10:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KtsL6yyTsdRfL58pMrd/cVVqUWZ3Qpi4P1xbGQ497SA=;
        b=VfSb6i7CO6ruLDo2yDHAEhRj3tkB7pO3suizcEQKb0xPFlkwllIbDZyW7RhQ2aHIXL
         FqhSKoj+RwzE27HoBNjxdTU1dOo/wAQj7siOo+Y/ntWjoy6QLYQKBWOeNygpzbQteutN
         fZEnylSc/DaG6VqYLY/J9G8QyAnXOutvRYZc+CKHbPktW/vRLVM7V8LzwdHzH17j8FZy
         +xpZeE6qCWRnmjpkjPsgi3YvVLcG3w0mUm7KYzQJ7juXJWwfXBnPatgmtyNVQkUI0iTs
         ToO+3bSGVHkKXYjceu0ANnh30hjqfInU2RExCqJh4nSu3wGSyut5MmtTujBveXeXzIoj
         rh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KtsL6yyTsdRfL58pMrd/cVVqUWZ3Qpi4P1xbGQ497SA=;
        b=e6EUYqJ2z3NQHdMwVC/CXaUt3T9+zOkE2Us2kEfMZa/9ID2HWGV1XkWBRAGhO6VdtP
         7sS3fmOu2022YS3n9S7jdy5q6a6LH1xoGZzeU5G3FYGhjn4ND9EwpNDrs6V7uSXb26h6
         NAjTkGUGdl3HF/kjLnB39N7AUFdYM+8ne1EBa/VX6V/rS7IESwCJDtc6i/GTpIhQjBoQ
         I3S27JomDIBlNYOcrf06y1/YY4Snn4t+k+J4VvmPHAVjHaQW9v9KoQnKK1PDcH3CVWhi
         zlXaf0bp+jDHIQ6F1VLJoRALrcUKP4mpKO8xWaJ4WyZG7lmnvs441MFKhAGxNmBdPPzy
         BWDw==
X-Gm-Message-State: AOAM532Lw1++DlLJ/FjLCj1Sd9e3zM5E40QcbJcocrW8Px3Bun/9cw8u
        6icdxBJxt+O4Tmn/9kt26Mwukq8Tsn8+SGSGEdjNZQ==
X-Google-Smtp-Source: ABdhPJyWaxVyzu/eCzLpxSL+BGt4RdiR3UrrzgqIuDxvzKnwDQHOd8dkCSuOJ8JoJW3sLaUTpeXKNzNTKof/w5DUcC4=
X-Received: by 2002:a05:651c:234:: with SMTP id z20mr1321110ljn.456.1607451634599;
 Tue, 08 Dec 2020 10:20:34 -0800 (PST)
MIME-Version: 1.0
References: <20201208095132.79383-1-songmuchun@bytedance.com>
In-Reply-To: <20201208095132.79383-1-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 8 Dec 2020 10:20:23 -0800
Message-ID: <CALvZod7Zt3v-g5gZYUST7_snXPoUijDzPkBT-Kf-ncxpE4W7ng@mail.gmail.com>
Subject: Re: [PATCH v2] mm: memcontrol: optimize per-lruvec stats counter
 memory usage
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Dec 8, 2020 at 1:53 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> The vmstat threshold is 32 (MEMCG_CHARGE_BATCH), so the type of s32
> of lruvec_stat_cpu is enough. And introduce struct per_cpu_lruvec_stat
> to optimize memory usage.
>
> The size of struct lruvec_stat is 304 bytes on 64 bits system. As it
> is a per-cpu structure. So with this patch, we can save 304 / 2 * ncpu
> bytes per-memcg per-node where ncpu is the number of the possible CPU.
> If there are c memory cgroup (include dying cgroup) and n NUMA node in
> the system. Finally, we can save (152 * ncpu * c * n) bytes.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Few nits below:

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> ---
> Changes in v1 -> v2:
>  - Update the commit log to point out how many bytes that we can save.
>
>  include/linux/memcontrol.h |  6 +++++-
>  mm/memcontrol.c            | 10 +++++++++-
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 3febf64d1b80..290d6ec8535a 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -92,6 +92,10 @@ struct lruvec_stat {
>         long count[NR_VM_NODE_STAT_ITEMS];
>  };
>
> +struct per_cpu_lruvec_stat {

lruvec_stat is also per-cpu, so the name per_cpu_lruvec_stat does not
really tell why it is different from lruvec. Maybe name is
batched_lruvec_stat or something else.

> +       s32 count[NR_VM_NODE_STAT_ITEMS];
> +};
> +
>  /*
>   * Bitmap of shrinker::id corresponding to memcg-aware shrinkers,
>   * which have elements charged to this memcg.
> @@ -111,7 +115,7 @@ struct mem_cgroup_per_node {
>         struct lruvec_stat __percpu *lruvec_stat_local;

A comment for the above why it still needs to be lruvec_stat.

>
>         /* Subtree VM stats (batched updates) */
> -       struct lruvec_stat __percpu *lruvec_stat_cpu;
> +       struct per_cpu_lruvec_stat __percpu *lruvec_stat_cpu;
>         atomic_long_t           lruvec_stat[NR_VM_NODE_STAT_ITEMS];
>
>         unsigned long           lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index eec44918d373..da6dc6ca388d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5198,7 +5198,7 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
>                 return 1;
>         }
>
> -       pn->lruvec_stat_cpu = alloc_percpu_gfp(struct lruvec_stat,
> +       pn->lruvec_stat_cpu = alloc_percpu_gfp(struct per_cpu_lruvec_stat,
>                                                GFP_KERNEL_ACCOUNT);
>         if (!pn->lruvec_stat_cpu) {
>                 free_percpu(pn->lruvec_stat_local);
> @@ -7089,6 +7089,14 @@ static int __init mem_cgroup_init(void)
>  {
>         int cpu, node;
>
> +       /*
> +        * Currently s32 type (can refer to struct per_cpu_lruvec_stat) is
> +        * used for per-memcg-per-cpu caching of per-node statistics. In order
> +        * to work fine, we should make sure that the overfill threshold can't
> +        * exceed S32_MAX / PAGE_SIZE.
> +        */
> +       BUILD_BUG_ON(MEMCG_CHARGE_BATCH > S32_MAX / PAGE_SIZE);
> +
>         cpuhp_setup_state_nocalls(CPUHP_MM_MEMCQ_DEAD, "mm/memctrl:dead", NULL,
>                                   memcg_hotplug_cpu_dead);
>
> --
> 2.11.0
>

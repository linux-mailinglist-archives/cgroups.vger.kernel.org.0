Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA22F259D
	for <lists+cgroups@lfdr.de>; Thu,  7 Nov 2019 03:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733104AbfKGCwL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 6 Nov 2019 21:52:11 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37347 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733102AbfKGCwL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 6 Nov 2019 21:52:11 -0500
Received: by mail-ot1-f68.google.com with SMTP id d5so724522otp.4
        for <cgroups@vger.kernel.org>; Wed, 06 Nov 2019 18:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QrlsmiSp9MaTLUUYnVA3xTtIb+I1YUcCTslV0/OmSFI=;
        b=YWUaaCR128DURGqWr9aDknrAFS+YYlD99jyCFzrnkBJytTen48x97ZotJo5kZT3QYa
         ZjUE1oID3Dz3eEh0vpwgEwGeKs1IlCU141yRD3Ii3VpOrdmuUt1pXff6VBBrmPDXf5BR
         qXBM00zj3eBtlE8qYCpEysmNqZNhlKyUyCZKV/BxMWYzxoRprgj3lbp8NIAqz2rLFUpO
         z7KJKXpi8gtqrRNZgvaqQz1TR+YS3y5+HWIU9XjnZ22K3cvZzhrU+m8RD2I10tL57kPA
         EJd3iqWEZrVXgSl0eXR0vr+OCwqGyOaSN396/nYQDmw7ApNC7AemBk6nrILEpvaB45N8
         B34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QrlsmiSp9MaTLUUYnVA3xTtIb+I1YUcCTslV0/OmSFI=;
        b=gxql3CGmzcFVBS6c3+i1dKvLOFbvxDnHGuRsbK1JxIzNy4+pojR7WnnVxgb2JrZZ8s
         l1sMAzl1dLLIV/I0OlMd1vVggOz+CXwbyjwsZzkB5hrW5MzZQ08zlcDv6XNC7d6ICDIY
         dwV287k9frs5jT7BtPWZjAPFVVdMC6GQYL/NyrU8h3dI0f1QMMDodANsWohHHhe/ajIG
         pMO3G9D5QA25w1C79dIiE9KkB2r6c4gs3Wz7FrGNtwu+EJHRF4fz0HWU2Ly8upPpZjiZ
         IMeUOSxvy2U3hLYf3MU8iLtCVL4Qgbu09oaIemb1b9//rUmh8fOQ6vFwN+ggJ0yt3KSC
         oMmg==
X-Gm-Message-State: APjAAAUwMGjeGOXqmBtJQOx/LKmeuytn+2unZFSmMsOCvu0RZeHDcUIZ
        NhweSAOxQauM9OfM9EmmwuPkJLCVr+TEVZ1TBu3egg==
X-Google-Smtp-Source: APXvYqxOEA6/MtSOLc+2Sk75LPiZD356yYgPUUdsBFVv+mxA1p5VnjYskNRQd2hJyi8yasnt75D22lhdfdnhROetgTM=
X-Received: by 2002:a9d:5e10:: with SMTP id d16mr886624oti.191.1573095130142;
 Wed, 06 Nov 2019 18:52:10 -0800 (PST)
MIME-Version: 1.0
References: <20190603210746.15800-1-hannes@cmpxchg.org> <20190603210746.15800-8-hannes@cmpxchg.org>
In-Reply-To: <20190603210746.15800-8-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 6 Nov 2019 18:51:59 -0800
Message-ID: <CALvZod7EFBD0SCoUFHacEtZqi7hcZ3S6FEZRmfJJORre3dxRtQ@mail.gmail.com>
Subject: Re: [PATCH 07/11] mm: vmscan: split shrink_node() into node part and
 memcgs part
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

On Mon, Jun 3, 2019 at 3:00 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> This function is getting long and unwieldy. The new shrink_node()
> handles the generic (node) reclaim aspects:
>   - global vmpressure notifications
>   - writeback and congestion throttling
>   - reclaim/compaction management
>   - kswapd giving up on unreclaimable nodes
>
> It then calls shrink_node_memcgs() which handles cgroup specifics:
>   - the cgroup tree traversal
>   - memory.low considerations
>   - per-cgroup slab shrinking callbacks
>   - per-cgroup vmpressure notifications
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>


> ---
>  mm/vmscan.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index b85111474ee2..ee79b39d0538 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2665,24 +2665,15 @@ static bool pgdat_memcg_congested(pg_data_t *pgdat, struct mem_cgroup *memcg)
>                 (memcg && memcg_congested(pgdat, memcg));
>  }
>
> -static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> +static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>  {
> -       struct reclaim_state *reclaim_state = current->reclaim_state;
>         struct mem_cgroup *root = sc->target_mem_cgroup;
>         struct mem_cgroup_reclaim_cookie reclaim = {
>                 .pgdat = pgdat,
>                 .priority = sc->priority,
>         };
> -       unsigned long nr_reclaimed, nr_scanned;
> -       bool reclaimable = false;
>         struct mem_cgroup *memcg;
>
> -again:
> -       memset(&sc->nr, 0, sizeof(sc->nr));
> -
> -       nr_reclaimed = sc->nr_reclaimed;
> -       nr_scanned = sc->nr_scanned;
> -
>         memcg = mem_cgroup_iter(root, NULL, &reclaim);
>         do {
>                 struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
> @@ -2750,6 +2741,22 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>                         break;
>                 }
>         } while ((memcg = mem_cgroup_iter(root, memcg, &reclaim)));
> +}
> +
> +static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> +{
> +       struct reclaim_state *reclaim_state = current->reclaim_state;
> +       struct mem_cgroup *root = sc->target_mem_cgroup;
> +       unsigned long nr_reclaimed, nr_scanned;
> +       bool reclaimable = false;
> +
> +again:
> +       memset(&sc->nr, 0, sizeof(sc->nr));
> +
> +       nr_reclaimed = sc->nr_reclaimed;
> +       nr_scanned = sc->nr_scanned;
> +
> +       shrink_node_memcgs(pgdat, sc);
>
>         if (reclaim_state) {
>                 sc->nr_reclaimed += reclaim_state->reclaimed_slab;
> @@ -2757,7 +2764,7 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>         }
>
>         /* Record the subtree's reclaim efficiency */
> -       vmpressure(sc->gfp_mask, sc->target_mem_cgroup, true,
> +       vmpressure(sc->gfp_mask, root, true,
>                    sc->nr_scanned - nr_scanned,
>                    sc->nr_reclaimed - nr_reclaimed);
>
> --
> 2.21.0
>

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 018E9F259B
	for <lists+cgroups@lfdr.de>; Thu,  7 Nov 2019 03:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732721AbfKGCwE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 6 Nov 2019 21:52:04 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44890 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbfKGCwE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 6 Nov 2019 21:52:04 -0500
Received: by mail-oi1-f193.google.com with SMTP id s71so627919oih.11
        for <cgroups@vger.kernel.org>; Wed, 06 Nov 2019 18:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kDdLz2dgz8WJIiGMPPdO9wrz/4A63qBVRe550gS0EUs=;
        b=bG2hARxlz9n/7uJUPESjTyuodO57X2/iCCk60Vl5V8zXwbQnnPstUSNKmrtIQ5HD3k
         epZTCMPvKmhpCHIOmLmmlN/MNEojn488H/JwDjSelciE6M0ds2/v36CNQWAstLIldGen
         L0DzEVJup+j3Tk55B4PcGE0F0HlfLIi4E0wiXL41BtXNYZrPkrjuvibgOL0Y6/dRh3WF
         +0rP/IgC9qirNn+Ftu0BchZ64hVBMeLUbHzslk/uENviWfrpjvxFzhdKdp4FOcVLDEXy
         429yPE0Hjjq6iNirVRV20WqQ6yzYriGgRi3YjwVIcs5bOxjI5WlCIPsk6RuvQfTmRL3t
         pfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kDdLz2dgz8WJIiGMPPdO9wrz/4A63qBVRe550gS0EUs=;
        b=C1mGMqbTksdNNjQW+WbA4gt0lca1xA4NLsZMIiQ8ICYcmG3at4d2cDZ4YA9Zi333Sj
         CRL0JDg6KqUuZ+yeA4M181aEKrxTkCEMpku/HT9hKfV5QbzpKORt0Ze4CTPajNaHAAPO
         6sGlK6kzbU+SRsPHPFRFZsUMgkoh4rJ+cilRxiqaJh+22WImnu3/TQCY43pBbDwHTcQh
         EyZe5fUV7JUxuv8A7ZTUvUjsrxSWILPTEYHdlDSYAwZypE4aNdbfRO1GfKsZD9+djBCJ
         Rkm2UYz+qums1ic21Nog6RpAItc+RDG1chsPnAJYu6l/Iw58JavUnq/jXueTKGtLQCuj
         sq9A==
X-Gm-Message-State: APjAAAUce+8s7XFUSPJThLfk1lnVK3HGVvJtXiPTra5d804Q/LzMOtKi
        HAYxIXuRH3K0hCJaMksR1oHJT3ybtyAA15s692Ui+A==
X-Google-Smtp-Source: APXvYqygM9oGTHer3UTgB/MHwMQWhr4sQtlL4s9IR1zML8zAxx56zAmbgHIIWQqZ8bBe3Q1WUQjtGdo8/8cO0vJ3pRU=
X-Received: by 2002:aca:7516:: with SMTP id q22mr1098320oic.144.1573095122710;
 Wed, 06 Nov 2019 18:52:02 -0800 (PST)
MIME-Version: 1.0
References: <20190603210746.15800-1-hannes@cmpxchg.org> <20190603210746.15800-7-hannes@cmpxchg.org>
In-Reply-To: <20190603210746.15800-7-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 6 Nov 2019 18:51:51 -0800
Message-ID: <CALvZod4fCXrNd+uruEu6J3mjzRgHuK4Mu++fp-dH63Pfb11VHw@mail.gmail.com>
Subject: Re: [PATCH 06/11] mm: vmscan: turn shrink_node_memcg() into shrink_lruvec()
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

On Mon, Jun 3, 2019 at 3:07 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> A lruvec holds LRU pages owned by a certain NUMA node and cgroup.
> Instead of awkwardly passing around a combination of a pgdat and a
> memcg pointer, pass down the lruvec as soon as we can look it up.
>
> Nested callers that need to access node or cgroup properties can look
> them them up if necessary, but there are only a few cases.

*them

>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>


> ---
>  mm/vmscan.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 304974481146..b85111474ee2 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2210,9 +2210,10 @@ enum scan_balance {
>   * nr[0] = anon inactive pages to scan; nr[1] = anon active pages to scan
>   * nr[2] = file inactive pages to scan; nr[3] = file active pages to scan
>   */
> -static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
> -                          struct scan_control *sc, unsigned long *nr)
> +static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
> +                          unsigned long *nr)
>  {
> +       struct mem_cgroup *memcg = lruvec_memcg(lruvec);
>         int swappiness = mem_cgroup_swappiness(memcg);
>         struct zone_reclaim_stat *reclaim_stat = &lruvec->reclaim_stat;
>         u64 fraction[2];
> @@ -2460,13 +2461,8 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
>         }
>  }
>
> -/*
> - * This is a basic per-node page freer.  Used by both kswapd and direct reclaim.
> - */
> -static void shrink_node_memcg(struct pglist_data *pgdat, struct mem_cgroup *memcg,
> -                             struct scan_control *sc)
> +static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
>  {
> -       struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
>         unsigned long nr[NR_LRU_LISTS];
>         unsigned long targets[NR_LRU_LISTS];
>         unsigned long nr_to_scan;
> @@ -2476,7 +2472,7 @@ static void shrink_node_memcg(struct pglist_data *pgdat, struct mem_cgroup *memc
>         struct blk_plug plug;
>         bool scan_adjusted;
>
> -       get_scan_count(lruvec, memcg, sc, nr);
> +       get_scan_count(lruvec, sc, nr);
>
>         /* Record the original scan target for proportional adjustments later */
>         memcpy(targets, nr, sizeof(nr));
> @@ -2689,6 +2685,7 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>
>         memcg = mem_cgroup_iter(root, NULL, &reclaim);
>         do {
> +               struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
>                 unsigned long reclaimed;
>                 unsigned long scanned;
>
> @@ -2725,7 +2722,8 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>
>                 reclaimed = sc->nr_reclaimed;
>                 scanned = sc->nr_scanned;
> -               shrink_node_memcg(pgdat, memcg, sc);
> +
> +               shrink_lruvec(lruvec, sc);
>
>                 if (sc->may_shrinkslab) {
>                         shrink_slab(sc->gfp_mask, pgdat->node_id,
> @@ -3243,6 +3241,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
>                                                 pg_data_t *pgdat,
>                                                 unsigned long *nr_scanned)
>  {
> +       struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
>         struct scan_control sc = {
>                 .nr_to_reclaim = SWAP_CLUSTER_MAX,
>                 .target_mem_cgroup = memcg,
> @@ -3268,7 +3267,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
>          * will pick up pages from other mem cgroup's as well. We hack
>          * the priority and make it zero.
>          */
> -       shrink_node_memcg(pgdat, memcg, &sc);
> +       shrink_lruvec(lruvec, &sc);
>
>         trace_mm_vmscan_memcg_softlimit_reclaim_end(
>                                         cgroup_ino(memcg->css.cgroup),
> --
> 2.21.0
>

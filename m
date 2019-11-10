Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5025F6BB5
	for <lists+cgroups@lfdr.de>; Sun, 10 Nov 2019 23:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfKJWCb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 10 Nov 2019 17:02:31 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35694 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbfKJWCb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 10 Nov 2019 17:02:31 -0500
Received: by mail-wr1-f66.google.com with SMTP id s5so1471998wrw.2
        for <cgroups@vger.kernel.org>; Sun, 10 Nov 2019 14:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XiZ3YYvjZNzRtqsEDX9KtMzE3FSNUK/E0+y+ayqaNl8=;
        b=WtlaAoKErXP6oWh9i1Y6e6ZRKTHN70XjeRLT416hN1ckMpqtDzYCh+sR89mKX21gf/
         UDGPs7klFvQmfC2EAAEFjL5vS/p3ehYtYldNJeRbr/WD6n5UDaIfuAsJ84tzUJXOVNnW
         G3Abu0CUUlai+X19pH9le4z/OxWuKC8BmsSPo0G7gupdv5mRhUPE+X1bM2dOfcbu3Ws7
         QNytQroxH332qqmKc4uwHRCLX/hsRbWdu5DGiuagbPOTsYRrgKAipm2I72VJeTp3jlsE
         z4fjNZQrUd2PeXyAnKiCGzcAOeoYJynZd+8WoCvCk8xMv2Lxy5hFQakBkCZbSrZ1L0BV
         ypfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XiZ3YYvjZNzRtqsEDX9KtMzE3FSNUK/E0+y+ayqaNl8=;
        b=dZRj+xBeCbROwAkYdlUtGXbtU3kFpET31nJD/hBAAiowaSUCEwqp7RJk63e3kJXqJa
         Q7s4Er2//yndwL7P6IReNER96HZCVmzS9Lw+QwrCE2Mw9l15Yl87661w76Jx9eBETLhl
         sgV467KdupMIN3LHDhK1jj4cWOMdWvEzOzc8/Ex+ubrlcnG/0xWBUMOyzMMY3xYxj2tl
         6sdHSnJENMU6GQp1TPTimz4UVUBARCJ05kcGoziuIxt/xtuxI/Ea4z5j1A8Mix0AL/8H
         ukxMo/n5JdhZf9fchAfjNKqUDDMJcDWBnR5a6AUUxnHsXKqbRxbl3pLQuMztNZ5rPUdX
         DdMQ==
X-Gm-Message-State: APjAAAWWS/Xu44rYvxtfiJywAER2GwDSIe1y2SNg4HB47okX//JFRIqA
        Y/X2T5RKmvNTvkcz8xl0yZwJbh0vXaN1LpObz+Rueg==
X-Google-Smtp-Source: APXvYqxjTkVDpprPp4u4gnSTrHGrGKSEdluo8CwAzRvVSQ7VsQh1BJztEPLmWj5IOX9NHLA5GKd8dD9AIl8B0r+SNc8=
X-Received: by 2002:a5d:678c:: with SMTP id v12mr6403180wru.116.1573423348179;
 Sun, 10 Nov 2019 14:02:28 -0800 (PST)
MIME-Version: 1.0
References: <20191107205334.158354-1-hannes@cmpxchg.org> <20191107205334.158354-2-hannes@cmpxchg.org>
In-Reply-To: <20191107205334.158354-2-hannes@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Sun, 10 Nov 2019 14:02:17 -0800
Message-ID: <CAJuCfpGCoPoMAMTkjvJEAxvSG+3ttcpVyoOd48c=69qS=7Pa0Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: vmscan: move file exhaustion detection to the
 node level
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm <linux-mm@kvack.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Nov 7, 2019 at 12:53 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> When file pages are lower than the watermark on a node, we try to
> force scan anonymous pages to counter-act the balancing algorithms
> preference for new file pages when they are likely thrashing. This is
> a node-level decision, but it's currently made each time we look at an
> lruvec. This is unnecessarily expensive and also a layering violation
> that makes the code harder to understand.
>
> Clean this up by making the check once per node and setting a flag in
> the scan_control.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> ---
>  mm/vmscan.c | 80 ++++++++++++++++++++++++++++-------------------------
>  1 file changed, 42 insertions(+), 38 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index d97985262dda..e8dd601e1fad 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -101,6 +101,9 @@ struct scan_control {
>         /* One of the zones is ready for compaction */
>         unsigned int compaction_ready:1;
>
> +       /* The file pages on the current node are dangerously low */
> +       unsigned int file_is_tiny:1;
> +
>         /* Allocation order */
>         s8 order;
>
> @@ -2289,45 +2292,16 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
>         }
>
>         /*
> -        * Prevent the reclaimer from falling into the cache trap: as
> -        * cache pages start out inactive, every cache fault will tip
> -        * the scan balance towards the file LRU.  And as the file LRU
> -        * shrinks, so does the window for rotation from references.
> -        * This means we have a runaway feedback loop where a tiny
> -        * thrashing file LRU becomes infinitely more attractive than
> -        * anon pages.  Try to detect this based on file LRU size.
> +        * If the system is almost out of file pages, force-scan anon.
> +        * But only if there are enough inactive anonymous pages on
> +        * the LRU. Otherwise, the small LRU gets thrashed.
>          */
> -       if (!cgroup_reclaim(sc)) {
> -               unsigned long pgdatfile;
> -               unsigned long pgdatfree;
> -               int z;
> -               unsigned long total_high_wmark = 0;
> -
> -               pgdatfree = sum_zone_node_page_state(pgdat->node_id, NR_FREE_PAGES);
> -               pgdatfile = node_page_state(pgdat, NR_ACTIVE_FILE) +
> -                          node_page_state(pgdat, NR_INACTIVE_FILE);
> -
> -               for (z = 0; z < MAX_NR_ZONES; z++) {
> -                       struct zone *zone = &pgdat->node_zones[z];
> -                       if (!managed_zone(zone))
> -                               continue;
> -
> -                       total_high_wmark += high_wmark_pages(zone);
> -               }
> -
> -               if (unlikely(pgdatfile + pgdatfree <= total_high_wmark)) {
> -                       /*
> -                        * Force SCAN_ANON if there are enough inactive
> -                        * anonymous pages on the LRU in eligible zones.
> -                        * Otherwise, the small LRU gets thrashed.
> -                        */
> -                       if (!inactive_list_is_low(lruvec, false, sc, false) &&
> -                           lruvec_lru_size(lruvec, LRU_INACTIVE_ANON, sc->reclaim_idx)
> -                                       >> sc->priority) {
> -                               scan_balance = SCAN_ANON;
> -                               goto out;
> -                       }
> -               }
> +       if (sc->file_is_tiny &&
> +           !inactive_list_is_low(lruvec, false, sc, false) &&
> +           lruvec_lru_size(lruvec, LRU_INACTIVE_ANON,
> +                           sc->reclaim_idx) >> sc->priority) {
> +               scan_balance = SCAN_ANON;
> +               goto out;
>         }
>
>         /*
> @@ -2754,6 +2728,36 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>         nr_reclaimed = sc->nr_reclaimed;
>         nr_scanned = sc->nr_scanned;
>
> +       /*
> +        * Prevent the reclaimer from falling into the cache trap: as
> +        * cache pages start out inactive, every cache fault will tip
> +        * the scan balance towards the file LRU.  And as the file LRU
> +        * shrinks, so does the window for rotation from references.
> +        * This means we have a runaway feedback loop where a tiny
> +        * thrashing file LRU becomes infinitely more attractive than
> +        * anon pages.  Try to detect this based on file LRU size.
> +        */
> +       if (!cgroup_reclaim(sc)) {
> +               unsigned long file;
> +               unsigned long free;
> +               int z;
> +               unsigned long total_high_wmark = 0;
> +
> +               free = sum_zone_node_page_state(pgdat->node_id, NR_FREE_PAGES);
> +               file = node_page_state(pgdat, NR_ACTIVE_FILE) +
> +                          node_page_state(pgdat, NR_INACTIVE_FILE);
> +
> +               for (z = 0; z < MAX_NR_ZONES; z++) {
> +                       struct zone *zone = &pgdat->node_zones[z];
> +                       if (!managed_zone(zone))
> +                               continue;
> +
> +                       total_high_wmark += high_wmark_pages(zone);
> +               }
> +
> +               sc->file_is_tiny = file + free <= total_high_wmark;
> +       }
> +
>         shrink_node_memcgs(pgdat, sc);
>
>         if (reclaim_state) {
> --
> 2.24.0
>

Hi Johannes,
Thanks for working on this! On Android reclaim regression caused by
memcgs is a known issue and I'll try to test your patcheset next week.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

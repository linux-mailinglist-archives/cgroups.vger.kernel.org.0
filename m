Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7070EF25A2
	for <lists+cgroups@lfdr.de>; Thu,  7 Nov 2019 03:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbfKGCwi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 6 Nov 2019 21:52:38 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42841 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbfKGCwi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 6 Nov 2019 21:52:38 -0500
Received: by mail-oi1-f196.google.com with SMTP id i185so639822oif.9
        for <cgroups@vger.kernel.org>; Wed, 06 Nov 2019 18:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LKlERTl9DvESYF3m/JsPRK2Ra4f773JCe1klUlJdfm8=;
        b=hrYAJcfjB5EUPkKmDUrpuOx0lOQSIA3j08ysAaXeXLKb013qoG8F1U6i/uTp1u8D/j
         fqryyYhwNLlzpm+LXUPaswVejzLsCS+peFQOt/ppVHTmoWcZUa8qdu2HWkt9U0X6Ey73
         bUtJkqxyxnUdRj/m0t9D9khHaLSUXvAIoSrMmDg8DvTCTz6lsQVTFuRkNIeo1fX+sRiL
         cqrTz/Stsei5t2BjQwO4UxGaex6ar7Q1ucu7SJGWY3q+jUemNmuN7rCnaXM1QJugbHl3
         n0v+r+JzONbo2agmPVu+BpZpJiFWgEBy83Yb554Rkq/4yqOlT0krKIeXL5ohHFTBnhbJ
         0NQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LKlERTl9DvESYF3m/JsPRK2Ra4f773JCe1klUlJdfm8=;
        b=CbImFkDTHOkqzQzQcPdTlyKikWH+JnETpsaf1rvIEO5d6F+UENnmpnR/aG3E9q78jM
         JORhaZs2fUec5YUFemlvrE7VKERpTZ8Fzcf8uvEISFJyA3u4JBxf/ax7cbWX7749j2FP
         2GOUPZ4LbUFlCXdsz9Ogaw6UhS5sPqZyis5qQvMUgo+QuYGxC3UF1/RR/73c2Rb1deYI
         J1A0MbXjlWhXB8a9n0cIVidaXi6s0LPBKL88RP4f2BaFjGf6fPZlMXcnwPr8yOrsNM78
         QFgBLOXyXFDopc9i/5kL+zdagyLFZEjWJTHNhZoJRF8dFNSSwrIeqLyrY0aMtkeYtGkg
         OIvg==
X-Gm-Message-State: APjAAAXLmDXVovapFqcYjEDfCqPQ3Srpesv/FVd+/S3/DQ+fB9Xsj3a5
        hWdNqF7VE4L1lBz0hyZDpXEDo0eheqYwfHBY9Xm3AQ==
X-Google-Smtp-Source: APXvYqxLSyryF3fKienTgCOzEZBGe6VVLooYyUdjdZWIh5gWqNJaOwiIFMEpUA637TIkM9C7K86t7b/a/gCOhlrRXzw=
X-Received: by 2002:aca:4fce:: with SMTP id d197mr1237938oib.142.1573095155625;
 Wed, 06 Nov 2019 18:52:35 -0800 (PST)
MIME-Version: 1.0
References: <20190603210746.15800-1-hannes@cmpxchg.org> <20190603210746.15800-10-hannes@cmpxchg.org>
In-Reply-To: <20190603210746.15800-10-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 6 Nov 2019 18:52:23 -0800
Message-ID: <CALvZod6rYcJ4jimyaTTKUvXVZ4a3-G-+wqnRkV875u5npUUeAQ@mail.gmail.com>
Subject: Re: [PATCH 09/11] mm: vmscan: move file exhaustion detection to the
 node level
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

On Mon, Jun 3, 2019 at 3:08 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> When file pages are lower than the watermark on a node, we try to
> force scan anonymous pages to counter-act the balancing algorithms
> preference for new file pages when they are likely thrashing. This is
> node-level decision, but it's currently made each time we look at an
> lruvec. This is unnecessarily expensive and also a layering violation
> that makes the code harder to understand.
>
> Clean this up by making the check once per node and setting a flag in
> the scan_control.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>


> ---
>  mm/vmscan.c | 80 ++++++++++++++++++++++++++++-------------------------
>  1 file changed, 42 insertions(+), 38 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index eb535c572733..cabf94dfa92d 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -104,6 +104,9 @@ struct scan_control {
>         /* One of the zones is ready for compaction */
>         unsigned int compaction_ready:1;
>
> +       /* The file pages on the current node are dangerously low */
> +       unsigned int file_is_tiny:1;
> +
>         /* Allocation order */
>         s8 order;
>
> @@ -2219,45 +2222,16 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
>         }
>

Unrelated to the patch. I think we need to revisit all the heuristics
that were added here over the years. get_scan_count() has become
really complicated and weird.

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
> @@ -2718,6 +2692,36 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
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
> 2.21.0
>

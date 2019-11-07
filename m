Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72534F2595
	for <lists+cgroups@lfdr.de>; Thu,  7 Nov 2019 03:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733050AbfKGCvO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 6 Nov 2019 21:51:14 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41511 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732990AbfKGCvO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 6 Nov 2019 21:51:14 -0500
Received: by mail-ot1-f68.google.com with SMTP id 94so701754oty.8
        for <cgroups@vger.kernel.org>; Wed, 06 Nov 2019 18:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GKO7/fbdppvBINU5UzZk1jxJvjGwB3qbyKeLUMFG0WY=;
        b=lHGybIy/4+Wd5Xs4rFF43Igo7QNmIxIkOuOeO28hVod0YQrbdceC97gt53BQZ/IXhX
         5XUSf0vl69ZMl/BHL/QP2dXa5rAauS3uo4T33ETfaQHSlKrFGEKWmMkuA1mx95AcHix5
         x+/uzcZlA1JTfMck4Lia9FP9eTVtJHq8rJTe6Zd977QZlsYRi4cOhgWUCFGnv2iXZiyA
         1qfoMzmCQ3/yTKxORuIPubW5CpJM2JJczPR77EO8tyN+1q5X8jHiaB+vPpZ2r6SMTQNt
         f+gBkwqBIA7GiVBBHaRKE5Ooff8jHI6UtIccu7HdP9NybJy8Dp0ur2UrYxED2hpmKSPf
         PAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GKO7/fbdppvBINU5UzZk1jxJvjGwB3qbyKeLUMFG0WY=;
        b=LPqlZ4bZYrtCSMXuXZY1+4JeQLyuuRnP9QTNjjPK7S/mw9nkuecNUEvqz4KomWjKdf
         eOA+TVKbODJm7KAAtz2QxIhlsHFGE9JXSHfiIu5wlCbJ75O+mvpdBelYpAFe7bEuvANP
         D7TCOnleWoMeBWt1mKBFPwZw5A6RxozOK3FREcupTqzMxsv430hqqPuEofXIjgrjQCpY
         F9PSSEBV16fGXic8unsFjkfVP88cZfbthLBl1h8iCHiZK5gMtWoB5DjjYiOZFTzPLFyI
         P/GO6CV62i3ypGq/Zop9vaIQkrEBNCrpNOxXPxme61rIhF1sMKXQFy7/l+MbvRL3jrid
         5OUA==
X-Gm-Message-State: APjAAAWknXuAxbQbmCCQvd26XROCa0vUuUr18qoWZNtriE91FURI/fTT
        l6s9mSD38JT9fIkk6ZDHiFuyK/cv99t+LWooHgY1zg==
X-Google-Smtp-Source: APXvYqzzv7HIbB64JiAktrqXuieu+Qi+ofExLaTWbbpI/vhljtRTUn8VDqOTsN6GKkLyWX6YVdkOZMePuaQRtZtspAA=
X-Received: by 2002:a9d:71cc:: with SMTP id z12mr840037otj.124.1573095073108;
 Wed, 06 Nov 2019 18:51:13 -0800 (PST)
MIME-Version: 1.0
References: <20190603210746.15800-1-hannes@cmpxchg.org> <20190603210746.15800-4-hannes@cmpxchg.org>
In-Reply-To: <20190603210746.15800-4-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 6 Nov 2019 18:51:02 -0800
Message-ID: <CALvZod5ac0fmfD+92kg8nu4zV31ow95DJmvsTp8Rh4Ff+FhcXg@mail.gmail.com>
Subject: Re: [PATCH 03/11] mm: vmscan: simplify lruvec_lru_size()
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

On Mon, Jun 3, 2019 at 2:59 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> This function currently takes the node or lruvec size and subtracts
> the zones that are excluded by the classzone index of the
> allocation. It uses four different types of counters to do this.
>
> Just add up the eligible zones.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

I think this became part of other series. Anyways:

Reviewed-by: Shakeel Butt <shakeelb@google.com>


> ---
>  mm/vmscan.c | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 853be16ee5e2..69c4c82a9b5a 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -342,30 +342,21 @@ unsigned long zone_reclaimable_pages(struct zone *zone)
>   */
>  unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone_idx)
>  {
> -       unsigned long lru_size;
> +       unsigned long size = 0;
>         int zid;
>
> -       if (!mem_cgroup_disabled())
> -               lru_size = lruvec_page_state_local(lruvec, NR_LRU_BASE + lru);
> -       else
> -               lru_size = node_page_state(lruvec_pgdat(lruvec), NR_LRU_BASE + lru);
> -
> -       for (zid = zone_idx + 1; zid < MAX_NR_ZONES; zid++) {
> +       for (zid = 0; zid <= zone_idx; zid++) {
>                 struct zone *zone = &lruvec_pgdat(lruvec)->node_zones[zid];
> -               unsigned long size;
>
>                 if (!managed_zone(zone))
>                         continue;
>
>                 if (!mem_cgroup_disabled())
> -                       size = mem_cgroup_get_zone_lru_size(lruvec, lru, zid);
> +                       size += mem_cgroup_get_zone_lru_size(lruvec, lru, zid);
>                 else
> -                       size = zone_page_state(&lruvec_pgdat(lruvec)->node_zones[zid],
> -                                      NR_ZONE_LRU_BASE + lru);
> -               lru_size -= min(size, lru_size);
> +                       size += zone_page_state(zone, NR_ZONE_LRU_BASE + lru);
>         }
> -
> -       return lru_size;
> +       return size;
>
>  }
>
> --
> 2.21.0
>

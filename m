Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098AF2E3266
	for <lists+cgroups@lfdr.de>; Sun, 27 Dec 2020 19:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgL0SR3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 27 Dec 2020 13:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgL0SR2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 27 Dec 2020 13:17:28 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D91FC061795
        for <cgroups@vger.kernel.org>; Sun, 27 Dec 2020 10:16:47 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id m25so19423178lfc.11
        for <cgroups@vger.kernel.org>; Sun, 27 Dec 2020 10:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bnArJigGBdabFnIq+hfnR+zQf4osesgW3QYyMon5IsY=;
        b=v2G03nV+9gGBzxb5Ei6xCyhk+ThA79SlBStyTRawZsx+G7RliHUy1xcyejpJptiZBU
         yGDD7PKM2T9YXLbQW7nrtC5GOpsfUZ4d1pzWzGW8oKU421LZZ6drxDOdj/jdkVCfc/JM
         OzFy/key+ZtK/8CJ0MTeV4nuzBMcYxPB69traZy8+yV5mntyLFs+iiln39ZhOtLCzkhK
         RBhRCdIODMRuedFES95/c1byzajReyejDRWbmdEfw1V66l+gwg/k2DOrr36yv01RHECl
         08PqLzrZekSImPDElEQ/2xvnUcr/CymVw48DApfx7C+urzHwkO4GRvYg5oT7mAkhjnOs
         h5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bnArJigGBdabFnIq+hfnR+zQf4osesgW3QYyMon5IsY=;
        b=pTs4GtarmmVBVkB/PCmfv1X58JXj/GXQbPmWj+QwhzDnDgg80EVpWeIjTd2DIL4Ae1
         IqCW2XxHq/rBAB1H0pDab5goCx+mvJFRyVJtFi+LMUexf85OF1Iqy0ibTkXIM1iqse0y
         Y98kTfX2NuJmUdncVCcHJTcdC/8DNXkoYvgzLcGcyiDmX43D8TQqBWNyI2nVfZ60V3nS
         44aJ99hZ95GyvqxvXX4NTB42BfIwBJSdX1dI4EgAh/cbZLAqRc6J+MeRGcPPlt+zCHQ+
         KSeNod9qbHt4oq4INJrMK5ljAG+ph186K+KOSWeLbtKX1tYe8XjdxhWC/ZDOwX/aDsYj
         vKnQ==
X-Gm-Message-State: AOAM532MsCwvusVVPVK8Pdx8a0/ia1lUu6mOBfpbr2z2HbVeuSqm4ntN
        RfPAOh2q4iOljFhS9ls4M3lwxLHTaqDv4hoG7LpYc5CamcuufQ==
X-Google-Smtp-Source: ABdhPJwDYKZBXIYknNHaca3czY4qQ//XT+pNDroUzz129cq14PS/yME1kP4onu8WFtcbZBmG6ghGS3ZCRHe06MF2OAk=
X-Received: by 2002:ac2:47e7:: with SMTP id b7mr16818656lfp.117.1609093005766;
 Sun, 27 Dec 2020 10:16:45 -0800 (PST)
MIME-Version: 1.0
References: <20201227181310.3235210-1-shakeelb@google.com> <20201227181310.3235210-2-shakeelb@google.com>
In-Reply-To: <20201227181310.3235210-2-shakeelb@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sun, 27 Dec 2020 10:16:34 -0800
Message-ID: <CALvZod5bH6gP=_Qo5d2wx=mpRxXDKGcoxwO3oXGPqe=HXx8ifA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: fix numa stats for thp migration
To:     Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Dec 27, 2020 at 10:14 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> Currently the kernel is not correctly updating the numa stats for
> NR_FILE_PAGES and NR_SHMEM on THP migration. Fix that. For NR_FILE_DIRTY
> and NR_ZONE_WRITE_PENDING, although at the moment there is no need to
> handle THP migration as kernel still does not have write support for
> file THP but to be more future proof, this patch adds the THP support
> for those stats as well.
>
> Fixes: e71769ae52609 ("mm: enable thp migration for shmem thp")
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Cc: <stable@vger.kernel.org>
> ---
>  mm/migrate.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 613794f6a433..ade163c6ecdf 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -402,6 +402,7 @@ int migrate_page_move_mapping(struct address_space *mapping,
>         struct zone *oldzone, *newzone;
>         int dirty;
>         int expected_count = expected_page_refs(mapping, page) + extra_count;
> +       int nr = thp_nr_pages(page);
>
>         if (!mapping) {
>                 /* Anonymous page without mapping */
> @@ -437,7 +438,7 @@ int migrate_page_move_mapping(struct address_space *mapping,
>          */
>         newpage->index = page->index;
>         newpage->mapping = page->mapping;
> -       page_ref_add(newpage, thp_nr_pages(page)); /* add cache reference */
> +       page_ref_add(newpage, nr); /* add cache reference */
>         if (PageSwapBacked(page)) {
>                 __SetPageSwapBacked(newpage);
>                 if (PageSwapCache(page)) {
> @@ -459,7 +460,7 @@ int migrate_page_move_mapping(struct address_space *mapping,
>         if (PageTransHuge(page)) {
>                 int i;
>
> -               for (i = 1; i < HPAGE_PMD_NR; i++) {
> +               for (i = 1; i < nr; i++) {
>                         xas_next(&xas);
>                         xas_store(&xas, newpage);
>                 }
> @@ -470,7 +471,7 @@ int migrate_page_move_mapping(struct address_space *mapping,
>          * to one less reference.
>          * We know this isn't the last reference.
>          */
> -       page_ref_unfreeze(page, expected_count - thp_nr_pages(page));
> +       page_ref_unfreeze(page, expected_count - nr);
>
>         xas_unlock(&xas);
>         /* Leave irq disabled to prevent preemption while updating stats */
> @@ -493,17 +494,17 @@ int migrate_page_move_mapping(struct address_space *mapping,
>                 old_lruvec = mem_cgroup_lruvec(memcg, oldzone->zone_pgdat);
>                 new_lruvec = mem_cgroup_lruvec(memcg, newzone->zone_pgdat);
>
> -               __dec_lruvec_state(old_lruvec, NR_FILE_PAGES);
> -               __inc_lruvec_state(new_lruvec, NR_FILE_PAGES);
> +               __mod_lruvec_state(old_lruvec, NR_FILE_PAGES, -nr);
> +               __mod_lruvec_state(new_lruvec, NR_FILE_PAGES, nr);
>                 if (PageSwapBacked(page) && !PageSwapCache(page)) {
> -                       __dec_lruvec_state(old_lruvec, NR_SHMEM);
> -                       __inc_lruvec_state(new_lruvec, NR_SHMEM);
> +                       __mod_lruvec_state(old_lruvec, NR_SHMEM, -nr);
> +                       __mod_lruvec_state(new_lruvec, NR_SHMEM, nr);
>                 }
>                 if (dirty && mapping_can_writeback(mapping)) {
> -                       __dec_lruvec_state(old_lruvec, NR_FILE_DIRTY);
> -                       __dec_zone_state(oldzone, NR_ZONE_WRITE_PENDING);
> -                       __inc_lruvec_state(new_lruvec, NR_FILE_DIRTY);
> -                       __inc_zone_state(newzone, NR_ZONE_WRITE_PENDING);
> +                       __mod_lruvec_state(old_lruvec, NR_FILE_DIRTY, -nr);
> +                       __mod_zone_page_tate(oldzone, NR_ZONE_WRITE_PENDING, -nr);

This should be __mod_zone_page_state(). I fixed locally but sent the
older patch by mistake.

> +                       __mod_lruvec_state(new_lruvec, NR_FILE_DIRTY, nr);
> +                       __mod_zone_page_state(newzone, NR_ZONE_WRITE_PENDING, nr);
>                 }
>         }
>         local_irq_enable();
> --
> 2.29.2.729.g45daf8777d-goog
>

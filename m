Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CD65F4D9A
	for <lists+cgroups@lfdr.de>; Wed,  5 Oct 2022 04:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJECMc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Oct 2022 22:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiJECMb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Oct 2022 22:12:31 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4480E39B9F
        for <cgroups@vger.kernel.org>; Tue,  4 Oct 2022 19:12:30 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id b7so16247545wrq.9
        for <cgroups@vger.kernel.org>; Tue, 04 Oct 2022 19:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=SWVCoi1Gx8LnXulmNxgsJVtM05JVSDV+EFTdzhdAZAc=;
        b=Wlx6fTfIk9oWnVVFzqungmClkIN18LcCPyg1sz/G3iJSiZkgE/5aTMtFrbr6j3NC+a
         fjvmzhGf2irhlh/ldrW3MoRLz1ap0OuLCMZ1pKZ4rGq8rwk9leu6duN9ok5Ud3BbuHgx
         Ht5XUub6e36fvH6VJ2FRu2NSXu2I3bN0jUxPqCrVjt8vgj2hPgLfTxs1gzwmvwhmVlQd
         1Bs1INnHS5DmvTNuuuoYiLyA8uvBTNvzRNcuU3GpYyqwG7aaM1ZNde2tNfigRYTprW7Y
         TiuKlB1/cXR+mvVrfvaMX8eNI0sPQmOrvchrlxPecMrUL0v0JXHpmODalnD1+Pcjb8up
         c9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=SWVCoi1Gx8LnXulmNxgsJVtM05JVSDV+EFTdzhdAZAc=;
        b=NQpvGQp0qtknBZLpDVaM/6LK49WLTikVEz+HEjZ20fhjf63QZhqdRSRBn114a39Pgb
         WF/RE7MEPi72/HJzbznAYhgjfLb9P6hW6VMZ28wKL/uckU6JuF4I5uoMLxbZTA9VxB37
         hchS+kTUw/3fKGdyy7eOvEjZ/+bCR+RfU6AfGFs+617SFmsnC6dT2he6RRzb9drxtexi
         p/hPCmV5v9iWa5B7FAQb5HBI4/43JY+NT9ZR+SOi4tx8bPDwcPJHXePBeqoufYBVOYnH
         yTXNkmS1jqZIWzDvrIOOZNf+lUnK4Z3TigQD5PWjEScG391o1MxWHDE0d3LeCVMyIRmG
         +CxA==
X-Gm-Message-State: ACrzQf31eUG87CdIJHKihI4FypUp3i8gI6zLXhotHP1dFk+zDz2Yn8CL
        N4e2MGpyV1I1/mSWQ8OnhjMKOyU4lzQmTClYHyOwug==
X-Google-Smtp-Source: AMsMyM49dRp2yqfHJSayRx3cgUWOmENXXmxTBsmZpwbH89qM5oE47pwoZYEVOZiPu7GziHPx90ZCyxaHNpRtO/VmYmU=
X-Received: by 2002:a5d:6741:0:b0:22e:2c5c:d611 with SMTP id
 l1-20020a5d6741000000b0022e2c5cd611mr11956883wrw.210.1664935948647; Tue, 04
 Oct 2022 19:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <20221004233446.787056-1-yosryahmed@google.com>
In-Reply-To: <20221004233446.787056-1-yosryahmed@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 4 Oct 2022 19:11:52 -0700
Message-ID: <CAJD7tkbCk+zs3_PxF4bj9hXSH9v_O4pjR0afvEKqdtA8+4bG+w@mail.gmail.com>
Subject: Re: [PATCH] mm/vmscan: check references from all memcgs for
 swapbacked memory
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
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

On Tue, Oct 4, 2022 at 4:34 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> During page/folio reclaim, we check folio is referenced using
> folio_referenced() to avoid reclaiming folios that have been recently
> accessed (hot memory). The ratinale is that this memory is likely to be

s/ratinale/rationale

> accessed soon, and hence reclaiming it will cause a refault.
>
> For memcg reclaim, we pass in sc->target_mem_cgroup to
> folio_referenced(), which means we only check accesses to the folio
> from processes in the subtree of the target memcg. This behavior was
> originally introduced by commit bed7161a519a ("Memory controller: make
> page_referenced() cgroup aware") a long time ago. Back then, refaulted
> pages would get charged to the memcg of the process that was faulting them
> in. It made sense to only consider accesses coming from processes in the
> subtree of target_mem_cgroup. If a page was charged to memcg A but only
> being accessed by a sibling memcg B, we would reclaim it if memcg A is
> under pressure. memcg B can then fault it back in and get charged for it
> appropriately.
>
> Today, this behavior still makes sense for file pages. However, unlike
> file pages, when swapbacked pages are refaulted they are charged to the
> memcg that was originally charged for them during swapout. Which
> means that if a swapbacked page is charged to memcg A but only used by
> memcg B, and we reclaim it when memcg A is under pressure, it would
> simply be faulted back in and charged again to memcg A once memcg B
> accesses it. In that sense, accesses from all memcgs matter equally when
> considering if a swapbacked page/folio is a viable reclaim target.
>
> Add folio_referenced_memcg() which decides what memcg we should pass to
> folio_referenced() based on the folio type, and includes an elaborate
> comment about why we should do so. This should help reclaim make better
> decision and reduce refaults when reclaiming swapbacked memory that is

s/decision/decisions

> used by multiple memcgs.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  mm/vmscan.c | 38 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 34 insertions(+), 4 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index c5a4bff11da6..f9fa0f9287e5 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1443,14 +1443,43 @@ enum folio_references {
>         FOLIOREF_ACTIVATE,
>  };
>
> +/* What memcg should we pass to folio_referenced()? */
> +static struct mem_cgroup *folio_referenced_memcg(struct folio *folio,
> +                                                struct mem_cgroup *target_memcg)
> +{
> +       /*
> +        * We check references to folios to make sure we don't reclaim hot
> +        * folios that are likely to be refaulted soon. We pass a memcg to
> +        * folio_referenced() to only check references coming from processes in
> +        * that memcg's subtree.
> +        *
> +        * For file folios, we only consider references from processes in the
> +        * subtree of the target memcg. If a folio is charged to
> +        * memcg A but is only referenced by processes in memcg B, we reclaim it
> +        * if memcg A is under pressure. If it is later accessed by memcg B it
> +        * will be faulted back in and charged to memcg B. For memcg A, this is
> +        * called memory that should be reclaimed.

s/called/cold

> +        *
> +        * On the other hand, when swapbacked folios are faulted in, they get
> +        * charged to the memcg that was originally charged for them at the time
> +        * of swapping out. This means that if a folio that is charged to
> +        * memcg A gets swapped out, it will get charged back to A when *any*
> +        * memcg accesses it. In that sense, we need to consider references from
> +        * *all* processes when considering whether to reclaim a swapbacked
> +        * folio.
> +        */
> +       return folio_test_swapbacked(folio) ? NULL : target_memcg;
> +}
> +
>  static enum folio_references folio_check_references(struct folio *folio,
>                                                   struct scan_control *sc)
>  {
>         int referenced_ptes, referenced_folio;
>         unsigned long vm_flags;
> +       struct mem_cgroup *memcg = folio_referenced_memcg(folio,
> +                                               sc->target_mem_cgroup);
>
> -       referenced_ptes = folio_referenced(folio, 1, sc->target_mem_cgroup,
> -                                          &vm_flags);
> +       referenced_ptes = folio_referenced(folio, 1, memcg, &vm_flags);
>         referenced_folio = folio_test_clear_referenced(folio);
>
>         /*
> @@ -2581,6 +2610,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
>
>         while (!list_empty(&l_hold)) {
>                 struct folio *folio;
> +               struct mem_cgroup *memcg;
>
>                 cond_resched();
>                 folio = lru_to_folio(&l_hold);
> @@ -2600,8 +2630,8 @@ static void shrink_active_list(unsigned long nr_to_scan,
>                 }
>
>                 /* Referenced or rmap lock contention: rotate */
> -               if (folio_referenced(folio, 0, sc->target_mem_cgroup,
> -                                    &vm_flags) != 0) {
> +               memcg = folio_referenced_memcg(folio, sc->target_mem_cgroup);
> +               if (folio_referenced(folio, 0, memcg, &vm_flags) != 0) {
>                         /*
>                          * Identify referenced, file-backed active folios and
>                          * give them one more trip around the active list. So
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3A17847CF
	for <lists+cgroups@lfdr.de>; Tue, 22 Aug 2023 18:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237895AbjHVQgZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Aug 2023 12:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237896AbjHVQgY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Aug 2023 12:36:24 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63108187
        for <cgroups@vger.kernel.org>; Tue, 22 Aug 2023 09:36:22 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9a19bf6ab66so265377166b.3
        for <cgroups@vger.kernel.org>; Tue, 22 Aug 2023 09:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692722181; x=1693326981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1Og0p3YsszYT5eyrrRdHLABJeyVk3h/09oUuO+tzhE=;
        b=gDjUEyD73IAB7rXmTKqH6+glsZKCHbYebuG08TAomJFqxwmRCh9mwKKlMjNA+7IOQK
         HhueFesfKUdocFF9KJVJRMPyUYh5+s60/hD8HTL5/EayDayVWBwRX7w15bEpxAjBr1D+
         RlTqPsiABd8hN+dvwvSfoI2h0YMFhNtNF2RD4k39TRNWx1WbdsQ9FYVQiKuN9xYEy0Ki
         OzyzDs3rl7ChWcjUEvNH23dcUPRg2tzRqIGMjnoZnOIOhhClLW/dEwZ3JT8crBXDCAEe
         WGwU/VxQgVxOK4zS1x8A30TV4dtbZW/lV1r49ZmXV88m9Nj/DEG2P6+6XnrufjLIz9ev
         hArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692722181; x=1693326981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1Og0p3YsszYT5eyrrRdHLABJeyVk3h/09oUuO+tzhE=;
        b=HiVcXF+9VsQ4J9YLSaKUfCjrBMb8m7zlMxOzSW7VuBMXZtmdVikVGrOvxKtQ25hb5N
         nHTVDG3j4vSjpjp1BhhoFviHnbFkBmtaBn3E5Wjj0jffB5sbcREA9bubEGMpPiBSYiZO
         qgbNsJjNuwEbNXC0rkUV5ZrS1LnoX6uB3lDpYRXOxk8haWBrXAcW7g1+XGWVrI+1VPBL
         GHP9EhfmkjwIObqSNX/XH3GA37na86j0b0UPvW1f7Ei+60t+54rgbwNuUTgU/8F9fAtM
         hseCnOaJaWMQrY/ARQcdgl1XAa+/goO0pgx1nwI2hNNPEO6pvEutpZgaIRXOLAu4Qnoo
         KOkg==
X-Gm-Message-State: AOJu0YxdFsNaXuGdr5Atbh5+eCelf7zFXa9XElODrQ47zFnH5n/mjgNf
        InGwiTao7C/OGBzFaQxtduSw0GA613SjLRLpAk2fmQ==
X-Google-Smtp-Source: AGHT+IF/Y7UW3BC3YfU03L2U7Xdkv8i4Mdi8P+tqfZNTm8Ng+7QrnnOIKOgtGVPZwSXzM/h/03iw9SxllfgCbjoRGas=
X-Received: by 2002:a17:907:a041:b0:991:c842:2ca2 with SMTP id
 gz1-20020a170907a04100b00991c8422ca2mr7821581ejc.15.1692722180640; Tue, 22
 Aug 2023 09:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230822024901.2412520-1-liushixin2@huawei.com>
In-Reply-To: <20230822024901.2412520-1-liushixin2@huawei.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 22 Aug 2023 09:35:44 -0700
Message-ID: <CAJD7tkZkYsopuqGH_Lo=kE4=HO33wmvK6mXhuq4p_KZ6pYuXtw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: vmscan: reclaim anon pages if there are swapcache pages
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        wangkefeng.wang@huawei.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Aug 21, 2023 at 6:54=E2=80=AFPM Liu Shixin <liushixin2@huawei.com> =
wrote:
>
> When spaces of swap devices are exhausted, only file pages can be reclaim=
ed.
> But there are still some swapcache pages in anon lru list. This can lead
> to a premature out-of-memory.
>
> This problem can be fixed by checking number of swapcache pages in
> can_reclaim_anon_pages(). For memcg v2, there are swapcache stat that can
> be used directly. For memcg v1, use total_swapcache_pages() instead, whic=
h
> may not accurate but can solve the problem.

Interesting find. I wonder if we really don't have any handling of
this situation.

>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  include/linux/swap.h |  6 ++++++
>  mm/memcontrol.c      |  8 ++++++++
>  mm/vmscan.c          | 12 ++++++++----
>  3 files changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 456546443f1f..0318e918bfa4 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -669,6 +669,7 @@ static inline void mem_cgroup_uncharge_swap(swp_entry=
_t entry, unsigned int nr_p
>  }
>
>  extern long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg);
> +extern long mem_cgroup_get_nr_swapcache_pages(struct mem_cgroup *memcg);
>  extern bool mem_cgroup_swap_full(struct folio *folio);
>  #else
>  static inline void mem_cgroup_swapout(struct folio *folio, swp_entry_t e=
ntry)
> @@ -691,6 +692,11 @@ static inline long mem_cgroup_get_nr_swap_pages(stru=
ct mem_cgroup *memcg)
>         return get_nr_swap_pages();
>  }
>
> +static inline long mem_cgroup_get_nr_swapcache_pages(struct mem_cgroup *=
memcg)
> +{
> +       return total_swapcache_pages();
> +}
> +
>  static inline bool mem_cgroup_swap_full(struct folio *folio)
>  {
>         return vm_swap_full();
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e8ca4bdcb03c..3e578f41023e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -7567,6 +7567,14 @@ long mem_cgroup_get_nr_swap_pages(struct mem_cgrou=
p *memcg)
>         return nr_swap_pages;
>  }
>
> +long mem_cgroup_get_nr_swapcache_pages(struct mem_cgroup *memcg)
> +{
> +       if (mem_cgroup_disabled() || do_memsw_account())
> +               return total_swapcache_pages();
> +
> +       return memcg_page_state(memcg, NR_SWAPCACHE);
> +}

Is there a reason why we cannot use NR_SWAPCACHE for cgroup v1? Isn't
that being maintained regardless of cgroup version? It is not exposed
in cgroup v1's memory.stat, but I don't think there is a reason we
can't do that -- if only to document that it is being used with cgroup
v1.


> +
>  bool mem_cgroup_swap_full(struct folio *folio)
>  {
>         struct mem_cgroup *memcg;
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 7c33c5b653ef..bcb6279cbae7 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -609,13 +609,17 @@ static inline bool can_reclaim_anon_pages(struct me=
m_cgroup *memcg,
>         if (memcg =3D=3D NULL) {
>                 /*
>                  * For non-memcg reclaim, is there
> -                * space in any swap device?
> +                * space in any swap device or swapcache pages?
>                  */
> -               if (get_nr_swap_pages() > 0)
> +               if (get_nr_swap_pages() + total_swapcache_pages() > 0)
>                         return true;
>         } else {
> -               /* Is the memcg below its swap limit? */
> -               if (mem_cgroup_get_nr_swap_pages(memcg) > 0)
> +               /*
> +                * Is the memcg below its swap limit or is there swapcach=
e
> +                * pages can be freed?
> +                */
> +               if (mem_cgroup_get_nr_swap_pages(memcg) +
> +                   mem_cgroup_get_nr_swapcache_pages(memcg) > 0)
>                         return true;
>         }

I wonder if it would be more efficient to set a bit in struct
scan_control if we only are out of swap spaces but have swap cache
pages, and only isolate anon pages that are in the swap cache, instead
of isolating random anon pages. We may end up isolating pages that are
not in the swap cache for a few iterations and wasting cycles.


>
> --
> 2.25.1
>

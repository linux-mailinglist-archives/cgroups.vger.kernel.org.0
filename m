Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6CD03730E8
	for <lists+cgroups@lfdr.de>; Tue,  4 May 2021 21:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbhEDTi1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 May 2021 15:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbhEDTi0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 May 2021 15:38:26 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8784BC06174A
        for <cgroups@vger.kernel.org>; Tue,  4 May 2021 12:37:31 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id j10so14965764lfb.12
        for <cgroups@vger.kernel.org>; Tue, 04 May 2021 12:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=btYsPAMNSGmXffsSk7+VR60HmUlYSHIt+oz7jjLh4E8=;
        b=qm3h49sUOH2s6tvF7KNhGDE1XdJRjRppqoGSbXNvcIvjPgsmygPRL+Huz/bo6LwJJk
         /0FRs5hMe3DuFnhdCHSW6+PF81z+rW7Yt1/7pBaFsY8xruoFVGCDcCF3ric6+eGNMf26
         QJi7EdjlGvaBNdL89o5778YfWQd2Lkstsx85AT0wSngk1QGxewfEqdZBOCTYlqRsu9jH
         X9EGZsayyWCKd39XPQumXqjjs0V/gicwgCK+mb4TGO6nhk+gLJK9zX6SjCWoDh5tJOWU
         viTvPxRimjGbUel53oqUg7BoKFeJM8s4RDOXTvYSemwmre0bTiaM5Gf4FCkfmH0nKTmb
         m5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=btYsPAMNSGmXffsSk7+VR60HmUlYSHIt+oz7jjLh4E8=;
        b=kA//fmh9ezoCxkIG/T7mF5AGWMo5OEXzUIFuXz3NNmm9ecLMDvFYzc3+t/Y5hfGZfq
         +T0LzVsVTjVe0lBF1aHWtnj7wYM1M430ACMPAoKnDXXXgaeEYMOYwQu2XQIDzXMiarmb
         /pvDT3PrluRhfjXGN/hed/Yy4o6UOH8/7uDbmsTwGYnXJoucsBQjTNdAzAXJaZM3wxIO
         xDbo4pMkF1Ef7h9ihz7+sIRCN7nvYmNVzzCfVX/P+AoH/EMkHiWhAysjfqCLJPX6ijBk
         AgW1UspHoI+r3zCN5YH/N0Y6UGUcx5G1vNp/txuuQpimwI71KDOIhv5nLssy9vkoOkIk
         sYVA==
X-Gm-Message-State: AOAM533EE862c8PN5Bj+HucnjTi0ss43LY1mNG1bSm0qH9JCN7hlNaI3
        Z3IM/0cBLE2OMugTIl1iRSt/zzLYaxtZaW6DTj69Vg==
X-Google-Smtp-Source: ABdhPJwlb9KA8U4u+KoRPFZ8uOLR3ragJIioyKxSSJZgFafWkkxACRJsoZDnRYbmY44M0lLfIIhm8avycXHH9tNpfNs=
X-Received: by 2002:a05:6512:acd:: with SMTP id n13mr17648346lfu.432.1620157049746;
 Tue, 04 May 2021 12:37:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210504132350.4693-1-longman@redhat.com> <20210504132350.4693-2-longman@redhat.com>
In-Reply-To: <20210504132350.4693-2-longman@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 4 May 2021 12:37:18 -0700
Message-ID: <CALvZod438=YKZtV0qckoaMkdL1seu5PiLnvPPQyRzA0S60-TpQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: memcg/slab: Properly set up gfp flags for
 objcg pointer array
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 4, 2021 at 6:24 AM Waiman Long <longman@redhat.com> wrote:
>
> Since the merging of the new slab memory controller in v5.9, the page
> structure may store a pointer to obj_cgroup pointer array for slab pages.
> Currently, only the __GFP_ACCOUNT bit is masked off. However, the array
> is not readily reclaimable and doesn't need to come from the DMA buffer.
> So those GFP bits should be masked off as well.
>
> Do the flag bit clearing at memcg_alloc_page_obj_cgroups() to make sure
> that it is consistently applied no matter where it is called.
>
> Fixes: 286e04b8ed7a ("mm: memcg/slab: allocate obj_cgroups for non-root slab pages")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  mm/memcontrol.c | 8 ++++++++
>  mm/slab.h       | 1 -
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c100265dc393..5e3b4f23b830 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2863,6 +2863,13 @@ static struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
>  }
>
>  #ifdef CONFIG_MEMCG_KMEM
> +/*
> + * The allocated objcg pointers array is not accounted directly.
> + * Moreover, it should not come from DMA buffer and is not readily
> + * reclaimable. So those GFP bits should be masked off.
> + */
> +#define OBJCGS_CLEAR_MASK      (__GFP_DMA | __GFP_RECLAIMABLE | __GFP_ACCOUNT)

What about __GFP_DMA32? Does it matter? It seems like DMA32 requests
go to normal caches.

> +
>  int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
>                                  gfp_t gfp, bool new_page)
>  {
> @@ -2870,6 +2877,7 @@ int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
>         unsigned long memcg_data;
>         void *vec;
>
> +       gfp &= ~OBJCGS_CLEAR_MASK;
>         vec = kcalloc_node(objects, sizeof(struct obj_cgroup *), gfp,
>                            page_to_nid(page));
>         if (!vec)
> diff --git a/mm/slab.h b/mm/slab.h
> index 18c1927cd196..b3294712a686 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -309,7 +309,6 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
>         if (!memcg_kmem_enabled() || !objcg)
>                 return;
>
> -       flags &= ~__GFP_ACCOUNT;
>         for (i = 0; i < size; i++) {
>                 if (likely(p[i])) {
>                         page = virt_to_head_page(p[i]);
> --
> 2.18.1
>

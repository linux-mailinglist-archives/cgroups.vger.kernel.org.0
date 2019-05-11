Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1DC1A5D5
	for <lists+cgroups@lfdr.de>; Sat, 11 May 2019 02:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbfEKAda (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 May 2019 20:33:30 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41612 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbfEKAda (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 May 2019 20:33:30 -0400
Received: by mail-yw1-f68.google.com with SMTP id o65so6117494ywd.8
        for <cgroups@vger.kernel.org>; Fri, 10 May 2019 17:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=06yq7LJHXJLhXvJtT8Hx1dzG/UksnBqriBWB06TOKsM=;
        b=FLenrYKCC/buLryrtTHR0QOzi7NfAoKEeQmjNgykhtuIow+SzOjew+0nhueVyTV8oG
         icHsrXyG4xGD0CDDMGWrvOhe+pUJC0h5crxPrcPIEjz3XsSbHIcPefgG/PwCkvb/3p+G
         cXsLhi6+XzgmpQUNfHk0KAD+C9L/7rV4lK8clWAv70+zNj2VKr0cIQK7EAuGd6SN1YBr
         eKE9IoajJZTDXrLuV3ytJW0X4APyReZzMv/1E/XrkOl28mSphBIQtGjW2G+YUr5yTUNl
         mgmK6pclL8909ZZq1z3N8iL9M6kyiN3LgMnZz6IcnmXYdiuK4XzET2jCogNThKOse6fY
         0lAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=06yq7LJHXJLhXvJtT8Hx1dzG/UksnBqriBWB06TOKsM=;
        b=orBMzv0/ccEGRC/TaNqshSTxwgkBWvJWK5/RcaaN9wz7y3X3IeO4FgKFM2A8SdiZJM
         sWSsIndJMd1lbk6WLYMJ0OxsSMNtEJgApVePz5a3Ws6OkVWsaPgxPI2F813sUGofo6qs
         5xjCPGHTMBeGBi2holehiSlBWAN0AGZJM20fkt7iczfdaibMmKRrrKTGsU/G3o07+nC8
         IXLHtd7K6l7gh/k/Iuh0+sfE6N3xeR+YbnZMNITQI9hiNjilVDIv2vIkST46Cc/0KEQk
         wxZlR5imUyXJw/B/wn6BvVSd2+XS66ZQ7V1CsOT6jt8OZvFog5rGR4HC8qiD8poxvUCF
         myBA==
X-Gm-Message-State: APjAAAXcKLyYOxpbEcZfSxjZfslpjg95R4+YL05DfKV7uW84rSVZt69b
        jN7XR9IMsD0jHXk06FWnHW7GZz/3L9Iy54JvNjqL/g==
X-Google-Smtp-Source: APXvYqySypYcSRvUZW+oAz8+5kM6/4U8A5b6xBJaRdDGuwRUvh4M1NiOMeCygnFvnnfciBHvIghMxKiWSj2ZrQFEQSY=
X-Received: by 2002:a81:25cb:: with SMTP id l194mr7255617ywl.489.1557534809439;
 Fri, 10 May 2019 17:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190508202458.550808-1-guro@fb.com> <20190508202458.550808-5-guro@fb.com>
In-Reply-To: <20190508202458.550808-5-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 10 May 2019 17:33:18 -0700
Message-ID: <CALvZod5mLReoo44=+s3uYng=e76tXcjDMdr=RPT=hKKr5Azy4Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] mm: unify SLAB and SLUB page accounting
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Christoph Lameter <cl@linux.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Roman Gushchin <guro@fb.com>
Date: Wed, May 8, 2019 at 1:40 PM
To: Andrew Morton, Shakeel Butt
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
<kernel-team@fb.com>, Johannes Weiner, Michal Hocko, Rik van Riel,
Christoph Lameter, Vladimir Davydov, <cgroups@vger.kernel.org>, Roman
Gushchin

> Currently the page accounting code is duplicated in SLAB and SLUB
> internals. Let's move it into new (un)charge_slab_page helpers
> in the slab_common.c file. These helpers will be responsible
> for statistics (global and memcg-aware) and memcg charging.
> So they are replacing direct memcg_(un)charge_slab() calls.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>


> ---
>  mm/slab.c | 19 +++----------------
>  mm/slab.h | 25 +++++++++++++++++++++++++
>  mm/slub.c | 14 ++------------
>  3 files changed, 30 insertions(+), 28 deletions(-)
>
> diff --git a/mm/slab.c b/mm/slab.c
> index 83000e46b870..32e6af9ed9af 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1389,7 +1389,6 @@ static struct page *kmem_getpages(struct kmem_cache *cachep, gfp_t flags,
>                                                                 int nodeid)
>  {
>         struct page *page;
> -       int nr_pages;
>
>         flags |= cachep->allocflags;
>
> @@ -1399,17 +1398,11 @@ static struct page *kmem_getpages(struct kmem_cache *cachep, gfp_t flags,
>                 return NULL;
>         }
>
> -       if (memcg_charge_slab(page, flags, cachep->gfporder, cachep)) {
> +       if (charge_slab_page(page, flags, cachep->gfporder, cachep)) {
>                 __free_pages(page, cachep->gfporder);
>                 return NULL;
>         }
>
> -       nr_pages = (1 << cachep->gfporder);
> -       if (cachep->flags & SLAB_RECLAIM_ACCOUNT)
> -               mod_lruvec_page_state(page, NR_SLAB_RECLAIMABLE, nr_pages);
> -       else
> -               mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE, nr_pages);
> -
>         __SetPageSlab(page);
>         /* Record if ALLOC_NO_WATERMARKS was set when allocating the slab */
>         if (sk_memalloc_socks() && page_is_pfmemalloc(page))
> @@ -1424,12 +1417,6 @@ static struct page *kmem_getpages(struct kmem_cache *cachep, gfp_t flags,
>  static void kmem_freepages(struct kmem_cache *cachep, struct page *page)
>  {
>         int order = cachep->gfporder;
> -       unsigned long nr_freed = (1 << order);
> -
> -       if (cachep->flags & SLAB_RECLAIM_ACCOUNT)
> -               mod_lruvec_page_state(page, NR_SLAB_RECLAIMABLE, -nr_freed);
> -       else
> -               mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE, -nr_freed);
>
>         BUG_ON(!PageSlab(page));
>         __ClearPageSlabPfmemalloc(page);
> @@ -1438,8 +1425,8 @@ static void kmem_freepages(struct kmem_cache *cachep, struct page *page)
>         page->mapping = NULL;
>
>         if (current->reclaim_state)
> -               current->reclaim_state->reclaimed_slab += nr_freed;
> -       memcg_uncharge_slab(page, order, cachep);
> +               current->reclaim_state->reclaimed_slab += 1 << order;
> +       uncharge_slab_page(page, order, cachep);
>         __free_pages(page, order);
>  }
>
> diff --git a/mm/slab.h b/mm/slab.h
> index 4a261c97c138..c9a31120fa1d 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -205,6 +205,12 @@ ssize_t slabinfo_write(struct file *file, const char __user *buffer,
>  void __kmem_cache_free_bulk(struct kmem_cache *, size_t, void **);
>  int __kmem_cache_alloc_bulk(struct kmem_cache *, gfp_t, size_t, void **);
>
> +static inline int cache_vmstat_idx(struct kmem_cache *s)
> +{
> +       return (s->flags & SLAB_RECLAIM_ACCOUNT) ?
> +               NR_SLAB_RECLAIMABLE : NR_SLAB_UNRECLAIMABLE;
> +}
> +
>  #ifdef CONFIG_MEMCG_KMEM
>
>  /* List of all root caches. */
> @@ -352,6 +358,25 @@ static inline void memcg_link_cache(struct kmem_cache *s,
>
>  #endif /* CONFIG_MEMCG_KMEM */
>
> +static __always_inline int charge_slab_page(struct page *page,
> +                                           gfp_t gfp, int order,
> +                                           struct kmem_cache *s)
> +{
> +       int ret = memcg_charge_slab(page, gfp, order, s);
> +
> +       if (!ret)
> +               mod_lruvec_page_state(page, cache_vmstat_idx(s), 1 << order);
> +
> +       return ret;
> +}
> +
> +static __always_inline void uncharge_slab_page(struct page *page, int order,
> +                                              struct kmem_cache *s)
> +{
> +       mod_lruvec_page_state(page, cache_vmstat_idx(s), -(1 << order));
> +       memcg_uncharge_slab(page, order, s);
> +}
> +
>  static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
>  {
>         struct kmem_cache *cachep;
> diff --git a/mm/slub.c b/mm/slub.c
> index 43c34d54ad86..9ec25a588bdd 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1494,7 +1494,7 @@ static inline struct page *alloc_slab_page(struct kmem_cache *s,
>         else
>                 page = __alloc_pages_node(node, flags, order);
>
> -       if (page && memcg_charge_slab(page, flags, order, s)) {
> +       if (page && charge_slab_page(page, flags, order, s)) {
>                 __free_pages(page, order);
>                 page = NULL;
>         }
> @@ -1687,11 +1687,6 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
>         if (!page)
>                 return NULL;
>
> -       mod_lruvec_page_state(page,
> -               (s->flags & SLAB_RECLAIM_ACCOUNT) ?
> -               NR_SLAB_RECLAIMABLE : NR_SLAB_UNRECLAIMABLE,
> -               1 << oo_order(oo));
> -
>         inc_slabs_node(s, page_to_nid(page), page->objects);
>
>         return page;
> @@ -1725,18 +1720,13 @@ static void __free_slab(struct kmem_cache *s, struct page *page)
>                         check_object(s, page, p, SLUB_RED_INACTIVE);
>         }
>
> -       mod_lruvec_page_state(page,
> -               (s->flags & SLAB_RECLAIM_ACCOUNT) ?
> -               NR_SLAB_RECLAIMABLE : NR_SLAB_UNRECLAIMABLE,
> -               -pages);
> -
>         __ClearPageSlabPfmemalloc(page);
>         __ClearPageSlab(page);
>
>         page->mapping = NULL;
>         if (current->reclaim_state)
>                 current->reclaim_state->reclaimed_slab += pages;
> -       memcg_uncharge_slab(page, order, s);
> +       uncharge_slab_page(page, order, s);
>         __free_pages(page, order);
>  }
>
> --
> 2.20.1
>

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 032021A5D4
	for <lists+cgroups@lfdr.de>; Sat, 11 May 2019 02:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbfEKAdX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 May 2019 20:33:23 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43056 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbfEKAdX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 May 2019 20:33:23 -0400
Received: by mail-yw1-f65.google.com with SMTP id t5so233438ywf.10
        for <cgroups@vger.kernel.org>; Fri, 10 May 2019 17:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sgSVfGODZNyEEQFjqirGNZR/8hnjEjcwoRyIzV62s/U=;
        b=j/7AW9ND/YCb7fpUlCIDu4CtWdaw+gNTEb78YjW42tti4DswHvmdv1fY/gad+Gof/S
         2fqgvpZh/3xg9lmvW05tWTyiMqY2v8WnbZfYnssAZHbwgVjL+jOs/rZFKhEnenFyB2yc
         EJ7HXgw6W38QUAkiBqABojxJ7MmmBj2K8BRP0LYmXvLycqiGDta26173/MSOtoyWhgV0
         oUGcrZRVVkUUk6zIVRTPJNuc2mp0lduQlMPk17IujjMLuipV518yH9q0ieS4q/sd1Tq9
         XEXksvzQ2RnJUPvzI4NKRtae7kbccTDP8QyAq8EaJ8rCO/aoTSXyUiBtYazqeZ8XK1nI
         bzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sgSVfGODZNyEEQFjqirGNZR/8hnjEjcwoRyIzV62s/U=;
        b=e2dW+WHU+0m9cMKeMhDTe+7QmNT3bJO3dlsaEE5iEQmjt25r8m7imicPBB0CpvdxM9
         ArvzUsNcsoc/XyzJb7YR+KubUXfCHNseXXd4zwp+8kHhabxR5CBNVOVEqAk05eMlx34W
         KsSe9figsAZIFB6lG1huIFPWJqlC0UQNa/Vq3z4Pn+63CfNW/kL9EDJ9yIl31lAcVuzK
         S2YmTsrbISaBmc4HCW9IBBEqcfnFmz2XDS+3YoKjRHz2+ejRIzeKO6oync2czEydp8e3
         363L1dAlnPKKXH8u1h//IXRtgZ1dt9sgoTR8QEt+pex4EjCnmwx3H3gpQzcYWS84C0TS
         aH7Q==
X-Gm-Message-State: APjAAAW//FTkBAGQgXwu4YVUxd+lVDmruADi6teXhX2FIV/9rna8vekP
        utGbbIICqsZBSDTP98sxVwHy3R1n40Gqk+3B5F5UYw==
X-Google-Smtp-Source: APXvYqxU2FO4D03Bonf/ZZELd4cfkZT2F6rpo69EGUgTyzSwY6vPlPXacS+XvNL9OVjozme5Yqz/cp9a0cwLEM3xGGU=
X-Received: by 2002:a25:a2c1:: with SMTP id c1mr6893225ybn.496.1557534801871;
 Fri, 10 May 2019 17:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190508202458.550808-1-guro@fb.com> <20190508202458.550808-4-guro@fb.com>
In-Reply-To: <20190508202458.550808-4-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 10 May 2019 17:33:10 -0700
Message-ID: <CALvZod4nvTnxvb2UKxvRiYMH9NRcuhat5FwvPDOFMCzZ+aeLxQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] mm: introduce __memcg_kmem_uncharge_memcg()
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
Date: Wed, May 8, 2019 at 1:30 PM
To: Andrew Morton, Shakeel Butt
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
<kernel-team@fb.com>, Johannes Weiner, Michal Hocko, Rik van Riel,
Christoph Lameter, Vladimir Davydov, <cgroups@vger.kernel.org>, Roman
Gushchin

> Let's separate the page counter modification code out of
> __memcg_kmem_uncharge() in a way similar to what
> __memcg_kmem_charge() and __memcg_kmem_charge_memcg() work.
>
> This will allow to reuse this code later using a new
> memcg_kmem_uncharge_memcg() wrapper, which calls
> __memcg_kmem_unchare_memcg() if memcg_kmem_enabled()

__memcg_kmem_uncharge_memcg()

> check is passed.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>


> ---
>  include/linux/memcontrol.h | 10 ++++++++++
>  mm/memcontrol.c            | 25 +++++++++++++++++--------
>  2 files changed, 27 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 36bdfe8e5965..deb209510902 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1298,6 +1298,8 @@ int __memcg_kmem_charge(struct page *page, gfp_t gfp, int order);
>  void __memcg_kmem_uncharge(struct page *page, int order);
>  int __memcg_kmem_charge_memcg(struct page *page, gfp_t gfp, int order,
>                               struct mem_cgroup *memcg);
> +void __memcg_kmem_uncharge_memcg(struct mem_cgroup *memcg,
> +                                unsigned int nr_pages);
>
>  extern struct static_key_false memcg_kmem_enabled_key;
>  extern struct workqueue_struct *memcg_kmem_cache_wq;
> @@ -1339,6 +1341,14 @@ static inline int memcg_kmem_charge_memcg(struct page *page, gfp_t gfp,
>                 return __memcg_kmem_charge_memcg(page, gfp, order, memcg);
>         return 0;
>  }
> +
> +static inline void memcg_kmem_uncharge_memcg(struct page *page, int order,
> +                                            struct mem_cgroup *memcg)
> +{
> +       if (memcg_kmem_enabled())
> +               __memcg_kmem_uncharge_memcg(memcg, 1 << order);
> +}
> +
>  /*
>   * helper for accessing a memcg's index. It will be used as an index in the
>   * child cache array in kmem_cache, and also to derive its name. This function
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 48a8f1c35176..b2c39f187cbb 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2750,6 +2750,22 @@ int __memcg_kmem_charge(struct page *page, gfp_t gfp, int order)
>         css_put(&memcg->css);
>         return ret;
>  }
> +
> +/**
> + * __memcg_kmem_uncharge_memcg: uncharge a kmem page
> + * @memcg: memcg to uncharge
> + * @nr_pages: number of pages to uncharge
> + */
> +void __memcg_kmem_uncharge_memcg(struct mem_cgroup *memcg,
> +                                unsigned int nr_pages)
> +{
> +       if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> +               page_counter_uncharge(&memcg->kmem, nr_pages);
> +
> +       page_counter_uncharge(&memcg->memory, nr_pages);
> +       if (do_memsw_account())
> +               page_counter_uncharge(&memcg->memsw, nr_pages);
> +}
>  /**
>   * __memcg_kmem_uncharge: uncharge a kmem page
>   * @page: page to uncharge
> @@ -2764,14 +2780,7 @@ void __memcg_kmem_uncharge(struct page *page, int order)
>                 return;
>
>         VM_BUG_ON_PAGE(mem_cgroup_is_root(memcg), page);
> -
> -       if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> -               page_counter_uncharge(&memcg->kmem, nr_pages);
> -
> -       page_counter_uncharge(&memcg->memory, nr_pages);
> -       if (do_memsw_account())
> -               page_counter_uncharge(&memcg->memsw, nr_pages);
> -
> +       __memcg_kmem_uncharge_memcg(memcg, nr_pages);
>         page->mem_cgroup = NULL;
>
>         /* slab pages do not have PageKmemcg flag set */
> --
> 2.20.1
>

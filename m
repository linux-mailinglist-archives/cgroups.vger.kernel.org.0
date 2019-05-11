Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8172D1A5CE
	for <lists+cgroups@lfdr.de>; Sat, 11 May 2019 02:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfEKAcm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 May 2019 20:32:42 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43021 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfEKAcm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 May 2019 20:32:42 -0400
Received: by mail-yw1-f66.google.com with SMTP id t5so232560ywf.10
        for <cgroups@vger.kernel.org>; Fri, 10 May 2019 17:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h+Sg7wqBtZAIQFIHjE5bsBOSA1iC/F0ye0Hv9HXbkK0=;
        b=kcxCQHChsnR+cRhz3yi2p4ECRh/JZG+P0/PcTAsfiPmbm4oGEA2xXzWIYDseK85A6i
         x2BamLYVIhkWr/Szcm7yMyBuNto4oSUlD3Re5713rkGubnY0wUF/l/5AafpR3s7I2CZS
         PWTNkx0u0MtloUPVj7SoJ04y02i87ecqt+mXsND//oPIROlVrZZVoa2Uo3BLsrWU99FW
         Z8mbCzqtZN6zBqeQh7qSNzabarlAD7wJVB0HoTS0UpUKHABFm+di2JRxKHJvbORD1TSQ
         yjuWQ+jVHPPJ28aC+B4pfrFJEpglT6/KJtj0bZxPqvLDEraUkBescoyLWj7iX0UHGvIz
         GYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h+Sg7wqBtZAIQFIHjE5bsBOSA1iC/F0ye0Hv9HXbkK0=;
        b=YgnMxkN3mHo2rPtvv3ezhYKdgO2gYirpvrqPNHmSshFH8bNb9o1ve9GcvgVq69mPLr
         dfi1SldOPJu7E5gh/l1E0TcTzVtB94UDfgdgCpm2pM7uu1i7Ih9Mnfg7ngX6O+Klxwb1
         /4lQaH85jPPgTqlZxHO7HiNtqFWfu+y60i/ezOm6YGQ1X5wnkcb5tb01cF+F9tfPIXtv
         pbcr8P2AMf91uqaBcyRDvhW52H8n2ayehf3EKNQWqvasV0cHqw9tZjQh+70OcBX7xJXe
         qhAQNVljS5jiXdgMta6xWhVY/sZL7V8lBN0b2O/UrJlqe0U5k1ORxPLs/oFnH6HJg1i2
         b+cQ==
X-Gm-Message-State: APjAAAWdwmcQxcoIcYNEx3qgwqIVy6oJtM5exjDldiI0fFLjk4eZSqfm
        JYFQP46Mv3CjMFkmMq7sL0bgYSK4Af4cH3vkZHQRhA==
X-Google-Smtp-Source: APXvYqzqSgEJzJtYm3uvXMsOkAq2SaQQE8oou7KC0VrJ98xQnmTidSladYAhQ7p9HTJvVJgQmsy2CWGx1/L/w8jNe34=
X-Received: by 2002:a25:dcd0:: with SMTP id y199mr7139438ybe.464.1557534761182;
 Fri, 10 May 2019 17:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190508202458.550808-1-guro@fb.com> <20190508202458.550808-2-guro@fb.com>
In-Reply-To: <20190508202458.550808-2-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 10 May 2019 17:32:29 -0700
Message-ID: <CALvZod6itDOn6-QFmvZbtYaGDdOT6vbLuGP2jouJeqSJeZNECQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] mm: postpone kmem_cache memcg pointer
 initialization to memcg_link_cache()
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

> Initialize kmem_cache->memcg_params.memcg pointer in
> memcg_link_cache() rather than in init_memcg_params().
>
> Once kmem_cache will hold a reference to the memory cgroup,
> it will simplify the refcounting.
>
> For non-root kmem_caches memcg_link_cache() is always called
> before the kmem_cache becomes visible to a user, so it's safe.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>


> ---
>  mm/slab.c        |  2 +-
>  mm/slab.h        |  5 +++--
>  mm/slab_common.c | 14 +++++++-------
>  mm/slub.c        |  2 +-
>  4 files changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/mm/slab.c b/mm/slab.c
> index 2915d912e89a..f6eff59e018e 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1268,7 +1268,7 @@ void __init kmem_cache_init(void)
>                                   nr_node_ids * sizeof(struct kmem_cache_node *),
>                                   SLAB_HWCACHE_ALIGN, 0, 0);
>         list_add(&kmem_cache->list, &slab_caches);
> -       memcg_link_cache(kmem_cache);
> +       memcg_link_cache(kmem_cache, NULL);
>         slab_state = PARTIAL;
>
>         /*
> diff --git a/mm/slab.h b/mm/slab.h
> index 43ac818b8592..6a562ca72bca 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -289,7 +289,7 @@ static __always_inline void memcg_uncharge_slab(struct page *page, int order,
>  }
>
>  extern void slab_init_memcg_params(struct kmem_cache *);
> -extern void memcg_link_cache(struct kmem_cache *s);
> +extern void memcg_link_cache(struct kmem_cache *s, struct mem_cgroup *memcg);
>  extern void slab_deactivate_memcg_cache_rcu_sched(struct kmem_cache *s,
>                                 void (*deact_fn)(struct kmem_cache *));
>
> @@ -344,7 +344,8 @@ static inline void slab_init_memcg_params(struct kmem_cache *s)
>  {
>  }
>
> -static inline void memcg_link_cache(struct kmem_cache *s)
> +static inline void memcg_link_cache(struct kmem_cache *s,
> +                                   struct mem_cgroup *memcg)
>  {
>  }
>
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 58251ba63e4a..6e00bdf8618d 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -140,13 +140,12 @@ void slab_init_memcg_params(struct kmem_cache *s)
>  }
>
>  static int init_memcg_params(struct kmem_cache *s,
> -               struct mem_cgroup *memcg, struct kmem_cache *root_cache)
> +                            struct kmem_cache *root_cache)
>  {
>         struct memcg_cache_array *arr;
>
>         if (root_cache) {
>                 s->memcg_params.root_cache = root_cache;
> -               s->memcg_params.memcg = memcg;
>                 INIT_LIST_HEAD(&s->memcg_params.children_node);
>                 INIT_LIST_HEAD(&s->memcg_params.kmem_caches_node);
>                 return 0;
> @@ -221,11 +220,12 @@ int memcg_update_all_caches(int num_memcgs)
>         return ret;
>  }
>
> -void memcg_link_cache(struct kmem_cache *s)
> +void memcg_link_cache(struct kmem_cache *s, struct mem_cgroup *memcg)
>  {
>         if (is_root_cache(s)) {
>                 list_add(&s->root_caches_node, &slab_root_caches);
>         } else {
> +               s->memcg_params.memcg = memcg;
>                 list_add(&s->memcg_params.children_node,
>                          &s->memcg_params.root_cache->memcg_params.children);
>                 list_add(&s->memcg_params.kmem_caches_node,
> @@ -244,7 +244,7 @@ static void memcg_unlink_cache(struct kmem_cache *s)
>  }
>  #else
>  static inline int init_memcg_params(struct kmem_cache *s,
> -               struct mem_cgroup *memcg, struct kmem_cache *root_cache)
> +                                   struct kmem_cache *root_cache)
>  {
>         return 0;
>  }
> @@ -384,7 +384,7 @@ static struct kmem_cache *create_cache(const char *name,
>         s->useroffset = useroffset;
>         s->usersize = usersize;
>
> -       err = init_memcg_params(s, memcg, root_cache);
> +       err = init_memcg_params(s, root_cache);
>         if (err)
>                 goto out_free_cache;
>
> @@ -394,7 +394,7 @@ static struct kmem_cache *create_cache(const char *name,
>
>         s->refcount = 1;
>         list_add(&s->list, &slab_caches);
> -       memcg_link_cache(s);
> +       memcg_link_cache(s, memcg);
>  out:
>         if (err)
>                 return ERR_PTR(err);
> @@ -997,7 +997,7 @@ struct kmem_cache *__init create_kmalloc_cache(const char *name,
>
>         create_boot_cache(s, name, size, flags, useroffset, usersize);
>         list_add(&s->list, &slab_caches);
> -       memcg_link_cache(s);
> +       memcg_link_cache(s, NULL);
>         s->refcount = 1;
>         return s;
>  }
> diff --git a/mm/slub.c b/mm/slub.c
> index 5b2e364102e1..16f7e4f5a141 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4219,7 +4219,7 @@ static struct kmem_cache * __init bootstrap(struct kmem_cache *static_cache)
>         }
>         slab_init_memcg_params(s);
>         list_add(&s->list, &slab_caches);
> -       memcg_link_cache(s);
> +       memcg_link_cache(s, NULL);
>         return s;
>  }
>
> --
> 2.20.1
>

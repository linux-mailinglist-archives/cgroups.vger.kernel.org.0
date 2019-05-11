Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67F231A5DB
	for <lists+cgroups@lfdr.de>; Sat, 11 May 2019 02:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbfEKAeU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 May 2019 20:34:20 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43099 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728410AbfEKAeU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 May 2019 20:34:20 -0400
Received: by mail-yw1-f65.google.com with SMTP id t5so234582ywf.10
        for <cgroups@vger.kernel.org>; Fri, 10 May 2019 17:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UdR8JD8KNYcClfaFJdc0xlMZRTEn4yngxUY4SL7WlW0=;
        b=ldjw+nnHKtK+fTb3weGK94cuP7qxL2t2RlNOFIukoBDh3zAGfoairpjWMbIy5l0awC
         Cme3/bk3ny+bZNg+Sk7MaNgjTzhXOTneCTyRQFxQFgkDjo+F43dfkwIAhr2ZDouf1ews
         ujrOSdkBOctfat+ir1VYjVQlB0jBB99jcYRj0lyEITB/Gf2XJgd3ff8voLr+y2opCB/C
         n4J26cguL50D8zOOjX+oxASqm3If2L17oo63Q8Jn+fD2R36iAm/rUY6vb5zRAUKQbHYH
         X5OWy/+DZyxzP1ozyftiL0Tx8uW2O7TiguDuR848V0mrs0l+HQDsrETH2rnVapR2eryN
         +1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UdR8JD8KNYcClfaFJdc0xlMZRTEn4yngxUY4SL7WlW0=;
        b=odAheB5PzsPX+/UHfBwVzQCgs1OD1e387X2jA+GDOb4Zf3cMCuUFmQIKffcUBk6job
         TzrJPElgZUehVbZnMica7YfZuc4tNQH9AM12LAOCFhSy4luaNcIdTjqOYpzUHt+kOF5u
         VPQBdQGAjIIWfunR/oFLiUoRlaUERT58exyAEy27rNhmzEJhWf27zOvJbJ113EOOGSAM
         0spPecyubsNOlEfh+ZEzmExTJqJS5SIytzkwifNsdOiWhjXbSzzP6kmHggGCD9hE8An/
         4CN1bMJXETae7YfDglujyZmWlzRc9zqFZELVMz8FsaK/9DarWRzfMFcsO/d7uyUe0ddR
         xvRA==
X-Gm-Message-State: APjAAAWn49a84MbrCqlQwLw8CAdhOSU2+WXGsQvPtVSvPYpWCGDfzTVg
        7nuMixtAEjdZiR4KQZV8OE4D82uJtq44bRv96yZU4A==
X-Google-Smtp-Source: APXvYqzMzoHGg899Vyb0ItflS72q8KkTnThgd/WORnQ3DVf4ygp5Lx6Lfya9tCIS3swbhrAwy7E449I3E1e5y2H8Xs0=
X-Received: by 2002:a0d:ff82:: with SMTP id p124mr7980895ywf.409.1557534859480;
 Fri, 10 May 2019 17:34:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190508202458.550808-1-guro@fb.com> <20190508202458.550808-8-guro@fb.com>
In-Reply-To: <20190508202458.550808-8-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 10 May 2019 17:34:08 -0700
Message-ID: <CALvZod5L=DXdcb87pbkxLoQnGxhH6W_nvJCoqEDdRTQ5h6R80g@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] mm: fix /proc/kpagecgroup interface for slab pages
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

> Switching to an indirect scheme of getting mem_cgroup pointer for
> !root slab pages broke /proc/kpagecgroup interface for them.
>
> Let's fix it by learning page_cgroup_ino() how to get memcg
> pointer for slab pages.
>
> Reported-by: Shakeel Butt <shakeelb@google.com>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  mm/memcontrol.c  |  5 ++++-
>  mm/slab.h        | 21 +++++++++++++++++++++
>  mm/slab_common.c |  1 +
>  3 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 6e4d9ed16069..8114838759f6 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -494,7 +494,10 @@ ino_t page_cgroup_ino(struct page *page)
>         unsigned long ino = 0;
>
>         rcu_read_lock();
> -       memcg = READ_ONCE(page->mem_cgroup);
> +       if (PageSlab(page))
> +               memcg = memcg_from_slab_page(page);
> +       else
> +               memcg = READ_ONCE(page->mem_cgroup);
>         while (memcg && !(memcg->css.flags & CSS_ONLINE))
>                 memcg = parent_mem_cgroup(memcg);
>         if (memcg)
> diff --git a/mm/slab.h b/mm/slab.h
> index acdc1810639d..cb684fbe2cc2 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -256,6 +256,22 @@ static inline struct kmem_cache *memcg_root_cache(struct kmem_cache *s)
>         return s->memcg_params.root_cache;
>  }
>

Can you please document the preconditions of this function? It seems
like it must be PageSlab() then why need to check PageTail and do
compound_head().


> +static inline struct mem_cgroup *memcg_from_slab_page(struct page *page)
> +{
> +       struct kmem_cache *s;
> +
> +       WARN_ON_ONCE(!rcu_read_lock_held());
> +
> +       if (PageTail(page))
> +               page = compound_head(page);
> +
> +       s = READ_ONCE(page->slab_cache);
> +       if (s && !is_root_cache(s))
> +               return rcu_dereference(s->memcg_params.memcg);
> +
> +       return NULL;
> +}
> +
>  static __always_inline int memcg_charge_slab(struct page *page,
>                                              gfp_t gfp, int order,
>                                              struct kmem_cache *s)
> @@ -338,6 +354,11 @@ static inline struct kmem_cache *memcg_root_cache(struct kmem_cache *s)
>         return s;
>  }
>
> +static inline struct mem_cgroup *memcg_from_slab_page(struct page *page)
> +{
> +       return NULL;
> +}
> +
>  static inline int memcg_charge_slab(struct page *page, gfp_t gfp, int order,
>                                     struct kmem_cache *s)
>  {
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 36673a43ed31..0cfdad0a0aac 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -253,6 +253,7 @@ static void memcg_unlink_cache(struct kmem_cache *s)
>                 list_del(&s->memcg_params.kmem_caches_node);
>                 mem_cgroup_put(rcu_dereference_protected(s->memcg_params.memcg,
>                         lockdep_is_held(&slab_mutex)));
> +               rcu_assign_pointer(s->memcg_params.memcg, NULL);
>         }
>  }
>  #else
> --
> 2.20.1
>

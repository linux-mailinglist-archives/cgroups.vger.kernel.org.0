Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6C501E5E2
	for <lists+cgroups@lfdr.de>; Wed, 15 May 2019 02:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfEOAKr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 May 2019 20:10:47 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:35173 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfEOAKq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 May 2019 20:10:46 -0400
Received: by mail-yb1-f195.google.com with SMTP id k202so310817ybk.2
        for <cgroups@vger.kernel.org>; Tue, 14 May 2019 17:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zluGg5sjuOMtZTmyGxNI8yHBaHDgl+Ebuu+Qwfri6HM=;
        b=Ndpzg0dE7l03zW4C131CKF+aIrpux3suRr9luBsGFoEWNvGZEvjNF20XDLVbdtRf8i
         p5v/+ywAJZT+/jRdIxabY3/fsgh0ea7zgeqb8NBhAdEkX67lwdpDqlmEVUdlD1voY4UK
         NmLUZ4XKWLdCBhmVIfu3Xeke6WlVc5IG5Sfc5zECji65SttNMRyc4GB575gAEU/azkLB
         cOKnJlLy1yNOFt2K8MSVOFqJgI+kCL1bkg2IBdnJuXTmPKNgzi8Ij77xZAwpxFBuyqA1
         mgOrhgguz8obPjJBlX4X6oJCUZNQTV8SMURUr1xwHFoTeYdjZDLgxOHNC+sD6WK/JekI
         8A/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zluGg5sjuOMtZTmyGxNI8yHBaHDgl+Ebuu+Qwfri6HM=;
        b=uBYQtXo2NNPdZP1R00iJPOLskt12++/2IEnkkIThXeYpXV3fQvI8c9LvOlc+0mWgB6
         WxoFmHw6eDQCbDJmNl1BCgiVh8H8zrOyjloulAly+uyCSlKoE7JekcED/piOjgCUPwww
         x/YWKaw74t5/PbvzjPOQQ7KDmELJVFPQ+h6wChJzFhngFkEWriKGQdu5Zjyq5d9rj7JN
         OPGcwDLLeDwPaeYVkqP0jNZzZJhqW+TlYlofjGR/tzxzWxYjoNugeNYfKWuD3ZntubGh
         kigVPxwfNgdqcnQ5TLFfWLFqOLeOvaT02JCwhyHHUpom+STrX4NyBbjLk2z3Ih848+3w
         I2tw==
X-Gm-Message-State: APjAAAXceccKuaabSo3PECC2XTjgjBuNYyWFNaZdgWWLWG845h3XUueN
        9bgN49sDTMmA4a0PP7haQOLsc3GSQWw8ztItruA8ag==
X-Google-Smtp-Source: APXvYqzEdusEfpnz9l5C8hPn5ut+WFR02WVznTKN6Nq4aV4/q18VioOpAKoW7WFWF+VamGbgyLdd0YruwBtkDF1KKYU=
X-Received: by 2002:a25:4147:: with SMTP id o68mr19108358yba.148.1557879045478;
 Tue, 14 May 2019 17:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190514213940.2405198-1-guro@fb.com> <20190514213940.2405198-7-guro@fb.com>
In-Reply-To: <20190514213940.2405198-7-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 14 May 2019 17:10:34 -0700
Message-ID: <CALvZod7FDwnxFLs_0+AfaU+5vCCSSX6wbjOZv+01hrCUoPKsWg@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] mm: reparent slab memory on cgroup removal
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
Date: Tue, May 14, 2019 at 2:54 PM
To: Andrew Morton, Shakeel Butt
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
<kernel-team@fb.com>, Johannes Weiner, Michal Hocko, Rik van Riel,
Christoph Lameter, Vladimir Davydov, <cgroups@vger.kernel.org>, Roman
Gushchin

> Let's reparent memcg slab memory on memcg offlining. This allows us
> to release the memory cgroup without waiting for the last outstanding
> kernel object (e.g. dentry used by another application).
>
> So instead of reparenting all accounted slab pages, let's do reparent
> a relatively small amount of kmem_caches. Reparenting is performed as
> a part of the deactivation process.
>
> Since the parent cgroup is already charged, everything we need to do
> is to splice the list of kmem_caches to the parent's kmem_caches list,
> swap the memcg pointer and drop the css refcounter for each kmem_cache
> and adjust the parent's css refcounter. Quite simple.
>
> Please, note that kmem_cache->memcg_params.memcg isn't a stable
> pointer anymore. It's safe to read it under rcu_read_lock() or
> with slab_mutex held.
>
> We can race with the slab allocation and deallocation paths. It's not
> a big problem: parent's charge and slab global stats are always
> correct, and we don't care anymore about the child usage and global
> stats. The child cgroup is already offline, so we don't use or show it
> anywhere.
>
> Local slab stats (NR_SLAB_RECLAIMABLE and NR_SLAB_UNRECLAIMABLE)
> aren't used anywhere except count_shadow_nodes(). But even there it
> won't break anything: after reparenting "nodes" will be 0 on child
> level (because we're already reparenting shrinker lists), and on
> parent level page stats always were 0, and this patch won't change
> anything.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> ---
>  include/linux/slab.h |  4 ++--
>  mm/memcontrol.c      | 14 ++++++++------
>  mm/slab.h            | 21 ++++++++++++++++-----
>  mm/slab_common.c     | 21 ++++++++++++++++++---
>  4 files changed, 44 insertions(+), 16 deletions(-)
>
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 1b54e5f83342..109cab2ad9b4 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -152,7 +152,7 @@ void kmem_cache_destroy(struct kmem_cache *);
>  int kmem_cache_shrink(struct kmem_cache *);
>
>  void memcg_create_kmem_cache(struct mem_cgroup *, struct kmem_cache *);
> -void memcg_deactivate_kmem_caches(struct mem_cgroup *);
> +void memcg_deactivate_kmem_caches(struct mem_cgroup *, struct mem_cgroup *);
>
>  /*
>   * Please use this macro to create slab caches. Simply specify the
> @@ -638,7 +638,7 @@ struct memcg_cache_params {
>                         bool dying;
>                 };
>                 struct {
> -                       struct mem_cgroup *memcg;
> +                       struct mem_cgroup __rcu *memcg;
>                         struct list_head children_node;
>                         struct list_head kmem_caches_node;
>                         struct percpu_ref refcnt;
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 413cef3d8369..0655639433ed 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3224,15 +3224,15 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
>          */
>         memcg->kmem_state = KMEM_ALLOCATED;
>
> -       memcg_deactivate_kmem_caches(memcg);
> -
> -       kmemcg_id = memcg->kmemcg_id;
> -       BUG_ON(kmemcg_id < 0);
> -
>         parent = parent_mem_cgroup(memcg);
>         if (!parent)
>                 parent = root_mem_cgroup;
>
> +       memcg_deactivate_kmem_caches(memcg, parent);
> +
> +       kmemcg_id = memcg->kmemcg_id;
> +       BUG_ON(kmemcg_id < 0);
> +
>         /*
>          * Change kmemcg_id of this cgroup and all its descendants to the
>          * parent's id, and then move all entries from this cgroup's list_lrus
> @@ -3265,7 +3265,6 @@ static void memcg_free_kmem(struct mem_cgroup *memcg)
>         if (memcg->kmem_state == KMEM_ALLOCATED) {
>                 WARN_ON(!list_empty(&memcg->kmem_caches));
>                 static_branch_dec(&memcg_kmem_enabled_key);
> -               WARN_ON(page_counter_read(&memcg->kmem));
>         }
>  }
>  #else
> @@ -4677,6 +4676,9 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
>
>         /* The following stuff does not apply to the root */
>         if (!parent) {
> +#ifdef CONFIG_MEMCG_KMEM
> +               INIT_LIST_HEAD(&memcg->kmem_caches);
> +#endif
>                 root_mem_cgroup = memcg;
>                 return &memcg->css;
>         }
> diff --git a/mm/slab.h b/mm/slab.h
> index b86744c58702..7ba50e526d82 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -268,10 +268,18 @@ static __always_inline int memcg_charge_slab(struct page *page,
>         struct lruvec *lruvec;
>         int ret;
>
> -       memcg = s->memcg_params.memcg;
> +       rcu_read_lock();
> +       memcg = rcu_dereference(s->memcg_params.memcg);
> +       while (memcg && !css_tryget_online(&memcg->css))
> +               memcg = parent_mem_cgroup(memcg);
> +       rcu_read_unlock();
> +
> +       if (unlikely(!memcg))
> +               return true;
> +
>         ret = memcg_kmem_charge_memcg(page, gfp, order, memcg);
>         if (ret)
> -               return ret;
> +               goto out;
>
>         lruvec = mem_cgroup_lruvec(page_pgdat(page), memcg);
>         mod_lruvec_state(lruvec, cache_vmstat_idx(s), 1 << order);
> @@ -279,8 +287,9 @@ static __always_inline int memcg_charge_slab(struct page *page,
>         /* transer try_charge() page references to kmem_cache */
>         percpu_ref_get_many(&s->memcg_params.refcnt, 1 << order);
>         css_put_many(&memcg->css, 1 << order);
> -
> -       return 0;
> +out:
> +       css_put(&memcg->css);
> +       return ret;
>  }
>
>  /*
> @@ -293,10 +302,12 @@ static __always_inline void memcg_uncharge_slab(struct page *page, int order,
>         struct mem_cgroup *memcg;
>         struct lruvec *lruvec;
>
> -       memcg = s->memcg_params.memcg;
> +       rcu_read_lock();
> +       memcg = rcu_dereference(s->memcg_params.memcg);
>         lruvec = mem_cgroup_lruvec(page_pgdat(page), memcg);
>         mod_lruvec_state(lruvec, cache_vmstat_idx(s), -(1 << order));
>         memcg_kmem_uncharge_memcg(page, order, memcg);
> +       rcu_read_unlock();
>
>         percpu_ref_put_many(&s->memcg_params.refcnt, 1 << order);
>  }
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 1ee967b4805e..354762394162 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -237,7 +237,7 @@ void memcg_link_cache(struct kmem_cache *s, struct mem_cgroup *memcg)
>                 list_add(&s->root_caches_node, &slab_root_caches);
>         } else {
>                 css_get(&memcg->css);
> -               s->memcg_params.memcg = memcg;
> +               rcu_assign_pointer(s->memcg_params.memcg, memcg);
>                 list_add(&s->memcg_params.children_node,
>                          &s->memcg_params.root_cache->memcg_params.children);
>                 list_add(&s->memcg_params.kmem_caches_node,
> @@ -252,7 +252,8 @@ static void memcg_unlink_cache(struct kmem_cache *s)
>         } else {
>                 list_del(&s->memcg_params.children_node);
>                 list_del(&s->memcg_params.kmem_caches_node);
> -               css_put(&s->memcg_params.memcg->css);
> +               mem_cgroup_put(rcu_dereference_protected(s->memcg_params.memcg,
> +                       lockdep_is_held(&slab_mutex)));
>         }
>  }
>  #else
> @@ -776,11 +777,13 @@ static void kmemcg_cache_deactivate(struct kmem_cache *s)
>         call_rcu(&s->memcg_params.rcu_head, kmemcg_schedule_work_after_rcu);
>  }
>
> -void memcg_deactivate_kmem_caches(struct mem_cgroup *memcg)
> +void memcg_deactivate_kmem_caches(struct mem_cgroup *memcg,
> +                                 struct mem_cgroup *parent)
>  {
>         int idx;
>         struct memcg_cache_array *arr;
>         struct kmem_cache *s, *c;
> +       unsigned int nr_reparented;
>
>         idx = memcg_cache_id(memcg);
>
> @@ -798,6 +801,18 @@ void memcg_deactivate_kmem_caches(struct mem_cgroup *memcg)
>                 kmemcg_cache_deactivate(c);
>                 arr->entries[idx] = NULL;
>         }
> +       nr_reparented = 0;
> +       list_for_each_entry(s, &memcg->kmem_caches,
> +                           memcg_params.kmem_caches_node) {
> +               rcu_assign_pointer(s->memcg_params.memcg, parent);
> +               css_put(&memcg->css);
> +               nr_reparented++;
> +       }
> +       if (nr_reparented) {
> +               list_splice_init(&memcg->kmem_caches,
> +                                &parent->kmem_caches);
> +               css_get_many(&parent->css, nr_reparented);
> +       }
>         mutex_unlock(&slab_mutex);
>
>         put_online_mems();
> --
> 2.20.1
>

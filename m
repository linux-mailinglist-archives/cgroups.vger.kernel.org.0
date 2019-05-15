Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1ECF1E5E0
	for <lists+cgroups@lfdr.de>; Wed, 15 May 2019 02:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfEOAHI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 May 2019 20:07:08 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:39857 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfEOAHI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 May 2019 20:07:08 -0400
Received: by mail-yb1-f195.google.com with SMTP id x5so298348ybn.6
        for <cgroups@vger.kernel.org>; Tue, 14 May 2019 17:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4WEWe9/M1KUwW0UCq7NNJNKHOWt12BNGDR2Zg8R92Io=;
        b=EhD9G7HoQNo0NrMzpLtzsiajiynFdUz7X9quQOVhGqdmr3zcrKgT/vv8bYg1XjtdO6
         aX33YONdzNcJghN2E9cXTzAlWJioU1e0XvrYp3LhUo5WCMKFTt+pm76xZiIVul25JQ2F
         AIz2WpO0ao3IpCnATgAOMsRVFL7IU+vbSugwGdCclZSRSPwD+I+lOZA3iMxy0xOFTFLy
         +2zCKuUacQWilysNEvPeFUzmtq6iJIsr3mtzQmnPueq7fvXjUk26by1X23r7QT6ZbC4D
         bgHU3XTSRwhcnvOWht0mhtKqxbyZdYEsDrIb2+gJnHr8RyzHl2TC0lWhQewBVNJIeKkl
         ZSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4WEWe9/M1KUwW0UCq7NNJNKHOWt12BNGDR2Zg8R92Io=;
        b=QFTjM75/wPLT4VmGmit0qwJd62RPhr0kCIwr3QnNTuf74VidE54hiYTon8cbzRZKZR
         1FbgpRpnHF3kP8Rh0m2AbMiUyvNtg4uFhXObsS5+3+RIC3MD4UQpw+ad92ysB4eQBkCi
         nKTgtJbI4Ry91Z2jC/AjhglQfFnjuKrJMeh91gEK22D3bhlc14bQOdBg0hVKV1hZ6VHG
         EK4ZV9e+rjEc+rmxuvnBDNY07ko3dFyp91VHswwYWLsyrgcDw/COIiPt7xOqu5XACAZM
         I8QOyw7mpwu+A8bN5NQRrvr+mTziuGIWQFAyaLC9+Z0NXOucFuWdNDkrE8hDJMt8mSsE
         aIzQ==
X-Gm-Message-State: APjAAAVj92+URJkV8MrrdyuXssSQiHSKg5SOqXtnZrVbBXFUcQ2ZaYfJ
        cLYwI5l+HIQDWSV2h9z02f785zBR6h+AsUibPYIRJw==
X-Google-Smtp-Source: APXvYqz7Vnay3ZhrspAqYXPmisDN+bPhdqF09Nw/8uYXDYbLYZXpWgaN4DM05eTgcpqvw47nHBD2/2CMnjWJbCSlGAY=
X-Received: by 2002:a25:a2c1:: with SMTP id c1mr17452529ybn.496.1557878826976;
 Tue, 14 May 2019 17:07:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190514213940.2405198-1-guro@fb.com> <20190514213940.2405198-6-guro@fb.com>
In-Reply-To: <20190514213940.2405198-6-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 14 May 2019 17:06:55 -0700
Message-ID: <CALvZod6Zb_kYHyG02jXBY9gvvUn_gOug7kq_hVa8vuCbXdPdjQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] mm: rework non-root kmem_cache lifecycle management
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
Date: Tue, May 14, 2019 at 2:55 PM
To: Andrew Morton, Shakeel Butt
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
<kernel-team@fb.com>, Johannes Weiner, Michal Hocko, Rik van Riel,
Christoph Lameter, Vladimir Davydov, <cgroups@vger.kernel.org>, Roman
Gushchin

> This commit makes several important changes in the lifecycle
> of a non-root kmem_cache, which also affect the lifecycle
> of a memory cgroup.
>
> Currently each charged slab page has a page->mem_cgroup pointer
> to the memory cgroup and holds a reference to it.
> Kmem_caches are held by the memcg and are released with it.
> It means that none of kmem_caches are released unless at least one
> reference to the memcg exists, which is not optimal.
>
> So the current scheme can be illustrated as:
> page->mem_cgroup->kmem_cache.
>
> To implement the slab memory reparenting we need to invert the scheme
> into: page->kmem_cache->mem_cgroup.
>
> Let's make every page to hold a reference to the kmem_cache (we
> already have a stable pointer), and make kmem_caches to hold a single
> reference to the memory cgroup.
>
> To make this possible we need to introduce a new percpu refcounter
> for non-root kmem_caches. The counter is initialized to the percpu
> mode, and is switched to atomic mode after deactivation, so we never
> shutdown an active cache. The counter is bumped for every charged page
> and also for every running allocation. So the kmem_cache can't
> be released unless all allocations complete.
>
> To shutdown non-active empty kmem_caches, let's reuse the
> infrastructure of the RCU-delayed work queue, used previously for
> the deactivation. After the generalization, it's perfectly suited
> for our needs.
>
> Since now we can release a kmem_cache at any moment after the
> deactivation, let's call sysfs_slab_remove() only from the shutdown
> path. It makes deactivation path simpler.
>
> Because we don't set the page->mem_cgroup pointer, we need to change
> the way how memcg-level stats is working for slab pages. We can't use
> mod_lruvec_page_state() helpers anymore, so switch over to
> mod_lruvec_state().
>
> * I used the following simple approach to test the performance
> (stolen from another patchset by T. Harding):
>
>     time find / -name fname-no-exist
>     echo 2 > /proc/sys/vm/drop_caches
>     repeat 10 times
>
> Results (I've chosen best results in several runs):
>
>         orig            patched
>
> real    0m0.648s        real    0m0.593s
> user    0m0.148s        user    0m0.162s
> sys     0m0.295s        sys     0m0.253s
>
> real    0m0.581s        real    0m0.649s
> user    0m0.119s        user    0m0.136s
> sys     0m0.254s        sys     0m0.250s
>
> real    0m0.645s        real    0m0.705s
> user    0m0.138s        user    0m0.138s
> sys     0m0.263s        sys     0m0.250s
>
> real    0m0.691s        real    0m0.718s
> user    0m0.139s        user    0m0.134s
> sys     0m0.262s        sys     0m0.253s
>
> real    0m0.654s        real    0m0.715s
> user    0m0.146s        user    0m0.128s
> sys     0m0.247s        sys     0m0.261s
>
> real    0m0.675s        real    0m0.717s
> user    0m0.129s        user    0m0.137s
> sys     0m0.277s        sys     0m0.248s
>
> real    0m0.631s        real    0m0.719s
> user    0m0.137s        user    0m0.134s
> sys     0m0.255s        sys     0m0.251s
>
> real    0m0.622s        real    0m0.715s
> user    0m0.108s        user    0m0.124s
> sys     0m0.279s        sys     0m0.264s
>
> real    0m0.651s        real    0m0.669s
> user    0m0.139s        user    0m0.139s
> sys     0m0.252s        sys     0m0.247s
>
> real    0m0.671s        real    0m0.632s
> user    0m0.130s        user    0m0.139s
> sys     0m0.263s        sys     0m0.245s
>
> So it looks like the difference is not noticeable in this test.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> ---
>  include/linux/slab.h |  3 +-
>  mm/memcontrol.c      | 57 +++++++++++++++++++++---------
>  mm/slab.h            | 82 +++++++++++++++++++++++++-------------------
>  mm/slab_common.c     | 74 +++++++++++++++++++++++----------------
>  mm/slub.c            | 12 +------
>  5 files changed, 135 insertions(+), 93 deletions(-)
>
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 47923c173f30..1b54e5f83342 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -16,6 +16,7 @@
>  #include <linux/overflow.h>
>  #include <linux/types.h>
>  #include <linux/workqueue.h>
> +#include <linux/percpu-refcount.h>
>
>
>  /*
> @@ -152,7 +153,6 @@ int kmem_cache_shrink(struct kmem_cache *);
>
>  void memcg_create_kmem_cache(struct mem_cgroup *, struct kmem_cache *);
>  void memcg_deactivate_kmem_caches(struct mem_cgroup *);
> -void memcg_destroy_kmem_caches(struct mem_cgroup *);
>
>  /*
>   * Please use this macro to create slab caches. Simply specify the
> @@ -641,6 +641,7 @@ struct memcg_cache_params {
>                         struct mem_cgroup *memcg;
>                         struct list_head children_node;
>                         struct list_head kmem_caches_node;
> +                       struct percpu_ref refcnt;
>
>                         void (*work_fn)(struct kmem_cache *);
>                         union {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b2c39f187cbb..413cef3d8369 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2610,12 +2610,13 @@ static void memcg_schedule_kmem_cache_create(struct mem_cgroup *memcg,
>  {
>         struct memcg_kmem_cache_create_work *cw;
>
> +       if (!css_tryget_online(&memcg->css))
> +               return;
> +
>         cw = kmalloc(sizeof(*cw), GFP_NOWAIT | __GFP_NOWARN);
>         if (!cw)
>                 return;
>
> -       css_get(&memcg->css);
> -
>         cw->memcg = memcg;
>         cw->cachep = cachep;
>         INIT_WORK(&cw->work, memcg_kmem_cache_create_func);
> @@ -2651,20 +2652,35 @@ struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep)
>         struct mem_cgroup *memcg;
>         struct kmem_cache *memcg_cachep;
>         int kmemcg_id;
> +       struct memcg_cache_array *arr;
>
>         VM_BUG_ON(!is_root_cache(cachep));
>
>         if (memcg_kmem_bypass())
>                 return cachep;
>
> -       memcg = get_mem_cgroup_from_current();
> +       rcu_read_lock();
> +
> +       if (unlikely(current->active_memcg))
> +               memcg = current->active_memcg;
> +       else
> +               memcg = mem_cgroup_from_task(current);
> +
> +       if (!memcg || memcg == root_mem_cgroup)
> +               goto out_unlock;
> +
>         kmemcg_id = READ_ONCE(memcg->kmemcg_id);
>         if (kmemcg_id < 0)
> -               goto out;
> +               goto out_unlock;
>
> -       memcg_cachep = cache_from_memcg_idx(cachep, kmemcg_id);
> -       if (likely(memcg_cachep))
> -               return memcg_cachep;
> +       arr = rcu_dereference(cachep->memcg_params.memcg_caches);
> +
> +       /*
> +        * Make sure we will access the up-to-date value. The code updating
> +        * memcg_caches issues a write barrier to match this (see
> +        * memcg_create_kmem_cache()).
> +        */
> +       memcg_cachep = READ_ONCE(arr->entries[kmemcg_id]);
>
>         /*
>          * If we are in a safe context (can wait, and not in interrupt
> @@ -2677,10 +2693,20 @@ struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep)
>          * memcg_create_kmem_cache, this means no further allocation
>          * could happen with the slab_mutex held. So it's better to
>          * defer everything.
> +        *
> +        * If the memcg is dying or memcg_cache is about to be released,
> +        * don't bother creating new kmem_caches. Because memcg_cachep
> +        * is ZEROed as the fist step of kmem offlining, we don't need
> +        * percpu_ref_tryget() here. css_tryget_online() check in

*percpu_ref_tryget_live()

> +        * memcg_schedule_kmem_cache_create() will prevent us from
> +        * creation of a new kmem_cache.
>          */
> -       memcg_schedule_kmem_cache_create(memcg, cachep);
> -out:
> -       css_put(&memcg->css);
> +       if (unlikely(!memcg_cachep))
> +               memcg_schedule_kmem_cache_create(memcg, cachep);
> +       else if (percpu_ref_tryget(&memcg_cachep->memcg_params.refcnt))
> +               cachep = memcg_cachep;
> +out_unlock:
> +       rcu_read_lock();
>         return cachep;
>  }
>
> @@ -2691,7 +2717,7 @@ struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep)
>  void memcg_kmem_put_cache(struct kmem_cache *cachep)
>  {
>         if (!is_root_cache(cachep))
> -               css_put(&cachep->memcg_params.memcg->css);
> +               percpu_ref_put(&cachep->memcg_params.refcnt);
>  }
>
>  /**
> @@ -2719,9 +2745,6 @@ int __memcg_kmem_charge_memcg(struct page *page, gfp_t gfp, int order,
>                 cancel_charge(memcg, nr_pages);
>                 return -ENOMEM;
>         }
> -
> -       page->mem_cgroup = memcg;
> -
>         return 0;
>  }
>
> @@ -2744,8 +2767,10 @@ int __memcg_kmem_charge(struct page *page, gfp_t gfp, int order)
>         memcg = get_mem_cgroup_from_current();
>         if (!mem_cgroup_is_root(memcg)) {
>                 ret = __memcg_kmem_charge_memcg(page, gfp, order, memcg);
> -               if (!ret)
> +               if (!ret) {
> +                       page->mem_cgroup = memcg;
>                         __SetPageKmemcg(page);
> +               }
>         }
>         css_put(&memcg->css);
>         return ret;
> @@ -3238,7 +3263,7 @@ static void memcg_free_kmem(struct mem_cgroup *memcg)
>                 memcg_offline_kmem(memcg);
>
>         if (memcg->kmem_state == KMEM_ALLOCATED) {
> -               memcg_destroy_kmem_caches(memcg);
> +               WARN_ON(!list_empty(&memcg->kmem_caches));
>                 static_branch_dec(&memcg_kmem_enabled_key);
>                 WARN_ON(page_counter_read(&memcg->kmem));
>         }
> diff --git a/mm/slab.h b/mm/slab.h
> index c9a31120fa1d..b86744c58702 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -173,6 +173,7 @@ void __kmem_cache_release(struct kmem_cache *);
>  int __kmem_cache_shrink(struct kmem_cache *);
>  void __kmemcg_cache_deactivate(struct kmem_cache *s);
>  void __kmemcg_cache_deactivate_after_rcu(struct kmem_cache *s);
> +void kmemcg_cache_shutdown(struct kmem_cache *s);
>  void slab_kmem_cache_release(struct kmem_cache *);
>
>  struct seq_file;
> @@ -248,31 +249,6 @@ static inline const char *cache_name(struct kmem_cache *s)
>         return s->name;
>  }
>
> -/*
> - * Note, we protect with RCU only the memcg_caches array, not per-memcg caches.
> - * That said the caller must assure the memcg's cache won't go away by either
> - * taking a css reference to the owner cgroup, or holding the slab_mutex.
> - */
> -static inline struct kmem_cache *
> -cache_from_memcg_idx(struct kmem_cache *s, int idx)
> -{
> -       struct kmem_cache *cachep;
> -       struct memcg_cache_array *arr;
> -
> -       rcu_read_lock();
> -       arr = rcu_dereference(s->memcg_params.memcg_caches);
> -
> -       /*
> -        * Make sure we will access the up-to-date value. The code updating
> -        * memcg_caches issues a write barrier to match this (see
> -        * memcg_create_kmem_cache()).
> -        */
> -       cachep = READ_ONCE(arr->entries[idx]);
> -       rcu_read_unlock();
> -
> -       return cachep;
> -}
> -
>  static inline struct kmem_cache *memcg_root_cache(struct kmem_cache *s)
>  {
>         if (is_root_cache(s))
> @@ -280,19 +256,49 @@ static inline struct kmem_cache *memcg_root_cache(struct kmem_cache *s)
>         return s->memcg_params.root_cache;
>  }
>
> +/*
> + * Charge the slab page belonging to the non-root kmem_cache.
> + * Can be called for non-root kmem_caches only.
> + */
>  static __always_inline int memcg_charge_slab(struct page *page,
>                                              gfp_t gfp, int order,
>                                              struct kmem_cache *s)
>  {
> -       if (is_root_cache(s))
> -               return 0;
> -       return memcg_kmem_charge_memcg(page, gfp, order, s->memcg_params.memcg);
> +       struct mem_cgroup *memcg;
> +       struct lruvec *lruvec;
> +       int ret;
> +
> +       memcg = s->memcg_params.memcg;
> +       ret = memcg_kmem_charge_memcg(page, gfp, order, memcg);
> +       if (ret)
> +               return ret;
> +
> +       lruvec = mem_cgroup_lruvec(page_pgdat(page), memcg);
> +       mod_lruvec_state(lruvec, cache_vmstat_idx(s), 1 << order);
> +
> +       /* transer try_charge() page references to kmem_cache */
> +       percpu_ref_get_many(&s->memcg_params.refcnt, 1 << order);
> +       css_put_many(&memcg->css, 1 << order);
> +
> +       return 0;
>  }
>
> +/*
> + * Uncharge a slab page belonging to a non-root kmem_cache.
> + * Can be called for non-root kmem_caches only.
> + */
>  static __always_inline void memcg_uncharge_slab(struct page *page, int order,
>                                                 struct kmem_cache *s)
>  {
> -       memcg_kmem_uncharge(page, order);
> +       struct mem_cgroup *memcg;
> +       struct lruvec *lruvec;
> +
> +       memcg = s->memcg_params.memcg;
> +       lruvec = mem_cgroup_lruvec(page_pgdat(page), memcg);
> +       mod_lruvec_state(lruvec, cache_vmstat_idx(s), -(1 << order));
> +       memcg_kmem_uncharge_memcg(page, order, memcg);
> +
> +       percpu_ref_put_many(&s->memcg_params.refcnt, 1 << order);
>  }
>
>  extern void slab_init_memcg_params(struct kmem_cache *);
> @@ -362,18 +368,24 @@ static __always_inline int charge_slab_page(struct page *page,
>                                             gfp_t gfp, int order,
>                                             struct kmem_cache *s)
>  {
> -       int ret = memcg_charge_slab(page, gfp, order, s);
> -
> -       if (!ret)
> -               mod_lruvec_page_state(page, cache_vmstat_idx(s), 1 << order);
> +       if (is_root_cache(s)) {
> +               mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
> +                                   1 << order);
> +               return 0;
> +       }
>
> -       return ret;
> +       return memcg_charge_slab(page, gfp, order, s);
>  }
>
>  static __always_inline void uncharge_slab_page(struct page *page, int order,
>                                                struct kmem_cache *s)
>  {
> -       mod_lruvec_page_state(page, cache_vmstat_idx(s), -(1 << order));
> +       if (is_root_cache(s)) {
> +               mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
> +                                   -(1 << order));
> +               return;
> +       }
> +
>         memcg_uncharge_slab(page, order, s);
>  }
>
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 4e5b4292a763..1ee967b4805e 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -45,6 +45,8 @@ static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work);
>  static DECLARE_WORK(slab_caches_to_rcu_destroy_work,
>                     slab_caches_to_rcu_destroy_workfn);
>
> +static void kmemcg_queue_cache_shutdown(struct percpu_ref *percpu_ref);
> +
>  /*
>   * Set of flags that will prevent slab merging
>   */
> @@ -130,6 +132,7 @@ int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t nr,
>  #ifdef CONFIG_MEMCG_KMEM
>
>  LIST_HEAD(slab_root_caches);
> +static DEFINE_SPINLOCK(memcg_kmem_wq_lock);
>
>  void slab_init_memcg_params(struct kmem_cache *s)
>  {
> @@ -145,6 +148,12 @@ static int init_memcg_params(struct kmem_cache *s,
>         struct memcg_cache_array *arr;
>
>         if (root_cache) {
> +               int ret = percpu_ref_init(&s->memcg_params.refcnt,
> +                                         kmemcg_queue_cache_shutdown,
> +                                         0, GFP_KERNEL);
> +               if (ret)
> +                       return ret;
> +
>                 s->memcg_params.root_cache = root_cache;
>                 INIT_LIST_HEAD(&s->memcg_params.children_node);
>                 INIT_LIST_HEAD(&s->memcg_params.kmem_caches_node);
> @@ -170,6 +179,8 @@ static void destroy_memcg_params(struct kmem_cache *s)
>  {
>         if (is_root_cache(s))
>                 kvfree(rcu_access_pointer(s->memcg_params.memcg_caches));
> +       else
> +               percpu_ref_exit(&s->memcg_params.refcnt);
>  }
>
>  static void free_memcg_params(struct rcu_head *rcu)
> @@ -225,6 +236,7 @@ void memcg_link_cache(struct kmem_cache *s, struct mem_cgroup *memcg)
>         if (is_root_cache(s)) {
>                 list_add(&s->root_caches_node, &slab_root_caches);
>         } else {
> +               css_get(&memcg->css);
>                 s->memcg_params.memcg = memcg;
>                 list_add(&s->memcg_params.children_node,
>                          &s->memcg_params.root_cache->memcg_params.children);
> @@ -240,6 +252,7 @@ static void memcg_unlink_cache(struct kmem_cache *s)
>         } else {
>                 list_del(&s->memcg_params.children_node);
>                 list_del(&s->memcg_params.kmem_caches_node);
> +               css_put(&s->memcg_params.memcg->css);
>         }
>  }
>  #else
> @@ -708,16 +721,13 @@ static void kmemcg_after_rcu_workfn(struct work_struct *work)
>
>         put_online_mems();
>         put_online_cpus();
> -
> -       /* done, put the ref from slab_deactivate_memcg_cache_rcu_sched() */
> -       css_put(&s->memcg_params.memcg->css);
>  }
>
>  /*
>   * We need to grab blocking locks.  Bounce to ->work.  The
>   * work item shares the space with the RCU head and can't be
> - * initialized eariler.
> -*/
> + * initialized earlier.
> + */
>  static void kmemcg_schedule_work_after_rcu(struct rcu_head *head)
>  {
>         struct kmem_cache *s = container_of(head, struct kmem_cache,
> @@ -727,9 +737,31 @@ static void kmemcg_schedule_work_after_rcu(struct rcu_head *head)
>         queue_work(memcg_kmem_cache_wq, &s->memcg_params.work);
>  }
>
> +static void kmemcg_cache_shutdown_after_rcu(struct kmem_cache *s)
> +{
> +       WARN_ON(shutdown_cache(s));
> +}
> +
> +static void kmemcg_queue_cache_shutdown(struct percpu_ref *percpu_ref)
> +{
> +       struct kmem_cache *s = container_of(percpu_ref, struct kmem_cache,
> +                                           memcg_params.refcnt);
> +
> +       spin_lock(&memcg_kmem_wq_lock);
> +       if (s->memcg_params.root_cache->memcg_params.dying)
> +               goto unlock;
> +
> +       WARN_ON(s->memcg_params.work_fn);
> +       s->memcg_params.work_fn = kmemcg_cache_shutdown_after_rcu;
> +       call_rcu(&s->memcg_params.rcu_head, kmemcg_schedule_work_after_rcu);
> +unlock:
> +       spin_unlock(&memcg_kmem_wq_lock);
> +}
> +
>  static void kmemcg_cache_deactivate_after_rcu(struct kmem_cache *s)
>  {
>         __kmemcg_cache_deactivate_after_rcu(s);
> +       percpu_ref_kill(&s->memcg_params.refcnt);
>  }
>
>  static void kmemcg_cache_deactivate(struct kmem_cache *s)
> @@ -739,9 +771,6 @@ static void kmemcg_cache_deactivate(struct kmem_cache *s)
>         if (s->memcg_params.root_cache->memcg_params.dying)
>                 return;
>
> -       /* pin memcg so that @s doesn't get destroyed in the middle */
> -       css_get(&s->memcg_params.memcg->css);
> -
>         WARN_ON_ONCE(s->memcg_params.work_fn);
>         s->memcg_params.work_fn = kmemcg_cache_deactivate_after_rcu;
>         call_rcu(&s->memcg_params.rcu_head, kmemcg_schedule_work_after_rcu);
> @@ -775,28 +804,6 @@ void memcg_deactivate_kmem_caches(struct mem_cgroup *memcg)
>         put_online_cpus();
>  }
>
> -void memcg_destroy_kmem_caches(struct mem_cgroup *memcg)
> -{
> -       struct kmem_cache *s, *s2;
> -
> -       get_online_cpus();
> -       get_online_mems();
> -
> -       mutex_lock(&slab_mutex);
> -       list_for_each_entry_safe(s, s2, &memcg->kmem_caches,
> -                                memcg_params.kmem_caches_node) {
> -               /*
> -                * The cgroup is about to be freed and therefore has no charges
> -                * left. Hence, all its caches must be empty by now.
> -                */
> -               BUG_ON(shutdown_cache(s));
> -       }
> -       mutex_unlock(&slab_mutex);
> -
> -       put_online_mems();
> -       put_online_cpus();
> -}
> -
>  static int shutdown_memcg_caches(struct kmem_cache *s)
>  {
>         struct memcg_cache_array *arr;
> @@ -854,8 +861,15 @@ static int shutdown_memcg_caches(struct kmem_cache *s)
>
>  static void flush_memcg_workqueue(struct kmem_cache *s)
>  {
> +       /*
> +        * memcg_params.dying is synchronized using slab_mutex AND
> +        * memcg_kmem_wq_lock spinlock, because it's not always
> +        * possible to grab slab_mutex.
> +        */
>         mutex_lock(&slab_mutex);
> +       spin_lock(&memcg_kmem_wq_lock);
>         s->memcg_params.dying = true;
> +       spin_unlock(&memcg_kmem_wq_lock);
>         mutex_unlock(&slab_mutex);
>
>         /*
> diff --git a/mm/slub.c b/mm/slub.c
> index 13e415cc71b7..0a4ddbeb5ca6 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4018,18 +4018,8 @@ void __kmemcg_cache_deactivate_after_rcu(struct kmem_cache *s)
>  {
>         /*
>          * Called with all the locks held after a sched RCU grace period.
> -        * Even if @s becomes empty after shrinking, we can't know that @s
> -        * doesn't have allocations already in-flight and thus can't
> -        * destroy @s until the associated memcg is released.
> -        *
> -        * However, let's remove the sysfs files for empty caches here.
> -        * Each cache has a lot of interface files which aren't
> -        * particularly useful for empty draining caches; otherwise, we can
> -        * easily end up with millions of unnecessary sysfs files on
> -        * systems which have a lot of memory and transient cgroups.
>          */
> -       if (!__kmem_cache_shrink(s))
> -               sysfs_slab_remove(s);
> +       __kmem_cache_shrink(s);
>  }
>
>  void __kmemcg_cache_deactivate(struct kmem_cache *s)
> --
> 2.20.1
>

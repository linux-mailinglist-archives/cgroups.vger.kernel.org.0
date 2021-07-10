Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314DC3C3445
	for <lists+cgroups@lfdr.de>; Sat, 10 Jul 2021 13:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbhGJLLk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 10 Jul 2021 07:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbhGJLLj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 10 Jul 2021 07:11:39 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5B5C0613E5
        for <cgroups@vger.kernel.org>; Sat, 10 Jul 2021 04:08:55 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id p36so1540230pfw.11
        for <cgroups@vger.kernel.org>; Sat, 10 Jul 2021 04:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iHOLK1FYMKPl4w+01Mt+LZRFbB4PbbyNSj4oldd4dZs=;
        b=aWIygH1Xn0ppYNtHlA/yEW7r4AyE9HfNS4d5ZwSzcFpWGPppoBsUwhGHkvgl7MML3L
         3dzTvDisWhidcvrObMAnacJa83nP3loQd+jGBvxA4Cga0hfwkhCDEgkwJ8RE15kTPHz4
         zm2jHC8qFo17G/v03QK0NrZEPvCEU7tvVXLNUCmaMNE0SbsgPkNbPczhEjsPX6udJQlv
         sBhNXf+/IUO+85NioIiL4IuYqJfvYpWRofUBnOIRvmHHeBH8lw/r6mm59X0172ht4W/4
         jA0/NAzq3T8LvucAn7CYKNuyFQdUSB7vd7/KYLywZouo7CyC+j4EToUy5AWGWedAfjm9
         Iq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iHOLK1FYMKPl4w+01Mt+LZRFbB4PbbyNSj4oldd4dZs=;
        b=cil+d9MIRjsVFbYBqKbcVzAf+eXRQUywIAKxfPAupu3h/R9vIrU72dqlTavvRJgRWr
         Dc8mgr682TZxKavsNvaF/UKNjARnrf9vTfMSd6iaN3s5eLEiLdZtLngm7ctw1YIsxjAA
         POUc2TDZFv3RDAP2fevrcwaURrEn3d5luZwo+YM1h35HWX/GMvj0RrVhMx/OknvcPomN
         mhQ9dWhnbI2czdKIsESq+kil0iU+GomIMI6c/7GMMrC7QM+3lUtDlOqpsS5UsgxGIaqt
         9vLiuojKngNorW21W7cJS6eHFA5VykQkY4F7blRHQdaWeCYGPmc0O1nyXmfeOTkQjOww
         uLSQ==
X-Gm-Message-State: AOAM532DYHLIEu7PTNg5Rf6BqF7stEHj5MaVEq5oDU6+5l1I1fL7ZUv7
        LAXnXuNFJBfftAjdS3sdTWuK0iaq9EjuUMtD/TTRWA==
X-Google-Smtp-Source: ABdhPJw3ZkAEJErp6tvCkZsrv56L0hxL4AmLfrmN+oFf2IIgk3CDs/XOJn2m+oLTpgBSTaxyzpr17xhoKOZMzRR1bHs=
X-Received: by 2002:a63:4607:: with SMTP id t7mr43271329pga.31.1625915334522;
 Sat, 10 Jul 2021 04:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210710003626.3549282-1-surenb@google.com> <20210710003626.3549282-2-surenb@google.com>
In-Reply-To: <20210710003626.3549282-2-surenb@google.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 10 Jul 2021 19:08:17 +0800
Message-ID: <CAMZfGtUqMKnMKDqY7wP+29U-fSxqsOv9OHnaZxQSsOtKrBQYfQ@mail.gmail.com>
Subject: Re: [External] [PATCH v3 2/3] mm, memcg: inline mem_cgroup_{charge/uncharge}
 to improve disabled memcg config
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, Yang Shi <shy828301@gmail.com>,
        Alex Shi <alexs@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, apopple@nvidia.com,
        Minchan Kim <minchan@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jul 10, 2021 at 8:36 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> Inline mem_cgroup_{charge/uncharge} and mem_cgroup_uncharge_list functions
> functions to perform mem_cgroup_disabled static key check inline before
> calling the main body of the function. This minimizes the memcg overhead
> in the pagefault and exit_mmap paths when memcgs are disabled using
> cgroup_disable=memory command-line option.
> This change results in ~0.4% overhead reduction when running PFT test
> comparing {CONFIG_MEMCG=n} against {CONFIG_MEMCG=y, cgroup_disable=memory}
> configurationon on an 8-core ARM64 Android device.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

But some nits below.

> ---
>  include/linux/memcontrol.h | 28 +++++++++++++++++++++++++---
>  mm/memcontrol.c            | 29 ++++++++++-------------------
>  2 files changed, 35 insertions(+), 22 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index bfe5c486f4ad..39fa88051a42 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -693,13 +693,35 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
>                 page_counter_read(&memcg->memory);
>  }
>
> -int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask);
> +int __mem_cgroup_charge(struct page *page, struct mm_struct *mm,
> +                       gfp_t gfp_mask);
> +static inline int mem_cgroup_charge(struct page *page, struct mm_struct *mm,
> +                                   gfp_t gfp_mask)
> +{
> +       if (mem_cgroup_disabled())
> +               return 0;
> +       return __mem_cgroup_charge(page, mm, gfp_mask);
> +}
> +
>  int mem_cgroup_swapin_charge_page(struct page *page, struct mm_struct *mm,
>                                   gfp_t gfp, swp_entry_t entry);
>  void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry);
>
> -void mem_cgroup_uncharge(struct page *page);
> -void mem_cgroup_uncharge_list(struct list_head *page_list);
> +void __mem_cgroup_uncharge(struct page *page);
> +static inline void mem_cgroup_uncharge(struct page *page)
> +{
> +       if (mem_cgroup_disabled())
> +               return;
> +       __mem_cgroup_uncharge(page);
> +}
> +
> +void __mem_cgroup_uncharge_list(struct list_head *page_list);
> +static inline void mem_cgroup_uncharge_list(struct list_head *page_list)
> +{
> +       if (mem_cgroup_disabled())
> +               return;
> +       __mem_cgroup_uncharge_list(page_list);
> +}
>
>  void mem_cgroup_migrate(struct page *oldpage, struct page *newpage);
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index a228cd51c4bd..cdaf7003b43d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6701,8 +6701,7 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
>                         atomic_long_read(&parent->memory.children_low_usage)));
>  }
>
> -static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
> -                              gfp_t gfp)
> +static int charge_memcg(struct page *page, struct mem_cgroup *memcg, gfp_t gfp)
>  {
>         unsigned int nr_pages = thp_nr_pages(page);
>         int ret;
> @@ -6723,7 +6722,7 @@ static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
>  }
>
>  /**
> - * mem_cgroup_charge - charge a newly allocated page to a cgroup
> + * __mem_cgroup_charge - charge a newly allocated page to a cgroup
>   * @page: page to charge
>   * @mm: mm context of the victim
>   * @gfp_mask: reclaim mode
> @@ -6736,16 +6735,14 @@ static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
>   *
>   * Returns 0 on success. Otherwise, an error code is returned.
>   */
> -int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
> +int __mem_cgroup_charge(struct page *page, struct mm_struct *mm,
> +                       gfp_t gfp_mask)
>  {
>         struct mem_cgroup *memcg;
>         int ret;
>
> -       if (mem_cgroup_disabled())
> -               return 0;
> -
>         memcg = get_mem_cgroup_from_mm(mm);
> -       ret = __mem_cgroup_charge(page, memcg, gfp_mask);
> +       ret = charge_memcg(page, memcg, gfp_mask);
>         css_put(&memcg->css);
>
>         return ret;
> @@ -6780,7 +6777,7 @@ int mem_cgroup_swapin_charge_page(struct page *page, struct mm_struct *mm,
>                 memcg = get_mem_cgroup_from_mm(mm);
>         rcu_read_unlock();
>
> -       ret = __mem_cgroup_charge(page, memcg, gfp);
> +       ret = charge_memcg(page, memcg, gfp);
>
>         css_put(&memcg->css);
>         return ret;
> @@ -6916,18 +6913,15 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
>  }
>
>  /**
> - * mem_cgroup_uncharge - uncharge a page
> + * __mem_cgroup_uncharge - uncharge a page
>   * @page: page to uncharge
>   *
>   * Uncharge a page previously charged with mem_cgroup_charge().

The comment here also needs to be updated.

mem_cgroup_uncharge() -> __mem_cgroup_uncharge()

>   */
> -void mem_cgroup_uncharge(struct page *page)
> +void __mem_cgroup_uncharge(struct page *page)
>  {
>         struct uncharge_gather ug;
>
> -       if (mem_cgroup_disabled())
> -               return;
> -
>         /* Don't touch page->lru of any random page, pre-check: */
>         if (!page_memcg(page))
>                 return;
> @@ -6938,20 +6932,17 @@ void mem_cgroup_uncharge(struct page *page)
>  }
>
>  /**
> - * mem_cgroup_uncharge_list - uncharge a list of page
> + * __mem_cgroup_uncharge_list - uncharge a list of page
>   * @page_list: list of pages to uncharge
>   *
>   * Uncharge a list of pages previously charged with
>   * mem_cgroup_charge().

Should be __mem_cgroup_charge().

Thanks.

>   */
> -void mem_cgroup_uncharge_list(struct list_head *page_list)
> +void __mem_cgroup_uncharge_list(struct list_head *page_list)
>  {
>         struct uncharge_gather ug;
>         struct page *page;
>
> -       if (mem_cgroup_disabled())
> -               return;
> -
>         uncharge_gather_clear(&ug);
>         list_for_each_entry(page, page_list, lru)
>                 uncharge_page(page, &ug);
> --
> 2.32.0.93.g670b81a890-goog
>

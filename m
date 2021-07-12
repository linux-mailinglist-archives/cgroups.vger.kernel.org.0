Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED2C3C5FD5
	for <lists+cgroups@lfdr.de>; Mon, 12 Jul 2021 17:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhGLP6m (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Jul 2021 11:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhGLP6l (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Jul 2021 11:58:41 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F369C0613E5
        for <cgroups@vger.kernel.org>; Mon, 12 Jul 2021 08:55:53 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id a16so29746418ybt.8
        for <cgroups@vger.kernel.org>; Mon, 12 Jul 2021 08:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Raj1UT+7iEKURSfnOW0pEUCg9+O5+IgIN4/nayR4b58=;
        b=rAzcoXutzrxwsjJ5J3QY3cKNxelhImJ/Gets9R0vMnBqddQbr4Op/jax00Dd+VbjB/
         UDS8PgKmDbUEc88QO3W90w7SKlzN5ihTeaDe1kItEZ2oyYWflTJ2Ja1NYvdO9hb76vxc
         /Jw3sngbmTWyzMszx/o24ySRU0iWr//eTJN1sP/tjsA+ftQj6CACobZkTSHM9GbuE6lp
         XyEnvRzAk2kZsD7W+rCNQfy7ohOASzQAQddDALqxtshI6GEdd6KWTvi6lqA4aUm6KyWB
         4LiPZDRqQ7DIrN6S6+2mRItFScOhD2X/BvsGT56obyMikYYeSKKHt4mXZjlgrW3Cqn+A
         VzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Raj1UT+7iEKURSfnOW0pEUCg9+O5+IgIN4/nayR4b58=;
        b=rnE6BjlpcnWgHaKaEOzlsqtKE34hyuoETE0GToTNlA6PMk3yNwyFS5HX2/6PUsHWxB
         b6vJl9lUTH3W3AvTxtTUFcZQsS5ADOo5wkco8nziBFtYEaVEBnKzcoWkgQtQi8yXWbUR
         1N6DrXalfGvmitc74aUsvzAFpW2F392F9RgEyP8oFp4RmPsyRR1uW3tiUzdhL+diaLa5
         XW5ox0wIibO2YWUdcQvK16bDLiS7c1SxYX2ndSVkKCg0VqNaPzH2BmYNBnK88OY6eNP8
         85n1jAix+rN6swO9VXSsT01rXiq6kqr7lFtm0tJJFYQIFe6AGP+gzGXdnvapUYyG9A3t
         Clyg==
X-Gm-Message-State: AOAM532G9znXusJp7YazEin8UDal6Ls8mK5mu7bx2fNCiGWOtN2zCbw9
        8Og2APwK4frZdNDr4qDHyuh4FqMkQHZgA8m3ynjezw==
X-Google-Smtp-Source: ABdhPJx8Wzn4MXANCSwsv2C5UtK/S4TmoqfrZSJa2X310gqPQQRfxU9XUzfck3KrssDDp9CBbu2UW/2tzSem8lhHKGs=
X-Received: by 2002:a25:d912:: with SMTP id q18mr12462254ybg.294.1626105352175;
 Mon, 12 Jul 2021 08:55:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210710003626.3549282-1-surenb@google.com> <20210710003626.3549282-2-surenb@google.com>
 <YOvsAG+F0n2U3c88@dhcp22.suse.cz>
In-Reply-To: <YOvsAG+F0n2U3c88@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 12 Jul 2021 08:55:41 -0700
Message-ID: <CAJuCfpGvB-nfJBM8wOXQCu-iXygDjBUaZOzqo=1HbW8ZxCkWCg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mm, memcg: inline mem_cgroup_{charge/uncharge} to
 improve disabled memcg config
To:     Michal Hocko <mhocko@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        vdavydov.dev@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, songmuchun@bytedance.com,
        Yang Shi <shy828301@gmail.com>, alexs@kernel.org,
        richard.weiyang@gmail.com, Vlastimil Babka <vbabka@suse.cz>,
        Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, apopple@nvidia.com,
        Minchan Kim <minchan@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 12, 2021 at 12:15 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 09-07-21 17:36:25, Suren Baghdasaryan wrote:
> > Inline mem_cgroup_{charge/uncharge} and mem_cgroup_uncharge_list functions
> > functions to perform mem_cgroup_disabled static key check inline before
> > calling the main body of the function. This minimizes the memcg overhead
> > in the pagefault and exit_mmap paths when memcgs are disabled using
> > cgroup_disable=memory command-line option.
> > This change results in ~0.4% overhead reduction when running PFT test
> > comparing {CONFIG_MEMCG=n} against {CONFIG_MEMCG=y, cgroup_disable=memory}
> > configurationon on an 8-core ARM64 Android device.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Reviewed-by: Shakeel Butt <shakeelb@google.com>
>
> With doc updated as suggested by Muchun Song
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks! Will fix the comment and post v4 later today.

>
> Thanks!
>
> > ---
> >  include/linux/memcontrol.h | 28 +++++++++++++++++++++++++---
> >  mm/memcontrol.c            | 29 ++++++++++-------------------
> >  2 files changed, 35 insertions(+), 22 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index bfe5c486f4ad..39fa88051a42 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -693,13 +693,35 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
> >               page_counter_read(&memcg->memory);
> >  }
> >
> > -int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask);
> > +int __mem_cgroup_charge(struct page *page, struct mm_struct *mm,
> > +                     gfp_t gfp_mask);
> > +static inline int mem_cgroup_charge(struct page *page, struct mm_struct *mm,
> > +                                 gfp_t gfp_mask)
> > +{
> > +     if (mem_cgroup_disabled())
> > +             return 0;
> > +     return __mem_cgroup_charge(page, mm, gfp_mask);
> > +}
> > +
> >  int mem_cgroup_swapin_charge_page(struct page *page, struct mm_struct *mm,
> >                                 gfp_t gfp, swp_entry_t entry);
> >  void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry);
> >
> > -void mem_cgroup_uncharge(struct page *page);
> > -void mem_cgroup_uncharge_list(struct list_head *page_list);
> > +void __mem_cgroup_uncharge(struct page *page);
> > +static inline void mem_cgroup_uncharge(struct page *page)
> > +{
> > +     if (mem_cgroup_disabled())
> > +             return;
> > +     __mem_cgroup_uncharge(page);
> > +}
> > +
> > +void __mem_cgroup_uncharge_list(struct list_head *page_list);
> > +static inline void mem_cgroup_uncharge_list(struct list_head *page_list)
> > +{
> > +     if (mem_cgroup_disabled())
> > +             return;
> > +     __mem_cgroup_uncharge_list(page_list);
> > +}
> >
> >  void mem_cgroup_migrate(struct page *oldpage, struct page *newpage);
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index a228cd51c4bd..cdaf7003b43d 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -6701,8 +6701,7 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
> >                       atomic_long_read(&parent->memory.children_low_usage)));
> >  }
> >
> > -static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
> > -                            gfp_t gfp)
> > +static int charge_memcg(struct page *page, struct mem_cgroup *memcg, gfp_t gfp)
> >  {
> >       unsigned int nr_pages = thp_nr_pages(page);
> >       int ret;
> > @@ -6723,7 +6722,7 @@ static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
> >  }
> >
> >  /**
> > - * mem_cgroup_charge - charge a newly allocated page to a cgroup
> > + * __mem_cgroup_charge - charge a newly allocated page to a cgroup
> >   * @page: page to charge
> >   * @mm: mm context of the victim
> >   * @gfp_mask: reclaim mode
> > @@ -6736,16 +6735,14 @@ static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
> >   *
> >   * Returns 0 on success. Otherwise, an error code is returned.
> >   */
> > -int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
> > +int __mem_cgroup_charge(struct page *page, struct mm_struct *mm,
> > +                     gfp_t gfp_mask)
> >  {
> >       struct mem_cgroup *memcg;
> >       int ret;
> >
> > -     if (mem_cgroup_disabled())
> > -             return 0;
> > -
> >       memcg = get_mem_cgroup_from_mm(mm);
> > -     ret = __mem_cgroup_charge(page, memcg, gfp_mask);
> > +     ret = charge_memcg(page, memcg, gfp_mask);
> >       css_put(&memcg->css);
> >
> >       return ret;
> > @@ -6780,7 +6777,7 @@ int mem_cgroup_swapin_charge_page(struct page *page, struct mm_struct *mm,
> >               memcg = get_mem_cgroup_from_mm(mm);
> >       rcu_read_unlock();
> >
> > -     ret = __mem_cgroup_charge(page, memcg, gfp);
> > +     ret = charge_memcg(page, memcg, gfp);
> >
> >       css_put(&memcg->css);
> >       return ret;
> > @@ -6916,18 +6913,15 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
> >  }
> >
> >  /**
> > - * mem_cgroup_uncharge - uncharge a page
> > + * __mem_cgroup_uncharge - uncharge a page
> >   * @page: page to uncharge
> >   *
> >   * Uncharge a page previously charged with mem_cgroup_charge().
> >   */
> > -void mem_cgroup_uncharge(struct page *page)
> > +void __mem_cgroup_uncharge(struct page *page)
> >  {
> >       struct uncharge_gather ug;
> >
> > -     if (mem_cgroup_disabled())
> > -             return;
> > -
> >       /* Don't touch page->lru of any random page, pre-check: */
> >       if (!page_memcg(page))
> >               return;
> > @@ -6938,20 +6932,17 @@ void mem_cgroup_uncharge(struct page *page)
> >  }
> >
> >  /**
> > - * mem_cgroup_uncharge_list - uncharge a list of page
> > + * __mem_cgroup_uncharge_list - uncharge a list of page
> >   * @page_list: list of pages to uncharge
> >   *
> >   * Uncharge a list of pages previously charged with
> >   * mem_cgroup_charge().
> >   */
> > -void mem_cgroup_uncharge_list(struct list_head *page_list)
> > +void __mem_cgroup_uncharge_list(struct list_head *page_list)
> >  {
> >       struct uncharge_gather ug;
> >       struct page *page;
> >
> > -     if (mem_cgroup_disabled())
> > -             return;
> > -
> >       uncharge_gather_clear(&ug);
> >       list_for_each_entry(page, page_list, lru)
> >               uncharge_page(page, &ug);
> > --
> > 2.32.0.93.g670b81a890-goog
>
> --
> Michal Hocko
> SUSE Labs

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0695F3C67EA
	for <lists+cgroups@lfdr.de>; Tue, 13 Jul 2021 03:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbhGMBPX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Jul 2021 21:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbhGMBPX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Jul 2021 21:15:23 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F65CC0613E9
        for <cgroups@vger.kernel.org>; Mon, 12 Jul 2021 18:12:34 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id a16so32055967ybt.8
        for <cgroups@vger.kernel.org>; Mon, 12 Jul 2021 18:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c3oAlTpbgK6u4tipighDXmanWuC5k+j2pz7LHeW3niE=;
        b=seQEp+0/ZpN/RK+fvG8klQBC3j7eW84QimkF86nmGyY8xuENBGhMw/dtqU1HqofJx+
         qSF0iqRZHKLoVWniM5fTCcOUAjyzBzRrYYe+wnEeP0L4Q3nCGdKo26wTAWGF2mauRJ13
         tOjhFdoOphrNcXGK5aZ3VIEoNG5cpH3qtf44HaWa3kVoS3HyVvFPk1wzWkFt7rYB+wDj
         BMjF8FxNIvqAFCI1dYFSD4ul3G7utINcF0CRxMJaegbwDLfC9FzeE84nmEd3ruMsE9uO
         E7YXB/C92IzbWGPUaQZv0Ad5pbbwzMDyFghYA563uleRAgkGiwnjUnZaOijuQI4p0IFN
         MPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c3oAlTpbgK6u4tipighDXmanWuC5k+j2pz7LHeW3niE=;
        b=KIhGLXz+qj3+JZmN3DzJp99K0BX6cTOyJIxpN0zroNTXofj7LktfzoHyJU6qkR1bcn
         lVzhaV45S1gx6oS7O4zpqakyacTlkOzcm3ho2p5Ny491PgjphbefrvBig9yu+vpRvJdO
         vKEtw0N8XkWF/Vxdm1zIeIsQ4id/oEuEi95FmwG7CR3TN75olmyHYtL+KLo0FdfhjXSE
         TYZ15yuD3WkQgc4VucKmsAI9o1ky/C1/t7NZNbWSBgJ1aR2l2/VmnjZ4HWer1zSpoFNp
         mzxYEUg3eOENMVeGzh8cWL2QmJYPmzX/bqQhZTHsG+jS1bmRnivF7OtSg+QZtpOKOpZ+
         R11Q==
X-Gm-Message-State: AOAM532Ds+HrWkEgzGMSqKz2eQb5PEcK5ah+OAowc9WdzlgexCXCyPBN
        Ui2QJjB/O1QwQggGxXttSBbisLzrH0IOejP4JqQ9hg==
X-Google-Smtp-Source: ABdhPJxoAygQp3R5au+npJIEr+9s6ZSsT7fy1m9V4+Af9mxLInsnUJJW5H0O1wZ3wJgC8UPwCnT32W71U/fnUkV4MPI=
X-Received: by 2002:a25:71c4:: with SMTP id m187mr2357132ybc.397.1626138753430;
 Mon, 12 Jul 2021 18:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210710003626.3549282-1-surenb@google.com> <20210710003626.3549282-2-surenb@google.com>
 <CAMZfGtUqMKnMKDqY7wP+29U-fSxqsOv9OHnaZxQSsOtKrBQYfQ@mail.gmail.com>
In-Reply-To: <CAMZfGtUqMKnMKDqY7wP+29U-fSxqsOv9OHnaZxQSsOtKrBQYfQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 12 Jul 2021 18:12:22 -0700
Message-ID: <CAJuCfpGB96oDToQewi6x2AAc03S1v0A97Z4OyiyZG9hCJ6nSOA@mail.gmail.com>
Subject: Re: [External] [PATCH v3 2/3] mm, memcg: inline mem_cgroup_{charge/uncharge}
 to improve disabled memcg config
To:     Muchun Song <songmuchun@bytedance.com>
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
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jul 10, 2021 at 4:08 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Sat, Jul 10, 2021 at 8:36 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >
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
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
>
> But some nits below.
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
> >                 page_counter_read(&memcg->memory);
> >  }
> >
> > -int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask);
> > +int __mem_cgroup_charge(struct page *page, struct mm_struct *mm,
> > +                       gfp_t gfp_mask);
> > +static inline int mem_cgroup_charge(struct page *page, struct mm_struct *mm,
> > +                                   gfp_t gfp_mask)
> > +{
> > +       if (mem_cgroup_disabled())
> > +               return 0;
> > +       return __mem_cgroup_charge(page, mm, gfp_mask);
> > +}
> > +
> >  int mem_cgroup_swapin_charge_page(struct page *page, struct mm_struct *mm,
> >                                   gfp_t gfp, swp_entry_t entry);
> >  void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry);
> >
> > -void mem_cgroup_uncharge(struct page *page);
> > -void mem_cgroup_uncharge_list(struct list_head *page_list);
> > +void __mem_cgroup_uncharge(struct page *page);
> > +static inline void mem_cgroup_uncharge(struct page *page)
> > +{
> > +       if (mem_cgroup_disabled())
> > +               return;
> > +       __mem_cgroup_uncharge(page);
> > +}
> > +
> > +void __mem_cgroup_uncharge_list(struct list_head *page_list);
> > +static inline void mem_cgroup_uncharge_list(struct list_head *page_list)
> > +{
> > +       if (mem_cgroup_disabled())
> > +               return;
> > +       __mem_cgroup_uncharge_list(page_list);
> > +}
> >
> >  void mem_cgroup_migrate(struct page *oldpage, struct page *newpage);
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index a228cd51c4bd..cdaf7003b43d 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -6701,8 +6701,7 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
> >                         atomic_long_read(&parent->memory.children_low_usage)));
> >  }
> >
> > -static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
> > -                              gfp_t gfp)
> > +static int charge_memcg(struct page *page, struct mem_cgroup *memcg, gfp_t gfp)
> >  {
> >         unsigned int nr_pages = thp_nr_pages(page);
> >         int ret;
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
> > +                       gfp_t gfp_mask)
> >  {
> >         struct mem_cgroup *memcg;
> >         int ret;
> >
> > -       if (mem_cgroup_disabled())
> > -               return 0;
> > -
> >         memcg = get_mem_cgroup_from_mm(mm);
> > -       ret = __mem_cgroup_charge(page, memcg, gfp_mask);
> > +       ret = charge_memcg(page, memcg, gfp_mask);
> >         css_put(&memcg->css);
> >
> >         return ret;
> > @@ -6780,7 +6777,7 @@ int mem_cgroup_swapin_charge_page(struct page *page, struct mm_struct *mm,
> >                 memcg = get_mem_cgroup_from_mm(mm);
> >         rcu_read_unlock();
> >
> > -       ret = __mem_cgroup_charge(page, memcg, gfp);
> > +       ret = charge_memcg(page, memcg, gfp);
> >
> >         css_put(&memcg->css);
> >         return ret;
> > @@ -6916,18 +6913,15 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
> >  }
> >
> >  /**
> > - * mem_cgroup_uncharge - uncharge a page
> > + * __mem_cgroup_uncharge - uncharge a page
> >   * @page: page to uncharge
> >   *
> >   * Uncharge a page previously charged with mem_cgroup_charge().
>
> The comment here also needs to be updated.
>
> mem_cgroup_uncharge() -> __mem_cgroup_uncharge()
>
> >   */
> > -void mem_cgroup_uncharge(struct page *page)
> > +void __mem_cgroup_uncharge(struct page *page)
> >  {
> >         struct uncharge_gather ug;
> >
> > -       if (mem_cgroup_disabled())
> > -               return;
> > -
> >         /* Don't touch page->lru of any random page, pre-check: */
> >         if (!page_memcg(page))
> >                 return;
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
>
> Should be __mem_cgroup_charge().

Fixed and posted in v4 at:
https://lore.kernel.org/patchwork/project/lkml/list/?series=507943
Thanks!

>
> Thanks.
>
> >   */
> > -void mem_cgroup_uncharge_list(struct list_head *page_list)
> > +void __mem_cgroup_uncharge_list(struct list_head *page_list)
> >  {
> >         struct uncharge_gather ug;
> >         struct page *page;
> >
> > -       if (mem_cgroup_disabled())
> > -               return;
> > -
> >         uncharge_gather_clear(&ug);
> >         list_for_each_entry(page, page_list, lru)
> >                 uncharge_page(page, &ug);
> > --
> > 2.32.0.93.g670b81a890-goog
> >

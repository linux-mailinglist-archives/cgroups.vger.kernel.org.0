Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6213B3C26B9
	for <lists+cgroups@lfdr.de>; Fri,  9 Jul 2021 17:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbhGIPVc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 9 Jul 2021 11:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbhGIPVb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 9 Jul 2021 11:21:31 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811B2C0613E5
        for <cgroups@vger.kernel.org>; Fri,  9 Jul 2021 08:18:48 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id p22so15176561yba.7
        for <cgroups@vger.kernel.org>; Fri, 09 Jul 2021 08:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hGX3UGEwXfFwKKdhbKxdN5Z9a9eTLdUcU8IFnRtBKXI=;
        b=dxLikpQTw+JGI68eVGXPE6+Vh6CNs2aa72+3GaFp/nhZH3pkxKvuJ4GDphfvTwANQh
         DwW5jmyPQNxQp+Gyg+r7oZaSKpbXMTnjJ9thXEB5FircFSbyu2WlopPeIjGFD4KnbEJ3
         bYzsdtMFPHBOdJiiJ2OcgObtZ/BHPgIcxPnlYvdZIjtQpa1ltOWVphSG/gUJ6w+ODLMF
         9RBzHBKRDJXEzH9lBmrhfqHDt7i9UzkjLi0ltOMOhrvm+TUFqvi/v0HjDEIMYHVm2mga
         7RvC6esBxwFX8ldoMQR+kadRcZVFoEXd48ZRjWo3iW1tQHu+xqXdgTmwcUhQXbR+S8So
         4Srw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hGX3UGEwXfFwKKdhbKxdN5Z9a9eTLdUcU8IFnRtBKXI=;
        b=WHRJxaSuT/ZKlcKEacsJi64sq+zODz0KirBy/85Ibj6c+6aNTbTaqExn7OsADiSUvx
         gXsY/N5DPQxEazAro0G/Ec4aXa0iUkfePxtjUjJIVNbNGlpONi2itYgY2OyFH4NVI1EI
         oYmNCgGhM2RcGeZX4kKA/elhmgQwuVe1nNlo6eO7RidQ0fwJS+sO1pC0UXmu1flCptoG
         Ska7U16D21wrEDRK+36wOq1pypDJO7TILm9LUfDFCnBvJz44qA0hvJ6Dfq+kQ1cOROPY
         8WCgVcPCn9kw4AnRQRHge3VtQyilLArCNPehofo3vpvJLKgbenWVSClCpxSivut6QWN5
         JX5g==
X-Gm-Message-State: AOAM531Nm+2lD2iHM6AIHMWGjzcv0oWrT4DgC4mAjkZwAyZ7vYdH/f3b
        /HdZzM+Oupk3O3y6FbfNCOJdSx6SF5Aq+PQLv8kINw==
X-Google-Smtp-Source: ABdhPJwy1KyUlSJdT8D6JvKzadspjS0MDYDuIZ/heFt7araixWEYiSoXGf5pfMlKnIsH+B/BkTG08YBlEtc8qa7V6Ts=
X-Received: by 2002:a25:ba08:: with SMTP id t8mr47499494ybg.111.1625843927371;
 Fri, 09 Jul 2021 08:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210709000509.2618345-1-surenb@google.com> <20210709000509.2618345-3-surenb@google.com>
 <YOhh0IabpRk/W/qR@cmpxchg.org>
In-Reply-To: <YOhh0IabpRk/W/qR@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 9 Jul 2021 08:18:36 -0700
Message-ID: <CAJuCfpFFNZ1DNQHFOyGwafw1MBHfELDzp2iqR4ot-gm3SGNNBA@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm, memcg: inline mem_cgroup_{charge/uncharge} to
 improve disabled memcg config
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@kernel.org>,
        vdavydov.dev@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, songmuchun@bytedance.com,
        Yang Shi <shy828301@gmail.com>, alexs@kernel.org,
        alexander.h.duyck@linux.intel.com, richard.weiyang@gmail.com,
        Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, apopple@nvidia.com,
        Minchan Kim <minchan@kernel.org>, linmiaohe@huawei.com,
        LKML <linux-kernel@vger.kernel.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jul 9, 2021 at 7:48 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Thu, Jul 08, 2021 at 05:05:08PM -0700, Suren Baghdasaryan wrote:
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
>
> Sounds reasonable to me as well. One comment:
>
> > @@ -693,13 +693,59 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
> >               page_counter_read(&memcg->memory);
> >  }
> >
> > -int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask);
> > +struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm);
> > +
> > +int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
> > +                     gfp_t gfp);
> > +/**
> > + * mem_cgroup_charge - charge a newly allocated page to a cgroup
> > + * @page: page to charge
> > + * @mm: mm context of the victim
> > + * @gfp_mask: reclaim mode
> > + *
> > + * Try to charge @page to the memcg that @mm belongs to, reclaiming
> > + * pages according to @gfp_mask if necessary. if @mm is NULL, try to
> > + * charge to the active memcg.
> > + *
> > + * Do not use this for pages allocated for swapin.
> > + *
> > + * Returns 0 on success. Otherwise, an error code is returned.
> > + */
> > +static inline int mem_cgroup_charge(struct page *page, struct mm_struct *mm,
> > +                                 gfp_t gfp_mask)
> > +{
> > +     struct mem_cgroup *memcg;
> > +     int ret;
> > +
> > +     if (mem_cgroup_disabled())
> > +             return 0;
> > +
> > +     memcg = get_mem_cgroup_from_mm(mm);
> > +     ret = __mem_cgroup_charge(page, memcg, gfp_mask);
> > +     css_put(&memcg->css);
> > +
> > +     return ret;
>
> Why not do
>
> int __mem_cgroup_charge(struct page *page, struct mm_struct *mm,
>                         gfp_t gfp_mask);
>
> static inline int mem_cgroup_charge(struct page *page, struct mm_struct *mm,
>                                     gfp_t gfp_mask)
> {
>         if (mem_cgroup_disabled())
>                 return 0;
>
>         return __mem_cgroup_charge(page, memcg, gfp_mask);
> }
>
> like in the other cases as well?
>
> That would avoid inlining two separate function calls into all the
> callsites...
>
> There is an (internal) __mem_cgroup_charge() already, but you can
> rename it charge_memcg().

Sounds good. I'll post an updated version with your suggestion.
Thanks for the review, Johannes!

>

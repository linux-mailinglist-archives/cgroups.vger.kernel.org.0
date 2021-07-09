Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB19E3C282E
	for <lists+cgroups@lfdr.de>; Fri,  9 Jul 2021 19:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhGIRUo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 9 Jul 2021 13:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhGIRUo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 9 Jul 2021 13:20:44 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1963AC0613E5
        for <cgroups@vger.kernel.org>; Fri,  9 Jul 2021 10:18:00 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id o139so15746762ybg.9
        for <cgroups@vger.kernel.org>; Fri, 09 Jul 2021 10:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6F4LOb4/qbICNruJHwbsWh8y31MCaegySpX98sO3li0=;
        b=NMc2lbTxvLMqVFevQe6lCca1Wk+YJmMCWhkCP6Iy4HwWowK2M9RJ2jBgpcfpA+yn/t
         2FMysA7140dTnBDBQrluNz0Y7eYYGHjLLpFg/WjfRb4WvKMaZxXuAU2z7VjzRMPx+9Rv
         DMaFCjFdwle1AchujQt/7vV48KFnN9nQOsXeqQK44TnPH43LwFGSoCklkIT9o2jRJKlY
         SOCUi4qdZXCyjlPmJMkV2NHx+mpdy8iSGld11vCUYr2Xc+nbof7t0CznipuL94S/THLf
         RRNXF9WsCaD6ZFmEauMBLXdLJvyj93jP/mI0ACpdmWs80NC+gb+A1VPVKHSWPoqsQYyG
         lqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6F4LOb4/qbICNruJHwbsWh8y31MCaegySpX98sO3li0=;
        b=WDN8HbbB0w3pqAU6uyUUa/BQZhXe/awCXo9Qt4LpvaRHUbiDjNOVRMRuGkNwPsVBqM
         bxI30Zmuhec3kTFukcLqO9ojHs7jSVlz1dV39yBts9PggkZY/cKeaaWH9CaMZX6xx5Tz
         AkGYAuBb3yXAy651Ace+lQ3xu206gTg60gQQSH4Rlt/o08sWqtgU6asi3dzriWfZtFZ7
         N+Y9OYyuEIFTmVRtSd3tbrhaDjHejSrTZYZE7zEcejM1kYV7sAH/i+W+LydMDZEvCGNg
         ZwFoam2zfVsdJILWGEL4/9hdTbQ2/inyp3mfY0jdK3Z1cA5JmOLz/qt3BEFeFNlw/tK4
         +bxQ==
X-Gm-Message-State: AOAM532uATJVMxeqdlL8mIad0Og8cUkjepRz23UbORcwaQTwW5AUbYvw
        aWSryztLHSzaIRAMAi4w6mzi8DeWouH2nqoVV58ULw==
X-Google-Smtp-Source: ABdhPJxvDpErNQxWRcZ+MAU94htzfVrGLAtZSmM+xT/xKHWMkDpKUC0qh5Gifw5VgIUNzKQBoMCh/4II+yF8rMrM14c=
X-Received: by 2002:a25:71c4:: with SMTP id m187mr42560004ybc.397.1625851079037;
 Fri, 09 Jul 2021 10:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210709000509.2618345-1-surenb@google.com> <20210709000509.2618345-3-surenb@google.com>
 <YOhh0IabpRk/W/qR@cmpxchg.org> <CAJuCfpFFNZ1DNQHFOyGwafw1MBHfELDzp2iqR4ot-gm3SGNNBA@mail.gmail.com>
In-Reply-To: <CAJuCfpFFNZ1DNQHFOyGwafw1MBHfELDzp2iqR4ot-gm3SGNNBA@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 9 Jul 2021 10:17:48 -0700
Message-ID: <CAJuCfpHTT6v2Gjph=BMHPRQ76DRY8q3+4UEs0gaOkm3cLvJKDw@mail.gmail.com>
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

On Fri, Jul 9, 2021 at 8:18 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Fri, Jul 9, 2021 at 7:48 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Thu, Jul 08, 2021 at 05:05:08PM -0700, Suren Baghdasaryan wrote:
> > > Inline mem_cgroup_{charge/uncharge} and mem_cgroup_uncharge_list functions
> > > functions to perform mem_cgroup_disabled static key check inline before
> > > calling the main body of the function. This minimizes the memcg overhead
> > > in the pagefault and exit_mmap paths when memcgs are disabled using
> > > cgroup_disable=memory command-line option.
> > > This change results in ~0.4% overhead reduction when running PFT test
> > > comparing {CONFIG_MEMCG=n} against {CONFIG_MEMCG=y, cgroup_disable=memory}
> > > configurationon on an 8-core ARM64 Android device.
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >
> > Sounds reasonable to me as well. One comment:
> >
> > > @@ -693,13 +693,59 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
> > >               page_counter_read(&memcg->memory);
> > >  }
> > >
> > > -int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask);
> > > +struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm);
> > > +
> > > +int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
> > > +                     gfp_t gfp);
> > > +/**
> > > + * mem_cgroup_charge - charge a newly allocated page to a cgroup
> > > + * @page: page to charge
> > > + * @mm: mm context of the victim
> > > + * @gfp_mask: reclaim mode
> > > + *
> > > + * Try to charge @page to the memcg that @mm belongs to, reclaiming
> > > + * pages according to @gfp_mask if necessary. if @mm is NULL, try to
> > > + * charge to the active memcg.
> > > + *
> > > + * Do not use this for pages allocated for swapin.
> > > + *
> > > + * Returns 0 on success. Otherwise, an error code is returned.
> > > + */
> > > +static inline int mem_cgroup_charge(struct page *page, struct mm_struct *mm,
> > > +                                 gfp_t gfp_mask)
> > > +{
> > > +     struct mem_cgroup *memcg;
> > > +     int ret;
> > > +
> > > +     if (mem_cgroup_disabled())
> > > +             return 0;
> > > +
> > > +     memcg = get_mem_cgroup_from_mm(mm);
> > > +     ret = __mem_cgroup_charge(page, memcg, gfp_mask);
> > > +     css_put(&memcg->css);
> > > +
> > > +     return ret;
> >
> > Why not do
> >
> > int __mem_cgroup_charge(struct page *page, struct mm_struct *mm,
> >                         gfp_t gfp_mask);
> >
> > static inline int mem_cgroup_charge(struct page *page, struct mm_struct *mm,
> >                                     gfp_t gfp_mask)
> > {
> >         if (mem_cgroup_disabled())
> >                 return 0;
> >
> >         return __mem_cgroup_charge(page, memcg, gfp_mask);
> > }
> >
> > like in the other cases as well?
> >
> > That would avoid inlining two separate function calls into all the
> > callsites...
> >
> > There is an (internal) __mem_cgroup_charge() already, but you can
> > rename it charge_memcg().
>
> Sounds good. I'll post an updated version with your suggestion.
> Thanks for the review, Johannes!

Posted v2 just for this patch at
https://lore.kernel.org/patchwork/patch/1455550 . Please let me know
if you want me to resent the whole patchset instead of just this
patch.
>
> >

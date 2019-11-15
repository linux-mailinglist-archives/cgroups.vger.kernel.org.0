Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 438E9FE364
	for <lists+cgroups@lfdr.de>; Fri, 15 Nov 2019 17:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfKOQwl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Nov 2019 11:52:41 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45258 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbfKOQwh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Nov 2019 11:52:37 -0500
Received: by mail-oi1-f194.google.com with SMTP id 14so9149993oir.12
        for <cgroups@vger.kernel.org>; Fri, 15 Nov 2019 08:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x9nEfpm4Qn3KUPLEqiBqX+Wd5id0rONEYyby+X9G1pY=;
        b=dZnOiRSTLZSxks+CVIAANablbHG+rIYQIX3NV7GjDmo/GIrgxmBn8pgMKzhF99Nf8W
         T37eXKZegY3lpG8kmBVdH3+UpUoxgAzo5EbonaljTE64o96bjQBiNSRYAl/sthMnPi1g
         g9TiNZzFHEFLJ2eCr+Xa6RHsinhdBYjxEYFd0GOlHCVrOIio9KP0ZQRumTJhosrYcL4F
         23cjDvd7e1akEQLnakcYzmmHy58/3Bgd9X/1wCjNiZFpv5sZUO9pXguURYrKJKJ224j8
         JOH33/I93oBH8RwMtbsqT4zlw6+wp5KlhZFC4QsIPG904WjC6r+hdpC/QOhqoRIAYckF
         NlCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x9nEfpm4Qn3KUPLEqiBqX+Wd5id0rONEYyby+X9G1pY=;
        b=Hx6JeopG/pdpMNXRKfqaYHFVVe/7/g9o3mHatXFS+8DYXFRDMUFUf05WO3MTRjEjrF
         8238OTqzO2g5EXYqpdupmWiveGvEpyNeLPrDdNu9w6/5ppXgwScGhpInKVkvPi9E5SZv
         o7ywBfV3FNh7S3Fjs9GDUWxgK/4CI02klwXQbsc7YiXp5suTDvzbksof3oqxpL45GHe0
         zjLccuWhdn9efcWVcIqLTeplFjVKQNbAlLPLr6W9JLUrF1EEWTLhjVe3HqC4oPU9JrI9
         ovF3+LLC3gtkE0jekK63HeK6KPde0Dilclh7f9ksi4Rg8fueeuC7bQ4zHASHAAdEmHBK
         Ajbg==
X-Gm-Message-State: APjAAAXO+UTF78mvdh8I8NT9pXNh1sDbx0NTkiWRdPdWfcra4iTpiBD2
        aYhhgqsfNXpQxa0IXFocb35r3YSGtlTeP0tsKv2MFg==
X-Google-Smtp-Source: APXvYqx2AVq593cMA+4ji4GXv3QAPg+9ct1XuU7Gg2GfBYSTG5+OuzHnoVtVqjmqrRu+pyuUAdg9xFHbBvX7RVKUhaE=
X-Received: by 2002:aca:4fce:: with SMTP id d197mr8992480oib.142.1573836755958;
 Fri, 15 Nov 2019 08:52:35 -0800 (PST)
MIME-Version: 1.0
References: <20191107205334.158354-1-hannes@cmpxchg.org> <20191107205334.158354-3-hannes@cmpxchg.org>
 <CALvZod5y2NPPg=24q33=ktQqwyUsH1gpwHgROe5z_P+tW74SDw@mail.gmail.com> <20191115160722.GA309754@cmpxchg.org>
In-Reply-To: <20191115160722.GA309754@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 15 Nov 2019 08:52:24 -0800
Message-ID: <CALvZod6YVC-dRV9PaGSCzPE_JA8fhUUEkeBnT7j4ZUVFGWiaOw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: vmscan: detect file thrashing at the reclaim root
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Nov 15, 2019 at 8:07 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Thu, Nov 14, 2019 at 03:47:59PM -0800, Shakeel Butt wrote:
> > On Thu, Nov 7, 2019 at 12:53 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > We use refault information to determine whether the cache workingset
> > > is stable or transitioning, and dynamically adjust the inactive:active
> > > file LRU ratio so as to maximize protection from one-off cache during
> > > stable periods, and minimize IO during transitions.
> > >
> > > With cgroups and their nested LRU lists, we currently don't do this
> > > correctly. While recursive cgroup reclaim establishes a relative LRU
> > > order among the pages of all involved cgroups, refaults only affect
> > > the local LRU order in the cgroup in which they are occuring. As a
> > > result, cache transitions can take longer in a cgrouped system as the
> > > active pages of sibling cgroups aren't challenged when they should be.
> > >
> > > [ Right now, this is somewhat theoretical, because the siblings, under
> > >   continued regular reclaim pressure, should eventually run out of
> > >   inactive pages - and since inactive:active *size* balancing is also
> > >   done on a cgroup-local level, we will challenge the active pages
> > >   eventually in most cases. But the next patch will move that relative
> > >   size enforcement to the reclaim root as well, and then this patch
> > >   here will be necessary to propagate refault pressure to siblings. ]
> > >
> > > This patch moves refault detection to the root of reclaim. Instead of
> > > remembering the cgroup owner of an evicted page, remember the cgroup
> > > that caused the reclaim to happen. When refaults later occur, they'll
> > > correctly influence the cross-cgroup LRU order that reclaim follows.
> >
> > Can you please explain how "they'll correctly influence"? I see that
> > if the refaulted page was evicted due to pressure in some ancestor,
> > then that's ancestor's refault distance and active file size will be
> > used to decide to activate the refaulted page but how that is
> > influencing cross-cgroup LRUs?
>
> I take it the next patch answered your question: Activating a page
> inside a cgroup has an effect on how it's reclaimed relative to pages
> in sibling cgroups. So the influence part isn't new with this change -
> it's about recognizing that an activation has an effect on a wider
> scope than just the local cgroup, and considering that scope when
> making the decision whether to activate or not.
>

Thanks for the clarification.

> > > @@ -302,6 +330,17 @@ void workingset_refault(struct page *page, void *shadow)
> > >          */
> > >         refault_distance = (refault - eviction) & EVICTION_MASK;
> > >
> > > +       /*
> > > +        * The activation decision for this page is made at the level
> > > +        * where the eviction occurred, as that is where the LRU order
> > > +        * during page reclaim is being determined.
> > > +        *
> > > +        * However, the cgroup that will own the page is the one that
> > > +        * is actually experiencing the refault event.
> > > +        */
> > > +       memcg = get_mem_cgroup_from_mm(current->mm);
> >
> > Why not page_memcg(page)? page is locked.
>
> Nice catch! Indeed, the page is charged and locked at this point, so
> we don't have to do another lookup and refcounting dance here.
>
> Delta patch:
>
> ---
>
> From 8984f37f3e88b1b39c7d6470b313730093b24474 Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Fri, 15 Nov 2019 09:14:04 -0500
> Subject: [PATCH] mm: vmscan: detect file thrashing at the reclaim root fix
>
> Shakeel points out that the page is locked and already charged by the
> time we call workingset_refault(). Instead of doing another cgroup
> lookup and reference from current->mm we can simply use page_memcg().
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

For the complete patch:

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> ---
>  mm/workingset.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/mm/workingset.c b/mm/workingset.c
> index f0885d9f41cd..474186b76ced 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -338,7 +338,7 @@ void workingset_refault(struct page *page, void *shadow)
>          * However, the cgroup that will own the page is the one that
>          * is actually experiencing the refault event.
>          */
> -       memcg = get_mem_cgroup_from_mm(current->mm);
> +       memcg = page_memcg(page);
>         lruvec = mem_cgroup_lruvec(memcg, pgdat);
>
>         inc_lruvec_state(lruvec, WORKINGSET_REFAULT);
> @@ -349,7 +349,7 @@ void workingset_refault(struct page *page, void *shadow)
>          * the memory was available to the page cache.
>          */
>         if (refault_distance > active_file)
> -               goto out_memcg;
> +               goto out;
>
>         SetPageActive(page);
>         advance_inactive_age(memcg, pgdat);
> @@ -360,9 +360,6 @@ void workingset_refault(struct page *page, void *shadow)
>                 SetPageWorkingset(page);
>                 inc_lruvec_state(lruvec, WORKINGSET_RESTORE);
>         }
> -
> -out_memcg:
> -       mem_cgroup_put(memcg);
>  out:
>         rcu_read_unlock();
>  }
> --
> 2.24.0
>

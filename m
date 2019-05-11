Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6451A5C9
	for <lists+cgroups@lfdr.de>; Sat, 11 May 2019 02:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfEKAc2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 May 2019 20:32:28 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:38822 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbfEKAc2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 May 2019 20:32:28 -0400
Received: by mail-yw1-f67.google.com with SMTP id b74so6122685ywe.5
        for <cgroups@vger.kernel.org>; Fri, 10 May 2019 17:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=41ax0xLOxm/LrOT3A3tZ5B68ILUGPJLp0atAjy77i6o=;
        b=knPK6xaKmMuLYUQlJOQ8p1WN4FUsPoYO9+yBhUOxRA+nPaF4tMaKtzK1UFnZDzAnR1
         /7ZEFdZi1ZbuE9I3FRiEU3+KECOjMfdBjCpQCllIlFGQqV+xwWEUus+IDnH4fcal2oaD
         DjmoJByG6r4hHkO01Y94+VpiK7veWvFZ1aBvLXGc+pnUvWCGXZzrFJ6KExypnFK+7UOm
         OAuK706LwUs9cnAwAIIdcB3l0WPuPMj8SQMz+0QgGkVwud+jjbE72x9QRvwJCH1Zsa/V
         XTxyykrqLQYsS6/QTMG4G37djT9cil0+EoWGLw3H3F7g9ik+dDkMxgQgA7zFEaLWS2Ss
         xGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=41ax0xLOxm/LrOT3A3tZ5B68ILUGPJLp0atAjy77i6o=;
        b=nUQkqjt5iRe1hOndJfhVVxftb5sA8qXCsGg2iEBYU+2tC++VdhWn7jFt7EHyQbxvwS
         WZx0jeMHyQWDdUsRrFkBmthO8/K52ZYhmupHUU8bUQBHas5XJPEP43YrXWkA4JjH3Aj6
         50lIB2/qwe+RSHUy1eIgLRPHNMEkM5G97XYo7jdsUMF/Fo9cw/5e6w6rJhy9NclDwEVe
         dpz6kmyk8cLoOfKzSaEr6PMMHr0IqwfyMnSyfjKBsr98KTMW58laCnHtgVAtXwqTmLfk
         YIIIepzRJS/z2ZBqHWayzVWIcksXEZEck1MQucL3HK8kOXHxDwH2HOhxJ+Y07jbMzon1
         dOdg==
X-Gm-Message-State: APjAAAXrJcFyU7JDrzbSMBCgQM6gK/ur4pUFFXGjkD7fwvg0hUKN/81G
        TK0jpAcSifhzDriWaOtEZkGeqDHC7SegF6v8Cf/CgQ==
X-Google-Smtp-Source: APXvYqwjns9n0oUciPRms5JJERnoBElcCJ1mcZ+OMgwpDHiPtM7z27hQetG1tauEX2cSfVOPTcBEXoIakE6PJoEEXqY=
X-Received: by 2002:a25:f507:: with SMTP id a7mr7198027ybe.164.1557534746760;
 Fri, 10 May 2019 17:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190508202458.550808-1-guro@fb.com>
In-Reply-To: <20190508202458.550808-1-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 10 May 2019 17:32:15 -0700
Message-ID: <CALvZod4WGVVq+UY_TZdKP_PHdifDrkYqPGgKYTeUB6DsxGAdVw@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] mm: reparent slab memory on cgroup removal
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

> # Why do we need this?
>
> We've noticed that the number of dying cgroups is steadily growing on most
> of our hosts in production. The following investigation revealed an issue
> in userspace memory reclaim code [1], accounting of kernel stacks [2],
> and also the mainreason: slab objects.
>
> The underlying problem is quite simple: any page charged
> to a cgroup holds a reference to it, so the cgroup can't be reclaimed unless
> all charged pages are gone. If a slab object is actively used by other cgroups,
> it won't be reclaimed, and will prevent the origin cgroup from being reclaimed.
>
> Slab objects, and first of all vfs cache, is shared between cgroups, which are
> using the same underlying fs, and what's even more important, it's shared
> between multiple generations of the same workload. So if something is running
> periodically every time in a new cgroup (like how systemd works), we do
> accumulate multiple dying cgroups.
>
> Strictly speaking pagecache isn't different here, but there is a key difference:
> we disable protection and apply some extra pressure on LRUs of dying cgroups,

How do you apply extra pressure on dying cgroups? cgroup-v2 does not
have memory.force_empty.


> and these LRUs contain all charged pages.
> My experiments show that with the disabled kernel memory accounting the number
> of dying cgroups stabilizes at a relatively small number (~100, depends on
> memory pressure and cgroup creation rate), and with kernel memory accounting
> it grows pretty steadily up to several thousands.
>
> Memory cgroups are quite complex and big objects (mostly due to percpu stats),
> so it leads to noticeable memory losses. Memory occupied by dying cgroups
> is measured in hundreds of megabytes. I've even seen a host with more than 100Gb
> of memory wasted for dying cgroups. It leads to a degradation of performance
> with the uptime, and generally limits the usage of cgroups.
>
> My previous attempt [3] to fix the problem by applying extra pressure on slab
> shrinker lists caused a regressions with xfs and ext4, and has been reverted [4].
> The following attempts to find the right balance [5, 6] were not successful.
>
> So instead of trying to find a maybe non-existing balance, let's do reparent
> the accounted slabs to the parent cgroup on cgroup removal.
>
>
> # Implementation approach
>
> There is however a significant problem with reparenting of slab memory:
> there is no list of charged pages. Some of them are in shrinker lists,
> but not all. Introducing of a new list is really not an option.
>
> But fortunately there is a way forward: every slab page has a stable pointer
> to the corresponding kmem_cache. So the idea is to reparent kmem_caches
> instead of slab pages.
>
> It's actually simpler and cheaper, but requires some underlying changes:
> 1) Make kmem_caches to hold a single reference to the memory cgroup,
>    instead of a separate reference per every slab page.
> 2) Stop setting page->mem_cgroup pointer for memcg slab pages and use
>    page->kmem_cache->memcg indirection instead. It's used only on
>    slab page release, so it shouldn't be a big issue.
> 3) Introduce a refcounter for non-root slab caches. It's required to
>    be able to destroy kmem_caches when they become empty and release
>    the associated memory cgroup.
>
> There is a bonus: currently we do release empty kmem_caches on cgroup
> removal, however all other are waiting for the releasing of the memory cgroup.
> These refactorings allow kmem_caches to be released as soon as they
> become inactive and free.
>
> Some additional implementation details are provided in corresponding
> commit messages.
>
>
> # Results
>
> Below is the average number of dying cgroups on two groups of our production
> hosts. They do run some sort of web frontend workload, the memory pressure
> is moderate. As we can see, with the kernel memory reparenting the number
> stabilizes in 50s range; however with the original version it grows almost
> linearly and doesn't show any signs of plateauing. The difference in slab
> and percpu usage between patched and unpatched versions also grows linearly.
> In 6 days it reached 200Mb.
>
> day           0    1    2    3    4    5    6
> original     39  338  580  827 1098 1349 1574
> patched      23   44   45   47   50   46   55
> mem diff(Mb) 53   73   99  137  148  182  209
>
>
> # History
>
> v3:
>   1) reworked memcg kmem_cache search on allocation path
>   2) fixed /proc/kpagecgroup interface
>
> v2:
>   1) switched to percpu kmem_cache refcounter
>   2) a reference to kmem_cache is held during the allocation
>   3) slabs stats are fixed for !MEMCG case (and the refactoring
>      is separated into a standalone patch)
>   4) kmem_cache reparenting is performed from deactivatation context
>
> v1:
>   https://lkml.org/lkml/2019/4/17/1095
>
>
> # Links
>
> [1]: commit 68600f623d69 ("mm: don't miss the last page because of
> round-off error")
> [2]: commit 9b6f7e163cd0 ("mm: rework memcg kernel stack accounting")
> [3]: commit 172b06c32b94 ("mm: slowly shrink slabs with a relatively
> small number of objects")
> [4]: commit a9a238e83fbb ("Revert "mm: slowly shrink slabs
> with a relatively small number of objects")
> [5]: https://lkml.org/lkml/2019/1/28/1865
> [6]: https://marc.info/?l=linux-mm&m=155064763626437&w=2
>
>
> Roman Gushchin (7):
>   mm: postpone kmem_cache memcg pointer initialization to
>     memcg_link_cache()
>   mm: generalize postponed non-root kmem_cache deactivation
>   mm: introduce __memcg_kmem_uncharge_memcg()
>   mm: unify SLAB and SLUB page accounting
>   mm: rework non-root kmem_cache lifecycle management
>   mm: reparent slab memory on cgroup removal
>   mm: fix /proc/kpagecgroup interface for slab pages
>
>  include/linux/memcontrol.h |  10 +++
>  include/linux/slab.h       |  13 ++--
>  mm/memcontrol.c            |  97 ++++++++++++++++--------
>  mm/slab.c                  |  25 ++----
>  mm/slab.h                  | 120 +++++++++++++++++++++--------
>  mm/slab_common.c           | 151 ++++++++++++++++++++-----------------
>  mm/slub.c                  |  36 ++-------
>  7 files changed, 267 insertions(+), 185 deletions(-)
>
> --
> 2.20.1
>

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3C0269C0B
	for <lists+cgroups@lfdr.de>; Tue, 15 Sep 2020 04:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgIOCom (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Sep 2020 22:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgIOCok (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Sep 2020 22:44:40 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873DFC06174A
        for <cgroups@vger.kernel.org>; Mon, 14 Sep 2020 19:44:38 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id n14so1078290pff.6
        for <cgroups@vger.kernel.org>; Mon, 14 Sep 2020 19:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yRm2Nxbq6RoVxMTPA/SHMqmJrVHr838yuFX4cqndMt0=;
        b=eFWJJ0TF8vJC4+HhW6AD/lLi2RSYaQDrfjMEP5aBQwKpOBh+N89x6QvOvayKTyfUAv
         J1VijI5i7/xN7kqGEV3O9vOg2jd37zxxSvagDqHHsFxvqOrKSIPgQlRF02NPvFru9249
         6FEZNt14c57Y1HZfaWJ4194FK/cVLCXbSwWHDqmGVVhfG6R+DYJqiI8woGHMfB8UbBI5
         GzM6ol77fu87BqvhuvY4IfjF+RehsqB3RsQcYvZHpKdSYE9672De8rmIQjtoMLebx4bW
         Wm1gNdEATLWCiB3Ebhku7lVbSw/2hVV2QcZwW7pGs3Nl+MSSI6x52vcD8b8QONt025UP
         5I+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yRm2Nxbq6RoVxMTPA/SHMqmJrVHr838yuFX4cqndMt0=;
        b=D80C/+YZyzz+qX6TQ0gSUo8PvC6N3PqmlOyWl8NkA8qJ4y65mHQn0RIkaDqOJOVAR3
         2zU++UOtoA534Yr9AyC7xxJDfxfnsHCj6UAO1YLzggg4Ea25omBlQm/KHWWzK3o8GEwQ
         7sljy/oNL2ocJeiStKC49pFPY4BpUR9HwwFMpY469KCYYlVu16QOLPdhGXCeA2OMQEDZ
         2gIW1dhJNPjq3nPy3FWfa3dQgiQdT5OmH64GiamOUivPEaHZWsyXO81nkk0DuiN3ZKGu
         4i94WyUohh2RaxlNKipFjDmIpWOQrwovP2rx1d0eVNCSqa/PCj8IkhPg9HM7/SZfLvM7
         X3rg==
X-Gm-Message-State: AOAM532AgbvtTSCscod2ouIHFDwBDFRmCqHPOC5uiCo3gCkTgjGsf3xh
        6am+TzQ/R+bh812lREVAYGEpLJIM7XAl6YNeFZDj5w==
X-Google-Smtp-Source: ABdhPJwkRr5960WGYZ2KPNSyBhEd+TxajHMwCIC2l1xYrvNRVAGlp68vEs1nbcICHHkKUR6ds7/lo3QNlZUU9ydGu1s=
X-Received: by 2002:a63:5515:: with SMTP id j21mr12647797pgb.31.1600137877541;
 Mon, 14 Sep 2020 19:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200913070010.44053-1-songmuchun@bytedance.com> <8387344f-0e43-9b6e-068d-b2c45bbda1de@infradead.org>
In-Reply-To: <8387344f-0e43-9b6e-068d-b2c45bbda1de@infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 15 Sep 2020 10:44:01 +0800
Message-ID: <CAMZfGtVvi5uY7iDAfWVVzaAy8YmfM9-UJ60p=aCw59Q=KKS-Vw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3] mm: memcontrol: Add the missing
 numa_stat interface for cgroup v2
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     tj@kernel.org, Zefan Li <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, corbet@lwn.net,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Cgroups <cgroups@vger.kernel.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 15, 2020 at 3:07 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 9/13/20 12:00 AM, Muchun Song wrote:
> > In the cgroup v1, we have a numa_stat interface. This is useful for
> > providing visibility into the numa locality information within an
> > memcg since the pages are allowed to be allocated from any physical
> > node. One of the use cases is evaluating application performance by
> > combining this information with the application's CPU allocation.
> > But the cgroup v2 does not. So this patch adds the missing information.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Suggested-by: Shakeel Butt <shakeelb@google.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > ---
> >  changelog in v3:
> >  1. Fix compiler error on powerpc architecture reported by kernel test robot.
> >  2. Fix a typo from "anno" to "anon".
> >
> >  changelog in v2:
> >  1. Add memory.numa_stat interface in cgroup v2.
> >
> >  Documentation/admin-guide/cgroup-v2.rst |  72 ++++++++++++++++
> >  mm/memcontrol.c                         | 107 ++++++++++++++++++++++++
> >  2 files changed, 179 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > index 6be43781ec7f..92207f0012e4 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -1368,6 +1368,78 @@ PAGE_SIZE multiple when read back.
> >               collapsing an existing range of pages. This counter is not
> >               present when CONFIG_TRANSPARENT_HUGEPAGE is not set.
> >
> > +  memory.numa_stat
> > +     A read-only flat-keyed file which exists on non-root cgroups.
> > +
> > +     This breaks down the cgroup's memory footprint into different
> > +     types of memory, type-specific details, and other information
> > +     per node on the state of the memory management system.
> > +
> > +     This is useful for providing visibility into the numa locality
>
> capitalize acronyms, please:                             NUMA

OK, I will do that. Thanks.

>
>
> > +     information within an memcg since the pages are allowed to be
> > +     allocated from any physical node. One of the use cases is evaluating
> > +     application performance by combining this information with the
> > +     application's CPU allocation.
> > +
> > +     All memory amounts are in bytes.
> > +
> > +     The output format of memory.numa_stat is::
> > +
> > +       type N0=<node 0 pages> N1=<node 1 pages> ...
>
> Now I'm confused.  5 lines above here it says "All memory amounts are in bytes"
> but these appear to be in pages. Which is it?  and what size pages if that matters?

Sorry. It's my mistake. I will fix it.

>
> Is it like this?
>           type N0=<bytes in node 0 pages> N1=<bytes in node 1 pages> ...

Thanks.

>
>
>
> > +     The entries are ordered to be human readable, and new entries
> > +     can show up in the middle. Don't rely on items remaining in a
> > +     fixed position; use the keys to look up specific values!
> > +
> > +       anon
> > +             Amount of memory per node used in anonymous mappings such
> > +             as brk(), sbrk(), and mmap(MAP_ANONYMOUS)
> > +
> > +       file
> > +             Amount of memory per node used to cache filesystem data,
> > +             including tmpfs and shared memory.
> > +
> > +       kernel_stack
> > +             Amount of memory per node allocated to kernel stacks.
> > +
> > +       shmem
> > +             Amount of cached filesystem data per node that is swap-backed,
> > +             such as tmpfs, shm segments, shared anonymous mmap()s
> > +
> > +       file_mapped
> > +             Amount of cached filesystem data per node mapped with mmap()
> > +
> > +       file_dirty
> > +             Amount of cached filesystem data per node that was modified but
> > +             not yet written back to disk
> > +
> > +       file_writeback
> > +             Amount of cached filesystem data per node that was modified and
> > +             is currently being written back to disk
> > +
> > +       anon_thp
> > +             Amount of memory per node used in anonymous mappings backed by
> > +             transparent hugepages
> > +
> > +       inactive_anon, active_anon, inactive_file, active_file, unevictable
> > +             Amount of memory, swap-backed and filesystem-backed,
> > +             per node on the internal memory management lists used
> > +             by the page reclaim algorithm.
> > +
> > +             As these represent internal list state (eg. shmem pages are on anon
>
>                                                          e.g.

Thanks.

>
> > +             memory management lists), inactive_foo + active_foo may not be equal to
> > +             the value for the foo counter, since the foo counter is type-based, not
> > +             list-based.
> > +
> > +       slab_reclaimable
> > +             Amount of memory per node used for storing in-kernel data
> > +             structures which might be reclaimed, such as dentries and
> > +             inodes.
> > +
> > +       slab_unreclaimable
> > +             Amount of memory per node used for storing in-kernel data
> > +             structures which cannot be reclaimed on memory pressure.
>
> Some of the descriptions above end with a '.' and some do not. Please be consistent.

Will do that.

>
> > +
> >    memory.swap.current
> >       A read-only single value file which exists on non-root
> >       cgroups.
>
>
> thanks.
> --
> ~Randy
>


-- 
Yours,
Muchun

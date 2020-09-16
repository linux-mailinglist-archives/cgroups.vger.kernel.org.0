Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0B626BB48
	for <lists+cgroups@lfdr.de>; Wed, 16 Sep 2020 06:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgIPEP1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Sep 2020 00:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgIPEP0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 16 Sep 2020 00:15:26 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40787C06174A
        for <cgroups@vger.kernel.org>; Tue, 15 Sep 2020 21:15:26 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y6so2479302plt.9
        for <cgroups@vger.kernel.org>; Tue, 15 Sep 2020 21:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LCRAOABNyfnd7lzn4QMxDV96zQMAtn58NYDWlvquY3g=;
        b=2G6cIT8yZsbFxrYcihmm01Gj0GSrMKff8Czby6u+EPsC5Y13yzYr4IjiO33Hbh6W/S
         3XcK0ykjiUDsKYjgLk5yq6aEZlY8UOw/EMR+GXEHF5B4qga8TW5wh71rA8wRUI+O1GpF
         JRF8qYyUOP2vwBL0t5/skhaS8XNKzuppA5BzeZPbp+3zARCR1zbOWN7Jt4HgGiOYEoBS
         qyqW/6uNQxmXZke8BhbUXEvptwlrBP5RMTLKs2xagCaon+uPVYO0G1YiJ2lliVZpRdQt
         EoLdWPztPztdRe7hxe6Qy/FfIlXNwnh1ij5YFpXRg9gnDnrr+tYWs2UU4DIu88wynRFK
         qWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LCRAOABNyfnd7lzn4QMxDV96zQMAtn58NYDWlvquY3g=;
        b=BGsaXH7RZJPK1p29dpABMwQGBkHuYp/0JTO+SVrDX6Yi4ijSHhf/kbs/u7obQGVWgc
         DTui1Fyjvxi6I3r1P/2T7xtAWUtM0DN6qxH/i32ja4gKOI3xY6X6XstgpQEi6cqKTbNj
         g/ZazPDqBd/gzmHVDDoBDQwRM796XfyEvjOy2cli3PHW78G1gQShN3Pf1wdV9lRUf/YW
         DpFeKcphAuCc6IOUh5G3A32YN5cW52xet0aBnsxEUI7vZI+PuJTMM4tFdmYUF7b3NKuO
         SMS+1vjEKEaCGyt+kC44UrGgNs5ZYAdyTnL5t7QqRPJZgwMOLDwRJ1NDjP5djEcU2Zte
         a1Cw==
X-Gm-Message-State: AOAM533mZj24VJ+XCTnUdtn0IeBTloe8wefhmuTx7kcOdkFph0ydgaYx
        nQtRESaWqVnqb7Cxfvz1RfTyFQxwIkQ+oRncrr52uQ==
X-Google-Smtp-Source: ABdhPJy2sy8PVXcyCJOvShHPTPgr0MnoBvJ8hNXFb+iNCh2bapM/ywuberhz6eOfN37SIu/IZPymzXp6hkAMbtGvh/Q=
X-Received: by 2002:a17:90a:b78b:: with SMTP id m11mr2289570pjr.13.1600229725682;
 Tue, 15 Sep 2020 21:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200915171801.39761-1-songmuchun@bytedance.com> <20200915214845.GB189808@cmpxchg.org>
In-Reply-To: <20200915214845.GB189808@cmpxchg.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 16 Sep 2020 12:14:49 +0800
Message-ID: <CAMZfGtXOR1Ed2PyB4TB5mq=1mh7p7La-4BsoZ8oYhtgc8ZcqLQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5] mm: memcontrol: Add the missing
 numa_stat interface for cgroup v2
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Cgroups <cgroups@vger.kernel.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 16, 2020 at 5:50 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Sep 16, 2020 at 01:18:01AM +0800, Muchun Song wrote:
> > In the cgroup v1, we have a numa_stat interface. This is useful for
> > providing visibility into the numa locality information within an
> > memcg since the pages are allowed to be allocated from any physical
> > node. One of the use cases is evaluating application performance by
> > combining this information with the application's CPU allocation.
> > But the cgroup v2 does not. So this patch adds the missing information.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Suggested-by: Shakeel Butt <shakeelb@google.com>
> > Reviewed-by: Shakeel Butt <shakeelb@google.com>
>
> Yup, that would be useful information to have. Just a few comments on
> the patch below:
>
> > @@ -1368,6 +1368,78 @@ PAGE_SIZE multiple when read back.
> >               collapsing an existing range of pages. This counter is not
> >               present when CONFIG_TRANSPARENT_HUGEPAGE is not set.
> >
> > +  memory.numa_stat
> > +     A read-only flat-keyed file which exists on non-root cgroups.
>
> It's a nested key file, not flat.

This is just copied from memory.stat documentation.Is the memory.stat
also a nested key file?

>
> > +     This breaks down the cgroup's memory footprint into different
> > +     types of memory, type-specific details, and other information
> > +     per node on the state of the memory management system.
> > +
> > +     This is useful for providing visibility into the NUMA locality
> > +     information within an memcg since the pages are allowed to be
> > +     allocated from any physical node. One of the use case is evaluating
> > +     application performance by combining this information with the
> > +     application's CPU allocation.
> > +
> > +     All memory amounts are in bytes.
> > +
> > +     The output format of memory.numa_stat is::
> > +
> > +       type N0=<bytes in node 0> N1=<bytes in node 1> ...
> > +
> > +     The entries are ordered to be human readable, and new entries
> > +     can show up in the middle. Don't rely on items remaining in a
> > +     fixed position; use the keys to look up specific values!
> > +
> > +       anon
> > +             Amount of memory per node used in anonymous mappings such
> > +             as brk(), sbrk(), and mmap(MAP_ANONYMOUS).
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
> > +             such as tmpfs, shm segments, shared anonymous mmap()s.
> > +
> > +       file_mapped
> > +             Amount of cached filesystem data per node mapped with mmap().
> > +
> > +       file_dirty
> > +             Amount of cached filesystem data per node that was modified but
> > +             not yet written back to disk.
> > +
> > +       file_writeback
> > +             Amount of cached filesystem data per node that was modified and
> > +             is currently being written back to disk.
> > +
> > +       anon_thp
> > +             Amount of memory per node used in anonymous mappings backed by
> > +             transparent hugepages.
> > +
> > +       inactive_anon, active_anon, inactive_file, active_file, unevictable
> > +             Amount of memory, swap-backed and filesystem-backed,
> > +             per node on the internal memory management lists used
> > +             by the page reclaim algorithm.
> > +
> > +             As these represent internal list state (e.g. shmem pages are on
> > +             anon memory management lists), inactive_foo + active_foo may not
> > +             be equal to the value for the foo counter, since the foo counter
> > +             is type-based, not list-based.
> > +
> > +       slab_reclaimable
> > +             Amount of memory per node used for storing in-kernel data
> > +             structures which might be reclaimed, such as dentries and
> > +             inodes.
> > +
> > +       slab_unreclaimable
> > +             Amount of memory per node used for storing in-kernel data
> > +             structures which cannot be reclaimed on memory pressure.
> > +
> >    memory.swap.current
> >       A read-only single value file which exists on non-root
> >       cgroups.
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 75cd1a1e66c8..ff919ef3b57b 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -6425,6 +6425,86 @@ static int memory_stat_show(struct seq_file *m, void *v)
> >       return 0;
> >  }
> >
> > +#ifdef CONFIG_NUMA
> > +struct numa_stat {
> > +     const char *name;
> > +     unsigned int ratio;
> > +     enum node_stat_item idx;
> > +};
> > +
> > +static struct numa_stat numa_stats[] = {
> > +     { "anon", PAGE_SIZE, NR_ANON_MAPPED },
> > +     { "file", PAGE_SIZE, NR_FILE_PAGES },
> > +     { "kernel_stack", 1024, NR_KERNEL_STACK_KB },
> > +     { "shmem", PAGE_SIZE, NR_SHMEM },
> > +     { "file_mapped", PAGE_SIZE, NR_FILE_MAPPED },
> > +     { "file_dirty", PAGE_SIZE, NR_FILE_DIRTY },
> > +     { "file_writeback", PAGE_SIZE, NR_WRITEBACK },
> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > +     /*
> > +      * The ratio will be initialized in numa_stats_init(). Because
> > +      * on some architectures, the macro of HPAGE_PMD_SIZE is not
> > +      * constant(e.g. powerpc).
> > +      */
> > +     { "anon_thp", 0, NR_ANON_THPS },
> > +#endif
> > +     { "inactive_anon", PAGE_SIZE, NR_INACTIVE_ANON },
> > +     { "active_anon", PAGE_SIZE, NR_ACTIVE_ANON },
> > +     { "inactive_file", PAGE_SIZE, NR_INACTIVE_FILE },
> > +     { "active_file", PAGE_SIZE, NR_ACTIVE_FILE },
> > +     { "unevictable", PAGE_SIZE, NR_UNEVICTABLE },
> > +     { "slab_reclaimable", 1, NR_SLAB_RECLAIMABLE_B },
> > +     { "slab_unreclaimable", 1, NR_SLAB_UNRECLAIMABLE_B },
> > +};
>
> This is a bit duplicative with memory_stat_format(), and the
> collections will easily go out of sync as we add/change stat items.
>
> Can you please convert memory_stat_format() to use the same shared table?
>
> You may have to add another flag for the MEMCG_* items for which we
> don't have per-node counters.
>
> The same applies to the documentation. Please don't duplicate the list
> of items, but have memory.numa_stat refer to the list for memory.stat.
> You can add (not in memory.numa_stat) or something to percpu and sock.

Thanks for your suggestions.

>
> > +static unsigned long memcg_node_page_state(struct mem_cgroup *memcg,
> > +                                        unsigned int nid,
> > +                                        enum node_stat_item idx)
> > +{
> > +     VM_BUG_ON(nid >= nr_node_ids);
> > +     return lruvec_page_state(mem_cgroup_lruvec(memcg, NODE_DATA(nid)), idx);
> > +}
>
> Please drop this wrapper and use lruvec_page_state directly below.
>
> Otherwise, this looks reasonable to me.

OK. Will do that.



-- 
Yours,
Muchun

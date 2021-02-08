Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15AFF3140BA
	for <lists+cgroups@lfdr.de>; Mon,  8 Feb 2021 21:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbhBHUns (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 8 Feb 2021 15:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbhBHUl1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 8 Feb 2021 15:41:27 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C962C06178B
        for <cgroups@vger.kernel.org>; Mon,  8 Feb 2021 12:40:47 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id a1so7596265qvd.13
        for <cgroups@vger.kernel.org>; Mon, 08 Feb 2021 12:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=trurRt8gUU2aadbEi0vZGrvIaapkw6K9paKqRwTKcaY=;
        b=IL858Nl22Xe2hZD/k7dFdDA3y+XeQMUvCmXDBjIFTXBken1a9/tGC8cuqXn/3roGxK
         7jtigYEaOOLoafpuKYhSmZEhQvp5Ocgsr1V7H+sKcbBBM3kyznclWFpSeqQ9iRaa8RK2
         valQydK60iZosDHNE6P+Gh8p0hvoJgaeznnlGjsKJ7ViMr3IIrDDQMozxhaG736LO4DV
         e0/hPjQZqz6YtgVg/HjadSA3vP6U+nx/XGm7VrQJwvqyTA4j6j2M/17ReimA5yhY3F7u
         lRNLTmFdnGave+CFQ3023/gG5YM7ARcRFQQkgsMbpJ5JcFIA8xm5HVIvIP7j6TblfL36
         kJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=trurRt8gUU2aadbEi0vZGrvIaapkw6K9paKqRwTKcaY=;
        b=PVaqO0dwW6uSZNYHRLEqLCW6L6omlqpsbvVFC4ObC4qKKFFOL9g5soQOsH20HVzYgB
         w9VRF1ne2mc8jlhkyYcul9s2w/5CYJu1w/3IlOa37qGBF6nb+dB/BFNNzYySxHdczckY
         1XMlpTbKbtREUOuGWDdKDedcgzrvB2JgulpPB6wskWcI+vgaBIpJDM8jXuDJRs8SIZ8G
         K5HqRXouvEguwdH9K/yNLXj7+cOC59dW9X2muDECghKQ5A7H0W8aidu1HLG9O4PpgM+D
         LmFPU4QJFwzc65COE4yeW8kKF/6JKrTmBA0gjDKxflQpLYjwzpybKIdc0FrWvBKyBPbN
         FPow==
X-Gm-Message-State: AOAM530ilhahhdQY0Gcozvdr0+NqTZok8+DleNkElSkAJLnG18hAWTJ5
        Bg4iispjG73Atws+/OE6p8g+FQ==
X-Google-Smtp-Source: ABdhPJwQyYGfIra8FZyNeaFtDsJvs7t0G5hWhE50xoYQf0FKtdiPESvQ624JJeOejSIA8QCtlXcLxA==
X-Received: by 2002:ad4:54a7:: with SMTP id r7mr18166203qvy.47.1612816846042;
        Mon, 08 Feb 2021 12:40:46 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id r10sm3584020qtn.21.2021.02.08.12.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 12:40:44 -0800 (PST)
Date:   Mon, 8 Feb 2021 15:40:44 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH 6/8] mm: memcontrol: switch to rstat
Message-ID: <YCGhzBiI/vaRFmOM@cmpxchg.org>
References: <20210205182806.17220-1-hannes@cmpxchg.org>
 <20210205182806.17220-7-hannes@cmpxchg.org>
 <CALvZod4LUfbgmTuHg_YOhp9n43QJsOdKD8F9-qnYBZ22svb8OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod4LUfbgmTuHg_YOhp9n43QJsOdKD8F9-qnYBZ22svb8OQ@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Feb 07, 2021 at 06:19:04PM -0800, Shakeel Butt wrote:
> On Fri, Feb 5, 2021 at 10:28 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > Replace the memory controller's custom hierarchical stats code with
> > the generic rstat infrastructure provided by the cgroup core.
> >
> > The current implementation does batched upward propagation from the
> > write side (i.e. as stats change). The per-cpu batches introduce an
> > error, which is multiplied by the number of subgroups in a tree. In
> > systems with many CPUs and sizable cgroup trees, the error can be
> > large enough to confuse users (e.g. 32 batch pages * 32 CPUs * 32
> > subgroups results in an error of up to 128M per stat item). This can
> > entirely swallow allocation bursts inside a workload that the user is
> > expecting to see reflected in the statistics.
> >
> > In the past, we've done read-side aggregation, where a memory.stat
> > read would have to walk the entire subtree and add up per-cpu
> > counts. This became problematic with lazily-freed cgroups: we could
> > have large subtrees where most cgroups were entirely idle. Hence the
> > switch to change-driven upward propagation. Unfortunately, it needed
> > to trade accuracy for speed due to the write side being so hot.
> >
> > Rstat combines the best of both worlds: from the write side, it
> > cheaply maintains a queue of cgroups that have pending changes, so
> > that the read side can do selective tree aggregation. This way the
> > reported stats will always be precise and recent as can be, while the
> > aggregation can skip over potentially large numbers of idle cgroups.
> >
> > The way rstat works is that it implements a tree for tracking cgroups
> > with pending local changes, as well as a flush function that walks the
> > tree upwards. The controller then drives this by 1) telling rstat when
> > a local cgroup stat changes (e.g. mod_memcg_state) and 2) when a flush
> > is required to get uptodate hierarchy stats for a given subtree
> > (e.g. when memory.stat is read). The controller also provides a flush
> > callback that is called during the rstat flush walk for each cgroup
> > and aggregates its local per-cpu counters and propagates them upwards.
> >
> > This adds a second vmstats to struct mem_cgroup (MEMCG_NR_STAT +
> > NR_VM_EVENT_ITEMS) to track pending subtree deltas during upward
> > aggregation. It removes 3 words from the per-cpu data. It eliminates
> > memcg_exact_page_state(), since memcg_page_state() is now exact.
> 
> Only if cgroup_rstat_flush() has been called before memcg_page_state(), right?

Yes, correct.

> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > Reviewed-by: Roman Gushchin <guro@fb.com>
> > Acked-by: Michal Hocko <mhocko@suse.com>
> 
> Overall the patch looks good to me with a couple of nits/queries below.
> 
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Thanks!

> > @@ -1383,8 +1388,16 @@ void count_memcg_event_mm(struct mm_struct *mm, enum vm_event_item idx)
> >  {
> >  }
> >
> > -static inline void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
> > +static inline void mem_cgroup_split_huge_fixup(struct page *head)
> > +{
> > +}
> > +
> > +static inline
> > +unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
> > +                                           gfp_t gfp_mask,
> > +                                           unsigned long *total_scanned)
> >  {
> > +       return 0;
> 
> Any technical reason to move around mem_cgroup_soft_limit_reclaim(),
> mem_cgroup_split_huge_fixup() and lruvec_memcg_debug() or just
> aesthetics?

Yeah, just a while-at-it cleanup. It seemed too minor to justify a
separate patch.

> >  #endif /* CONFIG_MEMCG */
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 2f97cb4cef6d..5dc0bd53b64a 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -757,6 +757,11 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
> >         return mz;
> >  }
> >
> > +static void memcg_flush_vmstats(struct mem_cgroup *memcg)
> > +{
> > +       cgroup_rstat_flush(memcg->css.cgroup);
> > +}
> 
> cgroup_rstat_flush() has one line wrapper but cgroup_rstat_updated()
> does not, any reason?

cgroup_rstat_flush() seemed a bit low-level to sprinkle around the
code base. Especially with cgroup_rstat_updated() encapsulated by the
mod_memcg_state() layer, a reader of such a callsite might not easily
understand what rstat even is and when and why it needs to be called.

> > @@ -3618,6 +3569,8 @@ static unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
> >  {
> >         unsigned long val;
> >
> > +       memcg_flush_vmstats(memcg);
> > +
> >         if (mem_cgroup_is_root(memcg)) {
> 
> I think memcg_flush_vmstats(memcg) should be here.

Good catch! I'll fix that in the next revision.

Thanks Shakeel

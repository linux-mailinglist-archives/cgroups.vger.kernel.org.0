Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB1C31349F
	for <lists+cgroups@lfdr.de>; Mon,  8 Feb 2021 15:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbhBHOLN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 8 Feb 2021 09:11:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:37952 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232621AbhBHOIp (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 8 Feb 2021 09:08:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612793278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LlDXTJ/+mUzV15EyOoun48VJUY2PxbKWWacbxPZk+kk=;
        b=ufzKIl8h3HFDVCQcbg92ITMMGlMo4V+/JlIbESARAXamNpTMAURcSRq7+6I6oKCtmuUYOE
        DvWNXZ4ujS87qHmOiFAn6p756AsonkA7P/U3SkBZ6oVBW8J5Aqr3a2vkAPVKzuj1pzQRkA
        o0M23XdroyHRCo135qOUslueTPmONc0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EAA22AE3C;
        Mon,  8 Feb 2021 14:07:57 +0000 (UTC)
Date:   Mon, 8 Feb 2021 15:07:57 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 6/7] mm: memcontrol: switch to rstat
Message-ID: <YCFFvdd7CgE+GWEQ@dhcp22.suse.cz>
References: <20210202184746.119084-1-hannes@cmpxchg.org>
 <20210202184746.119084-7-hannes@cmpxchg.org>
 <YB1esMKg3QhBDFG2@dhcp22.suse.cz>
 <YB1zi/bZdeL2j59I@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YB1zi/bZdeL2j59I@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 05-02-21 11:34:19, Johannes Weiner wrote:
> On Fri, Feb 05, 2021 at 04:05:20PM +0100, Michal Hocko wrote:
> > On Tue 02-02-21 13:47:45, Johannes Weiner wrote:
> > > Replace the memory controller's custom hierarchical stats code with
> > > the generic rstat infrastructure provided by the cgroup core.
> > > 
> > > The current implementation does batched upward propagation from the
> > > write side (i.e. as stats change). The per-cpu batches introduce an
> > > error, which is multiplied by the number of subgroups in a tree. In
> > > systems with many CPUs and sizable cgroup trees, the error can be
> > > large enough to confuse users (e.g. 32 batch pages * 32 CPUs * 32
> > > subgroups results in an error of up to 128M per stat item). This can
> > > entirely swallow allocation bursts inside a workload that the user is
> > > expecting to see reflected in the statistics.
> > > 
> > > In the past, we've done read-side aggregation, where a memory.stat
> > > read would have to walk the entire subtree and add up per-cpu
> > > counts. This became problematic with lazily-freed cgroups: we could
> > > have large subtrees where most cgroups were entirely idle. Hence the
> > > switch to change-driven upward propagation. Unfortunately, it needed
> > > to trade accuracy for speed due to the write side being so hot.
> > > 
> > > Rstat combines the best of both worlds: from the write side, it
> > > cheaply maintains a queue of cgroups that have pending changes, so
> > > that the read side can do selective tree aggregation. This way the
> > > reported stats will always be precise and recent as can be, while the
> > > aggregation can skip over potentially large numbers of idle cgroups.
> > > 
> > > This adds a second vmstats to struct mem_cgroup (MEMCG_NR_STAT +
> > > NR_VM_EVENT_ITEMS) to track pending subtree deltas during upward
> > > aggregation. It removes 3 words from the per-cpu data. It eliminates
> > > memcg_exact_page_state(), since memcg_page_state() is now exact.
> > 
> > The above confused me a bit. I can see the pcp data size increased by
> > adding _prev.  The resulting memory footprint should be increased by
> > sizeof(long) * (MEMCG_NR_STAT + NR_VM_EVENT_ITEMS) * (CPUS + 1)
> > which is roughly 1kB per CPU per memcg unless I have made any
> > mistake. This is a quite a lot and it should be mentioned in the
> > changelog.
> 
> Not quite, you missed a hunk further below in the patch.

You are right.

> Yes, the _prev arrays are added to the percpu struct. HOWEVER, we used
> to have TWO percpu structs in a memcg: one for local data, one for
> hierarchical data. In the rstat format, one is enough to capture both:
> 
> -       /* Legacy local VM stats and events */
> -       struct memcg_vmstats_percpu __percpu *vmstats_local;
> -
> -       /* Subtree VM stats and events (batched updates) */
>         struct memcg_vmstats_percpu __percpu *vmstats_percpu;
> 
> This eliminates dead duplicates of the nr_page_events and
> targets[MEM_CGROUP_NTARGETS(2)] we used to carry, which means we have
> a net reduction of 3 longs in the percpu data with this series.

In the old code we used to have
2*(MEMCG_NR_STAT + NR_VM_EVENT_ITEMS + MEM_CGROUP_NTARGETS) (2 struct
memcg_vmstats_percpu) pcp data plus MEMCG_NR_STAT + NR_VM_EVENT_ITEMS
atomics.

New code has 2*MEMCG_NR_STAT + 2*NR_VM_EVENT_ITEMS + MEM_CGROUP_NTARGETS
in pcp plus 2*MEMCG_NR_STAT + 2*NR_VM_EVENT_ITEMS aggregated
counters.

So the resulting diff is MEMCG_NR_STAT + NR_VM_EVENT_ITEMS - MEM_CGROUP_NTARGETS * nr_cpus

which would be 1024 - 2 * nr_cpus. Which looks better.

Thanks and sorry for misreading the patch.
-- 
Michal Hocko
SUSE Labs

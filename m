Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D6930F85D
	for <lists+cgroups@lfdr.de>; Thu,  4 Feb 2021 17:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237386AbhBDQpm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 Feb 2021 11:45:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:42542 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236971AbhBDQoz (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 4 Feb 2021 11:44:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612457047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uPMfnHJez5C0MYU9Bi3DY+Zzs1npEebnPNg9a6l1V9g=;
        b=OyUf2t2CyZUBOw3fyaefDcbgpMBcVsea+tJUuphQlBvBy9pQkyrcEsJBBG4GEajmW7vM6g
        H949fzmNE/GPXVwllufcLuwPy+hWIU2G05xDp8Yxm0U1lJsyNeCmeqSFogw1mxxO0JB1jW
        4YsoerN08FU9CzXsrURvSYD6tYTNAaM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A54D5AD19;
        Thu,  4 Feb 2021 16:44:07 +0000 (UTC)
Date:   Thu, 4 Feb 2021 17:44:06 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 6/7] mm: memcontrol: switch to rstat
Message-ID: <YBwkVoNa77Nn5TE9@dhcp22.suse.cz>
References: <20210202184746.119084-1-hannes@cmpxchg.org>
 <20210202184746.119084-7-hannes@cmpxchg.org>
 <YBwCZYWsQOFAGUar@dhcp22.suse.cz>
 <YBwdiu2Fj4JHgqhQ@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBwdiu2Fj4JHgqhQ@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 04-02-21 11:15:06, Johannes Weiner wrote:
> Hello Michal,
> 
> On Thu, Feb 04, 2021 at 03:19:17PM +0100, Michal Hocko wrote:
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
> > I am still digesting details and need to look deeper into how rstat
> > works but removing our own stats is definitely a good plan. Especially
> > when there are existing limitations and problems that would need fixing.
> > 
> > Just to check that my high level understanding is correct. The
> > transition is effectivelly removing a need to manually sync counters up
> > the hierarchy and partially outsources that decision to rstat core. The
> > controller is responsible just to tell the core how that syncing is done
> > (e.g. which specific counters etc).
> 
> Yes, exactly.
> 
> rstat implements a tree of cgroups that have local changes pending,
> and a flush walk on that tree. But it's all driven by the controller.
> 
> memcg needs to tell rstat 1) when stats in a local cgroup change
> e.g. when we do mod_memcg_state() (cgroup_rstat_updated), 2) when to
> flush, e.g. before a memory.stat read (cgroup_rstat_flush), and 3) how
> to flush one cgroup's per-cpu state and propagate it upward to the
> parent during rstat's flush walk (.css_rstat_flush).

Can we have this short summary in a changelog please?

> > Excplicit flushes are needed when you want an exact value (e.g. when
> > values are presented to the userspace). I do not see any flushes to
> > be done by the core pro-actively except for clean up on a release.
> > 
> > Is the above correct understanding?
> 
> Yes, that's correct.

OK, thanks for the confirmation. I will have a closer look tomorrow but
I do not see any problems now.

-- 
Michal Hocko
SUSE Labs

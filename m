Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677FD366E36
	for <lists+cgroups@lfdr.de>; Wed, 21 Apr 2021 16:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243167AbhDUO3g (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Apr 2021 10:29:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:39110 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238173AbhDUO3f (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 21 Apr 2021 10:29:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619015341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vb4w4rQjHd7BOri6tnIw9XpvN8SwPbJF3toyQYgzGRg=;
        b=qYNAOXNH2YsGh7mAvqkzXGBRCliQc8swtDatbLoWNIYm4Q4oFYaMdsxs2xgIFTxRiGYjzy
        e+teDibROzLugbdHxvDdxHVKbGaJEQ6PDxt85RVPy2LqF/PlbQe6QsddxC6D1vCcBoxuds
        iBtliyQaR6FGnV5opOHT+yreCfUKFG8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3900EAF65;
        Wed, 21 Apr 2021 14:29:01 +0000 (UTC)
Date:   Wed, 21 Apr 2021 16:29:00 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Dragos Sbirlea <dragoss@google.com>,
        Priya Duraisamy <padmapriyad@google.com>
Subject: Re: [RFC] memory reserve for userspace oom-killer
Message-ID: <YIA2rB0wgqKzfUfi@dhcp22.suse.cz>
References: <CALvZod7vtDxJZtNhn81V=oE-EPOf=4KZB2Bv6Giz+u3bFFyOLg@mail.gmail.com>
 <YH54pyRWSi1zLMw4@dhcp22.suse.cz>
 <CALvZod4kjdgMU=8T_bx6zFufA1cGtt2p1Jg8jOgi=+g=bs-Evw@mail.gmail.com>
 <YH/RPydqhwXdyG80@dhcp22.suse.cz>
 <CALvZod4kRWDQuZZQ5F+z6WMcUWLwgYd-Kb0mY8UAEK4MbSOZaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod4kRWDQuZZQ5F+z6WMcUWLwgYd-Kb0mY8UAEK4MbSOZaA@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 21-04-21 06:57:43, Shakeel Butt wrote:
> On Wed, Apr 21, 2021 at 12:16 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> [...]
> > > To decide when to kill, the oom-killer has to read a lot of metrics.
> > > It has to open a lot of files to read them and there will definitely
> > > be new allocations involved in those operations. For example reading
> > > memory.stat does a page size allocation. Similarly, to perform action
> > > the oom-killer may have to read cgroup.procs file which again has
> > > allocation inside it.
> >
> > True but many of those can be avoided by opening the file early. At
> > least seq_file based ones will not allocate later if the output size
> > doesn't increase. Which should be the case for many. I think it is a
> > general improvement to push those who allocate during read to an open
> > time allocation.
> >
> 
> I agree that this would be a general improvement but it is not always
> possible (see below).

It would be still great to invest into those improvements. And I would
be really grateful to learn about bottlenecks from the existing kernel
interfaces you have found on the way.

> > > Regarding sophisticated oom policy, I can give one example of our
> > > cluster level policy. For robustness, many user facing jobs run a lot
> > > of instances in a cluster to handle failures. Such jobs are tolerant
> > > to some amount of failures but they still have requirements to not let
> > > the number of running instances below some threshold. Normally killing
> > > such jobs is fine but we do want to make sure that we do not violate
> > > their cluster level agreement. So, the userspace oom-killer may
> > > dynamically need to confirm if such a job can be killed.
> >
> > What kind of data do you need to examine to make those decisions?
> >
> 
> Most of the time the cluster level scheduler pushes the information to
> the node controller which transfers that information to the
> oom-killer. However based on the freshness of the information the
> oom-killer might request to pull the latest information (IPC and RPC).

I cannot imagine any OOM handler to be reliable if it has to depend on
other userspace component with a lower resource priority. OOM handlers
are fundamentally complex components which has to reduce their
dependencies to the bare minimum.
 
> [...]
> > >
> > > I was thinking of simply prctl(SET_MEMPOOL, bytes) to assign mempool
> > > to a thread (not shared between threads) and prctl(RESET_MEMPOOL) to
> > > free the mempool.
> >
> > I am not a great fan of prctl. It has become a dumping ground for all
> > mix of unrelated functionality. But let's say this is a minor detail at
> > this stage.
> 
> I agree this does not have to be prctl().
> 
> > So you are proposing to have a per mm mem pool that would be
> 
> I was thinking of per-task_struct instead of per-mm_struct just for simplicity.
> 
> > used as a fallback for an allocation which cannot make a forward
> > progress, right?
> 
> Correct
> 
> > Would that pool be preallocated and sitting idle?
> 
> Correct
> 
> > What kind of allocations would be allowed to use the pool?
> 
> I was thinking of any type of allocation from the oom-killer (or
> specific threads). Please note that the mempool is the backup and only
> used in the slowpath.
> 
> > What if the pool is depleted?
> 
> This would mean that either the estimate of mempool size is bad or
> oom-killer is buggy and leaking memory.
> 
> I am open to any design directions for mempool or some other way where
> we can provide a notion of memory guarantee to oom-killer.

OK, thanks for clarification. There will certainly be hard problems to
sort out[1] but the overall idea makes sense to me and it sounds like a
much better approach than a OOM specific solution.


[1] - how the pool is going to be replenished without hitting all
potential reclaim problems (thus dependencies on other all tasks
directly/indirectly) yet to not rely on any background workers to do
that on the task behalf without a proper accounting etc...
-- 
Michal Hocko
SUSE Labs

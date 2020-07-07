Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7683A21786F
	for <lists+cgroups@lfdr.de>; Tue,  7 Jul 2020 21:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbgGGT6Q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 Jul 2020 15:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbgGGT6P (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 7 Jul 2020 15:58:15 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C020C061755
        for <cgroups@vger.kernel.org>; Tue,  7 Jul 2020 12:58:15 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id k4so3002483pld.12
        for <cgroups@vger.kernel.org>; Tue, 07 Jul 2020 12:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=k3L7y+uSvCu/I/UnzzytFeP318tzXpSpWitShBbWr1g=;
        b=bffwDZT/KMJH0fvnTo1oOrVFA0kd3hzqPazn5suuUTryy2Fr0TR53OXVKwgM8nMPna
         2XCfVgChDdYFcf6PF+LJU0NiyVjKzUqMjaEBLpNVjf4lXenXJMlOaD4KEccSg8YVFHSw
         Z4/PDKE6LA0K7tJpiwH8+IC0SYE1OZDm+SwIbFdcqz1NzlBKTFQw1L8kEfFqPH/l5iYO
         8VvwhIRQmhZu5N9ByJuc5l1gZ3gSSHIyb8a7IV/7DakktWynHs0Wn37HAGeTRV1WyxnX
         QA0zOtfhYUh9MRHypxRstHGWB0fz2xHXLJemoSzm+z08bsBJYYil1j13l0FOb67phGEk
         9B1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=k3L7y+uSvCu/I/UnzzytFeP318tzXpSpWitShBbWr1g=;
        b=tQhXzhqNs+pSTfyokGaZ0Si2CaIh/0nELItljIG+/ROaj0lSma7BqaaI9TVCUzCsTz
         KUv2ie2J2a0wGBrqvIAFxCforvdzFLJ2aeiVQAdFlFjVodWMhvCgKGPPDnjR88bNHXhP
         NiVITdm/0K/cdILlmhBZkq+Vapp+ctAtiofeNIW1jD3jI1X102IIxZHR7dZb1QrO+7uZ
         MdkrFMbOXdGj8LLTRr4vb5Dkbb/nRTwIZyrXMrGHcinoN7YJIcH2ULmUfCbtJR/bBgeB
         4nqTXZB2ms2xOQzKoacuaHMEXXume5QEg2CtiZGjyLb1B1Yoy2BSWv4kAbcIWZdX5SsL
         JUqA==
X-Gm-Message-State: AOAM532Ey2sEjuKOLjuMkPSXVet6syLGjS7QY5zbm9+3+kzE1UTDEGut
        fXGZb29LRt7vxVj3rkj2IKFH+gQbH3I=
X-Google-Smtp-Source: ABdhPJzelK0htGu5XecwxGi0uEzY5/kUFEdRvB3mPEIdDrZEySpTt/fKUHZCvXxJG3C3ofG7lwbVvA==
X-Received: by 2002:a17:902:c402:: with SMTP id k2mr46853681plk.89.1594151894115;
        Tue, 07 Jul 2020 12:58:14 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id j10sm1660164pgh.28.2020.07.07.12.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 12:58:13 -0700 (PDT)
Date:   Tue, 7 Jul 2020 12:58:12 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>, Greg Thelen <gthelen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Subject: Re: Memcg stat for available memory
In-Reply-To: <20200703081538.GO18446@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.23.453.2007071210410.396729@chino.kir.corp.google.com>
References: <alpine.DEB.2.22.394.2006281445210.855265@chino.kir.corp.google.com> <CALvZod5Zv33oNLxS_8TyGV_QT4CsBjiEuocxpt2+U-XDMaFDPw@mail.gmail.com> <20200703081538.GO18446@dhcp22.suse.cz>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 3 Jul 2020, Michal Hocko wrote:

> > > I'd like to discuss the feasibility of a stat similar to
> > > si_mem_available() but at memcg scope which would specify how much memory
> > > can be charged without I/O.
> > >
> > > The si_mem_available() stat is based on heuristics so this does not
> > > provide an exact quantity that is actually available at any given time,
> > > but can otherwise provide userspace with some guidance on the amount of
> > > reclaimable memory.  See the description in
> > > Documentation/filesystems/proc.rst and its implementation.
> 
> I have to say I was a fan of this metric when it was introduced mostly
> because it has removed that nasty subtle detail that Cached value
> includes the swap backed memory (e.g. shmem) and that has caused a lot
> of confusion. But I became very skeptical over time because it is really
> hard to set expectations right when relying on the value for two main
> reasons
> 	- it is a global snapshot value and as such it becomes largely
> 	  unusable for any decisions which are not implemented right
> 	  away or if there are multiple uncoordinated consumers.
> 	- it is not really hard to trigger "corner" cases where a careful
> 	  use of MemAvailable still leads to a lot of memory reclaim
> 	  even for single large consumer. What we consider reclaimable
> 	  might be pinned for different reasons or situation simply
> 	  changes. Our documentation claims that following this guidance
> 	  will help prevent from swapping/reclaim yet this is not true
> 	  and I have seen bug reports in the past.
> 

Hi everybody,

I agree that mileage may vary with MemAvailable and that it is only 
representative of the current state of memory at the time it is grabbed 
(although with a memcg equivalent we could have more of a guarantee here 
on a system that is not overcommitted).  I think it's best viewed as our 
best guess of the current amount of free + inexpensively reclaimable 
memory exists at any point in time.

An alternative would be to describe simply the amount of memory that we 
anticipate is reclaimable.  This doesn't get around the pinning issue but 
does provide, like MemAvailable, a field that can be queried that will be 
stable over kernel versions for what the kernel perceives as reclaimable 
and, importantly, makes its reclaim decisions based on.

> > >  [ Naturally, userspace would need to understand both the amount of memory
> > >    that is available for allocation and for charging, separately, on an
> > >    overcommitted system.  I assume this is trivial.  (Why don't we provide
> > >    MemAvailable in per-node meminfo?) ]
> 
> I presume you min the consumer would simply do min(global, memcg) right?
> Well a proper implementation of the value would have to be hierarchical
> so it would be minimum over the whole memcg tree up to the root. We
> cannot expect userspace do do that.
> 
> While technically possible and not that hard to express I am worried
> existing problems with the value would be just amplified because there
> is even more volatility here. Global value mostly depends on consumers,
> now you have a second source of volatility and that is the memcg limit
> (hard or high) that can be changed quite dynamically. Sure the global
> case can have a similar with memory hotplug but realistically this is
> not by far common. Another complication is that the amount of reclaim
> for each memcg depends on reclaimability of other reclaim under the
> global memory pressure (just consider low/min protection as the simplest
> example). So I expect imprecision will be even harder to predict for
> per-memcg value.
> 

Yeah, I think it's best approached by considering the global MemAvailable 
separately from any per-memcg metric and they have different scope 
depending on whether you're the application manager or whether you're the 
process/library attached to a memcg that is trying to orchestrate its own 
memory usage.  The memcg view of the amount of reclaimable memory (or 
available [free + reclaimable]) should be specific to that hierarchy 
without considering the global MemAvaiable, just as we can incur reclaim 
and/or oom today both from the page allocator and memcg charge path 
separately.  It's two different contexts.

Simplest example would be a malloc implementation that derives benefit 
from keeping as much heap backed by hugepages as possible so attempts to 
avoid splitting huge pmds whenever possible absent memory pressure.  As 
the amount of available memory decreases for whatever reason (more user 
or kernel memory charged to the hierarchy), it could start releasing more 
memory back to the system and splitting these pmds.  This may not only be 
memory.{high,max} - memory.current since it may be preferable for there to 
be some reclaim activity coupled with "userspace reclaim" at this mark, 
such as doing MADV_DONTNEED for memory on the malloc freelist.

> > > For such a stat at memcg scope, we can ignore totalreserves and
> > > watermarks.  We already have ~precise (modulo MEMCG_CHARGE_BATCH) data for
> > > both file pages and slab_reclaimable.
> > >
> > > We can infer lazily free memory by doing
> > >
> > >         file - (active_file + inactive_file)
> > >
> > > (This is necessary because lazy free memory is anon but on the inactive
> > >  file lru and we can't infer lazy freeable memory through pglazyfree -
> > >  pglazyfreed, they are event counters.)
> > > We can also infer the number of underlying compound pages that are on
> > >
> > > deferred split queues but have yet to be split with active_anon - anon (or
> > > is this a bug? :)
> > >
> > > So it *seems* like userspace can make a si_mem_available()-like
> > > calculation ("avail") by doing
> > >
> > >         free = memory.high - memory.current
> 
> min(memory.high, memory.max)
> 
> > >         lazyfree = file - (active_file + inactive_file)
> > >         deferred = active_anon - anon
> > >
> > >         avail = free + lazyfree + deferred +
> > >                 (active_file + inactive_file + slab_reclaimable) / 2
> 
> I am not sure why you want to trigger lazy free differently from the
> global value. But this is really a minor technical thing which is not
> really all that interesting until we actually can define what would be
> the real usecase.
> 
> > > For userspace interested in knowing how much memory it can charge without
> > > incurring I/O (and assuming it has knowledge of available memory on an
> > > overcommitted system), it seems like:
> > >
> > >  (a) it can derive the above avail amount that is at least similar to
> > >      MemAvailable,
> > >
> > >  (b) it can assume that all reclaim is considered equal so anything more
> > >      than memory.high - memory.current is disruptive enough that it's a
> > >      better heuristic than the above, or
> > >
> > >  (c) the kernel provide an "avail" stat in memory.stat based on the above
> > >      and can evolve as the kernel implementation changes (how lazy free
> > >      memory impacts anon vs file lru stats, how deferred split memory is
> > >      handled, any future extensions for "easily reclaimable memory") that
> > >      userspace can count on to the same degree it can count on
> > >      MemAvailable.
> > >
> > > Any thoughts?
> > 
> > 
> > I think we need to answer two questions:
> > 
> > 1) What's the use-case?
> > 2) Why is user space calculating their MemAvailable themselves not good?
> 
> These are questions the discussion should have started with. Thanks!
> 
> > The use case I have in mind is the latency sensitive distributed
> > caching service which would prefer to reduce the amount of its caching
> > over the stalls incurred by hitting the limit. Such applications can
> > monitor their MemAvailable and adjust their caching footprint.
> 
> Is the value really reliable enough to implement such a logic though? I
> have mentioned some problems above. The situation might change at any
> time and the source of that change might be external to the memcg so the
> value would have to be pro-actively polled all the time. This doesn't
> sound very viable to me, especially for latency sensitive service.
> Wouldn't it make more sense to protect the service and dynamically
> change the low memory protection based on the external memory pressure.
> There are different ways to achieve that. E.g. watch for LOW event
> notifications and/or PSI metrics. I believe FB is relying on such a
> dynamic scaling a lot.
>  

Right, and given the limitations imposed by MEMCG_CHARGE_BATCH variance in 
the stats themselves, for example, this value will not be 100% accurate 
since none of the stats are 100% accurate :)

> > For the second, I think it is to hide the internal implementation
> > details of the kernel from the user space. The deferred split queues
> > is an internal detail and we don't want that exposed to the user.
> > Similarly how lazyfree is implemented (i.e. anon pages on file LRU)
> > should not be exposed to the users.
> 
> I would tend to agree that there is a lot of internal logic that can
> skew existing statistics and that might be confusing. But I am not sure
> that providing something that aims to hide them yet is hard to use is a
> proper way forward. But maybe I am just too pessimistic. I would be
> happy to be convinced otherwise.
> 

Idea would be to expose what the kernel deems to be available, much like 
MemAvailable, at a given time without requiring userspace to derive the 
value for themselves.  Certainly they *can*, and I gave an example of how 
it would do that, but it requires an understanding of the metrics that the 
kernel exposes, how reclaim behaves, and attempts to be stable over 
multiple kernel versions which would be the same motivation for the global 
metric.

Assume a memcg hierarchy that is serving that latency sensitive service 
that has been protected from the affects of global pressure but the amount 
of memory consumed by that service varies over releases.  How the kernel 
handles lazy free memory, how it handles deferred split queues, etc, are 
specific details that userspace may not have visiblity into: the metric 
answers the question of "what can I actually get back if I call into 
reclaim?".  How much memory is on the deferred split queue can be 
substantial, for example, but userspace would be unaware of this unless 
they do something like active_anon - anon.

Another use case would be motivated by exactly the MemAvailable use case: 
when bound to a memcg hierarchy, how much memory is available without 
substantial swap or risk of oom for starting a new process or service?  
This would not trigger any memory.low or PSI notification but is a 
heuristic that can be used to determine what can and cannot be started 
without incurring substantial memory reclaim.

I'm indifferent to whether this would be a "reclaimable" or "available" 
metric, with a slight preference toward making it as similar in 
calculation to MemAvailable as possible, so I think the question is 
whether this is something the user should be deriving themselves based on 
memcg stats that are exported or whether we should solidify this based on 
how the kernel handles reclaim as a metric that will carry over across 
kernel vesions?

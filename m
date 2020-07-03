Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D5F213606
	for <lists+cgroups@lfdr.de>; Fri,  3 Jul 2020 10:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgGCIPo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Jul 2020 04:15:44 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:35872 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgGCIPn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Jul 2020 04:15:43 -0400
Received: by mail-ej1-f68.google.com with SMTP id dr13so33302008ejc.3
        for <cgroups@vger.kernel.org>; Fri, 03 Jul 2020 01:15:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nJKToe/ngyXNxbfxc+EUofabc8Tm8QUW9Rjz76FVoBQ=;
        b=Lk02q0CJHunvlRuRELsPO+3Yra8jqGMsw5++aFqvOoCSRdX3gYR/K0YOKUrM2PDZCy
         vzgX4z27wo5llH71eWJ9R2GJINvj6mJ662QDv3oBmyLlZUxCE0p6s9Zybk9sr3lRx3WM
         2Cd4F/vdafFUWpV3HJogDd0Cvbx/7S+Dw2DBRRzccJ4rgHGzTpTr38CZAUcBWaY7yhOb
         tsxWGyi7n0q90Mk1mJVYnHeqAvPGwkJ/x/IvI/udTR/2xWDq/JmXa+6j37iI9LpaStUe
         qSSZQCgvk+OGENzmOY6q7MoQTxg2UCfue+9ztYcY5v2HHT0yZ33WjP3D314nfL2SAdtl
         tYZw==
X-Gm-Message-State: AOAM530oZo/yPqan8iE87FuMRFKw1QQb8lwn2elArKLGA/vIg8MMCnPl
        RHQZiwsobB+J8Hom8fgL82M=
X-Google-Smtp-Source: ABdhPJw7umdLfXv/DAVDElsgL92ZxR/T+DiTHuV1Ye+AgX4t7u6e9QCSqWIx7ntqyEP81raGWd2+sQ==
X-Received: by 2002:a17:906:abca:: with SMTP id kq10mr16367768ejb.515.1593764140807;
        Fri, 03 Jul 2020 01:15:40 -0700 (PDT)
Received: from localhost (ip-37-188-168-3.eurotel.cz. [37.188.168.3])
        by smtp.gmail.com with ESMTPSA id x4sm8707419eju.2.2020.07.03.01.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 01:15:40 -0700 (PDT)
Date:   Fri, 3 Jul 2020 10:15:38 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     David Rientjes <rientjes@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>, Greg Thelen <gthelen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Subject: Re: Memcg stat for available memory
Message-ID: <20200703081538.GO18446@dhcp22.suse.cz>
References: <alpine.DEB.2.22.394.2006281445210.855265@chino.kir.corp.google.com>
 <CALvZod5Zv33oNLxS_8TyGV_QT4CsBjiEuocxpt2+U-XDMaFDPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5Zv33oNLxS_8TyGV_QT4CsBjiEuocxpt2+U-XDMaFDPw@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

I am sorry I was bussy and didn't get to it sooner]

On Thu 02-07-20 08:22:10, Shakeel Butt wrote:
> (Adding more people who might be interested in this)
> 
> 
> On Sun, Jun 28, 2020 at 3:15 PM David Rientjes <rientjes@google.com> wrote:
> >
> > Hi everybody,
> >
> > I'd like to discuss the feasibility of a stat similar to
> > si_mem_available() but at memcg scope which would specify how much memory
> > can be charged without I/O.
> >
> > The si_mem_available() stat is based on heuristics so this does not
> > provide an exact quantity that is actually available at any given time,
> > but can otherwise provide userspace with some guidance on the amount of
> > reclaimable memory.  See the description in
> > Documentation/filesystems/proc.rst and its implementation.

I have to say I was a fan of this metric when it was introduced mostly
because it has removed that nasty subtle detail that Cached value
includes the swap backed memory (e.g. shmem) and that has caused a lot
of confusion. But I became very skeptical over time because it is really
hard to set expectations right when relying on the value for two main
reasons
	- it is a global snapshot value and as such it becomes largely
	  unusable for any decisions which are not implemented right
	  away or if there are multiple uncoordinated consumers.
	- it is not really hard to trigger "corner" cases where a careful
	  use of MemAvailable still leads to a lot of memory reclaim
	  even for single large consumer. What we consider reclaimable
	  might be pinned for different reasons or situation simply
	  changes. Our documentation claims that following this guidance
	  will help prevent from swapping/reclaim yet this is not true
	  and I have seen bug reports in the past.

> >  [ Naturally, userspace would need to understand both the amount of memory
> >    that is available for allocation and for charging, separately, on an
> >    overcommitted system.  I assume this is trivial.  (Why don't we provide
> >    MemAvailable in per-node meminfo?) ]

I presume you min the consumer would simply do min(global, memcg) right?
Well a proper implementation of the value would have to be hierarchical
so it would be minimum over the whole memcg tree up to the root. We
cannot expect userspace do do that.

While technically possible and not that hard to express I am worried
existing problems with the value would be just amplified because there
is even more volatility here. Global value mostly depends on consumers,
now you have a second source of volatility and that is the memcg limit
(hard or high) that can be changed quite dynamically. Sure the global
case can have a similar with memory hotplug but realistically this is
not by far common. Another complication is that the amount of reclaim
for each memcg depends on reclaimability of other reclaim under the
global memory pressure (just consider low/min protection as the simplest
example). So I expect imprecision will be even harder to predict for
per-memcg value.

> > For such a stat at memcg scope, we can ignore totalreserves and
> > watermarks.  We already have ~precise (modulo MEMCG_CHARGE_BATCH) data for
> > both file pages and slab_reclaimable.
> >
> > We can infer lazily free memory by doing
> >
> >         file - (active_file + inactive_file)
> >
> > (This is necessary because lazy free memory is anon but on the inactive
> >  file lru and we can't infer lazy freeable memory through pglazyfree -
> >  pglazyfreed, they are event counters.)
> > We can also infer the number of underlying compound pages that are on
> >
> > deferred split queues but have yet to be split with active_anon - anon (or
> > is this a bug? :)
> >
> > So it *seems* like userspace can make a si_mem_available()-like
> > calculation ("avail") by doing
> >
> >         free = memory.high - memory.current

min(memory.high, memory.max)

> >         lazyfree = file - (active_file + inactive_file)
> >         deferred = active_anon - anon
> >
> >         avail = free + lazyfree + deferred +
> >                 (active_file + inactive_file + slab_reclaimable) / 2

I am not sure why you want to trigger lazy free differently from the
global value. But this is really a minor technical thing which is not
really all that interesting until we actually can define what would be
the real usecase.

> > For userspace interested in knowing how much memory it can charge without
> > incurring I/O (and assuming it has knowledge of available memory on an
> > overcommitted system), it seems like:
> >
> >  (a) it can derive the above avail amount that is at least similar to
> >      MemAvailable,
> >
> >  (b) it can assume that all reclaim is considered equal so anything more
> >      than memory.high - memory.current is disruptive enough that it's a
> >      better heuristic than the above, or
> >
> >  (c) the kernel provide an "avail" stat in memory.stat based on the above
> >      and can evolve as the kernel implementation changes (how lazy free
> >      memory impacts anon vs file lru stats, how deferred split memory is
> >      handled, any future extensions for "easily reclaimable memory") that
> >      userspace can count on to the same degree it can count on
> >      MemAvailable.
> >
> > Any thoughts?
> 
> 
> I think we need to answer two questions:
> 
> 1) What's the use-case?
> 2) Why is user space calculating their MemAvailable themselves not good?

These are questions the discussion should have started with. Thanks!

> The use case I have in mind is the latency sensitive distributed
> caching service which would prefer to reduce the amount of its caching
> over the stalls incurred by hitting the limit. Such applications can
> monitor their MemAvailable and adjust their caching footprint.

Is the value really reliable enough to implement such a logic though? I
have mentioned some problems above. The situation might change at any
time and the source of that change might be external to the memcg so the
value would have to be pro-actively polled all the time. This doesn't
sound very viable to me, especially for latency sensitive service.
Wouldn't it make more sense to protect the service and dynamically
change the low memory protection based on the external memory pressure.
There are different ways to achieve that. E.g. watch for LOW event
notifications and/or PSI metrics. I believe FB is relying on such a
dynamic scaling a lot.
 
> For the second, I think it is to hide the internal implementation
> details of the kernel from the user space. The deferred split queues
> is an internal detail and we don't want that exposed to the user.
> Similarly how lazyfree is implemented (i.e. anon pages on file LRU)
> should not be exposed to the users.

I would tend to agree that there is a lot of internal logic that can
skew existing statistics and that might be confusing. But I am not sure
that providing something that aims to hide them yet is hard to use is a
proper way forward. But maybe I am just too pessimistic. I would be
happy to be convinced otherwise.

-- 
Michal Hocko
SUSE Labs

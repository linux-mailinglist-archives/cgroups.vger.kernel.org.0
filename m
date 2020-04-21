Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D39F1B326B
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2020 23:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgDUV7u (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Apr 2020 17:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgDUV7t (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Apr 2020 17:59:49 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EA0C0610D5
        for <cgroups@vger.kernel.org>; Tue, 21 Apr 2020 14:59:49 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id l13so50189qtr.7
        for <cgroups@vger.kernel.org>; Tue, 21 Apr 2020 14:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bUs9vJdlwC1yJBCrhkzRhRnGrg32yXeJPKM89dGP0Lw=;
        b=II1T4yWmZQx9cdnhJzpV7MJWtdf+F/0/dsAQWktd9uiI3vaIK6RdSV37/5x+bnwhxD
         HvPGFKqZ0AmZ3sxXNCThOXVArW+VYyN9U9JJI2Ks9aZ6iP9x2kOuNos1SBQwObb2rJO1
         wtFmaj/BG2AxQRW9pW80NyKDfNCaFcbUDwm4bUz7kx8WCUQNwNccMRuFwLaM2WOZoEWL
         bcpBFk5k2kl/eRp0h4cBHnuHjYeM46Wc4gwPl5KjEYuNm0oz6sNxiM4WEDdwTAiqbPHl
         XhgofnhfHzuCSid1guGg2X16AnRfJo4gdp7jL0bHOlP9EQzhcjcALL18INcw7iXpLLLU
         5S1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bUs9vJdlwC1yJBCrhkzRhRnGrg32yXeJPKM89dGP0Lw=;
        b=nSdxIZr7UdQu2QHsDNak7TldD1xgnulRXDqnvaO+h/YuGHrt+W74bVEuBYzhaAKfPZ
         7nU1tAr95VyeXX5K+gUUdHCrHkqQLzsDYcYCo1BOVbprnxRD4ZwyyoGXi3NKy97knVVD
         YmeDoRCE997OxldrgTmn28E+jpOtMTF0Y+ALpmmGXKSXJwIy6cdofoX0ShuGWkv1SMZS
         6TwgJl4LKv43FIpePexiwAzRTw4sZjftrrySXyXvRVptrqujPPPsna0L7RQAyzrTzKdL
         9gx7klSlaVya5dyfn5M9YoyaLqEleXYOcfJPRqrLw6gByH2PsBD8x3HM7J6SHjJVT8zw
         7uVg==
X-Gm-Message-State: AGi0PuaKNgqXDJVkUNWHFMbhX1xV9+ED4AivF57b4y7aR8zUF5GTd2km
        aNVwXaPkkbhalh5I2ANx8Phy0g==
X-Google-Smtp-Source: APiQypIx1cwbdQWjPm9sZ1QMBM6YDhcbxL/QD2eBNmBrafSu/ptemfATOFQfe+vH5Ppxbb4LVB6fSg==
X-Received: by 2002:ac8:46d1:: with SMTP id h17mr23173710qto.72.1587506388355;
        Tue, 21 Apr 2020 14:59:48 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a70f])
        by smtp.gmail.com with ESMTPSA id u24sm2528607qkk.84.2020.04.21.14.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 14:59:47 -0700 (PDT)
Date:   Tue, 21 Apr 2020 17:59:46 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [PATCH 0/3] memcg: Slow down swap allocation as the available
 space gets depleted
Message-ID: <20200421215946.GA347151@cmpxchg.org>
References: <20200417193539.GC43469@mtj.thefacebook.com>
 <CALvZod6LT25t9aAA1KHmf1U4-L8zSjUXQ4VQvX4cMT1A+R_g+w@mail.gmail.com>
 <20200417225941.GE43469@mtj.thefacebook.com>
 <CALvZod6M4OsM-t8m_KX9wCkEutdwUMgbP9682eHGQor9JvO_BQ@mail.gmail.com>
 <20200420164740.GF43469@mtj.thefacebook.com>
 <20200420170318.GV27314@dhcp22.suse.cz>
 <20200420170650.GA169746@mtj.thefacebook.com>
 <20200421110612.GD27314@dhcp22.suse.cz>
 <20200421142746.GA341682@cmpxchg.org>
 <CALvZod650M1_46R4OiS1mug+LKbjD=1s_xqckh9T6V8fPjct2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod650M1_46R4OiS1mug+LKbjD=1s_xqckh9T6V8fPjct2g@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 21, 2020 at 12:09:27PM -0700, Shakeel Butt wrote:
> Hi Johannes,
> 
> On Tue, Apr 21, 2020 at 7:27 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> [snip]
> >
> 
> The following is a very good description and it gave me an idea of how
> you (FB) are approaching the memory overcommit problem. The approach
> you are taking is very different from ours and I would like to pick
> your brain on the why (sorry this might be a bit tangent to the
> series).
> 
> Please correct me if I am wrong, your memory overcommit strategy is to
> let the jobs use memory as much as they want but when the system is
> low on memory, slow down everyone (to not let the kernel oom-killer
> trigger) and let the userspace oomd take care of releasing the
> pressure.
> 
> We run multiple latency sensitive jobs along with multiple batch jobs
> on the machine. Overcommitting the memory on such machines, we learn
> that the battle is already lost when the system starts doing direct
> reclaim. Direct reclaim does not differentiate between the reclaimers.
> We could have tried the "slow down" approach but our latency sensitive
> jobs prefer to die and let the load-balancer handover the request to
> some other instance of the job than to stall the request for
> non-deterministic time. We could have tried the PSI-like monitor to
> trigger oom-kills when latency sensitive jobs start seeing the stalls
> but that would be less work-conserving and  non-deterministic behavior
> (i.e. sometimes more oom-kills and sometimes more memory
> overcommitted). The approach we took was to do proactive reclaim along
> with a very low latency refault medium (in-memory compression).
>
> Now as you mentioned, you are trying to be a bit more aggressive in
> the memory overcommit and I can see the writing on the wall that you
> will be stuffing more jobs of different types on a machine, why do you
> think the "slow down" approach will be able to provide the performance
> isolation guarantees?

We do control very aggressive batch jobs to the extent where they have
negligible latency impact on interactive services running on the same
hosts. All the tools to do that are upstream and/or public, but it's
still pretty new stuff (memory.low, io.cost, cpu headroom control,
freezer) and they need to be put together just right.

We're working on a demo application that showcases how it all fits
together and hope to be ready to publish it soon.

> > Just imagine we had a really slow swap device. Some spinning disk that
> > is terrible at random IO. From a performance point of view, this would
> > obviously suck. But from a resource management point of view, this is
> > actually pretty useful in slowing down a workload that is growing
> > unsustainably. This is so useful, in fact, that Virtuozzo implemented
> > virtual swap devices that are artificially slow to emulate this type
> > of "punishment".
> >
> > A while ago, we didn't have any swap configured. We set memory.high
> > and things were good: when things would go wrong and the workload
> > expanded beyond reclaim capabilities, memory.high would inject sleeps
> > until oomd would take care of the workload.
> >
> > Remember that the point is to avoid the kernel OOM killer and do OOM
> > handling in userspace. That's the difference between memory.high and
> > memory.max as well.
> >
> > However, in many cases we now want to overcommit more aggressively
> > than memory.high would allow us. For this purpose, we're switching to
> > memory.low, to only enforce limits when *physical* memory is
> > short. And we've added swap to have some buffer zone at the edge of
> > this aggressive overcommit.
> >
> > But swap has been a good news, bad news situation. The good news is
> > that we have really fast swap, so if the workload is only temporarily
> > a bit over RAM capacity, we can swap a few colder anon pages to tide
> > the workload over, without the workload even noticing. This is
> > fantastic from a performance point of view. It effectively increases
> > our amount of available memory or the workingset sizes we can support.
> >
> > But the bad news is also that we have really fast swap. If we have a
> > misbehaving workload that has a malloc() problem, we can *exhaust*
> > swap space very, very quickly. Where we previously had those nice
> > gradual slowdowns from memory.high when reclaim was failing, we now
> > have very powerful reclaim that can swap at hundreds of megabytes per
> > second - until swap is suddenly full and reclaim abruptly falls apart.
> 
> I think the concern is kernel oom-killer will be invoked too early and
> not giving the chance to oomd.

Yes.

> I am wondering if the PSI polling interface is usable here as it can
> give events in milliseconds. Will that be too noisy?

Yes, it would be hard to sample OOM pressure reliably from CPU bound
reclaim alone. The difference between successful and failing reclaim
isn't all that big in terms of CPU cycles.

> > So while fast swap is an enhancement to our memory capacity, it
> > doesn't reliably act as that overcommit crumble zone that memory.high
> > or slower swap devices used to give us.
> >
> > Should we replace those fast SSDs with crappy disks instead to achieve
> > this effect? Or add a slow disk as a secondary swap device once the
> > fast one is full? That would give us the desired effect, but obviously
> > it would be kind of silly.
> >
> > That's where swap.high comes in. It gives us the performance of a fast
> > drive during temporary dips into the overcommit buffer, while also
> > providing that large rubber band kind of slowdown of a slow drive when
> > the workload is expanding at an unsustainable trend.
> 
> BTW can you explain why is the system level low swap slowdown not
> sufficient and a per-cgroup swap.high is needed? Or maybe you want to
> slow down only specific cgroups.

Yes, that's exactly it. We have a hostcritical.slice cgroup that hosts
oomd and sshd etc., and we want this cgroup to be able to allocate as
quickly as possible. It's more important than the nominal workload.

It needs a headroom of fast swap space after everybody else is already
getting throttled on their swap consumption.

> > > I suspect that the problem is more related to the swap being handled as
> > > a separate resource. And it is still not clear to me why it is easier
> > > for you to tune swap.high than memory.high. You have said that you do
> > > not want to set up memory.high because it is harder to tune but I do
> > > not see why swap is easier in this regards. Maybe it is just that the
> > > swap is almost never used so a bad estimate is much easier to tolerate
> > > and you really do care about runaways?
> >
> > You hit the nail on the head.
> >
> > We don't want memory.high (in most cases) because we want to utilize
> > memory to the absolute maximum.
> >
> > Obviously, the same isn't true for swap because there is no DaX and
> > most workloads can't run when 80% of their workingset are on swap.
> >
> > They're not interchangeable resources.
> >
> 
> What do you mean by not interchangeable? If I keep the hot memory (or
> workingset) of a job in DRAM and cold memory in swap and control the
> rate of refaults by controlling the definition of cold memory then I
> am using the DRAM and swap interchangeably and transparently to the
> job (that is what we actually do).

Right, that's a more precise definition than my randomly chosen "80%"
number above. There are parts of a workload's memory access curve
(where x is distinct data accessed and y is the access frequency) that
don't need to stay in RAM permanently and can be got on-demand from
secondary storage without violating the workload's throughput/latency
requirements. For that part, RAM, swap, disk can be interchangeable.

I'm was specifically talking about the other half of that curve, and
meant to imply that that's usually bigger than 20%. Usually ;-)

I.e. we cannot say: workload x gets 10G of ram or swap, and it doesn't
matter whether it gets it in ram or in swap. There is a line somewhere
in between, and it'll vary with workload requirements, access patterns
and IO speed. But no workload can actually run with 10G of swap and 0
bytes worth of direct access memory, right?

Since you said before you're using combined memory+swap limits, I'm
assuming that you configure the resource as interchangeable, but still
have some form of determining where that cutoff line is between them -
either by tuning proactive reclaim toward that line or having OOM kill
policies when the line is crossed and latencies are violated?

> I am also wondering if you guys explored the in-memory compression
> based swap medium and if there are any reasons to not follow that
> route.

We played around with it, but I'm ambivalent about it.

You need to identify that perfect "warm" middle section of the
workingset curve that is 1) cold enough to not need permanent direct
access memory, yet 2) warm enough to justify allocating RAM to it.

A lot of our workloads have a distinguishable hot set and various
amounts of fairly cold data during stable states, with not too much
middle ground in between where compressed swap would really shine.

Do you use compressed swap fairly universally, or more specifically
for certain workloads?

> Oh you mentioned DAX, that brings to mind a very interesting topic.
> Are you guys exploring the idea of using PMEM as a cheap slow memory?
> It is byte-addressable, so, regarding memcg accounting, will you treat
> it as a memory or a separate resource like swap in v2? How does your
> memory overcommit model work with such a type of memory?

I think we (the kernel MM community, not we as in FB) are still some
ways away from having dynamic/transparent data placement for pmem the
same way we have for RAM. But I expect the kernel's high-level default
strategy to be similar: order virtual memory (the data) by access
frequency and distribute across physical memory/storage accordingly.

(With pmem being divided into volatile space and filesystem space,
where volatile space holds colder anon pages (and, if there is still a
disk, disk cache), and the sizing decisions between them being similar
as the ones we use for swap and filesystem today).

I expect cgroup policy to be separate, because to users the
performance difference matters. We won't want greedy batch
applications displacing latency sensitive ones from RAM into pmem,
just like we don't want this displacement into secondary storage
today. Other than that, there isn't too much difference to users,
because paging is already transparent - an mmapped() file looks the
same whether it's backed by RAM, by disk or by pmem. The difference is
access latencies and the aggregate throughput loss they add up to. So
I could see pmem cgroup limits and protections (for the volatile space
portion) the same way we have RAM limits and protections.

But yeah, I think this is going a bit off topic ;-)

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A10C1B32AC
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2020 00:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgDUWjQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Apr 2020 18:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgDUWjQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Apr 2020 18:39:16 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CF7C0610D5
        for <cgroups@vger.kernel.org>; Tue, 21 Apr 2020 15:39:15 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 198so33945lfo.7
        for <cgroups@vger.kernel.org>; Tue, 21 Apr 2020 15:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HBADq5i/qFEsn3GD0ObPojywM7FchlLznipuc6KZVGk=;
        b=tlhk58r6FhjvjTbo2qnJ7nV8jbf0+1sAG9VaNItYxrAEl8vFoPRgpoZA/hT7gbpjCS
         BlH9CtDPSyfIn2TJofxkZ2QsXsD/XTdu0BQZ4InaxQgWyxDf/56LZnO+Mtm/11B4kVp2
         sn6RZ4D0Qsa44zjS4Jd9TBvQ/TAcvHrzsxOMR5uzTLvHcDaPuqdsIi2DSx+VonQwuHR3
         sNiTejBmcczR82S2KK6s69uAuPlDvsUE1IIunFPs4BQg4rIF7hhUdAullCTZ7riYjqjr
         b054fxXCd/CQFBlS24oYnpNQqZmUYDYdmGyxI4yhjC5BYM6qB2hC0+wAlMTCcHkAdnRs
         XhKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HBADq5i/qFEsn3GD0ObPojywM7FchlLznipuc6KZVGk=;
        b=qC3Owpo4kW4V2wpdQRrIIyD39zc5d1cdvFnf0bsb5oUCcJIdZ2JeWqc7dlvloE5eV8
         MvA6J4t11+mnDz9SqsDMg7j/rdjjy7gbsE08V94P4gZ3eC+eC/zXWFSu1C6GMBHGv930
         MggZd0BkcmDiXBtE5S66AKPkKnL5bwzGcU/OMeSxuPzpmdq/Q8URHVsJFJNVa94NNNCL
         CfjUfZyfvdgrsGhZK68HKQQvoInlDzLlZ9IX27MdDm426P5ciGbS5hUQuKnzwEpASzIz
         wwr5NxJX2VvzfRecA13cwjo69/nhw9ezmpJGvdjBclZyhXIpkdchXNy/xJF79SOs/iH2
         yleA==
X-Gm-Message-State: AGi0PuYnKxdLSXExPek2zG8jIcpzldLbMT/TofflvzvEOKIJjTuG4ZtB
        l5Le7wuZ7m4TcOJ+Yruvpjk8zAoW6yeRqehP6Su9YQ==
X-Google-Smtp-Source: APiQypJVTIkjrsKXbaKgsFwRWDfJ5yGP+zS6tk0wcS411u7J+vcgAbV5ReElU3TpS7X+0A9/ANgsCpc0G9ipATGvJ8I=
X-Received: by 2002:a19:5206:: with SMTP id m6mr14936038lfb.33.1587508753816;
 Tue, 21 Apr 2020 15:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200417193539.GC43469@mtj.thefacebook.com> <CALvZod6LT25t9aAA1KHmf1U4-L8zSjUXQ4VQvX4cMT1A+R_g+w@mail.gmail.com>
 <20200417225941.GE43469@mtj.thefacebook.com> <CALvZod6M4OsM-t8m_KX9wCkEutdwUMgbP9682eHGQor9JvO_BQ@mail.gmail.com>
 <20200420164740.GF43469@mtj.thefacebook.com> <20200420170318.GV27314@dhcp22.suse.cz>
 <20200420170650.GA169746@mtj.thefacebook.com> <20200421110612.GD27314@dhcp22.suse.cz>
 <20200421142746.GA341682@cmpxchg.org> <CALvZod650M1_46R4OiS1mug+LKbjD=1s_xqckh9T6V8fPjct2g@mail.gmail.com>
 <20200421215946.GA347151@cmpxchg.org>
In-Reply-To: <20200421215946.GA347151@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 21 Apr 2020 15:39:01 -0700
Message-ID: <CALvZod4gwBxT=nYnO8eEHr3jrffoMBoLpaB_uHMWL1VAi8XH4Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] memcg: Slow down swap allocation as the available
 space gets depleted
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 21, 2020 at 2:59 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
[snip]
>
> We do control very aggressive batch jobs to the extent where they have
> negligible latency impact on interactive services running on the same
> hosts. All the tools to do that are upstream and/or public, but it's
> still pretty new stuff (memory.low, io.cost, cpu headroom control,
> freezer) and they need to be put together just right.
>
> We're working on a demo application that showcases how it all fits
> together and hope to be ready to publish it soon.
>

That would be awesome.

>
[snip]
> >
> > What do you mean by not interchangeable? If I keep the hot memory (or
> > workingset) of a job in DRAM and cold memory in swap and control the
> > rate of refaults by controlling the definition of cold memory then I
> > am using the DRAM and swap interchangeably and transparently to the
> > job (that is what we actually do).
>
> Right, that's a more precise definition than my randomly chosen "80%"
> number above. There are parts of a workload's memory access curve
> (where x is distinct data accessed and y is the access frequency) that
> don't need to stay in RAM permanently and can be got on-demand from
> secondary storage without violating the workload's throughput/latency
> requirements. For that part, RAM, swap, disk can be interchangeable.
>
> I'm was specifically talking about the other half of that curve, and
> meant to imply that that's usually bigger than 20%. Usually ;-)
>
> I.e. we cannot say: workload x gets 10G of ram or swap, and it doesn't
> matter whether it gets it in ram or in swap. There is a line somewhere
> in between, and it'll vary with workload requirements, access patterns
> and IO speed. But no workload can actually run with 10G of swap and 0
> bytes worth of direct access memory, right?

Yes.

>
> Since you said before you're using combined memory+swap limits, I'm
> assuming that you configure the resource as interchangeable, but still
> have some form of determining where that cutoff line is between them -
> either by tuning proactive reclaim toward that line or having OOM kill
> policies when the line is crossed and latencies are violated?
>

Yes, more specifically tuning proactive reclaim towards that line. We
define that line in terms of acceptable refault rate for the job. The
acceptable refault rate is measured through re-use and idle page
histograms (these histograms are collected through our internal
implementation of Page Idle Tracking). I am planning to upstream and
open-source these.

> > I am also wondering if you guys explored the in-memory compression
> > based swap medium and if there are any reasons to not follow that
> > route.
>
> We played around with it, but I'm ambivalent about it.
>
> You need to identify that perfect "warm" middle section of the
> workingset curve that is 1) cold enough to not need permanent direct
> access memory, yet 2) warm enough to justify allocating RAM to it.
>
> A lot of our workloads have a distinguishable hot set and various
> amounts of fairly cold data during stable states, with not too much
> middle ground in between where compressed swap would really shine.
>
> Do you use compressed swap fairly universally, or more specifically
> for certain workloads?
>

Yes, we are using it fairly universally. There are few exceptions like
user space net and storage drivers.

> > Oh you mentioned DAX, that brings to mind a very interesting topic.
> > Are you guys exploring the idea of using PMEM as a cheap slow memory?
> > It is byte-addressable, so, regarding memcg accounting, will you treat
> > it as a memory or a separate resource like swap in v2? How does your
> > memory overcommit model work with such a type of memory?
>
> I think we (the kernel MM community, not we as in FB) are still some
> ways away from having dynamic/transparent data placement for pmem the
> same way we have for RAM. But I expect the kernel's high-level default
> strategy to be similar: order virtual memory (the data) by access
> frequency and distribute across physical memory/storage accordingly.
>
> (With pmem being divided into volatile space and filesystem space,
> where volatile space holds colder anon pages (and, if there is still a
> disk, disk cache), and the sizing decisions between them being similar
> as the ones we use for swap and filesystem today).
>
> I expect cgroup policy to be separate, because to users the
> performance difference matters. We won't want greedy batch
> applications displacing latency sensitive ones from RAM into pmem,
> just like we don't want this displacement into secondary storage
> today. Other than that, there isn't too much difference to users,
> because paging is already transparent - an mmapped() file looks the
> same whether it's backed by RAM, by disk or by pmem. The difference is
> access latencies and the aggregate throughput loss they add up to. So
> I could see pmem cgroup limits and protections (for the volatile space
> portion) the same way we have RAM limits and protections.
>
> But yeah, I think this is going a bit off topic ;-)

That's really interesting. Thanks for appeasing my curiosity.

thanks,
Shakeel

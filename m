Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A3A358BD9
	for <lists+cgroups@lfdr.de>; Thu,  8 Apr 2021 20:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbhDHSBU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Apr 2021 14:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbhDHSBT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Apr 2021 14:01:19 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06908C061760;
        Thu,  8 Apr 2021 11:01:08 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g17so2731884edm.6;
        Thu, 08 Apr 2021 11:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZemReC1TSq55IWftd7xtsiCONEPHPNvjha2j4W6SaI4=;
        b=jUh2m8TKDU/PpL6QTytoENys9AsuzO6KAG84vtlxyGQyxblyO448kBvCxBhWqCMZBA
         aHWXWogQ/hnP+vOtWXUFDyVrSwDBxwH22U2+mRx9nKXyXGrddZ93+tKLfXAolPIprDDr
         JOidrjnTBIgcV7S1ZABNtmYB0NmDgE2Oq5rwfO6zBzMSKZERYXFyWQp2UDeoGriu7ZLE
         x/IU/felX2klrw2Ipc8FM4CaEy3LspRSVJEiS6vKVjrnk8ah8Ko7/gvM7S/0U3z2MByv
         TeGu9c5I7PETiyGMWy1Iy2bh5WAp3YqjgCBHQ0P/v5w/CtKubN6tRVqzOd4VVVLw7l33
         Bt+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZemReC1TSq55IWftd7xtsiCONEPHPNvjha2j4W6SaI4=;
        b=Zyb6MgVvd6DpQ2UXyYT2oZyhGruspV7Xn2+WrkA4UDhRH+6xmAz99nqOm/T2m7dFVD
         qMqVx1vEhYpvgsOaV1J7SuQO5qxxqBTbeurSBAg3wt6pR6bgFlT4Pp+gQaLnBAsoBkvv
         amEhRLfiNN342dRcHsXfCzsI3vhHTxalR1X5RQ/1I3k8UX8pyj9GNsMe2QQlEyg53Du0
         Yk/GQ6M0/VTF/BnM87K8zvDlNwLWFGg2szcvAy0Ceks4edLX0vQfr7JlvyLNiF7cjs+y
         ZwSL9C5jKdIdX1RxeTHKlGYwLTjBQJuJyVMTYu2wE17VWLxQsDxw2mcqmm2JZYTeMGnu
         JiRg==
X-Gm-Message-State: AOAM531SYlR/Mh+xqVDb90+galsgaQyKptB2sPBdmPrcIoDDjHp7OgmU
        89ehSAVgVktsl2CADT62zfbQ4/zx710GTN9ZXso=
X-Google-Smtp-Source: ABdhPJxC0uwcDWM43fV2v98JbMMwE5bUna5SUm3eKlBAo/ppAInR86YXKKA93ofFKE9zJy1V9to93M3cRMy+cMbIgwY=
X-Received: by 2002:aa7:cc03:: with SMTP id q3mr13258744edt.366.1617904866714;
 Thu, 08 Apr 2021 11:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1617642417.git.tim.c.chen@linux.intel.com> <CALvZod7StYJCPnWRNLnYQV8S5CBLtE0w4r2rH-wZzNs9jGJSRg@mail.gmail.com>
In-Reply-To: <CALvZod7StYJCPnWRNLnYQV8S5CBLtE0w4r2rH-wZzNs9jGJSRg@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 8 Apr 2021 11:00:54 -0700
Message-ID: <CAHbLzkrPD6s9vRy89cgQ36e+1cs6JbLqV84se7nnvP9MByizXA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 00/11] Manage the top tier memory in a tiered memory
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 8, 2021 at 10:19 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> Hi Tim,
>
> On Mon, Apr 5, 2021 at 11:08 AM Tim Chen <tim.c.chen@linux.intel.com> wrote:
> >
> > Traditionally, all memory is DRAM.  Some DRAM might be closer/faster than
> > others NUMA wise, but a byte of media has about the same cost whether it
> > is close or far.  But, with new memory tiers such as Persistent Memory
> > (PMEM).  there is a choice between fast/expensive DRAM and slow/cheap
> > PMEM.
> >
> > The fast/expensive memory lives in the top tier of the memory hierachy.
> >
> > Previously, the patchset
> > [PATCH 00/10] [v7] Migrate Pages in lieu of discard
> > https://lore.kernel.org/linux-mm/20210401183216.443C4443@viggo.jf.intel.com/
> > provides a mechanism to demote cold pages from DRAM node into PMEM.
> >
> > And the patchset
> > [PATCH 0/6] [RFC v6] NUMA balancing: optimize memory placement for memory tiering system
> > https://lore.kernel.org/linux-mm/20210311081821.138467-1-ying.huang@intel.com/
> > provides a mechanism to promote hot pages in PMEM to the DRAM node
> > leveraging autonuma.
> >
> > The two patchsets together keep the hot pages in DRAM and colder pages
> > in PMEM.
>
> Thanks for working on this as this is becoming more and more important
> particularly in the data centers where memory is a big portion of the
> cost.
>
> I see you have responded to Michal and I will add my more specific
> response there. Here I wanted to give my high level concern regarding
> using v1's soft limit like semantics for top tier memory.
>
> This patch series aims to distribute/partition top tier memory between
> jobs of different priorities. We want high priority jobs to have
> preferential access to the top tier memory and we don't want low
> priority jobs to hog the top tier memory.
>
> Using v1's soft limit like behavior can potentially cause high
> priority jobs to stall to make enough space on top tier memory on
> their allocation path and I think this patchset is aiming to reduce
> that impact by making kswapd do that work. However I think the more
> concerning issue is the low priority job hogging the top tier memory.
>
> The possible ways the low priority job can hog the top tier memory are
> by allocating non-movable memory or by mlocking the memory. (Oh there
> is also pinning the memory but I don't know if there is a user api to
> pin memory?) For the mlocked memory, you need to either modify the
> reclaim code or use a different mechanism for demoting cold memory.

Do you mean long term pin? RDMA should be able to simply pin the
memory for weeks. A lot of transient pins come from Direct I/O. They
should be less concerned.

The low priority jobs should be able to be restricted by cpuset, for
example, just keep them on second tier memory nodes. Then all the
above problems are gone.

>
> Basically I am saying we should put the upfront control (limit) on the
> usage of top tier memory by the jobs.

This sounds similar to what I talked about in LSFMM 2019
(https://lwn.net/Articles/787418/). We used to have some potential
usecase which divides DRAM:PMEM ratio for different jobs or memcgs
when I was with Alibaba.

In the first place I thought about per NUMA node limit, but it was
very hard to configure it correctly for users unless you know exactly
about your memory usage and hot/cold memory distribution.

I'm wondering, just off the top of my head, if we could extend the
semantic of low and min limit. For example, just redefine low and min
to "the limit on top tier memory". Then we could have low priority
jobs have 0 low/min limit.

>

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8AB358E57
	for <lists+cgroups@lfdr.de>; Thu,  8 Apr 2021 22:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhDHU3e (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Apr 2021 16:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhDHU3e (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Apr 2021 16:29:34 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92704C061761
        for <cgroups@vger.kernel.org>; Thu,  8 Apr 2021 13:29:22 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id o126so6244481lfa.0
        for <cgroups@vger.kernel.org>; Thu, 08 Apr 2021 13:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JKWZkaAxh0POJeezT3yF35pSQ4SUrFeYy/oZPNJwPrY=;
        b=PVqhoyfl2f2u/ilqwkxpT5t81ZjQ6fxWkKlc9c7/UD8g7alBWP1Zni++NjyRMxKn/x
         59fA6xFmvuAtKQmM7EaCGS3h2iAfnFPq4yTuvUg8OCTtOJi3ITULqRYc3BYdW3+UJAYV
         fsmkZ7aHDcgXgRh3Yz6xBZl/0jYo5y0si1V3grdPkUb5kH0HNrG2dRAWWgttVkGZ0wq+
         eKaaxGg1m3BEezNW+GPliAbu3tm0kHN222/w+irUTxfvLu73Yd1WgPD+gmUYs7jBKHBj
         WVgEuA1U+aFGSZbrELbq5jBqJKM5DqT9aCwZnjXwDLWYBUEyMqk+K9HVIoEWbXpSLgwo
         GhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JKWZkaAxh0POJeezT3yF35pSQ4SUrFeYy/oZPNJwPrY=;
        b=gjlIdgeevwAUQz5bUUbtcsgwmnPMnG95/RDKg/vDs7dApKA3jeL8GrFM8eETGogBac
         3VjE3hMJjpEOuqas4W96MQX7zY8gBFE0PeWf/17bHk7+m1P4HgN57oeVV17qo/125D+S
         5rVcjLndEctAXGsDp+V4QQeKI3iITEQJG9hVywUWLWI8nO+xNQEzLCuxHW6JWrECDvRA
         7LvmvATfC3cd/gWf8IpFAX0oh0PAMGma34ctdqVT3WGtKpbhdSP8ON7v3LflYFa/SvKD
         nh5SI6N6gWzE1HH49845NPcKAFnZ3kz6Z6L4CyFSLzIMqKPaApiX8WxruYKwYdlDnpdt
         AWpQ==
X-Gm-Message-State: AOAM532tli6zkxD7QU+Ip0CcGNcdNs9wkx4zow2p4Ypfslm6LK+NVaNB
        YpN3DiCf5ah8nYrEqgWtQ9QRZLHgC50wWlnVr6Go4Q==
X-Google-Smtp-Source: ABdhPJx9BhcY5woXbdg+3daXIYZOm/y17QAIL3rYs3JXjdmHsc5UfF+FCX7i2salJlUPCRTgqHgb0Ec9ZmZyqKWQMD8=
X-Received: by 2002:a05:6512:3703:: with SMTP id z3mr7860594lfr.358.1617913759939;
 Thu, 08 Apr 2021 13:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1617642417.git.tim.c.chen@linux.intel.com>
 <CALvZod7StYJCPnWRNLnYQV8S5CBLtE0w4r2rH-wZzNs9jGJSRg@mail.gmail.com> <CAHbLzkrPD6s9vRy89cgQ36e+1cs6JbLqV84se7nnvP9MByizXA@mail.gmail.com>
In-Reply-To: <CAHbLzkrPD6s9vRy89cgQ36e+1cs6JbLqV84se7nnvP9MByizXA@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 8 Apr 2021 13:29:08 -0700
Message-ID: <CALvZod69-GcS2W57hAUvjbWBCD6B2dTeVsFbtpQuZOM2DphwCQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 00/11] Manage the top tier memory in a tiered memory
To:     Yang Shi <shy828301@gmail.com>
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

On Thu, Apr 8, 2021 at 11:01 AM Yang Shi <shy828301@gmail.com> wrote:
>
> On Thu, Apr 8, 2021 at 10:19 AM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > Hi Tim,
> >
> > On Mon, Apr 5, 2021 at 11:08 AM Tim Chen <tim.c.chen@linux.intel.com> wrote:
> > >
> > > Traditionally, all memory is DRAM.  Some DRAM might be closer/faster than
> > > others NUMA wise, but a byte of media has about the same cost whether it
> > > is close or far.  But, with new memory tiers such as Persistent Memory
> > > (PMEM).  there is a choice between fast/expensive DRAM and slow/cheap
> > > PMEM.
> > >
> > > The fast/expensive memory lives in the top tier of the memory hierachy.
> > >
> > > Previously, the patchset
> > > [PATCH 00/10] [v7] Migrate Pages in lieu of discard
> > > https://lore.kernel.org/linux-mm/20210401183216.443C4443@viggo.jf.intel.com/
> > > provides a mechanism to demote cold pages from DRAM node into PMEM.
> > >
> > > And the patchset
> > > [PATCH 0/6] [RFC v6] NUMA balancing: optimize memory placement for memory tiering system
> > > https://lore.kernel.org/linux-mm/20210311081821.138467-1-ying.huang@intel.com/
> > > provides a mechanism to promote hot pages in PMEM to the DRAM node
> > > leveraging autonuma.
> > >
> > > The two patchsets together keep the hot pages in DRAM and colder pages
> > > in PMEM.
> >
> > Thanks for working on this as this is becoming more and more important
> > particularly in the data centers where memory is a big portion of the
> > cost.
> >
> > I see you have responded to Michal and I will add my more specific
> > response there. Here I wanted to give my high level concern regarding
> > using v1's soft limit like semantics for top tier memory.
> >
> > This patch series aims to distribute/partition top tier memory between
> > jobs of different priorities. We want high priority jobs to have
> > preferential access to the top tier memory and we don't want low
> > priority jobs to hog the top tier memory.
> >
> > Using v1's soft limit like behavior can potentially cause high
> > priority jobs to stall to make enough space on top tier memory on
> > their allocation path and I think this patchset is aiming to reduce
> > that impact by making kswapd do that work. However I think the more
> > concerning issue is the low priority job hogging the top tier memory.
> >
> > The possible ways the low priority job can hog the top tier memory are
> > by allocating non-movable memory or by mlocking the memory. (Oh there
> > is also pinning the memory but I don't know if there is a user api to
> > pin memory?) For the mlocked memory, you need to either modify the
> > reclaim code or use a different mechanism for demoting cold memory.
>
> Do you mean long term pin? RDMA should be able to simply pin the
> memory for weeks. A lot of transient pins come from Direct I/O. They
> should be less concerned.
>
> The low priority jobs should be able to be restricted by cpuset, for
> example, just keep them on second tier memory nodes. Then all the
> above problems are gone.
>

Yes that's an extreme way to overcome the issue but we can do less
extreme by just (hard) limiting the top tier usage of low priority
jobs.

> >
> > Basically I am saying we should put the upfront control (limit) on the
> > usage of top tier memory by the jobs.
>
> This sounds similar to what I talked about in LSFMM 2019
> (https://lwn.net/Articles/787418/). We used to have some potential
> usecase which divides DRAM:PMEM ratio for different jobs or memcgs
> when I was with Alibaba.
>
> In the first place I thought about per NUMA node limit, but it was
> very hard to configure it correctly for users unless you know exactly
> about your memory usage and hot/cold memory distribution.
>
> I'm wondering, just off the top of my head, if we could extend the
> semantic of low and min limit. For example, just redefine low and min
> to "the limit on top tier memory". Then we could have low priority
> jobs have 0 low/min limit.
>

The low and min limits have semantics similar to the v1's soft limit
for this situation i.e. letting the low priority job occupy top tier
memory and depending on reclaim to take back the excess top tier
memory use of such jobs.

I have some thoughts on NUMA node limits which I will share in the other thread.

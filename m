Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D017358EBA
	for <lists+cgroups@lfdr.de>; Thu,  8 Apr 2021 22:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbhDHUu5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Apr 2021 16:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhDHUu5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Apr 2021 16:50:57 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249AEC061760;
        Thu,  8 Apr 2021 13:50:45 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id n2so5252978ejy.7;
        Thu, 08 Apr 2021 13:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nSkcR4vgYfQ9bCiomxJK4YRcFfPacWHOv81qx13uXCk=;
        b=S+jRaaDesoRNqSTt0/e0qy7JOw05Ck9EsUF9SiuA3sBxm9U/qNUCvFFH6486LuDeXI
         wbNusF9mGCJxP1RKbUuQqZLicwrX7SWzwTHnbP4TQzIvUITOnNeD0Fni+HQXSFGGTyI9
         UnCIiMhdLvmiMjTDDyue4KlFrxDiRrdRhN+RVSF/MKyJ7FwmZ75epJ9C8ekNhEqt+qcm
         FDppNgO5h5AyDiEFW/JaQ/zL+dZOjnAAnd1shc9Fa7oDWIgJP25tIqTbDj+63aw5aP5Y
         /BknCfTYUOySH6gHm0TbwTzxonlU2WA5Brrv6BOpjoKpDvBbRSE08NPegH/Tyl7DnsEm
         OcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nSkcR4vgYfQ9bCiomxJK4YRcFfPacWHOv81qx13uXCk=;
        b=pb5dHCRlhruxxXKduiXKFygjKxBAMmNmo7WRR4JODa5hHYsRDtSeKNGZMqXdfJPI3L
         hDmRTVlgtKrpJFGVKFBk8W0RMu8nVlBexR0vDYjpejznUbvwkFSVplVQTIjQnGBHcMsE
         RfezCaU+n8NfR2i5uNFc4+kzu6/yvwmw1bp5fggzmOgXDCYsob3L9YwEX3WXya2hP9ec
         A+mLqs0IvxlocIFevZsZcKdqm9dupN4rpnnzaAVR7sqp83MjdNBzDGjIvXksi0tOWXvr
         7MrJXBwsS4RBoSrlDSF6+rbp5ZDjmh2m8Gu4KAWGINyg89PQsApv58BWr7qrSd5Xo+tW
         KBJg==
X-Gm-Message-State: AOAM5312glkjmHXsO7/m5r0nhlpOUsXD9fZLCx+I9euHKuAfM4NCGLRX
        c/lJMPLIRuc4lYjX56EcutyeSwtns92kyovcbFg=
X-Google-Smtp-Source: ABdhPJzDT4h97XJaHF/PbtM16viIv5D560gqJE9uxih1mtbScheWKyhXhZv6JlID3X0eZrK6FPC8CHmEXn9gQ6gyxJg=
X-Received: by 2002:a17:906:c143:: with SMTP id dp3mr11934552ejc.499.1617915043821;
 Thu, 08 Apr 2021 13:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1617642417.git.tim.c.chen@linux.intel.com>
 <CALvZod7StYJCPnWRNLnYQV8S5CBLtE0w4r2rH-wZzNs9jGJSRg@mail.gmail.com>
 <CAHbLzkrPD6s9vRy89cgQ36e+1cs6JbLqV84se7nnvP9MByizXA@mail.gmail.com> <CALvZod69-GcS2W57hAUvjbWBCD6B2dTeVsFbtpQuZOM2DphwCQ@mail.gmail.com>
In-Reply-To: <CALvZod69-GcS2W57hAUvjbWBCD6B2dTeVsFbtpQuZOM2DphwCQ@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 8 Apr 2021 13:50:32 -0700
Message-ID: <CAHbLzkoce41b-pJ5x=6nRhex_xBdC-+cYACBw9HKtA87H71A-Q@mail.gmail.com>
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

On Thu, Apr 8, 2021 at 1:29 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Thu, Apr 8, 2021 at 11:01 AM Yang Shi <shy828301@gmail.com> wrote:
> >
> > On Thu, Apr 8, 2021 at 10:19 AM Shakeel Butt <shakeelb@google.com> wrote:
> > >
> > > Hi Tim,
> > >
> > > On Mon, Apr 5, 2021 at 11:08 AM Tim Chen <tim.c.chen@linux.intel.com> wrote:
> > > >
> > > > Traditionally, all memory is DRAM.  Some DRAM might be closer/faster than
> > > > others NUMA wise, but a byte of media has about the same cost whether it
> > > > is close or far.  But, with new memory tiers such as Persistent Memory
> > > > (PMEM).  there is a choice between fast/expensive DRAM and slow/cheap
> > > > PMEM.
> > > >
> > > > The fast/expensive memory lives in the top tier of the memory hierachy.
> > > >
> > > > Previously, the patchset
> > > > [PATCH 00/10] [v7] Migrate Pages in lieu of discard
> > > > https://lore.kernel.org/linux-mm/20210401183216.443C4443@viggo.jf.intel.com/
> > > > provides a mechanism to demote cold pages from DRAM node into PMEM.
> > > >
> > > > And the patchset
> > > > [PATCH 0/6] [RFC v6] NUMA balancing: optimize memory placement for memory tiering system
> > > > https://lore.kernel.org/linux-mm/20210311081821.138467-1-ying.huang@intel.com/
> > > > provides a mechanism to promote hot pages in PMEM to the DRAM node
> > > > leveraging autonuma.
> > > >
> > > > The two patchsets together keep the hot pages in DRAM and colder pages
> > > > in PMEM.
> > >
> > > Thanks for working on this as this is becoming more and more important
> > > particularly in the data centers where memory is a big portion of the
> > > cost.
> > >
> > > I see you have responded to Michal and I will add my more specific
> > > response there. Here I wanted to give my high level concern regarding
> > > using v1's soft limit like semantics for top tier memory.
> > >
> > > This patch series aims to distribute/partition top tier memory between
> > > jobs of different priorities. We want high priority jobs to have
> > > preferential access to the top tier memory and we don't want low
> > > priority jobs to hog the top tier memory.
> > >
> > > Using v1's soft limit like behavior can potentially cause high
> > > priority jobs to stall to make enough space on top tier memory on
> > > their allocation path and I think this patchset is aiming to reduce
> > > that impact by making kswapd do that work. However I think the more
> > > concerning issue is the low priority job hogging the top tier memory.
> > >
> > > The possible ways the low priority job can hog the top tier memory are
> > > by allocating non-movable memory or by mlocking the memory. (Oh there
> > > is also pinning the memory but I don't know if there is a user api to
> > > pin memory?) For the mlocked memory, you need to either modify the
> > > reclaim code or use a different mechanism for demoting cold memory.
> >
> > Do you mean long term pin? RDMA should be able to simply pin the
> > memory for weeks. A lot of transient pins come from Direct I/O. They
> > should be less concerned.
> >
> > The low priority jobs should be able to be restricted by cpuset, for
> > example, just keep them on second tier memory nodes. Then all the
> > above problems are gone.
> >
>
> Yes that's an extreme way to overcome the issue but we can do less
> extreme by just (hard) limiting the top tier usage of low priority
> jobs.
>
> > >
> > > Basically I am saying we should put the upfront control (limit) on the
> > > usage of top tier memory by the jobs.
> >
> > This sounds similar to what I talked about in LSFMM 2019
> > (https://lwn.net/Articles/787418/). We used to have some potential
> > usecase which divides DRAM:PMEM ratio for different jobs or memcgs
> > when I was with Alibaba.
> >
> > In the first place I thought about per NUMA node limit, but it was
> > very hard to configure it correctly for users unless you know exactly
> > about your memory usage and hot/cold memory distribution.
> >
> > I'm wondering, just off the top of my head, if we could extend the
> > semantic of low and min limit. For example, just redefine low and min
> > to "the limit on top tier memory". Then we could have low priority
> > jobs have 0 low/min limit.
> >
>
> The low and min limits have semantics similar to the v1's soft limit
> for this situation i.e. letting the low priority job occupy top tier
> memory and depending on reclaim to take back the excess top tier
> memory use of such jobs.

I don't get why low priority jobs can *not* use top tier memory? I can
think of it may incur latency overhead for high priority jobs. If it
is not allowed, it could be restricted by cpuset without introducing
in any new interfaces.

I'm supposed the memory utilization could be maximized by allowing all
jobs allocate memory from all applicable nodes, then let reclaimer (or
something new if needed) do the job to migrate the memory to proper
nodes by time. We could achieve some kind of balance between memory
utilization and resource isolation.

>
> I have some thoughts on NUMA node limits which I will share in the other thread.

Look forward to reading it.

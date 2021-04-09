Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F51835A81C
	for <lists+cgroups@lfdr.de>; Fri,  9 Apr 2021 22:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbhDIUu6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 9 Apr 2021 16:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhDIUu5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 9 Apr 2021 16:50:57 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16943C061762;
        Fri,  9 Apr 2021 13:50:37 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id ba6so8049663edb.1;
        Fri, 09 Apr 2021 13:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dLgfKnerQa8S9kw5sUyqufs674F+LLwjy+/qpDVrtV4=;
        b=eG7YO91jFuC/ubBB6P/KKDlp1/jANHGvhdE1wzKPGH887hr0qnx7DTEM+Nzlm7fRXX
         yfGquzeL43SyeYSFkoFCWTlq4Arhr4oBhMQ7VmqVESTCliFXd3V3x0tK9+ft4EFKTVWL
         GVgziuqt33WW6aH9R4IRpaviJ1JkPDbpTaRZC1Mb9+8pMredfwJQBbJbQAnkNXzrTIAR
         fPagOrsF32qg17YyGcicIgblru/hfU1W5BkuDbFUiX/GJTn5Q6kw550M4GB2AHL2wAbt
         xTgSdIV8f/nhzz3Tn001xKfLjaDrpbo7JLzyfQ6j4tccLZ3LwL7mcD+AJX56oKRyg488
         gvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dLgfKnerQa8S9kw5sUyqufs674F+LLwjy+/qpDVrtV4=;
        b=klfEWEcmfOlGAo9aSCARYVv3f0MmS97AwOGoZcMbEw1JHn3e5wihI9STEnUCyIg9KT
         GeJV3My54b+Y6cVKnAomdMSxMKMiWvEtU0NNrHdDVLHFwopierPUHS42wbCEg8ct/Jrm
         GZh75mSiw5KJKbGBvMgw9xj15S9xB7z/REqe9aepxN/3DAqFdZO4PtgtvZmA68Ww+6Wy
         xYSRC6+tF+DnKcOzyZKNy4kso48P/CRkxyQNtySBqvNP9QFl/x8Rqu50RlUCPP3Mxnbd
         X0UiOLszpFIQRW8Ob6XjEr3DuTFMH2M2XFFjX4gFE5mzTYYw8cp5g7fVgXr/Cem+KsOA
         V1+w==
X-Gm-Message-State: AOAM530qoezwlr3VERG2MqRHwdaD+ZK/OUNoU5cRzYbWfW+MUkdLgehu
        Rce2x7DtE6KKToBEB5ay1IMQAh4ZNZLSdwB5LLU=
X-Google-Smtp-Source: ABdhPJxGrexh7XQIMbhChYUAHm6t79qHnHYnwzH77BTy3uzmqQaq5H/Byn0HzXRlRxjsz79n2AAvTcSjKFXy2Cy0jdE=
X-Received: by 2002:a50:fd12:: with SMTP id i18mr13568238eds.137.1618001435663;
 Fri, 09 Apr 2021 13:50:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1617642417.git.tim.c.chen@linux.intel.com>
 <CALvZod7StYJCPnWRNLnYQV8S5CBLtE0w4r2rH-wZzNs9jGJSRg@mail.gmail.com>
 <CAHbLzkrPD6s9vRy89cgQ36e+1cs6JbLqV84se7nnvP9MByizXA@mail.gmail.com> <87eefkxiys.fsf@yhuang6-desk1.ccr.corp.intel.com>
In-Reply-To: <87eefkxiys.fsf@yhuang6-desk1.ccr.corp.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 9 Apr 2021 13:50:24 -0700
Message-ID: <CAHbLzkotwwYkZHPRag4oEa3DT8yqd5m8hC_T0U-cJTz0=m0o_A@mail.gmail.com>
Subject: Re: [RFC PATCH v1 00/11] Manage the top tier memory in a tiered memory
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Feng Tang <feng.tang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 8, 2021 at 7:58 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> Yang Shi <shy828301@gmail.com> writes:
>
> > On Thu, Apr 8, 2021 at 10:19 AM Shakeel Butt <shakeelb@google.com> wrote:
> >>
> >> Hi Tim,
> >>
> >> On Mon, Apr 5, 2021 at 11:08 AM Tim Chen <tim.c.chen@linux.intel.com> wrote:
> >> >
> >> > Traditionally, all memory is DRAM.  Some DRAM might be closer/faster than
> >> > others NUMA wise, but a byte of media has about the same cost whether it
> >> > is close or far.  But, with new memory tiers such as Persistent Memory
> >> > (PMEM).  there is a choice between fast/expensive DRAM and slow/cheap
> >> > PMEM.
> >> >
> >> > The fast/expensive memory lives in the top tier of the memory hierachy.
> >> >
> >> > Previously, the patchset
> >> > [PATCH 00/10] [v7] Migrate Pages in lieu of discard
> >> > https://lore.kernel.org/linux-mm/20210401183216.443C4443@viggo.jf.intel.com/
> >> > provides a mechanism to demote cold pages from DRAM node into PMEM.
> >> >
> >> > And the patchset
> >> > [PATCH 0/6] [RFC v6] NUMA balancing: optimize memory placement for memory tiering system
> >> > https://lore.kernel.org/linux-mm/20210311081821.138467-1-ying.huang@intel.com/
> >> > provides a mechanism to promote hot pages in PMEM to the DRAM node
> >> > leveraging autonuma.
> >> >
> >> > The two patchsets together keep the hot pages in DRAM and colder pages
> >> > in PMEM.
> >>
> >> Thanks for working on this as this is becoming more and more important
> >> particularly in the data centers where memory is a big portion of the
> >> cost.
> >>
> >> I see you have responded to Michal and I will add my more specific
> >> response there. Here I wanted to give my high level concern regarding
> >> using v1's soft limit like semantics for top tier memory.
> >>
> >> This patch series aims to distribute/partition top tier memory between
> >> jobs of different priorities. We want high priority jobs to have
> >> preferential access to the top tier memory and we don't want low
> >> priority jobs to hog the top tier memory.
> >>
> >> Using v1's soft limit like behavior can potentially cause high
> >> priority jobs to stall to make enough space on top tier memory on
> >> their allocation path and I think this patchset is aiming to reduce
> >> that impact by making kswapd do that work. However I think the more
> >> concerning issue is the low priority job hogging the top tier memory.
> >>
> >> The possible ways the low priority job can hog the top tier memory are
> >> by allocating non-movable memory or by mlocking the memory. (Oh there
> >> is also pinning the memory but I don't know if there is a user api to
> >> pin memory?) For the mlocked memory, you need to either modify the
> >> reclaim code or use a different mechanism for demoting cold memory.
> >
> > Do you mean long term pin? RDMA should be able to simply pin the
> > memory for weeks. A lot of transient pins come from Direct I/O. They
> > should be less concerned.
> >
> > The low priority jobs should be able to be restricted by cpuset, for
> > example, just keep them on second tier memory nodes. Then all the
> > above problems are gone.
>
> To optimize the page placement of a process between DRAM and PMEM, we
> want to place the hot pages in DRAM and the cold pages in PMEM.  But the
> memory accessing pattern changes overtime, so we need to migrate pages
> between DRAM and PMEM to adapt to the changing.
>
> To avoid the hot pages be pinned in PMEM always, one way is to online
> the PMEM as movable zones.  If so, and if the low priority jobs are
> restricted by cpuset to allocate from PMEM only, we may fail to run
> quite some workloads as being discussed in the following threads,
>
> https://lore.kernel.org/linux-mm/1604470210-124827-1-git-send-email-feng.tang@intel.com/

Thanks for sharing the thread. It seems the configuration of movable
zone + node bind is not supported very well or need evolve to support
new use cases.

>
> >>
> >> Basically I am saying we should put the upfront control (limit) on the
> >> usage of top tier memory by the jobs.
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
>
> Per my understanding, memory.low/min are for the memory protection
> instead of the memory limiting.  memory.high is for the memory limiting.

Yes, it is not limit. I just misused the term, I actually do mean
protection but typed "limit". Sorry for the confusion.

>
> Best Regards,
> Huang, Ying

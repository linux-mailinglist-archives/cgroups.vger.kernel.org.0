Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D48B6F6EEE
	for <lists+cgroups@lfdr.de>; Thu,  4 May 2023 17:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjEDPcE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 May 2023 11:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjEDPcD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 4 May 2023 11:32:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA784697
        for <cgroups@vger.kernel.org>; Thu,  4 May 2023 08:32:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C4FC634F9
        for <cgroups@vger.kernel.org>; Thu,  4 May 2023 15:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0ADC433D2;
        Thu,  4 May 2023 15:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683214321;
        bh=K5f+ZOBIkEgY0QWXt5bxgfyR6U3QA/ZYNaRqOMRJ4Yc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vJW6O++UBsBewhBKc7iq/zdEBCDG4VOYkoQC+cvDBlINQOYRMwWZy8FL7p3tfQ0wq
         LKm9KdTI8hjkv0hEx9UvLnqfqaefpIsKixresfkRmfhQY1MKbvgVTon7+q4VO95FRM
         haB+aGCfcCDy8qlISl+D1uE+BaixU6ySTa5RMcUHFfIdP/273Vbkjha14s8lQ2P8dy
         PeRPa2jPahjujRY3NbkgUIyl1xDGD+qcD7kOLklXFARXbrw5DeKbNwsnUz9kRKtdka
         N+s87Gz7czfgpXkYZy2l5hYuxJDDkpodjyqxxufKwVw5X3AA22QrIzW/CWap5j3zMt
         +RsKeM2dpZ9Ow==
Date:   Thu, 4 May 2023 08:31:59 -0700
From:   Chris Li <chrisl@kernel.org>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     "T.J. Mercier" <tjmercier@google.com>,
        lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>,
        Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [LSF/MM/BPF TOPIC] Reducing zombie memcgs
Message-ID: <ZFPP71czDDxMPLQK@google.com>
References: <CABdmKX2M6koq4Q0Cmp_-=wbP0Qa190HdEGGaHfxNS05gAkUtPA@mail.gmail.com>
 <ZFLdDyHoIdJSXJt+@google.com>
 <874josz4rd.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874josz4rd.fsf@nvidia.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 04, 2023 at 09:58:56PM +1000, Alistair Popple wrote:
> 
> Chris Li <chrisl@kernel.org> writes:
> 
> > Hi T.J.,
> >
> > On Tue, Apr 11, 2023 at 04:36:37PM -0700, T.J. Mercier wrote:
> >> When a memcg is removed by userspace it gets offlined by the kernel.
> >> Offline memcgs are hidden from user space, but they still live in the
> >> kernel until their reference count drops to 0. New allocations cannot
> >> be charged to offline memcgs, but existing allocations charged to
> >> offline memcgs remain charged, and hold a reference to the memcg.
> >> 
> >> As such, an offline memcg can remain in the kernel indefinitely,
> >> becoming a zombie memcg. The accumulation of a large number of zombie
> >> memcgs lead to increased system overhead (mainly percpu data in struct
> >> mem_cgroup). It also causes some kernel operations that scale with the
> >> number of memcgs to become less efficient (e.g. reclaim).
> >> 
> >> There are currently out-of-tree solutions which attempt to
> >> periodically clean up zombie memcgs by reclaiming from them. However
> >> that is not effective for non-reclaimable memory, which it would be
> >> better to reparent or recharge to an online cgroup. There are also
> >> proposed changes that would benefit from recharging for shared
> >> resources like pinned pages, or DMA buffer pages.
> >
> > I am also interested in this topic. T.J. and I have some offline
> > discussion about this. We have some proposals to solve this
> > problem.
> >
> > I will share the write up here for the up coming LSF/MM discussion.
> 
> Unfortunately I won't be attending LSF/MM in person this year but I am

Will you be able to join virtually?

> interested in this topic as well from the point of view of limiting
> pinned pages with cgroups. I am hoping to revive this patch series soon:



> 
> https://lore.kernel.org/linux-mm/cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com/
> 
> The main problem with this series was getting agreement on whether to
> add pinning as a separate cgroup (which is what the series currently
> does) or whether it should be part of a per-page memcg limit.
> 
> The issue with per-page memcg limits is what to do for shared
> mappings. The below suggestion sounds promising because the pins for
> shared pages could be charged to the smemcg. However I'm not sure how it
> would solve the problem of a process in cgroup A being able to raise the
> pin count of cgroup B when pinning a smemcg page which was one of the
> reason I introduced a new cgroup controller.

Now that I think of it, I can see the pin count memcg as a subtype of
smemcg.

The smemcg can have a limit as well, when it add to a memcg, the operation
raise the pin count smemcg charge over the smemcg limit will fail.

For the detail tracking of shared/unshared behavior, the smemcg can model it
as a step 2 feature.

There are four different kind of operation can perform on a smemcg:

1) allocate/charge memory. The charge will add on the per smemcg charge
counter, check against the per smemcg limit. ENOMEM if it is over the limit.

2) free/uncharge memory. Similar to above just subtract the counter.

3) share/mmap already charged memory. This will not change the smemcg charge
count, it will add to a per <smemcg, memcg> borrow counter. It is possible to
put a limit on that counter as well, even though I haven't given too much thought
of how useful it is. That will limit how much memory can mapped from the smemcg.

4) unshare/unmmap already charged memory. That will reduce the per <smemcg, memcg>
borrow counter.

Will that work for your pin memory usage?

> 
> > Shared Memory Cgroup Controllers
> >
> > = Introduction
> >
> > The current memory cgroup controller does not support shared memory
> > objects. For the memory that is shared between different processes, it
> > is not obvious which process should get charged. Google has some
> > internal tmpfs “memcg=” mount option to charge tmpfs data to a
> > specific memcg that’s often different from where charging processes
> > run. However it faces some difficulties when the charged memcg exits
> > and the charged memcg becomes a zombie memcg.
> > Other approaches include “re-parenting” the memcg charge to the parent
> > memcg. Which has its own problem. If the charge is huge, iteration of
> > the reparenting can be costly.
> >
> > = Proposed Solution
> >
> > The proposed solution is to add a new type of memory controller for
> > shared memory usage. E.g. tmpfs, hugetlb, file system mmap and
> > dma_buf. This shared memory cgroup controller object will have the
> > same life cycle of the underlying shared memory.
> >
> > Processes can not be added to the shared memory cgroup. Instead the
> > shared memory cgroup can be added to the memcg using a “smemcg” API
> > file, similar to adding a process into the “tasks” API file.
> > When a smemcg is added to the memcg, the amount of memory that has
> > been shared in the memcg process will be accounted for as the part of
> > the memcg “memory.current”.The memory.current of the memcg is make up
> > of two parts, 1) the processes anonymous memory and 2) the memory
> > shared from smemcg.
> >
> > When the memcg “memory.current” is raised to the limit. The kernel
> > will active try to reclaim for the memcg to make “smemcg memory +
> > process anonymous memory” within the limit.
> 
> That means a process in one cgroup could force reclaim of smemcg memory
> in use by a process in another cgroup right? I guess that's no different
> to the current situation though.
> 
> > Further memory allocation
> > within those memcg processes will fail if the limit can not be
> > followed. If many reclaim attempts fail to bring the memcg
> > “memory.current” within the limit, the process in this memcg will get
> > OOM killed.
> 
> How would this work if say a charge for cgroup A to a smemcg in both
> cgroup A and B would cause cgroup B to go over its memory limit and not
> enough memory could be reclaimed from cgroup B? OOM killing a process in
> cgroup B due to a charge from cgroup A doesn't sound like a good idea.

If we separate out the charge counter with the borrow counter, that problem
will be solved. When smemcg is add to memcg A, we can have a policy specific
that adding the <smemcg, memcg A> borrow counter into memcg A's "memory.current".

If B did not map that page, that page will not be part of <smemcg, memcg B>
borrow count. B will not be punished.

However if B did map that page, The <smemcg, memcg B> need to increase as well.
B will be punished for it.

Will that work for your example situation?

> > = Benefits
> >
> > The benefits of this solution include:
> > * No zombie memcg. The life cycle of the smemcg match the share memory file system or dma_buf.
> 
> If we added pinning it could get a bit messier, as it would have to hang
> around until the driver unpinned the pages. But I don't think that's a
> problem.


That is exactly the reason pin memory can belong to a pin smemcg. You just need
to model the driver holding the pin ref count as one of the share/mmap operation.
Then the pin smemcg will not go away if there is a pending pin ref count on it.

We have have different policy option on smemcg.
For the simple usage don't care the per memcg borrow counter, it can add the
smemcg's charge count to "memory.current".

Only the user who cares about per memcg usage of a smemcg will need to maintain
per <smemcg, memcg> borrow counter, at additional cost.

Chris


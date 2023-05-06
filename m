Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A4F6F94D0
	for <lists+cgroups@lfdr.de>; Sun,  7 May 2023 00:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjEFWtP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 6 May 2023 18:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjEFWtO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 6 May 2023 18:49:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E9C1816F
        for <cgroups@vger.kernel.org>; Sat,  6 May 2023 15:49:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B8B560B79
        for <cgroups@vger.kernel.org>; Sat,  6 May 2023 22:49:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9D3C433D2;
        Sat,  6 May 2023 22:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683413351;
        bh=kx7QPUz0Y8c8AV4z4IpLKWfOYG/J2j7xHQZfV8fP1ic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KeK0udaOZpM6vUDMDN04busMODfk9CA9ck1xfge5y3enIwkvBq89tbuHPUCO7wL3X
         j3Wf1oTsYMDkM+AFFYCCnxiAoSzPL6s07lOCEkms7FcD4+byrS5flkUsMtSxIOzZe4
         9Bz/YWhPNP7XoYxSrMQDoBvTSZeubN/WriMTRvABWQJ0ggMbLHCrnqHPbo14SeqNH4
         oOI1LquKwvY9B6DBCv7cJ1eqzRLeTe0PldWQJYKGBZOeH8u4NW2FmG5Of8CAsTmoRE
         tUXCeDwcJbjJA7SVfkjup6dUeUrsLTHzTHnZNyEbRLp6PjcmUvJKh+GN8oodm+Co3i
         WiZrAVGg3yJqA==
Date:   Sat, 6 May 2023 15:49:08 -0700
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
Message-ID: <ZFbZZPkSpsKMe8iR@google.com>
References: <CABdmKX2M6koq4Q0Cmp_-=wbP0Qa190HdEGGaHfxNS05gAkUtPA@mail.gmail.com>
 <ZFLdDyHoIdJSXJt+@google.com>
 <874josz4rd.fsf@nvidia.com>
 <ZFPP71czDDxMPLQK@google.com>
 <877ctm518f.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877ctm518f.fsf@nvidia.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 05, 2023 at 11:53:24PM +1000, Alistair Popple wrote:
> 
> >> Unfortunately I won't be attending LSF/MM in person this year but I am
> >
> > Will you be able to join virtually?
> 
> I should be able to join afternoon sessions virtually.

Great.

> >> The issue with per-page memcg limits is what to do for shared
> >> mappings. The below suggestion sounds promising because the pins for
> >> shared pages could be charged to the smemcg. However I'm not sure how it
> >> would solve the problem of a process in cgroup A being able to raise the
> >> pin count of cgroup B when pinning a smemcg page which was one of the
> >> reason I introduced a new cgroup controller.
> >
> > Now that I think of it, I can see the pin count memcg as a subtype of
> > smemcg.
> >
> > The smemcg can have a limit as well, when it add to a memcg, the operation
> > raise the pin count smemcg charge over the smemcg limit will fail.
> 
> I'm not sure that works for the pinned scenario. If a smemcg already has
> pinned pages adding it to another memcg shouldn't raise the pin count of
> the memcg it's being added to. The pin counts should only be raised in
> memcg's of processes actually requesting the page be pinned. See below
> though, the idea of borrowing seems helpful.

I am very interested in letting smemcg support your pin usage case.
I read your patch thread a bit but I still feel a bit fuzzy about
the pin usage workflow.

If you have some more detailed write up of the usage case, with a sequence
of interaction and desired outcome that would help me understand. Links to
the previous threads work too.

We can set up some meetings to discuss it as well.

> So for pinning at least I don't see a per smemcg limit being useful.

That is fine.  I see you are interested in the <smemcg, memcg> limit.

> > For the detail tracking of shared/unshared behavior, the smemcg can model it
> > as a step 2 feature.
> >
> > There are four different kind of operation can perform on a smemcg:
> >
> > 1) allocate/charge memory. The charge will add on the per smemcg charge
> > counter, check against the per smemcg limit. ENOMEM if it is over the limit.
> >
> > 2) free/uncharge memory. Similar to above just subtract the counter.
> >
> > 3) share/mmap already charged memory. This will not change the smemcg charge
> > count, it will add to a per <smemcg, memcg> borrow counter. It is possible to
> > put a limit on that counter as well, even though I haven't given too much thought
> > of how useful it is. That will limit how much memory can mapped from the smemcg.
> 
> I would like to see the idea of a borrow counter fleshed out some more
> but this sounds like it could work for the pinning scenario.
> 
> Pinning could be charged to the per <smemcg, memcg> borrow counter and
> the pin limit would be enforced against that plus the anonymous pins.
> 
> Implementation wise we'd need a way to lookup both the smemcg of the
> struct page and the memcg that the pinning task belongs to.

The page->memcg_data points to the pin smemcg. I am hoping pinning API or
the current memcg can get to the pinning memcg.

> > 4) unshare/unmmap already charged memory. That will reduce the per <smemcg, memcg>
> > borrow counter.
> 
> Actually this is where things might get a bit tricky for pinning. We'd
> have to reduce the pin charge when a driver calls put_page(). But that
> implies looking up the borrow counter / <smemcg, memcg> pair a driver
> charged the page to.

Does the pin page share between different memcg or just one memcg?

If it is shared, can the put_page() API indicate it is performing in behalf
of which memcg?
> I will have to give this idea some more tought though. Most drivers
> don't store anything other than the struct page pointers, but my series
> added an accounting struct which I think could reference the borrow
> counter.

Ack.

> 
> > Will that work for your pin memory usage?
> 
> I think it could help. I will give it some thought.

Ack.
> 
> >> 
> >> > Shared Memory Cgroup Controllers
> >> >
> >> > = Introduction
> >> >
> >> > The current memory cgroup controller does not support shared memory
> >> > objects. For the memory that is shared between different processes, it
> >> > is not obvious which process should get charged. Google has some
> >> > internal tmpfs “memcg=” mount option to charge tmpfs data to a
> >> > specific memcg that’s often different from where charging processes
> >> > run. However it faces some difficulties when the charged memcg exits
> >> > and the charged memcg becomes a zombie memcg.
> >> > Other approaches include “re-parenting” the memcg charge to the parent
> >> > memcg. Which has its own problem. If the charge is huge, iteration of
> >> > the reparenting can be costly.
> >> >
> >> > = Proposed Solution
> >> >
> >> > The proposed solution is to add a new type of memory controller for
> >> > shared memory usage. E.g. tmpfs, hugetlb, file system mmap and
> >> > dma_buf. This shared memory cgroup controller object will have the
> >> > same life cycle of the underlying shared memory.
> >> >
> >> > Processes can not be added to the shared memory cgroup. Instead the
> >> > shared memory cgroup can be added to the memcg using a “smemcg” API
> >> > file, similar to adding a process into the “tasks” API file.
> >> > When a smemcg is added to the memcg, the amount of memory that has
> >> > been shared in the memcg process will be accounted for as the part of
> >> > the memcg “memory.current”.The memory.current of the memcg is make up
> >> > of two parts, 1) the processes anonymous memory and 2) the memory
> >> > shared from smemcg.
> >> >
> >> > When the memcg “memory.current” is raised to the limit. The kernel
> >> > will active try to reclaim for the memcg to make “smemcg memory +
> >> > process anonymous memory” within the limit.
> >> 
> >> That means a process in one cgroup could force reclaim of smemcg memory
> >> in use by a process in another cgroup right? I guess that's no different
> >> to the current situation though.
> >> 
> >> > Further memory allocation
> >> > within those memcg processes will fail if the limit can not be
> >> > followed. If many reclaim attempts fail to bring the memcg
> >> > “memory.current” within the limit, the process in this memcg will get
> >> > OOM killed.
> >> 
> >> How would this work if say a charge for cgroup A to a smemcg in both
> >> cgroup A and B would cause cgroup B to go over its memory limit and not
> >> enough memory could be reclaimed from cgroup B? OOM killing a process in
> >> cgroup B due to a charge from cgroup A doesn't sound like a good idea.
> >
> > If we separate out the charge counter with the borrow counter, that problem
> > will be solved. When smemcg is add to memcg A, we can have a policy specific
> > that adding the <smemcg, memcg A> borrow counter into memcg A's "memory.current".
> >
> > If B did not map that page, that page will not be part of <smemcg, memcg B>
> > borrow count. B will not be punished.
> >
> > However if B did map that page, The <smemcg, memcg B> need to increase as well.
> > B will be punished for it.
> >
> > Will that work for your example situation?
> 
> I think so, although I have been looking at this more from the point of
> view of pinning. It sounds like we could treat pinning in much the same
> way as mapping though.

Ack.
> 
> >> > = Benefits
> >> >
> >> > The benefits of this solution include:
> >> > * No zombie memcg. The life cycle of the smemcg match the share memory file system or dma_buf.
> >> 
> >> If we added pinning it could get a bit messier, as it would have to hang
> >> around until the driver unpinned the pages. But I don't think that's a
> >> problem.
> >
> >
> > That is exactly the reason pin memory can belong to a pin smemcg. You just need
> > to model the driver holding the pin ref count as one of the share/mmap operation.
> >
> > Then the pin smemcg will not go away if there is a pending pin ref count on it.
> >
> > We have have different policy option on smemcg.
> > For the simple usage don't care the per memcg borrow counter, it can add the
> > smemcg's charge count to "memory.current".
> >
> > Only the user who cares about per memcg usage of a smemcg will need to maintain
> > per <smemcg, memcg> borrow counter, at additional cost.
> 
> Right, I think pinning drivers will always have to care about the borrow
> counter so will have to track that.

Ack.

Chris


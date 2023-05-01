Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4746F339F
	for <lists+cgroups@lfdr.de>; Mon,  1 May 2023 18:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjEAQpM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 1 May 2023 12:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjEAQpL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 1 May 2023 12:45:11 -0400
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 01 May 2023 09:45:09 PDT
Received: from out-30.mta1.migadu.com (out-30.mta1.migadu.com [95.215.58.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E9810C2
        for <cgroups@vger.kernel.org>; Mon,  1 May 2023 09:45:09 -0700 (PDT)
Date:   Mon, 1 May 2023 09:38:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682959104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=frTPzV4iOiZmCIcq4YO0YBWe928Qg6lFX+1jFsedIxE=;
        b=GCFQWunLE/5T7i7hyR1Clr+xJL6k1eMABapgWo0+NCQyYSYIrRPq5aGvGQouS97PXFIPzN
        hWw/lF+ZcOkUBLoIw519298fzac3kZGbmQdhavrtu1q6XAtlfee0+lr2B8yKRtEEfSxRyy
        xEHKv/X8LGcW7LB14h+byrnBYG0TsBM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     "T.J. Mercier" <tjmercier@google.com>,
        lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alistair Popple <apopple@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Yu Zhao <yuzhao@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>
Subject: Re: [LSF/MM/BPF TOPIC] Reducing zombie memcgs
Message-ID: <ZE/q+ZFWLEa6C6rq@P9FQF9L96D>
References: <CABdmKX2M6koq4Q0Cmp_-=wbP0Qa190HdEGGaHfxNS05gAkUtPA@mail.gmail.com>
 <CAJD7tkZw9uVPe5KH2xrihsv5nDmExJmkmsUPYP6Npvv6Q0NcVw@mail.gmail.com>
 <CAJD7tkb56gR0X5v3VHfmk3az3bOz=wF2jhEi+7Eek0J8XXBeWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkb56gR0X5v3VHfmk3az3bOz=wF2jhEi+7Eek0J8XXBeWQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 25, 2023 at 04:36:53AM -0700, Yosry Ahmed wrote:
>  +David Rientjes +Greg Thelen +Matthew Wilcox

Hi Yosry!

Sorry for being late to the party, I was offline for a week.

> 
> On Tue, Apr 11, 2023 at 4:48 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > On Tue, Apr 11, 2023 at 4:36 PM T.J. Mercier <tjmercier@google.com> wrote:
> > >
> > > When a memcg is removed by userspace it gets offlined by the kernel.
> > > Offline memcgs are hidden from user space, but they still live in the
> > > kernel until their reference count drops to 0. New allocations cannot
> > > be charged to offline memcgs, but existing allocations charged to
> > > offline memcgs remain charged, and hold a reference to the memcg.
> > >
> > > As such, an offline memcg can remain in the kernel indefinitely,
> > > becoming a zombie memcg. The accumulation of a large number of zombie
> > > memcgs lead to increased system overhead (mainly percpu data in struct
> > > mem_cgroup). It also causes some kernel operations that scale with the
> > > number of memcgs to become less efficient (e.g. reclaim).

The problem is even more fundamental:
1) offline memcgs are (almost) fully functional memcgs from the kernel's point
   of view,
2) if memcg A allocates some memory, goes offline and now memcg B is using this
   memory, the memory is effectively shared between memcgs A and B,
3) sharing memory was never really supported by memcgs.

If memory is shared between memcgs, most memcg functionality is broken aside
from a case when memcgs are working in a very predictable and coordinated way.
But generally all counters and stats become racy (whoever allocated it first,
pays the full price, other get it for free), and memory limits and protections
are based on the same counters.

Depending on % memory shared, the rate at which memcg are created and destroyed,
memory pressure and other workload-depending factors the problem can be
significant or not.

One way to tackle this problem is to stop using memcgs as wrappers for
individual processes or workloads and use them more as performance classes.
This means more statically and with less memory sharing.
However I admit it's the opposite direction to where all went for the
last decade or so.

> > >
> > > There are currently out-of-tree solutions which attempt to
> > > periodically clean up zombie memcgs by reclaiming from them. However
> > > that is not effective for non-reclaimable memory, which it would be
> > > better to reparent or recharge to an online cgroup. There are also
> > > proposed changes that would benefit from recharging for shared
> > > resources like pinned pages, or DMA buffer pages.
> >
> > I am very interested in attending this discussion, it's something that
> > I have been actively looking into -- specifically recharging pages of
> > offlined memcgs.
> >
> > >
> > > Suggested attendees:
> > > Yosry Ahmed <yosryahmed@google.com>
> > > Yu Zhao <yuzhao@google.com>
> > > T.J. Mercier <tjmercier@google.com>
> > > Tejun Heo <tj@kernel.org>
> > > Shakeel Butt <shakeelb@google.com>
> > > Muchun Song <muchun.song@linux.dev>
> > > Johannes Weiner <hannes@cmpxchg.org>
> > > Roman Gushchin <roman.gushchin@linux.dev>
> > > Alistair Popple <apopple@nvidia.com>
> > > Jason Gunthorpe <jgg@nvidia.com>
> > > Kalesh Singh <kaleshsingh@google.com>
> 
> I was hoping I would bring a more complete idea to this thread, but
> here is what I have so far.
> 
> The idea is to recharge the memory charged to memcgs when they are
> offlined. I like to think of the options we have to deal with memory
> charged to offline memcgs as a toolkit. This toolkit includes:
> 
> (a) Evict memory.
> 
> This is the simplest option, just evict the memory.
> 
> For file-backed pages, this writes them back to their backing files,
> uncharging and freeing the page. The next access will read the page
> again and the faulting process’s memcg will be charged.
> 
> For swap-backed pages (anon/shmem), this swaps them out. Swapping out
> a page charged to an offline memcg uncharges the page and charges the
> swap to its parent. The next access will swap in the page and the
> parent will be charged. This is effectively deferred recharging to the
> parent.
> 
> Pros:
> - Simple.
> 
> Cons:
> - Behavior is different for file-backed vs. swap-backed pages, for
> swap-backed pages, the memory is recharged to the parent (aka
> reparented), not charged to the "rightful" user.
> - Next access will incur higher latency, especially if the pages are active.

Generally I think it's a good solution iff there is not much of memory sharing
with other memcgs. But in practice there is a high chance that some very hot
pages (e.g. shlib pages shared by pretty much everyone) will get evicted.

> 
> (b) Direct recharge to the parent
> 
> This can be done for any page and should be simple as the pages are
> already hierarchically charged to the parent.
> 
> Pros:
> - Simple.
> 
> Cons:
> - If a different memcg is using the memory, it will keep taxing the
> parent indefinitely. Same not the "rightful" user argument.

It worked for slabs and other kmem objects to reduce the severity of the memcg
zombie clogging. Muchun posted patches for lru pages. I believe it's a decent
way to solve the zombie problem, but it doesn't solve any issues with the memory
sharing.

> 
> (c) Direct recharge to the mapper
> 
> This can be done for any mapped page by walking the rmap and
> identifying the memcg of the process(es) mapping the page.
> 
> Pros:
> - Memory is recharged to the “rightful” user.
> 
> Cons:
> - More complicated, the “rightful” user’s memcg might run into an OOM
> situation – which in this case will be unpredictable and hard to
> correlate with an allocation.
> 
> (d) Deferred recharging
> 
> This is a mixture of (b) & (c) above. It is a two-step process. We
> first recharge the memory to the parent, which should be simple and
> reliable. Then, we mark the pages so that the next time they are
> accessed or mapped we recharge them to the "rightful" user.
> 
> For mapped pages, we can use the numa balancing approach of protecting
> the mapping (while the vma is still accessible), and then in the fault
> path recharge the page. This is better than eviction because the fault
> on the next access is minor, and better than direct recharging to the
> mapping in the sense that the charge is correlated with an
> allocation/mapping. Of course, it is more complicated, we have to
> handle different protection interactions (e.g. what if the page is
> already protected?). Another disadvantage is that the recharging
> happens in the context of a page fault, rather than asynchronously in
> the case of directly recharging to the mapper. Page faults are more
> latency sensitive, although this shouldn't be a common path.
> 
> For unmapped pages, I am struggling to find a way that is simple
> enough to recharge the memory on the next access. My first intuition
> was to add a hook to folio_mark_accessed(), but I was quickly told
> that this is not invoked in all access paths to unmapped pages (e.g.
> writes through fds). We can also add a hook to folio_mark_dirty() to
> add more coverage, but it seems like this path is fragile, and it
> would be ideal if there is a shared well-defined common path (or
> paths) for all accesses to unmapped pages. I would imagine if such a
> path exists or can be forged it would probably be in the page cache
> code somewhere.

The problem is that we'd need to add hooks and checks into many hot paths,
so the performance penalty will be likely severe.
But of course hard to tell without actual patches.
> 
> For both cases, if a new mapping is created, we can do recharging there.
> 
> Pros:
> - Memory is recharged to the “rightful” user, eventually.
> - The charge is predictable and correlates to a user's access.
> - Less overhead on next access than eviction.
> 
> Cons:
> - The memory will remain charged to the parent until the next access
> happens, if it ever happens.
> - Worse overhead on next access than directly recharging to the mapper.
> 
> With this (incompletely defined) toolkit, a recharging algorithm can
> look like this (as a rough example):
> 
> - If the page is file-backed:
>   - Unmapped? evict (a).
>   - Mapped? recharge to the mapper -- direct (c) or deferred (d).
> - If the page is swap-backed:
>   - Unmapped? deferred recharge to the next accessor (d).
>   - Mapped? recharge to the mapper -- direct (c) or deferred (d).
> 
> There are, of course, open questions:
> 1) How do we do deferred recharging for unmapped pages? Is deferred
> recharging even a reliable option to begin with? What if the pages are
> never accessed again?

I believe the real question is how to handle memory shared between memcgs.
Dealing with offline memcgs is just a specific case of this problem.
> 
> Again, I was hoping to come up with a more concrete proposal, but as
> LSF/MM/BPF is approaching, I wanted to share my thoughts on the
> mailing list looking for any feedback.

Thank you for bringing it in!

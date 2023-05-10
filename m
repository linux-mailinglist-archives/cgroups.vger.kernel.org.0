Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08E36FE0D2
	for <lists+cgroups@lfdr.de>; Wed, 10 May 2023 16:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237497AbjEJOvz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 May 2023 10:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237430AbjEJOvy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 10 May 2023 10:51:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A214E62
        for <cgroups@vger.kernel.org>; Wed, 10 May 2023 07:51:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD5E563C71
        for <cgroups@vger.kernel.org>; Wed, 10 May 2023 14:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE418C433D2;
        Wed, 10 May 2023 14:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683730310;
        bh=7evBYi0i7GbTztiP0Mr29XwL0agrgkBAJJMMkwtKGRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cyhtXMYhgJyKmzhMNocfhYL1c1rv5GpL+M8naZmrG5TP6GM0t9vC5Ka6yUuu45WPL
         DY45XWrBza3BDjXcPciDwnrl0ervqHsfQpSpMZQzEgee9fj30fu31AHsnF7oj4gMe0
         Tx1NNAO0fRbvo7Cb2A1xBSFoi2DAlPva7eHrx7o191esszeEdQk3bKdGTNqjWkM/Co
         htQpS6O6S5hKi+ec3LeMsykesSYnVAbZhVvZtxs+QRxiPvEHSTv8orMN28m+3M/C9U
         hW/Wak1Qe5NlBIzqglc+vhh6QL5dd9JVIkAFcqGpg3yA+GEX4TK2CjPikrmr0jCoSN
         olZyoGd1cxj7A==
Date:   Wed, 10 May 2023 07:51:48 -0700
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
Message-ID: <ZFuvhP5qGPivokc0@google.com>
References: <CABdmKX2M6koq4Q0Cmp_-=wbP0Qa190HdEGGaHfxNS05gAkUtPA@mail.gmail.com>
 <ZFLdDyHoIdJSXJt+@google.com>
 <874josz4rd.fsf@nvidia.com>
 <ZFPP71czDDxMPLQK@google.com>
 <877ctm518f.fsf@nvidia.com>
 <ZFbZZPkSpsKMe8iR@google.com>
 <87ttwnkzap.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ttwnkzap.fsf@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Alistair,

On Mon, May 08, 2023 at 06:17:04PM +1000, Alistair Popple wrote:
> Actually I don't have an invite so might not make it. However I believe
> Jason Gunthorpe is there and he has been helping with this as well so he
> might be able to attend the session. Or we could discuss it in one of

Yes, I talked to Jason Gunthorpe and asked him about the usage workflow
of the pin memory controller. He tell me that his original intend is
just to have something like RLIMIT but without the quirky limitation
of the RLIMIT. It has nothing to do with sharing memory.
Share memories are only brought up during the online discussion.  I guess
the share memory has similar reference count and facing similar challenges
on double counting.

> the Linux MM biweeklies. (TBH I've been busy on other work and am only
> just getting back up to speed on this myself).
> 
> > If you have some more detailed write up of the usage case, with a sequence
> > of interaction and desired outcome that would help me understand. Links to
> > the previous threads work too.
> 
> Unfortunately I don't (yet) have a detailed write up. But the primary
> use case we had in mind was sandboxing of containers and qemu instances
> to be able to limit the total amount of memory they can pin.

Ack.
 
> This is just like the existing RLIMIT, just with the limit assigned via
> a cgroup instead of a per-process or per-user limit as they can easily
> be subverted, particularly the per-process limit.

Ack.

> The sandboxing requirement is what drove us to not use the existing
> per-page memcg.

Not sure I understand what you mean here "use the existing per-page memcg".
Do you mean you need byte counter rather than page counter?

On the other hand it is not important to understand the rest of your points.
I can move on.

> For private mappings it would be fine because the page
> would only ever be mapped by a process in a single cgroup (ie. a single
> memcg).

Ack.
 
> However for shared mappings it isn't - processes in different cgroups
> could be mapping the same page but the accounting should happen to the
> cgroup the process is in, not the cgroup that happens to "own" the page.

Ack. That is actually the root of the share memory problem. The model
of charging to the first process does not work well for share usage.

> It is also possible that the page might not be mapped at all. For
> example a driver may be pinning a page with pin_user_pages(), but the
> userspace process may have munmap()ped it.

Ack.
In that case the driver will need to hold a reference count for it, right?

> 
> For drivers pinned memory is generally associated with some operation on
> a file-descriptor. So the desired interaction/outcome is:
> 
> 1. Process in cgroup A opens file-descriptor
> 2. Calls an ioctl() on the FD to pin memory.
> 3. Driver charges the memory to a counter and checks it's under the
>    limit.
> 4. If over limit the ioctl() will fail.

Ack.

> 
> This is effectively how the vm_pinned/locked RLIMIT works today. Even if
> a shared page is already pinned the process should still be "punished"
> for pinning the page.

OK. This is the critical usage information that I want to know. Thanks for
the explaination.

So there are two different definition of the pin page count:
1) sum(total set of pages that this memcg process issue pin ioctl on)
2) sum(total set of pined page this memcg process own a reference count on)

It seems you want 2).

If a page has three reference counts inside one memcg, e.g. map three times. 
Does the pin count three times or only once?

> Hence the interest in the total <smemcg, memcg>  limit.
> 
> Pinned memory may also outlive the process that created it - drivers
> associate it via a file-descriptor not a process and even if the FD is
> closed there's nothing say a driver has to unpin the memory then
> (although most do).

Ack.

> 
> > We can set up some meetings to discuss it as well.
> >
> >> So for pinning at least I don't see a per smemcg limit being useful.
> >
> > That is fine.  I see you are interested in the <smemcg, memcg> limit.
> 
> Right, because it sounds like it will allow pinning the same struct page
> multiple times to result in multiple charges. With the current memcg

Multiple times to different memcgs I assume, please see the above question
regard multiple times to the same memcg.

> implementation this isn't possible because a page can only be associated
> with a single memcg.

Ack.

> 
> A limit on just smemcg doesn't seem useful from a sandboxing perspective
> because processes from other cgroups can use up the limit.

Ack.

> >> Implementation wise we'd need a way to lookup both the smemcg of the
> >> struct page and the memcg that the pinning task belongs to.
> >
> > The page->memcg_data points to the pin smemcg. I am hoping pinning API or
> > the current memcg can get to the pinning memcg.
> 
> So the memcg to charge would come from the process doing the
> pin_user_pages() rather than say page->memcg_data? Seems reasonable.

That is more of a question for you. What is the desired behavior.
If charge the current process that perform the pin_user_pages()
works for you. Great.

I agree charge the pin count to current process memcg seems to make
sense.

> >> > 4) unshare/unmmap already charged memory. That will reduce the per <smemcg, memcg>
> >> > borrow counter.
> >> 
> >> Actually this is where things might get a bit tricky for pinning. We'd
> >> have to reduce the pin charge when a driver calls put_page(). But that
> >> implies looking up the borrow counter / <smemcg, memcg> pair a driver
> >> charged the page to.
> >
> > Does the pin page share between different memcg or just one memcg?
> 
> In general it can share between different memcg. Consider a shared
> mapping shared with processes in two different cgroups (A and B). There
> is nothing stopping each process opening a file-descriptor and calling
> an ioctl() to pin the shared page.

Ack.

> Each should be punished for pinning the page in the sense that the pin
> count for their respective cgroups must go up.

Ack. That clarfy my previous question. You want definition 2)

> Drivers pinning shared pages is I think relatively rare, but it's
> theorectically possible and if we're going down the path of adding
> limits for pinning to memcg it's something we need to deal with to make
> sandboxing effective.

The driver will still have a current processor. Do you mean in this case,
the current processor is not the right one to charge?
Another option can be charge to a default system/kernel smemcg or a driver
smemcg as well.

> 
> > If it is shared, can the put_page() API indicate it is performing in behalf
> > of which memcg?
> 
> I think so - although it varies by driver.
> 
> Drivers have to store the array of pages pinned so should be able to
> track the memcg with that as well. My series added a struct vm_account
> which would be the obvious place to keep that reference.

Where does the struct vm_account lives?

> Each set of pin 
> operations on a FD would need a new memcg reference though so it would
> add overhead for drivers that only pin a small number of pages at a
> time.

Set is more complicate then allow double counting the same page in the
same smemcg. Again mostly just collecting requirement from you.

> 
> Non-driver users such as the mlock() syscall don't keep a pinned pages
> array around but they should be able to use the current memcg during
> munlock().

Ack.

Chris

> 
> >> I will have to give this idea some more tought though. Most drivers
> >> don't store anything other than the struct page pointers, but my series
> >> added an accounting struct which I think could reference the borrow
> >> counter.
> >
> > Ack.
> >
> >> 
> >> > Will that work for your pin memory usage?
> >> 
> >> I think it could help. I will give it some thought.
> >
> > Ack.
> >> 
> >> >> 
> >> >> > Shared Memory Cgroup Controllers
> >> >> >
> >> >> > = Introduction
> >> >> >
> >> >> > The current memory cgroup controller does not support shared memory
> >> >> > objects. For the memory that is shared between different processes, it
> >> >> > is not obvious which process should get charged. Google has some
> >> >> > internal tmpfs “memcg=” mount option to charge tmpfs data to a
> >> >> > specific memcg that’s often different from where charging processes
> >> >> > run. However it faces some difficulties when the charged memcg exits
> >> >> > and the charged memcg becomes a zombie memcg.
> >> >> > Other approaches include “re-parenting” the memcg charge to the parent
> >> >> > memcg. Which has its own problem. If the charge is huge, iteration of
> >> >> > the reparenting can be costly.
> >> >> >
> >> >> > = Proposed Solution
> >> >> >
> >> >> > The proposed solution is to add a new type of memory controller for
> >> >> > shared memory usage. E.g. tmpfs, hugetlb, file system mmap and
> >> >> > dma_buf. This shared memory cgroup controller object will have the
> >> >> > same life cycle of the underlying shared memory.
> >> >> >
> >> >> > Processes can not be added to the shared memory cgroup. Instead the
> >> >> > shared memory cgroup can be added to the memcg using a “smemcg” API
> >> >> > file, similar to adding a process into the “tasks” API file.
> >> >> > When a smemcg is added to the memcg, the amount of memory that has
> >> >> > been shared in the memcg process will be accounted for as the part of
> >> >> > the memcg “memory.current”.The memory.current of the memcg is make up
> >> >> > of two parts, 1) the processes anonymous memory and 2) the memory
> >> >> > shared from smemcg.
> >> >> >
> >> >> > When the memcg “memory.current” is raised to the limit. The kernel
> >> >> > will active try to reclaim for the memcg to make “smemcg memory +
> >> >> > process anonymous memory” within the limit.
> >> >> 
> >> >> That means a process in one cgroup could force reclaim of smemcg memory
> >> >> in use by a process in another cgroup right? I guess that's no different
> >> >> to the current situation though.
> >> >> 
> >> >> > Further memory allocation
> >> >> > within those memcg processes will fail if the limit can not be
> >> >> > followed. If many reclaim attempts fail to bring the memcg
> >> >> > “memory.current” within the limit, the process in this memcg will get
> >> >> > OOM killed.
> >> >> 
> >> >> How would this work if say a charge for cgroup A to a smemcg in both
> >> >> cgroup A and B would cause cgroup B to go over its memory limit and not
> >> >> enough memory could be reclaimed from cgroup B? OOM killing a process in
> >> >> cgroup B due to a charge from cgroup A doesn't sound like a good idea.
> >> >
> >> > If we separate out the charge counter with the borrow counter, that problem
> >> > will be solved. When smemcg is add to memcg A, we can have a policy specific
> >> > that adding the <smemcg, memcg A> borrow counter into memcg A's "memory.current".
> >> >
> >> > If B did not map that page, that page will not be part of <smemcg, memcg B>
> >> > borrow count. B will not be punished.
> >> >
> >> > However if B did map that page, The <smemcg, memcg B> need to increase as well.
> >> > B will be punished for it.
> >> >
> >> > Will that work for your example situation?
> >> 
> >> I think so, although I have been looking at this more from the point of
> >> view of pinning. It sounds like we could treat pinning in much the same
> >> way as mapping though.
> >
> > Ack.
> >> 
> >> >> > = Benefits
> >> >> >
> >> >> > The benefits of this solution include:
> >> >> > * No zombie memcg. The life cycle of the smemcg match the share memory file system or dma_buf.
> >> >> 
> >> >> If we added pinning it could get a bit messier, as it would have to hang
> >> >> around until the driver unpinned the pages. But I don't think that's a
> >> >> problem.
> >> >
> >> >
> >> > That is exactly the reason pin memory can belong to a pin smemcg. You just need
> >> > to model the driver holding the pin ref count as one of the share/mmap operation.
> >> >
> >> > Then the pin smemcg will not go away if there is a pending pin ref count on it.
> >> >
> >> > We have have different policy option on smemcg.
> >> > For the simple usage don't care the per memcg borrow counter, it can add the
> >> > smemcg's charge count to "memory.current".
> >> >
> >> > Only the user who cares about per memcg usage of a smemcg will need to maintain
> >> > per <smemcg, memcg> borrow counter, at additional cost.
> >> 
> >> Right, I think pinning drivers will always have to care about the borrow
> >> counter so will have to track that.
> >
> > Ack.
> >
> > Chris
> 
> 

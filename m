Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B1270A8DA
	for <lists+cgroups@lfdr.de>; Sat, 20 May 2023 17:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjETPbI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 20 May 2023 11:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjETPbH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 20 May 2023 11:31:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AA3121
        for <cgroups@vger.kernel.org>; Sat, 20 May 2023 08:31:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 200A860DEF
        for <cgroups@vger.kernel.org>; Sat, 20 May 2023 15:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06805C433D2;
        Sat, 20 May 2023 15:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684596663;
        bh=SDFdEY5M6VQT8dUJDl+Tz+UxRV57s2ymsjeugVSGjzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CskNJM+Mp9beAWrZGNmoVuyZI/NNFo3PmdQP9IXQ200giKuot+qWiDARNiNNBzW6G
         HoiOSMAfqL9mq4/2R/TQz/ygN6wzfubbLbOne5tTRBeDMfq+kkRz7lmu9NWPn2DqyM
         Ny5rm8YZJn1nJgqkWrE4RVefgv55psyoVi/TFg52rk6D1bnWET2ZYzCLhNP9FhT3Sv
         d2Mf95eq4H/W9o433BhreRLlfdr9FZb8tmGlOws53QLb+Qj2gYyB2QHW42gZ27ARPX
         ArNnRG/9RgV9/yW9pqHi6WL6q1axi17RB/Ob8cYH7owu/bUSo1qsiDNdez+0VwxpnE
         bz/FQN9ZuEhbQ==
Date:   Sat, 20 May 2023 08:31:01 -0700
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
Message-ID: <ZGjntWoAfgyT0doo@google.com>
References: <CABdmKX2M6koq4Q0Cmp_-=wbP0Qa190HdEGGaHfxNS05gAkUtPA@mail.gmail.com>
 <ZFLdDyHoIdJSXJt+@google.com>
 <874josz4rd.fsf@nvidia.com>
 <ZFPP71czDDxMPLQK@google.com>
 <877ctm518f.fsf@nvidia.com>
 <ZFbZZPkSpsKMe8iR@google.com>
 <87ttwnkzap.fsf@nvidia.com>
 <ZFuvhP5qGPivokc0@google.com>
 <87jzxe9baj.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jzxe9baj.fsf@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Alistair,

Sorry for the late reply. Super busy after return from LSF/MM.
Catching up my emails.

On Fri, May 12, 2023 at 06:45:13PM +1000, Alistair Popple wrote:
> > Yes, I talked to Jason Gunthorpe and asked him about the usage workflow
> > of the pin memory controller. He tell me that his original intend is
> > just to have something like RLIMIT but without the quirky limitation
> > of the RLIMIT. It has nothing to do with sharing memory.
> > Share memories are only brought up during the online discussion.  I guess
> > the share memory has similar reference count and facing similar challenges
> > on double counting.
> 
> Ok, good. Now I realise perhaps we delved into this discussion without
> covering the background.
> 
> My original patch series implemented what Jason suggested. That was a
> standalone pinscg controller (which perhaps should be implemented as a
> misc controller) that behaves the same as RLIMIT does, just charged to a
> pinscg rather than a process or user.
> 
> However review comments suggested it needed to be added as part of
> memcg. As soon as we do that we have to address how we deal with shared
> memory. If we stick with the original RLIMIT proposal this discussion
> goes away, but based on feedback I think I need to at least investigate
> integrating it into memcg to get anything merged.
Ack.

> 
> [...]
> 
> >> However for shared mappings it isn't - processes in different cgroups
> >> could be mapping the same page but the accounting should happen to the
> >> cgroup the process is in, not the cgroup that happens to "own" the page.
> >
> > Ack. That is actually the root of the share memory problem. The model
> > of charging to the first process does not work well for share usage.
> 
> Right. The RLIMIT approach avoids the shared memory problem by charging
> every process in a pincg for every pin (see below). But I don't disagree
> there is appeal to having pinning work in the same way as memcg hence
> this discussion.

Ack.

> 
> >> It is also possible that the page might not be mapped at all. For
> >> example a driver may be pinning a page with pin_user_pages(), but the
> >> userspace process may have munmap()ped it.
> >
> > Ack.
> > In that case the driver will need to hold a reference count for it, right?
> 
> Correct. Drivers would normally drop that reference when the FD is
> closed but there's nothing that says they have to.

Ack.

> 
> [...]
> 
> > OK. This is the critical usage information that I want to know. Thanks for
> > the explaination.
> >
> > So there are two different definition of the pin page count:
> > 1) sum(total set of pages that this memcg process issue pin ioctl on)
> > 2) sum(total set of pined page this memcg process own a reference count on)
> >
> > It seems you want 2).
> >
> > If a page has three reference counts inside one memcg, e.g. map three times. 
> > Does the pin count three times or only once?
> 
> I'm going to be pedantic here because it's important - by "map three
> times" I assume you mean "pin three times with an ioctl". For pinning it
> doesn't matter if the page is actually mapped or not.

Pedantic is good.
I actually thinking about the other way around: pin the page with
ioctl once, then that page is map to other process three times with
three virtual addresses.

My guess from your reply is that it counts as one pin only.

> 
> This is basically where we need to get everyone aligned. The RLIMIT
> approach currently implemented by my patch series does (2). For example:
> 
> 1. If a process in a pincg requests (eg. via driver ioctl) to pin a page
>    it is charged against the pincg limit and will fail if going over
>    limit.
> 
> 2. If the same process requests another pin (doesn't matter if it's the
>    same page or not) it will be charged again and can't go over limit.
> 
> 3. If another process in the same pincg requests a page (again, doesn't
>    matter if it's the same page or not) be pinned it will be charged
>    against the limit.

I see. You want to track and punish the number of time process
issue pin ioctl on the page.

> 
> 4. If a process not in the pincg pins the same page it will not be
>    charged against the pincg limit.

Ack, because it is not in the pincg.

> 
> From my perspective I think (1) would be fine (or even preferable) if
> and only if the sharing issues can be resolved. In that case it becomes
> much easier to explain how to set the limit.

Ack.

> For example it could be set as a percentage of total memory allocated to
> the memcg, because all that really matters is the first pin within a
> given memcg.
> 
> Subsequent pins won't impact system performance or stability because
> once the page is pinned once it may as well be pinned a hundred
> times. The only reason I didn't take this approach in my series is that
> it's currently impossible to figure out what to do in the shared case
> because we have no way of mapping pages back to multiple memcgs to see
> if they've already been charged to that memcg, so they would have to be
> charged to a single memcg which isn't useful.
> 

Ack.

> >> Hence the interest in the total <smemcg, memcg>  limit.
> >> 
> >> Pinned memory may also outlive the process that created it - drivers
> >> associate it via a file-descriptor not a process and even if the FD is
> >> closed there's nothing say a driver has to unpin the memory then
> >> (although most do).
> >
> > Ack.
> >
> >> 
> >> > We can set up some meetings to discuss it as well.
> >> >
> >> >> So for pinning at least I don't see a per smemcg limit being useful.
> >> >
> >> > That is fine.  I see you are interested in the <smemcg, memcg> limit.
> >> 
> >> Right, because it sounds like it will allow pinning the same struct page
> >> multiple times to result in multiple charges. With the current memcg
> >
> > Multiple times to different memcgs I assume, please see the above question
> > regard multiple times to the same memcg.
> 
> Right. If we have a page that is pinned by two processes in different
> cgroups each cgroup should be charged once (and IMHO only once) for it.
> 
Ack.

> In other words if two processes in the same memcg pin the same page that
> should only count as a single pin towards that memcg's pin limit, and
> the pin would be uncharged when the final pinner unpins the page.

Ack. You need to track the set of page you already pin on. 

> Note this is not what is implemented by the RLIMIT approach hence why it
> conflicts with my answer to the above question which describes that
> approach.

Ack.

> 
> [...]
> 
> >> >> Implementation wise we'd need a way to lookup both the smemcg of the
> >> >> struct page and the memcg that the pinning task belongs to.
> >> >
> >> > The page->memcg_data points to the pin smemcg. I am hoping pinning API or
> >> > the current memcg can get to the pinning memcg.
> >> 
> >> So the memcg to charge would come from the process doing the
> >> pin_user_pages() rather than say page->memcg_data? Seems reasonable.
> >
> > That is more of a question for you. What is the desired behavior.
> > If charge the current process that perform the pin_user_pages()
> > works for you. Great.
> 
> Argh, if only I had the powers and the desire to commit what worked
> solely for me :-)

I want to learn about your usage case first. Of course others might have
different usage cases in mind. Let's start with yours.

> My current RLIMIT implementation works, but is it's own seperate thing
> and there was a strong and reasonable preference from maintainers to
> have this integrated with memcg.
> 
> But that opens up this whole set of problems around sharing, etc. which
> we need to solve. We didn't want to invent our own set of rules for
> sharing, etc. and changing memcg to support sharing in the way that was
> needed seemed like a massive project.
> 
> However if we tackle that project and resolve the sharing issues for
> memcg then I think adding a pin limit per-memcg shouldn't be so hard.

Ack.

I am consider the first step for smemcg should only include the simple
binary membership relationship. That will simplify things a lot, don't
need to track the per page shared usage count.

However it does not address your requirement of tracking each page
the share usage set. That I haven't figure out a good effective way to
do it. If any one knows, I am curious to know.


> >> >> > 4) unshare/unmmap already charged memory. That will reduce the per <smemcg, memcg>
> >> >> > borrow counter.
> >> >> 
> >> >> Actually this is where things might get a bit tricky for pinning. We'd
> >> >> have to reduce the pin charge when a driver calls put_page(). But that
> >> >> implies looking up the borrow counter / <smemcg, memcg> pair a driver
> >> >> charged the page to.
> >> >
> >> > Does the pin page share between different memcg or just one memcg?
> >> 
> >> In general it can share between different memcg. Consider a shared
> >> mapping shared with processes in two different cgroups (A and B). There
> >> is nothing stopping each process opening a file-descriptor and calling
> >> an ioctl() to pin the shared page.
> >
> > Ack.
> >
> >> Each should be punished for pinning the page in the sense that the pin
> >> count for their respective cgroups must go up.
> >
> > Ack. That clarfy my previous question. You want definition 2)
> 
> I wouldn't say "want" so much as that seemed the quickest/easiest path
> forward without having to fix the problems with support for shared pages
> in memcg.

Ack.

> 
> >> Drivers pinning shared pages is I think relatively rare, but it's
> >> theorectically possible and if we're going down the path of adding
> >> limits for pinning to memcg it's something we need to deal with to make
> >> sandboxing effective.
> >
> > The driver will still have a current processor. Do you mean in this case,
> > the current processor is not the right one to charge?
> > Another option can be charge to a default system/kernel smemcg or a driver
> > smemcg as well.
> 
> It's up to the driver to inform us which process should be
> charged. Potentially it's not current. But my point here was drivers are
> pretty much always pinning pages in private mappings. Hence why we
> thought the trade-off taking a pincg RLIMIT style approach that
> occasionally double charges pages would be fine because dealing with
> pinning a page in a shared mapping was both hard and rare.
> 
> But if we're solving the shared memcg problem that might at least change
> the "hard" bit of that equation.

Ack. The smemcg can start with simple binary membership relationship.
That does not help your pin controller much though.

> >> > If it is shared, can the put_page() API indicate it is performing in behalf
> >> > of which memcg?
> >> 
> >> I think so - although it varies by driver.
> >> 
> >> Drivers have to store the array of pages pinned so should be able to
> >> track the memcg with that as well. My series added a struct vm_account
> >> which would be the obvious place to keep that reference.
> >
> > Where does the struct vm_account lives?
> 
> I am about to send a rebased version of my series, but typically drivers
> keep some kind of per-FD context structure and we keep the vm_account
> there.
> 
> The vm_account holds references to the task_struct/mm_struct/pinscg as
> required.

I will keep an eye out for your patches.

> 
> >> Each set of pin 
> >> operations on a FD would need a new memcg reference though so it would
> >> add overhead for drivers that only pin a small number of pages at a
> >> time.
> >
> > Set is more complicate then allow double counting the same page in the
> > same smemcg. Again mostly just collecting requirement from you.
> 
> Right. Hence why we just went with double counting. I think it would be
> hard to figure out if a particular page is already pinned by a
> particular <memcg, smemcg> or not.

Agree. We can track it, the question is how to do it in a scalable way.
That I don't have a solution I am happy with yet.

Chris


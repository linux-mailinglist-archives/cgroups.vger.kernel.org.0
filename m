Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2D555D6DC
	for <lists+cgroups@lfdr.de>; Tue, 28 Jun 2022 15:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243155AbiF1BiH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Jun 2022 21:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243167AbiF1BiH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Jun 2022 21:38:07 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F53F37;
        Mon, 27 Jun 2022 18:38:05 -0700 (PDT)
Date:   Mon, 27 Jun 2022 18:37:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1656380284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bnAaNZgZKANVKPM3SEWCyp5u9DU/vO+7X8g2xR5xUiY=;
        b=i72uQudC75t/75RctyBHBa64qEJYX7WzxHrnE7y0hEouTMI68SEH+zqn0jSr5qAs0ISGnR
        79ZLPsJ7VaG/cMrtNBCtOohS6DjKp6iZvQJF77BwuNIWFnhP+jAb3O77qJ5w7cEhHToRbq
        Bti5NNeoUtiyx8yp3t/3RuW9+FcXl7Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, longman@redhat.com,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Cgroups <cgroups@vger.kernel.org>, duanxiongchun@bytedance.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v6 00/11] Use obj_cgroup APIs to charge the LRU pages
Message-ID: <Yrpbdk2xVa+B44rK@castle>
References: <20220621125658.64935-1-songmuchun@bytedance.com>
 <CAJD7tkbeTtkMcVri9vzKHATjxAVZfC_vPNfApJiyRxY53c8pZQ@mail.gmail.com>
 <YrlYG0ecJyzFTVVz@FVFYT0MHHV2J.usts.net>
 <CAJD7tkbubDhpJV81qkXqRE5-yvvcjKrtPnZnECenafz+to=3_Q@mail.gmail.com>
 <YrmC3FbUAD74lKq/@FVFYT0MHHV2J.usts.net>
 <YrpYPl1K/k1W30nh@castle>
 <CAJD7tkaOJoZ-8S5RaefDKtD_+aCGVa-RJ3hR23EHOZqT_wf+ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkaOJoZ-8S5RaefDKtD_+aCGVa-RJ3hR23EHOZqT_wf+ew@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jun 27, 2022 at 06:31:14PM -0700, Yosry Ahmed wrote:
> On Mon, Jun 27, 2022 at 6:24 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> >
> > On Mon, Jun 27, 2022 at 06:13:48PM +0800, Muchun Song wrote:
> > > On Mon, Jun 27, 2022 at 01:05:06AM -0700, Yosry Ahmed wrote:
> > > > On Mon, Jun 27, 2022 at 12:11 AM Muchun Song <songmuchun@bytedance.com> wrote:
> > > > >
> > > > > On Sun, Jun 26, 2022 at 03:32:02AM -0700, Yosry Ahmed wrote:
> > > > > > On Tue, Jun 21, 2022 at 5:57 AM Muchun Song <songmuchun@bytedance.com> wrote:
> > > > > > >
> > > > > > > This version is rebased on mm-unstable. Hopefully, Andrew can get this series
> > > > > > > into mm-unstable which will help to determine whether there is a problem or
> > > > > > > degradation. I am also doing some benchmark tests in parallel.
> > > > > > >
> > > > > > > Since the following patchsets applied. All the kernel memory are charged
> > > > > > > with the new APIs of obj_cgroup.
> > > > > > >
> > > > > > >         commit f2fe7b09a52b ("mm: memcg/slab: charge individual slab objects instead of pages")
> > > > > > >         commit b4e0b68fbd9d ("mm: memcontrol: use obj_cgroup APIs to charge kmem pages")
> > > > > > >
> > > > > > > But user memory allocations (LRU pages) pinning memcgs for a long time -
> > > > > > > it exists at a larger scale and is causing recurring problems in the real
> > > > > > > world: page cache doesn't get reclaimed for a long time, or is used by the
> > > > > > > second, third, fourth, ... instance of the same job that was restarted into
> > > > > > > a new cgroup every time. Unreclaimable dying cgroups pile up, waste memory,
> > > > > > > and make page reclaim very inefficient.
> > > > > > >
> > > > > > > We can convert LRU pages and most other raw memcg pins to the objcg direction
> > > > > > > to fix this problem, and then the LRU pages will not pin the memcgs.
> > > > > > >
> > > > > > > This patchset aims to make the LRU pages to drop the reference to memory
> > > > > > > cgroup by using the APIs of obj_cgroup. Finally, we can see that the number
> > > > > > > of the dying cgroups will not increase if we run the following test script.
> > > > > >
> > > > > > This is amazing work!
> > > > > >
> > > > > > Sorry if I came late, I didn't follow the threads of previous versions
> > > > > > so this might be redundant, I just have a couple of questions.
> > > > > >
> > > > > > a) If LRU pages keep getting parented until they reach root_mem_cgroup
> > > > > > (assuming they can), aren't these pages effectively unaccounted at
> > > > > > this point or leaked? Is there protection against this?
> > > > > >
> > > > >
> > > > > In this case, those pages are accounted in root memcg level. Unfortunately,
> > > > > there is no mechanism now to transfer a page's memcg from one to another.
> > > > >
> > > > > > b) Since moving charged pages between memcgs is now becoming easier by
> > > > > > using the APIs of obj_cgroup, I wonder if this opens the door for
> > > > > > future work to transfer charges to memcgs that are actually using
> > > > > > reparented resources. For example, let's say cgroup A reads a few
> > > > > > pages into page cache, and then they are no longer used by cgroup A.
> > > > > > cgroup B, however, is using the same pages that are currently charged
> > > > > > to cgroup A, so it keeps taxing cgroup A for its use. When cgroup A
> > > > > > dies, and these pages are reparented to A's parent, can we possibly
> > > > > > mark these reparented pages (maybe in the page tables somewhere) so
> > > > > > that next time they get accessed we recharge them to B instead
> > > > > > (possibly asynchronously)?
> > > > > > I don't have much experience about page tables but I am pretty sure
> > > > > > they are loaded so maybe there is no room in PTEs for something like
> > > > > > this, but I have always wondered about what we can do for this case
> > > > > > where a cgroup is consistently using memory charged to another cgroup.
> > > > > > Maybe when this memory is reparented is a good point in time to decide
> > > > > > to recharge appropriately. It would also fix the reparenty leak to
> > > > > > root problem (if it even exists).
> > > > > >
> > > > >
> > > > > From my point of view, this is going to be an improvement to the memcg
> > > > > subsystem in the future.  IIUC, most reparented pages are page cache
> > > > > pages without be mapped to users. So page tables are not a suitable
> > > > > place to record this information. However, we already have this information
> > > > > in struct obj_cgroup and struct mem_cgroup. If a page's obj_cgroup is not
> > > > > equal to the page's obj_cgroup->memcg->objcg, it means this page have
> > > > > been reparented. I am thinking if a place where a page is mapped (probably
> > > > > page fault patch) or page (cache) is written (usually vfs write path)
> > > > > is suitable to transfer page's memcg from one to another. But need more
> > > >
> > > > Very good point about unmapped pages, I missed this. Page tables will
> > > > do us no good here. Such a change would indeed require careful thought
> > > > because (like you mentioned) there are multiple points in time where
> > > > it might be suitable to consider recharging the page (e.g. when the
> > > > page is mapped). This could be an incremental change though. Right now
> > > > we have no recharging at all, so maybe we can gradually add recharging
> > > > to suitable paths.
> > > >
> > >
> > > Agree.
> > >
> > > > > thinking, e.g. How to decide if a reparented page needs to be transferred?
> > > >
> > > > Maybe if (page's obj_cgroup->memcg == root_mem_cgroup) OR (memcg of
> > >
> > > This is a good start.
> > >
> > > > current is not a descendant of page's obj_cgroup->memcg) is a good
> > >
> > > I am not sure this one since a page could be shared between different
> > > memcg.
> >
> > No way :)
> 
> No way in terms of charging or usage? AFAIU a page is only charged to
> one memcg, but can be used by multiple memcgs if it exists in the page
> cache for example. Am I missing something here?

Charging of course. I mean we can't realistically precisely account for
shared use of a page between multiple cgroups, at least not at 4k granularity.

> 
> >
> > >
> > >     root
> > >    /   \
> > >   A     B
> > >  / \     \
> > > C   E     D
> > >
> > > e.g. a page (originally, it belongs to memcg E and E is dying) is reparented
> > > to memcg A, and it is shared between C and D now. Then we need to consider
> > > whether it should be recharged. Yep, we need more thinging about recharging.
> >
> > This is why I wasn't sure that objcg-based reparenting is the best approach.
> > Instead (or maybe even _with_ the reparenting) we can recharge pages on, say,
> > page activation and/or rotation (inactive->inactive). Pagefaults/reads are
> > probably to hot to do it there. But the reclaim path should be more accessible
> > in terms of the performance overhead. Just some ideas.
> 
> Thanks for chipping in, Roman! I am honestly not sure on what paths
> the recharge should occur, but I know that we will probably need a
> recharge mechanism at some point. We can start adding recharging
> gradually to paths that don't affect performance, reclaim is a very
> good place. Maybe we sort LRUs such that reparented pages are scanned
> first, and possibly recharged under memcg pressure.

I think the activation path is a good place to start because we know for sure
that a page is actively used and we know who is using it.

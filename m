Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542CD52AC3B
	for <lists+cgroups@lfdr.de>; Tue, 17 May 2022 21:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352869AbiEQTth (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 May 2022 15:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352842AbiEQTtb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 May 2022 15:49:31 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8D337BEE
        for <cgroups@vger.kernel.org>; Tue, 17 May 2022 12:49:27 -0700 (PDT)
Date:   Tue, 17 May 2022 12:49:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1652816965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x8/m9pscXPgMWqwVWzgRqqeaN2wYNV2F67Ox50pe6iM=;
        b=psFhQoJLE7MdaiV9+WY6i5QU/Xwo5a7aV7ktDmG6bzyzZeXvnowsdD/EFpM27O7tmQnPzO
        0cpxA74+TmCocE7a1kXBo429A5S+bZBG4HwLJHfTwK4rHK9zpL+dRIRIe1hJV2CSRSFh8O
        0hx6nxqFTSoSvdF9CoiNZGm1n9I3vNk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Yu Zhao <yuzhao@google.com>, Wei Xu <weixugc@google.com>,
        Greg Thelen <gthelen@google.com>,
        Chen Wandun <chenwandun@huawei.com>
Subject: Re: [RFC] Add swappiness argument to memory.reclaim
Message-ID: <YoP8P7hzXIyogQ68@carbon>
References: <CAJD7tkbDpyoODveCsnaqBBMZEkDvshXJmNdbk51yKSNgD7aGdg@mail.gmail.com>
 <YoPHtHXzpK51F/1Z@carbon>
 <CAJD7tkbbiP0RusWBdCvozjauKN-vhgvzWtsL3Hu5y2dLr63idQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkbbiP0RusWBdCvozjauKN-vhgvzWtsL3Hu5y2dLr63idQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 17, 2022 at 11:13:10AM -0700, Yosry Ahmed wrote:
> On Tue, May 17, 2022 at 9:05 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> >
> > On Mon, May 16, 2022 at 03:29:42PM -0700, Yosry Ahmed wrote:
> > > The discussions on the patch series [1] to add memory.reclaim has
> > > shown that it is desirable to add an argument to control the type of
> > > memory being reclaimed by invoked proactive reclaim using
> > > memory.reclaim.
> > >
> > > I am proposing adding a swappiness optional argument to the interface.
> > > If set, it overwrites vm.swappiness and per-memcg swappiness. This
> > > provides a way to enforce user policy on a stateless per-reclaim
> > > basis. We can make policy decisions to perform reclaim differently for
> > > tasks of different app classes based on their individual QoS needs. It
> > > also helps for use cases when particularly page cache is high and we
> > > want to mainly hit that without swapping out.
> > >
> > > The interface would be something like this (utilizing the nested-keyed
> > > interface we documented earlier):
> > >
> > > $ echo "200M swappiness=30" > memory.reclaim
> >
> > What are the anticipated use cases except swappiness == 0 and
> > swappiness == system_default?
> >
> > IMO it's better to allow specifying the type of memory to reclaim,
> > e.g. type="file"/"anon"/"slab", it's a way more clear what to expect.
> 
> I imagined swappiness would give user space flexibility to reclaim a
> ratio of file vs. anon as it sees fit based on app class or userspace
> policy, but I agree that the guarantees of swappiness are weak and we
> might want an explicit argument that directly controls the return
> value of get_scan_count() or whether or not we call shrink_slab(). My
> fear is that this interface may be less flexible, for example if we
> only want to avoid reclaiming file pages, but we are fine with anon or
> slab.
> Maybe in the future we will have a new type of memory to
> reclaim, does it get implicitly reclaimed when other types are
> specified or not?
> 
> Maybe we can use one argument per type instead? E.g.
>     $ echo "200M file=no anon=yes slab=yes" > memory.reclaim
> 
> The default value would be "yes" for all types unless stated
> otherwise. This is also leaves room for future extensions (maybe
> file=clean to reclaim clean file pages only?). Interested to hear your
> thoughts on this!

The question to answer is do you want the code which is determining
the balance of scanning be a part of the interface?

If not, I'd stick with explicitly specifying a type of memory to scan
(and the "I don't care" mode, where you simply ask to reclaim X bytes).

Otherwise you need to describe how the artificial memory pressure will
be distributed over different memory types. And with time it might
start being significantly different to what the generic reclaim code does,
because the reclaim path is free to do what's better, there are no
user-visible guarantees.

> 
> >
> > E.g. what
> > $ echo "200M swappiness=1" > memory.reclaim
> > means if there is only 10M of pagecache? How much of anon memory will
> > be reclaimed?
> 
> Good point. I agree that the type argument or per-type arguments have
> multiple advantages over swappiness.

If a user wants to select multiple types of memory, can they just run several
requests in parallel? Or one by one?

Thanks!

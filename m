Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D145B52ACF2
	for <lists+cgroups@lfdr.de>; Tue, 17 May 2022 22:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347957AbiEQUpy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 May 2022 16:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351440AbiEQUpw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 May 2022 16:45:52 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B718315FC3
        for <cgroups@vger.kernel.org>; Tue, 17 May 2022 13:45:50 -0700 (PDT)
Date:   Tue, 17 May 2022 13:45:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1652820349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Em8NsZUR8JQ7Gugh2/gtd6noWd4WuWBv2BitYZODNhk=;
        b=gzIje8V5/YcreFfY/XovYcV9/bRe+Q+bz7ix4NVeJbUGrDDGGKXA6P1dVzhpOYec180+j1
        687rvJUDXF+QWBXpMR9zbz3liFxyDGztBFNH/KvWQ5pdpm0KVoHYUpWWXSrliTCmmhEmtG
        Uj3MXGL4v/J5MCUfWT6Ey4xVnycj/4w=
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
Message-ID: <YoQJdoqh7/S0FI7a@carbon>
References: <CAJD7tkbDpyoODveCsnaqBBMZEkDvshXJmNdbk51yKSNgD7aGdg@mail.gmail.com>
 <YoPHtHXzpK51F/1Z@carbon>
 <CAJD7tkbbiP0RusWBdCvozjauKN-vhgvzWtsL3Hu5y2dLr63idQ@mail.gmail.com>
 <YoP8P7hzXIyogQ68@carbon>
 <CAJD7tkaPWcFyisv3Kso0AFUGkQiiAiFmsV2R3ZU2SNc4XP8v+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkaPWcFyisv3Kso0AFUGkQiiAiFmsV2R3ZU2SNc4XP8v+w@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 17, 2022 at 01:11:13PM -0700, Yosry Ahmed wrote:
> On Tue, May 17, 2022 at 12:49 PM Roman Gushchin
> <roman.gushchin@linux.dev> wrote:
> >
> > On Tue, May 17, 2022 at 11:13:10AM -0700, Yosry Ahmed wrote:
> > > On Tue, May 17, 2022 at 9:05 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> > > >
> > > > On Mon, May 16, 2022 at 03:29:42PM -0700, Yosry Ahmed wrote:
> > > > > The discussions on the patch series [1] to add memory.reclaim has
> > > > > shown that it is desirable to add an argument to control the type of
> > > > > memory being reclaimed by invoked proactive reclaim using
> > > > > memory.reclaim.
> > > > >
> > > > > I am proposing adding a swappiness optional argument to the interface.
> > > > > If set, it overwrites vm.swappiness and per-memcg swappiness. This
> > > > > provides a way to enforce user policy on a stateless per-reclaim
> > > > > basis. We can make policy decisions to perform reclaim differently for
> > > > > tasks of different app classes based on their individual QoS needs. It
> > > > > also helps for use cases when particularly page cache is high and we
> > > > > want to mainly hit that without swapping out.
> > > > >
> > > > > The interface would be something like this (utilizing the nested-keyed
> > > > > interface we documented earlier):
> > > > >
> > > > > $ echo "200M swappiness=30" > memory.reclaim
> > > >
> > > > What are the anticipated use cases except swappiness == 0 and
> > > > swappiness == system_default?
> > > >
> > > > IMO it's better to allow specifying the type of memory to reclaim,
> > > > e.g. type="file"/"anon"/"slab", it's a way more clear what to expect.
> > >
> > > I imagined swappiness would give user space flexibility to reclaim a
> > > ratio of file vs. anon as it sees fit based on app class or userspace
> > > policy, but I agree that the guarantees of swappiness are weak and we
> > > might want an explicit argument that directly controls the return
> > > value of get_scan_count() or whether or not we call shrink_slab(). My
> > > fear is that this interface may be less flexible, for example if we
> > > only want to avoid reclaiming file pages, but we are fine with anon or
> > > slab.
> > > Maybe in the future we will have a new type of memory to
> > > reclaim, does it get implicitly reclaimed when other types are
> > > specified or not?
> > >
> > > Maybe we can use one argument per type instead? E.g.
> > >     $ echo "200M file=no anon=yes slab=yes" > memory.reclaim
> > >
> > > The default value would be "yes" for all types unless stated
> > > otherwise. This is also leaves room for future extensions (maybe
> > > file=clean to reclaim clean file pages only?). Interested to hear your
> > > thoughts on this!
> >
> > The question to answer is do you want the code which is determining
> > the balance of scanning be a part of the interface?
> >
> > If not, I'd stick with explicitly specifying a type of memory to scan
> > (and the "I don't care" mode, where you simply ask to reclaim X bytes).
> >
> > Otherwise you need to describe how the artificial memory pressure will
> > be distributed over different memory types. And with time it might
> > start being significantly different to what the generic reclaim code does,
> > because the reclaim path is free to do what's better, there are no
> > user-visible guarantees.
> 
> My understanding is that your question is about the swappiness
> argument, and I agree it can get complicated. I am on board with
> explicitly specifying the type(s) to reclaim. I think an interface
> with one argument per type (whitelist/blacklist approach) could be
> more flexible in specifying multiple types per invocation (smaller
> race window between reading usages and writing to memory.reclaim), and
> has room for future extensions (e.g. file=clean). However, if you
> still think a type=file/anon/slab parameter is better we can also go
> with this.

If you allow more than one type, how would you balance between them?
E.g. in your example:
     $ echo "200M file=no anon=yes slab=yes" > memory.reclaim
How much slab and anonymous memory will be reclaimed? 100M and 100M?
Probably not (we don't balance slabs with other types of the memory).
And if not, the interface becomes very vague: all we can guarantee
is that *some* pressure will be applied on both anon and slab.

My point is that the interface should have a deterministic behavior
and not rely on the current state of the memory pressure balancing
heuristic. It can be likely done in different ways, I don't have
a strong opinion here.

Thanks!

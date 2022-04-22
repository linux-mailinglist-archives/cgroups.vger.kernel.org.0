Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FCF50BB09
	for <lists+cgroups@lfdr.de>; Fri, 22 Apr 2022 17:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449108AbiDVPEZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Apr 2022 11:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449136AbiDVPDp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Apr 2022 11:03:45 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8135C84C;
        Fri, 22 Apr 2022 08:00:46 -0700 (PDT)
Date:   Fri, 22 Apr 2022 08:00:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650639644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d3IirLrwzfP+t0cf/Qt/pjPqRe913cYQABamRgMemA8=;
        b=Lm54JO89yEThLSIOPkqiO6LOVwh/7ZwT7BCwz0zLcI/aXxl9HFRy2wt5mfdfSbbE+e+BYB
        bQyb0q49de7JTreNY6cN9UX4H5WWDQWzNEHLbyyXbGLILRdK/dSOz1lUkEN4UbqazIhnP8
        3DvXNVVjpOLYzc3+lxM/e73OuXDStK4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/memcg: Free percpu stats memory of dying memcg's
Message-ID: <YmLDF58Mz3inl9Ev@carbon>
References: <20220421145845.1044652-1-longman@redhat.com>
 <YmGHYNuAp8957ouq@carbon>
 <112a4d7f-bc53-6e59-7bb8-6fecb65d045d@redhat.com>
 <YmGbmrH/Hg1VJlUc@carbon>
 <58c41f14-356e-88dd-54aa-dc6873bf80ff@redhat.com>
 <YmIZ9Lpvx5pY3oTV@carbon>
 <YmKDCjJFYMmfa8sG@FVFYT0MHHV2J.usts.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmKDCjJFYMmfa8sG@FVFYT0MHHV2J.usts.net>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 22, 2022 at 06:27:22PM +0800, Muchun Song wrote:
> On Thu, Apr 21, 2022 at 07:59:00PM -0700, Roman Gushchin wrote:
> > On Thu, Apr 21, 2022 at 02:46:00PM -0400, Waiman Long wrote:
> > > On 4/21/22 13:59, Roman Gushchin wrote:
> > > > On Thu, Apr 21, 2022 at 01:28:20PM -0400, Waiman Long wrote:
> > > > > On 4/21/22 12:33, Roman Gushchin wrote:
> > > > > > On Thu, Apr 21, 2022 at 10:58:45AM -0400, Waiman Long wrote:
> > > > > > > For systems with large number of CPUs, the majority of the memory
> > > > > > > consumed by the mem_cgroup structure is actually the percpu stats
> > > > > > > memory. When a large number of memory cgroups are continuously created
> > > > > > > and destroyed (like in a container host), it is possible that more
> > > > > > > and more mem_cgroup structures remained in the dying state holding up
> > > > > > > increasing amount of percpu memory.
> > > > > > > 
> > > > > > > We can't free up the memory of the dying mem_cgroup structure due to
> > > > > > > active references in some other places. However, the percpu stats memory
> > > > > > > allocated to that mem_cgroup is a different story.
> > > > > > > 
> > > > > > > This patch adds a new percpu_stats_disabled variable to keep track of
> > > > > > > the state of the percpu stats memory. If the variable is set, percpu
> > > > > > > stats update will be disabled for that particular memcg. All the stats
> > > > > > > update will be forward to its parent instead. Reading of the its percpu
> > > > > > > stats will return 0.
> > > > > > > 
> > > > > > > The flushing and freeing of the percpu stats memory is a multi-step
> > > > > > > process. The percpu_stats_disabled variable is set when the memcg is
> > > > > > > being set to offline state. After a grace period with the help of RCU,
> > > > > > > the percpu stats data are flushed and then freed.
> > > > > > > 
> > > > > > > This will greatly reduce the amount of memory held up by dying memory
> > > > > > > cgroups.
> > > > > > > 
> > > > > > > By running a simple management tool for container 2000 times per test
> > > > > > > run, below are the results of increases of percpu memory (as reported
> > > > > > > in /proc/meminfo) and nr_dying_descendants in root's cgroup.stat.
> > > > > > Hi Waiman!
> > > > > > 
> > > > > > I've been proposing the same idea some time ago:
> > > > > > https://lore.kernel.org/all/20190312223404.28665-7-guro@fb.com/T/ .
> > > > > > 
> > > > > > However I dropped it with the thinking that with many other fixes
> > > > > > preventing the accumulation of the dying cgroups it's not worth the added
> > > > > > complexity and a potential cpu overhead.
> > > > > > 
> > > > > > I think it ultimately comes to the number of dying cgroups. If it's low,
> > > > > > memory savings are not worth the cpu overhead. If it's high, they are.
> > > > > > I hope long-term to drive it down significantly (with lru-pages reparenting
> > > > > > being the first major milestone), but it might take a while.
> > > > > > 
> > > > > > I don't have a strong opinion either way, just want to dump my thoughts
> > > > > > on this.
> > > > > I have quite a number of customer cases complaining about increasing percpu
> > > > > memory usages. The number of dying memcg's can go to tens of thousands. From
> > > > > my own investigation, I believe that those dying memcg's are not freed
> > > > > because they are pinned down by references in the page structure. I am aware
> > > > > that we support the use of objcg in the page structure which will allow easy
> > > > > reparenting, but most pages don't do that and it is not easy to do this
> > > > > conversion and it may take quite a while to do that.
> > > > The big question is whether there is a memory pressure on those systems.
> > > > If yes, and the number of dying cgroups is growing, it's worth investigating.
> > > > It might be due to the sharing of pagecache pages and this will be ultimately
> > > > fixed with implementing of the pagecache reparenting. But it also might be due
> > > > to other bugs, which are fixable, so it would be great to understand.
> > > 
> > > 
> > > Pagecache reparenting will probably fix the problem that I have seen. Is
> > > someone working on this?
> > 
> > Some time ago Muchun posted patches based on the reusing of the obj_cgroup API.
> >
> 
> Yep. It is here:
> 
> https://lore.kernel.org/all/20220216115132.52602-1-songmuchun@bytedance.com/.
>  
> > I'm not strictly against this approach, but in my opinion it's not the best.
> > I suggested to use lru vectors as an intermediate objects. In theory, it might
> 
> I remember this.
> 
> > allow to avoid bumping reference counters for all charged pages at all: live
> > cgroups will be protected by being live, dying cgroups will only need
> > a temporarily protection while lru vectors and associated pages are reparenting.
> > 
> > There are pros and cons:
> > + cgroup reference counting becomes simpler and more debuggable
> > + potential perf wins from fewer operations with live cgroups css refcounters
> > = I hope to see code simplifications (but not guaranteed)
> > - deleting cgroups becomes more expensive, but the cost can be spread to
> >   asynchronous workers
> > 
> > Idk if Muchun tried to implement it. If not, I might try myself.
> >
> 
> Yep. I have implemented a initial version recently. I'll do some stability tests
> and send it out ASAP.

Great! Looking forward to see it! And thank you for working on it!

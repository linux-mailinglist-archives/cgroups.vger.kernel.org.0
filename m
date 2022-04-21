Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7212E50A7A2
	for <lists+cgroups@lfdr.de>; Thu, 21 Apr 2022 20:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350276AbiDUSC7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Apr 2022 14:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391215AbiDUSCx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Apr 2022 14:02:53 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E39BE29;
        Thu, 21 Apr 2022 11:00:02 -0700 (PDT)
Date:   Thu, 21 Apr 2022 10:59:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650564000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k9KJFoROadhQEi217HirEqtdLkXBsecvLOO9CIt2GKE=;
        b=GU+fP14UtB62v1iOUhU2TiO8Tiqpbg/dnJjCrtcQl6Lp7MGa9EyUFAlQNpj0j1rTfbFAmr
        ZVJv/GJLYHVIE9+l0NHbkjyOMoQcQZHPDxoCBeMOaIczAgyyq/bilbi/9kSuTEsDEFBj4C
        foH+6WlVvovyemQkAHrZ6cVl9IVCKWo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/memcg: Free percpu stats memory of dying memcg's
Message-ID: <YmGbmrH/Hg1VJlUc@carbon>
References: <20220421145845.1044652-1-longman@redhat.com>
 <YmGHYNuAp8957ouq@carbon>
 <112a4d7f-bc53-6e59-7bb8-6fecb65d045d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <112a4d7f-bc53-6e59-7bb8-6fecb65d045d@redhat.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 21, 2022 at 01:28:20PM -0400, Waiman Long wrote:
> 
> On 4/21/22 12:33, Roman Gushchin wrote:
> > On Thu, Apr 21, 2022 at 10:58:45AM -0400, Waiman Long wrote:
> > > For systems with large number of CPUs, the majority of the memory
> > > consumed by the mem_cgroup structure is actually the percpu stats
> > > memory. When a large number of memory cgroups are continuously created
> > > and destroyed (like in a container host), it is possible that more
> > > and more mem_cgroup structures remained in the dying state holding up
> > > increasing amount of percpu memory.
> > > 
> > > We can't free up the memory of the dying mem_cgroup structure due to
> > > active references in some other places. However, the percpu stats memory
> > > allocated to that mem_cgroup is a different story.
> > > 
> > > This patch adds a new percpu_stats_disabled variable to keep track of
> > > the state of the percpu stats memory. If the variable is set, percpu
> > > stats update will be disabled for that particular memcg. All the stats
> > > update will be forward to its parent instead. Reading of the its percpu
> > > stats will return 0.
> > > 
> > > The flushing and freeing of the percpu stats memory is a multi-step
> > > process. The percpu_stats_disabled variable is set when the memcg is
> > > being set to offline state. After a grace period with the help of RCU,
> > > the percpu stats data are flushed and then freed.
> > > 
> > > This will greatly reduce the amount of memory held up by dying memory
> > > cgroups.
> > > 
> > > By running a simple management tool for container 2000 times per test
> > > run, below are the results of increases of percpu memory (as reported
> > > in /proc/meminfo) and nr_dying_descendants in root's cgroup.stat.
> > Hi Waiman!
> > 
> > I've been proposing the same idea some time ago:
> > https://lore.kernel.org/all/20190312223404.28665-7-guro@fb.com/T/ .
> > 
> > However I dropped it with the thinking that with many other fixes
> > preventing the accumulation of the dying cgroups it's not worth the added
> > complexity and a potential cpu overhead.
> > 
> > I think it ultimately comes to the number of dying cgroups. If it's low,
> > memory savings are not worth the cpu overhead. If it's high, they are.
> > I hope long-term to drive it down significantly (with lru-pages reparenting
> > being the first major milestone), but it might take a while.
> > 
> > I don't have a strong opinion either way, just want to dump my thoughts
> > on this.
> 
> I have quite a number of customer cases complaining about increasing percpu
> memory usages. The number of dying memcg's can go to tens of thousands. From
> my own investigation, I believe that those dying memcg's are not freed
> because they are pinned down by references in the page structure. I am aware
> that we support the use of objcg in the page structure which will allow easy
> reparenting, but most pages don't do that and it is not easy to do this
> conversion and it may take quite a while to do that.

The big question is whether there is a memory pressure on those systems.
If yes, and the number of dying cgroups is growing, it's worth investigating.
It might be due to the sharing of pagecache pages and this will be ultimately
fixed with implementing of the pagecache reparenting. But it also might be due
to other bugs, which are fixable, so it would be great to understand.

So if there is a memory pressure and dying cgroups are still accumulating,
we need to investigate and fix it.

If there is (almost) no memory pressure, it's a proactive reclaim question.
There are several discussions and projects going on in this area.

Releasing percpu memory is more a workaround of the problem rather than fix.
In the end, if we're accumulating dying cgroups, we're still leaking memory,
just at a smaller pace (which is good, of course).

Thanks!

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4322FA0E9
	for <lists+cgroups@lfdr.de>; Mon, 18 Jan 2021 14:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392062AbhARNNK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Jan 2021 08:13:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:38878 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391961AbhARNNH (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 18 Jan 2021 08:13:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610975540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2HWlEcvjoTMsI47i3B2eDVwrEWOw9JoCLpGemiNPf30=;
        b=WRI2Tg5vF8LWLchV6CyUa6ivZgv/GZ8dICb27aHO7w65YYVBVTsSCslltgUdJL+5iSUSY3
        q3FLiSeOueIALl6QC9t2JrZVeaylnKbjNcKK2h5TXpo0xEyqGu3vB46UNAw6PAJ1uQU2tS
        rvY30do+2Sn34TtauQe67VRF6eknetE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 92D72ACBA;
        Mon, 18 Jan 2021 13:12:20 +0000 (UTC)
Date:   Mon, 18 Jan 2021 14:12:19 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: prevent starvation when writing
 memory.high
Message-ID: <20210118131219.GD14336@dhcp22.suse.cz>
References: <20210112163011.127833-1-hannes@cmpxchg.org>
 <20210113144654.GD22493@dhcp22.suse.cz>
 <YAHA4uBSLlnxxAbu@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAHA4uBSLlnxxAbu@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 15-01-21 11:20:50, Johannes Weiner wrote:
> On Wed, Jan 13, 2021 at 03:46:54PM +0100, Michal Hocko wrote:
> > On Tue 12-01-21 11:30:11, Johannes Weiner wrote:
> > > When a value is written to a cgroup's memory.high control file, the
> > > write() context first tries to reclaim the cgroup to size before
> > > putting the limit in place for the workload. Concurrent charges from
> > > the workload can keep such a write() looping in reclaim indefinitely.
> > > 
> > > In the past, a write to memory.high would first put the limit in place
> > > for the workload, then do targeted reclaim until the new limit has
> > > been met - similar to how we do it for memory.max. This wasn't prone
> > > to the described starvation issue. However, this sequence could cause
> > > excessive latencies in the workload, when allocating threads could be
> > > put into long penalty sleeps on the sudden memory.high overage created
> > > by the write(), before that had a chance to work it off.
> > > 
> > > Now that memory_high_write() performs reclaim before enforcing the new
> > > limit, reflect that the cgroup may well fail to converge due to
> > > concurrent workload activity. Bail out of the loop after a few tries.
> > 
> > I can see that you have provided some more details in follow up replies
> > but I do not see any explicit argument why an excessive time for writer
> > is an actual problem. Could you be more specific?
> 
> Our writer isn't necessarily time sensitive, but there is a difference
> between a) the write taking a few seconds to reclaim down the
> requested delta and b) the writer essentially turning into kswapd for
> the workload and busy-spinning inside the kernel indefinitely.
> 
> We've seen the writer stuck in this function for minutes, long after
> the requested delta has been reclaimed, consuming alarming amounts of
> CPU cycles - CPU time that should really be accounted to the workload,
> not the system software performing the write.

OK, this is an important detail. So the context which is doing the work
doesn't belong to the target memcg? If that is the case then I do
understand why you consider it a problem. In general I would recommend
running operations like this one in scope of the affected cgroup. But
maybe that is not really an option in your setup.

Anyway this is an important information to have in the changelog.

> Obviously, we could work around it using timeouts and signals. In
> fact, we may have to until the new kernel is deployed everywhere. But
> this is the definition of an interface change breaking userspace, so
> I'm a bit surprised by your laid-back response.

Well, I was basing my feedback on the available information in the
changelog. It is quite clear that somebody has to pay for the work.
Moving as much of the work to the writer makes sense as long as the
context is runing in the same cgroup so the work gets accounted
properly. If this assumption doesn't match the reality then we have to
re-evaluate our priorities here.

> > > Fixes: 536d3bf261a2 ("mm: memcontrol: avoid workload stalls when lowering memory.high")
> > > Cc: <stable@vger.kernel.org> # 5.8+
> > 
> > Why is this worth backporting to stable? The behavior is different but I
> > do not think any of them is harmful.
> 
> The referenced patch changed user-visible behavior in a way that is
> causing real production problems for us. From stable-kernel-rules:
> 
>  - It must fix a real bug that bothers people (not a, "This could be a
>    problem..." type thing).
> 
> > > Reported-by: Tejun Heo <tj@kernel.org>
> > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > 
> > I am not against the patch. The existing interface doesn't provide any
> > meaningful feedback to the userspace anyway. User would have to re check
> > to see the result of the operation. So how hard we try is really an
> > implementation detail.
> 
> Yeah, I wish it was a bit more consistent from an interface POV.
> 
> Btw, if you have noticed, Roman's patch to enforce memcg->high *after*
> trying to reclaim went into the tree at the same exact time as Chris's
> series "mm, memcg: reclaim harder before high throttling" (commit
> b3ff92916af3b458712110bb83976a23471c12fa). It's likely they overlap.
> 
> Chris's patch changes memory.high reclaim on the allocation side from
> 
> 	reclaim once, sleep if there is still overage
> 
> to
> 
> 	reclaim the overage as long as you make forward progress;
> 	sleep after 16 no-progress loops if there is still overage
> 
> Roman's patch describes a problem where allocating threads go to sleep
> when memory.high is lowered by a wider step. This is exceedingly
> unlikely after Chris's change.
> 
> Because after Chris's change, memory.high is reclaimed on the
> allocation side as aggressively as memory.max. The only difference is
> that upon failure, one sleeps and the other OOMs.
> 
> If Roman's issue were present after Chris's change, then we'd also see
> premature OOM kills when memory.max is lowered by a large step. And I
> have never seen that happening.

This should be something quite easy to double check right?

> So I suggest instead of my fix here, we revert Roman's patch instead,
> as it should no longer be needed. Thoughts?

Reverting 536d3bf261a2 ("mm: memcontrol: avoid workload stalls when
lowering memory.high") would certainly help to throttle producers but it
still doesn't solve the underlying problem that a lot of work could be
done in a context which lives outside of the memcg, right? The effect
would be much smaller and it shouldn't be effectivelly unbounded but
still something we should think about.

That being said going with the revert sounds like a slightly better
approach to me.
-- 
Michal Hocko
SUSE Labs

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4983F358277
	for <lists+cgroups@lfdr.de>; Thu,  8 Apr 2021 13:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhDHLwr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Apr 2021 07:52:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:47882 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231244AbhDHLwr (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 8 Apr 2021 07:52:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617882754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Vxf/Rtqoq9cSHpyTLbA+D/Tz1bK6eTu2aX5QUqZu3s=;
        b=byyTyOdY+AS9gT2WSkbCuGKS135Due4isvhpfxgM4HuYBanvO/ML3RrZ/mPrT+DV0wAtu9
        aaqsWKNPcs/YgwjJLv8d5LxDyIGAhS7dryABfKL86abWEO49l1n2HadFwVXL+Cvn4ovBYI
        7kc5ho0cbjGcBg6cxziVvRTCA8pJDtw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D197BB090;
        Thu,  8 Apr 2021 11:52:33 +0000 (UTC)
Date:   Thu, 8 Apr 2021 13:52:33 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 00/11] Manage the top tier memory in a tiered
 memory
Message-ID: <YG7ugXZZ9BcXyGGk@dhcp22.suse.cz>
References: <cover.1617642417.git.tim.c.chen@linux.intel.com>
 <YGwlGrHtDJPQF7UG@dhcp22.suse.cz>
 <c615a610-eb4b-7e1e-16d1-4bc12938b08a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c615a610-eb4b-7e1e-16d1-4bc12938b08a@linux.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 07-04-21 15:33:26, Tim Chen wrote:
> 
> 
> On 4/6/21 2:08 AM, Michal Hocko wrote:
> > On Mon 05-04-21 10:08:24, Tim Chen wrote:
> > [...]
> >> To make fine grain cgroup based management of the precious top tier
> >> DRAM memory possible, this patchset adds a few new features:
> >> 1. Provides memory monitors on the amount of top tier memory used per cgroup 
> >>    and by the system as a whole.
> >> 2. Applies soft limits on the top tier memory each cgroup uses 
> >> 3. Enables kswapd to demote top tier pages from cgroup with excess top
> >>    tier memory usages.
> > 
> 
> Michal,
> 
> Thanks for giving your feedback.  Much appreciated.
> 
> > Could you be more specific on how this interface is supposed to be used?
> 
> We created a README section on the cgroup control part of this patchset:
> https://git.kernel.org/pub/scm/linux/kernel/git/vishal/tiering.git/commit/?h=tiering-0.71&id=20f20be02671384470c7cd8f66b56a9061a4071f
> to illustrate how this interface should be used.

I have to confess I didn't get to look at demotion patches yet.

> The top tier memory used is reported in
> 
> memory.toptier_usage_in_bytes
> 
> The amount of top tier memory usable by each cgroup without
> triggering page reclaim is controlled by the
> 
> memory.toptier_soft_limit_in_bytes 

Are you trying to say that soft limit acts as some sort of guarantee?
Does that mean that if the memcg is under memory pressure top tiear
memory is opted out from any reclaim if the usage is not in excess?

From you previous email it sounds more like the limit is evaluated on
the global memory pressure to balance specific memcgs which are in
excess when trying to reclaim/demote a toptier numa node.

Soft limit reclaim has several problems. Those are historical and
therefore the behavior cannot be changed. E.g. go after the biggest
excessed memcg (with priority 0 - aka potential full LRU scan) and then
continue with a normal reclaim. This can be really disruptive to the top
user.

So you can likely define a more sane semantic. E.g. push back memcgs
proporitional to their excess but then we have two different soft limits
behavior which is bad as well. I am not really sure there is a sensible
way out by (ab)using soft limit here.

Also I am not really sure how this is going to be used in practice.
There is no soft limit by default. So opting in would effectivelly
discriminate those memcgs. There has been a similar problem with the
soft limit we have in general. Is this really what you are looing for?
What would be a typical usecase?

[...]
> >> The patchset is based on cgroup v1 interface. One shortcoming of the v1
> >> interface is the limit on the cgroup is a soft limit, so a cgroup can
> >> exceed the limit quite a bit before reclaim before page demotion reins
> >> it in. 
> > 
> > I have to say that I dislike abusing soft limit reclaim for this. In the
> > past we have learned that the existing implementation is unfixable and
> > changing the existing semantic impossible due to backward compatibility.
> > So I would really prefer the soft limit just find its rest rather than
> > see new potential usecases.
> 
> Do you think we can reuse some of the existing soft reclaim machinery
> for the v2 interface?
> 
> More particularly, can we treat memory_toptier.high in cgroup v2 as a soft limit?

No, you should follow existing limits semantics. High limit acts as a
allocation throttling interface.

> We sort how much each mem cgroup exceeds memory_toptier.high and
> go after the cgroup that have largest excess first for page demotion.
> Will appreciate if you can shed some insights on what could go wrong
> with such an approach. 

This cannot work as a thorttling interface.
 
> > I haven't really looked into details of this patchset but from a cursory
> > look it seems like you are actually introducing a NUMA aware limits into
> > memcg that would control consumption from some nodes differently than
> > other nodes. This would be rather alien concept to the existing memcg
> > infrastructure IMO. It looks like it is fusing borders between memcg and
> > cputset controllers.
> 
> Want to make sure I understand what you mean by NUMA aware limits.
> Yes, in the patch set, it does treat the NUMA nodes differently.
> We are putting constraint on the "top tier" RAM nodes vs the lower
> tier PMEM nodes.  Is this what you mean?

What I am trying to say (and I have brought that up when demotion has been
discussed at LSFMM) is that the implementation shouldn't be PMEM aware.
The specific technology shouldn't be imprinted into the interface.
Fundamentally you are trying to balance memory among NUMA nodes as we do
not have other abstraction to use. So rather than talking about top,
secondary, nth tier we have different NUMA nodes with different
characteristics and you want to express your "priorities" for them.

> I can see it does has
> some flavor of cpuset controller.  In this case, it doesn't explicitly
> set a node as allowed or forbidden as in cpuset, but put some constraints
> on the usage of a group of nodes.  
> 
> Do you have suggestions on alternative controller for allocating tiered memory resource?
 
I am not really sure what would be the best interface to be honest.
Maybe we want to carve this into memcg in some form of node priorities
for the reclaim. Any of the existing limits is numa aware so far. Maybe
we want to say hammer this node more than others if there is a memory
pressure. Not sure that would help you particular usecase though.

> > You also seem to be basing the interface on the very specific usecase.
> > Can we expect that there will be many different tiers requiring their
> > own balancing?
> > 
> 
> You mean more than two tiers of memory? We did think a bit about system
> that has stuff like high bandwidth memory that's faster than DRAM.
> Our thought is usage and freeing of those memory will require 
> explicit assignment (not used by default), so will be outside the
> realm of auto balancing.  So at this point, we think two tiers will be good.

Please keep in mind that once there is an interface it will be
impossible to change in the future. So do not bind yourself to the 2
tier setups that you have in hands right now.

-- 
Michal Hocko
SUSE Labs

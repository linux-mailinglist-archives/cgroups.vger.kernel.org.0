Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890A335DA25
	for <lists+cgroups@lfdr.de>; Tue, 13 Apr 2021 10:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243030AbhDMId5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Apr 2021 04:33:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:37656 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243002AbhDMIdv (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 13 Apr 2021 04:33:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618302811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xqtPjR7YPu3QtWRhej9VtvpTC9wUcZOleE8LJV9ZstU=;
        b=gW6C57kRMYh9tnigP4Yod/k2tcJ22/aMy7THV74MfzMBT9OXrTXUYhLOLjyoxJAeYbBTzC
        ktScc275SZcMd1IxnU5F2nBI3e72PAIoWqNLVXVrRF4tJcuKDnx2R9OC4d2TBrbub8S4fB
        +8LuK7iOS1fkZgxxxWrF+QdgiW40fKA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0D83DB125;
        Tue, 13 Apr 2021 08:33:31 +0000 (UTC)
Date:   Tue, 13 Apr 2021 10:33:30 +0200
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
Message-ID: <YHVXWu4aG/X+W7q2@dhcp22.suse.cz>
References: <cover.1617642417.git.tim.c.chen@linux.intel.com>
 <YGwlGrHtDJPQF7UG@dhcp22.suse.cz>
 <c615a610-eb4b-7e1e-16d1-4bc12938b08a@linux.intel.com>
 <YG7ugXZZ9BcXyGGk@dhcp22.suse.cz>
 <58e5dcc9-c134-78de-6965-7980f8596b57@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58e5dcc9-c134-78de-6965-7980f8596b57@linux.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 09-04-21 16:26:53, Tim Chen wrote:
> 
> On 4/8/21 4:52 AM, Michal Hocko wrote:
> 
> >> The top tier memory used is reported in
> >>
> >> memory.toptier_usage_in_bytes
> >>
> >> The amount of top tier memory usable by each cgroup without
> >> triggering page reclaim is controlled by the
> >>
> >> memory.toptier_soft_limit_in_bytes 
> > 
> 
> Michal,
> 
> Thanks for your comments.  I will like to take a step back and
> look at the eventual goal we envision: a mechanism to partition the 
> tiered memory between the cgroups. 

OK, this is goot mission statemet to start with. I would expect a follow
up to say what kind of granularity of control you want to achieve here.
Pressumably you want more than all or nothing because that is where
cpusets can be used for.

> A typical use case may be a system with two set of tasks.
> One set of task is very latency sensitive and we desire instantaneous
> response from them. Another set of tasks will be running batch jobs
> were latency and performance is not critical.   In this case,
> we want to carve out enough top tier memory such that the working set
> of the latency sensitive tasks can fit entirely in the top tier memory.
> The rest of the top tier memory can be assigned to the background tasks.  

While from a very high level this makes sense I would be interested in
more details though. Your high letency sensitive applications very likely
want to be bound to high performance node, right? Can they tolerate
memory reclaim? Can they consume more memory than the node size? What do
you expect to happen then?
 
> To achieve such cgroup based tiered memory management, we probably want
> something like the following.
> 
> For generalization let's say that there are N tiers of memory t_0, t_1 ... t_N-1,
> where tier t_0 sits at the top and demotes to the lower tier. 

How is each tear defined? Is this an admin define set of NUMA nodes or
is this platform specific?

[...]

> Will such an interface looks sane and acceptable with everyone?

Let's talk more about usecases first before we even start talking about
the interface or which controller is the best fit for implementing it.
 
> The patch set I posted is meant to be a straw man cgroup v1 implementation
> and I readily admits that it falls short of the eventual functionality 
> we want to achieve.  It is meant to solicit feedback from everyone on how the tiered
> memory management should work.

OK, fair enough. Let me then just state that I strongly believe that
Soft limit based approach is a dead end and it would be better to focus
on the actual usecases and try to understand what you want to achieve
first.

[...]

> > What I am trying to say (and I have brought that up when demotion has been
> > discussed at LSFMM) is that the implementation shouldn't be PMEM aware.
> > The specific technology shouldn't be imprinted into the interface.
> > Fundamentally you are trying to balance memory among NUMA nodes as we do
> > not have other abstraction to use. So rather than talking about top,
> > secondary, nth tier we have different NUMA nodes with different
> > characteristics and you want to express your "priorities" for them.
> 
> With node priorities, how would the system reserve enough
> high performance memory for those performance critical task cgroup? 
> 
> By priority, do you mean the order of allocation of nodes for a cgroup?
> Or you mean that all the similar performing memory node will be grouped in
> the same priority?

I have to say I do not yet have a clear idea on what those priorities
would look like. I just wanted to outline that usecases you are
interested about likely want to implement some form of (application
transparent) control for memory distribution over several nodes. There
is a long way to land on something more specific I am afraid.
-- 
Michal Hocko
SUSE Labs

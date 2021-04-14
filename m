Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92A135F058
	for <lists+cgroups@lfdr.de>; Wed, 14 Apr 2021 11:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbhDNJB6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 14 Apr 2021 05:01:58 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2849 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350462AbhDNJBt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 14 Apr 2021 05:01:49 -0400
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FKx9H2T3Mz68987;
        Wed, 14 Apr 2021 16:54:11 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 14 Apr 2021 11:01:26 +0200
Received: from localhost (10.47.83.55) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 14 Apr
 2021 10:01:25 +0100
Date:   Wed, 14 Apr 2021 09:59:58 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Ying Huang" <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "David Rientjes" <rientjes@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Thelen <gthelen@google.com>, Wei Xu <weixugc@google.com>
Subject: Re: [RFC PATCH v1 00/11] Manage the top tier memory in a tiered
 memory
Message-ID: <20210414095958.000008c4@Huawei.com>
In-Reply-To: <CALvZod4zXB6-3Mshu_TnTsQaDErfYkPTw9REYNRptSvPSRmKVA@mail.gmail.com>
References: <cover.1617642417.git.tim.c.chen@linux.intel.com>
        <YGwlGrHtDJPQF7UG@dhcp22.suse.cz>
        <c615a610-eb4b-7e1e-16d1-4bc12938b08a@linux.intel.com>
        <YG7ugXZZ9BcXyGGk@dhcp22.suse.cz>
        <58e5dcc9-c134-78de-6965-7980f8596b57@linux.intel.com>
        <CALvZod4zXB6-3Mshu_TnTsQaDErfYkPTw9REYNRptSvPSRmKVA@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.83.55]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 12 Apr 2021 12:20:22 -0700
Shakeel Butt <shakeelb@google.com> wrote:

> On Fri, Apr 9, 2021 at 4:26 PM Tim Chen <tim.c.chen@linux.intel.com> wrote:
> >
> >
> > On 4/8/21 4:52 AM, Michal Hocko wrote:
> >  
> > >> The top tier memory used is reported in
> > >>
> > >> memory.toptier_usage_in_bytes
> > >>
> > >> The amount of top tier memory usable by each cgroup without
> > >> triggering page reclaim is controlled by the
> > >>
> > >> memory.toptier_soft_limit_in_bytes  
> > >  
> >
> > Michal,
> >
> > Thanks for your comments.  I will like to take a step back and
> > look at the eventual goal we envision: a mechanism to partition the
> > tiered memory between the cgroups.
> >
> > A typical use case may be a system with two set of tasks.
> > One set of task is very latency sensitive and we desire instantaneous
> > response from them. Another set of tasks will be running batch jobs
> > were latency and performance is not critical.   In this case,
> > we want to carve out enough top tier memory such that the working set
> > of the latency sensitive tasks can fit entirely in the top tier memory.
> > The rest of the top tier memory can be assigned to the background tasks.
> >
> > To achieve such cgroup based tiered memory management, we probably want
> > something like the following.
> >
> > For generalization let's say that there are N tiers of memory t_0, t_1 ... t_N-1,
> > where tier t_0 sits at the top and demotes to the lower tier.
> > We envision for this top tier memory t0 the following knobs and counters
> > in the cgroup memory controller
> >
> > memory_t0.current       Current usage of tier 0 memory by the cgroup.
> >
> > memory_t0.min           If tier 0 memory used by the cgroup falls below this low
> >                         boundary, the memory will not be subjected to demotion
> >                         to lower tiers to free up memory at tier 0.
> >
> > memory_t0.low           Above this boundary, the tier 0 memory will be subjected
> >                         to demotion.  The demotion pressure will be proportional
> >                         to the overage.
> >
> > memory_t0.high          If tier 0 memory used by the cgroup exceeds this high
> >                         boundary, allocation of tier 0 memory by the cgroup will
> >                         be throttled. The tier 0 memory used by this cgroup
> >                         will also be subjected to heavy demotion.
> >
> > memory_t0.max           This will be a hard usage limit of tier 0 memory on the cgroup.
> >
> > If needed, memory_t[12...].current/min/low/high for additional tiers can be added.
> > This follows closely with the design of the general memory controller interface.
> >
> > Will such an interface looks sane and acceptable with everyone?
> >  
> 
> I have a couple of questions. Let's suppose we have a two socket
> system. Node 0 (DRAM+CPUs), Node 1 (DRAM+CPUs), Node 2 (PMEM on socket
> 0 along with Node 0) and Node 3 (PMEM on socket 1 along with Node 1).
> Based on the tier definition of this patch series, tier_0: {node_0,
> node_1} and tier_1: {node_2, node_3}.
> 
> My questions are:
> 
> 1) Can we assume that the cost of access within a tier will always be
> less than the cost of access from the tier? (node_0 <-> node_1 vs
> node_0 <-> node_2)

No in large systems even it we can make this assumption in 2 socket ones.

> 2) If yes to (1), is that assumption future proof? Will the future
> systems with DRAM over CXL support have the same characteristics?
> 3) Will the cost of access from tier_0 to tier_1 be uniform? (node_0
> <-> node_2 vs node_0 <-> node_3). For jobs running on node_0, node_3
> might be third tier and similarly for jobs running on node_1, node_2
> might be third tier.
> 
> The reason I am asking these questions is that the statically
> partitioning memory nodes into tiers will inherently add platform
> specific assumptions in the user API.

Absolutely agree.

> 
> Assumptions like:
> 1) Access within tier is always cheaper than across tier.
> 2) Access from tier_i to tier_i+1 has uniform cost.
> 
> The reason I am more inclined towards having numa centric control is
> that we don't have to make these assumptions. Though the usability
> will be more difficult. Greg (CCed) has some ideas on making it better
> and we will share our proposal after polishing it a bit more.
> 

Sounds good, will look out for that.

Jonathan


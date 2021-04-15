Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F7035FEF8
	for <lists+cgroups@lfdr.de>; Thu, 15 Apr 2021 02:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbhDOAnF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 14 Apr 2021 20:43:05 -0400
Received: from mga07.intel.com ([134.134.136.100]:56494 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230040AbhDOAnE (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 14 Apr 2021 20:43:04 -0400
IronPort-SDR: gbQ6GFFy8fZOM73j00asM+fKi9qPyWTuqLLOkGzPPDAL600Ie5dT4DyOIt3GLwzmEyExdVBkbs
 DcOGKwkN0tKQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="258728973"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="258728973"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 17:42:40 -0700
IronPort-SDR: lP90tNN9rJXZ+zZzV/Ob6WFrbiWIsX1Gf3oImAeXo2y42oGv7f/qKBGesrYeacp3vfvicrD5fQ
 E50xgL7dT9IQ==
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="389573156"
Received: from schen9-mobl.amr.corp.intel.com ([10.209.63.115])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 17:42:40 -0700
Subject: Re: [RFC PATCH v1 00/11] Manage the top tier memory in a tiered
 memory
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Thelen <gthelen@google.com>, Wei Xu <weixugc@google.com>
References: <cover.1617642417.git.tim.c.chen@linux.intel.com>
 <YGwlGrHtDJPQF7UG@dhcp22.suse.cz>
 <c615a610-eb4b-7e1e-16d1-4bc12938b08a@linux.intel.com>
 <YG7ugXZZ9BcXyGGk@dhcp22.suse.cz>
 <58e5dcc9-c134-78de-6965-7980f8596b57@linux.intel.com>
 <CALvZod4zXB6-3Mshu_TnTsQaDErfYkPTw9REYNRptSvPSRmKVA@mail.gmail.com>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <ec5d5da8-bfc8-cd7a-7959-ee86d4e01bfa@linux.intel.com>
Date:   Wed, 14 Apr 2021 17:42:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CALvZod4zXB6-3Mshu_TnTsQaDErfYkPTw9REYNRptSvPSRmKVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 4/12/21 12:20 PM, Shakeel Butt wrote:

>>
>> memory_t0.current       Current usage of tier 0 memory by the cgroup.
>>
>> memory_t0.min           If tier 0 memory used by the cgroup falls below this low
>>                         boundary, the memory will not be subjected to demotion
>>                         to lower tiers to free up memory at tier 0.
>>
>> memory_t0.low           Above this boundary, the tier 0 memory will be subjected
>>                         to demotion.  The demotion pressure will be proportional
>>                         to the overage.
>>
>> memory_t0.high          If tier 0 memory used by the cgroup exceeds this high
>>                         boundary, allocation of tier 0 memory by the cgroup will
>>                         be throttled. The tier 0 memory used by this cgroup
>>                         will also be subjected to heavy demotion.
>>
>> memory_t0.max           This will be a hard usage limit of tier 0 memory on the cgroup.
>>
>> If needed, memory_t[12...].current/min/low/high for additional tiers can be added.
>> This follows closely with the design of the general memory controller interface.
>>
>> Will such an interface looks sane and acceptable with everyone?
>>
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

I do assume that higher tier memory offers better performance (or less
access latency) than a lower tier memory.  Otherwise, this defeats the
whole purpose of promoting hot memory from lower tier to a higher tier,
and demoting cold memory to a lower tier.

Tiers assumption is embedded once we define this promotion/demotion relationship
between the numa nodes.

So if 

  node_m ----demotes----> node_n
         <---promotes---- 

then node_m is one tier higher tier than node_n. This promotion/demotion
relationship between the nodes is the underpinning of Dave and Ying's
demotion and promotion patch sets.  

> 2) If yes to (1), is that assumption future proof? Will the future
> systems with DRAM over CXL support have the same characteristics?

I think if you configure a promotion/demotion relationship between
DRAM over CXL and local-socket connected DRAM, you could divide them
up into separate tiers.  Or you don't care about the difference and
you will configure them not to have a promotion/demotion relationship
and they will be at the same tier.  Balance within the same tier
will be effected by the autonuma mechanism.

> 3) Will the cost of access from tier_0 to tier_1 be uniform? (node_0
> <-> node_2 vs node_0 <-> node_3). For jobs running on node_0, node_3
> might be third tier and similarly for jobs running on node_1, node_2
> might be third tier.

Tier definition is an admin's choice, of where the admin think the
hot memory should reside after looking at the memory performance.
It falls out of how the admin construct the promotion/demotion relationship
between the nodes and OS does not assume the tier relationship from
memory performance directly. 

> 
> The reason I am asking these questions is that the statically
> partitioning memory nodes into tiers will inherently add platform
> specific assumptions in the user API.
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

I am still trying to understand how a numa centric control actually
work. Putting limits on every numa node for each cgroup
seems to make the system configuration quite complicated.  Looking
forward to your proposal so I can better understand that perspective.

Tim 

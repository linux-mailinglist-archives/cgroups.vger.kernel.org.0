Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9813259D0
	for <lists+cgroups@lfdr.de>; Thu, 25 Feb 2021 23:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhBYWuv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Feb 2021 17:50:51 -0500
Received: from mga17.intel.com ([192.55.52.151]:41696 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231326AbhBYWuu (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 25 Feb 2021 17:50:50 -0500
IronPort-SDR: U4+q9rhKLJ/oHQ8W6WkAK+iUy4PGP/ljldIjDJCif5ebdZrfnKOqSFNJCQWcYXfJFp2u4NE+i/
 aORolfRPHSbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9906"; a="165566197"
X-IronPort-AV: E=Sophos;i="5.81,207,1610438400"; 
   d="scan'208";a="165566197"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2021 14:49:05 -0800
IronPort-SDR: iNQrhR4B49D66thWy+kAZeBWhban/MHq1DSL3qHgMM8rR/clwTk3ySMQQF0TJ3oixjADsJcSNG
 AfByzWW6o0dQ==
X-IronPort-AV: E=Sophos;i="5.81,207,1610438400"; 
   d="scan'208";a="442790842"
Received: from schen9-mobl.amr.corp.intel.com ([10.254.86.33])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2021 14:49:03 -0800
Subject: Re: [PATCH v2 2/3] mm: Force update of mem cgroup soft limit tree on
 usage excess
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1613584277.git.tim.c.chen@linux.intel.com>
 <06f1f92f1f7d4e57c4e20c97f435252c16c60a27.1613584277.git.tim.c.chen@linux.intel.com>
 <YC+ApsntwnlVfCuK@dhcp22.suse.cz>
 <884d7559-e118-3773-351d-84c02642ca96@linux.intel.com>
 <YDNuAIztiGJpLEtw@dhcp22.suse.cz>
 <e132f836-b5d5-3776-22d6-669e713983e4@linux.intel.com>
 <YDQBh5th9txxEFUm@dhcp22.suse.cz>
 <cf5ca7a1-7965-f307-22e1-e216316904cf@linux.intel.com>
 <YDY+PydRUGQpHNaJ@dhcp22.suse.cz>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <b5b1944d-846b-3212-fe4a-f10f5fcb87d7@linux.intel.com>
Date:   Thu, 25 Feb 2021 14:48:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <YDY+PydRUGQpHNaJ@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2/24/21 3:53 AM, Michal Hocko wrote:
> On Mon 22-02-21 11:48:37, Tim Chen wrote:
>>
>>
>> On 2/22/21 11:09 AM, Michal Hocko wrote:
>>
>>>>
>>>> I actually have tried adjusting the threshold but found that it doesn't work well for
>>>> the case with unenven memory access frequency between cgroups.  The soft
>>>> limit for the low memory event cgroup could creep up quite a lot, exceeding
>>>> the soft limit by hundreds of MB, even
>>>> if I drop the SOFTLIMIT_EVENTS_TARGET from 1024 to something like 8.
>>>
>>> What was the underlying reason? Higher order allocations?
>>>
>>
>> Not high order allocation.
>>
>> The reason was because the run away memcg asks for memory much less often, compared
>> to the other memcgs in the system.  So it escapes the sampling update and
>> was not put onto the tree and exceeds the soft limit
>> pretty badly.  Even if it was put onto the tree and gets page reclaimed below the
>> limit, it could escape the sampling the next time it exceeds the soft limit.
> 
> I am sorry but I really do not follow. Maybe I am missing something
> obvious but the the rate of events (charge/uncharge) shouldn't be really
> important. There is no way to exceed the limit without charging memory
> (either a new or via task migration in v1 and immigrate_on_move). If you
> have SOFTLIMIT_EVENTS_TARGET 8 then you should be 128 * 8 events to
> re-evaluate. Huge pages can make the runaway much bigger but how it
> would be possible to runaway outside of that bound.


Michal,

Let's take an extreme case where memcg 1 always generate the
first event and memcg 2 generates the rest of 128*8-1 events
and the pattern repeat.  The update tree happens on the 128*8th event
so memcg 1 did not trigger update tree.  In this case we will
keep missing memcg 1's event and not put memcg 1 on the tree.

Something like this pattern of memory events


cg1 cg2 cg2 cg2 ....cg2 cg1 cg2 cg2 cg2....cg2 cg1 cg2 .....
                     ^                      ^
		  update tree              update tree

Of course in real life the update events are random in nature.
However, due to the low occurrence of memcg 1 event, we can miss
updating it for a long time due to its lower probability of occurrence.

> 
> Btw. do we really need SOFTLIMIT_EVENTS_TARGET at all? Why cannot we
> just stick with a single threshold? mem_cgroup_update_tree can be made
> a effectivelly a noop when there is no soft limit in place so overhead
> shouldn't matter for the vast majority of workloads.
> 

I think there are two limits because the original code wants
memc_cgroup_threshold to be updated more frequently than the
soft_limit_tree.  The soft limit tree update is more costly.

Tim

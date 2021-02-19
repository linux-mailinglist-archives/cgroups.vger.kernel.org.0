Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEFB131FF75
	for <lists+cgroups@lfdr.de>; Fri, 19 Feb 2021 20:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhBSTaf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Feb 2021 14:30:35 -0500
Received: from mga07.intel.com ([134.134.136.100]:21503 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230071AbhBSTae (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 19 Feb 2021 14:30:34 -0500
IronPort-SDR: Nm66EkXcQKSmzdEs6qrF8PDCCj/Q/LYi8M3bIQQvJGwlqTtQCk9knoo5ai5oqUy/GUkwxoz0Xg
 rxRFjju7rNbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9900"; a="248005108"
X-IronPort-AV: E=Sophos;i="5.81,189,1610438400"; 
   d="scan'208";a="248005108"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2021 11:28:46 -0800
IronPort-SDR: L2XGn9Zo4R2llyAxs8pq98hgkcxha5oZsJ9Cb1JbjidupriGbJGd4F8sD201lr4MZGN7XwtfrW
 d1Lg3B7g0aTw==
X-IronPort-AV: E=Sophos;i="5.81,189,1610438400"; 
   d="scan'208";a="379000055"
Received: from schen9-mobl.amr.corp.intel.com ([10.251.10.112])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2021 11:28:47 -0800
Subject: Re: [PATCH v2 3/3] mm: Fix missing mem cgroup soft limit tree updates
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1613584277.git.tim.c.chen@linux.intel.com>
 <e269f5df3af1157232b01a9b0dae3edf4880d786.1613584277.git.tim.c.chen@linux.intel.com>
 <YC+B2KvJVSgfVDTe@dhcp22.suse.cz>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <1ecd277e-c236-08e1-f068-3dd65ee0e640@linux.intel.com>
Date:   Fri, 19 Feb 2021 11:28:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <YC+B2KvJVSgfVDTe@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2/19/21 1:16 AM, Michal Hocko wrote:

>>
>> Something like this?
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 8bddee75f5cb..b50cae3b2a1a 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -3472,6 +3472,14 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
>>                 if (!mz)
>>                         break;
>>
>> +               /*
>> +                * Soft limit tree is updated based on memcg events sampling.
>> +                * We could have missed some updates on page uncharge and
>> +                * the cgroup is below soft limit.  Skip useless soft reclaim.
>> +                */
>> +               if (!soft_limit_excess(mz->memcg))
>> +                       continue;
>> +
>>                 nr_scanned = 0;
>>                 reclaimed = mem_cgroup_soft_reclaim(mz->memcg, pgdat,
> 
> Yes I meant something like this but then I have looked more closely and
> this shouldn't be needed afterall. __mem_cgroup_largest_soft_limit_node
> already does all the work
>         if (!soft_limit_excess(mz->memcg) ||
>             !css_tryget(&mz->memcg->css))
>                 goto retry;
> so this shouldn't really happen.
> 

Ah, that's true.  The added check for soft_limit_excess is not needed.

Do you think it is still a good idea to add patch 3 to
restrict the uncharge update in page batch of the same node and cgroup?

I am okay with dropping patch 3 and let the inaccuracies in the ordering
of soft limit tree be cleared out by an occasional soft reclaim.
These inaccuracies will still be there even with patch 3 fix due
to the memcg event sampling.  Patch 3 does help to keep the soft reclaim
tree ordering more up to date.

Thanks.

Tim

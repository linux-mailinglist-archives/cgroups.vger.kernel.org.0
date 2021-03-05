Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDBD32F37C
	for <lists+cgroups@lfdr.de>; Fri,  5 Mar 2021 20:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbhCETID (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 Mar 2021 14:08:03 -0500
Received: from mga11.intel.com ([192.55.52.93]:64879 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229791AbhCETIA (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 5 Mar 2021 14:08:00 -0500
IronPort-SDR: k5s6LlXd0vtwLQfRm5qS3KLczx+4fbA4PYBCzGONWsF1330Morp1/GX9j3qW4drO4aRHH6MG2I
 ZxT2HVX+XJHw==
X-IronPort-AV: E=McAfee;i="6000,8403,9914"; a="184338888"
X-IronPort-AV: E=Sophos;i="5.81,226,1610438400"; 
   d="scan'208";a="184338888"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2021 11:08:00 -0800
IronPort-SDR: hHPr2NOdMM3kwVF0lCWTAa3OSE3EVPljoLuM7c8D8zhnq6pEaijfvn/l6lZ9dBLkVNRvJayJj6
 T/ZhnlnY+VaA==
X-IronPort-AV: E=Sophos;i="5.81,226,1610438400"; 
   d="scan'208";a="368694013"
Received: from schen9-mobl.amr.corp.intel.com ([10.251.16.203])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2021 11:08:00 -0800
Subject: Re: [PATCH v2 1/3] mm: Fix dropped memcg from mem cgroup soft limit
 tree
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1613584277.git.tim.c.chen@linux.intel.com>
 <8d35206601ccf0e1fe021d24405b2a0c2f4e052f.1613584277.git.tim.c.chen@linux.intel.com>
 <YC68Xo9+R2msn/ul@dhcp22.suse.cz>
 <72cb8618-73af-ce08-d5d5-30cab30755a3@linux.intel.com>
 <YEH1xF8xm9MCsQ+q@dhcp22.suse.cz>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <087bed0e-5b5f-0e25-c247-7fcb34de1513@linux.intel.com>
Date:   Fri, 5 Mar 2021 11:07:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <YEH1xF8xm9MCsQ+q@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 3/5/21 1:11 AM, Michal Hocko wrote:
> On Thu 04-03-21 09:35:08, Tim Chen wrote:
>>
>>
>> On 2/18/21 11:13 AM, Michal Hocko wrote:
>>
>>>
>>> Fixes: 4e41695356fb ("memory controller: soft limit reclaim on contention")
>>> Acked-by: Michal Hocko <mhocko@suse.com>
>>>
>>> Thanks!
>>>> ---
>>>>  mm/memcontrol.c | 6 +++++-
>>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>>> index ed5cc78a8dbf..a51bf90732cb 100644
>>>> --- a/mm/memcontrol.c
>>>> +++ b/mm/memcontrol.c
>>>> @@ -3505,8 +3505,12 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
>>>>  			loop > MEM_CGROUP_MAX_SOFT_LIMIT_RECLAIM_LOOPS))
>>>>  			break;
>>>>  	} while (!nr_reclaimed);
>>>> -	if (next_mz)
>>>> +	if (next_mz) {
>>>> +		spin_lock_irq(&mctz->lock);
>>>> +		__mem_cgroup_insert_exceeded(next_mz, mctz, excess);
>>>> +		spin_unlock_irq(&mctz->lock);
>>>>  		css_put(&next_mz->memcg->css);
>>>> +	}
>>>>  	return nr_reclaimed;
>>>>  }
>>>>  
>>>> -- 
>>>> 2.20.1
>>>
>>
>> Mel,
>>
>> Reviewing this patch a bit more, I realize that there is a chance that the removed
>> next_mz could be inserted back to the tree from a memcg_check_events
>> that happen in between.  So we need to make sure that the next_mz
>> is indeed off the tree and update the excess value before adding it
>> back.  Update the patch to the patch below.
> 
> This scenario is certainly possible but it shouldn't really matter much
> as __mem_cgroup_insert_exceeded bails out when the node is on the tree
> already.
> 

Makes sense. We should still update the excess value with

+		excess = soft_limit_excess(next_mz->memcg);
+		__mem_cgroup_insert_exceeded(next_mz, mctz, excess);

before doing insertion.  The excess value was recorded from previous
mz in the loop and needs to be updated to that of next_mz.

Tim

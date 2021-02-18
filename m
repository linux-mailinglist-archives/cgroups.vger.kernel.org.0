Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4B731F090
	for <lists+cgroups@lfdr.de>; Thu, 18 Feb 2021 20:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhBRTze (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 18 Feb 2021 14:55:34 -0500
Received: from mga12.intel.com ([192.55.52.136]:2834 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232246AbhBRTxQ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 18 Feb 2021 14:53:16 -0500
IronPort-SDR: EGYZ0JRVTuRaO1WtKt6JW9o2MFS1PsIme1hfEA7v+8H8b/qvK4ecEvZAQkU5XWmypebhJp6N2a
 r9BAmXT0qu/Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="162776059"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="162776059"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 11:51:29 -0800
IronPort-SDR: Laxqy638jBahXM/Nn1uEjjSLbDexQjGW13cAai0nmMz4tPOw4aaSlZ/8c1Uy4n9jHYq8NZ4hb4
 q3aVtuPVbnDA==
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="428366282"
Received: from schen9-mobl.amr.corp.intel.com ([10.254.101.217])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 11:51:29 -0800
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
 <YC4kV7dkJpxjW+df@dhcp22.suse.cz>
 <c3ffa2cb-cb2c-20b7-d722-c875934992e9@linux.intel.com>
 <YC68QRVsCONXscCl@dhcp22.suse.cz>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <286b1ade-46d9-2fca-1641-69de4694deb1@linux.intel.com>
Date:   Thu, 18 Feb 2021 11:51:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <YC68QRVsCONXscCl@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2/18/21 11:13 AM, Michal Hocko wrote:
> On Thu 18-02-21 10:30:20, Tim Chen wrote:
>>
>>
>> On 2/18/21 12:24 AM, Michal Hocko wrote:
>>
>>>
>>> I have already acked this patch in the previous version along with Fixes
>>> tag. It seems that my review feedback has been completely ignored also
>>> for other patches in this series.
>>
>> Michal,
>>
>> My apology.  Our mail system screwed up and there are some mail missing
>> from our mail system that I completely missed your mail.  
>> Only saw them now after I looked into the lore.kernel.org.
> 
> I see. My apology for suspecting you from ignoring my review.
>  
>> Responding to your comment:
>>
>>> Have you observed this happening in the real life? I do agree that the
>>> threshold based updates of the tree is not ideal but the whole soft
>>> reclaim code is far from optimal. So why do we care only now? The
>>> feature is essentially dead and fine tuning it sounds like a step back
>>> to me.
>>
>> Yes, I did see the issue mentioned in patch 2 breaking soft limit
>> reclaim for cgroup v1.  There are still some of our customers using
>> cgroup v1 so we will like to fix this if possible.
> 
> It would be great to see more details.
> 

The sceanrio I saw was we have multiple cgroups running pmbench.
One cgroup exceeded the soft limit and soft reclaim is active on
that cgroup.  So there are a whole bunch of memcg events associated
with that cgroup.  Then another cgroup starts to exceed its
soft limit.  

Memory is accessed at a much lower frequency
for the second cgroup.  The memcg event update was not triggered for the
second cgroup as the memcg event update didn't happened on the 1024th sample.
The second cgroup was not placed on the soft limit tree and we didn't
try to reclaim the excess pages.

As time goes on, we saw that the first cgroup was kept close to its
soft limit due to reclaim activities, while the second cgroup's memory
usage slowly creep up as it keeps getting missed from the soft limit tree
update as the update didn't fall on the modulo 1024 sample.  As a result,
the memory usage of the second cgroup keeps growing over the soft limit
for a long time due to its relatively rare occurrence.

>> For patch 3 regarding the uncharge_batch, it
>> is more of an observation that we should uncharge in batch of same node
>> and not prompted by actual workload.
>> Thinking more about this, the worst that could happen
>> is we could have some entries in the soft limit tree that overestimate
>> the memory used.  The worst that could happen is a soft page reclaim
>> on that cgroup.  The overhead from extra memcg event update could
>> be more than a soft page reclaim pass.  So let's drop patch 3
>> for now.
> 
> I would still prefer to handle that in the soft limit reclaim path and
> check each memcg for the soft limit reclaim excess before the reclaim.
>  

Something like this?

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8bddee75f5cb..b50cae3b2a1a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3472,6 +3472,14 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
                if (!mz)
                        break;
 
+               /*
+                * Soft limit tree is updated based on memcg events sampling.
+                * We could have missed some updates on page uncharge and
+                * the cgroup is below soft limit.  Skip useless soft reclaim.
+                */
+               if (!soft_limit_excess(mz->memcg))
+                       continue;
+
                nr_scanned = 0;
                reclaimed = mem_cgroup_soft_reclaim(mz->memcg, pgdat,

Tim


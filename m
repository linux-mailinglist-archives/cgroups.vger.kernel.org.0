Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061BD32D8AE
	for <lists+cgroups@lfdr.de>; Thu,  4 Mar 2021 18:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237747AbhCDRhZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 Mar 2021 12:37:25 -0500
Received: from mga05.intel.com ([192.55.52.43]:57559 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238054AbhCDRg5 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 4 Mar 2021 12:36:57 -0500
IronPort-SDR: DQMZTf/3NzQ0v7inozieATYhcPcKracA1+KGVCOlg7Kqk5fVKH843sbeWtPnNbUYFIA6EjbaH3
 TICA20xPJDdQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="272469215"
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="272469215"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 09:35:09 -0800
IronPort-SDR: VGpwhUK+Pw9QnSpgsePTNfYQokM/1Dqv2T8jcAvMiwHe9DTYl3Rw3rzhXDeQBmHgbbN0kyVpB9
 xXxfI5W/fyMw==
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="428734093"
Received: from schen9-mobl.amr.corp.intel.com ([10.255.229.203])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 09:35:08 -0800
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
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <72cb8618-73af-ce08-d5d5-30cab30755a3@linux.intel.com>
Date:   Thu, 4 Mar 2021 09:35:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <YC68Xo9+R2msn/ul@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2/18/21 11:13 AM, Michal Hocko wrote:

> 
> Fixes: 4e41695356fb ("memory controller: soft limit reclaim on contention")
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> Thanks!
>> ---
>>  mm/memcontrol.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index ed5cc78a8dbf..a51bf90732cb 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -3505,8 +3505,12 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
>>  			loop > MEM_CGROUP_MAX_SOFT_LIMIT_RECLAIM_LOOPS))
>>  			break;
>>  	} while (!nr_reclaimed);
>> -	if (next_mz)
>> +	if (next_mz) {
>> +		spin_lock_irq(&mctz->lock);
>> +		__mem_cgroup_insert_exceeded(next_mz, mctz, excess);
>> +		spin_unlock_irq(&mctz->lock);
>>  		css_put(&next_mz->memcg->css);
>> +	}
>>  	return nr_reclaimed;
>>  }
>>  
>> -- 
>> 2.20.1
> 

Mel,

Reviewing this patch a bit more, I realize that there is a chance that the removed
next_mz could be inserted back to the tree from a memcg_check_events
that happen in between.  So we need to make sure that the next_mz
is indeed off the tree and update the excess value before adding it
back.  Update the patch to the patch below.

Thanks.

Tim
---

From 412764d1fad219b04c77bcb1cc8161067c8424f2 Mon Sep 17 00:00:00 2001
From: Tim Chen <tim.c.chen@linux.intel.com>
Date: Tue, 2 Feb 2021 15:53:21 -0800
Subject: [PATCH v3] mm: Fix dropped memcg from mem cgroup soft limit tree
To: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.cz>,Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org

During soft limit memory reclaim, we will temporarily remove the target
mem cgroup from the cgroup soft limit tree.  We then perform memory
reclaim, update the memory usage excess count and re-insert the mem
cgroup back into the mem cgroup soft limit tree according to the new
memory usage excess count.

However, when memory reclaim failed for a maximum number of attempts
and we bail out of the reclaim loop, we forgot to put the target mem
cgroup chosen for next reclaim back to the soft limit tree. This prevented
pages in the mem cgroup from being reclaimed in the future even though
the mem cgroup exceeded its soft limit.  Fix the logic and put the mem
cgroup back on the tree when page reclaim failed for the mem cgroup.

Fixes: 4e41695356fb ("memory controller: soft limit reclaim on contention")
---
 mm/memcontrol.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ed5cc78a8dbf..bc9cc73ff66b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3505,8 +3505,18 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 			loop > MEM_CGROUP_MAX_SOFT_LIMIT_RECLAIM_LOOPS))
 			break;
 	} while (!nr_reclaimed);
-	if (next_mz)
+	if (next_mz) {
+		/*
+		 * next_mz was removed in __mem_cgroup_largest_soft_limit_node.
+		 * Put it back in tree with latest excess value.
+		 */
+		spin_lock_irq(&mctz->lock);
+		__mem_cgroup_remove_exceeded(next_mz, mctz);
+		excess = soft_limit_excess(next_mz->memcg);
+		__mem_cgroup_insert_exceeded(next_mz, mctz, excess);
+		spin_unlock_irq(&mctz->lock);
 		css_put(&next_mz->memcg->css);
+	}
 	return nr_reclaimed;
 }
 
-- 
2.20.1


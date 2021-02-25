Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793503259A8
	for <lists+cgroups@lfdr.de>; Thu, 25 Feb 2021 23:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhBYW15 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Feb 2021 17:27:57 -0500
Received: from mga12.intel.com ([192.55.52.136]:33744 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231881AbhBYW1g (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 25 Feb 2021 17:27:36 -0500
IronPort-SDR: uQBRiXE8ffy4Dd+tHy0u2+jC9MQtzLeyUnSjejC0f60gTFMk5tpCiNyX5YSBcDWVBzV7sRTQ6K
 cnoGO5/xRWiQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9906"; a="164916683"
X-IronPort-AV: E=Sophos;i="5.81,207,1610438400"; 
   d="scan'208";a="164916683"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2021 14:25:48 -0800
IronPort-SDR: 3xeohI4Olwdz2iRO+Wcc4cNuCWodhBY1jeeoz7LVZ+cZBwoZwLjM3a7ax373SR3+PoXrk0U++r
 pxX9gr5hypXQ==
X-IronPort-AV: E=Sophos;i="5.81,207,1610438400"; 
   d="scan'208";a="365618944"
Received: from schen9-mobl.amr.corp.intel.com ([10.254.86.33])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2021 14:25:48 -0800
Subject: Re: [PATCH v2 2/3] mm: Force update of mem cgroup soft limit tree on
 usage excess
From:   Tim Chen <tim.c.chen@linux.intel.com>
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
Message-ID: <cc046fc0-930d-76f6-7cd5-2aba582d72dd@linux.intel.com>
Date:   Thu, 25 Feb 2021 14:25:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <e132f836-b5d5-3776-22d6-669e713983e4@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2/22/21 9:41 AM, Tim Chen wrote:
> 
> 
> On 2/22/21 12:40 AM, Michal Hocko wrote:
>> On Fri 19-02-21 10:59:05, Tim Chen wrote:
>  occurrence.
>>>>
>>>> Soft limit is evaluated every THRESHOLDS_EVENTS_TARGET * SOFTLIMIT_EVENTS_TARGET.
>>>> If all events correspond with a newly charged memory and the last event
>>>> was just about the soft limit boundary then we should be bound by 128k
>>>> pages (512M and much more if this were huge pages) which is a lot!
>>>> I haven't realized this was that much. Now I see the problem. This would
>>>> be a useful information for the changelog.
>>>>
>>>> Your fix is focusing on the over-the-limit boundary which will solve the
>>>> problem but wouldn't that lead to to updates happening too often in
>>>> pathological situation when a memcg would get reclaimed immediatelly?
>>>
>>> Not really immediately.  The memcg that has the most soft limit excess will
>>> be chosen for page reclaim, which is the way it should be.  
>>> It is less likely that a memcg that just exceeded
>>> the soft limit becomes the worst offender immediately. 
>>
>> Well this all depends on when the the soft limit reclaim triggeres. In
>> other words how often you see the global memory reclaim. If we have a
>> memcg with a sufficient excess then this will work mostly fine. I was more
>> worried about a case when you have memcgs just slightly over the limit
>> and the global memory pressure is a regular event. You can easily end up
>> bouncing memcgs off and on the tree in a rapid fashion. 
>>
> 
> If you are concerned about such a case, we can add an excess threshold,
> say 4 MB (or 1024 4K pages), before we trigger a forced update. You think
> that will cover this concern?
> 

Michal,

How about modifiying this patch with a threshold? Like the following?

Tim

---
From 5a78ab56e2e654290cacab2f5a1631e1da1d90d2 Mon Sep 17 00:00:00 2001
From: Tim Chen <tim.c.chen@linux.intel.com>
Date: Wed, 3 Feb 2021 14:08:48 -0800
Subject: [PATCH] mm: Force update of mem cgroup soft limit tree on usage
 excess

To rate limit updates to the mem cgroup soft limit tree, we only perform
updates every SOFTLIMIT_EVENTS_TARGET (defined as 1024) memory events.

However, this sampling based updates may miss a critical update: i.e. when
the mem cgroup first exceeded its limit but it was not on the soft limit tree.
It should be on the tree at that point so it could be subjected to soft
limit page reclaim. If the mem cgroup had few memory events compared with
other mem cgroups, we may not update it and place in on the mem cgroup
soft limit tree for many memory events.  And this mem cgroup excess
usage could creep up and the mem cgroup could be hidden from the soft
limit page reclaim for a long time.

Fix this issue by forcing an update to the mem cgroup soft limit tree if a
mem cgroup has exceeded its memory soft limit but it is not on the mem
cgroup soft limit tree.

---
 mm/memcontrol.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a51bf90732cb..e0f6948f8ea5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -104,6 +104,7 @@ static bool do_memsw_account(void)
 
 #define THRESHOLDS_EVENTS_TARGET 128
 #define SOFTLIMIT_EVENTS_TARGET 1024
+#define SOFTLIMIT_EXCESS_THRESHOLD 1024
 
 /*
  * Cgroups above their limits are maintained in a RB-Tree, independent of
@@ -985,15 +986,29 @@ static bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
  */
 static void memcg_check_events(struct mem_cgroup *memcg, struct page *page)
 {
+	struct mem_cgroup_per_node *mz;
+	bool force_update = false;
+
+	mz = mem_cgroup_nodeinfo(memcg, page_to_nid(page));
+	/*
+	 * mem_cgroup_update_tree may not be called for a memcg exceeding
+	 * soft limit due to the sampling nature of update. Don't allow
+	 * a memcg to be left out of the tree if it has too much usage
+	 * excess.
+	 */
+	if (mz && !mz->on_tree &&
+	    soft_limit_excess(mz->memcg) > SOFTLIMIT_EXCESS_THRESHOLD)
+		force_update = true;
+
 	/* threshold event is triggered in finer grain than soft limit */
-	if (unlikely(mem_cgroup_event_ratelimit(memcg,
+	if (unlikely((force_update) || mem_cgroup_event_ratelimit(memcg,
 						MEM_CGROUP_TARGET_THRESH))) {
 		bool do_softlimit;
 
 		do_softlimit = mem_cgroup_event_ratelimit(memcg,
 						MEM_CGROUP_TARGET_SOFTLIMIT);
 		mem_cgroup_threshold(memcg);
-		if (unlikely(do_softlimit))
+		if (unlikely((force_update) || do_softlimit))
 			mem_cgroup_update_tree(memcg, page);
 	}
 }
-- 
2.20.1



Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3382231E195
	for <lists+cgroups@lfdr.de>; Wed, 17 Feb 2021 22:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhBQVnr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Feb 2021 16:43:47 -0500
Received: from mga14.intel.com ([192.55.52.115]:37251 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232478AbhBQVnm (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 17 Feb 2021 16:43:42 -0500
IronPort-SDR: CSxJqeqQoDuQ+cH/498vjRF8ceZrUNQnrBREoeXm1CjS2F+2++r1tIZisNWCQv1UXGVq9K7tAT
 5MZmx3URE1xg==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="182538757"
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="182538757"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 13:41:55 -0800
IronPort-SDR: 9Hq9KtM7miCiBDav7pvUqi5nyuDRGHZpaD7BBiidOVHP9uYoSc5++KYkN6vXYDuFE8r3evNcC+
 tofPWpXB6Xqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="401430712"
Received: from skl-02.jf.intel.com ([10.54.74.28])
  by orsmga007.jf.intel.com with ESMTP; 17 Feb 2021 13:41:55 -0800
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] mm: Force update of mem cgroup soft limit tree on usage excess
Date:   Wed, 17 Feb 2021 12:41:35 -0800
Message-Id: <06f1f92f1f7d4e57c4e20c97f435252c16c60a27.1613584277.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1613584277.git.tim.c.chen@linux.intel.com>
References: <cover.1613584277.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

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

Reviewed-by: Ying Huang <ying.huang@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 mm/memcontrol.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a51bf90732cb..d72449eeb85a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -985,15 +985,22 @@ static bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
  */
 static void memcg_check_events(struct mem_cgroup *memcg, struct page *page)
 {
+	struct mem_cgroup_per_node *mz;
+	bool force_update = false;
+
+	mz = mem_cgroup_nodeinfo(memcg, page_to_nid(page));
+	if (mz && !mz->on_tree && soft_limit_excess(mz->memcg) > 0)
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


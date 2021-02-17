Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315CA31E193
	for <lists+cgroups@lfdr.de>; Wed, 17 Feb 2021 22:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbhBQVnm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Feb 2021 16:43:42 -0500
Received: from mga14.intel.com ([192.55.52.115]:37248 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232355AbhBQVnl (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 17 Feb 2021 16:43:41 -0500
IronPort-SDR: 0PQl3/aoqTkDfyZ3aZKKMZaR+2RMND3GZqkeJEIVH7/J/4hhJOTeStJkfRBQzFlgMXwhGyB2Bi
 bb8MMKCB02Cw==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="182538752"
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="182538752"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 13:41:52 -0800
IronPort-SDR: gQswESc8jFJCnGPHICQznAp1G92RTJTrzHTvajwRGCPDLpJzqZfkC8RbeDPAX+SmqhuWKVZuxY
 gvB7cnNEntVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="401430707"
Received: from skl-02.jf.intel.com ([10.54.74.28])
  by orsmga007.jf.intel.com with ESMTP; 17 Feb 2021 13:41:52 -0800
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] mm: Fix dropped memcg from mem cgroup soft limit tree
Date:   Wed, 17 Feb 2021 12:41:34 -0800
Message-Id: <8d35206601ccf0e1fe021d24405b2a0c2f4e052f.1613584277.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1613584277.git.tim.c.chen@linux.intel.com>
References: <cover.1613584277.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

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

Reviewed-by: Ying Huang <ying.huang@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 mm/memcontrol.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ed5cc78a8dbf..a51bf90732cb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3505,8 +3505,12 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 			loop > MEM_CGROUP_MAX_SOFT_LIMIT_RECLAIM_LOOPS))
 			break;
 	} while (!nr_reclaimed);
-	if (next_mz)
+	if (next_mz) {
+		spin_lock_irq(&mctz->lock);
+		__mem_cgroup_insert_exceeded(next_mz, mctz, excess);
+		spin_unlock_irq(&mctz->lock);
 		css_put(&next_mz->memcg->css);
+	}
 	return nr_reclaimed;
 }
 
-- 
2.20.1


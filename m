Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73FFB315955
	for <lists+cgroups@lfdr.de>; Tue,  9 Feb 2021 23:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbhBIWVb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Feb 2021 17:21:31 -0500
Received: from mga12.intel.com ([192.55.52.136]:8467 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231395AbhBIWLG (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 9 Feb 2021 17:11:06 -0500
IronPort-SDR: BqpNjUBAt8Oeg9Z+FKo5kPTGcpnKBMsxBkM7iaBfZ+l0zWn8t7z6+k9kPWIXCAugjKbep0wZzX
 VBCiYTTBsWcw==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="161113142"
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="161113142"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 13:30:34 -0800
IronPort-SDR: LudR3XWil918DSthPWyyBqoO8EWHAOIRC8WyvaRhVpXmHic1CIkS6jcfhCD68569+SMYdn4DS/
 xKcXcqLESlDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="361953013"
Received: from skl-02.jf.intel.com ([10.54.74.28])
  by orsmga006.jf.intel.com with ESMTP; 09 Feb 2021 13:30:34 -0800
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mm: Fix dropped memcg from mem cgroup soft limit tree
Date:   Tue,  9 Feb 2021 12:29:45 -0800
Message-Id: <d50e3bb513845d1f7816b94733576ce6f798682a.1612902157.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1612902157.git.tim.c.chen@linux.intel.com>
References: <cover.1612902157.git.tim.c.chen@linux.intel.com>
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


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C15835469A
	for <lists+cgroups@lfdr.de>; Mon,  5 Apr 2021 20:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbhDESJ1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Apr 2021 14:09:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:44462 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239964AbhDESJR (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 5 Apr 2021 14:09:17 -0400
IronPort-SDR: 6+SZBlIoK940qfNjJiaofpHbj6n4Qk4OfTy73HveZL4Thz/qFRrNZNUZ/0ohvLwr5LasojR/Zi
 3jFPjfo6rtLw==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="193010980"
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="193010980"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 11:09:11 -0700
IronPort-SDR: 0xW5HPtaRmBNDOzGdePrXlWBYYSSOULrHjmoKovNYHXubrBvKHI5PkcdihG+mW6p0cdusOgqex
 KqVm4nR3S91Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="448153945"
Received: from skl-02.jf.intel.com ([10.54.74.28])
  by fmsmga002.fm.intel.com with ESMTP; 05 Apr 2021 11:09:10 -0700
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Michal Hocko <mhocko@suse.cz>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 08/11] mm: Add toptier option for mem_cgroup_soft_limit_reclaim()
Date:   Mon,  5 Apr 2021 10:08:32 -0700
Message-Id: <babf74082f450ece2fd55bd5ca9a1857fd32c307.1617642417.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617642417.git.tim.c.chen@linux.intel.com>
References: <cover.1617642417.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Add toptier relcaim type in mem_cgroup_soft_limit_reclaim().
This option reclaims top tier memory from cgroups in the order of its
excess usage of top tier memory.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 include/linux/memcontrol.h |  9 ++++---
 mm/memcontrol.c            | 48 ++++++++++++++++++++++++--------------
 mm/vmscan.c                |  4 ++--
 3 files changed, 39 insertions(+), 22 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0ed8ddfd5436..c494c4b11ba2 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -21,6 +21,7 @@
 #include <linux/vmstat.h>
 #include <linux/writeback.h>
 #include <linux/page-flags.h>
+#include <linux/nodemask.h>
 
 struct mem_cgroup;
 struct obj_cgroup;
@@ -1003,7 +1004,8 @@ static inline void mod_memcg_lruvec_state(struct lruvec *lruvec,
 
 unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 						gfp_t gfp_mask,
-						unsigned long *total_scanned);
+						unsigned long *total_scanned,
+						enum node_states type);
 
 void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
 			  unsigned long count);
@@ -1421,8 +1423,9 @@ static inline void mod_lruvec_kmem_state(void *p, enum node_stat_item idx,
 
 static inline
 unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
-					    gfp_t gfp_mask,
-					    unsigned long *total_scanned)
+						gfp_t gfp_mask,
+						unsigned long *total_scanned,
+						enum node_states type)
 {
 	return 0;
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8a7648b79635..9f75475ae833 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1875,7 +1875,8 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
 static int mem_cgroup_soft_reclaim(struct mem_cgroup *root_memcg,
 				   pg_data_t *pgdat,
 				   gfp_t gfp_mask,
-				   unsigned long *total_scanned)
+				   unsigned long *total_scanned,
+				   enum node_states type)
 {
 	struct mem_cgroup *victim = NULL;
 	int total = 0;
@@ -1886,7 +1887,7 @@ static int mem_cgroup_soft_reclaim(struct mem_cgroup *root_memcg,
 		.pgdat = pgdat,
 	};
 
-	excess = soft_limit_excess(root_memcg, N_MEMORY);
+	excess = soft_limit_excess(root_memcg, type);
 
 	while (1) {
 		victim = mem_cgroup_iter(root_memcg, victim, &reclaim);
@@ -1915,7 +1916,7 @@ static int mem_cgroup_soft_reclaim(struct mem_cgroup *root_memcg,
 		total += mem_cgroup_shrink_node(victim, gfp_mask, false,
 					pgdat, &nr_scanned);
 		*total_scanned += nr_scanned;
-		if (!soft_limit_excess(root_memcg, N_MEMORY))
+		if (!soft_limit_excess(root_memcg, type))
 			break;
 	}
 	mem_cgroup_iter_break(root_memcg, victim);
@@ -3524,7 +3525,8 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
 
 unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 					    gfp_t gfp_mask,
-					    unsigned long *total_scanned)
+					    unsigned long *total_scanned,
+					    enum node_states type)
 {
 	unsigned long nr_reclaimed = 0;
 	struct mem_cgroup_per_node *mz, *next_mz = NULL;
@@ -3534,12 +3536,24 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 	unsigned long excess;
 	unsigned long nr_scanned;
 	int migration_nid;
+	enum node_states sibling_type;
 
 	if (order > 0)
 		return 0;
 
-	mctz = soft_limit_tree_node(pgdat->node_id, N_MEMORY);
-	mctz_sibling = soft_limit_tree_node(pgdat->node_id, N_TOPTIER);
+	if (type != N_MEMORY && type != N_TOPTIER)
+		return 0;
+
+	if (type == N_TOPTIER && !node_state(pgdat->node_id, N_TOPTIER))
+		return 0;
+
+	if (type == N_TOPTIER)
+		sibling_type = N_MEMORY;
+	else
+		sibling_type = N_TOPTIER;
+
+	mctz = soft_limit_tree_node(pgdat->node_id, type);
+	mctz_sibling = soft_limit_tree_node(pgdat->node_id, sibling_type);
 
 	/*
 	 * Do not even bother to check the largest node if the root
@@ -3558,11 +3572,11 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 	if (migration_nid != -1) {
 		struct mem_cgroup_tree_per_node *mmctz;
 
-		mmctz = soft_limit_tree_node(migration_nid);
+		mmctz = soft_limit_tree_node(migration_nid, type);
 		if (mmctz && !RB_EMPTY_ROOT(&mmctz->rb_root)) {
 			pgdat = NODE_DATA(migration_nid);
 			return mem_cgroup_soft_limit_reclaim(pgdat, order,
-				gfp_mask, total_scanned);
+				gfp_mask, total_scanned, type);
 		}
 	}
 
@@ -3575,17 +3589,17 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 		if (next_mz)
 			mz = next_mz;
 		else
-			mz = mem_cgroup_largest_soft_limit_node(mctz, N_MEMORY);
+			mz = mem_cgroup_largest_soft_limit_node(mctz, type);
 		if (!mz)
 			break;
 
 		nr_scanned = 0;
 		reclaimed = mem_cgroup_soft_reclaim(mz->memcg, pgdat,
-						    gfp_mask, &nr_scanned);
+						    gfp_mask, &nr_scanned, type);
 		nr_reclaimed += reclaimed;
 		*total_scanned += nr_scanned;
 		spin_lock_irq(&mctz->lock);
-		__mem_cgroup_remove_exceeded(mz, mctz, N_MEMORY);
+		__mem_cgroup_remove_exceeded(mz, mctz, type);
 
 		/*
 		 * If we failed to reclaim anything from this memory cgroup
@@ -3594,9 +3608,9 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 		next_mz = NULL;
 		if (!reclaimed)
 			next_mz =
-			   __mem_cgroup_largest_soft_limit_node(mctz, N_MEMORY);
+			   __mem_cgroup_largest_soft_limit_node(mctz, type);
 
-		excess = soft_limit_excess(mz->memcg, N_MEMORY);
+		excess = soft_limit_excess(mz->memcg, type);
 		/*
 		 * One school of thought says that we should not add
 		 * back the node to the tree if reclaim returns 0.
@@ -3606,17 +3620,17 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 		 * term TODO.
 		 */
 		/* If excess == 0, no tree ops */
-		__mem_cgroup_insert_exceeded(mz, mctz, excess, N_MEMORY);
+		__mem_cgroup_insert_exceeded(mz, mctz, excess, type);
 		spin_unlock_irq(&mctz->lock);
 
 		/* update both affected N_MEMORY and N_TOPTIER trees */
 		if (mctz_sibling) {
 			spin_lock_irq(&mctz_sibling->lock);
 			__mem_cgroup_remove_exceeded(mz, mctz_sibling,
-						     N_TOPTIER);
-			excess = soft_limit_excess(mz->memcg, N_TOPTIER);
+						     sibling_type);
+			excess = soft_limit_excess(mz->memcg, sibling_type);
 			__mem_cgroup_insert_exceeded(mz, mctz, excess,
-						     N_TOPTIER);
+						     sibling_type);
 			spin_unlock_irq(&mctz_sibling->lock);
 		}
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 3b200b7170a9..11bb0c6fa524 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3134,7 +3134,7 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 			nr_soft_scanned = 0;
 			nr_soft_reclaimed = mem_cgroup_soft_limit_reclaim(zone->zone_pgdat,
 						sc->order, sc->gfp_mask,
-						&nr_soft_scanned);
+						&nr_soft_scanned, N_MEMORY);
 			sc->nr_reclaimed += nr_soft_reclaimed;
 			sc->nr_scanned += nr_soft_scanned;
 			/* need some check for avoid more shrink_zone() */
@@ -3849,7 +3849,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 		sc.nr_scanned = 0;
 		nr_soft_scanned = 0;
 		nr_soft_reclaimed = mem_cgroup_soft_limit_reclaim(pgdat, sc.order,
-						sc.gfp_mask, &nr_soft_scanned);
+						sc.gfp_mask, &nr_soft_scanned, N_MEMORY);
 		sc.nr_reclaimed += nr_soft_reclaimed;
 
 		/*
-- 
2.20.1


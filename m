Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17869354697
	for <lists+cgroups@lfdr.de>; Mon,  5 Apr 2021 20:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbhDESJY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Apr 2021 14:09:24 -0400
Received: from mga09.intel.com ([134.134.136.24]:44462 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234661AbhDESJL (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 5 Apr 2021 14:09:11 -0400
IronPort-SDR: 4/R6l77dWj++9X0dFG2St2dAeAJ3PbPrhp2vvGDhj8DP4ALBhCoVFxQn+HryImAFjdbjOaWviI
 TOX0m01lmAeQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="193010934"
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="193010934"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 11:09:05 -0700
IronPort-SDR: dqiazJeDK+5dnrLq82BR3rtp/1vJ1y/Xf2Kr8yfYi7ZHLqw5nCAi+y3mvFlQ+nLNp5VEX6GwQH
 yoQOMuM6C30w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="448153918"
Received: from skl-02.jf.intel.com ([10.54.74.28])
  by fmsmga002.fm.intel.com with ESMTP; 05 Apr 2021 11:09:04 -0700
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
Subject: [RFC PATCH v1 05/11] mm: Add soft_limit_top_tier tree for mem cgroup
Date:   Mon,  5 Apr 2021 10:08:29 -0700
Message-Id: <04b7c9bce901d271eae216dcfbb928aadc8d48d0.1617642417.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617642417.git.tim.c.chen@linux.intel.com>
References: <cover.1617642417.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Define a per node soft_limit_top_tier red black tree that sort and track
the cgroups by each group's excess over its toptier soft limit.  A cgroup
is added to the tree if it has exceeded its top tier soft limit and it
has used pages on the node.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 mm/memcontrol.c | 68 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 52 insertions(+), 16 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 68590f46fa76..90a78ff3fca8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -122,6 +122,7 @@ struct mem_cgroup_tree {
 };
 
 static struct mem_cgroup_tree soft_limit_tree __read_mostly;
+static struct mem_cgroup_tree soft_limit_toptier_tree __read_mostly;
 
 /* for OOM */
 struct mem_cgroup_eventfd_list {
@@ -590,17 +591,27 @@ mem_cgroup_page_nodeinfo(struct mem_cgroup *memcg, struct page *page)
 }
 
 static struct mem_cgroup_tree_per_node *
-soft_limit_tree_node(int nid)
-{
-	return soft_limit_tree.rb_tree_per_node[nid];
+soft_limit_tree_node(int nid, enum node_states type)
+{
+	switch (type) {
+	case N_MEMORY:
+		return soft_limit_tree.rb_tree_per_node[nid];
+	case N_TOPTIER:
+		if (node_state(nid, N_TOPTIER))
+			return soft_limit_toptier_tree.rb_tree_per_node[nid];
+		else
+			return NULL;
+	default:
+		return NULL;
+	}
 }
 
 static struct mem_cgroup_tree_per_node *
-soft_limit_tree_from_page(struct page *page)
+soft_limit_tree_from_page(struct page *page, enum node_states type)
 {
 	int nid = page_to_nid(page);
 
-	return soft_limit_tree.rb_tree_per_node[nid];
+	return soft_limit_tree_node(nid, type);
 }
 
 static void __mem_cgroup_insert_exceeded(struct mem_cgroup_per_node *mz,
@@ -661,12 +672,24 @@ static void mem_cgroup_remove_exceeded(struct mem_cgroup_per_node *mz,
 	spin_unlock_irqrestore(&mctz->lock, flags);
 }
 
-static unsigned long soft_limit_excess(struct mem_cgroup *memcg)
+static unsigned long soft_limit_excess(struct mem_cgroup *memcg, enum node_states type)
 {
-	unsigned long nr_pages = page_counter_read(&memcg->memory);
-	unsigned long soft_limit = READ_ONCE(memcg->soft_limit);
+	unsigned long nr_pages;
+	unsigned long soft_limit;
 	unsigned long excess = 0;
 
+	switch (type) {
+	case N_MEMORY:
+		nr_pages = page_counter_read(&memcg->memory);
+		soft_limit = READ_ONCE(memcg->soft_limit);
+		break;
+	case N_TOPTIER:
+		nr_pages = page_counter_read(&memcg->toptier);
+		soft_limit = READ_ONCE(memcg->toptier_soft_limit);
+		break;
+	default:
+		return 0;
+	}
 	if (nr_pages > soft_limit)
 		excess = nr_pages - soft_limit;
 
@@ -679,7 +702,7 @@ static void mem_cgroup_update_tree(struct mem_cgroup *memcg, struct page *page)
 	struct mem_cgroup_per_node *mz;
 	struct mem_cgroup_tree_per_node *mctz;
 
-	mctz = soft_limit_tree_from_page(page);
+	mctz = soft_limit_tree_from_page(page, N_MEMORY);
 	if (!mctz)
 		return;
 	/*
@@ -688,7 +711,7 @@ static void mem_cgroup_update_tree(struct mem_cgroup *memcg, struct page *page)
 	 */
 	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
 		mz = mem_cgroup_page_nodeinfo(memcg, page);
-		excess = soft_limit_excess(memcg);
+		excess = soft_limit_excess(memcg, N_MEMORY);
 		/*
 		 * We have to update the tree if mz is on RB-tree or
 		 * mem is over its softlimit.
@@ -718,7 +741,7 @@ static void mem_cgroup_remove_from_trees(struct mem_cgroup *memcg)
 
 	for_each_node(nid) {
 		mz = mem_cgroup_nodeinfo(memcg, nid);
-		mctz = soft_limit_tree_node(nid);
+		mctz = soft_limit_tree_node(nid, N_MEMORY);
 		if (mctz)
 			mem_cgroup_remove_exceeded(mz, mctz);
 	}
@@ -742,7 +765,7 @@ __mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
 	 * position in the tree.
 	 */
 	__mem_cgroup_remove_exceeded(mz, mctz);
-	if (!soft_limit_excess(mz->memcg) ||
+	if (!soft_limit_excess(mz->memcg, N_MEMORY) ||
 	    !css_tryget(&mz->memcg->css))
 		goto retry;
 done:
@@ -1805,7 +1828,7 @@ static int mem_cgroup_soft_reclaim(struct mem_cgroup *root_memcg,
 		.pgdat = pgdat,
 	};
 
-	excess = soft_limit_excess(root_memcg);
+	excess = soft_limit_excess(root_memcg, N_MEMORY);
 
 	while (1) {
 		victim = mem_cgroup_iter(root_memcg, victim, &reclaim);
@@ -1834,7 +1857,7 @@ static int mem_cgroup_soft_reclaim(struct mem_cgroup *root_memcg,
 		total += mem_cgroup_shrink_node(victim, gfp_mask, false,
 					pgdat, &nr_scanned);
 		*total_scanned += nr_scanned;
-		if (!soft_limit_excess(root_memcg))
+		if (!soft_limit_excess(root_memcg, N_MEMORY))
 			break;
 	}
 	mem_cgroup_iter_break(root_memcg, victim);
@@ -3457,7 +3480,7 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 	if (order > 0)
 		return 0;
 
-	mctz = soft_limit_tree_node(pgdat->node_id);
+	mctz = soft_limit_tree_node(pgdat->node_id, N_MEMORY);
 
 	/*
 	 * Do not even bother to check the largest node if the root
@@ -3513,7 +3536,7 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 		if (!reclaimed)
 			next_mz = __mem_cgroup_largest_soft_limit_node(mctz);
 
-		excess = soft_limit_excess(mz->memcg);
+		excess = soft_limit_excess(mz->memcg, N_MEMORY);
 		/*
 		 * One school of thought says that we should not add
 		 * back the node to the tree if reclaim returns 0.
@@ -7189,6 +7212,19 @@ static int __init mem_cgroup_init(void)
 		rtpn->rb_rightmost = NULL;
 		spin_lock_init(&rtpn->lock);
 		soft_limit_tree.rb_tree_per_node[node] = rtpn;
+
+		if (!node_state(node, N_TOPTIER)) {
+			soft_limit_toptier_tree.rb_tree_per_node[node] = NULL;
+			continue;
+		}
+
+		rtpn = kzalloc_node(sizeof(*rtpn), GFP_KERNEL,
+				    node_online(node) ? node : NUMA_NO_NODE);
+
+		rtpn->rb_root = RB_ROOT;
+		rtpn->rb_rightmost = NULL;
+		spin_lock_init(&rtpn->lock);
+		soft_limit_toptier_tree.rb_tree_per_node[node] = rtpn;
 	}
 
 	return 0;
-- 
2.20.1


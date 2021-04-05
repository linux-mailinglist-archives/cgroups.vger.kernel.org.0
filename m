Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0933354699
	for <lists+cgroups@lfdr.de>; Mon,  5 Apr 2021 20:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240052AbhDESJ0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Apr 2021 14:09:26 -0400
Received: from mga09.intel.com ([134.134.136.24]:44462 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238390AbhDESJP (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 5 Apr 2021 14:09:15 -0400
IronPort-SDR: NrZaeHY4DdiNxlAPXNaea0cPqrJeg+0Yk9bRAT5bU7wTBMBwI6KZblg7rKSsOww95sXEFCJV4Y
 FaHk0DLxcoLg==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="193010951"
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="193010951"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 11:09:08 -0700
IronPort-SDR: zciwvXhVlJxANCS1RQuETFmvpI/SVAShGiAS1SOFk+fup6XS3eaAdNiHzq00W3PW/LzFQBiUp1
 11xpUJFo26pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="448153935"
Received: from skl-02.jf.intel.com ([10.54.74.28])
  by fmsmga002.fm.intel.com with ESMTP; 05 Apr 2021 11:09:08 -0700
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
Subject: [RFC PATCH v1 07/11] mm: Account the total top tier memory in use
Date:   Mon,  5 Apr 2021 10:08:31 -0700
Message-Id: <9170c90b0f58dee05a2b2c1d3789d674df42ed65.1617642417.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617642417.git.tim.c.chen@linux.intel.com>
References: <cover.1617642417.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Track the global top tier memory usage stats. They are used as the basis of
deciding when to start demoting pages from memory cgroups that have exceeded
their soft limit.  We start reclaiming top tier memory when the total
top tier memory is low.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 include/linux/vmstat.h | 18 ++++++++++++++++++
 mm/vmstat.c            | 20 +++++++++++++++++---
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index e1a4fa9abb3a..a3ad5a937fd8 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -139,6 +139,7 @@ static inline void vm_events_fold_cpu(int cpu)
  * Zone and node-based page accounting with per cpu differentials.
  */
 extern atomic_long_t vm_zone_stat[NR_VM_ZONE_STAT_ITEMS];
+extern atomic_long_t vm_toptier_zone_stat[NR_VM_ZONE_STAT_ITEMS];
 extern atomic_long_t vm_numa_stat[NR_VM_NUMA_STAT_ITEMS];
 extern atomic_long_t vm_node_stat[NR_VM_NODE_STAT_ITEMS];
 
@@ -175,6 +176,8 @@ static inline void zone_page_state_add(long x, struct zone *zone,
 {
 	atomic_long_add(x, &zone->vm_stat[item]);
 	atomic_long_add(x, &vm_zone_stat[item]);
+	if (node_state(zone->zone_pgdat->node_id, N_TOPTIER))
+		atomic_long_add(x, &vm_toptier_zone_stat[item]);
 }
 
 static inline void node_page_state_add(long x, struct pglist_data *pgdat,
@@ -212,6 +215,17 @@ static inline unsigned long global_node_page_state(enum node_stat_item item)
 	return global_node_page_state_pages(item);
 }
 
+static inline unsigned long global_toptier_zone_page_state(enum zone_stat_item item)
+{
+	long x = atomic_long_read(&vm_toptier_zone_stat[item]);
+
+#ifdef CONFIG_SMP
+	if (x < 0)
+		x = 0;
+#endif
+	return x;
+}
+
 static inline unsigned long zone_page_state(struct zone *zone,
 					enum zone_stat_item item)
 {
@@ -325,6 +339,8 @@ static inline void __inc_zone_state(struct zone *zone, enum zone_stat_item item)
 {
 	atomic_long_inc(&zone->vm_stat[item]);
 	atomic_long_inc(&vm_zone_stat[item]);
+	if (node_state(zone->zone_pgdat->node_id, N_TOPTIER))
+		atomic_long_inc(&vm_toptier_zone_stat[item]);
 }
 
 static inline void __inc_node_state(struct pglist_data *pgdat, enum node_stat_item item)
@@ -337,6 +353,8 @@ static inline void __dec_zone_state(struct zone *zone, enum zone_stat_item item)
 {
 	atomic_long_dec(&zone->vm_stat[item]);
 	atomic_long_dec(&vm_zone_stat[item]);
+	if (node_state(zone->zone_pgdat->node_id, N_TOPTIER))
+		atomic_long_dec(&vm_toptier_zone_stat[item]);
 }
 
 static inline void __dec_node_state(struct pglist_data *pgdat, enum node_stat_item item)
diff --git a/mm/vmstat.c b/mm/vmstat.c
index f299d2e89acb..b59efbcaef4e 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -161,9 +161,11 @@ void vm_events_fold_cpu(int cpu)
  * vm_stat contains the global counters
  */
 atomic_long_t vm_zone_stat[NR_VM_ZONE_STAT_ITEMS] __cacheline_aligned_in_smp;
+atomic_long_t vm_toptier_zone_stat[NR_VM_ZONE_STAT_ITEMS] __cacheline_aligned_in_smp;
 atomic_long_t vm_numa_stat[NR_VM_NUMA_STAT_ITEMS] __cacheline_aligned_in_smp;
 atomic_long_t vm_node_stat[NR_VM_NODE_STAT_ITEMS] __cacheline_aligned_in_smp;
 EXPORT_SYMBOL(vm_zone_stat);
+EXPORT_SYMBOL(vm_toptier_zone_stat);
 EXPORT_SYMBOL(vm_numa_stat);
 EXPORT_SYMBOL(vm_node_stat);
 
@@ -695,7 +697,7 @@ EXPORT_SYMBOL(dec_node_page_state);
  * Returns the number of counters updated.
  */
 #ifdef CONFIG_NUMA
-static int fold_diff(int *zone_diff, int *numa_diff, int *node_diff)
+static int fold_diff(int *zone_diff, int *numa_diff, int *node_diff, int *toptier_diff)
 {
 	int i;
 	int changes = 0;
@@ -717,6 +719,11 @@ static int fold_diff(int *zone_diff, int *numa_diff, int *node_diff)
 			atomic_long_add(node_diff[i], &vm_node_stat[i]);
 			changes++;
 	}
+
+	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++)
+		if (toptier_diff[i]) {
+			atomic_long_add(toptier_diff[i], &vm_toptier_zone_stat[i]);
+	}
 	return changes;
 }
 #else
@@ -762,6 +769,7 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
 	struct zone *zone;
 	int i;
 	int global_zone_diff[NR_VM_ZONE_STAT_ITEMS] = { 0, };
+	int global_toptier_diff[NR_VM_ZONE_STAT_ITEMS] = { 0, };
 #ifdef CONFIG_NUMA
 	int global_numa_diff[NR_VM_NUMA_STAT_ITEMS] = { 0, };
 #endif
@@ -779,6 +787,9 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
 
 				atomic_long_add(v, &zone->vm_stat[i]);
 				global_zone_diff[i] += v;
+				if (node_state(zone->zone_pgdat->node_id, N_TOPTIER)) {
+					global_toptier_diff[i] +=v;
+				}
 #ifdef CONFIG_NUMA
 				/* 3 seconds idle till flush */
 				__this_cpu_write(p->expire, 3);
@@ -846,7 +857,7 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
 
 #ifdef CONFIG_NUMA
 	changes += fold_diff(global_zone_diff, global_numa_diff,
-			     global_node_diff);
+			     global_node_diff, global_toptier_diff);
 #else
 	changes += fold_diff(global_zone_diff, global_node_diff);
 #endif
@@ -868,6 +879,7 @@ void cpu_vm_stats_fold(int cpu)
 	int global_numa_diff[NR_VM_NUMA_STAT_ITEMS] = { 0, };
 #endif
 	int global_node_diff[NR_VM_NODE_STAT_ITEMS] = { 0, };
+	int global_toptier_diff[NR_VM_NODE_STAT_ITEMS] = { 0, };
 
 	for_each_populated_zone(zone) {
 		struct per_cpu_pageset *p;
@@ -910,11 +922,13 @@ void cpu_vm_stats_fold(int cpu)
 				p->vm_node_stat_diff[i] = 0;
 				atomic_long_add(v, &pgdat->vm_stat[i]);
 				global_node_diff[i] += v;
+				if (node_state(pgdat->node_id, N_TOPTIER))
+					global_toptier_diff[i] +=v;
 			}
 	}
 
 #ifdef CONFIG_NUMA
-	fold_diff(global_zone_diff, global_numa_diff, global_node_diff);
+	fold_diff(global_zone_diff, global_numa_diff, global_node_diff, global_toptier_diff);
 #else
 	fold_diff(global_zone_diff, global_node_diff);
 #endif
-- 
2.20.1


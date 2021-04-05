Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36BB35469C
	for <lists+cgroups@lfdr.de>; Mon,  5 Apr 2021 20:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237321AbhDESJ1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Apr 2021 14:09:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:44462 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240003AbhDESJT (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 5 Apr 2021 14:09:19 -0400
IronPort-SDR: w/7CJ+4awTzPK1F6xQ1zGRil1cY83RAKfs3dFeYOkCeVbu6FCHCK4T1WXDuJCPqoly/R5ZJ/9l
 X7xkRmC/eQ8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="193010984"
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="193010984"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 11:09:12 -0700
IronPort-SDR: uRJWNIEvIVenX3zhCfRavpX69HZihlo15E+HdqNsuhc8s2r9sEnAo//jTyEmVjEzmIsM3NyzhF
 6er8odyQGP3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="448153952"
Received: from skl-02.jf.intel.com ([10.54.74.28])
  by fmsmga002.fm.intel.com with ESMTP; 05 Apr 2021 11:09:12 -0700
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
Subject: [RFC PATCH v1 09/11] mm: Use kswapd to demote pages when toptier memory is tight
Date:   Mon,  5 Apr 2021 10:08:33 -0700
Message-Id: <83c06bf70e38360358c84daab399f18f57e7eba4.1617642417.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617642417.git.tim.c.chen@linux.intel.com>
References: <cover.1617642417.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Demote pages from memory cgroup that has excess
toptier memory usage when top tier memory is tight.

When free top tier memory falls below this fraction
"toptier_scale_factor/10000" of overall toptier memory in a node, kswapd
reclaims top tier memory from those mem cgroups that exceeded their
toptier memory soft limit by deomoting the top tier pages to
lower memory tier.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 Documentation/admin-guide/sysctl/vm.rst | 12 +++++
 include/linux/mmzone.h                  |  2 +
 mm/page_alloc.c                         | 14 +++++
 mm/vmscan.c                             | 69 ++++++++++++++++++++++++-
 4 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 9de3847c3469..6b49e2e90953 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -74,6 +74,7 @@ Currently, these files are in /proc/sys/vm:
 - vfs_cache_pressure
 - watermark_boost_factor
 - watermark_scale_factor
+- toptier_scale_factor
 - zone_reclaim_mode
 
 
@@ -962,6 +963,17 @@ too small for the allocation bursts occurring in the system. This knob
 can then be used to tune kswapd aggressiveness accordingly.
 
 
+toptier_scale_factor
+====================
+
+This factor controls when kswapd wakes up to demote pages of those
+cgroups that have exceeded their memory soft limit.
+
+The unit is in fractions of 10,000. The default value of 2000 means the
+if there are less than 20% of free top tier memory in the
+node/system, we will start to demote pages of those memory cgroups
+that have exceeded their soft memory limit.
+
 zone_reclaim_mode
 =================
 
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index bbe649c4fdee..4ee0073d255f 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -332,12 +332,14 @@ enum zone_watermarks {
 	WMARK_MIN,
 	WMARK_LOW,
 	WMARK_HIGH,
+	WMARK_TOPTIER,
 	NR_WMARK
 };
 
 #define min_wmark_pages(z) (z->_watermark[WMARK_MIN] + z->watermark_boost)
 #define low_wmark_pages(z) (z->_watermark[WMARK_LOW] + z->watermark_boost)
 #define high_wmark_pages(z) (z->_watermark[WMARK_HIGH] + z->watermark_boost)
+#define toptier_wmark_pages(z) (z->_watermark[WMARK_TOPTIER] + z->watermark_boost)
 #define wmark_pages(z, i) (z->_watermark[i] + z->watermark_boost)
 
 struct per_cpu_pages {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 471a2c342c4f..20f3caee60f3 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7964,6 +7964,20 @@ static void __setup_per_zone_wmarks(void)
 		zone->_watermark[WMARK_LOW]  = min_wmark_pages(zone) + tmp;
 		zone->_watermark[WMARK_HIGH] = min_wmark_pages(zone) + tmp * 2;
 
+		tmp = mult_frac(zone_managed_pages(zone),
+				toptier_scale_factor, 10000);
+		/*
+		 * Clamp toptier watermark between twice high watermark
+		 * and max managed pages.
+		 */
+		if (tmp < 2 * zone->_watermark[WMARK_HIGH])
+			tmp = 2 * zone->_watermark[WMARK_HIGH];
+		if (tmp > zone_managed_pages(zone))
+			tmp = zone_managed_pages(zone);
+		zone->_watermark[WMARK_TOPTIER] = tmp;
+
+		zone->watermark_boost = 0;
+
 		spin_unlock_irqrestore(&zone->lock, flags);
 	}
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 11bb0c6fa524..270880c8baef 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -185,6 +185,7 @@ static void set_task_reclaim_state(struct task_struct *task,
 
 static LIST_HEAD(shrinker_list);
 static DECLARE_RWSEM(shrinker_rwsem);
+int toptier_scale_factor = 2000;
 
 #ifdef CONFIG_MEMCG
 /*
@@ -3624,6 +3625,34 @@ static bool pgdat_balanced(pg_data_t *pgdat, int order, int highest_zoneidx)
 	return false;
 }
 
+static bool pgdat_toptier_balanced(pg_data_t *pgdat, int order, int classzone_idx)
+{
+	int i;
+	unsigned long mark;
+	struct zone *zone;
+
+	zone = pgdat->node_zones + ZONE_NORMAL;
+
+	if (!node_state(pgdat->node_id, N_TOPTIER) ||
+	    next_demotion_node(pgdat->node_id) == -1 ||
+	    order > 0 || classzone_idx < ZONE_NORMAL) {
+		return true;
+	}
+
+	zone = pgdat->node_zones + ZONE_NORMAL;
+
+	if (!managed_zone(zone))
+		return true;
+
+	mark = min(toptier_wmark_pages(zone),
+		   zone_managed_pages(zone));
+
+	if (zone_page_state(zone, NR_FREE_PAGES) < mark)
+		return false;
+
+	return true;
+}
+
 /* Clear pgdat state for congested, dirty or under writeback. */
 static void clear_pgdat_congested(pg_data_t *pgdat)
 {
@@ -4049,6 +4078,39 @@ static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_o
 	finish_wait(&pgdat->kswapd_wait, &wait);
 }
 
+static bool toptier_soft_reclaim(pg_data_t *pgdat,
+			      unsigned int reclaim_order,
+			      unsigned int classzone_idx)
+{
+	unsigned long nr_soft_scanned, nr_soft_reclaimed;
+	int ret;
+	struct scan_control sc = {
+		.gfp_mask = GFP_KERNEL,
+		.order = reclaim_order,
+		.may_unmap = 1,
+	};
+
+	if (!node_state(pgdat->node_id, N_TOPTIER) || kthread_should_stop())
+		return false;
+
+	set_task_reclaim_state(current, &sc.reclaim_state);
+
+	if (!pgdat_toptier_balanced(pgdat, 0, classzone_idx)) {
+		nr_soft_scanned = 0;
+		nr_soft_reclaimed = mem_cgroup_soft_limit_reclaim(pgdat,
+					0, GFP_KERNEL,
+					&nr_soft_scanned, N_TOPTIER);
+	}
+
+	set_task_reclaim_state(current, NULL);
+
+	if (prepare_kswapd_sleep(pgdat, reclaim_order, classzone_idx) &&
+	   !kthread_should_stop())
+		return true;
+	else
+		return false;
+}
+
 /*
  * The background pageout daemon, started as a kernel thread
  * from the init process.
@@ -4108,6 +4170,10 @@ static int kswapd(void *p)
 		WRITE_ONCE(pgdat->kswapd_order, 0);
 		WRITE_ONCE(pgdat->kswapd_highest_zoneidx, MAX_NR_ZONES);
 
+		if (toptier_soft_reclaim(pgdat, 0,
+					highest_zoneidx))
+			goto kswapd_try_sleep;
+
 		ret = try_to_freeze();
 		if (kthread_should_stop())
 			break;
@@ -4173,7 +4239,8 @@ void wakeup_kswapd(struct zone *zone, gfp_t gfp_flags, int order,
 
 	/* Hopeless node, leave it to direct reclaim if possible */
 	if (pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES ||
-	    (pgdat_balanced(pgdat, order, highest_zoneidx) &&
+	    (pgdat_toptier_balanced(pgdat, 0, highest_zoneidx) &&
+	     pgdat_balanced(pgdat, order, highest_zoneidx) &&
 	     !pgdat_watermark_boosted(pgdat, highest_zoneidx))) {
 		/*
 		 * There may be plenty of free memory available, but it's too
-- 
2.20.1


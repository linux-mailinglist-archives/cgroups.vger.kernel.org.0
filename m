Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC25DE06BD
	for <lists+cgroups@lfdr.de>; Tue, 22 Oct 2019 16:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388835AbfJVOs3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Oct 2019 10:48:29 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38621 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388669AbfJVOs0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Oct 2019 10:48:26 -0400
Received: by mail-qt1-f196.google.com with SMTP id o25so13759088qtr.5
        for <cgroups@vger.kernel.org>; Tue, 22 Oct 2019 07:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y/S9YM5L03E9mp2moYFg2d0XgAPZjVTeoGAh0CaM0+A=;
        b=q12d0v3zXOV5WGnLHVwyjLzM9fmUPfDWDCKmbLLTwIQBZHcDFlV7gImPBZowyjR6Zx
         lB6pxnBBIOuyk2Pb2qr6t83Dh0tW0naxXd067CoC7FHaw1+uxUCAU4AxdOtf50nyMsT6
         aGzqFmoduz+Tvgjc10N4tOY53iU8IMjQ3m7U7otj/BRSD/OLtkOJAKzYDRFDMY/mH4oH
         DliRKULyu7UQq4GUMbNRxXw25RE60ZuZ+AnCRTeuHicS5Cv+lGttW7ixocRtQTlaQr+C
         U4md7L2wE6RKhOlePlEk2fREDYcZecEhb91bIKtFpvSiGWhN+VPltnwNhZU0ey4/Q+n0
         Ukng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y/S9YM5L03E9mp2moYFg2d0XgAPZjVTeoGAh0CaM0+A=;
        b=Gr12q+DKgy0AtNZXAntXwZBuwPhKvPeLg0WMk/pev1tna8gGCgV3XLZ7xaS2Ix2lTL
         LQsp8JaEkrtJg+5u51IjGoR2iKPoQ1zV0rUqg6BrSV4TjuV24bgsCwSC6NPeQOgua3HN
         wPO3sQTR8uIBR+eZbkHh2kiiWp/Y2rsi8lO3t/8s0Vgdv4kxBLP+dse0ALtCL8Ceuv/Y
         jQPn9vilrXQYVXsDu6rzbZ1ayEpru2mbgWO94ytOpOPz5NJXoVlRIV7T5duwEfuOt99q
         49n2CojgPsLH8TATkKrdoJ8UhLiasKs9WKKcm8lAuPul2gx7E1Jstxp9RoELUWIPNq8Q
         U8Tw==
X-Gm-Message-State: APjAAAUmuHxZ1azkFqPBBMQg37KRjiBZSxL2NuqehVJFmRGwyKCrogZP
        g8jjGJYtvqtWkd6OQn2DfhnlZQ==
X-Google-Smtp-Source: APXvYqzFOGhpHSTiy9Bfr0pdbWvQdXv5B+K83ETYEPzgzz0WiqOM/UNmdII5ZyFVY3U3lJARYdnb/Q==
X-Received: by 2002:ac8:2fd9:: with SMTP id m25mr3544986qta.177.1571755704659;
        Tue, 22 Oct 2019 07:48:24 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:10ad])
        by smtp.gmail.com with ESMTPSA id w6sm9134982qkj.136.2019.10.22.07.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 07:48:24 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 8/8] mm: vmscan: harmonize writeback congestion tracking for nodes & memcgs
Date:   Tue, 22 Oct 2019 10:48:03 -0400
Message-Id: <20191022144803.302233-9-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191022144803.302233-1-hannes@cmpxchg.org>
References: <20191022144803.302233-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The current writeback congestion tracking has separate flags for
kswapd reclaim (node level) and cgroup limit reclaim (memcg-node
level). This is unnecessarily complicated: the lruvec is an existing
abstraction layer for that node-memcg intersection.

Introduce lruvec->flags and LRUVEC_CONGESTED. Then track that at the
reclaim root level, which is either the NUMA node for global reclaim,
or the cgroup-node intersection for cgroup reclaim.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/memcontrol.h |  6 +--
 include/linux/mmzone.h     | 11 ++++--
 mm/vmscan.c                | 80 ++++++++++++--------------------------
 3 files changed, 36 insertions(+), 61 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 498cea07cbb1..d8ffcf60440c 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -133,9 +133,6 @@ struct mem_cgroup_per_node {
 	unsigned long		usage_in_excess;/* Set to the value by which */
 						/* the soft limit is exceeded*/
 	bool			on_tree;
-	bool			congested;	/* memcg has many dirty pages */
-						/* backed by a congested BDI */
-
 	struct mem_cgroup	*memcg;		/* Back pointer, we cannot */
 						/* use container_of	   */
 };
@@ -412,6 +409,9 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
 		goto out;
 	}
 
+	if (!memcg)
+		memcg = root_mem_cgroup;
+
 	mz = mem_cgroup_nodeinfo(memcg, pgdat->node_id);
 	lruvec = &mz->lruvec;
 out:
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 449a44171026..c04b4c1f01fa 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -296,6 +296,12 @@ struct zone_reclaim_stat {
 	unsigned long		recent_scanned[2];
 };
 
+enum lruvec_flags {
+	LRUVEC_CONGESTED,		/* lruvec has many dirty pages
+					 * backed by a congested BDI
+					 */
+};
+
 struct lruvec {
 	struct list_head		lists[NR_LRU_LISTS];
 	struct zone_reclaim_stat	reclaim_stat;
@@ -303,6 +309,8 @@ struct lruvec {
 	atomic_long_t			inactive_age;
 	/* Refaults at the time of last reclaim cycle */
 	unsigned long			refaults;
+	/* Various lruvec state flags (enum lruvec_flags) */
+	unsigned long			flags;
 #ifdef CONFIG_MEMCG
 	struct pglist_data *pgdat;
 #endif
@@ -572,9 +580,6 @@ struct zone {
 } ____cacheline_internodealigned_in_smp;
 
 enum pgdat_flags {
-	PGDAT_CONGESTED,		/* pgdat has many dirty pages backed by
-					 * a congested BDI
-					 */
 	PGDAT_DIRTY,			/* reclaim scanning has recently found
 					 * many dirty file pages at the tail
 					 * of the LRU.
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 65baa89740dd..3e21166d5198 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -267,29 +267,6 @@ static bool writeback_throttling_sane(struct scan_control *sc)
 #endif
 	return false;
 }
-
-static void set_memcg_congestion(pg_data_t *pgdat,
-				struct mem_cgroup *memcg,
-				bool congested)
-{
-	struct mem_cgroup_per_node *mn;
-
-	if (!memcg)
-		return;
-
-	mn = mem_cgroup_nodeinfo(memcg, pgdat->node_id);
-	WRITE_ONCE(mn->congested, congested);
-}
-
-static bool memcg_congested(pg_data_t *pgdat,
-			struct mem_cgroup *memcg)
-{
-	struct mem_cgroup_per_node *mn;
-
-	mn = mem_cgroup_nodeinfo(memcg, pgdat->node_id);
-	return READ_ONCE(mn->congested);
-
-}
 #else
 static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 {
@@ -309,18 +286,6 @@ static bool writeback_throttling_sane(struct scan_control *sc)
 {
 	return true;
 }
-
-static inline void set_memcg_congestion(struct pglist_data *pgdat,
-				struct mem_cgroup *memcg, bool congested)
-{
-}
-
-static inline bool memcg_congested(struct pglist_data *pgdat,
-			struct mem_cgroup *memcg)
-{
-	return false;
-
-}
 #endif
 
 /*
@@ -2716,12 +2681,6 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
 	return inactive_lru_pages > pages_for_compaction;
 }
 
-static bool pgdat_memcg_congested(pg_data_t *pgdat, struct mem_cgroup *memcg)
-{
-	return test_bit(PGDAT_CONGESTED, &pgdat->flags) ||
-		(memcg && memcg_congested(pgdat, memcg));
-}
-
 static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 {
 	struct mem_cgroup *root = sc->target_mem_cgroup;
@@ -2785,8 +2744,11 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	struct reclaim_state *reclaim_state = current->reclaim_state;
 	struct mem_cgroup *root = sc->target_mem_cgroup;
 	unsigned long nr_reclaimed, nr_scanned;
+	struct lruvec *target_lruvec;
 	bool reclaimable = false;
 
+	target_lruvec = mem_cgroup_lruvec(sc->target_mem_cgroup, pgdat);
+
 again:
 	memset(&sc->nr, 0, sizeof(sc->nr));
 
@@ -2829,14 +2791,6 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 		if (sc->nr.writeback && sc->nr.writeback == sc->nr.taken)
 			set_bit(PGDAT_WRITEBACK, &pgdat->flags);
 
-		/*
-		 * Tag a node as congested if all the dirty pages
-		 * scanned were backed by a congested BDI and
-		 * wait_iff_congested will stall.
-		 */
-		if (sc->nr.dirty && sc->nr.dirty == sc->nr.congested)
-			set_bit(PGDAT_CONGESTED, &pgdat->flags);
-
 		/* Allow kswapd to start writing pages during reclaim.*/
 		if (sc->nr.unqueued_dirty == sc->nr.file_taken)
 			set_bit(PGDAT_DIRTY, &pgdat->flags);
@@ -2852,12 +2806,17 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	}
 
 	/*
+	 * Tag a node/memcg as congested if all the dirty pages
+	 * scanned were backed by a congested BDI and
+	 * wait_iff_congested will stall.
+	 *
 	 * Legacy memcg will stall in page writeback so avoid forcibly
 	 * stalling in wait_iff_congested().
 	 */
-	if (cgroup_reclaim(sc) && writeback_throttling_sane(sc) &&
+	if ((current_is_kswapd() ||
+	     (cgroup_reclaim(sc) && writeback_throttling_sane(sc))) &&
 	    sc->nr.dirty && sc->nr.dirty == sc->nr.congested)
-		set_memcg_congestion(pgdat, root, true);
+		set_bit(LRUVEC_CONGESTED, &target_lruvec->flags);
 
 	/*
 	 * Stall direct reclaim for IO completions if underlying BDIs
@@ -2865,8 +2824,9 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	 * starts encountering unqueued dirty pages or cycling through
 	 * the LRU too quickly.
 	 */
-	if (!sc->hibernation_mode && !current_is_kswapd() &&
-	    current_may_throttle() && pgdat_memcg_congested(pgdat, root))
+	if (!current_is_kswapd() && current_may_throttle() &&
+	    !sc->hibernation_mode &&
+	    test_bit(LRUVEC_CONGESTED, &target_lruvec->flags))
 		wait_iff_congested(BLK_RW_ASYNC, HZ/10);
 
 	if (should_continue_reclaim(pgdat, sc->nr_reclaimed - nr_reclaimed,
@@ -3080,8 +3040,16 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
 		if (zone->zone_pgdat == last_pgdat)
 			continue;
 		last_pgdat = zone->zone_pgdat;
+
 		snapshot_refaults(sc->target_mem_cgroup, zone->zone_pgdat);
-		set_memcg_congestion(last_pgdat, sc->target_mem_cgroup, false);
+
+		if (cgroup_reclaim(sc)) {
+			struct lruvec *lruvec;
+
+			lruvec = mem_cgroup_lruvec(sc->target_mem_cgroup,
+						   zone->zone_pgdat);
+			clear_bit(LRUVEC_CONGESTED, &lruvec->flags);
+		}
 	}
 
 	delayacct_freepages_end();
@@ -3461,7 +3429,9 @@ static bool pgdat_balanced(pg_data_t *pgdat, int order, int classzone_idx)
 /* Clear pgdat state for congested, dirty or under writeback. */
 static void clear_pgdat_congested(pg_data_t *pgdat)
 {
-	clear_bit(PGDAT_CONGESTED, &pgdat->flags);
+	struct lruvec *lruvec = mem_cgroup_lruvec(NULL, pgdat);
+
+	clear_bit(LRUVEC_CONGESTED, &lruvec->flags);
 	clear_bit(PGDAT_DIRTY, &pgdat->flags);
 	clear_bit(PGDAT_WRITEBACK, &pgdat->flags);
 }
-- 
2.23.0


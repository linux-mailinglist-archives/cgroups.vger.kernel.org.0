Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64011E4F60
	for <lists+cgroups@lfdr.de>; Fri, 25 Oct 2019 16:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440001AbfJYOlt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 25 Oct 2019 10:41:49 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42186 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436853AbfJYOlt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 25 Oct 2019 10:41:49 -0400
Received: by mail-pg1-f195.google.com with SMTP id f14so1667720pgi.9
        for <cgroups@vger.kernel.org>; Fri, 25 Oct 2019 07:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zopk2n3INMhAt+O7dZr5myyb00sMWX6MG5l0pp/KS1g=;
        b=RpckThTACjR1E23JjStH5lRdoWr3JL+WZmPTnKi9fI3UV/UaYWg1Syjrb7WJtSWp0l
         ggj+G7TxRvUcfX1v9IgCWcabopmvjAOQeqkAXHVysYefzXOwNyuqfLEBJxOmnMViORNY
         J8aiyBw9bi0gTIX/c1GLURyuB5BUGQinTNAU/nUEyggHWgK1oX1/3L9nWmlM5q+pdJKi
         R8r2JrPJPkJBlzBa/O1HRz1H0aNIwJiBlflMjpuCZ8zxBauEnw6jefVaJ6DtaSLZ6IY0
         +VlCR9UaEukANTXAHuv/+iDjvaTqOPuGrpE0bR3iUZk4//KDJjZxIiFuUJ+toM2AOolh
         gyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zopk2n3INMhAt+O7dZr5myyb00sMWX6MG5l0pp/KS1g=;
        b=WgHkiCYfL2mk1lAy0sTEmKr0qM6htKLIQmQsdgEAZwHNJp+u5MVJ3f3Vckvqe/twn6
         45Aj1067d/hpgP6ikd6+VyUUsAnrcQxegNji3fIpTw22RtcAeYTMWeCkTqkJAZWSPeEc
         XCsQRYO0ZjB1K5Iu9SlCvwflH98vYjNmKUvLl184QAndIvJP2waqU7+cIWK0RiKZz41w
         fjF/yfQB1QsBVhsQixFBWl6rICcAx4Pp8ufoI1orKxlwTisOFgMStBMn52KIgFOwNbXH
         NMMWLzxByP/RDkx0lGrBTkhfywMKQxhhKALS9/ta8cvaXjt4lFoz6WEk9TO1WSDA9oHP
         Lagw==
X-Gm-Message-State: APjAAAWu2jMoCQh58FVQ3Ayl/mUqzt2SIzVFUA3BBCK/Eoj1hcLlxU32
        ok8VnC5lQ2P6I8DE2h0l9ZpNGw==
X-Google-Smtp-Source: APXvYqx86q+aCN1lktyEZI9aPO+E6UdsgrtsR3ns5lxuyvWEJVJEU2ZbOpkrSPwdtkiva6CbcH9XTA==
X-Received: by 2002:a17:90a:6305:: with SMTP id e5mr4582313pjj.24.1572014507264;
        Fri, 25 Oct 2019 07:41:47 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::553e])
        by smtp.gmail.com with ESMTPSA id j11sm2575271pgk.3.2019.10.25.07.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 07:41:46 -0700 (PDT)
Date:   Fri, 25 Oct 2019 10:41:44 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 8/8] mm: vmscan: harmonize writeback congestion tracking
 for nodes & memcgs
Message-ID: <20191025144144.GB386981@cmpxchg.org>
References: <20191022144803.302233-1-hannes@cmpxchg.org>
 <20191022144803.302233-9-hannes@cmpxchg.org>
 <20191022210352.GB24142@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022210352.GB24142@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 22, 2019 at 09:03:57PM +0000, Roman Gushchin wrote:
> On Tue, Oct 22, 2019 at 10:48:03AM -0400, Johannes Weiner wrote:
> > The current writeback congestion tracking has separate flags for
> > kswapd reclaim (node level) and cgroup limit reclaim (memcg-node
> > level). This is unnecessarily complicated: the lruvec is an existing
> > abstraction layer for that node-memcg intersection.
> > 
> > Introduce lruvec->flags and LRUVEC_CONGESTED. Then track that at the
> > reclaim root level, which is either the NUMA node for global reclaim,
> > or the cgroup-node intersection for cgroup reclaim.
> 
> Good idea!
> 
> Reviewed-by: Roman Gushchin <guro@fb.com>

Thank you.

The suggested cleanup fixlet for patch 7 causes conflicts in this
one. Here is the rebased version:

---

From 253729a7639780508b166e547d13fa7894987a87 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Mon, 11 Mar 2019 15:43:44 -0400
Subject: [PATCH] mm: vmscan: harmonize writeback congestion tracking for
 nodes & memcgs

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
 include/linux/mmzone.h     | 11 +++--
 mm/vmscan.c                | 84 ++++++++++++--------------------------
 3 files changed, 37 insertions(+), 64 deletions(-)

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
index 6199692af434..47b5c5548f3a 100644
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
 	struct mem_cgroup *target_memcg = sc->target_mem_cgroup;
@@ -2783,10 +2742,12 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 {
 	struct reclaim_state *reclaim_state = current->reclaim_state;
-	struct mem_cgroup *target_memcg = sc->target_mem_cgroup;
 	unsigned long nr_reclaimed, nr_scanned;
+	struct lruvec *target_lruvec;
 	bool reclaimable = false;
 
+	target_lruvec = mem_cgroup_lruvec(sc->target_mem_cgroup, pgdat);
+
 again:
 	memset(&sc->nr, 0, sizeof(sc->nr));
 
@@ -2801,7 +2762,7 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	}
 
 	/* Record the subtree's reclaim efficiency */
-	vmpressure(sc->gfp_mask, target_memcg, true,
+	vmpressure(sc->gfp_mask, sc->target_mem_cgroup, true,
 		   sc->nr_scanned - nr_scanned,
 		   sc->nr_reclaimed - nr_reclaimed);
 
@@ -2829,14 +2790,6 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
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
@@ -2852,12 +2805,17 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
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
-		set_memcg_congestion(pgdat, target_memcg, true);
+		set_bit(LRUVEC_CONGESTED, &target_lruvec->flags);
 
 	/*
 	 * Stall direct reclaim for IO completions if underlying BDIs
@@ -2865,9 +2823,9 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	 * starts encountering unqueued dirty pages or cycling through
 	 * the LRU too quickly.
 	 */
-	if (!sc->hibernation_mode && !current_is_kswapd() &&
-	    current_may_throttle() &&
-	    pgdat_memcg_congested(pgdat, target_memcg))
+	if (!current_is_kswapd() && current_may_throttle() &&
+	    !sc->hibernation_mode &&
+	    test_bit(LRUVEC_CONGESTED, &target_lruvec->flags))
 		wait_iff_congested(BLK_RW_ASYNC, HZ/10);
 
 	if (should_continue_reclaim(pgdat, sc->nr_reclaimed - nr_reclaimed,
@@ -3081,8 +3039,16 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
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
@@ -3462,7 +3428,9 @@ static bool pgdat_balanced(pg_data_t *pgdat, int order, int classzone_idx)
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



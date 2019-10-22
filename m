Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9475FE06B8
	for <lists+cgroups@lfdr.de>; Tue, 22 Oct 2019 16:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388389AbfJVOsX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Oct 2019 10:48:23 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46550 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388287AbfJVOsW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Oct 2019 10:48:22 -0400
Received: by mail-qt1-f195.google.com with SMTP id u22so27093760qtq.13
        for <cgroups@vger.kernel.org>; Tue, 22 Oct 2019 07:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BqchrERh+fBCV4S1nl+pMih++jK6+VDmqbtYzv8myJg=;
        b=bsgl5q1bt8l1nOFCJI4ZBKHjgyxytglXH3c8Hoq1n841wRERkIOPZ0XWOTcAbZ1nQ2
         r91S+hiPqXr91e7bxMNb3SONiWrxHtJcQ1W4xGk4YsqNBNe4ituKMOT4HpLd4uGvnwrY
         Ql5xs3Jh8h2fvVzJuQITV2Te+4qDODDAfEIFTnfFayX3swlInJuwsXj8g77mt283QUof
         Rk0DdGUfvHubbb3tpf985XnJ4n4YVdBlYfmdkSgQeSwLsdlaa4zncGrFTorUeR8EyhuG
         rTLafsoevXONL/GT40F/7TNsZcCGLmo47KU9rZlyLiSVxdcgTvRvvLIffN3TgPm1l9O2
         TvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BqchrERh+fBCV4S1nl+pMih++jK6+VDmqbtYzv8myJg=;
        b=r0PKVUpP3rwviABH5awjDJ2IjtEEMMv/zPw5mCdrIXMclLtrAN5HrHGv1vdfa7oasp
         +L5uYFrcHJE2rV06KucRpoodAW2yE67RocxgkpNTo9F7YRomopqKN0uLI22mV1Ymxwbu
         Xhq2OETM+LL2fzKzM4yBlQLvRet91Q2NJsf/VlCjEQfZfXiU58l5WfgdMOYqY5eNPv0B
         +5FFOtIMCLmeOsQMfCBBhR5NMioTE+E7wAq3JOorAZwH2ou7HfsKs+YdqmCk97OF/wVN
         YPEAlO0prGs7LCJ6FJSTg33lWJt1yghSov8K7sxGVFPQ0+UfwFzbgMryg2bb6L9FNSrK
         S27w==
X-Gm-Message-State: APjAAAVD+AlT5Ps7v2OEIld7BJooS40h4s9TXBRKLkrYpYPHirfcI1Xm
        ULBSclPrtV+hJIRgDWx/djfuwA==
X-Google-Smtp-Source: APXvYqx8CEXERtQpz0N76Hn80rVLsRCnezmuvfy2AZ4HqkuQ2wBrGfJurxeOnxdj5+/MVkSEDlhnXA==
X-Received: by 2002:ac8:6686:: with SMTP id d6mr3546623qtp.332.1571755700564;
        Tue, 22 Oct 2019 07:48:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:10ad])
        by smtp.gmail.com with ESMTPSA id d126sm6810585qkc.93.2019.10.22.07.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 07:48:20 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 5/8] mm: vmscan: replace shrink_node() loop with a retry jump
Date:   Tue, 22 Oct 2019 10:48:00 -0400
Message-Id: <20191022144803.302233-6-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191022144803.302233-1-hannes@cmpxchg.org>
References: <20191022144803.302233-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Most of the function body is inside a loop, which imposes an
additional indentation and scoping level that makes the code a bit
hard to follow and modify.

The looping only happens in case of reclaim-compaction, which isn't
the common case. So rather than adding yet another function level to
the reclaim path and have every reclaim invocation go through a level
that only exists for one specific cornercase, use a retry goto.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/vmscan.c | 231 ++++++++++++++++++++++++++--------------------------
 1 file changed, 115 insertions(+), 116 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 302dad112f75..235d1fc72311 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2729,144 +2729,143 @@ static bool pgdat_memcg_congested(pg_data_t *pgdat, struct mem_cgroup *memcg)
 static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 {
 	struct reclaim_state *reclaim_state = current->reclaim_state;
+	struct mem_cgroup *root = sc->target_mem_cgroup;
 	unsigned long nr_reclaimed, nr_scanned;
 	bool reclaimable = false;
+	struct mem_cgroup *memcg;
+again:
+	memset(&sc->nr, 0, sizeof(sc->nr));
 
-	do {
-		struct mem_cgroup *root = sc->target_mem_cgroup;
-		struct mem_cgroup *memcg;
-
-		memset(&sc->nr, 0, sizeof(sc->nr));
-
-		nr_reclaimed = sc->nr_reclaimed;
-		nr_scanned = sc->nr_scanned;
+	nr_reclaimed = sc->nr_reclaimed;
+	nr_scanned = sc->nr_scanned;
 
-		memcg = mem_cgroup_iter(root, NULL, NULL);
-		do {
-			unsigned long reclaimed;
-			unsigned long scanned;
+	memcg = mem_cgroup_iter(root, NULL, NULL);
+	do {
+		unsigned long reclaimed;
+		unsigned long scanned;
 
-			switch (mem_cgroup_protected(root, memcg)) {
-			case MEMCG_PROT_MIN:
-				/*
-				 * Hard protection.
-				 * If there is no reclaimable memory, OOM.
-				 */
+		switch (mem_cgroup_protected(root, memcg)) {
+		case MEMCG_PROT_MIN:
+			/*
+			 * Hard protection.
+			 * If there is no reclaimable memory, OOM.
+			 */
+			continue;
+		case MEMCG_PROT_LOW:
+			/*
+			 * Soft protection.
+			 * Respect the protection only as long as
+			 * there is an unprotected supply
+			 * of reclaimable memory from other cgroups.
+			 */
+			if (!sc->memcg_low_reclaim) {
+				sc->memcg_low_skipped = 1;
 				continue;
-			case MEMCG_PROT_LOW:
-				/*
-				 * Soft protection.
-				 * Respect the protection only as long as
-				 * there is an unprotected supply
-				 * of reclaimable memory from other cgroups.
-				 */
-				if (!sc->memcg_low_reclaim) {
-					sc->memcg_low_skipped = 1;
-					continue;
-				}
-				memcg_memory_event(memcg, MEMCG_LOW);
-				break;
-			case MEMCG_PROT_NONE:
-				/*
-				 * All protection thresholds breached. We may
-				 * still choose to vary the scan pressure
-				 * applied based on by how much the cgroup in
-				 * question has exceeded its protection
-				 * thresholds (see get_scan_count).
-				 */
-				break;
 			}
+			memcg_memory_event(memcg, MEMCG_LOW);
+			break;
+		case MEMCG_PROT_NONE:
+			/*
+			 * All protection thresholds breached. We may
+			 * still choose to vary the scan pressure
+			 * applied based on by how much the cgroup in
+			 * question has exceeded its protection
+			 * thresholds (see get_scan_count).
+			 */
+			break;
+		}
 
-			reclaimed = sc->nr_reclaimed;
-			scanned = sc->nr_scanned;
-			shrink_node_memcg(pgdat, memcg, sc);
-
-			shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
-					sc->priority);
-
-			/* Record the group's reclaim efficiency */
-			vmpressure(sc->gfp_mask, memcg, false,
-				   sc->nr_scanned - scanned,
-				   sc->nr_reclaimed - reclaimed);
-
-		} while ((memcg = mem_cgroup_iter(root, memcg, NULL)));
+		reclaimed = sc->nr_reclaimed;
+		scanned = sc->nr_scanned;
+		shrink_node_memcg(pgdat, memcg, sc);
 
-		if (reclaim_state) {
-			sc->nr_reclaimed += reclaim_state->reclaimed_slab;
-			reclaim_state->reclaimed_slab = 0;
-		}
+		shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
+			    sc->priority);
 
-		/* Record the subtree's reclaim efficiency */
-		vmpressure(sc->gfp_mask, sc->target_mem_cgroup, true,
-			   sc->nr_scanned - nr_scanned,
-			   sc->nr_reclaimed - nr_reclaimed);
+		/* Record the group's reclaim efficiency */
+		vmpressure(sc->gfp_mask, memcg, false,
+			   sc->nr_scanned - scanned,
+			   sc->nr_reclaimed - reclaimed);
 
-		if (sc->nr_reclaimed - nr_reclaimed)
-			reclaimable = true;
+	} while ((memcg = mem_cgroup_iter(root, memcg, NULL)));
 
-		if (current_is_kswapd()) {
-			/*
-			 * If reclaim is isolating dirty pages under writeback,
-			 * it implies that the long-lived page allocation rate
-			 * is exceeding the page laundering rate. Either the
-			 * global limits are not being effective at throttling
-			 * processes due to the page distribution throughout
-			 * zones or there is heavy usage of a slow backing
-			 * device. The only option is to throttle from reclaim
-			 * context which is not ideal as there is no guarantee
-			 * the dirtying process is throttled in the same way
-			 * balance_dirty_pages() manages.
-			 *
-			 * Once a node is flagged PGDAT_WRITEBACK, kswapd will
-			 * count the number of pages under pages flagged for
-			 * immediate reclaim and stall if any are encountered
-			 * in the nr_immediate check below.
-			 */
-			if (sc->nr.writeback && sc->nr.writeback == sc->nr.taken)
-				set_bit(PGDAT_WRITEBACK, &pgdat->flags);
+	if (reclaim_state) {
+		sc->nr_reclaimed += reclaim_state->reclaimed_slab;
+		reclaim_state->reclaimed_slab = 0;
+	}
 
-			/*
-			 * Tag a node as congested if all the dirty pages
-			 * scanned were backed by a congested BDI and
-			 * wait_iff_congested will stall.
-			 */
-			if (sc->nr.dirty && sc->nr.dirty == sc->nr.congested)
-				set_bit(PGDAT_CONGESTED, &pgdat->flags);
+	/* Record the subtree's reclaim efficiency */
+	vmpressure(sc->gfp_mask, sc->target_mem_cgroup, true,
+		   sc->nr_scanned - nr_scanned,
+		   sc->nr_reclaimed - nr_reclaimed);
 
-			/* Allow kswapd to start writing pages during reclaim.*/
-			if (sc->nr.unqueued_dirty == sc->nr.file_taken)
-				set_bit(PGDAT_DIRTY, &pgdat->flags);
+	if (sc->nr_reclaimed - nr_reclaimed)
+		reclaimable = true;
 
-			/*
-			 * If kswapd scans pages marked marked for immediate
-			 * reclaim and under writeback (nr_immediate), it
-			 * implies that pages are cycling through the LRU
-			 * faster than they are written so also forcibly stall.
-			 */
-			if (sc->nr.immediate)
-				congestion_wait(BLK_RW_ASYNC, HZ/10);
-		}
+	if (current_is_kswapd()) {
+		/*
+		 * If reclaim is isolating dirty pages under writeback,
+		 * it implies that the long-lived page allocation rate
+		 * is exceeding the page laundering rate. Either the
+		 * global limits are not being effective at throttling
+		 * processes due to the page distribution throughout
+		 * zones or there is heavy usage of a slow backing
+		 * device. The only option is to throttle from reclaim
+		 * context which is not ideal as there is no guarantee
+		 * the dirtying process is throttled in the same way
+		 * balance_dirty_pages() manages.
+		 *
+		 * Once a node is flagged PGDAT_WRITEBACK, kswapd will
+		 * count the number of pages under pages flagged for
+		 * immediate reclaim and stall if any are encountered
+		 * in the nr_immediate check below.
+		 */
+		if (sc->nr.writeback && sc->nr.writeback == sc->nr.taken)
+			set_bit(PGDAT_WRITEBACK, &pgdat->flags);
 
 		/*
-		 * Legacy memcg will stall in page writeback so avoid forcibly
-		 * stalling in wait_iff_congested().
+		 * Tag a node as congested if all the dirty pages
+		 * scanned were backed by a congested BDI and
+		 * wait_iff_congested will stall.
 		 */
-		if (cgroup_reclaim(sc) && writeback_throttling_sane(sc) &&
-		    sc->nr.dirty && sc->nr.dirty == sc->nr.congested)
-			set_memcg_congestion(pgdat, root, true);
+		if (sc->nr.dirty && sc->nr.dirty == sc->nr.congested)
+			set_bit(PGDAT_CONGESTED, &pgdat->flags);
+
+		/* Allow kswapd to start writing pages during reclaim.*/
+		if (sc->nr.unqueued_dirty == sc->nr.file_taken)
+			set_bit(PGDAT_DIRTY, &pgdat->flags);
 
 		/*
-		 * Stall direct reclaim for IO completions if underlying BDIs
-		 * and node is congested. Allow kswapd to continue until it
-		 * starts encountering unqueued dirty pages or cycling through
-		 * the LRU too quickly.
+		 * If kswapd scans pages marked marked for immediate
+		 * reclaim and under writeback (nr_immediate), it
+		 * implies that pages are cycling through the LRU
+		 * faster than they are written so also forcibly stall.
 		 */
-		if (!sc->hibernation_mode && !current_is_kswapd() &&
-		   current_may_throttle() && pgdat_memcg_congested(pgdat, root))
-			wait_iff_congested(BLK_RW_ASYNC, HZ/10);
+		if (sc->nr.immediate)
+			congestion_wait(BLK_RW_ASYNC, HZ/10);
+	}
+
+	/*
+	 * Legacy memcg will stall in page writeback so avoid forcibly
+	 * stalling in wait_iff_congested().
+	 */
+	if (cgroup_reclaim(sc) && writeback_throttling_sane(sc) &&
+	    sc->nr.dirty && sc->nr.dirty == sc->nr.congested)
+		set_memcg_congestion(pgdat, root, true);
+
+	/*
+	 * Stall direct reclaim for IO completions if underlying BDIs
+	 * and node is congested. Allow kswapd to continue until it
+	 * starts encountering unqueued dirty pages or cycling through
+	 * the LRU too quickly.
+	 */
+	if (!sc->hibernation_mode && !current_is_kswapd() &&
+	    current_may_throttle() && pgdat_memcg_congested(pgdat, root))
+		wait_iff_congested(BLK_RW_ASYNC, HZ/10);
 
-	} while (should_continue_reclaim(pgdat, sc->nr_reclaimed - nr_reclaimed,
-					 sc));
+	if (should_continue_reclaim(pgdat, sc->nr_reclaimed - nr_reclaimed,
+				    sc))
+		goto again;
 
 	/*
 	 * Kswapd gives up on balancing particular nodes after too
-- 
2.23.0


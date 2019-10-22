Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 108BCE06C0
	for <lists+cgroups@lfdr.de>; Tue, 22 Oct 2019 16:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbfJVOsj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Oct 2019 10:48:39 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34840 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388172AbfJVOsX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Oct 2019 10:48:23 -0400
Received: by mail-qk1-f194.google.com with SMTP id w2so16485459qkf.2
        for <cgroups@vger.kernel.org>; Tue, 22 Oct 2019 07:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hxh0IM0xlU3vTA2ZQpF8tyo6AUPcwm84qmU6yKeg7AE=;
        b=06y95XccQ47sNAPL8uhNFIISYVKYHbZBLHpvJ//HY7ED8ifACzizBBmrCeGvn7/4Zg
         +YEyppc3xQfaKFCGcZGNq7Cnhsw2R/CxzKDe4Z0cpUfaorTp8h+nilk9ExL4dkXX1eKG
         LioBdrUgywnZDq6EYMusUNOgI/QGFG052qREgRAU78aOQji59fTFPkF3PawYCXt03wZu
         5TG5pEPCsdOiwww9jnEJrkE4SxCF95zziI8twhfhs0vnzft25kpiI0nfscdVsvij1QUq
         6OnbyDY41FGYeL+V4lPOwsAo/+PDowshd1lLkMCXC6uycDjmx0+3I/MAyBvB46gto8kS
         yN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hxh0IM0xlU3vTA2ZQpF8tyo6AUPcwm84qmU6yKeg7AE=;
        b=ojyFmtuVW8dII6UMW/fS3+9WicwQr7gJpStY+/eAPXr2vefBZoNIVowaKdVhFUabEW
         2EtrQOD0u8AYce+E5ZGmsGwWH1urOP3WeUzVUYBa1B4mD7lslgs2c8vrO7bq+6D9so49
         fB7jSXTKLgreHmcgewFkvgY37giBTyWu+j+RCTDQexQg9OpezU03NNhpR3QmMdVhRxw1
         JrvonVqiQ8qzOCEof56oPndIJM6UfuM+m64Z3Ex8NncvgmYgCPlQ1NErhIPy6lvqfo+z
         LV6TJsplu7kX8COwzz+rjqzhuA5r9ScL0chfG7FL9nF9OvprdaRgHkVuAQB912WO7fUV
         wReQ==
X-Gm-Message-State: APjAAAUICSsTpX8sdyFNtxXzEcFW2HH6FC0FTLrCw4HLKJXbf3+nU5xv
        /SeaF5gvNbvxmZfjDnPYddDMIg==
X-Google-Smtp-Source: APXvYqxRGyy7EdMQXI+J2blgh97/sGUFZVM/ZtaDfoFqFo8q3zdoWEmxTaMWpL4oHjNuZN4jtFu4pw==
X-Received: by 2002:a37:aac3:: with SMTP id t186mr3083773qke.221.1571755702048;
        Tue, 22 Oct 2019 07:48:22 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:10ad])
        by smtp.gmail.com with ESMTPSA id x133sm8682703qka.44.2019.10.22.07.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 07:48:21 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 6/8] mm: vmscan: turn shrink_node_memcg() into shrink_lruvec()
Date:   Tue, 22 Oct 2019 10:48:01 -0400
Message-Id: <20191022144803.302233-7-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191022144803.302233-1-hannes@cmpxchg.org>
References: <20191022144803.302233-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

A lruvec holds LRU pages owned by a certain NUMA node and cgroup.
Instead of awkwardly passing around a combination of a pgdat and a
memcg pointer, pass down the lruvec as soon as we can look it up.

Nested callers that need to access node or cgroup properties can look
them them up if necessary, but there are only a few cases.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/vmscan.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 235d1fc72311..db073b40c432 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2280,9 +2280,10 @@ enum scan_balance {
  * nr[0] = anon inactive pages to scan; nr[1] = anon active pages to scan
  * nr[2] = file inactive pages to scan; nr[3] = file active pages to scan
  */
-static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
-			   struct scan_control *sc, unsigned long *nr)
+static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
+			   unsigned long *nr)
 {
+	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	int swappiness = mem_cgroup_swappiness(memcg);
 	struct zone_reclaim_stat *reclaim_stat = &lruvec->reclaim_stat;
 	u64 fraction[2];
@@ -2530,13 +2531,8 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
 	}
 }
 
-/*
- * This is a basic per-node page freer.  Used by both kswapd and direct reclaim.
- */
-static void shrink_node_memcg(struct pglist_data *pgdat, struct mem_cgroup *memcg,
-			      struct scan_control *sc)
+static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 {
-	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
 	unsigned long nr[NR_LRU_LISTS];
 	unsigned long targets[NR_LRU_LISTS];
 	unsigned long nr_to_scan;
@@ -2546,7 +2542,7 @@ static void shrink_node_memcg(struct pglist_data *pgdat, struct mem_cgroup *memc
 	struct blk_plug plug;
 	bool scan_adjusted;
 
-	get_scan_count(lruvec, memcg, sc, nr);
+	get_scan_count(lruvec, sc, nr);
 
 	/* Record the original scan target for proportional adjustments later */
 	memcpy(targets, nr, sizeof(nr));
@@ -2741,6 +2737,7 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 
 	memcg = mem_cgroup_iter(root, NULL, NULL);
 	do {
+		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
 		unsigned long reclaimed;
 		unsigned long scanned;
 
@@ -2777,7 +2774,8 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 
 		reclaimed = sc->nr_reclaimed;
 		scanned = sc->nr_scanned;
-		shrink_node_memcg(pgdat, memcg, sc);
+
+		shrink_lruvec(lruvec, sc);
 
 		shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
 			    sc->priority);
@@ -3281,6 +3279,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 						pg_data_t *pgdat,
 						unsigned long *nr_scanned)
 {
+	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
 	struct scan_control sc = {
 		.nr_to_reclaim = SWAP_CLUSTER_MAX,
 		.target_mem_cgroup = memcg,
@@ -3307,7 +3306,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 	 * will pick up pages from other mem cgroup's as well. We hack
 	 * the priority and make it zero.
 	 */
-	shrink_node_memcg(pgdat, memcg, &sc);
+	shrink_lruvec(lruvec, &sc);
 
 	trace_mm_vmscan_memcg_softlimit_reclaim_end(
 					cgroup_ino(memcg->css.cgroup),
-- 
2.23.0


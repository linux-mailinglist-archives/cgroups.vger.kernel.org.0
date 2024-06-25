Return-Path: <cgroups+bounces-3324-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0721E915B54
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 03:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 810FD1F2281D
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 01:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7423612B82;
	Tue, 25 Jun 2024 00:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vC47+CqM"
X-Original-To: cgroups@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1700E18049
	for <cgroups@vger.kernel.org>; Tue, 25 Jun 2024 00:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719277177; cv=none; b=pH+QJX5kntYVSbF2iTNLsOfv7NzPmBybi8dvkT1VmRMDWA5eQVzxTujqbtZ/hd0ZFg8vzHaLPICwfuv03mfN3hgFIJwDS1ELGji7qVUErXtdvStf4+XY+SdbCQhShGKRoL1g7OzR8MXUfNFyLLyz7/s1jpTS2LiPbazZPIW24a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719277177; c=relaxed/simple;
	bh=kry4xK+p8M5zaDaq9rnZFn3CVVELpltW4OQH7B4V3yE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqDmKDA7XuaVY//Rm8SOkfwq7RFa2emrY9pcp3+BdKeoSoHHpWxHML5oZgT+iN9XrsglHiTU0yAtGHwlxz1/C+WD+VCJ3UYQY7c/tBUyFyM2JhFBvVuR5r4o1gWzTQzQ+XbUP6O1HjXsy2WsCHhk4tximfoukJ/f/ldk26YrhXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vC47+CqM; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719277173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jqHMldr5yb8EHMopv4QA8bs9iV164cfr+gO2HUVb6OI=;
	b=vC47+CqMGWRzP59I6JXMOgvoaLbgn6Avaqr2H6e/hxJishCg/ejeMxkMXhSHpjUjIptXFO
	LFVdS25i0wSGT3zri597XOuNN81MUCYX5Yb7NzyvW3ye0M4dADWj+tGmjFyCUAN5oPQFgE
	8zmBGd0hMknLsB9MyuQU7jNjIDMmrdA=
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: roman.gushchin@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v2 03/14] mm: memcg: rename soft limit reclaim-related functions
Date: Mon, 24 Jun 2024 17:58:55 -0700
Message-ID: <20240625005906.106920-4-roman.gushchin@linux.dev>
In-Reply-To: <20240625005906.106920-1-roman.gushchin@linux.dev>
References: <20240625005906.106920-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Rename exported function related to the softlimit reclaim
to have memcg1_ prefix.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/memcontrol.h | 12 ++++++------
 mm/memcontrol-v1.c         |  6 +++---
 mm/memcontrol-v1.h         |  4 ++--
 mm/memcontrol.c            |  4 ++--
 mm/vmscan.c                | 10 +++++-----
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 7403dd5926eb..83c8327455d8 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1121,9 +1121,9 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
 
 void split_page_memcg(struct page *head, int old_order, int new_order);
 
-unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
-						gfp_t gfp_mask,
-						unsigned long *total_scanned);
+unsigned long memcg1_soft_limit_reclaim(pg_data_t *pgdat, int order,
+					gfp_t gfp_mask,
+					unsigned long *total_scanned);
 
 #else /* CONFIG_MEMCG */
 
@@ -1572,9 +1572,9 @@ static inline void split_page_memcg(struct page *head, int old_order, int new_or
 }
 
 static inline
-unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
-					    gfp_t gfp_mask,
-					    unsigned long *total_scanned)
+unsigned long memcg1_soft_limit_reclaim(pg_data_t *pgdat, int order,
+					gfp_t gfp_mask,
+					unsigned long *total_scanned)
 {
 	return 0;
 }
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 2ccb8406fa84..68e2f1a718d3 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -100,7 +100,7 @@ static unsigned long soft_limit_excess(struct mem_cgroup *memcg)
 	return excess;
 }
 
-void mem_cgroup_update_tree(struct mem_cgroup *memcg, int nid)
+void memcg1_update_tree(struct mem_cgroup *memcg, int nid)
 {
 	unsigned long excess;
 	struct mem_cgroup_per_node *mz;
@@ -143,7 +143,7 @@ void mem_cgroup_update_tree(struct mem_cgroup *memcg, int nid)
 	}
 }
 
-void mem_cgroup_remove_from_trees(struct mem_cgroup *memcg)
+void memcg1_remove_from_trees(struct mem_cgroup *memcg)
 {
 	struct mem_cgroup_tree_per_node *mctz;
 	struct mem_cgroup_per_node *mz;
@@ -243,7 +243,7 @@ static int mem_cgroup_soft_reclaim(struct mem_cgroup *root_memcg,
 	return total;
 }
 
-unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
+unsigned long memcg1_soft_limit_reclaim(pg_data_t *pgdat, int order,
 					    gfp_t gfp_mask,
 					    unsigned long *total_scanned)
 {
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 4da6fa561c6d..e37bc7e8d955 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -3,8 +3,8 @@
 #ifndef __MM_MEMCONTROL_V1_H
 #define __MM_MEMCONTROL_V1_H
 
-void mem_cgroup_update_tree(struct mem_cgroup *memcg, int nid);
-void mem_cgroup_remove_from_trees(struct mem_cgroup *memcg);
+void memcg1_update_tree(struct mem_cgroup *memcg, int nid);
+void memcg1_remove_from_trees(struct mem_cgroup *memcg);
 
 static inline void memcg1_soft_limit_reset(struct mem_cgroup *memcg)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 003e944f34ea..3479e1af12d5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1012,7 +1012,7 @@ static void memcg_check_events(struct mem_cgroup *memcg, int nid)
 						MEM_CGROUP_TARGET_SOFTLIMIT);
 		mem_cgroup_threshold(memcg);
 		if (unlikely(do_softlimit))
-			mem_cgroup_update_tree(memcg, nid);
+			memcg1_update_tree(memcg, nid);
 	}
 }
 
@@ -5610,7 +5610,7 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 
 	vmpressure_cleanup(&memcg->vmpressure);
 	cancel_work_sync(&memcg->high_work);
-	mem_cgroup_remove_from_trees(memcg);
+	memcg1_remove_from_trees(memcg);
 	free_shrinker_info(memcg);
 	mem_cgroup_free(memcg);
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 900bad16e506..3d4c681c6d40 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6186,9 +6186,9 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 			 * and balancing, not for a memcg's limit.
 			 */
 			nr_soft_scanned = 0;
-			nr_soft_reclaimed = mem_cgroup_soft_limit_reclaim(zone->zone_pgdat,
-						sc->order, sc->gfp_mask,
-						&nr_soft_scanned);
+			nr_soft_reclaimed = memcg1_soft_limit_reclaim(zone->zone_pgdat,
+								      sc->order, sc->gfp_mask,
+								      &nr_soft_scanned);
 			sc->nr_reclaimed += nr_soft_reclaimed;
 			sc->nr_scanned += nr_soft_scanned;
 			/* need some check for avoid more shrink_zone() */
@@ -6952,8 +6952,8 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 		/* Call soft limit reclaim before calling shrink_node. */
 		sc.nr_scanned = 0;
 		nr_soft_scanned = 0;
-		nr_soft_reclaimed = mem_cgroup_soft_limit_reclaim(pgdat, sc.order,
-						sc.gfp_mask, &nr_soft_scanned);
+		nr_soft_reclaimed = memcg1_soft_limit_reclaim(pgdat, sc.order,
+							      sc.gfp_mask, &nr_soft_scanned);
 		sc.nr_reclaimed += nr_soft_reclaimed;
 
 		/*
-- 
2.45.2



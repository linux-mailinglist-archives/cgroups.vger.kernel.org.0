Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A37789386
	for <lists+cgroups@lfdr.de>; Sat, 26 Aug 2023 04:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjHZCuN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 25 Aug 2023 22:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjHZCtt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 25 Aug 2023 22:49:49 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D781FD7;
        Fri, 25 Aug 2023 19:49:46 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RXh6N462CzJrmp;
        Sat, 26 Aug 2023 10:46:36 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sat, 26 Aug
 2023 10:49:43 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Yosry Ahmed <yosryahmed@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        <wangkefeng.wang@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH v3] mm: vmscan: try to reclaim swapcache pages if no swap space
Date:   Sat, 26 Aug 2023 11:44:01 +0800
Message-ID: <20230826034401.640861-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When spaces of swap devices are exhausted, only file pages can be reclaimed.
But there are still some swapcache pages in anon lru list. This can lead
to a premature out-of-memory.

This problem can be fixed by checking number of swapcache pages in
can_reclaim_anon_pages().

Add a new bit swapcache_only in struct scan_control to skip isolating anon
pages that are not in the swap cache when only swap cache can be reclaimed.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 include/linux/swap.h |  6 ++++++
 mm/memcontrol.c      |  8 ++++++++
 mm/vmscan.c          | 29 +++++++++++++++++++++++++++--
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 456546443f1f..0318e918bfa4 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -669,6 +669,7 @@ static inline void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_p
 }
 
 extern long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg);
+extern long mem_cgroup_get_nr_swapcache_pages(struct mem_cgroup *memcg);
 extern bool mem_cgroup_swap_full(struct folio *folio);
 #else
 static inline void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry)
@@ -691,6 +692,11 @@ static inline long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
 	return get_nr_swap_pages();
 }
 
+static inline long mem_cgroup_get_nr_swapcache_pages(struct mem_cgroup *memcg)
+{
+	return total_swapcache_pages();
+}
+
 static inline bool mem_cgroup_swap_full(struct folio *folio)
 {
 	return vm_swap_full();
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e8ca4bdcb03c..c465829db92b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7567,6 +7567,14 @@ long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
 	return nr_swap_pages;
 }
 
+long mem_cgroup_get_nr_swapcache_pages(struct mem_cgroup *memcg)
+{
+	if (mem_cgroup_disabled())
+		return total_swapcache_pages();
+
+	return memcg_page_state(memcg, NR_SWAPCACHE);
+}
+
 bool mem_cgroup_swap_full(struct folio *folio)
 {
 	struct mem_cgroup *memcg;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7c33c5b653ef..5cb4adf6642b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -137,6 +137,9 @@ struct scan_control {
 	/* Always discard instead of demoting to lower tier memory */
 	unsigned int no_demotion:1;
 
+	/* Swap space is exhausted, only reclaim swapcache for anon LRU */
+	unsigned int swapcache_only:1;
+
 	/* Allocation order */
 	s8 order;
 
@@ -613,10 +616,20 @@ static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
 		 */
 		if (get_nr_swap_pages() > 0)
 			return true;
+		/* Is there any swapcache pages to reclaim? */
+		if (total_swapcache_pages() > 0) {
+			sc->swapcache_only = 1;
+			return true;
+		}
 	} else {
 		/* Is the memcg below its swap limit? */
 		if (mem_cgroup_get_nr_swap_pages(memcg) > 0)
 			return true;
+		/* Is there any swapcache pages in memcg to reclaim? */
+		if (mem_cgroup_get_nr_swapcache_pages(memcg) > 0) {
+			sc->swapcache_only = 1;
+			return true;
+		}
 	}
 
 	/*
@@ -2280,6 +2293,19 @@ static bool skip_cma(struct folio *folio, struct scan_control *sc)
 }
 #endif
 
+static bool skip_isolate(struct folio *folio, struct scan_control *sc,
+			 enum lru_list lru)
+{
+	if (folio_zonenum(folio) > sc->reclaim_idx)
+		return true;
+	if (skip_cma(folio, sc))
+		return true;
+	if (unlikely(sc->swapcache_only && !is_file_lru(lru) &&
+	    !folio_test_swapcache(folio)))
+		return true;
+	return false;
+}
+
 /*
  * Isolating page from the lruvec to fill in @dst list by nr_to_scan times.
  *
@@ -2326,8 +2352,7 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
 		nr_pages = folio_nr_pages(folio);
 		total_scan += nr_pages;
 
-		if (folio_zonenum(folio) > sc->reclaim_idx ||
-				skip_cma(folio, sc)) {
+		if (skip_isolate(folio, sc, lru)) {
 			nr_skipped[folio_zonenum(folio)] += nr_pages;
 			move_to = &folios_skipped;
 			goto move;
-- 
2.25.1


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A3942D474
	for <lists+cgroups@lfdr.de>; Thu, 14 Oct 2021 10:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhJNIF2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Oct 2021 04:05:28 -0400
Received: from relay.sw.ru ([185.231.240.75]:33376 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229970AbhJNIF0 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 14 Oct 2021 04:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=ml/asmO2M55pRoF1Gh0wA+ZD2la4BPG3z6+NcpeHyVE=; b=d3eBUq3lpjOVTy9cmKM
        mpNWN6wrh9dFOEUw7oJMxHrTxIl4YT/DybLGVtK8YInhHntC56JRz95JAZCsDl5TBfPpll+nMXaqG
        eTiseE2yNAFYEekMwK+/bv4gp+QDyPVg7p/sMB5vtYLQGy8wsWmx0YEhCJGo9QlvBWYsAm39/io=;
Received: from [172.29.1.17]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mavhu-005z98-9a; Thu, 14 Oct 2021 11:03:18 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH mm v5] memcg: enable memory accounting in __alloc_pages_bulk
To:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Roman Gushchin <guro@fb.com>, Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel@openvz.org
References: <0baa2b26-a41b-acab-b75d-72ec241f5151@virtuozzo.com>
Message-ID: <65c1afaf-7947-ce28-55b7-06bde7aeb278@virtuozzo.com>
Date:   Thu, 14 Oct 2021 11:02:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <0baa2b26-a41b-acab-b75d-72ec241f5151@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Bulk page allocator is used in vmalloc where it can be called
with __GFP_ACCOUNT and must charge allocated pages into memory cgroup.

Fixes: 387ba26fb1cb ("mm/page_alloc: add a bulk page allocator")
Cc: <stable@vger.kernel.org>
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
v5: remove pre-charge,
    use post-allocation per-page charges according to Michal Hocko's remarks
v4: updated according to Shakeel Butt's remarks,
    fixed wrong location of hooks declaration in memcontrol.h
v3: added comments,
    removed call of post charge hook for nr_pages = 0
v2: modified according to Shakeel Butt's remarks
---
 include/linux/memcontrol.h |  9 +++++++
 mm/memcontrol.c            | 50 ++++++++++++++++++++++++++++++++++++++
 mm/page_alloc.c            | 12 +++++++--
 3 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 3096c9a0ee01..6bad3d6efd03 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1692,6 +1692,9 @@ static inline int memcg_cache_id(struct mem_cgroup *memcg)
 
 struct mem_cgroup *mem_cgroup_from_obj(void *p);
 
+int memcg_charge_bulk_pages(gfp_t gfp, int nr_pages,
+			    struct list_head *page_list,
+			    struct page **page_array);
 #else
 static inline bool mem_cgroup_kmem_disabled(void)
 {
@@ -1744,6 +1747,12 @@ static inline struct mem_cgroup *mem_cgroup_from_obj(void *p)
        return NULL;
 }
 
+int memcg_charge_bulk_pages(gfp_t gfp, int nr_pages,
+			    struct list_head *page_list,
+			    struct page **page_array)
+{
+	return 0;
+}
 #endif /* CONFIG_MEMCG_KMEM */
 
 #endif /* _LINUX_MEMCONTROL_H */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 87e41c3cac10..568e594179f5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3239,6 +3239,56 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
 	refill_obj_stock(objcg, size, true);
 }
 
+/*
+ * memcg_charge_bulk_pages - Charge pages allocated by bulk allocator
+ * @gfp: GFP flags for the allocation
+ * @nr_pages: The number of pages added into the list or array
+ * @page_list: Optional list of allocated pages
+ * @page_array: Optional array of allocated pages
+ *
+ * Walks through array or list of allocated pages.
+ * For each page tries to charge it.
+ * If charge fails removes page from of array/list, frees it,
+ * and repeat it till end of array/list
+ *
+ * Returns the number of freed pages.
+ */
+int memcg_charge_bulk_pages(gfp_t gfp, int nr_pages,
+			    struct list_head *page_list,
+			    struct page **page_array)
+{
+	struct page *page, *np = NULL;
+	bool charge = true;
+	int i, nr_freed = 0;
+
+	if (page_list)
+		page = list_first_entry(page_list, struct page, lru);
+
+	for (i = 0; i < nr_pages; i++) {
+		if (page_list) {
+			if (np)
+				page = np;
+			np = list_next_entry(page, lru);
+		} else {
+			page = page_array[i];
+		}
+		/* some pages in incoming array can be charged already */
+		if (!page->memcg_data) {
+			if (charge && __memcg_kmem_charge_page(page, gfp, 0))
+				charge = false;
+
+			if (!charge) {
+				if (page_list)
+					list_del(&page->lru);
+				else
+					page_array[i] = NULL;
+				__free_pages(page, 0);
+				nr_freed++;
+			}
+		}
+	}
+	return nr_freed;
+}
 #endif /* CONFIG_MEMCG_KMEM */
 
 /*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b37435c274cf..71c7f29ff8dc 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5203,10 +5203,11 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	struct zoneref *z;
 	struct per_cpu_pages *pcp;
 	struct list_head *pcp_list;
+	LIST_HEAD(tpl);
 	struct alloc_context ac;
 	gfp_t alloc_gfp;
 	unsigned int alloc_flags = ALLOC_WMARK_LOW;
-	int nr_populated = 0, nr_account = 0;
+	int nr_populated = 0, nr_account = 0, nr_freed = 0;
 
 	/*
 	 * Skip populated array elements to determine if any pages need
@@ -5300,7 +5301,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 
 		prep_new_page(page, 0, gfp, 0);
 		if (page_list)
-			list_add(&page->lru, page_list);
+			list_add(&page->lru, &tpl);
 		else
 			page_array[nr_populated] = page;
 		nr_populated++;
@@ -5308,6 +5309,13 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 
 	local_unlock_irqrestore(&pagesets.lock, flags);
 
+	if (memcg_kmem_enabled() && (gfp & __GFP_ACCOUNT) && nr_account)
+       		nr_freed = memcg_charge_bulk_pages(gfp, nr_populated,
+						   page_list ? &tpl : NULL,
+						   page_array);
+	nr_account -= nr_freed;
+	nr_populated -= nr_freed;
+	list_splice(&tpl, page_list);
 	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
 	zone_statistics(ac.preferred_zoneref->zone, zone, nr_account);
 
-- 
2.31.1


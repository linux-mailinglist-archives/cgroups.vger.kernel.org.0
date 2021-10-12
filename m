Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACDC42A7BE
	for <lists+cgroups@lfdr.de>; Tue, 12 Oct 2021 16:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237258AbhJLPAt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Oct 2021 11:00:49 -0400
Received: from relay.sw.ru ([185.231.240.75]:45866 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237062AbhJLPAs (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 12 Oct 2021 11:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=RnsGlL3UBRJ/4cEPNnMhtn3bFoiisljeaKBlGJj1gVU=; b=evsQghIYusTLmgdlCUk
        1uiMVa3tQ03LqhJBGeBL4KH5OGXVpyTc6yTLTyvvElFeOM3wkcqgExVqxr67g6ha10lkc0HiGztPf
        GCu0OIBHexZinlW2uOtMD4dM1aR+Mrt5hxOghxX2gVABLz21xOwxfQJRtEnZVRHqWQHwIiVapLI=;
Received: from [172.29.1.17]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1maJEo-005om9-HH; Tue, 12 Oct 2021 17:58:42 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH mm v3] memcg: enable memory accounting in __alloc_pages_bulk
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
Message-ID: <60df0efd-f458-a13c-7c89-749bdab21d1d@virtuozzo.com>
Date:   Tue, 12 Oct 2021 17:58:21 +0300
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

Enable memory accounting for bulk page allocator.

Fixes: 387ba26fb1cb ("mm/page_alloc: add a bulk page allocator")
Cc: <stable@vger.kernel.org>
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
v3: added comments,
    removed call of post charge hook for nr_pages = 0
v2: modified according to Shakeel Butt's remarks
---
 include/linux/memcontrol.h | 11 +++++++++
 mm/memcontrol.c            | 48 +++++++++++++++++++++++++++++++++++++-
 mm/page_alloc.c            | 21 ++++++++++++++++-
 3 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 3096c9a0ee01..990acd70c846 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -810,6 +810,12 @@ static inline void obj_cgroup_put(struct obj_cgroup *objcg)
 	percpu_ref_put(&objcg->refcnt);
 }
 
+static inline void obj_cgroup_put_many(struct obj_cgroup *objcg,
+				       unsigned long nr)
+{
+	percpu_ref_put_many(&objcg->refcnt, nr);
+}
+
 static inline void mem_cgroup_put(struct mem_cgroup *memcg)
 {
 	if (memcg)
@@ -1746,4 +1752,9 @@ static inline struct mem_cgroup *mem_cgroup_from_obj(void *p)
 
 #endif /* CONFIG_MEMCG_KMEM */
 
+bool memcg_bulk_pre_charge_hook(struct obj_cgroup **objcgp, gfp_t gfp,
+				unsigned int nr_pages);
+void memcg_bulk_charge_hook(struct obj_cgroup *objcgp, struct page *page);
+void memcg_bulk_post_charge_hook(struct obj_cgroup *objcg,
+				 unsigned int nr_pages);
 #endif /* _LINUX_MEMCONTROL_H */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 87e41c3cac10..16fe3384c12c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3239,7 +3239,53 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
 	refill_obj_stock(objcg, size, true);
 }
 
-#endif /* CONFIG_MEMCG_KMEM */
+bool memcg_bulk_pre_charge_hook(struct obj_cgroup **objcgp, gfp_t gfp,
+				unsigned int nr_pages)
+{
+	struct obj_cgroup *objcg = NULL;
+
+	if (!memcg_kmem_enabled() || !(gfp & __GFP_ACCOUNT))
+		return true;
+
+	objcg = get_obj_cgroup_from_current();
+
+	if (objcg && obj_cgroup_charge_pages(objcg, gfp, nr_pages)) {
+		obj_cgroup_put(objcg);
+		return false;
+	}
+	obj_cgroup_get_many(objcg, nr_pages - 1);
+	*objcgp = objcg;
+	return true;
+}
+
+void memcg_bulk_charge_hook(struct obj_cgroup *objcg, struct page *page)
+{
+	page->memcg_data = (unsigned long)objcg | MEMCG_DATA_KMEM;
+}
+
+void memcg_bulk_post_charge_hook(struct obj_cgroup *objcg,
+				 unsigned int nr_pages)
+{
+	obj_cgroup_uncharge_pages(objcg, nr_pages);
+	obj_cgroup_put_many(objcg, nr_pages);
+}
+#else /* !CONFIG_MEMCG_KMEM */
+bool memcg_bulk_pre_charge_hook(struct obj_cgroup **objcgp, gfp_t gfp,
+				unsigned int nr_pages)
+{
+	return true;
+}
+
+void memcg_bulk_charge_hook(struct obj_cgroup *objcgp, struct page *page)
+{
+}
+
+void memcg_bulk_post_charge_hook(struct obj_cgroup *objcg,
+				 unsigned int nr_pages)
+{
+}
+#endif
+
 
 /*
  * Because page_memcg(head) is not set on tails, set it now.
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b37435c274cf..23a8b55df508 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5207,6 +5207,8 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	gfp_t alloc_gfp;
 	unsigned int alloc_flags = ALLOC_WMARK_LOW;
 	int nr_populated = 0, nr_account = 0;
+	unsigned int nr_pre_charge = 0;
+	struct obj_cgroup *objcg = NULL;
 
 	/*
 	 * Skip populated array elements to determine if any pages need
@@ -5275,6 +5277,11 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	if (unlikely(!zone))
 		goto failed;
 
+	nr_pre_charge = nr_pages - nr_populated;
+	/* pre-charge memory and take refcounts for each allocated page */
+	if (!memcg_bulk_pre_charge_hook(&objcg, gfp, nr_pre_charge))
+		goto failed;
+
 	/* Attempt the batch allocation */
 	local_lock_irqsave(&pagesets.lock, flags);
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
@@ -5299,6 +5306,9 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		nr_account++;
 
 		prep_new_page(page, 0, gfp, 0);
+		if (objcg)
+			memcg_bulk_charge_hook(objcg, page);
+
 		if (page_list)
 			list_add(&page->lru, page_list);
 		else
@@ -5310,13 +5320,22 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 
 	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
 	zone_statistics(ac.preferred_zoneref->zone, zone, nr_account);
+	/*
+	 * Typically nr_pre_charge == nr_account,
+	 * otherwise a few extra pages was pre-charged,
+	 * and must be uncharged now.
+	 */
+	if (objcg && nr_pre_charge - nr_account)
+		memcg_bulk_post_charge_hook(objcg, nr_pre_charge - nr_account);
 
 out:
 	return nr_populated;
 
 failed_irq:
 	local_unlock_irqrestore(&pagesets.lock, flags);
-
+	/* uncharge memory and decrement refcounts for all pre-charged pages */
+	if (objcg)
+		memcg_bulk_post_charge_hook(objcg, nr_pre_charge);
 failed:
 	page = __alloc_pages(gfp, 0, preferred_nid, nodemask);
 	if (page) {
-- 
2.31.1


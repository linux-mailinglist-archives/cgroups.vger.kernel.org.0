Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C4435BB55
	for <lists+cgroups@lfdr.de>; Mon, 12 Apr 2021 09:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237130AbhDLHwY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Apr 2021 03:52:24 -0400
Received: from m12-13.163.com ([220.181.12.13]:55905 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237110AbhDLHwX (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 12 Apr 2021 03:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=G/6Z4nNqZYq7RUqhry
        lTggPskhrSTLLuKMTwylozwN8=; b=Pd9HUn5gUA4b5cO5VygQjnTLjN3HdtVAbt
        1/AwKWWC6sMw7oP/zTJbjb2a9QO4VpEAL4Gk3S1wSvuDSn4TIVpN+XwMonoOCM+l
        CCrzwyiobo2NF3oiFanGrOkv2ih8+sF9VPG48vU6oyJE39hskcdsjXAhlUn37+x0
        7J1aneeSg=
Received: from localhost.localdomain (unknown [14.17.22.36])
        by smtp9 (Coremail) with SMTP id DcCowAA3Huux+3Ng4SZBFg--.46650S3;
        Mon, 12 Apr 2021 15:50:10 +0800 (CST)
From:   ultrachin@163.com
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, linux-mm@kvack.org,
        cgroups@vger.kernel.org, Chen Xiaoguang <xiaoggchen@tencent.com>,
        Chen He <heddchen@tencent.com>
Subject: [PATCH] mm: optimize memory allocation
Date:   Mon, 12 Apr 2021 15:49:53 +0800
Message-Id: <1618213793-17741-1-git-send-email-ultrachin@163.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: DcCowAA3Huux+3Ng4SZBFg--.46650S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jr43Gw17Ar4DXF1rWFW3ZFb_yoWxuryrpF
        sxJ3Z3Aw4rArWrGrsxKFWq934rZ3WkXFZ5A3y7Jw48X343tw1jyFnrGFy8AFy8GFZ7Jry3
        GF45tw1kGa1DAaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5PEfUUUUU=
X-Originating-IP: [14.17.22.36]
X-CM-SenderInfo: xxow2thfkl0qqrwthudrp/1tbivxJyWFWBtZlafgAAsb
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chen Xiaoguang <xiaoggchen@tencent.com>

Check memory cgroup limit before allocating real memory. This may
improve performance especially in slow path when memory allocation
exceeds cgroup limitation.

Signed-off-by: Chen Xiaoguang <xiaoggchen@tencent.com>
Signed-off-by: Chen He <heddchen@tencent.com>
---
 include/linux/memcontrol.h | 30 ++++++++++++++++++++++--------
 mm/memcontrol.c            | 34 ++++++++++++++++------------------
 mm/page_alloc.c            | 24 +++++++++++++++++-------
 3 files changed, 55 insertions(+), 33 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0c04d39..59bb3ba 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1583,8 +1583,9 @@ static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
 #endif
 
 #ifdef CONFIG_MEMCG_KMEM
-int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order);
-void __memcg_kmem_uncharge_page(struct page *page, int order);
+int __memcg_kmem_charge_page(struct mem_cgroup *memcg, gfp_t gfp, int order);
+void __memcg_kmem_uncharge_page(struct page *page, int order,
+				struct mem_cgroup *memcg);
 
 struct obj_cgroup *get_obj_cgroup_from_current(void);
 
@@ -1610,18 +1611,30 @@ static inline bool memcg_kmem_enabled(void)
 	return static_branch_likely(&memcg_kmem_enabled_key);
 }
 
+extern struct mem_cgroup *get_mem_cgroup_from_current(void);
+
 static inline int memcg_kmem_charge_page(struct page *page, gfp_t gfp,
 					 int order)
 {
-	if (memcg_kmem_enabled())
-		return __memcg_kmem_charge_page(page, gfp, order);
-	return 0;
+	struct mem_cgroup *memcg;
+	int ret = 0;
+
+	memcg = get_mem_cgroup_from_current();
+	if (memcg && memcg_kmem_enabled() && !mem_cgroup_is_root(memcg)) {
+		ret = __memcg_kmem_charge_page(memcg, gfp, order);
+		if (!ret) {
+			page->memcg_data = (unsigned long)memcg | MEMCG_DATA_KMEM;
+			return 0;
+		}
+		css_put(&memcg->css);
+	}
+	return ret;
 }
 
 static inline void memcg_kmem_uncharge_page(struct page *page, int order)
 {
 	if (memcg_kmem_enabled())
-		__memcg_kmem_uncharge_page(page, order);
+		__memcg_kmem_uncharge_page(page, order, NULL);
 }
 
 /*
@@ -1647,13 +1660,14 @@ static inline void memcg_kmem_uncharge_page(struct page *page, int order)
 {
 }
 
-static inline int __memcg_kmem_charge_page(struct page *page, gfp_t gfp,
+static inline int __memcg_kmem_charge_page(struct mem_cgroup *memcg, gfp_t gfp,
 					   int order)
 {
 	return 0;
 }
 
-static inline void __memcg_kmem_uncharge_page(struct page *page, int order)
+static inline void __memcg_kmem_uncharge_page(struct page *page, int order,
+					    struct mem_cgroup *memcg)
 {
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e064ac0d..8df57b7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1085,7 +1085,7 @@ static __always_inline bool memcg_kmem_bypass(void)
 /**
  * If active memcg is set, do not fallback to current->mm->memcg.
  */
-static __always_inline struct mem_cgroup *get_mem_cgroup_from_current(void)
+struct mem_cgroup *get_mem_cgroup_from_current(void)
 {
 	if (memcg_kmem_bypass())
 		return NULL;
@@ -3113,21 +3113,11 @@ static void __memcg_kmem_uncharge(struct mem_cgroup *memcg, unsigned int nr_page
  *
  * Returns 0 on success, an error code on failure.
  */
-int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
+int __memcg_kmem_charge_page(struct mem_cgroup *memcg, gfp_t gfp, int order)
 {
-	struct mem_cgroup *memcg;
-	int ret = 0;
+	int ret;
 
-	memcg = get_mem_cgroup_from_current();
-	if (memcg && !mem_cgroup_is_root(memcg)) {
-		ret = __memcg_kmem_charge(memcg, gfp, 1 << order);
-		if (!ret) {
-			page->memcg_data = (unsigned long)memcg |
-				MEMCG_DATA_KMEM;
-			return 0;
-		}
-		css_put(&memcg->css);
-	}
+	ret = __memcg_kmem_charge(memcg, gfp, 1 << order);
 	return ret;
 }
 
@@ -3136,17 +3126,25 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
  * @page: page to uncharge
  * @order: allocation order
  */
-void __memcg_kmem_uncharge_page(struct page *page, int order)
+void __memcg_kmem_uncharge_page(struct page *page, int order,
+		struct mem_cgroup *memcg_in)
 {
-	struct mem_cgroup *memcg = page_memcg(page);
+	struct mem_cgroup *memcg;
 	unsigned int nr_pages = 1 << order;
 
+	if (page)
+		memcg = page_memcg(page);
+	else
+		memcg = memcg_in;
+
 	if (!memcg)
 		return;
 
-	VM_BUG_ON_PAGE(mem_cgroup_is_root(memcg), page);
+	if (page)
+		VM_BUG_ON_PAGE(mem_cgroup_is_root(memcg), page);
 	__memcg_kmem_uncharge(memcg, nr_pages);
-	page->memcg_data = 0;
+	if (page)
+		page->memcg_data = 0;
 	css_put(&memcg->css);
 }
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cfc7287..c3d1d0c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1230,7 +1230,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 		 * Untie memcg state and reset page's owner
 		 */
 		if (memcg_kmem_enabled() && PageMemcgKmem(page))
-			__memcg_kmem_uncharge_page(page, order);
+			__memcg_kmem_uncharge_page(page, order, NULL);
 		reset_page_owner(page, order);
 		return false;
 	}
@@ -1260,7 +1260,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	if (PageMappingFlags(page))
 		page->mapping = NULL;
 	if (memcg_kmem_enabled() && PageMemcgKmem(page))
-		__memcg_kmem_uncharge_page(page, order);
+		__memcg_kmem_uncharge_page(page, order, NULL);
 	if (check_free)
 		bad += check_free_page(page);
 	if (bad)
@@ -4976,6 +4976,8 @@ struct page *
 	unsigned int alloc_flags = ALLOC_WMARK_LOW;
 	gfp_t alloc_mask; /* The gfp_t that was actually used for allocation */
 	struct alloc_context ac = { };
+	struct mem_cgroup *memcg;
+	bool charged = false;
 
 	/*
 	 * There are several places where we assume that the order value is sane
@@ -4987,6 +4989,15 @@ struct page *
 	}
 
 	gfp_mask &= gfp_allowed_mask;
+	memcg = get_mem_cgroup_from_current();
+	if (memcg && memcg_kmem_enabled() && (gfp_mask & __GFP_ACCOUNT) &&
+	    !mem_cgroup_is_root(memcg)) {
+		if (unlikely(__memcg_kmem_charge_page(memcg, gfp_mask, order) != 0)) {
+			css_put(&memcg->css);
+			return NULL;
+		}
+		charged = true;
+	}
 	alloc_mask = gfp_mask;
 	if (!prepare_alloc_pages(gfp_mask, order, preferred_nid, nodemask, &ac, &alloc_mask, &alloc_flags))
 		return NULL;
@@ -5020,11 +5031,10 @@ struct page *
 	page = __alloc_pages_slowpath(alloc_mask, order, &ac);
 
 out:
-	if (memcg_kmem_enabled() && (gfp_mask & __GFP_ACCOUNT) && page &&
-	    unlikely(__memcg_kmem_charge_page(page, gfp_mask, order) != 0)) {
-		__free_pages(page, order);
-		page = NULL;
-	}
+	if (page && charged)
+		page->memcg_data = (unsigned long)memcg | MEMCG_DATA_KMEM;
+	else if (charged)
+		__memcg_kmem_uncharge_page(NULL, order, memcg);
 
 	trace_mm_page_alloc(page, order, alloc_mask, ac.migratetype);
 
-- 
1.8.3.1



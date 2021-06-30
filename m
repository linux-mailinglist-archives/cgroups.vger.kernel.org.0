Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E527C3B7C68
	for <lists+cgroups@lfdr.de>; Wed, 30 Jun 2021 06:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbhF3EKk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Jun 2021 00:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhF3EKh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Jun 2021 00:10:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CB8C061760
        for <cgroups@vger.kernel.org>; Tue, 29 Jun 2021 21:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=EAl8xxbwMFaWRPB7s9hTtKvYo+m1NveKdSWstmV/WJk=; b=E1WsjlCvrvuiYDpezV19Cl3cAT
        BoWd0Q8zE8NLd+F7x73qBzKOktyZHKZNFTm32F0+86/EwEH9z+6hCSSGFmagT2jR9CXUgKNx+EOrh
        UUbqF48yV09RjFRTzUKJ7PXEwNgCIPif4OM+shQKUVRuVpP2PnngusDAr/qZy1fwW50NF5K6e9Otr
        s4CU7fTp/ZLuQMsuXPZiGT0LB9d0VYarpQNssWq+eosXw90fYakSQ/nxk001OuhmPLpnxwJ+kez8U
        C0kNZjPNeirSUJq/q4gQuw6LigAl+pCfck+EmuLHAo8JGx0xq3A2mz+MB5dQ3RhRr+Y2uRcb5uhTQ
        BD02m8Rw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyRV6-004rD2-L9; Wed, 30 Jun 2021 04:07:13 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: [PATCH v3 10/18] mm/memcg: Convert mem_cgroup_uncharge() to take a folio
Date:   Wed, 30 Jun 2021 05:00:26 +0100
Message-Id: <20210630040034.1155892-11-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210630040034.1155892-1-willy@infradead.org>
References: <20210630040034.1155892-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Convert all the callers to call page_folio().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/memcontrol.h |  4 ++--
 mm/filemap.c               |  2 +-
 mm/khugepaged.c            |  4 ++--
 mm/memcontrol.c            | 14 +++++++-------
 mm/memory-failure.c        |  2 +-
 mm/memremap.c              |  2 +-
 mm/page_alloc.c            |  2 +-
 mm/swap.c                  |  2 +-
 8 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 90d48b0e3191..d6386a2b9d7a 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -710,7 +710,7 @@ int mem_cgroup_swapin_charge_page(struct page *page, struct mm_struct *mm,
 				  gfp_t gfp, swp_entry_t entry);
 void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry);
 
-void mem_cgroup_uncharge(struct page *page);
+void mem_cgroup_uncharge(struct folio *);
 void mem_cgroup_uncharge_list(struct list_head *page_list);
 
 void mem_cgroup_migrate(struct page *oldpage, struct page *newpage);
@@ -1202,7 +1202,7 @@ static inline void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry)
 {
 }
 
-static inline void mem_cgroup_uncharge(struct page *page)
+static inline void mem_cgroup_uncharge(struct folio *folio)
 {
 }
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 9600bca84162..0008ada132c4 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -923,7 +923,7 @@ noinline int __add_to_page_cache_locked(struct page *page,
 	if (xas_error(&xas)) {
 		error = xas_error(&xas);
 		if (charged)
-			mem_cgroup_uncharge(page);
+			mem_cgroup_uncharge(page_folio(page));
 		goto error;
 	}
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 0daa21fbdd71..988a230c7a41 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1212,7 +1212,7 @@ static void collapse_huge_page(struct mm_struct *mm,
 	mmap_write_unlock(mm);
 out_nolock:
 	if (!IS_ERR_OR_NULL(*hpage))
-		mem_cgroup_uncharge(*hpage);
+		mem_cgroup_uncharge(page_folio(*hpage));
 	trace_mm_collapse_huge_page(mm, isolated, result);
 	return;
 }
@@ -1963,7 +1963,7 @@ static void collapse_file(struct mm_struct *mm,
 out:
 	VM_BUG_ON(!list_empty(&pagelist));
 	if (!IS_ERR_OR_NULL(*hpage))
-		mem_cgroup_uncharge(*hpage);
+		mem_cgroup_uncharge(page_folio(*hpage));
 	/* TODO: tracepoints */
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 21b791935957..90a53f554371 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6892,24 +6892,24 @@ static void uncharge_folio(struct folio *folio, struct uncharge_gather *ug)
 }
 
 /**
- * mem_cgroup_uncharge - uncharge a page
- * @page: page to uncharge
+ * mem_cgroup_uncharge - Uncharge a folio.
+ * @folio: Folio to uncharge.
  *
- * Uncharge a page previously charged with mem_cgroup_charge().
+ * Uncharge a folio previously charged with folio_charge_cgroup().
  */
-void mem_cgroup_uncharge(struct page *page)
+void mem_cgroup_uncharge(struct folio *folio)
 {
 	struct uncharge_gather ug;
 
 	if (mem_cgroup_disabled())
 		return;
 
-	/* Don't touch page->lru of any random page, pre-check: */
-	if (!page_memcg(page))
+	/* Don't touch folio->lru of any random page, pre-check: */
+	if (!folio_memcg(folio))
 		return;
 
 	uncharge_gather_clear(&ug);
-	uncharge_folio(page_folio(page), &ug);
+	uncharge_folio(folio, &ug);
 	uncharge_batch(&ug);
 }
 
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index e5a1531f7f4e..7ada5959b5ad 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -750,7 +750,7 @@ static int delete_from_lru_cache(struct page *p)
 		 * Poisoned page might never drop its ref count to 0 so we have
 		 * to uncharge it manually from its memcg.
 		 */
-		mem_cgroup_uncharge(p);
+		mem_cgroup_uncharge(page_folio(p));
 
 		/*
 		 * drop the page count elevated by isolate_lru_page()
diff --git a/mm/memremap.c b/mm/memremap.c
index 15a074ffb8d7..6eac40f9f62a 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -508,7 +508,7 @@ void free_devmap_managed_page(struct page *page)
 
 	__ClearPageWaiters(page);
 
-	mem_cgroup_uncharge(page);
+	mem_cgroup_uncharge(page_folio(page));
 
 	/*
 	 * When a device_private page is freed, the page->mapping field
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0817d88383d5..5a5fcd4f21a8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -737,7 +737,7 @@ static inline void free_the_page(struct page *page, unsigned int order)
 
 void free_compound_page(struct page *page)
 {
-	mem_cgroup_uncharge(page);
+	mem_cgroup_uncharge(page_folio(page));
 	free_the_page(page, compound_order(page));
 }
 
diff --git a/mm/swap.c b/mm/swap.c
index 6954cfebab4f..8ba62a930370 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -94,7 +94,7 @@ static void __page_cache_release(struct page *page)
 static void __put_single_page(struct page *page)
 {
 	__page_cache_release(page);
-	mem_cgroup_uncharge(page);
+	mem_cgroup_uncharge(page_folio(page));
 	free_unref_page(page, 0);
 }
 
-- 
2.30.2


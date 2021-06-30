Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171DA3B7C73
	for <lists+cgroups@lfdr.de>; Wed, 30 Jun 2021 06:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbhF3EOk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Jun 2021 00:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhF3EOk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Jun 2021 00:14:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D68C061760
        for <cgroups@vger.kernel.org>; Tue, 29 Jun 2021 21:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=IMpVf9S+XpwTzl+bYUatz0DuE99ehch4OO1u76GrFbo=; b=EPruxIwYKmHbDTPvTFOqdEZR9o
        NTbmzVxzZRc/8LuMzZR+Yzs5KICK0JEqyLk33tjEirYkv44wun0qqn/LP1ph5TY7tsobiqnwKsRlZ
        TX1XEnO/FRoyW7EfxWuDH1JS6ARXyWVx67JwH+jkgsrA1Fp4o2FyF2/cbhYb7evLiG3fwGPrwYprk
        xdgDKmaSpIZxJgJrFuLof39Z2fT8hleDaZToPNJzRPZSZFwvz7qECaFTT2LSRrjJuzsHcp0zLNbQ5
        AOd7d9L51RZTjpw+O25JR0rmxQDmeqQa7kW0v8xNugU6DtUldGmLKJ13Ck1Wx01vgTJpR/bPywsF4
        Alo9C9PA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyRZ8-004rRW-Cn; Wed, 30 Jun 2021 04:11:20 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: [PATCH v3 16/18] mm/memcg: Add folio_lruvec_lock() and similar functions
Date:   Wed, 30 Jun 2021 05:00:32 +0100
Message-Id: <20210630040034.1155892-17-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210630040034.1155892-1-willy@infradead.org>
References: <20210630040034.1155892-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

These are the folio equivalents of lock_page_lruvec() and
similar functions.  Retain lock_page_lruvec() as wrappers so we
don't have to convert all these functions twice.  Also convert
lruvec_memcg_debug() to take a folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/memcontrol.h | 39 +++++++++++++++++++++++++++-----------
 mm/compaction.c            |  2 +-
 mm/memcontrol.c            | 33 ++++++++++++++------------------
 3 files changed, 43 insertions(+), 31 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index a7e1ccbc7ed6..b21a77669277 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -769,15 +769,16 @@ struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p);
 
 struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm);
 
-struct lruvec *lock_page_lruvec(struct page *page);
-struct lruvec *lock_page_lruvec_irq(struct page *page);
-struct lruvec *lock_page_lruvec_irqsave(struct page *page,
+struct lruvec *folio_lruvec_lock(struct folio *folio);
+struct lruvec *folio_lruvec_lock_irq(struct folio *folio);
+struct lruvec *folio_lruvec_lock_irqsave(struct folio *folio,
 						unsigned long *flags);
 
 #ifdef CONFIG_DEBUG_VM
-void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page);
+void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio);
 #else
-static inline void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
+static inline
+void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
 {
 }
 #endif
@@ -1257,26 +1258,26 @@ static inline void mem_cgroup_put(struct mem_cgroup *memcg)
 {
 }
 
-static inline struct lruvec *lock_page_lruvec(struct page *page)
+static inline struct lruvec *folio_lruvec_lock(struct folio *folio)
 {
-	struct pglist_data *pgdat = page_pgdat(page);
+	struct pglist_data *pgdat = folio_pgdat(folio);
 
 	spin_lock(&pgdat->__lruvec.lru_lock);
 	return &pgdat->__lruvec;
 }
 
-static inline struct lruvec *lock_page_lruvec_irq(struct page *page)
+static inline struct lruvec *folio_lruvec_lock_irq(struct folio *folio)
 {
-	struct pglist_data *pgdat = page_pgdat(page);
+	struct pglist_data *pgdat = folio_pgdat(folio);
 
 	spin_lock_irq(&pgdat->__lruvec.lru_lock);
 	return &pgdat->__lruvec;
 }
 
-static inline struct lruvec *lock_page_lruvec_irqsave(struct page *page,
+static inline struct lruvec *folio_lruvec_lock_irqsave(struct folio *folio,
 		unsigned long *flagsp)
 {
-	struct pglist_data *pgdat = page_pgdat(page);
+	struct pglist_data *pgdat = folio_pgdat(folio);
 
 	spin_lock_irqsave(&pgdat->__lruvec.lru_lock, *flagsp);
 	return &pgdat->__lruvec;
@@ -1488,6 +1489,22 @@ static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page)
 	return mem_cgroup_folio_lruvec(page_folio(page));
 }
 
+static inline struct lruvec *lock_page_lruvec(struct page *page)
+{
+	return folio_lruvec_lock(page_folio(page));
+}
+
+static inline struct lruvec *lock_page_lruvec_irq(struct page *page)
+{
+	return folio_lruvec_lock_irq(page_folio(page));
+}
+
+static inline struct lruvec *lock_page_lruvec_irqsave(struct page *page,
+						unsigned long *flags)
+{
+	return folio_lruvec_lock_irqsave(page_folio(page), flags);
+}
+
 static inline void __inc_lruvec_kmem_state(void *p, enum node_stat_item idx)
 {
 	__mod_lruvec_kmem_state(p, idx, 1);
diff --git a/mm/compaction.c b/mm/compaction.c
index 3a509fbf2bea..8b0da04b70f2 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1038,7 +1038,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);
 			locked = lruvec;
 
-			lruvec_memcg_debug(lruvec, page);
+			lruvec_memcg_debug(lruvec, page_folio(page));
 
 			/* Try get exclusive access under lock */
 			if (!skip_updated) {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 95795b65ae3e..23b166917def 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1153,19 +1153,19 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 }
 
 #ifdef CONFIG_DEBUG_VM
-void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
+void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
 {
 	struct mem_cgroup *memcg;
 
 	if (mem_cgroup_disabled())
 		return;
 
-	memcg = page_memcg(page);
+	memcg = folio_memcg(folio);
 
 	if (!memcg)
-		VM_BUG_ON_PAGE(lruvec_memcg(lruvec) != root_mem_cgroup, page);
+		VM_BUG_ON_FOLIO(lruvec_memcg(lruvec) != root_mem_cgroup, folio);
 	else
-		VM_BUG_ON_PAGE(lruvec_memcg(lruvec) != memcg, page);
+		VM_BUG_ON_FOLIO(lruvec_memcg(lruvec) != memcg, folio);
 }
 #endif
 
@@ -1179,38 +1179,33 @@ void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
  * - lock_page_memcg()
  * - page->_refcount is zero
  */
-struct lruvec *lock_page_lruvec(struct page *page)
+struct lruvec *folio_lruvec_lock(struct folio *folio)
 {
-	struct lruvec *lruvec;
+	struct lruvec *lruvec = mem_cgroup_folio_lruvec(folio);
 
-	lruvec = mem_cgroup_page_lruvec(page);
 	spin_lock(&lruvec->lru_lock);
-
-	lruvec_memcg_debug(lruvec, page);
+	lruvec_memcg_debug(lruvec, folio);
 
 	return lruvec;
 }
 
-struct lruvec *lock_page_lruvec_irq(struct page *page)
+struct lruvec *folio_lruvec_lock_irq(struct folio *folio)
 {
-	struct lruvec *lruvec;
+	struct lruvec *lruvec = mem_cgroup_folio_lruvec(folio);
 
-	lruvec = mem_cgroup_page_lruvec(page);
 	spin_lock_irq(&lruvec->lru_lock);
-
-	lruvec_memcg_debug(lruvec, page);
+	lruvec_memcg_debug(lruvec, folio);
 
 	return lruvec;
 }
 
-struct lruvec *lock_page_lruvec_irqsave(struct page *page, unsigned long *flags)
+struct lruvec *folio_lruvec_lock_irqsave(struct folio *folio,
+		unsigned long *flags)
 {
-	struct lruvec *lruvec;
+	struct lruvec *lruvec = mem_cgroup_folio_lruvec(folio);
 
-	lruvec = mem_cgroup_page_lruvec(page);
 	spin_lock_irqsave(&lruvec->lru_lock, *flags);
-
-	lruvec_memcg_debug(lruvec, page);
+	lruvec_memcg_debug(lruvec, folio);
 
 	return lruvec;
 }
-- 
2.30.2


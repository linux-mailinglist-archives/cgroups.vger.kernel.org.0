Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705E03B7C70
	for <lists+cgroups@lfdr.de>; Wed, 30 Jun 2021 06:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbhF3EMp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Jun 2021 00:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhF3EMo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Jun 2021 00:12:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A30C061760
        for <cgroups@vger.kernel.org>; Tue, 29 Jun 2021 21:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Xs+C8igKGtsfobOsWI7v7pFbJ5dQkVc5kSbNpGFbjuk=; b=hBR/N+GqwANlp/g5TmqeHCtGAg
        C8T+YV+0kVEgaWdbkCvDXfY+uM/hxn0n5HxcG2qh+E32tX2mXG1PsiDEjhEUqlyBn0mNfdnTFTHzJ
        w3QAfffEj0GP9aNtpsoNpz2I4xDedCYKqLw5O2vz+ylbF+cHS3aLrkIuR7xWAlbhwvLZvWMmz8mNN
        f//ECNgEu84NMivae2qsAk9WxY8jL4sXa4Sfck2wDsJnoWROIj2dn0Pco67o0qU3XBVvBquyABvAB
        NxXPIrEtwIB+b4bgt6jJ2j9zykeuE3kA6LJD5GsBUuAKhyw5hYXiOJDX7poFYT9l8ClaPQXlBDFlN
        AMi9b5MA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyRXF-004rJw-TY; Wed, 30 Jun 2021 04:09:24 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: [PATCH v3 13/18] mm/memcg: Add folio_memcg_lock() and folio_memcg_unlock()
Date:   Wed, 30 Jun 2021 05:00:29 +0100
Message-Id: <20210630040034.1155892-14-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210630040034.1155892-1-willy@infradead.org>
References: <20210630040034.1155892-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

These are the folio equivalents of lock_page_memcg() and
unlock_page_memcg().  Reimplement them as wrappers.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/memcontrol.h | 10 +++++++++
 mm/memcontrol.c            | 45 ++++++++++++++++++++++++--------------
 2 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index ef79f9c0b296..279ea2640365 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -951,6 +951,8 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg);
 extern bool cgroup_memory_noswap;
 #endif
 
+void folio_memcg_lock(struct folio *folio);
+void folio_memcg_unlock(struct folio *folio);
 void lock_page_memcg(struct page *page);
 void unlock_page_memcg(struct page *page);
 
@@ -1363,6 +1365,14 @@ static inline void unlock_page_memcg(struct page *page)
 {
 }
 
+static inline void folio_memcg_lock(struct folio *folio)
+{
+}
+
+static inline void folio_memcg_unlock(struct folio *folio)
+{
+}
+
 static inline void mem_cgroup_handle_over_high(void)
 {
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b925bdce0c6e..b94a6122f27d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1960,18 +1960,17 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg)
 }
 
 /**
- * lock_page_memcg - lock a page and memcg binding
- * @page: the page
+ * folio_memcg_lock - Bind a folio to its memcg.
+ * @folio: The folio.
  *
- * This function protects unlocked LRU pages from being moved to
+ * This function prevents unlocked LRU folios from being moved to
  * another cgroup.
  *
- * It ensures lifetime of the locked memcg. Caller is responsible
- * for the lifetime of the page.
+ * It ensures lifetime of the bound memcg.  The caller is responsible
+ * for the lifetime of the folio.
  */
-void lock_page_memcg(struct page *page)
+void folio_memcg_lock(struct folio *folio)
 {
-	struct page *head = compound_head(page); /* rmap on tail pages */
 	struct mem_cgroup *memcg;
 	unsigned long flags;
 
@@ -1985,7 +1984,7 @@ void lock_page_memcg(struct page *page)
 	if (mem_cgroup_disabled())
 		return;
 again:
-	memcg = page_memcg(head);
+	memcg = folio_memcg(folio);
 	if (unlikely(!memcg))
 		return;
 
@@ -1999,7 +1998,7 @@ void lock_page_memcg(struct page *page)
 		return;
 
 	spin_lock_irqsave(&memcg->move_lock, flags);
-	if (memcg != page_memcg(head)) {
+	if (memcg != folio_memcg(folio)) {
 		spin_unlock_irqrestore(&memcg->move_lock, flags);
 		goto again;
 	}
@@ -2013,9 +2012,15 @@ void lock_page_memcg(struct page *page)
 	memcg->move_lock_task = current;
 	memcg->move_lock_flags = flags;
 }
+EXPORT_SYMBOL(folio_memcg_lock);
+
+void lock_page_memcg(struct page *page)
+{
+	folio_memcg_lock(page_folio(page));
+}
 EXPORT_SYMBOL(lock_page_memcg);
 
-static void __unlock_page_memcg(struct mem_cgroup *memcg)
+static void __memcg_unlock(struct mem_cgroup *memcg)
 {
 	if (memcg && memcg->move_lock_task == current) {
 		unsigned long flags = memcg->move_lock_flags;
@@ -2030,14 +2035,22 @@ static void __unlock_page_memcg(struct mem_cgroup *memcg)
 }
 
 /**
- * unlock_page_memcg - unlock a page and memcg binding
- * @page: the page
+ * folio_memcg_unlock - Release the binding between a folio and its memcg.
+ * @folio: The folio.
+ *
+ * This releases the binding created by folio_memcg_lock().  This does
+ * not change the accounting of this folio to its memcg, but it does
+ * permit others to change it.
  */
-void unlock_page_memcg(struct page *page)
+void folio_memcg_unlock(struct folio *folio)
 {
-	struct page *head = compound_head(page);
+	__memcg_unlock(folio_memcg(folio));
+}
+EXPORT_SYMBOL(folio_memcg_unlock);
 
-	__unlock_page_memcg(page_memcg(head));
+void unlock_page_memcg(struct page *page)
+{
+	folio_memcg_unlock(page_folio(page));
 }
 EXPORT_SYMBOL(unlock_page_memcg);
 
@@ -5661,7 +5674,7 @@ static int mem_cgroup_move_account(struct page *page,
 
 	page->memcg_data = (unsigned long)to;
 
-	__unlock_page_memcg(from);
+	__memcg_unlock(from);
 
 	ret = 0;
 	nid = page_to_nid(page);
-- 
2.30.2


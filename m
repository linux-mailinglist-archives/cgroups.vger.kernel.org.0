Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8659B3B7C6A
	for <lists+cgroups@lfdr.de>; Wed, 30 Jun 2021 06:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhF3EL1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Jun 2021 00:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhF3EL0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Jun 2021 00:11:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA26AC061760
        for <cgroups@vger.kernel.org>; Tue, 29 Jun 2021 21:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=kOgSDY9XpY3a3MJvXCpmTtvtHJLW2b/IsU2xttrkmZc=; b=angQ8OeGW1ANOe7Wc5hCMAE2pV
        VS6H/3c3vVjq8xVxfb5QSFIN/87lwgYubymYCPw7ZZA14WiFYps87oyvm15mHKC3Q6Z0WrmKtPIDl
        4Gdfy/OzoHckMrwrswdknlFdXeq1yXVm0VQ2z8Pe0McAEp82ECN613VRTnqkv3+THsfRmGmptBy1h
        qDhS4mNjS4ON7k+i5StuOVpSNcyWSAtOzDPIToBO8vlLMlWGLEHrrpw1uzYuY8BYYrxU+/pi/jOxz
        Mbp7OO0Li8W9a5h01mJnUsR38sMq1iecvZNlFEfob4vIjswQzB/jgtYfYlp1Lyp7HOQVzhHQfCqvA
        f9Tye7IQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyRVe-004rEf-Iw; Wed, 30 Jun 2021 04:07:45 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: [PATCH v3 11/18] mm/memcg: Convert mem_cgroup_migrate() to take folios
Date:   Wed, 30 Jun 2021 05:00:27 +0100
Message-Id: <20210630040034.1155892-12-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210630040034.1155892-1-willy@infradead.org>
References: <20210630040034.1155892-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Convert all callers of mem_cgroup_migrate() to call page_folio() first.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/memcontrol.h |  4 ++--
 mm/filemap.c               |  4 +++-
 mm/memcontrol.c            | 35 +++++++++++++++++------------------
 mm/migrate.c               |  4 +++-
 mm/shmem.c                 |  5 ++++-
 5 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d6386a2b9d7a..2c57a405acd2 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -713,7 +713,7 @@ void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry);
 void mem_cgroup_uncharge(struct folio *);
 void mem_cgroup_uncharge_list(struct list_head *page_list);
 
-void mem_cgroup_migrate(struct page *oldpage, struct page *newpage);
+void mem_cgroup_migrate(struct folio *old, struct folio *new);
 
 /**
  * mem_cgroup_lruvec - get the lru list vector for a memcg & node
@@ -1210,7 +1210,7 @@ static inline void mem_cgroup_uncharge_list(struct list_head *page_list)
 {
 }
 
-static inline void mem_cgroup_migrate(struct page *old, struct page *new)
+static inline void mem_cgroup_migrate(struct folio *old, struct folio *new)
 {
 }
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 0008ada132c4..964f1643dd97 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -817,6 +817,8 @@ EXPORT_SYMBOL(file_write_and_wait_range);
  */
 void replace_page_cache_page(struct page *old, struct page *new)
 {
+	struct folio *fold = page_folio(old);
+	struct folio *fnew = page_folio(new);
 	struct address_space *mapping = old->mapping;
 	void (*freepage)(struct page *) = mapping->a_ops->freepage;
 	pgoff_t offset = old->index;
@@ -831,7 +833,7 @@ void replace_page_cache_page(struct page *old, struct page *new)
 	new->mapping = mapping;
 	new->index = offset;
 
-	mem_cgroup_migrate(old, new);
+	mem_cgroup_migrate(fold, fnew);
 
 	xas_lock_irqsave(&xas, flags);
 	xas_store(&xas, new);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 90a53f554371..4ce2f2eb81d8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6936,36 +6936,35 @@ void mem_cgroup_uncharge_list(struct list_head *page_list)
 }
 
 /**
- * mem_cgroup_migrate - charge a page's replacement
- * @oldpage: currently circulating page
- * @newpage: replacement page
+ * mem_cgroup_migrate - Charge a folio's replacement.
+ * @old: Currently circulating folio.
+ * @new: Replacement folio.
  *
- * Charge @newpage as a replacement page for @oldpage. @oldpage will
+ * Charge @new as a replacement folio for @old. @old will
  * be uncharged upon free.
  *
- * Both pages must be locked, @newpage->mapping must be set up.
+ * Both folios must be locked, @new->mapping must be set up.
  */
-void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
+void mem_cgroup_migrate(struct folio *old, struct folio *new)
 {
-	struct folio *newfolio = page_folio(newpage);
 	struct mem_cgroup *memcg;
-	unsigned int nr_pages = folio_nr_pages(newfolio);
+	unsigned int nr_pages = folio_nr_pages(new);
 	unsigned long flags;
 
-	VM_BUG_ON_PAGE(!PageLocked(oldpage), oldpage);
-	VM_BUG_ON_FOLIO(!folio_locked(newfolio), newfolio);
-	VM_BUG_ON_FOLIO(PageAnon(oldpage) != folio_anon(newfolio), newfolio);
-	VM_BUG_ON_FOLIO(compound_nr(oldpage) != nr_pages, newfolio);
+	VM_BUG_ON_FOLIO(!folio_locked(old), old);
+	VM_BUG_ON_FOLIO(!folio_locked(new), new);
+	VM_BUG_ON_FOLIO(folio_anon(old) != folio_anon(new), new);
+	VM_BUG_ON_FOLIO(folio_nr_pages(old) != nr_pages, new);
 
 	if (mem_cgroup_disabled())
 		return;
 
-	/* Page cache replacement: new page already charged? */
-	if (folio_memcg(newfolio))
+	/* Page cache replacement: new folio already charged? */
+	if (folio_memcg(new))
 		return;
 
-	memcg = page_memcg(oldpage);
-	VM_WARN_ON_ONCE_PAGE(!memcg, oldpage);
+	memcg = folio_memcg(old);
+	VM_WARN_ON_ONCE_FOLIO(!memcg, old);
 	if (!memcg)
 		return;
 
@@ -6977,11 +6976,11 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 	}
 
 	css_get(&memcg->css);
-	commit_charge(newfolio, memcg);
+	commit_charge(new, memcg);
 
 	local_irq_save(flags);
 	mem_cgroup_charge_statistics(memcg, nr_pages);
-	memcg_check_events(memcg, page_to_nid(newpage));
+	memcg_check_events(memcg, folio_nid(new));
 	local_irq_restore(flags);
 }
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 94efe09bb2a0..f71e72f9c812 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -582,6 +582,8 @@ static void copy_huge_page(struct page *dst, struct page *src)
  */
 void migrate_page_states(struct page *newpage, struct page *page)
 {
+	struct folio *folio = page_folio(page);
+	struct folio *newfolio = page_folio(newpage);
 	int cpupid;
 
 	if (PageError(page))
@@ -646,7 +648,7 @@ void migrate_page_states(struct page *newpage, struct page *page)
 	copy_page_owner(page, newpage);
 
 	if (!PageHuge(page))
-		mem_cgroup_migrate(page, newpage);
+		mem_cgroup_migrate(folio, newfolio);
 }
 EXPORT_SYMBOL(migrate_page_states);
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 3cc5ddd5cc6b..1e172fb40fb3 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1619,6 +1619,7 @@ static int shmem_replace_page(struct page **pagep, gfp_t gfp,
 				struct shmem_inode_info *info, pgoff_t index)
 {
 	struct page *oldpage, *newpage;
+	struct folio *old, *new;
 	struct address_space *swap_mapping;
 	swp_entry_t entry;
 	pgoff_t swap_index;
@@ -1655,7 +1656,9 @@ static int shmem_replace_page(struct page **pagep, gfp_t gfp,
 	xa_lock_irq(&swap_mapping->i_pages);
 	error = shmem_replace_entry(swap_mapping, swap_index, oldpage, newpage);
 	if (!error) {
-		mem_cgroup_migrate(oldpage, newpage);
+		old = page_folio(oldpage);
+		new = page_folio(newpage);
+		mem_cgroup_migrate(old, new);
 		__inc_lruvec_page_state(newpage, NR_FILE_PAGES);
 		__dec_lruvec_page_state(oldpage, NR_FILE_PAGES);
 	}
-- 
2.30.2


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64463C6439
	for <lists+cgroups@lfdr.de>; Mon, 12 Jul 2021 21:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbhGLTzS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Jul 2021 15:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236652AbhGLTzR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Jul 2021 15:55:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C168C0613E8;
        Mon, 12 Jul 2021 12:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=LwA7VSocPE+sRZTUGK9+W+V+/dVYYufIe3SAcyWueu0=; b=aiaJPIj9hcI3J68l/uFxyI6z+c
        SQAbEgXaW3uWfWK6APcfocb+ifCcq3hGHW/7nCk42Q6Mc0N3iFEdsT8cYaMgAEPQ6Nej0BC7D9sv4
        yOY+S+CtWzWXED3AV3/9euSAQ3EfIjC6/ndDM9I1yccnezDjdwgTloZ+vNUX9j5RrMMi6Grb8R+RR
        e5/vb7m8Onfz1HBnVG3aBPFWbO6RroYGyGzOUSRl0gv6jV1AECWuEcqtBdQVo9QLT/stGA2ikygu/
        RQYESqanAZ/CiC1f5xVfHvytUZksS22Pa1kYJHtgMspFx78GmWH7DfwbZfZ0lwHz8xkou3nW86+V/
        92kApQWg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m31xc-000OLr-TD; Mon, 12 Jul 2021 19:51:42 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v13 11/18] mm/memcg: Convert mem_cgroup_migrate() to take folios
Date:   Mon, 12 Jul 2021 20:45:44 +0100
Message-Id: <20210712194551.91920-12-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712194551.91920-1-willy@infradead.org>
References: <20210712194551.91920-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Convert all callers of mem_cgroup_migrate() to call page_folio() first.
They all look like they're using head pages already, but this proves it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/memcontrol.h |  4 ++--
 mm/filemap.c               |  4 +++-
 mm/memcontrol.c            | 35 +++++++++++++++++------------------
 mm/migrate.c               |  4 +++-
 mm/shmem.c                 |  5 ++++-
 5 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 876465323b06..46bad4a50e19 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -712,7 +712,7 @@ void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry);
 void mem_cgroup_uncharge(struct folio *folio);
 void mem_cgroup_uncharge_list(struct list_head *page_list);
 
-void mem_cgroup_migrate(struct page *oldpage, struct page *newpage);
+void mem_cgroup_migrate(struct folio *old, struct folio *new);
 
 /**
  * mem_cgroup_lruvec - get the lru list vector for a memcg & node
@@ -1214,7 +1214,7 @@ static inline void mem_cgroup_uncharge_list(struct list_head *page_list)
 {
 }
 
-static inline void mem_cgroup_migrate(struct page *old, struct page *new)
+static inline void mem_cgroup_migrate(struct folio *old, struct folio *new)
 {
 }
 
diff --git a/mm/filemap.c b/mm/filemap.c
index b8be62793316..cc21da4157f1 100644
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
index c787a87a54ff..06fc88d75a04 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6941,36 +6941,35 @@ void mem_cgroup_uncharge_list(struct list_head *page_list)
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
 
@@ -6982,11 +6981,11 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
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
index 01c05d7f9d6a..d8df117dca7e 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -589,6 +589,8 @@ void copy_huge_page(struct page *dst, struct page *src)
  */
 void migrate_page_states(struct page *newpage, struct page *page)
 {
+	struct folio *folio = page_folio(page);
+	struct folio *newfolio = page_folio(newpage);
 	int cpupid;
 
 	if (PageError(page))
@@ -656,7 +658,7 @@ void migrate_page_states(struct page *newpage, struct page *page)
 	copy_page_owner(page, newpage);
 
 	if (!PageHuge(page))
-		mem_cgroup_migrate(page, newpage);
+		mem_cgroup_migrate(folio, newfolio);
 }
 EXPORT_SYMBOL(migrate_page_states);
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 3931fed5c8d8..2fd75b4d4974 100644
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


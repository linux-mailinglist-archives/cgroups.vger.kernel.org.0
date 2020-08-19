Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37BFC24A636
	for <lists+cgroups@lfdr.de>; Wed, 19 Aug 2020 20:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgHSStK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Aug 2020 14:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgHSStH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Aug 2020 14:49:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317BBC061343;
        Wed, 19 Aug 2020 11:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ND98uMZYrcjfbVhxga4enxbqENG9QME9SJj8HZvY1Rw=; b=JPo0GgqofTk7M5A0cGUAOy99T2
        5nHqBXZ+m83jatnjFvA0RKJJ/SDhAoR8rXyzbhaBPVI1ig31d/FaB9LjNYGIPTUJOsk5E3HSrLbS4
        NXj00j+SXuSiu6Xl3KXQhcIGyvr/vPp7cvZIRk0alqg2evX3lW37FqP56ZOrlvjeCYAc5TJyTF7kG
        tKvYFXrnqSLamGVH1LjMrnspOcwR97NVZkxKZ/b+gcDGQe/WPt0hHvruO4I8QTyReFX1IezLYtTLS
        wuHER1m2boO71ITzeQmzJBMJmi9jH9hs3Rw1QFCTk6q7j9BDEQ9Lj+120aiy7ZnDSlOwyMloN7scs
        JYe52Trw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8T8m-0006Ss-Tl; Wed, 19 Aug 2020 18:48:52 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        intel-gfx@lists.freedesktop.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] mm: Factor find_get_swap_page out of mincore_page
Date:   Wed, 19 Aug 2020 19:48:43 +0100
Message-Id: <20200819184850.24779-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200819184850.24779-1-willy@infradead.org>
References: <20200819184850.24779-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Provide this functionality from the swap cache.  It's useful for
more than just mincore().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/swap.h |  7 +++++++
 mm/mincore.c         | 28 ++--------------------------
 mm/swap_state.c      | 31 +++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 661046994db4..247527ea3e66 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -427,6 +427,7 @@ extern void free_pages_and_swap_cache(struct page **, int);
 extern struct page *lookup_swap_cache(swp_entry_t entry,
 				      struct vm_area_struct *vma,
 				      unsigned long addr);
+struct page *find_get_swap_page(struct address_space *mapping, pgoff_t index);
 extern struct page *read_swap_cache_async(swp_entry_t, gfp_t,
 			struct vm_area_struct *vma, unsigned long addr,
 			bool do_poll);
@@ -569,6 +570,12 @@ static inline struct page *lookup_swap_cache(swp_entry_t swp,
 	return NULL;
 }
 
+static inline
+struct page *find_get_swap_page(struct address_space *mapping, pgoff_t index)
+{
+	return find_get_page(mapping, index);
+}
+
 static inline int add_to_swap(struct page *page)
 {
 	return 0;
diff --git a/mm/mincore.c b/mm/mincore.c
index 453ff112470f..2806258f99c6 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -48,7 +48,7 @@ static int mincore_hugetlb(pte_t *pte, unsigned long hmask, unsigned long addr,
  * and is up to date; i.e. that no page-in operation would be required
  * at this time if an application were to map and access this page.
  */
-static unsigned char mincore_page(struct address_space *mapping, pgoff_t pgoff)
+static unsigned char mincore_page(struct address_space *mapping, pgoff_t index)
 {
 	unsigned char present = 0;
 	struct page *page;
@@ -59,31 +59,7 @@ static unsigned char mincore_page(struct address_space *mapping, pgoff_t pgoff)
 	 * any other file mapping (ie. marked !present and faulted in with
 	 * tmpfs's .fault). So swapped out tmpfs mappings are tested here.
 	 */
-#ifdef CONFIG_SWAP
-	if (shmem_mapping(mapping)) {
-		page = find_get_entry(mapping, pgoff);
-		/*
-		 * shmem/tmpfs may return swap: account for swapcache
-		 * page too.
-		 */
-		if (xa_is_value(page)) {
-			swp_entry_t swp = radix_to_swp_entry(page);
-			struct swap_info_struct *si;
-
-			/* Prevent swap device to being swapoff under us */
-			si = get_swap_device(swp);
-			if (si) {
-				page = find_get_page(swap_address_space(swp),
-						     swp_offset(swp));
-				put_swap_device(si);
-			} else
-				page = NULL;
-		}
-	} else
-		page = find_get_page(mapping, pgoff);
-#else
-	page = find_get_page(mapping, pgoff);
-#endif
+	page = find_get_swap_page(mapping, index);
 	if (page) {
 		present = PageUptodate(page);
 		put_page(page);
diff --git a/mm/swap_state.c b/mm/swap_state.c
index c16eebb81d8b..986b4e3d3bad 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -414,6 +414,37 @@ struct page *lookup_swap_cache(swp_entry_t entry, struct vm_area_struct *vma,
 	return page;
 }
 
+/**
+ * find_get_swap_page - Find and get a page from the page or swap caches.
+ * @mapping: The address_space to search.
+ * @index: The page cache index.
+ *
+ * This is like find_get_page(), but if we find a swap entry for
+ * shmem/tmpfs, we also look in the swap cache for the page.
+ *
+ * Return: The found page or %NULL.
+ */
+struct page *find_get_swap_page(struct address_space *mapping, pgoff_t index)
+{
+	swp_entry_t swp;
+	struct swap_info_struct *si;
+	struct page *page = find_get_entry(mapping, index);
+
+	if (!xa_is_value(page))
+		return page;
+	if (!shmem_mapping(mapping))
+		return NULL;
+
+	swp = radix_to_swp_entry(page);
+	/* Prevent swapoff from happening to us */
+	si = get_swap_device(swp);
+	if (!si)
+		return NULL;
+	page = find_get_page(swap_address_space(swp), swp_offset(swp));
+	put_swap_device(si);
+	return page;
+}
+
 struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 			struct vm_area_struct *vma, unsigned long addr,
 			bool *new_page_allocated)
-- 
2.28.0


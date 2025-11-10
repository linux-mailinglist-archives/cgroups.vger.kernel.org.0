Return-Path: <cgroups+bounces-11769-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64423C49BAC
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 00:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CD0C3AC2BD
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 23:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D740E2206A7;
	Mon, 10 Nov 2025 23:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R4NU6Q8J"
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8FB242D78
	for <cgroups@vger.kernel.org>; Mon, 10 Nov 2025 23:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762816887; cv=none; b=RDkRcH80xRuaFvyrZu9RKkELbk1wxm3sMnf+yTxmw5V75Q05e+bbTK1TWGR0ODbJgPAWT+M8PU3RS/E/akWr0XuGLGDQFg0zdhRvR/vSvmIEjlafPZxTN2lfETp3FFCZXD9/b5r13giyTLU0u8HBrTpwk6D5mdpz5L1WcBxNxuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762816887; c=relaxed/simple;
	bh=WLEBOTkZKUM14cVgKXUz+PaAOxh51gV8vtHKxRIAvWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PlffS/64qGp93+IHvBg2Uu0uVEoSTvMSAx/7FyBzm96nUdiEPReEenREBXTClBPFyj7CcwjtbHGs8QDnKXmmyJRuyhNoL9I89Rc+0YmS19VabFjCC08UiPnugqFJZPbUvu3aD7wm28j69WoxJhQ+il9LNph2JCZio7biazdjKwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R4NU6Q8J; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762816883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KeXZlzM9S/cAH2YiJk+aaehPaWC6sAatt90g+33TR9M=;
	b=R4NU6Q8JCz+vv5o5XmD4mFPnZiEkcZEeGblXosVFQw+RFf9leuRmhR0urgV21dHwZQIuL9
	T3w0t0fzyPiOGdBbxvlt0vGbaBSsux7ELLDLlXmNEd0BBaDNtaUNWI0NmH6bvA0RUStsI0
	ANDzkbGwvlFROHEOOQpmnoW1jnNzIAk=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH 4/4] memcg: remove __lruvec_stat_mod_folio
Date: Mon, 10 Nov 2025 15:20:08 -0800
Message-ID: <20251110232008.1352063-5-shakeel.butt@linux.dev>
In-Reply-To: <20251110232008.1352063-1-shakeel.butt@linux.dev>
References: <20251110232008.1352063-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The __lruvec_stat_mod_folio is already safe against irqs, so there is no
need to have a separate interface (i.e. lruvec_stat_mod_folio) which
wraps calls to it with irq disabling and reenabling. Let's rename
__lruvec_stat_mod_folio to lruvec_stat_mod_folio.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/vmstat.h | 30 +-----------------------------
 mm/filemap.c           | 20 ++++++++++----------
 mm/huge_memory.c       |  4 ++--
 mm/khugepaged.c        |  8 ++++----
 mm/memcontrol.c        |  4 ++--
 mm/page-writeback.c    |  2 +-
 mm/rmap.c              |  4 ++--
 mm/shmem.c             |  6 +++---
 8 files changed, 25 insertions(+), 53 deletions(-)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 4eb7753e6e5c..3398a345bda8 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -523,19 +523,9 @@ static inline const char *vm_event_name(enum vm_event_item item)
 void mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 			int val);
 
-void __lruvec_stat_mod_folio(struct folio *folio,
+void lruvec_stat_mod_folio(struct folio *folio,
 			     enum node_stat_item idx, int val);
 
-static inline void lruvec_stat_mod_folio(struct folio *folio,
-					 enum node_stat_item idx, int val)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	__lruvec_stat_mod_folio(folio, idx, val);
-	local_irq_restore(flags);
-}
-
 static inline void mod_lruvec_page_state(struct page *page,
 					 enum node_stat_item idx, int val)
 {
@@ -550,12 +540,6 @@ static inline void mod_lruvec_state(struct lruvec *lruvec,
 	mod_node_page_state(lruvec_pgdat(lruvec), idx, val);
 }
 
-static inline void __lruvec_stat_mod_folio(struct folio *folio,
-					 enum node_stat_item idx, int val)
-{
-	mod_node_page_state(folio_pgdat(folio), idx, val);
-}
-
 static inline void lruvec_stat_mod_folio(struct folio *folio,
 					 enum node_stat_item idx, int val)
 {
@@ -570,18 +554,6 @@ static inline void mod_lruvec_page_state(struct page *page,
 
 #endif /* CONFIG_MEMCG */
 
-static inline void __lruvec_stat_add_folio(struct folio *folio,
-					   enum node_stat_item idx)
-{
-	__lruvec_stat_mod_folio(folio, idx, folio_nr_pages(folio));
-}
-
-static inline void __lruvec_stat_sub_folio(struct folio *folio,
-					   enum node_stat_item idx)
-{
-	__lruvec_stat_mod_folio(folio, idx, -folio_nr_pages(folio));
-}
-
 static inline void lruvec_stat_add_folio(struct folio *folio,
 					 enum node_stat_item idx)
 {
diff --git a/mm/filemap.c b/mm/filemap.c
index 63eb163af99c..9a52fb3ba093 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -182,13 +182,13 @@ static void filemap_unaccount_folio(struct address_space *mapping,
 
 	nr = folio_nr_pages(folio);
 
-	__lruvec_stat_mod_folio(folio, NR_FILE_PAGES, -nr);
+	lruvec_stat_mod_folio(folio, NR_FILE_PAGES, -nr);
 	if (folio_test_swapbacked(folio)) {
-		__lruvec_stat_mod_folio(folio, NR_SHMEM, -nr);
+		lruvec_stat_mod_folio(folio, NR_SHMEM, -nr);
 		if (folio_test_pmd_mappable(folio))
-			__lruvec_stat_mod_folio(folio, NR_SHMEM_THPS, -nr);
+			lruvec_stat_mod_folio(folio, NR_SHMEM_THPS, -nr);
 	} else if (folio_test_pmd_mappable(folio)) {
-		__lruvec_stat_mod_folio(folio, NR_FILE_THPS, -nr);
+		lruvec_stat_mod_folio(folio, NR_FILE_THPS, -nr);
 		filemap_nr_thps_dec(mapping);
 	}
 	if (test_bit(AS_KERNEL_FILE, &folio->mapping->flags))
@@ -831,13 +831,13 @@ void replace_page_cache_folio(struct folio *old, struct folio *new)
 	old->mapping = NULL;
 	/* hugetlb pages do not participate in page cache accounting. */
 	if (!folio_test_hugetlb(old))
-		__lruvec_stat_sub_folio(old, NR_FILE_PAGES);
+		lruvec_stat_sub_folio(old, NR_FILE_PAGES);
 	if (!folio_test_hugetlb(new))
-		__lruvec_stat_add_folio(new, NR_FILE_PAGES);
+		lruvec_stat_add_folio(new, NR_FILE_PAGES);
 	if (folio_test_swapbacked(old))
-		__lruvec_stat_sub_folio(old, NR_SHMEM);
+		lruvec_stat_sub_folio(old, NR_SHMEM);
 	if (folio_test_swapbacked(new))
-		__lruvec_stat_add_folio(new, NR_SHMEM);
+		lruvec_stat_add_folio(new, NR_SHMEM);
 	xas_unlock_irq(&xas);
 	if (free_folio)
 		free_folio(old);
@@ -920,9 +920,9 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 
 		/* hugetlb pages do not participate in page cache accounting */
 		if (!huge) {
-			__lruvec_stat_mod_folio(folio, NR_FILE_PAGES, nr);
+			lruvec_stat_mod_folio(folio, NR_FILE_PAGES, nr);
 			if (folio_test_pmd_mappable(folio))
-				__lruvec_stat_mod_folio(folio,
+				lruvec_stat_mod_folio(folio,
 						NR_FILE_THPS, nr);
 		}
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 949250932bb4..943099eae8d5 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3866,10 +3866,10 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 			if (folio_test_pmd_mappable(folio) &&
 			    new_order < HPAGE_PMD_ORDER) {
 				if (folio_test_swapbacked(folio)) {
-					__lruvec_stat_mod_folio(folio,
+					lruvec_stat_mod_folio(folio,
 							NR_SHMEM_THPS, -nr);
 				} else {
-					__lruvec_stat_mod_folio(folio,
+					lruvec_stat_mod_folio(folio,
 							NR_FILE_THPS, -nr);
 					filemap_nr_thps_dec(mapping);
 				}
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 1a08673b0d8b..2a460664a67d 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2174,14 +2174,14 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	}
 
 	if (is_shmem)
-		__lruvec_stat_mod_folio(new_folio, NR_SHMEM_THPS, HPAGE_PMD_NR);
+		lruvec_stat_mod_folio(new_folio, NR_SHMEM_THPS, HPAGE_PMD_NR);
 	else
-		__lruvec_stat_mod_folio(new_folio, NR_FILE_THPS, HPAGE_PMD_NR);
+		lruvec_stat_mod_folio(new_folio, NR_FILE_THPS, HPAGE_PMD_NR);
 
 	if (nr_none) {
-		__lruvec_stat_mod_folio(new_folio, NR_FILE_PAGES, nr_none);
+		lruvec_stat_mod_folio(new_folio, NR_FILE_PAGES, nr_none);
 		/* nr_none is always 0 for non-shmem. */
-		__lruvec_stat_mod_folio(new_folio, NR_SHMEM, nr_none);
+		lruvec_stat_mod_folio(new_folio, NR_SHMEM, nr_none);
 	}
 
 	/*
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c31074e5852b..7f074d72dabc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -777,7 +777,7 @@ void mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 		mod_memcg_lruvec_state(lruvec, idx, val);
 }
 
-void __lruvec_stat_mod_folio(struct folio *folio, enum node_stat_item idx,
+void lruvec_stat_mod_folio(struct folio *folio, enum node_stat_item idx,
 			     int val)
 {
 	struct mem_cgroup *memcg;
@@ -797,7 +797,7 @@ void __lruvec_stat_mod_folio(struct folio *folio, enum node_stat_item idx,
 	mod_lruvec_state(lruvec, idx, val);
 	rcu_read_unlock();
 }
-EXPORT_SYMBOL(__lruvec_stat_mod_folio);
+EXPORT_SYMBOL(lruvec_stat_mod_folio);
 
 void mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val)
 {
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index a124ab6a205d..ccdeb0e84d39 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2652,7 +2652,7 @@ static void folio_account_dirtied(struct folio *folio,
 		inode_attach_wb(inode, folio);
 		wb = inode_to_wb(inode);
 
-		__lruvec_stat_mod_folio(folio, NR_FILE_DIRTY, nr);
+		lruvec_stat_mod_folio(folio, NR_FILE_DIRTY, nr);
 		__zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, nr);
 		__node_stat_mod_folio(folio, NR_DIRTIED, nr);
 		wb_stat_mod(wb, WB_RECLAIMABLE, nr);
diff --git a/mm/rmap.c b/mm/rmap.c
index 60c3cd70b6ea..1b3a3c7b0aeb 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1212,12 +1212,12 @@ static void __folio_mod_stat(struct folio *folio, int nr, int nr_pmdmapped)
 
 	if (nr) {
 		idx = folio_test_anon(folio) ? NR_ANON_MAPPED : NR_FILE_MAPPED;
-		__lruvec_stat_mod_folio(folio, idx, nr);
+		lruvec_stat_mod_folio(folio, idx, nr);
 	}
 	if (nr_pmdmapped) {
 		if (folio_test_anon(folio)) {
 			idx = NR_ANON_THPS;
-			__lruvec_stat_mod_folio(folio, idx, nr_pmdmapped);
+			lruvec_stat_mod_folio(folio, idx, nr_pmdmapped);
 		} else {
 			/* NR_*_PMDMAPPED are not maintained per-memcg */
 			idx = folio_test_swapbacked(folio) ?
diff --git a/mm/shmem.c b/mm/shmem.c
index c3ed2dcd17f8..4fba8a597256 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -882,9 +882,9 @@ static unsigned int shmem_huge_global_enabled(struct inode *inode, pgoff_t index
 static void shmem_update_stats(struct folio *folio, int nr_pages)
 {
 	if (folio_test_pmd_mappable(folio))
-		__lruvec_stat_mod_folio(folio, NR_SHMEM_THPS, nr_pages);
-	__lruvec_stat_mod_folio(folio, NR_FILE_PAGES, nr_pages);
-	__lruvec_stat_mod_folio(folio, NR_SHMEM, nr_pages);
+		lruvec_stat_mod_folio(folio, NR_SHMEM_THPS, nr_pages);
+	lruvec_stat_mod_folio(folio, NR_FILE_PAGES, nr_pages);
+	lruvec_stat_mod_folio(folio, NR_SHMEM, nr_pages);
 }
 
 /*
-- 
2.47.3



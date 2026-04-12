Return-Path: <cgroups+bounces-15231-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBOxNOjr22lkIwkAu9opvQ
	(envelope-from <cgroups+bounces-15231-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 21:00:56 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 791BF3E5916
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 21:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FBB4301454E
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 19:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF2437B007;
	Sun, 12 Apr 2026 19:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pun7H51n"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6A5212FAD;
	Sun, 12 Apr 2026 19:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776020405; cv=none; b=qWhm3CaFoBELL+mRI0kDnEmk+Jtlm0nGCQlQOrXoINoFAh1ZYNNlVKqXTQV1mEsmil7E6Aj+GICEJLutH6IEve6adoZfgc0mFKoAaGMsIiuANr50aEI29RA4uZp7ZhLrdfTt+bP77O1dIs2oYzfOEPJd0cctidbczk5whizd3wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776020405; c=relaxed/simple;
	bh=z0FycolEC/hA2fNoRfGSQMHKHO9y5oklz5MYsCc8qTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eWB311I8Jc4kkIHPWdiaKAyGn1x3lsvm4sDwa28IKy4XyjL0FO8agT+eHfqRMSu9/f+08QiZjdWrAfumt0XQpxlKHxwSagHXGo/wTqdW1lvs/j1KeiqSaj+uvsAhp/AXIeImr9UNnMZu8trWHn64sE/KXHOBbHWsJwhqgsPgY5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pun7H51n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A51C19424;
	Sun, 12 Apr 2026 18:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776020404;
	bh=z0FycolEC/hA2fNoRfGSQMHKHO9y5oklz5MYsCc8qTc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Pun7H51nn3MNLOdz8dNZTytgI91h85zAu9aR8QqxEtehYGNjD7oE0GEY7TEJwz5uV
	 t5soC2FIEP79Vdu3ie9AmiZMU4W71/A82X3ZAeIEIUivzymD85YN14Ej+Tf05m+KvS
	 s1cpxgUAf+ZcKW8HFabZVi6rCDKYQ0jc8mhwHKHOHoSj8eOps7LDqsZzEklODZZybn
	 aS8CT37FnKcNnFJIqrNXv7J2WsaVDavHyLJ4l4P3f2D4Se5WjN4CJTVgiGPf4nkw2O
	 8Ddljp8dKWUyKjnWdkR05hCx2kGAk+QpwBJIAjnfUYMIhnRIC4uXHLbEDlZ0wZvWip
	 Am8h9/ZM44dgQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sun, 12 Apr 2026 20:59:32 +0200
Subject: [PATCH RFC 01/13] mm/rmap: remove folio->_nr_pages_mapped
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-mapcount-v1-1-05e8dfab52e0@kernel.org>
References: <20260412-mapcount-v1-0-05e8dfab52e0@kernel.org>
In-Reply-To: <20260412-mapcount-v1-0-05e8dfab52e0@kernel.org>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Jann Horn <jannh@google.com>, Brendan Jackman <jackmanb@google.com>, 
 Zi Yan <ziy@nvidia.com>, Pedro Falcato <pfalcato@suse.de>, 
 Matthew Wilcox <willy@infradead.org>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-fsdevel@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.13.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15231-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 791BF3E5916
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In preparation for removing CONFIG_PAGE_MAPCOUNT, let's stop updating
a folio's _nr_pages_mapped and remove it.

This will make CONFIG_PAGE_MAPCOUNT behave just like
CONFIG_NO_PAGE_MAPCOUNT, in particular:

(1) We account folios as fully mapped as soon as a single page is
    mapped. That is visible through:

    (1) Memcg stats (e.g., "anon" and "file_mapped" in cgroup v2)

    (2) System stats (e.g., "AnonPages:", "Mapped:" and "Shmem"
        in /proc/meminfo)

    (3) Per-node stats (e.g., "AnonPages:", "Mapped:" and "Shmem")
        in /sys/devices/system/node/nodeX/meminfo

Especially for anonymous memory, that memory consumption is now visible
for partially-mapped folios until actually split and the unmapped pages
are reclaimed.

(2) We do not detect partially-mapped anonymous folios in all cases

We now detect partial mappings based on the average per-page mapcount in a
folio: if it is < 1, at least one page is not mapped.

In the most common case (exclusive anonymous folios), we always detect
partial mappings this way reliably.

Example scenarios where we will not detect partial mappings:

(A) Allocate a THP and fork a child process. Then, unmap up to half of the
    THP in the parent *and* the child. Once the child quits, we detect
    the partial mapping.

    The folio mapcount will be >= 512 -> Average >= 1.

(B) Allocate a THP and fork 511 child processes. Then, unmap all but one
    page in *all* processes.

    The folio mapcount will be 512 -> Average == 1.

There are two main ideas on how to detect these cases as well, if we
ever get a real indication that this is problematic:

* Let memory reclaim scan candidates (shared anonymous folios) to detect
  partial mappings.

* Add candidate folios to the deferred split queue and let the deferred
  shrinker detect partial mappings.

More code cleanups are possible, but we'll defer that and focus on the
core change here.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 Documentation/admin-guide/cgroup-v1/memory.rst |   6 +-
 Documentation/admin-guide/cgroup-v2.rst        |  13 +-
 Documentation/mm/transhuge.rst                 |  23 ++--
 include/linux/mm_types.h                       |   4 +-
 include/linux/rmap.h                           |   4 +-
 mm/debug.c                                     |   3 +-
 mm/internal.h                                  |  24 ----
 mm/page_alloc.c                                |   5 -
 mm/rmap.c                                      | 159 ++++++++-----------------
 9 files changed, 69 insertions(+), 172 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 7db63c002922..ddb5ff5cee15 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -609,9 +609,9 @@ memory.stat file includes following statistics:
 
 	'rss + mapped_file" will give you resident set size of cgroup.
 
-	Note that some kernel configurations might account complete larger
-	allocations (e.g., THP) towards 'rss' and 'mapped_file', even if
-	only some, but not all that memory is mapped.
+	Note that the kernel accounts entire larger allocations (e.g., THP)
+	towards 'rss' and 'mapped_file' if any part of such an allocation
+	is mapped.
 
 	(Note: file and shmem may be shared among other cgroups. In that case,
 	mapped_file is accounted only when the memory cgroup is owner of page
diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 8ad0b2781317..aa703ec89e29 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1538,10 +1538,9 @@ The following nested keys are defined.
 
 	  anon
 		Amount of memory used in anonymous mappings such as
-		brk(), sbrk(), and mmap(MAP_ANONYMOUS). Note that
-		some kernel configurations might account complete larger
-		allocations (e.g., THP) if only some, but not all the
-		memory of such an allocation is mapped anymore.
+		brk(), sbrk(), and mmap(MAP_ANONYMOUS). Note that the
+		kernel accounts entire larger allocations (e.g., THP) towards
+		"anon" if any part of such an allocation is mapped.
 
 	  file
 		Amount of memory used to cache filesystem data,
@@ -1585,9 +1584,9 @@ The following nested keys are defined.
 
 	  file_mapped
 		Amount of cached filesystem data mapped with mmap(). Note
-		that some kernel configurations might account complete
-		larger allocations (e.g., THP) if only some, but not
-		not all the memory of such an allocation is mapped.
+		that the kernel accounts entire larger allocations
+		(e.g., THP) towards "file_mapped" if any part of such an
+		allocation is mapped.
 
 	  file_dirty
 		Amount of cached filesystem data that was modified but
diff --git a/Documentation/mm/transhuge.rst b/Documentation/mm/transhuge.rst
index 0e7f8e4cd2e3..f200c1ac19cb 100644
--- a/Documentation/mm/transhuge.rst
+++ b/Documentation/mm/transhuge.rst
@@ -122,10 +122,6 @@ pages:
     corresponding mapcount), and the current status ("maybe mapped shared" vs.
     "mapped exclusively").
 
-    With CONFIG_PAGE_MAPCOUNT, we also increment/decrement
-    folio->_nr_pages_mapped by ENTIRELY_MAPPED when _entire_mapcount goes
-    from -1 to 0 or 0 to -1.
-
   - map/unmap of individual pages with PTE entry increment/decrement
     folio->_large_mapcount.
 
@@ -134,9 +130,7 @@ pages:
     "mapped exclusively").
 
     With CONFIG_PAGE_MAPCOUNT, we also increment/decrement
-    page->_mapcount and increment/decrement folio->_nr_pages_mapped when
-    page->_mapcount goes from -1 to 0 or 0 to -1 as this counts the number
-    of pages mapped by PTE.
+    page->_mapcount.
 
 split_huge_page internally has to distribute the refcounts in the head
 page to the tail pages before clearing all PG_head/tail bits from the page
@@ -181,12 +175,9 @@ The function deferred_split_folio() is used to queue a folio for splitting.
 The splitting itself will happen when we get memory pressure via shrinker
 interface.
 
-With CONFIG_PAGE_MAPCOUNT, we reliably detect partial mappings based on
-folio->_nr_pages_mapped.
-
-With CONFIG_NO_PAGE_MAPCOUNT, we detect partial mappings based on the
-average per-page mapcount in a THP: if the average is < 1, an anon THP is
-certainly partially mapped. As long as only a single process maps a THP,
-this detection is reliable. With long-running child processes, there can
-be scenarios where partial mappings can currently not be detected, and
-might need asynchronous detection during memory reclaim in the future.
+We detect partial mappings based on the average per-page mapcount in a THP: if
+the average is < 1, an anon THP is certainly partially mapped. As long as
+only a single process maps a THP, this detection is reliable. With
+long-running child processes, there can be scenarios where partial mappings
+can currently not be detected, and might need asynchronous detection during
+memory reclaim in the future.
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index a308e2c23b82..47b2c3d05f41 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -377,7 +377,7 @@ typedef unsigned short mm_id_t;
  * @_last_cpupid: IDs of last CPU and last process that accessed the folio.
  * @_entire_mapcount: Do not use directly, call folio_entire_mapcount().
  * @_large_mapcount: Do not use directly, call folio_mapcount().
- * @_nr_pages_mapped: Do not use outside of rmap and debug code.
+ * @_unused_1: Temporary placeholder.
  * @_pincount: Do not use directly, call folio_maybe_dma_pinned().
  * @_nr_pages: Do not use directly, call folio_nr_pages().
  * @_mm_id: Do not use outside of rmap code.
@@ -452,7 +452,7 @@ struct folio {
 				struct {
 	/* public: */
 					atomic_t _large_mapcount;
-					atomic_t _nr_pages_mapped;
+					unsigned int _unused_1;
 #ifdef CONFIG_64BIT
 					atomic_t _entire_mapcount;
 					atomic_t _pincount;
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 8dc0871e5f00..e5569f5fdaec 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -291,7 +291,7 @@ static inline void folio_add_large_mapcount(struct folio *folio,
 static inline int folio_add_return_large_mapcount(struct folio *folio,
 		int diff, struct vm_area_struct *vma)
 {
-	BUILD_BUG();
+	return atomic_add_return(diff, &folio->_large_mapcount) + 1;
 }
 
 static inline void folio_sub_large_mapcount(struct folio *folio,
@@ -303,7 +303,7 @@ static inline void folio_sub_large_mapcount(struct folio *folio,
 static inline int folio_sub_return_large_mapcount(struct folio *folio,
 		int diff, struct vm_area_struct *vma)
 {
-	BUILD_BUG();
+	return atomic_sub_return(diff, &folio->_large_mapcount) + 1;
 }
 #endif /* CONFIG_MM_ID */
 
diff --git a/mm/debug.c b/mm/debug.c
index 77fa8fe1d641..bfb41ef17a5e 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -86,11 +86,10 @@ static void __dump_folio(const struct folio *folio, const struct page *page,
 		if (folio_has_pincount(folio))
 			pincount = atomic_read(&folio->_pincount);
 
-		pr_warn("head: order:%u mapcount:%d entire_mapcount:%d nr_pages_mapped:%d pincount:%d\n",
+		pr_warn("head: order:%u mapcount:%d entire_mapcount:%d pincount:%d\n",
 				folio_order(folio),
 				folio_mapcount(folio),
 				folio_entire_mapcount(folio),
-				folio_nr_pages_mapped(folio),
 				pincount);
 	}
 
diff --git a/mm/internal.h b/mm/internal.h
index c693646e5b3f..30e48f39d2de 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -103,34 +103,12 @@ struct pagetable_move_control {
 
 void page_writeback_init(void);
 
-/*
- * If a 16GB hugetlb folio were mapped by PTEs of all of its 4kB pages,
- * its nr_pages_mapped would be 0x400000: choose the ENTIRELY_MAPPED bit
- * above that range, instead of 2*(PMD_SIZE/PAGE_SIZE).  Hugetlb currently
- * leaves nr_pages_mapped at 0, but avoid surprise if it participates later.
- */
-#define ENTIRELY_MAPPED		0x800000
-#define FOLIO_PAGES_MAPPED	(ENTIRELY_MAPPED - 1)
-
 /*
  * Flags passed to __show_mem() and show_free_areas() to suppress output in
  * various contexts.
  */
 #define SHOW_MEM_FILTER_NODES		(0x0001u)	/* disallowed nodes */
 
-/*
- * How many individual pages have an elevated _mapcount.  Excludes
- * the folio's entire_mapcount.
- *
- * Don't use this function outside of debugging code.
- */
-static inline int folio_nr_pages_mapped(const struct folio *folio)
-{
-	if (IS_ENABLED(CONFIG_NO_PAGE_MAPCOUNT))
-		return -1;
-	return atomic_read(&folio->_nr_pages_mapped) & FOLIO_PAGES_MAPPED;
-}
-
 /*
  * Retrieve the first entry of a folio based on a provided entry within the
  * folio. We cannot rely on folio->swap as there is no guarantee that it has
@@ -885,8 +863,6 @@ static inline void prep_compound_head(struct page *page, unsigned int order)
 
 	folio_set_order(folio, order);
 	atomic_set(&folio->_large_mapcount, -1);
-	if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT))
-		atomic_set(&folio->_nr_pages_mapped, 0);
 	if (IS_ENABLED(CONFIG_MM_ID)) {
 		folio->_mm_ids = 0;
 		folio->_mm_id_mapcount[0] = -1;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b1c5430cad4e..8888f31aca49 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1111,11 +1111,6 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 			bad_page(page, "nonzero large_mapcount");
 			goto out;
 		}
-		if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT) &&
-		    unlikely(atomic_read(&folio->_nr_pages_mapped))) {
-			bad_page(page, "nonzero nr_pages_mapped");
-			goto out;
-		}
 		if (IS_ENABLED(CONFIG_MM_ID)) {
 			if (unlikely(folio->_mm_id_mapcount[0] != -1)) {
 				bad_page(page, "nonzero mm mapcount 0");
diff --git a/mm/rmap.c b/mm/rmap.c
index 78b7fb5f367c..df42c38fe387 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1353,9 +1353,8 @@ static __always_inline void __folio_add_rmap(struct folio *folio,
 		struct page *page, int nr_pages, struct vm_area_struct *vma,
 		enum pgtable_level level)
 {
-	atomic_t *mapped = &folio->_nr_pages_mapped;
+	int nr = 0, nr_pmdmapped = 0, mapcount;
 	const int orig_nr_pages = nr_pages;
-	int first = 0, nr = 0, nr_pmdmapped = 0;
 
 	__folio_rmap_sanity_checks(folio, page, nr_pages, level);
 
@@ -1366,61 +1365,25 @@ static __always_inline void __folio_add_rmap(struct folio *folio,
 			break;
 		}
 
-		if (IS_ENABLED(CONFIG_NO_PAGE_MAPCOUNT)) {
-			nr = folio_add_return_large_mapcount(folio, orig_nr_pages, vma);
-			if (nr == orig_nr_pages)
-				/* Was completely unmapped. */
-				nr = folio_large_nr_pages(folio);
-			else
-				nr = 0;
-			break;
+		if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT)) {
+			do {
+				atomic_inc(&page->_mapcount);
+			} while (page++, --nr_pages > 0);
 		}
 
-		do {
-			first += atomic_inc_and_test(&page->_mapcount);
-		} while (page++, --nr_pages > 0);
-
-		if (first &&
-		    atomic_add_return_relaxed(first, mapped) < ENTIRELY_MAPPED)
-			nr = first;
-
-		folio_add_large_mapcount(folio, orig_nr_pages, vma);
+		mapcount = folio_add_return_large_mapcount(folio, orig_nr_pages, vma);
+		if (mapcount == orig_nr_pages)
+			nr = folio_large_nr_pages(folio);
 		break;
 	case PGTABLE_LEVEL_PMD:
 	case PGTABLE_LEVEL_PUD:
-		first = atomic_inc_and_test(&folio->_entire_mapcount);
-		if (IS_ENABLED(CONFIG_NO_PAGE_MAPCOUNT)) {
-			if (level == PGTABLE_LEVEL_PMD && first)
-				nr_pmdmapped = folio_large_nr_pages(folio);
-			nr = folio_inc_return_large_mapcount(folio, vma);
-			if (nr == 1)
-				/* Was completely unmapped. */
-				nr = folio_large_nr_pages(folio);
-			else
-				nr = 0;
-			break;
-		}
+		if (atomic_inc_and_test(&folio->_entire_mapcount) &&
+		    level == PGTABLE_LEVEL_PMD)
+			nr_pmdmapped = HPAGE_PMD_NR;
 
-		if (first) {
-			nr = atomic_add_return_relaxed(ENTIRELY_MAPPED, mapped);
-			if (likely(nr < ENTIRELY_MAPPED + ENTIRELY_MAPPED)) {
-				nr_pages = folio_large_nr_pages(folio);
-				/*
-				 * We only track PMD mappings of PMD-sized
-				 * folios separately.
-				 */
-				if (level == PGTABLE_LEVEL_PMD)
-					nr_pmdmapped = nr_pages;
-				nr = nr_pages - (nr & FOLIO_PAGES_MAPPED);
-				/* Raced ahead of a remove and another add? */
-				if (unlikely(nr < 0))
-					nr = 0;
-			} else {
-				/* Raced ahead of a remove of ENTIRELY_MAPPED */
-				nr = 0;
-			}
-		}
-		folio_inc_large_mapcount(folio, vma);
+		mapcount = folio_inc_return_large_mapcount(folio, vma);
+		if (mapcount == 1)
+			nr = folio_large_nr_pages(folio);
 		break;
 	default:
 		BUILD_BUG();
@@ -1676,15 +1639,11 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 		}
 
 		folio_set_large_mapcount(folio, nr, vma);
-		if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT))
-			atomic_set(&folio->_nr_pages_mapped, nr);
 	} else {
 		nr = folio_large_nr_pages(folio);
 		/* increment count (starts at -1) */
 		atomic_set(&folio->_entire_mapcount, 0);
 		folio_set_large_mapcount(folio, 1, vma);
-		if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT))
-			atomic_set(&folio->_nr_pages_mapped, ENTIRELY_MAPPED);
 		if (exclusive)
 			SetPageAnonExclusive(&folio->page);
 		nr_pmdmapped = nr;
@@ -1773,12 +1732,28 @@ void folio_add_file_rmap_pud(struct folio *folio, struct page *page,
 #endif
 }
 
+static bool __folio_certainly_partially_mapped(struct folio *folio, int mapcount)
+{
+	/*
+	 * This is a best-effort check only: if the average per-page
+	 * mapcount in the folio is smaller than 1, at least one page is not
+	 * mapped -> partially mapped. This is always reliable for exclusive
+	 * folios.
+	 *
+	 * We will not detect partial mappings in all scenarios:
+	 * when a folio becomes partially mapped while shared and the
+	 * average per-page mapcount is >= 1. However, we will detect the
+	 * partial mapping once it becomes exclusively mapped again.
+	 */
+	return mapcount && !folio_entire_mapcount(folio) &&
+	       mapcount < folio_large_nr_pages(folio);
+}
+
 static __always_inline void __folio_remove_rmap(struct folio *folio,
 		struct page *page, int nr_pages, struct vm_area_struct *vma,
 		enum pgtable_level level)
 {
-	atomic_t *mapped = &folio->_nr_pages_mapped;
-	int last = 0, nr = 0, nr_pmdmapped = 0;
+	int nr = 0, nr_pmdmapped = 0, mapcount;
 	bool partially_mapped = false;
 
 	__folio_rmap_sanity_checks(folio, page, nr_pages, level);
@@ -1790,67 +1765,29 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 			break;
 		}
 
-		if (IS_ENABLED(CONFIG_NO_PAGE_MAPCOUNT)) {
-			nr = folio_sub_return_large_mapcount(folio, nr_pages, vma);
-			if (!nr) {
-				/* Now completely unmapped. */
-				nr = folio_large_nr_pages(folio);
-			} else {
-				partially_mapped = nr < folio_large_nr_pages(folio) &&
-						   !folio_entire_mapcount(folio);
-				nr = 0;
-			}
-			break;
-		}
-
-		folio_sub_large_mapcount(folio, nr_pages, vma);
-		do {
-			last += atomic_add_negative(-1, &page->_mapcount);
-		} while (page++, --nr_pages > 0);
+		mapcount = folio_sub_return_large_mapcount(folio, nr_pages, vma);
+		if (!mapcount)
+			nr = folio_large_nr_pages(folio);
 
-		if (last &&
-		    atomic_sub_return_relaxed(last, mapped) < ENTIRELY_MAPPED)
-			nr = last;
+		if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT)) {
+			do {
+				atomic_dec(&page->_mapcount);
+			} while (page++, --nr_pages > 0);
+		}
 
-		partially_mapped = nr && atomic_read(mapped);
+		partially_mapped = __folio_certainly_partially_mapped(folio, mapcount);
 		break;
 	case PGTABLE_LEVEL_PMD:
 	case PGTABLE_LEVEL_PUD:
-		if (IS_ENABLED(CONFIG_NO_PAGE_MAPCOUNT)) {
-			last = atomic_add_negative(-1, &folio->_entire_mapcount);
-			if (level == PGTABLE_LEVEL_PMD && last)
-				nr_pmdmapped = folio_large_nr_pages(folio);
-			nr = folio_dec_return_large_mapcount(folio, vma);
-			if (!nr) {
-				/* Now completely unmapped. */
-				nr = folio_large_nr_pages(folio);
-			} else {
-				partially_mapped = last &&
-						   nr < folio_large_nr_pages(folio);
-				nr = 0;
-			}
-			break;
-		}
+		mapcount = folio_dec_return_large_mapcount(folio, vma);
+		if (!mapcount)
+			nr = folio_large_nr_pages(folio);
 
-		folio_dec_large_mapcount(folio, vma);
-		last = atomic_add_negative(-1, &folio->_entire_mapcount);
-		if (last) {
-			nr = atomic_sub_return_relaxed(ENTIRELY_MAPPED, mapped);
-			if (likely(nr < ENTIRELY_MAPPED)) {
-				nr_pages = folio_large_nr_pages(folio);
-				if (level == PGTABLE_LEVEL_PMD)
-					nr_pmdmapped = nr_pages;
-				nr = nr_pages - nr;
-				/* Raced ahead of another remove and an add? */
-				if (unlikely(nr < 0))
-					nr = 0;
-			} else {
-				/* An add of ENTIRELY_MAPPED raced ahead */
-				nr = 0;
-			}
-		}
+		if (atomic_add_negative(-1, &folio->_entire_mapcount) &&
+		    level == PGTABLE_LEVEL_PMD)
+			nr_pmdmapped = HPAGE_PMD_NR;
 
-		partially_mapped = nr && nr < nr_pmdmapped;
+		partially_mapped = __folio_certainly_partially_mapped(folio, mapcount);
 		break;
 	default:
 		BUILD_BUG();

-- 
2.43.0



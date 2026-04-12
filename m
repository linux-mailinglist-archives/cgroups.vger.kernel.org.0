Return-Path: <cgroups+bounces-15236-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kO0vJZHs22mLIwkAu9opvQ
	(envelope-from <cgroups+bounces-15236-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 21:03:45 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F98A3E59F2
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 21:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 824A3304A6F4
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 19:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898C237B007;
	Sun, 12 Apr 2026 19:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTsB/BI+"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F6B1B6CE9;
	Sun, 12 Apr 2026 19:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776020437; cv=none; b=nZGwlBcvcplXItFRq+540z0qHQwA4Go0BGlgXX8etvupte50jYThl1B8jiP4P6/WO8+7YBtLwPmmOA0q4o2xdXFO13tUyK7Y/z3+9prh4AHv+jIwRIgK5ZEfmWXPMolozMK4Tdg5e9xOf5TM4rYat9OtqN7lUmbl1+T3mo1kPVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776020437; c=relaxed/simple;
	bh=yNYLmrGnpm3rDeYHInOzSns7YDbk74L5kqWxpI7DVEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ESC+KtIFTc4SdDOF/m9I9c4IHnBeHmoPKNW/fgEFeQlM9zSE7XRJe5IrRgScn65s0JAZIGKzeCIIHTBwqhRLMXsS4W9jJoRNh3Tizm0DeTzDx06QnODqTEZlIHADj80KKDENMMGkTkrcGYMxSNjzHzCM2jkVhV1q1Nko3QJ/xAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTsB/BI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED343C19425;
	Sun, 12 Apr 2026 19:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776020436;
	bh=yNYLmrGnpm3rDeYHInOzSns7YDbk74L5kqWxpI7DVEE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iTsB/BI+9t8dv8YRegNzIFDj6lZbfvFhThQl3GygHLwVFFcVrbNnKBLtHHTlU0Yop
	 0Rq3KiQ6pes3bAlsSXwy0EZ2vDPhF6Ao4JXwRDLtfkMgjzhRquU0XeVGJd3T2/p6uY
	 0mnNmS8GKRKu/juwS42BHymY2DflXq4l4XqkLUwVrPV0CoImfO+/qOFjsjODXrM3Kt
	 cXUVOiK5oIvq+lJRCyKYgUXC9eOOUMEtfFfdGEHikDD6aV9V/3Bk0QoBuwSMBaiBj1
	 eNESRFfFhUvmQSrl9fuuwnDdmGmRKkZ+xKefgyLG0OyI/5koKXQoXD3QmkOwJmsZor
	 uK8YHFqXWjsjQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sun, 12 Apr 2026 20:59:37 +0200
Subject: [PATCH RFC 06/13] fs/proc/task_mmu: remove CONFIG_PAGE_MAPCOUNT
 handling in smaps_account()
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-mapcount-v1-6-05e8dfab52e0@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15236-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: 0F98A3E59F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In preparation for removing CONFIG_PAGE_MAPCOUNT, let's always use
folio_maybe_mapped_shared() to detect possible page sharing for
calculating the USS, and use folio_average_page_mapcount() to calculate
the PSS, like we do with CONFIG_NO_PAGE_MAPCOUNT.

We can now stop looping over all pages. We could now also get rid
of the "folio_ref_count(folio) == 1" handling that tried to avoid the loop
in the past. But it still looks like a nice and simply
micro-optimization given that many (small) folios only have a single
mapping.

Rename "exclusive" to "private" such that it directly matches the
parameter name in smaps_page_accumulate(), and cleanup the code to
only have a single smaps_page_accumulate() call.

Update the doc to state that this behavior no longer depends on the
kernel config, and simplify the doc a bit to mention less details that
are hard to follow.

We can now remove folio_precise_page_mapcount().

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 Documentation/filesystems/proc.rst | 33 +++++++++++-------------------
 fs/proc/internal.h                 | 39 ------------------------------------
 fs/proc/task_mmu.c                 | 41 ++++++++++----------------------------
 3 files changed, 22 insertions(+), 91 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 1224dc73e089..d2264240e43f 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -490,27 +490,18 @@ in memory, where each page is divided by the number of processes sharing it.
 So if a process has 1000 pages all to itself, and 1000 shared with one other
 process, its PSS will be 1500.  "Pss_Dirty" is the portion of PSS which
 consists of dirty pages.  ("Pss_Clean" is not included, but it can be
-calculated by subtracting "Pss_Dirty" from "Pss".)
-
-Traditionally, a page is accounted as "private" if it is mapped exactly once,
-and a page is accounted as "shared" when mapped multiple times, even when
-mapped in the same process multiple times. Note that this accounting is
-independent of MAP_SHARED.
-
-In some kernel configurations, the semantics of pages part of a larger
-allocation (e.g., THP) can differ: a page is accounted as "private" if all
-pages part of the corresponding large allocation are *certainly* mapped in the
-same process, even if the page is mapped multiple times in that process. A
-page is accounted as "shared" if any page page of the larger allocation
-is *maybe* mapped in a different process. In some cases, a large allocation
-might be treated as "maybe mapped by multiple processes" even though this
-is no longer the case.
-
-Some kernel configurations do not track the precise number of times a page part
-of a larger allocation is mapped. In this case, when calculating the PSS, the
-average number of mappings per page in this larger allocation might be used
-as an approximation for the number of mappings of a page. The PSS calculation
-will be imprecise in this case.
+calculated by subtracting "Pss_Dirty" from "Pss".)  In some scenarios where
+larger allocations (e.g., THP) are used, the PSS can be sightly imprecise,
+as precise information about how many processes share a page is not available
+for individual pages in such allocations.
+
+A page is accounted as "private" if it is currently *certainly* exclusively
+mapped in this process, and as "shared" if the page *might be* mapped into
+multiple processes.  Note that this accounting is independent of MAP_SHARED.
+In the past, pages that were mapped exactly once were accounted as "private",
+and pages with multiple mappings, even if in the same process, as "shared".
+As this precise information is not available for pages that are part of large
+allocations (e.g., THP), the semantics have been slightly adjusted.
 
 "Referenced" indicates the amount of memory currently marked as referenced or
 accessed.
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index c1e8eb984da8..a5908167ce2d 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -161,45 +161,6 @@ unsigned name_to_int(const struct qstr *qstr);
 /* Worst case buffer size needed for holding an integer. */
 #define PROC_NUMBUF 13
 
-#ifdef CONFIG_PAGE_MAPCOUNT
-/**
- * folio_precise_page_mapcount() - Number of mappings of this folio page.
- * @folio: The folio.
- * @page: The page.
- *
- * The number of present user page table entries that reference this page
- * as tracked via the RMAP: either referenced directly (PTE) or as part of
- * a larger area that covers this page (e.g., PMD).
- *
- * Use this function only for the calculation of existing statistics
- * (USS, PSS, mapcount_max) and for debugging purposes (/proc/kpagecount).
- *
- * Do not add new users.
- *
- * Returns: The number of mappings of this folio page. 0 for
- * folios that are not mapped to user space or are not tracked via the RMAP
- * (e.g., shared zeropage).
- */
-static inline int folio_precise_page_mapcount(struct folio *folio,
-		struct page *page)
-{
-	int mapcount = atomic_read(&page->_mapcount) + 1;
-
-	if (page_mapcount_is_type(mapcount))
-		mapcount = 0;
-	if (folio_test_large(folio))
-		mapcount += folio_entire_mapcount(folio);
-
-	return mapcount;
-}
-#else /* !CONFIG_PAGE_MAPCOUNT */
-static inline int folio_precise_page_mapcount(struct folio *folio,
-		struct page *page)
-{
-	BUILD_BUG();
-}
-#endif /* CONFIG_PAGE_MAPCOUNT */
-
 /**
  * folio_average_page_mapcount() - Average number of mappings per page in this
  *				   folio
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 55b037768c60..7b212fb6ae6c 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -918,10 +918,9 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
 		bool present)
 {
 	struct folio *folio = page_folio(page);
-	int i, nr = compound ? compound_nr(page) : 1;
-	unsigned long size = nr * PAGE_SIZE;
-	bool exclusive;
-	int mapcount;
+	const unsigned long size = compound ? folio_size(folio) : PAGE_SIZE;
+	unsigned long pss = size << PSS_SHIFT;
+	bool private = false;
 
 	/*
 	 * First accumulate quantities that depend only on |size| and the type
@@ -943,13 +942,6 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
 		mss->referenced += size;
 
 	/*
-	 * Then accumulate quantities that may depend on sharing, or that may
-	 * differ page-by-page.
-	 *
-	 * refcount == 1 for present entries guarantees that the folio is mapped
-	 * exactly once. For large folios this implies that exactly one
-	 * PTE/PMD/... maps (a part of) this folio.
-	 *
 	 * Treat all non-present entries (where relying on the mapcount and
 	 * refcount doesn't make sense) as "maybe shared, but not sure how
 	 * often". We treat device private entries as being fake-present.
@@ -957,30 +949,17 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
 	 * Note that it would not be safe to read the mapcount especially for
 	 * pages referenced by migration entries, even with the PTL held.
 	 */
-	if (folio_ref_count(folio) == 1 || !present) {
-		smaps_page_accumulate(mss, folio, size, size << PSS_SHIFT,
-				      dirty, locked, present);
-		return;
-	}
-
-	if (IS_ENABLED(CONFIG_NO_PAGE_MAPCOUNT)) {
-		mapcount = folio_average_page_mapcount(folio);
-		exclusive = !folio_maybe_mapped_shared(folio);
-	}
-
-	for (i = 0; i < nr; i++, page++) {
-		unsigned long pss = PAGE_SIZE << PSS_SHIFT;
-
-		if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT)) {
-			mapcount = folio_precise_page_mapcount(folio, page);
-			exclusive = mapcount < 2;
-		}
+	if (present && folio_ref_count(folio) == 1) {
+		/* Single mapping, no need to mess with mapcounts. */
+		private = true;
+	} else if (present) {
+		const int mapcount = folio_average_page_mapcount(folio);
 
 		if (mapcount >= 2)
 			pss /= mapcount;
-		smaps_page_accumulate(mss, folio, PAGE_SIZE, pss,
-				dirty, locked, exclusive);
+		private = !folio_maybe_mapped_shared(folio);
 	}
+	smaps_page_accumulate(mss, folio, size, pss, dirty, locked, private);
 }
 
 #ifdef CONFIG_SHMEM

-- 
2.43.0



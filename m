Return-Path: <cgroups+bounces-15243-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDLjJ4js22mLIwkAu9opvQ
	(envelope-from <cgroups+bounces-15243-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 21:03:36 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1436D3E59EA
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 21:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1AF933036E8B
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 19:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F04237BE6E;
	Sun, 12 Apr 2026 19:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2q5NZoz"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C60D363C77;
	Sun, 12 Apr 2026 19:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776020482; cv=none; b=PpRDWWld1d61VXDnNIzL6oofhk7XzUmRqm71r3OnXMse7+XQvpQxgEJWJpob2nqoUSL2qq/ASPsjFdzISfy5TDgtK2p3LzqEB/x8tb4KBYQ9dMnGMasMCY+KoflHNgG0L9BVGsCpXEyPOba3FKAzZ4brEQKWw1QobT0SYlEajFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776020482; c=relaxed/simple;
	bh=xnzEdijsKWDm0hyDDUg8A1Raky1RtIeHjzSIv3QsySQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bV5zTGJ7c+MHSj1AmYtnP2v6IhFU8QxKBw0Dd6+AO3+tk8Arz7S8nSt5PjcfHXICDZOo0O6Bh11flJUZCkipbrssShQlHjsKDp2ZAFXpF0OSunt8Zo+VHXEpW9jD7XQZ/I2IxHcS2stECfLUjOFoIN283R4WanvAHu74latKPzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2q5NZoz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2B6C19424;
	Sun, 12 Apr 2026 19:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776020482;
	bh=xnzEdijsKWDm0hyDDUg8A1Raky1RtIeHjzSIv3QsySQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=u2q5NZoz4m7pHL5Akq/ZJnOIQS8wJwXO8euqHypsoh3vPYHBFu+v44hZLT9XuszyZ
	 W4OTPABtTPcuaOIpeSYECOGkecttT3pHA13QQmKNG7yZVsnQ/EvATx9dvnzrxdK5Fi
	 Z9dkpUdw3XRySTtZ3rhpk6zTKT+q6MHPIXp1CiUA5hYNoP8TFOL+5cOj5pZg3Q8viU
	 WilUjrG3ldkPQyDWzp6StKvJMgz+nPWeYqhRxWFz+pTn9enMaJFqkvktzqb902xnVv
	 GRd+ABvw3VRG2afhLJsdzqZOargjUCqLTCYDiY0GNjQ1L01C02xD7voX879tdoXICy
	 gkXr8F6CypoPg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sun, 12 Apr 2026 20:59:44 +0200
Subject: [PATCH RFC 13/13] mm/rmap: support arbitrary folio mappings
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-mapcount-v1-13-05e8dfab52e0@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15243-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1436D3E59EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Let's replace the entire mapcount by the sum of mapped pages ("total mapped
pages"), which we update alongside the mapcount under the large mapcount
lock.

This allows for teaching all rmap code to just support arbitrary folio
mappings: PUD-sized folio being mapped by PMDs and PTEs, or
mapping folios that span multiple PMDs/PUDs. Note that calling code still
has to be updated to support that.

For example, a PMD-sized large folio with 512 pages that is mapped
through 2 PMDs and a single PTE has mapcount == 3 and 1025 total mapped
pages.

Calculating folio_average_page_mapcount() is now trivial. Provide a
new helper folio_total_mapped_pages() for that purpose. Similarly,
detecting certainly partially mapped folios in
__folio_certainly_partially_mapped() when unmapping is now trivial.

Pass another parameter ("nr_pages") to the large mapcount helpers that
update the new folio->_total_mapped_pages counter atomically with the
mapcount, and return the new value alongside the new mapcount.

We can keep maintaining the PMD statistics for PMD-sized THPs
(e.g., AnonHugePages) based on the new mapcount and the new total mapped
pages quite neatly, without the need for an additional pmd mapcount.

This all cleans up the code nicely. Introduce pgtable_level_to_order() to
easily convert from a pgtable_level to the mapping order so we can

Is an unsigned long for "total mapped pages" sufficient on 32bit? Maybe
not, but it is a similar problem to an "int" being insufficient to store
the mapcount on 64bit (and likely on 32bit) when triggering many PTE
mappings. Likely, for the time being, we might just want to prevent
overflowing both of these counters by teaching rmap code to fail early, or
letting calling code do some opportunistic checks: we don't expect current
reasonable use cases to overflow these counters.

Note that the !CONFIG_MM_ID implementation only exists for cases where
rmap code is called with a large folio even though THPs are not
supported by the kernel config: PMD/PUD mappings are impossible in such
configurations, and proper large folios are not possible. In the future,
we will remove this code entirely, as these pages are not actual folios,
and we can just enable CONFIG_MM_ID in

No functional change intended.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 Documentation/mm/transhuge.rst |   5 +-
 fs/proc/internal.h             |  22 ++---
 include/linux/mm.h             |  33 +++++---
 include/linux/mm_types.h       |   6 +-
 include/linux/pgtable.h        |  22 +++++
 include/linux/rmap.h           | 184 +++++++++++++++++++----------------------
 mm/debug.c                     |   4 +-
 mm/internal.h                  |   2 +-
 mm/memory.c                    |   3 +-
 mm/page_alloc.c                |   4 +-
 mm/rmap.c                      | 165 ++++++++++++++++--------------------
 11 files changed, 214 insertions(+), 236 deletions(-)

diff --git a/Documentation/mm/transhuge.rst b/Documentation/mm/transhuge.rst
index eb5ac076e4c6..76d3413a5b6b 100644
--- a/Documentation/mm/transhuge.rst
+++ b/Documentation/mm/transhuge.rst
@@ -116,14 +116,15 @@ pages:
     succeeds on tail pages.
 
   - map/unmap of a PMD entry for the whole THP increment/decrement
-    folio->_entire_mapcount and folio->_large_mapcount.
+    folio->_large_mapcount and add/remove HPAGE_PMD_NR to
+    folio->_total_mapped_pages.
 
     We also maintain the two slots for tracking MM owners (MM ID and
     corresponding mapcount), and the current status ("maybe mapped shared" vs.
     "mapped exclusively").
 
   - map/unmap of individual pages with PTE entry increment/decrement
-    folio->_large_mapcount.
+    folio->_total_mapped_pages and folio->_large_mapcount.
 
     We also maintain the two slots for tracking MM owners (MM ID and
     corresponding mapcount), and the current status ("maybe mapped shared" vs.
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 1dd46e55c850..fae901769529 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -178,26 +178,16 @@ unsigned name_to_int(const struct qstr *qstr);
  */
 static inline int folio_average_page_mapcount(struct folio *folio)
 {
-	int mapcount, entire_mapcount, avg;
+	unsigned long total_mapped_pages = folio_total_mapped_pages(folio);
+	const unsigned int order = folio_order(folio);
 
-	if (!folio_test_large(folio))
-		return atomic_read(&folio->_mapcount) + 1;
-
-	mapcount = folio_large_mapcount(folio);
-	if (unlikely(mapcount <= 0))
-		return 0;
-	if (folio_test_hugetlb(folio))
-		return mapcount;
-
-	entire_mapcount = folio_entire_mapcount(folio);
-	if (mapcount <= entire_mapcount)
-		return entire_mapcount;
-	mapcount -= entire_mapcount;
+	if (!total_mapped_pages || !order)
+		return total_mapped_pages;
 
 	/* Round to closest integer ... */
-	avg = ((unsigned int)mapcount + folio_large_nr_pages(folio) / 2) >> folio_large_order(folio);
+	total_mapped_pages += 1ul << (order - 1);
 	/* ... but return at least 1. */
-	return max_t(int, avg + entire_mapcount, 1);
+	return max(total_mapped_pages >> order, 1);
 }
 /*
  * array.c
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3092db64a009..b1c55e0cd317 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1825,19 +1825,6 @@ static inline int is_vmalloc_or_module_addr(const void *x)
 }
 #endif
 
-/*
- * How many times the entire folio is mapped as a single unit (eg by a
- * PMD or PUD entry).  This is probably not what you want, except for
- * debugging purposes or implementation of other core folio_*() primitives.
- *
- * Always 0 for hugetlb folios.
- */
-static inline int folio_entire_mapcount(const struct folio *folio)
-{
-	VM_WARN_ON_FOLIO(!folio_test_large(folio), folio);
-	return atomic_read(&folio->_entire_mapcount) + 1;
-}
-
 static inline int folio_large_mapcount(const struct folio *folio)
 {
 	VM_WARN_ON_FOLIO(!folio_test_large(folio), folio);
@@ -1888,6 +1875,26 @@ static inline bool folio_mapped(const struct folio *folio)
 	return folio_mapcount(folio) >= 1;
 }
 
+/**
+ * folio_total_mapped_pages - total mapped pages across all mappings
+ * @folio: The folio.
+ *
+ * Return the total number of pages mapped by all mappings of this folio.
+ * A page mapped multiple times is counted multiple times.
+ *
+ * For example, a single folio mapped through two PMD-sized mappings will
+ * contribute 1024 pages to the total on systems where a PMD maps 512 pages.
+ *
+ * Return: Total number of mapped pages across all mappings of @folio.
+ */
+static inline unsigned long folio_total_mapped_pages(const struct folio *folio)
+{
+	if (!folio_test_large(folio) || folio_test_hugetlb(folio) ||
+	    !IS_ENABLED(CONFIG_MM_ID))
+		return folio_mapcount(folio);
+	return atomic_long_read(&folio->_total_mapped_pages);
+}
+
 /*
  * Return true if this page is mapped into pagetables.
  * For compound page it returns true if any sub-page of compound page is mapped,
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 450f61cad678..93e05c4fd7b3 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -374,10 +374,9 @@ typedef unsigned short mm_id_t;
  * @pgmap: Metadata for ZONE_DEVICE mappings
  * @virtual: Virtual address in the kernel direct map.
  * @_last_cpupid: IDs of last CPU and last process that accessed the folio.
- * @_entire_mapcount: Do not use directly, call folio_entire_mapcount().
+ * @_total_mapped_pages: Do not use directly, call folio_total_mapped_pages().
  * @_large_mapcount: Do not use directly, call folio_mapcount().
  * @_unused_1: Temporary placeholder.
- * @_unused_2: Temporary placeholder.
  * @_pincount: Do not use directly, call folio_maybe_dma_pinned().
  * @_nr_pages: Do not use directly, call folio_nr_pages().
  * @_mm_id: Do not use outside of rmap code.
@@ -452,11 +451,10 @@ struct folio {
 				struct {
 	/* public: */
 					atomic_t _pincount;
-					atomic_t _entire_mapcount;
 #ifdef CONFIG_64BIT
 					unsigned int _unused_1;
-					unsigned int _unused_2;
 #endif /* CONFIG_64BIT */
+					atomic_long_t _total_mapped_pages;
 					mm_id_mapcount_t _mm_id_mapcount[2];
 					union {
 						mm_id_t _mm_id[2];
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index cdd68ed3ae1a..2351205d9076 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -7,6 +7,8 @@
 
 #define PMD_ORDER	(PMD_SHIFT - PAGE_SHIFT)
 #define PUD_ORDER	(PUD_SHIFT - PAGE_SHIFT)
+#define P4D_ORDER	(P4D_SHIFT - PAGE_SHIFT)
+#define PGDIR_ORDER	(PGDIR_SHIFT - PAGE_SHIFT)
 
 #ifndef __ASSEMBLY__
 #ifdef CONFIG_MMU
@@ -2243,6 +2245,26 @@ static inline const char *pgtable_level_to_str(enum pgtable_level level)
 	}
 }
 
+#ifdef CONFIG_MMU
+static __always_inline unsigned int pgtable_level_to_order(enum pgtable_level level)
+{
+	switch (level) {
+	case PGTABLE_LEVEL_PTE:
+		return 0;
+	case PGTABLE_LEVEL_PMD:
+		return PMD_ORDER;
+	case PGTABLE_LEVEL_PUD:
+		return PUD_ORDER;
+	case PGTABLE_LEVEL_P4D:
+		return P4D_ORDER;
+	case PGTABLE_LEVEL_PGD:
+		return PGDIR_ORDER;
+	default:
+		BUILD_BUG();
+	}
+}
+#endif /* CONFIG_MMU */
+
 #endif /* !__ASSEMBLY__ */
 
 #if !defined(MAX_POSSIBLE_PHYSMEM_BITS) && !defined(CONFIG_64BIT)
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 5a02ffd3744a..a71cdd706c7e 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -133,10 +133,10 @@ static inline void folio_set_mm_id(struct folio *folio, int idx, mm_id_t id)
 }
 
 static inline void __folio_large_mapcount_sanity_checks(const struct folio *folio,
-		unsigned int nr_mappings, mm_id_t mm_id)
+		unsigned int nr_mappings, unsigned int nr_pages, mm_id_t mm_id)
 {
 	VM_WARN_ON_ONCE(!folio_test_large(folio) || folio_test_hugetlb(folio));
-	VM_WARN_ON_ONCE(nr_mappings == 0);
+	VM_WARN_ON_ONCE(nr_mappings == 0 || nr_pages == 0 || nr_mappings > nr_pages);
 	VM_WARN_ON_ONCE(mm_id < MM_ID_MIN || mm_id > MM_ID_MAX);
 
 	/*
@@ -145,7 +145,7 @@ static inline void __folio_large_mapcount_sanity_checks(const struct folio *foli
 	 * a check on 32bit, where we currently reduce the size of the per-MM
 	 * mapcount to a short.
 	 */
-	VM_WARN_ON_ONCE(nr_mappings > folio_large_nr_pages(folio));
+	VM_WARN_ON_ONCE(nr_pages > folio_large_nr_pages(folio));
 	VM_WARN_ON_ONCE(folio_large_nr_pages(folio) - 1 > MM_ID_MAPCOUNT_MAX);
 
 	VM_WARN_ON_ONCE(folio_mm_id(folio, 0) == MM_ID_DUMMY &&
@@ -161,31 +161,38 @@ static inline void __folio_large_mapcount_sanity_checks(const struct folio *foli
 }
 
 static __always_inline void folio_set_large_mapcount(struct folio *folio,
-		unsigned int nr_mappings, struct vm_area_struct *vma)
+		unsigned int nr_mappings, int nr_pages, struct vm_area_struct *vma)
 {
-	__folio_large_mapcount_sanity_checks(folio, nr_mappings, vma->vm_mm->mm_id);
+	__folio_large_mapcount_sanity_checks(folio, nr_mappings, nr_pages,
+					     vma->vm_mm->mm_id);
 
 	VM_WARN_ON_ONCE(folio_mm_id(folio, 0) != MM_ID_DUMMY);
 	VM_WARN_ON_ONCE(folio_mm_id(folio, 1) != MM_ID_DUMMY);
 
 	/* Note: mapcounts start at -1. */
 	atomic_set(&folio->_large_mapcount, nr_mappings - 1);
+	atomic_long_set(&folio->_total_mapped_pages, nr_pages);
 	folio->_mm_id_mapcount[0] = nr_mappings - 1;
 	folio_set_mm_id(folio, 0, vma->vm_mm->mm_id);
 }
 
 static __always_inline int folio_add_return_large_mapcount(struct folio *folio,
-		unsigned int nr_mappings, struct vm_area_struct *vma)
+		unsigned int nr_mappings, unsigned int nr_pages,
+		struct vm_area_struct *vma, unsigned long *nr_mapped_pages)
 {
 	const mm_id_t mm_id = vma->vm_mm->mm_id;
+	unsigned long new_mapped_pages;
 	int new_mapcount_val;
 
 	folio_lock_large_mapcount(folio);
-	__folio_large_mapcount_sanity_checks(folio, nr_mappings, mm_id);
+	__folio_large_mapcount_sanity_checks(folio, nr_mappings, nr_pages, mm_id);
 
 	new_mapcount_val = atomic_read(&folio->_large_mapcount) + nr_mappings;
 	atomic_set(&folio->_large_mapcount, new_mapcount_val);
 
+	new_mapped_pages = atomic_long_read(&folio->_total_mapped_pages) + nr_pages;
+	atomic_long_set(&folio->_total_mapped_pages, new_mapped_pages);
+
 	/*
 	 * If a folio is mapped more than once into an MM on 32bit, we
 	 * can in theory overflow the per-MM mapcount (although only for
@@ -220,22 +227,38 @@ static __always_inline int folio_add_return_large_mapcount(struct folio *folio,
 		folio->_mm_ids |= FOLIO_MM_IDS_SHARED_BIT;
 	}
 	folio_unlock_large_mapcount(folio);
+
+	*nr_mapped_pages = new_mapped_pages;
 	return new_mapcount_val + 1;
 }
-#define folio_add_large_mapcount folio_add_return_large_mapcount
+
+static __always_inline void folio_add_large_mapcount(struct folio *folio,
+		unsigned int nr_mappings, unsigned int nr_pages,
+		struct vm_area_struct *vma)
+{
+	unsigned long nr_mapped_pages;
+
+	folio_add_return_large_mapcount(folio, nr_mappings, nr_pages, vma,
+					&nr_mapped_pages);
+}
 
 static __always_inline int folio_sub_return_large_mapcount(struct folio *folio,
-		unsigned int nr_mappings, struct vm_area_struct *vma)
+		unsigned int nr_mappings, unsigned int nr_pages,
+		struct vm_area_struct *vma, unsigned long *nr_mapped_pages)
 {
 	const mm_id_t mm_id = vma->vm_mm->mm_id;
+	unsigned long new_mapped_pages;
 	int new_mapcount_val;
 
 	folio_lock_large_mapcount(folio);
-	__folio_large_mapcount_sanity_checks(folio, nr_mappings, mm_id);
+	__folio_large_mapcount_sanity_checks(folio, nr_mappings, nr_pages, mm_id);
 
 	new_mapcount_val = atomic_read(&folio->_large_mapcount) - nr_mappings;
 	atomic_set(&folio->_large_mapcount, new_mapcount_val);
 
+	new_mapped_pages = atomic_long_read(&folio->_total_mapped_pages) - nr_pages;
+	atomic_long_set(&folio->_total_mapped_pages, new_mapped_pages);
+
 	/*
 	 * There are valid corner cases where we might underflow a per-MM
 	 * mapcount (some mappings added when no slot was free, some mappings
@@ -267,56 +290,59 @@ static __always_inline int folio_sub_return_large_mapcount(struct folio *folio,
 		folio->_mm_ids &= ~FOLIO_MM_IDS_SHARED_BIT;
 out:
 	folio_unlock_large_mapcount(folio);
+
+	*nr_mapped_pages = new_mapped_pages;
 	return new_mapcount_val + 1;
 }
-#define folio_sub_large_mapcount folio_sub_return_large_mapcount
 #else /* !CONFIG_MM_ID */
 /*
  * See __folio_rmap_sanity_checks(), we might map large folios even without
  * CONFIG_TRANSPARENT_HUGEPAGE. We'll keep that working for now.
  */
 static inline void folio_set_large_mapcount(struct folio *folio,
-		unsigned int nr_mappings,
+		unsigned int nr_mappings, unsigned int nr_pages,
 		struct vm_area_struct *vma)
 {
+	/* No support for large mappings. */
+	VM_WARN_ON_ONCE(nr_mappings != nr_pages);
 	/* Note: mapcounts start at -1. */
 	atomic_set(&folio->_large_mapcount, nr_mappings - 1);
 }
 
 static inline void folio_add_large_mapcount(struct folio *folio,
-		unsigned int nr_mappings, struct vm_area_struct *vma)
+		unsigned int nr_mappings, unsigned int nr_pages,
+		struct vm_area_struct *vma)
 {
+	/* No support for large mappings. */
+	VM_WARN_ON_ONCE(nr_mappings != nr_pages);
 	atomic_add(nr_mappings, &folio->_large_mapcount);
 }
 
 static inline int folio_add_return_large_mapcount(struct folio *folio,
-		unsigned int nr_mappings, struct vm_area_struct *vma)
+		unsigned int nr_mappings, unsigned int nr_pages,
+		struct vm_area_struct *vma, unsigned long *nr_mapped_pages)
 {
-	return atomic_add_return(nr_mappings, &folio->_large_mapcount) + 1;
-}
+	int new_mapcount = atomic_add_return(nr_mappings, &folio->_large_mapcount) + 1;
 
-static inline void folio_sub_large_mapcount(struct folio *folio,
-		unsigned int nr_mappings, struct vm_area_struct *vma)
-{
-	atomic_sub(nr_mappings, &folio->_large_mapcount);
+	/* No support for large mappings. */
+	VM_WARN_ON_ONCE(nr_mappings != nr_pages);
+	*nr_mapped_pages = new_mapcount;
+	return new_mapcount;
 }
 
 static inline int folio_sub_return_large_mapcount(struct folio *folio,
-		unsigned int nr_mappings, struct vm_area_struct *vma)
+		unsigned int nr_mappings, unsigned int nr_pages,
+		struct vm_area_struct *vma, unsigned long *nr_mapped_pages)
 {
-	return atomic_sub_return(nr_mappings, &folio->_large_mapcount) + 1;
+	int new_mapcount = atomic_sub_return(nr_mappings, &folio->_large_mapcount) + 1;
+
+	/* No support for large mappings. */
+	VM_WARN_ON_ONCE(nr_mappings != nr_pages);
+	*nr_mapped_pages = new_mapcount;
+	return new_mapcount;
 }
 #endif /* CONFIG_MM_ID */
 
-#define folio_inc_large_mapcount(folio, vma) \
-	folio_add_large_mapcount(folio, 1, vma)
-#define folio_inc_return_large_mapcount(folio, vma) \
-	folio_add_return_large_mapcount(folio, 1, vma)
-#define folio_dec_large_mapcount(folio, vma) \
-	folio_sub_large_mapcount(folio, 1, vma)
-#define folio_dec_return_large_mapcount(folio, vma) \
-	folio_sub_return_large_mapcount(folio, 1, vma)
-
 /* RMAP flags, currently only relevant for some anon rmap operations. */
 typedef int __bitwise rmap_t;
 
@@ -332,6 +358,8 @@ typedef int __bitwise rmap_t;
 static __always_inline void __folio_rmap_sanity_checks(const struct folio *folio,
 		const struct page *page, int nr_pages, enum pgtable_level level)
 {
+	const unsigned int mapping_order = pgtable_level_to_order(level);
+
 	/* hugetlb folios are handled separately. */
 	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
 
@@ -351,29 +379,8 @@ static __always_inline void __folio_rmap_sanity_checks(const struct folio *folio
 	VM_WARN_ON_FOLIO(page_folio(page) != folio, folio);
 	VM_WARN_ON_FOLIO(page_folio(page + nr_pages - 1) != folio, folio);
 
-	switch (level) {
-	case PGTABLE_LEVEL_PTE:
-		break;
-	case PGTABLE_LEVEL_PMD:
-		/*
-		 * We don't support folios larger than a single PMD yet. So
-		 * when PGTABLE_LEVEL_PMD is set, we assume that we are creating
-		 * a single "entire" mapping of the folio.
-		 */
-		VM_WARN_ON_FOLIO(folio_nr_pages(folio) != HPAGE_PMD_NR, folio);
-		VM_WARN_ON_FOLIO(nr_pages != HPAGE_PMD_NR, folio);
-		break;
-	case PGTABLE_LEVEL_PUD:
-		/*
-		 * Assume that we are creating a single "entire" mapping of the
-		 * folio.
-		 */
-		VM_WARN_ON_FOLIO(folio_nr_pages(folio) != HPAGE_PUD_NR, folio);
-		VM_WARN_ON_FOLIO(nr_pages != HPAGE_PUD_NR, folio);
-		break;
-	default:
-		BUILD_BUG();
-	}
+	VM_WARN_ON_FOLIO(!IS_ALIGNED(nr_pages, 1u << mapping_order), folio);
+	VM_WARN_ON_FOLIO(!IS_ALIGNED(folio_page_idx(folio, page), 1u << mapping_order), folio);
 
 	/*
 	 * Anon folios must have an associated live anon_vma as long as they're
@@ -491,25 +498,14 @@ static __always_inline void __folio_dup_file_rmap(struct folio *folio,
 		struct page *page, int nr_pages, struct vm_area_struct *dst_vma,
 		enum pgtable_level level)
 {
-	__folio_rmap_sanity_checks(folio, page, nr_pages, level);
+	const unsigned int nr_mappings = nr_pages >> pgtable_level_to_order(level);
 
-	switch (level) {
-	case PGTABLE_LEVEL_PTE:
-		if (!folio_test_large(folio)) {
-			atomic_inc(&folio->_mapcount);
-			break;
-		}
+	__folio_rmap_sanity_checks(folio, page, nr_pages, level);
 
-		folio_add_large_mapcount(folio, nr_pages, dst_vma);
-		break;
-	case PGTABLE_LEVEL_PMD:
-	case PGTABLE_LEVEL_PUD:
-		atomic_inc(&folio->_entire_mapcount);
-		folio_inc_large_mapcount(folio, dst_vma);
-		break;
-	default:
-		BUILD_BUG();
-	}
+	if (level == PGTABLE_LEVEL_PTE && !folio_test_large(folio))
+		atomic_inc(&folio->_mapcount);
+	else
+		folio_add_large_mapcount(folio, nr_mappings, nr_pages, dst_vma);
 }
 
 /**
@@ -559,7 +555,6 @@ static __always_inline int __folio_try_dup_anon_rmap(struct folio *folio,
 		struct page *page, int nr_pages, struct vm_area_struct *dst_vma,
 		struct vm_area_struct *src_vma, enum pgtable_level level)
 {
-	const int orig_nr_pages = nr_pages;
 	bool maybe_pinned;
 	int i;
 
@@ -581,39 +576,28 @@ static __always_inline int __folio_try_dup_anon_rmap(struct folio *folio,
 	 * folio. But if any page is PageAnonExclusive, we must fallback to
 	 * copying if the folio maybe pinned.
 	 */
-	switch (level) {
-	case PGTABLE_LEVEL_PTE:
-		if (unlikely(maybe_pinned)) {
-			for (i = 0; i < nr_pages; i++)
-				if (PageAnonExclusive(page + i))
-					return -EBUSY;
-		}
-
-		if (!folio_test_large(folio)) {
-			if (PageAnonExclusive(page))
-				ClearPageAnonExclusive(page);
-			atomic_inc(&folio->_mapcount);
-			break;
-		}
-
-		do {
-			if (PageAnonExclusive(page))
-				ClearPageAnonExclusive(page);
-		} while (page++, --nr_pages > 0);
-		folio_add_large_mapcount(folio, orig_nr_pages, dst_vma);
-		break;
-	case PGTABLE_LEVEL_PMD:
-	case PGTABLE_LEVEL_PUD:
+	if (level == PGTABLE_LEVEL_PTE && !folio_test_large(folio)) {
 		if (PageAnonExclusive(page)) {
 			if (unlikely(maybe_pinned))
 				return -EBUSY;
 			ClearPageAnonExclusive(page);
 		}
-		atomic_inc(&folio->_entire_mapcount);
-		folio_inc_large_mapcount(folio, dst_vma);
-		break;
-	default:
-		BUILD_BUG();
+		atomic_inc(&folio->_mapcount);
+	} else {
+		const unsigned int mapping_order = pgtable_level_to_order(level);
+		const unsigned int nr_mappings = nr_pages >> mapping_order;
+
+		if (unlikely(maybe_pinned)) {
+			for (i = 0; i < nr_pages; i += 1u << mapping_order)
+				if (PageAnonExclusive(page + i))
+					return -EBUSY;
+		} else {
+			for (i = 0; i < nr_pages; i += 1u << mapping_order) {
+				if (PageAnonExclusive(page + i))
+					ClearPageAnonExclusive(page + i);
+			}
+		}
+		folio_add_large_mapcount(folio, nr_mappings, nr_pages, dst_vma);
 	}
 	return 0;
 }
diff --git a/mm/debug.c b/mm/debug.c
index 82baaf87ef3d..15d3cb9c1cb0 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -83,10 +83,10 @@ static void __dump_folio(const struct folio *folio, const struct page *page,
 	if (folio_test_large(folio)) {
 		int pincount = atomic_read(&folio->_pincount);
 
-		pr_warn("head: order:%u mapcount:%d entire_mapcount:%d pincount:%d\n",
+		pr_warn("head: order:%u mapcount:%d total_mapped_pages:%lu pincount:%d\n",
 				folio_order(folio),
 				folio_mapcount(folio),
-				folio_entire_mapcount(folio);
+				folio_total_mapped_pages(folio),
 				pincount);
 	}
 
diff --git a/mm/internal.h b/mm/internal.h
index aa1206495bc6..d4d74f614e7f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -868,7 +868,7 @@ static inline void prep_compound_head(struct page *page, unsigned int order)
 		folio->_mm_id_mapcount[0] = -1;
 		folio->_mm_id_mapcount[1] = -1;
 	}
-	atomic_set(&folio->_entire_mapcount, -1);
+	atomic_long_set(&folio->_total_mapped_pages, 0);
 	atomic_set(&folio->_pincount, 0);
 	if (order > 1)
 		INIT_LIST_HEAD(&folio->_deferred_list);
diff --git a/mm/memory.c b/mm/memory.c
index ea6568571131..6a3e0eed29cc 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4139,8 +4139,7 @@ static bool __wp_can_reuse_large_anon_folio(struct folio *folio,
 	if (folio_large_mapcount(folio) != folio_ref_count(folio))
 		goto unlock;
 
-	VM_WARN_ON_ONCE_FOLIO(folio_large_mapcount(folio) > folio_nr_pages(folio), folio);
-	VM_WARN_ON_ONCE_FOLIO(folio_entire_mapcount(folio), folio);
+	VM_WARN_ON_ONCE_FOLIO(folio_total_mapped_pages(folio) > folio_nr_pages(folio), folio);
 	VM_WARN_ON_ONCE(folio_mm_id(folio, 0) != vma->vm_mm->mm_id &&
 			folio_mm_id(folio, 1) != vma->vm_mm->mm_id);
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8ed4c73fdba4..43000d869215 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1121,8 +1121,8 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 				goto out;
 			}
 		}
-		if (folio_entire_mapcount(folio)) {
-			bad_page(page, "nonzero entire_mapcount");
+		if (unlikely(atomic_long_read(&folio->_total_mapped_pages))) {
+			bad_page(page, "nonzero total_mapped_pages");
 			goto out;
 		}
 		if (unlikely(atomic_read(&folio->_pincount))) {
diff --git a/mm/rmap.c b/mm/rmap.c
index d08927949284..47b144f6d3c7 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1357,30 +1357,28 @@ static __always_inline void __folio_add_rmap(struct folio *folio,
 
 	__folio_rmap_sanity_checks(folio, page, nr_pages, level);
 
-	switch (level) {
-	case PGTABLE_LEVEL_PTE:
-		if (!folio_test_large(folio)) {
-			nr = atomic_inc_and_test(&folio->_mapcount);
-			break;
-		}
+	if (level == PGTABLE_LEVEL_PTE && !folio_test_large(folio)) {
+		nr = atomic_inc_and_test(&folio->_mapcount);
+	} else {
+		const unsigned int nr_mappings = nr_pages >> pgtable_level_to_order(level);
+		unsigned long nr_mapped_pages;
 
-		mapcount = folio_add_return_large_mapcount(folio, nr_pages, vma);
-		if (mapcount == nr_pages)
+		mapcount = folio_add_return_large_mapcount(folio, nr_mappings,
+							   nr_pages, vma,
+							   &nr_mapped_pages);
+		if (mapcount == nr_mappings)
 			nr = folio_large_nr_pages(folio);
-		break;
-	case PGTABLE_LEVEL_PMD:
-	case PGTABLE_LEVEL_PUD:
-		if (atomic_inc_and_test(&folio->_entire_mapcount) &&
-		    level == PGTABLE_LEVEL_PMD)
-			nr_pmdmapped = HPAGE_PMD_NR;
 
-		mapcount = folio_inc_return_large_mapcount(folio, vma);
-		if (mapcount == 1)
-			nr = folio_large_nr_pages(folio);
-		break;
-	default:
-		BUILD_BUG();
+		/*
+		 * For PMD-sized THPs, we'll adjust the counter once the
+		 * first PMD mapping is added.
+		 */
+		if (level == PGTABLE_LEVEL_PMD &&
+		    folio_large_nr_pages(folio) == HPAGE_PMD_NR &&
+		    nr_mapped_pages - mapcount == nr_pages - nr_mappings)
+			nr_pmdmapped = HPAGE_PMD_NR;
 	}
+
 	__folio_mod_stat(folio, nr, nr_pmdmapped);
 }
 
@@ -1483,35 +1481,14 @@ static __always_inline void __folio_add_anon_rmap(struct folio *folio,
 		__page_check_anon_rmap(folio, page, vma, address);
 
 	if (flags & RMAP_EXCLUSIVE) {
-		switch (level) {
-		case PGTABLE_LEVEL_PTE:
-			for (i = 0; i < nr_pages; i++)
-				SetPageAnonExclusive(page + i);
-			break;
-		case PGTABLE_LEVEL_PMD:
-			SetPageAnonExclusive(page);
-			break;
-		case PGTABLE_LEVEL_PUD:
-			/*
-			 * Keep the compiler happy, we don't support anonymous
-			 * PUD mappings.
-			 */
-			WARN_ON_ONCE(1);
-			break;
-		default:
-			BUILD_BUG();
-		}
+		const unsigned int mapping_order = pgtable_level_to_order(level);
+
+		for (i = 0; i < nr_pages; i += 1u << mapping_order)
+			SetPageAnonExclusive(page + i);
 	}
 
 	VM_WARN_ON_FOLIO(!folio_test_large(folio) && PageAnonExclusive(page) &&
 			 atomic_read(&folio->_mapcount) > 0, folio);
-	for (i = 0; i < nr_pages; i++) {
-		struct page *cur_page = page + i;
-
-		VM_WARN_ON_FOLIO(folio_test_large(folio) &&
-				 folio_entire_mapcount(folio) > 1 &&
-				 PageAnonExclusive(cur_page), folio);
-	}
 
 	/*
 	 * Only mlock it if the folio is fully mapped to the VMA.
@@ -1608,27 +1585,34 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 		atomic_set(&folio->_mapcount, 0);
 		if (exclusive)
 			SetPageAnonExclusive(&folio->page);
-	} else if (!folio_test_pmd_mappable(folio)) {
+	} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
+		const unsigned int order = folio_large_order(folio);
+		unsigned int nr_mappings, mapping_order;
 		int i;
 
+		if (order >= PUD_ORDER)
+			mapping_order = PUD_ORDER;
+		else if (order >= PMD_ORDER)
+			mapping_order = PMD_ORDER;
+		else
+			mapping_order = 0;
+
 		nr = folio_large_nr_pages(folio);
+		if (order == PMD_ORDER)
+			nr_pmdmapped = 1u << order;
+
 		if (exclusive) {
-			for (i = 0; i < nr; i++) {
+			for (i = 0; i < nr; i += 1u << mapping_order) {
 				struct page *page = folio_page(folio, i);
 
 				SetPageAnonExclusive(page);
 			}
 		}
 
-		folio_set_large_mapcount(folio, nr, vma);
+		nr_mappings = nr >> mapping_order;
+		folio_set_large_mapcount(folio, nr_mappings, nr, vma);
 	} else {
-		nr = folio_large_nr_pages(folio);
-		/* increment count (starts at -1) */
-		atomic_set(&folio->_entire_mapcount, 0);
-		folio_set_large_mapcount(folio, 1, vma);
-		if (exclusive)
-			SetPageAnonExclusive(&folio->page);
-		nr_pmdmapped = nr;
+		WARN_ON_ONCE(1);
 	}
 
 	VM_WARN_ON_ONCE(address < vma->vm_start ||
@@ -1714,8 +1698,10 @@ void folio_add_file_rmap_pud(struct folio *folio, struct page *page,
 #endif
 }
 
-static bool __folio_certainly_partially_mapped(struct folio *folio, int mapcount)
+static bool __folio_certainly_partially_mapped(struct folio *folio)
 {
+	unsigned long total_mapped_pages = atomic_long_read(&folio->_total_mapped_pages);
+
 	/*
 	 * This is a best-effort check only: if the average per-page
 	 * mapcount in the folio is smaller than 1, at least one page is not
@@ -1727,8 +1713,7 @@ static bool __folio_certainly_partially_mapped(struct folio *folio, int mapcount
 	 * average per-page mapcount is >= 1. However, we will detect the
 	 * partial mapping once it becomes exclusively mapped again.
 	 */
-	return mapcount && !folio_entire_mapcount(folio) &&
-	       mapcount < folio_large_nr_pages(folio);
+	return total_mapped_pages && total_mapped_pages < folio_large_nr_pages(folio);
 }
 
 static __always_inline void __folio_remove_rmap(struct folio *folio,
@@ -1736,53 +1721,45 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 		enum pgtable_level level)
 {
 	int nr = 0, nr_pmdmapped = 0, mapcount;
-	bool partially_mapped = false;
 
 	__folio_rmap_sanity_checks(folio, page, nr_pages, level);
 
-	switch (level) {
-	case PGTABLE_LEVEL_PTE:
-		if (!folio_test_large(folio)) {
-			nr = atomic_add_negative(-1, &folio->_mapcount);
-			break;
-		}
+	if (level == PGTABLE_LEVEL_PTE && !folio_test_large(folio)) {
+		nr = atomic_add_negative(-1, &folio->_mapcount);
+	} else {
+		const unsigned int nr_mappings = nr_pages >> pgtable_level_to_order(level);
+		unsigned long nr_mapped_pages;
 
-		mapcount = folio_sub_return_large_mapcount(folio, nr_pages, vma);
+		mapcount = folio_sub_return_large_mapcount(folio, nr_mappings,
+							   nr_pages, vma,
+							   &nr_mapped_pages);
 		if (!mapcount)
 			nr = folio_large_nr_pages(folio);
 
-		partially_mapped = __folio_certainly_partially_mapped(folio, mapcount);
-		break;
-	case PGTABLE_LEVEL_PMD:
-	case PGTABLE_LEVEL_PUD:
-		mapcount = folio_dec_return_large_mapcount(folio, vma);
-		if (!mapcount)
-			nr = folio_large_nr_pages(folio);
-
-		if (atomic_add_negative(-1, &folio->_entire_mapcount) &&
-		    level == PGTABLE_LEVEL_PMD)
+		/*
+		 * For PMD-sized THPs, we'll adjust the counter once the
+		 * last PMD mapping is removed.
+		 */
+		if (level == PGTABLE_LEVEL_PMD &&
+		    folio_large_nr_pages(folio) == HPAGE_PMD_NR &&
+		    nr_mapped_pages - mapcount == 0)
 			nr_pmdmapped = HPAGE_PMD_NR;
 
-		partially_mapped = __folio_certainly_partially_mapped(folio, mapcount);
-		break;
-	default:
-		BUILD_BUG();
+		/*
+		 * Queue anon large folio for deferred split if at least one
+		 * page of the folio is unmapped and at least one page is still
+		 * mapped.
+		 *
+		 * Device private folios do not support deferred splitting and
+		 * shrinker based scanning of the folios to free.
+		 */
+		if (folio_test_anon(folio) &&
+		    __folio_certainly_partially_mapped(folio) &&
+		    !folio_test_partially_mapped(folio) &&
+		    !folio_is_device_private(folio))
+			deferred_split_folio(folio, true);
 	}
 
-	/*
-	 * Queue anon large folio for deferred split if at least one page of
-	 * the folio is unmapped and at least one page is still mapped.
-	 *
-	 * Check partially_mapped first to ensure it is a large folio.
-	 *
-	 * Device private folios do not support deferred splitting and
-	 * shrinker based scanning of the folios to free.
-	 */
-	if (partially_mapped && folio_test_anon(folio) &&
-	    !folio_test_partially_mapped(folio) &&
-	    !folio_is_device_private(folio))
-		deferred_split_folio(folio, true);
-
 	__folio_mod_stat(folio, -nr, -nr_pmdmapped);
 
 	/*

-- 
2.43.0



Return-Path: <cgroups+bounces-6775-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A75A4A4C7BA
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 17:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17C1D1882E75
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 16:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C593F250C18;
	Mon,  3 Mar 2025 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q13mMVkm"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EA62505B6
	for <cgroups@vger.kernel.org>; Mon,  3 Mar 2025 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019456; cv=none; b=TDi9VdO2kG6kRvo7pLyKrDJ8Wq4LCk+0K7PUB6a/LhtoZTgVT+SuhKDpFcD1bOdQsSvLbW5A2KjCSDAJ2JkSNn8m6n/HmPQDIq2b5NElck11DFHqbTOlaz/+hCsTdszxfrhKpchd2qwWviQ6aXm8m4eXFQRCXklvIUpCJoOnldY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019456; c=relaxed/simple;
	bh=5Byq/1lPhYtwhuDbN8LggOFcuPhv/xZrM5odxMvY8QE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQaioeDtPrhwPOD6Uyy7+pimNp7+GGTje6ZINf1mQ6MgvGS1GjJB/QaTPuszuzAKJen8CB03RgKxckTq+7Fg1wKKZ0LJVqf+AaZUekhYbF9tP/UZCQAQMJMYAUSimuDXNglQvMazYr782Ka0NaFIBRmXX0eySfhG/k7joBq8xqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q13mMVkm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741019452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JxmqLp4raSjE/u9Ir1kxxBRe4WYvModjbml+BLkpapQ=;
	b=Q13mMVkm0RhDNlno5TD6SOalFniW3J+hjsz4mtUz47hHt4TTsjViVYR76KZhfoaZaj8A57
	50BkGvIDRf1QLEkxpvk5VQ2lI/GNb9TAFVAKzSvmYAFPODK/1EvZ6Ic0C3WjGmTMFqtiH0
	e5z1YdBuLgpJiWKsr0QueD/p+9TVN+I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-QeUf96xJPr-dbSBRv4yjqg-1; Mon, 03 Mar 2025 11:30:51 -0500
X-MC-Unique: QeUf96xJPr-dbSBRv4yjqg-1
X-Mimecast-MFC-AGG-ID: QeUf96xJPr-dbSBRv4yjqg_1741019450
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-438e180821aso24937475e9.1
        for <cgroups@vger.kernel.org>; Mon, 03 Mar 2025 08:30:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019450; x=1741624250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JxmqLp4raSjE/u9Ir1kxxBRe4WYvModjbml+BLkpapQ=;
        b=cH+QXRzEQJcUL/Ysxv8RO3tnG1Ve93TIddoeqPIZc9bsDoMFdDq0WcvUxZ3OvZ9lId
         yZUgB+Tli1870R4wl/tIH/jEu4/KJhETnTWktXmBUbqLwpRPggvGsxfwHwlNyfs0nfPE
         t/dKXrU9hpPHtIY1n3qj7FVlSb0oCAK2sc/QKK0vttfco2Ffk8Hvcm2Tea+JaiMDg8p+
         cetzdVQWcwCM8uzu5pWimcqGIBoyLglfU1B8riBex4+1Q4m9dlN8ssvxpVJhHaHUFpAi
         ZElTJ4hZDqwbVYp+VcpwJb4ViQ2P1f8OoTIxTZWgYFKwNPOz8Z9gCZtaCo6mo43WalTF
         6rig==
X-Forwarded-Encrypted: i=1; AJvYcCUJ6UBaaz3FMieg187qNfC4dUhDzH+XjEQV6vatgyUL2Qq0e8EJ85l/zwqOPp/1EPmANZ3jr0W2@vger.kernel.org
X-Gm-Message-State: AOJu0YzGkGepRxU8Ou6cFBB4R8fvzPyQFyR50dtti8VithwvHP0PowPD
	Ob54K0a5SAo5Lu9XrY5kn/VBglNsmXviVFW63qJOH4yEXdhvylebDWlTv7TYh3mHwCGwCK6qJiw
	wd9AnYrGSVpv2nnMxtVcZ/3oNr50T1TKsgHnEAzmUsNZ+r5ouv487U+s=
X-Gm-Gg: ASbGnctyVupuQ4LSoZtNvNTs9HLzHG09/7Mbo9pOBQhT9DlkVliIiKF+GzlKYOj80cs
	ysLyLVnk7noU6OscdOXcnsDVgsV9r0s15P9pDy6g+aN+48FVlBtm1stuuQs8SSgYFcdLrLRETsW
	1BFPsixa34sgcIgyhewBvwBqmalnxS5Bg4w93Xsa1qqCXbxI8nPyExBQbYeccdrCicsx53P5pl+
	rTQvUBg2HSOJrk0wgj1S29t0WLYHNrb90+afb4dZl/yUTKqQ9YRkTfUqykffPPjUuWDqgyBGcAw
	cejhvoDSi5Mau8Orz7GLDmHncRbfXBwz5lGOcOG/QJ+iHI1UghX50I6C0ETkQTJVjt6uzKJypaE
	j
X-Received: by 2002:a05:600c:3584:b0:43b:c541:51d3 with SMTP id 5b1f17b1804b1-43bc541542fmr24517685e9.6.1741019449767;
        Mon, 03 Mar 2025 08:30:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVn/HGhyotsr/snfJTLhgk+vvrfF/OlvUq6vlbvbEOG4XZJVEXeDZKaxpl01mM+yROzC4hsQ==
X-Received: by 2002:a05:600c:3584:b0:43b:c541:51d3 with SMTP id 5b1f17b1804b1-43bc541542fmr24517095e9.6.1741019449189;
        Mon, 03 Mar 2025 08:30:49 -0800 (PST)
Received: from localhost (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bc2828afesm38792575e9.9.2025.03.03.08.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:30:48 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>
Subject: [PATCH v3 14/20] mm: convert folio_likely_mapped_shared() to folio_maybe_mapped_shared()
Date: Mon,  3 Mar 2025 17:30:07 +0100
Message-ID: <20250303163014.1128035-15-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303163014.1128035-1-david@redhat.com>
References: <20250303163014.1128035-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's reuse our new MM ownership tracking infrastructure for large folios
to make folio_likely_mapped_shared() never return false negatives --
never indicating "not mapped shared" although the folio *is* mapped shared.
With that, we can rename it to folio_maybe_mapped_shared() and get rid of
the dependency on the mapcount of the first folio page.

The semantics are now arguably clearer: no mixture of "false negatives" and
"false positives", only the remaining possibility for "false positives".

Thoroughly document the new semantics. We might now detect that a large
folio is "maybe mapped shared" although it *no longer* is -- but once was.
Now, if more than two MMs mapped a folio at the same time, and the MM
mapping the folio exclusively at the end is not one tracked in the two
folio MM slots, we will detect the folio as "maybe mapped shared".

For anonymous folios, usually (except weird corner cases) all PTEs
that target a "maybe mapped shared" folio are R/O. As soon as a child
process would write to them (iow, actively use them), we would CoW and
effectively replace these PTEs. Most cases (below) are not expected to
really matter with large anonymous folios for this reason.

Most importantly, there will be no change at all for:
* small folios
* hugetlb folios
* PMD-mapped PMD-sized THPs (single mapping)

This change has the potential to affect existing callers of
folio_likely_mapped_shared() -> folio_maybe_mapped_shared():

(1) fs/proc/task_mmu.c: no change (hugetlb)

(2) khugepaged counts PTEs that target shared folios towards
    max_ptes_shared (default: HPAGE_PMD_NR / 2), meaning we could skip a
    collapse where we would have previously collapsed. This only applies to
    anonymous folios and is not expected to matter in practice.

    Worth noting that this change sorts out case (A) documented in
    commit 1bafe96e89f0 ("mm/khugepaged: replace page_mapcount() check by
    folio_likely_mapped_shared()") by removing the possibility
    for "false negatives".

(3) MADV_COLD / MADV_PAGEOUT / MADV_FREE will not try splitting PTE-mapped
    THPs that are considered shared but not fully covered by the
    requested range, consequently not processing them.

    PMD-mapped PMD-sized THP are not affected, or when all PTEs are
    covered. These functions are usually only called on anon/file folios
    that are exclusively mapped most of the time (no other file mappings
    or no fork()), so the "false negatives" are not expected to matter in
    practice.

(4) mbind() / migrate_pages() / move_pages() will refuse to migrate shared
    folios unless MPOL_MF_MOVE_ALL is effective (requires CAP_SYS_NICE).
    We will now reject some folios that could be migrated.

    Similar to (3), especially with MPOL_MF_MOVE_ALL, so this is not
    expected to matter in practice.

    Note that cpuset_migrate_mm_workfn() calls do_migrate_pages() with
    MPOL_MF_MOVE_ALL.

(5) NUMA hinting

    mm/migrate.c:migrate_misplaced_folio_prepare() will skip file folios
    that are probably shared libraries (-> "mapped shared" and
    executable). This check would have detected it as a shared library
    at some point (at least 3 MMs mapping it), so detecting it
    afterwards does not sound wrong (still a shared library). Not
    expected to matter.

    mm/memory.c:numa_migrate_check() will indicate TNF_SHARED in
    MAP_SHARED file mappings when encountering a shared folio. Similar
    reasoning, not expected to matter.

    mm/mprotect.c:change_pte_range() will skip folios detected as shared
    in CoW mappings. Similarly, this is not expected to matter in
    practice, but if it would ever be a problem we could relax that
    check a bit (e.g., basing it on the average page-mapcount in a folio),
    because it was only an optimization when many (e.g., 288) processes
    were mapping the same folios -- see commit 859d4adc3415 ("mm: numa: do
    not trap faults on shared data section pages.")

(6) mm/rmap.c:folio_referenced_one() will skip exclusive swapbacked folios
    in dying processes. Applies to anonymous folios only. Without "false
    negatives", we'll now skip all actually shared ones. Skipping ones
    that are actually exclusive won't really matter, it's a pure
    optimization, and is not expected to matter in practice.

In theory, one can detect the problematic scenario: folio_mapcount() > 0
and no folio MM slot is occupied ("state unknown"). One could reset the MM
slots while doing an rmap walk, which migration / folio split already do
when setting everything up. Further, when batching PTEs we might naturally
learn about a owner (e.g., folio_mapcount() == nr_ptes) and could update
the owner. However, we'll defer that until the scenarios where it would
really matter are clear.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/task_mmu.c |  4 ++--
 include/linux/mm.h | 43 ++++++++++++++++++++++---------------------
 mm/huge_memory.c   |  2 +-
 mm/khugepaged.c    |  8 +++-----
 mm/madvise.c       |  6 +++---
 mm/memory.c        |  2 +-
 mm/mempolicy.c     |  8 ++++----
 mm/migrate.c       |  7 +++----
 mm/mprotect.c      |  2 +-
 mm/rmap.c          |  2 +-
 10 files changed, 41 insertions(+), 43 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index c17615e21a5d6..1162f0e72df2e 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1023,7 +1023,7 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
 
 	if (folio) {
 		/* We treat non-present entries as "maybe shared". */
-		if (!present || folio_likely_mapped_shared(folio) ||
+		if (!present || folio_maybe_mapped_shared(folio) ||
 		    hugetlb_pmd_shared(pte))
 			mss->shared_hugetlb += huge_page_size(hstate_vma(vma));
 		else
@@ -1882,7 +1882,7 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
 		if (!folio_test_anon(folio))
 			flags |= PM_FILE;
 
-		if (!folio_likely_mapped_shared(folio) &&
+		if (!folio_maybe_mapped_shared(folio) &&
 		    !hugetlb_pmd_shared(ptep))
 			flags |= PM_MMAP_EXCLUSIVE;
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 53dd4f99fdabc..a4f2c56fcf524 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2245,23 +2245,18 @@ static inline size_t folio_size(const struct folio *folio)
 }
 
 /**
- * folio_likely_mapped_shared - Estimate if the folio is mapped into the page
- *				tables of more than one MM
+ * folio_maybe_mapped_shared - Whether the folio is mapped into the page
+ *			       tables of more than one MM
  * @folio: The folio.
  *
- * This function checks if the folio is currently mapped into more than one
- * MM ("mapped shared"), or if the folio is only mapped into a single MM
- * ("mapped exclusively").
+ * This function checks if the folio maybe currently mapped into more than one
+ * MM ("maybe mapped shared"), or if the folio is certainly mapped into a single
+ * MM ("mapped exclusively").
  *
  * For KSM folios, this function also returns "mapped shared" when a folio is
  * mapped multiple times into the same MM, because the individual page mappings
  * are independent.
  *
- * As precise information is not easily available for all folios, this function
- * estimates the number of MMs ("sharers") that are currently mapping a folio
- * using the number of times the first page of the folio is currently mapped
- * into page tables.
- *
  * For small anonymous folios and anonymous hugetlb folios, the return
  * value will be exactly correct: non-KSM folios can only be mapped at most once
  * into an MM, and they cannot be partially mapped. KSM folios are
@@ -2269,8 +2264,8 @@ static inline size_t folio_size(const struct folio *folio)
  *
  * For other folios, the result can be fuzzy:
  *    #. For partially-mappable large folios (THP), the return value can wrongly
- *       indicate "mapped exclusively" (false negative) when the folio is
- *       only partially mapped into at least one MM.
+ *       indicate "mapped shared" (false positive) if a folio was mapped by
+ *       more than two MMs at one point in time.
  *    #. For pagecache folios (including hugetlb), the return value can wrongly
  *       indicate "mapped shared" (false positive) when two VMAs in the same MM
  *       cover the same file range.
@@ -2287,7 +2282,7 @@ static inline size_t folio_size(const struct folio *folio)
  *
  * Return: Whether the folio is estimated to be mapped into more than one MM.
  */
-static inline bool folio_likely_mapped_shared(struct folio *folio)
+static inline bool folio_maybe_mapped_shared(struct folio *folio)
 {
 	int mapcount = folio_mapcount(folio);
 
@@ -2295,16 +2290,22 @@ static inline bool folio_likely_mapped_shared(struct folio *folio)
 	if (!folio_test_large(folio) || unlikely(folio_test_hugetlb(folio)))
 		return mapcount > 1;
 
-	/* A single mapping implies "mapped exclusively". */
-	if (mapcount <= 1)
-		return false;
-
-	/* If any page is mapped more than once we treat it "mapped shared". */
-	if (folio_entire_mapcount(folio) || mapcount > folio_nr_pages(folio))
+	/*
+	 * vm_insert_page() without CONFIG_TRANSPARENT_HUGEPAGE ...
+	 * simply assume "mapped shared", nobody should really care
+	 * about this for arbitrary kernel allocations.
+	 */
+	if (!IS_ENABLED(CONFIG_MM_ID))
 		return true;
 
-	/* Let's guess based on the first subpage. */
-	return atomic_read(&folio->_mapcount) > 0;
+	/*
+	 * A single mapping implies "mapped exclusively", even if the
+	 * folio flag says something different: it's easier to handle this
+	 * case here instead of on the RMAP hot path.
+	 */
+	if (mapcount <= 1)
+		return false;
+	return folio_test_large_maybe_mapped_shared(folio);
 }
 
 #ifndef HAVE_ARCH_MAKE_FOLIO_ACCESSIBLE
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 8e8b07e8b12fe..826bfe907017f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2155,7 +2155,7 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	 * If other processes are mapping this folio, we couldn't discard
 	 * the folio unless they all do MADV_FREE so let's skip the folio.
 	 */
-	if (folio_likely_mapped_shared(folio))
+	if (folio_maybe_mapped_shared(folio))
 		goto out;
 
 	if (!folio_trylock(folio))
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 5f0be134141e8..cc945c6ab3bdb 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -607,7 +607,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 		VM_BUG_ON_FOLIO(!folio_test_anon(folio), folio);
 
 		/* See hpage_collapse_scan_pmd(). */
-		if (folio_likely_mapped_shared(folio)) {
+		if (folio_maybe_mapped_shared(folio)) {
 			++shared;
 			if (cc->is_khugepaged &&
 			    shared > khugepaged_max_ptes_shared) {
@@ -1359,11 +1359,9 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 
 		/*
 		 * We treat a single page as shared if any part of the THP
-		 * is shared. "False negatives" from
-		 * folio_likely_mapped_shared() are not expected to matter
-		 * much in practice.
+		 * is shared.
 		 */
-		if (folio_likely_mapped_shared(folio)) {
+		if (folio_maybe_mapped_shared(folio)) {
 			++shared;
 			if (cc->is_khugepaged &&
 			    shared > khugepaged_max_ptes_shared) {
diff --git a/mm/madvise.c b/mm/madvise.c
index e01e93e179a8a..388dc289b5d12 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -387,7 +387,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		folio = pmd_folio(orig_pmd);
 
 		/* Do not interfere with other mappings of this folio */
-		if (folio_likely_mapped_shared(folio))
+		if (folio_maybe_mapped_shared(folio))
 			goto huge_unlock;
 
 		if (pageout_anon_only_filter && !folio_test_anon(folio))
@@ -486,7 +486,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 			if (nr < folio_nr_pages(folio)) {
 				int err;
 
-				if (folio_likely_mapped_shared(folio))
+				if (folio_maybe_mapped_shared(folio))
 					continue;
 				if (pageout_anon_only_filter && !folio_test_anon(folio))
 					continue;
@@ -721,7 +721,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 			if (nr < folio_nr_pages(folio)) {
 				int err;
 
-				if (folio_likely_mapped_shared(folio))
+				if (folio_maybe_mapped_shared(folio))
 					continue;
 				if (!folio_trylock(folio))
 					continue;
diff --git a/mm/memory.c b/mm/memory.c
index bb245a8fe04bc..a838c8c44bfdc 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5700,7 +5700,7 @@ int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
 	 * Flag if the folio is shared between multiple address spaces. This
 	 * is later used when determining whether to group tasks together
 	 */
-	if (folio_likely_mapped_shared(folio) && (vma->vm_flags & VM_SHARED))
+	if (folio_maybe_mapped_shared(folio) && (vma->vm_flags & VM_SHARED))
 		*flags |= TNF_SHARED;
 	/*
 	 * For memory tiering mode, cpupid of slow memory page is used
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index bbaadbeeb2919..530e71fe91476 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -642,11 +642,11 @@ static int queue_folios_hugetlb(pte_t *pte, unsigned long hmask,
 	 * Unless MPOL_MF_MOVE_ALL, we try to avoid migrating a shared folio.
 	 * Choosing not to migrate a shared folio is not counted as a failure.
 	 *
-	 * See folio_likely_mapped_shared() on possible imprecision when we
+	 * See folio_maybe_mapped_shared() on possible imprecision when we
 	 * cannot easily detect if a folio is shared.
 	 */
 	if ((flags & MPOL_MF_MOVE_ALL) ||
-	    (!folio_likely_mapped_shared(folio) && !hugetlb_pmd_shared(pte)))
+	    (!folio_maybe_mapped_shared(folio) && !hugetlb_pmd_shared(pte)))
 		if (!folio_isolate_hugetlb(folio, qp->pagelist))
 			qp->nr_failed++;
 unlock:
@@ -1033,10 +1033,10 @@ static bool migrate_folio_add(struct folio *folio, struct list_head *foliolist,
 	 * Unless MPOL_MF_MOVE_ALL, we try to avoid migrating a shared folio.
 	 * Choosing not to migrate a shared folio is not counted as a failure.
 	 *
-	 * See folio_likely_mapped_shared() on possible imprecision when we
+	 * See folio_maybe_mapped_shared() on possible imprecision when we
 	 * cannot easily detect if a folio is shared.
 	 */
-	if ((flags & MPOL_MF_MOVE_ALL) || !folio_likely_mapped_shared(folio)) {
+	if ((flags & MPOL_MF_MOVE_ALL) || !folio_maybe_mapped_shared(folio)) {
 		if (folio_isolate_lru(folio)) {
 			list_add_tail(&folio->lru, foliolist);
 			node_stat_mod_folio(folio,
diff --git a/mm/migrate.c b/mm/migrate.c
index 365c6daa8d1b1..fb4afd31baf0c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2228,7 +2228,7 @@ static int __add_folio_for_migration(struct folio *folio, int node,
 	if (folio_nid(folio) == node)
 		return 0;
 
-	if (folio_likely_mapped_shared(folio) && !migrate_all)
+	if (folio_maybe_mapped_shared(folio) && !migrate_all)
 		return -EACCES;
 
 	if (folio_test_hugetlb(folio)) {
@@ -2653,11 +2653,10 @@ int migrate_misplaced_folio_prepare(struct folio *folio,
 		 * processes with execute permissions as they are probably
 		 * shared libraries.
 		 *
-		 * See folio_likely_mapped_shared() on possible imprecision
+		 * See folio_maybe_mapped_shared() on possible imprecision
 		 * when we cannot easily detect if a folio is shared.
 		 */
-		if ((vma->vm_flags & VM_EXEC) &&
-		    folio_likely_mapped_shared(folio))
+		if ((vma->vm_flags & VM_EXEC) && folio_maybe_mapped_shared(folio))
 			return -EACCES;
 
 		/*
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 1444878f7aeb2..62c1f79457412 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -133,7 +133,7 @@ static long change_pte_range(struct mmu_gather *tlb,
 				/* Also skip shared copy-on-write pages */
 				if (is_cow_mapping(vma->vm_flags) &&
 				    (folio_maybe_dma_pinned(folio) ||
-				     folio_likely_mapped_shared(folio)))
+				     folio_maybe_mapped_shared(folio)))
 					continue;
 
 				/*
diff --git a/mm/rmap.c b/mm/rmap.c
index c9922928616ee..8de415157bc8d 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -889,7 +889,7 @@ static bool folio_referenced_one(struct folio *folio,
 		if ((!atomic_read(&vma->vm_mm->mm_users) ||
 		    check_stable_address_space(vma->vm_mm)) &&
 		    folio_test_anon(folio) && folio_test_swapbacked(folio) &&
-		    !folio_likely_mapped_shared(folio)) {
+		    !folio_maybe_mapped_shared(folio)) {
 			pra->referenced = -1;
 			page_vma_mapped_walk_done(&pvmw);
 			return false;
-- 
2.48.1



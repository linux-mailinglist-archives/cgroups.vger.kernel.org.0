Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9795D1CB73D
	for <lists+cgroups@lfdr.de>; Fri,  8 May 2020 20:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgEHScT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 May 2020 14:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727777AbgEHScS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 May 2020 14:32:18 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812EBC061A0C
        for <cgroups@vger.kernel.org>; Fri,  8 May 2020 11:32:18 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b188so2619402qkd.9
        for <cgroups@vger.kernel.org>; Fri, 08 May 2020 11:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gvivdVW5ETEWIYjqcsfazu+QEuC7bxT1uGHyPgIWjdk=;
        b=thueaNSzB9N5148LgAHFdFdG6qWsqk9sLRwVZyjA/QRcylFxyl3W6+y/QRIqPzN5Og
         9Pv2CpMfWqFHhWpjJ2RyqtKWy5yRTl1Ln10Zxi7fkzfvqYY6L3hfLDHtKMmk5+8Bb/eL
         KzJh1gOwJtcqtWS1XPx+BB+TFITu3/Gk9LUO9zCeWiVnpKTMXalyzJw3ZsG+5t0vTR0h
         0oDO8/PO2coRYClNaseLX9HesQWoLxDSP/3t8saXR+mLwyqYnPn2esHpQmG4FbcctBxa
         utZhvOwDLbyQEEt3kSGvbViVJNz7/lv8WVMKARiSZN2RG9aczKPQgUEJ8WmCCp7sYnZH
         dTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gvivdVW5ETEWIYjqcsfazu+QEuC7bxT1uGHyPgIWjdk=;
        b=gbyLyFoDB76UIDNPT6HqN931GDAkVLDQAFyw4U9zkU0oO4DEF6yp9YLaiRI/TzZAxR
         80CQuBK9faVC75YOeeQlCTBo0jAjCyjzOEhXP0Fe+ckctNOfWrTFsYTtjZxFOV8ZTk9B
         NNYCfBZCwo/SrS2HMLVRNKZmTJZVQ1OgTUT9F1JCDzaZN0nIyt0WMwXRwASejwu0eJdx
         EMj+fO3/de24/ILCjehyiP3IDtsedEFYMS3nRvndXPlRPDJ+68oAPHTG8l30EHkl395h
         9/N9/bd+h8DDitl8J5WnYyHvhjZ44Op1NGazRLbNiFCWVo0Ziyv7IPNzM0+7TY7dXmyb
         ccug==
X-Gm-Message-State: AGi0Puaak0VG7ErLtLOuDcCsLmaGYyFmmxAsIvnofQ7Qpi6Q5Pk5UZWF
        0FjihwX3CY18rgjRtjqFtJdI+g==
X-Google-Smtp-Source: APiQypLUI/5NpRUhG8en1GEKBOIKUsLd+v7Z/yEwtkDtzARtIfzz8lZ06zalfdVgVt17GYeE2XIO7Q==
X-Received: by 2002:a37:82c1:: with SMTP id e184mr4376200qkd.186.1588962737179;
        Fri, 08 May 2020 11:32:17 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2627])
        by smtp.gmail.com with ESMTPSA id a124sm1801685qkf.93.2020.05.08.11.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 11:32:16 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Joonsoo Kim <js1304@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 03/19] mm: memcontrol: drop @compound parameter from memcg charging API
Date:   Fri,  8 May 2020 14:30:50 -0400
Message-Id: <20200508183105.225460-4-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508183105.225460-1-hannes@cmpxchg.org>
References: <20200508183105.225460-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The memcg charging API carries a boolean @compound parameter that
tells whether the page we're dealing with is a hugepage.
mem_cgroup_commit_charge() has another boolean @lrucare that indicates
whether the page needs LRU locking or not while charging. The majority
of callsites know those parameters at compile time, which results in a
lot of naked "false, false" argument lists. This makes for cryptic
code and is a breeding ground for subtle mistakes.

Thankfully, the huge page state can be inferred from the page itself
and doesn't need to be passed along. This is safe because charging
completes before the page is published and somebody may split it.

Simplify the callsites by removing @compound, and let memcg infer the
state by using hpage_nr_pages() unconditionally. That function does
PageTransHuge() to identify huge pages, which also helpfully asserts
that nobody passes in tail pages by accident.

The following patches will introduce a new charging API, best not to
carry over unnecessary weight.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>
Reviewed-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/memcontrol.h | 22 ++++++++--------------
 kernel/events/uprobes.c    |  6 +++---
 mm/filemap.c               |  6 +++---
 mm/huge_memory.c           |  8 ++++----
 mm/khugepaged.c            | 20 ++++++++++----------
 mm/memcontrol.c            | 38 +++++++++++++++-----------------------
 mm/memory.c                | 32 +++++++++++++++-----------------
 mm/migrate.c               |  6 +++---
 mm/shmem.c                 | 22 +++++++++-------------
 mm/swapfile.c              |  9 ++++-----
 mm/userfaultfd.c           |  6 +++---
 11 files changed, 77 insertions(+), 98 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index b67dd43aaa4b..30292d57c8af 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -373,15 +373,12 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
 }
 
 int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
-			  gfp_t gfp_mask, struct mem_cgroup **memcgp,
-			  bool compound);
+			  gfp_t gfp_mask, struct mem_cgroup **memcgp);
 int mem_cgroup_try_charge_delay(struct page *page, struct mm_struct *mm,
-			  gfp_t gfp_mask, struct mem_cgroup **memcgp,
-			  bool compound);
+			  gfp_t gfp_mask, struct mem_cgroup **memcgp);
 void mem_cgroup_commit_charge(struct page *page, struct mem_cgroup *memcg,
-			      bool lrucare, bool compound);
-void mem_cgroup_cancel_charge(struct page *page, struct mem_cgroup *memcg,
-		bool compound);
+			      bool lrucare);
+void mem_cgroup_cancel_charge(struct page *page, struct mem_cgroup *memcg);
 void mem_cgroup_uncharge(struct page *page);
 void mem_cgroup_uncharge_list(struct list_head *page_list);
 
@@ -870,8 +867,7 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
 
 static inline int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
 					gfp_t gfp_mask,
-					struct mem_cgroup **memcgp,
-					bool compound)
+					struct mem_cgroup **memcgp)
 {
 	*memcgp = NULL;
 	return 0;
@@ -880,8 +876,7 @@ static inline int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
 static inline int mem_cgroup_try_charge_delay(struct page *page,
 					      struct mm_struct *mm,
 					      gfp_t gfp_mask,
-					      struct mem_cgroup **memcgp,
-					      bool compound)
+					      struct mem_cgroup **memcgp)
 {
 	*memcgp = NULL;
 	return 0;
@@ -889,13 +884,12 @@ static inline int mem_cgroup_try_charge_delay(struct page *page,
 
 static inline void mem_cgroup_commit_charge(struct page *page,
 					    struct mem_cgroup *memcg,
-					    bool lrucare, bool compound)
+					    bool lrucare)
 {
 }
 
 static inline void mem_cgroup_cancel_charge(struct page *page,
-					    struct mem_cgroup *memcg,
-					    bool compound)
+					    struct mem_cgroup *memcg)
 {
 }
 
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index ece7e13f6e4a..40e7488ce467 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -169,7 +169,7 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 
 	if (new_page) {
 		err = mem_cgroup_try_charge(new_page, vma->vm_mm, GFP_KERNEL,
-					    &memcg, false);
+					    &memcg);
 		if (err)
 			return err;
 	}
@@ -181,7 +181,7 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 	err = -EAGAIN;
 	if (!page_vma_mapped_walk(&pvmw)) {
 		if (new_page)
-			mem_cgroup_cancel_charge(new_page, memcg, false);
+			mem_cgroup_cancel_charge(new_page, memcg);
 		goto unlock;
 	}
 	VM_BUG_ON_PAGE(addr != pvmw.address, old_page);
@@ -189,7 +189,7 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 	if (new_page) {
 		get_page(new_page);
 		page_add_new_anon_rmap(new_page, vma, addr, false);
-		mem_cgroup_commit_charge(new_page, memcg, false, false);
+		mem_cgroup_commit_charge(new_page, memcg, false);
 		lru_cache_add_active_or_unevictable(new_page, vma);
 	} else
 		/* no new page, just dec_mm_counter for old_page */
diff --git a/mm/filemap.c b/mm/filemap.c
index 2b057b0aa882..ce200386736c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -842,7 +842,7 @@ static int __add_to_page_cache_locked(struct page *page,
 
 	if (!huge) {
 		error = mem_cgroup_try_charge(page, current->mm,
-					      gfp_mask, &memcg, false);
+					      gfp_mask, &memcg);
 		if (error)
 			return error;
 	}
@@ -878,14 +878,14 @@ static int __add_to_page_cache_locked(struct page *page,
 		goto error;
 
 	if (!huge)
-		mem_cgroup_commit_charge(page, memcg, false, false);
+		mem_cgroup_commit_charge(page, memcg, false);
 	trace_mm_filemap_add_to_page_cache(page);
 	return 0;
 error:
 	page->mapping = NULL;
 	/* Leave page->index set: truncation relies upon it */
 	if (!huge)
-		mem_cgroup_cancel_charge(page, memcg, false);
+		mem_cgroup_cancel_charge(page, memcg);
 	put_page(page);
 	return xas_error(&xas);
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d7384eb2e017..46c2bc20b7cb 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -594,7 +594,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 
 	VM_BUG_ON_PAGE(!PageCompound(page), page);
 
-	if (mem_cgroup_try_charge_delay(page, vma->vm_mm, gfp, &memcg, true)) {
+	if (mem_cgroup_try_charge_delay(page, vma->vm_mm, gfp, &memcg)) {
 		put_page(page);
 		count_vm_event(THP_FAULT_FALLBACK);
 		count_vm_event(THP_FAULT_FALLBACK_CHARGE);
@@ -630,7 +630,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 			vm_fault_t ret2;
 
 			spin_unlock(vmf->ptl);
-			mem_cgroup_cancel_charge(page, memcg, true);
+			mem_cgroup_cancel_charge(page, memcg);
 			put_page(page);
 			pte_free(vma->vm_mm, pgtable);
 			ret2 = handle_userfault(vmf, VM_UFFD_MISSING);
@@ -641,7 +641,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 		entry = mk_huge_pmd(page, vma->vm_page_prot);
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
 		page_add_new_anon_rmap(page, vma, haddr, true);
-		mem_cgroup_commit_charge(page, memcg, false, true);
+		mem_cgroup_commit_charge(page, memcg, false);
 		lru_cache_add_active_or_unevictable(page, vma);
 		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
 		set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
@@ -658,7 +658,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 release:
 	if (pgtable)
 		pte_free(vma->vm_mm, pgtable);
-	mem_cgroup_cancel_charge(page, memcg, true);
+	mem_cgroup_cancel_charge(page, memcg);
 	put_page(page);
 	return ret;
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index a02a4c5f2fe4..b73d2af6d11a 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1067,7 +1067,7 @@ static void collapse_huge_page(struct mm_struct *mm,
 		goto out_nolock;
 	}
 
-	if (unlikely(mem_cgroup_try_charge(new_page, mm, gfp, &memcg, true))) {
+	if (unlikely(mem_cgroup_try_charge(new_page, mm, gfp, &memcg))) {
 		result = SCAN_CGROUP_CHARGE_FAIL;
 		goto out_nolock;
 	}
@@ -1075,7 +1075,7 @@ static void collapse_huge_page(struct mm_struct *mm,
 	down_read(&mm->mmap_sem);
 	result = hugepage_vma_revalidate(mm, address, &vma);
 	if (result) {
-		mem_cgroup_cancel_charge(new_page, memcg, true);
+		mem_cgroup_cancel_charge(new_page, memcg);
 		up_read(&mm->mmap_sem);
 		goto out_nolock;
 	}
@@ -1083,7 +1083,7 @@ static void collapse_huge_page(struct mm_struct *mm,
 	pmd = mm_find_pmd(mm, address);
 	if (!pmd) {
 		result = SCAN_PMD_NULL;
-		mem_cgroup_cancel_charge(new_page, memcg, true);
+		mem_cgroup_cancel_charge(new_page, memcg);
 		up_read(&mm->mmap_sem);
 		goto out_nolock;
 	}
@@ -1095,7 +1095,7 @@ static void collapse_huge_page(struct mm_struct *mm,
 	 */
 	if (unmapped && !__collapse_huge_page_swapin(mm, vma, address,
 				pmd, referenced)) {
-		mem_cgroup_cancel_charge(new_page, memcg, true);
+		mem_cgroup_cancel_charge(new_page, memcg);
 		up_read(&mm->mmap_sem);
 		goto out_nolock;
 	}
@@ -1183,7 +1183,7 @@ static void collapse_huge_page(struct mm_struct *mm,
 	spin_lock(pmd_ptl);
 	BUG_ON(!pmd_none(*pmd));
 	page_add_new_anon_rmap(new_page, vma, address, true);
-	mem_cgroup_commit_charge(new_page, memcg, false, true);
+	mem_cgroup_commit_charge(new_page, memcg, false);
 	count_memcg_events(memcg, THP_COLLAPSE_ALLOC, 1);
 	lru_cache_add_active_or_unevictable(new_page, vma);
 	pgtable_trans_huge_deposit(mm, pmd, pgtable);
@@ -1201,7 +1201,7 @@ static void collapse_huge_page(struct mm_struct *mm,
 	trace_mm_collapse_huge_page(mm, isolated, result);
 	return;
 out:
-	mem_cgroup_cancel_charge(new_page, memcg, true);
+	mem_cgroup_cancel_charge(new_page, memcg);
 	goto out_up_write;
 }
 
@@ -1628,7 +1628,7 @@ static void collapse_file(struct mm_struct *mm,
 		goto out;
 	}
 
-	if (unlikely(mem_cgroup_try_charge(new_page, mm, gfp, &memcg, true))) {
+	if (unlikely(mem_cgroup_try_charge(new_page, mm, gfp, &memcg))) {
 		result = SCAN_CGROUP_CHARGE_FAIL;
 		goto out;
 	}
@@ -1641,7 +1641,7 @@ static void collapse_file(struct mm_struct *mm,
 			break;
 		xas_unlock_irq(&xas);
 		if (!xas_nomem(&xas, GFP_KERNEL)) {
-			mem_cgroup_cancel_charge(new_page, memcg, true);
+			mem_cgroup_cancel_charge(new_page, memcg);
 			result = SCAN_FAIL;
 			goto out;
 		}
@@ -1877,7 +1877,7 @@ static void collapse_file(struct mm_struct *mm,
 
 		SetPageUptodate(new_page);
 		page_ref_add(new_page, HPAGE_PMD_NR - 1);
-		mem_cgroup_commit_charge(new_page, memcg, false, true);
+		mem_cgroup_commit_charge(new_page, memcg, false);
 
 		if (is_shmem) {
 			set_page_dirty(new_page);
@@ -1932,7 +1932,7 @@ static void collapse_file(struct mm_struct *mm,
 		VM_BUG_ON(nr_none);
 		xas_unlock_irq(&xas);
 
-		mem_cgroup_cancel_charge(new_page, memcg, true);
+		mem_cgroup_cancel_charge(new_page, memcg);
 		new_page->mapping = NULL;
 	}
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index cdd29b59929b..13da46a5d8ae 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -834,7 +834,7 @@ static unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
 
 static void mem_cgroup_charge_statistics(struct mem_cgroup *memcg,
 					 struct page *page,
-					 bool compound, int nr_pages)
+					 int nr_pages)
 {
 	/*
 	 * Here, RSS means 'mapped anon' and anon's SwapCache. Shmem/tmpfs is
@@ -848,7 +848,7 @@ static void mem_cgroup_charge_statistics(struct mem_cgroup *memcg,
 			__mod_memcg_state(memcg, NR_SHMEM, nr_pages);
 	}
 
-	if (compound) {
+	if (abs(nr_pages) > 1) {
 		VM_BUG_ON_PAGE(!PageTransHuge(page), page);
 		__mod_memcg_state(memcg, MEMCG_RSS_HUGE, nr_pages);
 	}
@@ -5445,9 +5445,9 @@ static int mem_cgroup_move_account(struct page *page,
 	ret = 0;
 
 	local_irq_disable();
-	mem_cgroup_charge_statistics(to, page, compound, nr_pages);
+	mem_cgroup_charge_statistics(to, page, nr_pages);
 	memcg_check_events(to, page);
-	mem_cgroup_charge_statistics(from, page, compound, -nr_pages);
+	mem_cgroup_charge_statistics(from, page, -nr_pages);
 	memcg_check_events(from, page);
 	local_irq_enable();
 out_unlock:
@@ -6435,7 +6435,6 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
  * @mm: mm context of the victim
  * @gfp_mask: reclaim mode
  * @memcgp: charged memcg return
- * @compound: charge the page as compound or small page
  *
  * Try to charge @page to the memcg that @mm belongs to, reclaiming
  * pages according to @gfp_mask if necessary.
@@ -6448,11 +6447,10 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
  * with mem_cgroup_cancel_charge() in case page instantiation fails.
  */
 int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
-			  gfp_t gfp_mask, struct mem_cgroup **memcgp,
-			  bool compound)
+			  gfp_t gfp_mask, struct mem_cgroup **memcgp)
 {
+	unsigned int nr_pages = hpage_nr_pages(page);
 	struct mem_cgroup *memcg = NULL;
-	unsigned int nr_pages = compound ? hpage_nr_pages(page) : 1;
 	int ret = 0;
 
 	if (mem_cgroup_disabled())
@@ -6494,13 +6492,12 @@ int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
 }
 
 int mem_cgroup_try_charge_delay(struct page *page, struct mm_struct *mm,
-			  gfp_t gfp_mask, struct mem_cgroup **memcgp,
-			  bool compound)
+			  gfp_t gfp_mask, struct mem_cgroup **memcgp)
 {
 	struct mem_cgroup *memcg;
 	int ret;
 
-	ret = mem_cgroup_try_charge(page, mm, gfp_mask, memcgp, compound);
+	ret = mem_cgroup_try_charge(page, mm, gfp_mask, memcgp);
 	memcg = *memcgp;
 	mem_cgroup_throttle_swaprate(memcg, page_to_nid(page), gfp_mask);
 	return ret;
@@ -6511,7 +6508,6 @@ int mem_cgroup_try_charge_delay(struct page *page, struct mm_struct *mm,
  * @page: page to charge
  * @memcg: memcg to charge the page to
  * @lrucare: page might be on LRU already
- * @compound: charge the page as compound or small page
  *
  * Finalize a charge transaction started by mem_cgroup_try_charge(),
  * after page->mapping has been set up.  This must happen atomically
@@ -6524,9 +6520,9 @@ int mem_cgroup_try_charge_delay(struct page *page, struct mm_struct *mm,
  * Use mem_cgroup_cancel_charge() to cancel the transaction instead.
  */
 void mem_cgroup_commit_charge(struct page *page, struct mem_cgroup *memcg,
-			      bool lrucare, bool compound)
+			      bool lrucare)
 {
-	unsigned int nr_pages = compound ? hpage_nr_pages(page) : 1;
+	unsigned int nr_pages = hpage_nr_pages(page);
 
 	VM_BUG_ON_PAGE(!page->mapping, page);
 	VM_BUG_ON_PAGE(PageLRU(page) && !lrucare, page);
@@ -6544,7 +6540,7 @@ void mem_cgroup_commit_charge(struct page *page, struct mem_cgroup *memcg,
 	commit_charge(page, memcg, lrucare);
 
 	local_irq_disable();
-	mem_cgroup_charge_statistics(memcg, page, compound, nr_pages);
+	mem_cgroup_charge_statistics(memcg, page, nr_pages);
 	memcg_check_events(memcg, page);
 	local_irq_enable();
 
@@ -6563,14 +6559,12 @@ void mem_cgroup_commit_charge(struct page *page, struct mem_cgroup *memcg,
  * mem_cgroup_cancel_charge - cancel a page charge
  * @page: page to charge
  * @memcg: memcg to charge the page to
- * @compound: charge the page as compound or small page
  *
  * Cancel a charge transaction started by mem_cgroup_try_charge().
  */
-void mem_cgroup_cancel_charge(struct page *page, struct mem_cgroup *memcg,
-		bool compound)
+void mem_cgroup_cancel_charge(struct page *page, struct mem_cgroup *memcg)
 {
-	unsigned int nr_pages = compound ? hpage_nr_pages(page) : 1;
+	unsigned int nr_pages = hpage_nr_pages(page);
 
 	if (mem_cgroup_disabled())
 		return;
@@ -6785,8 +6779,7 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 	commit_charge(newpage, memcg, false);
 
 	local_irq_save(flags);
-	mem_cgroup_charge_statistics(memcg, newpage, PageTransHuge(newpage),
-			nr_pages);
+	mem_cgroup_charge_statistics(memcg, newpage, nr_pages);
 	memcg_check_events(memcg, newpage);
 	local_irq_restore(flags);
 }
@@ -7016,8 +7009,7 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 	 * only synchronisation we have for updating the per-CPU variables.
 	 */
 	VM_BUG_ON(!irqs_disabled());
-	mem_cgroup_charge_statistics(memcg, page, PageTransHuge(page),
-				     -nr_entries);
+	mem_cgroup_charge_statistics(memcg, page, -nr_entries);
 	memcg_check_events(memcg, page);
 
 	if (!mem_cgroup_is_root(memcg))
diff --git a/mm/memory.c b/mm/memory.c
index 0ad29c7274de..a08cbaa81607 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2676,7 +2676,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		}
 	}
 
-	if (mem_cgroup_try_charge_delay(new_page, mm, GFP_KERNEL, &memcg, false))
+	if (mem_cgroup_try_charge_delay(new_page, mm, GFP_KERNEL, &memcg))
 		goto oom_free_new;
 
 	__SetPageUptodate(new_page);
@@ -2711,7 +2711,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		 */
 		ptep_clear_flush_notify(vma, vmf->address, vmf->pte);
 		page_add_new_anon_rmap(new_page, vma, vmf->address, false);
-		mem_cgroup_commit_charge(new_page, memcg, false, false);
+		mem_cgroup_commit_charge(new_page, memcg, false);
 		lru_cache_add_active_or_unevictable(new_page, vma);
 		/*
 		 * We call the notify macro here because, when using secondary
@@ -2750,7 +2750,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		new_page = old_page;
 		page_copied = 1;
 	} else {
-		mem_cgroup_cancel_charge(new_page, memcg, false);
+		mem_cgroup_cancel_charge(new_page, memcg);
 	}
 
 	if (new_page)
@@ -3193,8 +3193,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		goto out_page;
 	}
 
-	if (mem_cgroup_try_charge_delay(page, vma->vm_mm, GFP_KERNEL,
-					&memcg, false)) {
+	if (mem_cgroup_try_charge_delay(page, vma->vm_mm, GFP_KERNEL, &memcg)) {
 		ret = VM_FAULT_OOM;
 		goto out_page;
 	}
@@ -3245,11 +3244,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	/* ksm created a completely new copy */
 	if (unlikely(page != swapcache && swapcache)) {
 		page_add_new_anon_rmap(page, vma, vmf->address, false);
-		mem_cgroup_commit_charge(page, memcg, false, false);
+		mem_cgroup_commit_charge(page, memcg, false);
 		lru_cache_add_active_or_unevictable(page, vma);
 	} else {
 		do_page_add_anon_rmap(page, vma, vmf->address, exclusive);
-		mem_cgroup_commit_charge(page, memcg, true, false);
+		mem_cgroup_commit_charge(page, memcg, true);
 		activate_page(page);
 	}
 
@@ -3285,7 +3284,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 out:
 	return ret;
 out_nomap:
-	mem_cgroup_cancel_charge(page, memcg, false);
+	mem_cgroup_cancel_charge(page, memcg);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 out_page:
 	unlock_page(page);
@@ -3359,8 +3358,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	if (!page)
 		goto oom;
 
-	if (mem_cgroup_try_charge_delay(page, vma->vm_mm, GFP_KERNEL, &memcg,
-					false))
+	if (mem_cgroup_try_charge_delay(page, vma->vm_mm, GFP_KERNEL, &memcg))
 		goto oom_free_page;
 
 	/*
@@ -3386,14 +3384,14 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	/* Deliver the page fault to userland, check inside PT lock */
 	if (userfaultfd_missing(vma)) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
-		mem_cgroup_cancel_charge(page, memcg, false);
+		mem_cgroup_cancel_charge(page, memcg);
 		put_page(page);
 		return handle_userfault(vmf, VM_UFFD_MISSING);
 	}
 
 	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
 	page_add_new_anon_rmap(page, vma, vmf->address, false);
-	mem_cgroup_commit_charge(page, memcg, false, false);
+	mem_cgroup_commit_charge(page, memcg, false);
 	lru_cache_add_active_or_unevictable(page, vma);
 setpte:
 	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
@@ -3404,7 +3402,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 	return ret;
 release:
-	mem_cgroup_cancel_charge(page, memcg, false);
+	mem_cgroup_cancel_charge(page, memcg);
 	put_page(page);
 	goto unlock;
 oom_free_page:
@@ -3655,7 +3653,7 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct mem_cgroup *memcg,
 	if (write && !(vma->vm_flags & VM_SHARED)) {
 		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
 		page_add_new_anon_rmap(page, vma, vmf->address, false);
-		mem_cgroup_commit_charge(page, memcg, false, false);
+		mem_cgroup_commit_charge(page, memcg, false);
 		lru_cache_add_active_or_unevictable(page, vma);
 	} else {
 		inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page));
@@ -3864,8 +3862,8 @@ static vm_fault_t do_cow_fault(struct vm_fault *vmf)
 	if (!vmf->cow_page)
 		return VM_FAULT_OOM;
 
-	if (mem_cgroup_try_charge_delay(vmf->cow_page, vma->vm_mm, GFP_KERNEL,
-				&vmf->memcg, false)) {
+	if (mem_cgroup_try_charge_delay(vmf->cow_page, vma->vm_mm,
+					GFP_KERNEL, &vmf->memcg)) {
 		put_page(vmf->cow_page);
 		return VM_FAULT_OOM;
 	}
@@ -3886,7 +3884,7 @@ static vm_fault_t do_cow_fault(struct vm_fault *vmf)
 		goto uncharge_out;
 	return ret;
 uncharge_out:
-	mem_cgroup_cancel_charge(vmf->cow_page, vmf->memcg, false);
+	mem_cgroup_cancel_charge(vmf->cow_page, vmf->memcg);
 	put_page(vmf->cow_page);
 	return ret;
 }
diff --git a/mm/migrate.c b/mm/migrate.c
index f66f93f9a5e2..50c7a08f8f31 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2786,7 +2786,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 
 	if (unlikely(anon_vma_prepare(vma)))
 		goto abort;
-	if (mem_cgroup_try_charge(page, vma->vm_mm, GFP_KERNEL, &memcg, false))
+	if (mem_cgroup_try_charge(page, vma->vm_mm, GFP_KERNEL, &memcg))
 		goto abort;
 
 	/*
@@ -2832,7 +2832,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 
 	inc_mm_counter(mm, MM_ANONPAGES);
 	page_add_new_anon_rmap(page, vma, addr, false);
-	mem_cgroup_commit_charge(page, memcg, false, false);
+	mem_cgroup_commit_charge(page, memcg, false);
 	if (!is_zone_device_page(page))
 		lru_cache_add_active_or_unevictable(page, vma);
 	get_page(page);
@@ -2854,7 +2854,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 
 unlock_abort:
 	pte_unmap_unlock(ptep, ptl);
-	mem_cgroup_cancel_charge(page, memcg, false);
+	mem_cgroup_cancel_charge(page, memcg);
 abort:
 	*src &= ~MIGRATE_PFN_MIGRATE;
 }
diff --git a/mm/shmem.c b/mm/shmem.c
index bd8840082c94..d505b6cce4ab 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1664,8 +1664,7 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
 			goto failed;
 	}
 
-	error = mem_cgroup_try_charge_delay(page, charge_mm, gfp, &memcg,
-					    false);
+	error = mem_cgroup_try_charge_delay(page, charge_mm, gfp, &memcg);
 	if (!error) {
 		error = shmem_add_to_page_cache(page, mapping, index,
 						swp_to_radix_entry(swap), gfp);
@@ -1680,14 +1679,14 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
 		 * the rest.
 		 */
 		if (error) {
-			mem_cgroup_cancel_charge(page, memcg, false);
+			mem_cgroup_cancel_charge(page, memcg);
 			delete_from_swap_cache(page);
 		}
 	}
 	if (error)
 		goto failed;
 
-	mem_cgroup_commit_charge(page, memcg, true, false);
+	mem_cgroup_commit_charge(page, memcg, true);
 
 	spin_lock_irq(&info->lock);
 	info->swapped--;
@@ -1859,8 +1858,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 	if (sgp == SGP_WRITE)
 		__SetPageReferenced(page);
 
-	error = mem_cgroup_try_charge_delay(page, charge_mm, gfp, &memcg,
-					    PageTransHuge(page));
+	error = mem_cgroup_try_charge_delay(page, charge_mm, gfp, &memcg);
 	if (error) {
 		if (PageTransHuge(page)) {
 			count_vm_event(THP_FILE_FALLBACK);
@@ -1871,12 +1869,10 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 	error = shmem_add_to_page_cache(page, mapping, hindex,
 					NULL, gfp & GFP_RECLAIM_MASK);
 	if (error) {
-		mem_cgroup_cancel_charge(page, memcg,
-					 PageTransHuge(page));
+		mem_cgroup_cancel_charge(page, memcg);
 		goto unacct;
 	}
-	mem_cgroup_commit_charge(page, memcg, false,
-				 PageTransHuge(page));
+	mem_cgroup_commit_charge(page, memcg, false);
 	lru_cache_add_anon(page);
 
 	spin_lock_irq(&info->lock);
@@ -2364,7 +2360,7 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 	if (unlikely(offset >= max_off))
 		goto out_release;
 
-	ret = mem_cgroup_try_charge_delay(page, dst_mm, gfp, &memcg, false);
+	ret = mem_cgroup_try_charge_delay(page, dst_mm, gfp, &memcg);
 	if (ret)
 		goto out_release;
 
@@ -2373,7 +2369,7 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 	if (ret)
 		goto out_release_uncharge;
 
-	mem_cgroup_commit_charge(page, memcg, false, false);
+	mem_cgroup_commit_charge(page, memcg, false);
 
 	_dst_pte = mk_pte(page, dst_vma->vm_page_prot);
 	if (dst_vma->vm_flags & VM_WRITE)
@@ -2424,7 +2420,7 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 	ClearPageDirty(page);
 	delete_from_page_cache(page);
 out_release_uncharge:
-	mem_cgroup_cancel_charge(page, memcg, false);
+	mem_cgroup_cancel_charge(page, memcg);
 out_release:
 	unlock_page(page);
 	put_page(page);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 0aa9a9dd5d3d..15e5f8f290cc 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1868,15 +1868,14 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 	if (unlikely(!page))
 		return -ENOMEM;
 
-	if (mem_cgroup_try_charge(page, vma->vm_mm, GFP_KERNEL,
-				&memcg, false)) {
+	if (mem_cgroup_try_charge(page, vma->vm_mm, GFP_KERNEL, &memcg)) {
 		ret = -ENOMEM;
 		goto out_nolock;
 	}
 
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	if (unlikely(!pte_same_as_swp(*pte, swp_entry_to_pte(entry)))) {
-		mem_cgroup_cancel_charge(page, memcg, false);
+		mem_cgroup_cancel_charge(page, memcg);
 		ret = 0;
 		goto out;
 	}
@@ -1888,10 +1887,10 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 		   pte_mkold(mk_pte(page, vma->vm_page_prot)));
 	if (page == swapcache) {
 		page_add_anon_rmap(page, vma, addr, false);
-		mem_cgroup_commit_charge(page, memcg, true, false);
+		mem_cgroup_commit_charge(page, memcg, true);
 	} else { /* ksm created a completely new copy */
 		page_add_new_anon_rmap(page, vma, addr, false);
-		mem_cgroup_commit_charge(page, memcg, false, false);
+		mem_cgroup_commit_charge(page, memcg, false);
 		lru_cache_add_active_or_unevictable(page, vma);
 	}
 	swap_free(entry);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 512576e171ce..bb57d0a3fca7 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -97,7 +97,7 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 	__SetPageUptodate(page);
 
 	ret = -ENOMEM;
-	if (mem_cgroup_try_charge(page, dst_mm, GFP_KERNEL, &memcg, false))
+	if (mem_cgroup_try_charge(page, dst_mm, GFP_KERNEL, &memcg))
 		goto out_release;
 
 	_dst_pte = pte_mkdirty(mk_pte(page, dst_vma->vm_page_prot));
@@ -124,7 +124,7 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 
 	inc_mm_counter(dst_mm, MM_ANONPAGES);
 	page_add_new_anon_rmap(page, dst_vma, dst_addr, false);
-	mem_cgroup_commit_charge(page, memcg, false, false);
+	mem_cgroup_commit_charge(page, memcg, false);
 	lru_cache_add_active_or_unevictable(page, dst_vma);
 
 	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
@@ -138,7 +138,7 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 	return ret;
 out_release_uncharge_unlock:
 	pte_unmap_unlock(dst_pte, ptl);
-	mem_cgroup_cancel_charge(page, memcg, false);
+	mem_cgroup_cancel_charge(page, memcg);
 out_release:
 	put_page(page);
 	goto out;
-- 
2.26.2


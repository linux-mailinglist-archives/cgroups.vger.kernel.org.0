Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAC61B191B
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2020 00:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgDTWMG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Apr 2020 18:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbgDTWME (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Apr 2020 18:12:04 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7FBC061A0E
        for <cgroups@vger.kernel.org>; Mon, 20 Apr 2020 15:12:04 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id c16so10067070qtv.1
        for <cgroups@vger.kernel.org>; Mon, 20 Apr 2020 15:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7AmtiWZgkvOnFthLztBwKG3f5Qy7StJTB8hHddtbvuk=;
        b=hCjdOaViHrkEbtl51ryOezSxodDPN5uB38yPcy9im9C++lG92QI55IW8rCTxgSd00O
         gaHLCNITytGhTVsrtHGGMMcKmf08Vc3GgQLWyjHjH67yemLVayLaC1cNQ5EdxYd5viI4
         SHYOM36shzUZjSD2wEN/mUGvDeO3IMk9SmRPt8VLcEcB7y5GKHEjfmPVyDaeLl3rrA5i
         gOIWYVrDgH1rDY0lMd8B4Ghl9filGSvMNzXGEmdt/kvwNgqOUKUpvwg1B39u+DnxQj+7
         cXyYzh+7VEgCwCuX26qU9v7E4SMu65amGj8ySKWMpZ1yS8EGsU/R+ljdOjpWYZSxeEXo
         yRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7AmtiWZgkvOnFthLztBwKG3f5Qy7StJTB8hHddtbvuk=;
        b=hsPc3DXLYipRlk1pyRWJhCPZvlia490bbq8ITFIuGoOlXxgwAN/U6BYkj+R3ULUxZg
         s6GtFmXxpixQ+qAXXMjcw0vSx1JI4gEBSstHbzjPUGJaL4F/9GLrUpR55t2rTicFa41c
         J8W9cZQ/vfNtJ/FF/9V5QZ6XWfHT6BFtIWhsAn1bzrrARWMRxlsqgVWUkUSXnwNkYYDl
         GpPmNeLvwSWw5GjC8YNRNJG6oAXQMay9PLNJwUBC3R2pFjIb3sgRqYyMGaBkWyY4eiau
         suQbT4sty3VUCbUNVu62iqZm1wswpKGyc1FgmSh7tzZg2/C8dFdrQKXM7c0DN3tO+sN5
         bw4A==
X-Gm-Message-State: AGi0PuYgTBRf69aLiqKBU54/cko3LmqghlGmPdEdyJWJ6m0qePLVmpJX
        MMGiX6on4FuvLreR0oF76vJoyQ==
X-Google-Smtp-Source: APiQypKyWfoJ53mOA+3wyCXCIy/W5MCoQKsIVb8UgFnQqW1Wp4vQMpHVnjqVBwWgauqBIt+pNfBnFw==
X-Received: by 2002:ac8:1757:: with SMTP id u23mr18275577qtk.138.1587420722978;
        Mon, 20 Apr 2020 15:12:02 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:e6b6])
        by smtp.gmail.com with ESMTPSA id r51sm445355qtk.89.2020.04.20.15.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 15:12:02 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Joonsoo Kim <js1304@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 12/18] mm: memcontrol: convert anon and file-thp to new mem_cgroup_charge() API
Date:   Mon, 20 Apr 2020 18:11:20 -0400
Message-Id: <20200420221126.341272-13-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200420221126.341272-1-hannes@cmpxchg.org>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

With the page->mapping requirement gone from memcg, we can charge anon
and file-thp pages in one single step, right after they're allocated.

This removes two out of three API calls - especially the tricky commit
step that needed to happen at just the right time between when the
page is "set up" and when it's "published" - somewhat vague and fluid
concepts that varied by page type. All we need is a freshly allocated
page and a memcg context to charge.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/mm.h      |  4 +---
 kernel/events/uprobes.c | 11 +++--------
 mm/filemap.c            |  2 +-
 mm/huge_memory.c        | 41 ++++++++++++-----------------------------
 mm/khugepaged.c         | 31 ++++++-------------------------
 mm/memory.c             | 36 ++++++++++--------------------------
 mm/migrate.c            |  5 +----
 mm/swapfile.c           |  6 +-----
 mm/userfaultfd.c        |  5 +----
 9 files changed, 36 insertions(+), 105 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5a323422d783..892096bb7292 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -505,7 +505,6 @@ struct vm_fault {
 	pte_t orig_pte;			/* Value of PTE at the time of fault */
 
 	struct page *cow_page;		/* Page handler may use for COW fault */
-	struct mem_cgroup *memcg;	/* Cgroup cow_page belongs to */
 	struct page *page;		/* ->fault handlers should return a
 					 * page here, unless VM_FAULT_NOPAGE
 					 * is set (which is also implied by
@@ -939,8 +938,7 @@ static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
 	return pte;
 }
 
-vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct mem_cgroup *memcg,
-		struct page *page);
+vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct page *page);
 vm_fault_t finish_fault(struct vm_fault *vmf);
 vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf);
 #endif
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 40e7488ce467..4253c153e985 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -162,14 +162,13 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 	};
 	int err;
 	struct mmu_notifier_range range;
-	struct mem_cgroup *memcg;
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm, addr,
 				addr + PAGE_SIZE);
 
 	if (new_page) {
-		err = mem_cgroup_try_charge(new_page, vma->vm_mm, GFP_KERNEL,
-					    &memcg);
+		err = mem_cgroup_charge(new_page, vma->vm_mm, GFP_KERNEL,
+					false);
 		if (err)
 			return err;
 	}
@@ -179,17 +178,13 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 
 	mmu_notifier_invalidate_range_start(&range);
 	err = -EAGAIN;
-	if (!page_vma_mapped_walk(&pvmw)) {
-		if (new_page)
-			mem_cgroup_cancel_charge(new_page, memcg);
+	if (!page_vma_mapped_walk(&pvmw))
 		goto unlock;
-	}
 	VM_BUG_ON_PAGE(addr != pvmw.address, old_page);
 
 	if (new_page) {
 		get_page(new_page);
 		page_add_new_anon_rmap(new_page, vma, addr, false);
-		mem_cgroup_commit_charge(new_page, memcg, false);
 		lru_cache_add_active_or_unevictable(new_page, vma);
 	} else
 		/* no new page, just dec_mm_counter for old_page */
diff --git a/mm/filemap.c b/mm/filemap.c
index f4592ff3ca8b..a10bd6696049 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2633,7 +2633,7 @@ void filemap_map_pages(struct vm_fault *vmf,
 		if (vmf->pte)
 			vmf->pte += xas.xa_index - last_pgoff;
 		last_pgoff = xas.xa_index;
-		if (alloc_set_pte(vmf, NULL, page))
+		if (alloc_set_pte(vmf, page))
 			goto unlock;
 		unlock_page(page);
 		goto next;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index da6c413a75a5..0b33eaf0740a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -587,19 +587,19 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 			struct page *page, gfp_t gfp)
 {
 	struct vm_area_struct *vma = vmf->vma;
-	struct mem_cgroup *memcg;
 	pgtable_t pgtable;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
 	vm_fault_t ret = 0;
 
 	VM_BUG_ON_PAGE(!PageCompound(page), page);
 
-	if (mem_cgroup_try_charge_delay(page, vma->vm_mm, gfp, &memcg)) {
+	if (mem_cgroup_charge(page, vma->vm_mm, gfp, false)) {
 		put_page(page);
 		count_vm_event(THP_FAULT_FALLBACK);
 		count_vm_event(THP_FAULT_FALLBACK_CHARGE);
 		return VM_FAULT_FALLBACK;
 	}
+	cgroup_throttle_swaprate(page, gfp);
 
 	pgtable = pte_alloc_one(vma->vm_mm);
 	if (unlikely(!pgtable)) {
@@ -630,7 +630,6 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 			vm_fault_t ret2;
 
 			spin_unlock(vmf->ptl);
-			mem_cgroup_cancel_charge(page, memcg);
 			put_page(page);
 			pte_free(vma->vm_mm, pgtable);
 			ret2 = handle_userfault(vmf, VM_UFFD_MISSING);
@@ -641,7 +640,6 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 		entry = mk_huge_pmd(page, vma->vm_page_prot);
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
 		page_add_new_anon_rmap(page, vma, haddr, true);
-		mem_cgroup_commit_charge(page, memcg, false);
 		lru_cache_add_active_or_unevictable(page, vma);
 		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
 		set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
@@ -649,7 +647,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 		mm_inc_nr_ptes(vma->vm_mm);
 		spin_unlock(vmf->ptl);
 		count_vm_event(THP_FAULT_ALLOC);
-		count_memcg_events(memcg, THP_FAULT_ALLOC, 1);
+		count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
 	}
 
 	return 0;
@@ -658,7 +656,6 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 release:
 	if (pgtable)
 		pte_free(vma->vm_mm, pgtable);
-	mem_cgroup_cancel_charge(page, memcg);
 	put_page(page);
 	return ret;
 
@@ -1260,7 +1257,6 @@ static vm_fault_t do_huge_pmd_wp_page_fallback(struct vm_fault *vmf,
 {
 	struct vm_area_struct *vma = vmf->vma;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
-	struct mem_cgroup *memcg;
 	pgtable_t pgtable;
 	pmd_t _pmd;
 	int i;
@@ -1279,21 +1275,17 @@ static vm_fault_t do_huge_pmd_wp_page_fallback(struct vm_fault *vmf,
 		pages[i] = alloc_page_vma_node(GFP_HIGHUSER_MOVABLE, vma,
 					       vmf->address, page_to_nid(page));
 		if (unlikely(!pages[i] ||
-			     mem_cgroup_try_charge_delay(pages[i], vma->vm_mm,
-							 GFP_KERNEL, &memcg))) {
+			     mem_cgroup_charge(pages[i], vma->vm_mm,
+					       GFP_KERNEL, false))) {
 			if (pages[i])
 				put_page(pages[i]);
-			while (--i >= 0) {
-				memcg = (void *)page_private(pages[i]);
-				set_page_private(pages[i], 0);
-				mem_cgroup_cancel_charge(pages[i], memcg);
+			while (--i >= 0)
 				put_page(pages[i]);
-			}
 			kfree(pages);
 			ret |= VM_FAULT_OOM;
 			goto out;
 		}
-		set_page_private(pages[i], (unsigned long)memcg);
+		cgroup_throttle_swaprate(pages[i], GFP_KERNEL);
 	}
 
 	for (i = 0; i < HPAGE_PMD_NR; i++) {
@@ -1329,10 +1321,7 @@ static vm_fault_t do_huge_pmd_wp_page_fallback(struct vm_fault *vmf,
 		pte_t entry;
 		entry = mk_pte(pages[i], vma->vm_page_prot);
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
-		memcg = (void *)page_private(pages[i]);
-		set_page_private(pages[i], 0);
 		page_add_new_anon_rmap(pages[i], vmf->vma, haddr, false);
-		mem_cgroup_commit_charge(pages[i], memcg, false);
 		lru_cache_add_active_or_unevictable(pages[i], vma);
 		vmf->pte = pte_offset_map(&_pmd, haddr);
 		VM_BUG_ON(!pte_none(*vmf->pte));
@@ -1361,12 +1350,8 @@ static vm_fault_t do_huge_pmd_wp_page_fallback(struct vm_fault *vmf,
 out_free_pages:
 	spin_unlock(vmf->ptl);
 	mmu_notifier_invalidate_range_end(&range);
-	for (i = 0; i < HPAGE_PMD_NR; i++) {
-		memcg = (void *)page_private(pages[i]);
-		set_page_private(pages[i], 0);
-		mem_cgroup_cancel_charge(pages[i], memcg);
+	for (i = 0; i < HPAGE_PMD_NR; i++)
 		put_page(pages[i]);
-	}
 	kfree(pages);
 	goto out;
 }
@@ -1375,7 +1360,6 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct page *page = NULL, *new_page;
-	struct mem_cgroup *memcg;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
 	struct mmu_notifier_range range;
 	gfp_t huge_gfp;			/* for allocation and charge */
@@ -1446,8 +1430,8 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
 		goto out;
 	}
 
-	if (unlikely(mem_cgroup_try_charge_delay(new_page, vma->vm_mm,
-						 huge_gfp, &memcg))) {
+	if (unlikely(mem_cgroup_charge(new_page, vma->vm_mm, huge_gfp,
+				       false))) {
 		put_page(new_page);
 		split_huge_pmd(vma, vmf->pmd, vmf->address);
 		if (page)
@@ -1457,9 +1441,10 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
 		count_vm_event(THP_FAULT_FALLBACK_CHARGE);
 		goto out;
 	}
+	cgroup_throttle_swaprate(new_page, huge_gfp);
 
 	count_vm_event(THP_FAULT_ALLOC);
-	count_memcg_events(memcg, THP_FAULT_ALLOC, 1);
+	count_memcg_page_event(new_page, THP_FAULT_ALLOC);
 
 	if (!page)
 		clear_huge_page(new_page, vmf->address, HPAGE_PMD_NR);
@@ -1477,7 +1462,6 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
 		put_page(page);
 	if (unlikely(!pmd_same(*vmf->pmd, orig_pmd))) {
 		spin_unlock(vmf->ptl);
-		mem_cgroup_cancel_charge(new_page, memcg);
 		put_page(new_page);
 		goto out_mn;
 	} else {
@@ -1486,7 +1470,6 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
 		pmdp_huge_clear_flush_notify(vma, haddr, vmf->pmd);
 		page_add_new_anon_rmap(new_page, vma, haddr, true);
-		mem_cgroup_commit_charge(new_page, memcg, false);
 		lru_cache_add_active_or_unevictable(new_page, vma);
 		set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
 		update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index ee2ef4b8e828..5cf8082fb038 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -951,7 +951,6 @@ static void collapse_huge_page(struct mm_struct *mm,
 	struct page *new_page;
 	spinlock_t *pmd_ptl, *pte_ptl;
 	int isolated = 0, result = 0;
-	struct mem_cgroup *memcg;
 	struct vm_area_struct *vma;
 	struct mmu_notifier_range range;
 	gfp_t gfp;
@@ -974,15 +973,15 @@ static void collapse_huge_page(struct mm_struct *mm,
 		goto out_nolock;
 	}
 
-	if (unlikely(mem_cgroup_try_charge(new_page, mm, gfp, &memcg))) {
+	if (unlikely(mem_cgroup_charge(new_page, mm, gfp, false))) {
 		result = SCAN_CGROUP_CHARGE_FAIL;
 		goto out_nolock;
 	}
+	count_memcg_page_event(new_page, THP_COLLAPSE_ALLOC);
 
 	down_read(&mm->mmap_sem);
 	result = hugepage_vma_revalidate(mm, address, &vma);
 	if (result) {
-		mem_cgroup_cancel_charge(new_page, memcg);
 		up_read(&mm->mmap_sem);
 		goto out_nolock;
 	}
@@ -990,7 +989,6 @@ static void collapse_huge_page(struct mm_struct *mm,
 	pmd = mm_find_pmd(mm, address);
 	if (!pmd) {
 		result = SCAN_PMD_NULL;
-		mem_cgroup_cancel_charge(new_page, memcg);
 		up_read(&mm->mmap_sem);
 		goto out_nolock;
 	}
@@ -1001,7 +999,6 @@ static void collapse_huge_page(struct mm_struct *mm,
 	 * Continuing to collapse causes inconsistency.
 	 */
 	if (!__collapse_huge_page_swapin(mm, vma, address, pmd, referenced)) {
-		mem_cgroup_cancel_charge(new_page, memcg);
 		up_read(&mm->mmap_sem);
 		goto out_nolock;
 	}
@@ -1087,8 +1084,6 @@ static void collapse_huge_page(struct mm_struct *mm,
 	spin_lock(pmd_ptl);
 	BUG_ON(!pmd_none(*pmd));
 	page_add_new_anon_rmap(new_page, vma, address, true);
-	mem_cgroup_commit_charge(new_page, memcg, false);
-	count_memcg_events(memcg, THP_COLLAPSE_ALLOC, 1);
 	lru_cache_add_active_or_unevictable(new_page, vma);
 	pgtable_trans_huge_deposit(mm, pmd, pgtable);
 	set_pmd_at(mm, address, pmd, _pmd);
@@ -1105,7 +1100,6 @@ static void collapse_huge_page(struct mm_struct *mm,
 	trace_mm_collapse_huge_page(mm, isolated, result);
 	return;
 out:
-	mem_cgroup_cancel_charge(new_page, memcg);
 	goto out_up_write;
 }
 
@@ -1515,7 +1509,6 @@ static void collapse_file(struct mm_struct *mm,
 	struct address_space *mapping = file->f_mapping;
 	gfp_t gfp;
 	struct page *new_page;
-	struct mem_cgroup *memcg;
 	pgoff_t index, end = start + HPAGE_PMD_NR;
 	LIST_HEAD(pagelist);
 	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
@@ -1534,10 +1527,11 @@ static void collapse_file(struct mm_struct *mm,
 		goto out;
 	}
 
-	if (unlikely(mem_cgroup_try_charge(new_page, mm, gfp, &memcg))) {
+	if (unlikely(mem_cgroup_charge(new_page, mm, gfp, false))) {
 		result = SCAN_CGROUP_CHARGE_FAIL;
 		goto out;
 	}
+	count_memcg_page_event(new_page, THP_COLLAPSE_ALLOC);
 
 	/* This will be less messy when we use multi-index entries */
 	do {
@@ -1547,7 +1541,6 @@ static void collapse_file(struct mm_struct *mm,
 			break;
 		xas_unlock_irq(&xas);
 		if (!xas_nomem(&xas, GFP_KERNEL)) {
-			mem_cgroup_cancel_charge(new_page, memcg);
 			result = SCAN_FAIL;
 			goto out;
 		}
@@ -1740,18 +1733,9 @@ static void collapse_file(struct mm_struct *mm,
 	}
 
 	if (nr_none) {
-		struct lruvec *lruvec;
-		/*
-		 * XXX: We have started try_charge and pinned the
-		 * memcg, but the page isn't committed yet so we
-		 * cannot use mod_lruvec_page_state(). This hackery
-		 * will be cleaned up when remove the page->mapping
-		 * dependency from memcg and fully charge above.
-		 */
-		lruvec = mem_cgroup_lruvec(memcg, page_pgdat(new_page));
-		__mod_lruvec_state(lruvec, NR_FILE_PAGES, nr_none);
+		__mod_lruvec_page_state(new_page, NR_FILE_PAGES, nr_none);
 		if (is_shmem)
-			__mod_lruvec_state(lruvec, NR_SHMEM, nr_none);
+			__mod_lruvec_page_state(new_page, NR_SHMEM, nr_none);
 	}
 
 xa_locked:
@@ -1789,7 +1773,6 @@ static void collapse_file(struct mm_struct *mm,
 
 		SetPageUptodate(new_page);
 		page_ref_add(new_page, HPAGE_PMD_NR - 1);
-		mem_cgroup_commit_charge(new_page, memcg, false);
 
 		if (is_shmem) {
 			set_page_dirty(new_page);
@@ -1797,7 +1780,6 @@ static void collapse_file(struct mm_struct *mm,
 		} else {
 			lru_cache_add_file(new_page);
 		}
-		count_memcg_events(memcg, THP_COLLAPSE_ALLOC, 1);
 
 		/*
 		 * Remove pte page tables, so we can re-fault the page as huge.
@@ -1844,7 +1826,6 @@ static void collapse_file(struct mm_struct *mm,
 		VM_BUG_ON(nr_none);
 		xas_unlock_irq(&xas);
 
-		mem_cgroup_cancel_charge(new_page, memcg);
 		new_page->mapping = NULL;
 	}
 
diff --git a/mm/memory.c b/mm/memory.c
index 43a3345ecdf3..3fa379d9b17d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2647,7 +2647,6 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 	struct page *new_page = NULL;
 	pte_t entry;
 	int page_copied = 0;
-	struct mem_cgroup *memcg;
 	struct mmu_notifier_range range;
 
 	if (unlikely(anon_vma_prepare(vma)))
@@ -2678,8 +2677,9 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		}
 	}
 
-	if (mem_cgroup_try_charge_delay(new_page, mm, GFP_KERNEL, &memcg))
+	if (mem_cgroup_charge(new_page, mm, GFP_KERNEL, false))
 		goto oom_free_new;
+	cgroup_throttle_swaprate(new_page, GFP_KERNEL);
 
 	__SetPageUptodate(new_page);
 
@@ -2713,7 +2713,6 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		 */
 		ptep_clear_flush_notify(vma, vmf->address, vmf->pte);
 		page_add_new_anon_rmap(new_page, vma, vmf->address, false);
-		mem_cgroup_commit_charge(new_page, memcg, false);
 		lru_cache_add_active_or_unevictable(new_page, vma);
 		/*
 		 * We call the notify macro here because, when using secondary
@@ -2751,8 +2750,6 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		/* Free the old page.. */
 		new_page = old_page;
 		page_copied = 1;
-	} else {
-		mem_cgroup_cancel_charge(new_page, memcg);
 	}
 
 	if (new_page)
@@ -3090,7 +3087,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct page *page = NULL, *swapcache;
-	struct mem_cgroup *memcg;
 	swp_entry_t entry;
 	pte_t pte;
 	int locked;
@@ -3195,10 +3191,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		goto out_page;
 	}
 
-	if (mem_cgroup_try_charge_delay(page, vma->vm_mm, GFP_KERNEL, &memcg)) {
+	if (mem_cgroup_charge(page, vma->vm_mm, GFP_KERNEL, true)) {
 		ret = VM_FAULT_OOM;
 		goto out_page;
 	}
+	cgroup_throttle_swaprate(page, GFP_KERNEL);
 
 	/*
 	 * Back out if somebody else already faulted in this pte.
@@ -3246,11 +3243,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	/* ksm created a completely new copy */
 	if (unlikely(page != swapcache && swapcache)) {
 		page_add_new_anon_rmap(page, vma, vmf->address, false);
-		mem_cgroup_commit_charge(page, memcg, false);
 		lru_cache_add_active_or_unevictable(page, vma);
 	} else {
 		do_page_add_anon_rmap(page, vma, vmf->address, exclusive);
-		mem_cgroup_commit_charge(page, memcg, true);
 		activate_page(page);
 	}
 
@@ -3286,7 +3281,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 out:
 	return ret;
 out_nomap:
-	mem_cgroup_cancel_charge(page, memcg);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 out_page:
 	unlock_page(page);
@@ -3307,7 +3301,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
-	struct mem_cgroup *memcg;
 	struct page *page;
 	vm_fault_t ret = 0;
 	pte_t entry;
@@ -3360,8 +3353,9 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	if (!page)
 		goto oom;
 
-	if (mem_cgroup_try_charge_delay(page, vma->vm_mm, GFP_KERNEL, &memcg))
+	if (mem_cgroup_charge(page, vma->vm_mm, GFP_KERNEL, false))
 		goto oom_free_page;
+	cgroup_throttle_swaprate(page, GFP_KERNEL);
 
 	/*
 	 * The memory barrier inside __SetPageUptodate makes sure that
@@ -3386,14 +3380,12 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	/* Deliver the page fault to userland, check inside PT lock */
 	if (userfaultfd_missing(vma)) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
-		mem_cgroup_cancel_charge(page, memcg);
 		put_page(page);
 		return handle_userfault(vmf, VM_UFFD_MISSING);
 	}
 
 	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
 	page_add_new_anon_rmap(page, vma, vmf->address, false);
-	mem_cgroup_commit_charge(page, memcg, false);
 	lru_cache_add_active_or_unevictable(page, vma);
 setpte:
 	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
@@ -3404,7 +3396,6 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 	return ret;
 release:
-	mem_cgroup_cancel_charge(page, memcg);
 	put_page(page);
 	goto unlock;
 oom_free_page:
@@ -3609,7 +3600,6 @@ static vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
  * mapping. If needed, the fucntion allocates page table or use pre-allocated.
  *
  * @vmf: fault environment
- * @memcg: memcg to charge page (only for private mappings)
  * @page: page to map
  *
  * Caller must take care of unlocking vmf->ptl, if vmf->pte is non-NULL on
@@ -3620,8 +3610,7 @@ static vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
  *
  * Return: %0 on success, %VM_FAULT_ code in case of error.
  */
-vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct mem_cgroup *memcg,
-		struct page *page)
+vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct page *page)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
@@ -3629,9 +3618,6 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct mem_cgroup *memcg,
 	vm_fault_t ret;
 
 	if (pmd_none(*vmf->pmd) && PageTransCompound(page)) {
-		/* THP on COW? */
-		VM_BUG_ON_PAGE(memcg, page);
-
 		ret = do_set_pmd(vmf, page);
 		if (ret != VM_FAULT_FALLBACK)
 			return ret;
@@ -3655,7 +3641,6 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct mem_cgroup *memcg,
 	if (write && !(vma->vm_flags & VM_SHARED)) {
 		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
 		page_add_new_anon_rmap(page, vma, vmf->address, false);
-		mem_cgroup_commit_charge(page, memcg, false);
 		lru_cache_add_active_or_unevictable(page, vma);
 	} else {
 		inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page));
@@ -3704,7 +3689,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 	if (!(vmf->vma->vm_flags & VM_SHARED))
 		ret = check_stable_address_space(vmf->vma->vm_mm);
 	if (!ret)
-		ret = alloc_set_pte(vmf, vmf->memcg, page);
+		ret = alloc_set_pte(vmf, page);
 	if (vmf->pte)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 	return ret;
@@ -3864,11 +3849,11 @@ static vm_fault_t do_cow_fault(struct vm_fault *vmf)
 	if (!vmf->cow_page)
 		return VM_FAULT_OOM;
 
-	if (mem_cgroup_try_charge_delay(vmf->cow_page, vma->vm_mm,
-					GFP_KERNEL, &vmf->memcg)) {
+	if (mem_cgroup_charge(vmf->cow_page, vma->vm_mm, GFP_KERNEL, false)) {
 		put_page(vmf->cow_page);
 		return VM_FAULT_OOM;
 	}
+	cgroup_throttle_swaprate(vmf->cow_page, GFP_KERNEL);
 
 	ret = __do_fault(vmf);
 	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY)))
@@ -3886,7 +3871,6 @@ static vm_fault_t do_cow_fault(struct vm_fault *vmf)
 		goto uncharge_out;
 	return ret;
 uncharge_out:
-	mem_cgroup_cancel_charge(vmf->cow_page, vmf->memcg);
 	put_page(vmf->cow_page);
 	return ret;
 }
diff --git a/mm/migrate.c b/mm/migrate.c
index 14a584c52782..a3361c744069 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2746,7 +2746,6 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 {
 	struct vm_area_struct *vma = migrate->vma;
 	struct mm_struct *mm = vma->vm_mm;
-	struct mem_cgroup *memcg;
 	bool flush = false;
 	spinlock_t *ptl;
 	pte_t entry;
@@ -2793,7 +2792,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 
 	if (unlikely(anon_vma_prepare(vma)))
 		goto abort;
-	if (mem_cgroup_try_charge(page, vma->vm_mm, GFP_KERNEL, &memcg))
+	if (mem_cgroup_charge(page, vma->vm_mm, GFP_KERNEL, false))
 		goto abort;
 
 	/*
@@ -2839,7 +2838,6 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 
 	inc_mm_counter(mm, MM_ANONPAGES);
 	page_add_new_anon_rmap(page, vma, addr, false);
-	mem_cgroup_commit_charge(page, memcg, false);
 	if (!is_zone_device_page(page))
 		lru_cache_add_active_or_unevictable(page, vma);
 	get_page(page);
@@ -2861,7 +2859,6 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 
 unlock_abort:
 	pte_unmap_unlock(ptep, ptl);
-	mem_cgroup_cancel_charge(page, memcg);
 abort:
 	*src &= ~MIGRATE_PFN_MIGRATE;
 }
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 74543137371b..08140aed9258 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1854,7 +1854,6 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long addr, swp_entry_t entry, struct page *page)
 {
 	struct page *swapcache;
-	struct mem_cgroup *memcg;
 	spinlock_t *ptl;
 	pte_t *pte;
 	int ret = 1;
@@ -1864,14 +1863,13 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 	if (unlikely(!page))
 		return -ENOMEM;
 
-	if (mem_cgroup_try_charge(page, vma->vm_mm, GFP_KERNEL, &memcg)) {
+	if (mem_cgroup_charge(page, vma->vm_mm, GFP_KERNEL, true)) {
 		ret = -ENOMEM;
 		goto out_nolock;
 	}
 
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	if (unlikely(!pte_same_as_swp(*pte, swp_entry_to_pte(entry)))) {
-		mem_cgroup_cancel_charge(page, memcg);
 		ret = 0;
 		goto out;
 	}
@@ -1883,10 +1881,8 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 		   pte_mkold(mk_pte(page, vma->vm_page_prot)));
 	if (page == swapcache) {
 		page_add_anon_rmap(page, vma, addr, false);
-		mem_cgroup_commit_charge(page, memcg, true);
 	} else { /* ksm created a completely new copy */
 		page_add_new_anon_rmap(page, vma, addr, false);
-		mem_cgroup_commit_charge(page, memcg, false);
 		lru_cache_add_active_or_unevictable(page, vma);
 	}
 	swap_free(entry);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index bb57d0a3fca7..2745489415cc 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -56,7 +56,6 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 			    struct page **pagep,
 			    bool wp_copy)
 {
-	struct mem_cgroup *memcg;
 	pte_t _dst_pte, *dst_pte;
 	spinlock_t *ptl;
 	void *page_kaddr;
@@ -97,7 +96,7 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 	__SetPageUptodate(page);
 
 	ret = -ENOMEM;
-	if (mem_cgroup_try_charge(page, dst_mm, GFP_KERNEL, &memcg))
+	if (mem_cgroup_charge(page, dst_mm, GFP_KERNEL, false))
 		goto out_release;
 
 	_dst_pte = pte_mkdirty(mk_pte(page, dst_vma->vm_page_prot));
@@ -124,7 +123,6 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 
 	inc_mm_counter(dst_mm, MM_ANONPAGES);
 	page_add_new_anon_rmap(page, dst_vma, dst_addr, false);
-	mem_cgroup_commit_charge(page, memcg, false);
 	lru_cache_add_active_or_unevictable(page, dst_vma);
 
 	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
@@ -138,7 +136,6 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 	return ret;
 out_release_uncharge_unlock:
 	pte_unmap_unlock(dst_pte, ptl);
-	mem_cgroup_cancel_charge(page, memcg);
 out_release:
 	put_page(page);
 	goto out;
-- 
2.26.0


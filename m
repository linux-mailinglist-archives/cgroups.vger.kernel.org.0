Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69FE1B1912
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2020 00:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgDTWLt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Apr 2020 18:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbgDTWLr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Apr 2020 18:11:47 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95263C061A0E
        for <cgroups@vger.kernel.org>; Mon, 20 Apr 2020 15:11:46 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 20so12519439qkl.10
        for <cgroups@vger.kernel.org>; Mon, 20 Apr 2020 15:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N1Kt7GaRlBgHYvz2R3UkwCNM1QGleRb2TGFG0WxLepM=;
        b=CPRje4RJBLOamVWXXCqXUXfyin92EREviLN750PBgRHtGKOza8bRGBqp2Vdz/nQTS0
         Gbwpqh5sx3yH+DBu4aQauPGqdGZqI1ZD2alUSOZTG2htw01LmopDppXYr2NGh1YCE5Wi
         8Pg7AEjsdO0gl7vaEsrShEwhcYFhh9m3LuL+XfVtO5llSNGdgqMvAN11GE/tnejTdZPq
         HQyzHPH7c+fxlZfBIZ8itH4NKse4MsdTH3qQa0ZwE2XTOytRp2/43plqJqm8N2E4ftD6
         PNRIpOVQc14UAHpr+qdb5V1HnyvAmD+wMMxwnLYibZ4eFaMzhl4c/c25ozHQPwolc7UG
         NyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N1Kt7GaRlBgHYvz2R3UkwCNM1QGleRb2TGFG0WxLepM=;
        b=YXVm6AhewCtLuCmvLmyq0J7Sk6lfIGA/KwUW25S05RyvFvCDmnFVxUszYKspZet1PY
         V6jbTK4DooAr/9TX9u/THSNOWpd2JbsJMFbHlMy+MiDSk9ouPvNEtj7wQ9L7KQotRZj+
         yly9R2y8H7o8EpQoELWZuqorNI0trlLeCKdcfYndwRMN3W1uD3uu+BgaLtAZffTA0Zik
         oWeUisbVxLswB1sSkZBbzxoevNN/wPhLfW+5eXlVIkVms/R1U6X7bVBjCU6Zk/irrWd2
         ClrcIWjhQMX720nAq7mYZGIfTTWWLuB5gk5lmeWKRxnC/ZfTV4QU94V45k6Rt9SmHZu2
         q+Mg==
X-Gm-Message-State: AGi0PubAEfviI57hapMZ2A8gd1JzDQ+ObbDBpr3IL1h5+wi3fhfEPViU
        GF0dCaABGJPgOTnio9tU/YGMQA==
X-Google-Smtp-Source: APiQypLVqOqfY0AKlXLUV0hmw+mN4OhpkjFjzwzTmvXQOl/3vd7tew3e+XzCvtiLfv8h9y3/sOouzg==
X-Received: by 2002:a37:851:: with SMTP id 78mr18564874qki.352.1587420705249;
        Mon, 20 Apr 2020 15:11:45 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:e6b6])
        by smtp.gmail.com with ESMTPSA id 190sm610527qkl.46.2020.04.20.15.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 15:11:44 -0700 (PDT)
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
Subject: [PATCH 03/18] mm: memcontrol: drop @compound parameter from memcg charging API
Date:   Mon, 20 Apr 2020 18:11:11 -0400
Message-Id: <20200420221126.341272-4-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200420221126.341272-1-hannes@cmpxchg.org>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
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
---
 include/linux/memcontrol.h | 22 ++++++++--------------
 kernel/events/uprobes.c    |  6 +++---
 mm/filemap.c               |  6 +++---
 mm/huge_memory.c           | 23 +++++++++++------------
 mm/khugepaged.c            | 20 ++++++++++----------
 mm/memcontrol.c            | 38 +++++++++++++++-----------------------
 mm/memory.c                | 32 +++++++++++++++-----------------
 mm/migrate.c               |  6 +++---
 mm/shmem.c                 | 22 +++++++++-------------
 mm/swapfile.c              |  9 ++++-----
 mm/userfaultfd.c           |  6 +++---
 11 files changed, 84 insertions(+), 106 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 1b4150ff64be..c7875a48c8c1 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -361,15 +361,12 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 						struct mem_cgroup *memcg);
 
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
 
@@ -849,8 +846,7 @@ static inline enum mem_cgroup_protection mem_cgroup_protected(
 
 static inline int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
 					gfp_t gfp_mask,
-					struct mem_cgroup **memcgp,
-					bool compound)
+					struct mem_cgroup **memcgp)
 {
 	*memcgp = NULL;
 	return 0;
@@ -859,8 +855,7 @@ static inline int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
 static inline int mem_cgroup_try_charge_delay(struct page *page,
 					      struct mm_struct *mm,
 					      gfp_t gfp_mask,
-					      struct mem_cgroup **memcgp,
-					      bool compound)
+					      struct mem_cgroup **memcgp)
 {
 	*memcgp = NULL;
 	return 0;
@@ -868,13 +863,12 @@ static inline int mem_cgroup_try_charge_delay(struct page *page,
 
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
index 49e3b5da0216..5b31af9d5b1b 100644
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
index 6ecd1045113b..e9355a463e74 100644
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
 
@@ -1280,14 +1280,13 @@ static vm_fault_t do_huge_pmd_wp_page_fallback(struct vm_fault *vmf,
 					       vmf->address, page_to_nid(page));
 		if (unlikely(!pages[i] ||
 			     mem_cgroup_try_charge_delay(pages[i], vma->vm_mm,
-				     GFP_KERNEL, &memcg, false))) {
+							 GFP_KERNEL, &memcg))) {
 			if (pages[i])
 				put_page(pages[i]);
 			while (--i >= 0) {
 				memcg = (void *)page_private(pages[i]);
 				set_page_private(pages[i], 0);
-				mem_cgroup_cancel_charge(pages[i], memcg,
-						false);
+				mem_cgroup_cancel_charge(pages[i], memcg);
 				put_page(pages[i]);
 			}
 			kfree(pages);
@@ -1333,7 +1332,7 @@ static vm_fault_t do_huge_pmd_wp_page_fallback(struct vm_fault *vmf,
 		memcg = (void *)page_private(pages[i]);
 		set_page_private(pages[i], 0);
 		page_add_new_anon_rmap(pages[i], vmf->vma, haddr, false);
-		mem_cgroup_commit_charge(pages[i], memcg, false, false);
+		mem_cgroup_commit_charge(pages[i], memcg, false);
 		lru_cache_add_active_or_unevictable(pages[i], vma);
 		vmf->pte = pte_offset_map(&_pmd, haddr);
 		VM_BUG_ON(!pte_none(*vmf->pte));
@@ -1365,7 +1364,7 @@ static vm_fault_t do_huge_pmd_wp_page_fallback(struct vm_fault *vmf,
 	for (i = 0; i < HPAGE_PMD_NR; i++) {
 		memcg = (void *)page_private(pages[i]);
 		set_page_private(pages[i], 0);
-		mem_cgroup_cancel_charge(pages[i], memcg, false);
+		mem_cgroup_cancel_charge(pages[i], memcg);
 		put_page(pages[i]);
 	}
 	kfree(pages);
@@ -1448,7 +1447,7 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
 	}
 
 	if (unlikely(mem_cgroup_try_charge_delay(new_page, vma->vm_mm,
-					huge_gfp, &memcg, true))) {
+						 huge_gfp, &memcg))) {
 		put_page(new_page);
 		split_huge_pmd(vma, vmf->pmd, vmf->address);
 		if (page)
@@ -1478,7 +1477,7 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
 		put_page(page);
 	if (unlikely(!pmd_same(*vmf->pmd, orig_pmd))) {
 		spin_unlock(vmf->ptl);
-		mem_cgroup_cancel_charge(new_page, memcg, true);
+		mem_cgroup_cancel_charge(new_page, memcg);
 		put_page(new_page);
 		goto out_mn;
 	} else {
@@ -1487,7 +1486,7 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
 		pmdp_huge_clear_flush_notify(vma, haddr, vmf->pmd);
 		page_add_new_anon_rmap(new_page, vma, haddr, true);
-		mem_cgroup_commit_charge(new_page, memcg, false, true);
+		mem_cgroup_commit_charge(new_page, memcg, false);
 		lru_cache_add_active_or_unevictable(new_page, vma);
 		set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
 		update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 99d77ffb79c2..46f9b565e8d5 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -974,7 +974,7 @@ static void collapse_huge_page(struct mm_struct *mm,
 		goto out_nolock;
 	}
 
-	if (unlikely(mem_cgroup_try_charge(new_page, mm, gfp, &memcg, true))) {
+	if (unlikely(mem_cgroup_try_charge(new_page, mm, gfp, &memcg))) {
 		result = SCAN_CGROUP_CHARGE_FAIL;
 		goto out_nolock;
 	}
@@ -982,7 +982,7 @@ static void collapse_huge_page(struct mm_struct *mm,
 	down_read(&mm->mmap_sem);
 	result = hugepage_vma_revalidate(mm, address, &vma);
 	if (result) {
-		mem_cgroup_cancel_charge(new_page, memcg, true);
+		mem_cgroup_cancel_charge(new_page, memcg);
 		up_read(&mm->mmap_sem);
 		goto out_nolock;
 	}
@@ -990,7 +990,7 @@ static void collapse_huge_page(struct mm_struct *mm,
 	pmd = mm_find_pmd(mm, address);
 	if (!pmd) {
 		result = SCAN_PMD_NULL;
-		mem_cgroup_cancel_charge(new_page, memcg, true);
+		mem_cgroup_cancel_charge(new_page, memcg);
 		up_read(&mm->mmap_sem);
 		goto out_nolock;
 	}
@@ -1001,7 +1001,7 @@ static void collapse_huge_page(struct mm_struct *mm,
 	 * Continuing to collapse causes inconsistency.
 	 */
 	if (!__collapse_huge_page_swapin(mm, vma, address, pmd, referenced)) {
-		mem_cgroup_cancel_charge(new_page, memcg, true);
+		mem_cgroup_cancel_charge(new_page, memcg);
 		up_read(&mm->mmap_sem);
 		goto out_nolock;
 	}
@@ -1087,7 +1087,7 @@ static void collapse_huge_page(struct mm_struct *mm,
 	spin_lock(pmd_ptl);
 	BUG_ON(!pmd_none(*pmd));
 	page_add_new_anon_rmap(new_page, vma, address, true);
-	mem_cgroup_commit_charge(new_page, memcg, false, true);
+	mem_cgroup_commit_charge(new_page, memcg, false);
 	count_memcg_events(memcg, THP_COLLAPSE_ALLOC, 1);
 	lru_cache_add_active_or_unevictable(new_page, vma);
 	pgtable_trans_huge_deposit(mm, pmd, pgtable);
@@ -1105,7 +1105,7 @@ static void collapse_huge_page(struct mm_struct *mm,
 	trace_mm_collapse_huge_page(mm, isolated, result);
 	return;
 out:
-	mem_cgroup_cancel_charge(new_page, memcg, true);
+	mem_cgroup_cancel_charge(new_page, memcg);
 	goto out_up_write;
 }
 
@@ -1534,7 +1534,7 @@ static void collapse_file(struct mm_struct *mm,
 		goto out;
 	}
 
-	if (unlikely(mem_cgroup_try_charge(new_page, mm, gfp, &memcg, true))) {
+	if (unlikely(mem_cgroup_try_charge(new_page, mm, gfp, &memcg))) {
 		result = SCAN_CGROUP_CHARGE_FAIL;
 		goto out;
 	}
@@ -1547,7 +1547,7 @@ static void collapse_file(struct mm_struct *mm,
 			break;
 		xas_unlock_irq(&xas);
 		if (!xas_nomem(&xas, GFP_KERNEL)) {
-			mem_cgroup_cancel_charge(new_page, memcg, true);
+			mem_cgroup_cancel_charge(new_page, memcg);
 			result = SCAN_FAIL;
 			goto out;
 		}
@@ -1783,7 +1783,7 @@ static void collapse_file(struct mm_struct *mm,
 
 		SetPageUptodate(new_page);
 		page_ref_add(new_page, HPAGE_PMD_NR - 1);
-		mem_cgroup_commit_charge(new_page, memcg, false, true);
+		mem_cgroup_commit_charge(new_page, memcg, false);
 
 		if (is_shmem) {
 			set_page_dirty(new_page);
@@ -1838,7 +1838,7 @@ static void collapse_file(struct mm_struct *mm,
 		VM_BUG_ON(nr_none);
 		xas_unlock_irq(&xas);
 
-		mem_cgroup_cancel_charge(new_page, memcg, true);
+		mem_cgroup_cancel_charge(new_page, memcg);
 		new_page->mapping = NULL;
 	}
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 41f5ed79272e..5ed8f6651383 100644
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
@@ -5441,9 +5441,9 @@ static int mem_cgroup_move_account(struct page *page,
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
@@ -6434,7 +6434,6 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
  * @mm: mm context of the victim
  * @gfp_mask: reclaim mode
  * @memcgp: charged memcg return
- * @compound: charge the page as compound or small page
  *
  * Try to charge @page to the memcg that @mm belongs to, reclaiming
  * pages according to @gfp_mask if necessary.
@@ -6447,11 +6446,10 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
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
@@ -6493,13 +6491,12 @@ int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
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
@@ -6510,7 +6507,6 @@ int mem_cgroup_try_charge_delay(struct page *page, struct mm_struct *mm,
  * @page: page to charge
  * @memcg: memcg to charge the page to
  * @lrucare: page might be on LRU already
- * @compound: charge the page as compound or small page
  *
  * Finalize a charge transaction started by mem_cgroup_try_charge(),
  * after page->mapping has been set up.  This must happen atomically
@@ -6523,9 +6519,9 @@ int mem_cgroup_try_charge_delay(struct page *page, struct mm_struct *mm,
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
@@ -6543,7 +6539,7 @@ void mem_cgroup_commit_charge(struct page *page, struct mem_cgroup *memcg,
 	commit_charge(page, memcg, lrucare);
 
 	local_irq_disable();
-	mem_cgroup_charge_statistics(memcg, page, compound, nr_pages);
+	mem_cgroup_charge_statistics(memcg, page, nr_pages);
 	memcg_check_events(memcg, page);
 	local_irq_enable();
 
@@ -6562,14 +6558,12 @@ void mem_cgroup_commit_charge(struct page *page, struct mem_cgroup *memcg,
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
@@ -6784,8 +6778,7 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 	commit_charge(newpage, memcg, false);
 
 	local_irq_save(flags);
-	mem_cgroup_charge_statistics(memcg, newpage, PageTransHuge(newpage),
-			nr_pages);
+	mem_cgroup_charge_statistics(memcg, newpage, nr_pages);
 	memcg_check_events(memcg, newpage);
 	local_irq_restore(flags);
 }
@@ -7015,8 +7008,7 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 	 * only synchronisation we have for updating the per-CPU variables.
 	 */
 	VM_BUG_ON(!irqs_disabled());
-	mem_cgroup_charge_statistics(memcg, page, PageTransHuge(page),
-				     -nr_entries);
+	mem_cgroup_charge_statistics(memcg, page, -nr_entries);
 	memcg_check_events(memcg, page);
 
 	if (!mem_cgroup_is_root(memcg))
diff --git a/mm/memory.c b/mm/memory.c
index f703fe8c8346..43a3345ecdf3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2678,7 +2678,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		}
 	}
 
-	if (mem_cgroup_try_charge_delay(new_page, mm, GFP_KERNEL, &memcg, false))
+	if (mem_cgroup_try_charge_delay(new_page, mm, GFP_KERNEL, &memcg))
 		goto oom_free_new;
 
 	__SetPageUptodate(new_page);
@@ -2713,7 +2713,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		 */
 		ptep_clear_flush_notify(vma, vmf->address, vmf->pte);
 		page_add_new_anon_rmap(new_page, vma, vmf->address, false);
-		mem_cgroup_commit_charge(new_page, memcg, false, false);
+		mem_cgroup_commit_charge(new_page, memcg, false);
 		lru_cache_add_active_or_unevictable(new_page, vma);
 		/*
 		 * We call the notify macro here because, when using secondary
@@ -2752,7 +2752,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		new_page = old_page;
 		page_copied = 1;
 	} else {
-		mem_cgroup_cancel_charge(new_page, memcg, false);
+		mem_cgroup_cancel_charge(new_page, memcg);
 	}
 
 	if (new_page)
@@ -3195,8 +3195,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		goto out_page;
 	}
 
-	if (mem_cgroup_try_charge_delay(page, vma->vm_mm, GFP_KERNEL,
-					&memcg, false)) {
+	if (mem_cgroup_try_charge_delay(page, vma->vm_mm, GFP_KERNEL, &memcg)) {
 		ret = VM_FAULT_OOM;
 		goto out_page;
 	}
@@ -3247,11 +3246,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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
 
@@ -3287,7 +3286,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 out:
 	return ret;
 out_nomap:
-	mem_cgroup_cancel_charge(page, memcg, false);
+	mem_cgroup_cancel_charge(page, memcg);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 out_page:
 	unlock_page(page);
@@ -3361,8 +3360,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	if (!page)
 		goto oom;
 
-	if (mem_cgroup_try_charge_delay(page, vma->vm_mm, GFP_KERNEL, &memcg,
-					false))
+	if (mem_cgroup_try_charge_delay(page, vma->vm_mm, GFP_KERNEL, &memcg))
 		goto oom_free_page;
 
 	/*
@@ -3388,14 +3386,14 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
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
@@ -3406,7 +3404,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 	return ret;
 release:
-	mem_cgroup_cancel_charge(page, memcg, false);
+	mem_cgroup_cancel_charge(page, memcg);
 	put_page(page);
 	goto unlock;
 oom_free_page:
@@ -3657,7 +3655,7 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct mem_cgroup *memcg,
 	if (write && !(vma->vm_flags & VM_SHARED)) {
 		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
 		page_add_new_anon_rmap(page, vma, vmf->address, false);
-		mem_cgroup_commit_charge(page, memcg, false, false);
+		mem_cgroup_commit_charge(page, memcg, false);
 		lru_cache_add_active_or_unevictable(page, vma);
 	} else {
 		inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page));
@@ -3866,8 +3864,8 @@ static vm_fault_t do_cow_fault(struct vm_fault *vmf)
 	if (!vmf->cow_page)
 		return VM_FAULT_OOM;
 
-	if (mem_cgroup_try_charge_delay(vmf->cow_page, vma->vm_mm, GFP_KERNEL,
-				&vmf->memcg, false)) {
+	if (mem_cgroup_try_charge_delay(vmf->cow_page, vma->vm_mm,
+					GFP_KERNEL, &vmf->memcg)) {
 		put_page(vmf->cow_page);
 		return VM_FAULT_OOM;
 	}
@@ -3888,7 +3886,7 @@ static vm_fault_t do_cow_fault(struct vm_fault *vmf)
 		goto uncharge_out;
 	return ret;
 uncharge_out:
-	mem_cgroup_cancel_charge(vmf->cow_page, vmf->memcg, false);
+	mem_cgroup_cancel_charge(vmf->cow_page, vmf->memcg);
 	put_page(vmf->cow_page);
 	return ret;
 }
diff --git a/mm/migrate.c b/mm/migrate.c
index 7160c1556f79..5dd50128568c 100644
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
index d722eb830317..52c66801321e 100644
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
@@ -2361,7 +2357,7 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 	if (unlikely(offset >= max_off))
 		goto out_release;
 
-	ret = mem_cgroup_try_charge_delay(page, dst_mm, gfp, &memcg, false);
+	ret = mem_cgroup_try_charge_delay(page, dst_mm, gfp, &memcg);
 	if (ret)
 		goto out_release;
 
@@ -2370,7 +2366,7 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 	if (ret)
 		goto out_release_uncharge;
 
-	mem_cgroup_commit_charge(page, memcg, false, false);
+	mem_cgroup_commit_charge(page, memcg, false);
 
 	_dst_pte = mk_pte(page, dst_vma->vm_page_prot);
 	if (dst_vma->vm_flags & VM_WRITE)
@@ -2421,7 +2417,7 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 	ClearPageDirty(page);
 	delete_from_page_cache(page);
 out_release_uncharge:
-	mem_cgroup_cancel_charge(page, memcg, false);
+	mem_cgroup_cancel_charge(page, memcg);
 out_release:
 	unlock_page(page);
 	put_page(page);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 5871a2aa86a5..9c9ab44780ba 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1864,15 +1864,14 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
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
@@ -1884,10 +1883,10 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
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
2.26.0


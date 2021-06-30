Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC5A3B7C63
	for <lists+cgroups@lfdr.de>; Wed, 30 Jun 2021 06:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhF3EJU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Jun 2021 00:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhF3EJS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Jun 2021 00:09:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78294C061760
        for <cgroups@vger.kernel.org>; Tue, 29 Jun 2021 21:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=BxzDO/vdys0RWGOPT4+6zHhBViUDbOJIbJsHaZ/Vz+o=; b=XRv2ogDboZtaaWFkyoPr3thfFu
        depMYF97pvL/PLOTumReG7m77y6YZiBR9m6wPSu8rGvCvIcFoYxr1koJY3JNg4xdg2G95gdpZ4wY/
        mLddnZNYsE/uVAk0AJFr3tGdQihDF6Rwv8o5Aex42jx3kFvSCREbDwdHO3T+hepNPaSqeQpa2+87K
        Eo4IXIV9dzu7i+8m2YPrQZuh8KH72dNtb9OHkG6Z1y7woy5kWt3T83yAG1my5iMyLd0VBxEGXDmI5
        ipGOFFRuVlM2BsDMBulwvphlU/Ti4s9O3eKB6BL1OcpDE5hiSblEWL9k2DGptx53qHiLuhF2EET8Q
        IT5XVHlg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyRTm-004r6q-K7; Wed, 30 Jun 2021 04:05:50 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: [PATCH v3 08/18] mm/memcg: Convert mem_cgroup_charge() to take a folio
Date:   Wed, 30 Jun 2021 05:00:24 +0100
Message-Id: <20210630040034.1155892-9-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210630040034.1155892-1-willy@infradead.org>
References: <20210630040034.1155892-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Convert all callers of mem_cgroup_charge() to call page_folio() on the
page they're currently passing in.  Many of them will be converted to
use folios themselves soon.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/memcontrol.h |  6 +++---
 kernel/events/uprobes.c    |  3 ++-
 mm/filemap.c               |  2 +-
 mm/huge_memory.c           |  2 +-
 mm/khugepaged.c            |  4 ++--
 mm/ksm.c                   |  3 ++-
 mm/memcontrol.c            | 26 +++++++++++++-------------
 mm/memory.c                |  9 +++++----
 mm/migrate.c               |  2 +-
 mm/shmem.c                 |  2 +-
 mm/userfaultfd.c           |  2 +-
 11 files changed, 32 insertions(+), 29 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 92689fb2dab4..90d48b0e3191 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -705,7 +705,7 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
 		page_counter_read(&memcg->memory);
 }
 
-int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask);
+int mem_cgroup_charge(struct folio *, struct mm_struct *, gfp_t);
 int mem_cgroup_swapin_charge_page(struct page *page, struct mm_struct *mm,
 				  gfp_t gfp, swp_entry_t entry);
 void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry);
@@ -1186,8 +1186,8 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
 	return false;
 }
 
-static inline int mem_cgroup_charge(struct page *page, struct mm_struct *mm,
-				    gfp_t gfp_mask)
+static inline int mem_cgroup_charge(struct folio *folio,
+		struct mm_struct *mm, gfp_t gfp)
 {
 	return 0;
 }
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index af24dc3febbe..6357c3580d07 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -167,7 +167,8 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 				addr + PAGE_SIZE);
 
 	if (new_page) {
-		err = mem_cgroup_charge(new_page, vma->vm_mm, GFP_KERNEL);
+		err = mem_cgroup_charge(page_folio(new_page), vma->vm_mm,
+					GFP_KERNEL);
 		if (err)
 			return err;
 	}
diff --git a/mm/filemap.c b/mm/filemap.c
index 3fb48130f980..9600bca84162 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -872,7 +872,7 @@ noinline int __add_to_page_cache_locked(struct page *page,
 	page->index = offset;
 
 	if (!huge) {
-		error = mem_cgroup_charge(page, NULL, gfp);
+		error = mem_cgroup_charge(page_folio(page), NULL, gfp);
 		if (error)
 			goto error;
 		charged = true;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 6d2a0119fc58..662f92bb1953 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -594,7 +594,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 
 	VM_BUG_ON_PAGE(!PageCompound(page), page);
 
-	if (mem_cgroup_charge(page, vma->vm_mm, gfp)) {
+	if (mem_cgroup_charge(page_folio(page), vma->vm_mm, gfp)) {
 		put_page(page);
 		count_vm_event(THP_FAULT_FALLBACK);
 		count_vm_event(THP_FAULT_FALLBACK_CHARGE);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 6c0185fdd815..0daa21fbdd71 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1088,7 +1088,7 @@ static void collapse_huge_page(struct mm_struct *mm,
 		goto out_nolock;
 	}
 
-	if (unlikely(mem_cgroup_charge(new_page, mm, gfp))) {
+	if (unlikely(mem_cgroup_charge(page_folio(new_page), mm, gfp))) {
 		result = SCAN_CGROUP_CHARGE_FAIL;
 		goto out_nolock;
 	}
@@ -1659,7 +1659,7 @@ static void collapse_file(struct mm_struct *mm,
 		goto out;
 	}
 
-	if (unlikely(mem_cgroup_charge(new_page, mm, gfp))) {
+	if (unlikely(mem_cgroup_charge(page_folio(new_page), mm, gfp))) {
 		result = SCAN_CGROUP_CHARGE_FAIL;
 		goto out;
 	}
diff --git a/mm/ksm.c b/mm/ksm.c
index 3fa9bc8a67cf..23d36b59f997 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2580,7 +2580,8 @@ struct page *ksm_might_need_to_copy(struct page *page,
 		return page;		/* let do_swap_page report the error */
 
 	new_page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma, address);
-	if (new_page && mem_cgroup_charge(new_page, vma->vm_mm, GFP_KERNEL)) {
+	if (new_page &&
+	    mem_cgroup_charge(page_folio(new_page), vma->vm_mm, GFP_KERNEL)) {
 		put_page(new_page);
 		new_page = NULL;
 	}
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 727bd578ca7d..1dc02ecd3257 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6676,10 +6676,9 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 			atomic_long_read(&parent->memory.children_low_usage)));
 }
 
-static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
+static int __mem_cgroup_charge(struct folio *folio, struct mem_cgroup *memcg,
 			       gfp_t gfp)
 {
-	struct folio *folio = page_folio(page);
 	unsigned int nr_pages = folio_nr_pages(folio);
 	int ret;
 
@@ -6692,27 +6691,27 @@ static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
 
 	local_irq_disable();
 	mem_cgroup_charge_statistics(memcg, nr_pages);
-	memcg_check_events(memcg, page_to_nid(page));
+	memcg_check_events(memcg, folio_nid(folio));
 	local_irq_enable();
 out:
 	return ret;
 }
 
 /**
- * mem_cgroup_charge - charge a newly allocated page to a cgroup
- * @page: page to charge
- * @mm: mm context of the victim
- * @gfp_mask: reclaim mode
+ * mem_cgroup_charge - Charge a newly allocated folio to a cgroup.
+ * @folio: Folio to charge.
+ * @mm: mm context of the allocating task.
+ * @gfp: reclaim mode
  *
- * Try to charge @page to the memcg that @mm belongs to, reclaiming
- * pages according to @gfp_mask if necessary. if @mm is NULL, try to
+ * Try to charge @folio to the memcg that @mm belongs to, reclaiming
+ * pages according to @gfp if necessary.  If @mm is NULL, try to
  * charge to the active memcg.
  *
- * Do not use this for pages allocated for swapin.
+ * Do not use this for folios allocated for swapin.
  *
  * Returns 0 on success. Otherwise, an error code is returned.
  */
-int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
+int mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp)
 {
 	struct mem_cgroup *memcg;
 	int ret;
@@ -6721,7 +6720,7 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
 		return 0;
 
 	memcg = get_mem_cgroup_from_mm(mm);
-	ret = __mem_cgroup_charge(page, memcg, gfp_mask);
+	ret = __mem_cgroup_charge(folio, memcg, gfp);
 	css_put(&memcg->css);
 
 	return ret;
@@ -6742,6 +6741,7 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
 int mem_cgroup_swapin_charge_page(struct page *page, struct mm_struct *mm,
 				  gfp_t gfp, swp_entry_t entry)
 {
+	struct folio *folio = page_folio(page);
 	struct mem_cgroup *memcg;
 	unsigned short id;
 	int ret;
@@ -6756,7 +6756,7 @@ int mem_cgroup_swapin_charge_page(struct page *page, struct mm_struct *mm,
 		memcg = get_mem_cgroup_from_mm(mm);
 	rcu_read_unlock();
 
-	ret = __mem_cgroup_charge(page, memcg, gfp);
+	ret = __mem_cgroup_charge(folio, memcg, gfp);
 
 	css_put(&memcg->css);
 	return ret;
diff --git a/mm/memory.c b/mm/memory.c
index afff080caf8b..2e7a568e2c15 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -915,7 +915,7 @@ page_copy_prealloc(struct mm_struct *src_mm, struct vm_area_struct *vma,
 	if (!new_page)
 		return NULL;
 
-	if (mem_cgroup_charge(new_page, src_mm, GFP_KERNEL)) {
+	if (mem_cgroup_charge(page_folio(new_page), src_mm, GFP_KERNEL)) {
 		put_page(new_page);
 		return NULL;
 	}
@@ -2922,7 +2922,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		}
 	}
 
-	if (mem_cgroup_charge(new_page, mm, GFP_KERNEL))
+	if (mem_cgroup_charge(page_folio(new_page), mm, GFP_KERNEL))
 		goto oom_free_new;
 	cgroup_throttle_swaprate(new_page, GFP_KERNEL);
 
@@ -3640,7 +3640,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	if (!page)
 		goto oom;
 
-	if (mem_cgroup_charge(page, vma->vm_mm, GFP_KERNEL))
+	if (mem_cgroup_charge(page_folio(page), vma->vm_mm, GFP_KERNEL))
 		goto oom_free_page;
 	cgroup_throttle_swaprate(page, GFP_KERNEL);
 
@@ -4053,7 +4053,8 @@ static vm_fault_t do_cow_fault(struct vm_fault *vmf)
 	if (!vmf->cow_page)
 		return VM_FAULT_OOM;
 
-	if (mem_cgroup_charge(vmf->cow_page, vma->vm_mm, GFP_KERNEL)) {
+	if (mem_cgroup_charge(page_folio(vmf->cow_page), vma->vm_mm,
+				GFP_KERNEL)) {
 		put_page(vmf->cow_page);
 		return VM_FAULT_OOM;
 	}
diff --git a/mm/migrate.c b/mm/migrate.c
index 380ca57b9031..94efe09bb2a0 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2914,7 +2914,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 
 	if (unlikely(anon_vma_prepare(vma)))
 		goto abort;
-	if (mem_cgroup_charge(page, vma->vm_mm, GFP_KERNEL))
+	if (mem_cgroup_charge(page_folio(page), vma->vm_mm, GFP_KERNEL))
 		goto abort;
 
 	/*
diff --git a/mm/shmem.c b/mm/shmem.c
index 6268b9b4e41a..3cc5ddd5cc6b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -685,7 +685,7 @@ static int shmem_add_to_page_cache(struct page *page,
 	page->index = index;
 
 	if (!PageSwapCache(page)) {
-		error = mem_cgroup_charge(page, charge_mm, gfp);
+		error = mem_cgroup_charge(page_folio(page), charge_mm, gfp);
 		if (error) {
 			if (PageTransHuge(page)) {
 				count_vm_event(THP_FILE_FALLBACK);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 63a73e164d55..bc8a2c3e5aea 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -96,7 +96,7 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 	__SetPageUptodate(page);
 
 	ret = -ENOMEM;
-	if (mem_cgroup_charge(page, dst_mm, GFP_KERNEL))
+	if (mem_cgroup_charge(page_folio(page), dst_mm, GFP_KERNEL))
 		goto out_release;
 
 	_dst_pte = pte_mkdirty(mk_pte(page, dst_vma->vm_page_prot));
-- 
2.30.2


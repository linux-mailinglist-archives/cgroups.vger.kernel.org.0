Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343E91CB757
	for <lists+cgroups@lfdr.de>; Fri,  8 May 2020 20:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgEHSdK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 May 2020 14:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727980AbgEHSce (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 May 2020 14:32:34 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71E7C05BD43
        for <cgroups@vger.kernel.org>; Fri,  8 May 2020 11:32:34 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id k81so2647334qke.5
        for <cgroups@vger.kernel.org>; Fri, 08 May 2020 11:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LIYh8wCoO3ncJ1D0s45AEXYMs5PqKu9avSmsgq+sM2s=;
        b=XBN6sfz1JeWwuRl/YJVh02uYqQ1Z27yY1Lk21geT8vcVCyF4fugi2XhmmA1sUp/krz
         QuW2ZTO9g9d5UPlLV4U2EB400clWtWtPRe1YsZcvGH5yYuhxur9lHk0K5u6ql7vwaU/t
         +FYfraX1XsMladoYLhH8xB8mu5AhjHViVZMWNt2Q08Q8v3GBIn6Itb82B6B6JbzeZANl
         FOS2WUGC82paWUGOEBNQU6pi8+GXnES1wUIsxxn79xeRbLXVXpql/2qRUqQ/154JQBTj
         AFXKHvfmHF85klZagKYQ6gcK67P3zVbTaYY1i4o/IvVI+5tlWwLTW5i4CSpGibMLyAKI
         hOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LIYh8wCoO3ncJ1D0s45AEXYMs5PqKu9avSmsgq+sM2s=;
        b=nURNQ6p6Wx6ZBBZvXNPY8rr7x5mh0/lyuTIyTB3sWdrsp1TRuaS3vz7TKMuc4ZpTq3
         zwK/dmdqlijmPvFJ5jaM6ioVox8NO84hecuHHmeeSUl77ckYm61de+8jZVufkEKBsI28
         An68ym7YYTtIiQhYBAkwg1Acl60MlyadOjgr79TAaVD6XdtpFaYmEmmUk2hk9L19pgaW
         PUHNAhRC/LfI5FnKE4B0i0QS3+StNVImhsvOvjvNIEqkOTnG8HmesZ51Jv593If1wRH6
         8pI1eMvnFleqwpOg6IwvzcMajP+8hPhTdzneGHqPETw0Iwy0CuJf2Klw6CGA2SL5qmgf
         Mvyg==
X-Gm-Message-State: AGi0PuYd7zfLk9HoWxl0k7EgZdti+3pmp+7VHnR6RId9iddZFarV/RSu
        opeRFXCAfY3f7m//N3SBAfxyEg==
X-Google-Smtp-Source: APiQypJ2dq4D2Q8qYTIM5CI3D2Dt8AuQ54e2ePTq3BHc9vySM/AKJUkRL5X5ubsXpGXuLWKAHYlbgg==
X-Received: by 2002:a05:620a:1184:: with SMTP id b4mr4024803qkk.364.1588962753591;
        Fri, 08 May 2020 11:32:33 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2627])
        by smtp.gmail.com with ESMTPSA id m33sm666084qtb.88.2020.05.08.11.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 11:32:32 -0700 (PDT)
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
Subject: [PATCH 12/19] mm: memcontrol: convert anon and file-thp to new mem_cgroup_charge() API
Date:   Fri,  8 May 2020 14:30:59 -0400
Message-Id: <20200508183105.225460-13-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508183105.225460-1-hannes@cmpxchg.org>
References: <20200508183105.225460-1-hannes@cmpxchg.org>
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

v2: prevent double charges on pre-allocated hugepages in khugepaged

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/mm.h      |  4 +---
 kernel/events/uprobes.c | 11 +++--------
 mm/filemap.c            |  2 +-
 mm/huge_memory.c        |  9 +++------
 mm/khugepaged.c         | 35 ++++++++++-------------------------
 mm/memory.c             | 36 ++++++++++--------------------------
 mm/migrate.c            |  5 +----
 mm/swapfile.c           |  6 +-----
 mm/userfaultfd.c        |  5 +----
 9 files changed, 31 insertions(+), 82 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index bb8d3716bfe4..87a2c2b66d05 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -501,7 +501,6 @@ struct vm_fault {
 	pte_t orig_pte;			/* Value of PTE at the time of fault */
 
 	struct page *cow_page;		/* Page handler may use for COW fault */
-	struct mem_cgroup *memcg;	/* Cgroup cow_page belongs to */
 	struct page *page;		/* ->fault handlers should return a
 					 * page here, unless VM_FAULT_NOPAGE
 					 * is set (which is also implied by
@@ -935,8 +934,7 @@ static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
 	return pte;
 }
 
-vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct mem_cgroup *memcg,
-		struct page *page);
+vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct page *page);
 vm_fault_t finish_fault(struct vm_fault *vmf);
 vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf);
 #endif
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 89ef81b65bcb..4253c153e985 100644
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
@@ -179,16 +178,12 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 
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
-		mem_cgroup_commit_charge(new_page, memcg, false);
 		page_add_new_anon_rmap(new_page, vma, addr, false);
 		lru_cache_add_active_or_unevictable(new_page, vma);
 	} else
diff --git a/mm/filemap.c b/mm/filemap.c
index d5b6e3d7d402..fa47f160e1cc 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2638,7 +2638,7 @@ void filemap_map_pages(struct vm_fault *vmf,
 		if (vmf->pte)
 			vmf->pte += xas.xa_index - last_pgoff;
 		last_pgoff = xas.xa_index;
-		if (alloc_set_pte(vmf, NULL, page))
+		if (alloc_set_pte(vmf, page))
 			goto unlock;
 		unlock_page(page);
 		goto next;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 74f8b4013203..d0f1e8cee93c 100644
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
@@ -640,7 +639,6 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 
 		entry = mk_huge_pmd(page, vma->vm_page_prot);
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
-		mem_cgroup_commit_charge(page, memcg, false);
 		page_add_new_anon_rmap(page, vma, haddr, true);
 		lru_cache_add_active_or_unevictable(page, vma);
 		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
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
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index be67ebe8a120..34731e7c9a67 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1044,7 +1044,6 @@ static void collapse_huge_page(struct mm_struct *mm,
 	struct page *new_page;
 	spinlock_t *pmd_ptl, *pte_ptl;
 	int isolated = 0, result = 0;
-	struct mem_cgroup *memcg;
 	struct vm_area_struct *vma;
 	struct mmu_notifier_range range;
 	gfp_t gfp;
@@ -1067,15 +1066,15 @@ static void collapse_huge_page(struct mm_struct *mm,
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
@@ -1083,7 +1082,6 @@ static void collapse_huge_page(struct mm_struct *mm,
 	pmd = mm_find_pmd(mm, address);
 	if (!pmd) {
 		result = SCAN_PMD_NULL;
-		mem_cgroup_cancel_charge(new_page, memcg);
 		up_read(&mm->mmap_sem);
 		goto out_nolock;
 	}
@@ -1095,7 +1093,6 @@ static void collapse_huge_page(struct mm_struct *mm,
 	 */
 	if (unmapped && !__collapse_huge_page_swapin(mm, vma, address,
 				pmd, referenced)) {
-		mem_cgroup_cancel_charge(new_page, memcg);
 		up_read(&mm->mmap_sem);
 		goto out_nolock;
 	}
@@ -1182,9 +1179,7 @@ static void collapse_huge_page(struct mm_struct *mm,
 
 	spin_lock(pmd_ptl);
 	BUG_ON(!pmd_none(*pmd));
-	mem_cgroup_commit_charge(new_page, memcg, false);
 	page_add_new_anon_rmap(new_page, vma, address, true);
-	count_memcg_events(memcg, THP_COLLAPSE_ALLOC, 1);
 	lru_cache_add_active_or_unevictable(new_page, vma);
 	pgtable_trans_huge_deposit(mm, pmd, pgtable);
 	set_pmd_at(mm, address, pmd, _pmd);
@@ -1198,10 +1193,11 @@ static void collapse_huge_page(struct mm_struct *mm,
 out_up_write:
 	up_write(&mm->mmap_sem);
 out_nolock:
+	if (*hpage)
+		mem_cgroup_uncharge(*hpage);
 	trace_mm_collapse_huge_page(mm, isolated, result);
 	return;
 out:
-	mem_cgroup_cancel_charge(new_page, memcg);
 	goto out_up_write;
 }
 
@@ -1609,7 +1605,6 @@ static void collapse_file(struct mm_struct *mm,
 	struct address_space *mapping = file->f_mapping;
 	gfp_t gfp;
 	struct page *new_page;
-	struct mem_cgroup *memcg;
 	pgoff_t index, end = start + HPAGE_PMD_NR;
 	LIST_HEAD(pagelist);
 	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
@@ -1628,10 +1623,11 @@ static void collapse_file(struct mm_struct *mm,
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
@@ -1641,7 +1637,6 @@ static void collapse_file(struct mm_struct *mm,
 			break;
 		xas_unlock_irq(&xas);
 		if (!xas_nomem(&xas, GFP_KERNEL)) {
-			mem_cgroup_cancel_charge(new_page, memcg);
 			result = SCAN_FAIL;
 			goto out;
 		}
@@ -1834,18 +1829,9 @@ static void collapse_file(struct mm_struct *mm,
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
@@ -1883,7 +1869,6 @@ static void collapse_file(struct mm_struct *mm,
 
 		SetPageUptodate(new_page);
 		page_ref_add(new_page, HPAGE_PMD_NR - 1);
-		mem_cgroup_commit_charge(new_page, memcg, false);
 
 		if (is_shmem) {
 			set_page_dirty(new_page);
@@ -1891,7 +1876,6 @@ static void collapse_file(struct mm_struct *mm,
 		} else {
 			lru_cache_add_file(new_page);
 		}
-		count_memcg_events(memcg, THP_COLLAPSE_ALLOC, 1);
 
 		/*
 		 * Remove pte page tables, so we can re-fault the page as huge.
@@ -1938,13 +1922,14 @@ static void collapse_file(struct mm_struct *mm,
 		VM_BUG_ON(nr_none);
 		xas_unlock_irq(&xas);
 
-		mem_cgroup_cancel_charge(new_page, memcg);
 		new_page->mapping = NULL;
 	}
 
 	unlock_page(new_page);
 out:
 	VM_BUG_ON(!list_empty(&pagelist));
+	if (*hpage)
+		mem_cgroup_uncharge(*hpage);
 	/* TODO: tracepoints */
 }
 
diff --git a/mm/memory.c b/mm/memory.c
index 46c3e5dc918d..832ee914cbcf 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2645,7 +2645,6 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 	struct page *new_page = NULL;
 	pte_t entry;
 	int page_copied = 0;
-	struct mem_cgroup *memcg;
 	struct mmu_notifier_range range;
 
 	if (unlikely(anon_vma_prepare(vma)))
@@ -2676,8 +2675,9 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		}
 	}
 
-	if (mem_cgroup_try_charge_delay(new_page, mm, GFP_KERNEL, &memcg))
+	if (mem_cgroup_charge(new_page, mm, GFP_KERNEL, false))
 		goto oom_free_new;
+	cgroup_throttle_swaprate(new_page, GFP_KERNEL);
 
 	__SetPageUptodate(new_page);
 
@@ -2710,7 +2710,6 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		 * thread doing COW.
 		 */
 		ptep_clear_flush_notify(vma, vmf->address, vmf->pte);
-		mem_cgroup_commit_charge(new_page, memcg, false);
 		page_add_new_anon_rmap(new_page, vma, vmf->address, false);
 		lru_cache_add_active_or_unevictable(new_page, vma);
 		/*
@@ -2749,8 +2748,6 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		/* Free the old page.. */
 		new_page = old_page;
 		page_copied = 1;
-	} else {
-		mem_cgroup_cancel_charge(new_page, memcg);
 	}
 
 	if (new_page)
@@ -3088,7 +3085,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct page *page = NULL, *swapcache;
-	struct mem_cgroup *memcg;
 	swp_entry_t entry;
 	pte_t pte;
 	int locked;
@@ -3193,10 +3189,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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
@@ -3243,11 +3240,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 
 	/* ksm created a completely new copy */
 	if (unlikely(page != swapcache && swapcache)) {
-		mem_cgroup_commit_charge(page, memcg, false);
 		page_add_new_anon_rmap(page, vma, vmf->address, false);
 		lru_cache_add_active_or_unevictable(page, vma);
 	} else {
-		mem_cgroup_commit_charge(page, memcg, true);
 		do_page_add_anon_rmap(page, vma, vmf->address, exclusive);
 		activate_page(page);
 	}
@@ -3284,7 +3279,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 out:
 	return ret;
 out_nomap:
-	mem_cgroup_cancel_charge(page, memcg);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 out_page:
 	unlock_page(page);
@@ -3305,7 +3299,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
-	struct mem_cgroup *memcg;
 	struct page *page;
 	vm_fault_t ret = 0;
 	pte_t entry;
@@ -3358,8 +3351,9 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	if (!page)
 		goto oom;
 
-	if (mem_cgroup_try_charge_delay(page, vma->vm_mm, GFP_KERNEL, &memcg))
+	if (mem_cgroup_charge(page, vma->vm_mm, GFP_KERNEL, false))
 		goto oom_free_page;
+	cgroup_throttle_swaprate(page, GFP_KERNEL);
 
 	/*
 	 * The memory barrier inside __SetPageUptodate makes sure that
@@ -3384,13 +3378,11 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	/* Deliver the page fault to userland, check inside PT lock */
 	if (userfaultfd_missing(vma)) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
-		mem_cgroup_cancel_charge(page, memcg);
 		put_page(page);
 		return handle_userfault(vmf, VM_UFFD_MISSING);
 	}
 
 	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
-	mem_cgroup_commit_charge(page, memcg, false);
 	page_add_new_anon_rmap(page, vma, vmf->address, false);
 	lru_cache_add_active_or_unevictable(page, vma);
 setpte:
@@ -3402,7 +3394,6 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 	return ret;
 release:
-	mem_cgroup_cancel_charge(page, memcg);
 	put_page(page);
 	goto unlock;
 oom_free_page:
@@ -3607,7 +3598,6 @@ static vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
  * mapping. If needed, the fucntion allocates page table or use pre-allocated.
  *
  * @vmf: fault environment
- * @memcg: memcg to charge page (only for private mappings)
  * @page: page to map
  *
  * Caller must take care of unlocking vmf->ptl, if vmf->pte is non-NULL on
@@ -3618,8 +3608,7 @@ static vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
  *
  * Return: %0 on success, %VM_FAULT_ code in case of error.
  */
-vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct mem_cgroup *memcg,
-		struct page *page)
+vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct page *page)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
@@ -3627,9 +3616,6 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct mem_cgroup *memcg,
 	vm_fault_t ret;
 
 	if (pmd_none(*vmf->pmd) && PageTransCompound(page)) {
-		/* THP on COW? */
-		VM_BUG_ON_PAGE(memcg, page);
-
 		ret = do_set_pmd(vmf, page);
 		if (ret != VM_FAULT_FALLBACK)
 			return ret;
@@ -3652,7 +3638,6 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct mem_cgroup *memcg,
 	/* copy-on-write page */
 	if (write && !(vma->vm_flags & VM_SHARED)) {
 		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
-		mem_cgroup_commit_charge(page, memcg, false);
 		page_add_new_anon_rmap(page, vma, vmf->address, false);
 		lru_cache_add_active_or_unevictable(page, vma);
 	} else {
@@ -3702,7 +3687,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 	if (!(vmf->vma->vm_flags & VM_SHARED))
 		ret = check_stable_address_space(vmf->vma->vm_mm);
 	if (!ret)
-		ret = alloc_set_pte(vmf, vmf->memcg, page);
+		ret = alloc_set_pte(vmf, page);
 	if (vmf->pte)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 	return ret;
@@ -3862,11 +3847,11 @@ static vm_fault_t do_cow_fault(struct vm_fault *vmf)
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
@@ -3884,7 +3869,6 @@ static vm_fault_t do_cow_fault(struct vm_fault *vmf)
 		goto uncharge_out;
 	return ret;
 uncharge_out:
-	mem_cgroup_cancel_charge(vmf->cow_page, vmf->memcg);
 	put_page(vmf->cow_page);
 	return ret;
 }
diff --git a/mm/migrate.c b/mm/migrate.c
index e84fb5b87a85..2028f08e3e8d 100644
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
@@ -2838,7 +2837,6 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 		goto unlock_abort;
 
 	inc_mm_counter(mm, MM_ANONPAGES);
-	mem_cgroup_commit_charge(page, memcg, false);
 	page_add_new_anon_rmap(page, vma, addr, false);
 	if (!is_zone_device_page(page))
 		lru_cache_add_active_or_unevictable(page, vma);
@@ -2861,7 +2859,6 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 
 unlock_abort:
 	pte_unmap_unlock(ptep, ptl);
-	mem_cgroup_cancel_charge(page, memcg);
 abort:
 	*src &= ~MIGRATE_PFN_MIGRATE;
 }
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 45b937b924f5..8c9b6767013b 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1858,7 +1858,6 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long addr, swp_entry_t entry, struct page *page)
 {
 	struct page *swapcache;
-	struct mem_cgroup *memcg;
 	spinlock_t *ptl;
 	pte_t *pte;
 	int ret = 1;
@@ -1868,14 +1867,13 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
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
@@ -1886,10 +1884,8 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 	set_pte_at(vma->vm_mm, addr, pte,
 		   pte_mkold(mk_pte(page, vma->vm_page_prot)));
 	if (page == swapcache) {
-		mem_cgroup_commit_charge(page, memcg, true);
 		page_add_anon_rmap(page, vma, addr, false);
 	} else { /* ksm created a completely new copy */
-		mem_cgroup_commit_charge(page, memcg, false);
 		page_add_new_anon_rmap(page, vma, addr, false);
 		lru_cache_add_active_or_unevictable(page, vma);
 	}
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 3dea268d2850..2745489415cc 100644
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
@@ -123,7 +122,6 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 		goto out_release_uncharge_unlock;
 
 	inc_mm_counter(dst_mm, MM_ANONPAGES);
-	mem_cgroup_commit_charge(page, memcg, false);
 	page_add_new_anon_rmap(page, dst_vma, dst_addr, false);
 	lru_cache_add_active_or_unevictable(page, dst_vma);
 
@@ -138,7 +136,6 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 	return ret;
 out_release_uncharge_unlock:
 	pte_unmap_unlock(dst_pte, ptl);
-	mem_cgroup_cancel_charge(page, memcg);
 out_release:
 	put_page(page);
 	goto out;
-- 
2.26.2


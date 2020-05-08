Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061B01CB750
	for <lists+cgroups@lfdr.de>; Fri,  8 May 2020 20:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgEHScx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 May 2020 14:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728065AbgEHScr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 May 2020 14:32:47 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB024C05BD09
        for <cgroups@vger.kernel.org>; Fri,  8 May 2020 11:32:45 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id n14so2628863qke.8
        for <cgroups@vger.kernel.org>; Fri, 08 May 2020 11:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TTuAqgld6SyEaK3rLHUNyouiF/IGEwrIxqQKkdAzWpI=;
        b=FGe17OT4Z1CVjqvCLrTYH2xv12QXScSBv87SZC3klEnRKeQFyPFP0SC4ydb552/3Rg
         X6i+MSWQabSacr+0jUlJRUTMOq5PGbHHRM6TO9aqig3r8b4RBBeE6p+O6NpqtRRxUT8F
         X0R93Tsvx5ZjkrS1lJKjuIa/UB+RJIwGuCFUFC3A8GfMAVLZ/ocPnNm4BHIaYN3Ff9UY
         Ku1XEeRzWLlzuvveV5Uetea6OIszYVsa0A67gLtXH+CsQoya3Acnu5l1rEWNdyjTHhTj
         hVRtskVhBt+aNsQxAdk2guuMvAzTP2hh8wXDaiKB7rcAmHTss3cr/aueCB61xSYgSKT0
         DEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TTuAqgld6SyEaK3rLHUNyouiF/IGEwrIxqQKkdAzWpI=;
        b=lKWewSG9VYEhWL/koDWxffBJPZUQizb1Prb5HVpBFk87jP4PkSFQCu+7XJRUDaPURJ
         n54iPR0xR1xhmw70ze1+tS3+bO+oEps0NKd4lKOVEkOJHW/yUxKjYFGla0YrrMVer+kZ
         a1F30mW4MjMtAU6CXeZD8+bZBeOQVbNPaCH9Ph5lEdYfx4HsnoHH0zq4U4PtyrF3NOLj
         mSCYLjU/V1nL6jMQM5JwaRpRwzbEPpahQC9MR2ooRlmNI8WFU+6hKFWr+4k0YDuFOc5O
         rcphzqyJyZz7sfF0oKC6WDG16rm5UomSb7iwKAWVBZExXMv6xSc9SDenGeytoR0u+8gP
         WBBg==
X-Gm-Message-State: AGi0PubTp9RArE+3jXIOFymYEXxMFHiyYqHpD9+yfMeFn8xkgpVuERBU
        UOSh2KWMt9cgHfT2cInfAsQQFEQPYd4=
X-Google-Smtp-Source: APiQypIYRDDnYjt6Iom/0xBEDFBj4IPN2NA1mCsIxAvpTe9dUxvXmZwcVLL8TWEvbgfWaVrkmAm5cw==
X-Received: by 2002:a37:4e08:: with SMTP id c8mr4246765qkb.60.1588962764827;
        Fri, 08 May 2020 11:32:44 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2627])
        by smtp.gmail.com with ESMTPSA id c11sm1763050qkj.78.2020.05.08.11.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 11:32:44 -0700 (PDT)
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
Subject: [PATCH 18/19] mm: memcontrol: delete unused lrucare handling
Date:   Fri,  8 May 2020 14:31:05 -0400
Message-Id: <20200508183105.225460-19-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508183105.225460-1-hannes@cmpxchg.org>
References: <20200508183105.225460-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Swapin faults were the last event to charge pages after they had
already been put on the LRU list. Now that we charge directly on
swapin, the lrucare portion of the charge code is unused.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/memcontrol.h |  5 ++--
 kernel/events/uprobes.c    |  3 +-
 mm/filemap.c               |  2 +-
 mm/huge_memory.c           |  2 +-
 mm/khugepaged.c            |  4 +--
 mm/memcontrol.c            | 57 +++-----------------------------------
 mm/memory.c                |  8 +++---
 mm/migrate.c               |  2 +-
 mm/shmem.c                 |  2 +-
 mm/swap_state.c            |  2 +-
 mm/userfaultfd.c           |  2 +-
 11 files changed, 19 insertions(+), 70 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 3fa70ca73c31..e7209f4ca938 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -369,8 +369,7 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
 		page_counter_read(&memcg->memory);
 }
 
-int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask,
-		      bool lrucare);
+int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask);
 
 void mem_cgroup_uncharge(struct page *page);
 void mem_cgroup_uncharge_list(struct list_head *page_list);
@@ -860,7 +859,7 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
 }
 
 static inline int mem_cgroup_charge(struct page *page, struct mm_struct *mm,
-				    gfp_t gfp_mask, bool lrucare)
+				    gfp_t gfp_mask)
 {
 	return 0;
 }
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 4253c153e985..eddc8db96027 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -167,8 +167,7 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 				addr + PAGE_SIZE);
 
 	if (new_page) {
-		err = mem_cgroup_charge(new_page, vma->vm_mm, GFP_KERNEL,
-					false);
+		err = mem_cgroup_charge(new_page, vma->vm_mm, GFP_KERNEL);
 		if (err)
 			return err;
 	}
diff --git a/mm/filemap.c b/mm/filemap.c
index fa47f160e1cc..792e22e1e3c0 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -845,7 +845,7 @@ static int __add_to_page_cache_locked(struct page *page,
 	page->index = offset;
 
 	if (!huge) {
-		error = mem_cgroup_charge(page, current->mm, gfp_mask, false);
+		error = mem_cgroup_charge(page, current->mm, gfp_mask);
 		if (error)
 			goto error;
 	}
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d0f1e8cee93c..21e6687895e2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -593,7 +593,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 
 	VM_BUG_ON_PAGE(!PageCompound(page), page);
 
-	if (mem_cgroup_charge(page, vma->vm_mm, gfp, false)) {
+	if (mem_cgroup_charge(page, vma->vm_mm, gfp)) {
 		put_page(page);
 		count_vm_event(THP_FAULT_FALLBACK);
 		count_vm_event(THP_FAULT_FALLBACK_CHARGE);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 34731e7c9a67..fbb1030091ca 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1066,7 +1066,7 @@ static void collapse_huge_page(struct mm_struct *mm,
 		goto out_nolock;
 	}
 
-	if (unlikely(mem_cgroup_charge(new_page, mm, gfp, false))) {
+	if (unlikely(mem_cgroup_charge(new_page, mm, gfp))) {
 		result = SCAN_CGROUP_CHARGE_FAIL;
 		goto out_nolock;
 	}
@@ -1623,7 +1623,7 @@ static void collapse_file(struct mm_struct *mm,
 		goto out;
 	}
 
-	if (unlikely(mem_cgroup_charge(new_page, mm, gfp, false))) {
+	if (unlikely(mem_cgroup_charge(new_page, mm, gfp))) {
 		result = SCAN_CGROUP_CHARGE_FAIL;
 		goto out;
 	}
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4a003531af07..491fdeec0ce4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2601,51 +2601,9 @@ static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
 	css_put_many(&memcg->css, nr_pages);
 }
 
-static void lock_page_lru(struct page *page, int *isolated)
+static void commit_charge(struct page *page, struct mem_cgroup *memcg)
 {
-	pg_data_t *pgdat = page_pgdat(page);
-
-	spin_lock_irq(&pgdat->lru_lock);
-	if (PageLRU(page)) {
-		struct lruvec *lruvec;
-
-		lruvec = mem_cgroup_page_lruvec(page, pgdat);
-		ClearPageLRU(page);
-		del_page_from_lru_list(page, lruvec, page_lru(page));
-		*isolated = 1;
-	} else
-		*isolated = 0;
-}
-
-static void unlock_page_lru(struct page *page, int isolated)
-{
-	pg_data_t *pgdat = page_pgdat(page);
-
-	if (isolated) {
-		struct lruvec *lruvec;
-
-		lruvec = mem_cgroup_page_lruvec(page, pgdat);
-		VM_BUG_ON_PAGE(PageLRU(page), page);
-		SetPageLRU(page);
-		add_page_to_lru_list(page, lruvec, page_lru(page));
-	}
-	spin_unlock_irq(&pgdat->lru_lock);
-}
-
-static void commit_charge(struct page *page, struct mem_cgroup *memcg,
-			  bool lrucare)
-{
-	int isolated;
-
 	VM_BUG_ON_PAGE(page->mem_cgroup, page);
-
-	/*
-	 * In some cases, SwapCache and FUSE(splice_buf->radixtree), the page
-	 * may already be on some other mem_cgroup's LRU.  Take care of it.
-	 */
-	if (lrucare)
-		lock_page_lru(page, &isolated);
-
 	/*
 	 * Nobody should be changing or seriously looking at
 	 * page->mem_cgroup at this point:
@@ -2661,9 +2619,6 @@ static void commit_charge(struct page *page, struct mem_cgroup *memcg,
 	 *   have the page locked
 	 */
 	page->mem_cgroup = memcg;
-
-	if (lrucare)
-		unlock_page_lru(page, isolated);
 }
 
 #ifdef CONFIG_MEMCG_KMEM
@@ -6434,22 +6389,18 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
  * @page: page to charge
  * @mm: mm context of the victim
  * @gfp_mask: reclaim mode
- * @lrucare: page might be on the LRU already
  *
  * Try to charge @page to the memcg that @mm belongs to, reclaiming
  * pages according to @gfp_mask if necessary.
  *
  * Returns 0 on success. Otherwise, an error code is returned.
  */
-int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask,
-		      bool lrucare)
+int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
 {
 	unsigned int nr_pages = hpage_nr_pages(page);
 	struct mem_cgroup *memcg = NULL;
 	int ret = 0;
 
-	VM_BUG_ON_PAGE(PageLRU(page) && !lrucare, page);
-
 	if (mem_cgroup_disabled())
 		goto out;
 
@@ -6483,7 +6434,7 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask,
 	if (ret)
 		goto out_put;
 
-	commit_charge(page, memcg, lrucare);
+	commit_charge(page, memcg);
 
 	local_irq_disable();
 	mem_cgroup_charge_statistics(memcg, page, nr_pages);
@@ -6684,7 +6635,7 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 		page_counter_charge(&memcg->memsw, nr_pages);
 	css_get_many(&memcg->css, nr_pages);
 
-	commit_charge(newpage, memcg, false);
+	commit_charge(newpage, memcg);
 
 	local_irq_save(flags);
 	mem_cgroup_charge_statistics(memcg, newpage, nr_pages);
diff --git a/mm/memory.c b/mm/memory.c
index 93900b121b6e..7f19a73db0f0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2675,7 +2675,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		}
 	}
 
-	if (mem_cgroup_charge(new_page, mm, GFP_KERNEL, false))
+	if (mem_cgroup_charge(new_page, mm, GFP_KERNEL))
 		goto oom_free_new;
 	cgroup_throttle_swaprate(new_page, GFP_KERNEL);
 
@@ -3134,7 +3134,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 				/* Tell memcg to use swap ownership records */
 				SetPageSwapCache(page);
 				err = mem_cgroup_charge(page, vma->vm_mm,
-							GFP_KERNEL, false);
+							GFP_KERNEL);
 				ClearPageSwapCache(page);
 				if (err)
 					goto out_page;
@@ -3358,7 +3358,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	if (!page)
 		goto oom;
 
-	if (mem_cgroup_charge(page, vma->vm_mm, GFP_KERNEL, false))
+	if (mem_cgroup_charge(page, vma->vm_mm, GFP_KERNEL))
 		goto oom_free_page;
 	cgroup_throttle_swaprate(page, GFP_KERNEL);
 
@@ -3854,7 +3854,7 @@ static vm_fault_t do_cow_fault(struct vm_fault *vmf)
 	if (!vmf->cow_page)
 		return VM_FAULT_OOM;
 
-	if (mem_cgroup_charge(vmf->cow_page, vma->vm_mm, GFP_KERNEL, false)) {
+	if (mem_cgroup_charge(vmf->cow_page, vma->vm_mm, GFP_KERNEL)) {
 		put_page(vmf->cow_page);
 		return VM_FAULT_OOM;
 	}
diff --git a/mm/migrate.c b/mm/migrate.c
index 2028f08e3e8d..5fed0305d2ec 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2792,7 +2792,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 
 	if (unlikely(anon_vma_prepare(vma)))
 		goto abort;
-	if (mem_cgroup_charge(page, vma->vm_mm, GFP_KERNEL, false))
+	if (mem_cgroup_charge(page, vma->vm_mm, GFP_KERNEL))
 		goto abort;
 
 	/*
diff --git a/mm/shmem.c b/mm/shmem.c
index 98547dc4642d..ccda43fd0328 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -624,7 +624,7 @@ static int shmem_add_to_page_cache(struct page *page,
 	page->index = index;
 
 	if (!PageSwapCache(page)) {
-		error = mem_cgroup_charge(page, charge_mm, gfp, false);
+		error = mem_cgroup_charge(page, charge_mm, gfp);
 		if (error) {
 			if (PageTransHuge(page)) {
 				count_vm_event(THP_FILE_FALLBACK);
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 4052c011391d..3a66ed4e3574 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -427,7 +427,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	if (add_to_swap_cache(page, entry, gfp_mask & GFP_KERNEL))
 		goto fail_unlock;
 
-	if (mem_cgroup_charge(page, NULL, gfp_mask & GFP_KERNEL, false))
+	if (mem_cgroup_charge(page, NULL, gfp_mask & GFP_KERNEL))
 		goto fail_delete;
 
 	/* Initiate read into locked page */
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 2745489415cc..7f5194046b01 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -96,7 +96,7 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 	__SetPageUptodate(page);
 
 	ret = -ENOMEM;
-	if (mem_cgroup_charge(page, dst_mm, GFP_KERNEL, false))
+	if (mem_cgroup_charge(page, dst_mm, GFP_KERNEL))
 		goto out_release;
 
 	_dst_pte = pte_mkdirty(mk_pte(page, dst_vma->vm_page_prot));
-- 
2.26.2


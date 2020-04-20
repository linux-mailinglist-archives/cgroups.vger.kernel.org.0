Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D731B1926
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2020 00:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgDTWM0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Apr 2020 18:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728434AbgDTWMO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Apr 2020 18:12:14 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352E1C061A0E
        for <cgroups@vger.kernel.org>; Mon, 20 Apr 2020 15:12:14 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id t3so12598923qkg.1
        for <cgroups@vger.kernel.org>; Mon, 20 Apr 2020 15:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PncRoalTORTzbPDipW6LC/3hBRJEv36Hcb5+zF4gMQI=;
        b=lD2oKzCp8iMw2/AoEsPsa7wNaiC7gPfC/xtQbGFpVKtiYZcZw1aaTPz3iutggIrJYj
         +F39OgqOjUV24z5rbhHJ0hRn7w+tBm0XBBT7c1Hmxu0UF5Y+Ggh+HK6Kostsdj/NyvyH
         EvFx5J+8al9GXzRRuJ3vDEWRZckh7TPr5J+sH+iEGksj7idRcraj57Nkv8ntPVxnw1hI
         Es0XUIHbguzDRlfAFCk9aHkdV2KUD9nI9sHGr9WFre3CS53I8JC2//bxVqEsp8NV4vLb
         erMHFO1mmEvAsoU7i168DpDvh3bNY1WtbSXX62iEASE2Lqz20vy20jkDFpc01nai5awo
         ERxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PncRoalTORTzbPDipW6LC/3hBRJEv36Hcb5+zF4gMQI=;
        b=mPD2srSdgyAph3sixxkqbBHfUBpkP95t8D4IjM4Y01MKh5Tcu6bMTgDsAzouzkWE+N
         SU2Ag6Z6wTNpdcj+13kLqUYXoj0BBD8S0XByUJWQVgp0qrh/jmyUdmwzuZ9N1z/UI7m4
         LWcGvmZDE28XI9VaTxmP++hR+PdBoocmRSl5Zp+g5fZ3a33fBxkyytiesrKDcwJt8Tur
         xRMdIvr4zI8Qlhf+UDBB3+mm2EJ0sqHPjsuIbb3d85M8rgepjSYuB4EAJp+Nj9TY9ykU
         HQq5em5PRLkGJIcKSB7YlZOBGszaQLxbhJu5CK9M2PPKBH48UgX/roL6bZZyttOEpDSl
         sdtw==
X-Gm-Message-State: AGi0PuY8R2/PJZ8NTbKt+UYiD0r81J+Qylqecs7hbCTapmWU2ial2trm
        6kUTiFxH5G6JtlCHGIHQCo1ZSg==
X-Google-Smtp-Source: APiQypKmCeYifa3cirZ/DIUOjt014kXlMLmlAxwLPSf6UL0vF1T1XfAndFyIPskVlxtnbXWOHNwFMA==
X-Received: by 2002:a37:e310:: with SMTP id y16mr18741966qki.275.1587420733327;
        Mon, 20 Apr 2020 15:12:13 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:e6b6])
        by smtp.gmail.com with ESMTPSA id o68sm568301qka.110.2020.04.20.15.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 15:12:12 -0700 (PDT)
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
Subject: [PATCH 17/18] mm: memcontrol: delete unused lrucare handling
Date:   Mon, 20 Apr 2020 18:11:25 -0400
Message-Id: <20200420221126.341272-18-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200420221126.341272-1-hannes@cmpxchg.org>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/memcontrol.h |  5 ++--
 kernel/events/uprobes.c    |  3 +-
 mm/filemap.c               |  2 +-
 mm/huge_memory.c           |  7 ++---
 mm/khugepaged.c            |  4 +--
 mm/memcontrol.c            | 57 +++-----------------------------------
 mm/memory.c                |  8 +++---
 mm/migrate.c               |  2 +-
 mm/shmem.c                 |  2 +-
 mm/swap_state.c            |  2 +-
 mm/userfaultfd.c           |  2 +-
 11 files changed, 21 insertions(+), 73 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d458f1d90aa4..4b868e5a687f 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -357,8 +357,7 @@ static inline unsigned long mem_cgroup_protection(struct mem_cgroup *memcg,
 enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 						struct mem_cgroup *memcg);
 
-int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask,
-		      bool lrucare);
+int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask);
 
 void mem_cgroup_uncharge(struct page *page);
 void mem_cgroup_uncharge_list(struct list_head *page_list);
@@ -839,7 +838,7 @@ static inline enum mem_cgroup_protection mem_cgroup_protected(
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
index a10bd6696049..f73b221314df 100644
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
index 0b33eaf0740a..35a716720e26 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -593,7 +593,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 
 	VM_BUG_ON_PAGE(!PageCompound(page), page);
 
-	if (mem_cgroup_charge(page, vma->vm_mm, gfp, false)) {
+	if (mem_cgroup_charge(page, vma->vm_mm, gfp)) {
 		put_page(page);
 		count_vm_event(THP_FAULT_FALLBACK);
 		count_vm_event(THP_FAULT_FALLBACK_CHARGE);
@@ -1276,7 +1276,7 @@ static vm_fault_t do_huge_pmd_wp_page_fallback(struct vm_fault *vmf,
 					       vmf->address, page_to_nid(page));
 		if (unlikely(!pages[i] ||
 			     mem_cgroup_charge(pages[i], vma->vm_mm,
-					       GFP_KERNEL, false))) {
+					       GFP_KERNEL))) {
 			if (pages[i])
 				put_page(pages[i]);
 			while (--i >= 0)
@@ -1430,8 +1430,7 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
 		goto out;
 	}
 
-	if (unlikely(mem_cgroup_charge(new_page, vma->vm_mm, huge_gfp,
-				       false))) {
+	if (unlikely(mem_cgroup_charge(new_page, vma->vm_mm, huge_gfp))) {
 		put_page(new_page);
 		split_huge_pmd(vma, vmf->pmd, vmf->address);
 		if (page)
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 5cf8082fb038..28c6d84db4ee 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -973,7 +973,7 @@ static void collapse_huge_page(struct mm_struct *mm,
 		goto out_nolock;
 	}
 
-	if (unlikely(mem_cgroup_charge(new_page, mm, gfp, false))) {
+	if (unlikely(mem_cgroup_charge(new_page, mm, gfp))) {
 		result = SCAN_CGROUP_CHARGE_FAIL;
 		goto out_nolock;
 	}
@@ -1527,7 +1527,7 @@ static void collapse_file(struct mm_struct *mm,
 		goto out;
 	}
 
-	if (unlikely(mem_cgroup_charge(new_page, mm, gfp, false))) {
+	if (unlikely(mem_cgroup_charge(new_page, mm, gfp))) {
 		result = SCAN_CGROUP_CHARGE_FAIL;
 		goto out;
 	}
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1d7408a8744a..a8cce52b6b4d 100644
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
@@ -6433,22 +6388,18 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
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
 
@@ -6482,7 +6433,7 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask,
 	if (ret)
 		goto out_put;
 
-	commit_charge(page, memcg, lrucare);
+	commit_charge(page, memcg);
 
 	local_irq_disable();
 	mem_cgroup_charge_statistics(memcg, page, nr_pages);
@@ -6685,7 +6636,7 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 		page_counter_charge(&memcg->memsw, nr_pages);
 	css_get_many(&memcg->css, nr_pages);
 
-	commit_charge(newpage, memcg, false);
+	commit_charge(newpage, memcg);
 
 	local_irq_save(flags);
 	mem_cgroup_charge_statistics(memcg, newpage, nr_pages);
diff --git a/mm/memory.c b/mm/memory.c
index 5d266532fc40..0ad4db56bea2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2677,7 +2677,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		}
 	}
 
-	if (mem_cgroup_charge(new_page, mm, GFP_KERNEL, false))
+	if (mem_cgroup_charge(new_page, mm, GFP_KERNEL))
 		goto oom_free_new;
 	cgroup_throttle_swaprate(new_page, GFP_KERNEL);
 
@@ -3136,7 +3136,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 				/* Tell memcg to use swap ownership records */
 				SetPageSwapCache(page);
 				err = mem_cgroup_charge(page, vma->vm_mm,
-							GFP_KERNEL, false);
+							GFP_KERNEL);
 				ClearPageSwapCache(page);
 				if (err)
 					goto out_page;
@@ -3360,7 +3360,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	if (!page)
 		goto oom;
 
-	if (mem_cgroup_charge(page, vma->vm_mm, GFP_KERNEL, false))
+	if (mem_cgroup_charge(page, vma->vm_mm, GFP_KERNEL))
 		goto oom_free_page;
 	cgroup_throttle_swaprate(page, GFP_KERNEL);
 
@@ -3856,7 +3856,7 @@ static vm_fault_t do_cow_fault(struct vm_fault *vmf)
 	if (!vmf->cow_page)
 		return VM_FAULT_OOM;
 
-	if (mem_cgroup_charge(vmf->cow_page, vma->vm_mm, GFP_KERNEL, false)) {
+	if (mem_cgroup_charge(vmf->cow_page, vma->vm_mm, GFP_KERNEL)) {
 		put_page(vmf->cow_page);
 		return VM_FAULT_OOM;
 	}
diff --git a/mm/migrate.c b/mm/migrate.c
index a3361c744069..ced652d069ee 100644
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
index 966f150a4823..add10d448bc6 100644
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
index f3b9073bfff3..26fded65c30d 100644
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
2.26.0


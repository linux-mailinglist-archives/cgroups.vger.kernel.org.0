Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C855D1CB745
	for <lists+cgroups@lfdr.de>; Fri,  8 May 2020 20:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgEHScc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 May 2020 14:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727969AbgEHSca (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 May 2020 14:32:30 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9813FC061A0C
        for <cgroups@vger.kernel.org>; Fri,  8 May 2020 11:32:30 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id z90so2120704qtd.10
        for <cgroups@vger.kernel.org>; Fri, 08 May 2020 11:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S76spG0o9PUrt+bPnw9UjhNU0/IWRliCZs9PZhoTRQ8=;
        b=vO6yWWOmZS2d0QMCp5tDJqPYYEitb5lxKcUL8Gbz/pebyYanWzDSoILG7KSPHOj1v5
         pI56vRyGc/Ww5diRYRUHvEDbf9BZdpQXhK/ieuwQmlp9FNGsibJUMyYMW4DJquU3PIxx
         nx/kUIZJuyVGT6w6Bwndue9Ti2TLcHGBp0qm1xPCuJQCG4Jmpg95lz1r8BOYjNbAV/3a
         RU8YEfa+UaFhljtuNcTBeB8c9wT0FfodZHZGl+A3fGSyw4NMinP/Ds95ll4YRK4VswtF
         Er629z4JRoqV2eHeExkFPe3gElwzse2mlmXEIBiwaIxOOf8B8oweViheVgPiGyw+jy1V
         7Vhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S76spG0o9PUrt+bPnw9UjhNU0/IWRliCZs9PZhoTRQ8=;
        b=aX/BFuPPWesICD1aQ0us15y+w88aeOmZ6+EugPSMfaaSgGknC4uUADgkcZs3bXZkMn
         ym5i5LQw15eOfczDhC++3uK4gIvNEvWjFm/UD7tXrmRj5f4mFq5Gan2Qo1Fg1X23/HU5
         Dx2XLgZGJCpTsKE5FgofCbOFXGYUOV55JJyl/qd13i22zemRB7xIq/rfEi24s6foAyQV
         D04YVTbU3RgD0OGB4tIhXovZWZQ7jOIBMlcEj2JUt6KU+3K3vsnVH11BG36EHij9rmIx
         7mZdNQJWFhOeQYZJ6KuYzUmb/j5f9h3Mlk5XBE7cI6C6ZXK1vyuWqhXlhjZFTCqvP1dw
         1i5g==
X-Gm-Message-State: AGi0PuZkZz3keJuJMb1tKHdn9LTdJAyeLLDdPa7eo3jCnjQHsA+LLzDB
        A8kRgO9GeFnuszq9Fl4KvP8LBA==
X-Google-Smtp-Source: APiQypJifvuyq81OqXS5Kf1m/ECh/qW6ZUD+MNRDQXyLMJpGO32m4DO+sV/hqAoUKNs2KqYcJCqiuA==
X-Received: by 2002:ac8:19dd:: with SMTP id s29mr4464315qtk.164.1588962749580;
        Fri, 08 May 2020 11:32:29 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2627])
        by smtp.gmail.com with ESMTPSA id d7sm1772115qkk.26.2020.05.08.11.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 11:32:28 -0700 (PDT)
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
Subject: [PATCH 10/19] mm: memcontrol: switch to native NR_ANON_MAPPED counter
Date:   Fri,  8 May 2020 14:30:57 -0400
Message-Id: <20200508183105.225460-11-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508183105.225460-1-hannes@cmpxchg.org>
References: <20200508183105.225460-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Memcg maintains a private MEMCG_RSS counter. This divergence from the
generic VM accounting means unnecessary code overhead, and creates a
dependency for memcg that page->mapping is set up at the time of
charging, so that page types can be told apart.

Convert the generic accounting sites to mod_lruvec_page_state and
friends to maintain the per-cgroup vmstat counter of
NR_ANON_MAPPED. We use lock_page_memcg() to stabilize page->mem_cgroup
during rmap changes, the same way we do for NR_FILE_MAPPED.

With the previous patch removing MEMCG_CACHE and the private NR_SHMEM
counter, this patch finally eliminates the need to have page->mapping
set up at charge time. However, we need to have page->mem_cgroup set
up by the time rmap runs and does the accounting, so switch the commit
and the rmap callbacks around.

v2: fix temporary accounting bug by switching rmap<->commit (Joonsoo)

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/memcontrol.h |  3 +--
 kernel/events/uprobes.c    |  2 +-
 mm/huge_memory.c           |  2 +-
 mm/khugepaged.c            |  2 +-
 mm/memcontrol.c            | 27 ++++++++--------------
 mm/memory.c                | 10 ++++----
 mm/migrate.c               |  2 +-
 mm/rmap.c                  | 47 +++++++++++++++++++++++---------------
 mm/swapfile.c              |  4 ++--
 mm/userfaultfd.c           |  2 +-
 10 files changed, 51 insertions(+), 50 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index f932e7e9fad8..2df978a3a253 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -29,8 +29,7 @@ struct kmem_cache;
 
 /* Cgroup-specific page state, on top of universal node page state */
 enum memcg_stat_item {
-	MEMCG_RSS = NR_VM_NODE_STAT_ITEMS,
-	MEMCG_RSS_HUGE,
+	MEMCG_RSS_HUGE = NR_VM_NODE_STAT_ITEMS,
 	MEMCG_SWAP,
 	MEMCG_SOCK,
 	/* XXX: why are these zone and not node counters? */
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 40e7488ce467..89ef81b65bcb 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -188,8 +188,8 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 
 	if (new_page) {
 		get_page(new_page);
-		page_add_new_anon_rmap(new_page, vma, addr, false);
 		mem_cgroup_commit_charge(new_page, memcg, false);
+		page_add_new_anon_rmap(new_page, vma, addr, false);
 		lru_cache_add_active_or_unevictable(new_page, vma);
 	} else
 		/* no new page, just dec_mm_counter for old_page */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 46c2bc20b7cb..07c012d89570 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -640,8 +640,8 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 
 		entry = mk_huge_pmd(page, vma->vm_page_prot);
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
-		page_add_new_anon_rmap(page, vma, haddr, true);
 		mem_cgroup_commit_charge(page, memcg, false);
+		page_add_new_anon_rmap(page, vma, haddr, true);
 		lru_cache_add_active_or_unevictable(page, vma);
 		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
 		set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index e2be7f9a92db..be67ebe8a120 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1182,8 +1182,8 @@ static void collapse_huge_page(struct mm_struct *mm,
 
 	spin_lock(pmd_ptl);
 	BUG_ON(!pmd_none(*pmd));
-	page_add_new_anon_rmap(new_page, vma, address, true);
 	mem_cgroup_commit_charge(new_page, memcg, false);
+	page_add_new_anon_rmap(new_page, vma, address, true);
 	count_memcg_events(memcg, THP_COLLAPSE_ALLOC, 1);
 	lru_cache_add_active_or_unevictable(new_page, vma);
 	pgtable_trans_huge_deposit(mm, pmd, pgtable);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c4c060ce1876..fccb396ed7bd 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -836,13 +836,6 @@ static void mem_cgroup_charge_statistics(struct mem_cgroup *memcg,
 					 struct page *page,
 					 int nr_pages)
 {
-	/*
-	 * Here, RSS means 'mapped anon' and anon's SwapCache. Shmem/tmpfs is
-	 * counted as CACHE even if it's on ANON LRU.
-	 */
-	if (PageAnon(page))
-		__mod_memcg_state(memcg, MEMCG_RSS, nr_pages);
-
 	if (abs(nr_pages) > 1) {
 		VM_BUG_ON_PAGE(!PageTransHuge(page), page);
 		__mod_memcg_state(memcg, MEMCG_RSS_HUGE, nr_pages);
@@ -1384,7 +1377,7 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
 	 */
 
 	seq_buf_printf(&s, "anon %llu\n",
-		       (u64)memcg_page_state(memcg, MEMCG_RSS) *
+		       (u64)memcg_page_state(memcg, NR_ANON_MAPPED) *
 		       PAGE_SIZE);
 	seq_buf_printf(&s, "file %llu\n",
 		       (u64)memcg_page_state(memcg, NR_FILE_PAGES) *
@@ -3298,7 +3291,7 @@ static unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
 
 	if (mem_cgroup_is_root(memcg)) {
 		val = memcg_page_state(memcg, NR_FILE_PAGES) +
-			memcg_page_state(memcg, MEMCG_RSS);
+			memcg_page_state(memcg, NR_ANON_MAPPED);
 		if (swap)
 			val += memcg_page_state(memcg, MEMCG_SWAP);
 	} else {
@@ -3769,7 +3762,7 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
 
 static const unsigned int memcg1_stats[] = {
 	NR_FILE_PAGES,
-	MEMCG_RSS,
+	NR_ANON_MAPPED,
 	MEMCG_RSS_HUGE,
 	NR_SHMEM,
 	NR_FILE_MAPPED,
@@ -5399,7 +5392,12 @@ static int mem_cgroup_move_account(struct page *page,
 
 	lock_page_memcg(page);
 
-	if (!PageAnon(page)) {
+	if (PageAnon(page)) {
+		if (page_mapped(page)) {
+			__mod_lruvec_state(from_vec, NR_ANON_MAPPED, -nr_pages);
+			__mod_lruvec_state(to_vec, NR_ANON_MAPPED, nr_pages);
+		}
+	} else {
 		__mod_lruvec_state(from_vec, NR_FILE_PAGES, -nr_pages);
 		__mod_lruvec_state(to_vec, NR_FILE_PAGES, nr_pages);
 
@@ -6530,7 +6528,6 @@ void mem_cgroup_commit_charge(struct page *page, struct mem_cgroup *memcg,
 {
 	unsigned int nr_pages = hpage_nr_pages(page);
 
-	VM_BUG_ON_PAGE(!page->mapping, page);
 	VM_BUG_ON_PAGE(PageLRU(page) && !lrucare, page);
 
 	if (mem_cgroup_disabled())
@@ -6603,8 +6600,6 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask,
 	struct mem_cgroup *memcg;
 	int ret;
 
-	VM_BUG_ON_PAGE(!page->mapping, page);
-
 	ret = mem_cgroup_try_charge(page, mm, gfp_mask, &memcg);
 	if (ret)
 		return ret;
@@ -6616,7 +6611,6 @@ struct uncharge_gather {
 	struct mem_cgroup *memcg;
 	unsigned long nr_pages;
 	unsigned long pgpgout;
-	unsigned long nr_anon;
 	unsigned long nr_kmem;
 	unsigned long nr_huge;
 	struct page *dummy_page;
@@ -6641,7 +6635,6 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 	}
 
 	local_irq_save(flags);
-	__mod_memcg_state(ug->memcg, MEMCG_RSS, -ug->nr_anon);
 	__mod_memcg_state(ug->memcg, MEMCG_RSS_HUGE, -ug->nr_huge);
 	__count_memcg_events(ug->memcg, PGPGOUT, ug->pgpgout);
 	__this_cpu_add(ug->memcg->vmstats_percpu->nr_page_events, ug->nr_pages);
@@ -6681,8 +6674,6 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 	if (!PageKmemcg(page)) {
 		if (PageTransHuge(page))
 			ug->nr_huge += nr_pages;
-		if (PageAnon(page))
-			ug->nr_anon += nr_pages;
 		ug->pgpgout++;
 	} else {
 		ug->nr_kmem += nr_pages;
diff --git a/mm/memory.c b/mm/memory.c
index a08cbaa81607..46c3e5dc918d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2710,8 +2710,8 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		 * thread doing COW.
 		 */
 		ptep_clear_flush_notify(vma, vmf->address, vmf->pte);
-		page_add_new_anon_rmap(new_page, vma, vmf->address, false);
 		mem_cgroup_commit_charge(new_page, memcg, false);
+		page_add_new_anon_rmap(new_page, vma, vmf->address, false);
 		lru_cache_add_active_or_unevictable(new_page, vma);
 		/*
 		 * We call the notify macro here because, when using secondary
@@ -3243,12 +3243,12 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 
 	/* ksm created a completely new copy */
 	if (unlikely(page != swapcache && swapcache)) {
-		page_add_new_anon_rmap(page, vma, vmf->address, false);
 		mem_cgroup_commit_charge(page, memcg, false);
+		page_add_new_anon_rmap(page, vma, vmf->address, false);
 		lru_cache_add_active_or_unevictable(page, vma);
 	} else {
-		do_page_add_anon_rmap(page, vma, vmf->address, exclusive);
 		mem_cgroup_commit_charge(page, memcg, true);
+		do_page_add_anon_rmap(page, vma, vmf->address, exclusive);
 		activate_page(page);
 	}
 
@@ -3390,8 +3390,8 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	}
 
 	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
-	page_add_new_anon_rmap(page, vma, vmf->address, false);
 	mem_cgroup_commit_charge(page, memcg, false);
+	page_add_new_anon_rmap(page, vma, vmf->address, false);
 	lru_cache_add_active_or_unevictable(page, vma);
 setpte:
 	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
@@ -3652,8 +3652,8 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct mem_cgroup *memcg,
 	/* copy-on-write page */
 	if (write && !(vma->vm_flags & VM_SHARED)) {
 		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
-		page_add_new_anon_rmap(page, vma, vmf->address, false);
 		mem_cgroup_commit_charge(page, memcg, false);
+		page_add_new_anon_rmap(page, vma, vmf->address, false);
 		lru_cache_add_active_or_unevictable(page, vma);
 	} else {
 		inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page));
diff --git a/mm/migrate.c b/mm/migrate.c
index 3af5447e7aca..e84fb5b87a85 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2838,8 +2838,8 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 		goto unlock_abort;
 
 	inc_mm_counter(mm, MM_ANONPAGES);
-	page_add_new_anon_rmap(page, vma, addr, false);
 	mem_cgroup_commit_charge(page, memcg, false);
+	page_add_new_anon_rmap(page, vma, addr, false);
 	if (!is_zone_device_page(page))
 		lru_cache_add_active_or_unevictable(page, vma);
 	get_page(page);
diff --git a/mm/rmap.c b/mm/rmap.c
index 2126fd4a254b..e96f1d099c3f 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1114,6 +1114,11 @@ void do_page_add_anon_rmap(struct page *page,
 	bool compound = flags & RMAP_COMPOUND;
 	bool first;
 
+	if (unlikely(PageKsm(page)))
+		lock_page_memcg(page);
+	else
+		VM_BUG_ON_PAGE(!PageLocked(page), page);
+
 	if (compound) {
 		atomic_t *mapcount;
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
@@ -1134,12 +1139,13 @@ void do_page_add_anon_rmap(struct page *page,
 		 */
 		if (compound)
 			__inc_node_page_state(page, NR_ANON_THPS);
-		__mod_node_page_state(page_pgdat(page), NR_ANON_MAPPED, nr);
+		__mod_lruvec_page_state(page, NR_ANON_MAPPED, nr);
 	}
-	if (unlikely(PageKsm(page)))
-		return;
 
-	VM_BUG_ON_PAGE(!PageLocked(page), page);
+	if (unlikely(PageKsm(page))) {
+		unlock_page_memcg(page);
+		return;
+	}
 
 	/* address might be in next vma when migration races vma_adjust */
 	if (first)
@@ -1181,7 +1187,7 @@ void page_add_new_anon_rmap(struct page *page,
 		/* increment count (starts at -1) */
 		atomic_set(&page->_mapcount, 0);
 	}
-	__mod_node_page_state(page_pgdat(page), NR_ANON_MAPPED, nr);
+	__mod_lruvec_page_state(page, NR_ANON_MAPPED, nr);
 	__page_set_anon_rmap(page, vma, address, 1);
 }
 
@@ -1230,13 +1236,12 @@ static void page_remove_file_rmap(struct page *page, bool compound)
 	int i, nr = 1;
 
 	VM_BUG_ON_PAGE(compound && !PageHead(page), page);
-	lock_page_memcg(page);
 
 	/* Hugepages are not counted in NR_FILE_MAPPED for now. */
 	if (unlikely(PageHuge(page))) {
 		/* hugetlb pages are always mapped with pmds */
 		atomic_dec(compound_mapcount_ptr(page));
-		goto out;
+		return;
 	}
 
 	/* page still mapped by someone else? */
@@ -1246,14 +1251,14 @@ static void page_remove_file_rmap(struct page *page, bool compound)
 				nr++;
 		}
 		if (!atomic_add_negative(-1, compound_mapcount_ptr(page)))
-			goto out;
+			return;
 		if (PageSwapBacked(page))
 			__dec_node_page_state(page, NR_SHMEM_PMDMAPPED);
 		else
 			__dec_node_page_state(page, NR_FILE_PMDMAPPED);
 	} else {
 		if (!atomic_add_negative(-1, &page->_mapcount))
-			goto out;
+			return;
 	}
 
 	/*
@@ -1265,8 +1270,6 @@ static void page_remove_file_rmap(struct page *page, bool compound)
 
 	if (unlikely(PageMlocked(page)))
 		clear_page_mlock(page);
-out:
-	unlock_page_memcg(page);
 }
 
 static void page_remove_anon_compound_rmap(struct page *page)
@@ -1310,7 +1313,7 @@ static void page_remove_anon_compound_rmap(struct page *page)
 		clear_page_mlock(page);
 
 	if (nr)
-		__mod_node_page_state(page_pgdat(page), NR_ANON_MAPPED, -nr);
+		__mod_lruvec_page_state(page, NR_ANON_MAPPED, -nr);
 }
 
 /**
@@ -1322,22 +1325,28 @@ static void page_remove_anon_compound_rmap(struct page *page)
  */
 void page_remove_rmap(struct page *page, bool compound)
 {
-	if (!PageAnon(page))
-		return page_remove_file_rmap(page, compound);
+	lock_page_memcg(page);
 
-	if (compound)
-		return page_remove_anon_compound_rmap(page);
+	if (!PageAnon(page)) {
+		page_remove_file_rmap(page, compound);
+		goto out;
+	}
+
+	if (compound) {
+		page_remove_anon_compound_rmap(page);
+		goto out;
+	}
 
 	/* page still mapped by someone else? */
 	if (!atomic_add_negative(-1, &page->_mapcount))
-		return;
+		goto out;
 
 	/*
 	 * We use the irq-unsafe __{inc|mod}_zone_page_stat because
 	 * these counters are not modified in interrupt context, and
 	 * pte lock(a spinlock) is held, which implies preemption disabled.
 	 */
-	__dec_node_page_state(page, NR_ANON_MAPPED);
+	__dec_lruvec_page_state(page, NR_ANON_MAPPED);
 
 	if (unlikely(PageMlocked(page)))
 		clear_page_mlock(page);
@@ -1354,6 +1363,8 @@ void page_remove_rmap(struct page *page, bool compound)
 	 * Leaving it set also helps swapoff to reinstate ptes
 	 * faster for those pages still in swapcache.
 	 */
+out:
+	unlock_page_memcg(page);
 }
 
 /*
diff --git a/mm/swapfile.c b/mm/swapfile.c
index ad42eac1822d..45b937b924f5 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1886,11 +1886,11 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 	set_pte_at(vma->vm_mm, addr, pte,
 		   pte_mkold(mk_pte(page, vma->vm_page_prot)));
 	if (page == swapcache) {
-		page_add_anon_rmap(page, vma, addr, false);
 		mem_cgroup_commit_charge(page, memcg, true);
+		page_add_anon_rmap(page, vma, addr, false);
 	} else { /* ksm created a completely new copy */
-		page_add_new_anon_rmap(page, vma, addr, false);
 		mem_cgroup_commit_charge(page, memcg, false);
+		page_add_new_anon_rmap(page, vma, addr, false);
 		lru_cache_add_active_or_unevictable(page, vma);
 	}
 	swap_free(entry);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index bb57d0a3fca7..3dea268d2850 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -123,8 +123,8 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 		goto out_release_uncharge_unlock;
 
 	inc_mm_counter(dst_mm, MM_ANONPAGES);
-	page_add_new_anon_rmap(page, dst_vma, dst_addr, false);
 	mem_cgroup_commit_charge(page, memcg, false);
+	page_add_new_anon_rmap(page, dst_vma, dst_addr, false);
 	lru_cache_add_active_or_unevictable(page, dst_vma);
 
 	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
-- 
2.26.2


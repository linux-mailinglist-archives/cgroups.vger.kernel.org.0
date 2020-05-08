Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF0B1CB75B
	for <lists+cgroups@lfdr.de>; Fri,  8 May 2020 20:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgEHSdQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 May 2020 14:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727972AbgEHScc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 May 2020 14:32:32 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DFBC05BD43
        for <cgroups@vger.kernel.org>; Fri,  8 May 2020 11:32:32 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id 59so1224178qva.13
        for <cgroups@vger.kernel.org>; Fri, 08 May 2020 11:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZybKj/hrHeEZIVHdPNsqOos0TY5Kh5D8W8ZpFPXZKJg=;
        b=kJ+YukfhluUDLc43RoMkVCbL0Q/9IsJh96aeSBnqEWw4vGOi1sdbTAI6tEyX1LRg3i
         DjiTUXs5C6/HkaCH37WDNwtHMSHkpkOkxJPf3n++GeKjIkKBMXQNBu56GwVVrXBaNu5Z
         tv1YxvXSvlcttEp3I1POTr+lPJIxwu+u9CT7lAjF1L9jJfcbtXJalSm8KiXQSPhylmiJ
         G8Jfo8O2BNFSC9PwzEeEUrgG+hZ2WayBbCjX04f99C/GEhUB7y3PDHad0aZJXHlf4Ddo
         9tY+yAU94F2q33NNXmdKBD5CxXkFLKK7BIdRMraEpUce1RuSXxVcDiVaf0fX6wRnu9/e
         wTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZybKj/hrHeEZIVHdPNsqOos0TY5Kh5D8W8ZpFPXZKJg=;
        b=eER2Tfx+pR+RfM6tyaDOH1Nq62RaNVuo65zPo/f8+jDT0IsufZ3AAwk+viKzBZHLBz
         Ad7ABaymp1JdYgvkTcAQDsyBFuubelI90t0h+AU8sOwE/gXld13z8cxQRhCjvRH0vQhj
         eymJw53/C1rCPsbtaOocUoqE06r5A6muSAx3HhvekYFyh+Nqi/IkITgpl+RHpgO7aoG5
         k7DOEZ4xl/IbrWTdL3IUKaCpvZpOaCVlnTPxAx2qcSM2WsHj3GA//CGtqegwibGHSKs9
         l49/iXwYbN//y6kg7s5y8tKh0S9gsr1BrTc6jOTrWG17zs1TNC/hTdKv/md+hrfqEmip
         xEWQ==
X-Gm-Message-State: AGi0PuZ+cHScj72iuzGJt4tk8diurZGlolgw4AUO0XSpdhK1D8eM8GvJ
        cps+iKv5Xg7p7QaI8zcbiSuVfg==
X-Google-Smtp-Source: APiQypKiMQIYkuDn2nAgpPV8KxRqOQ2MPk729HS4+PBjvo0k2F8acseFbEwdahC8QWnfscPpNdxDbw==
X-Received: by 2002:a0c:facb:: with SMTP id p11mr4105188qvo.17.1588962751543;
        Fri, 08 May 2020 11:32:31 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2627])
        by smtp.gmail.com with ESMTPSA id y23sm1675968qta.37.2020.05.08.11.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 11:32:30 -0700 (PDT)
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
Subject: [PATCH 11/19] mm: memcontrol: switch to native NR_ANON_THPS counter
Date:   Fri,  8 May 2020 14:30:58 -0400
Message-Id: <20200508183105.225460-12-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508183105.225460-1-hannes@cmpxchg.org>
References: <20200508183105.225460-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

With rmap memcg locking already in place for NR_ANON_MAPPED, it's just
a small step to remove the MEMCG_RSS_HUGE wart and switch memcg to the
native NR_ANON_THPS accounting sites.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/memcontrol.h |  3 +--
 mm/huge_memory.c           |  4 +++-
 mm/memcontrol.c            | 39 ++++++++++++++++----------------------
 mm/rmap.c                  |  6 +++---
 4 files changed, 23 insertions(+), 29 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 2df978a3a253..9b1054bf6d35 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -29,8 +29,7 @@ struct kmem_cache;
 
 /* Cgroup-specific page state, on top of universal node page state */
 enum memcg_stat_item {
-	MEMCG_RSS_HUGE = NR_VM_NODE_STAT_ITEMS,
-	MEMCG_SWAP,
+	MEMCG_SWAP = NR_VM_NODE_STAT_ITEMS,
 	MEMCG_SOCK,
 	/* XXX: why are these zone and not node counters? */
 	MEMCG_KERNEL_STACK_KB,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 07c012d89570..74f8b4013203 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2159,15 +2159,17 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			atomic_inc(&page[i]._mapcount);
 	}
 
+	lock_page_memcg(page);
 	if (atomic_add_negative(-1, compound_mapcount_ptr(page))) {
 		/* Last compound_mapcount is gone. */
-		__dec_node_page_state(page, NR_ANON_THPS);
+		__dec_lruvec_page_state(page, NR_ANON_THPS);
 		if (TestClearPageDoubleMap(page)) {
 			/* No need in mapcount reference anymore */
 			for (i = 0; i < HPAGE_PMD_NR; i++)
 				atomic_dec(&page[i]._mapcount);
 		}
 	}
+	unlock_page_memcg(page);
 
 	smp_wmb(); /* make pte visible before pmd */
 	pmd_populate(mm, pmd, pgtable);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index fccb396ed7bd..fd92c1c99e1f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -836,11 +836,6 @@ static void mem_cgroup_charge_statistics(struct mem_cgroup *memcg,
 					 struct page *page,
 					 int nr_pages)
 {
-	if (abs(nr_pages) > 1) {
-		VM_BUG_ON_PAGE(!PageTransHuge(page), page);
-		__mod_memcg_state(memcg, MEMCG_RSS_HUGE, nr_pages);
-	}
-
 	/* pagein of a big page is an event. So, ignore page size */
 	if (nr_pages > 0)
 		__count_memcg_events(memcg, PGPGIN, 1);
@@ -1406,15 +1401,9 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
 		       (u64)memcg_page_state(memcg, NR_WRITEBACK) *
 		       PAGE_SIZE);
 
-	/*
-	 * TODO: We should eventually replace our own MEMCG_RSS_HUGE counter
-	 * with the NR_ANON_THP vm counter, but right now it's a pain in the
-	 * arse because it requires migrating the work out of rmap to a place
-	 * where the page->mem_cgroup is set up and stable.
-	 */
 	seq_buf_printf(&s, "anon_thp %llu\n",
-		       (u64)memcg_page_state(memcg, MEMCG_RSS_HUGE) *
-		       PAGE_SIZE);
+		       (u64)memcg_page_state(memcg, NR_ANON_THPS) *
+		       HPAGE_PMD_NR * PAGE_SIZE);
 
 	for (i = 0; i < NR_LRU_LISTS; i++)
 		seq_buf_printf(&s, "%s %llu\n", lru_list_name(i),
@@ -3006,8 +2995,6 @@ void mem_cgroup_split_huge_fixup(struct page *head)
 
 	for (i = 1; i < HPAGE_PMD_NR; i++)
 		head[i].mem_cgroup = head->mem_cgroup;
-
-	__mod_memcg_state(head->mem_cgroup, MEMCG_RSS_HUGE, -HPAGE_PMD_NR);
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
@@ -3763,7 +3750,7 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
 static const unsigned int memcg1_stats[] = {
 	NR_FILE_PAGES,
 	NR_ANON_MAPPED,
-	MEMCG_RSS_HUGE,
+	NR_ANON_THPS,
 	NR_SHMEM,
 	NR_FILE_MAPPED,
 	NR_FILE_DIRTY,
@@ -3800,11 +3787,14 @@ static int memcg_stat_show(struct seq_file *m, void *v)
 	BUILD_BUG_ON(ARRAY_SIZE(memcg1_stat_names) != ARRAY_SIZE(memcg1_stats));
 
 	for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++) {
+		unsigned long nr;
+
 		if (memcg1_stats[i] == MEMCG_SWAP && !do_memsw_account())
 			continue;
-		seq_printf(m, "%s %lu\n", memcg1_stat_names[i],
-			   memcg_page_state_local(memcg, memcg1_stats[i]) *
-			   PAGE_SIZE);
+		nr = memcg_page_state_local(memcg, memcg1_stats[i]);
+		if (memcg1_stats[i] == NR_ANON_THPS)
+			nr *= HPAGE_PMD_NR;
+		seq_printf(m, "%s %lu\n", memcg1_stat_names[i], nr * PAGE_SIZE);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(memcg1_events); i++)
@@ -5396,6 +5386,13 @@ static int mem_cgroup_move_account(struct page *page,
 		if (page_mapped(page)) {
 			__mod_lruvec_state(from_vec, NR_ANON_MAPPED, -nr_pages);
 			__mod_lruvec_state(to_vec, NR_ANON_MAPPED, nr_pages);
+			if (PageTransHuge(page)) {
+				__mod_lruvec_state(from_vec, NR_ANON_THPS,
+						   -nr_pages);
+				__mod_lruvec_state(to_vec, NR_ANON_THPS,
+						   nr_pages);
+			}
+
 		}
 	} else {
 		__mod_lruvec_state(from_vec, NR_FILE_PAGES, -nr_pages);
@@ -6612,7 +6609,6 @@ struct uncharge_gather {
 	unsigned long nr_pages;
 	unsigned long pgpgout;
 	unsigned long nr_kmem;
-	unsigned long nr_huge;
 	struct page *dummy_page;
 };
 
@@ -6635,7 +6631,6 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 	}
 
 	local_irq_save(flags);
-	__mod_memcg_state(ug->memcg, MEMCG_RSS_HUGE, -ug->nr_huge);
 	__count_memcg_events(ug->memcg, PGPGOUT, ug->pgpgout);
 	__this_cpu_add(ug->memcg->vmstats_percpu->nr_page_events, ug->nr_pages);
 	memcg_check_events(ug->memcg, ug->dummy_page);
@@ -6672,8 +6667,6 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 	ug->nr_pages += nr_pages;
 
 	if (!PageKmemcg(page)) {
-		if (PageTransHuge(page))
-			ug->nr_huge += nr_pages;
 		ug->pgpgout++;
 	} else {
 		ug->nr_kmem += nr_pages;
diff --git a/mm/rmap.c b/mm/rmap.c
index e96f1d099c3f..bd98a995c573 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1138,7 +1138,7 @@ void do_page_add_anon_rmap(struct page *page,
 		 * disabled.
 		 */
 		if (compound)
-			__inc_node_page_state(page, NR_ANON_THPS);
+			__inc_lruvec_page_state(page, NR_ANON_THPS);
 		__mod_lruvec_page_state(page, NR_ANON_MAPPED, nr);
 	}
 
@@ -1180,7 +1180,7 @@ void page_add_new_anon_rmap(struct page *page,
 		if (hpage_pincount_available(page))
 			atomic_set(compound_pincount_ptr(page), 0);
 
-		__inc_node_page_state(page, NR_ANON_THPS);
+		__inc_lruvec_page_state(page, NR_ANON_THPS);
 	} else {
 		/* Anon THP always mapped first with PMD */
 		VM_BUG_ON_PAGE(PageTransCompound(page), page);
@@ -1286,7 +1286,7 @@ static void page_remove_anon_compound_rmap(struct page *page)
 	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
 		return;
 
-	__dec_node_page_state(page, NR_ANON_THPS);
+	__dec_lruvec_page_state(page, NR_ANON_THPS);
 
 	if (TestClearPageDoubleMap(page)) {
 		/*
-- 
2.26.2


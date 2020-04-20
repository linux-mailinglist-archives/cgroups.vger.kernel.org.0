Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1E81B192D
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2020 00:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgDTWMA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Apr 2020 18:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbgDTWMA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Apr 2020 18:12:00 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAB1C061A0C
        for <cgroups@vger.kernel.org>; Mon, 20 Apr 2020 15:11:59 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id g74so12520510qke.13
        for <cgroups@vger.kernel.org>; Mon, 20 Apr 2020 15:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BdaTHSulpE2zzB/6JwXh0SRm1+Npp4vhHduu9et/U1A=;
        b=xocpHaipvx0mCwme5RQ47EmCDwQi1yM3HT4rUVXaDLYLh128h4u1qiplVjhVhbrUqC
         wVg+/YC4tXEYTAKaVexd/suB8x0QK0G7r3Lz/AYX5KO4WOTZCa6E3XSfsJXfsYExhsiq
         qtPmOjTGmN7+QaFpwjdAT/9ox2GgFf2mB2CTOzWCJXFxy/0fFqzKXyFje0Hwust0ctMF
         YUBONAB4URfOnaPcylTrgwLe5uFsygDWxenDouuIvb+Y8hd57kgO4SZAfVU/7Vpwm9z4
         FoDaC2Tk2oa+gJ9FkF3niuzUpt14UxGOLgOeYCSXsP6pUBLjyb0AbZxIgd9biwiOy3GU
         FBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BdaTHSulpE2zzB/6JwXh0SRm1+Npp4vhHduu9et/U1A=;
        b=Ysx++dMj32PhbmMXxlsZIvPIHAUbYTDsHcjqoweowy53YCrfRdk7WWhSU4S2ObaqtR
         qwFzeDKjFevq0z9Y6DgjJg0LEv8mjJ7VMu0PRUNxtbaoUdma/jhxfmrcTfyO6SNcAU6L
         97jNQCZPJoMCgN+U0EPHDD9bcxpqb1wD/BK7RbtzVF5nBPhMCT9KW2p5WDtw1A/gULRL
         39uh1eXBxXK8WzlyMIUDQyEDnnBbeTQnROQDzja62RgTpwlaMG5nHaDYJOFOH/rEnMMc
         AaxUcuGq1kzvx2sZRbnLEzcTUlRKn8kRYFvm2qtKwZakkEpbhaFzE1z84UgqJ+MKvIs+
         Ebcg==
X-Gm-Message-State: AGi0PuY+6G9G28t7tV9sFlHr1EOdmYbcns3Btb8kSFaTQN2tFPE6WfPD
        VvxvCaQxizO3ylvWXquWP5DaLg==
X-Google-Smtp-Source: APiQypLq3RPjEYYXidJlHsDmMgeGRdsRhgYNiFhqZPobAOyPq6LL6Z5JpCDKEWPhM2gFjsQBCqRfVQ==
X-Received: by 2002:a37:614a:: with SMTP id v71mr9999616qkb.326.1587420718979;
        Mon, 20 Apr 2020 15:11:58 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:e6b6])
        by smtp.gmail.com with ESMTPSA id b1sm585956qkf.103.2020.04.20.15.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 15:11:58 -0700 (PDT)
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
Subject: [PATCH 10/18] mm: memcontrol: switch to native NR_ANON_MAPPED counter
Date:   Mon, 20 Apr 2020 18:11:18 -0400
Message-Id: <20200420221126.341272-11-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200420221126.341272-1-hannes@cmpxchg.org>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
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
set up at charge time.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/memcontrol.h |  3 +--
 mm/memcontrol.c            | 27 ++++++++--------------
 mm/rmap.c                  | 47 +++++++++++++++++++++++---------------
 3 files changed, 39 insertions(+), 38 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index c44aa1ccf553..bfb1d961e346 100644
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
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7e77166cf10b..c87178d6219f 100644
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
@@ -3768,7 +3761,7 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
 
 static const unsigned int memcg1_stats[] = {
 	NR_FILE_PAGES,
-	MEMCG_RSS,
+	NR_ANON_MAPPED,
 	MEMCG_RSS_HUGE,
 	NR_SHMEM,
 	NR_FILE_MAPPED,
@@ -5395,7 +5388,12 @@ static int mem_cgroup_move_account(struct page *page,
 
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
 
@@ -6529,7 +6527,6 @@ void mem_cgroup_commit_charge(struct page *page, struct mem_cgroup *memcg,
 {
 	unsigned int nr_pages = hpage_nr_pages(page);
 
-	VM_BUG_ON_PAGE(!page->mapping, page);
 	VM_BUG_ON_PAGE(PageLRU(page) && !lrucare, page);
 
 	if (mem_cgroup_disabled())
@@ -6602,8 +6599,6 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask,
 	struct mem_cgroup *memcg;
 	int ret;
 
-	VM_BUG_ON_PAGE(!page->mapping, page);
-
 	ret = mem_cgroup_try_charge(page, mm, gfp_mask, &memcg);
 	if (ret)
 		return ret;
@@ -6615,7 +6610,6 @@ struct uncharge_gather {
 	struct mem_cgroup *memcg;
 	unsigned long nr_pages;
 	unsigned long pgpgout;
-	unsigned long nr_anon;
 	unsigned long nr_kmem;
 	unsigned long nr_huge;
 	struct page *dummy_page;
@@ -6640,7 +6634,6 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 	}
 
 	local_irq_save(flags);
-	__mod_memcg_state(ug->memcg, MEMCG_RSS, -ug->nr_anon);
 	__mod_memcg_state(ug->memcg, MEMCG_RSS_HUGE, -ug->nr_huge);
 	__count_memcg_events(ug->memcg, PGPGOUT, ug->pgpgout);
 	__this_cpu_add(ug->memcg->vmstats_percpu->nr_page_events, ug->nr_pages);
@@ -6682,8 +6675,6 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 	if (!PageKmemcg(page)) {
 		if (PageTransHuge(page))
 			ug->nr_huge += nr_pages;
-		if (PageAnon(page))
-			ug->nr_anon += nr_pages;
 		ug->pgpgout++;
 	} else {
 		ug->nr_kmem += nr_pages;
diff --git a/mm/rmap.c b/mm/rmap.c
index f79a206b271a..150513d31efa 100644
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
-- 
2.26.0


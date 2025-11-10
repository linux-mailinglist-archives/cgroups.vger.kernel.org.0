Return-Path: <cgroups+bounces-11768-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A96C49BB2
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 00:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E3494EFB5B
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 23:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DD62FFDF5;
	Mon, 10 Nov 2025 23:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X4c+7Vyx"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1815303A03
	for <cgroups@vger.kernel.org>; Mon, 10 Nov 2025 23:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762816881; cv=none; b=pFF2hNmsotJ+D+gFHvZr2qxI9JNckhXLi5DqecJpG9YaR3AITnZXsJJl5+7YlTX3MTnoNoBvoXu0OSfMCjeE/Fx6Cn11eEJYOPtylbs14Aqu87JtG6etNgb2eDXhZhvHrDOZ8pla0Eg1gsuLsVyjgAJO2V3YSpbMtr3JN/sA55Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762816881; c=relaxed/simple;
	bh=xbrd9ny/EOrPz6PNLd/wWUHVuo1aRCdU8KfRKO1WBiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q4W+/RDfxRmvr34oWILksqoK488e2y8iAWoBWkbxkpe3Zxz0yiDA6CAJjti+MCtV6/jTUq2QuiSiPDm0tk9f+Xk201BgdNX6e3Sp6INQeah0QHbNiLDvzTFLgDXchC1qHxnvO+kR//gEd1lPj1DTvfIHCu4MpY2jWwy4qy7LBlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X4c+7Vyx; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762816877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lysW96W1EmnFFHlgmtNEYrJza4enbLaPzVpDvxDjGNQ=;
	b=X4c+7VyxY6HfvIJvlc94nZqVXjd6UGao/+wY3ZSW8aRNNVfIQBFkDBtQKgi0EPUX+AOmpz
	EyOywj6kMmJdY5bFDCW/9ay/25AgeaRzgBZ4JO5btKLtAfePuPV9Jl8k3tMg/1RhpW9y9R
	WSJR52Vcc1McW39v0PLZZvvceHO1+0c=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH 3/4] memcg: remove __mod_lruvec_state
Date: Mon, 10 Nov 2025 15:20:07 -0800
Message-ID: <20251110232008.1352063-4-shakeel.butt@linux.dev>
In-Reply-To: <20251110232008.1352063-1-shakeel.butt@linux.dev>
References: <20251110232008.1352063-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The __mod_lruvec_state is already safe against irqs, so there is no
need to have a separate interface (i.e. mod_lruvec_state) which
wraps calls to it with irq disabling and reenabling. Let's rename
__mod_lruvec_state to mod_lruvec_state.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/mm_inline.h |  2 +-
 include/linux/vmstat.h    | 18 +-----------------
 mm/memcontrol.c           |  8 ++++----
 mm/migrate.c              | 20 ++++++++++----------
 mm/vmscan.c               |  4 ++--
 5 files changed, 18 insertions(+), 34 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 795b255abf65..d7b963255012 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -44,7 +44,7 @@ static __always_inline void __update_lru_size(struct lruvec *lruvec,
 	lockdep_assert_held(&lruvec->lru_lock);
 	WARN_ON_ONCE(nr_pages != (int)nr_pages);
 
-	__mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
+	mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
 	__mod_zone_page_state(&pgdat->node_zones[zid],
 				NR_ZONE_LRU_BASE + lru, nr_pages);
 }
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 11a37aaa4dd9..4eb7753e6e5c 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -520,19 +520,9 @@ static inline const char *vm_event_name(enum vm_event_item item)
 
 #ifdef CONFIG_MEMCG
 
-void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
+void mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 			int val);
 
-static inline void mod_lruvec_state(struct lruvec *lruvec,
-				    enum node_stat_item idx, int val)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	__mod_lruvec_state(lruvec, idx, val);
-	local_irq_restore(flags);
-}
-
 void __lruvec_stat_mod_folio(struct folio *folio,
 			     enum node_stat_item idx, int val);
 
@@ -554,12 +544,6 @@ static inline void mod_lruvec_page_state(struct page *page,
 
 #else
 
-static inline void __mod_lruvec_state(struct lruvec *lruvec,
-				      enum node_stat_item idx, int val)
-{
-	mod_node_page_state(lruvec_pgdat(lruvec), idx, val);
-}
-
 static inline void mod_lruvec_state(struct lruvec *lruvec,
 				    enum node_stat_item idx, int val)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3a59d3ee92a7..c31074e5852b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -757,7 +757,7 @@ static void mod_memcg_lruvec_state(struct lruvec *lruvec,
 }
 
 /**
- * __mod_lruvec_state - update lruvec memory statistics
+ * mod_lruvec_state - update lruvec memory statistics
  * @lruvec: the lruvec
  * @idx: the stat item
  * @val: delta to add to the counter, can be negative
@@ -766,7 +766,7 @@ static void mod_memcg_lruvec_state(struct lruvec *lruvec,
  * function updates the all three counters that are affected by a
  * change of state at this level: per-node, per-cgroup, per-lruvec.
  */
-void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
+void mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 			int val)
 {
 	/* Update node */
@@ -794,7 +794,7 @@ void __lruvec_stat_mod_folio(struct folio *folio, enum node_stat_item idx,
 	}
 
 	lruvec = mem_cgroup_lruvec(memcg, pgdat);
-	__mod_lruvec_state(lruvec, idx, val);
+	mod_lruvec_state(lruvec, idx, val);
 	rcu_read_unlock();
 }
 EXPORT_SYMBOL(__lruvec_stat_mod_folio);
@@ -818,7 +818,7 @@ void mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val)
 		mod_node_page_state(pgdat, idx, val);
 	} else {
 		lruvec = mem_cgroup_lruvec(memcg, pgdat);
-		__mod_lruvec_state(lruvec, idx, val);
+		mod_lruvec_state(lruvec, idx, val);
 	}
 	rcu_read_unlock();
 }
diff --git a/mm/migrate.c b/mm/migrate.c
index 567dfae4d9f8..be00c3c82f3a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -675,27 +675,27 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 		old_lruvec = mem_cgroup_lruvec(memcg, oldzone->zone_pgdat);
 		new_lruvec = mem_cgroup_lruvec(memcg, newzone->zone_pgdat);
 
-		__mod_lruvec_state(old_lruvec, NR_FILE_PAGES, -nr);
-		__mod_lruvec_state(new_lruvec, NR_FILE_PAGES, nr);
+		mod_lruvec_state(old_lruvec, NR_FILE_PAGES, -nr);
+		mod_lruvec_state(new_lruvec, NR_FILE_PAGES, nr);
 		if (folio_test_swapbacked(folio) && !folio_test_swapcache(folio)) {
-			__mod_lruvec_state(old_lruvec, NR_SHMEM, -nr);
-			__mod_lruvec_state(new_lruvec, NR_SHMEM, nr);
+			mod_lruvec_state(old_lruvec, NR_SHMEM, -nr);
+			mod_lruvec_state(new_lruvec, NR_SHMEM, nr);
 
 			if (folio_test_pmd_mappable(folio)) {
-				__mod_lruvec_state(old_lruvec, NR_SHMEM_THPS, -nr);
-				__mod_lruvec_state(new_lruvec, NR_SHMEM_THPS, nr);
+				mod_lruvec_state(old_lruvec, NR_SHMEM_THPS, -nr);
+				mod_lruvec_state(new_lruvec, NR_SHMEM_THPS, nr);
 			}
 		}
 #ifdef CONFIG_SWAP
 		if (folio_test_swapcache(folio)) {
-			__mod_lruvec_state(old_lruvec, NR_SWAPCACHE, -nr);
-			__mod_lruvec_state(new_lruvec, NR_SWAPCACHE, nr);
+			mod_lruvec_state(old_lruvec, NR_SWAPCACHE, -nr);
+			mod_lruvec_state(new_lruvec, NR_SWAPCACHE, nr);
 		}
 #endif
 		if (dirty && mapping_can_writeback(mapping)) {
-			__mod_lruvec_state(old_lruvec, NR_FILE_DIRTY, -nr);
+			mod_lruvec_state(old_lruvec, NR_FILE_DIRTY, -nr);
 			__mod_zone_page_state(oldzone, NR_ZONE_WRITE_PENDING, -nr);
-			__mod_lruvec_state(new_lruvec, NR_FILE_DIRTY, nr);
+			mod_lruvec_state(new_lruvec, NR_FILE_DIRTY, nr);
 			__mod_zone_page_state(newzone, NR_ZONE_WRITE_PENDING, nr);
 		}
 	}
diff --git a/mm/vmscan.c b/mm/vmscan.c
index ba760072830b..b3231bdde4e6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2019,7 +2019,7 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
 	spin_lock_irq(&lruvec->lru_lock);
 	move_folios_to_lru(lruvec, &folio_list);
 
-	__mod_lruvec_state(lruvec, PGDEMOTE_KSWAPD + reclaimer_offset(sc),
+	mod_lruvec_state(lruvec, PGDEMOTE_KSWAPD + reclaimer_offset(sc),
 					stat.nr_demoted);
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
 	item = PGSTEAL_KSWAPD + reclaimer_offset(sc);
@@ -4745,7 +4745,7 @@ static int evict_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
 		reset_batch_size(walk);
 	}
 
-	__mod_lruvec_state(lruvec, PGDEMOTE_KSWAPD + reclaimer_offset(sc),
+	mod_lruvec_state(lruvec, PGDEMOTE_KSWAPD + reclaimer_offset(sc),
 					stat.nr_demoted);
 
 	item = PGSTEAL_KSWAPD + reclaimer_offset(sc);
-- 
2.47.3



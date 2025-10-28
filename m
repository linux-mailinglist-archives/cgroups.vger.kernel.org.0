Return-Path: <cgroups+bounces-11248-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E511EC15108
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 15:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F78C642D0D
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 14:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA297332909;
	Tue, 28 Oct 2025 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ek9b/gCz"
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686E03370F7
	for <cgroups@vger.kernel.org>; Tue, 28 Oct 2025 14:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660145; cv=none; b=ORynxAPCMaav/yeYcqSEz8FlSHc9bjqlbtZ2Yy/A4MBqOvr/MywC25QdD3R9p4hvjB/MSjvFMBiDhiwomNORizvxXP9Ml4zBY2Tk1rQ2Fakmn2C88HyfupMMHoQK5FIxRvkJ7Hl/vH3y7NueKgUtdzm6szvLvcwHZJhk7RMNeA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660145; c=relaxed/simple;
	bh=AWNGi7LTxvG9oHz7t6w+GQBl3pJenLXTwMOmNvqPRSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oE0zk2DbMUbfZ7PX2c+UmLjEbhffW2ygRAtTBX2v3tAEV6/u7Z/zvi883gSR5AKwzDtb6RzC5urmQtwSdwfQ8eoTo0LO84U7mWzfwVD0EhrTpxtEKlQSdXiMTUwOw1nLv+SIQdeaKbd26rL29T3Sh8NiN/xC0EZfIvC3WeoKxv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ek9b/gCz; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761660141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/UKL5kOds3ICU+T2GyTUXmAkx1XUpiy8Su9/vaOkCW0=;
	b=Ek9b/gCzsgxylJugL0ca4VIGAc3IiM8/A2ufsf3dpRjY+iWIyMyPFT1WblHirpEDrp9mp5
	oPD0lv3NYbDv/ox837kWGFkHfrmKV1uWz2fdqB327GIzAEeylU6SiCT29a0aUyVHqVxVC+
	YOMiftSXryOaAvBB38StW/kk2zo0lpI=
From: Qi Zheng <qi.zheng@linux.dev>
To: hannes@cmpxchg.org,
	hughd@google.com,
	mhocko@suse.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	harry.yoo@oracle.com,
	imran.f.khan@oracle.com,
	kamalesh.babulal@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v1 03/26] mm: rename unlock_page_lruvec_irq and its variants
Date: Tue, 28 Oct 2025 21:58:16 +0800
Message-ID: <f68f1ae435edbbc6cfe15448c2df5c4112a4a61c.1761658310.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1761658310.git.zhengqi.arch@bytedance.com>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Muchun Song <songmuchun@bytedance.com>

It is inappropriate to use folio_lruvec_lock() variants in conjunction
with unlock_page_lruvec() variants, as this involves the inconsistent
operation of locking a folio while unlocking a page. To rectify this, the
functions unlock_page_lruvec{_irq, _irqrestore} are renamed to
lruvec_unlock{_irq,_irqrestore}.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/memcontrol.h | 10 +++++-----
 mm/compaction.c            | 14 +++++++-------
 mm/huge_memory.c           |  2 +-
 mm/mlock.c                 |  2 +-
 mm/swap.c                  | 12 ++++++------
 mm/vmscan.c                |  4 ++--
 6 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 8d2e250535a8a..6185d8399a54e 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1493,17 +1493,17 @@ static inline struct lruvec *parent_lruvec(struct lruvec *lruvec)
 	return mem_cgroup_lruvec(memcg, lruvec_pgdat(lruvec));
 }
 
-static inline void unlock_page_lruvec(struct lruvec *lruvec)
+static inline void lruvec_unlock(struct lruvec *lruvec)
 {
 	spin_unlock(&lruvec->lru_lock);
 }
 
-static inline void unlock_page_lruvec_irq(struct lruvec *lruvec)
+static inline void lruvec_unlock_irq(struct lruvec *lruvec)
 {
 	spin_unlock_irq(&lruvec->lru_lock);
 }
 
-static inline void unlock_page_lruvec_irqrestore(struct lruvec *lruvec,
+static inline void lruvec_unlock_irqrestore(struct lruvec *lruvec,
 		unsigned long flags)
 {
 	spin_unlock_irqrestore(&lruvec->lru_lock, flags);
@@ -1525,7 +1525,7 @@ static inline struct lruvec *folio_lruvec_relock_irq(struct folio *folio,
 		if (folio_matches_lruvec(folio, locked_lruvec))
 			return locked_lruvec;
 
-		unlock_page_lruvec_irq(locked_lruvec);
+		lruvec_unlock_irq(locked_lruvec);
 	}
 
 	return folio_lruvec_lock_irq(folio);
@@ -1539,7 +1539,7 @@ static inline void folio_lruvec_relock_irqsave(struct folio *folio,
 		if (folio_matches_lruvec(folio, *lruvecp))
 			return;
 
-		unlock_page_lruvec_irqrestore(*lruvecp, *flags);
+		lruvec_unlock_irqrestore(*lruvecp, *flags);
 	}
 
 	*lruvecp = folio_lruvec_lock_irqsave(folio, flags);
diff --git a/mm/compaction.c b/mm/compaction.c
index 8760d10bd0b32..4dce180f699b4 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -913,7 +913,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		 */
 		if (!(low_pfn % COMPACT_CLUSTER_MAX)) {
 			if (locked) {
-				unlock_page_lruvec_irqrestore(locked, flags);
+				lruvec_unlock_irqrestore(locked, flags);
 				locked = NULL;
 			}
 
@@ -964,7 +964,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			}
 			/* for alloc_contig case */
 			if (locked) {
-				unlock_page_lruvec_irqrestore(locked, flags);
+				lruvec_unlock_irqrestore(locked, flags);
 				locked = NULL;
 			}
 
@@ -1053,7 +1053,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			if (unlikely(page_has_movable_ops(page)) &&
 			    !PageMovableOpsIsolated(page)) {
 				if (locked) {
-					unlock_page_lruvec_irqrestore(locked, flags);
+					lruvec_unlock_irqrestore(locked, flags);
 					locked = NULL;
 				}
 
@@ -1158,7 +1158,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		/* If we already hold the lock, we can skip some rechecking */
 		if (lruvec != locked) {
 			if (locked)
-				unlock_page_lruvec_irqrestore(locked, flags);
+				lruvec_unlock_irqrestore(locked, flags);
 
 			compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);
 			locked = lruvec;
@@ -1226,7 +1226,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 isolate_fail_put:
 		/* Avoid potential deadlock in freeing page under lru_lock */
 		if (locked) {
-			unlock_page_lruvec_irqrestore(locked, flags);
+			lruvec_unlock_irqrestore(locked, flags);
 			locked = NULL;
 		}
 		folio_put(folio);
@@ -1242,7 +1242,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		 */
 		if (nr_isolated) {
 			if (locked) {
-				unlock_page_lruvec_irqrestore(locked, flags);
+				lruvec_unlock_irqrestore(locked, flags);
 				locked = NULL;
 			}
 			putback_movable_pages(&cc->migratepages);
@@ -1274,7 +1274,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 
 isolate_abort:
 	if (locked)
-		unlock_page_lruvec_irqrestore(locked, flags);
+		lruvec_unlock_irqrestore(locked, flags);
 	if (folio) {
 		folio_set_lru(folio);
 		folio_put(folio);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0a826b6e6aa7f..9d3594df6eedf 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4014,7 +4014,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		expected_refs = folio_expected_ref_count(folio) + 1;
 		folio_ref_unfreeze(folio, expected_refs);
 
-		unlock_page_lruvec(lruvec);
+		lruvec_unlock(lruvec);
 
 		if (ci)
 			swap_cluster_unlock(ci);
diff --git a/mm/mlock.c b/mm/mlock.c
index bb0776f5ef7ca..5a81de8dd4875 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -205,7 +205,7 @@ static void mlock_folio_batch(struct folio_batch *fbatch)
 	}
 
 	if (lruvec)
-		unlock_page_lruvec_irq(lruvec);
+		lruvec_unlock_irq(lruvec);
 	folios_put(fbatch);
 }
 
diff --git a/mm/swap.c b/mm/swap.c
index 2260dcd2775e7..ec0c654e128dc 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -91,7 +91,7 @@ static void page_cache_release(struct folio *folio)
 
 	__page_cache_release(folio, &lruvec, &flags);
 	if (lruvec)
-		unlock_page_lruvec_irqrestore(lruvec, flags);
+		lruvec_unlock_irqrestore(lruvec, flags);
 }
 
 void __folio_put(struct folio *folio)
@@ -175,7 +175,7 @@ static void folio_batch_move_lru(struct folio_batch *fbatch, move_fn_t move_fn)
 	}
 
 	if (lruvec)
-		unlock_page_lruvec_irqrestore(lruvec, flags);
+		lruvec_unlock_irqrestore(lruvec, flags);
 	folios_put(fbatch);
 }
 
@@ -349,7 +349,7 @@ void folio_activate(struct folio *folio)
 
 	lruvec = folio_lruvec_lock_irq(folio);
 	lru_activate(lruvec, folio);
-	unlock_page_lruvec_irq(lruvec);
+	lruvec_unlock_irq(lruvec);
 	folio_set_lru(folio);
 }
 #endif
@@ -963,7 +963,7 @@ void folios_put_refs(struct folio_batch *folios, unsigned int *refs)
 
 		if (folio_is_zone_device(folio)) {
 			if (lruvec) {
-				unlock_page_lruvec_irqrestore(lruvec, flags);
+				lruvec_unlock_irqrestore(lruvec, flags);
 				lruvec = NULL;
 			}
 			if (folio_ref_sub_and_test(folio, nr_refs))
@@ -977,7 +977,7 @@ void folios_put_refs(struct folio_batch *folios, unsigned int *refs)
 		/* hugetlb has its own memcg */
 		if (folio_test_hugetlb(folio)) {
 			if (lruvec) {
-				unlock_page_lruvec_irqrestore(lruvec, flags);
+				lruvec_unlock_irqrestore(lruvec, flags);
 				lruvec = NULL;
 			}
 			free_huge_folio(folio);
@@ -991,7 +991,7 @@ void folios_put_refs(struct folio_batch *folios, unsigned int *refs)
 		j++;
 	}
 	if (lruvec)
-		unlock_page_lruvec_irqrestore(lruvec, flags);
+		lruvec_unlock_irqrestore(lruvec, flags);
 	if (!j) {
 		folio_batch_reinit(folios);
 		return;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c922bad2b8fd4..3a1044ce30f1e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1829,7 +1829,7 @@ bool folio_isolate_lru(struct folio *folio)
 		folio_get(folio);
 		lruvec = folio_lruvec_lock_irq(folio);
 		lruvec_del_folio(lruvec, folio);
-		unlock_page_lruvec_irq(lruvec);
+		lruvec_unlock_irq(lruvec);
 		ret = true;
 	}
 
@@ -7849,7 +7849,7 @@ void check_move_unevictable_folios(struct folio_batch *fbatch)
 	if (lruvec) {
 		__count_vm_events(UNEVICTABLE_PGRESCUED, pgrescued);
 		__count_vm_events(UNEVICTABLE_PGSCANNED, pgscanned);
-		unlock_page_lruvec_irq(lruvec);
+		lruvec_unlock_irq(lruvec);
 	} else if (pgscanned) {
 		count_vm_events(UNEVICTABLE_PGSCANNED, pgscanned);
 	}
-- 
2.20.1



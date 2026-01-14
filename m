Return-Path: <cgroups+bounces-13200-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFDCD1E77E
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 12:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BF5B0301C556
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 11:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AC538A705;
	Wed, 14 Jan 2026 11:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="slZ/TAA8"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5197834A797
	for <cgroups@vger.kernel.org>; Wed, 14 Jan 2026 11:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768390552; cv=none; b=Hua+uh/woQFKQC2GfhYQdQ7kK1RxTVrIwnb2R1lN9GBag7mt+WJ3WeJqAkiBXdHqfz0hehKa7anuP4j1RahoikcQMbEnPhdzgqNA/UF6gvZuSs+e/0C/3IjjUIwJ+6A4KbMrfViCR2VpMbwxwWjKhe9zHdHber4GmxMgcp4n+KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768390552; c=relaxed/simple;
	bh=vTwX+VOvDpMiN0UZkoDNkbw/qxPAWL2YeOjuNlJMaeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F12tCFO1qA3z3BePUf8d2jhQFVpeQa87PSIbMhDBH3Xl7Prw11Pl8eIbe5GgM7q564OLsAKUy079EaAuDKqs0JXZ4yyrCHYYUToXOMBFec38o1nZBPAej1ly1vK9waSsGzJKNlKLxRiywhtbofP3f5bcG2Dhif5/EcGSopi4sK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=slZ/TAA8; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768390548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kw4Qx13Tz3w3N8Y7Uh6WKDafDqfBEeECCeDokmS4kMk=;
	b=slZ/TAA86DEIeNudqQJ5V0R8NYkJXXIB125k2oTP7ccdKCy8bXS04PWSXtw/q3syli8p+F
	LyNzkPW9HqixQFPkntiq83ZtVMFOVyQQqwiniNN4kepMhU4FsUu5kByKacVh2APOVbv3dv
	foJ+8zHqPOk2C8Of+uO6G/w5dkwmIAw=
From: Qi Zheng <qi.zheng@linux.dev>
To: hannes@cmpxchg.org,
	hughd@google.com,
	mhocko@suse.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	harry.yoo@oracle.com,
	yosry.ahmed@linux.dev,
	imran.f.khan@oracle.com,
	kamalesh.babulal@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	chenridong@huaweicloud.com,
	mkoutny@suse.com,
	akpm@linux-foundation.org,
	hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com,
	lance.yang@linux.dev
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 24/30] mm: memcontrol: prepare for reparenting LRU pages for lruvec lock
Date: Wed, 14 Jan 2026 19:32:51 +0800
Message-ID: <0252f9acc29d4b1e9b8252dc003aff065c8ac1f6.1768389889.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1768389889.git.zhengqi.arch@bytedance.com>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Muchun Song <songmuchun@bytedance.com>

The following diagram illustrates how to ensure the safety of the folio
lruvec lock when LRU folios undergo reparenting.

In the folio_lruvec_lock(folio) function:
```
    rcu_read_lock();
retry:
    lruvec = folio_lruvec(folio);
    /* There is a possibility of folio reparenting at this point. */
    spin_lock(&lruvec->lru_lock);
    if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
        /*
         * The wrong lruvec lock was acquired, and a retry is required.
         * This is because the folio resides on the parent memcg lruvec
         * list.
         */
        spin_unlock(&lruvec->lru_lock);
        goto retry;
    }

    /* Reaching here indicates that folio_memcg() is stable. */
```

In the memcg_reparent_objcgs(memcg) function:
```
    spin_lock(&lruvec->lru_lock);
    spin_lock(&lruvec_parent->lru_lock);
    /* Transfer folios from the lruvec list to the parent's. */
    spin_unlock(&lruvec_parent->lru_lock);
    spin_unlock(&lruvec->lru_lock);
```

After acquiring the lruvec lock, it is necessary to verify whether
the folio has been reparented. If reparenting has occurred, the new
lruvec lock must be reacquired. During the LRU folio reparenting
process, the lruvec lock will also be acquired (this will be
implemented in a subsequent patch). Therefore, folio_memcg() remains
unchanged while the lruvec lock is held.

Given that lruvec_memcg(lruvec) is always equal to folio_memcg(folio)
after the lruvec lock is acquired, the lruvec_memcg_debug() check is
redundant. Hence, it is removed.

This patch serves as a preparation for the reparenting of LRU folios.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/memcontrol.h | 45 +++++++++++++++++++----------
 include/linux/swap.h       |  1 +
 mm/compaction.c            | 29 +++++++++++++++----
 mm/memcontrol.c            | 59 +++++++++++++++++++++-----------------
 mm/swap.c                  |  4 +++
 5 files changed, 91 insertions(+), 47 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 4b6f20dc694ba..26c3c0e375f58 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -742,7 +742,15 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
  * folio_lruvec - return lruvec for isolating/putting an LRU folio
  * @folio: Pointer to the folio.
  *
- * This function relies on folio->mem_cgroup being stable.
+ * Call with rcu_read_lock() held to ensure the lifetime of the returned lruvec.
+ * Note that this alone will NOT guarantee the stability of the folio->lruvec
+ * association; the folio can be reparented to an ancestor if this races with
+ * cgroup deletion.
+ *
+ * Use folio_lruvec_lock() to ensure both lifetime and stability of the binding.
+ * Once a lruvec is locked, folio_lruvec() can be called on other folios, and
+ * their binding is stable if the returned lruvec matches the one the caller has
+ * locked. Useful for lock batching.
  */
 static inline struct lruvec *folio_lruvec(struct folio *folio)
 {
@@ -761,18 +769,15 @@ struct mem_cgroup *get_mem_cgroup_from_current(void);
 struct mem_cgroup *get_mem_cgroup_from_folio(struct folio *folio);
 
 struct lruvec *folio_lruvec_lock(struct folio *folio);
+	__acquires(&lruvec->lru_lock)
+	__acquires(rcu)
 struct lruvec *folio_lruvec_lock_irq(struct folio *folio);
+	__acquires(&lruvec->lru_lock)
+	__acquires(rcu)
 struct lruvec *folio_lruvec_lock_irqsave(struct folio *folio,
 						unsigned long *flags);
-
-#ifdef CONFIG_DEBUG_VM
-void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio);
-#else
-static inline
-void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
-{
-}
-#endif
+	__acquires(&lruvec->lru_lock)
+	__acquires(rcu)
 
 static inline
 struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css){
@@ -1199,11 +1204,6 @@ static inline struct lruvec *folio_lruvec(struct folio *folio)
 	return &pgdat->__lruvec;
 }
 
-static inline
-void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
-{
-}
-
 static inline struct mem_cgroup *parent_mem_cgroup(struct mem_cgroup *memcg)
 {
 	return NULL;
@@ -1262,6 +1262,7 @@ static inline struct lruvec *folio_lruvec_lock(struct folio *folio)
 {
 	struct pglist_data *pgdat = folio_pgdat(folio);
 
+	rcu_read_lock();
 	spin_lock(&pgdat->__lruvec.lru_lock);
 	return &pgdat->__lruvec;
 }
@@ -1270,6 +1271,7 @@ static inline struct lruvec *folio_lruvec_lock_irq(struct folio *folio)
 {
 	struct pglist_data *pgdat = folio_pgdat(folio);
 
+	rcu_read_lock();
 	spin_lock_irq(&pgdat->__lruvec.lru_lock);
 	return &pgdat->__lruvec;
 }
@@ -1279,6 +1281,7 @@ static inline struct lruvec *folio_lruvec_lock_irqsave(struct folio *folio,
 {
 	struct pglist_data *pgdat = folio_pgdat(folio);
 
+	rcu_read_lock();
 	spin_lock_irqsave(&pgdat->__lruvec.lru_lock, *flagsp);
 	return &pgdat->__lruvec;
 }
@@ -1500,24 +1503,36 @@ static inline struct lruvec *parent_lruvec(struct lruvec *lruvec)
 }
 
 static inline void lruvec_lock_irq(struct lruvec *lruvec)
+	__acquires(&lruvec->lru_lock)
+	__acquires(rcu)
 {
+	rcu_read_lock();
 	spin_lock_irq(&lruvec->lru_lock);
 }
 
 static inline void lruvec_unlock(struct lruvec *lruvec)
+	__releases(&lruvec->lru_lock)
+	__releases(rcu)
 {
 	spin_unlock(&lruvec->lru_lock);
+	rcu_read_unlock();
 }
 
 static inline void lruvec_unlock_irq(struct lruvec *lruvec)
+	__releases(&lruvec->lru_lock)
+	__releases(rcu)
 {
 	spin_unlock_irq(&lruvec->lru_lock);
+	rcu_read_unlock();
 }
 
 static inline void lruvec_unlock_irqrestore(struct lruvec *lruvec,
 		unsigned long flags)
+	__releases(&lruvec->lru_lock)
+	__releases(rcu)
 {
 	spin_unlock_irqrestore(&lruvec->lru_lock, flags);
+	rcu_read_unlock();
 }
 
 /* Test requires a stable folio->memcg binding, see folio_memcg() */
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 62fc7499b4089..e60f45b48e74d 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -330,6 +330,7 @@ extern unsigned long totalreserve_pages;
 void lru_note_cost_unlock_irq(struct lruvec *lruvec, bool file,
 		unsigned int nr_io, unsigned int nr_rotated)
 		__releases(lruvec->lru_lock);
+		__releases(rcu)
 void lru_note_cost_refault(struct folio *);
 void folio_add_lru(struct folio *);
 void folio_add_lru_vma(struct folio *, struct vm_area_struct *);
diff --git a/mm/compaction.c b/mm/compaction.c
index c3e338aaa0ffb..3648ce22c8072 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -518,6 +518,24 @@ static bool compact_lock_irqsave(spinlock_t *lock, unsigned long *flags,
 	return true;
 }
 
+static struct lruvec *
+compact_folio_lruvec_lock_irqsave(struct folio *folio, unsigned long *flags,
+				  struct compact_control *cc)
+{
+	struct lruvec *lruvec;
+
+	rcu_read_lock();
+retry:
+	lruvec = folio_lruvec(folio);
+	compact_lock_irqsave(&lruvec->lru_lock, flags, cc);
+	if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
+		spin_unlock_irqrestore(&lruvec->lru_lock, *flags);
+		goto retry;
+	}
+
+	return lruvec;
+}
+
 /*
  * Compaction requires the taking of some coarse locks that are potentially
  * very heavily contended. The lock should be periodically unlocked to avoid
@@ -839,7 +857,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 {
 	pg_data_t *pgdat = cc->zone->zone_pgdat;
 	unsigned long nr_scanned = 0, nr_isolated = 0;
-	struct lruvec *lruvec;
+	struct lruvec *lruvec = NULL;
 	unsigned long flags = 0;
 	struct lruvec *locked = NULL;
 	struct folio *folio = NULL;
@@ -1153,18 +1171,17 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		if (!folio_test_clear_lru(folio))
 			goto isolate_fail_put;
 
-		lruvec = folio_lruvec(folio);
+		if (locked)
+			lruvec = folio_lruvec(folio);
 
 		/* If we already hold the lock, we can skip some rechecking */
-		if (lruvec != locked) {
+		if (lruvec != locked || !locked) {
 			if (locked)
 				lruvec_unlock_irqrestore(locked, flags);
 
-			compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);
+			lruvec = compact_folio_lruvec_lock_irqsave(folio, &flags, cc);
 			locked = lruvec;
 
-			lruvec_memcg_debug(lruvec, folio);
-
 			/*
 			 * Try get exclusive access under lock. If marked for
 			 * skip, the scan is aborted unless the current context
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 548e67dbf2386..a1573600d4188 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1201,23 +1201,6 @@ void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 	}
 }
 
-#ifdef CONFIG_DEBUG_VM
-void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
-{
-	struct mem_cgroup *memcg;
-
-	if (mem_cgroup_disabled())
-		return;
-
-	memcg = folio_memcg(folio);
-
-	if (!memcg)
-		VM_BUG_ON_FOLIO(!mem_cgroup_is_root(lruvec_memcg(lruvec)), folio);
-	else
-		VM_BUG_ON_FOLIO(lruvec_memcg(lruvec) != memcg, folio);
-}
-#endif
-
 /**
  * folio_lruvec_lock - Lock the lruvec for a folio.
  * @folio: Pointer to the folio.
@@ -1227,14 +1210,22 @@ void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
  * - folio_test_lru false
  * - folio frozen (refcount of 0)
  *
- * Return: The lruvec this folio is on with its lock held.
+ * Return: The lruvec this folio is on with its lock held and rcu read lock held.
  */
 struct lruvec *folio_lruvec_lock(struct folio *folio)
+	__acquires(&lruvec->lru_lock)
+	__acquires(rcu)
 {
-	struct lruvec *lruvec = folio_lruvec(folio);
+	struct lruvec *lruvec;
 
+	rcu_read_lock();
+retry:
+	lruvec = folio_lruvec(folio);
 	spin_lock(&lruvec->lru_lock);
-	lruvec_memcg_debug(lruvec, folio);
+	if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
+		spin_unlock(&lruvec->lru_lock);
+		goto retry;
+	}
 
 	return lruvec;
 }
@@ -1249,14 +1240,22 @@ struct lruvec *folio_lruvec_lock(struct folio *folio)
  * - folio frozen (refcount of 0)
  *
  * Return: The lruvec this folio is on with its lock held and interrupts
- * disabled.
+ * disabled and rcu read lock held.
  */
 struct lruvec *folio_lruvec_lock_irq(struct folio *folio)
+	__acquires(&lruvec->lru_lock)
+	__acquires(rcu)
 {
-	struct lruvec *lruvec = folio_lruvec(folio);
+	struct lruvec *lruvec;
 
+	rcu_read_lock();
+retry:
+	lruvec = folio_lruvec(folio);
 	spin_lock_irq(&lruvec->lru_lock);
-	lruvec_memcg_debug(lruvec, folio);
+	if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
+		spin_unlock_irq(&lruvec->lru_lock);
+		goto retry;
+	}
 
 	return lruvec;
 }
@@ -1272,15 +1271,23 @@ struct lruvec *folio_lruvec_lock_irq(struct folio *folio)
  * - folio frozen (refcount of 0)
  *
  * Return: The lruvec this folio is on with its lock held and interrupts
- * disabled.
+ * disabled and rcu read lock held.
  */
 struct lruvec *folio_lruvec_lock_irqsave(struct folio *folio,
 		unsigned long *flags)
+	__acquires(&lruvec->lru_lock)
+	__acquires(rcu)
 {
-	struct lruvec *lruvec = folio_lruvec(folio);
+	struct lruvec *lruvec;
 
+	rcu_read_lock();
+retry:
+	lruvec = folio_lruvec(folio);
 	spin_lock_irqsave(&lruvec->lru_lock, *flags);
-	lruvec_memcg_debug(lruvec, folio);
+	if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
+		spin_unlock_irqrestore(&lruvec->lru_lock, *flags);
+		goto retry;
+	}
 
 	return lruvec;
 }
diff --git a/mm/swap.c b/mm/swap.c
index cb1148a92d8ec..7e53479ca1732 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -240,6 +240,7 @@ void folio_rotate_reclaimable(struct folio *folio)
 void lru_note_cost_unlock_irq(struct lruvec *lruvec, bool file,
 		unsigned int nr_io, unsigned int nr_rotated)
 		__releases(lruvec->lru_lock)
+		__releases(rcu)
 {
 	unsigned long cost;
 
@@ -253,6 +254,7 @@ void lru_note_cost_unlock_irq(struct lruvec *lruvec, bool file,
 	cost = nr_io * SWAP_CLUSTER_MAX + nr_rotated;
 	if (!cost) {
 		spin_unlock_irq(&lruvec->lru_lock);
+		rcu_read_unlock();
 		return;
 	}
 
@@ -284,9 +286,11 @@ void lru_note_cost_unlock_irq(struct lruvec *lruvec, bool file,
 		}
 
 		spin_unlock_irq(&lruvec->lru_lock);
+		rcu_read_unlock();
 		lruvec = parent_lruvec(lruvec);
 		if (!lruvec)
 			break;
+		rcu_read_lock();
 		spin_lock_irq(&lruvec->lru_lock);
 	}
 }
-- 
2.20.1



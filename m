Return-Path: <cgroups+bounces-12413-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EC6CC676A
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 08:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81305303E3D2
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 07:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798E734253F;
	Wed, 17 Dec 2025 07:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tidJtTr2"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27027342537
	for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 07:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765956824; cv=none; b=tSHoIBp54VwcpMyEgdbPjl7QdxAEcZUWwwNiSCkn96XLoF5HPVAeLm1srLCk7UCFG8BzSpEyTjlGhAsSg56xqUbwqDKQTH+WMQ93r4cNIoigaspjgIvxfpVvzcHoKTDpXgN+0bv6ZDObvO2aT5vv5lYLdzCDAK3+Uo76AIebjL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765956824; c=relaxed/simple;
	bh=iZw9sD9n4TGNzBelAqfFvNoggjdYiuQEZV7FLFy86wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nzZNHnXpQVx1HVs3f0nelm8VZ1Jtbo0i85hEsPnpEAW9OBxqpmpYlGoH66VWd300SjYidR3Prmk4Y7olToQdyH5pbxwR1+FLI9Xli6nHj6qGlHCW/+zLmG9bBlttJ6jydGolqLbdiMBa6WUc8SUH67xLOoNIq4qQttFdhO8vmSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tidJtTr2; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765956815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R8YR9gN+9LKeUz1NQLMLCUGYh2Hy/QLvO4JfzYTy1RU=;
	b=tidJtTr2EuymlnKpDmZPd1dmfRgbULwp4WtdUDc16XnyIjODf6yUCldeSWrpQWBTBYp4BY
	UWVJwLpBTE+3v8zXTelxiSGHmsRYdpSlwHHU4p65p7Y3feB/FoZev4ao7VwqCdGH+bHpcJ
	zZOnHwD3qZ4ZgJ2CBPl+BiBu4QdxlHM=
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
Subject: [PATCH v2 23/28] mm: memcontrol: prepare for reparenting LRU pages for lruvec lock
Date: Wed, 17 Dec 2025 15:27:47 +0800
Message-ID: <6d643ea41dd89134eb3c7af96f5bfb3531da7aa7.1765956026.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1765956025.git.zhengqi.arch@bytedance.com>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
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
---
 include/linux/memcontrol.h | 26 ++++++++-----------
 mm/compaction.c            | 29 ++++++++++++++++-----
 mm/memcontrol.c            | 53 +++++++++++++++++++-------------------
 3 files changed, 61 insertions(+), 47 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 69c4bcfb3c3cd..85265b28c5d18 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -740,7 +740,11 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
  * folio_lruvec - return lruvec for isolating/putting an LRU folio
  * @folio: Pointer to the folio.
  *
- * This function relies on folio->mem_cgroup being stable.
+ * The user should hold an rcu read lock to protect lruvec associated with
+ * the folio from being released. But it does not prevent binding stability
+ * between the folio and the returned lruvec from being changed to its parent
+ * or ancestor (e.g. like folio_lruvec_lock() does that holds LRU lock to
+ * prevent the change).
  */
 static inline struct lruvec *folio_lruvec(struct folio *folio)
 {
@@ -763,15 +767,6 @@ struct lruvec *folio_lruvec_lock_irq(struct folio *folio);
 struct lruvec *folio_lruvec_lock_irqsave(struct folio *folio,
 						unsigned long *flags);
 
-#ifdef CONFIG_DEBUG_VM
-void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio);
-#else
-static inline
-void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
-{
-}
-#endif
-
 static inline
 struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css){
 	return css ? container_of(css, struct mem_cgroup, css) : NULL;
@@ -1194,11 +1189,6 @@ static inline struct lruvec *folio_lruvec(struct folio *folio)
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
@@ -1257,6 +1247,7 @@ static inline struct lruvec *folio_lruvec_lock(struct folio *folio)
 {
 	struct pglist_data *pgdat = folio_pgdat(folio);
 
+	rcu_read_lock();
 	spin_lock(&pgdat->__lruvec.lru_lock);
 	return &pgdat->__lruvec;
 }
@@ -1265,6 +1256,7 @@ static inline struct lruvec *folio_lruvec_lock_irq(struct folio *folio)
 {
 	struct pglist_data *pgdat = folio_pgdat(folio);
 
+	rcu_read_lock();
 	spin_lock_irq(&pgdat->__lruvec.lru_lock);
 	return &pgdat->__lruvec;
 }
@@ -1274,6 +1266,7 @@ static inline struct lruvec *folio_lruvec_lock_irqsave(struct folio *folio,
 {
 	struct pglist_data *pgdat = folio_pgdat(folio);
 
+	rcu_read_lock();
 	spin_lock_irqsave(&pgdat->__lruvec.lru_lock, *flagsp);
 	return &pgdat->__lruvec;
 }
@@ -1487,17 +1480,20 @@ static inline struct lruvec *parent_lruvec(struct lruvec *lruvec)
 static inline void lruvec_unlock(struct lruvec *lruvec)
 {
 	spin_unlock(&lruvec->lru_lock);
+	rcu_read_unlock();
 }
 
 static inline void lruvec_unlock_irq(struct lruvec *lruvec)
 {
 	spin_unlock_irq(&lruvec->lru_lock);
+	rcu_read_unlock();
 }
 
 static inline void lruvec_unlock_irqrestore(struct lruvec *lruvec,
 		unsigned long flags)
 {
 	spin_unlock_irqrestore(&lruvec->lru_lock, flags);
+	rcu_read_unlock();
 }
 
 /* Test requires a stable folio->memcg binding, see folio_memcg() */
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
index f2c891c1f49d5..930dacd6ce31a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1184,23 +1184,6 @@ void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
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
@@ -1210,14 +1193,20 @@ void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
  * - folio_test_lru false
  * - folio frozen (refcount of 0)
  *
- * Return: The lruvec this folio is on with its lock held.
+ * Return: The lruvec this folio is on with its lock held and rcu read lock held.
  */
 struct lruvec *folio_lruvec_lock(struct folio *folio)
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
@@ -1232,14 +1221,20 @@ struct lruvec *folio_lruvec_lock(struct folio *folio)
  * - folio frozen (refcount of 0)
  *
  * Return: The lruvec this folio is on with its lock held and interrupts
- * disabled.
+ * disabled and rcu read lock held.
  */
 struct lruvec *folio_lruvec_lock_irq(struct folio *folio)
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
@@ -1255,15 +1250,21 @@ struct lruvec *folio_lruvec_lock_irq(struct folio *folio)
  * - folio frozen (refcount of 0)
  *
  * Return: The lruvec this folio is on with its lock held and interrupts
- * disabled.
+ * disabled and rcu read lock held.
  */
 struct lruvec *folio_lruvec_lock_irqsave(struct folio *folio,
 		unsigned long *flags)
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
-- 
2.20.1



Return-Path: <cgroups+bounces-13708-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPsiMC1ehGnS2gMAu9opvQ
	(envelope-from <cgroups+bounces-13708-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 05 Feb 2026 10:09:01 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B46AF0514
	for <lists+cgroups@lfdr.de>; Thu, 05 Feb 2026 10:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A1233022F5E
	for <lists+cgroups@lfdr.de>; Thu,  5 Feb 2026 09:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D661395D9A;
	Thu,  5 Feb 2026 09:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="my6s5b1t"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D61395D90
	for <cgroups@vger.kernel.org>; Thu,  5 Feb 2026 09:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770282276; cv=none; b=ol/C+WKnrsxgtRQkWK209WyYl9Brw7UOYDBqyd+OfuunNQlP9YH83KawsXwcSbXFrIiLTL2Y357jhgC6aF8kGRn2ZW2X63NLFTL2T7lLKf/LAp1WU8tTB1fub1bcht/GgCLz6PT3LOGyn476CI3bOTjOTm9lVQjNdbfFTgCWVyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770282276; c=relaxed/simple;
	bh=e459BDN3KxeIZ7iaITdx891JMqfj9tvca2M1Pi/cay0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sVgxJSbP63O0Yu2JFfHIwLtrErOrLmlBa8QnX0V9ZRd9NqFqSGCv0Swuk1/gBU/+me1eoQj2Weoi5ktcR55Z8ZAAHpOKNwtzRDqe7YkKT4yP+NedjXBFzQP3LdrMRXKYbQNx+75buv1+u24tEb4hyiOzBcpkhwSEtHy8srHsDw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=my6s5b1t; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770282274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lQ2lnYQpq6fxyua53i27uGM3QlX05nYmVPivITah5Uo=;
	b=my6s5b1t+SBBqKgDCS58v69/iV+t585JExO58aoRwbHaCpn5WeIVHbV+WiCEbZj1hDHwEn
	dboiK4r/3DgknL4rLa917BfPWFEl5gkkphTZxPyuxXx4lrrWgp5La2Qdct4P3kawCkjm3q
	sD4+eDcOK2PGD9t9Hhzh+vTTX6O+r78=
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
	lance.yang@linux.dev,
	bhe@redhat.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 24/31] mm: memcontrol: prepare for reparenting LRU pages for lruvec lock
Date: Thu,  5 Feb 2026 17:01:43 +0800
Message-ID: <e27edb311dda624751cb41860237f290de8c16ae.1770279888.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1770279888.git.zhengqi.arch@bytedance.com>
References: <cover.1770279888.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-13708-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3B46AF0514
X-Rspamd-Action: no action

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
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/memcontrol.h | 51 ++++++++----------------
 include/linux/swap.h       |  3 +-
 mm/compaction.c            | 29 +++++++++++---
 mm/memcontrol.c            | 79 ++++++++++++++++++++++++++++----------
 mm/swap.c                  |  6 ++-
 5 files changed, 104 insertions(+), 64 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 4b6f20dc694ba..3970c102fe741 100644
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
@@ -765,15 +773,6 @@ struct lruvec *folio_lruvec_lock_irq(struct folio *folio);
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
@@ -1199,11 +1198,6 @@ static inline struct lruvec *folio_lruvec(struct folio *folio)
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
@@ -1262,6 +1256,7 @@ static inline struct lruvec *folio_lruvec_lock(struct folio *folio)
 {
 	struct pglist_data *pgdat = folio_pgdat(folio);
 
+	rcu_read_lock();
 	spin_lock(&pgdat->__lruvec.lru_lock);
 	return &pgdat->__lruvec;
 }
@@ -1270,6 +1265,7 @@ static inline struct lruvec *folio_lruvec_lock_irq(struct folio *folio)
 {
 	struct pglist_data *pgdat = folio_pgdat(folio);
 
+	rcu_read_lock();
 	spin_lock_irq(&pgdat->__lruvec.lru_lock);
 	return &pgdat->__lruvec;
 }
@@ -1279,6 +1275,7 @@ static inline struct lruvec *folio_lruvec_lock_irqsave(struct folio *folio,
 {
 	struct pglist_data *pgdat = folio_pgdat(folio);
 
+	rcu_read_lock();
 	spin_lock_irqsave(&pgdat->__lruvec.lru_lock, *flagsp);
 	return &pgdat->__lruvec;
 }
@@ -1499,26 +1496,10 @@ static inline struct lruvec *parent_lruvec(struct lruvec *lruvec)
 	return mem_cgroup_lruvec(memcg, lruvec_pgdat(lruvec));
 }
 
-static inline void lruvec_lock_irq(struct lruvec *lruvec)
-{
-	spin_lock_irq(&lruvec->lru_lock);
-}
-
-static inline void lruvec_unlock(struct lruvec *lruvec)
-{
-	spin_unlock(&lruvec->lru_lock);
-}
-
-static inline void lruvec_unlock_irq(struct lruvec *lruvec)
-{
-	spin_unlock_irq(&lruvec->lru_lock);
-}
-
-static inline void lruvec_unlock_irqrestore(struct lruvec *lruvec,
-		unsigned long flags)
-{
-	spin_unlock_irqrestore(&lruvec->lru_lock, flags);
-}
+void lruvec_lock_irq(struct lruvec *lruvec);
+void lruvec_unlock(struct lruvec *lruvec);
+void lruvec_unlock_irq(struct lruvec *lruvec);
+void lruvec_unlock_irqrestore(struct lruvec *lruvec, unsigned long flags);
 
 /* Test requires a stable folio->memcg binding, see folio_memcg() */
 static inline bool folio_matches_lruvec(struct folio *folio,
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 62fc7499b4089..39ecd25217178 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -328,8 +328,7 @@ extern unsigned long totalreserve_pages;
 
 /* linux/mm/swap.c */
 void lru_note_cost_unlock_irq(struct lruvec *lruvec, bool file,
-		unsigned int nr_io, unsigned int nr_rotated)
-		__releases(lruvec->lru_lock);
+		unsigned int nr_io, unsigned int nr_rotated);
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
index 641c2fa077ccf..115a1f34bcef9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1201,22 +1201,37 @@ void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 	}
 }
 
-#ifdef CONFIG_DEBUG_VM
-void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
+void lruvec_lock_irq(struct lruvec *lruvec)
+	__acquires(&lruvec->lru_lock)
+	__acquires(rcu)
 {
-	struct mem_cgroup *memcg;
+	rcu_read_lock();
+	spin_lock_irq(&lruvec->lru_lock);
+}
 
-	if (mem_cgroup_disabled())
-		return;
+void lruvec_unlock(struct lruvec *lruvec)
+	__releases(&lruvec->lru_lock)
+	__releases(rcu)
+{
+	spin_unlock(&lruvec->lru_lock);
+	rcu_read_unlock();
+}
 
-	memcg = folio_memcg(folio);
+void lruvec_unlock_irq(struct lruvec *lruvec)
+	__releases(&lruvec->lru_lock)
+	__releases(rcu)
+{
+	spin_unlock_irq(&lruvec->lru_lock);
+	rcu_read_unlock();
+}
 
-	if (!memcg)
-		VM_BUG_ON_FOLIO(!mem_cgroup_is_root(lruvec_memcg(lruvec)), folio);
-	else
-		VM_BUG_ON_FOLIO(lruvec_memcg(lruvec) != memcg, folio);
+void lruvec_unlock_irqrestore(struct lruvec *lruvec, unsigned long flags)
+	__releases(&lruvec->lru_lock)
+	__releases(rcu)
+{
+	spin_unlock_irqrestore(&lruvec->lru_lock, flags);
+	rcu_read_unlock();
 }
-#endif
 
 /**
  * folio_lruvec_lock - Lock the lruvec for a folio.
@@ -1227,14 +1242,22 @@ void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
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
@@ -1249,14 +1272,22 @@ struct lruvec *folio_lruvec_lock(struct folio *folio)
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
@@ -1272,15 +1303,23 @@ struct lruvec *folio_lruvec_lock_irq(struct folio *folio)
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
index cb1148a92d8ec..d5bfe6a76ca45 100644
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
 
@@ -285,8 +287,10 @@ void lru_note_cost_unlock_irq(struct lruvec *lruvec, bool file,
 
 		spin_unlock_irq(&lruvec->lru_lock);
 		lruvec = parent_lruvec(lruvec);
-		if (!lruvec)
+		if (!lruvec) {
+			rcu_read_unlock();
 			break;
+		}
 		spin_lock_irq(&lruvec->lru_lock);
 	}
 }
-- 
2.20.1



Return-Path: <cgroups+bounces-7570-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9918AA89237
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 04:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67140189C819
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 02:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF9F1B0430;
	Tue, 15 Apr 2025 02:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fouCe7N9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53A219E967
	for <cgroups@vger.kernel.org>; Tue, 15 Apr 2025 02:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744685289; cv=none; b=EldTYTswo7z13/6m1U36VEZIYQzA/R6UH3qlOk0O2NzwTuCZFap4pju1HoWiX7m0byMVthqxSMQYXLeH24ssRw0GsOgyohJZI1MIRN1h84CigcT0517bpeDl/aGXEXcwdDboZhKB9SoZ6KNj2rd1qBac/7c15nduvAqZCTLygHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744685289; c=relaxed/simple;
	bh=sTTiATuZuhDebCoRqHZETQjvP/LxD7C7zdqE+ikAVAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WHJGbZN/aRXnAGto4Uh/LsGC0QUtHO4Op0ClW1UVc4Nhr1YAM26U9xsqBY8ilC7St/zJtp8MwuvJ3xlugeeQiR+PhAZEbVqKe/ZgLF/EWkKBYpHEqfAGEbXgY+sPxC7rHg3Dbxxb+vDB+O/9sFK0VHQJsAHQ8ZG/H02xKytR2Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fouCe7N9; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-af19b9f4c8cso3564022a12.2
        for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 19:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1744685286; x=1745290086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CpSUB3YDfgeYGmfO/fpEZlFvo0fqwlF+YsT5eAHFtoQ=;
        b=fouCe7N9Fz6S2r/9QDtKPmxM5j/H8o76UNwIAh43qVFeIbNUlI9zSEBT0Qke6SWmvi
         y9ulJIYDhG2ZIkdxn1EURA/fmi3IQ+lGY3RoJmgU1bchVzvt8YP+S92z+O1Zu94rOkM0
         1EDcYUyFu+tkZ6j3v2TLsJoJdkhycE+wkYj0dB5qqVp1dH6usqDA8zJLZsoyuDyS+Kgw
         r5zjcV9dQr9JB2l4YzBI2xtAq6abontUycqAujCzsggEZ+2UTgOjtqfPmTK9SLNt6i4i
         zPN2xo9e+rfjkxnwSP1SgMkHmVq/HUXgmQcqzzCqbxEEJ/phW0F5QEDaA8oueSyXhK6u
         8N+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744685286; x=1745290086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CpSUB3YDfgeYGmfO/fpEZlFvo0fqwlF+YsT5eAHFtoQ=;
        b=rz35YxAAseHIaOe0O5tAflhVAehM2AuMe1/hleLmHLbBoXKfomhmM4R5e4ucR9jca4
         fAC/iHpWTqSRR9BFCSo+fIB0SoEZA5FSP2m8RO8hsyz6bmY/uDpXozeabDh7Z4t/JXZU
         14Ebyw0hlcHnoUkJlhqPBYGrZexF705GRlRtaOKPk5fowMJW1FIHb8ECN9J3+Nd0pOAI
         BYHErQrz+MddehVsLCmoqvv/zJdGy8vTmmm8ymofePH62SAQsGenYKgoRJCM+xTxEBUU
         kQbitbTxMRJMaip+Qh9t6AsX0CFCnjhFgxB02txRM/MCKhh04uBqTiymbmfftxSfm4tl
         tjSg==
X-Forwarded-Encrypted: i=1; AJvYcCXLopcIlY5twOebgrnu34NobsU1G5K6q7/NFlaNpBxpH3stTEa/BmljHeGNewQ0U0c8bJxmhIGc@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5CY4iWI0GGe/QM1c4+CTa1BuSVIFD+cy1ZZ51zSluQ0wMg/Dh
	lpshw93/q3hJQX6PhyJUnLMukfGUJOIJUnRUEDedxiQPCHTV1ccquuju/QKXyKo=
X-Gm-Gg: ASbGncv8Ww3FWZ2ACe7ZXJqIdpw6vFCMo3l1I4lJU69itMLTJaOfszKqU2keQ6EehGj
	BYCg4jP+nmw8RjRv4PTXeCtn2Wz9KtjfhfyTZf9Q/w2RSpFwfCfHc4nGT5fg6aM3LhF+oOZCAl1
	BC5JxE1Lutxwh0JMzb02p1Qjx0kZh9JMz00vxWPnIi9P5JrlI4CGh8gnmCnsR+DVZfRQlbgwWz/
	BdNgpt4xEHS3M5ZuQA0Fv0XJF2rw4MYQ4qMMD3rJnyUiErx+/du9nsRFcTaK+ztKcddYgttTd7e
	V3Zf/wGxlGWQzYW1Smjt7H9/5imFsZJOMlQfCVXAIKQogS9ZAPRryWbtnhC2jlLg/RsC/dZPTj/
	h8iUV13E=
X-Google-Smtp-Source: AGHT+IHgqNDuzvTzNM38ht/Apai59kRy7TIM0/jwQoLjF9IBxI/3XCoQow31pfiiq7WdKcqDsqh+0g==
X-Received: by 2002:a17:902:f78a:b0:224:1eab:97b5 with SMTP id d9443c01a7336-22bea49530dmr219890795ad.1.1744685285756;
        Mon, 14 Apr 2025 19:48:05 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccac49sm106681185ad.217.2025.04.14.19.48.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Apr 2025 19:48:05 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	david@fromorbit.com,
	zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH RFC 24/28] mm: memcontrol: prepare for reparenting LRU pages for lruvec lock
Date: Tue, 15 Apr 2025 10:45:28 +0800
Message-Id: <20250415024532.26632-25-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250415024532.26632-1-songmuchun@bytedance.com>
References: <20250415024532.26632-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 include/linux/memcontrol.h | 23 ++++++-----------
 mm/compaction.c            | 29 ++++++++++++++++-----
 mm/memcontrol.c            | 53 +++++++++++++++++++-------------------
 3 files changed, 58 insertions(+), 47 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 01239147eb11..27b23e464229 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -719,7 +719,11 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
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
@@ -742,15 +746,6 @@ struct lruvec *folio_lruvec_lock_irq(struct folio *folio);
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
@@ -1211,11 +1206,6 @@ static inline struct lruvec *folio_lruvec(struct folio *folio)
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
@@ -1532,17 +1522,20 @@ static inline struct lruvec *parent_lruvec(struct lruvec *lruvec)
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
index ce45d633ddad..4abd1481d5de 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -551,6 +551,24 @@ static bool compact_lock_irqsave(spinlock_t *lock, unsigned long *flags,
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
@@ -872,7 +890,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 {
 	pg_data_t *pgdat = cc->zone->zone_pgdat;
 	unsigned long nr_scanned = 0, nr_isolated = 0;
-	struct lruvec *lruvec;
+	struct lruvec *lruvec = NULL;
 	unsigned long flags = 0;
 	struct lruvec *locked = NULL;
 	struct folio *folio = NULL;
@@ -1189,18 +1207,17 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
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
index 694f19017699..1f0c6e7b69cc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1196,23 +1196,6 @@ void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
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
@@ -1222,14 +1205,20 @@ void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
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
@@ -1244,14 +1233,20 @@ struct lruvec *folio_lruvec_lock(struct folio *folio)
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
@@ -1267,15 +1262,21 @@ struct lruvec *folio_lruvec_lock_irq(struct folio *folio)
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



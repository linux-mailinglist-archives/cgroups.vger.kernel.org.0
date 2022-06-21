Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC305532C0
	for <lists+cgroups@lfdr.de>; Tue, 21 Jun 2022 15:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbiFUM7X (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Jun 2022 08:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351027AbiFUM6Y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Jun 2022 08:58:24 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618E9E24
        for <cgroups@vger.kernel.org>; Tue, 21 Jun 2022 05:58:02 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id r66so7095276pgr.2
        for <cgroups@vger.kernel.org>; Tue, 21 Jun 2022 05:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SlTUvNn4DYl954HH+rppOxcDjVgo6GqCQhQnv1Q1EhI=;
        b=fL58wbGMa2SB+egmCsOvHcDN9eGBoafFpvGg3so9U2DmhwQApgE7KCSCjC0WqjJSEn
         U5vzUEd9XhSPlTzg2SbtZtzSKOqEvUMV1cOHyWmMvvC1jYprYDJl3s9sItS89pDeS9ju
         RecNr0jOEyi1FNnA5SBkQiHhh6ThScEZzdCM/AQHdtKi4/YLil617oq14JDUMS09tcfU
         JhfTJo28sCf+ZmeDAmSLtgBqjE0xZ7p6panlmEzDWBJKFE3B7RHOsAdD+pYq2fj0tFhP
         A3Y94ty0igohGF4sTFirkZWPJzp4qvQtmS9/W3uwgeypNIZuA5gd8Qkxq/Tz6WFjN4ly
         lPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SlTUvNn4DYl954HH+rppOxcDjVgo6GqCQhQnv1Q1EhI=;
        b=HqkmZQrTvMNpgS63p0jCaDX6MFrhzQ2Q6q+ZjObH/3ouUD7fz9m2lyUeHfmmnzHAop
         rTl2CqOCk7rosonPRkh2d5mELbIACbWoX+LKdEn53c5BIvl6nP/d5oiOSbs8UUEbe4WM
         MHM/YiqL/1qA5k/PFcClyUV8fLTaFQvlZ4Slg5gh0wxSv4twrdFwcBT2DvbDU9V4/ftv
         +tptz8xmuzpi0xbr/u9+SFAtEqdLkI0qjUtmzlC8/pFKT7jXLADU/mKHv28DFPQBhJCd
         Yr5YqqM45euEVWlxeqyOnOj0NceJt46uhGuHX2f3WNeljdOryD1wmPRTLoLR3gwKS/Yn
         115A==
X-Gm-Message-State: AJIora8n1CGXLQZmHjlv/D3Xy9yDp+YBFIO3OtOJE+qe2tRs+KAerSJc
        31YWs6Lf4MJa6YSI3/Zqy1fFhQ==
X-Google-Smtp-Source: AGRyM1uuuY5reI7WuH0uENLbGB2vH7kDjDFb906OSYMlWq65zYFJjEPKnW83COUBx7RaIXd8cyjJnw==
X-Received: by 2002:a05:6a00:c92:b0:51c:1030:5eef with SMTP id a18-20020a056a000c9200b0051c10305eefmr30060253pfv.76.1655816282163;
        Tue, 21 Jun 2022 05:58:02 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id e3-20020a170903240300b0015ea3a491a1sm10643134plo.191.2022.06.21.05.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 05:58:01 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, hannes@cmpxchg.org, longman@redhat.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com
Cc:     cgroups@vger.kernel.org, duanxiongchun@bytedance.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v6 04/11] mm: memcontrol: make lruvec lock safe when LRU pages are reparented
Date:   Tue, 21 Jun 2022 20:56:51 +0800
Message-Id: <20220621125658.64935-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220621125658.64935-1-songmuchun@bytedance.com>
References: <20220621125658.64935-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The diagram below shows how to make the folio lruvec lock safe when LRU
pages are reparented.

folio_lruvec_lock(folio)
	rcu_read_lock();
    retry:
	lruvec = folio_lruvec(folio);

        // The folio is reparented at this time.
        spin_lock(&lruvec->lru_lock);

        if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio)))
            // Acquired the wrong lruvec lock and need to retry.
            // Because this folio is on the parent memcg lruvec list.
            spin_unlock(&lruvec->lru_lock);
	    goto retry;

        // If we reach here, it means that folio_memcg(folio) is stable.

memcg_reparent_objcgs(memcg)
    // lruvec belongs to memcg and lruvec_parent belongs to parent memcg.
    spin_lock(&lruvec->lru_lock);
    spin_lock(&lruvec_parent->lru_lock);

    // Move all the pages from the lruvec list to the parent lruvec list.

    spin_unlock(&lruvec_parent->lru_lock);
    spin_unlock(&lruvec->lru_lock);

After we acquire the lruvec lock, we need to check whether the folio is
reparented. If so, we need to reacquire the new lruvec lock. On the
routine of the LRU pages reparenting, we will also acquire the lruvec
lock (will be implemented in the later patch). So folio_memcg() cannot
be changed when we hold the lruvec lock.

Since lruvec_memcg(lruvec) is always equal to folio_memcg(folio) after
we hold the lruvec lock, lruvec_memcg_debug() check is pointless. So
remove it.

This is a preparation for reparenting the LRU pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h | 18 +++-------------
 mm/compaction.c            | 27 +++++++++++++++++++----
 mm/memcontrol.c            | 53 ++++++++++++++++++++++++++--------------------
 mm/swap.c                  |  5 +++++
 4 files changed, 61 insertions(+), 42 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 111eda6ff1ce..ff3106eca6f3 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -758,7 +758,9 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
  * folio_lruvec - return lruvec for isolating/putting an LRU folio
  * @folio: Pointer to the folio.
  *
- * This function relies on folio->mem_cgroup being stable.
+ * The lruvec can be changed to its parent lruvec when the page reparented.
+ * The caller need to recheck if it cares about this changes (just like
+ * folio_lruvec_lock() does).
  */
 static inline struct lruvec *folio_lruvec(struct folio *folio)
 {
@@ -777,15 +779,6 @@ struct lruvec *folio_lruvec_lock_irq(struct folio *folio);
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
@@ -1260,11 +1253,6 @@ static inline struct lruvec *folio_lruvec(struct folio *folio)
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
diff --git a/mm/compaction.c b/mm/compaction.c
index 46351a14eed2..fe49ac9aedd8 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -508,6 +508,25 @@ static bool compact_lock_irqsave(spinlock_t *lock, unsigned long *flags,
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
+	rcu_read_unlock();
+
+	return lruvec;
+}
+
 /*
  * Compaction requires the taking of some coarse locks that are potentially
  * very heavily contended. The lock should be periodically unlocked to avoid
@@ -834,6 +853,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 
 	/* Time to isolate some pages for migration */
 	for (; low_pfn < end_pfn; low_pfn++) {
+		struct folio *folio;
 
 		if (skip_on_failure && low_pfn >= next_skip_pfn) {
 			/*
@@ -1055,18 +1075,17 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		if (!TestClearPageLRU(page))
 			goto isolate_fail_put;
 
-		lruvec = folio_lruvec(page_folio(page));
+		folio = page_folio(page);
+		lruvec = folio_lruvec(folio);
 
 		/* If we already hold the lock, we can skip some rechecking */
 		if (lruvec != locked) {
 			if (locked)
 				lruvec_unlock_irqrestore(locked, flags);
 
-			compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);
+			lruvec = compact_folio_lruvec_lock_irqsave(folio, &flags, cc);
 			locked = lruvec;
 
-			lruvec_memcg_debug(lruvec, page_folio(page));
-
 			/* Try get exclusive access under lock */
 			if (!skip_updated) {
 				skip_updated = true;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3c489651d312..6f171480b2f2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1195,23 +1195,6 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 	return ret;
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
-		VM_BUG_ON_FOLIO(lruvec_memcg(lruvec) != root_mem_cgroup, folio);
-	else
-		VM_BUG_ON_FOLIO(lruvec_memcg(lruvec) != memcg, folio);
-}
-#endif
-
 /**
  * folio_lruvec_lock - Lock the lruvec for a folio.
  * @folio: Pointer to the folio.
@@ -1226,10 +1209,18 @@ void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
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
+
+	if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
+		spin_unlock(&lruvec->lru_lock);
+		goto retry;
+	}
+	rcu_read_unlock();
 
 	return lruvec;
 }
@@ -1249,10 +1240,18 @@ struct lruvec *folio_lruvec_lock(struct folio *folio)
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
+
+	if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
+		spin_unlock_irq(&lruvec->lru_lock);
+		goto retry;
+	}
+	rcu_read_unlock();
 
 	return lruvec;
 }
@@ -1274,10 +1273,18 @@ struct lruvec *folio_lruvec_lock_irq(struct folio *folio)
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
+
+	if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
+		spin_unlock_irqrestore(&lruvec->lru_lock, *flags);
+		goto retry;
+	}
+	rcu_read_unlock();
 
 	return lruvec;
 }
diff --git a/mm/swap.c b/mm/swap.c
index 127ef4db394f..987dcbd93ffa 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -337,6 +337,11 @@ void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
 
 void lru_note_cost_folio(struct folio *folio)
 {
+	WARN_ON_ONCE(!rcu_read_lock_held());
+	/*
+	 * The rcu read lock is held by the caller, so we do not need to
+	 * care about the lruvec returned by folio_lruvec() being released.
+	 */
 	lru_note_cost(folio_lruvec(folio), folio_is_file_lru(folio),
 			folio_nr_pages(folio));
 }
-- 
2.11.0


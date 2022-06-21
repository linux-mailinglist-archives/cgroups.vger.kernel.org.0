Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19BB5532A8
	for <lists+cgroups@lfdr.de>; Tue, 21 Jun 2022 14:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351251AbiFUM6w (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Jun 2022 08:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350947AbiFUM6P (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Jun 2022 08:58:15 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B437F1AF08
        for <cgroups@vger.kernel.org>; Tue, 21 Jun 2022 05:57:50 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id d129so13037099pgc.9
        for <cgroups@vger.kernel.org>; Tue, 21 Jun 2022 05:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gTiFdIy6o2Yi1gJX4lzQx8P4N9gDSqx+3EHpcopFmMs=;
        b=H6I4gmqjOFEdoEBuSJPzHJ6dCyaEaCmJXpSxrAZPjyTDv2Q8SbONI8KHfphtzLSqAT
         9lc44ETpllLe4mOMH3oB/7XjlxsXvUWOJI2lPGD9OdboEEo7oWRGt/sNWjQjg6uKTUaT
         OOdb2lpx/vJUedABwJ4o/OcHKlu8smj+MJLQbU2n/KlYlyJj9eG75Hj1MsTmf/JkzZra
         PWAdrUqyJuZ9KAi7TS7rUa7eL8821+6CHCEga0i4PVqxW6rgphVWRtshdCB+Q8T8vkBM
         KF9731XEaigVx6tvEzqN6j/Hfbzh2otQQV4EaGCl0EvE7UfQNhJl6MSBUPoAkj5QJX62
         XTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gTiFdIy6o2Yi1gJX4lzQx8P4N9gDSqx+3EHpcopFmMs=;
        b=TSyOle47azvYGoKWZxBBKIHk8IJTabzYJ+3VCOkLiP7tWlaI/tfMPWelDHYDqYZy0U
         gtLDaF9J9bGpl8Ywq9r0Gz6I3mpJCNsGTYxq5CFMlk9nIlHpVkJTLcPEMfYvLx3vmCx/
         Y3TwxEJsyHTySnjVp9fM8dUwagCTz2XpF5hg4/oTn3AnCszSWOHAnNJYiVY8W8XEKamG
         q396MmJ+OqIDYn61FtX12QJry6kofImpgNzbDdFVfIWelibkO4SYXAoTS4HX7xk78rwW
         1rPw554AbZimlQ2jFprHaInP8XI0wz166qxF4FII6J+8VYD3Uake14CHuSRYBXKw51pE
         1ggw==
X-Gm-Message-State: AJIora9PurwUwFoqJ9Qu6AgGa1831LsjSwwpGDAl86MD9oVfH5g1rgCy
        4MVV8WR3KSgCIm/1CNYVV1zO6A==
X-Google-Smtp-Source: AGRyM1vpTJTblWfSYnZ+Nh7sMujWCZHB4wqmjhM8d1a4YN3w990DlToN0ZohIO62P6JEDRcNdGSzyg==
X-Received: by 2002:a63:f453:0:b0:3fc:7939:9654 with SMTP id p19-20020a63f453000000b003fc79399654mr26239787pgk.341.1655816270064;
        Tue, 21 Jun 2022 05:57:50 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id e3-20020a170903240300b0015ea3a491a1sm10643134plo.191.2022.06.21.05.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 05:57:49 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, hannes@cmpxchg.org, longman@redhat.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com
Cc:     cgroups@vger.kernel.org, duanxiongchun@bytedance.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v6 02/11] mm: rename unlock_page_lruvec{_irq, _irqrestore} to lruvec_unlock{_irq, _irqrestore}
Date:   Tue, 21 Jun 2022 20:56:49 +0800
Message-Id: <20220621125658.64935-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220621125658.64935-1-songmuchun@bytedance.com>
References: <20220621125658.64935-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

It is weird to use folio_lruvec_lock() variants and unlock_page_lruvec() variants
together, e.g. locking folio and unlocking page.  So rename
unlock_page_lruvec{_irq, _irqrestore} to lruvec_unlock{_irq, _irqrestore}.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/memcontrol.h | 10 +++++-----
 mm/compaction.c            | 12 ++++++------
 mm/huge_memory.c           |  2 +-
 mm/mlock.c                 |  2 +-
 mm/swap.c                  | 14 +++++++-------
 mm/vmscan.c                |  4 ++--
 6 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 318d8880d62a..d0c0da7cafb7 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1579,17 +1579,17 @@ static inline struct lruvec *parent_lruvec(struct lruvec *lruvec)
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
@@ -1611,7 +1611,7 @@ static inline struct lruvec *folio_lruvec_relock_irq(struct folio *folio,
 		if (folio_matches_lruvec(folio, locked_lruvec))
 			return locked_lruvec;
 
-		unlock_page_lruvec_irq(locked_lruvec);
+		lruvec_unlock_irq(locked_lruvec);
 	}
 
 	return folio_lruvec_lock_irq(folio);
@@ -1625,7 +1625,7 @@ static inline struct lruvec *folio_lruvec_relock_irqsave(struct folio *folio,
 		if (folio_matches_lruvec(folio, locked_lruvec))
 			return locked_lruvec;
 
-		unlock_page_lruvec_irqrestore(locked_lruvec, *flags);
+		lruvec_unlock_irqrestore(locked_lruvec, *flags);
 	}
 
 	return folio_lruvec_lock_irqsave(folio, flags);
diff --git a/mm/compaction.c b/mm/compaction.c
index 1f89b969c12b..46351a14eed2 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -864,7 +864,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		 */
 		if (!(low_pfn % COMPACT_CLUSTER_MAX)) {
 			if (locked) {
-				unlock_page_lruvec_irqrestore(locked, flags);
+				lruvec_unlock_irqrestore(locked, flags);
 				locked = NULL;
 			}
 
@@ -977,7 +977,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			if (unlikely(__PageMovable(page)) &&
 					!PageIsolated(page)) {
 				if (locked) {
-					unlock_page_lruvec_irqrestore(locked, flags);
+					lruvec_unlock_irqrestore(locked, flags);
 					locked = NULL;
 				}
 
@@ -1060,7 +1060,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		/* If we already hold the lock, we can skip some rechecking */
 		if (lruvec != locked) {
 			if (locked)
-				unlock_page_lruvec_irqrestore(locked, flags);
+				lruvec_unlock_irqrestore(locked, flags);
 
 			compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);
 			locked = lruvec;
@@ -1119,7 +1119,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 isolate_fail_put:
 		/* Avoid potential deadlock in freeing page under lru_lock */
 		if (locked) {
-			unlock_page_lruvec_irqrestore(locked, flags);
+			lruvec_unlock_irqrestore(locked, flags);
 			locked = NULL;
 		}
 		put_page(page);
@@ -1135,7 +1135,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		 */
 		if (nr_isolated) {
 			if (locked) {
-				unlock_page_lruvec_irqrestore(locked, flags);
+				lruvec_unlock_irqrestore(locked, flags);
 				locked = NULL;
 			}
 			putback_movable_pages(&cc->migratepages);
@@ -1167,7 +1167,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 
 isolate_abort:
 	if (locked)
-		unlock_page_lruvec_irqrestore(locked, flags);
+		lruvec_unlock_irqrestore(locked, flags);
 	if (page) {
 		SetPageLRU(page);
 		put_page(page);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2e2a8b5bc567..66d9ed8a1289 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2515,7 +2515,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	}
 
 	ClearPageCompound(head);
-	unlock_page_lruvec(lruvec);
+	lruvec_unlock(lruvec);
 	/* Caller disabled irqs, so they are still disabled here */
 
 	split_page_owner(head, nr);
diff --git a/mm/mlock.c b/mm/mlock.c
index 7032f6dd0ce1..d9039fb9c56b 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -205,7 +205,7 @@ static void mlock_pagevec(struct pagevec *pvec)
 	}
 
 	if (lruvec)
-		unlock_page_lruvec_irq(lruvec);
+		lruvec_unlock_irq(lruvec);
 	release_pages(pvec->pages, pvec->nr);
 	pagevec_reinit(pvec);
 }
diff --git a/mm/swap.c b/mm/swap.c
index 1f563d857768..127ef4db394f 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -86,7 +86,7 @@ static void __page_cache_release(struct folio *folio)
 		lruvec = folio_lruvec_lock_irqsave(folio, &flags);
 		lruvec_del_folio(lruvec, folio);
 		__folio_clear_lru_flags(folio);
-		unlock_page_lruvec_irqrestore(lruvec, flags);
+		lruvec_unlock_irqrestore(lruvec, flags);
 	}
 	/* See comment on folio_test_mlocked in release_pages() */
 	if (unlikely(folio_test_mlocked(folio))) {
@@ -249,7 +249,7 @@ static void folio_batch_move_lru(struct folio_batch *fbatch, move_fn_t move_fn)
 	}
 
 	if (lruvec)
-		unlock_page_lruvec_irqrestore(lruvec, flags);
+		lruvec_unlock_irqrestore(lruvec, flags);
 	folios_put(fbatch->folios, folio_batch_count(fbatch));
 	folio_batch_init(fbatch);
 }
@@ -392,7 +392,7 @@ static void folio_activate(struct folio *folio)
 	if (folio_test_clear_lru(folio)) {
 		lruvec = folio_lruvec_lock_irq(folio);
 		folio_activate_fn(lruvec, folio);
-		unlock_page_lruvec_irq(lruvec);
+		lruvec_unlock_irq(lruvec);
 		folio_set_lru(folio);
 	}
 }
@@ -948,7 +948,7 @@ void release_pages(struct page **pages, int nr)
 		 * same lruvec. The lock is held only if lruvec != NULL.
 		 */
 		if (lruvec && ++lock_batch == SWAP_CLUSTER_MAX) {
-			unlock_page_lruvec_irqrestore(lruvec, flags);
+			lruvec_unlock_irqrestore(lruvec, flags);
 			lruvec = NULL;
 		}
 
@@ -957,7 +957,7 @@ void release_pages(struct page **pages, int nr)
 
 		if (folio_is_zone_device(folio)) {
 			if (lruvec) {
-				unlock_page_lruvec_irqrestore(lruvec, flags);
+				lruvec_unlock_irqrestore(lruvec, flags);
 				lruvec = NULL;
 			}
 			if (put_devmap_managed_page(&folio->page))
@@ -972,7 +972,7 @@ void release_pages(struct page **pages, int nr)
 
 		if (folio_test_large(folio)) {
 			if (lruvec) {
-				unlock_page_lruvec_irqrestore(lruvec, flags);
+				lruvec_unlock_irqrestore(lruvec, flags);
 				lruvec = NULL;
 			}
 			__folio_put_large(folio);
@@ -1006,7 +1006,7 @@ void release_pages(struct page **pages, int nr)
 		list_add(&folio->lru, &pages_to_free);
 	}
 	if (lruvec)
-		unlock_page_lruvec_irqrestore(lruvec, flags);
+		lruvec_unlock_irqrestore(lruvec, flags);
 
 	mem_cgroup_uncharge_list(&pages_to_free);
 	free_unref_page_list(&pages_to_free);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b68b0216424d..6a554712ef5d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2257,7 +2257,7 @@ int folio_isolate_lru(struct folio *folio)
 		folio_get(folio);
 		lruvec = folio_lruvec_lock_irq(folio);
 		lruvec_del_folio(lruvec, folio);
-		unlock_page_lruvec_irq(lruvec);
+		lruvec_unlock_irq(lruvec);
 		ret = 0;
 	}
 
@@ -4886,7 +4886,7 @@ void check_move_unevictable_pages(struct pagevec *pvec)
 	if (lruvec) {
 		__count_vm_events(UNEVICTABLE_PGRESCUED, pgrescued);
 		__count_vm_events(UNEVICTABLE_PGSCANNED, pgscanned);
-		unlock_page_lruvec_irq(lruvec);
+		lruvec_unlock_irq(lruvec);
 	} else if (pgscanned) {
 		count_vm_events(UNEVICTABLE_PGSCANNED, pgscanned);
 	}
-- 
2.11.0


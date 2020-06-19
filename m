Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5185D20041E
	for <lists+cgroups@lfdr.de>; Fri, 19 Jun 2020 10:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731854AbgFSIfu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Jun 2020 04:35:50 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:54469 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731587AbgFSIe3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 19 Jun 2020 04:34:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0U01BjYa_1592555662;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U01BjYa_1592555662)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 19 Jun 2020 16:34:22 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
Subject: [PATCH v13 09/18] mm/swap: fold vm event PGROTATED into pagevec_move_tail_fn
Date:   Fri, 19 Jun 2020 16:33:47 +0800
Message-Id: <1592555636-115095-10-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1592555636-115095-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1592555636-115095-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Fold the PGROTATED event collection into pagevec_move_tail_fn call back
func like other funcs does in pagevec_lru_move_fn. Now all usage of
pagevec_lru_move_fn are same and no needs of the 3rd parameter.

It's simply the calling.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/swap.c | 64 +++++++++++++++++++++++----------------------------------------
 1 file changed, 23 insertions(+), 41 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 03a5cad29d03..e2a9f58a2826 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -204,8 +204,7 @@ int get_kernel_page(unsigned long start, int write, struct page **pages)
 EXPORT_SYMBOL_GPL(get_kernel_page);
 
 static void pagevec_lru_move_fn(struct pagevec *pvec,
-	void (*move_fn)(struct page *page, struct lruvec *lruvec, void *arg),
-	void *arg)
+	void (*move_fn)(struct page *page, struct lruvec *lruvec))
 {
 	int i;
 	struct pglist_data *pgdat = NULL;
@@ -224,7 +223,7 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
 		}
 
 		lruvec = mem_cgroup_page_lruvec(page, pgdat);
-		(*move_fn)(page, lruvec, arg);
+		(*move_fn)(page, lruvec);
 	}
 	if (pgdat)
 		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
@@ -232,35 +231,23 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
 	pagevec_reinit(pvec);
 }
 
-static void pagevec_move_tail_fn(struct page *page, struct lruvec *lruvec,
-				 void *arg)
+static void pagevec_move_tail_fn(struct page *page, struct lruvec *lruvec)
 {
-	int *pgmoved = arg;
-
 	if (PageLRU(page) && !PageUnevictable(page)) {
 		del_page_from_lru_list(page, lruvec, page_lru(page));
 		ClearPageActive(page);
 		add_page_to_lru_list_tail(page, lruvec, page_lru(page));
-		(*pgmoved) += hpage_nr_pages(page);
+		__count_vm_events(PGROTATED, hpage_nr_pages(page));
 	}
 }
 
 /*
- * pagevec_move_tail() must be called with IRQ disabled.
- * Otherwise this may cause nasty races.
- */
-static void pagevec_move_tail(struct pagevec *pvec)
-{
-	int pgmoved = 0;
-
-	pagevec_lru_move_fn(pvec, pagevec_move_tail_fn, &pgmoved);
-	__count_vm_events(PGROTATED, pgmoved);
-}
-
-/*
  * Writeback is about to end against a page which has been marked for immediate
  * reclaim.  If it still appears to be reclaimable, move it to the tail of the
  * inactive list.
+ *
+ * pagevec_move_tail_fn() must be called with IRQ disabled.
+ * Otherwise this may cause nasty races.
  */
 void rotate_reclaimable_page(struct page *page)
 {
@@ -273,7 +260,7 @@ void rotate_reclaimable_page(struct page *page)
 		local_lock_irqsave(&lru_rotate.lock, flags);
 		pvec = this_cpu_ptr(&lru_rotate.pvec);
 		if (!pagevec_add(pvec, page) || PageCompound(page))
-			pagevec_move_tail(pvec);
+			pagevec_lru_move_fn(pvec, pagevec_move_tail_fn);
 		local_unlock_irqrestore(&lru_rotate.lock, flags);
 	}
 }
@@ -315,8 +302,7 @@ void lru_note_cost_page(struct page *page)
 		      page_is_file_lru(page), hpage_nr_pages(page));
 }
 
-static void __activate_page(struct page *page, struct lruvec *lruvec,
-			    void *arg)
+static void __activate_page(struct page *page, struct lruvec *lruvec)
 {
 	if (PageLRU(page) && !PageActive(page) && !PageUnevictable(page)) {
 		int lru = page_lru_base_type(page);
@@ -340,7 +326,7 @@ static void activate_page_drain(int cpu)
 	struct pagevec *pvec = &per_cpu(lru_pvecs.activate_page, cpu);
 
 	if (pagevec_count(pvec))
-		pagevec_lru_move_fn(pvec, __activate_page, NULL);
+		pagevec_lru_move_fn(pvec, __activate_page);
 }
 
 static bool need_activate_page_drain(int cpu)
@@ -358,7 +344,7 @@ void activate_page(struct page *page)
 		pvec = this_cpu_ptr(&lru_pvecs.activate_page);
 		get_page(page);
 		if (!pagevec_add(pvec, page) || PageCompound(page))
-			pagevec_lru_move_fn(pvec, __activate_page, NULL);
+			pagevec_lru_move_fn(pvec, __activate_page);
 		local_unlock(&lru_pvecs.lock);
 	}
 }
@@ -527,8 +513,7 @@ void lru_cache_add_active_or_unevictable(struct page *page,
  * be write it out by flusher threads as this is much more effective
  * than the single-page writeout from reclaim.
  */
-static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
-			      void *arg)
+static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec)
 {
 	int lru;
 	bool active;
@@ -575,8 +560,7 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
 	}
 }
 
-static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec,
-			    void *arg)
+static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec)
 {
 	if (PageLRU(page) && PageActive(page) && !PageUnevictable(page)) {
 		int lru = page_lru_base_type(page);
@@ -593,8 +577,7 @@ static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec,
 	}
 }
 
-static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec,
-			    void *arg)
+static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec)
 {
 	if (PageLRU(page) && PageAnon(page) && PageSwapBacked(page) &&
 	    !PageSwapCache(page) && !PageUnevictable(page)) {
@@ -638,21 +621,21 @@ void lru_add_drain_cpu(int cpu)
 
 		/* No harm done if a racing interrupt already did this */
 		local_lock_irqsave(&lru_rotate.lock, flags);
-		pagevec_move_tail(pvec);
+		pagevec_lru_move_fn(pvec, pagevec_move_tail_fn);
 		local_unlock_irqrestore(&lru_rotate.lock, flags);
 	}
 
 	pvec = &per_cpu(lru_pvecs.lru_deactivate_file, cpu);
 	if (pagevec_count(pvec))
-		pagevec_lru_move_fn(pvec, lru_deactivate_file_fn, NULL);
+		pagevec_lru_move_fn(pvec, lru_deactivate_file_fn);
 
 	pvec = &per_cpu(lru_pvecs.lru_deactivate, cpu);
 	if (pagevec_count(pvec))
-		pagevec_lru_move_fn(pvec, lru_deactivate_fn, NULL);
+		pagevec_lru_move_fn(pvec, lru_deactivate_fn);
 
 	pvec = &per_cpu(lru_pvecs.lru_lazyfree, cpu);
 	if (pagevec_count(pvec))
-		pagevec_lru_move_fn(pvec, lru_lazyfree_fn, NULL);
+		pagevec_lru_move_fn(pvec, lru_lazyfree_fn);
 
 	activate_page_drain(cpu);
 }
@@ -681,7 +664,7 @@ void deactivate_file_page(struct page *page)
 		pvec = this_cpu_ptr(&lru_pvecs.lru_deactivate_file);
 
 		if (!pagevec_add(pvec, page) || PageCompound(page))
-			pagevec_lru_move_fn(pvec, lru_deactivate_file_fn, NULL);
+			pagevec_lru_move_fn(pvec, lru_deactivate_file_fn);
 		local_unlock(&lru_pvecs.lock);
 	}
 }
@@ -703,7 +686,7 @@ void deactivate_page(struct page *page)
 		pvec = this_cpu_ptr(&lru_pvecs.lru_deactivate);
 		get_page(page);
 		if (!pagevec_add(pvec, page) || PageCompound(page))
-			pagevec_lru_move_fn(pvec, lru_deactivate_fn, NULL);
+			pagevec_lru_move_fn(pvec, lru_deactivate_fn);
 		local_unlock(&lru_pvecs.lock);
 	}
 }
@@ -725,7 +708,7 @@ void mark_page_lazyfree(struct page *page)
 		pvec = this_cpu_ptr(&lru_pvecs.lru_lazyfree);
 		get_page(page);
 		if (!pagevec_add(pvec, page) || PageCompound(page))
-			pagevec_lru_move_fn(pvec, lru_lazyfree_fn, NULL);
+			pagevec_lru_move_fn(pvec, lru_lazyfree_fn);
 		local_unlock(&lru_pvecs.lock);
 	}
 }
@@ -935,8 +918,7 @@ void __pagevec_release(struct pagevec *pvec)
 }
 EXPORT_SYMBOL(__pagevec_release);
 
-static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
-				 void *arg)
+static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
 {
 	enum lru_list lru;
 	int was_unevictable = TestClearPageUnevictable(page);
@@ -995,7 +977,7 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
  */
 void __pagevec_lru_add(struct pagevec *pvec)
 {
-	pagevec_lru_move_fn(pvec, __pagevec_lru_add_fn, NULL);
+	pagevec_lru_move_fn(pvec, __pagevec_lru_add_fn);
 }
 
 /**
-- 
1.8.3.1


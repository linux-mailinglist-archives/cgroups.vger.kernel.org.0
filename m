Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89E761758DE
	for <lists+cgroups@lfdr.de>; Mon,  2 Mar 2020 12:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbgCBLBK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Mar 2020 06:01:10 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:53448 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727492AbgCBLBJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Mar 2020 06:01:09 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04428;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TrQzvPA_1583146857;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TrQzvPA_1583146857)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 02 Mar 2020 19:00:58 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     cgroups@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com
Cc:     Alex Shi <alex.shi@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 10/20] mm/lru: take PageLRU first in moving page between lru lists
Date:   Mon,  2 Mar 2020 19:00:20 +0800
Message-Id: <1583146830-169516-11-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1583146830-169516-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1583146830-169516-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Current move_fn do moving with PageLRU in lru_lock protection. Moving
include a lru isolation and a lru adding. As to the isolation part,
we need take PageLRU before move_fn, that add a extra PageLRU guard
to block other isolations. and set lru bit back after page settled on
lru list.

This makes TestClearPageLRU as isolation's necessary condition in
page moving between lru lists.

Another page moving between lru lists is check_move_unevictable_pages
func, we need to take PageLRu temporarilly same as move_fn.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/swap.c   | 42 ++++++++++++++++++++++++------------------
 mm/vmscan.c |  3 ++-
 2 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 8e71bdd04a1a..16af7c8369fe 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -187,7 +187,7 @@ int get_kernel_page(unsigned long start, int write, struct page **pages)
 
 static void pagevec_lru_move_fn(struct pagevec *pvec,
 	void (*move_fn)(struct page *page, struct lruvec *lruvec, void *arg),
-	void *arg)
+	void *arg, bool isolation)
 {
 	int i;
 	struct pglist_data *pgdat = NULL;
@@ -198,6 +198,10 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
 		struct page *page = pvec->pages[i];
 		struct pglist_data *pagepgdat = page_pgdat(page);
 
+		if (isolation && !TestClearPageLRU(page))
+			continue;
+
+		/* every page should be isolated from lru */
 		if (pagepgdat != pgdat) {
 			if (pgdat)
 				spin_unlock_irqrestore(&pgdat->lru_lock, flags);
@@ -207,6 +211,9 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
 
 		lruvec = mem_cgroup_page_lruvec(page, pgdat);
 		(*move_fn)(page, lruvec, arg);
+
+		if (isolation)
+			SetPageLRU(page);
 	}
 	if (pgdat)
 		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
@@ -219,7 +226,7 @@ static void pagevec_move_tail_fn(struct page *page, struct lruvec *lruvec,
 {
 	int *pgmoved = arg;
 
-	if (PageLRU(page) && !PageUnevictable(page)) {
+	if (!PageUnevictable(page)) {
 		del_page_from_lru_list(page, lruvec, page_lru(page));
 		ClearPageActive(page);
 		add_page_to_lru_list_tail(page, lruvec, page_lru(page));
@@ -235,7 +242,7 @@ static void pagevec_move_tail(struct pagevec *pvec)
 {
 	int pgmoved = 0;
 
-	pagevec_lru_move_fn(pvec, pagevec_move_tail_fn, &pgmoved);
+	pagevec_lru_move_fn(pvec, pagevec_move_tail_fn, &pgmoved, true);
 	__count_vm_events(PGROTATED, pgmoved);
 }
 
@@ -272,7 +279,7 @@ void update_page_reclaim_stat(struct lruvec *lruvec, int file, int rotated)
 static void __activate_page(struct page *page, struct lruvec *lruvec,
 			    void *arg)
 {
-	if (PageLRU(page) && !PageActive(page) && !PageUnevictable(page)) {
+	if (!PageActive(page) && !PageUnevictable(page)) {
 		int file = page_is_file_cache(page);
 		int lru = page_lru_base_type(page);
 
@@ -293,7 +300,7 @@ static void activate_page_drain(int cpu)
 	struct pagevec *pvec = &per_cpu(activate_page_pvecs, cpu);
 
 	if (pagevec_count(pvec))
-		pagevec_lru_move_fn(pvec, __activate_page, NULL);
+		pagevec_lru_move_fn(pvec, __activate_page, NULL, true);
 }
 
 static bool need_activate_page_drain(int cpu)
@@ -309,7 +316,7 @@ void activate_page(struct page *page)
 
 		get_page(page);
 		if (!pagevec_add(pvec, page) || PageCompound(page))
-			pagevec_lru_move_fn(pvec, __activate_page, NULL);
+			pagevec_lru_move_fn(pvec, __activate_page, NULL, true);
 		put_cpu_var(activate_page_pvecs);
 	}
 }
@@ -501,9 +508,6 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
 	int lru, file;
 	bool active;
 
-	if (!PageLRU(page))
-		return;
-
 	if (PageUnevictable(page))
 		return;
 
@@ -544,7 +548,7 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
 static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec,
 			    void *arg)
 {
-	if (PageLRU(page) && PageActive(page) && !PageUnevictable(page)) {
+	if (PageActive(page) && !PageUnevictable(page)) {
 		int file = page_is_file_cache(page);
 		int lru = page_lru_base_type(page);
 
@@ -561,7 +565,7 @@ static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec,
 static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec,
 			    void *arg)
 {
-	if (PageLRU(page) && PageAnon(page) && PageSwapBacked(page) &&
+	if (PageAnon(page) && PageSwapBacked(page) &&
 	    !PageSwapCache(page) && !PageUnevictable(page)) {
 		bool active = PageActive(page);
 
@@ -607,15 +611,15 @@ void lru_add_drain_cpu(int cpu)
 
 	pvec = &per_cpu(lru_deactivate_file_pvecs, cpu);
 	if (pagevec_count(pvec))
-		pagevec_lru_move_fn(pvec, lru_deactivate_file_fn, NULL);
+		pagevec_lru_move_fn(pvec, lru_deactivate_file_fn, NULL, true);
 
 	pvec = &per_cpu(lru_deactivate_pvecs, cpu);
 	if (pagevec_count(pvec))
-		pagevec_lru_move_fn(pvec, lru_deactivate_fn, NULL);
+		pagevec_lru_move_fn(pvec, lru_deactivate_fn, NULL, true);
 
 	pvec = &per_cpu(lru_lazyfree_pvecs, cpu);
 	if (pagevec_count(pvec))
-		pagevec_lru_move_fn(pvec, lru_lazyfree_fn, NULL);
+		pagevec_lru_move_fn(pvec, lru_lazyfree_fn, NULL, true);
 
 	activate_page_drain(cpu);
 }
@@ -641,7 +645,8 @@ void deactivate_file_page(struct page *page)
 		struct pagevec *pvec = &get_cpu_var(lru_deactivate_file_pvecs);
 
 		if (!pagevec_add(pvec, page) || PageCompound(page))
-			pagevec_lru_move_fn(pvec, lru_deactivate_file_fn, NULL);
+			pagevec_lru_move_fn(pvec,
+					lru_deactivate_file_fn, NULL, true);
 		put_cpu_var(lru_deactivate_file_pvecs);
 	}
 }
@@ -661,7 +666,8 @@ void deactivate_page(struct page *page)
 
 		get_page(page);
 		if (!pagevec_add(pvec, page) || PageCompound(page))
-			pagevec_lru_move_fn(pvec, lru_deactivate_fn, NULL);
+			pagevec_lru_move_fn(pvec,
+					lru_deactivate_fn, NULL, true);
 		put_cpu_var(lru_deactivate_pvecs);
 	}
 }
@@ -681,7 +687,7 @@ void mark_page_lazyfree(struct page *page)
 
 		get_page(page);
 		if (!pagevec_add(pvec, page) || PageCompound(page))
-			pagevec_lru_move_fn(pvec, lru_lazyfree_fn, NULL);
+			pagevec_lru_move_fn(pvec, lru_lazyfree_fn, NULL, true);
 		put_cpu_var(lru_lazyfree_pvecs);
 	}
 }
@@ -941,7 +947,7 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
  */
 void __pagevec_lru_add(struct pagevec *pvec)
 {
-	pagevec_lru_move_fn(pvec, __pagevec_lru_add_fn, NULL);
+	pagevec_lru_move_fn(pvec, __pagevec_lru_add_fn, NULL, false);
 }
 EXPORT_SYMBOL(__pagevec_lru_add);
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index bc2ec3fe4f48..efaa4f41044e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4343,7 +4343,7 @@ void check_move_unevictable_pages(struct pagevec *pvec)
 		}
 		lruvec = mem_cgroup_page_lruvec(page, pgdat);
 
-		if (!PageLRU(page) || !PageUnevictable(page))
+		if (!TestClearPageLRU(page) || !PageUnevictable(page))
 			continue;
 
 		if (page_evictable(page)) {
@@ -4354,6 +4354,7 @@ void check_move_unevictable_pages(struct pagevec *pvec)
 			del_page_from_lru_list(page, lruvec, LRU_UNEVICTABLE);
 			add_page_to_lru_list(page, lruvec, lru);
 			pgrescued++;
+			SetPageLRU(page);
 		}
 	}
 
-- 
1.8.3.1


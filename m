Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91EB51B980C
	for <lists+cgroups@lfdr.de>; Mon, 27 Apr 2020 09:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgD0HEI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Apr 2020 03:04:08 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:45847 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726496AbgD0HEH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Apr 2020 03:04:07 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0Twm2W44_1587971014;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0Twm2W44_1587971014)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 27 Apr 2020 15:03:34 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
Cc:     Alex Shi <alex.shi@linux.alibaba.com>
Subject: [PATCH v10 04/15] mm/thp: move lru_add_page_tail func to huge_memory.c
Date:   Mon, 27 Apr 2020 15:02:53 +0800
Message-Id: <1587970985-21629-5-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1587970985-21629-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1587970985-21629-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The func is only used in huge_memory.c, defining it in other file with a
CONFIG_TRANSPARENT_HUGEPAGE macro restrict just looks weird.

Let's move it close user.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/swap.h |  4 ++--
 mm/huge_memory.c     | 35 +++++++++++++++++++++++++++++++++++
 mm/swap.c            | 41 +----------------------------------------
 3 files changed, 38 insertions(+), 42 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 6ca3adf62fe0..4e13d0bb8e82 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -328,11 +328,11 @@ struct vma_swap_readahead {
 
 
 /* linux/mm/swap.c */
+extern void update_page_reclaim_stat(struct lruvec *lruvec,
+						int file, int rotated);
 extern void lru_cache_add(struct page *);
 extern void lru_cache_add_anon(struct page *page);
 extern void lru_cache_add_file(struct page *page);
-extern void lru_add_page_tail(struct page *page, struct page *page_tail,
-			 struct lruvec *lruvec, struct list_head *head);
 extern void activate_page(struct page *);
 extern void mark_page_accessed(struct page *);
 extern void lru_add_drain(void);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 35a716720e26..ea60340a14c8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2501,6 +2501,41 @@ static void remap_page(struct page *page)
 	}
 }
 
+void lru_add_page_tail(struct page *page, struct page *page_tail,
+		       struct lruvec *lruvec, struct list_head *list)
+{
+	const int file = 0;
+
+	VM_BUG_ON_PAGE(!PageHead(page), page);
+	VM_BUG_ON_PAGE(PageCompound(page_tail), page);
+	VM_BUG_ON_PAGE(PageLRU(page_tail), page);
+	lockdep_assert_held(&lruvec_pgdat(lruvec)->lru_lock);
+
+	if (!list)
+		SetPageLRU(page_tail);
+
+	if (likely(PageLRU(page)))
+		list_add_tail(&page_tail->lru, &page->lru);
+	else if (list) {
+		/* page reclaim is reclaiming a huge page */
+		get_page(page_tail);
+		list_add_tail(&page_tail->lru, list);
+	} else {
+		/*
+		 * Head page has not yet been counted, as an hpage,
+		 * so we must account for each subpage individually.
+		 *
+		 * Put page_tail on the list at the correct position
+		 * so they all end up in order.
+		 */
+		add_page_to_lru_list_tail(page_tail, lruvec,
+					  page_lru(page_tail));
+	}
+
+	if (!PageUnevictable(page))
+		update_page_reclaim_stat(lruvec, file, PageActive(page_tail));
+}
+
 static void __split_huge_page_tail(struct page *head, int tail,
 		struct lruvec *lruvec, struct list_head *list)
 {
diff --git a/mm/swap.c b/mm/swap.c
index bf9a79fed62d..6203e35652f4 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -262,8 +262,7 @@ void rotate_reclaimable_page(struct page *page)
 	}
 }
 
-static void update_page_reclaim_stat(struct lruvec *lruvec,
-				     int file, int rotated)
+void update_page_reclaim_stat(struct lruvec *lruvec, int file, int rotated)
 {
 	struct zone_reclaim_stat *reclaim_stat = &lruvec->reclaim_stat;
 
@@ -885,44 +884,6 @@ void __pagevec_release(struct pagevec *pvec)
 }
 EXPORT_SYMBOL(__pagevec_release);
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-/* used by __split_huge_page_refcount() */
-void lru_add_page_tail(struct page *page, struct page *page_tail,
-		       struct lruvec *lruvec, struct list_head *list)
-{
-	const int file = 0;
-
-	VM_BUG_ON_PAGE(!PageHead(page), page);
-	VM_BUG_ON_PAGE(PageCompound(page_tail), page);
-	VM_BUG_ON_PAGE(PageLRU(page_tail), page);
-	lockdep_assert_held(&lruvec_pgdat(lruvec)->lru_lock);
-
-	if (!list)
-		SetPageLRU(page_tail);
-
-	if (likely(PageLRU(page)))
-		list_add_tail(&page_tail->lru, &page->lru);
-	else if (list) {
-		/* page reclaim is reclaiming a huge page */
-		get_page(page_tail);
-		list_add_tail(&page_tail->lru, list);
-	} else {
-		/*
-		 * Head page has not yet been counted, as an hpage,
-		 * so we must account for each subpage individually.
-		 *
-		 * Put page_tail on the list at the correct position
-		 * so they all end up in order.
-		 */
-		add_page_to_lru_list_tail(page_tail, lruvec,
-					  page_lru(page_tail));
-	}
-
-	if (!PageUnevictable(page))
-		update_page_reclaim_stat(lruvec, file, PageActive(page_tail));
-}
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
-
 static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
 				 void *arg)
 {
-- 
1.8.3.1


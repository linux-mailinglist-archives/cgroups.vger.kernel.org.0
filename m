Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF59B20041D
	for <lists+cgroups@lfdr.de>; Fri, 19 Jun 2020 10:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731882AbgFSIfu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Jun 2020 04:35:50 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:44804 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731600AbgFSIe3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 19 Jun 2020 04:34:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0U01UeXc_1592555660;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U01UeXc_1592555660)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 19 Jun 2020 16:34:20 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
Subject: [PATCH v13 05/18] mm/thp: move lru_add_page_tail func to huge_memory.c
Date:   Fri, 19 Jun 2020 16:33:43 +0800
Message-Id: <1592555636-115095-6-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1592555636-115095-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1592555636-115095-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The func is only used in huge_memory.c, defining it in other file with a
CONFIG_TRANSPARENT_HUGEPAGE macro restrict just looks weird.

Let's move it THP. And make it static as Hugh Dickin suggested.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/swap.h |  2 --
 mm/huge_memory.c     | 30 ++++++++++++++++++++++++++++++
 mm/swap.c            | 33 ---------------------------------
 3 files changed, 30 insertions(+), 35 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 4c5974bb9ba9..29ba748b0d99 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -338,8 +338,6 @@ extern void lru_note_cost(struct lruvec *lruvec, bool file,
 			  unsigned int nr_pages);
 extern void lru_note_cost_page(struct page *);
 extern void lru_cache_add(struct page *);
-extern void lru_add_page_tail(struct page *page, struct page *page_tail,
-			 struct lruvec *lruvec, struct list_head *head);
 extern void activate_page(struct page *);
 extern void mark_page_accessed(struct page *);
 extern void lru_add_drain(void);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 78c84bee7e29..9e050b13f597 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2340,6 +2340,36 @@ static void remap_page(struct page *page)
 	}
 }
 
+static void lru_add_page_tail(struct page *page, struct page *page_tail,
+				struct lruvec *lruvec, struct list_head *list)
+{
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
+}
+
 static void __split_huge_page_tail(struct page *head, int tail,
 		struct lruvec *lruvec, struct list_head *list)
 {
diff --git a/mm/swap.c b/mm/swap.c
index 667133d25e56..03a5cad29d03 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -935,39 +935,6 @@ void __pagevec_release(struct pagevec *pvec)
 }
 EXPORT_SYMBOL(__pagevec_release);
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-/* used by __split_huge_page_refcount() */
-void lru_add_page_tail(struct page *page, struct page *page_tail,
-		       struct lruvec *lruvec, struct list_head *list)
-{
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
-}
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
-
 static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
 				 void *arg)
 {
-- 
1.8.3.1


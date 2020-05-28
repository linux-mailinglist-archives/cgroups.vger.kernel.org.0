Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A711E5DB5
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2020 13:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388207AbgE1LCs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 May 2020 07:02:48 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:40620 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388064AbgE1LBk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 May 2020 07:01:40 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0TztM4bn_1590663686;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TztM4bn_1590663686)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 28 May 2020 19:01:26 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
Cc:     Alex Shi <alex.shi@linux.alibaba.com>
Subject: [PATCH v11 05/16] mm/thp: move lru_add_page_tail func to huge_memory.c
Date:   Thu, 28 May 2020 19:00:47 +0800
Message-Id: <1590663658-184131-6-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1590663658-184131-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1590663658-184131-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The func is only used in huge_memory.c, defining it in other file with a
CONFIG_TRANSPARENT_HUGEPAGE macro restrict just looks weird.

Let's move it THP.

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
index d9e362c7439c..d12ecacce307 100644
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
index 21e6687895e2..4c3990ba29cb 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2316,6 +2316,36 @@ static void remap_page(struct page *page)
 	}
 }
 
+void lru_add_page_tail(struct page *page, struct page *page_tail,
+		       struct lruvec *lruvec, struct list_head *list)
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
index acd88873f076..ffb4ea7b82b5 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -880,39 +880,6 @@ void __pagevec_release(struct pagevec *pvec)
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


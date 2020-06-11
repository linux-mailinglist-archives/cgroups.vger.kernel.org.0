Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D102A1F61A4
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2020 08:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgFKGRl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 11 Jun 2020 02:17:41 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:41616 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726654AbgFKGRQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 11 Jun 2020 02:17:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0U.EqdSY_1591856229;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U.EqdSY_1591856229)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Jun 2020 14:17:10 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: [PATCH v12 11/16] mm/mlock: reorder isolation sequence during munlock
Date:   Thu, 11 Jun 2020 14:16:44 +0800
Message-Id: <1591856209-166869-12-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1591856209-166869-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1591856209-166869-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patch reorder the isolation steps during munlock, move the lru lock
to guard each pages, unfold __munlock_isolate_lru_page func, to do the
preparation for lru lock change.

__split_huge_page_refcount doesn't exist, but we still have to guard
PageMlocked and PageLRU in __split_huge_page_tail.

[lkp@intel.com: found a sleeping function bug ... at mm/rmap.c]
Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/mlock.c | 93 ++++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 51 insertions(+), 42 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 228ba5a8e0a5..7098be122966 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -103,25 +103,6 @@ void mlock_vma_page(struct page *page)
 }
 
 /*
- * Isolate a page from LRU with optional get_page() pin.
- * Assumes lru_lock already held and page already pinned.
- */
-static bool __munlock_isolate_lru_page(struct page *page, bool getpage)
-{
-	if (TestClearPageLRU(page)) {
-		struct lruvec *lruvec;
-
-		lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
-		if (getpage)
-			get_page(page);
-		del_page_from_lru_list(page, lruvec, page_lru(page));
-		return true;
-	}
-
-	return false;
-}
-
-/*
  * Finish munlock after successful page isolation
  *
  * Page must be locked. This is a wrapper for try_to_munlock()
@@ -181,6 +162,7 @@ static void __munlock_isolation_failed(struct page *page)
 unsigned int munlock_vma_page(struct page *page)
 {
 	int nr_pages;
+	bool clearlru = false;
 	pg_data_t *pgdat = page_pgdat(page);
 
 	/* For try_to_munlock() and to serialize with page migration */
@@ -189,32 +171,42 @@ unsigned int munlock_vma_page(struct page *page)
 	VM_BUG_ON_PAGE(PageTail(page), page);
 
 	/*
-	 * Serialize with any parallel __split_huge_page_refcount() which
+	 * Serialize with any parallel __split_huge_page_tail() which
 	 * might otherwise copy PageMlocked to part of the tail pages before
 	 * we clear it in the head page. It also stabilizes hpage_nr_pages().
 	 */
+	get_page(page);
 	spin_lock_irq(&pgdat->lru_lock);
+	clearlru = TestClearPageLRU(page);
 
 	if (!TestClearPageMlocked(page)) {
-		/* Potentially, PTE-mapped THP: do not skip the rest PTEs */
-		nr_pages = 1;
-		goto unlock_out;
+		if (clearlru)
+			SetPageLRU(page);
+		/*
+		 * Potentially, PTE-mapped THP: do not skip the rest PTEs
+		 * Reuse lock as memory barrier for release_pages racing.
+		 */
+		spin_unlock_irq(&pgdat->lru_lock);
+		put_page(page);
+		return 0;
 	}
 
 	nr_pages = hpage_nr_pages(page);
 	__mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
 
-	if (__munlock_isolate_lru_page(page, true)) {
+	if (clearlru) {
+		struct lruvec *lruvec;
+
+		lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
+		del_page_from_lru_list(page, lruvec, page_lru(page));
 		spin_unlock_irq(&pgdat->lru_lock);
 		__munlock_isolated_page(page);
-		goto out;
+	} else {
+		spin_unlock_irq(&pgdat->lru_lock);
+		put_page(page);
+		__munlock_isolation_failed(page);
 	}
-	__munlock_isolation_failed(page);
-
-unlock_out:
-	spin_unlock_irq(&pgdat->lru_lock);
 
-out:
 	return nr_pages - 1;
 }
 
@@ -297,34 +289,51 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
 	pagevec_init(&pvec_putback);
 
 	/* Phase 1: page isolation */
-	spin_lock_irq(&zone->zone_pgdat->lru_lock);
 	for (i = 0; i < nr; i++) {
 		struct page *page = pvec->pages[i];
+		struct lruvec *lruvec;
+		bool clearlru;
 
-		if (TestClearPageMlocked(page)) {
-			/*
-			 * We already have pin from follow_page_mask()
-			 * so we can spare the get_page() here.
-			 */
-			if (__munlock_isolate_lru_page(page, false))
-				continue;
-			else
-				__munlock_isolation_failed(page);
-		} else {
+		clearlru = TestClearPageLRU(page);
+		spin_lock_irq(&zone->zone_pgdat->lru_lock);
+
+		if (!TestClearPageMlocked(page)) {
 			delta_munlocked++;
+			if (clearlru)
+				SetPageLRU(page);
+			goto putback;
+		}
+
+		if (!clearlru) {
+			__munlock_isolation_failed(page);
+			goto putback;
 		}
 
 		/*
+		 * Isolate this page.
+		 * We already have pin from follow_page_mask()
+		 * so we can spare the get_page() here.
+		 */
+		lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
+		del_page_from_lru_list(page, lruvec, page_lru(page));
+		spin_unlock_irq(&zone->zone_pgdat->lru_lock);
+		continue;
+
+		/*
 		 * We won't be munlocking this page in the next phase
 		 * but we still need to release the follow_page_mask()
 		 * pin. We cannot do it under lru_lock however. If it's
 		 * the last pin, __page_cache_release() would deadlock.
 		 */
+putback:
+		spin_unlock_irq(&zone->zone_pgdat->lru_lock);
 		pagevec_add(&pvec_putback, pvec->pages[i]);
 		pvec->pages[i] = NULL;
 	}
+	/* tempary disable irq, will remove later */
+	local_irq_disable();
 	__mod_zone_page_state(zone, NR_MLOCK, delta_munlocked);
-	spin_unlock_irq(&zone->zone_pgdat->lru_lock);
+	local_irq_enable();
 
 	/* Now we can release pins of pages that we are not munlocking */
 	pagevec_release(&pvec_putback);
-- 
1.8.3.1


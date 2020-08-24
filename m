Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FD424FE20
	for <lists+cgroups@lfdr.de>; Mon, 24 Aug 2020 14:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgHXMzi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Aug 2020 08:55:38 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:46626 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727859AbgHXMzh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 Aug 2020 08:55:37 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0U6k9-bl_1598273712;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U6k9-bl_1598273712)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 24 Aug 2020 20:55:24 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com, kirill@shutemov.name,
        alexander.duyck@gmail.com, rong.a.chen@intel.com, mhocko@suse.com,
        vdavydov.dev@gmail.com, shy828301@gmail.com
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: [PATCH v18 32/32] mm: Split release_pages work into 3 passes
Date:   Mon, 24 Aug 2020 20:55:05 +0800
Message-Id: <1598273705-69124-33-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

The release_pages function has a number of paths that end up with the
LRU lock having to be released and reacquired. Such an example would be the
freeing of THP pages as it requires releasing the LRU lock so that it can
be potentially reacquired by __put_compound_page.

In order to avoid that we can split the work into 3 passes, the first
without the LRU lock to go through and sort out those pages that are not in
the LRU so they can be freed immediately from those that can't. The second
pass will then go through removing those pages from the LRU in batches as
large as a pagevec can hold before freeing the LRU lock. Once the pages have
been removed from the LRU we can then proceed to free the remaining pages
without needing to worry about if they are in the LRU any further.

The general idea is to avoid bouncing the LRU lock between pages and to
hopefully aggregate the lock for up to the full page vector worth of pages.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 mm/swap.c | 109 ++++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 67 insertions(+), 42 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index fe53449fa1b8..b405f81b2c60 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -795,6 +795,54 @@ void lru_add_drain_all(void)
 }
 #endif
 
+static void __release_page(struct page *page, struct list_head *pages_to_free)
+{
+	if (PageCompound(page)) {
+		__put_compound_page(page);
+	} else {
+		/* Clear Active bit in case of parallel mark_page_accessed */
+		__ClearPageActive(page);
+		__ClearPageWaiters(page);
+
+		list_add(&page->lru, pages_to_free);
+	}
+}
+
+static void __release_lru_pages(struct pagevec *pvec,
+				struct list_head *pages_to_free)
+{
+	struct lruvec *lruvec = NULL;
+	unsigned long flags = 0;
+	int i;
+
+	/*
+	 * The pagevec at this point should contain a set of pages with
+	 * their reference count at 0 and the LRU flag set. We will now
+	 * need to pull the pages from their LRU lists.
+	 *
+	 * We walk the list backwards here since that way we are starting at
+	 * the pages that should be warmest in the cache.
+	 */
+	for (i = pagevec_count(pvec); i--;) {
+		struct page *page = pvec->pages[i];
+
+		lruvec = relock_page_lruvec_irqsave(page, lruvec, &flags);
+		VM_BUG_ON_PAGE(!PageLRU(page), page);
+		__ClearPageLRU(page);
+		del_page_from_lru_list(page, lruvec, page_off_lru(page));
+	}
+
+	unlock_page_lruvec_irqrestore(lruvec, flags);
+
+	/*
+	 * A batch of pages are no longer on the LRU list. Go through and
+	 * start the final process of returning the deferred pages to their
+	 * appropriate freelists.
+	 */
+	for (i = pagevec_count(pvec); i--;)
+		__release_page(pvec->pages[i], pages_to_free);
+}
+
 /**
  * release_pages - batched put_page()
  * @pages: array of pages to release
@@ -806,32 +854,24 @@ void lru_add_drain_all(void)
 void release_pages(struct page **pages, int nr)
 {
 	int i;
+	struct pagevec pvec;
 	LIST_HEAD(pages_to_free);
-	struct lruvec *lruvec = NULL;
-	unsigned long flags;
-	unsigned int lock_batch;
 
+	pagevec_init(&pvec);
+
+	/*
+	 * We need to first walk through the list cleaning up the low hanging
+	 * fruit and clearing those pages that either cannot be freed or that
+	 * are non-LRU. We will store the LRU pages in a pagevec so that we
+	 * can get to them in the next pass.
+	 */
 	for (i = 0; i < nr; i++) {
 		struct page *page = pages[i];
 
-		/*
-		 * Make sure the IRQ-safe lock-holding time does not get
-		 * excessive with a continuous string of pages from the
-		 * same lruvec. The lock is held only if lruvec != NULL.
-		 */
-		if (lruvec && ++lock_batch == SWAP_CLUSTER_MAX) {
-			unlock_page_lruvec_irqrestore(lruvec, flags);
-			lruvec = NULL;
-		}
-
 		if (is_huge_zero_page(page))
 			continue;
 
 		if (is_zone_device_page(page)) {
-			if (lruvec) {
-				unlock_page_lruvec_irqrestore(lruvec, flags);
-				lruvec = NULL;
-			}
 			/*
 			 * ZONE_DEVICE pages that return 'false' from
 			 * put_devmap_managed_page() do not require special
@@ -848,36 +888,21 @@ void release_pages(struct page **pages, int nr)
 		if (!put_page_testzero(page))
 			continue;
 
-		if (PageCompound(page)) {
-			if (lruvec) {
-				unlock_page_lruvec_irqrestore(lruvec, flags);
-				lruvec = NULL;
-			}
-			__put_compound_page(page);
+		if (!PageLRU(page)) {
+			__release_page(page, &pages_to_free);
 			continue;
 		}
 
-		if (PageLRU(page)) {
-			struct lruvec *prev_lruvec = lruvec;
-
-			lruvec = relock_page_lruvec_irqsave(page, lruvec,
-									&flags);
-			if (prev_lruvec != lruvec)
-				lock_batch = 0;
-
-			VM_BUG_ON_PAGE(!PageLRU(page), page);
-			__ClearPageLRU(page);
-			del_page_from_lru_list(page, lruvec, page_off_lru(page));
+		/* record page so we can get it in the next pass */
+		if (!pagevec_add(&pvec, page)) {
+			__release_lru_pages(&pvec, &pages_to_free);
+			pagevec_reinit(&pvec);
 		}
-
-		/* Clear Active bit in case of parallel mark_page_accessed */
-		__ClearPageActive(page);
-		__ClearPageWaiters(page);
-
-		list_add(&page->lru, &pages_to_free);
 	}
-	if (lruvec)
-		unlock_page_lruvec_irqrestore(lruvec, flags);
+
+	/* flush any remaining LRU pages that need to be processed */
+	if (pagevec_count(&pvec))
+		__release_lru_pages(&pvec, &pages_to_free);
 
 	mem_cgroup_uncharge_list(&pages_to_free);
 	free_unref_page_list(&pages_to_free);
-- 
1.8.3.1


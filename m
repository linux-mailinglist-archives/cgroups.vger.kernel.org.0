Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616641E5DAE
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2020 13:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388218AbgE1LCT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 May 2020 07:02:19 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:42917 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388099AbgE1LCS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 May 2020 07:02:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0TztNb5P_1590663688;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TztNb5P_1590663688)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 28 May 2020 19:01:29 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
Cc:     Alex Shi <alex.shi@linux.alibaba.com>
Subject: [PATCH v11 10/16] mm/compaction: do page isolation first in compaction
Date:   Thu, 28 May 2020 19:00:52 +0800
Message-Id: <1590663658-184131-11-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1590663658-184131-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1590663658-184131-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Johannes Weiner has suggested:
"So here is a crazy idea that may be worth exploring:

Right now, pgdat->lru_lock protects both PageLRU *and* the lruvec's
linked list.

Can we make PageLRU atomic and use it to stabilize the lru_lock
instead, and then use the lru_lock only serialize list operations?
..."

Yes, this patch is doing so on  __isolate_lru_page which is the core
page isolation func in compaction and shrinking path.
With this patch, the compaction will only deal the PageLRU set and now
isolated pages to skip the just alloced page which no LRU bit. And the
isolation could exclusive the other isolations in memcg move_account,
page migrations and thp split_huge_page.

As a side effect, PageLRU may be cleared during shrink_inactive_list
path for isolation reason. If so, we can skip that page.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/swap.h |  2 +-
 mm/compaction.c      | 33 +++++++++++++++++++++++----------
 mm/vmscan.c          | 38 ++++++++++++++++++++++----------------
 3 files changed, 46 insertions(+), 27 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index d12ecacce307..8baf0c2928e2 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -356,7 +356,7 @@ extern void lru_cache_add_active_or_unevictable(struct page *page,
 extern unsigned long zone_reclaimable_pages(struct zone *zone);
 extern unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
 					gfp_t gfp_mask, nodemask_t *mask);
-extern int __isolate_lru_page(struct page *page, isolate_mode_t mode);
+extern int __isolate_lru_page_prepare(struct page *page, isolate_mode_t mode);
 extern unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 						  unsigned long nr_pages,
 						  gfp_t gfp_mask,
diff --git a/mm/compaction.c b/mm/compaction.c
index c359772dbfcc..c36d832b2a84 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -954,6 +954,23 @@ static bool too_many_isolated(pg_data_t *pgdat)
 		if (!(cc->gfp_mask & __GFP_FS) && page_mapping(page))
 			goto isolate_fail;
 
+		if (__isolate_lru_page_prepare(page, isolate_mode) != 0)
+			goto isolate_fail;
+
+		/*
+		 * Be careful not to clear PageLRU until after we're
+		 * sure the page is not being freed elsewhere -- the
+		 * page release code relies on it.
+		 */
+		if (unlikely(!get_page_unless_zero(page)))
+			goto isolate_fail;
+
+		/* Try isolate the page */
+		if (!TestClearPageLRU(page)) {
+			put_page(page);
+			goto isolate_fail;
+		}
+
 		/* If we already hold the lock, we can skip some rechecking */
 		if (!locked) {
 			locked = compact_lock_irqsave(&pgdat->lru_lock,
@@ -966,10 +983,6 @@ static bool too_many_isolated(pg_data_t *pgdat)
 					goto isolate_abort;
 			}
 
-			/* Recheck PageLRU and PageCompound under lock */
-			if (!PageLRU(page))
-				goto isolate_fail;
-
 			/*
 			 * Page become compound since the non-locked check,
 			 * and it's on LRU. It can only be a THP so the order
@@ -980,18 +993,18 @@ static bool too_many_isolated(pg_data_t *pgdat)
 				goto isolate_fail;
 			}
 
-			/* Recheck page extra references under lock */
-			if (page_count(page) > page_mapcount(page) +
+			/*
+			 * Recheck page extra references under lock. The
+			 * extra page_count comes from above
+			 * get_page_unless_zero().
+			 */
+			if (page_count(page) > page_mapcount(page) + 1 +
 				    (!PageAnon(page) || PageSwapCache(page)))
 				goto isolate_fail;
 		}
 
 		lruvec = mem_cgroup_page_lruvec(page, pgdat);
 
-		/* Try isolate the page */
-		if (__isolate_lru_page(page, isolate_mode) != 0)
-			goto isolate_fail;
-
 		/* The whole page is taken off the LRU; skip the tail pages. */
 		if (PageCompound(page))
 			low_pfn += compound_nr(page) - 1;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 8a88a907c19d..df0765203473 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1543,7 +1543,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
  *
  * returns 0 on success, -ve errno on failure.
  */
-int __isolate_lru_page(struct page *page, isolate_mode_t mode)
+int __isolate_lru_page_prepare(struct page *page, isolate_mode_t mode)
 {
 	int ret = -EINVAL;
 
@@ -1597,20 +1597,9 @@ int __isolate_lru_page(struct page *page, isolate_mode_t mode)
 	if ((mode & ISOLATE_UNMAPPED) && page_mapped(page))
 		return ret;
 
-	if (likely(get_page_unless_zero(page))) {
-		/*
-		 * Be careful not to clear PageLRU until after we're
-		 * sure the page is not being freed elsewhere -- the
-		 * page release code relies on it.
-		 */
-		ClearPageLRU(page);
-		ret = 0;
-	}
-
-	return ret;
+	return 0;
 }
 
-
 /*
  * Update LRU sizes after isolating pages. The LRU size updates must
  * be complete before mem_cgroup_update_lru_size due to a sanity check.
@@ -1690,17 +1679,34 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
 		 * only when the page is being freed somewhere else.
 		 */
 		scan += nr_pages;
-		switch (__isolate_lru_page(page, mode)) {
+		switch (__isolate_lru_page_prepare(page, mode)) {
 		case 0:
+			/*
+			 * Be careful not to clear PageLRU until after we're
+			 * sure the page is not being freed elsewhere -- the
+			 * page release code relies on it.
+			 */
+			if (unlikely(!get_page_unless_zero(page)))
+				goto busy;
+
+			if (!TestClearPageLRU(page)) {
+				/*
+				 * This page may in other isolation path,
+				 * but we still hold lru_lock.
+				 */
+				put_page(page);
+				goto busy;
+			}
+
 			nr_taken += nr_pages;
 			nr_zone_taken[page_zonenum(page)] += nr_pages;
 			list_move(&page->lru, dst);
 			break;
-
+busy:
 		case -EBUSY:
 			/* else it is being freed elsewhere */
 			list_move(&page->lru, src);
-			continue;
+			break;
 
 		default:
 			BUG();
-- 
1.8.3.1


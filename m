Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496FE1F61A5
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2020 08:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgFKGRl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 11 Jun 2020 02:17:41 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:34763 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726659AbgFKGRQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 11 Jun 2020 02:17:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0U.EnDAd_1591856229;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U.EnDAd_1591856229)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Jun 2020 14:17:09 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
Subject: [PATCH v12 10/16] mm/compaction: do page isolation first in compaction
Date:   Thu, 11 Jun 2020 14:16:43 +0800
Message-Id: <1591856209-166869-11-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1591856209-166869-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1591856209-166869-1-git-send-email-alex.shi@linux.alibaba.com>
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
 mm/compaction.c      | 25 +++++++++++++++++--------
 mm/vmscan.c          | 38 ++++++++++++++++++++++----------------
 3 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 29ba748b0d99..6811d0c34261 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -357,7 +357,7 @@ extern void lru_cache_add_active_or_unevictable(struct page *page,
 extern unsigned long zone_reclaimable_pages(struct zone *zone);
 extern unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
 					gfp_t gfp_mask, nodemask_t *mask);
-extern int __isolate_lru_page(struct page *page, isolate_mode_t mode);
+extern int __isolate_lru_page_prepare(struct page *page, isolate_mode_t mode);
 extern unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 						  unsigned long nr_pages,
 						  gfp_t gfp_mask,
diff --git a/mm/compaction.c b/mm/compaction.c
index 5d59e77cd424..b0d096fd0b4b 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -950,6 +950,23 @@ static bool too_many_isolated(pg_data_t *pgdat)
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
@@ -962,10 +979,6 @@ static bool too_many_isolated(pg_data_t *pgdat)
 					goto isolate_abort;
 			}
 
-			/* Recheck PageLRU and PageCompound under lock */
-			if (!PageLRU(page))
-				goto isolate_fail;
-
 			/*
 			 * Page become compound since the non-locked check,
 			 * and it's on LRU. It can only be a THP so the order
@@ -979,10 +992,6 @@ static bool too_many_isolated(pg_data_t *pgdat)
 
 		lruvec = mem_cgroup_page_lruvec(page, pgdat);
 
-		/* Try isolate the page */
-		if (__isolate_lru_page(page, isolate_mode) != 0)
-			goto isolate_fail;
-
 		/* The whole page is taken off the LRU; skip the tail pages. */
 		if (PageCompound(page))
 			low_pfn += compound_nr(page) - 1;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 08910ca9fa40..17b34e5b7ad5 100644
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


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE6995B83
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2019 11:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbfHTJtx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Aug 2019 05:49:53 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:57061 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729774AbfHTJtu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Aug 2019 05:49:50 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Ta-AHGG_1566294576;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0Ta-AHGG_1566294576)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 20 Aug 2019 17:49:37 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: [PATCH 11/14] lru/vmscan: using per lruvec lock in lists shrinking.
Date:   Tue, 20 Aug 2019 17:48:34 +0800
Message-Id: <1566294517-86418-12-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1566294517-86418-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1566294517-86418-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The involoving functions includes isolate_lru_page, move_pages_to_lru
and shrink_in/active_list. also remove unnecessary pgdat.

And remove unnecessary pgdat accordingly.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Yafang Shao <laoar.shao@gmail.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/vmscan.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index c7a228525df0..defc2c4778eb 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1805,8 +1805,9 @@ int isolate_lru_page(struct page *page)
 		pg_data_t *pgdat = page_pgdat(page);
 		struct lruvec *lruvec;
 
-		spin_lock_irq(&pgdat->lruvec.lru_lock);
 		lruvec = mem_cgroup_page_lruvec(page, pgdat);
+		spin_lock_irq(&lruvec->lru_lock);
+		sync_lruvec_pgdat(lruvec, pgdat);
 		if (PageLRU(page)) {
 			int lru = page_lru(page);
 			get_page(page);
@@ -1814,7 +1815,7 @@ int isolate_lru_page(struct page *page)
 			del_page_from_lru_list(page, lruvec, lru);
 			ret = 0;
 		}
-		spin_unlock_irq(&pgdat->lruvec.lru_lock);
+		spin_unlock_irq(&lruvec->lru_lock);
 	}
 	return ret;
 }
@@ -1879,7 +1880,6 @@ static int too_many_isolated(struct pglist_data *pgdat, int file,
 static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 						     struct list_head *list)
 {
-	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 	int nr_pages, nr_moved = 0;
 	LIST_HEAD(pages_to_free);
 	struct page *page;
@@ -1890,12 +1890,11 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 		VM_BUG_ON_PAGE(PageLRU(page), page);
 		if (unlikely(!page_evictable(page))) {
 			list_del(&page->lru);
-			spin_unlock_irq(&pgdat->lruvec.lru_lock);
+			spin_unlock_irq(&lruvec->lru_lock);
 			putback_lru_page(page);
-			spin_lock_irq(&pgdat->lruvec.lru_lock);
+			spin_lock_irq(&lruvec->lru_lock);
 			continue;
 		}
-		lruvec = mem_cgroup_page_lruvec(page, pgdat);
 
 		SetPageLRU(page);
 		lru = page_lru(page);
@@ -1910,10 +1909,10 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 			del_page_from_lru_list(page, lruvec, lru);
 
 			if (unlikely(PageCompound(page))) {
-				spin_unlock_irq(&pgdat->lruvec.lru_lock);
+				spin_unlock_irq(&lruvec->lru_lock);
 				mem_cgroup_uncharge(page);
 				(*get_compound_page_dtor(page))(page);
-				spin_lock_irq(&pgdat->lruvec.lru_lock);
+				spin_lock_irq(&lruvec->lru_lock);
 			} else
 				list_add(&page->lru, &pages_to_free);
 		} else {
@@ -1976,7 +1975,7 @@ static int current_may_throttle(void)
 
 	lru_add_drain();
 
-	spin_lock_irq(&pgdat->lruvec.lru_lock);
+	spin_lock_irq(&lruvec->lru_lock);
 
 	nr_taken = isolate_lru_pages(nr_to_scan, lruvec, &page_list,
 				     &nr_scanned, sc, lru);
@@ -1988,7 +1987,7 @@ static int current_may_throttle(void)
 	if (global_reclaim(sc))
 		__count_vm_events(item, nr_scanned);
 	__count_memcg_events(lruvec_memcg(lruvec), item, nr_scanned);
-	spin_unlock_irq(&pgdat->lruvec.lru_lock);
+	spin_unlock_irq(&lruvec->lru_lock);
 
 	if (nr_taken == 0)
 		return 0;
@@ -1996,7 +1995,7 @@ static int current_may_throttle(void)
 	nr_reclaimed = shrink_page_list(&page_list, pgdat, sc, 0,
 				&stat, false);
 
-	spin_lock_irq(&pgdat->lruvec.lru_lock);
+	spin_lock_irq(&lruvec->lru_lock);
 
 	item = current_is_kswapd() ? PGSTEAL_KSWAPD : PGSTEAL_DIRECT;
 	if (global_reclaim(sc))
@@ -2009,7 +2008,7 @@ static int current_may_throttle(void)
 
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
 
-	spin_unlock_irq(&pgdat->lruvec.lru_lock);
+	spin_unlock_irq(&lruvec->lru_lock);
 
 	mem_cgroup_uncharge_list(&page_list);
 	free_unref_page_list(&page_list);
@@ -2062,7 +2061,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 
 	lru_add_drain();
 
-	spin_lock_irq(&pgdat->lruvec.lru_lock);
+	spin_lock_irq(&lruvec->lru_lock);
 
 	nr_taken = isolate_lru_pages(nr_to_scan, lruvec, &l_hold,
 				     &nr_scanned, sc, lru);
@@ -2073,7 +2072,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	__count_vm_events(PGREFILL, nr_scanned);
 	__count_memcg_events(lruvec_memcg(lruvec), PGREFILL, nr_scanned);
 
-	spin_unlock_irq(&pgdat->lruvec.lru_lock);
+	spin_unlock_irq(&lruvec->lru_lock);
 
 	while (!list_empty(&l_hold)) {
 		cond_resched();
@@ -2119,7 +2118,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	/*
 	 * Move pages back to the lru list.
 	 */
-	spin_lock_irq(&pgdat->lruvec.lru_lock);
+	spin_lock_irq(&lruvec->lru_lock);
 	/*
 	 * Count referenced pages from currently used mappings as rotated,
 	 * even though only some of them are actually re-activated.  This
@@ -2137,7 +2136,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	__count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_deactivate);
 
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
-	spin_unlock_irq(&pgdat->lruvec.lru_lock);
+	spin_unlock_irq(&lruvec->lru_lock);
 
 	mem_cgroup_uncharge_list(&l_active);
 	free_unref_page_list(&l_active);
-- 
1.8.3.1


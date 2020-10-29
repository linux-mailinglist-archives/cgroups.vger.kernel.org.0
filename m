Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9445529E94F
	for <lists+cgroups@lfdr.de>; Thu, 29 Oct 2020 11:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgJ2Kpq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Oct 2020 06:45:46 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:51585 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726882AbgJ2Kpp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Oct 2020 06:45:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0UDXwDyN_1603968328;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UDXwDyN_1603968328)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 29 Oct 2020 18:45:36 +0800
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
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH v20 19/20] mm/lru: introduce the relock_page_lruvec function
Date:   Thu, 29 Oct 2020 18:45:04 +0800
Message-Id: <1603968305-8026-20-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Use this new function to replace repeated same code, no func change.

When testing for relock we can avoid the need for RCU locking if we simply
compare the page pgdat and memcg pointers versus those that the lruvec is
holding. By doing this we can avoid the extra pointer walks and accesses of
the memory cgroup.

In addition we can avoid the checks entirely if lruvec is currently NULL.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Acked-by: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Hugh Dickins <hughd@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/memcontrol.h | 52 ++++++++++++++++++++++++++++++++++++++++++++++
 mm/mlock.c                 | 11 +---------
 mm/swap.c                  | 33 +++++++----------------------
 mm/vmscan.c                | 12 ++---------
 4 files changed, 62 insertions(+), 46 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index f447a1bfa654..3c5c5c433167 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -491,6 +491,22 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
 
 struct lruvec *mem_cgroup_page_lruvec(struct page *, struct pglist_data *);
 
+static inline bool lruvec_holds_page_lru_lock(struct page *page,
+					      struct lruvec *lruvec)
+{
+	pg_data_t *pgdat = page_pgdat(page);
+	const struct mem_cgroup *memcg;
+	struct mem_cgroup_per_node *mz;
+
+	if (mem_cgroup_disabled())
+		return lruvec == &pgdat->__lruvec;
+
+	mz = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
+	memcg = page->mem_cgroup ? : root_mem_cgroup;
+
+	return lruvec->pgdat == pgdat && mz->memcg == memcg;
+}
+
 struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p);
 
 struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm);
@@ -1026,6 +1042,14 @@ static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page,
 	return &pgdat->__lruvec;
 }
 
+static inline bool lruvec_holds_page_lru_lock(struct page *page,
+					      struct lruvec *lruvec)
+{
+	pg_data_t *pgdat = page_pgdat(page);
+
+	return lruvec == &pgdat->__lruvec;
+}
+
 static inline struct mem_cgroup *parent_mem_cgroup(struct mem_cgroup *memcg)
 {
 	return NULL;
@@ -1472,6 +1496,34 @@ static inline void unlock_page_lruvec_irqrestore(struct lruvec *lruvec,
 	spin_unlock_irqrestore(&lruvec->lru_lock, flags);
 }
 
+/* Don't lock again iff page's lruvec locked */
+static inline struct lruvec *relock_page_lruvec_irq(struct page *page,
+		struct lruvec *locked_lruvec)
+{
+	if (locked_lruvec) {
+		if (lruvec_holds_page_lru_lock(page, locked_lruvec))
+			return locked_lruvec;
+
+		unlock_page_lruvec_irq(locked_lruvec);
+	}
+
+	return lock_page_lruvec_irq(page);
+}
+
+/* Don't lock again iff page's lruvec locked */
+static inline struct lruvec *relock_page_lruvec_irqsave(struct page *page,
+		struct lruvec *locked_lruvec, unsigned long *flags)
+{
+	if (locked_lruvec) {
+		if (lruvec_holds_page_lru_lock(page, locked_lruvec))
+			return locked_lruvec;
+
+		unlock_page_lruvec_irqrestore(locked_lruvec, *flags);
+	}
+
+	return lock_page_lruvec_irqsave(page, flags);
+}
+
 #ifdef CONFIG_CGROUP_WRITEBACK
 
 struct wb_domain *mem_cgroup_wb_domain(struct bdi_writeback *wb);
diff --git a/mm/mlock.c b/mm/mlock.c
index ab164a675c25..55b3b3672977 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -277,16 +277,7 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
 			 * so we can spare the get_page() here.
 			 */
 			if (TestClearPageLRU(page)) {
-				struct lruvec *new_lruvec;
-
-				new_lruvec = mem_cgroup_page_lruvec(page,
-						page_pgdat(page));
-				if (new_lruvec != lruvec) {
-					if (lruvec)
-						unlock_page_lruvec_irq(lruvec);
-					lruvec = lock_page_lruvec_irq(page);
-				}
-
+				lruvec = relock_page_lruvec_irq(page, lruvec);
 				del_page_from_lru_list(page, lruvec,
 							page_lru(page));
 				continue;
diff --git a/mm/swap.c b/mm/swap.c
index 580ea18a9596..9fe5ff9a8111 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -210,19 +210,12 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
 
 	for (i = 0; i < pagevec_count(pvec); i++) {
 		struct page *page = pvec->pages[i];
-		struct lruvec *new_lruvec;
 
 		/* block memcg migration during page moving between lru */
 		if (!TestClearPageLRU(page))
 			continue;
 
-		new_lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
-		if (lruvec != new_lruvec) {
-			if (lruvec)
-				unlock_page_lruvec_irqrestore(lruvec, flags);
-			lruvec = lock_page_lruvec_irqsave(page, &flags);
-		}
-
+		lruvec = relock_page_lruvec_irqsave(page, lruvec, &flags);
 		(*move_fn)(page, lruvec);
 
 		SetPageLRU(page);
@@ -906,17 +899,12 @@ void release_pages(struct page **pages, int nr)
 		}
 
 		if (PageLRU(page)) {
-			struct lruvec *new_lruvec;
-
-			new_lruvec = mem_cgroup_page_lruvec(page,
-							page_pgdat(page));
-			if (new_lruvec != lruvec) {
-				if (lruvec)
-					unlock_page_lruvec_irqrestore(lruvec,
-									flags);
+			struct lruvec *prev_lruvec = lruvec;
+
+			lruvec = relock_page_lruvec_irqsave(page, lruvec,
+									&flags);
+			if (prev_lruvec != lruvec)
 				lock_batch = 0;
-				lruvec = lock_page_lruvec_irqsave(page, &flags);
-			}
 
 			VM_BUG_ON_PAGE(!PageLRU(page), page);
 			__ClearPageLRU(page);
@@ -1021,15 +1009,8 @@ void __pagevec_lru_add(struct pagevec *pvec)
 
 	for (i = 0; i < pagevec_count(pvec); i++) {
 		struct page *page = pvec->pages[i];
-		struct lruvec *new_lruvec;
-
-		new_lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
-		if (lruvec != new_lruvec) {
-			if (lruvec)
-				unlock_page_lruvec_irqrestore(lruvec, flags);
-			lruvec = lock_page_lruvec_irqsave(page, &flags);
-		}
 
+		lruvec = relock_page_lruvec_irqsave(page, lruvec, &flags);
 		__pagevec_lru_add_fn(page, lruvec);
 	}
 	if (lruvec)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9e726b587d74..ee0b08a67d2d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1880,8 +1880,7 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 			continue;
 		}
 
-		VM_BUG_ON_PAGE(mem_cgroup_page_lruvec(page, page_pgdat(page))
-							!= lruvec, page);
+		VM_BUG_ON_PAGE(!lruvec_holds_page_lru_lock(page, lruvec), page);
 		lru = page_lru(page);
 		nr_pages = thp_nr_pages(page);
 
@@ -4273,7 +4272,6 @@ void check_move_unevictable_pages(struct pagevec *pvec)
 	for (i = 0; i < pvec->nr; i++) {
 		struct page *page = pvec->pages[i];
 		int nr_pages;
-		struct lruvec *new_lruvec;
 
 		if (PageTransTail(page))
 			continue;
@@ -4285,13 +4283,7 @@ void check_move_unevictable_pages(struct pagevec *pvec)
 		if (!TestClearPageLRU(page))
 			continue;
 
-		new_lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
-		if (lruvec != new_lruvec) {
-			if (lruvec)
-				unlock_page_lruvec_irq(lruvec);
-			lruvec = lock_page_lruvec_irq(page);
-		}
-
+		lruvec = relock_page_lruvec_irq(page, lruvec);
 		if (page_evictable(page) && PageUnevictable(page)) {
 			enum lru_list lru = page_lru_base_type(page);
 
-- 
1.8.3.1


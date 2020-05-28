Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C6B1E5DB0
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2020 13:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388227AbgE1LCe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 May 2020 07:02:34 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:33464 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388092AbgE1LBl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 May 2020 07:01:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0TztdQAT_1590663689;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TztdQAT_1590663689)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 28 May 2020 19:01:30 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: [PATCH v11 12/16] mm/lru: replace pgdat lru_lock with lruvec lock
Date:   Thu, 28 May 2020 19:00:54 +0800
Message-Id: <1590663658-184131-13-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1590663658-184131-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1590663658-184131-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patch moves per node lru_lock into lruvec, thus bring a lru_lock for
each of memcg per node. So on a large machine, each of memcg don't
have to suffer from per node pgdat->lru_lock competition. They could go
fast with their self lru_lock.

After move memcg charge before lru inserting, page isolation could
stable page's memcg, then per memcg lruvec lock is stable and could
replace per node lru lock.

According to Daniel Jordan's suggestion, I run 208 'dd' with on 104
containers on a 2s * 26cores * HT box with a modefied case:
https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-lru-file-readtwice

With this and later patches, the readtwice performance increases about
80% within concurrent containers.

Also add a debug func in locking which may give some clues if there are
sth out of hands.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Hugh Dickins <hughd@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: cgroups@vger.kernel.org
---
 include/linux/memcontrol.h | 56 ++++++++++++++++++++++++++++++++
 include/linux/mmzone.h     |  2 ++
 mm/compaction.c            | 61 +++++++++++++++++++++++------------
 mm/huge_memory.c           |  9 ++----
 mm/memcontrol.c            | 79 ++++++++++++++++++++++++++++++++++++++++++++--
 mm/mlock.c                 | 32 +++++++++----------
 mm/mmzone.c                |  1 +
 mm/swap.c                  | 75 ++++++++++++++++++++-----------------------
 mm/swap_state.c            |  6 ++--
 mm/vmscan.c                | 70 ++++++++++++++++++++++------------------
 mm/workingset.c            |  4 +--
 11 files changed, 275 insertions(+), 120 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0ba84f1c3f91..a4601169bf7d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -413,6 +413,17 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
 
 struct mem_cgroup *get_mem_cgroup_from_page(struct page *page);
 
+struct lruvec *lock_page_lruvec(struct page *page);
+struct lruvec *lock_page_lruvec_irq(struct page *page);
+struct lruvec *lock_page_lruvec_irqsave(struct page *page,
+						unsigned long *flags);
+
+void unlock_page_lruvec(struct lruvec *lruvec);
+void unlock_page_lruvec_irq(struct lruvec *lruvec);
+void unlock_page_lruvec_irqrestore(struct lruvec *lruvec, unsigned long flags);
+
+void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page);
+
 static inline
 struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css){
 	return css ? container_of(css, struct mem_cgroup, css) : NULL;
@@ -894,6 +905,47 @@ static inline void mem_cgroup_put(struct mem_cgroup *memcg)
 {
 }
 
+static inline struct lruvec *lock_page_lruvec(struct page *page)
+{
+	struct pglist_data *pgdat = page_pgdat(page);
+
+	spin_lock(&pgdat->__lruvec.lru_lock);
+	return &pgdat->__lruvec;
+}
+
+static inline struct lruvec *lock_page_lruvec_irq(struct page *page)
+{
+	struct pglist_data *pgdat = page_pgdat(page);
+
+	spin_lock_irq(&pgdat->__lruvec.lru_lock);
+	return &pgdat->__lruvec;
+}
+
+static inline struct lruvec *lock_page_lruvec_irqsave(struct page *page,
+		unsigned long *flagsp)
+{
+	struct pglist_data *pgdat = page_pgdat(page);
+
+	spin_lock_irqsave(&pgdat->__lruvec.lru_lock, *flagsp);
+	return &pgdat->__lruvec;
+}
+
+static inline void unlock_page_lruvec(struct lruvec *lruvec)
+{
+	spin_unlock(&lruvec->lru_lock);
+}
+
+static inline void unlock_page_lruvec_irq(struct lruvec *lruvec)
+{
+	spin_unlock_irq(&lruvec->lru_lock);
+}
+
+static inline void unlock_page_lruvec_irqrestore(struct lruvec *lruvec,
+		unsigned long flags)
+{
+	spin_unlock_irqrestore(&lruvec->lru_lock, flags);
+}
+
 static inline struct mem_cgroup *
 mem_cgroup_iter(struct mem_cgroup *root,
 		struct mem_cgroup *prev,
@@ -1128,6 +1180,10 @@ static inline void count_memcg_page_event(struct page *page,
 void count_memcg_event_mm(struct mm_struct *mm, enum vm_event_item idx)
 {
 }
+
+static inline void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
+{
+}
 #endif /* CONFIG_MEMCG */
 
 /* idx can be of type enum memcg_stat_item or node_stat_item */
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 545b663678ed..d70a12214936 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -259,6 +259,8 @@ struct lruvec {
 	atomic_long_t			inactive_age;
 	/* Refaults at the time of last reclaim cycle */
 	unsigned long			refaults;
+	/* per lruvec lru_lock for memcg */
+	spinlock_t			lru_lock;
 	/* Various lruvec state flags (enum lruvec_flags) */
 	unsigned long			flags;
 #ifdef CONFIG_MEMCG
diff --git a/mm/compaction.c b/mm/compaction.c
index c36d832b2a84..e15aa83ebc07 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -787,7 +787,7 @@ static bool too_many_isolated(pg_data_t *pgdat)
 	unsigned long nr_scanned = 0, nr_isolated = 0;
 	struct lruvec *lruvec;
 	unsigned long flags = 0;
-	bool locked = false;
+	struct lruvec *locked_lruvec = NULL;
 	struct page *page = NULL, *valid_page = NULL;
 	unsigned long start_pfn = low_pfn;
 	bool skip_on_failure = false;
@@ -847,11 +847,21 @@ static bool too_many_isolated(pg_data_t *pgdat)
 		 * contention, to give chance to IRQs. Abort completely if
 		 * a fatal signal is pending.
 		 */
-		if (!(low_pfn % SWAP_CLUSTER_MAX)
-		    && compact_unlock_should_abort(&pgdat->lru_lock,
-					    flags, &locked, cc)) {
-			low_pfn = 0;
-			goto fatal_pending;
+		if (!(low_pfn % SWAP_CLUSTER_MAX)) {
+			if (locked_lruvec) {
+				unlock_page_lruvec_irqrestore(locked_lruvec,
+									flags);
+				locked_lruvec = NULL;
+			}
+
+			if (fatal_signal_pending(current)) {
+				cc->contended = true;
+
+				low_pfn = 0;
+				goto fatal_pending;
+			}
+
+			cond_resched();
 		}
 
 		if (!pfn_valid_within(low_pfn))
@@ -921,10 +931,9 @@ static bool too_many_isolated(pg_data_t *pgdat)
 			 */
 			if (unlikely(__PageMovable(page)) &&
 					!PageIsolated(page)) {
-				if (locked) {
-					spin_unlock_irqrestore(&pgdat->lru_lock,
-									flags);
-					locked = false;
+				if (locked_lruvec) {
+					unlock_page_lruvec_irqrestore(locked_lruvec, flags);
+					locked_lruvec = NULL;
 				}
 
 				if (!isolate_movable_page(page, isolate_mode))
@@ -971,10 +980,20 @@ static bool too_many_isolated(pg_data_t *pgdat)
 			goto isolate_fail;
 		}
 
+		rcu_read_lock();
+		lruvec = mem_cgroup_page_lruvec(page, pgdat);
+
 		/* If we already hold the lock, we can skip some rechecking */
-		if (!locked) {
-			locked = compact_lock_irqsave(&pgdat->lru_lock,
-								&flags, cc);
+		if (lruvec != locked_lruvec) {
+			if (locked_lruvec)
+				unlock_page_lruvec_irqrestore(locked_lruvec,
+									flags);
+
+			compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);
+			locked_lruvec = lruvec;
+			rcu_read_unlock();
+
+			lruvec_memcg_debug(lruvec, page);
 
 			/* Try get exclusive access under lock */
 			if (!skip_updated) {
@@ -1001,9 +1020,8 @@ static bool too_many_isolated(pg_data_t *pgdat)
 			if (page_count(page) > page_mapcount(page) + 1 +
 				    (!PageAnon(page) || PageSwapCache(page)))
 				goto isolate_fail;
-		}
-
-		lruvec = mem_cgroup_page_lruvec(page, pgdat);
+		} else
+			rcu_read_unlock();
 
 		/* The whole page is taken off the LRU; skip the tail pages. */
 		if (PageCompound(page))
@@ -1043,9 +1061,10 @@ static bool too_many_isolated(pg_data_t *pgdat)
 		 * page anyway.
 		 */
 		if (nr_isolated) {
-			if (locked) {
-				spin_unlock_irqrestore(&pgdat->lru_lock, flags);
-				locked = false;
+			if (locked_lruvec) {
+				unlock_page_lruvec_irqrestore(locked_lruvec,
+									flags);
+				locked_lruvec = NULL;
 			}
 			putback_movable_pages(&cc->migratepages);
 			cc->nr_migratepages = 0;
@@ -1070,8 +1089,8 @@ static bool too_many_isolated(pg_data_t *pgdat)
 		low_pfn = end_pfn;
 
 isolate_abort:
-	if (locked)
-		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
+	if (locked_lruvec)
+		unlock_page_lruvec_irqrestore(locked_lruvec, flags);
 
 	/*
 	 * Updated the cached scanner pfn once the pageblock has been scanned
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 44d4b45281a3..39025c651692 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2322,7 +2322,7 @@ void lru_add_page_tail(struct page *head, struct page *page_tail,
 	VM_BUG_ON_PAGE(!PageHead(head), head);
 	VM_BUG_ON_PAGE(PageCompound(page_tail), head);
 	VM_BUG_ON_PAGE(PageLRU(page_tail), head);
-	lockdep_assert_held(&lruvec_pgdat(lruvec)->lru_lock);
+	lockdep_assert_held(&lruvec->lru_lock);
 
 	if (!list)
 		SetPageLRU(page_tail);
@@ -2412,7 +2412,6 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		pgoff_t end, unsigned long flags)
 {
 	struct page *head = compound_head(page);
-	pg_data_t *pgdat = page_pgdat(head);
 	struct lruvec *lruvec;
 	struct address_space *swap_cache = NULL;
 	unsigned long offset = 0;
@@ -2430,9 +2429,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	}
 
 	/* lock lru list/PageCompound, isolate freezed by page_ref_freeze */
-	spin_lock(&pgdat->lru_lock);
-
-	lruvec = mem_cgroup_page_lruvec(head, pgdat);
+	lruvec = lock_page_lruvec(head);
 
 	for (i = HPAGE_PMD_NR - 1; i >= 1; i--) {
 		__split_huge_page_tail(head, i, lruvec, list);
@@ -2452,7 +2449,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		}
 	}
 	ClearPageCompound(head);
-	spin_unlock(&pgdat->lru_lock);
+	unlock_page_lruvec(lruvec);
 
 	split_page_owner(head, HPAGE_PMD_ORDER);
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 91b073891d06..b106e3b86fff 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1196,6 +1196,20 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 	return ret;
 }
 
+
+void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
+{
+#ifdef CONFIG_DEBUG_VM
+	if (mem_cgroup_disabled())
+		return;
+
+	if (!page->mem_cgroup)
+		VM_BUG_ON_PAGE(lruvec_memcg(lruvec) != root_mem_cgroup, page);
+	else
+		VM_BUG_ON_PAGE(lruvec_memcg(lruvec) != page->mem_cgroup, page);
+#endif
+}
+
 /**
  * mem_cgroup_page_lruvec - return lruvec for isolating/putting an LRU page
  * @page: the page
@@ -1215,7 +1229,7 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgd
 		goto out;
 	}
 
-	memcg = page->mem_cgroup;
+	memcg = READ_ONCE(page->mem_cgroup);
 	/*
 	 * Swapcache readahead pages are added to the LRU - and
 	 * possibly migrated - before they are charged.
@@ -1236,6 +1250,67 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgd
 	return lruvec;
 }
 
+/* page was isolated */
+struct lruvec *lock_page_lruvec(struct page *page)
+{
+	struct lruvec *lruvec;
+	struct pglist_data *pgdat = page_pgdat(page);
+
+	rcu_read_lock();
+	lruvec = mem_cgroup_page_lruvec(page, pgdat);
+	spin_lock(&lruvec->lru_lock);
+	rcu_read_unlock();
+
+	lruvec_memcg_debug(lruvec, page);
+
+	return lruvec;
+}
+
+struct lruvec *lock_page_lruvec_irq(struct page *page)
+{
+	struct lruvec *lruvec;
+	struct pglist_data *pgdat = page_pgdat(page);
+
+	rcu_read_lock();
+	lruvec = mem_cgroup_page_lruvec(page, pgdat);
+	spin_lock_irq(&lruvec->lru_lock);
+	rcu_read_unlock();
+
+	lruvec_memcg_debug(lruvec, page);
+
+	return lruvec;
+}
+
+struct lruvec *lock_page_lruvec_irqsave(struct page *page, unsigned long *flags)
+{
+	struct lruvec *lruvec;
+	struct pglist_data *pgdat = page_pgdat(page);
+
+	rcu_read_lock();
+	lruvec = mem_cgroup_page_lruvec(page, pgdat);
+	spin_lock_irqsave(&lruvec->lru_lock, *flags);
+	rcu_read_unlock();
+
+	lruvec_memcg_debug(lruvec, page);
+
+	return lruvec;
+}
+
+void unlock_page_lruvec(struct lruvec *lruvec)
+{
+	spin_unlock(&lruvec->lru_lock);
+}
+
+void unlock_page_lruvec_irq(struct lruvec *lruvec)
+{
+	spin_unlock_irq(&lruvec->lru_lock);
+}
+
+void unlock_page_lruvec_irqrestore(struct lruvec *lruvec, unsigned long flags)
+{
+	spin_unlock_irqrestore(&lruvec->lru_lock, flags);
+}
+
 /**
  * mem_cgroup_update_lru_size - account for adding or removing an lru page
  * @lruvec: mem_cgroup per zone lru vector
@@ -2942,7 +3017,7 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
 
 /*
  * Because tail pages are not marked as "used", set it. We're under
- * pgdat->lru_lock and migration entries setup in all page mappings.
+ * lruvec->lru_lock and migration entries setup in all page mappings.
  */
 void mem_cgroup_split_huge_fixup(struct page *head)
 {
diff --git a/mm/mlock.c b/mm/mlock.c
index a0856085c4b7..c1ef4ac7a744 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -163,7 +163,7 @@ unsigned int munlock_vma_page(struct page *page)
 {
 	int nr_pages;
 	bool clearlru = false;
-	pg_data_t *pgdat = page_pgdat(page);
+	struct lruvec *lruvec;
 
 	/* For try_to_munlock() and to serialize with page migration */
 	BUG_ON(!PageLocked(page));
@@ -176,7 +176,7 @@ unsigned int munlock_vma_page(struct page *page)
 	 * we clear it in the head page. It also stabilizes hpage_nr_pages().
 	 */
 	get_page(page);
-	spin_lock_irq(&pgdat->lru_lock);
+	lruvec = lock_page_lruvec_irq(page);
 	clearlru = TestClearPageLRU(page);
 
 	if (!TestClearPageMlocked(page)) {
@@ -186,7 +186,7 @@ unsigned int munlock_vma_page(struct page *page)
 		 * Potentially, PTE-mapped THP: do not skip the rest PTEs
 		 * Reuse lock as memory barrier for release_pages racing.
 		 */
-		spin_unlock_irq(&pgdat->lru_lock);
+		unlock_page_lruvec_irq(lruvec);
 		put_page(page);
 		return 0;
 	}
@@ -195,14 +195,11 @@ unsigned int munlock_vma_page(struct page *page)
 	__mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
 
 	if (clearlru) {
-		struct lruvec *lruvec;
-
-		lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
 		del_page_from_lru_list(page, lruvec, page_lru(page));
-		spin_unlock_irq(&pgdat->lru_lock);
+		unlock_page_lruvec_irq(lruvec);
 		__munlock_isolated_page(page);
 	} else {
-		spin_unlock_irq(&pgdat->lru_lock);
+		unlock_page_lruvec_irq(lruvec);
 		put_page(page);
 		__munlock_isolation_failed(page);
 	}
@@ -284,6 +281,7 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
 	int nr = pagevec_count(pvec);
 	int delta_munlocked = -nr;
 	struct pagevec pvec_putback;
+	struct lruvec *lruvec = NULL;
 	int pgrescued = 0;
 
 	pagevec_init(&pvec_putback);
@@ -291,11 +289,17 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
 	/* Phase 1: page isolation */
 	for (i = 0; i < nr; i++) {
 		struct page *page = pvec->pages[i];
-		struct lruvec *lruvec;
+		struct lruvec *new_lruvec;
 		bool clearlru;
 
 		clearlru = TestClearPageLRU(page);
-		spin_lock_irq(&zone->zone_pgdat->lru_lock);
+
+		new_lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
+		if (new_lruvec != lruvec) {
+			if (lruvec)
+				unlock_page_lruvec_irq(lruvec);
+			lruvec = lock_page_lruvec_irq(page);
+		}
 
 		if (!TestClearPageMlocked(page)) {
 			delta_munlocked++;
@@ -314,9 +318,7 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
 		 * We already have pin from follow_page_mask()
 		 * so we can spare the get_page() here.
 		 */
-		lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
 		del_page_from_lru_list(page, lruvec, page_lru(page));
-		spin_unlock_irq(&zone->zone_pgdat->lru_lock);
 		continue;
 
 		/*
@@ -326,14 +328,12 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
 		 * the last pin, __page_cache_release() would deadlock.
 		 */
 putback:
-		spin_unlock_irq(&zone->zone_pgdat->lru_lock);
 		pagevec_add(&pvec_putback, pvec->pages[i]);
 		pvec->pages[i] = NULL;
 	}
-	/* tempary disable irq, will remove later */
-	local_irq_disable();
 	__mod_zone_page_state(zone, NR_MLOCK, delta_munlocked);
-	local_irq_enable();
+	if (lruvec)
+		unlock_page_lruvec_irq(lruvec);
 
 	/* Now we can release pins of pages that we are not munlocking */
 	pagevec_release(&pvec_putback);
diff --git a/mm/mmzone.c b/mm/mmzone.c
index 4686fdc23bb9..3750a90ed4a0 100644
--- a/mm/mmzone.c
+++ b/mm/mmzone.c
@@ -91,6 +91,7 @@ void lruvec_init(struct lruvec *lruvec)
 	enum lru_list lru;
 
 	memset(lruvec, 0, sizeof(struct lruvec));
+	spin_lock_init(&lruvec->lru_lock);
 
 	for_each_lru(lru)
 		INIT_LIST_HEAD(&lruvec->lists[lru]);
diff --git a/mm/swap.c b/mm/swap.c
index 2898efc24135..91ff3d4a7751 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -60,14 +60,12 @@
 static void __page_cache_release(struct page *page)
 {
 	if (TestClearPageLRU(page)) {
-		pg_data_t *pgdat = page_pgdat(page);
 		struct lruvec *lruvec;
 		unsigned long flags;
 
-		spin_lock_irqsave(&pgdat->lru_lock, flags);
-		lruvec = mem_cgroup_page_lruvec(page, pgdat);
+		lruvec = lock_page_lruvec_irqsave(page, &flags);
 		del_page_from_lru_list(page, lruvec, page_off_lru(page));
-		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
+		unlock_page_lruvec_irqrestore(lruvec, flags);
 	}
 	__ClearPageWaiters(page);
 }
@@ -187,26 +185,24 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
 	void *arg)
 {
 	int i;
-	struct pglist_data *pgdat = NULL;
-	struct lruvec *lruvec;
+	struct lruvec *lruvec = NULL;
 	unsigned long flags = 0;
 
 	for (i = 0; i < pagevec_count(pvec); i++) {
 		struct page *page = pvec->pages[i];
-		struct pglist_data *pagepgdat = page_pgdat(page);
+		struct lruvec *new_lruvec;
 
-		if (pagepgdat != pgdat) {
-			if (pgdat)
-				spin_unlock_irqrestore(&pgdat->lru_lock, flags);
-			pgdat = pagepgdat;
-			spin_lock_irqsave(&pgdat->lru_lock, flags);
+		new_lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
+		if (lruvec != new_lruvec) {
+			if (lruvec)
+				unlock_page_lruvec_irqrestore(lruvec, flags);
+			lruvec = lock_page_lruvec_irqsave(page, &flags);
 		}
 
-		lruvec = mem_cgroup_page_lruvec(page, pgdat);
 		(*move_fn)(page, lruvec, arg);
 	}
-	if (pgdat)
-		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
+	if (lruvec)
+		unlock_page_lruvec_irqrestore(lruvec, flags);
 	release_pages(pvec->pages, pvec->nr);
 	pagevec_reinit(pvec);
 }
@@ -345,11 +341,12 @@ static inline void activate_page_drain(int cpu)
 void activate_page(struct page *page)
 {
 	pg_data_t *pgdat = page_pgdat(page);
+	struct lruvec *lruvec;
 
 	page = compound_head(page);
-	spin_lock_irq(&pgdat->lru_lock);
-	__activate_page(page, mem_cgroup_page_lruvec(page, pgdat), NULL);
-	spin_unlock_irq(&pgdat->lru_lock);
+	lruvec = lock_page_lruvec_irq(page);
+	__activate_page(page, lruvec, NULL);
+	unlock_page_lruvec_irq(lruvec);
 }
 #endif
 
@@ -773,8 +770,7 @@ void release_pages(struct page **pages, int nr)
 {
 	int i;
 	LIST_HEAD(pages_to_free);
-	struct pglist_data *locked_pgdat = NULL;
-	struct lruvec *lruvec;
+	struct lruvec *lruvec = NULL;
 	unsigned long uninitialized_var(flags);
 	unsigned int uninitialized_var(lock_batch);
 
@@ -784,21 +780,20 @@ void release_pages(struct page **pages, int nr)
 		/*
 		 * Make sure the IRQ-safe lock-holding time does not get
 		 * excessive with a continuous string of pages from the
-		 * same pgdat. The lock is held only if pgdat != NULL.
+		 * same lruvec. The lock is held only if lruvec != NULL.
 		 */
-		if (locked_pgdat && ++lock_batch == SWAP_CLUSTER_MAX) {
-			spin_unlock_irqrestore(&locked_pgdat->lru_lock, flags);
-			locked_pgdat = NULL;
+		if (lruvec && ++lock_batch == SWAP_CLUSTER_MAX) {
+			unlock_page_lruvec_irqrestore(lruvec, flags);
+			lruvec = NULL;
 		}
 
 		if (is_huge_zero_page(page))
 			continue;
 
 		if (is_zone_device_page(page)) {
-			if (locked_pgdat) {
-				spin_unlock_irqrestore(&locked_pgdat->lru_lock,
-						       flags);
-				locked_pgdat = NULL;
+			if (lruvec) {
+				unlock_page_lruvec_irqrestore(lruvec, flags);
+				lruvec = NULL;
 			}
 			/*
 			 * ZONE_DEVICE pages that return 'false' from
@@ -817,27 +812,27 @@ void release_pages(struct page **pages, int nr)
 			continue;
 
 		if (PageCompound(page)) {
-			if (locked_pgdat) {
-				spin_unlock_irqrestore(&locked_pgdat->lru_lock, flags);
-				locked_pgdat = NULL;
+			if (lruvec) {
+				unlock_page_lruvec_irqrestore(lruvec, flags);
+				lruvec = NULL;
 			}
 			__put_compound_page(page);
 			continue;
 		}
 
 		if (TestClearPageLRU(page)) {
-			struct pglist_data *pgdat = page_pgdat(page);
+			struct lruvec *new_lruvec;
 
-			if (pgdat != locked_pgdat) {
-				if (locked_pgdat)
-					spin_unlock_irqrestore(&locked_pgdat->lru_lock,
+			new_lruvec = mem_cgroup_page_lruvec(page,
+							page_pgdat(page));
+			if (new_lruvec != lruvec) {
+				if (lruvec)
+					unlock_page_lruvec_irqrestore(lruvec,
 									flags);
 				lock_batch = 0;
-				locked_pgdat = pgdat;
-				spin_lock_irqsave(&locked_pgdat->lru_lock, flags);
+				lruvec = lock_page_lruvec_irqsave(page, &flags);
 			}
 
-			lruvec = mem_cgroup_page_lruvec(page, locked_pgdat);
 			del_page_from_lru_list(page, lruvec, page_off_lru(page));
 		}
 
@@ -847,8 +842,8 @@ void release_pages(struct page **pages, int nr)
 
 		list_add(&page->lru, &pages_to_free);
 	}
-	if (locked_pgdat)
-		spin_unlock_irqrestore(&locked_pgdat->lru_lock, flags);
+	if (lruvec)
+		unlock_page_lruvec_irqrestore(lruvec, flags);
 
 	mem_cgroup_uncharge_list(&pages_to_free);
 	free_unref_page_list(&pages_to_free);
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 9d20b00627af..cbaa1a60434d 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -362,6 +362,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 {
 	struct swap_info_struct *si;
 	struct page *page;
+	struct lruvec *lruvec = NULL;
 
 	*new_page_allocated = false;
 
@@ -441,9 +442,10 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	}
 
 	/* XXX: Move to lru_cache_add() when it supports new vs putback */
-	spin_lock_irq(&page_pgdat(page)->lru_lock);
+	lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
+	spin_lock_irq(&lruvec->lru_lock);
 	lru_note_cost_page(page);
-	spin_unlock_irq(&page_pgdat(page)->lru_lock);
+	spin_unlock_irq(&lruvec->lru_lock);
 
 	/* Caller will initiate read into locked page */
 	SetPageWorkingset(page);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index df0765203473..c4c30b530876 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1774,14 +1774,12 @@ int isolate_lru_page(struct page *page)
 
 	get_page(page);
 	if (TestClearPageLRU(page)) {
-		pg_data_t *pgdat = page_pgdat(page);
 		struct lruvec *lruvec;
 		int lru = page_lru(page);
 
-		lruvec = mem_cgroup_page_lruvec(page, pgdat);
-		spin_lock_irq(&pgdat->lru_lock);
+		lruvec = lock_page_lruvec_irq(page);
 		del_page_from_lru_list(page, lruvec, lru);
-		spin_unlock_irq(&pgdat->lru_lock);
+		unlock_page_lruvec_irq(lruvec);
 		ret = 0;
 	} else
 		put_page(page);
@@ -1849,20 +1847,22 @@ static int too_many_isolated(struct pglist_data *pgdat, int file,
 static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 						     struct list_head *list)
 {
-	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 	int nr_pages, nr_moved = 0;
 	LIST_HEAD(pages_to_free);
 	struct page *page;
+	struct lruvec *orig_lruvec = lruvec;
 	enum lru_list lru;
 
 	while (!list_empty(list)) {
+		struct lruvec *new_lruvec = NULL;
+
 		page = lru_to_page(list);
 		VM_BUG_ON_PAGE(PageLRU(page), page);
 		list_del(&page->lru);
 		if (unlikely(!page_evictable(page))) {
-			spin_unlock_irq(&pgdat->lru_lock);
+			spin_unlock_irq(&lruvec->lru_lock);
 			putback_lru_page(page);
-			spin_lock_irq(&pgdat->lru_lock);
+			spin_lock_irq(&lruvec->lru_lock);
 			continue;
 		}
 
@@ -1876,6 +1876,12 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 		 *                                        list_add(&page->lru,)
 		 *     list_add(&page->lru,) //corrupt
 		 */
+		new_lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
+		if (new_lruvec != lruvec) {
+			if (lruvec)
+				spin_unlock_irq(&lruvec->lru_lock);
+			lruvec = lock_page_lruvec_irq(page);
+		}
 		SetPageLRU(page);
 
 		if (unlikely(put_page_testzero(page))) {
@@ -1883,15 +1889,14 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 			__ClearPageActive(page);
 
 			if (unlikely(PageCompound(page))) {
-				spin_unlock_irq(&pgdat->lru_lock);
+				spin_unlock_irq(&lruvec->lru_lock);
 				destroy_compound_page(page);
-				spin_lock_irq(&pgdat->lru_lock);
+				spin_lock_irq(&lruvec->lru_lock);
 			} else
 				list_add(&page->lru, &pages_to_free);
 			continue;
 		}
 
-		lruvec = mem_cgroup_page_lruvec(page, pgdat);
 		lru = page_lru(page);
 		nr_pages = hpage_nr_pages(page);
 
@@ -1899,6 +1904,11 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 		list_add(&page->lru, &lruvec->lists[lru]);
 		nr_moved += nr_pages;
 	}
+	if (orig_lruvec != lruvec) {
+		if (lruvec)
+			spin_unlock_irq(&lruvec->lru_lock);
+		spin_lock_irq(&orig_lruvec->lru_lock);
+	}
 
 	/*
 	 * To save our caller's stack, now use input list for pages to free.
@@ -1954,7 +1964,7 @@ static int current_may_throttle(void)
 
 	lru_add_drain();
 
-	spin_lock_irq(&pgdat->lru_lock);
+	spin_lock_irq(&lruvec->lru_lock);
 
 	nr_taken = isolate_lru_pages(nr_to_scan, lruvec, &page_list,
 				     &nr_scanned, sc, lru);
@@ -1966,7 +1976,7 @@ static int current_may_throttle(void)
 	__count_memcg_events(lruvec_memcg(lruvec), item, nr_scanned);
 	__count_vm_events(PGSCAN_ANON + file, nr_scanned);
 
-	spin_unlock_irq(&pgdat->lru_lock);
+	spin_unlock_irq(&lruvec->lru_lock);
 
 	if (nr_taken == 0)
 		return 0;
@@ -1974,7 +1984,7 @@ static int current_may_throttle(void)
 	nr_reclaimed = shrink_page_list(&page_list, pgdat, sc, 0,
 				&stat, false);
 
-	spin_lock_irq(&pgdat->lru_lock);
+	spin_lock_irq(&lruvec->lru_lock);
 
 	move_pages_to_lru(lruvec, &page_list);
 
@@ -1986,7 +1996,7 @@ static int current_may_throttle(void)
 	__count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
 	__count_vm_events(PGSTEAL_ANON + file, nr_reclaimed);
 
-	spin_unlock_irq(&pgdat->lru_lock);
+	spin_unlock_irq(&lruvec->lru_lock);
 
 	mem_cgroup_uncharge_list(&page_list);
 	free_unref_page_list(&page_list);
@@ -2038,7 +2048,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 
 	lru_add_drain();
 
-	spin_lock_irq(&pgdat->lru_lock);
+	spin_lock_irq(&lruvec->lru_lock);
 
 	nr_taken = isolate_lru_pages(nr_to_scan, lruvec, &l_hold,
 				     &nr_scanned, sc, lru);
@@ -2048,7 +2058,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	__count_vm_events(PGREFILL, nr_scanned);
 	__count_memcg_events(lruvec_memcg(lruvec), PGREFILL, nr_scanned);
 
-	spin_unlock_irq(&pgdat->lru_lock);
+	spin_unlock_irq(&lruvec->lru_lock);
 
 	while (!list_empty(&l_hold)) {
 		cond_resched();
@@ -2094,7 +2104,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	/*
 	 * Move pages back to the lru list.
 	 */
-	spin_lock_irq(&pgdat->lru_lock);
+	spin_lock_irq(&lruvec->lru_lock);
 
 	nr_activate = move_pages_to_lru(lruvec, &l_active);
 	nr_deactivate = move_pages_to_lru(lruvec, &l_inactive);
@@ -2105,7 +2115,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	__count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_deactivate);
 
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
-	spin_unlock_irq(&pgdat->lru_lock);
+	spin_unlock_irq(&lruvec->lru_lock);
 
 	mem_cgroup_uncharge_list(&l_active);
 	free_unref_page_list(&l_active);
@@ -2695,10 +2705,10 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	/*
 	 * Determine the scan balance between anon and file LRUs.
 	 */
-	spin_lock_irq(&pgdat->lru_lock);
+	spin_lock_irq(&target_lruvec->lru_lock);
 	sc->anon_cost = target_lruvec->anon_cost;
 	sc->file_cost = target_lruvec->file_cost;
-	spin_unlock_irq(&pgdat->lru_lock);
+	spin_unlock_irq(&target_lruvec->lru_lock);
 
 	/*
 	 * Target desirable inactive:active list ratios for the anon
@@ -4274,24 +4284,22 @@ int node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned int order)
  */
 void check_move_unevictable_pages(struct pagevec *pvec)
 {
-	struct lruvec *lruvec;
-	struct pglist_data *pgdat = NULL;
+	struct lruvec *lruvec = NULL;
 	int pgscanned = 0;
 	int pgrescued = 0;
 	int i;
 
 	for (i = 0; i < pvec->nr; i++) {
 		struct page *page = pvec->pages[i];
-		struct pglist_data *pagepgdat = page_pgdat(page);
+		struct lruvec *new_lruvec;
 
 		pgscanned++;
-		if (pagepgdat != pgdat) {
-			if (pgdat)
-				spin_unlock_irq(&pgdat->lru_lock);
-			pgdat = pagepgdat;
-			spin_lock_irq(&pgdat->lru_lock);
+		new_lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
+		if (lruvec != new_lruvec) {
+			if (lruvec)
+				unlock_page_lruvec_irq(lruvec);
+			lruvec = lock_page_lruvec_irq(page);
 		}
-		lruvec = mem_cgroup_page_lruvec(page, pgdat);
 
 		if (!PageLRU(page) || !PageUnevictable(page))
 			continue;
@@ -4307,10 +4315,10 @@ void check_move_unevictable_pages(struct pagevec *pvec)
 		}
 	}
 
-	if (pgdat) {
+	if (lruvec) {
 		__count_vm_events(UNEVICTABLE_PGRESCUED, pgrescued);
 		__count_vm_events(UNEVICTABLE_PGSCANNED, pgscanned);
-		spin_unlock_irq(&pgdat->lru_lock);
+		unlock_page_lruvec_irq(lruvec);
 	}
 }
 EXPORT_SYMBOL_GPL(check_move_unevictable_pages);
diff --git a/mm/workingset.c b/mm/workingset.c
index d481ea452eeb..7423a022c27b 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -366,9 +366,9 @@ void workingset_refault(struct page *page, void *shadow)
 	if (workingset) {
 		SetPageWorkingset(page);
 		/* XXX: Move to lru_cache_add() when it supports new vs putback */
-		spin_lock_irq(&page_pgdat(page)->lru_lock);
+		spin_lock_irq(&lruvec->lru_lock);
 		lru_note_cost_page(page);
-		spin_unlock_irq(&page_pgdat(page)->lru_lock);
+		spin_unlock_irq(&lruvec->lru_lock);
 		inc_lruvec_state(lruvec, WORKINGSET_RESTORE);
 	}
 out:
-- 
1.8.3.1


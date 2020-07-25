Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370E022D7C7
	for <lists+cgroups@lfdr.de>; Sat, 25 Jul 2020 15:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgGYNBf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 25 Jul 2020 09:01:35 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:37558 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727087AbgGYNBf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 25 Jul 2020 09:01:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0U3l6fmD_1595682015;
Received: from aliy8.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U3l6fmD_1595682015)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 25 Jul 2020 21:00:27 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: [PATCH v17 17/21] mm/lru: replace pgdat lru_lock with lruvec lock
Date:   Sat, 25 Jul 2020 20:59:54 +0800
Message-Id: <1595681998-19193-18-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patch moves per node lru_lock into lruvec, thus bring a lru_lock for
each of memcg per node. So on a large machine, each of memcg don't
have to suffer from per node pgdat->lru_lock competition. They could go
fast with their self lru_lock.

After move memcg charge before lru inserting, page isolation could
serialize page's memcg, then per memcg lruvec lock is stable and could
replace per node lru lock.

According to Daniel Jordan's suggestion, I run 208 'dd' with on 104
containers on a 2s * 26cores * HT box with a modefied case:
https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-lru-file-readtwice

With this and later patches, the readtwice performance increases about
80% within concurrent containers.

Also add a debug func in locking which may give some clues if there are
sth out of hands.

Hugh Dickins helped on patch polish, thanks!

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: cgroups@vger.kernel.org
---
 include/linux/memcontrol.h |  58 +++++++++++++++++++++++++
 include/linux/mmzone.h     |   2 +
 mm/compaction.c            |  67 ++++++++++++++++++-----------
 mm/huge_memory.c           |  11 ++---
 mm/memcontrol.c            |  63 ++++++++++++++++++++++++++-
 mm/mlock.c                 |  47 +++++++++++++-------
 mm/mmzone.c                |   1 +
 mm/swap.c                  | 104 +++++++++++++++++++++------------------------
 mm/vmscan.c                |  70 ++++++++++++++++--------------
 9 files changed, 288 insertions(+), 135 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e77197a62809..258901021c6c 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -411,6 +411,19 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
 
 struct mem_cgroup *get_mem_cgroup_from_page(struct page *page);
 
+struct lruvec *lock_page_lruvec(struct page *page);
+struct lruvec *lock_page_lruvec_irq(struct page *page);
+struct lruvec *lock_page_lruvec_irqsave(struct page *page,
+						unsigned long *flags);
+
+#ifdef CONFIG_DEBUG_VM
+void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page);
+#else
+static inline void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
+{
+}
+#endif
+
 static inline
 struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css){
 	return css ? container_of(css, struct mem_cgroup, css) : NULL;
@@ -892,6 +905,31 @@ static inline void mem_cgroup_put(struct mem_cgroup *memcg)
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
 static inline struct mem_cgroup *
 mem_cgroup_iter(struct mem_cgroup *root,
 		struct mem_cgroup *prev,
@@ -1126,6 +1164,10 @@ static inline void count_memcg_page_event(struct page *page,
 void count_memcg_event_mm(struct mm_struct *mm, enum vm_event_item idx)
 {
 }
+
+static inline void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
+{
+}
 #endif /* CONFIG_MEMCG */
 
 /* idx can be of type enum memcg_stat_item or node_stat_item */
@@ -1255,6 +1297,22 @@ static inline struct lruvec *parent_lruvec(struct lruvec *lruvec)
 	return mem_cgroup_lruvec(memcg, lruvec_pgdat(lruvec));
 }
 
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
 #ifdef CONFIG_CGROUP_WRITEBACK
 
 struct wb_domain *mem_cgroup_wb_domain(struct bdi_writeback *wb);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 14c668b7e793..30b961a9a749 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -249,6 +249,8 @@ enum lruvec_flags {
 };
 
 struct lruvec {
+	/* per lruvec lru_lock for memcg */
+	spinlock_t			lru_lock;
 	struct list_head		lists[NR_LRU_LISTS];
 	/*
 	 * These track the cost of reclaiming one LRU - file or anon -
diff --git a/mm/compaction.c b/mm/compaction.c
index 2da2933fe56b..88bbd2e93895 100644
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
@@ -922,10 +932,9 @@ static bool too_many_isolated(pg_data_t *pgdat)
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
@@ -966,10 +975,20 @@ static bool too_many_isolated(pg_data_t *pgdat)
 		if (!TestClearPageLRU(page))
 			goto isolate_fail_put;
 
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
@@ -988,9 +1007,8 @@ static bool too_many_isolated(pg_data_t *pgdat)
 				SetPageLRU(page);
 				goto isolate_fail_put;
 			}
-		}
-
-		lruvec = mem_cgroup_page_lruvec(page, pgdat);
+		} else
+			rcu_read_unlock();
 
 		/* The whole page is taken off the LRU; skip the tail pages. */
 		if (PageCompound(page))
@@ -1023,9 +1041,9 @@ static bool too_many_isolated(pg_data_t *pgdat)
 
 isolate_fail_put:
 		/* Avoid potential deadlock in freeing page under lru_lock */
-		if (locked) {
-			spin_unlock_irqrestore(&pgdat->lru_lock, flags);
-			locked = false;
+		if (locked_lruvec) {
+			unlock_page_lruvec_irqrestore(locked_lruvec, flags);
+			locked_lruvec = NULL;
 		}
 		put_page(page);
 
@@ -1039,9 +1057,10 @@ static bool too_many_isolated(pg_data_t *pgdat)
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
@@ -1068,8 +1087,8 @@ static bool too_many_isolated(pg_data_t *pgdat)
 	page = NULL;
 
 isolate_abort:
-	if (locked)
-		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
+	if (locked_lruvec)
+		unlock_page_lruvec_irqrestore(locked_lruvec, flags);
 	if (page) {
 		SetPageLRU(page);
 		put_page(page);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 28538444197b..a0cb95891ae5 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2346,7 +2346,7 @@ static void lru_add_page_tail(struct page *head, struct page *page_tail,
 	VM_BUG_ON_PAGE(!PageHead(head), head);
 	VM_BUG_ON_PAGE(PageCompound(page_tail), head);
 	VM_BUG_ON_PAGE(PageLRU(page_tail), head);
-	lockdep_assert_held(&lruvec_pgdat(lruvec)->lru_lock);
+	lockdep_assert_held(&lruvec->lru_lock);
 
 	if (list) {
 		/* page reclaim is reclaiming a huge page */
@@ -2430,7 +2430,6 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 			      pgoff_t end)
 {
 	struct page *head = compound_head(page);
-	pg_data_t *pgdat = page_pgdat(head);
 	struct lruvec *lruvec;
 	struct address_space *swap_cache = NULL;
 	unsigned long offset = 0;
@@ -2447,10 +2446,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		xa_lock(&swap_cache->i_pages);
 	}
 
-	/* prevent PageLRU to go away from under us, and freeze lru stats */
-	spin_lock(&pgdat->lru_lock);
-
-	lruvec = mem_cgroup_page_lruvec(head, pgdat);
+	/* lock lru list/PageCompound, ref freezed by page_ref_freeze */
+	lruvec = lock_page_lruvec(head);
 
 	for (i = HPAGE_PMD_NR - 1; i >= 1; i--) {
 		__split_huge_page_tail(head, i, lruvec, list);
@@ -2471,7 +2468,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	}
 
 	ClearPageCompound(head);
-	spin_unlock(&pgdat->lru_lock);
+	unlock_page_lruvec(lruvec);
 	/* Caller disabled irqs, so they are still disabled here */
 
 	split_page_owner(head, HPAGE_PMD_ORDER);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 20c8ed69a930..d6746656cc39 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1196,6 +1196,19 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 	return ret;
 }
 
+#ifdef CONFIG_DEBUG_VM
+void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
+{
+	if (mem_cgroup_disabled())
+		return;
+
+	if (!page->mem_cgroup)
+		VM_BUG_ON_PAGE(lruvec_memcg(lruvec) != root_mem_cgroup, page);
+	else
+		VM_BUG_ON_PAGE(lruvec_memcg(lruvec) != page->mem_cgroup, page);
+}
+#endif
+
 /**
  * mem_cgroup_page_lruvec - return lruvec for isolating/putting an LRU page
  * @page: the page
@@ -1215,7 +1228,8 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgd
 		goto out;
 	}
 
-	memcg = page->mem_cgroup;
+	VM_BUG_ON_PAGE(PageTail(page), page);
+	memcg = READ_ONCE(page->mem_cgroup);
 	/*
 	 * Swapcache readahead pages are added to the LRU - and
 	 * possibly migrated - before they are charged.
@@ -1236,6 +1250,51 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgd
 	return lruvec;
 }
 
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
 /**
  * mem_cgroup_update_lru_size - account for adding or removing an lru page
  * @lruvec: mem_cgroup per zone lru vector
@@ -2999,7 +3058,7 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
 
 /*
  * Because tail pages are not marked as "used", set it. We're under
- * pgdat->lru_lock and migration entries setup in all page mappings.
+ * lruvec->lru_lock and migration entries setup in all page mappings.
  */
 void mem_cgroup_split_huge_fixup(struct page *head)
 {
diff --git a/mm/mlock.c b/mm/mlock.c
index 228ba5a8e0a5..5d40d259a931 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -106,12 +106,10 @@ void mlock_vma_page(struct page *page)
  * Isolate a page from LRU with optional get_page() pin.
  * Assumes lru_lock already held and page already pinned.
  */
-static bool __munlock_isolate_lru_page(struct page *page, bool getpage)
+static bool __munlock_isolate_lru_page(struct page *page,
+				struct lruvec *lruvec, bool getpage)
 {
 	if (TestClearPageLRU(page)) {
-		struct lruvec *lruvec;
-
-		lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
 		if (getpage)
 			get_page(page);
 		del_page_from_lru_list(page, lruvec, page_lru(page));
@@ -181,7 +179,7 @@ static void __munlock_isolation_failed(struct page *page)
 unsigned int munlock_vma_page(struct page *page)
 {
 	int nr_pages;
-	pg_data_t *pgdat = page_pgdat(page);
+	struct lruvec *lruvec;
 
 	/* For try_to_munlock() and to serialize with page migration */
 	BUG_ON(!PageLocked(page));
@@ -189,11 +187,16 @@ unsigned int munlock_vma_page(struct page *page)
 	VM_BUG_ON_PAGE(PageTail(page), page);
 
 	/*
-	 * Serialize with any parallel __split_huge_page_refcount() which
+	 * Serialize split tail pages in __split_huge_page_tail() which
 	 * might otherwise copy PageMlocked to part of the tail pages before
 	 * we clear it in the head page. It also stabilizes hpage_nr_pages().
+	 * TestClearPageLRU can't be used here to block page isolation, since
+	 * out of lock clear_page_mlock may interfer PageLRU/PageMlocked
+	 * sequence, same as __pagevec_lru_add_fn, and lead the page place to
+	 * wrong lru list here. So relay on PageLocked to stop lruvec change
+	 * in mem_cgroup_move_account().
 	 */
-	spin_lock_irq(&pgdat->lru_lock);
+	lruvec = lock_page_lruvec_irq(page);
 
 	if (!TestClearPageMlocked(page)) {
 		/* Potentially, PTE-mapped THP: do not skip the rest PTEs */
@@ -204,15 +207,15 @@ unsigned int munlock_vma_page(struct page *page)
 	nr_pages = hpage_nr_pages(page);
 	__mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
 
-	if (__munlock_isolate_lru_page(page, true)) {
-		spin_unlock_irq(&pgdat->lru_lock);
+	if (__munlock_isolate_lru_page(page, lruvec, true)) {
+		unlock_page_lruvec_irq(lruvec);
 		__munlock_isolated_page(page);
 		goto out;
 	}
 	__munlock_isolation_failed(page);
 
 unlock_out:
-	spin_unlock_irq(&pgdat->lru_lock);
+	unlock_page_lruvec_irq(lruvec);
 
 out:
 	return nr_pages - 1;
@@ -292,23 +295,34 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
 	int nr = pagevec_count(pvec);
 	int delta_munlocked = -nr;
 	struct pagevec pvec_putback;
+	struct lruvec *lruvec = NULL;
 	int pgrescued = 0;
 
 	pagevec_init(&pvec_putback);
 
 	/* Phase 1: page isolation */
-	spin_lock_irq(&zone->zone_pgdat->lru_lock);
 	for (i = 0; i < nr; i++) {
 		struct page *page = pvec->pages[i];
+		struct lruvec *new_lruvec;
+
+		/* block memcg change in mem_cgroup_move_account */
+		lock_page_memcg(page);
+		new_lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
+		if (new_lruvec != lruvec) {
+			if (lruvec)
+				unlock_page_lruvec_irq(lruvec);
+			lruvec = lock_page_lruvec_irq(page);
+		}
 
 		if (TestClearPageMlocked(page)) {
 			/*
 			 * We already have pin from follow_page_mask()
 			 * so we can spare the get_page() here.
 			 */
-			if (__munlock_isolate_lru_page(page, false))
+			if (__munlock_isolate_lru_page(page, lruvec, false)) {
+				unlock_page_memcg(page);
 				continue;
-			else
+			} else
 				__munlock_isolation_failed(page);
 		} else {
 			delta_munlocked++;
@@ -320,11 +334,14 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
 		 * pin. We cannot do it under lru_lock however. If it's
 		 * the last pin, __page_cache_release() would deadlock.
 		 */
+		unlock_page_memcg(page);
 		pagevec_add(&pvec_putback, pvec->pages[i]);
 		pvec->pages[i] = NULL;
 	}
-	__mod_zone_page_state(zone, NR_MLOCK, delta_munlocked);
-	spin_unlock_irq(&zone->zone_pgdat->lru_lock);
+	if (lruvec) {
+		__mod_zone_page_state(zone, NR_MLOCK, delta_munlocked);
+		unlock_page_lruvec_irq(lruvec);
+	}
 
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
index 3029b3f74811..09edac441eb6 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -79,15 +79,13 @@ static DEFINE_PER_CPU(struct lru_pvecs, lru_pvecs) = {
 static void __page_cache_release(struct page *page)
 {
 	if (PageLRU(page)) {
-		pg_data_t *pgdat = page_pgdat(page);
 		struct lruvec *lruvec;
 		unsigned long flags;
 
 		__ClearPageLRU(page);
-		spin_lock_irqsave(&pgdat->lru_lock, flags);
-		lruvec = mem_cgroup_page_lruvec(page, pgdat);
+		lruvec = lock_page_lruvec_irqsave(page, &flags);
 		del_page_from_lru_list(page, lruvec, page_off_lru(page));
-		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
+		unlock_page_lruvec_irqrestore(lruvec, flags);
 	}
 	__ClearPageWaiters(page);
 }
@@ -206,32 +204,30 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
 	void (*move_fn)(struct page *page, struct lruvec *lruvec))
 {
 	int i;
-	struct pglist_data *pgdat = NULL;
-	struct lruvec *lruvec;
+	struct lruvec *lruvec = NULL;
 	unsigned long flags = 0;
 
 	for (i = 0; i < pagevec_count(pvec); i++) {
 		struct page *page = pvec->pages[i];
-		struct pglist_data *pagepgdat = page_pgdat(page);
-
-		if (pagepgdat != pgdat) {
-			if (pgdat)
-				spin_unlock_irqrestore(&pgdat->lru_lock, flags);
-			pgdat = pagepgdat;
-			spin_lock_irqsave(&pgdat->lru_lock, flags);
-		}
+		struct lruvec *new_lruvec;
 
 		/* block memcg migration during page moving between lru */
 		if (!TestClearPageLRU(page))
 			continue;
 
-		lruvec = mem_cgroup_page_lruvec(page, pgdat);
+		new_lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
+		if (lruvec != new_lruvec) {
+			if (lruvec)
+				unlock_page_lruvec_irqrestore(lruvec, flags);
+			lruvec = lock_page_lruvec_irqsave(page, &flags);
+		}
+
 		(*move_fn)(page, lruvec);
 
 		SetPageLRU(page);
 	}
-	if (pgdat)
-		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
+	if (lruvec)
+		unlock_page_lruvec_irqrestore(lruvec, flags);
 	release_pages(pvec->pages, pvec->nr);
 	pagevec_reinit(pvec);
 }
@@ -274,9 +270,8 @@ void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
 {
 	do {
 		unsigned long lrusize;
-		struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 
-		spin_lock_irq(&pgdat->lru_lock);
+		spin_lock_irq(&lruvec->lru_lock);
 		/* Record cost event */
 		if (file)
 			lruvec->file_cost += nr_pages;
@@ -300,7 +295,7 @@ void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
 			lruvec->file_cost /= 2;
 			lruvec->anon_cost /= 2;
 		}
-		spin_unlock_irq(&pgdat->lru_lock);
+		spin_unlock_irq(&lruvec->lru_lock);
 	} while ((lruvec = parent_lruvec(lruvec)));
 }
 
@@ -365,12 +360,13 @@ static inline void activate_page_drain(int cpu)
 void activate_page(struct page *page)
 {
 	pg_data_t *pgdat = page_pgdat(page);
+	struct lruvec *lruvec;
 
 	page = compound_head(page);
-	spin_lock_irq(&pgdat->lru_lock);
+	lruvec = lock_page_lruvec_irq(page);
 	if (PageLRU(page))
-		__activate_page(page, mem_cgroup_page_lruvec(page, pgdat));
-	spin_unlock_irq(&pgdat->lru_lock);
+		__activate_page(page, lruvec);
+	unlock_page_lruvec_irq(lruvec);
 }
 #endif
 
@@ -817,8 +813,7 @@ void release_pages(struct page **pages, int nr)
 {
 	int i;
 	LIST_HEAD(pages_to_free);
-	struct pglist_data *locked_pgdat = NULL;
-	struct lruvec *lruvec;
+	struct lruvec *lruvec = NULL;
 	unsigned long uninitialized_var(flags);
 	unsigned int uninitialized_var(lock_batch);
 
@@ -828,21 +823,20 @@ void release_pages(struct page **pages, int nr)
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
@@ -861,28 +855,28 @@ void release_pages(struct page **pages, int nr)
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
 
 		if (PageLRU(page)) {
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
 
 			__ClearPageLRU(page);
-			lruvec = mem_cgroup_page_lruvec(page, locked_pgdat);
 			del_page_from_lru_list(page, lruvec, page_off_lru(page));
 		}
 
@@ -892,8 +886,8 @@ void release_pages(struct page **pages, int nr)
 
 		list_add(&page->lru, &pages_to_free);
 	}
-	if (locked_pgdat)
-		spin_unlock_irqrestore(&locked_pgdat->lru_lock, flags);
+	if (lruvec)
+		unlock_page_lruvec_irqrestore(lruvec, flags);
 
 	mem_cgroup_uncharge_list(&pages_to_free);
 	free_unref_page_list(&pages_to_free);
@@ -981,26 +975,24 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
 void __pagevec_lru_add(struct pagevec *pvec)
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
 		__pagevec_lru_add_fn(page, lruvec);
 	}
-	if (pgdat)
-		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
+	if (lruvec)
+		unlock_page_lruvec_irqrestore(lruvec, flags);
 	release_pages(pvec->pages, pvec->nr);
 	pagevec_reinit(pvec);
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index f77748adc340..168c1659e430 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1774,15 +1774,13 @@ int isolate_lru_page(struct page *page)
 	WARN_RATELIMIT(PageTail(page), "trying to isolate tail page");
 
 	if (TestClearPageLRU(page)) {
-		pg_data_t *pgdat = page_pgdat(page);
 		struct lruvec *lruvec;
 		int lru = page_lru(page);
 
 		get_page(page);
-		lruvec = mem_cgroup_page_lruvec(page, pgdat);
-		spin_lock_irq(&pgdat->lru_lock);
+		lruvec = lock_page_lruvec_irq(page);
 		del_page_from_lru_list(page, lruvec, lru);
-		spin_unlock_irq(&pgdat->lru_lock);
+		unlock_page_lruvec_irq(lruvec);
 		ret = 0;
 	}
 
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
@@ -1883,16 +1889,15 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
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
 
@@ -1902,6 +1907,11 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 		if (PageActive(page))
 			workingset_age_nonresident(lruvec, nr_pages);
 	}
+	if (orig_lruvec != lruvec) {
+		if (lruvec)
+			spin_unlock_irq(&lruvec->lru_lock);
+		spin_lock_irq(&orig_lruvec->lru_lock);
+	}
 
 	/*
 	 * To save our caller's stack, now use input list for pages to free.
@@ -1957,7 +1967,7 @@ static int current_may_throttle(void)
 
 	lru_add_drain();
 
-	spin_lock_irq(&pgdat->lru_lock);
+	spin_lock_irq(&lruvec->lru_lock);
 
 	nr_taken = isolate_lru_pages(nr_to_scan, lruvec, &page_list,
 				     &nr_scanned, sc, lru);
@@ -1969,7 +1979,7 @@ static int current_may_throttle(void)
 	__count_memcg_events(lruvec_memcg(lruvec), item, nr_scanned);
 	__count_vm_events(PGSCAN_ANON + file, nr_scanned);
 
-	spin_unlock_irq(&pgdat->lru_lock);
+	spin_unlock_irq(&lruvec->lru_lock);
 
 	if (nr_taken == 0)
 		return 0;
@@ -1977,7 +1987,7 @@ static int current_may_throttle(void)
 	nr_reclaimed = shrink_page_list(&page_list, pgdat, sc, 0,
 				&stat, false);
 
-	spin_lock_irq(&pgdat->lru_lock);
+	spin_lock_irq(&lruvec->lru_lock);
 	move_pages_to_lru(lruvec, &page_list);
 
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
@@ -1986,7 +1996,7 @@ static int current_may_throttle(void)
 		__count_vm_events(item, nr_reclaimed);
 	__count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
 	__count_vm_events(PGSTEAL_ANON + file, nr_reclaimed);
-	spin_unlock_irq(&pgdat->lru_lock);
+	spin_unlock_irq(&lruvec->lru_lock);
 
 	lru_note_cost(lruvec, file, stat.nr_pageout);
 	mem_cgroup_uncharge_list(&page_list);
@@ -2039,7 +2049,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 
 	lru_add_drain();
 
-	spin_lock_irq(&pgdat->lru_lock);
+	spin_lock_irq(&lruvec->lru_lock);
 
 	nr_taken = isolate_lru_pages(nr_to_scan, lruvec, &l_hold,
 				     &nr_scanned, sc, lru);
@@ -2049,7 +2059,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	__count_vm_events(PGREFILL, nr_scanned);
 	__count_memcg_events(lruvec_memcg(lruvec), PGREFILL, nr_scanned);
 
-	spin_unlock_irq(&pgdat->lru_lock);
+	spin_unlock_irq(&lruvec->lru_lock);
 
 	while (!list_empty(&l_hold)) {
 		cond_resched();
@@ -2095,7 +2105,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	/*
 	 * Move pages back to the lru list.
 	 */
-	spin_lock_irq(&pgdat->lru_lock);
+	spin_lock_irq(&lruvec->lru_lock);
 
 	nr_activate = move_pages_to_lru(lruvec, &l_active);
 	nr_deactivate = move_pages_to_lru(lruvec, &l_inactive);
@@ -2106,7 +2116,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	__count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_deactivate);
 
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
-	spin_unlock_irq(&pgdat->lru_lock);
+	spin_unlock_irq(&lruvec->lru_lock);
 
 	mem_cgroup_uncharge_list(&l_active);
 	free_unref_page_list(&l_active);
@@ -2696,10 +2706,10 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
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
@@ -4275,24 +4285,22 @@ int node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned int order)
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
@@ -4308,10 +4316,10 @@ void check_move_unevictable_pages(struct pagevec *pvec)
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
-- 
1.8.3.1


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E14C6FEA5F
	for <lists+cgroups@lfdr.de>; Sat, 16 Nov 2019 04:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfKPDPQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Nov 2019 22:15:16 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:1470 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727215AbfKPDPP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Nov 2019 22:15:15 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=30;SR=0;TI=SMTPD_---0TiC5Qf._1573874110;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TiC5Qf._1573874110)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 16 Nov 2019 11:15:10 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     alex.shi@linux.alibaba.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        swkhack <swkhack@gmail.com>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 4/7] mm/lru: only change the lru_lock iff page's lruvec is different
Date:   Sat, 16 Nov 2019 11:15:03 +0800
Message-Id: <1573874106-23802-5-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1573874106-23802-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1573874106-23802-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

During the pagevec locking, a new page's lruvec is may same as
previous one. Thus we could save a re-locking, and only
change lock iff lruvec is new.

Function named relock_page_lruvec following Hugh Dickins patch.

The first version of this patch used rcu_read_lock to guard
lruvec assign and comparsion with locked_lruvev in relock_page_lruvec.
But Rong Chen <rong.a.chen@intel.com> report a regression with
PROVE_LOCKING config. The rcu_read locking causes qspinlock waiting to
be locked for too long.

Since we had hold a spinlock, rcu_read locking isn't necessary.

[lkp@intel.com: Fix RCU-related regression reported by LKP robot]
Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Roman Gushchin <guro@fb.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Chris Down <chris@chrisdown.name>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: swkhack <swkhack@gmail.com>
Cc: "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Nikolay Borisov <nborisov@suse.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Yafang Shao <laoar.shao@gmail.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Hugh Dickins <hughd@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/memcontrol.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
 mm/mlock.c                 | 16 +++++++++-------
 mm/swap.c                  | 14 ++++++--------
 mm/vmscan.c                | 24 ++++++++++++------------
 4 files changed, 71 insertions(+), 27 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0b32eadd0eda..eaec01fb627f 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1290,6 +1290,50 @@ static inline void dec_lruvec_page_state(struct page *page,
 	mod_lruvec_page_state(page, idx, -1);
 }
 
+/* Don't lock again iff page's lruvec locked */
+static inline struct lruvec *relock_page_lruvec_irq(struct page *page,
+					struct lruvec *locked_lruvec)
+{
+	struct pglist_data *pgdat = page_pgdat(page);
+	struct lruvec *lruvec;
+
+	if (!locked_lruvec)
+		goto lock;
+
+	lruvec = mem_cgroup_page_lruvec(page, pgdat);
+
+	if (locked_lruvec == lruvec)
+		return lruvec;
+
+	spin_unlock_irq(&locked_lruvec->lru_lock);
+
+lock:
+	lruvec = lock_page_lruvec_irq(page, pgdat);
+	return lruvec;
+}
+
+/* Don't lock again iff page's lruvec locked */
+static inline struct lruvec *relock_page_lruvec_irqsave(struct page *page,
+					struct lruvec *locked_lruvec)
+{
+	struct pglist_data *pgdat = page_pgdat(page);
+	struct lruvec *lruvec;
+
+	if (!locked_lruvec)
+		goto lock;
+
+	lruvec = mem_cgroup_page_lruvec(page, pgdat);
+
+	if (locked_lruvec == lruvec)
+		return lruvec;
+
+	spin_unlock_irqrestore(&locked_lruvec->lru_lock, locked_lruvec->irqflags);
+
+lock:
+	lruvec = lock_page_lruvec_irqsave(page, pgdat);
+	return lruvec;
+}
+
 #ifdef CONFIG_CGROUP_WRITEBACK
 
 struct wb_domain *mem_cgroup_wb_domain(struct bdi_writeback *wb);
diff --git a/mm/mlock.c b/mm/mlock.c
index b509b80b8513..8b3a97b62c0a 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -290,6 +290,7 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
 {
 	int i;
 	int nr = pagevec_count(pvec);
+	int delta_munlocked = -nr;
 	struct pagevec pvec_putback;
 	struct lruvec *lruvec = NULL;
 	int pgrescued = 0;
@@ -300,20 +301,19 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
 	for (i = 0; i < nr; i++) {
 		struct page *page = pvec->pages[i];
 
-		lruvec = lock_page_lruvec_irq(page, page_pgdat(page));
+		lruvec = relock_page_lruvec_irq(page, lruvec);
 
 		if (TestClearPageMlocked(page)) {
 			/*
 			 * We already have pin from follow_page_mask()
 			 * so we can spare the get_page() here.
 			 */
-			if (__munlock_isolate_lru_page(page, lruvec, false)) {
-				__mod_zone_page_state(zone, NR_MLOCK,  -1);
-				spin_unlock_irq(&lruvec->lru_lock);
+			if (__munlock_isolate_lru_page(page, lruvec, false))
 				continue;
-			} else
+			else
 				__munlock_isolation_failed(page);
-		}
+		} else
+			delta_munlocked++;
 
 		/*
 		 * We won't be munlocking this page in the next phase
@@ -323,8 +323,10 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
 		 */
 		pagevec_add(&pvec_putback, pvec->pages[i]);
 		pvec->pages[i] = NULL;
-		spin_unlock_irq(&lruvec->lru_lock);
 	}
+	__mod_zone_page_state(zone, NR_MLOCK, delta_munlocked);
+	if (lruvec)
+		spin_unlock_irq(&lruvec->lru_lock);
 
 	/* Now we can release pins of pages that we are not munlocking */
 	pagevec_release(&pvec_putback);
diff --git a/mm/swap.c b/mm/swap.c
index 60f04cb2b49e..a26e19738e96 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -195,11 +195,12 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
 	for (i = 0; i < pagevec_count(pvec); i++) {
 		struct page *page = pvec->pages[i];
 
-		lruvec = lock_page_lruvec_irqsave(page, page_pgdat(page));
+		lruvec = relock_page_lruvec_irqsave(page, lruvec);
 
 		(*move_fn)(page, lruvec, arg);
-		spin_unlock_irqrestore(&lruvec->lru_lock, lruvec->irqflags);
 	}
+	if (lruvec)
+		spin_unlock_irqrestore(&lruvec->lru_lock, lruvec->irqflags);
 
 	release_pages(pvec->pages, pvec->nr);
 	pagevec_reinit(pvec);
@@ -821,15 +822,12 @@ void release_pages(struct page **pages, int nr)
 		}
 
 		if (PageLRU(page)) {
-			struct lruvec *new_lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
+			struct lruvec *pre_lruvec = lruvec;
 
-			if (new_lruvec != lruvec) {
-				if (lruvec)
-					spin_unlock_irqrestore(&lruvec->lru_lock, lruvec->irqflags);
+			lruvec = relock_page_lruvec_irqsave(page, lruvec);
+			if (pre_lruvec != lruvec)
 				lock_batch = 0;
-				lruvec = lock_page_lruvec_irqsave(page, page_pgdat(page));
 
-			}
 			VM_BUG_ON_PAGE(!PageLRU(page), page);
 			__ClearPageLRU(page);
 			del_page_from_lru_list(page, lruvec, page_off_lru(page));
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 3cdf343e7a27..ba57c55a6a41 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1825,22 +1825,25 @@ static int too_many_isolated(struct pglist_data *pgdat, int file,
  * Returns the number of pages moved to the given lruvec.
  */
 
-static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
+static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *llvec,
 						     struct list_head *list)
 {
 	int nr_pages, nr_moved = 0;
 	LIST_HEAD(pages_to_free);
 	struct page *page;
 	enum lru_list lru;
+	struct lruvec *lruvec = llvec;
 
 	while (!list_empty(list)) {
 		page = lru_to_page(list);
+		lruvec = relock_page_lruvec_irq(page, lruvec);
+
 		VM_BUG_ON_PAGE(PageLRU(page), page);
 		if (unlikely(!page_evictable(page))) {
 			list_del(&page->lru);
 			spin_unlock_irq(&lruvec->lru_lock);
+			lruvec = NULL;
 			putback_lru_page(page);
-			spin_lock_irq(&lruvec->lru_lock);
 			continue;
 		}
 
@@ -1858,8 +1861,8 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 
 			if (unlikely(PageCompound(page))) {
 				spin_unlock_irq(&lruvec->lru_lock);
+				lruvec = NULL;
 				(*get_compound_page_dtor(page))(page);
-				spin_lock_irq(&lruvec->lru_lock);
 			} else
 				list_add(&page->lru, &pages_to_free);
 		} else {
@@ -1867,6 +1870,11 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 		}
 	}
 
+	if (lruvec != llvec) {
+		if (lruvec)
+			spin_unlock_irq(&lruvec->lru_lock);
+		spin_lock_irq(&llvec->lru_lock);
+	}
 	/*
 	 * To save our caller's stack, now use input list for pages to free.
 	 */
@@ -4289,18 +4297,10 @@ void check_move_unevictable_pages(struct pagevec *pvec)
 
 	for (i = 0; i < pvec->nr; i++) {
 		struct page *page = pvec->pages[i];
-		struct pglist_data *pgdat = page_pgdat(page);
-		struct lruvec *new_lruvec = mem_cgroup_page_lruvec(page, pgdat);
-
 
 		pgscanned++;
 
-		if (lruvec != new_lruvec) {
-			if (lruvec)
-				spin_unlock_irq(&lruvec->lru_lock);
-			lruvec = new_lruvec;
-			spin_lock_irq(&lruvec->lru_lock);
-		}
+		lruvec = relock_page_lruvec_irq(page, lruvec);
 
 		if (!PageLRU(page) || !PageUnevictable(page))
 			continue;
-- 
1.8.3.1


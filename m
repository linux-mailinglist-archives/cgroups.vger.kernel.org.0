Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84ADEF91A1
	for <lists+cgroups@lfdr.de>; Tue, 12 Nov 2019 15:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfKLOLI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Nov 2019 09:11:08 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:40834 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727298AbfKLOLI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 Nov 2019 09:11:08 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=30;SR=0;TI=SMTPD_---0ThuRPWj_1573567600;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ThuRPWj_1573567600)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 12 Nov 2019 22:06:40 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     alex.shi@linux.alibaba.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com
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
        Matthew Wilcox <willy@infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 4/8] mm/lru: only change the lru_lock iff page's lruvec is different
Date:   Tue, 12 Nov 2019 22:06:24 +0800
Message-Id: <1573567588-47048-5-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1573567588-47048-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1573567588-47048-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

During the pagevec locking, a new page's lruvec is may same as
previous one. So we may save a lruvec locking if the lruvec is same as
previous one, and only change the lock iff lruvec is new.

Function named relock_page_lruvec following Hugh Dickins patch.

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
 include/linux/memcontrol.h | 49 ++++++++++++++++++++++++++++++++++++++++++++++
 mm/mlock.c                 | 16 ++++++++-------
 mm/swap.c                  | 14 ++++++-------
 mm/vmscan.c                | 24 +++++++++++------------
 4 files changed, 76 insertions(+), 27 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 1c1e68537eca..2421b720d272 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1300,6 +1300,55 @@ static inline void dec_lruvec_page_state(struct page *page,
 	mod_lruvec_page_state(page, idx, -1);
 }
 
+/* Don't lock again iff page's lruvec locked */
+static inline struct lruvec *relock_page_lruvec_irq(struct page *page,
+					struct lruvec *locked_lruvec)
+{
+	struct pglist_data *pgdat = page_pgdat(page);
+	struct lruvec *lruvec;
+
+	rcu_read_lock();
+	lruvec = mem_cgroup_page_lruvec(page, pgdat);
+
+	if (locked_lruvec == lruvec) {
+		rcu_read_unlock();
+		return lruvec;
+	}
+	rcu_read_unlock();
+
+	if (locked_lruvec)
+		spin_unlock_irq(&locked_lruvec->lru_lock);
+
+	lruvec = lock_page_lruvec_irq(page, pgdat);
+
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
+	rcu_read_lock();
+	lruvec = mem_cgroup_page_lruvec(page, pgdat);
+
+	if (locked_lruvec == lruvec) {
+		rcu_read_unlock();
+		return lruvec;
+	}
+	rcu_read_unlock();
+
+	if (locked_lruvec)
+		spin_unlock_irqrestore(&locked_lruvec->lru_lock,
+							locked_lruvec->flags);
+
+	lruvec = lock_page_lruvec_irqsave(page, pgdat);
+
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
index 267c3e262254..0639b3e9e03b 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -195,11 +195,12 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
 	for (i = 0; i < pagevec_count(pvec); i++) {
 		struct page *page = pvec->pages[i];
 
-		lruvec = lock_page_lruvec_irqsave(page, page_pgdat(page));
+		lruvec = relock_page_lruvec_irqsave(page, lruvec);
 
 		(*move_fn)(page, lruvec, arg);
-		spin_unlock_irqrestore(&lruvec->lru_lock, lruvec->flags);
 	}
+	if (lruvec)
+		spin_unlock_irqrestore(&lruvec->lru_lock, lruvec->flags);
 
 	release_pages(pvec->pages, pvec->nr);
 	pagevec_reinit(pvec);
@@ -802,15 +803,12 @@ void release_pages(struct page **pages, int nr)
 		}
 
 		if (PageLRU(page)) {
-			struct lruvec *new_lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
+			struct lruvec *pre_lruvec = lruvec;
 
-			if (new_lruvec != lruvec) {
-				if (lruvec)
-					spin_unlock_irqrestore(&lruvec->lru_lock, lruvec->flags);
+			lruvec = relock_page_lruvec_irqsave(page, lruvec);
+			if (pre_lruvec != lruvec)
 				lock_batch = 0;
-				lruvec = lock_page_lruvec_irqsave(page, page_pgdat(page));
 
-			}
 			VM_BUG_ON_PAGE(!PageLRU(page), page);
 			__ClearPageLRU(page);
 			del_page_from_lru_list(page, lruvec, page_off_lru(page));
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 50f15d1e5f18..cbebd9b0b9c8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1874,22 +1874,25 @@ static int too_many_isolated(struct pglist_data *pgdat, int file,
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
 
@@ -1907,8 +1910,8 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 
 			if (unlikely(PageCompound(page))) {
 				spin_unlock_irq(&lruvec->lru_lock);
+				lruvec = NULL;
 				(*get_compound_page_dtor(page))(page);
-				spin_lock_irq(&lruvec->lru_lock);
 			} else
 				list_add(&page->lru, &pages_to_free);
 		} else {
@@ -1916,6 +1919,11 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
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
@@ -4338,18 +4346,10 @@ void check_move_unevictable_pages(struct pagevec *pvec)
 
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


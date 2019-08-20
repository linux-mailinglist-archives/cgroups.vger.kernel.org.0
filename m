Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2D9695B82
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2019 11:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbfHTJtx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Aug 2019 05:49:53 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:34168 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729748AbfHTJtu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Aug 2019 05:49:50 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=40;SR=0;TI=SMTPD_---0Ta-AHFA_1566294571;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0Ta-AHFA_1566294571)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 20 Aug 2019 17:49:32 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@gmail.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Arun KS <arunks@codeaurora.org>, Qian Cai <cai@lca.pw>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Hugh Dickins <hughd@google.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        swkhack <swkhack@gmail.com>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Colin Ian King <colin.king@canonical.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Peng Fan <peng.fan@nxp.com>, Ira Weiny <ira.weiny@intel.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: [PATCH 01/14] mm/lru: move pgdat lru_lock into lruvec
Date:   Tue, 20 Aug 2019 17:48:24 +0800
Message-Id: <1566294517-86418-2-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1566294517-86418-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1566294517-86418-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patch move lru_lock into lruvec, give a lru_lock for each of
lruvec, thus bring a lru_lock for each of memcg.

Per memcg lru_lock would ease the lru_lock contention a lot in
this patch series.

In some data center, containers are used widely to deploy different kind
of services, then multiple memcgs share per node pgdat->lru_lock which
cause heavy lock contentions when doing lru operations.
On my 2 socket * 6 cores E5-2630 platform, 24 containers run aim9
simultaneously with mmtests' config:
	# AIM9
	export AIM9_TESTTIME=180
	export AIM9_TESTLIST=page_test,brk_test

perf lock report show much contentions on lru_lock in 20 second snapshot:
        	        Name   acquired  contended   avg wait (ns) total wait (ns)   max wait (ns)   min wait (ns)
	&(ptlock_ptr(pag...         22          0               0	0               0               0
	...
	&(&pgdat->lru_lo...          9          7           12728	89096           26656            1597

With this patch series, lruvec->lru_lock show no contentions
	&(&lruvec->lru_l...          8          0               0	0               0               0

and aim9 page_test/brk_test performance increased 5%~50%.

Now this patch still using per pgdat lru_lock, no function changes yet.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Arun KS <arunks@codeaurora.org>
Cc: Qian Cai <cai@lca.pw>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Souptick Joarder <jrdr.linux@gmail.com>
Cc: swkhack <swkhack@gmail.com>
Cc: "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Yafang Shao <laoar.shao@gmail.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/mmzone.h |  4 +++-
 mm/compaction.c        | 10 +++++-----
 mm/huge_memory.c       |  6 +++---
 mm/memcontrol.c        |  6 +++---
 mm/mlock.c             | 10 +++++-----
 mm/mmzone.c            |  1 +
 mm/page_alloc.c        |  1 -
 mm/page_idle.c         |  4 ++--
 mm/swap.c              | 28 ++++++++++++++--------------
 mm/vmscan.c            | 38 +++++++++++++++++++-------------------
 10 files changed, 55 insertions(+), 53 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index d77d717c620c..8d0076d084be 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -295,6 +295,9 @@ struct zone_reclaim_stat {
 
 struct lruvec {
 	struct list_head		lists[NR_LRU_LISTS];
+	/* move lru_lock to per lruvec for memcg */
+	spinlock_t			lru_lock;
+
 	struct zone_reclaim_stat	reclaim_stat;
 	/* Evictions & activations on the inactive file list */
 	atomic_long_t			inactive_age;
@@ -744,7 +747,6 @@ struct zonelist {
 
 	/* Write-intensive fields used by page reclaim */
 	ZONE_PADDING(_pad1_)
-	spinlock_t		lru_lock;
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 	/*
diff --git a/mm/compaction.c b/mm/compaction.c
index 952dc2fb24e5..9a737f343183 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -846,7 +846,7 @@ static bool too_many_isolated(pg_data_t *pgdat)
 		 * a fatal signal is pending.
 		 */
 		if (!(low_pfn % SWAP_CLUSTER_MAX)
-		    && compact_unlock_should_abort(&pgdat->lru_lock,
+		    && compact_unlock_should_abort(&pgdat->lruvec.lru_lock,
 					    flags, &locked, cc)) {
 			low_pfn = 0;
 			goto fatal_pending;
@@ -919,7 +919,7 @@ static bool too_many_isolated(pg_data_t *pgdat)
 			if (unlikely(__PageMovable(page)) &&
 					!PageIsolated(page)) {
 				if (locked) {
-					spin_unlock_irqrestore(&pgdat->lru_lock,
+					spin_unlock_irqrestore(&pgdat->lruvec.lru_lock,
 									flags);
 					locked = false;
 				}
@@ -949,7 +949,7 @@ static bool too_many_isolated(pg_data_t *pgdat)
 
 		/* If we already hold the lock, we can skip some rechecking */
 		if (!locked) {
-			locked = compact_lock_irqsave(&pgdat->lru_lock,
+			locked = compact_lock_irqsave(&pgdat->lruvec.lru_lock,
 								&flags, cc);
 
 			/* Try get exclusive access under lock */
@@ -1016,7 +1016,7 @@ static bool too_many_isolated(pg_data_t *pgdat)
 		 */
 		if (nr_isolated) {
 			if (locked) {
-				spin_unlock_irqrestore(&pgdat->lru_lock, flags);
+				spin_unlock_irqrestore(&pgdat->lruvec.lru_lock, flags);
 				locked = false;
 			}
 			putback_movable_pages(&cc->migratepages);
@@ -1043,7 +1043,7 @@ static bool too_many_isolated(pg_data_t *pgdat)
 
 isolate_abort:
 	if (locked)
-		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
+		spin_unlock_irqrestore(&pgdat->lruvec.lru_lock, flags);
 
 	/*
 	 * Updated the cached scanner pfn once the pageblock has been scanned
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 738065f765ab..3a483deee807 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2529,7 +2529,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		xa_unlock(&head->mapping->i_pages);
 	}
 
-	spin_unlock_irqrestore(&pgdat->lru_lock, flags);
+	spin_unlock_irqrestore(&pgdat->lruvec.lru_lock, flags);
 
 	remap_page(head);
 
@@ -2740,7 +2740,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 		lru_add_drain();
 
 	/* prevent PageLRU to go away from under us, and freeze lru stats */
-	spin_lock_irqsave(&pgdata->lru_lock, flags);
+	spin_lock_irqsave(&pgdata->lruvec.lru_lock, flags);
 
 	if (mapping) {
 		XA_STATE(xas, &mapping->i_pages, page_index(head));
@@ -2785,7 +2785,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 		spin_unlock(&pgdata->split_queue_lock);
 fail:		if (mapping)
 			xa_unlock(&mapping->i_pages);
-		spin_unlock_irqrestore(&pgdata->lru_lock, flags);
+		spin_unlock_irqrestore(&pgdata->lruvec.lru_lock, flags);
 		remap_page(head);
 		ret = -EBUSY;
 	}
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6f5c0c517c49..2792b8ed405f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2557,7 +2557,7 @@ static void lock_page_lru(struct page *page, int *isolated)
 {
 	pg_data_t *pgdat = page_pgdat(page);
 
-	spin_lock_irq(&pgdat->lru_lock);
+	spin_lock_irq(&pgdat->lruvec.lru_lock);
 	if (PageLRU(page)) {
 		struct lruvec *lruvec;
 
@@ -2581,7 +2581,7 @@ static void unlock_page_lru(struct page *page, int isolated)
 		SetPageLRU(page);
 		add_page_to_lru_list(page, lruvec, page_lru(page));
 	}
-	spin_unlock_irq(&pgdat->lru_lock);
+	spin_unlock_irq(&pgdat->lruvec.lru_lock);
 }
 
 static void commit_charge(struct page *page, struct mem_cgroup *memcg,
@@ -2901,7 +2901,7 @@ void __memcg_kmem_uncharge(struct page *page, int order)
 
 /*
  * Because tail pages are not marked as "used", set it. We're under
- * pgdat->lru_lock and migration entries setup in all page mappings.
+ * pgdat->lruvec.lru_lock and migration entries setup in all page mappings.
  */
 void mem_cgroup_split_huge_fixup(struct page *head)
 {
diff --git a/mm/mlock.c b/mm/mlock.c
index a90099da4fb4..1279684bada0 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -194,7 +194,7 @@ unsigned int munlock_vma_page(struct page *page)
 	 * might otherwise copy PageMlocked to part of the tail pages before
 	 * we clear it in the head page. It also stabilizes hpage_nr_pages().
 	 */
-	spin_lock_irq(&pgdat->lru_lock);
+	spin_lock_irq(&pgdat->lruvec.lru_lock);
 
 	if (!TestClearPageMlocked(page)) {
 		/* Potentially, PTE-mapped THP: do not skip the rest PTEs */
@@ -206,14 +206,14 @@ unsigned int munlock_vma_page(struct page *page)
 	__mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
 
 	if (__munlock_isolate_lru_page(page, true)) {
-		spin_unlock_irq(&pgdat->lru_lock);
+		spin_unlock_irq(&pgdat->lruvec.lru_lock);
 		__munlock_isolated_page(page);
 		goto out;
 	}
 	__munlock_isolation_failed(page);
 
 unlock_out:
-	spin_unlock_irq(&pgdat->lru_lock);
+	spin_unlock_irq(&pgdat->lruvec.lru_lock);
 
 out:
 	return nr_pages - 1;
@@ -298,7 +298,7 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
 	pagevec_init(&pvec_putback);
 
 	/* Phase 1: page isolation */
-	spin_lock_irq(&zone->zone_pgdat->lru_lock);
+	spin_lock_irq(&zone->zone_pgdat->lruvec.lru_lock);
 	for (i = 0; i < nr; i++) {
 		struct page *page = pvec->pages[i];
 
@@ -325,7 +325,7 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
 		pvec->pages[i] = NULL;
 	}
 	__mod_zone_page_state(zone, NR_MLOCK, delta_munlocked);
-	spin_unlock_irq(&zone->zone_pgdat->lru_lock);
+	spin_unlock_irq(&zone->zone_pgdat->lruvec.lru_lock);
 
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
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 272c6de1bf4e..1b07dcaabbd7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6677,7 +6677,6 @@ static void __meminit pgdat_init_internals(struct pglist_data *pgdat)
 	init_waitqueue_head(&pgdat->pfmemalloc_wait);
 
 	pgdat_page_ext_init(pgdat);
-	spin_lock_init(&pgdat->lru_lock);
 	lruvec_init(node_lruvec(pgdat));
 }
 
diff --git a/mm/page_idle.c b/mm/page_idle.c
index 295512465065..420bc0ac8c1e 100644
--- a/mm/page_idle.c
+++ b/mm/page_idle.c
@@ -42,12 +42,12 @@ static struct page *page_idle_get_page(unsigned long pfn)
 		return NULL;
 
 	pgdat = page_pgdat(page);
-	spin_lock_irq(&pgdat->lru_lock);
+	spin_lock_irq(&pgdat->lruvec.lru_lock);
 	if (unlikely(!PageLRU(page))) {
 		put_page(page);
 		page = NULL;
 	}
-	spin_unlock_irq(&pgdat->lru_lock);
+	spin_unlock_irq(&pgdat->lruvec.lru_lock);
 	return page;
 }
 
diff --git a/mm/swap.c b/mm/swap.c
index ae300397dfda..63f4782af57a 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -63,12 +63,12 @@ static void __page_cache_release(struct page *page)
 		struct lruvec *lruvec;
 		unsigned long flags;
 
-		spin_lock_irqsave(&pgdat->lru_lock, flags);
+		spin_lock_irqsave(&pgdat->lruvec.lru_lock, flags);
 		lruvec = mem_cgroup_page_lruvec(page, pgdat);
 		VM_BUG_ON_PAGE(!PageLRU(page), page);
 		__ClearPageLRU(page);
 		del_page_from_lru_list(page, lruvec, page_off_lru(page));
-		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
+		spin_unlock_irqrestore(&pgdat->lruvec.lru_lock, flags);
 	}
 	__ClearPageWaiters(page);
 	mem_cgroup_uncharge(page);
@@ -201,16 +201,16 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
 
 		if (pagepgdat != pgdat) {
 			if (pgdat)
-				spin_unlock_irqrestore(&pgdat->lru_lock, flags);
+				spin_unlock_irqrestore(&pgdat->lruvec.lru_lock, flags);
 			pgdat = pagepgdat;
-			spin_lock_irqsave(&pgdat->lru_lock, flags);
+			spin_lock_irqsave(&pgdat->lruvec.lru_lock, flags);
 		}
 
 		lruvec = mem_cgroup_page_lruvec(page, pgdat);
 		(*move_fn)(page, lruvec, arg);
 	}
 	if (pgdat)
-		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
+		spin_unlock_irqrestore(&pgdat->lruvec.lru_lock, flags);
 	release_pages(pvec->pages, pvec->nr);
 	pagevec_reinit(pvec);
 }
@@ -326,9 +326,9 @@ void activate_page(struct page *page)
 	pg_data_t *pgdat = page_pgdat(page);
 
 	page = compound_head(page);
-	spin_lock_irq(&pgdat->lru_lock);
+	spin_lock_irq(&pgdat->lruvec.lru_lock);
 	__activate_page(page, mem_cgroup_page_lruvec(page, pgdat), NULL);
-	spin_unlock_irq(&pgdat->lru_lock);
+	spin_unlock_irq(&pgdat->lruvec.lru_lock);
 }
 #endif
 
@@ -733,7 +733,7 @@ void release_pages(struct page **pages, int nr)
 		 * same pgdat. The lock is held only if pgdat != NULL.
 		 */
 		if (locked_pgdat && ++lock_batch == SWAP_CLUSTER_MAX) {
-			spin_unlock_irqrestore(&locked_pgdat->lru_lock, flags);
+			spin_unlock_irqrestore(&locked_pgdat->lruvec.lru_lock, flags);
 			locked_pgdat = NULL;
 		}
 
@@ -742,7 +742,7 @@ void release_pages(struct page **pages, int nr)
 
 		if (is_zone_device_page(page)) {
 			if (locked_pgdat) {
-				spin_unlock_irqrestore(&locked_pgdat->lru_lock,
+				spin_unlock_irqrestore(&locked_pgdat->lruvec.lru_lock,
 						       flags);
 				locked_pgdat = NULL;
 			}
@@ -762,7 +762,7 @@ void release_pages(struct page **pages, int nr)
 
 		if (PageCompound(page)) {
 			if (locked_pgdat) {
-				spin_unlock_irqrestore(&locked_pgdat->lru_lock, flags);
+				spin_unlock_irqrestore(&locked_pgdat->lruvec.lru_lock, flags);
 				locked_pgdat = NULL;
 			}
 			__put_compound_page(page);
@@ -774,11 +774,11 @@ void release_pages(struct page **pages, int nr)
 
 			if (pgdat != locked_pgdat) {
 				if (locked_pgdat)
-					spin_unlock_irqrestore(&locked_pgdat->lru_lock,
+					spin_unlock_irqrestore(&locked_pgdat->lruvec.lru_lock,
 									flags);
 				lock_batch = 0;
 				locked_pgdat = pgdat;
-				spin_lock_irqsave(&locked_pgdat->lru_lock, flags);
+				spin_lock_irqsave(&locked_pgdat->lruvec.lru_lock, flags);
 			}
 
 			lruvec = mem_cgroup_page_lruvec(page, locked_pgdat);
@@ -794,7 +794,7 @@ void release_pages(struct page **pages, int nr)
 		list_add(&page->lru, &pages_to_free);
 	}
 	if (locked_pgdat)
-		spin_unlock_irqrestore(&locked_pgdat->lru_lock, flags);
+		spin_unlock_irqrestore(&locked_pgdat->lruvec.lru_lock, flags);
 
 	mem_cgroup_uncharge_list(&pages_to_free);
 	free_unref_page_list(&pages_to_free);
@@ -832,7 +832,7 @@ void lru_add_page_tail(struct page *page, struct page *page_tail,
 	VM_BUG_ON_PAGE(!PageHead(page), page);
 	VM_BUG_ON_PAGE(PageCompound(page_tail), page);
 	VM_BUG_ON_PAGE(PageLRU(page_tail), page);
-	lockdep_assert_held(&lruvec_pgdat(lruvec)->lru_lock);
+	lockdep_assert_held(&lruvec->lru_lock);
 
 	if (!list)
 		SetPageLRU(page_tail);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c77d1e3761a7..c7a228525df0 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1805,7 +1805,7 @@ int isolate_lru_page(struct page *page)
 		pg_data_t *pgdat = page_pgdat(page);
 		struct lruvec *lruvec;
 
-		spin_lock_irq(&pgdat->lru_lock);
+		spin_lock_irq(&pgdat->lruvec.lru_lock);
 		lruvec = mem_cgroup_page_lruvec(page, pgdat);
 		if (PageLRU(page)) {
 			int lru = page_lru(page);
@@ -1814,7 +1814,7 @@ int isolate_lru_page(struct page *page)
 			del_page_from_lru_list(page, lruvec, lru);
 			ret = 0;
 		}
-		spin_unlock_irq(&pgdat->lru_lock);
+		spin_unlock_irq(&pgdat->lruvec.lru_lock);
 	}
 	return ret;
 }
@@ -1890,9 +1890,9 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 		VM_BUG_ON_PAGE(PageLRU(page), page);
 		if (unlikely(!page_evictable(page))) {
 			list_del(&page->lru);
-			spin_unlock_irq(&pgdat->lru_lock);
+			spin_unlock_irq(&pgdat->lruvec.lru_lock);
 			putback_lru_page(page);
-			spin_lock_irq(&pgdat->lru_lock);
+			spin_lock_irq(&pgdat->lruvec.lru_lock);
 			continue;
 		}
 		lruvec = mem_cgroup_page_lruvec(page, pgdat);
@@ -1910,10 +1910,10 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 			del_page_from_lru_list(page, lruvec, lru);
 
 			if (unlikely(PageCompound(page))) {
-				spin_unlock_irq(&pgdat->lru_lock);
+				spin_unlock_irq(&pgdat->lruvec.lru_lock);
 				mem_cgroup_uncharge(page);
 				(*get_compound_page_dtor(page))(page);
-				spin_lock_irq(&pgdat->lru_lock);
+				spin_lock_irq(&pgdat->lruvec.lru_lock);
 			} else
 				list_add(&page->lru, &pages_to_free);
 		} else {
@@ -1976,7 +1976,7 @@ static int current_may_throttle(void)
 
 	lru_add_drain();
 
-	spin_lock_irq(&pgdat->lru_lock);
+	spin_lock_irq(&pgdat->lruvec.lru_lock);
 
 	nr_taken = isolate_lru_pages(nr_to_scan, lruvec, &page_list,
 				     &nr_scanned, sc, lru);
@@ -1988,7 +1988,7 @@ static int current_may_throttle(void)
 	if (global_reclaim(sc))
 		__count_vm_events(item, nr_scanned);
 	__count_memcg_events(lruvec_memcg(lruvec), item, nr_scanned);
-	spin_unlock_irq(&pgdat->lru_lock);
+	spin_unlock_irq(&pgdat->lruvec.lru_lock);
 
 	if (nr_taken == 0)
 		return 0;
@@ -1996,7 +1996,7 @@ static int current_may_throttle(void)
 	nr_reclaimed = shrink_page_list(&page_list, pgdat, sc, 0,
 				&stat, false);
 
-	spin_lock_irq(&pgdat->lru_lock);
+	spin_lock_irq(&pgdat->lruvec.lru_lock);
 
 	item = current_is_kswapd() ? PGSTEAL_KSWAPD : PGSTEAL_DIRECT;
 	if (global_reclaim(sc))
@@ -2009,7 +2009,7 @@ static int current_may_throttle(void)
 
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
 
-	spin_unlock_irq(&pgdat->lru_lock);
+	spin_unlock_irq(&pgdat->lruvec.lru_lock);
 
 	mem_cgroup_uncharge_list(&page_list);
 	free_unref_page_list(&page_list);
@@ -2062,7 +2062,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 
 	lru_add_drain();
 
-	spin_lock_irq(&pgdat->lru_lock);
+	spin_lock_irq(&pgdat->lruvec.lru_lock);
 
 	nr_taken = isolate_lru_pages(nr_to_scan, lruvec, &l_hold,
 				     &nr_scanned, sc, lru);
@@ -2073,7 +2073,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	__count_vm_events(PGREFILL, nr_scanned);
 	__count_memcg_events(lruvec_memcg(lruvec), PGREFILL, nr_scanned);
 
-	spin_unlock_irq(&pgdat->lru_lock);
+	spin_unlock_irq(&pgdat->lruvec.lru_lock);
 
 	while (!list_empty(&l_hold)) {
 		cond_resched();
@@ -2119,7 +2119,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	/*
 	 * Move pages back to the lru list.
 	 */
-	spin_lock_irq(&pgdat->lru_lock);
+	spin_lock_irq(&pgdat->lruvec.lru_lock);
 	/*
 	 * Count referenced pages from currently used mappings as rotated,
 	 * even though only some of them are actually re-activated.  This
@@ -2137,7 +2137,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	__count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_deactivate);
 
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
-	spin_unlock_irq(&pgdat->lru_lock);
+	spin_unlock_irq(&pgdat->lruvec.lru_lock);
 
 	mem_cgroup_uncharge_list(&l_active);
 	free_unref_page_list(&l_active);
@@ -2373,7 +2373,7 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
 	file  = lruvec_lru_size(lruvec, LRU_ACTIVE_FILE, MAX_NR_ZONES) +
 		lruvec_lru_size(lruvec, LRU_INACTIVE_FILE, MAX_NR_ZONES);
 
-	spin_lock_irq(&pgdat->lru_lock);
+	spin_lock_irq(&pgdat->lruvec.lru_lock);
 	if (unlikely(reclaim_stat->recent_scanned[0] > anon / 4)) {
 		reclaim_stat->recent_scanned[0] /= 2;
 		reclaim_stat->recent_rotated[0] /= 2;
@@ -2394,7 +2394,7 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
 
 	fp = file_prio * (reclaim_stat->recent_scanned[1] + 1);
 	fp /= reclaim_stat->recent_rotated[1] + 1;
-	spin_unlock_irq(&pgdat->lru_lock);
+	spin_unlock_irq(&pgdat->lruvec.lru_lock);
 
 	fraction[0] = ap;
 	fraction[1] = fp;
@@ -4263,9 +4263,9 @@ void check_move_unevictable_pages(struct pagevec *pvec)
 		pgscanned++;
 		if (pagepgdat != pgdat) {
 			if (pgdat)
-				spin_unlock_irq(&pgdat->lru_lock);
+				spin_unlock_irq(&pgdat->lruvec.lru_lock);
 			pgdat = pagepgdat;
-			spin_lock_irq(&pgdat->lru_lock);
+			spin_lock_irq(&pgdat->lruvec.lru_lock);
 		}
 		lruvec = mem_cgroup_page_lruvec(page, pgdat);
 
@@ -4286,7 +4286,7 @@ void check_move_unevictable_pages(struct pagevec *pvec)
 	if (pgdat) {
 		__count_vm_events(UNEVICTABLE_PGRESCUED, pgrescued);
 		__count_vm_events(UNEVICTABLE_PGSCANNED, pgscanned);
-		spin_unlock_irq(&pgdat->lru_lock);
+		spin_unlock_irq(&pgdat->lruvec.lru_lock);
 	}
 }
 EXPORT_SYMBOL_GPL(check_move_unevictable_pages);
-- 
1.8.3.1


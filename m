Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3221B102452
	for <lists+cgroups@lfdr.de>; Tue, 19 Nov 2019 13:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfKSM0z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Nov 2019 07:26:55 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:47021 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727906AbfKSM0z (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Nov 2019 07:26:55 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=39;SR=0;TI=SMTPD_---0TiZ64C-_1574166245;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TiZ64C-_1574166245)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 19 Nov 2019 20:24:05 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        shakeelb@google.com, hannes@cmpxchg.org
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, Qian Cai <cai@lca.pw>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        swkhack <swkhack@gmail.com>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Colin Ian King <colin.king@canonical.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v4 3/9] mm/lru: replace pgdat lru_lock with lruvec lock
Date:   Tue, 19 Nov 2019 20:23:17 +0800
Message-Id: <1574166203-151975-4-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574166203-151975-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1574166203-151975-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patchset move lru_lock into lruvec, give a lru_lock for each of
lruvec, thus bring a lru_lock for each of memcg per node.

This is the main patch to replace per node lru_lock with per memcg
lruvec lock.

We introduce function lock_page_lruvec, it's same as vanilla pgdat lock
when memory cgroup unset, w/o memcg, the function will keep repin the
lruvec's lock to guard from page->mem_cgroup changes in page
migrations between memcgs. (Thanks Hugh Dickins and Konstantin
Khlebnikov reminder on this. Than the core logical is same as their
previous patchs)

According to Daniel Jordan's suggestion, I run 64 'dd' with on 32
containers on my 2s* 8 core * HT box with the modefied case:
  https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-lru-file-readtwice

With this and later patches, the dd performance is 144MB/s, the vanilla
kernel performance is 123MB/s. 17% performance increased.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Roman Gushchin <guro@fb.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Chris Down <chris@chrisdown.name>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Qian Cai <cai@lca.pw>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: David Rientjes <rientjes@google.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: swkhack <swkhack@gmail.com>
Cc: "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Nikolay Borisov <nborisov@suse.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Yafang Shao <laoar.shao@gmail.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Hugh Dickins <hughd@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: cgroups@vger.kernel.org
---
 include/linux/memcontrol.h | 24 +++++++++++++++
 include/linux/mmzone.h     |  2 ++
 mm/compaction.c            | 67 ++++++++++++++++++++++++++++-------------
 mm/huge_memory.c           | 15 ++++------
 mm/memcontrol.c            | 75 +++++++++++++++++++++++++++++++++++-----------
 mm/mlock.c                 | 31 ++++++++++---------
 mm/mmzone.c                |  1 +
 mm/page_idle.c             |  5 ++--
 mm/swap.c                  | 74 +++++++++++++++++++--------------------------
 mm/vmscan.c                | 58 +++++++++++++++++------------------
 10 files changed, 214 insertions(+), 138 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 5b86287fa069..9538253998a6 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -418,6 +418,10 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
 
 struct lruvec *mem_cgroup_page_lruvec(struct page *, struct pglist_data *);
 
+struct lruvec *lock_page_lruvec_irq(struct page *, struct pglist_data *);
+struct lruvec *lock_page_lruvec_irqsave(struct page *, struct pglist_data *,
+					unsigned long*);
+
 struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p);
 
 struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm);
@@ -901,6 +905,26 @@ static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page,
 	return &pgdat->__lruvec;
 }
 
+static inline struct lruvec *lock_page_lruvec_irq(struct page *page,
+						struct pglist_data *pgdat)
+{
+	struct lruvec *lruvec = mem_cgroup_page_lruvec(page, pgdat);
+
+	spin_lock_irq(&lruvec->lru_lock);
+
+	return lruvec;
+}
+
+static inline struct lruvec *lock_page_lruvec_irqsave(struct page *page,
+				struct pglist_data *pgdat, unsigned long *flags)
+{
+	struct lruvec *lruvec = mem_cgroup_page_lruvec(page, pgdat);
+
+	spin_lock_irqsave(&lruvec->lru_lock, *flags);
+
+	return lruvec;
+}
+
 static inline bool mm_match_cgroup(struct mm_struct *mm,
 		struct mem_cgroup *memcg)
 {
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 07b784ffbb14..a13b8a602ee5 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -267,6 +267,8 @@ struct lruvec {
 	unsigned long			refaults;
 	/* Various lruvec state flags (enum lruvec_flags) */
 	unsigned long			flags;
+	/* per lruvec lru_lock for memcg */
+	spinlock_t			lru_lock;
 #ifdef CONFIG_MEMCG
 	struct pglist_data *pgdat;
 #endif
diff --git a/mm/compaction.c b/mm/compaction.c
index d20816b21b55..f8018226fdbc 100644
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
+				spin_unlock_irqrestore(&locked_lruvec->lru_lock,
+							flags);
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
@@ -920,10 +930,10 @@ static bool too_many_isolated(pg_data_t *pgdat)
 			 */
 			if (unlikely(__PageMovable(page)) &&
 					!PageIsolated(page)) {
-				if (locked) {
-					spin_unlock_irqrestore(&pgdat->lru_lock,
-									flags);
-					locked = false;
+				if (locked_lruvec) {
+					spin_unlock_irqrestore(&locked_lruvec->lru_lock,
+								flags);
+					locked_lruvec = NULL;
 				}
 
 				if (!isolate_movable_page(page, isolate_mode))
@@ -949,10 +959,26 @@ static bool too_many_isolated(pg_data_t *pgdat)
 		if (!(cc->gfp_mask & __GFP_FS) && page_mapping(page))
 			goto isolate_fail;
 
+		rcu_read_lock();
+reget_lruvec:
+		lruvec = mem_cgroup_page_lruvec(page, pgdat);
+
 		/* If we already hold the lock, we can skip some rechecking */
-		if (!locked) {
-			locked = compact_lock_irqsave(&pgdat->lru_lock,
-								&flags, cc);
+		if (lruvec != locked_lruvec) {
+			if (locked_lruvec) {
+				spin_unlock_irqrestore(&locked_lruvec->lru_lock,
+							flags);
+				locked_lruvec = NULL;
+			}
+			if (compact_lock_irqsave(&lruvec->lru_lock,
+							&flags, cc))
+				locked_lruvec = lruvec;
+
+
+			if (lruvec != mem_cgroup_page_lruvec(page, pgdat))
+				goto reget_lruvec;
+
+			rcu_read_unlock();
 
 			/* Try get exclusive access under lock */
 			if (!skip_updated) {
@@ -974,9 +1000,9 @@ static bool too_many_isolated(pg_data_t *pgdat)
 				low_pfn += compound_nr(page) - 1;
 				goto isolate_fail;
 			}
-		}
+		} else
+			rcu_read_unlock();
 
-		lruvec = mem_cgroup_page_lruvec(page, pgdat);
 
 		/* Try isolate the page */
 		if (__isolate_lru_page(page, isolate_mode) != 0)
@@ -1017,9 +1043,10 @@ static bool too_many_isolated(pg_data_t *pgdat)
 		 * page anyway.
 		 */
 		if (nr_isolated) {
-			if (locked) {
-				spin_unlock_irqrestore(&pgdat->lru_lock, flags);
-				locked = false;
+			if (locked_lruvec) {
+				spin_unlock_irqrestore(&locked_lruvec->lru_lock,
+							flags);
+				locked_lruvec = NULL;
 			}
 			putback_movable_pages(&cc->migratepages);
 			cc->nr_migratepages = 0;
@@ -1044,8 +1071,8 @@ static bool too_many_isolated(pg_data_t *pgdat)
 		low_pfn = end_pfn;
 
 isolate_abort:
-	if (locked)
-		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
+	if (locked_lruvec)
+		spin_unlock_irqrestore(&locked_lruvec->lru_lock, flags);
 
 	/*
 	 * Updated the cached scanner pfn once the pageblock has been scanned
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4cdfdbeb6b2b..cf37c58f0558 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2495,17 +2495,13 @@ static void __split_huge_page_tail(struct page *head, int tail,
 }
 
 static void __split_huge_page(struct page *page, struct list_head *list,
-		pgoff_t end, unsigned long flags)
+			struct lruvec *lruvec, pgoff_t end, unsigned long flags)
 {
 	struct page *head = compound_head(page);
-	pg_data_t *pgdat = page_pgdat(head);
-	struct lruvec *lruvec;
 	struct address_space *swap_cache = NULL;
 	unsigned long offset = 0;
 	int i;
 
-	lruvec = mem_cgroup_page_lruvec(head, pgdat);
-
 	/* complete memcg works before add pages to LRU */
 	mem_cgroup_split_huge_fixup(head);
 
@@ -2554,7 +2550,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		xa_unlock(&head->mapping->i_pages);
 	}
 
-	spin_unlock_irqrestore(&pgdat->lru_lock, flags);
+	spin_unlock_irqrestore(&lruvec->lru_lock, flags);
 
 	remap_page(head);
 
@@ -2697,6 +2693,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	struct deferred_split *ds_queue = get_deferred_split_queue(page);
 	struct anon_vma *anon_vma = NULL;
 	struct address_space *mapping = NULL;
+	struct lruvec *lruvec;
 	int count, mapcount, extra_pins, ret;
 	bool mlocked;
 	unsigned long flags = 0;
@@ -2766,7 +2763,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 		lru_add_drain();
 
 	/* prevent PageLRU to go away from under us, and freeze lru stats */
-	spin_lock_irqsave(&pgdata->lru_lock, flags);
+	lruvec = lock_page_lruvec_irqsave(head, pgdata, &flags);
 
 	if (mapping) {
 		XA_STATE(xas, &mapping->i_pages, page_index(head));
@@ -2797,7 +2794,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 		}
 
 		spin_unlock(&ds_queue->split_queue_lock);
-		__split_huge_page(page, list, end, flags);
+		__split_huge_page(page, list, lruvec, end, flags);
 		if (PageSwapCache(head)) {
 			swp_entry_t entry = { .val = page_private(head) };
 
@@ -2816,7 +2813,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 		spin_unlock(&ds_queue->split_queue_lock);
 fail:		if (mapping)
 			xa_unlock(&mapping->i_pages);
-		spin_unlock_irqrestore(&pgdata->lru_lock, flags);
+		spin_unlock_irqrestore(&lruvec->lru_lock, flags);
 		remap_page(head);
 		ret = -EBUSY;
 	}
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 62470325f9bc..7e6387ad01f0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1210,9 +1210,8 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
  * @page: the page
  * @pgdat: pgdat of the page
  *
- * This function is only safe when following the LRU page isolation
- * and putback protocol: the LRU lock must be held, and the page must
- * either be PageLRU() or the caller must have isolated/allocated it.
+ * The caller needs to grantee the page's mem_cgroup is undisturbed during
+ * using. That could be done by lock_page_memcg or lock_page_lruvec.
  */
 struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgdat)
 {
@@ -1225,7 +1224,7 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgd
 		goto out;
 	}
 
-	memcg = page->mem_cgroup;
+	memcg = READ_ONCE(page->mem_cgroup);
 	/*
 	 * Swapcache readahead pages are added to the LRU - and
 	 * possibly migrated - before they are charged.
@@ -1246,6 +1245,46 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgd
 	return lruvec;
 }
 
+struct lruvec *lock_page_lruvec_irq(struct page *page,
+					struct pglist_data *pgdat)
+{
+	struct lruvec *lruvec;
+
+again:
+	rcu_read_lock();
+	lruvec = mem_cgroup_page_lruvec(page, pgdat);
+	spin_lock_irq(&lruvec->lru_lock);
+	rcu_read_unlock();
+
+	/* lruvec may changed in commit_charge() */
+	if (lruvec != mem_cgroup_page_lruvec(page, pgdat)) {
+		spin_unlock_irq(&lruvec->lru_lock);
+		goto again;
+	}
+
+	return lruvec;
+}
+
+struct lruvec *lock_page_lruvec_irqsave(struct page *page,
+			struct pglist_data *pgdat, unsigned long *flags)
+{
+	struct lruvec *lruvec;
+
+again:
+	rcu_read_lock();
+	lruvec = mem_cgroup_page_lruvec(page, pgdat);
+	spin_lock_irqsave(&lruvec->lru_lock, *flags);
+	rcu_read_unlock();
+
+	/* lruvec may changed in commit_charge() */
+	if (lruvec != mem_cgroup_page_lruvec(page, pgdat)) {
+		spin_unlock_irqrestore(&lruvec->lru_lock, *flags);
+		goto again;
+	}
+
+	return lruvec;
+}
+
 /**
  * mem_cgroup_update_lru_size - account for adding or removing an lru page
  * @lruvec: mem_cgroup per zone lru vector
@@ -2571,41 +2610,43 @@ static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
 	css_put_many(&memcg->css, nr_pages);
 }
 
-static void lock_page_lru(struct page *page, int *isolated)
+static struct lruvec *lock_page_lru(struct page *page, int *isolated)
 {
 	pg_data_t *pgdat = page_pgdat(page);
+	struct lruvec *lruvec = lock_page_lruvec_irq(page, pgdat);
 
-	spin_lock_irq(&pgdat->lru_lock);
 	if (PageLRU(page)) {
-		struct lruvec *lruvec;
 
-		lruvec = mem_cgroup_page_lruvec(page, pgdat);
 		ClearPageLRU(page);
 		del_page_from_lru_list(page, lruvec, page_lru(page));
 		*isolated = 1;
 	} else
 		*isolated = 0;
+
+	return lruvec;
 }
 
-static void unlock_page_lru(struct page *page, int isolated)
+static void unlock_page_lru(struct page *page, int isolated,
+				struct lruvec *locked_lruvec)
 {
-	pg_data_t *pgdat = page_pgdat(page);
+	struct lruvec *lruvec;
 
-	if (isolated) {
-		struct lruvec *lruvec;
+	spin_unlock_irq(&locked_lruvec->lru_lock);
+	lruvec = lock_page_lruvec_irq(page, page_pgdat(page));
 
-		lruvec = mem_cgroup_page_lruvec(page, pgdat);
+	if (isolated) {
 		VM_BUG_ON_PAGE(PageLRU(page), page);
 		SetPageLRU(page);
 		add_page_to_lru_list(page, lruvec, page_lru(page));
 	}
-	spin_unlock_irq(&pgdat->lru_lock);
+	spin_unlock_irq(&lruvec->lru_lock);
 }
 
 static void commit_charge(struct page *page, struct mem_cgroup *memcg,
 			  bool lrucare)
 {
 	int isolated;
+	struct lruvec *lruvec;
 
 	VM_BUG_ON_PAGE(page->mem_cgroup, page);
 
@@ -2614,7 +2655,7 @@ static void commit_charge(struct page *page, struct mem_cgroup *memcg,
 	 * may already be on some other mem_cgroup's LRU.  Take care of it.
 	 */
 	if (lrucare)
-		lock_page_lru(page, &isolated);
+		lruvec = lock_page_lru(page, &isolated);
 
 	/*
 	 * Nobody should be changing or seriously looking at
@@ -2633,7 +2674,7 @@ static void commit_charge(struct page *page, struct mem_cgroup *memcg,
 	page->mem_cgroup = memcg;
 
 	if (lrucare)
-		unlock_page_lru(page, isolated);
+		unlock_page_lru(page, isolated, lruvec);
 }
 
 #ifdef CONFIG_MEMCG_KMEM
@@ -2929,7 +2970,7 @@ void __memcg_kmem_uncharge(struct page *page, int order)
 
 /*
  * Because tail pages are not marked as "used", set it. We're under
- * pgdat->lru_lock and migration entries setup in all page mappings.
+ * pgdat->lruvec.lru_lock and migration entries setup in all page mappings.
  */
 void mem_cgroup_split_huge_fixup(struct page *head)
 {
diff --git a/mm/mlock.c b/mm/mlock.c
index a72c1eeded77..b509b80b8513 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -106,12 +106,10 @@ void mlock_vma_page(struct page *page)
  * Isolate a page from LRU with optional get_page() pin.
  * Assumes lru_lock already held and page already pinned.
  */
-static bool __munlock_isolate_lru_page(struct page *page, bool getpage)
+static bool __munlock_isolate_lru_page(struct page *page,
+			struct lruvec *lruvec, bool getpage)
 {
 	if (PageLRU(page)) {
-		struct lruvec *lruvec;
-
-		lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
 		if (getpage)
 			get_page(page);
 		ClearPageLRU(page);
@@ -183,6 +181,7 @@ unsigned int munlock_vma_page(struct page *page)
 {
 	int nr_pages;
 	pg_data_t *pgdat = page_pgdat(page);
+	struct lruvec *lruvec;
 
 	/* For try_to_munlock() and to serialize with page migration */
 	BUG_ON(!PageLocked(page));
@@ -194,7 +193,7 @@ unsigned int munlock_vma_page(struct page *page)
 	 * might otherwise copy PageMlocked to part of the tail pages before
 	 * we clear it in the head page. It also stabilizes hpage_nr_pages().
 	 */
-	spin_lock_irq(&pgdat->lru_lock);
+	lruvec = lock_page_lruvec_irq(page, pgdat);
 
 	if (!TestClearPageMlocked(page)) {
 		/* Potentially, PTE-mapped THP: do not skip the rest PTEs */
@@ -205,15 +204,15 @@ unsigned int munlock_vma_page(struct page *page)
 	nr_pages = hpage_nr_pages(page);
 	__mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
 
-	if (__munlock_isolate_lru_page(page, true)) {
-		spin_unlock_irq(&pgdat->lru_lock);
+	if (__munlock_isolate_lru_page(page, lruvec, true)) {
+		spin_unlock_irq(&lruvec->lru_lock);
 		__munlock_isolated_page(page);
 		goto out;
 	}
 	__munlock_isolation_failed(page);
 
 unlock_out:
-	spin_unlock_irq(&pgdat->lru_lock);
+	spin_unlock_irq(&lruvec->lru_lock);
 
 out:
 	return nr_pages - 1;
@@ -291,28 +290,29 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
 {
 	int i;
 	int nr = pagevec_count(pvec);
-	int delta_munlocked = -nr;
 	struct pagevec pvec_putback;
+	struct lruvec *lruvec = NULL;
 	int pgrescued = 0;
 
 	pagevec_init(&pvec_putback);
 
 	/* Phase 1: page isolation */
-	spin_lock_irq(&zone->zone_pgdat->lru_lock);
 	for (i = 0; i < nr; i++) {
 		struct page *page = pvec->pages[i];
 
+		lruvec = lock_page_lruvec_irq(page, page_pgdat(page));
+
 		if (TestClearPageMlocked(page)) {
 			/*
 			 * We already have pin from follow_page_mask()
 			 * so we can spare the get_page() here.
 			 */
-			if (__munlock_isolate_lru_page(page, false))
+			if (__munlock_isolate_lru_page(page, lruvec, false)) {
+				__mod_zone_page_state(zone, NR_MLOCK,  -1);
+				spin_unlock_irq(&lruvec->lru_lock);
 				continue;
-			else
+			} else
 				__munlock_isolation_failed(page);
-		} else {
-			delta_munlocked++;
 		}
 
 		/*
@@ -323,9 +323,8 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
 		 */
 		pagevec_add(&pvec_putback, pvec->pages[i]);
 		pvec->pages[i] = NULL;
+		spin_unlock_irq(&lruvec->lru_lock);
 	}
-	__mod_zone_page_state(zone, NR_MLOCK, delta_munlocked);
-	spin_unlock_irq(&zone->zone_pgdat->lru_lock);
 
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
diff --git a/mm/page_idle.c b/mm/page_idle.c
index 295512465065..25f4b1cf3e0f 100644
--- a/mm/page_idle.c
+++ b/mm/page_idle.c
@@ -32,6 +32,7 @@ static struct page *page_idle_get_page(unsigned long pfn)
 {
 	struct page *page;
 	pg_data_t *pgdat;
+	struct lruvec *lruvec;
 
 	if (!pfn_valid(pfn))
 		return NULL;
@@ -42,12 +43,12 @@ static struct page *page_idle_get_page(unsigned long pfn)
 		return NULL;
 
 	pgdat = page_pgdat(page);
-	spin_lock_irq(&pgdat->lru_lock);
+	lruvec = lock_page_lruvec_irq(page, pgdat);
 	if (unlikely(!PageLRU(page))) {
 		put_page(page);
 		page = NULL;
 	}
-	spin_unlock_irq(&pgdat->lru_lock);
+	spin_unlock_irq(&lruvec->lru_lock);
 	return page;
 }
 
diff --git a/mm/swap.c b/mm/swap.c
index c36a10244d07..05fee145e382 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -64,12 +64,11 @@ static void __page_cache_release(struct page *page)
 		struct lruvec *lruvec;
 		unsigned long flags = 0;
 
-		spin_lock_irqsave(&pgdat->lru_lock, flags);
-		lruvec = mem_cgroup_page_lruvec(page, pgdat);
+		lruvec = lock_page_lruvec_irqsave(page, pgdat, &flags);
 		VM_BUG_ON_PAGE(!PageLRU(page), page);
 		__ClearPageLRU(page);
 		del_page_from_lru_list(page, lruvec, page_off_lru(page));
-		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
+		spin_unlock_irqrestore(&lruvec->lru_lock, flags);
 	}
 	__ClearPageWaiters(page);
 }
@@ -192,26 +191,18 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
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
 
-		if (pagepgdat != pgdat) {
-			if (pgdat)
-				spin_unlock_irqrestore(&pgdat->lru_lock, flags);
-			pgdat = pagepgdat;
-			spin_lock_irqsave(&pgdat->lru_lock, flags);
-		}
+		lruvec = lock_page_lruvec_irqsave(page, page_pgdat(page), &flags);
 
-		lruvec = mem_cgroup_page_lruvec(page, pgdat);
 		(*move_fn)(page, lruvec, arg);
+		spin_unlock_irqrestore(&lruvec->lru_lock, flags);
 	}
-	if (pgdat)
-		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
+
 	release_pages(pvec->pages, pvec->nr);
 	pagevec_reinit(pvec);
 }
@@ -252,7 +243,6 @@ void rotate_reclaimable_page(struct page *page)
 	    !PageUnevictable(page) && PageLRU(page)) {
 		struct pagevec *pvec;
 		unsigned long flags;
-
 		get_page(page);
 		local_irq_save(flags);
 		pvec = this_cpu_ptr(&lru_rotate_pvecs);
@@ -325,11 +315,12 @@ static inline void activate_page_drain(int cpu)
 void activate_page(struct page *page)
 {
 	pg_data_t *pgdat = page_pgdat(page);
+	struct lruvec *lruvec;
 
 	page = compound_head(page);
-	spin_lock_irq(&pgdat->lru_lock);
-	__activate_page(page, mem_cgroup_page_lruvec(page, pgdat), NULL);
-	spin_unlock_irq(&pgdat->lru_lock);
+	lruvec = lock_page_lruvec_irq(page, pgdat);
+	__activate_page(page, lruvec, NULL);
+	spin_unlock_irq(&lruvec->lru_lock);
 }
 #endif
 
@@ -780,8 +771,7 @@ void release_pages(struct page **pages, int nr)
 {
 	int i;
 	LIST_HEAD(pages_to_free);
-	struct pglist_data *locked_pgdat = NULL;
-	struct lruvec *lruvec;
+	struct lruvec *lruvec = NULL;
 	unsigned long uninitialized_var(flags);
 	unsigned int uninitialized_var(lock_batch);
 
@@ -791,21 +781,20 @@ void release_pages(struct page **pages, int nr)
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
+			spin_unlock_irqrestore(&lruvec->lru_lock, flags);
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
+				spin_unlock_irqrestore(&lruvec->lru_lock, flags);
+				lruvec = NULL;
 			}
 			/*
 			 * ZONE_DEVICE pages that return 'false' from
@@ -822,27 +811,24 @@ void release_pages(struct page **pages, int nr)
 			continue;
 
 		if (PageCompound(page)) {
-			if (locked_pgdat) {
-				spin_unlock_irqrestore(&locked_pgdat->lru_lock, flags);
-				locked_pgdat = NULL;
+			if (lruvec) {
+				spin_unlock_irqrestore(&lruvec->lru_lock, flags);
+				lruvec = NULL;
 			}
 			__put_compound_page(page);
 			continue;
 		}
 
 		if (PageLRU(page)) {
-			struct pglist_data *pgdat = page_pgdat(page);
+			struct lruvec *new_lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
 
-			if (pgdat != locked_pgdat) {
-				if (locked_pgdat)
-					spin_unlock_irqrestore(&locked_pgdat->lru_lock,
-									flags);
+			if (new_lruvec != lruvec) {
+				if (lruvec)
+					spin_unlock_irqrestore(&lruvec->lru_lock, flags);
 				lock_batch = 0;
-				locked_pgdat = pgdat;
-				spin_lock_irqsave(&locked_pgdat->lru_lock, flags);
-			}
+				lruvec = lock_page_lruvec_irqsave(page, page_pgdat(page), &flags);
 
-			lruvec = mem_cgroup_page_lruvec(page, locked_pgdat);
+			}
 			VM_BUG_ON_PAGE(!PageLRU(page), page);
 			__ClearPageLRU(page);
 			del_page_from_lru_list(page, lruvec, page_off_lru(page));
@@ -854,8 +840,8 @@ void release_pages(struct page **pages, int nr)
 
 		list_add(&page->lru, &pages_to_free);
 	}
-	if (locked_pgdat)
-		spin_unlock_irqrestore(&locked_pgdat->lru_lock, flags);
+	if (lruvec)
+		spin_unlock_irqrestore(&lruvec->lru_lock, flags);
 
 	mem_cgroup_uncharge_list(&pages_to_free);
 	free_unref_page_list(&pages_to_free);
@@ -893,7 +879,7 @@ void lru_add_page_tail(struct page *page, struct page *page_tail,
 	VM_BUG_ON_PAGE(!PageHead(page), page);
 	VM_BUG_ON_PAGE(PageCompound(page_tail), page);
 	VM_BUG_ON_PAGE(PageLRU(page_tail), page);
-	lockdep_assert_held(&lruvec_pgdat(lruvec)->lru_lock);
+	lockdep_assert_held(&lruvec->lru_lock);
 
 	if (!list)
 		SetPageLRU(page_tail);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index d97985262dda..3cdf343e7a27 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1755,8 +1755,7 @@ int isolate_lru_page(struct page *page)
 		pg_data_t *pgdat = page_pgdat(page);
 		struct lruvec *lruvec;
 
-		spin_lock_irq(&pgdat->lru_lock);
-		lruvec = mem_cgroup_page_lruvec(page, pgdat);
+		lruvec = lock_page_lruvec_irq(page, pgdat);
 		if (PageLRU(page)) {
 			int lru = page_lru(page);
 			get_page(page);
@@ -1764,7 +1763,7 @@ int isolate_lru_page(struct page *page)
 			del_page_from_lru_list(page, lruvec, lru);
 			ret = 0;
 		}
-		spin_unlock_irq(&pgdat->lru_lock);
+		spin_unlock_irq(&lruvec->lru_lock);
 	}
 	return ret;
 }
@@ -1829,7 +1828,6 @@ static int too_many_isolated(struct pglist_data *pgdat, int file,
 static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 						     struct list_head *list)
 {
-	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 	int nr_pages, nr_moved = 0;
 	LIST_HEAD(pages_to_free);
 	struct page *page;
@@ -1840,12 +1838,11 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 		VM_BUG_ON_PAGE(PageLRU(page), page);
 		if (unlikely(!page_evictable(page))) {
 			list_del(&page->lru);
-			spin_unlock_irq(&pgdat->lru_lock);
+			spin_unlock_irq(&lruvec->lru_lock);
 			putback_lru_page(page);
-			spin_lock_irq(&pgdat->lru_lock);
+			spin_lock_irq(&lruvec->lru_lock);
 			continue;
 		}
-		lruvec = mem_cgroup_page_lruvec(page, pgdat);
 
 		SetPageLRU(page);
 		lru = page_lru(page);
@@ -1860,9 +1857,9 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 			del_page_from_lru_list(page, lruvec, lru);
 
 			if (unlikely(PageCompound(page))) {
-				spin_unlock_irq(&pgdat->lru_lock);
+				spin_unlock_irq(&lruvec->lru_lock);
 				(*get_compound_page_dtor(page))(page);
-				spin_lock_irq(&pgdat->lru_lock);
+				spin_lock_irq(&lruvec->lru_lock);
 			} else
 				list_add(&page->lru, &pages_to_free);
 		} else {
@@ -1925,7 +1922,7 @@ static int current_may_throttle(void)
 
 	lru_add_drain();
 
-	spin_lock_irq(&pgdat->lru_lock);
+	spin_lock_irq(&lruvec->lru_lock);
 
 	nr_taken = isolate_lru_pages(nr_to_scan, lruvec, &page_list,
 				     &nr_scanned, sc, lru);
@@ -1937,7 +1934,7 @@ static int current_may_throttle(void)
 	if (!cgroup_reclaim(sc))
 		__count_vm_events(item, nr_scanned);
 	__count_memcg_events(lruvec_memcg(lruvec), item, nr_scanned);
-	spin_unlock_irq(&pgdat->lru_lock);
+	spin_unlock_irq(&lruvec->lru_lock);
 
 	if (nr_taken == 0)
 		return 0;
@@ -1945,7 +1942,7 @@ static int current_may_throttle(void)
 	nr_reclaimed = shrink_page_list(&page_list, pgdat, sc, 0,
 				&stat, false);
 
-	spin_lock_irq(&pgdat->lru_lock);
+	spin_lock_irq(&lruvec->lru_lock);
 
 	item = current_is_kswapd() ? PGSTEAL_KSWAPD : PGSTEAL_DIRECT;
 	if (!cgroup_reclaim(sc))
@@ -1958,7 +1955,7 @@ static int current_may_throttle(void)
 
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
 
-	spin_unlock_irq(&pgdat->lru_lock);
+	spin_unlock_irq(&lruvec->lru_lock);
 
 	mem_cgroup_uncharge_list(&page_list);
 	free_unref_page_list(&page_list);
@@ -2011,7 +2008,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 
 	lru_add_drain();
 
-	spin_lock_irq(&pgdat->lru_lock);
+	spin_lock_irq(&lruvec->lru_lock);
 
 	nr_taken = isolate_lru_pages(nr_to_scan, lruvec, &l_hold,
 				     &nr_scanned, sc, lru);
@@ -2022,7 +2019,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	__count_vm_events(PGREFILL, nr_scanned);
 	__count_memcg_events(lruvec_memcg(lruvec), PGREFILL, nr_scanned);
 
-	spin_unlock_irq(&pgdat->lru_lock);
+	spin_unlock_irq(&lruvec->lru_lock);
 
 	while (!list_empty(&l_hold)) {
 		cond_resched();
@@ -2068,7 +2065,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	/*
 	 * Move pages back to the lru list.
 	 */
-	spin_lock_irq(&pgdat->lru_lock);
+	spin_lock_irq(&lruvec->lru_lock);
 	/*
 	 * Count referenced pages from currently used mappings as rotated,
 	 * even though only some of them are actually re-activated.  This
@@ -2086,7 +2083,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	__count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_deactivate);
 
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
-	spin_unlock_irq(&pgdat->lru_lock);
+	spin_unlock_irq(&lruvec->lru_lock);
 
 	mem_cgroup_uncharge_list(&l_active);
 	free_unref_page_list(&l_active);
@@ -2371,7 +2368,7 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 	file  = lruvec_lru_size(lruvec, LRU_ACTIVE_FILE, MAX_NR_ZONES) +
 		lruvec_lru_size(lruvec, LRU_INACTIVE_FILE, MAX_NR_ZONES);
 
-	spin_lock_irq(&pgdat->lru_lock);
+	spin_lock_irq(&lruvec->lru_lock);
 	if (unlikely(reclaim_stat->recent_scanned[0] > anon / 4)) {
 		reclaim_stat->recent_scanned[0] /= 2;
 		reclaim_stat->recent_rotated[0] /= 2;
@@ -2392,7 +2389,7 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 
 	fp = file_prio * (reclaim_stat->recent_scanned[1] + 1);
 	fp /= reclaim_stat->recent_rotated[1] + 1;
-	spin_unlock_irq(&pgdat->lru_lock);
+	spin_unlock_irq(&lruvec->lru_lock);
 
 	fraction[0] = ap;
 	fraction[1] = fp;
@@ -4285,24 +4282,25 @@ int page_evictable(struct page *page)
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
+		struct pglist_data *pgdat = page_pgdat(page);
+		struct lruvec *new_lruvec = mem_cgroup_page_lruvec(page, pgdat);
+
 
 		pgscanned++;
-		if (pagepgdat != pgdat) {
-			if (pgdat)
-				spin_unlock_irq(&pgdat->lru_lock);
-			pgdat = pagepgdat;
-			spin_lock_irq(&pgdat->lru_lock);
+
+		if (lruvec != new_lruvec) {
+			if (lruvec)
+				spin_unlock_irq(&lruvec->lru_lock);
+			lruvec = new_lruvec;
+			spin_lock_irq(&lruvec->lru_lock);
 		}
-		lruvec = mem_cgroup_page_lruvec(page, pgdat);
 
 		if (!PageLRU(page) || !PageUnevictable(page))
 			continue;
@@ -4318,10 +4316,10 @@ void check_move_unevictable_pages(struct pagevec *pvec)
 		}
 	}
 
-	if (pgdat) {
+	if (lruvec) {
 		__count_vm_events(UNEVICTABLE_PGRESCUED, pgrescued);
 		__count_vm_events(UNEVICTABLE_PGSCANNED, pgscanned);
-		spin_unlock_irq(&pgdat->lru_lock);
+		spin_unlock_irq(&lruvec->lru_lock);
 	}
 }
 EXPORT_SYMBOL_GPL(check_move_unevictable_pages);
-- 
1.8.3.1


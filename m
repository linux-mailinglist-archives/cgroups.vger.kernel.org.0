Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C3D29E965
	for <lists+cgroups@lfdr.de>; Thu, 29 Oct 2020 11:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgJ2Kqn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Oct 2020 06:46:43 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:58896 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726740AbgJ2Kpg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Oct 2020 06:45:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0UDXwDyN_1603968328;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UDXwDyN_1603968328)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 29 Oct 2020 18:45:31 +0800
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
Cc:     Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v20 06/20] mm/thp: narrow lru locking
Date:   Thu, 29 Oct 2020 18:44:51 +0800
Message-Id: <1603968305-8026-7-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

lru_lock and page cache xa_lock have no obvious reason to be taken
one way round or the other: until now, lru_lock has been taken before
page cache xa_lock, when splitting a THP; but nothing else takes them
together.  Reverse that ordering: let's narrow the lru locking - but
leave local_irq_disable to block interrupts throughout, like before.

Hugh Dickins point: split_huge_page_to_list() was already silly, to be
using the _irqsave variant: it's just been taking sleeping locks, so
would already be broken if entered with interrupts enabled.  So we
can save passing flags argument down to __split_huge_page().

Why change the lock ordering here? That was hard to decide. One reason:
when this series reaches per-memcg lru locking, it relies on the THP's
memcg to be stable when taking the lru_lock: that is now done after the
THP's refcount has been frozen, which ensures page memcg cannot change.

Another reason: previously, lock_page_memcg()'s move_lock was presumed
to nest inside lru_lock; but now lru_lock must nest inside (page cache
lock inside) move_lock, so it becomes possible to use lock_page_memcg()
to stabilize page memcg before taking its lru_lock.  That is not the
mechanism used in this series, but it is an option we want to keep open.

[Hugh Dickins: rewrite commit log]
Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Hugh Dickins <hughd@google.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/huge_memory.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4b72dd7b8b34..5fa890e26975 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2433,7 +2433,7 @@ static void __split_huge_page_tail(struct page *head, int tail,
 }
 
 static void __split_huge_page(struct page *page, struct list_head *list,
-		pgoff_t end, unsigned long flags)
+		pgoff_t end)
 {
 	struct page *head = compound_head(page);
 	pg_data_t *pgdat = page_pgdat(head);
@@ -2443,8 +2443,6 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	unsigned int nr = thp_nr_pages(head);
 	int i;
 
-	lruvec = mem_cgroup_page_lruvec(head, pgdat);
-
 	/* complete memcg works before add pages to LRU */
 	mem_cgroup_split_huge_fixup(head);
 
@@ -2456,6 +2454,11 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		xa_lock(&swap_cache->i_pages);
 	}
 
+	/* prevent PageLRU to go away from under us, and freeze lru stats */
+	spin_lock(&pgdat->lru_lock);
+
+	lruvec = mem_cgroup_page_lruvec(head, pgdat);
+
 	for (i = nr - 1; i >= 1; i--) {
 		__split_huge_page_tail(head, i, lruvec, list);
 		/* Some pages can be beyond i_size: drop them from page cache */
@@ -2475,6 +2478,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	}
 
 	ClearPageCompound(head);
+	spin_unlock(&pgdat->lru_lock);
+	/* Caller disabled irqs, so they are still disabled here */
 
 	split_page_owner(head, nr);
 
@@ -2492,8 +2497,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		page_ref_add(head, 2);
 		xa_unlock(&head->mapping->i_pages);
 	}
-
-	spin_unlock_irqrestore(&pgdat->lru_lock, flags);
+	local_irq_enable();
 
 	remap_page(head, nr);
 
@@ -2639,12 +2643,10 @@ bool can_split_huge_page(struct page *page, int *pextra_pins)
 int split_huge_page_to_list(struct page *page, struct list_head *list)
 {
 	struct page *head = compound_head(page);
-	struct pglist_data *pgdata = NODE_DATA(page_to_nid(head));
 	struct deferred_split *ds_queue = get_deferred_split_queue(head);
 	struct anon_vma *anon_vma = NULL;
 	struct address_space *mapping = NULL;
 	int count, mapcount, extra_pins, ret;
-	unsigned long flags;
 	pgoff_t end;
 
 	VM_BUG_ON_PAGE(is_huge_zero_page(head), head);
@@ -2705,9 +2707,8 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	unmap_page(head);
 	VM_BUG_ON_PAGE(compound_mapcount(head), head);
 
-	/* prevent PageLRU to go away from under us, and freeze lru stats */
-	spin_lock_irqsave(&pgdata->lru_lock, flags);
-
+	/* block interrupt reentry in xa_lock and spinlock */
+	local_irq_disable();
 	if (mapping) {
 		XA_STATE(xas, &mapping->i_pages, page_index(head));
 
@@ -2737,7 +2738,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 				__dec_node_page_state(head, NR_FILE_THPS);
 		}
 
-		__split_huge_page(page, list, end, flags);
+		__split_huge_page(page, list, end);
 		ret = 0;
 	} else {
 		if (IS_ENABLED(CONFIG_DEBUG_VM) && mapcount) {
@@ -2751,7 +2752,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 		spin_unlock(&ds_queue->split_queue_lock);
 fail:		if (mapping)
 			xa_unlock(&mapping->i_pages);
-		spin_unlock_irqrestore(&pgdata->lru_lock, flags);
+		local_irq_enable();
 		remap_page(head, thp_nr_pages(head));
 		ret = -EBUSY;
 	}
-- 
1.8.3.1


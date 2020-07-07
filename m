Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9125E216C12
	for <lists+cgroups@lfdr.de>; Tue,  7 Jul 2020 13:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgGGLrZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 Jul 2020 07:47:25 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:58099 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728591AbgGGLrY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 7 Jul 2020 07:47:24 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0U20joWQ_1594122436;
Received: from alexshi-test.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U20joWQ_1594122436)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 07 Jul 2020 19:47:20 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v15 07/21] mm/thp: narrow lru locking
Date:   Tue,  7 Jul 2020 19:46:39 +0800
Message-Id: <1594122412-28057-8-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1594122412-28057-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1594122412-28057-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

lru_lock and page cache xa_lock have no reason with current sequence,
put them together isn't necessary. let's narrow the lru locking, but
left the local_irq_disable to block interrupt re-entry and statistic update.

Hugh Dickins point: split_huge_page_to_list() was already silly,to be
using the _irqsave variant: it's just been taking sleeping locks, so
would already be broken if entered with interrupts enabled.
so we can save passing flags argument down to __split_huge_page().

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/huge_memory.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b18f21da4dac..b74d0f8354e3 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2433,7 +2433,7 @@ static void __split_huge_page_tail(struct page *head, int tail,
 }
 
 static void __split_huge_page(struct page *page, struct list_head *list,
-		pgoff_t end, unsigned long flags)
+			      pgoff_t end)
 {
 	struct page *head = compound_head(page);
 	pg_data_t *pgdat = page_pgdat(head);
@@ -2442,8 +2442,6 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	unsigned long offset = 0;
 	int i;
 
-	lruvec = mem_cgroup_page_lruvec(head, pgdat);
-
 	/* complete memcg works before add pages to LRU */
 	mem_cgroup_split_huge_fixup(head);
 
@@ -2455,6 +2453,11 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		xa_lock(&swap_cache->i_pages);
 	}
 
+	/* prevent PageLRU to go away from under us, and freeze lru stats */
+	spin_lock(&pgdat->lru_lock);
+
+	lruvec = mem_cgroup_page_lruvec(head, pgdat);
+
 	for (i = HPAGE_PMD_NR - 1; i >= 1; i--) {
 		__split_huge_page_tail(head, i, lruvec, list);
 		/* Some pages can be beyond i_size: drop them from page cache */
@@ -2474,6 +2477,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	}
 
 	ClearPageCompound(head);
+	spin_unlock(&pgdat->lru_lock);
+	/* Caller disabled irqs, so they are still disabled here */
 
 	split_page_owner(head, HPAGE_PMD_ORDER);
 
@@ -2491,8 +2496,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		page_ref_add(head, 2);
 		xa_unlock(&head->mapping->i_pages);
 	}
-
-	spin_unlock_irqrestore(&pgdat->lru_lock, flags);
+	local_irq_enable();
 
 	remap_page(head);
 
@@ -2631,12 +2635,10 @@ bool can_split_huge_page(struct page *page, int *pextra_pins)
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
@@ -2697,9 +2699,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	unmap_page(head);
 	VM_BUG_ON_PAGE(compound_mapcount(head), head);
 
-	/* prevent PageLRU to go away from under us, and freeze lru stats */
-	spin_lock_irqsave(&pgdata->lru_lock, flags);
-
+	local_irq_disable();
 	if (mapping) {
 		XA_STATE(xas, &mapping->i_pages, page_index(head));
 
@@ -2729,7 +2729,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 				__dec_node_page_state(head, NR_FILE_THPS);
 		}
 
-		__split_huge_page(page, list, end, flags);
+		__split_huge_page(page, list, end);
 		if (PageSwapCache(head)) {
 			swp_entry_t entry = { .val = page_private(head) };
 
@@ -2748,7 +2748,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 		spin_unlock(&ds_queue->split_queue_lock);
 fail:		if (mapping)
 			xa_unlock(&mapping->i_pages);
-		spin_unlock_irqrestore(&pgdata->lru_lock, flags);
+		local_irq_enable();
 		remap_page(head);
 		ret = -EBUSY;
 	}
-- 
1.8.3.1


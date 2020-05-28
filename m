Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868721E5DBC
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2020 13:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388276AbgE1LDN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 May 2020 07:03:13 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:39088 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388224AbgE1LDM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 May 2020 07:03:12 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07425;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0TztfJfN_1590663687;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TztfJfN_1590663687)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 28 May 2020 19:01:27 +0800
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
Subject: [PATCH v11 07/16] mm/thp: narrow lru locking
Date:   Thu, 28 May 2020 19:00:49 +0800
Message-Id: <1590663658-184131-8-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1590663658-184131-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1590663658-184131-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

lru_lock and page cache xa_lock have no reason with current sequence,
put them together isn't necessary. let's narrow the lru locking, but
left the local_irq_disable/preempt_disable to block interrupt
re-entry and statistic update.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/huge_memory.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a4ba75e143b3..44d4b45281a3 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2418,8 +2418,6 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	unsigned long offset = 0;
 	int i;
 
-	lruvec = mem_cgroup_page_lruvec(head, pgdat);
-
 	/* complete memcg works before add pages to LRU */
 	mem_cgroup_split_huge_fixup(head);
 
@@ -2431,6 +2429,11 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		xa_lock(&swap_cache->i_pages);
 	}
 
+	/* lock lru list/PageCompound, isolate freezed by page_ref_freeze */
+	spin_lock(&pgdat->lru_lock);
+
+	lruvec = mem_cgroup_page_lruvec(head, pgdat);
+
 	for (i = HPAGE_PMD_NR - 1; i >= 1; i--) {
 		__split_huge_page_tail(head, i, lruvec, list);
 		/* Some pages can be beyond i_size: drop them from page cache */
@@ -2448,8 +2451,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 					head + i, 0);
 		}
 	}
-
 	ClearPageCompound(head);
+	spin_unlock(&pgdat->lru_lock);
 
 	split_page_owner(head, HPAGE_PMD_ORDER);
 
@@ -2467,8 +2470,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		page_ref_add(head, 2);
 		xa_unlock(&head->mapping->i_pages);
 	}
-
-	spin_unlock_irqrestore(&pgdat->lru_lock, flags);
+	preempt_enable();
+	local_irq_restore(flags);
 
 	remap_page(head);
 
@@ -2607,7 +2610,6 @@ bool can_split_huge_page(struct page *page, int *pextra_pins)
 int split_huge_page_to_list(struct page *page, struct list_head *list)
 {
 	struct page *head = compound_head(page);
-	struct pglist_data *pgdata = NODE_DATA(page_to_nid(head));
 	struct deferred_split *ds_queue = get_deferred_split_queue(head);
 	struct anon_vma *anon_vma = NULL;
 	struct address_space *mapping = NULL;
@@ -2673,9 +2675,8 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	unmap_page(head);
 	VM_BUG_ON_PAGE(compound_mapcount(head), head);
 
-	/* prevent PageLRU to go away from under us, and freeze lru stats */
-	spin_lock_irqsave(&pgdata->lru_lock, flags);
-
+	local_irq_save(flags);
+	preempt_disable();
 	if (mapping) {
 		XA_STATE(xas, &mapping->i_pages, page_index(head));
 
@@ -2724,7 +2725,8 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 		spin_unlock(&ds_queue->split_queue_lock);
 fail:		if (mapping)
 			xa_unlock(&mapping->i_pages);
-		spin_unlock_irqrestore(&pgdata->lru_lock, flags);
+		preempt_enable();
+		local_irq_restore(flags);
 		remap_page(head);
 		ret = -EBUSY;
 	}
-- 
1.8.3.1


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6582A79E0
	for <lists+cgroups@lfdr.de>; Thu,  5 Nov 2020 09:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgKEI4Q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Nov 2020 03:56:16 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:57004 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726428AbgKEI4O (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Nov 2020 03:56:14 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0UEJC3Fv_1604566567;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UEJC3Fv_1604566567)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 05 Nov 2020 16:56:08 +0800
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
Subject: [PATCH v21 02/19] mm/thp: use head for head page in lru_add_page_tail
Date:   Thu,  5 Nov 2020 16:55:32 +0800
Message-Id: <1604566549-62481-3-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Since the first parameter is only used by head page, it's better to make
it explicit.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Hugh Dickins <hughd@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/huge_memory.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 8f16e991f7cc..60726eb26840 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2348,33 +2348,32 @@ static void remap_page(struct page *page, unsigned int nr)
 	}
 }
 
-static void lru_add_page_tail(struct page *page, struct page *page_tail,
+static void lru_add_page_tail(struct page *head, struct page *tail,
 		struct lruvec *lruvec, struct list_head *list)
 {
-	VM_BUG_ON_PAGE(!PageHead(page), page);
-	VM_BUG_ON_PAGE(PageCompound(page_tail), page);
-	VM_BUG_ON_PAGE(PageLRU(page_tail), page);
+	VM_BUG_ON_PAGE(!PageHead(head), head);
+	VM_BUG_ON_PAGE(PageCompound(tail), head);
+	VM_BUG_ON_PAGE(PageLRU(tail), head);
 	lockdep_assert_held(&lruvec_pgdat(lruvec)->lru_lock);
 
 	if (!list)
-		SetPageLRU(page_tail);
+		SetPageLRU(tail);
 
-	if (likely(PageLRU(page)))
-		list_add_tail(&page_tail->lru, &page->lru);
+	if (likely(PageLRU(head)))
+		list_add_tail(&tail->lru, &head->lru);
 	else if (list) {
 		/* page reclaim is reclaiming a huge page */
-		get_page(page_tail);
-		list_add_tail(&page_tail->lru, list);
+		get_page(tail);
+		list_add_tail(&tail->lru, list);
 	} else {
 		/*
 		 * Head page has not yet been counted, as an hpage,
 		 * so we must account for each subpage individually.
 		 *
-		 * Put page_tail on the list at the correct position
+		 * Put tail on the list at the correct position
 		 * so they all end up in order.
 		 */
-		add_page_to_lru_list_tail(page_tail, lruvec,
-					  page_lru(page_tail));
+		add_page_to_lru_list_tail(tail, lruvec, page_lru(tail));
 	}
 }
 
-- 
1.8.3.1


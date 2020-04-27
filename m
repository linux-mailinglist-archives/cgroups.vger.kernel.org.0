Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAFD1B9806
	for <lists+cgroups@lfdr.de>; Mon, 27 Apr 2020 09:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgD0HDn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Apr 2020 03:03:43 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:34746 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726713AbgD0HDn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Apr 2020 03:03:43 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0TwlaTj1_1587971014;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TwlaTj1_1587971014)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 27 Apr 2020 15:03:35 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
Cc:     Alex Shi <alex.shi@linux.alibaba.com>
Subject: [PATCH v10 05/15] mm/thp: clean up lru_add_page_tail
Date:   Mon, 27 Apr 2020 15:02:54 +0800
Message-Id: <1587970985-21629-6-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1587970985-21629-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1587970985-21629-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Since the first parameter is only used by head page, it's better to make
it stright. And no needs to keep head checking:
	VM_BUG_ON_PAGE(!PageHead(page), page);

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/huge_memory.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ea60340a14c8..bd28d68ad3a8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2501,21 +2501,20 @@ static void remap_page(struct page *page)
 	}
 }
 
-void lru_add_page_tail(struct page *page, struct page *page_tail,
+void lru_add_page_tail(struct page *head, struct page *page_tail,
 		       struct lruvec *lruvec, struct list_head *list)
 {
 	const int file = 0;
 
-	VM_BUG_ON_PAGE(!PageHead(page), page);
-	VM_BUG_ON_PAGE(PageCompound(page_tail), page);
-	VM_BUG_ON_PAGE(PageLRU(page_tail), page);
+	VM_BUG_ON_PAGE(PageCompound(page_tail), head);
+	VM_BUG_ON_PAGE(PageLRU(page_tail), head);
 	lockdep_assert_held(&lruvec_pgdat(lruvec)->lru_lock);
 
 	if (!list)
 		SetPageLRU(page_tail);
 
-	if (likely(PageLRU(page)))
-		list_add_tail(&page_tail->lru, &page->lru);
+	if (likely(PageLRU(head)))
+		list_add_tail(&page_tail->lru, &head->lru);
 	else if (list) {
 		/* page reclaim is reclaiming a huge page */
 		get_page(page_tail);
@@ -2532,7 +2531,7 @@ void lru_add_page_tail(struct page *page, struct page *page_tail,
 					  page_lru(page_tail));
 	}
 
-	if (!PageUnevictable(page))
+	if (!PageUnevictable(head))
 		update_page_reclaim_stat(lruvec, file, PageActive(page_tail));
 }
 
-- 
1.8.3.1


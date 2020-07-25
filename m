Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC8722D7B4
	for <lists+cgroups@lfdr.de>; Sat, 25 Jul 2020 15:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgGYNA3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 25 Jul 2020 09:00:29 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:46328 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726613AbgGYNA3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 25 Jul 2020 09:00:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0U3l6fmD_1595682015;
Received: from aliy8.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U3l6fmD_1595682015)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 25 Jul 2020 21:00:23 +0800
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
Subject: [PATCH v17 06/21] mm/thp: clean up lru_add_page_tail
Date:   Sat, 25 Jul 2020 20:59:43 +0800
Message-Id: <1595681998-19193-7-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Since the first parameter is only used by head page, it's better to make
it explicit.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/huge_memory.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9e050b13f597..b18f21da4dac 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2340,19 +2340,19 @@ static void remap_page(struct page *page)
 	}
 }
 
-static void lru_add_page_tail(struct page *page, struct page *page_tail,
+static void lru_add_page_tail(struct page *head, struct page *page_tail,
 				struct lruvec *lruvec, struct list_head *list)
 {
-	VM_BUG_ON_PAGE(!PageHead(page), page);
-	VM_BUG_ON_PAGE(PageCompound(page_tail), page);
-	VM_BUG_ON_PAGE(PageLRU(page_tail), page);
+	VM_BUG_ON_PAGE(!PageHead(head), head);
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
-- 
1.8.3.1


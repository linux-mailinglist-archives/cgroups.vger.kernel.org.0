Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3DF721C170
	for <lists+cgroups@lfdr.de>; Sat, 11 Jul 2020 03:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgGKA7u (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Jul 2020 20:59:50 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:49090 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727983AbgGKA7t (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Jul 2020 20:59:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0U2KGAZr_1594429139;
Received: from alexshi-test.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U2KGAZr_1594429139)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 11 Jul 2020 08:59:05 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name
Cc:     =?UTF-8?q?Mika=20Penttil=C3=A4?= <mika.penttila@nextfour.com>
Subject: [PATCH v16 14/22] mm/thp: add tail pages into lru anyway in split_huge_page()
Date:   Sat, 11 Jul 2020 08:58:48 +0800
Message-Id: <1594429136-20002-15-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

split_huge_page() must start with PageLRU(head), but lru bit *maybe*
cleared by isolate_lru_page, anyway the head still in lru list, since we
still held the lru_lock.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Mika Penttilä <mika.penttila@nextfour.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/huge_memory.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d866b6e43434..4fe7b92c9330 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2348,15 +2348,18 @@ static void lru_add_page_tail(struct page *head, struct page *page_tail,
 	VM_BUG_ON_PAGE(PageLRU(page_tail), head);
 	lockdep_assert_held(&lruvec_pgdat(lruvec)->lru_lock);
 
-	if (!list)
-		SetPageLRU(page_tail);
-
-	if (likely(PageLRU(head)))
-		list_add_tail(&page_tail->lru, &head->lru);
-	else if (list) {
+	if (list) {
 		/* page reclaim is reclaiming a huge page */
 		get_page(page_tail);
 		list_add_tail(&page_tail->lru, list);
+	} else {
+		/*
+		 * Split start from PageLRU(head), but lru bit maybe cleared
+		 * by isolate_lru_page, but head still in lru list, since we
+		 * held the lru_lock.
+		 */
+		SetPageLRU(page_tail);
+		list_add_tail(&page_tail->lru, &head->lru);
 	}
 }
 
-- 
1.8.3.1


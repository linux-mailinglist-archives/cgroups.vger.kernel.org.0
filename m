Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4426A1B9803
	for <lists+cgroups@lfdr.de>; Mon, 27 Apr 2020 09:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgD0HD5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Apr 2020 03:03:57 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:34480 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726719AbgD0HDo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Apr 2020 03:03:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0TwkfAl6_1587971019;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TwkfAl6_1587971019)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 27 Apr 2020 15:03:39 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Jann Horn <jannh@google.com>
Subject: [PATCH v10 13/15] mm/vmscan: use relock for move_pages_to_lru
Date:   Mon, 27 Apr 2020 15:03:03 +0800
Message-Id: <1587970985-21629-15-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1587970985-21629-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1587970985-21629-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Hugh Dickins <hughd@google.com>

Use the relock function to replace relocking action. And try to save few
lock times.

Signed-off-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Jann Horn <jannh@google.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: cgroups@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 mm/vmscan.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6dd3e1be5bbb..52d8a35fdf6a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1836,15 +1836,15 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 	enum lru_list lru;
 
 	while (!list_empty(list)) {
-		struct lruvec *new_lruvec = NULL;
-
 		page = lru_to_page(list);
 		VM_BUG_ON_PAGE(PageLRU(page), page);
 		list_del(&page->lru);
 		if (unlikely(!page_evictable(page))) {
-			spin_unlock_irq(&lruvec->lru_lock);
+			if (lruvec) {
+				spin_unlock_irq(&lruvec->lru_lock);
+				lruvec = NULL;
+			}
 			putback_lru_page(page);
-			spin_lock_irq(&lruvec->lru_lock);
 			continue;
 		}
 
@@ -1858,12 +1858,7 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 		 *                                        list_add(&page->lru,)
 		 *     list_add(&page->lru,) //corrupt
 		 */
-		new_lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
-		if (new_lruvec != lruvec) {
-			if (lruvec)
-				spin_unlock_irq(&lruvec->lru_lock);
-			lruvec = lock_page_lruvec_irq(page);
-		}
+		lruvec = relock_page_lruvec_irq(page, lruvec);
 		SetPageLRU(page);
 
 		if (unlikely(put_page_testzero(page))) {
@@ -1872,8 +1867,8 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 
 			if (unlikely(PageCompound(page))) {
 				spin_unlock_irq(&lruvec->lru_lock);
+				lruvec = NULL;
 				(*get_compound_page_dtor(page))(page);
-				spin_lock_irq(&lruvec->lru_lock);
 			} else
 				list_add(&page->lru, &pages_to_free);
 			continue;
@@ -1891,7 +1886,6 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 		spin_lock_irq(&orig_lruvec->lru_lock);
 	}
 
-
 	/*
 	 * To save our caller's stack, now use input list for pages to free.
 	 */
-- 
1.8.3.1


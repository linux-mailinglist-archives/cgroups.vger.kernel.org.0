Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F07213362
	for <lists+cgroups@lfdr.de>; Fri,  3 Jul 2020 07:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgGCFIq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Jul 2020 01:08:46 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:38665 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726427AbgGCFIp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Jul 2020 01:08:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0U1Y4LGX_1593752912;
Received: from alexshi-test.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U1Y4LGX_1593752912)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 03 Jul 2020 13:08:41 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
Subject: [PATCH v14 18/20] mm/vmscan: use relock for move_pages_to_lru
Date:   Fri,  3 Jul 2020 13:07:51 +0800
Message-Id: <1593752873-4493-19-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1593752873-4493-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1593752873-4493-1-git-send-email-alex.shi@linux.alibaba.com>
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
 mm/vmscan.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index bdb53a678e7e..078a1640ec60 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1854,15 +1854,15 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
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
 
@@ -1876,12 +1876,7 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
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
@@ -1890,8 +1885,8 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 
 			if (unlikely(PageCompound(page))) {
 				spin_unlock_irq(&lruvec->lru_lock);
+				lruvec = NULL;
 				destroy_compound_page(page);
-				spin_lock_irq(&lruvec->lru_lock);
 			} else
 				list_add(&page->lru, &pages_to_free);
 
-- 
1.8.3.1


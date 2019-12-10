Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2641186FE
	for <lists+cgroups@lfdr.de>; Tue, 10 Dec 2019 12:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfLJLr7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Dec 2019 06:47:59 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:55384 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727018AbfLJLr7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Dec 2019 06:47:59 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0TkXAQaw_1575978471;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TkXAQaw_1575978471)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 10 Dec 2019 19:47:51 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        shakeelb@google.com, hannes@cmpxchg.org
Cc:     Alex Shi <alex.shi@linux.alibaba.com>, yun.wang@linux.alibaba.com
Subject: [PATCH v5 1/8] mm/vmscan: remove unnecessary lruvec adding
Date:   Tue, 10 Dec 2019 19:46:17 +0800
Message-Id: <1575978384-222381-2-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1575978384-222381-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1575978384-222381-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We don't have to add a freeable page into lru and then remove from it.
This change saves a couple of actions and makes the moving more clear.

The SetPageLRU needs to be kept here for list intergrity. Otherwise:

    #0 mave_pages_to_lru                #1 release_pages
                                        if (put_page_testzero())
    if (put_page_testzero())
	                                    !PageLRU //skip lru_lock
                                                list_add(&page->lru,);
    else
        list_add(&page->lru,) //corrupt

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: yun.wang@linux.alibaba.com
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/vmscan.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index d97985262dda..69fb9bd9ef49 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1838,26 +1838,18 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 	while (!list_empty(list)) {
 		page = lru_to_page(list);
 		VM_BUG_ON_PAGE(PageLRU(page), page);
+		list_del(&page->lru);
 		if (unlikely(!page_evictable(page))) {
-			list_del(&page->lru);
 			spin_unlock_irq(&pgdat->lru_lock);
 			putback_lru_page(page);
 			spin_lock_irq(&pgdat->lru_lock);
 			continue;
 		}
-		lruvec = mem_cgroup_page_lruvec(page, pgdat);
-
 		SetPageLRU(page);
-		lru = page_lru(page);
-
-		nr_pages = hpage_nr_pages(page);
-		update_lru_size(lruvec, lru, page_zonenum(page), nr_pages);
-		list_move(&page->lru, &lruvec->lists[lru]);
 
 		if (put_page_testzero(page)) {
 			__ClearPageLRU(page);
 			__ClearPageActive(page);
-			del_page_from_lru_list(page, lruvec, lru);
 
 			if (unlikely(PageCompound(page))) {
 				spin_unlock_irq(&pgdat->lru_lock);
@@ -1866,6 +1858,12 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 			} else
 				list_add(&page->lru, &pages_to_free);
 		} else {
+			lruvec = mem_cgroup_page_lruvec(page, pgdat);
+			lru = page_lru(page);
+			nr_pages = hpage_nr_pages(page);
+
+			update_lru_size(lruvec, lru, page_zonenum(page), nr_pages);
+			list_add(&page->lru, &lruvec->lists[lru]);
 			nr_moved += nr_pages;
 		}
 	}
-- 
1.8.3.1


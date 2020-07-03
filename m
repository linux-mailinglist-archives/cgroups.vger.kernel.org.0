Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06E4213366
	for <lists+cgroups@lfdr.de>; Fri,  3 Jul 2020 07:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgGCFJm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Jul 2020 01:09:42 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:58340 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726396AbgGCFIq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Jul 2020 01:08:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07425;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0U1Y4LGX_1593752912;
Received: from alexshi-test.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U1Y4LGX_1593752912)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 03 Jul 2020 13:08:38 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
Subject: [PATCH v14 11/20] mm/lru: move lock into lru_note_cost
Date:   Fri,  3 Jul 2020 13:07:44 +0800
Message-Id: <1593752873-4493-12-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1593752873-4493-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1593752873-4493-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patch move lru_lock into lru_note_cost. It's a bit ugly and may
cost more locking, but it's necessary for later per pgdat lru_lock to
per memcg lru_lock change.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/swap.c   | 5 +++--
 mm/vmscan.c | 4 +---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index b88ca630db70..c67699de4869 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -269,7 +269,9 @@ void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
 {
 	do {
 		unsigned long lrusize;
+		pglist_data *pgdat = lruvec_pgdat(lruvec);
 
+		spin_lock_irq(&pgdat->lru_lock);
 		/* Record cost event */
 		if (file)
 			lruvec->file_cost += nr_pages;
@@ -293,15 +295,14 @@ void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
 			lruvec->file_cost /= 2;
 			lruvec->anon_cost /= 2;
 		}
+		spin_unlock_irq(&pgdat->lru_lock);
 	} while ((lruvec = parent_lruvec(lruvec)));
 }
 
 void lru_note_cost_page(struct page *page)
 {
-	spin_lock_irq(&page_pgdat(page)->lru_lock);
 	lru_note_cost(mem_cgroup_page_lruvec(page, page_pgdat(page)),
 		      page_is_file_lru(page), hpage_nr_pages(page));
-	spin_unlock_irq(&page_pgdat(page)->lru_lock);
 }
 
 static void __activate_page(struct page *page, struct lruvec *lruvec)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index ddb29d813d77..c1c4259b4de5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1976,19 +1976,17 @@ static int current_may_throttle(void)
 				&stat, false);
 
 	spin_lock_irq(&pgdat->lru_lock);
-
 	move_pages_to_lru(lruvec, &page_list);
 
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
-	lru_note_cost(lruvec, file, stat.nr_pageout);
 	item = current_is_kswapd() ? PGSTEAL_KSWAPD : PGSTEAL_DIRECT;
 	if (!cgroup_reclaim(sc))
 		__count_vm_events(item, nr_reclaimed);
 	__count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
 	__count_vm_events(PGSTEAL_ANON + file, nr_reclaimed);
-
 	spin_unlock_irq(&pgdat->lru_lock);
 
+	lru_note_cost(lruvec, file, stat.nr_pageout);
 	mem_cgroup_uncharge_list(&page_list);
 	free_unref_page_list(&page_list);
 
-- 
1.8.3.1


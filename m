Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAAF276747
	for <lists+cgroups@lfdr.de>; Thu, 24 Sep 2020 05:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgIXD2r (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Sep 2020 23:28:47 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:33950 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726908AbgIXD2q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Sep 2020 23:28:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0U9w0Ss1_1600918116;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U9w0Ss1_1600918116)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 24 Sep 2020 11:28:41 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com, kirill@shutemov.name,
        alexander.duyck@gmail.com, rong.a.chen@intel.com, mhocko@suse.com,
        vdavydov.dev@gmail.com, shy828301@gmail.com, aaron.lwe@gmail.com
Subject: [PATCH v19 11/20] mm/lru: move lock into lru_note_cost
Date:   Thu, 24 Sep 2020 11:28:26 +0800
Message-Id: <1600918115-22007-12-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1600918115-22007-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1600918115-22007-1-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We have to move lru_lock into lru_note_cost, since it cycle up on memcg
tree, for future per lruvec lru_lock replace. It's a bit ugly and may
cost a bit more locking, but benefit from multiple memcg locking could
cover the lost.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Acked-by: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/swap.c       | 3 +++
 mm/vmscan.c     | 4 +---
 mm/workingset.c | 2 --
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 4e33873975a6..6a4b00267384 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -268,7 +268,9 @@ void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
 {
 	do {
 		unsigned long lrusize;
+		struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 
+		spin_lock_irq(&pgdat->lru_lock);
 		/* Record cost event */
 		if (file)
 			lruvec->file_cost += nr_pages;
@@ -292,6 +294,7 @@ void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
 			lruvec->file_cost /= 2;
 			lruvec->anon_cost /= 2;
 		}
+		spin_unlock_irq(&pgdat->lru_lock);
 	} while ((lruvec = parent_lruvec(lruvec)));
 }
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 32102e5d354d..656558bbf399 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1971,19 +1971,17 @@ static int current_may_throttle(void)
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
 
diff --git a/mm/workingset.c b/mm/workingset.c
index 92e66113a577..32e24cda1b4f 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -381,9 +381,7 @@ void workingset_refault(struct page *page, void *shadow)
 	if (workingset) {
 		SetPageWorkingset(page);
 		/* XXX: Move to lru_cache_add() when it supports new vs putback */
-		spin_lock_irq(&page_pgdat(page)->lru_lock);
 		lru_note_cost_page(page);
-		spin_unlock_irq(&page_pgdat(page)->lru_lock);
 		inc_lruvec_state(lruvec, WORKINGSET_RESTORE_BASE + file);
 	}
 out:
-- 
1.8.3.1


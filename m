Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDDDE20041F
	for <lists+cgroups@lfdr.de>; Fri, 19 Jun 2020 10:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731438AbgFSIfu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Jun 2020 04:35:50 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:39244 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731608AbgFSIea (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 19 Jun 2020 04:34:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0U01Hlju_1592555664;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U01Hlju_1592555664)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 19 Jun 2020 16:34:24 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
Subject: [PATCH v13 13/18] mm/swap: serialize memcg changes during pagevec_lru_move_fn
Date:   Fri, 19 Jun 2020 16:33:51 +0800
Message-Id: <1592555636-115095-14-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1592555636-115095-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1592555636-115095-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hugh Dickins' found a memcg change bug on original version:
If we want to change the pgdat->lru_lock to memcg's lruvec lock, we have
to serialize mem_cgroup_move_account during pagevec_lru_move_fn. The
possible bad scenario would like:

	cpu 0					cpu 1
lruvec = mem_cgroup_page_lruvec()
					if (!isolate_lru_page())
						mem_cgroup_move_account

spin_lock_irqsave(&lruvec->lru_lock <== wrong lock.

So we need the ClearPageLRU to block isolate_lru_page(), then serialize
the memcg change here.

Reported-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/swap.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 7ff9aa6a716a..cebb25ddeee7 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -203,7 +203,7 @@ int get_kernel_page(unsigned long start, int write, struct page **pages)
 EXPORT_SYMBOL_GPL(get_kernel_page);
 
 static void pagevec_lru_move_fn(struct pagevec *pvec,
-	void (*move_fn)(struct page *page, struct lruvec *lruvec))
+	void (*move_fn)(struct page *page, struct lruvec *lruvec), bool add)
 {
 	int i;
 	struct pglist_data *pgdat = NULL;
@@ -221,8 +221,15 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
 			spin_lock_irqsave(&pgdat->lru_lock, flags);
 		}
 
+		/* new page add to lru or page moving between lru */
+		if (!add && !TestClearPageLRU(page))
+			continue;
+
 		lruvec = mem_cgroup_page_lruvec(page, pgdat);
 		(*move_fn)(page, lruvec);
+
+		if (!add)
+			SetPageLRU(page);
 	}
 	if (pgdat)
 		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
@@ -259,7 +266,7 @@ void rotate_reclaimable_page(struct page *page)
 		local_lock_irqsave(&lru_rotate.lock, flags);
 		pvec = this_cpu_ptr(&lru_rotate.pvec);
 		if (!pagevec_add(pvec, page) || PageCompound(page))
-			pagevec_lru_move_fn(pvec, pagevec_move_tail_fn);
+			pagevec_lru_move_fn(pvec, pagevec_move_tail_fn, false);
 		local_unlock_irqrestore(&lru_rotate.lock, flags);
 	}
 }
@@ -325,7 +332,7 @@ static void activate_page_drain(int cpu)
 	struct pagevec *pvec = &per_cpu(lru_pvecs.activate_page, cpu);
 
 	if (pagevec_count(pvec))
-		pagevec_lru_move_fn(pvec, __activate_page);
+		pagevec_lru_move_fn(pvec, __activate_page, false);
 }
 
 static bool need_activate_page_drain(int cpu)
@@ -343,7 +350,7 @@ void activate_page(struct page *page)
 		pvec = this_cpu_ptr(&lru_pvecs.activate_page);
 		get_page(page);
 		if (!pagevec_add(pvec, page) || PageCompound(page))
-			pagevec_lru_move_fn(pvec, __activate_page);
+			pagevec_lru_move_fn(pvec, __activate_page, false);
 		local_unlock(&lru_pvecs.lock);
 	}
 }
@@ -620,21 +627,21 @@ void lru_add_drain_cpu(int cpu)
 
 		/* No harm done if a racing interrupt already did this */
 		local_lock_irqsave(&lru_rotate.lock, flags);
-		pagevec_lru_move_fn(pvec, pagevec_move_tail_fn);
+		pagevec_lru_move_fn(pvec, pagevec_move_tail_fn, false);
 		local_unlock_irqrestore(&lru_rotate.lock, flags);
 	}
 
 	pvec = &per_cpu(lru_pvecs.lru_deactivate_file, cpu);
 	if (pagevec_count(pvec))
-		pagevec_lru_move_fn(pvec, lru_deactivate_file_fn);
+		pagevec_lru_move_fn(pvec, lru_deactivate_file_fn, false);
 
 	pvec = &per_cpu(lru_pvecs.lru_deactivate, cpu);
 	if (pagevec_count(pvec))
-		pagevec_lru_move_fn(pvec, lru_deactivate_fn);
+		pagevec_lru_move_fn(pvec, lru_deactivate_fn, false);
 
 	pvec = &per_cpu(lru_pvecs.lru_lazyfree, cpu);
 	if (pagevec_count(pvec))
-		pagevec_lru_move_fn(pvec, lru_lazyfree_fn);
+		pagevec_lru_move_fn(pvec, lru_lazyfree_fn, false);
 
 	activate_page_drain(cpu);
 }
@@ -663,7 +670,7 @@ void deactivate_file_page(struct page *page)
 		pvec = this_cpu_ptr(&lru_pvecs.lru_deactivate_file);
 
 		if (!pagevec_add(pvec, page) || PageCompound(page))
-			pagevec_lru_move_fn(pvec, lru_deactivate_file_fn);
+			pagevec_lru_move_fn(pvec, lru_deactivate_file_fn, false);
 		local_unlock(&lru_pvecs.lock);
 	}
 }
@@ -685,7 +692,7 @@ void deactivate_page(struct page *page)
 		pvec = this_cpu_ptr(&lru_pvecs.lru_deactivate);
 		get_page(page);
 		if (!pagevec_add(pvec, page) || PageCompound(page))
-			pagevec_lru_move_fn(pvec, lru_deactivate_fn);
+			pagevec_lru_move_fn(pvec, lru_deactivate_fn, false);
 		local_unlock(&lru_pvecs.lock);
 	}
 }
@@ -707,7 +714,7 @@ void mark_page_lazyfree(struct page *page)
 		pvec = this_cpu_ptr(&lru_pvecs.lru_lazyfree);
 		get_page(page);
 		if (!pagevec_add(pvec, page) || PageCompound(page))
-			pagevec_lru_move_fn(pvec, lru_lazyfree_fn);
+			pagevec_lru_move_fn(pvec, lru_lazyfree_fn, false);
 		local_unlock(&lru_pvecs.lock);
 	}
 }
@@ -975,7 +982,7 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
  */
 void __pagevec_lru_add(struct pagevec *pvec)
 {
-	pagevec_lru_move_fn(pvec, __pagevec_lru_add_fn);
+	pagevec_lru_move_fn(pvec, __pagevec_lru_add_fn, true);
 }
 
 /**
-- 
1.8.3.1


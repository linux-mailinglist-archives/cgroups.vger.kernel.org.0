Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8AC216C2D
	for <lists+cgroups@lfdr.de>; Tue,  7 Jul 2020 13:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgGGLsN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 Jul 2020 07:48:13 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:51824 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728036AbgGGLsM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 7 Jul 2020 07:48:12 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07425;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0U20joWQ_1594122436;
Received: from alexshi-test.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U20joWQ_1594122436)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 07 Jul 2020 19:47:21 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
Cc:     Alex Shi <alex.shi@linux.alibaba.com>
Subject: [PATCH v15 10/21] mm/lru: move lru_lock holding in func lru_note_cost_page
Date:   Tue,  7 Jul 2020 19:46:42 +0800
Message-Id: <1594122412-28057-11-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1594122412-28057-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1594122412-28057-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

It's a clean up patch w/o function changes.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/memory.c     | 3 ---
 mm/swap.c       | 2 ++
 mm/swap_state.c | 2 --
 mm/workingset.c | 2 --
 4 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 87ec87cdc1ff..dafc5585517e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3150,10 +3150,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 				 * XXX: Move to lru_cache_add() when it
 				 * supports new vs putback
 				 */
-				spin_lock_irq(&page_pgdat(page)->lru_lock);
 				lru_note_cost_page(page);
-				spin_unlock_irq(&page_pgdat(page)->lru_lock);
-
 				lru_cache_add(page);
 				swap_readpage(page, true);
 			}
diff --git a/mm/swap.c b/mm/swap.c
index dc8b02cdddcb..b88ca630db70 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -298,8 +298,10 @@ void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
 
 void lru_note_cost_page(struct page *page)
 {
+	spin_lock_irq(&page_pgdat(page)->lru_lock);
 	lru_note_cost(mem_cgroup_page_lruvec(page, page_pgdat(page)),
 		      page_is_file_lru(page), hpage_nr_pages(page));
+	spin_unlock_irq(&page_pgdat(page)->lru_lock);
 }
 
 static void __activate_page(struct page *page, struct lruvec *lruvec)
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 05889e8e3c97..080be52db6a8 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -440,9 +440,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	}
 
 	/* XXX: Move to lru_cache_add() when it supports new vs putback */
-	spin_lock_irq(&page_pgdat(page)->lru_lock);
 	lru_note_cost_page(page);
-	spin_unlock_irq(&page_pgdat(page)->lru_lock);
 
 	/* Caller will initiate read into locked page */
 	SetPageWorkingset(page);
diff --git a/mm/workingset.c b/mm/workingset.c
index 50b7937bab32..337d5b9ad132 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -372,9 +372,7 @@ void workingset_refault(struct page *page, void *shadow)
 	if (workingset) {
 		SetPageWorkingset(page);
 		/* XXX: Move to lru_cache_add() when it supports new vs putback */
-		spin_lock_irq(&page_pgdat(page)->lru_lock);
 		lru_note_cost_page(page);
-		spin_unlock_irq(&page_pgdat(page)->lru_lock);
 		inc_lruvec_state(lruvec, WORKINGSET_RESTORE);
 	}
 out:
-- 
1.8.3.1


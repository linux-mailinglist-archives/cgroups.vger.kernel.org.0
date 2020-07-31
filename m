Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F094233DB7
	for <lists+cgroups@lfdr.de>; Fri, 31 Jul 2020 05:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731199AbgGaDe4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Jul 2020 23:34:56 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:45324 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730820AbgGaDez (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Jul 2020 23:34:55 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U4HxHq._1596166492;
Received: from aliy8.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U4HxHq._1596166492)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 31 Jul 2020 11:34:53 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/memcg: remove useless check on page->mem_cgroup
Date:   Fri, 31 Jul 2020 11:34:40 +0800
Message-Id: <1596166480-22814-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Since readahead page will be charged on memcg too. We don't need to
check this exception now. Rmove them is safe as all user pages are
charged before use.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/memcontrol.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e84c2b5596f2..9e44ae22d591 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1322,12 +1322,7 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgd
 	}
 
 	memcg = page->mem_cgroup;
-	/*
-	 * Swapcache readahead pages are added to the LRU - and
-	 * possibly migrated - before they are charged.
-	 */
-	if (!memcg)
-		memcg = root_mem_cgroup;
+	VM_BUG_ON_PAGE(!memcg, page);
 
 	mz = mem_cgroup_page_nodeinfo(memcg, page);
 	lruvec = &mz->lruvec;
@@ -6897,10 +6892,8 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 	if (newpage->mem_cgroup)
 		return;
 
-	/* Swapcache readahead pages can get replaced before being charged */
 	memcg = oldpage->mem_cgroup;
-	if (!memcg)
-		return;
+	VM_BUG_ON_PAGE(!memcg, oldpage);
 
 	/* Force-charge the new page. The old one will be freed soon */
 	nr_pages = thp_nr_pages(newpage);
@@ -7094,10 +7087,7 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 		return;
 
 	memcg = page->mem_cgroup;
-
-	/* Readahead page, never charged */
-	if (!memcg)
-		return;
+	VM_BUG_ON_PAGE(!memcg, page);
 
 	/*
 	 * In case the memcg owning these pages has been offlined and doesn't
@@ -7158,10 +7148,7 @@ int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
 		return 0;
 
 	memcg = page->mem_cgroup;
-
-	/* Readahead page, never charged */
-	if (!memcg)
-		return 0;
+	VM_BUG_ON_PAGE(!memcg, page);
 
 	if (!entry.val) {
 		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
-- 
1.8.3.1


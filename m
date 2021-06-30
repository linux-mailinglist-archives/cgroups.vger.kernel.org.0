Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE673B7C5E
	for <lists+cgroups@lfdr.de>; Wed, 30 Jun 2021 06:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhF3EHU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Jun 2021 00:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhF3EHU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Jun 2021 00:07:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF41C061760
        for <cgroups@vger.kernel.org>; Tue, 29 Jun 2021 21:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=MPvBRvoA+lVjGYcBT1v6tGu4QtgMR9ceT5UjEW39UbU=; b=uvP2jhH1pd1n+xqgse8zq2VjRM
        bI5UKTYOqu+MvrP1XastqesPZxl+wtn/9e8o/iO0gQ/vAzmnbUPczl2z/m4KsyR8+TG1F6qJIH5NZ
        hYFcs3vjznfGR8mo/UPM9bPvFwWuSPvgRMBJqhtL7QhQgaqW2iWQPTsJiqd1MJwTeWX0tY2m2d1X5
        ivfxnRstvAx5aLn64MT0K3LrFOi2d0gKV3Wiz06idtCwFVt1w3gpFSTWP+HKdbXB0giVoW+NesqV5
        03tZJ38K6dcd1RJSKw8di3c2EHha9PQF9ECMyt7mK+F0GTnK7lCapcQleyCrMIHqgjEhObnacPOQO
        4IMoHV/A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyRS2-004qv0-Iy; Wed, 30 Jun 2021 04:03:59 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: [PATCH v3 05/18] mm/memcg: Convert memcg_check_events to take a node ID
Date:   Wed, 30 Jun 2021 05:00:21 +0100
Message-Id: <20210630040034.1155892-6-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210630040034.1155892-1-willy@infradead.org>
References: <20210630040034.1155892-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

memcg_check_events only uses the page's nid, so call page_to_nid in the
callers to make the folio conversion easier.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memcontrol.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 29fdb70dca42..5d143d46a8a4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -846,7 +846,7 @@ static bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
  * Check events in order.
  *
  */
-static void memcg_check_events(struct mem_cgroup *memcg, struct page *page)
+static void memcg_check_events(struct mem_cgroup *memcg, int nid)
 {
 	/* threshold event is triggered in finer grain than soft limit */
 	if (unlikely(mem_cgroup_event_ratelimit(memcg,
@@ -857,7 +857,7 @@ static void memcg_check_events(struct mem_cgroup *memcg, struct page *page)
 						MEM_CGROUP_TARGET_SOFTLIMIT);
 		mem_cgroup_threshold(memcg);
 		if (unlikely(do_softlimit))
-			mem_cgroup_update_tree(memcg, page_to_nid(page));
+			mem_cgroup_update_tree(memcg, nid);
 	}
 }
 
@@ -5573,7 +5573,7 @@ static int mem_cgroup_move_account(struct page *page,
 	struct lruvec *from_vec, *to_vec;
 	struct pglist_data *pgdat;
 	unsigned int nr_pages = compound ? thp_nr_pages(page) : 1;
-	int ret;
+	int nid, ret;
 
 	VM_BUG_ON(from == to);
 	VM_BUG_ON_PAGE(PageLRU(page), page);
@@ -5662,12 +5662,13 @@ static int mem_cgroup_move_account(struct page *page,
 	__unlock_page_memcg(from);
 
 	ret = 0;
+	nid = page_to_nid(page);
 
 	local_irq_disable();
 	mem_cgroup_charge_statistics(to, nr_pages);
-	memcg_check_events(to, page);
+	memcg_check_events(to, nid);
 	mem_cgroup_charge_statistics(from, -nr_pages);
-	memcg_check_events(from, page);
+	memcg_check_events(from, nid);
 	local_irq_enable();
 out_unlock:
 	unlock_page(page);
@@ -6688,7 +6689,7 @@ static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
 
 	local_irq_disable();
 	mem_cgroup_charge_statistics(memcg, nr_pages);
-	memcg_check_events(memcg, page);
+	memcg_check_events(memcg, page_to_nid(page));
 	local_irq_enable();
 out:
 	return ret;
@@ -6796,7 +6797,7 @@ struct uncharge_gather {
 	unsigned long nr_memory;
 	unsigned long pgpgout;
 	unsigned long nr_kmem;
-	struct page *dummy_page;
+	int nid;
 };
 
 static inline void uncharge_gather_clear(struct uncharge_gather *ug)
@@ -6820,7 +6821,7 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 	local_irq_save(flags);
 	__count_memcg_events(ug->memcg, PGPGOUT, ug->pgpgout);
 	__this_cpu_add(ug->memcg->vmstats_percpu->nr_page_events, ug->nr_memory);
-	memcg_check_events(ug->memcg, ug->dummy_page);
+	memcg_check_events(ug->memcg, ug->nid);
 	local_irq_restore(flags);
 
 	/* drop reference from uncharge_page */
@@ -6861,7 +6862,7 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 			uncharge_gather_clear(ug);
 		}
 		ug->memcg = memcg;
-		ug->dummy_page = page;
+		ug->nid = page_to_nid(page);
 
 		/* pairs with css_put in uncharge_batch */
 		css_get(&memcg->css);
@@ -6979,7 +6980,7 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 
 	local_irq_save(flags);
 	mem_cgroup_charge_statistics(memcg, nr_pages);
-	memcg_check_events(memcg, newpage);
+	memcg_check_events(memcg, page_to_nid(newpage));
 	local_irq_restore(flags);
 }
 
@@ -7209,7 +7210,7 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 	 */
 	VM_BUG_ON(!irqs_disabled());
 	mem_cgroup_charge_statistics(memcg, -nr_entries);
-	memcg_check_events(memcg, page);
+	memcg_check_events(memcg, page_to_nid(page));
 
 	css_put(&memcg->css);
 }
-- 
2.30.2


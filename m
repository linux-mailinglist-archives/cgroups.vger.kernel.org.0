Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C888B3B7C65
	for <lists+cgroups@lfdr.de>; Wed, 30 Jun 2021 06:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhF3EJw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Jun 2021 00:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhF3EJw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Jun 2021 00:09:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5099AC061760
        for <cgroups@vger.kernel.org>; Tue, 29 Jun 2021 21:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=BjFTpfwTcvz8MB4hey3lD2XB4nBfnZtvn9hoGEU7psY=; b=LhcrdRX8xHPlCZzxWD5rgHNQLd
        7RTIJiPMacDiMun10jtFkRbyaEkpzow5sMxM6qGhikcFkuPAATjrwgrFRzbppUmCySfcvM+pXj23P
        2RlWftAPIjXeEFiuy0cIoqKeR2SdibjNjZB0eH3B+IcuQ42Pw2Y2za20GQnawP0fzwzL/z/VBvuAq
        uQhlXvycqBr9s9YEDhS98nFcK7Ii4sNPP1Ob6GgBBdYj6E4BnrqlCUtQLwQF2x522STDwMbycFcFt
        xqAe87EyGlgno5lX8pCoIqhk8zDhmyEOq050WAGeguJw1CmKMuzR4wFqQHXsT1yMzrNUGSlZMpHoG
        oayCqTSA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyRUP-004r8f-Ok; Wed, 30 Jun 2021 04:06:26 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: [PATCH v3 09/18] mm/memcg: Convert uncharge_page() to uncharge_folio()
Date:   Wed, 30 Jun 2021 05:00:25 +0100
Message-Id: <20210630040034.1155892-10-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210630040034.1155892-1-willy@infradead.org>
References: <20210630040034.1155892-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Use a folio rather than a page to ensure that we're only operating on
base or head pages, and not tail pages.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memcontrol.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1dc02ecd3257..21b791935957 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6827,24 +6827,23 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 	memcg_check_events(ug->memcg, ug->nid);
 	local_irq_restore(flags);
 
-	/* drop reference from uncharge_page */
+	/* drop reference from uncharge_folio */
 	css_put(&ug->memcg->css);
 }
 
-static void uncharge_page(struct page *page, struct uncharge_gather *ug)
+static void uncharge_folio(struct folio *folio, struct uncharge_gather *ug)
 {
-	struct folio *folio = page_folio(page);
 	unsigned long nr_pages;
 	struct mem_cgroup *memcg;
 	struct obj_cgroup *objcg;
-	bool use_objcg = PageMemcgKmem(page);
+	bool use_objcg = folio_memcg_kmem(folio);
 
-	VM_BUG_ON_PAGE(PageLRU(page), page);
+	VM_BUG_ON_FOLIO(folio_lru(folio), folio);
 
 	/*
 	 * Nobody should be changing or seriously looking at
-	 * page memcg or objcg at this point, we have fully
-	 * exclusive access to the page.
+	 * folio memcg or objcg at this point, we have fully
+	 * exclusive access to the folio.
 	 */
 	if (use_objcg) {
 		objcg = __folio_objcg(folio);
@@ -6866,19 +6865,19 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 			uncharge_gather_clear(ug);
 		}
 		ug->memcg = memcg;
-		ug->nid = page_to_nid(page);
+		ug->nid = folio_nid(folio);
 
 		/* pairs with css_put in uncharge_batch */
 		css_get(&memcg->css);
 	}
 
-	nr_pages = compound_nr(page);
+	nr_pages = folio_nr_pages(folio);
 
 	if (use_objcg) {
 		ug->nr_memory += nr_pages;
 		ug->nr_kmem += nr_pages;
 
-		page->memcg_data = 0;
+		folio->memcg_data = 0;
 		obj_cgroup_put(objcg);
 	} else {
 		/* LRU pages aren't accounted at the root level */
@@ -6886,7 +6885,7 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 			ug->nr_memory += nr_pages;
 		ug->pgpgout++;
 
-		page->memcg_data = 0;
+		folio->memcg_data = 0;
 	}
 
 	css_put(&memcg->css);
@@ -6910,7 +6909,7 @@ void mem_cgroup_uncharge(struct page *page)
 		return;
 
 	uncharge_gather_clear(&ug);
-	uncharge_page(page, &ug);
+	uncharge_folio(page_folio(page), &ug);
 	uncharge_batch(&ug);
 }
 
@@ -6924,14 +6923,14 @@ void mem_cgroup_uncharge(struct page *page)
 void mem_cgroup_uncharge_list(struct list_head *page_list)
 {
 	struct uncharge_gather ug;
-	struct page *page;
+	struct folio *folio;
 
 	if (mem_cgroup_disabled())
 		return;
 
 	uncharge_gather_clear(&ug);
-	list_for_each_entry(page, page_list, lru)
-		uncharge_page(page, &ug);
+	list_for_each_entry(folio, page_list, lru)
+		uncharge_folio(folio, &ug);
 	if (ug.memcg)
 		uncharge_batch(&ug);
 }
-- 
2.30.2


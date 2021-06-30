Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9F43B7C60
	for <lists+cgroups@lfdr.de>; Wed, 30 Jun 2021 06:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbhF3EIr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Jun 2021 00:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhF3EIr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Jun 2021 00:08:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31ABCC061760
        for <cgroups@vger.kernel.org>; Tue, 29 Jun 2021 21:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=WeFvvQ3KBB1ENMOJ6f7Rya8a7gf7U8HCBtx5RYCkXSI=; b=nkJu5V1G++weobkGUK8VPbe6Il
        kHIIIWXJl9U4sT99L6Dc6dg0ogtHumvfiYsBTr3T68ycJIBUewoBwOSLBOdPJyJ+2EYNZ0lRPKrHc
        HyWsoHw/gtA8ugWteFXp6GFJyRobvmmveV2j9bAro+YlgI6BbGgBSQodvQBSK5XhdpxpUrnF7B8pg
        M6wSI99jxh1KiAY5/FLXbBjhZQfKpqYB11Si6Fr+mGpYLjY28WL/SkyPUeh2ie8DzkWpgRNuiImHP
        X6E5+AZk/ELvbXZyQfs6AQxrmgiPsrRkyee77wUqz673EIZHlyxPNhmG3Wy15fZtWwj/NWH6OY0gx
        04kRg+wQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyRT3-004r4f-NE; Wed, 30 Jun 2021 04:05:04 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Michal Hocko <mhocko@suse.com>
Subject: [PATCH v3 07/18] mm/memcg: Convert commit_charge() to take a folio
Date:   Wed, 30 Jun 2021 05:00:23 +0100
Message-Id: <20210630040034.1155892-8-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210630040034.1155892-1-willy@infradead.org>
References: <20210630040034.1155892-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The memcg_data is only set on the head page, so enforce that by
typing it as a folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/memcontrol.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f369bbaf584b..727bd578ca7d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2764,9 +2764,9 @@ static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
 }
 #endif
 
-static void commit_charge(struct page *page, struct mem_cgroup *memcg)
+static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
 {
-	VM_BUG_ON_PAGE(page_memcg(page), page);
+	VM_BUG_ON_FOLIO(folio_memcg(folio), folio);
 	/*
 	 * Any of the following ensures page's memcg stability:
 	 *
@@ -2775,7 +2775,7 @@ static void commit_charge(struct page *page, struct mem_cgroup *memcg)
 	 * - lock_page_memcg()
 	 * - exclusive reference
 	 */
-	page->memcg_data = (unsigned long)memcg;
+	folio->memcg_data = (unsigned long)memcg;
 }
 
 static struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
@@ -6679,7 +6679,8 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
 			       gfp_t gfp)
 {
-	unsigned int nr_pages = thp_nr_pages(page);
+	struct folio *folio = page_folio(page);
+	unsigned int nr_pages = folio_nr_pages(folio);
 	int ret;
 
 	ret = try_charge(memcg, gfp, nr_pages);
@@ -6687,7 +6688,7 @@ static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
 		goto out;
 
 	css_get(&memcg->css);
-	commit_charge(page, memcg);
+	commit_charge(folio, memcg);
 
 	local_irq_disable();
 	mem_cgroup_charge_statistics(memcg, nr_pages);
@@ -6947,21 +6948,21 @@ void mem_cgroup_uncharge_list(struct list_head *page_list)
  */
 void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 {
+	struct folio *newfolio = page_folio(newpage);
 	struct mem_cgroup *memcg;
-	unsigned int nr_pages;
+	unsigned int nr_pages = folio_nr_pages(newfolio);
 	unsigned long flags;
 
 	VM_BUG_ON_PAGE(!PageLocked(oldpage), oldpage);
-	VM_BUG_ON_PAGE(!PageLocked(newpage), newpage);
-	VM_BUG_ON_PAGE(PageAnon(oldpage) != PageAnon(newpage), newpage);
-	VM_BUG_ON_PAGE(PageTransHuge(oldpage) != PageTransHuge(newpage),
-		       newpage);
+	VM_BUG_ON_FOLIO(!folio_locked(newfolio), newfolio);
+	VM_BUG_ON_FOLIO(PageAnon(oldpage) != folio_anon(newfolio), newfolio);
+	VM_BUG_ON_FOLIO(compound_nr(oldpage) != nr_pages, newfolio);
 
 	if (mem_cgroup_disabled())
 		return;
 
 	/* Page cache replacement: new page already charged? */
-	if (page_memcg(newpage))
+	if (folio_memcg(newfolio))
 		return;
 
 	memcg = page_memcg(oldpage);
@@ -6970,8 +6971,6 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 		return;
 
 	/* Force-charge the new page. The old one will be freed soon */
-	nr_pages = thp_nr_pages(newpage);
-
 	if (!mem_cgroup_is_root(memcg)) {
 		page_counter_charge(&memcg->memory, nr_pages);
 		if (do_memsw_account())
@@ -6979,7 +6978,7 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 	}
 
 	css_get(&memcg->css);
-	commit_charge(newpage, memcg);
+	commit_charge(newfolio, memcg);
 
 	local_irq_save(flags);
 	mem_cgroup_charge_statistics(memcg, nr_pages);
-- 
2.30.2


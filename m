Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACD03B7C72
	for <lists+cgroups@lfdr.de>; Wed, 30 Jun 2021 06:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbhF3EOA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Jun 2021 00:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhF3EOA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Jun 2021 00:14:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56143C061760
        for <cgroups@vger.kernel.org>; Tue, 29 Jun 2021 21:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=o6pKETfaUH00IzELahKAqvYiyZSdREp3JjqSImxgqHs=; b=v6eo7OkRNK0b1zjWIbAX/JOtzm
        5ym+SCJfzbikRiR1bQbmwq/9IGTB+sfJDFL6IOm5nY6xeIehRR//kPCBMkhV1ZqrXey1BEudgY+kD
        JEje6Y7MiYJeDWj1SsaedR/t06oiddeSGC1fAqw55HDsmiCQ9YZh1SYvGmAoTz5q+PQ/PSGrUPm1R
        MBD/vCHOOg04jqveeSxVaT2mqzukv2gnUBZiqWFAg518nn0Sy/DDdu5ab8EwtMOOjz9sLEzo49cYI
        eM5nupiadJETh0G6Kg0OcSB/XpSxfGtLdO5UwgUX9wEJAZWEMar7F2R/QzRJ1DgRkzHGZatP5MphK
        Mf5bXsKg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyRYb-004rNk-4i; Wed, 30 Jun 2021 04:10:51 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: [PATCH v3 15/18] mm/memcg: Add mem_cgroup_folio_lruvec()
Date:   Wed, 30 Jun 2021 05:00:31 +0100
Message-Id: <20210630040034.1155892-16-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210630040034.1155892-1-willy@infradead.org>
References: <20210630040034.1155892-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This is the folio equivalent of mem_cgroup_page_lruvec().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/memcontrol.h | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 279ea2640365..a7e1ccbc7ed6 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -752,18 +752,17 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
 }
 
 /**
- * mem_cgroup_page_lruvec - return lruvec for isolating/putting an LRU page
- * @page: the page
+ * mem_cgroup_folio_lruvec - return lruvec for isolating/putting an LRU folio
+ * @folio: Pointer to the folio.
  *
- * This function relies on page->mem_cgroup being stable.
+ * This function relies on folio->mem_cgroup being stable.
  */
-static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page)
+static inline struct lruvec *mem_cgroup_folio_lruvec(struct folio *folio)
 {
-	pg_data_t *pgdat = page_pgdat(page);
-	struct mem_cgroup *memcg = page_memcg(page);
+	struct mem_cgroup *memcg = folio_memcg(folio);
 
-	VM_WARN_ON_ONCE_PAGE(!memcg && !mem_cgroup_disabled(), page);
-	return mem_cgroup_lruvec(memcg, pgdat);
+	VM_WARN_ON_ONCE_FOLIO(!memcg && !mem_cgroup_disabled(), folio);
+	return mem_cgroup_lruvec(memcg, folio_pgdat(folio));
 }
 
 struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p);
@@ -1222,10 +1221,9 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
 	return &pgdat->__lruvec;
 }
 
-static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page)
+static inline struct lruvec *mem_cgroup_folio_lruvec(struct folio *folio)
 {
-	pg_data_t *pgdat = page_pgdat(page);
-
+	struct pglist_data *pgdat = folio_pgdat(folio);
 	return &pgdat->__lruvec;
 }
 
@@ -1485,6 +1483,11 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 }
 #endif /* CONFIG_MEMCG */
 
+static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page)
+{
+	return mem_cgroup_folio_lruvec(page_folio(page));
+}
+
 static inline void __inc_lruvec_kmem_state(void *p, enum node_stat_item idx)
 {
 	__mod_lruvec_kmem_state(p, idx, 1);
-- 
2.30.2


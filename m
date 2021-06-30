Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B723B7C6E
	for <lists+cgroups@lfdr.de>; Wed, 30 Jun 2021 06:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbhF3EMT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Jun 2021 00:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhF3EMS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Jun 2021 00:12:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDBFC061760
        for <cgroups@vger.kernel.org>; Tue, 29 Jun 2021 21:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XpL9mSB1/nC9mL/c7VMPmLAgXM0YlVQrzvZC5z/pLHE=; b=ossPoxGa6GiSdoiW5T49jOjf5+
        YfBKUKY1L/d9XQwsjT0lHFMUvUUFqo28fDYTCPynU2ZOCz+hDFC/PR41RPIqP/HLbxRLrxhPC77UZ
        5g2L5zJFADW1YIh4tConLlic8WB0C/PlyoD7bmoM89OWD3wuBtlXRfbJ01qZ4CII2mfhm/rXZIsvI
        dfRZV1URS2RjeEcyI8O80M2MoqxMtqGiiQhSPCLt8ohVIxA40sBUivAi3hapKt1Rk5IHRyWKB+QIP
        Q1FAkGBXBdbiCX9Wb+gKvsQuqlL9w8R0xt4rzvrNIyZmqzEZW1fywrONoEDItpzsCivVaACQkIcGF
        r/YG+MrQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyRWI-004rHg-Ry; Wed, 30 Jun 2021 04:08:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 12/18] mm/memcg: Convert mem_cgroup_track_foreign_dirty_slowpath() to folio
Date:   Wed, 30 Jun 2021 05:00:28 +0100
Message-Id: <20210630040034.1155892-13-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210630040034.1155892-1-willy@infradead.org>
References: <20210630040034.1155892-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The page was only being used for the memcg and to gather trace
information, so this is a simple conversion.  The only caller of
mem_cgroup_track_foreign_dirty() will be converted to folios in a later
patch, so doing this now makes that patch simpler.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/memcontrol.h       | 7 ++++---
 include/trace/events/writeback.h | 8 ++++----
 mm/memcontrol.c                  | 6 +++---
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 2c57a405acd2..ef79f9c0b296 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1556,17 +1556,18 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 			 unsigned long *pheadroom, unsigned long *pdirty,
 			 unsigned long *pwriteback);
 
-void mem_cgroup_track_foreign_dirty_slowpath(struct page *page,
+void mem_cgroup_track_foreign_dirty_slowpath(struct folio *folio,
 					     struct bdi_writeback *wb);
 
 static inline void mem_cgroup_track_foreign_dirty(struct page *page,
 						  struct bdi_writeback *wb)
 {
+	struct folio *folio = page_folio(page);
 	if (mem_cgroup_disabled())
 		return;
 
-	if (unlikely(&page_memcg(page)->css != wb->memcg_css))
-		mem_cgroup_track_foreign_dirty_slowpath(page, wb);
+	if (unlikely(&folio_memcg(folio)->css != wb->memcg_css))
+		mem_cgroup_track_foreign_dirty_slowpath(folio, wb);
 }
 
 void mem_cgroup_flush_foreign(struct bdi_writeback *wb);
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 1efa463c4979..80b24801bbf7 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -235,9 +235,9 @@ TRACE_EVENT(inode_switch_wbs,
 
 TRACE_EVENT(track_foreign_dirty,
 
-	TP_PROTO(struct page *page, struct bdi_writeback *wb),
+	TP_PROTO(struct folio *folio, struct bdi_writeback *wb),
 
-	TP_ARGS(page, wb),
+	TP_ARGS(folio, wb),
 
 	TP_STRUCT__entry(
 		__array(char,		name, 32)
@@ -249,7 +249,7 @@ TRACE_EVENT(track_foreign_dirty,
 	),
 
 	TP_fast_assign(
-		struct address_space *mapping = page_mapping(page);
+		struct address_space *mapping = folio_mapping(folio);
 		struct inode *inode = mapping ? mapping->host : NULL;
 
 		strscpy_pad(__entry->name, bdi_dev_name(wb->bdi), 32);
@@ -257,7 +257,7 @@ TRACE_EVENT(track_foreign_dirty,
 		__entry->ino		= inode ? inode->i_ino : 0;
 		__entry->memcg_id	= wb->memcg_css->id;
 		__entry->cgroup_ino	= __trace_wb_assign_cgroup(wb);
-		__entry->page_cgroup_ino = cgroup_ino(page_memcg(page)->css.cgroup);
+		__entry->page_cgroup_ino = cgroup_ino(folio_memcg(folio)->css.cgroup);
 	),
 
 	TP_printk("bdi %s[%llu]: ino=%lu memcg_id=%u cgroup_ino=%lu page_cgroup_ino=%lu",
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4ce2f2eb81d8..b925bdce0c6e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4566,17 +4566,17 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
  * As being wrong occasionally doesn't matter, updates and accesses to the
  * records are lockless and racy.
  */
-void mem_cgroup_track_foreign_dirty_slowpath(struct page *page,
+void mem_cgroup_track_foreign_dirty_slowpath(struct folio *folio,
 					     struct bdi_writeback *wb)
 {
-	struct mem_cgroup *memcg = page_memcg(page);
+	struct mem_cgroup *memcg = folio_memcg(folio);
 	struct memcg_cgwb_frn *frn;
 	u64 now = get_jiffies_64();
 	u64 oldest_at = now;
 	int oldest = -1;
 	int i;
 
-	trace_track_foreign_dirty(page, wb);
+	trace_track_foreign_dirty(folio, wb);
 
 	/*
 	 * Pick the slot to use.  If there is already a slot for @wb, keep
-- 
2.30.2


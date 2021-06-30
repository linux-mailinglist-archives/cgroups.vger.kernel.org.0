Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E2A3B7C74
	for <lists+cgroups@lfdr.de>; Wed, 30 Jun 2021 06:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhF3EPF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Jun 2021 00:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhF3EPE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Jun 2021 00:15:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B309C061760
        for <cgroups@vger.kernel.org>; Tue, 29 Jun 2021 21:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=k2cIxuyIWNq/4pAHuKjXPfaEbxUqkyWNYHWDk+v+iO4=; b=CqBPJcxFJ0HP3oRMWS9y2/Spj+
        kAIZV8s2nVejVxTxIvnacW3NYPMIPlrBZWZaA+5VpWEQeJvlsUvVowI4XnWvGClWkUPDh7RfbXmvj
        bZPKRrbd+eh1tVy3xrHua2/s3X/y/Ofn+mAALk3BrcfjB4Nq3ezAHJqFVf8aVcuJgp/ZhQE9Jrqv5
        0rx9Gxbmrp2wG5T+SBCuztQeBRwkwOS4f696HjjCSqa+LgC0iUuw2nWA+tCbdpQgWQIBMkwx2IZfy
        mYufz88FocyF5ihPH2TNDg1PGVkzH7Z9HrDWwNi/EcRrNl0obQV6MVUrFXZPJQIhADYFgXQx9BMlq
        YJ14X0QA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyRZa-004rSI-Kk; Wed, 30 Jun 2021 04:11:49 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: [PATCH v3 17/18] mm/memcg: Add folio_lruvec_relock_irq() and folio_lruvec_relock_irqsave()
Date:   Wed, 30 Jun 2021 05:00:33 +0100
Message-Id: <20210630040034.1155892-18-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210630040034.1155892-1-willy@infradead.org>
References: <20210630040034.1155892-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

These are the folio equivalents of relock_page_lruvec_irq() and
folio_lruvec_relock_irqsave(), which are retained as compatibility wrappers.
Also convert lruvec_holds_page_lru_lock() to folio_lruvec_holds_lru_lock().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/memcontrol.h | 31 ++++++++++++++++++++++---------
 mm/vmscan.c                |  2 +-
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index b21a77669277..e6b5e8fbf770 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1545,40 +1545,53 @@ static inline void unlock_page_lruvec_irqrestore(struct lruvec *lruvec,
 }
 
 /* Test requires a stable page->memcg binding, see page_memcg() */
-static inline bool page_matches_lruvec(struct page *page, struct lruvec *lruvec)
+static inline bool folio_matches_lruvec(struct folio *folio,
+		struct lruvec *lruvec)
 {
-	return lruvec_pgdat(lruvec) == page_pgdat(page) &&
-	       lruvec_memcg(lruvec) == page_memcg(page);
+	return lruvec_pgdat(lruvec) == folio_pgdat(folio) &&
+	       lruvec_memcg(lruvec) == folio_memcg(folio);
 }
 
 /* Don't lock again iff page's lruvec locked */
-static inline struct lruvec *relock_page_lruvec_irq(struct page *page,
+static inline struct lruvec *folio_lruvec_relock_irq(struct folio *folio,
 		struct lruvec *locked_lruvec)
 {
 	if (locked_lruvec) {
-		if (page_matches_lruvec(page, locked_lruvec))
+		if (folio_matches_lruvec(folio, locked_lruvec))
 			return locked_lruvec;
 
 		unlock_page_lruvec_irq(locked_lruvec);
 	}
 
-	return lock_page_lruvec_irq(page);
+	return folio_lruvec_lock_irq(folio);
 }
 
 /* Don't lock again iff page's lruvec locked */
-static inline struct lruvec *relock_page_lruvec_irqsave(struct page *page,
+static inline struct lruvec *folio_lruvec_relock_irqsave(struct folio *folio,
 		struct lruvec *locked_lruvec, unsigned long *flags)
 {
 	if (locked_lruvec) {
-		if (page_matches_lruvec(page, locked_lruvec))
+		if (folio_matches_lruvec(folio, locked_lruvec))
 			return locked_lruvec;
 
 		unlock_page_lruvec_irqrestore(locked_lruvec, *flags);
 	}
 
-	return lock_page_lruvec_irqsave(page, flags);
+	return folio_lruvec_lock_irqsave(folio, flags);
 }
 
+static inline struct lruvec *relock_page_lruvec_irq(struct page *page,
+		struct lruvec *locked_lruvec)
+{
+	return folio_lruvec_relock_irq(page_folio(page), locked_lruvec);
+}
+
+static inline struct lruvec *relock_page_lruvec_irqsave(struct page *page,
+		struct lruvec *locked_lruvec, unsigned long *flags)
+{
+	return folio_lruvec_relock_irqsave(page_folio(page), locked_lruvec,
+			flags);
+}
 #ifdef CONFIG_CGROUP_WRITEBACK
 
 struct wb_domain *mem_cgroup_wb_domain(struct bdi_writeback *wb);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index d7c3cb8688dd..a8d8f4673451 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2063,7 +2063,7 @@ static unsigned int move_pages_to_lru(struct lruvec *lruvec,
 		 * All pages were isolated from the same lruvec (and isolation
 		 * inhibits memcg migration).
 		 */
-		VM_BUG_ON_PAGE(!page_matches_lruvec(page, lruvec), page);
+		VM_BUG_ON_PAGE(!folio_matches_lruvec(page_folio(page), lruvec), page);
 		add_page_to_lru_list(page, lruvec);
 		nr_pages = thp_nr_pages(page);
 		nr_moved += nr_pages;
-- 
2.30.2


Return-Path: <cgroups+bounces-1120-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD2182B48E
	for <lists+cgroups@lfdr.de>; Thu, 11 Jan 2024 19:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C9BB1F25D52
	for <lists+cgroups@lfdr.de>; Thu, 11 Jan 2024 18:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93266537E4;
	Thu, 11 Jan 2024 18:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FhyOtFe6"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B673554F88
	for <cgroups@vger.kernel.org>; Thu, 11 Jan 2024 18:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=3mQloxYVj81b7FxsG36DgI4RFnukVPFBF5N4HJB/q50=; b=FhyOtFe6kL8S/UGls9v/7hVEhe
	hdgLfkztUvUHgUvmV5con/y5NczYd+XVAhQdNT1Ps6UNhmhIMToP/7ZCBLbm85c/p1ula8/ZyNxai
	Dvte+kg/OeLEbPK2ZcD1/iF10PILenh7orq47CpPVB9Hd4yaZ2kJrtz27GLfHcPDF/F9sPVnqc0ae
	YIn9jCjGEgVib4OROuAY/oY0Wu4Nnp3vZ5J+FDmfksJJBBKv9Vu/865sBAF4HpU7zO5djGxS6JDpo
	ksSFpvv5qOkMr97Mj8iLy64ffVZH+aA/DsnaRuQPF1sJQjW+TbAagu/Vp3KlDDPhpbpWMiiV9JhJ9
	ohD92AdA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rNzXR-00EWqy-F1; Thu, 11 Jan 2024 18:12:21 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/4] memcg: Convert mem_cgroup_move_charge_pte_range() to use a folio
Date: Thu, 11 Jan 2024 18:12:16 +0000
Message-Id: <20240111181219.3462852-2-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240111181219.3462852-1-willy@infradead.org>
References: <20240111181219.3462852-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove many calls to compound_head() by calling page_folio() once at
the start of each stanza which receives a struct page from 'target'.
There should be no change in behaviour here as all the called functions
start out by converting the page to its folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memcontrol.c | 49 ++++++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c4c422c81f93..c04bda961165 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5932,23 +5932,22 @@ static struct page *mc_handle_file_pte(struct vm_area_struct *vma,
 }
 
 /**
- * mem_cgroup_move_account - move account of the page
- * @page: the page
+ * mem_cgroup_move_account - move account of the folio
+ * @folio: The folio.
  * @compound: charge the page as compound or small page
- * @from: mem_cgroup which the page is moved from.
- * @to:	mem_cgroup which the page is moved to. @from != @to.
+ * @from: mem_cgroup which the folio is moved from.
+ * @to:	mem_cgroup which the folio is moved to. @from != @to.
  *
- * The page must be locked and not on the LRU.
+ * The folio must be locked and not on the LRU.
  *
  * This function doesn't do "charge" to new cgroup and doesn't do "uncharge"
  * from old cgroup.
  */
-static int mem_cgroup_move_account(struct page *page,
+static int mem_cgroup_move_account(struct folio *folio,
 				   bool compound,
 				   struct mem_cgroup *from,
 				   struct mem_cgroup *to)
 {
-	struct folio *folio = page_folio(page);
 	struct lruvec *from_vec, *to_vec;
 	struct pglist_data *pgdat;
 	unsigned int nr_pages = compound ? folio_nr_pages(folio) : 1;
@@ -6398,7 +6397,7 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 	spinlock_t *ptl;
 	enum mc_target_type target_type;
 	union mc_target target;
-	struct page *page;
+	struct folio *folio;
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
@@ -6408,26 +6407,26 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 		}
 		target_type = get_mctgt_type_thp(vma, addr, *pmd, &target);
 		if (target_type == MC_TARGET_PAGE) {
-			page = target.page;
-			if (isolate_lru_page(page)) {
-				if (!mem_cgroup_move_account(page, true,
+			folio = page_folio(target.page);
+			if (folio_isolate_lru(folio)) {
+				if (!mem_cgroup_move_account(folio, true,
 							     mc.from, mc.to)) {
 					mc.precharge -= HPAGE_PMD_NR;
 					mc.moved_charge += HPAGE_PMD_NR;
 				}
-				putback_lru_page(page);
+				folio_putback_lru(folio);
 			}
-			unlock_page(page);
-			put_page(page);
+			folio_unlock(folio);
+			folio_put(folio);
 		} else if (target_type == MC_TARGET_DEVICE) {
-			page = target.page;
-			if (!mem_cgroup_move_account(page, true,
+			folio = page_folio(target.page);
+			if (!mem_cgroup_move_account(folio, true,
 						     mc.from, mc.to)) {
 				mc.precharge -= HPAGE_PMD_NR;
 				mc.moved_charge += HPAGE_PMD_NR;
 			}
-			unlock_page(page);
-			put_page(page);
+			folio_unlock(folio);
+			folio_put(folio);
 		}
 		spin_unlock(ptl);
 		return 0;
@@ -6450,28 +6449,28 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 			device = true;
 			fallthrough;
 		case MC_TARGET_PAGE:
-			page = target.page;
+			folio = page_folio(target.page);
 			/*
 			 * We can have a part of the split pmd here. Moving it
 			 * can be done but it would be too convoluted so simply
 			 * ignore such a partial THP and keep it in original
 			 * memcg. There should be somebody mapping the head.
 			 */
-			if (PageTransCompound(page))
+			if (folio_test_large(folio))
 				goto put;
-			if (!device && !isolate_lru_page(page))
+			if (!device && !folio_isolate_lru(folio))
 				goto put;
-			if (!mem_cgroup_move_account(page, false,
+			if (!mem_cgroup_move_account(folio, false,
 						mc.from, mc.to)) {
 				mc.precharge--;
 				/* we uncharge from mc.from later. */
 				mc.moved_charge++;
 			}
 			if (!device)
-				putback_lru_page(page);
+				folio_putback_lru(folio);
 put:			/* get_mctgt_type() gets & locks the page */
-			unlock_page(page);
-			put_page(page);
+			folio_unlock(folio);
+			folio_put(folio);
 			break;
 		case MC_TARGET_SWAP:
 			ent = target.ent;
-- 
2.43.0



Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E870E697A0D
	for <lists+cgroups@lfdr.de>; Wed, 15 Feb 2023 11:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbjBOKj5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Feb 2023 05:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbjBOKjw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Feb 2023 05:39:52 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC21936FFE;
        Wed, 15 Feb 2023 02:39:50 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0VbkAEsj_1676457586;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VbkAEsj_1676457586)
          by smtp.aliyun-inc.com;
          Wed, 15 Feb 2023 18:39:47 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     torvalds@linux-foundation.org, sj@kernel.org, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, naoya.horiguchi@nec.com,
        linmiaohe@huawei.com, david@redhat.com, osalvador@suse.de,
        mike.kravetz@oracle.com, willy@infradead.org,
        baolin.wang@linux.alibaba.com, damon@lists.linux.dev,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] mm: change to return bool for isolate_lru_page()
Date:   Wed, 15 Feb 2023 18:39:35 +0800
Message-Id: <3074c1ab628d9dbf139b33f248a8bc253a3f95f0.1676424378.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1676424378.git.baolin.wang@linux.alibaba.com>
References: <cover.1676424378.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The isolate_lru_page() can only return 0 or -EBUSY, and most users did
not care about the negative error of isolate_lru_page(), except one user
in add_page_for_migration(). So we can convert the isolate_lru_page() to
return a boolean value, which can help to make the code more clear when
checking the return value of isolate_lru_page().

Also convert all users' logic of checking the isolation state.

No functional changes intended.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/folio-compat.c   | 12 +++---------
 mm/internal.h       |  2 +-
 mm/khugepaged.c     |  2 +-
 mm/memcontrol.c     |  4 ++--
 mm/memory-failure.c |  4 ++--
 mm/memory_hotplug.c |  8 +++++---
 mm/migrate.c        |  9 ++++++---
 mm/migrate_device.c |  2 +-
 8 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 540373cf904e..cabcd1de9ecb 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -113,17 +113,11 @@ struct page *grab_cache_page_write_begin(struct address_space *mapping,
 }
 EXPORT_SYMBOL(grab_cache_page_write_begin);
 
-int isolate_lru_page(struct page *page)
+bool isolate_lru_page(struct page *page)
 {
-	bool ret;
-
 	if (WARN_RATELIMIT(PageTail(page), "trying to isolate tail page"))
-		return -EBUSY;
-	ret = folio_isolate_lru((struct folio *)page);
-	if (ret)
-		return 0;
-
-	return -EBUSY;
+		return false;
+	return folio_isolate_lru((struct folio *)page);
 }
 
 void putback_lru_page(struct page *page)
diff --git a/mm/internal.h b/mm/internal.h
index 8645e8496537..fc01fd092ea5 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -187,7 +187,7 @@ pgprot_t __init early_memremap_pgprot_adjust(resource_size_t phys_addr,
 /*
  * in mm/vmscan.c:
  */
-int isolate_lru_page(struct page *page);
+bool isolate_lru_page(struct page *page);
 bool folio_isolate_lru(struct folio *folio);
 void putback_lru_page(struct page *page);
 void folio_putback_lru(struct folio *folio);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index cee659cfa3c1..8dbc39896811 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -659,7 +659,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 		 * Isolate the page to avoid collapsing an hugepage
 		 * currently in use by the VM.
 		 */
-		if (isolate_lru_page(page)) {
+		if (!isolate_lru_page(page)) {
 			unlock_page(page);
 			result = SCAN_DEL_PAGE_LRU;
 			goto out;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 17335459d8dc..e8fd42be5fab 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6176,7 +6176,7 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 		target_type = get_mctgt_type_thp(vma, addr, *pmd, &target);
 		if (target_type == MC_TARGET_PAGE) {
 			page = target.page;
-			if (!isolate_lru_page(page)) {
+			if (isolate_lru_page(page)) {
 				if (!mem_cgroup_move_account(page, true,
 							     mc.from, mc.to)) {
 					mc.precharge -= HPAGE_PMD_NR;
@@ -6226,7 +6226,7 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 			 */
 			if (PageTransCompound(page))
 				goto put;
-			if (!device && isolate_lru_page(page))
+			if (!device && !isolate_lru_page(page))
 				goto put;
 			if (!mem_cgroup_move_account(page, false,
 						mc.from, mc.to)) {
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index db85c2d37f70..e504362fdb23 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -846,7 +846,7 @@ static const char * const action_page_types[] = {
  */
 static int delete_from_lru_cache(struct page *p)
 {
-	if (!isolate_lru_page(p)) {
+	if (isolate_lru_page(p)) {
 		/*
 		 * Clear sensible page flags, so that the buddy system won't
 		 * complain when the page is unpoison-and-freed.
@@ -2513,7 +2513,7 @@ static bool isolate_page(struct page *page, struct list_head *pagelist)
 		bool lru = !__PageMovable(page);
 
 		if (lru)
-			isolated = !isolate_lru_page(page);
+			isolated = isolate_lru_page(page);
 		else
 			isolated = !isolate_movable_page(page,
 							 ISOLATE_UNEVICTABLE);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index a1e8c3e9ab08..5fc2dcf4e3ab 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1632,6 +1632,7 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 
 	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
 		struct folio *folio;
+		bool isolated;
 
 		if (!pfn_valid(pfn))
 			continue;
@@ -1667,9 +1668,10 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 		 * We can skip free pages. And we can deal with pages on
 		 * LRU and non-lru movable pages.
 		 */
-		if (PageLRU(page))
-			ret = isolate_lru_page(page);
-		else
+		if (PageLRU(page)) {
+			isolated = isolate_lru_page(page);
+			ret = isolated ? 0 : -EBUSY;
+		} else
 			ret = isolate_movable_page(page, ISOLATE_UNEVICTABLE);
 		if (!ret) { /* Success */
 			list_add_tail(&page->lru, &source);
diff --git a/mm/migrate.c b/mm/migrate.c
index ef68a1aff35c..53010a142e7f 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2132,11 +2132,14 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
 		}
 	} else {
 		struct page *head;
+		bool isolated;
 
 		head = compound_head(page);
-		err = isolate_lru_page(head);
-		if (err)
+		isolated = isolate_lru_page(head);
+		if (!isolated) {
+			err = -EBUSY;
 			goto out_putpage;
+		}
 
 		err = 1;
 		list_add_tail(&head->lru, pagelist);
@@ -2541,7 +2544,7 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 		return 0;
 	}
 
-	if (isolate_lru_page(page))
+	if (!isolate_lru_page(page))
 		return 0;
 
 	mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON + page_is_file_lru(page),
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 6c3740318a98..d30c9de60b0d 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -388,7 +388,7 @@ static unsigned long migrate_device_unmap(unsigned long *src_pfns,
 				allow_drain = false;
 			}
 
-			if (isolate_lru_page(page)) {
+			if (!isolate_lru_page(page)) {
 				src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
 				restore++;
 				continue;
-- 
2.27.0


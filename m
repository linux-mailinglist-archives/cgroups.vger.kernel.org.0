Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062EE696599
	for <lists+cgroups@lfdr.de>; Tue, 14 Feb 2023 15:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjBNOAE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Feb 2023 09:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjBNOAA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Feb 2023 09:00:00 -0500
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8800513DF4;
        Tue, 14 Feb 2023 05:59:51 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0VbgTJ1R_1676383183;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VbgTJ1R_1676383183)
          by smtp.aliyun-inc.com;
          Tue, 14 Feb 2023 21:59:44 +0800
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
Subject: [PATCH v2 4/4] mm: change to return bool for isolate_movable_page()
Date:   Tue, 14 Feb 2023 21:59:32 +0800
Message-Id: <57406039579e764fb6002648699d4896da56ba4a.1676382188.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1676382188.git.baolin.wang@linux.alibaba.com>
References: <cover.1676382188.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Now the isolate_movable_page() can only return 0 or -EBUSY, and no users
will care about the negative return value, thus we can convert the
isolate_movable_page() to return a boolean value to make the code more
clear when checking the movable page isolation state.

No functional changes intended.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 include/linux/migrate.h | 6 +++---
 mm/compaction.c         | 2 +-
 mm/memory-failure.c     | 4 ++--
 mm/memory_hotplug.c     | 4 ++--
 mm/migrate.c            | 6 +++---
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index c88b96b48be7..6b252f519c86 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -71,7 +71,7 @@ extern int migrate_pages(struct list_head *l, new_page_t new, free_page_t free,
 		unsigned long private, enum migrate_mode mode, int reason,
 		unsigned int *ret_succeeded);
 extern struct page *alloc_migration_target(struct page *page, unsigned long private);
-extern int isolate_movable_page(struct page *page, isolate_mode_t mode);
+extern bool isolate_movable_page(struct page *page, isolate_mode_t mode);
 
 int migrate_huge_page_move_mapping(struct address_space *mapping,
 		struct folio *dst, struct folio *src);
@@ -92,8 +92,8 @@ static inline int migrate_pages(struct list_head *l, new_page_t new,
 static inline struct page *alloc_migration_target(struct page *page,
 		unsigned long private)
 	{ return NULL; }
-static inline int isolate_movable_page(struct page *page, isolate_mode_t mode)
-	{ return -EBUSY; }
+static inline bool isolate_movable_page(struct page *page, isolate_mode_t mode)
+	{ return false; }
 
 static inline int migrate_huge_page_move_mapping(struct address_space *mapping,
 				  struct folio *dst, struct folio *src)
diff --git a/mm/compaction.c b/mm/compaction.c
index d73578af44cc..ad7409f70519 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -976,7 +976,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 					locked = NULL;
 				}
 
-				if (!isolate_movable_page(page, mode))
+				if (isolate_movable_page(page, mode))
 					goto isolate_success;
 			}
 
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 8604753bc644..a1ede7bdce95 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2515,8 +2515,8 @@ static bool isolate_page(struct page *page, struct list_head *pagelist)
 		if (lru)
 			isolated = isolate_lru_page(page);
 		else
-			isolated = !isolate_movable_page(page,
-							 ISOLATE_UNEVICTABLE);
+			isolated = isolate_movable_page(page,
+							ISOLATE_UNEVICTABLE);
 
 		if (isolated) {
 			list_add(&page->lru, pagelist);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 17ed80707518..e54c4aa69636 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1668,10 +1668,10 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 		 * LRU and non-lru movable pages.
 		 */
 		if (PageLRU(page))
-			ret = !isolate_lru_page(page);
+			ret = isolate_lru_page(page);
 		else
 			ret = isolate_movable_page(page, ISOLATE_UNEVICTABLE);
-		if (!ret) { /* Success */
+		if (ret) { /* Success */
 			list_add_tail(&page->lru, &source);
 			if (!__PageMovable(page))
 				inc_node_page_state(page, NR_ISOLATED_ANON +
diff --git a/mm/migrate.c b/mm/migrate.c
index c5136fa48638..b7982aa745b0 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -58,7 +58,7 @@
 
 #include "internal.h"
 
-int isolate_movable_page(struct page *page, isolate_mode_t mode)
+bool isolate_movable_page(struct page *page, isolate_mode_t mode)
 {
 	struct folio *folio = folio_get_nontail_page(page);
 	const struct movable_operations *mops;
@@ -119,14 +119,14 @@ int isolate_movable_page(struct page *page, isolate_mode_t mode)
 	folio_set_isolated(folio);
 	folio_unlock(folio);
 
-	return 0;
+	return true;
 
 out_no_isolated:
 	folio_unlock(folio);
 out_putfolio:
 	folio_put(folio);
 out:
-	return -EBUSY;
+	return false;
 }
 
 static void putback_movable_folio(struct folio *folio)
-- 
2.27.0


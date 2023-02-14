Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBF2695757
	for <lists+cgroups@lfdr.de>; Tue, 14 Feb 2023 04:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjBNDSe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Feb 2023 22:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjBNDSd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Feb 2023 22:18:33 -0500
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EEE12587;
        Mon, 13 Feb 2023 19:18:32 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VbdtbCV_1676344707;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VbdtbCV_1676344707)
          by smtp.aliyun-inc.com;
          Tue, 14 Feb 2023 11:18:27 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     torvalds@linux-foundation.org, sj@kernel.org, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, baolin.wang@linux.alibaba.com,
        damon@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mm: check negative error of isolate_lru_page() when failed to isolate a page
Date:   Tue, 14 Feb 2023 11:18:07 +0800
Message-Id: <fd5eff1f4f1225dd43748fa34c7e6c7c5f77f170.1676342827.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1676342827.git.baolin.wang@linux.alibaba.com>
References: <cover.1676342827.git.baolin.wang@linux.alibaba.com>
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

Better to check the negative error of isolate_lru_page() when failed to
isolate a page from its LRU, which makes the code more clear.

No functional changes.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/khugepaged.c     | 2 +-
 mm/memcontrol.c     | 2 +-
 mm/migrate.c        | 4 ++--
 mm/migrate_device.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 463dfca4b841..99a2d993b51c 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -659,7 +659,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 		 * Isolate the page to avoid collapsing an hugepage
 		 * currently in use by the VM.
 		 */
-		if (isolate_lru_page(page)) {
+		if (isolate_lru_page(page) < 0) {
 			unlock_page(page);
 			result = SCAN_DEL_PAGE_LRU;
 			goto out;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 17335459d8dc..33cad66a4132 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6226,7 +6226,7 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 			 */
 			if (PageTransCompound(page))
 				goto put;
-			if (!device && isolate_lru_page(page))
+			if (!device && isolate_lru_page(page) < 0)
 				goto put;
 			if (!mem_cgroup_move_account(page, false,
 						mc.from, mc.to)) {
diff --git a/mm/migrate.c b/mm/migrate.c
index ef68a1aff35c..eaae39564f86 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2135,7 +2135,7 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
 
 		head = compound_head(page);
 		err = isolate_lru_page(head);
-		if (err)
+		if (err < 0)
 			goto out_putpage;
 
 		err = 1;
@@ -2541,7 +2541,7 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 		return 0;
 	}
 
-	if (isolate_lru_page(page))
+	if (isolate_lru_page(page) < 0)
 		return 0;
 
 	mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON + page_is_file_lru(page),
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 6c3740318a98..1ab56b5b7914 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -388,7 +388,7 @@ static unsigned long migrate_device_unmap(unsigned long *src_pfns,
 				allow_drain = false;
 			}
 
-			if (isolate_lru_page(page)) {
+			if (isolate_lru_page(page) < 0) {
 				src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
 				restore++;
 				continue;
-- 
2.27.0


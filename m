Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A24E695754
	for <lists+cgroups@lfdr.de>; Tue, 14 Feb 2023 04:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjBNDSb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Feb 2023 22:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjBNDSb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Feb 2023 22:18:31 -0500
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D261A869C;
        Mon, 13 Feb 2023 19:18:29 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Vbe-fy8_1676344706;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vbe-fy8_1676344706)
          by smtp.aliyun-inc.com;
          Tue, 14 Feb 2023 11:18:27 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     torvalds@linux-foundation.org, sj@kernel.org, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, baolin.wang@linux.alibaba.com,
        damon@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mm: check negative error of folio_isolate_lru() when failed to isolate a folio
Date:   Tue, 14 Feb 2023 11:18:06 +0800
Message-Id: <ef7059c8442b7e1ee5f406523b79d24d19b050b6.1676342827.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1676342827.git.baolin.wang@linux.alibaba.com>
References: <cover.1676342827.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The folio_isolate_lru() will return a negative error if failed to isolate
a folio from its LRU list, thus better to check the negative error to
make the code more clear per Linus's suggestion[1].

No functional changes.

[1] https://lore.kernel.org/all/CAHk-=wiBrY+O-4=2mrbVyxR+hOqfdJ=Do6xoucfJ9_5az01L4Q@mail.gmail.com/

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/damon/paddr.c | 2 +-
 mm/gup.c         | 2 +-
 mm/khugepaged.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index b4df9b9bcc0a..ebf3dd084af2 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -246,7 +246,7 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
 
 		folio_clear_referenced(folio);
 		folio_test_clear_young(folio);
-		if (folio_isolate_lru(folio)) {
+		if (folio_isolate_lru(folio) < 0) {
 			folio_put(folio);
 			continue;
 		}
diff --git a/mm/gup.c b/mm/gup.c
index b0885f70579c..7fdddd43663c 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1939,7 +1939,7 @@ static unsigned long collect_longterm_unpinnable_pages(
 			drain_allow = false;
 		}
 
-		if (folio_isolate_lru(folio))
+		if (folio_isolate_lru(folio) < 0)
 			continue;
 
 		list_add_tail(&folio->lru, movable_page_list);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index a5d32231bfad..463dfca4b841 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2047,7 +2047,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 			goto out_unlock;
 		}
 
-		if (folio_isolate_lru(folio)) {
+		if (folio_isolate_lru(folio) < 0) {
 			result = SCAN_DEL_PAGE_LRU;
 			goto out_unlock;
 		}
-- 
2.27.0


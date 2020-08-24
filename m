Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 618D324FE3B
	for <lists+cgroups@lfdr.de>; Mon, 24 Aug 2020 14:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgHXM4x (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Aug 2020 08:56:53 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:42325 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727849AbgHXMzc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 Aug 2020 08:55:32 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0U6k9-bl_1598273712;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U6k9-bl_1598273712)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 24 Aug 2020 20:55:24 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com, kirill@shutemov.name,
        alexander.duyck@gmail.com, rong.a.chen@intel.com, mhocko@suse.com,
        vdavydov.dev@gmail.com, shy828301@gmail.com
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v18 30/32] mm: Drop use of test_and_set_skip in favor of just setting skip
Date:   Mon, 24 Aug 2020 20:55:03 +0800
Message-Id: <1598273705-69124-31-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

The only user of test_and_set_skip was isolate_migratepages_block and it
was using it after a call that was testing and clearing the LRU flag. As
such it really didn't need to be behind the LRU lock anymore as it wasn't
really fulfilling its purpose.

Since it is only possible to be able to test and set the skip flag if we
were able to obtain the LRU bit for the first page in the pageblock the
use of the test_and_set_skip becomes redundant as the LRU flag now becomes
the item that limits us to only one thread being able to perform the
operation and there being no need for a test_and_set operation.

With that being the case we can simply drop the bit and instead directly
just call the set_pageblock_skip function if the page we are working on is
the valid_page at the start of the pageblock. Then any other threads that
enter this pageblock should see the skip bit set on the first valid page in
the pageblock.

Since we have dropped the late abort case we can drop the code that was
clearing the LRU flag and calling page_put since the abort case will now
not be holding a reference to a page now.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 mm/compaction.c | 53 +++++++++++++----------------------------------------
 1 file changed, 13 insertions(+), 40 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index a0e48d079124..9443bc4d763d 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -399,29 +399,6 @@ void reset_isolation_suitable(pg_data_t *pgdat)
 	}
 }
 
-/*
- * Sets the pageblock skip bit if it was clear. Note that this is a hint as
- * locks are not required for read/writers. Returns true if it was already set.
- */
-static bool test_and_set_skip(struct compact_control *cc, struct page *page,
-							unsigned long pfn)
-{
-	bool skip;
-
-	/* Do no update if skip hint is being ignored */
-	if (cc->ignore_skip_hint)
-		return false;
-
-	if (!IS_ALIGNED(pfn, pageblock_nr_pages))
-		return false;
-
-	skip = get_pageblock_skip(page);
-	if (!skip && !cc->no_set_skip_hint)
-		set_pageblock_skip(page);
-
-	return skip;
-}
-
 static void update_cached_migrate(struct compact_control *cc, unsigned long pfn)
 {
 	struct zone *zone = cc->zone;
@@ -480,12 +457,6 @@ static inline void update_pageblock_skip(struct compact_control *cc,
 static void update_cached_migrate(struct compact_control *cc, unsigned long pfn)
 {
 }
-
-static bool test_and_set_skip(struct compact_control *cc, struct page *page,
-							unsigned long pfn)
-{
-	return false;
-}
 #endif /* CONFIG_COMPACTION */
 
 /*
@@ -895,7 +866,6 @@ static bool too_many_isolated(pg_data_t *pgdat)
 		if (!valid_page && IS_ALIGNED(low_pfn, pageblock_nr_pages)) {
 			if (!cc->ignore_skip_hint && get_pageblock_skip(page)) {
 				low_pfn = end_pfn;
-				page = NULL;
 				goto isolate_abort;
 			}
 			valid_page = page;
@@ -1021,11 +991,20 @@ static bool too_many_isolated(pg_data_t *pgdat)
 
 			lruvec_memcg_debug(lruvec, page);
 
-			/* Try get exclusive access under lock */
-			if (!skip_updated) {
+			/*
+			 * Indicate that we want exclusive access to the
+			 * rest of the pageblock.
+			 *
+			 * The LRU flag prevents simultaneous access to the
+			 * first PFN, and the LRU lock helps to prevent
+			 * simultaneous update of multiple pageblocks shared
+			 * in the same bitmap.
+			 */
+			if (page == valid_page) {
+				if (!cc->ignore_skip_hint &&
+				    !cc->no_set_skip_hint)
+					set_pageblock_skip(page);
 				skip_updated = true;
-				if (test_and_set_skip(cc, page, low_pfn))
-					goto isolate_abort;
 			}
 		}
 
@@ -1098,15 +1077,9 @@ static bool too_many_isolated(pg_data_t *pgdat)
 	if (unlikely(low_pfn > end_pfn))
 		low_pfn = end_pfn;
 
-	page = NULL;
-
 isolate_abort:
 	if (lruvec)
 		unlock_page_lruvec_irqrestore(lruvec, flags);
-	if (page) {
-		SetPageLRU(page);
-		put_page(page);
-	}
 
 	/*
 	 * Updated the cached scanner pfn once the pageblock has been scanned
-- 
1.8.3.1


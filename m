Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C949124FE32
	for <lists+cgroups@lfdr.de>; Mon, 24 Aug 2020 14:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgHXM4j (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Aug 2020 08:56:39 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:43108 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727851AbgHXMze (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 Aug 2020 08:55:34 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0U6k9-bl_1598273712;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U6k9-bl_1598273712)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 24 Aug 2020 20:55:23 +0800
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
Subject: [PATCH v18 29/32] mm: Identify compound pages sooner in isolate_migratepages_block
Date:   Mon, 24 Aug 2020 20:55:02 +0800
Message-Id: <1598273705-69124-30-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Since we are holding a reference to the page much sooner in
isolate_migratepages_block we can move the PageCompound check out of the
LRU locked section and instead just place it after get_page_unless_zero. By
doing this we can allow any of the items that might trigger a failure to
trigger a failure for the compound page rather than the order 0 page and as
a result we should be able to process the pageblock faster.

In addition by testing for PageCompound sooner we can avoid having the LRU
flag cleared and then reset in the exception case. As a result this should
prevent possible races where another thread might be attempting to pull the
LRU pages from the list.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 mm/compaction.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 6bf5ccd8fcf6..a0e48d079124 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -984,6 +984,24 @@ static bool too_many_isolated(pg_data_t *pgdat)
 		if (unlikely(!get_page_unless_zero(page)))
 			goto isolate_fail;
 
+		/*
+		 * Page is compound. We know the order before we know if it is
+		 * on the LRU so we cannot assume it is THP. However since the
+		 * page will have the LRU validated shortly we can use the value
+		 * to skip over this page for now or validate the LRU is set and
+		 * then isolate the entire compound page if we are isolating to
+		 * generate a CMA page.
+		 */
+		if (PageCompound(page)) {
+			const unsigned int order = compound_order(page);
+
+			if (likely(order < MAX_ORDER))
+				low_pfn += (1UL << order) - 1;
+
+			if (!cc->alloc_contig)
+				goto isolate_fail_put;
+		}
+
 		if (__isolate_lru_page_prepare(page, isolate_mode) != 0)
 			goto isolate_fail_put;
 
@@ -1009,23 +1027,8 @@ static bool too_many_isolated(pg_data_t *pgdat)
 				if (test_and_set_skip(cc, page, low_pfn))
 					goto isolate_abort;
 			}
-
-			/*
-			 * Page become compound since the non-locked check,
-			 * and it's on LRU. It can only be a THP so the order
-			 * is safe to read and it's 0 for tail pages.
-			 */
-			if (unlikely(PageCompound(page) && !cc->alloc_contig)) {
-				low_pfn += compound_nr(page) - 1;
-				SetPageLRU(page);
-				goto isolate_fail_put;
-			}
 		}
 
-		/* The whole page is taken off the LRU; skip the tail pages. */
-		if (PageCompound(page))
-			low_pfn += compound_nr(page) - 1;
-
 		/* Successfully isolated */
 		del_page_from_lru_list(page, lruvec, page_lru(page));
 		mod_node_page_state(page_pgdat(page),
-- 
1.8.3.1


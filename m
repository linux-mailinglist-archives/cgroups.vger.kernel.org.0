Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE1329E948
	for <lists+cgroups@lfdr.de>; Thu, 29 Oct 2020 11:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgJ2Kpi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Oct 2020 06:45:38 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:51553 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726748AbgJ2Kpg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Oct 2020 06:45:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0UDXwDyN_1603968328;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UDXwDyN_1603968328)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 29 Oct 2020 18:45:30 +0800
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
Cc:     =?UTF-8?q?Mika=20Penttil=C3=A4?= <mika.penttila@nextfour.com>
Subject: [PATCH v20 05/20] mm/thp: Simplify lru_add_page_tail()
Date:   Thu, 29 Oct 2020 18:44:50 +0800
Message-Id: <1603968305-8026-6-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Simplify lru_add_page_tail(), there are actually only two cases possible:
split_huge_page_to_list(), with list supplied and head isolated from lru
by its caller; or split_huge_page(), with NULL list and head on lru -
because when head is racily isolated from lru, the isolator's reference
will stop the split from getting any further than its page_ref_freeze().

So decide between the two cases by "list", but add VM_WARN_ON()s to
verify that they match our lru expectations.

[Hugh Dickins: rewrite commit log]
Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Hugh Dickins <hughd@google.com>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Mika Penttilä <mika.penttila@nextfour.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/huge_memory.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 93c0b73eb8c6..4b72dd7b8b34 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2354,25 +2354,16 @@ static void lru_add_page_tail(struct page *head, struct page *page_tail,
 	VM_BUG_ON_PAGE(PageLRU(page_tail), head);
 	lockdep_assert_held(&lruvec_pgdat(lruvec)->lru_lock);
 
-	if (!list)
-		SetPageLRU(page_tail);
-
-	if (likely(PageLRU(head)))
-		list_add_tail(&page_tail->lru, &head->lru);
-	else if (list) {
+	if (list) {
 		/* page reclaim is reclaiming a huge page */
+		VM_WARN_ON(PageLRU(head));
 		get_page(page_tail);
 		list_add_tail(&page_tail->lru, list);
 	} else {
-		/*
-		 * Head page has not yet been counted, as an hpage,
-		 * so we must account for each subpage individually.
-		 *
-		 * Put page_tail on the list at the correct position
-		 * so they all end up in order.
-		 */
-		add_page_to_lru_list_tail(page_tail, lruvec,
-					  page_lru(page_tail));
+		/* head is still on lru (and we have it frozen) */
+		VM_WARN_ON(!PageLRU(head));
+		SetPageLRU(page_tail);
+		list_add_tail(&page_tail->lru, &head->lru);
 	}
 }
 
-- 
1.8.3.1


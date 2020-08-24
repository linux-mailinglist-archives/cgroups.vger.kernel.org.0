Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326F524FE28
	for <lists+cgroups@lfdr.de>; Mon, 24 Aug 2020 14:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgHXM4L (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Aug 2020 08:56:11 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:60780 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727948AbgHXM4J (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 Aug 2020 08:56:09 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0U6k9-bl_1598273712;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U6k9-bl_1598273712)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 24 Aug 2020 20:55:22 +0800
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
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v18 26/32] mm/mlock: remove __munlock_isolate_lru_page
Date:   Mon, 24 Aug 2020 20:54:59 +0800
Message-Id: <1598273705-69124-27-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The func only has one caller, remove it to clean up code and simplify
code.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/mlock.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 46a05e6ec5ba..40a8bb79c65e 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -102,23 +102,6 @@ void mlock_vma_page(struct page *page)
 }
 
 /*
- * Isolate a page from LRU with optional get_page() pin.
- * Assumes lru_lock already held and page already pinned.
- */
-static bool __munlock_isolate_lru_page(struct page *page,
-				struct lruvec *lruvec, bool getpage)
-{
-	if (TestClearPageLRU(page)) {
-		if (getpage)
-			get_page(page);
-		del_page_from_lru_list(page, lruvec, page_lru(page));
-		return true;
-	}
-
-	return false;
-}
-
-/*
  * Finish munlock after successful page isolation
  *
  * Page must be locked. This is a wrapper for try_to_munlock()
@@ -300,7 +283,10 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
 			 * We already have pin from follow_page_mask()
 			 * so we can spare the get_page() here.
 			 */
-			if (__munlock_isolate_lru_page(page, lruvec, false)) {
+			if (TestClearPageLRU(page)) {
+				enum lru_list lru = page_lru(page);
+
+				del_page_from_lru_list(page, lruvec, lru);
 				unlock_page_memcg(page);
 				continue;
 			} else
-- 
1.8.3.1


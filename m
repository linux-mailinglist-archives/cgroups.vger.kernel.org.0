Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6506D22386C
	for <lists+cgroups@lfdr.de>; Fri, 17 Jul 2020 11:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgGQJb2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Jul 2020 05:31:28 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:35474 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725912AbgGQJb1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Jul 2020 05:31:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07425;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0U2zo7Ok_1594978280;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U2zo7Ok_1594978280)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 17 Jul 2020 17:31:21 +0800
Subject: Re: [PATCH v16 14/22] mm/thp: add tail pages into lru anyway in
 split_huge_page()
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name
Cc:     =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
 <1594429136-20002-15-git-send-email-alex.shi@linux.alibaba.com>
Message-ID: <d478a44b-c598-e99b-d438-9387f208ad37@linux.alibaba.com>
Date:   Fri, 17 Jul 2020 17:30:27 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1594429136-20002-15-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


Add a VM_WARN_ON for tracking. and updated comments for the code.

Thanks

---
From f1381a1547625a6521777bf9235823d8fbd00dac Mon Sep 17 00:00:00 2001
From: Alex Shi <alex.shi@linux.alibaba.com>
Date: Fri, 10 Jul 2020 16:54:37 +0800
Subject: [PATCH v16 14/22] mm/thp: add tail pages into lru anyway in
 split_huge_page()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Split_huge_page() must start with PageLRU(head), and we are holding the
lru_lock here. If the head was cleared lru bit unexpected, tracking it.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Mika Penttilä <mika.penttila@nextfour.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/huge_memory.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d866b6e43434..28538444197b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2348,15 +2348,19 @@ static void lru_add_page_tail(struct page *head, struct page *page_tail,
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
 		get_page(page_tail);
 		list_add_tail(&page_tail->lru, list);
+	} else {
+		/*
+		 * Split start from PageLRU(head), and we are holding the
+		 * lru_lock.
+		 * Do a warning if the head's lru bit was cleared unexpected.
+		 */
+		VM_WARN_ON(!PageLRU(head));
+		SetPageLRU(page_tail);
+		list_add_tail(&page_tail->lru, &head->lru);
 	}
 }
 
-- 
1.8.3.1


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAFC1E5D92
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2020 13:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388077AbgE1LB3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 May 2020 07:01:29 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:52862 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388064AbgE1LB3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 May 2020 07:01:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0TztdQ9T_1590663684;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TztdQ9T_1590663684)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 28 May 2020 19:01:25 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
Cc:     Alex Shi <alex.shi@linux.alibaba.com>
Subject: [PATCH v11 02/16] mm/page_idle: no unlikely double check for idle page counting
Date:   Thu, 28 May 2020 19:00:44 +0800
Message-Id: <1590663658-184131-3-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1590663658-184131-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1590663658-184131-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

As func comments mentioned, few isolated page missing be tolerated.
So why not do further to drop the unlikely double check. That won't
cause more idle pages, but reduce a lock contention.

This is also a preparation for later new page isolation feature.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/page_idle.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/mm/page_idle.c b/mm/page_idle.c
index 295512465065..914df63948b1 100644
--- a/mm/page_idle.c
+++ b/mm/page_idle.c
@@ -31,7 +31,6 @@
 static struct page *page_idle_get_page(unsigned long pfn)
 {
 	struct page *page;
-	pg_data_t *pgdat;
 
 	if (!pfn_valid(pfn))
 		return NULL;
@@ -41,13 +40,6 @@ static struct page *page_idle_get_page(unsigned long pfn)
 	    !get_page_unless_zero(page))
 		return NULL;
 
-	pgdat = page_pgdat(page);
-	spin_lock_irq(&pgdat->lru_lock);
-	if (unlikely(!PageLRU(page))) {
-		put_page(page);
-		page = NULL;
-	}
-	spin_unlock_irq(&pgdat->lru_lock);
 	return page;
 }
 
-- 
1.8.3.1


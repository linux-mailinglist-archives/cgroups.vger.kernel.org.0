Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35931102448
	for <lists+cgroups@lfdr.de>; Tue, 19 Nov 2019 13:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfKSMYR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Nov 2019 07:24:17 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:45090 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727948AbfKSMYQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Nov 2019 07:24:16 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TiZ64Bq_1574166244;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TiZ64Bq_1574166244)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 19 Nov 2019 20:24:05 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        shakeelb@google.com, hannes@cmpxchg.org
Cc:     Alex Shi <alex.shi@linux.alibaba.com>
Subject: [PATCH v4 1/9] mm/swap: fix uninitialized compiler warning
Date:   Tue, 19 Nov 2019 20:23:15 +0800
Message-Id: <1574166203-151975-2-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574166203-151975-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1574166203-151975-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

  ../mm/swap.c: In function ‘__page_cache_release’:
  ../mm/swap.c:67:10: warning: ‘flags’ may be used uninitialized in this
  function [-Wmaybe-uninitialized]
       lruvec = lock_page_lruvec_irqsave(page, pgdat, flags);
       ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/swap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/swap.c b/mm/swap.c
index 5341ae93861f..c36a10244d07 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -62,7 +62,7 @@ static void __page_cache_release(struct page *page)
 	if (PageLRU(page)) {
 		pg_data_t *pgdat = page_pgdat(page);
 		struct lruvec *lruvec;
-		unsigned long flags;
+		unsigned long flags = 0;
 
 		spin_lock_irqsave(&pgdat->lru_lock, flags);
 		lruvec = mem_cgroup_page_lruvec(page, pgdat);
-- 
1.8.3.1


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B86200426
	for <lists+cgroups@lfdr.de>; Fri, 19 Jun 2020 10:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731241AbgFSIgY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Jun 2020 04:36:24 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:55485 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731559AbgFSIeY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 19 Jun 2020 04:34:24 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0U01UeXS_1592555659;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U01UeXS_1592555659)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 19 Jun 2020 16:34:19 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
Subject: [PATCH v13 03/18] mm/compaction: correct the comments of compact_defer_shift
Date:   Fri, 19 Jun 2020 16:33:41 +0800
Message-Id: <1592555636-115095-4-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1592555636-115095-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1592555636-115095-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

There is no compact_defer_limit. It should be compact_defer_shift in
use. and add compact_order_failed explanation.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/mmzone.h | 1 +
 mm/compaction.c        | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index c4c37fd12104..592ef93ae64c 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -512,6 +512,7 @@ struct zone {
 	 * On compaction failure, 1<<compact_defer_shift compactions
 	 * are skipped before trying again. The number attempted since
 	 * last failure is tracked with compact_considered.
+	 * compact_order_failed is the minimum compaction failed order.
 	 */
 	unsigned int		compact_considered;
 	unsigned int		compact_defer_shift;
diff --git a/mm/compaction.c b/mm/compaction.c
index fd988b7e5f2b..48114f98e362 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -136,7 +136,7 @@ void __ClearPageMovable(struct page *page)
 
 /*
  * Compaction is deferred when compaction fails to result in a page
- * allocation success. 1 << compact_defer_limit compactions are skipped up
+ * allocation success. compact_defer_shift++, compactions are skipped up
  * to a limit of 1 << COMPACT_MAX_DEFER_SHIFT
  */
 void defer_compaction(struct zone *zone, int order)
-- 
1.8.3.1


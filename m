Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E7F1F6193
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2020 08:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgFKGRL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 11 Jun 2020 02:17:11 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:32795 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726462AbgFKGRK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 11 Jun 2020 02:17:10 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0U.EnD9o_1591856225;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U.EnD9o_1591856225)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Jun 2020 14:17:06 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
Subject: [PATCH v12 03/16] mm/compaction: correct the comments of compact_defer_shift
Date:   Thu, 11 Jun 2020 14:16:36 +0800
Message-Id: <1591856209-166869-4-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1591856209-166869-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1591856209-166869-1-git-send-email-alex.shi@linux.alibaba.com>
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
index df1f08486d81..7ae464188588 100644
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


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D46230950
	for <lists+cgroups@lfdr.de>; Tue, 28 Jul 2020 14:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgG1L7u (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Jul 2020 07:59:50 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:57244 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728433AbgG1L7t (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Jul 2020 07:59:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0U43tT5Y_1595937583;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U43tT5Y_1595937583)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 28 Jul 2020 19:59:44 +0800
Subject: Re: [PATCH v17 03/21] mm/compaction: correct the comments of
 compact_defer_shift
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        kbuild test robot <lkp@intel.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Rong Chen <rong.a.chen@intel.com>
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
 <1595681998-19193-4-git-send-email-alex.shi@linux.alibaba.com>
 <CAKgT0UfmbdhpUdGy+4VircovmJfiJy9m-MN_o0LChNT_kWRUng@mail.gmail.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <3bd60e1b-a74e-050d-ade4-6e8f54e00b92@linux.alibaba.com>
Date:   Tue, 28 Jul 2020 19:59:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UfmbdhpUdGy+4VircovmJfiJy9m-MN_o0LChNT_kWRUng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


>>   * Compaction is deferred when compaction fails to result in a page
>> - * allocation success. 1 << compact_defer_limit compactions are skipped up
>> + * allocation success. compact_defer_shift++, compactions are skipped up
>>   * to a limit of 1 << COMPACT_MAX_DEFER_SHIFT
>>   */
>>  void defer_compaction(struct zone *zone, int order)
> 
> So this doesn't read right. I wouldn't keep the "++," in the
> explanation, and if we are going to refer to a limit of "1 <<
> COMPACT_MAX_DEFER_SHIFT" then maybe this should be left as "1 <<
> compact_defer_shift".
> 

Thanks for comments! So is the changed patch fine?
--

From 80ffde4c8e13ba2ad1ad5175dbaef245c2fe49bc Mon Sep 17 00:00:00 2001
From: Alex Shi <alex.shi@linux.alibaba.com>
Date: Tue, 26 May 2020 09:47:01 +0800
Subject: [PATCH] mm/compaction: correct the comments of compact_defer_shift

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
index f6f884970511..14c668b7e793 100644
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
index 86375605faa9..4950240cd455 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -136,7 +136,7 @@ void __ClearPageMovable(struct page *page)
 
 /*
  * Compaction is deferred when compaction fails to result in a page
- * allocation success. 1 << compact_defer_limit compactions are skipped up
+ * allocation success. 1 << compact_defer_shift, compactions are skipped up
  * to a limit of 1 << COMPACT_MAX_DEFER_SHIFT
  */
 void defer_compaction(struct zone *zone, int order)
-- 
1.8.3.1


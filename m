Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A8424FE38
	for <lists+cgroups@lfdr.de>; Mon, 24 Aug 2020 14:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgHXM4x (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Aug 2020 08:56:53 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:39478 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727841AbgHXMzd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 Aug 2020 08:55:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01353;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0U6k9-bl_1598273712;
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
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: [PATCH v18 31/32] mm: Add explicit page decrement in exception path for isolate_lru_pages
Date:   Mon, 24 Aug 2020 20:55:04 +0800
Message-Id: <1598273705-69124-32-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

In isolate_lru_pages we have an exception path where if we call
get_page_unless_zero and that succeeds, but TestClearPageLRU fails we call
put_page. Normally this would be problematic but due to the way that the
calls are ordered and the fact that we are holding the LRU lock we know
that the caller must be holding another reference for the page. Since we
can assume that we can replace the put_page with a call to
put_page_testzero contained within a WARN_ON. By doing this we should see
if we ever leak a page as a result of the reference count somehow hitting
zero when it shouldn't, and can avoid the overhead and confusion of using
the full put_page call.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 mm/vmscan.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 601fbcb994fb..604240303ea2 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1688,10 +1688,13 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
 
 			if (!TestClearPageLRU(page)) {
 				/*
-				 * This page may in other isolation path,
-				 * but we still hold lru_lock.
+				 * This page is being isolated in another
+				 * thread, but we still hold lru_lock. The
+				 * other thread must be holding a reference
+				 * to the page so this should never hit a
+				 * reference count of 0.
 				 */
-				put_page(page);
+				WARN_ON(put_page_testzero(page));
 				goto busy;
 			}
 
-- 
1.8.3.1


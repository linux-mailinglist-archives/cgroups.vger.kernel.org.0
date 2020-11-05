Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDF72A79BA
	for <lists+cgroups@lfdr.de>; Thu,  5 Nov 2020 09:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbgKEI4R (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Nov 2020 03:56:17 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:53282 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730276AbgKEI4Q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Nov 2020 03:56:16 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0UEJC3Fv_1604566567;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UEJC3Fv_1604566567)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 05 Nov 2020 16:56:11 +0800
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
Cc:     Vlastimil Babka <vbabka@suse.cz>, Minchan Kim <minchan@kernel.org>
Subject: [PATCH v21 07/19] mm: page_idle_get_page() does not need lru_lock
Date:   Thu,  5 Nov 2020 16:55:37 +0800
Message-Id: <1604566549-62481-8-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Hugh Dickins <hughd@google.com>

It is necessary for page_idle_get_page() to recheck PageLRU() after
get_page_unless_zero(), but holding lru_lock around that serves no
useful purpose, and adds to lru_lock contention: delete it.

See https://lore.kernel.org/lkml/20150504031722.GA2768@blaptop for the
discussion that led to lru_lock there; but __page_set_anon_rmap() now
uses WRITE_ONCE(), and I see no other risk in page_idle_clear_pte_refs()
using rmap_walk() (beyond the risk of racing PageAnon->PageKsm, mostly
but not entirely prevented by page_count() check in ksm.c's
write_protect_page(): that risk being shared with page_referenced() and
not helped by lru_lock).

Signed-off-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Alex Shi <alex.shi@linux.alibaba.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/page_idle.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/page_idle.c b/mm/page_idle.c
index 057c61df12db..64e5344a992c 100644
--- a/mm/page_idle.c
+++ b/mm/page_idle.c
@@ -32,19 +32,15 @@
 static struct page *page_idle_get_page(unsigned long pfn)
 {
 	struct page *page = pfn_to_online_page(pfn);
-	pg_data_t *pgdat;
 
 	if (!page || !PageLRU(page) ||
 	    !get_page_unless_zero(page))
 		return NULL;
 
-	pgdat = page_pgdat(page);
-	spin_lock_irq(&pgdat->lru_lock);
 	if (unlikely(!PageLRU(page))) {
 		put_page(page);
 		page = NULL;
 	}
-	spin_unlock_irq(&pgdat->lru_lock);
 	return page;
 }
 
-- 
1.8.3.1


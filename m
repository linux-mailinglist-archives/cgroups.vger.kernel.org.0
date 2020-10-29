Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBF829E94B
	for <lists+cgroups@lfdr.de>; Thu, 29 Oct 2020 11:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgJ2Kpm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Oct 2020 06:45:42 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:36721 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726826AbgJ2Kpl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Oct 2020 06:45:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0UDXwDyN_1603968328;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UDXwDyN_1603968328)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 29 Oct 2020 18:45:34 +0800
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
Subject: [PATCH v20 13/20] mm/mlock: remove lru_lock on TestClearPageMlocked
Date:   Thu, 29 Oct 2020 18:44:58 +0800
Message-Id: <1603968305-8026-14-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

In the func munlock_vma_page, comments mentained lru_lock needed for
serialization with split_huge_pages. But the page must be PageLocked
as well as pages in split_huge_page series funcs. Thus the PageLocked
is enough to serialize both funcs.

Further more, Hugh Dickins pointed: before splitting in
split_huge_page_to_list, the page was unmap_page() to remove pmd/ptes
which protect the page from munlock. Thus, no needs to guard
__split_huge_page_tail for mlock clean, just keep the lru_lock there for
isolation purpose.

LKP found a preempt issue on __mod_zone_page_state which need change
to mod_zone_page_state. Thanks!

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Acked-by: Hugh Dickins <hughd@google.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/mlock.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 884b1216da6a..796c726a0407 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -187,40 +187,24 @@ static void __munlock_isolation_failed(struct page *page)
 unsigned int munlock_vma_page(struct page *page)
 {
 	int nr_pages;
-	pg_data_t *pgdat = page_pgdat(page);
 
 	/* For try_to_munlock() and to serialize with page migration */
 	BUG_ON(!PageLocked(page));
-
 	VM_BUG_ON_PAGE(PageTail(page), page);
 
-	/*
-	 * Serialize with any parallel __split_huge_page_refcount() which
-	 * might otherwise copy PageMlocked to part of the tail pages before
-	 * we clear it in the head page. It also stabilizes thp_nr_pages().
-	 */
-	spin_lock_irq(&pgdat->lru_lock);
-
 	if (!TestClearPageMlocked(page)) {
 		/* Potentially, PTE-mapped THP: do not skip the rest PTEs */
-		nr_pages = 1;
-		goto unlock_out;
+		return 0;
 	}
 
 	nr_pages = thp_nr_pages(page);
-	__mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
+	mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
 
-	if (__munlock_isolate_lru_page(page, true)) {
-		spin_unlock_irq(&pgdat->lru_lock);
+	if (!isolate_lru_page(page))
 		__munlock_isolated_page(page);
-		goto out;
-	}
-	__munlock_isolation_failed(page);
-
-unlock_out:
-	spin_unlock_irq(&pgdat->lru_lock);
+	else
+		__munlock_isolation_failed(page);
 
-out:
 	return nr_pages - 1;
 }
 
-- 
1.8.3.1


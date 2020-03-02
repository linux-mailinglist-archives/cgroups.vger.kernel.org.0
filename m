Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C46E17591E
	for <lists+cgroups@lfdr.de>; Mon,  2 Mar 2020 12:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgCBLDE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Mar 2020 06:03:04 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:35284 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727911AbgCBLDE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Mar 2020 06:03:04 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0TrRgpkM_1583146857;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TrRgpkM_1583146857)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 02 Mar 2020 19:00:57 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     cgroups@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 09/20] mm/mlock: ClearPageLRU before get lru lock in munlock page isolation
Date:   Mon,  2 Mar 2020 19:00:19 +0800
Message-Id: <1583146830-169516-10-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1583146830-169516-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1583146830-169516-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This is one of effort to split the PageLRU clear from old page
isolation.

This patch move the lru_lock after TestClearPageLRU, which takes holding
PageLRU as precondition for page isolation, as a preparation for later
lru_lock replacment. So we have to unfold __munlock_isolate_lru_page.

__split_huge_page_refcount doesn't exist, but we still have to guard
PageMlocked in __split_huge_page_tail. That make code ugly.
Anyway we still remove 2 gotos.

[lkp@intel.com: found a sleeping function bug ... at mm/rmap.c:1861]
Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/mlock.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 03b3a5d99ad7..7ddc52ca14b1 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -181,6 +181,7 @@ static void __munlock_isolation_failed(struct page *page)
 unsigned int munlock_vma_page(struct page *page)
 {
 	int nr_pages;
+	bool clearlru = false;
 	pg_data_t *pgdat = page_pgdat(page);
 
 	/* For try_to_munlock() and to serialize with page migration */
@@ -189,32 +190,42 @@ unsigned int munlock_vma_page(struct page *page)
 	VM_BUG_ON_PAGE(PageTail(page), page);
 
 	/*
-	 * Serialize with any parallel __split_huge_page_refcount() which
+	 * Serialize with any parallel __split_huge_page_tail() which
 	 * might otherwise copy PageMlocked to part of the tail pages before
 	 * we clear it in the head page. It also stabilizes hpage_nr_pages().
 	 */
+	get_page(page);
+	clearlru = TestClearPageLRU(page);
 	spin_lock_irq(&pgdat->lru_lock);
 
 	if (!TestClearPageMlocked(page)) {
-		/* Potentially, PTE-mapped THP: do not skip the rest PTEs */
-		nr_pages = 1;
-		goto unlock_out;
+		if (clearlru)
+			SetPageLRU(page);
+		/*
+		 * Potentially, PTE-mapped THP: do not skip the rest PTEs
+		 * Reuse lock as memory barrier for release_pages racing.
+		 */
+		spin_unlock_irq(&pgdat->lru_lock);
+		put_page(page);
+		return 0;
 	}
 
 	nr_pages = hpage_nr_pages(page);
 	__mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
 
-	if (__munlock_isolate_lru_page(page, true)) {
+	if (clearlru) {
+		struct lruvec *lruvec;
+
+		lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
+		del_page_from_lru_list(page, lruvec, page_lru(page));
 		spin_unlock_irq(&pgdat->lru_lock);
 		__munlock_isolated_page(page);
-		goto out;
+	} else {
+		spin_unlock_irq(&pgdat->lru_lock);
+		put_page(page);
+		__munlock_isolation_failed(page);
 	}
-	__munlock_isolation_failed(page);
-
-unlock_out:
-	spin_unlock_irq(&pgdat->lru_lock);
 
-out:
 	return nr_pages - 1;
 }
 
@@ -323,8 +334,8 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
 		pagevec_add(&pvec_putback, pvec->pages[i]);
 		pvec->pages[i] = NULL;
 	}
-	__mod_zone_page_state(zone, NR_MLOCK, delta_munlocked);
 	spin_unlock_irq(&zone->zone_pgdat->lru_lock);
+	__mod_zone_page_state(zone, NR_MLOCK, delta_munlocked);
 
 	/* Now we can release pins of pages that we are not munlocking */
 	pagevec_release(&pvec_putback);
-- 
1.8.3.1


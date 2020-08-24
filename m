Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD5B24FE3C
	for <lists+cgroups@lfdr.de>; Mon, 24 Aug 2020 14:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgHXM5E (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Aug 2020 08:57:04 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:56632 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727836AbgHXMzb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 Aug 2020 08:55:31 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04392;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0U6k9-bl_1598273712;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U6k9-bl_1598273712)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 24 Aug 2020 20:55:22 +0800
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
Subject: [PATCH v18 25/32] mm/mlock: remove lru_lock on TestClearPageMlocked in munlock_vma_page
Date:   Mon, 24 Aug 2020 20:54:58 +0800
Message-Id: <1598273705-69124-26-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

In the func munlock_vma_page, the page must be PageLocked as well as
pages in split_huge_page series funcs. Thus the PageLocked is enough
to serialize both funcs.

So we could relief the TestClearPageMlocked/hpage_nr_pages which are not
necessary under lru lock.

As to another munlock func __munlock_pagevec, which no PageLocked
protection and should remain lru protecting.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/mlock.c | 41 +++++++++++++++--------------------------
 1 file changed, 15 insertions(+), 26 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 0448409184e3..46a05e6ec5ba 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -69,9 +69,9 @@ void clear_page_mlock(struct page *page)
 	 *
 	 * See __pagevec_lru_add_fn for more explanation.
 	 */
-	if (!isolate_lru_page(page)) {
+	if (!isolate_lru_page(page))
 		putback_lru_page(page);
-	} else {
+	else {
 		/*
 		 * We lost the race. the page already moved to evictable list.
 		 */
@@ -178,7 +178,6 @@ static void __munlock_isolation_failed(struct page *page)
 unsigned int munlock_vma_page(struct page *page)
 {
 	int nr_pages;
-	struct lruvec *lruvec;
 
 	/* For try_to_munlock() and to serialize with page migration */
 	BUG_ON(!PageLocked(page));
@@ -186,37 +185,22 @@ unsigned int munlock_vma_page(struct page *page)
 	VM_BUG_ON_PAGE(PageTail(page), page);
 
 	/*
-	 * Serialize split tail pages in __split_huge_page_tail() which
-	 * might otherwise copy PageMlocked to part of the tail pages before
-	 * we clear it in the head page. It also stabilizes thp_nr_pages().
-	 * TestClearPageLRU can't be used here to block page isolation, since
-	 * out of lock clear_page_mlock may interfer PageLRU/PageMlocked
-	 * sequence, same as __pagevec_lru_add_fn, and lead the page place to
-	 * wrong lru list here. So relay on PageLocked to stop lruvec change
-	 * in mem_cgroup_move_account().
+	 * Serialize split tail pages in __split_huge_page_tail() by
+	 * lock_page(); Do TestClearPageMlocked/PageLRU sequence like
+	 * clear_page_mlock().
 	 */
-	lruvec = lock_page_lruvec_irq(page);
-
-	if (!TestClearPageMlocked(page)) {
+	if (!TestClearPageMlocked(page))
 		/* Potentially, PTE-mapped THP: do not skip the rest PTEs */
-		nr_pages = 1;
-		goto unlock_out;
-	}
+		return 0;
 
 	nr_pages = thp_nr_pages(page);
 	__mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
 
-	if (__munlock_isolate_lru_page(page, lruvec, true)) {
-		unlock_page_lruvec_irq(lruvec);
+	if (!isolate_lru_page(page))
 		__munlock_isolated_page(page);
-		goto out;
-	}
-	__munlock_isolation_failed(page);
-
-unlock_out:
-	unlock_page_lruvec_irq(lruvec);
+	else
+		__munlock_isolation_failed(page);
 
-out:
 	return nr_pages - 1;
 }
 
@@ -305,6 +289,11 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
 
 		/* block memcg change in mem_cgroup_move_account */
 		lock_page_memcg(page);
+		/*
+		 * Serialize split tail pages in __split_huge_page_tail() which
+		 * might otherwise copy PageMlocked to part of the tail pages
+		 * before we clear it in the head page.
+		 */
 		lruvec = relock_page_lruvec_irq(page, lruvec);
 		if (TestClearPageMlocked(page)) {
 			/*
-- 
1.8.3.1


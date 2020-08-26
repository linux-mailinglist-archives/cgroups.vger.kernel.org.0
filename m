Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21207252699
	for <lists+cgroups@lfdr.de>; Wed, 26 Aug 2020 07:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbgHZFx4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Aug 2020 01:53:56 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:34979 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725928AbgHZFxz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Aug 2020 01:53:55 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01353;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0U6tzIW8_1598421228;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U6tzIW8_1598421228)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 26 Aug 2020 13:53:49 +0800
Subject: Re: [PATCH v18 25/32] mm/mlock: remove lru_lock on
 TestClearPageMlocked in munlock_vma_page
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
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
 <1598273705-69124-26-git-send-email-alex.shi@linux.alibaba.com>
Message-ID: <b184e732-35b9-e6bb-e665-e7bea51b9a42@linux.alibaba.com>
Date:   Wed, 26 Aug 2020 13:52:18 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1598273705-69124-26-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

LKP reported a preemptiable issue on this patch. update and refresh
the commit log.

From f18e8c87a045bbb8040006b6816ded1f55fa6f9c Mon Sep 17 00:00:00 2001
From: Alex Shi <alex.shi@linux.alibaba.com>
Date: Sat, 25 Jul 2020 22:31:03 +0800
Subject: [PATCH] mm/mlock: remove lru_lock on TestClearPageMlocked in
 munlock_vma_page

In the func munlock_vma_page, comments mentained lru_lock needed for
serialization with split_huge_pages. But the page must be PageLocked
as well as pages in split_huge_page series funcs. Thus the PageLocked
is enough to serialize both funcs.

So we could relief the TestClearPageMlocked/hpage_nr_pages which are not
necessary under lru lock.

As to another munlock func __munlock_pagevec, which no PageLocked
protection and should remain lru protecting.

LKP found a preempt issue on __mod_zone_page_state which need change
to mod_zone_page_state. Thanks!

Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/mlock.c | 43 ++++++++++++++++---------------------------
 1 file changed, 16 insertions(+), 27 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 0448409184e3..cd88b93b0f0d 100644
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
-	__mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
+	mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
 
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
2.17.1


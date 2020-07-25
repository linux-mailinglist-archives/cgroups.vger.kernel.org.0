Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04E222D7BE
	for <lists+cgroups@lfdr.de>; Sat, 25 Jul 2020 15:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgGYNBJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 25 Jul 2020 09:01:09 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:48897 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727087AbgGYNAc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 25 Jul 2020 09:00:32 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0U3l6fmD_1595682015;
Received: from aliy8.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U3l6fmD_1595682015)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 25 Jul 2020 21:00:26 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: [PATCH v17 13/21] mm/lru: introduce TestClearPageLRU
Date:   Sat, 25 Jul 2020 20:59:50 +0800
Message-Id: <1595681998-19193-14-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently lru_lock still guards both lru list and page's lru bit, that's
ok. but if we want to use specific lruvec lock on the page, we need to
pin down the page's lruvec/memcg during locking. Just taking lruvec
lock first may be undermined by the page's memcg charge/migration. To
fix this problem, we could clear the lru bit out of locking and use
it as pin down action to block the page isolation in memcg changing.
So now we do page isolating by both actions:
	TestClearPageLRU and hold the lru_lock.

This patch start with the first part: TestClearPageLRU, which combines
PageLRU check and ClearPageLRU into a macro func TestClearPageLRU. This
function will be used as page isolation precondition to prevent other
isolations some where else. Then there are may !PageLRU page on lru
list, need to remove BUG() checking accordingly.

There 2 rules for lru bit now:
1, the lru bit still indicate if a page on lru list, just in some
   temporary moment(isolating), the page may have no lru bit when
   it's on lru list.  but the page still must be on lru list when the
   lru bit set.
2, have to remove lru bit before delete it from lru list.

Hugh Dickins pointed that when a page is in free path and no one is
possible to take it, non atomic lru bit clearing is better, like in
__page_cache_release and release_pages.
And no need get_page() before lru bit clear in isolate_lru_page,
since it '(1) Must be called with an elevated refcount on the page'.

As Andrew Morton mentioned this change would dirty cacheline for page
isn't on LRU. But the lost would be acceptable with Rong Chen
<rong.a.chen@intel.com> report:
https://lkml.org/lkml/2020/3/4/173

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/page-flags.h |  1 +
 mm/mlock.c                 |  3 +--
 mm/swap.c                  |  6 ++----
 mm/vmscan.c                | 18 +++++++-----------
 4 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 6be1aa559b1e..9554ed1387dc 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -326,6 +326,7 @@ static inline void page_init_poison(struct page *page, size_t size)
 PAGEFLAG(Dirty, dirty, PF_HEAD) TESTSCFLAG(Dirty, dirty, PF_HEAD)
 	__CLEARPAGEFLAG(Dirty, dirty, PF_HEAD)
 PAGEFLAG(LRU, lru, PF_HEAD) __CLEARPAGEFLAG(LRU, lru, PF_HEAD)
+	TESTCLEARFLAG(LRU, lru, PF_HEAD)
 PAGEFLAG(Active, active, PF_HEAD) __CLEARPAGEFLAG(Active, active, PF_HEAD)
 	TESTCLEARFLAG(Active, active, PF_HEAD)
 PAGEFLAG(Workingset, workingset, PF_HEAD)
diff --git a/mm/mlock.c b/mm/mlock.c
index f8736136fad7..228ba5a8e0a5 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -108,13 +108,12 @@ void mlock_vma_page(struct page *page)
  */
 static bool __munlock_isolate_lru_page(struct page *page, bool getpage)
 {
-	if (PageLRU(page)) {
+	if (TestClearPageLRU(page)) {
 		struct lruvec *lruvec;
 
 		lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
 		if (getpage)
 			get_page(page);
-		ClearPageLRU(page);
 		del_page_from_lru_list(page, lruvec, page_lru(page));
 		return true;
 	}
diff --git a/mm/swap.c b/mm/swap.c
index f645965fde0e..5092fe9c8c47 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -83,10 +83,9 @@ static void __page_cache_release(struct page *page)
 		struct lruvec *lruvec;
 		unsigned long flags;
 
+		__ClearPageLRU(page);
 		spin_lock_irqsave(&pgdat->lru_lock, flags);
 		lruvec = mem_cgroup_page_lruvec(page, pgdat);
-		VM_BUG_ON_PAGE(!PageLRU(page), page);
-		__ClearPageLRU(page);
 		del_page_from_lru_list(page, lruvec, page_off_lru(page));
 		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
 	}
@@ -878,9 +877,8 @@ void release_pages(struct page **pages, int nr)
 				spin_lock_irqsave(&locked_pgdat->lru_lock, flags);
 			}
 
-			lruvec = mem_cgroup_page_lruvec(page, locked_pgdat);
-			VM_BUG_ON_PAGE(!PageLRU(page), page);
 			__ClearPageLRU(page);
+			lruvec = mem_cgroup_page_lruvec(page, locked_pgdat);
 			del_page_from_lru_list(page, lruvec, page_off_lru(page));
 		}
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c1c4259b4de5..4183ae6b54b5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1671,8 +1671,6 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
 		page = lru_to_page(src);
 		prefetchw_prev_lru_page(page, src, flags);
 
-		VM_BUG_ON_PAGE(!PageLRU(page), page);
-
 		nr_pages = compound_nr(page);
 		total_scan += nr_pages;
 
@@ -1769,21 +1767,19 @@ int isolate_lru_page(struct page *page)
 	VM_BUG_ON_PAGE(!page_count(page), page);
 	WARN_RATELIMIT(PageTail(page), "trying to isolate tail page");
 
-	if (PageLRU(page)) {
+	if (TestClearPageLRU(page)) {
 		pg_data_t *pgdat = page_pgdat(page);
 		struct lruvec *lruvec;
+		int lru = page_lru(page);
 
-		spin_lock_irq(&pgdat->lru_lock);
+		get_page(page);
 		lruvec = mem_cgroup_page_lruvec(page, pgdat);
-		if (PageLRU(page)) {
-			int lru = page_lru(page);
-			get_page(page);
-			ClearPageLRU(page);
-			del_page_from_lru_list(page, lruvec, lru);
-			ret = 0;
-		}
+		spin_lock_irq(&pgdat->lru_lock);
+		del_page_from_lru_list(page, lruvec, lru);
 		spin_unlock_irq(&pgdat->lru_lock);
+		ret = 0;
 	}
+
 	return ret;
 }
 
-- 
1.8.3.1


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C6D1F619E
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2020 08:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgFKGRa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 11 Jun 2020 02:17:30 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:60321 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726573AbgFKGRS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 11 Jun 2020 02:17:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0U.EtHpx_1591856228;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U.EtHpx_1591856228)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Jun 2020 14:17:09 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: [PATCH v12 09/16] mm/lru: introduce TestClearPageLRU
Date:   Thu, 11 Jun 2020 14:16:42 +0800
Message-Id: <1591856209-166869-10-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1591856209-166869-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1591856209-166869-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Combine PageLRU check and ClearPageLRU into a function by new
introduced func TestClearPageLRU. This function will be used as page
isolation precondition to prevent other isolations some where else.

Then there are may non PageLRU page on lru list, need to remove BUG
checking accordingly.

As Andrew Morton mentioned this change would dirty cacheline for page
isn't on LRU. But the lost would be acceptable with Rong Chen
<rong.a.chen@intel.com> report:
https://lkml.org/lkml/2020/3/4/173

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
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
 mm/swap.c                  |  8 ++------
 mm/vmscan.c                | 29 +++++++++++++----------------
 4 files changed, 17 insertions(+), 24 deletions(-)

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
index 41cc329aa842..d0516efdde47 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -78,15 +78,13 @@ static DEFINE_PER_CPU(struct lru_pvecs, lru_pvecs) = {
  */
 static void __page_cache_release(struct page *page)
 {
-	if (PageLRU(page)) {
+	if (TestClearPageLRU(page)) {
 		pg_data_t *pgdat = page_pgdat(page);
 		struct lruvec *lruvec;
 		unsigned long flags;
 
 		spin_lock_irqsave(&pgdat->lru_lock, flags);
 		lruvec = mem_cgroup_page_lruvec(page, pgdat);
-		VM_BUG_ON_PAGE(!PageLRU(page), page);
-		__ClearPageLRU(page);
 		del_page_from_lru_list(page, lruvec, page_off_lru(page));
 		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
 	}
@@ -881,7 +879,7 @@ void release_pages(struct page **pages, int nr)
 			continue;
 		}
 
-		if (PageLRU(page)) {
+		if (TestClearPageLRU(page)) {
 			struct pglist_data *pgdat = page_pgdat(page);
 
 			if (pgdat != locked_pgdat) {
@@ -894,8 +892,6 @@ void release_pages(struct page **pages, int nr)
 			}
 
 			lruvec = mem_cgroup_page_lruvec(page, locked_pgdat);
-			VM_BUG_ON_PAGE(!PageLRU(page), page);
-			__ClearPageLRU(page);
 			del_page_from_lru_list(page, lruvec, page_off_lru(page));
 		}
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 81228334f7d6..08910ca9fa40 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1547,16 +1547,16 @@ int __isolate_lru_page(struct page *page, isolate_mode_t mode)
 {
 	int ret = -EINVAL;
 
-	/* Only take pages on the LRU. */
-	if (!PageLRU(page))
-		return ret;
-
 	/* Compaction should not handle unevictable pages but CMA can do so */
 	if (PageUnevictable(page) && !(mode & ISOLATE_UNEVICTABLE))
 		return ret;
 
 	ret = -EBUSY;
 
+	/* Only take pages on the LRU. */
+	if (!PageLRU(page))
+		return ret;
+
 	/*
 	 * To minimise LRU disruption, the caller can indicate that it only
 	 * wants to isolate pages it will be able to operate on without
@@ -1670,8 +1670,6 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
 		page = lru_to_page(src);
 		prefetchw_prev_lru_page(page, src, flags);
 
-		VM_BUG_ON_PAGE(!PageLRU(page), page);
-
 		nr_pages = compound_nr(page);
 		total_scan += nr_pages;
 
@@ -1768,21 +1766,20 @@ int isolate_lru_page(struct page *page)
 	VM_BUG_ON_PAGE(!page_count(page), page);
 	WARN_RATELIMIT(PageTail(page), "trying to isolate tail page");
 
-	if (PageLRU(page)) {
+	get_page(page);
+	if (TestClearPageLRU(page)) {
 		pg_data_t *pgdat = page_pgdat(page);
 		struct lruvec *lruvec;
+		int lru = page_lru(page);
 
-		spin_lock_irq(&pgdat->lru_lock);
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
-	}
+		ret = 0;
+	} else
+		put_page(page);
+
 	return ret;
 }
 
-- 
1.8.3.1


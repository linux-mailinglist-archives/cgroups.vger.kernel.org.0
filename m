Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1E124FE2D
	for <lists+cgroups@lfdr.de>; Mon, 24 Aug 2020 14:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgHXMzj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Aug 2020 08:55:39 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:11582 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726968AbgHXMzg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 Aug 2020 08:55:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0U6k9-bl_1598273712;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U6k9-bl_1598273712)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 24 Aug 2020 20:55:20 +0800
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
Subject: [PATCH v18 19/32] mm/swap.c: serialize memcg changes in pagevec_lru_move_fn
Date:   Mon, 24 Aug 2020 20:54:52 +0800
Message-Id: <1598273705-69124-20-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hugh Dickins' found a memcg change bug on original version:
If we want to change the pgdat->lru_lock to memcg's lruvec lock, we have
to serialize mem_cgroup_move_account during pagevec_lru_move_fn. The
possible bad scenario would like:

	cpu 0					cpu 1
lruvec = mem_cgroup_page_lruvec()
					if (!isolate_lru_page())
						mem_cgroup_move_account

spin_lock_irqsave(&lruvec->lru_lock <== wrong lock.

So we need the ClearPageLRU to block isolate_lru_page(), that serializes
the memcg change. and then removing the PageLRU check in move_fn callee
as the consequence.

Reported-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/swap.c | 44 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 446ffe280809..2d9a86bf93a4 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -221,8 +221,14 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
 			spin_lock_irqsave(&pgdat->lru_lock, flags);
 		}
 
+		/* block memcg migration during page moving between lru */
+		if (!TestClearPageLRU(page))
+			continue;
+
 		lruvec = mem_cgroup_page_lruvec(page, pgdat);
 		(*move_fn)(page, lruvec);
+
+		SetPageLRU(page);
 	}
 	if (pgdat)
 		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
@@ -232,7 +238,7 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
 
 static void pagevec_move_tail_fn(struct page *page, struct lruvec *lruvec)
 {
-	if (PageLRU(page) && !PageUnevictable(page)) {
+	if (!PageUnevictable(page)) {
 		del_page_from_lru_list(page, lruvec, page_lru(page));
 		ClearPageActive(page);
 		add_page_to_lru_list_tail(page, lruvec, page_lru(page));
@@ -306,7 +312,7 @@ void lru_note_cost_page(struct page *page)
 
 static void __activate_page(struct page *page, struct lruvec *lruvec)
 {
-	if (PageLRU(page) && !PageActive(page) && !PageUnevictable(page)) {
+	if (!PageActive(page) && !PageUnevictable(page)) {
 		int lru = page_lru_base_type(page);
 		int nr_pages = thp_nr_pages(page);
 
@@ -362,7 +368,8 @@ void activate_page(struct page *page)
 
 	page = compound_head(page);
 	spin_lock_irq(&pgdat->lru_lock);
-	__activate_page(page, mem_cgroup_page_lruvec(page, pgdat));
+	if (PageLRU(page))
+		__activate_page(page, mem_cgroup_page_lruvec(page, pgdat));
 	spin_unlock_irq(&pgdat->lru_lock);
 }
 #endif
@@ -521,9 +528,6 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec)
 	bool active;
 	int nr_pages = thp_nr_pages(page);
 
-	if (!PageLRU(page))
-		return;
-
 	if (PageUnevictable(page))
 		return;
 
@@ -564,7 +568,7 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec)
 
 static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec)
 {
-	if (PageLRU(page) && PageActive(page) && !PageUnevictable(page)) {
+	if (PageActive(page) && !PageUnevictable(page)) {
 		int lru = page_lru_base_type(page);
 		int nr_pages = thp_nr_pages(page);
 
@@ -581,7 +585,7 @@ static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec)
 
 static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec)
 {
-	if (PageLRU(page) && PageAnon(page) && PageSwapBacked(page) &&
+	if (PageAnon(page) && PageSwapBacked(page) &&
 	    !PageSwapCache(page) && !PageUnevictable(page)) {
 		bool active = PageActive(page);
 		int nr_pages = thp_nr_pages(page);
@@ -979,7 +983,29 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
  */
 void __pagevec_lru_add(struct pagevec *pvec)
 {
-	pagevec_lru_move_fn(pvec, __pagevec_lru_add_fn);
+	int i;
+	struct pglist_data *pgdat = NULL;
+	struct lruvec *lruvec;
+	unsigned long flags = 0;
+
+	for (i = 0; i < pagevec_count(pvec); i++) {
+		struct page *page = pvec->pages[i];
+		struct pglist_data *pagepgdat = page_pgdat(page);
+
+		if (pagepgdat != pgdat) {
+			if (pgdat)
+				spin_unlock_irqrestore(&pgdat->lru_lock, flags);
+			pgdat = pagepgdat;
+			spin_lock_irqsave(&pgdat->lru_lock, flags);
+		}
+
+		lruvec = mem_cgroup_page_lruvec(page, pgdat);
+		__pagevec_lru_add_fn(page, lruvec);
+	}
+	if (pgdat)
+		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
+	release_pages(pvec->pages, pvec->nr);
+	pagevec_reinit(pvec);
 }
 
 /**
-- 
1.8.3.1


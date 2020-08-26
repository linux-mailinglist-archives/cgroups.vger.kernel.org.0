Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76732529BD
	for <lists+cgroups@lfdr.de>; Wed, 26 Aug 2020 11:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgHZJJa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Aug 2020 05:09:30 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:38375 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727122AbgHZJJa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Aug 2020 05:09:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0U6v-68g_1598432963;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U6v-68g_1598432963)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 26 Aug 2020 17:09:24 +0800
Subject: Re: [PATCH v18 27/32] mm/swap.c: optimizing __pagevec_lru_add
 lru_lock
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
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
 <1598273705-69124-28-git-send-email-alex.shi@linux.alibaba.com>
Message-ID: <57cea811-13bd-c026-01dc-69bd9eafa014@linux.alibaba.com>
Date:   Wed, 26 Aug 2020 17:07:53 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1598273705-69124-28-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The patch need update since a bug found.

From 547d95205e666c7c5a81c44b7b1f8e1b6c7b1749 Mon Sep 17 00:00:00 2001
From: Alex Shi <alex.shi@linux.alibaba.com>
Date: Sat, 1 Aug 2020 22:49:31 +0800
Subject: [PATCH] mm/swap.c: optimizing __pagevec_lru_add lru_lock

The current relock logical will change lru_lock when if found a new
lruvec, so if 2 memcgs are reading file or alloc page equally, they
could hold the lru_lock alternately.

This patch will record the needed lru_lock and only hold them once in
above scenario. That could reduce the lock contention.

Suggested-by: Konstantin Khlebnikov <koct9i@gmail.com>
Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/swap.c | 42 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 2ac78e8fab71..dba3f0aba2a0 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -958,24 +958,52 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
 	trace_mm_lru_insertion(page, lru);
 }
 
+struct add_lruvecs {
+	struct list_head lists[PAGEVEC_SIZE];
+	struct lruvec *vecs[PAGEVEC_SIZE];
+};
+
 /*
  * Add the passed pages to the LRU, then drop the caller's refcount
  * on them.  Reinitialises the caller's pagevec.
  */
 void __pagevec_lru_add(struct pagevec *pvec)
 {
-	int i;
+	int i, j, total;
 	struct lruvec *lruvec = NULL;
 	unsigned long flags = 0;
+	struct page *page;
+	struct add_lruvecs lruvecs;
+
+	for (i = total = 0; i < pagevec_count(pvec); i++) {
+		page = pvec->pages[i];
+		lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
+		lruvecs.vecs[i] = NULL;
+
+		/* Try to find a same lruvec */
+		for (j = 0; j < total; j++)
+			if (lruvec == lruvecs.vecs[j])
+				break;
+		/* A new lruvec */
+		if (j == total) {
+			INIT_LIST_HEAD(&lruvecs.lists[total]);
+			lruvecs.vecs[total] = lruvec;
+			total++;
+		}
 
-	for (i = 0; i < pagevec_count(pvec); i++) {
-		struct page *page = pvec->pages[i];
+		list_add(&page->lru, &lruvecs.lists[j]);
+	}
 
-		lruvec = relock_page_lruvec_irqsave(page, lruvec, &flags);
-		__pagevec_lru_add_fn(page, lruvec);
+	for (i = 0; i < total; i++) {
+		spin_lock_irqsave(&lruvecs.vecs[i]->lru_lock, flags);
+		while (!list_empty(&lruvecs.lists[i])) {
+			page = lru_to_page(&lruvecs.lists[i]);
+			list_del(&page->lru);
+			__pagevec_lru_add_fn(page, lruvecs.vecs[i]);
+		}
+		spin_unlock_irqrestore(&lruvecs.vecs[i]->lru_lock, flags);
 	}
-	if (lruvec)
-		unlock_page_lruvec_irqrestore(lruvec, flags);
+
 	release_pages(pvec->pages, pvec->nr);
 	pagevec_reinit(pvec);
 }
-- 
1.8.3.1


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2E995B7D
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2019 11:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbfHTJto (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Aug 2019 05:49:44 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:54383 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729699AbfHTJto (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Aug 2019 05:49:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Ta-6uif_1566294573;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0Ta-6uif_1566294573)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 20 Aug 2019 17:49:33 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: [PATCH 03/14] lru/memcg: using per lruvec lock in un/lock_page_lru
Date:   Tue, 20 Aug 2019 17:48:26 +0800
Message-Id: <1566294517-86418-4-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1566294517-86418-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1566294517-86418-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Now we repeatly assign the lruvec->pgdat in memcg. Will remove the
assignment in lruvec getting function after very points are protected.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/memcontrol.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e8a1b0d95ba8..19fd911e8098 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2550,12 +2550,12 @@ static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
 static void lock_page_lru(struct page *page, int *isolated)
 {
 	pg_data_t *pgdat = page_pgdat(page);
+	struct lruvec *lruvec = mem_cgroup_page_lruvec(page, pgdat);
 
-	spin_lock_irq(&pgdat->lruvec.lru_lock);
+	spin_lock_irq(&lruvec->lru_lock);
+	sync_lruvec_pgdat(lruvec, pgdat);
 	if (PageLRU(page)) {
-		struct lruvec *lruvec;
 
-		lruvec = mem_cgroup_page_lruvec(page, pgdat);
 		ClearPageLRU(page);
 		del_page_from_lru_list(page, lruvec, page_lru(page));
 		*isolated = 1;
@@ -2566,16 +2566,14 @@ static void lock_page_lru(struct page *page, int *isolated)
 static void unlock_page_lru(struct page *page, int isolated)
 {
 	pg_data_t *pgdat = page_pgdat(page);
+	struct lruvec *lruvec = mem_cgroup_page_lruvec(page, pgdat);
 
 	if (isolated) {
-		struct lruvec *lruvec;
-
-		lruvec = mem_cgroup_page_lruvec(page, pgdat);
 		VM_BUG_ON_PAGE(PageLRU(page), page);
 		SetPageLRU(page);
 		add_page_to_lru_list(page, lruvec, page_lru(page));
 	}
-	spin_unlock_irq(&pgdat->lruvec.lru_lock);
+	spin_unlock_irq(&lruvec->lru_lock);
 }
 
 static void commit_charge(struct page *page, struct mem_cgroup *memcg,
-- 
1.8.3.1


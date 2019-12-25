Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A67112A6E6
	for <lists+cgroups@lfdr.de>; Wed, 25 Dec 2019 10:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfLYJFF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 Dec 2019 04:05:05 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:37105 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726461AbfLYJFE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 Dec 2019 04:05:04 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0TltPEgn_1577264680;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TltPEgn_1577264680)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 25 Dec 2019 17:04:41 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        shakeelb@google.com, hannes@cmpxchg.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: [PATCH v7 02/10] mm/memcg: fold lru_lock in lock_page_lru
Date:   Wed, 25 Dec 2019 17:04:18 +0800
Message-Id: <1577264666-246071-3-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1577264666-246071-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1577264666-246071-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From the commit_charge's explanations and mem_cgroup_commit_charge
comments, as well as call path when lrucare is ture, The lru_lock is
just to guard the task migration(which would be lead to move_account)
So it isn't needed when !PageLRU, and better be fold into PageLRU to
reduce lock contentions.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/memcontrol.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c5b5f74cfd4d..0ad10caabc3d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2572,12 +2572,11 @@ static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
 
 static void lock_page_lru(struct page *page, int *isolated)
 {
-	pg_data_t *pgdat = page_pgdat(page);
-
-	spin_lock_irq(&pgdat->lru_lock);
 	if (PageLRU(page)) {
+		pg_data_t *pgdat = page_pgdat(page);
 		struct lruvec *lruvec;
 
+		spin_lock_irq(&pgdat->lru_lock);
 		lruvec = mem_cgroup_page_lruvec(page, pgdat);
 		ClearPageLRU(page);
 		del_page_from_lru_list(page, lruvec, page_lru(page));
@@ -2588,17 +2587,17 @@ static void lock_page_lru(struct page *page, int *isolated)
 
 static void unlock_page_lru(struct page *page, int isolated)
 {
-	pg_data_t *pgdat = page_pgdat(page);
 
 	if (isolated) {
+		pg_data_t *pgdat = page_pgdat(page);
 		struct lruvec *lruvec;
 
 		lruvec = mem_cgroup_page_lruvec(page, pgdat);
 		VM_BUG_ON_PAGE(PageLRU(page), page);
 		SetPageLRU(page);
 		add_page_to_lru_list(page, lruvec, page_lru(page));
+		spin_unlock_irq(&pgdat->lru_lock);
 	}
-	spin_unlock_irq(&pgdat->lru_lock);
 }
 
 static void commit_charge(struct page *page, struct mem_cgroup *memcg,
-- 
1.8.3.1


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65A6B120125
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2019 10:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfLPJ2R (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Dec 2019 04:28:17 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:59751 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727067AbfLPJ2R (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Dec 2019 04:28:17 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0Tl3i.ek_1576488441;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0Tl3i.ek_1576488441)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 16 Dec 2019 17:27:21 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        shakeelb@google.com, hannes@cmpxchg.org
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: [PATCH v6 09/10] mm/memcg: fold lock in lock_page_lru
Date:   Mon, 16 Dec 2019 17:26:25 +0800
Message-Id: <1576488386-32544-10-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576488386-32544-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1576488386-32544-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

According to the calling path of commit_charge, the lrucare is bound
with PageLRU, so we could just fold it under PageLRU. This has no
functional change.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/memcontrol.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 138f298b694f..f8e279487e1d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2621,9 +2621,10 @@ static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
 
 static struct lruvec *lock_page_lru(struct page *page, int *isolated)
 {
-	struct lruvec *lruvec = lock_page_lruvec_irq(page);
+	struct lruvec *lruvec = NULL;
 
 	if (PageLRU(page)) {
+		lruvec = lock_page_lruvec_irq(page);
 
 		ClearPageLRU(page);
 		del_page_from_lru_list(page, lruvec, page_lru(page));
@@ -2637,17 +2638,18 @@ static struct lruvec *lock_page_lru(struct page *page, int *isolated)
 static void unlock_page_lru(struct page *page, int isolated,
 				struct lruvec *locked_lruvec)
 {
-	struct lruvec *lruvec;
+	if (isolated) {
+		struct lruvec *lruvec;
 
-	unlock_page_lruvec_irq(locked_lruvec);
-	lruvec = lock_page_lruvec_irq(page);
+		if (locked_lruvec)
+			unlock_page_lruvec_irq(locked_lruvec);
+		lruvec = lock_page_lruvec_irq(page);
 
-	if (isolated) {
 		VM_BUG_ON_PAGE(PageLRU(page), page);
 		SetPageLRU(page);
 		add_page_to_lru_list(page, lruvec, page_lru(page));
+		unlock_page_lruvec_irq(lruvec);
 	}
-	unlock_page_lruvec_irq(lruvec);
 }
 
 static void commit_charge(struct page *page, struct mem_cgroup *memcg,
-- 
1.8.3.1


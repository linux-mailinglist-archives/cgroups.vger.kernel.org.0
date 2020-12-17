Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8532DCC7F
	for <lists+cgroups@lfdr.de>; Thu, 17 Dec 2020 07:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgLQG3q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Dec 2020 01:29:46 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:50590 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726862AbgLQG3q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Dec 2020 01:29:46 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UItliQ7_1608186540;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UItliQ7_1608186540)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Dec 2020 14:29:01 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mm/memcg: remove rcu locking for lock_page_lruvec function series
Date:   Thu, 17 Dec 2020 14:28:51 +0800
Message-Id: <1608186532-81218-2-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1608186532-81218-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1608186532-81218-1-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The rcu_read_lock was used to block memcg destory, but with the detailed
calling conditions, the memcg won't gone since the page is hold. So we
don't need it now, let's remove them to save locking load in debugging.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/memcontrol.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e6b50d068b2f..98bbee1d2faf 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1356,10 +1356,8 @@ struct lruvec *lock_page_lruvec(struct page *page)
 	struct lruvec *lruvec;
 	struct pglist_data *pgdat = page_pgdat(page);
 
-	rcu_read_lock();
 	lruvec = mem_cgroup_page_lruvec(page, pgdat);
 	spin_lock(&lruvec->lru_lock);
-	rcu_read_unlock();
 
 	lruvec_memcg_debug(lruvec, page);
 
@@ -1371,10 +1369,8 @@ struct lruvec *lock_page_lruvec_irq(struct page *page)
 	struct lruvec *lruvec;
 	struct pglist_data *pgdat = page_pgdat(page);
 
-	rcu_read_lock();
 	lruvec = mem_cgroup_page_lruvec(page, pgdat);
 	spin_lock_irq(&lruvec->lru_lock);
-	rcu_read_unlock();
 
 	lruvec_memcg_debug(lruvec, page);
 
@@ -1386,10 +1382,8 @@ struct lruvec *lock_page_lruvec_irqsave(struct page *page, unsigned long *flags)
 	struct lruvec *lruvec;
 	struct pglist_data *pgdat = page_pgdat(page);
 
-	rcu_read_lock();
 	lruvec = mem_cgroup_page_lruvec(page, pgdat);
 	spin_lock_irqsave(&lruvec->lru_lock, *flags);
-	rcu_read_unlock();
 
 	lruvec_memcg_debug(lruvec, page);
 
-- 
2.29.GIT


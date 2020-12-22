Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58DF62E0597
	for <lists+cgroups@lfdr.de>; Tue, 22 Dec 2020 06:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgLVFVr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Dec 2020 00:21:47 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:35224 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725782AbgLVFVr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Dec 2020 00:21:47 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UJPqUQy_1608614460;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UJPqUQy_1608614460)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 22 Dec 2020 13:21:00 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     hughd@google.com
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] mm/memcg: remove rcu locking for lock_page_lruvec function series
Date:   Tue, 22 Dec 2020 13:20:52 +0800
Message-Id: <1608614453-10739-2-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1608614453-10739-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1608614453-10739-1-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

lock_page_lruvec() and its variants used rcu_read_lock() with the
intention of safeguarding against the mem_cgroup being destroyed
concurrently; but so long as they are called under the specified
conditions (as they are), there is no way for the page's mem_cgroup
to be destroyed.  Delete the unnecessary rcu_read_lock() and _unlock().

Hugh Dickin's polished the commit log, Thanks a lot!

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Acked-by: Hugh Dickins <hughd@google.com>
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
index 8d400efc81b9..0af13c4fe4b3 100644
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


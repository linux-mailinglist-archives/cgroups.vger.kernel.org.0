Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5E712A6EE
	for <lists+cgroups@lfdr.de>; Wed, 25 Dec 2019 10:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfLYJFS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 Dec 2019 04:05:18 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:43667 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726025AbfLYJEt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 Dec 2019 04:04:49 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0TltG7dO_1577264684;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TltG7dO_1577264684)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 25 Dec 2019 17:04:45 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        shakeelb@google.com, hannes@cmpxchg.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: [PATCH v7 09/10] mm/lru: add debug checking for page memcg moving
Date:   Wed, 25 Dec 2019 17:04:25 +0800
Message-Id: <1577264666-246071-10-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1577264666-246071-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1577264666-246071-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This debug patch could give some clues if there are sth out of
consideration.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/compaction.c | 4 ++++
 mm/memcontrol.c | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/mm/compaction.c b/mm/compaction.c
index 8c0a2da217d8..f47820355b66 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -971,6 +971,10 @@ static bool too_many_isolated(pg_data_t *pgdat)
 			compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);
 			locked_lruvec = lruvec;
 
+#ifdef	CONFIG_MEMCG
+			if (!mem_cgroup_disabled())
+				VM_BUG_ON_PAGE(lruvec_memcg(lruvec) != page->mem_cgroup, page);
+#endif
 			/* Try get exclusive access under lock */
 			if (!skip_updated) {
 				skip_updated = true;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1b69e27d1b9f..33bf086faed0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1247,6 +1247,10 @@ struct lruvec *lock_page_lruvec_irq(struct page *page)
 	lruvec = mem_cgroup_lruvec(memcg, page_pgdat(page));
 	spin_lock_irq(&lruvec->lru_lock);
 
+#ifdef CONFIG_MEMCG
+	if (!mem_cgroup_disabled())
+		VM_BUG_ON_PAGE(lruvec_memcg(lruvec) != page->mem_cgroup, page);
+#endif
 	return lruvec;
 }
 
@@ -1259,6 +1263,10 @@ struct lruvec *lock_page_lruvec_irqsave(struct page *page, unsigned long *flags)
 	lruvec = mem_cgroup_lruvec(memcg, page_pgdat(page));
 	spin_lock_irqsave(&lruvec->lru_lock, *flags);
 
+#ifdef CONFIG_MEMCG
+	if (!mem_cgroup_disabled())
+		VM_BUG_ON_PAGE(lruvec_memcg(lruvec) != page->mem_cgroup, page);
+#endif
 	return lruvec;
 }
 
-- 
1.8.3.1


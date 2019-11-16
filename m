Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F33B8FEA63
	for <lists+cgroups@lfdr.de>; Sat, 16 Nov 2019 04:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfKPDRS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Nov 2019 22:17:18 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:49238 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727418AbfKPDRR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Nov 2019 22:17:17 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0TiBsg6x_1573874111;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TiBsg6x_1573874111)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 16 Nov 2019 11:15:11 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     alex.shi@linux.alibaba.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3 6/7] mm/lru: likely enhancement
Date:   Sat, 16 Nov 2019 11:15:05 +0800
Message-Id: <1573874106-23802-7-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1573874106-23802-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1573874106-23802-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Use likely() to remove speculations according to pagevec usage.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Roman Gushchin <guro@fb.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Chris Down <chris@chrisdown.name>
Cc: Tejun Heo <tj@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/memcontrol.h | 8 ++++----
 mm/memcontrol.c            | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index eaec01fb627f..5c49fe1ee9fe 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1297,12 +1297,12 @@ static inline struct lruvec *relock_page_lruvec_irq(struct page *page,
 	struct pglist_data *pgdat = page_pgdat(page);
 	struct lruvec *lruvec;
 
-	if (!locked_lruvec)
+	if (unlikely(!locked_lruvec))
 		goto lock;
 
 	lruvec = mem_cgroup_page_lruvec(page, pgdat);
 
-	if (locked_lruvec == lruvec)
+	if (likely(locked_lruvec == lruvec))
 		return lruvec;
 
 	spin_unlock_irq(&locked_lruvec->lru_lock);
@@ -1319,12 +1319,12 @@ static inline struct lruvec *relock_page_lruvec_irqsave(struct page *page,
 	struct pglist_data *pgdat = page_pgdat(page);
 	struct lruvec *lruvec;
 
-	if (!locked_lruvec)
+	if (unlikely(!locked_lruvec))
 		goto lock;
 
 	lruvec = mem_cgroup_page_lruvec(page, pgdat);
 
-	if (locked_lruvec == lruvec)
+	if (likely(locked_lruvec == lruvec))
 		return lruvec;
 
 	spin_unlock_irqrestore(&locked_lruvec->lru_lock, locked_lruvec->irqflags);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index cf274739e619..75b8480bed69 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1256,7 +1256,7 @@ struct lruvec *lock_page_lruvec_irq(struct page *page,
 	spin_lock_irq(&lruvec->lru_lock);
 
 	/* lruvec may changed in commit_charge() */
-	if (lruvec != mem_cgroup_page_lruvec(page, pgdat)) {
+	if (unlikely(lruvec != mem_cgroup_page_lruvec(page, pgdat))) {
 		spin_unlock_irq(&lruvec->lru_lock);
 		goto again;
 	}
@@ -1274,7 +1274,7 @@ struct lruvec *lock_page_lruvec_irqsave(struct page *page,
 	spin_lock_irqsave(&lruvec->lru_lock, lruvec->irqflags);
 
 	/* lruvec may changed in commit_charge() */
-	if (lruvec != mem_cgroup_page_lruvec(page, pgdat)) {
+	if (unlikely(lruvec != mem_cgroup_page_lruvec(page, pgdat))) {
 		spin_unlock_irqrestore(&lruvec->lru_lock, lruvec->irqflags);
 		goto again;
 	}
-- 
1.8.3.1


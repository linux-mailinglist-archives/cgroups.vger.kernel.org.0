Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68724F917A
	for <lists+cgroups@lfdr.de>; Tue, 12 Nov 2019 15:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfKLOGs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Nov 2019 09:06:48 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:34843 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727312AbfKLOGs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 Nov 2019 09:06:48 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0Thubemo_1573567601;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0Thubemo_1573567601)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 12 Nov 2019 22:06:41 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     alex.shi@linux.alibaba.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 7/8] mm/lru: likely enhancement
Date:   Tue, 12 Nov 2019 22:06:27 +0800
Message-Id: <1573567588-47048-8-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1573567588-47048-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1573567588-47048-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Use likely() to remove speculations according to pagevec usage mode.

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
index f869897a68f0..2a6d7a503452 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1307,12 +1307,12 @@ static inline struct lruvec *relock_page_lruvec_irq(struct page *page,
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
@@ -1329,12 +1329,12 @@ static inline struct lruvec *relock_page_lruvec_irqsave(struct page *page,
 	struct pglist_data *pgdat = page_pgdat(page);
 	struct lruvec *lruvec;
 
-	if (!locked_lruvec)
+	if (unlikely(!locked_lruvec))
 		goto lock;
 
 	lruvec = mem_cgroup_page_lruvec(page, pgdat);
 
-	if (locked_lruvec == lruvec)
+	if (likely(locked_lruvec == lruvec))
 		return lruvec;
 
 	spin_unlock_irqrestore(&locked_lruvec->lru_lock, locked_lruvec->flags);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d2539bac4677..d95adf49fae3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1273,7 +1273,7 @@ struct lruvec *lock_page_lruvec_irq(struct page *page,
 	spin_lock_irq(&lruvec->lru_lock);
 
 	/* lruvec may changed in commit_charge() */
-	if (lruvec != mem_cgroup_page_lruvec(page, pgdat)) {
+	if (unlikely(lruvec != mem_cgroup_page_lruvec(page, pgdat))) {
 		spin_unlock_irq(&lruvec->lru_lock);
 		goto again;
 	}
@@ -1291,7 +1291,7 @@ struct lruvec *lock_page_lruvec_irqsave(struct page *page,
 	spin_lock_irqsave(&lruvec->lru_lock, lruvec->flags);
 
 	/* lruvec may changed in commit_charge() */
-	if (lruvec != mem_cgroup_page_lruvec(page, pgdat)) {
+	if (unlikely(lruvec != mem_cgroup_page_lruvec(page, pgdat))) {
 		spin_unlock_irqrestore(&lruvec->lru_lock, lruvec->flags);
 		goto again;
 	}
-- 
1.8.3.1


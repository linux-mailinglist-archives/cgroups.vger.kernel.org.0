Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D20A95B91
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2019 11:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbfHTJuN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Aug 2019 05:50:13 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:56240 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729705AbfHTJto (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Aug 2019 05:49:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0Ta-6uiR_1566294572;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0Ta-6uiR_1566294572)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 20 Aug 2019 17:49:32 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 02/14] lru/memcg: move the lruvec->pgdat sync out lru_lock
Date:   Tue, 20 Aug 2019 17:48:25 +0800
Message-Id: <1566294517-86418-3-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1566294517-86418-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1566294517-86418-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We are going to move lruvec getting out of lru_lock, the only unsafe
part is lruvec->pgdat syncing when memory node hot pluging.

Splitting out the lruvec->pgdat assignment now and will put it in
lruvec lru_lock protection.

No function changes in this patch now.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Roman Gushchin <guro@fb.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Chris Down <chris@chrisdown.name>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/memcontrol.h | 24 +++++++++++++++++-------
 mm/memcontrol.c            |  8 +-------
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 2cd4359cb38c..95b3d9885ab6 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -359,6 +359,17 @@ void mem_cgroup_cancel_charge(struct page *page, struct mem_cgroup *memcg,
 	return memcg->nodeinfo[nid];
 }
 
+static void sync_lruvec_pgdat(struct lruvec *lruvec, struct pglist_data *pgdat)
+{
+	/*
+	 * Since a node can be onlined after the mem_cgroup was created,
+	 * we have to be prepared to initialize lruvec->pgdat here;
+	 * and if offlined then reonlined, we need to reinitialize it.
+	 */
+	if (!mem_cgroup_disabled() && unlikely(lruvec->pgdat != pgdat))
+		lruvec->pgdat = pgdat;
+}
+
 /**
  * mem_cgroup_lruvec - get the lru list vector for a node or a memcg zone
  * @node: node of the wanted lruvec
@@ -382,13 +393,7 @@ static inline struct lruvec *mem_cgroup_lruvec(struct pglist_data *pgdat,
 	mz = mem_cgroup_nodeinfo(memcg, pgdat->node_id);
 	lruvec = &mz->lruvec;
 out:
-	/*
-	 * Since a node can be onlined after the mem_cgroup was created,
-	 * we have to be prepared to initialize lruvec->pgdat here;
-	 * and if offlined then reonlined, we need to reinitialize it.
-	 */
-	if (unlikely(lruvec->pgdat != pgdat))
-		lruvec->pgdat = pgdat;
+	sync_lruvec_pgdat(lruvec, pgdat);
 	return lruvec;
 }
 
@@ -857,6 +862,11 @@ static inline void mem_cgroup_migrate(struct page *old, struct page *new)
 {
 }
 
+static inline void sync_lruvec_pgdat(struct lruvec *lruvec,
+						struct pglist_data *pgdat)
+{
+}
+
 static inline struct lruvec *mem_cgroup_lruvec(struct pglist_data *pgdat,
 				struct mem_cgroup *memcg)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2792b8ed405f..e8a1b0d95ba8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1257,13 +1257,7 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgd
 	mz = mem_cgroup_page_nodeinfo(memcg, page);
 	lruvec = &mz->lruvec;
 out:
-	/*
-	 * Since a node can be onlined after the mem_cgroup was created,
-	 * we have to be prepared to initialize lruvec->zone here;
-	 * and if offlined then reonlined, we need to reinitialize it.
-	 */
-	if (unlikely(lruvec->pgdat != pgdat))
-		lruvec->pgdat = pgdat;
+	sync_lruvec_pgdat(lruvec, pgdat);
 	return lruvec;
 }
 
-- 
1.8.3.1


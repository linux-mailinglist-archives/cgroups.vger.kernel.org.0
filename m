Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725163B9B2F
	for <lists+cgroups@lfdr.de>; Fri,  2 Jul 2021 05:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbhGBD6q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Jul 2021 23:58:46 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6034 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbhGBD6q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Jul 2021 23:58:46 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GGLhn56mGzXlyS;
        Fri,  2 Jul 2021 11:50:49 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 2 Jul 2021 11:56:11 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 2 Jul
 2021 11:56:11 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH] blk-cgroup: prevent rcu_sched detected stalls warnings while iterating blkgs
Date:   Fri, 2 Jul 2021 12:04:44 +0800
Message-ID: <20210702040444.1917834-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We run a test that create millions of cgroups and blkgs, and then trigger
blkg_destroy_all(). blkg_destroy_all() will hold spin lock for a long
time in such situation. Thus release the lock when a batch of blkgs are
destroyed.

blkcg_activate_policy() and blkcg_deactivate_policy() might have the
same problem, fix them the same way.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-cgroup.c | 56 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 6 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 7b06a5fa3cac..1d26b58d7c25 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -56,6 +56,8 @@ static LIST_HEAD(all_blkcgs);		/* protected by blkcg_pol_mutex */
 bool blkcg_debug_stats = false;
 static struct workqueue_struct *blkcg_punt_bio_wq;
 
+#define BLKG_BATCH_OP_NUM 64
+
 static bool blkcg_policy_enabled(struct request_queue *q,
 				 const struct blkcg_policy *pol)
 {
@@ -422,7 +424,9 @@ static void blkg_destroy(struct blkcg_gq *blkg)
 static void blkg_destroy_all(struct request_queue *q)
 {
 	struct blkcg_gq *blkg, *n;
+	int count = BLKG_BATCH_OP_NUM;
 
+restart:
 	spin_lock_irq(&q->queue_lock);
 	list_for_each_entry_safe(blkg, n, &q->blkg_list, q_node) {
 		struct blkcg *blkcg = blkg->blkcg;
@@ -430,6 +434,17 @@ static void blkg_destroy_all(struct request_queue *q)
 		spin_lock(&blkcg->lock);
 		blkg_destroy(blkg);
 		spin_unlock(&blkcg->lock);
+
+		/*
+		 * in order to avoid holding the spin lock for too long, release
+		 * it when a batch of blkgs are destroyed.
+		 */
+		if (!(--count)) {
+			count = BLKG_BATCH_OP_NUM;
+			spin_unlock_irq(&q->queue_lock);
+			cond_resched();
+			goto restart;
+		}
 	}
 
 	q->root_blkg = NULL;
@@ -1291,6 +1306,7 @@ int blkcg_activate_policy(struct request_queue *q,
 {
 	struct blkg_policy_data *pd_prealloc = NULL;
 	struct blkcg_gq *blkg, *pinned_blkg = NULL;
+	int count;
 	int ret;
 
 	if (blkcg_policy_enabled(q, pol))
@@ -1299,6 +1315,7 @@ int blkcg_activate_policy(struct request_queue *q,
 	if (queue_is_mq(q))
 		blk_mq_freeze_queue(q);
 retry:
+	count = BLKG_BATCH_OP_NUM;
 	spin_lock_irq(&q->queue_lock);
 
 	/* blkg_list is pushed at the head, reverse walk to allocate parents first */
@@ -1342,6 +1359,16 @@ int blkcg_activate_policy(struct request_queue *q,
 		blkg->pd[pol->plid] = pd;
 		pd->blkg = blkg;
 		pd->plid = pol->plid;
+
+		/*
+		 * in order to avoid holding the spin lock for too long, release
+		 * it when a batch of blkgs are activated.
+		 */
+		if (!(--count)) {
+			spin_unlock_irq(&q->queue_lock);
+			cond_resched();
+			goto retry;
+		}
 	}
 
 	/* all allocated, init in the same order */
@@ -1389,6 +1416,7 @@ void blkcg_deactivate_policy(struct request_queue *q,
 			     const struct blkcg_policy *pol)
 {
 	struct blkcg_gq *blkg;
+	int count;
 
 	if (!blkcg_policy_enabled(q, pol))
 		return;
@@ -1397,15 +1425,31 @@ void blkcg_deactivate_policy(struct request_queue *q,
 		blk_mq_freeze_queue(q);
 
 	spin_lock_irq(&q->queue_lock);
-
 	__clear_bit(pol->plid, q->blkcg_pols);
+retry:
+	count = BLKG_BATCH_OP_NUM;
 
 	list_for_each_entry(blkg, &q->blkg_list, q_node) {
-		if (blkg->pd[pol->plid]) {
-			if (pol->pd_offline_fn)
-				pol->pd_offline_fn(blkg->pd[pol->plid]);
-			pol->pd_free_fn(blkg->pd[pol->plid]);
-			blkg->pd[pol->plid] = NULL;
+		if (!blkg->pd[pol->plid])
+			continue;
+
+		if (pol->pd_offline_fn) {
+			pol->pd_offline_fn(blkg->pd[pol->plid]);
+			count--;
+		}
+
+		pol->pd_free_fn(blkg->pd[pol->plid]);
+		blkg->pd[pol->plid] = NULL;
+
+		/*
+		 * in order to avoid holding the spin lock for too long, release
+		 * it when a batch of blkgs are deactivated.
+		 */
+		if (!count) {
+			spin_unlock_irq(&q->queue_lock);
+			cond_resched();
+			spin_lock_irq(&q->queue_lock);
+			goto retry;
 		}
 	}
 
-- 
2.31.1


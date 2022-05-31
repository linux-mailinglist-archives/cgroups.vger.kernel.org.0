Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F421B5392C7
	for <lists+cgroups@lfdr.de>; Tue, 31 May 2022 15:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245539AbiEaNzo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 May 2022 09:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245530AbiEaNzm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 May 2022 09:55:42 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CF5D5C;
        Tue, 31 May 2022 06:55:35 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LCDHJ2D70zRhVj;
        Tue, 31 May 2022 21:52:28 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 31 May 2022 21:55:33 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 31 May
 2022 21:55:33 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <paolo.valente@linaro.org>, <jack@suse.cz>, <axboe@kernel.dk>,
        <tj@kernel.org>
CC:     <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next v8 1/4] block, bfq: support to track if bfqq has pending requests
Date:   Tue, 31 May 2022 22:08:55 +0800
Message-ID: <20220531140858.3324294-2-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220531140858.3324294-1-yukuai3@huawei.com>
References: <20220531140858.3324294-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

If entity belongs to bfqq, then entity->in_groups_with_pending_reqs
is not used currently. This patch use it to track if bfqq has pending
requests through callers of weights_tree insertion and removal.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c |  1 +
 block/bfq-iosched.h |  1 +
 block/bfq-wf2q.c    | 24 ++++++++++++++++++++++--
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 0d46cb728bbf..0ec21018daba 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6263,6 +6263,7 @@ static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
 		 */
 		bfqq->budget_timeout = jiffies;
 
+		bfq_del_bfqq_in_groups_with_pending_reqs(bfqq);
 		bfq_weights_tree_remove(bfqd, bfqq);
 	}
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index ca8177d7bf7c..3b9b1a0e7c1c 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -1080,6 +1080,7 @@ void bfq_requeue_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 void bfq_del_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		       bool expiration);
 void bfq_add_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq);
+void bfq_del_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq);
 
 /* --------------- end of interface of B-WF2Q+ ---------------- */
 
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index f8eb340381cf..12d20f26ad69 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -1647,6 +1647,22 @@ void bfq_requeue_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 				    bfqq == bfqd->in_service_queue, expiration);
 }
 
+static void bfq_add_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq)
+{
+	struct bfq_entity *entity = &bfqq->entity;
+
+	if (!entity->in_groups_with_pending_reqs)
+		entity->in_groups_with_pending_reqs = true;
+}
+
+void bfq_del_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq)
+{
+	struct bfq_entity *entity = &bfqq->entity;
+
+	if (entity->in_groups_with_pending_reqs)
+		entity->in_groups_with_pending_reqs = false;
+}
+
 /*
  * Called when the bfqq no longer has requests pending, remove it from
  * the service tree. As a special case, it can be invoked during an
@@ -1668,8 +1684,10 @@ void bfq_del_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
 	bfq_deactivate_bfqq(bfqd, bfqq, true, expiration);
 
-	if (!bfqq->dispatched)
+	if (!bfqq->dispatched) {
+		bfq_del_bfqq_in_groups_with_pending_reqs(bfqq);
 		bfq_weights_tree_remove(bfqd, bfqq);
+	}
 }
 
 /*
@@ -1684,10 +1702,12 @@ void bfq_add_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 	bfq_mark_bfqq_busy(bfqq);
 	bfqd->busy_queues[bfqq->ioprio_class - 1]++;
 
-	if (!bfqq->dispatched)
+	if (!bfqq->dispatched) {
+		bfq_add_bfqq_in_groups_with_pending_reqs(bfqq);
 		if (bfqq->wr_coeff == 1)
 			bfq_weights_tree_add(bfqd, bfqq,
 					     &bfqd->queue_weights_tree);
+	}
 
 	if (bfqq->wr_coeff > 1)
 		bfqd->wr_busy_queues++;
-- 
2.31.1


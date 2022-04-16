Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C495035B8
	for <lists+cgroups@lfdr.de>; Sat, 16 Apr 2022 11:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiDPJ0A (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 16 Apr 2022 05:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiDPJZ7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 16 Apr 2022 05:25:59 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614B110F4;
        Sat, 16 Apr 2022 02:23:28 -0700 (PDT)
Received: from kwepemi100021.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KgSRc3wLKzQjCx;
        Sat, 16 Apr 2022 17:23:24 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100021.china.huawei.com (7.221.188.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 16 Apr 2022 17:23:26 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 16 Apr
 2022 17:23:25 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <jack@suse.cz>, <paolo.valente@linaro.org>, <axboe@kernel.dk>,
        <tj@kernel.org>
CC:     <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next v2 1/5] block, bfq: cleanup bfq_weights_tree add/remove apis
Date:   Sat, 16 Apr 2022 17:37:49 +0800
Message-ID: <20220416093753.3054696-2-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220416093753.3054696-1-yukuai3@huawei.com>
References: <20220416093753.3054696-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

They already pass 'bfqd' as the first parameter, there is no need to
pass 'bfqd->queue_weights_tree' as another parameter.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c | 14 +++++++-------
 block/bfq-iosched.h |  7 ++-----
 block/bfq-wf2q.c    | 16 +++++-----------
 3 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 2e0dd68a3cbe..2deea2d07a1f 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -862,9 +862,9 @@ static bool bfq_asymmetric_scenario(struct bfq_data *bfqd,
  * In most scenarios, the rate at which nodes are created/destroyed
  * should be low too.
  */
-void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfqq,
-			  struct rb_root_cached *root)
+void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 {
+	struct rb_root_cached *root = &bfqd->queue_weights_tree;
 	struct bfq_entity *entity = &bfqq->entity;
 	struct rb_node **new = &(root->rb_root.rb_node), *parent = NULL;
 	bool leftmost = true;
@@ -936,13 +936,14 @@ void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfqq,
  * See the comments to the function bfq_weights_tree_add() for considerations
  * about overhead.
  */
-void __bfq_weights_tree_remove(struct bfq_data *bfqd,
-			       struct bfq_queue *bfqq,
-			       struct rb_root_cached *root)
+void __bfq_weights_tree_remove(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 {
+	struct rb_root_cached *root;
+
 	if (!bfqq->weight_counter)
 		return;
 
+	root = &bfqd->queue_weights_tree;
 	bfqq->weight_counter->num_active--;
 	if (bfqq->weight_counter->num_active > 0)
 		goto reset_entity_pointer;
@@ -1004,8 +1005,7 @@ void bfq_weights_tree_remove(struct bfq_data *bfqd,
 	 * has no dispatched request. DO NOT use bfqq after the next
 	 * function invocation.
 	 */
-	__bfq_weights_tree_remove(bfqd, bfqq,
-				  &bfqd->queue_weights_tree);
+	__bfq_weights_tree_remove(bfqd, bfqq);
 }
 
 /*
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 3b83e3d1c2e5..072099b0c11a 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -969,11 +969,8 @@ struct bfq_queue *bic_to_bfqq(struct bfq_io_cq *bic, bool is_sync);
 void bic_set_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq, bool is_sync);
 struct bfq_data *bic_to_bfqd(struct bfq_io_cq *bic);
 void bfq_pos_tree_add_move(struct bfq_data *bfqd, struct bfq_queue *bfqq);
-void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfqq,
-			  struct rb_root_cached *root);
-void __bfq_weights_tree_remove(struct bfq_data *bfqd,
-			       struct bfq_queue *bfqq,
-			       struct rb_root_cached *root);
+void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfqq);
+void __bfq_weights_tree_remove(struct bfq_data *bfqd, struct bfq_queue *bfqq);
 void bfq_weights_tree_remove(struct bfq_data *bfqd,
 			     struct bfq_queue *bfqq);
 void bfq_bfqq_expire(struct bfq_data *bfqd, struct bfq_queue *bfqq,
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index f8eb340381cf..a1296058c1ec 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -707,7 +707,6 @@ __bfq_entity_update_weight_prio(struct bfq_service_tree *old_st,
 		struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
 		unsigned int prev_weight, new_weight;
 		struct bfq_data *bfqd = NULL;
-		struct rb_root_cached *root;
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
 		struct bfq_sched_data *sd;
 		struct bfq_group *bfqg;
@@ -770,19 +769,15 @@ __bfq_entity_update_weight_prio(struct bfq_service_tree *old_st,
 		 * queue, remove the entity from its old weight counter (if
 		 * there is a counter associated with the entity).
 		 */
-		if (prev_weight != new_weight && bfqq) {
-			root = &bfqd->queue_weights_tree;
-			__bfq_weights_tree_remove(bfqd, bfqq, root);
-		}
+		if (prev_weight != new_weight && bfqq)
+			__bfq_weights_tree_remove(bfqd, bfqq);
 		entity->weight = new_weight;
 		/*
 		 * Add the entity, if it is not a weight-raised queue,
 		 * to the counter associated with its new weight.
 		 */
-		if (prev_weight != new_weight && bfqq && bfqq->wr_coeff == 1) {
-			/* If we get here, root has been initialized. */
-			bfq_weights_tree_add(bfqd, bfqq, root);
-		}
+		if (prev_weight != new_weight && bfqq && bfqq->wr_coeff == 1)
+			bfq_weights_tree_add(bfqd, bfqq);
 
 		new_st->wsum += entity->weight;
 
@@ -1686,8 +1681,7 @@ void bfq_add_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 
 	if (!bfqq->dispatched)
 		if (bfqq->wr_coeff == 1)
-			bfq_weights_tree_add(bfqd, bfqq,
-					     &bfqd->queue_weights_tree);
+			bfq_weights_tree_add(bfqd, bfqq);
 
 	if (bfqq->wr_coeff > 1)
 		bfqd->wr_busy_queues++;
-- 
2.31.1


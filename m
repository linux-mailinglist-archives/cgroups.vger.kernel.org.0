Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F1A527013
	for <lists+cgroups@lfdr.de>; Sat, 14 May 2022 10:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiENIvj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 14 May 2022 04:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiENIvi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 14 May 2022 04:51:38 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EB0E0F9;
        Sat, 14 May 2022 01:51:36 -0700 (PDT)
Received: from kwepemi100004.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L0fNV3jFDz1JBsb;
        Sat, 14 May 2022 16:50:18 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100004.china.huawei.com (7.221.188.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 14 May 2022 16:51:34 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 14 May
 2022 16:51:33 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <jack@suse.cz>, <paolo.valente@linaro.org>, <axboe@kernel.dk>,
        <tj@kernel.org>
CC:     <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next 1/8] block, bfq: cleanup bfq_weights_tree add/remove apis
Date:   Sat, 14 May 2022 17:05:15 +0800
Message-ID: <20220514090522.1669270-2-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220514090522.1669270-1-yukuai3@huawei.com>
References: <20220514090522.1669270-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

They already pass 'bfqd' as the first parameter, there is no need to
pass 'bfqd->queue_weights_tree' as another parameter.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c | 12 ++++++------
 block/bfq-iosched.h | 10 +++-------
 block/bfq-wf2q.c    | 16 +++++-----------
 3 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index d32b8340510a..bcbe78d71143 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -870,9 +870,9 @@ static bool bfq_asymmetric_scenario(struct bfq_data *bfqd,
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
@@ -945,12 +945,13 @@ void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfqq,
  * about overhead.
  */
 void __bfq_weights_tree_remove(struct bfq_data *bfqd,
-			       struct bfq_queue *bfqq,
-			       struct rb_root_cached *root)
+			       struct bfq_queue *bfqq)
 {
+	struct rb_root_cached *root;
 	if (!bfqq->weight_counter)
 		return;
 
+	root = &bfqd->queue_weights_tree;
 	bfqq->weight_counter->num_active--;
 	if (bfqq->weight_counter->num_active > 0)
 		goto reset_entity_pointer;
@@ -970,8 +971,7 @@ void __bfq_weights_tree_remove(struct bfq_data *bfqd,
 void bfq_weights_tree_remove(struct bfq_data *bfqd,
 			     struct bfq_queue *bfqq)
 {
-	__bfq_weights_tree_remove(bfqd, bfqq,
-				  &bfqd->queue_weights_tree);
+	__bfq_weights_tree_remove(bfqd, bfqq);
 }
 
 /*
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index c3bd8ab169e0..0a3415abb994 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -932,13 +932,9 @@ struct bfq_queue *bic_to_bfqq(struct bfq_io_cq *bic, bool is_sync);
 void bic_set_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq, bool is_sync);
 struct bfq_data *bic_to_bfqd(struct bfq_io_cq *bic);
 void bfq_pos_tree_add_move(struct bfq_data *bfqd, struct bfq_queue *bfqq);
-void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfqq,
-			  struct rb_root_cached *root);
-void __bfq_weights_tree_remove(struct bfq_data *bfqd,
-			       struct bfq_queue *bfqq,
-			       struct rb_root_cached *root);
-void bfq_weights_tree_remove(struct bfq_data *bfqd,
-			     struct bfq_queue *bfqq);
+void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfqq);
+void __bfq_weights_tree_remove(struct bfq_data *bfqd, struct bfq_queue *bfqq);
+void bfq_weights_tree_remove(struct bfq_data *bfqd, struct bfq_queue *bfqq);
 void bfq_bfqq_expire(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		     bool compensate, enum bfqq_expiration reason);
 void bfq_put_queue(struct bfq_queue *bfqq);
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 42464e6ff40c..ccd227fed1c3 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -727,7 +727,6 @@ __bfq_entity_update_weight_prio(struct bfq_service_tree *old_st,
 		struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
 		unsigned int prev_weight, new_weight;
 		struct bfq_data *bfqd = NULL;
-		struct rb_root_cached *root;
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
 		struct bfq_sched_data *sd;
 		struct bfq_group *bfqg;
@@ -790,19 +789,15 @@ __bfq_entity_update_weight_prio(struct bfq_service_tree *old_st,
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
 
@@ -1695,8 +1690,7 @@ void bfq_add_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 
 	if (!bfqq->dispatched)
 		if (bfqq->wr_coeff == 1)
-			bfq_weights_tree_add(bfqd, bfqq,
-					     &bfqd->queue_weights_tree);
+			bfq_weights_tree_add(bfqd, bfqq);
 
 	if (bfqq->wr_coeff > 1)
 		bfqd->wr_busy_queues++;
-- 
2.31.1


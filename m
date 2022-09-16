Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5889C5BA73B
	for <lists+cgroups@lfdr.de>; Fri, 16 Sep 2022 09:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiIPHJA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Sep 2022 03:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiIPHIy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Sep 2022 03:08:54 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7230A3D33;
        Fri, 16 Sep 2022 00:08:52 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MTQ9X2vDDzKFGP;
        Fri, 16 Sep 2022 15:06:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP2 (Coremail) with SMTP id Syh0CgD3SXP9ICRj02qwAw--.33483S9;
        Fri, 16 Sep 2022 15:08:50 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, axboe@kernel.dk, paolo.valente@linaro.org,
        jack@suse.cz
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [patch v11 5/6] block, bfq: cleanup bfq_weights_tree add/remove apis
Date:   Fri, 16 Sep 2022 15:19:41 +0800
Message-Id: <20220916071942.214222-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220916071942.214222-1-yukuai1@huaweicloud.com>
References: <20220916071942.214222-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgD3SXP9ICRj02qwAw--.33483S9
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw1kZw4kKrWrArWxJw1fWFg_yoW7Zw4fp3
        W3t34UG3W8AF4fXr4rJa1UZrnxtrn3Cw1Dtas3u3y5KrW7ArnFv3Wqy3WFvFyFgrWkKw43
        Zr1Yq34kAF17XFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
        kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
        W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTY
        UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

The 'bfq_data' and 'rb_root_cached' can both be accessed through
'bfq_queue', thus only pass 'bfq_queue' as parameter.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c | 19 +++++++++----------
 block/bfq-iosched.h | 10 +++-------
 block/bfq-wf2q.c    | 18 ++++++------------
 3 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 6d95b0e488a8..4ad4fa0dad4a 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -870,9 +870,9 @@ static bool bfq_asymmetric_scenario(struct bfq_data *bfqd,
  * In most scenarios, the rate at which nodes are created/destroyed
  * should be low too.
  */
-void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfqq,
-			  struct rb_root_cached *root)
+void bfq_weights_tree_add(struct bfq_queue *bfqq)
 {
+	struct rb_root_cached *root = &bfqq->bfqd->queue_weights_tree;
 	struct bfq_entity *entity = &bfqq->entity;
 	struct rb_node **new = &(root->rb_root.rb_node), *parent = NULL;
 	bool leftmost = true;
@@ -944,13 +944,14 @@ void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfqq,
  * See the comments to the function bfq_weights_tree_add() for considerations
  * about overhead.
  */
-void __bfq_weights_tree_remove(struct bfq_data *bfqd,
-			       struct bfq_queue *bfqq,
-			       struct rb_root_cached *root)
+void __bfq_weights_tree_remove(struct bfq_queue *bfqq)
 {
+	struct rb_root_cached *root;
+
 	if (!bfqq->weight_counter)
 		return;
 
+	root = &bfqq->bfqd->queue_weights_tree;
 	bfqq->weight_counter->num_active--;
 	if (bfqq->weight_counter->num_active > 0)
 		goto reset_entity_pointer;
@@ -967,11 +968,9 @@ void __bfq_weights_tree_remove(struct bfq_data *bfqd,
  * Invoke __bfq_weights_tree_remove on bfqq and decrement the number
  * of active groups for each queue's inactive parent entity.
  */
-void bfq_weights_tree_remove(struct bfq_data *bfqd,
-			     struct bfq_queue *bfqq)
+void bfq_weights_tree_remove(struct bfq_queue *bfqq)
 {
-	__bfq_weights_tree_remove(bfqd, bfqq,
-				  &bfqd->queue_weights_tree);
+	__bfq_weights_tree_remove(bfqq);
 }
 
 /*
@@ -6220,7 +6219,7 @@ static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
 		bfqq->budget_timeout = jiffies;
 
 		bfq_del_bfqq_in_groups_with_pending_reqs(bfqq);
-		bfq_weights_tree_remove(bfqd, bfqq);
+		bfq_weights_tree_remove(bfqq);
 	}
 
 	now_ns = ktime_get_ns();
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 257acb54c6dc..4bb58ab0c90a 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -973,13 +973,9 @@ struct bfq_queue *bic_to_bfqq(struct bfq_io_cq *bic, bool is_sync);
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
+void bfq_weights_tree_add(struct bfq_queue *bfqq);
+void __bfq_weights_tree_remove(struct bfq_queue *bfqq);
+void bfq_weights_tree_remove(struct bfq_queue *bfqq);
 void bfq_bfqq_expire(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		     bool compensate, enum bfqq_expiration reason);
 void bfq_put_queue(struct bfq_queue *bfqq);
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 5e8224c96921..124aaea6196e 100644
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
+			__bfq_weights_tree_remove(bfqq);
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
+			bfq_weights_tree_add(bfqq);
 
 		new_st->wsum += entity->weight;
 
@@ -1687,7 +1682,7 @@ void bfq_del_bfqq_busy(struct bfq_queue *bfqq, bool expiration)
 		 * Next function is invoked last, because it causes bfqq to be
 		 * freed. DO NOT use bfqq after the next function invocation.
 		 */
-		bfq_weights_tree_remove(bfqd, bfqq);
+		bfq_weights_tree_remove(bfqq);
 	}
 }
 
@@ -1708,8 +1703,7 @@ void bfq_add_bfqq_busy(struct bfq_queue *bfqq)
 	if (!bfqq->dispatched) {
 		bfq_add_bfqq_in_groups_with_pending_reqs(bfqq);
 		if (bfqq->wr_coeff == 1)
-			bfq_weights_tree_add(bfqd, bfqq,
-					     &bfqd->queue_weights_tree);
+			bfq_weights_tree_add(bfqq);
 	}
 
 	if (bfqq->wr_coeff > 1)
-- 
2.31.1


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C135BA734
	for <lists+cgroups@lfdr.de>; Fri, 16 Sep 2022 09:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiIPHI6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Sep 2022 03:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiIPHIy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Sep 2022 03:08:54 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB81A3D37;
        Fri, 16 Sep 2022 00:08:52 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MTQ9s5lhxzlCKk;
        Fri, 16 Sep 2022 15:07:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP2 (Coremail) with SMTP id Syh0CgD3SXP9ICRj02qwAw--.33483S10;
        Fri, 16 Sep 2022 15:08:51 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, axboe@kernel.dk, paolo.valente@linaro.org,
        jack@suse.cz
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [patch v11 6/6] block, bfq: cleanup __bfq_weights_tree_remove()
Date:   Fri, 16 Sep 2022 15:19:42 +0800
Message-Id: <20220916071942.214222-7-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220916071942.214222-1-yukuai1@huaweicloud.com>
References: <20220916071942.214222-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgD3SXP9ICRj02qwAw--.33483S10
X-Coremail-Antispam: 1UD129KBjvJXoW7KF1UXr17Wr1fJF1UtF4fZrb_yoW5JF1Dp3
        ZxKw4UW3WIkF4fXF48Ja1UZwn3trn5GrnrJas3u3yjgry7Arn2v3Z0y3WFvryFqrZ3Krsx
        Zr1Yg3s7JF1xGrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

It's the same with bfq_weights_tree_remove() now.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c | 11 +----------
 block/bfq-iosched.h |  1 -
 block/bfq-wf2q.c    |  2 +-
 3 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 4ad4fa0dad4a..c14fb6b2a46d 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -944,7 +944,7 @@ void bfq_weights_tree_add(struct bfq_queue *bfqq)
  * See the comments to the function bfq_weights_tree_add() for considerations
  * about overhead.
  */
-void __bfq_weights_tree_remove(struct bfq_queue *bfqq)
+void bfq_weights_tree_remove(struct bfq_queue *bfqq)
 {
 	struct rb_root_cached *root;
 
@@ -964,15 +964,6 @@ void __bfq_weights_tree_remove(struct bfq_queue *bfqq)
 	bfq_put_queue(bfqq);
 }
 
-/*
- * Invoke __bfq_weights_tree_remove on bfqq and decrement the number
- * of active groups for each queue's inactive parent entity.
- */
-void bfq_weights_tree_remove(struct bfq_queue *bfqq)
-{
-	__bfq_weights_tree_remove(bfqq);
-}
-
 /*
  * Return expired entry, or NULL to just start from scratch in rbtree.
  */
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 4bb58ab0c90a..7795aaf4454f 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -974,7 +974,6 @@ void bic_set_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq, bool is_sync);
 struct bfq_data *bic_to_bfqd(struct bfq_io_cq *bic);
 void bfq_pos_tree_add_move(struct bfq_data *bfqd, struct bfq_queue *bfqq);
 void bfq_weights_tree_add(struct bfq_queue *bfqq);
-void __bfq_weights_tree_remove(struct bfq_queue *bfqq);
 void bfq_weights_tree_remove(struct bfq_queue *bfqq);
 void bfq_bfqq_expire(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		     bool compensate, enum bfqq_expiration reason);
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 124aaea6196e..5a02cb94d86e 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -770,7 +770,7 @@ __bfq_entity_update_weight_prio(struct bfq_service_tree *old_st,
 		 * there is a counter associated with the entity).
 		 */
 		if (prev_weight != new_weight && bfqq)
-			__bfq_weights_tree_remove(bfqq);
+			bfq_weights_tree_remove(bfqq);
 		entity->weight = new_weight;
 		/*
 		 * Add the entity, if it is not a weight-raised queue,
-- 
2.31.1


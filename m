Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F91536C12
	for <lists+cgroups@lfdr.de>; Sat, 28 May 2022 11:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343971AbiE1Jqg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 28 May 2022 05:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbiE1Jqc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 28 May 2022 05:46:32 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8126065D3;
        Sat, 28 May 2022 02:46:31 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L9Gx33w2cz1JCBM;
        Sat, 28 May 2022 17:44:55 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 28 May 2022 17:46:29 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 28 May
 2022 17:46:29 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>, <tj@kernel.org>
CC:     <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next v3 2/6] block, bfq: cleanup __bfq_weights_tree_remove()
Date:   Sat, 28 May 2022 17:59:54 +0800
Message-ID: <20220528095958.270455-3-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220528095958.270455-1-yukuai3@huawei.com>
References: <20220528095958.270455-1-yukuai3@huawei.com>
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

It's the same with bfq_weights_tree_remove() now.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c | 13 +------------
 block/bfq-iosched.h |  1 -
 block/bfq-wf2q.c    |  2 +-
 3 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 2315cfbe46e7..8c7020f8cdf2 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -944,8 +944,7 @@ void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfqq)
  * See the comments to the function bfq_weights_tree_add() for considerations
  * about overhead.
  */
-void __bfq_weights_tree_remove(struct bfq_data *bfqd,
-			       struct bfq_queue *bfqq)
+void bfq_weights_tree_remove(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 {
 	struct rb_root_cached *root;
 
@@ -965,16 +964,6 @@ void __bfq_weights_tree_remove(struct bfq_data *bfqd,
 	bfq_put_queue(bfqq);
 }
 
-/*
- * Invoke __bfq_weights_tree_remove on bfqq and decrement the number
- * of active groups for each queue's inactive parent entity.
- */
-void bfq_weights_tree_remove(struct bfq_data *bfqd,
-			     struct bfq_queue *bfqq)
-{
-	__bfq_weights_tree_remove(bfqd, bfqq);
-}
-
 /*
  * Return expired entry, or NULL to just start from scratch in rbtree.
  */
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 50c554134196..ecca2c0570ea 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -934,7 +934,6 @@ void bic_set_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq, bool is_sync);
 struct bfq_data *bic_to_bfqd(struct bfq_io_cq *bic);
 void bfq_pos_tree_add_move(struct bfq_data *bfqd, struct bfq_queue *bfqq);
 void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfqq);
-void __bfq_weights_tree_remove(struct bfq_data *bfqd, struct bfq_queue *bfqq);
 void bfq_weights_tree_remove(struct bfq_data *bfqd, struct bfq_queue *bfqq);
 void bfq_bfqq_expire(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		     bool compensate, enum bfqq_expiration reason);
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 03949c20494d..44905ed5175d 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -794,7 +794,7 @@ __bfq_entity_update_weight_prio(struct bfq_service_tree *old_st,
 		 * there is a counter associated with the entity).
 		 */
 		if (prev_weight != new_weight && bfqq)
-			__bfq_weights_tree_remove(bfqd, bfqq);
+			bfq_weights_tree_remove(bfqd, bfqq);
 		entity->weight = new_weight;
 		/*
 		 * Add the entity, if it is not a weight-raised queue,
-- 
2.31.1


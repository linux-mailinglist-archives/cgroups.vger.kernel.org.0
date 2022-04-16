Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23FD5035C3
	for <lists+cgroups@lfdr.de>; Sat, 16 Apr 2022 11:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiDPJ0B (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 16 Apr 2022 05:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiDPJ0A (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 16 Apr 2022 05:26:00 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5951031;
        Sat, 16 Apr 2022 02:23:29 -0700 (PDT)
Received: from kwepemi100019.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KgSNr057nzFphG;
        Sat, 16 Apr 2022 17:20:59 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100019.china.huawei.com (7.221.188.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 16 Apr 2022 17:23:27 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 16 Apr
 2022 17:23:26 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <jack@suse.cz>, <paolo.valente@linaro.org>, <axboe@kernel.dk>,
        <tj@kernel.org>
CC:     <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next v2 2/5] block, bfq: add fake weight_counter for weight-raised queue
Date:   Sat, 16 Apr 2022 17:37:50 +0800
Message-ID: <20220416093753.3054696-3-yukuai3@huawei.com>
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

Weight-raised queue is not inserted to weights_tree, which makes it
impossible to track how many queues have pending requests through
weights_tree insertion and removel. This patch add fake weight_counter
for weight-raised queue to do that.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c | 11 +++++++++++
 block/bfq-wf2q.c    |  5 ++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 2deea2d07a1f..a2977c938c70 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -134,6 +134,8 @@
 #include "bfq-iosched.h"
 #include "blk-wbt.h"
 
+#define BFQ_FAKE_WEIGHT_COUNTER ((void *) POISON_INUSE)
+
 #define BFQ_BFQQ_FNS(name)						\
 void bfq_mark_bfqq_##name(struct bfq_queue *bfqq)			\
 {									\
@@ -884,6 +886,12 @@ void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 	if (bfqq->weight_counter)
 		return;
 
+	if (bfqq->wr_coeff != 1) {
+		bfqq->weight_counter = BFQ_FAKE_WEIGHT_COUNTER;
+		bfqq->ref++;
+		return;
+	}
+
 	while (*new) {
 		struct bfq_weight_counter *__counter = container_of(*new,
 						struct bfq_weight_counter,
@@ -943,6 +951,9 @@ void __bfq_weights_tree_remove(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 	if (!bfqq->weight_counter)
 		return;
 
+	if (bfqq->weight_counter == BFQ_FAKE_WEIGHT_COUNTER)
+		goto reset_entity_pointer;
+
 	root = &bfqd->queue_weights_tree;
 	bfqq->weight_counter->num_active--;
 	if (bfqq->weight_counter->num_active > 0)
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index a1296058c1ec..ae12c6b2c525 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -776,7 +776,7 @@ __bfq_entity_update_weight_prio(struct bfq_service_tree *old_st,
 		 * Add the entity, if it is not a weight-raised queue,
 		 * to the counter associated with its new weight.
 		 */
-		if (prev_weight != new_weight && bfqq && bfqq->wr_coeff == 1)
+		if (prev_weight != new_weight && bfqq)
 			bfq_weights_tree_add(bfqd, bfqq);
 
 		new_st->wsum += entity->weight;
@@ -1680,8 +1680,7 @@ void bfq_add_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 	bfqd->busy_queues[bfqq->ioprio_class - 1]++;
 
 	if (!bfqq->dispatched)
-		if (bfqq->wr_coeff == 1)
-			bfq_weights_tree_add(bfqd, bfqq);
+		bfq_weights_tree_add(bfqd, bfqq);
 
 	if (bfqq->wr_coeff > 1)
 		bfqd->wr_busy_queues++;
-- 
2.31.1


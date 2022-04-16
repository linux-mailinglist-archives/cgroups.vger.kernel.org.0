Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4855035BE
	for <lists+cgroups@lfdr.de>; Sat, 16 Apr 2022 11:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiDPJ0B (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 16 Apr 2022 05:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbiDPJ0B (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 16 Apr 2022 05:26:01 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5504B1171;
        Sat, 16 Apr 2022 02:23:30 -0700 (PDT)
Received: from kwepemi100018.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KgSQw60rfz1HBnQ;
        Sat, 16 Apr 2022 17:22:48 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100018.china.huawei.com (7.221.188.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 16 Apr 2022 17:23:28 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 16 Apr
 2022 17:23:27 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <jack@suse.cz>, <paolo.valente@linaro.org>, <axboe@kernel.dk>,
        <tj@kernel.org>
CC:     <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next v2 3/5] bfq, block: record how many queues have pending requests in bfq_group
Date:   Sat, 16 Apr 2022 17:37:51 +0800
Message-ID: <20220416093753.3054696-4-yukuai3@huawei.com>
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

Prepare to refactor the counting of 'num_groups_with_pending_reqs'.

bfqq will be inserted to weights_tree when new io is inserted to it, and
bfqq will be removed from weights_tree when all the requests are completed.
Thus use weights_tree insertion and removal to track how many queues have
pending requests.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-cgroup.c  |  1 +
 block/bfq-iosched.c | 17 ++++++++++++++++-
 block/bfq-iosched.h |  1 +
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 420eda2589c0..e8b58b2361a6 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -557,6 +557,7 @@ static void bfq_pd_init(struct blkg_policy_data *pd)
 				   */
 	bfqg->bfqd = bfqd;
 	bfqg->active_entities = 0;
+	bfqg->num_entities_with_pending_reqs = 0;
 	bfqg->rq_pos_tree = RB_ROOT;
 }
 
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index a2977c938c70..994c6b36a5d5 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -889,7 +889,7 @@ void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 	if (bfqq->wr_coeff != 1) {
 		bfqq->weight_counter = BFQ_FAKE_WEIGHT_COUNTER;
 		bfqq->ref++;
-		return;
+		goto update;
 	}
 
 	while (*new) {
@@ -936,6 +936,14 @@ void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 inc_counter:
 	bfqq->weight_counter->num_active++;
 	bfqq->ref++;
+
+update:
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	if (!entity->in_groups_with_pending_reqs) {
+		entity->in_groups_with_pending_reqs = true;
+		bfqq_group(bfqq)->num_entities_with_pending_reqs++;
+	}
+#endif
 }
 
 /*
@@ -963,6 +971,13 @@ void __bfq_weights_tree_remove(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 	kfree(bfqq->weight_counter);
 
 reset_entity_pointer:
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	if (bfqq->entity.in_groups_with_pending_reqs) {
+		bfqq->entity.in_groups_with_pending_reqs = false;
+		bfqq_group(bfqq)->num_entities_with_pending_reqs--;
+	}
+#endif
+
 	bfqq->weight_counter = NULL;
 	bfq_put_queue(bfqq);
 }
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 072099b0c11a..5e1a0ead2b6a 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -940,6 +940,7 @@ struct bfq_group {
 	struct bfq_entity *my_entity;
 
 	int active_entities;
+	int num_entities_with_pending_reqs;
 
 	struct rb_root rq_pos_tree;
 
-- 
2.31.1


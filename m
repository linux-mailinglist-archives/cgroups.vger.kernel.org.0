Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFD34CE3CA
	for <lists+cgroups@lfdr.de>; Sat,  5 Mar 2022 09:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbiCEI5m (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 5 Mar 2022 03:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiCEI5h (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 5 Mar 2022 03:57:37 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9C1269A45;
        Sat,  5 Mar 2022 00:56:48 -0800 (PST)
Received: from kwepemi500022.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4K9dkp4lYVz1GDMs;
        Sat,  5 Mar 2022 16:52:02 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500022.china.huawei.com (7.221.188.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Sat, 5 Mar 2022 16:56:46 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 5 Mar
 2022 16:56:45 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <paolo.valente@linaro.org>,
        <jack@suse.cz>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next 08/11] block, bfq: record how many queues have pending requests in bfq_group
Date:   Sat, 5 Mar 2022 17:12:02 +0800
Message-ID: <20220305091205.4188398-9-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220305091205.4188398-1-yukuai3@huawei.com>
References: <20220305091205.4188398-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

Prepare to decrease 'num_groups_with_pending_reqs' earlier.

bfqq will be inserted to weights_tree when new io is inserted to it, and
bfqq will be removed from weights_tree when all the requests are completed.
Thus use weights_tree insertion and removal to track how many queues have
pending requests.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-cgroup.c  |  1 +
 block/bfq-iosched.c | 15 +++++++++++++++
 block/bfq-iosched.h |  1 +
 3 files changed, 17 insertions(+)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 6cd65b5e790d..58acaf14a91d 100644
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
index 07027dc9dc4c..2a48c40b4f02 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -928,6 +928,13 @@ void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 inc_counter:
 	bfqq->weight_counter->num_active++;
 	bfqq->ref++;
+
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	if (!entity->in_groups_with_pending_reqs) {
+		entity->in_groups_with_pending_reqs = true;
+		bfqq_group(bfqq)->num_entities_with_pending_reqs++;
+	}
+#endif
 }
 
 /*
@@ -944,6 +951,14 @@ void __bfq_weights_tree_remove(struct bfq_data *bfqd,
 		return;
 
 	bfqq->weight_counter->num_active--;
+
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	if (bfqq->entity.in_groups_with_pending_reqs) {
+		bfqq->entity.in_groups_with_pending_reqs = false;
+		bfqq_group(bfqq)->num_entities_with_pending_reqs--;
+	}
+#endif
+
 	if (bfqq->weight_counter->num_active > 0)
 		goto reset_entity_pointer;
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 4530ab8b42ac..5d904851519c 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -940,6 +940,7 @@ struct bfq_group {
 	struct bfq_entity *my_entity;
 
 	int active_entities;
+	int num_entities_with_pending_reqs;
 
 	struct rb_root rq_pos_tree;
 
-- 
2.31.1


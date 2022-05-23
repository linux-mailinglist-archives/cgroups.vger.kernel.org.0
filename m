Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668355310B3
	for <lists+cgroups@lfdr.de>; Mon, 23 May 2022 15:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbiEWNEq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 23 May 2022 09:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235729AbiEWNEq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 23 May 2022 09:04:46 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204F92DF;
        Mon, 23 May 2022 06:04:45 -0700 (PDT)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4L6Hbs0zfJzDqMC;
        Mon, 23 May 2022 21:04:41 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 23 May 2022 21:04:42 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 23 May
 2022 21:04:42 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <jack@suse.cz>, <tj@kernel.org>, <axboe@kernel.dk>,
        <paolo.valente@linaro.org>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next v6 1/3] block, bfq: record how many queues are busy in bfq_group
Date:   Mon, 23 May 2022 21:18:16 +0800
Message-ID: <20220523131818.2798712-2-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220523131818.2798712-1-yukuai3@huawei.com>
References: <20220523131818.2798712-1-yukuai3@huawei.com>
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

Prepare to refactor the counting of 'num_groups_with_pending_reqs'.

Add a counter 'busy_queues' in bfq_group, and update it in
bfq_add/del_bfqq_busy().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/bfq-cgroup.c  |  1 +
 block/bfq-iosched.h |  2 ++
 block/bfq-wf2q.c    | 20 ++++++++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 09574af83566..4d516879d9fa 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -557,6 +557,7 @@ static void bfq_pd_init(struct blkg_policy_data *pd)
 				   */
 	bfqg->bfqd = bfqd;
 	bfqg->active_entities = 0;
+	bfqg->busy_queues = 0;
 	bfqg->online = true;
 	bfqg->rq_pos_tree = RB_ROOT;
 }
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 978ef5d6fe6a..3847f4ab77ac 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -906,6 +906,7 @@ struct bfq_group_data {
  *                   are groups with more than one active @bfq_entity
  *                   (see the comments to the function
  *                   bfq_bfqq_may_idle()).
+ * @busy_queues: number of busy bfqqs.
  * @rq_pos_tree: rbtree sorted by next_request position, used when
  *               determining if two or more queues have interleaving
  *               requests (see bfq_find_close_cooperator()).
@@ -942,6 +943,7 @@ struct bfq_group {
 	struct bfq_entity *my_entity;
 
 	int active_entities;
+	int busy_queues;
 
 	struct rb_root rq_pos_tree;
 
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index f8eb340381cf..d9ff33e0be38 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -218,6 +218,16 @@ static bool bfq_no_longer_next_in_service(struct bfq_entity *entity)
 	return false;
 }
 
+static void bfq_inc_busy_queues(struct bfq_queue *bfqq)
+{
+	bfqq_group(bfqq)->busy_queues++;
+}
+
+static void bfq_dec_busy_queues(struct bfq_queue *bfqq)
+{
+	bfqq_group(bfqq)->busy_queues--;
+}
+
 #else /* CONFIG_BFQ_GROUP_IOSCHED */
 
 static bool bfq_update_parent_budget(struct bfq_entity *next_in_service)
@@ -230,6 +240,14 @@ static bool bfq_no_longer_next_in_service(struct bfq_entity *entity)
 	return true;
 }
 
+static void bfq_inc_busy_queues(struct bfq_queue *bfqq)
+{
+}
+
+static void bfq_dec_busy_queues(struct bfq_queue *bfqq)
+{
+}
+
 #endif /* CONFIG_BFQ_GROUP_IOSCHED */
 
 /*
@@ -1660,6 +1678,7 @@ void bfq_del_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	bfq_clear_bfqq_busy(bfqq);
 
 	bfqd->busy_queues[bfqq->ioprio_class - 1]--;
+	bfq_inc_busy_queues(bfqq);
 
 	if (bfqq->wr_coeff > 1)
 		bfqd->wr_busy_queues--;
@@ -1683,6 +1702,7 @@ void bfq_add_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 
 	bfq_mark_bfqq_busy(bfqq);
 	bfqd->busy_queues[bfqq->ioprio_class - 1]++;
+	bfq_dec_busy_queues(bfqq);
 
 	if (!bfqq->dispatched)
 		if (bfqq->wr_coeff == 1)
-- 
2.31.1


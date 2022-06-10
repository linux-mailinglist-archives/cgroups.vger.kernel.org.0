Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239815459E3
	for <lists+cgroups@lfdr.de>; Fri, 10 Jun 2022 04:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238877AbiFJCE1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Jun 2022 22:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242627AbiFJCEP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Jun 2022 22:04:15 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB98384;
        Thu,  9 Jun 2022 19:03:53 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LK43S3hmHzjXC3;
        Fri, 10 Jun 2022 10:02:28 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 10 Jun 2022 10:03:51 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 10 Jun
 2022 10:03:50 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <paolo.valente@linaro.org>, <jack@suse.cz>,
        <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>
CC:     <tj@kernel.org>, <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH -next v10 2/4] block, bfq: record how many queues have pending requests
Date:   Fri, 10 Jun 2022 10:16:59 +0800
Message-ID: <20220610021701.2347602-3-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220610021701.2347602-1-yukuai3@huawei.com>
References: <20220610021701.2347602-1-yukuai3@huawei.com>
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

Prepare to refactor the counting of 'num_groups_with_pending_reqs'.

Add a counter in bfq_group, update it while tracking if bfqq have pending
requests and when bfq_bfqq_move() is called.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/bfq-cgroup.c  | 10 ++++++++++
 block/bfq-iosched.h |  1 +
 block/bfq-wf2q.c    | 12 ++++++++++--
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 09574af83566..88c0c320ddf3 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -557,6 +557,7 @@ static void bfq_pd_init(struct blkg_policy_data *pd)
 				   */
 	bfqg->bfqd = bfqd;
 	bfqg->active_entities = 0;
+	bfqg->num_queues_with_pending_reqs = 0;
 	bfqg->online = true;
 	bfqg->rq_pos_tree = RB_ROOT;
 }
@@ -646,6 +647,7 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 {
 	struct bfq_entity *entity = &bfqq->entity;
 	struct bfq_group *old_parent = bfqq_group(bfqq);
+	bool has_pending_reqs = false;
 
 	/*
 	 * No point to move bfqq to the same group, which can happen when
@@ -666,6 +668,11 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	 */
 	bfqq->ref++;
 
+	if (entity->in_groups_with_pending_reqs) {
+		has_pending_reqs = true;
+		bfq_del_bfqq_in_groups_with_pending_reqs(bfqq);
+	}
+
 	/* If bfqq is empty, then bfq_bfqq_expire also invokes
 	 * bfq_del_bfqq_busy, thereby removing bfqq and its entity
 	 * from data structures related to current group. Otherwise we
@@ -693,6 +700,9 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	/* pin down bfqg and its associated blkg  */
 	bfqg_and_blkg_get(bfqg);
 
+	if (has_pending_reqs)
+		bfq_add_bfqq_in_groups_with_pending_reqs(bfqq);
+
 	if (bfq_bfqq_busy(bfqq)) {
 		if (unlikely(!bfqd->nonrot_with_queueing))
 			bfq_pos_tree_add_move(bfqd, bfqq);
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 69c7d15417e5..de2446a9b7ab 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -943,6 +943,7 @@ struct bfq_group {
 	struct bfq_entity *my_entity;
 
 	int active_entities;
+	int num_queues_with_pending_reqs;
 
 	struct rb_root rq_pos_tree;
 
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 5704a0315cf2..6f36f3fe5cc8 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -1651,16 +1651,24 @@ void bfq_add_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq)
 {
 	struct bfq_entity *entity = &bfqq->entity;
 
-	if (!entity->in_groups_with_pending_reqs)
+	if (!entity->in_groups_with_pending_reqs) {
 		entity->in_groups_with_pending_reqs = true;
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+		bfqq_group(bfqq)->num_queues_with_pending_reqs++;
+#endif
+	}
 }
 
 void bfq_del_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq)
 {
 	struct bfq_entity *entity = &bfqq->entity;
 
-	if (entity->in_groups_with_pending_reqs)
+	if (entity->in_groups_with_pending_reqs) {
 		entity->in_groups_with_pending_reqs = false;
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+		bfqq_group(bfqq)->num_queues_with_pending_reqs--;
+#endif
+	}
 }
 
 /*
-- 
2.31.1


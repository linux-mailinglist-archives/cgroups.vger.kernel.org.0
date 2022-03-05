Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F944CE3D7
	for <lists+cgroups@lfdr.de>; Sat,  5 Mar 2022 09:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiCEI5r (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 5 Mar 2022 03:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbiCEI5m (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 5 Mar 2022 03:57:42 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86080254A92;
        Sat,  5 Mar 2022 00:56:49 -0800 (PST)
Received: from kwepemi500026.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4K9dkr1Nncz1GDbv;
        Sat,  5 Mar 2022 16:52:04 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500026.china.huawei.com (7.221.188.247) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Sat, 5 Mar 2022 16:56:47 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 5 Mar
 2022 16:56:46 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <paolo.valente@linaro.org>,
        <jack@suse.cz>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next 10/11] block, bfq: decrease 'num_groups_with_pending_reqs' earlier
Date:   Sat, 5 Mar 2022 17:12:04 +0800
Message-ID: <20220305091205.4188398-11-yukuai3@huawei.com>
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

Currently 'num_groups_with_pending_reqs' won't be decreased when
the group doesn't have any pending requests, while some child group
still have pending requests. The decrement is delayed to when all the
child groups doesn't have any pending requests.

For example:
1) t1 issue sync io on root group, t2 and t3 issue sync io on the same
child group. num_groups_with_pending_reqs is 2 now.
2) t1 stopped, num_groups_with_pending_reqs is still 2. io from t2 and
t3 still can't be handled concurrently.

Fix the problem by decreasing 'num_groups_with_pending_reqs'
immediately upon the weights_tree removal of last bfqq of the group.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c | 56 +++++++++++++++------------------------------
 block/bfq-iosched.h | 16 ++++++-------
 2 files changed, 27 insertions(+), 45 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index f221e9cab4d0..119b64c9c1d9 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -970,6 +970,24 @@ void __bfq_weights_tree_remove(struct bfq_data *bfqd,
 	bfq_put_queue(bfqq);
 }
 
+static void decrease_groups_with_pending_reqs(struct bfq_data *bfqd,
+					      struct bfq_queue *bfqq)
+{
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	struct bfq_entity *entity = bfqq->entity.parent;
+
+	/*
+	 * The decrement of num_groups_with_pending_reqs is performed
+	 * immediately when the last bfqq completes all the requests.
+	 */
+	if (!bfqq_group(bfqq)->num_entities_with_pending_reqs &&
+	    entity->in_groups_with_pending_reqs) {
+		entity->in_groups_with_pending_reqs = false;
+		bfqd->num_groups_with_pending_reqs--;
+	}
+#endif
+}
+
 /*
  * Invoke __bfq_weights_tree_remove on bfqq and decrement the number
  * of active groups for each queue's inactive parent entity.
@@ -977,8 +995,6 @@ void __bfq_weights_tree_remove(struct bfq_data *bfqd,
 void bfq_weights_tree_remove(struct bfq_data *bfqd,
 			     struct bfq_queue *bfqq)
 {
-	struct bfq_entity *entity = bfqq->entity.parent;
-
 	/*
 	 * grab a ref to prevent bfqq to be freed in
 	 * __bfq_weights_tree_remove
@@ -991,41 +1007,7 @@ void bfq_weights_tree_remove(struct bfq_data *bfqd,
 	 */
 	__bfq_weights_tree_remove(bfqd, bfqq,
 				  &bfqd->queue_weights_tree);
-
-	for_each_entity(entity) {
-		struct bfq_sched_data *sd = entity->my_sched_data;
-
-		if (sd->next_in_service || sd->in_service_entity) {
-			/*
-			 * entity is still active, because either
-			 * next_in_service or in_service_entity is not
-			 * NULL (see the comments on the definition of
-			 * next_in_service for details on why
-			 * in_service_entity must be checked too).
-			 *
-			 * As a consequence, its parent entities are
-			 * active as well, and thus this loop must
-			 * stop here.
-			 */
-			break;
-		}
-
-		/*
-		 * The decrement of num_groups_with_pending_reqs is
-		 * not performed immediately upon the deactivation of
-		 * entity, but it is delayed to when it also happens
-		 * that the first leaf descendant bfqq of entity gets
-		 * all its pending requests completed. The following
-		 * instructions perform this delayed decrement, if
-		 * needed. See the comments on
-		 * num_groups_with_pending_reqs for details.
-		 */
-		if (entity->in_groups_with_pending_reqs) {
-			entity->in_groups_with_pending_reqs = false;
-			bfqd->num_groups_with_pending_reqs--;
-		}
-	}
-
+	decrease_groups_with_pending_reqs(bfqd, bfqq);
 	bfq_put_queue(bfqq);
 }
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 5d904851519c..9ec72bd24fc2 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -495,7 +495,7 @@ struct bfq_data {
 	struct rb_root_cached queue_weights_tree;
 
 	/*
-	 * Number of groups with at least one descendant process that
+	 * Number of groups with at least one process that
 	 * has at least one request waiting for completion. Note that
 	 * this accounts for also requests already dispatched, but not
 	 * yet completed. Therefore this number of groups may differ
@@ -508,14 +508,14 @@ struct bfq_data {
 	 * bfq_better_to_idle().
 	 *
 	 * However, it is hard to compute this number exactly, for
-	 * groups with multiple descendant processes. Consider a group
-	 * that is inactive, i.e., that has no descendant process with
+	 * groups with multiple processes. Consider a group
+	 * that is inactive, i.e., that has no process with
 	 * pending I/O inside BFQ queues. Then suppose that
 	 * num_groups_with_pending_reqs is still accounting for this
-	 * group, because the group has descendant processes with some
+	 * group, because the group has processes with some
 	 * I/O request still in flight. num_groups_with_pending_reqs
 	 * should be decremented when the in-flight request of the
-	 * last descendant process is finally completed (assuming that
+	 * last process is finally completed (assuming that
 	 * nothing else has changed for the group in the meantime, in
 	 * terms of composition of the group and active/inactive state of child
 	 * groups and processes). To accomplish this, an additional
@@ -524,7 +524,7 @@ struct bfq_data {
 	 * we resort to the following tradeoff between simplicity and
 	 * accuracy: for an inactive group that is still counted in
 	 * num_groups_with_pending_reqs, we decrement
-	 * num_groups_with_pending_reqs when the first descendant
+	 * num_groups_with_pending_reqs when the last
 	 * process of the group remains with no request waiting for
 	 * completion.
 	 *
@@ -532,12 +532,12 @@ struct bfq_data {
 	 * carefulness: to avoid multiple decrements, we flag a group,
 	 * more precisely an entity representing a group, as still
 	 * counted in num_groups_with_pending_reqs when it becomes
-	 * inactive. Then, when the first descendant queue of the
+	 * inactive. Then, when the last queue of the
 	 * entity remains with no request waiting for completion,
 	 * num_groups_with_pending_reqs is decremented, and this flag
 	 * is reset. After this flag is reset for the entity,
 	 * num_groups_with_pending_reqs won't be decremented any
-	 * longer in case a new descendant queue of the entity remains
+	 * longer in case a new queue of the entity remains
 	 * with no request waiting for completion.
 	 */
 	unsigned int num_groups_with_pending_reqs;
-- 
2.31.1


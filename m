Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0E753A41D
	for <lists+cgroups@lfdr.de>; Wed,  1 Jun 2022 13:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352713AbiFALaf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Jun 2022 07:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352706AbiFALaZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Jun 2022 07:30:25 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6609F6FD34;
        Wed,  1 Jun 2022 04:30:21 -0700 (PDT)
Received: from kwepemi100015.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LCn1D6JxGzRhbg;
        Wed,  1 Jun 2022 19:27:12 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100015.china.huawei.com (7.221.188.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 1 Jun 2022 19:30:19 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 1 Jun
 2022 19:30:18 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <paolo.valente@linaro.org>, <jack@suse.cz>, <tj@kernel.org>,
        <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next v9 3/4] block, bfq: refactor the counting of 'num_groups_with_pending_reqs'
Date:   Wed, 1 Jun 2022 19:43:39 +0800
Message-ID: <20220601114340.949953-4-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220601114340.949953-1-yukuai3@huawei.com>
References: <20220601114340.949953-1-yukuai3@huawei.com>
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

Currently, bfq can't handle sync io concurrently as long as they
are not issued from root group. This is because
'bfqd->num_groups_with_pending_reqs > 0' is always true in
bfq_asymmetric_scenario().

The way that bfqg is counted into 'num_groups_with_pending_reqs':

Before this patch:
 1) root group will never be counted.
 2) Count if bfqg or it's child bfqgs have pending requests.
 3) Don't count if bfqg and it's child bfqgs complete all the requests.

After this patch:
 1) root group is counted.
 2) Count if bfqg have pending requests.
 3) Don't count if bfqg complete all the requests.

With this change, the occasion that only one group is activated can be
detected, and next patch will support concurrent sync io in the
occasion.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c | 42 ------------------------------------------
 block/bfq-iosched.h | 18 +++++++++---------
 block/bfq-wf2q.c    | 19 ++++---------------
 3 files changed, 13 insertions(+), 66 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 0ec21018daba..03b04892440c 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -970,48 +970,6 @@ void __bfq_weights_tree_remove(struct bfq_data *bfqd,
 void bfq_weights_tree_remove(struct bfq_data *bfqd,
 			     struct bfq_queue *bfqq)
 {
-	struct bfq_entity *entity = bfqq->entity.parent;
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
-	/*
-	 * Next function is invoked last, because it causes bfqq to be
-	 * freed if the following holds: bfqq is not in service and
-	 * has no dispatched request. DO NOT use bfqq after the next
-	 * function invocation.
-	 */
 	__bfq_weights_tree_remove(bfqd, bfqq,
 				  &bfqd->queue_weights_tree);
 }
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index de2446a9b7ab..f0fce94583e4 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -496,27 +496,27 @@ struct bfq_data {
 	struct rb_root_cached queue_weights_tree;
 
 	/*
-	 * Number of groups with at least one descendant process that
+	 * Number of groups with at least one process that
 	 * has at least one request waiting for completion. Note that
 	 * this accounts for also requests already dispatched, but not
 	 * yet completed. Therefore this number of groups may differ
 	 * (be larger) than the number of active groups, as a group is
 	 * considered active only if its corresponding entity has
-	 * descendant queues with at least one request queued. This
+	 * queues with at least one request queued. This
 	 * number is used to decide whether a scenario is symmetric.
 	 * For a detailed explanation see comments on the computation
 	 * of the variable asymmetric_scenario in the function
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
@@ -525,7 +525,7 @@ struct bfq_data {
 	 * we resort to the following tradeoff between simplicity and
 	 * accuracy: for an inactive group that is still counted in
 	 * num_groups_with_pending_reqs, we decrement
-	 * num_groups_with_pending_reqs when the first descendant
+	 * num_groups_with_pending_reqs when the first
 	 * process of the group remains with no request waiting for
 	 * completion.
 	 *
@@ -533,12 +533,12 @@ struct bfq_data {
 	 * carefulness: to avoid multiple decrements, we flag a group,
 	 * more precisely an entity representing a group, as still
 	 * counted in num_groups_with_pending_reqs when it becomes
-	 * inactive. Then, when the first descendant queue of the
+	 * inactive. Then, when the first queue of the
 	 * entity remains with no request waiting for completion,
 	 * num_groups_with_pending_reqs is decremented, and this flag
 	 * is reset. After this flag is reset for the entity,
 	 * num_groups_with_pending_reqs won't be decremented any
-	 * longer in case a new descendant queue of the entity remains
+	 * longer in case a new queue of the entity remains
 	 * with no request waiting for completion.
 	 */
 	unsigned int num_groups_with_pending_reqs;
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 6f36f3fe5cc8..9c2842bedf97 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -984,19 +984,6 @@ static void __bfq_activate_entity(struct bfq_entity *entity,
 		entity->on_st_or_in_serv = true;
 	}
 
-#ifdef CONFIG_BFQ_GROUP_IOSCHED
-	if (!bfq_entity_to_bfqq(entity)) { /* bfq_group */
-		struct bfq_group *bfqg =
-			container_of(entity, struct bfq_group, entity);
-		struct bfq_data *bfqd = bfqg->bfqd;
-
-		if (!entity->in_groups_with_pending_reqs) {
-			entity->in_groups_with_pending_reqs = true;
-			bfqd->num_groups_with_pending_reqs++;
-		}
-	}
-#endif
-
 	bfq_update_fin_time_enqueue(entity, st, backshifted);
 }
 
@@ -1654,7 +1641,8 @@ void bfq_add_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq)
 	if (!entity->in_groups_with_pending_reqs) {
 		entity->in_groups_with_pending_reqs = true;
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
-		bfqq_group(bfqq)->num_queues_with_pending_reqs++;
+		if (!(bfqq_group(bfqq)->num_queues_with_pending_reqs++))
+			bfqq->bfqd->num_groups_with_pending_reqs++;
 #endif
 	}
 }
@@ -1666,7 +1654,8 @@ void bfq_del_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq)
 	if (entity->in_groups_with_pending_reqs) {
 		entity->in_groups_with_pending_reqs = false;
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
-		bfqq_group(bfqq)->num_queues_with_pending_reqs--;
+		if (!(--bfqq_group(bfqq)->num_queues_with_pending_reqs))
+			bfqq->bfqd->num_groups_with_pending_reqs--;
 #endif
 	}
 }
-- 
2.31.1


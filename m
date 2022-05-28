Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A468536BFC
	for <lists+cgroups@lfdr.de>; Sat, 28 May 2022 11:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbiE1JhM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 28 May 2022 05:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbiE1Jg6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 28 May 2022 05:36:58 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AA017065;
        Sat, 28 May 2022 02:36:54 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L9Gjx5TbPz1JCBy;
        Sat, 28 May 2022 17:35:17 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 28 May 2022 17:36:52 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 28 May
 2022 17:36:51 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <paolo.valente@linaro.org>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next v7 2/3] block, bfq: refactor the counting of 'num_groups_with_pending_reqs'
Date:   Sat, 28 May 2022 17:50:19 +0800
Message-ID: <20220528095020.186970-3-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220528095020.186970-1-yukuai3@huawei.com>
References: <20220528095020.186970-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
 2) Count if bfqg have at least one bfqq that is marked busy.
 3) Don't count if bfqg doesn't have any busy bfqqs.

The main reason to use busy state of bfqq instead of 'pending requests'
is that bfqq can stay busy after dispatching the last request if idling
is needed for service guarantees.

With this change, the occasion that only one group is activated can be
detected, and next patch will support concurrent sync io in the
occasion.

This patch also rename 'num_groups_with_pending_reqs' to
'num_groups_with_busy_queues'.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c | 46 ++-----------------------------------
 block/bfq-iosched.h | 55 ++++++---------------------------------------
 block/bfq-wf2q.c    | 19 ++++------------
 3 files changed, 13 insertions(+), 107 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 0d46cb728bbf..eb1da1bd5eb4 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -852,7 +852,7 @@ static bool bfq_asymmetric_scenario(struct bfq_data *bfqd,
 
 	return varied_queue_weights || multiple_classes_busy
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
-	       || bfqd->num_groups_with_pending_reqs > 0
+	       || bfqd->num_groups_with_busy_queues > 0
 #endif
 		;
 }
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
@@ -7118,7 +7076,7 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	bfqd->idle_slice_timer.function = bfq_idle_slice_timer;
 
 	bfqd->queue_weights_tree = RB_ROOT_CACHED;
-	bfqd->num_groups_with_pending_reqs = 0;
+	bfqd->num_groups_with_busy_queues = 0;
 
 	INIT_LIST_HEAD(&bfqd->active_list);
 	INIT_LIST_HEAD(&bfqd->idle_list);
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index d92adbdd70ee..6c6cd984d769 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -197,9 +197,6 @@ struct bfq_entity {
 	/* flag, set to request a weight, ioprio or ioprio_class change  */
 	int prio_changed;
 
-	/* flag, set if the entity is counted in groups_with_pending_reqs */
-	bool in_groups_with_pending_reqs;
-
 	/* last child queue of entity created (for non-leaf entities) */
 	struct bfq_queue *last_bfqq_created;
 };
@@ -496,52 +493,14 @@ struct bfq_data {
 	struct rb_root_cached queue_weights_tree;
 
 	/*
-	 * Number of groups with at least one descendant process that
-	 * has at least one request waiting for completion. Note that
-	 * this accounts for also requests already dispatched, but not
-	 * yet completed. Therefore this number of groups may differ
-	 * (be larger) than the number of active groups, as a group is
-	 * considered active only if its corresponding entity has
-	 * descendant queues with at least one request queued. This
-	 * number is used to decide whether a scenario is symmetric.
-	 * For a detailed explanation see comments on the computation
-	 * of the variable asymmetric_scenario in the function
-	 * bfq_better_to_idle().
-	 *
-	 * However, it is hard to compute this number exactly, for
-	 * groups with multiple descendant processes. Consider a group
-	 * that is inactive, i.e., that has no descendant process with
-	 * pending I/O inside BFQ queues. Then suppose that
-	 * num_groups_with_pending_reqs is still accounting for this
-	 * group, because the group has descendant processes with some
-	 * I/O request still in flight. num_groups_with_pending_reqs
-	 * should be decremented when the in-flight request of the
-	 * last descendant process is finally completed (assuming that
-	 * nothing else has changed for the group in the meantime, in
-	 * terms of composition of the group and active/inactive state of child
-	 * groups and processes). To accomplish this, an additional
-	 * pending-request counter must be added to entities, and must
-	 * be updated correctly. To avoid this additional field and operations,
-	 * we resort to the following tradeoff between simplicity and
-	 * accuracy: for an inactive group that is still counted in
-	 * num_groups_with_pending_reqs, we decrement
-	 * num_groups_with_pending_reqs when the first descendant
-	 * process of the group remains with no request waiting for
-	 * completion.
-	 *
-	 * Even this simpler decrement strategy requires a little
-	 * carefulness: to avoid multiple decrements, we flag a group,
-	 * more precisely an entity representing a group, as still
-	 * counted in num_groups_with_pending_reqs when it becomes
-	 * inactive. Then, when the first descendant queue of the
-	 * entity remains with no request waiting for completion,
-	 * num_groups_with_pending_reqs is decremented, and this flag
-	 * is reset. After this flag is reset for the entity,
-	 * num_groups_with_pending_reqs won't be decremented any
-	 * longer in case a new descendant queue of the entity remains
-	 * with no request waiting for completion.
+	 * Number of groups with at least one bfqq that is marked busy,
+	 * and this number is used to decide whether a scenario is symmetric.
+	 * Note that bfqq is busy doesn't mean that the bfqq contains requests.
+	 * If idling is needed for service guarantees, bfqq will stay busy
+	 * after dispatching the last request, see details in
+	 * __bfq_bfqq_expire().
 	 */
-	unsigned int num_groups_with_pending_reqs;
+	unsigned int num_groups_with_busy_queues;
 
 	/*
 	 * Per-class (RT, BE, IDLE) number of bfq_queues containing
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index b97e33688335..48ca7922035c 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -221,13 +221,15 @@ static bool bfq_no_longer_next_in_service(struct bfq_entity *entity)
 static void bfq_inc_busy_queues(struct bfq_queue *bfqq)
 {
 	bfqq->bfqd->busy_queues[bfqq->ioprio_class - 1]++;
-	bfqq_group(bfqq)->busy_queues++;
+	if (!(bfqq_group(bfqq)->busy_queues++))
+		bfqq->bfqd->num_groups_with_busy_queues++;
 }
 
 static void bfq_dec_busy_queues(struct bfq_queue *bfqq)
 {
 	bfqq->bfqd->busy_queues[bfqq->ioprio_class - 1]--;
-	bfqq_group(bfqq)->busy_queues--;
+	if (!(--bfqq_group(bfqq)->busy_queues))
+		bfqq->bfqd->num_groups_with_busy_queues--;
 }
 
 #else /* CONFIG_BFQ_GROUP_IOSCHED */
@@ -1006,19 +1008,6 @@ static void __bfq_activate_entity(struct bfq_entity *entity,
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
 
-- 
2.31.1


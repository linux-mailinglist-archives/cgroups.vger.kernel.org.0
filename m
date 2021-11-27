Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7039945FDEF
	for <lists+cgroups@lfdr.de>; Sat, 27 Nov 2021 11:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354657AbhK0KEn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 27 Nov 2021 05:04:43 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:14988 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354068AbhK0KCl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 27 Nov 2021 05:02:41 -0500
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J1Rpn58JkzZcNX;
        Sat, 27 Nov 2021 17:56:49 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 27 Nov 2021 17:59:25 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Sat, 27 Nov
 2021 17:59:24 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <paolo.valente@linaro.org>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH RFC 6/9] block, bfq: only count group that the bfq_queue belongs to
Date:   Sat, 27 Nov 2021 18:11:29 +0800
Message-ID: <20211127101132.486806-7-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211127101132.486806-1-yukuai3@huawei.com>
References: <20211127101132.486806-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently, group will be counted into 'num_groups_with_pending_reqs'
once it's child cgroup is activated, even if the group doesn't have
any pending requests itself.

For example, if we issue sync io in cgroup /root/c1/c2, root, c1 and c2
will all be counted into 'num_groups_with_pending_reqs', which makes it
impossible to handle requests concurrently.

This patch doesn't count the group that doesn't have any pending
request, even if it's child group is activated.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-wf2q.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 6693765ff3a0..343cfc8b952e 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -950,6 +950,8 @@ static void bfq_update_fin_time_enqueue(struct bfq_entity *entity,
  * __bfq_activate_entity - handle activation of entity.
  * @entity: the entity being activated.
  * @non_blocking_wait_rq: true if entity was waiting for a request
+ * @count_group: if entity represents group, true if the group will be
+ * counted in 'num_groups_with_pending_reqs'.
  *
  * Called for a 'true' activation, i.e., if entity is not active and
  * one of its children receives a new request.
@@ -959,7 +961,8 @@ static void bfq_update_fin_time_enqueue(struct bfq_entity *entity,
  * from its idle tree.
  */
 static void __bfq_activate_entity(struct bfq_entity *entity,
-				  bool non_blocking_wait_rq)
+				  bool non_blocking_wait_rq,
+				  bool count_group)
 {
 	struct bfq_service_tree *st = bfq_entity_service_tree(entity);
 	bool backshifted = false;
@@ -1010,7 +1013,7 @@ static void __bfq_activate_entity(struct bfq_entity *entity,
 
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
 update:
-	if (!bfq_entity_to_bfqq(entity)) { /* bfq_group */
+	if (count_group && !bfq_entity_to_bfqq(entity)) { /* bfq_group */
 		struct bfq_group *bfqg =
 			container_of(entity, struct bfq_group, entity);
 		struct bfq_data *bfqd = bfqg->bfqd;
@@ -1106,7 +1109,8 @@ static void __bfq_requeue_entity(struct bfq_entity *entity)
 
 static void __bfq_activate_requeue_entity(struct bfq_entity *entity,
 					  struct bfq_sched_data *sd,
-					  bool non_blocking_wait_rq)
+					  bool non_blocking_wait_rq,
+					  bool count_group)
 {
 	struct bfq_service_tree *st = bfq_entity_service_tree(entity);
 
@@ -1122,7 +1126,8 @@ static void __bfq_activate_requeue_entity(struct bfq_entity *entity,
 		 * Not in service and not queued on its active tree:
 		 * the activity is idle and this is a true activation.
 		 */
-		__bfq_activate_entity(entity, non_blocking_wait_rq);
+		__bfq_activate_entity(entity, non_blocking_wait_rq,
+				      count_group);
 }
 
 
@@ -1144,10 +1149,12 @@ static void bfq_activate_requeue_entity(struct bfq_entity *entity,
 					bool requeue, bool expiration)
 {
 	struct bfq_sched_data *sd;
+	int depth = 0;
 
 	for_each_entity(entity) {
 		sd = entity->sched_data;
-		__bfq_activate_requeue_entity(entity, sd, non_blocking_wait_rq);
+		__bfq_activate_requeue_entity(entity, sd, non_blocking_wait_rq,
+					      depth++ == 1);
 
 		if (sd && !bfq_update_next_in_service(sd, entity, expiration) &&
 		    !requeue)
-- 
2.31.1


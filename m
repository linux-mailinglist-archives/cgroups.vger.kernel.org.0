Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8DD45FDEA
	for <lists+cgroups@lfdr.de>; Sat, 27 Nov 2021 11:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354021AbhK0KEj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 27 Nov 2021 05:04:39 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:14987 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353957AbhK0KCi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 27 Nov 2021 05:02:38 -0500
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J1Rpk4pnczZdFc;
        Sat, 27 Nov 2021 17:56:46 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 27 Nov 2021 17:59:22 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Sat, 27 Nov
 2021 17:59:22 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <paolo.valente@linaro.org>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH RFC 2/9] block, bfq: apply news apis where root group is not expected
Date:   Sat, 27 Nov 2021 18:11:25 +0800
Message-ID: <20211127101132.486806-3-yukuai3@huawei.com>
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

'entity->sched_data' is set to parent group's sched_data, thus it's NULL
for root group. And for_each_entity() is used widely to access
'entity->sched_data', thus aplly news apis if root group is not
expected. The case that root group is expected will be handled in next
patch.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c |  2 +-
 block/bfq-iosched.h | 22 ++++++++--------------
 block/bfq-wf2q.c    | 10 +++++-----
 3 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 1ce1a99a7160..3262d062e21f 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4273,7 +4273,7 @@ void bfq_bfqq_expire(struct bfq_data *bfqd,
 	 * service with the same budget.
 	 */
 	entity = entity->parent;
-	for_each_entity(entity)
+	for_each_entity_not_root(entity)
 		entity->service = 0;
 }
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index f5afc80ff11c..ef875b8046e5 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -1021,25 +1021,22 @@ extern struct blkcg_policy blkcg_policy_bfq;
 /* - interface of the internal hierarchical B-WF2Q+ scheduler - */
 
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
-/* both next loops stop at one of the child entities of the root group */
+/* stop at one of the child entities of the root group */
 #define for_each_entity(entity)	\
 	for (; entity ; entity = entity->parent)
 
-/*
- * For each iteration, compute parent in advance, so as to be safe if
- * entity is deallocated during the iteration. Such a deallocation may
- * happen as a consequence of a bfq_put_queue that frees the bfq_queue
- * containing entity.
- */
-#define for_each_entity_safe(entity, parent) \
-	for (; entity && ({ parent = entity->parent; 1; }); entity = parent)
-
 #define is_root_entity(entity) \
 	(entity->sched_data == NULL)
 
 #define for_each_entity_not_root(entity) \
 	for (; entity && !is_root_entity(entity); entity = entity->parent)
 
+/*
+ * For each iteration, compute parent in advance, so as to be safe if
+ * entity is deallocated during the iteration. Such a deallocation may
+ * happen as a consequence of a bfq_put_queue that frees the bfq_queue
+ * containing entity.
+ */
 #define for_each_entity_not_root_safe(entity, parent) \
 	for (; entity && !is_root_entity(entity) && \
 	       ({ parent = entity->parent; 1; }); entity = parent)
@@ -1047,16 +1044,13 @@ extern struct blkcg_policy blkcg_policy_bfq;
 #define is_root_entity(entity) (false)
 
 /*
- * Next four macros are fake loops when cgroups support is not
+ * Next three macros are fake loops when cgroups support is not
  * enabled. I fact, in such a case, there is only one level to go up
  * (to reach the root group).
  */
 #define for_each_entity(entity)	\
 	for (; entity ; entity = NULL)
 
-#define for_each_entity_safe(entity, parent) \
-	for (parent = NULL; entity ; entity = parent)
-
 #define for_each_entity_not_root(entity) \
 	for (; entity ; entity = NULL)
 
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index b74cc0da118e..67e32481e455 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -830,7 +830,7 @@ void bfq_bfqq_served(struct bfq_queue *bfqq, int served)
 		bfqq->service_from_wr += served;
 
 	bfqq->service_from_backlogged += served;
-	for_each_entity(entity) {
+	for_each_entity_not_root(entity) {
 		st = bfq_entity_service_tree(entity);
 
 		entity->service += served;
@@ -1216,7 +1216,7 @@ static void bfq_deactivate_entity(struct bfq_entity *entity,
 	struct bfq_sched_data *sd;
 	struct bfq_entity *parent = NULL;
 
-	for_each_entity_safe(entity, parent) {
+	for_each_entity_not_root_safe(entity, parent) {
 		sd = entity->sched_data;
 
 		if (!__bfq_deactivate_entity(entity, ins_into_idle_tree)) {
@@ -1285,7 +1285,7 @@ static void bfq_deactivate_entity(struct bfq_entity *entity,
 	 * is not the case.
 	 */
 	entity = parent;
-	for_each_entity(entity) {
+	for_each_entity_not_root(entity) {
 		/*
 		 * Invoke __bfq_requeue_entity on entity, even if
 		 * already active, to requeue/reposition it in the
@@ -1585,7 +1585,7 @@ struct bfq_queue *bfq_get_next_queue(struct bfq_data *bfqd)
 	 * We can finally update all next-to-serve entities along the
 	 * path from the leaf entity just set in service to the root.
 	 */
-	for_each_entity(entity) {
+	for_each_entity_not_root(entity) {
 		struct bfq_sched_data *sd = entity->sched_data;
 
 		if (!bfq_update_next_in_service(sd, NULL, false))
@@ -1612,7 +1612,7 @@ bool __bfq_bfqd_reset_in_service(struct bfq_data *bfqd)
 	 * execute the final step: reset in_service_entity along the
 	 * path from entity to the root.
 	 */
-	for_each_entity(entity)
+	for_each_entity_not_root(entity)
 		entity->sched_data->in_service_entity = NULL;
 
 	/*
-- 
2.31.1


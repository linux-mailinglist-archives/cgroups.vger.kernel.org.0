Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209EA4CE3BE
	for <lists+cgroups@lfdr.de>; Sat,  5 Mar 2022 09:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiCEI5e (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 5 Mar 2022 03:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiCEI5d (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 5 Mar 2022 03:57:33 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C120E254A99;
        Sat,  5 Mar 2022 00:56:43 -0800 (PST)
Received: from kwepemi100001.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K9dpf4S64zdcNH;
        Sat,  5 Mar 2022 16:55:22 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100001.china.huawei.com (7.221.188.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 5 Mar 2022 16:56:41 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 5 Mar
 2022 16:56:40 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <paolo.valente@linaro.org>,
        <jack@suse.cz>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next 02/11] block, bfq: apply news apis where root group is not expected
Date:   Sat, 5 Mar 2022 17:11:56 +0800
Message-ID: <20220305091205.4188398-3-yukuai3@huawei.com>
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

'entity->sched_data' is set to parent group's sched_data, thus it's NULL
for root group. And for_each_entity() is used widely to access
'entity->sched_data', thus aplly news apis if root group is not
expected. Prepare to count root group into 'num_groups_with_pending_reqs'.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c |  2 +-
 block/bfq-iosched.h | 22 ++++++++--------------
 block/bfq-wf2q.c    | 10 +++++-----
 3 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 69ddf6b0f01d..3bc7a7686aad 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4393,7 +4393,7 @@ void bfq_bfqq_expire(struct bfq_data *bfqd,
 	 * service with the same budget.
 	 */
 	entity = entity->parent;
-	for_each_entity(entity)
+	for_each_entity_not_root(entity)
 		entity->service = 0;
 }
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index d703492714e2..ddd8eff5c272 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -1024,25 +1024,22 @@ extern struct blkcg_policy blkcg_policy_bfq;
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
@@ -1050,16 +1047,13 @@ extern struct blkcg_policy blkcg_policy_bfq;
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
index f8eb340381cf..c4cb935a615a 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -815,7 +815,7 @@ void bfq_bfqq_served(struct bfq_queue *bfqq, int served)
 		bfqq->service_from_wr += served;
 
 	bfqq->service_from_backlogged += served;
-	for_each_entity(entity) {
+	for_each_entity_not_root(entity) {
 		st = bfq_entity_service_tree(entity);
 
 		entity->service += served;
@@ -1201,7 +1201,7 @@ static void bfq_deactivate_entity(struct bfq_entity *entity,
 	struct bfq_sched_data *sd;
 	struct bfq_entity *parent = NULL;
 
-	for_each_entity_safe(entity, parent) {
+	for_each_entity_not_root_safe(entity, parent) {
 		sd = entity->sched_data;
 
 		if (!__bfq_deactivate_entity(entity, ins_into_idle_tree)) {
@@ -1270,7 +1270,7 @@ static void bfq_deactivate_entity(struct bfq_entity *entity,
 	 * is not the case.
 	 */
 	entity = parent;
-	for_each_entity(entity) {
+	for_each_entity_not_root(entity) {
 		/*
 		 * Invoke __bfq_requeue_entity on entity, even if
 		 * already active, to requeue/reposition it in the
@@ -1570,7 +1570,7 @@ struct bfq_queue *bfq_get_next_queue(struct bfq_data *bfqd)
 	 * We can finally update all next-to-serve entities along the
 	 * path from the leaf entity just set in service to the root.
 	 */
-	for_each_entity(entity) {
+	for_each_entity_not_root(entity) {
 		struct bfq_sched_data *sd = entity->sched_data;
 
 		if (!bfq_update_next_in_service(sd, NULL, false))
@@ -1597,7 +1597,7 @@ bool __bfq_bfqd_reset_in_service(struct bfq_data *bfqd)
 	 * execute the final step: reset in_service_entity along the
 	 * path from entity to the root.
 	 */
-	for_each_entity(entity)
+	for_each_entity_not_root(entity)
 		entity->sched_data->in_service_entity = NULL;
 
 	/*
-- 
2.31.1


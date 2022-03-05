Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEEC4CE3D9
	for <lists+cgroups@lfdr.de>; Sat,  5 Mar 2022 09:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiCEI5n (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 5 Mar 2022 03:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiCEI5h (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 5 Mar 2022 03:57:37 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029B0F68C0;
        Sat,  5 Mar 2022 00:56:46 -0800 (PST)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4K9dkm3B9Sz1GDhL;
        Sat,  5 Mar 2022 16:52:00 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500024.china.huawei.com (7.221.188.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Sat, 5 Mar 2022 16:56:43 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 5 Mar
 2022 16:56:43 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <paolo.valente@linaro.org>,
        <jack@suse.cz>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next 05/11] block, bfq: count root group into 'num_groups_with_pending_reqs'
Date:   Sat, 5 Mar 2022 17:11:59 +0800
Message-ID: <20220305091205.4188398-6-yukuai3@huawei.com>
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

Root group is not counted into 'num_groups_with_pending_reqs' because
'entity->parent' is set to NULL for child entities, thus
for_each_entity() can't access root group.

This patch set root_group's entity to 'entity->parent' for child
entities, this way root_group will be counted because for_each_entity()
can access root_group in bfq_activate_requeue_entity(),

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-cgroup.c  | 6 +++---
 block/bfq-iosched.h | 3 ++-
 block/bfq-wf2q.c    | 5 +++++
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 420eda2589c0..6cd65b5e790d 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -436,7 +436,7 @@ void bfq_init_entity(struct bfq_entity *entity, struct bfq_group *bfqg)
 		 */
 		bfqg_and_blkg_get(bfqg);
 	}
-	entity->parent = bfqg->my_entity; /* NULL for root group */
+	entity->parent = &bfqg->entity;
 	entity->sched_data = &bfqg->sched_data;
 }
 
@@ -581,7 +581,7 @@ static void bfq_group_set_parent(struct bfq_group *bfqg,
 	struct bfq_entity *entity;
 
 	entity = &bfqg->entity;
-	entity->parent = parent->my_entity;
+	entity->parent = &parent->entity;
 	entity->sched_data = &parent->sched_data;
 }
 
@@ -688,7 +688,7 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	else if (bfqd->last_bfqq_created == bfqq)
 		bfqd->last_bfqq_created = NULL;
 
-	entity->parent = bfqg->my_entity;
+	entity->parent = &bfqg->entity;
 	entity->sched_data = &bfqg->sched_data;
 	/* pin down bfqg and its associated blkg  */
 	bfqg_and_blkg_get(bfqg);
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index ddd8eff5c272..4530ab8b42ac 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -1024,13 +1024,14 @@ extern struct blkcg_policy blkcg_policy_bfq;
 /* - interface of the internal hierarchical B-WF2Q+ scheduler - */
 
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
-/* stop at one of the child entities of the root group */
+/* stop at root group */
 #define for_each_entity(entity)	\
 	for (; entity ; entity = entity->parent)
 
 #define is_root_entity(entity) \
 	(entity->sched_data == NULL)
 
+/* stop at one of the child entities of the root group */
 #define for_each_entity_not_root(entity) \
 	for (; entity && !is_root_entity(entity); entity = entity->parent)
 
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 17f1d2c5b8dc..138a2950b841 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -1125,6 +1125,11 @@ static void bfq_activate_requeue_entity(struct bfq_entity *entity,
 {
 	for_each_entity(entity) {
 		bfq_update_groups_with_pending_reqs(entity);
+
+		/* root group is not in service tree */
+		if (is_root_entity(entity))
+			break;
+
 		__bfq_activate_requeue_entity(entity, non_blocking_wait_rq);
 
 		if (!bfq_update_next_in_service(entity->sched_data, entity,
-- 
2.31.1


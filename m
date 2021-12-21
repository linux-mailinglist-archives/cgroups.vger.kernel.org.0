Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD5A47B8D7
	for <lists+cgroups@lfdr.de>; Tue, 21 Dec 2021 04:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbhLUDKA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Dec 2021 22:10:00 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:16842 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbhLUDJ7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Dec 2021 22:09:59 -0500
Received: from kwepemi500005.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JJ1dJ1wH8z91Lp;
        Tue, 21 Dec 2021 11:09:08 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500005.china.huawei.com (7.221.188.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 21 Dec 2021 11:09:57 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 21 Dec
 2021 11:09:56 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <paolo.valente@linaro.org>,
        <jack@suse.cz>, <fchecconi@gmail.com>, <avanzini.arianna@gmail.com>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH 1/4] block, bfq: cleanup bfq_bfqq_to_bfqg()
Date:   Tue, 21 Dec 2021 11:21:32 +0800
Message-ID: <20211221032135.878550-2-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211221032135.878550-1-yukuai3@huawei.com>
References: <20211221032135.878550-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Use bfq_group() instead, which do the same thing.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c |  4 ++--
 block/bfq-iosched.h |  1 -
 block/bfq-wf2q.c    | 15 ---------------
 3 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 0c612a911696..2f2b97cad980 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -774,7 +774,7 @@ bfq_pos_tree_add_move(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 	if (!bfqq->next_rq)
 		return;
 
-	bfqq->pos_root = &bfq_bfqq_to_bfqg(bfqq)->rq_pos_tree;
+	bfqq->pos_root = &bfqq_group(bfqq)->rq_pos_tree;
 	__bfqq = bfq_rq_pos_tree_lookup(bfqd, bfqq->pos_root,
 			blk_rq_pos(bfqq->next_rq), &parent, &p);
 	if (!__bfqq) {
@@ -2669,7 +2669,7 @@ static struct bfq_queue *bfqq_find_close(struct bfq_data *bfqd,
 					 struct bfq_queue *bfqq,
 					 sector_t sector)
 {
-	struct rb_root *root = &bfq_bfqq_to_bfqg(bfqq)->rq_pos_tree;
+	struct rb_root *root = &bfqq_group(bfqq)->rq_pos_tree;
 	struct rb_node *parent, *node;
 	struct bfq_queue *__bfqq;
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 07288b9da389..99949548896e 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -1051,7 +1051,6 @@ extern struct blkcg_policy blkcg_policy_bfq;
 	for (parent = NULL; entity ; entity = parent)
 #endif /* CONFIG_BFQ_GROUP_IOSCHED */
 
-struct bfq_group *bfq_bfqq_to_bfqg(struct bfq_queue *bfqq);
 struct bfq_queue *bfq_entity_to_bfqq(struct bfq_entity *entity);
 unsigned int bfq_tot_busy_queues(struct bfq_data *bfqd);
 struct bfq_service_tree *bfq_entity_service_tree(struct bfq_entity *entity);
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index b74cc0da118e..e1f5ca5c1fdb 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -142,16 +142,6 @@ static bool bfq_update_next_in_service(struct bfq_sched_data *sd,
 
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
 
-struct bfq_group *bfq_bfqq_to_bfqg(struct bfq_queue *bfqq)
-{
-	struct bfq_entity *group_entity = bfqq->entity.parent;
-
-	if (!group_entity)
-		group_entity = &bfqq->bfqd->root_group->entity;
-
-	return container_of(group_entity, struct bfq_group, entity);
-}
-
 /*
  * Returns true if this budget changes may let next_in_service->parent
  * become the next_in_service entity for its parent entity.
@@ -230,11 +220,6 @@ static bool bfq_no_longer_next_in_service(struct bfq_entity *entity)
 
 #else /* CONFIG_BFQ_GROUP_IOSCHED */
 
-struct bfq_group *bfq_bfqq_to_bfqg(struct bfq_queue *bfqq)
-{
-	return bfqq->bfqd->root_group;
-}
-
 static bool bfq_update_parent_budget(struct bfq_entity *next_in_service)
 {
 	return false;
-- 
2.31.1


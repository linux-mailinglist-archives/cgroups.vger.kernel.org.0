Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D801F45FDFB
	for <lists+cgroups@lfdr.de>; Sat, 27 Nov 2021 11:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354114AbhK0KEx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 27 Nov 2021 05:04:53 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:16310 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354012AbhK0KCj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 27 Nov 2021 05:02:39 -0500
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J1RsB2m8Xz90xm;
        Sat, 27 Nov 2021 17:58:54 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 27 Nov 2021 17:59:23 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Sat, 27 Nov
 2021 17:59:22 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <paolo.valente@linaro.org>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH RFC 3/9] block, bfq: handle the case when for_each_entity() access root group
Date:   Sat, 27 Nov 2021 18:11:26 +0800
Message-ID: <20211127101132.486806-4-yukuai3@huawei.com>
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

Prevent null-ptr-deref after counting root group into
'num_groups_with_pending_reqs'.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c |  2 +-
 block/bfq-wf2q.c    | 17 +++++++++++++----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 3262d062e21f..47722f931ee3 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -864,7 +864,7 @@ void bfq_weights_tree_remove(struct bfq_data *bfqd,
 	for_each_entity(entity) {
 		struct bfq_sched_data *sd = entity->my_sched_data;
 
-		if (sd->next_in_service || sd->in_service_entity) {
+		if (sd && (sd->next_in_service || sd->in_service_entity)) {
 			/*
 			 * entity is still active, because either
 			 * next_in_service or in_service_entity is not
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 67e32481e455..6693765ff3a0 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -965,6 +965,13 @@ static void __bfq_activate_entity(struct bfq_entity *entity,
 	bool backshifted = false;
 	unsigned long long min_vstart;
 
+	if (is_root_entity(entity))
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+		goto update;
+#else
+		return;
+#endif
+
 	/* See comments on bfq_fqq_update_budg_for_activation */
 	if (non_blocking_wait_rq && bfq_gt(st->vtime, entity->finish)) {
 		backshifted = true;
@@ -999,7 +1006,10 @@ static void __bfq_activate_entity(struct bfq_entity *entity,
 		entity->on_st_or_in_serv = true;
 	}
 
+	bfq_update_fin_time_enqueue(entity, st, backshifted);
+
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
+update:
 	if (!bfq_entity_to_bfqq(entity)) { /* bfq_group */
 		struct bfq_group *bfqg =
 			container_of(entity, struct bfq_group, entity);
@@ -1011,8 +1021,6 @@ static void __bfq_activate_entity(struct bfq_entity *entity,
 		}
 	}
 #endif
-
-	bfq_update_fin_time_enqueue(entity, st, backshifted);
 }
 
 /**
@@ -1102,7 +1110,8 @@ static void __bfq_activate_requeue_entity(struct bfq_entity *entity,
 {
 	struct bfq_service_tree *st = bfq_entity_service_tree(entity);
 
-	if (sd->in_service_entity == entity || entity->tree == &st->active)
+	if (sd && (sd->in_service_entity == entity ||
+		   entity->tree == &st->active))
 		 /*
 		  * in service or already queued on the active tree,
 		  * requeue or reposition
@@ -1140,7 +1149,7 @@ static void bfq_activate_requeue_entity(struct bfq_entity *entity,
 		sd = entity->sched_data;
 		__bfq_activate_requeue_entity(entity, sd, non_blocking_wait_rq);
 
-		if (!bfq_update_next_in_service(sd, entity, expiration) &&
+		if (sd && !bfq_update_next_in_service(sd, entity, expiration) &&
 		    !requeue)
 			break;
 	}
-- 
2.31.1


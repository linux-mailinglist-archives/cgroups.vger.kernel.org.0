Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3622945FDF1
	for <lists+cgroups@lfdr.de>; Sat, 27 Nov 2021 11:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354665AbhK0KEo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 27 Nov 2021 05:04:44 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:16311 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354075AbhK0KCm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 27 Nov 2021 05:02:42 -0500
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J1RsF4FY5z91Ct;
        Sat, 27 Nov 2021 17:58:57 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 27 Nov 2021 17:59:26 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Sat, 27 Nov
 2021 17:59:25 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <paolo.valente@linaro.org>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH RFC 7/9] block, bfq: record how many queues have pending requests in bfq_group
Date:   Sat, 27 Nov 2021 18:11:30 +0800
Message-ID: <20211127101132.486806-8-yukuai3@huawei.com>
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

Prepare to decrease 'num_groups_with_pending_reqs' earlier.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-cgroup.c  |  1 +
 block/bfq-iosched.c | 21 +++++++++++++++++++++
 block/bfq-iosched.h |  1 +
 3 files changed, 23 insertions(+)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 9c36deda4ed4..d6f7e96ec852 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -557,6 +557,7 @@ static void bfq_pd_init(struct blkg_policy_data *pd)
 				   */
 	bfqg->bfqd = bfqd;
 	bfqg->active_entities = 0;
+	bfqg->num_entities_with_pending_reqs = 0;
 	bfqg->rq_pos_tree = RB_ROOT;
 }
 
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 63e4e13db92f..e3c31db4bffb 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -825,6 +825,16 @@ void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 inc_counter:
 	bfqq->weight_counter->num_active++;
 	bfqq->ref++;
+
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	if (!entity->in_groups_with_pending_reqs) {
+		struct bfq_group *bfqg =
+			container_of(entity->parent, struct bfq_group, entity);
+
+		entity->in_groups_with_pending_reqs = true;
+		bfqg->num_entities_with_pending_reqs++;
+	}
+#endif
 }
 
 /*
@@ -841,6 +851,17 @@ void __bfq_weights_tree_remove(struct bfq_data *bfqd,
 		return;
 
 	bfqq->weight_counter->num_active--;
+
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	if (bfqq->entity.in_groups_with_pending_reqs) {
+		struct bfq_group *bfqg = container_of(bfqq->entity.parent,
+				struct bfq_group, entity);
+
+		bfqq->entity.in_groups_with_pending_reqs = false;
+		bfqg->num_entities_with_pending_reqs--;
+	}
+#endif
+
 	if (bfqq->weight_counter->num_active > 0)
 		goto reset_entity_pointer;
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 515eb2604a37..df08bff89a70 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -937,6 +937,7 @@ struct bfq_group {
 	struct bfq_entity *my_entity;
 
 	int active_entities;
+	int num_entities_with_pending_reqs;
 
 	struct rb_root rq_pos_tree;
 
-- 
2.31.1


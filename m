Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E8B45FDF3
	for <lists+cgroups@lfdr.de>; Sat, 27 Nov 2021 11:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354713AbhK0KEq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 27 Nov 2021 05:04:46 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:27306 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354047AbhK0KCj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 27 Nov 2021 05:02:39 -0500
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J1Rsh0gJ6zbj81;
        Sat, 27 Nov 2021 17:59:20 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 27 Nov 2021 17:59:24 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Sat, 27 Nov
 2021 17:59:23 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <paolo.valente@linaro.org>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH RFC 4/9] block, bfq: count root group into 'num_groups_with_pending_reqs'
Date:   Sat, 27 Nov 2021 18:11:27 +0800
Message-ID: <20211127101132.486806-5-yukuai3@huawei.com>
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

Root group is not counted into 'num_groups_with_pending_reqs' because
'entity->parent' is set to NULL for child entities, thus
for_each_entity() can't access root group.

This patch set root_group's entity to 'entity->parent' for child
entities, It's okay with previous patches handle the case that
for_each_entity() access root group.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-cgroup.c  | 2 +-
 block/bfq-iosched.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 24a5c5329bcd..9c36deda4ed4 100644
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
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index ef875b8046e5..515eb2604a37 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -1021,13 +1021,14 @@ extern struct blkcg_policy blkcg_policy_bfq;
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
 
-- 
2.31.1


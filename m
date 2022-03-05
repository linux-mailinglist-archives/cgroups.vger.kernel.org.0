Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0BE4CE3C2
	for <lists+cgroups@lfdr.de>; Sat,  5 Mar 2022 09:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiCEI5f (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 5 Mar 2022 03:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiCEI5e (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 5 Mar 2022 03:57:34 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCAC254A92;
        Sat,  5 Mar 2022 00:56:44 -0800 (PST)
Received: from kwepemi100013.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K9dph0hR6zdcRc;
        Sat,  5 Mar 2022 16:55:24 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100013.china.huawei.com (7.221.188.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 5 Mar 2022 16:56:43 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 5 Mar
 2022 16:56:42 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <paolo.valente@linaro.org>,
        <jack@suse.cz>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next 04/11] block, bfq: move the increasement of 'num_groups_with_pending_reqs' to it's caller
Date:   Sat, 5 Mar 2022 17:11:58 +0800
Message-ID: <20220305091205.4188398-5-yukuai3@huawei.com>
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

Root group is not in service tree, thus __bfq_activate_entity() is not
needed for root_group. This will simplify counting root group into
'num_groups_with_pending_reqs'.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-wf2q.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index e30da27f356d..17f1d2c5b8dc 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -218,6 +218,19 @@ static bool bfq_no_longer_next_in_service(struct bfq_entity *entity)
 	return false;
 }
 
+static void bfq_update_groups_with_pending_reqs(struct bfq_entity *entity)
+{
+	if (!bfq_entity_to_bfqq(entity) && /* bfq_group */
+	    !entity->in_groups_with_pending_reqs) {
+		struct bfq_group *bfqg =
+			container_of(entity, struct bfq_group, entity);
+		struct bfq_data *bfqd = bfqg->bfqd;
+
+		entity->in_groups_with_pending_reqs = true;
+		bfqd->num_groups_with_pending_reqs++;
+	}
+}
+
 #else /* CONFIG_BFQ_GROUP_IOSCHED */
 
 static bool bfq_update_parent_budget(struct bfq_entity *next_in_service)
@@ -230,6 +243,10 @@ static bool bfq_no_longer_next_in_service(struct bfq_entity *entity)
 	return true;
 }
 
+static void bfq_update_groups_with_pending_reqs(struct bfq_entity *entity)
+{
+}
+
 #endif /* CONFIG_BFQ_GROUP_IOSCHED */
 
 /*
@@ -984,19 +1001,6 @@ static void __bfq_activate_entity(struct bfq_entity *entity,
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
 
@@ -1120,6 +1124,7 @@ static void bfq_activate_requeue_entity(struct bfq_entity *entity,
 					bool requeue, bool expiration)
 {
 	for_each_entity(entity) {
+		bfq_update_groups_with_pending_reqs(entity);
 		__bfq_activate_requeue_entity(entity, non_blocking_wait_rq);
 
 		if (!bfq_update_next_in_service(entity->sched_data, entity,
-- 
2.31.1


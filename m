Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A7D4CE3C5
	for <lists+cgroups@lfdr.de>; Sat,  5 Mar 2022 09:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiCEI5f (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 5 Mar 2022 03:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiCEI5e (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 5 Mar 2022 03:57:34 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0145F68C0;
        Sat,  5 Mar 2022 00:56:44 -0800 (PST)
Received: from kwepemi500021.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K9dpf71rMzdhK0;
        Sat,  5 Mar 2022 16:55:22 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500021.china.huawei.com (7.221.188.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Sat, 5 Mar 2022 16:56:42 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 5 Mar
 2022 16:56:41 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <paolo.valente@linaro.org>,
        <jack@suse.cz>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next 03/11] block, bfq: cleanup for __bfq_activate_requeue_entity()
Date:   Sat, 5 Mar 2022 17:11:57 +0800
Message-ID: <20220305091205.4188398-4-yukuai3@huawei.com>
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

Remove the parameter 'sd', which can be access by 'entity'. Just to
make the code a litter cleaner.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-wf2q.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index c4cb935a615a..e30da27f356d 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -1082,12 +1082,12 @@ static void __bfq_requeue_entity(struct bfq_entity *entity)
 }
 
 static void __bfq_activate_requeue_entity(struct bfq_entity *entity,
-					  struct bfq_sched_data *sd,
 					  bool non_blocking_wait_rq)
 {
 	struct bfq_service_tree *st = bfq_entity_service_tree(entity);
 
-	if (sd->in_service_entity == entity || entity->tree == &st->active)
+	if (entity->sched_data->in_service_entity == entity ||
+	    entity->tree == &st->active)
 		 /*
 		  * in service or already queued on the active tree,
 		  * requeue or reposition
@@ -1119,14 +1119,11 @@ static void bfq_activate_requeue_entity(struct bfq_entity *entity,
 					bool non_blocking_wait_rq,
 					bool requeue, bool expiration)
 {
-	struct bfq_sched_data *sd;
-
 	for_each_entity(entity) {
-		sd = entity->sched_data;
-		__bfq_activate_requeue_entity(entity, sd, non_blocking_wait_rq);
+		__bfq_activate_requeue_entity(entity, non_blocking_wait_rq);
 
-		if (!bfq_update_next_in_service(sd, entity, expiration) &&
-		    !requeue)
+		if (!bfq_update_next_in_service(entity->sched_data, entity,
+					expiration) && !requeue)
 			break;
 	}
 }
-- 
2.31.1


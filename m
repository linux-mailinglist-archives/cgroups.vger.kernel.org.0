Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3FB52F987
	for <lists+cgroups@lfdr.de>; Sat, 21 May 2022 09:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353174AbiEUHVy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 21 May 2022 03:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240809AbiEUHVv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 21 May 2022 03:21:51 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0C64BFED;
        Sat, 21 May 2022 00:21:49 -0700 (PDT)
Received: from kwepemi100021.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L4w4N5y1TzhYr3;
        Sat, 21 May 2022 15:21:08 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100021.china.huawei.com (7.221.188.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 21 May 2022 15:21:47 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 21 May
 2022 15:21:46 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <jack@suse.cz>, <axboe@kernel.dk>, <paolo.valente@linaro.org>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next v2 5/6] block, bfq: cleanup bfq_activate_requeue_entity()
Date:   Sat, 21 May 2022 15:35:22 +0800
Message-ID: <20220521073523.3118246-6-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220521073523.3118246-1-yukuai3@huawei.com>
References: <20220521073523.3118246-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Just make the code a litter cleaner by removing the unnecessary
variable 'sd'.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/bfq-wf2q.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 15b97687493a..da189c732376 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -1085,12 +1085,12 @@ static void __bfq_requeue_entity(struct bfq_entity *entity)
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
@@ -1122,14 +1122,10 @@ static void bfq_activate_requeue_entity(struct bfq_entity *entity,
 					bool non_blocking_wait_rq,
 					bool requeue, bool expiration)
 {
-	struct bfq_sched_data *sd;
-
 	for_each_entity(entity) {
-		sd = entity->sched_data;
-		__bfq_activate_requeue_entity(entity, sd, non_blocking_wait_rq);
-
-		if (!bfq_update_next_in_service(sd, entity, expiration) &&
-		    !requeue)
+		__bfq_activate_requeue_entity(entity, non_blocking_wait_rq);
+		if (!bfq_update_next_in_service(entity->sched_data, entity,
+						expiration) && !requeue)
 			break;
 	}
 }
-- 
2.31.1


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E139552701E
	for <lists+cgroups@lfdr.de>; Sat, 14 May 2022 10:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiENIvm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 14 May 2022 04:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiENIvj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 14 May 2022 04:51:39 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEC116592;
        Sat, 14 May 2022 01:51:38 -0700 (PDT)
Received: from kwepemi100001.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L0fLj4R9qzGpd9;
        Sat, 14 May 2022 16:48:45 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100001.china.huawei.com (7.221.188.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 14 May 2022 16:51:36 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 14 May
 2022 16:51:35 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <jack@suse.cz>, <paolo.valente@linaro.org>, <axboe@kernel.dk>,
        <tj@kernel.org>
CC:     <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next 4/8] block, bfq: don't declare 'bfqd' as type 'void *' in bfq_group
Date:   Sat, 14 May 2022 17:05:18 +0800
Message-ID: <20220514090522.1669270-5-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220514090522.1669270-1-yukuai3@huawei.com>
References: <20220514090522.1669270-1-yukuai3@huawei.com>
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

Prevent unnecessary format conversion for bfqg->bfqd in multiple
places.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-cgroup.c  | 2 +-
 block/bfq-iosched.h | 2 +-
 block/bfq-wf2q.c    | 8 +++-----
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 4d516879d9fa..b4e39ab4ad17 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -224,7 +224,7 @@ void bfqg_stats_update_io_add(struct bfq_group *bfqg, struct bfq_queue *bfqq,
 {
 	blkg_rwstat_add(&bfqg->stats.queued, op, 1);
 	bfqg_stats_end_empty_time(&bfqg->stats);
-	if (!(bfqq == ((struct bfq_data *)bfqg->bfqd)->in_service_queue))
+	if (!(bfqq == bfqg->bfqd->in_service_queue))
 		bfqg_stats_set_start_group_wait_time(bfqg, bfqq_group(bfqq));
 }
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index bc54b9824b1e..d57e4848f57f 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -894,7 +894,7 @@ struct bfq_group {
 	struct bfq_entity entity;
 	struct bfq_sched_data sched_data;
 
-	void *bfqd;
+	struct bfq_data *bfqd;
 
 	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS];
 	struct bfq_queue *async_idle_bfqq;
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index c58568a4b009..15b97687493a 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -234,9 +234,8 @@ static void bfq_inc_active_entities(struct bfq_entity *entity)
 {
 	struct bfq_sched_data *sd = entity->sched_data;
 	struct bfq_group *bfqg = container_of(sd, struct bfq_group, sched_data);
-	struct bfq_data *bfqd = (struct bfq_data *)bfqg->bfqd;
 
-	if (bfqg != bfqd->root_group)
+	if (bfqg != bfqg->bfqd->root_group)
 		bfqg->active_entities++;
 }
 
@@ -244,9 +243,8 @@ static void bfq_dec_active_entities(struct bfq_entity *entity)
 {
 	struct bfq_sched_data *sd = entity->sched_data;
 	struct bfq_group *bfqg = container_of(sd, struct bfq_group, sched_data);
-	struct bfq_data *bfqd = (struct bfq_data *)bfqg->bfqd;
 
-	if (bfqg != bfqd->root_group)
+	if (bfqg != bfqg->bfqd->root_group)
 		bfqg->active_entities--;
 }
 
@@ -741,7 +739,7 @@ __bfq_entity_update_weight_prio(struct bfq_service_tree *old_st,
 		else {
 			sd = entity->my_sched_data;
 			bfqg = container_of(sd, struct bfq_group, sched_data);
-			bfqd = (struct bfq_data *)bfqg->bfqd;
+			bfqd = bfqg->bfqd;
 		}
 #endif
 
-- 
2.31.1


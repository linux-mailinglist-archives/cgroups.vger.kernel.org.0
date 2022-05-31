Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE7B5392CE
	for <lists+cgroups@lfdr.de>; Tue, 31 May 2022 15:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243620AbiEaNzr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 May 2022 09:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344766AbiEaNzm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 May 2022 09:55:42 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACD53B6;
        Tue, 31 May 2022 06:55:36 -0700 (PDT)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LCDHK0P2qzRhWW;
        Tue, 31 May 2022 21:52:29 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500015.china.huawei.com (7.221.188.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 31 May 2022 21:55:34 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 31 May
 2022 21:55:33 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <paolo.valente@linaro.org>, <jack@suse.cz>, <axboe@kernel.dk>,
        <tj@kernel.org>
CC:     <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next v8 2/4] block, bfq: record how many queues have pending requests
Date:   Tue, 31 May 2022 22:08:56 +0800
Message-ID: <20220531140858.3324294-3-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220531140858.3324294-1-yukuai3@huawei.com>
References: <20220531140858.3324294-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Prepare to refactor the counting of 'num_groups_with_pending_reqs'.

Add a counter in bfq_group, and update it while tracking if bfqq have
pending requests.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-cgroup.c  |  1 +
 block/bfq-iosched.h |  1 +
 block/bfq-wf2q.c    | 12 ++++++++++--
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 09574af83566..0954a258a107 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -557,6 +557,7 @@ static void bfq_pd_init(struct blkg_policy_data *pd)
 				   */
 	bfqg->bfqd = bfqd;
 	bfqg->active_entities = 0;
+	bfqg->num_queues_with_pending_reqs = 0;
 	bfqg->online = true;
 	bfqg->rq_pos_tree = RB_ROOT;
 }
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 3b9b1a0e7c1c..a5f7c0c1a3b3 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -943,6 +943,7 @@ struct bfq_group {
 	struct bfq_entity *my_entity;
 
 	int active_entities;
+	int num_queues_with_pending_reqs;
 
 	struct rb_root rq_pos_tree;
 
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 12d20f26ad69..b533e17e9f0c 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -1651,16 +1651,24 @@ static void bfq_add_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq)
 {
 	struct bfq_entity *entity = &bfqq->entity;
 
-	if (!entity->in_groups_with_pending_reqs)
+	if (!entity->in_groups_with_pending_reqs) {
 		entity->in_groups_with_pending_reqs = true;
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+		bfqq_group(bfqq)->num_queues_with_pending_reqs++;
+#endif
+	}
 }
 
 void bfq_del_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq)
 {
 	struct bfq_entity *entity = &bfqq->entity;
 
-	if (entity->in_groups_with_pending_reqs)
+	if (entity->in_groups_with_pending_reqs) {
 		entity->in_groups_with_pending_reqs = false;
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+		bfqq_group(bfqq)->num_queues_with_pending_reqs--;
+#endif
+	}
 }
 
 /*
-- 
2.31.1


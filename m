Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB124CE3DD
	for <lists+cgroups@lfdr.de>; Sat,  5 Mar 2022 09:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiCEI5p (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 5 Mar 2022 03:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiCEI5h (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 5 Mar 2022 03:57:37 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA392634F2;
        Sat,  5 Mar 2022 00:56:47 -0800 (PST)
Received: from kwepemi500025.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K9dkn55PHzbc1t;
        Sat,  5 Mar 2022 16:52:01 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500025.china.huawei.com (7.221.188.170) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Sat, 5 Mar 2022 16:56:45 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 5 Mar
 2022 16:56:44 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <paolo.valente@linaro.org>,
        <jack@suse.cz>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next 07/11] block, bfq: only count parent bfqg when bfqq is activated
Date:   Sat, 5 Mar 2022 17:12:01 +0800
Message-ID: <20220305091205.4188398-8-yukuai3@huawei.com>
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

Currently, bfqg will be counted into 'num_groups_with_pending_reqs'
once it's child cgroup is activated, even if the group doesn't have
any pending requests itself.

For example, if we issue sync io in cgroup /root/c1/c2, root, c1 and c2
will all be counted into 'num_groups_with_pending_reqs', which makes it
impossible to handle requests concurrently.

This patch doesn't count the group that doesn't have any pending
requests while it's child group has pending requests.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-wf2q.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 138a2950b841..db066ae35a71 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -1123,13 +1123,7 @@ static void bfq_activate_requeue_entity(struct bfq_entity *entity,
 					bool non_blocking_wait_rq,
 					bool requeue, bool expiration)
 {
-	for_each_entity(entity) {
-		bfq_update_groups_with_pending_reqs(entity);
-
-		/* root group is not in service tree */
-		if (is_root_entity(entity))
-			break;
-
+	for_each_entity_not_root(entity) {
 		__bfq_activate_requeue_entity(entity, non_blocking_wait_rq);
 
 		if (!bfq_update_next_in_service(entity->sched_data, entity,
@@ -1640,6 +1634,7 @@ void bfq_activate_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 {
 	struct bfq_entity *entity = &bfqq->entity;
 
+	bfq_update_groups_with_pending_reqs(bfqq->entity.parent);
 	bfq_activate_requeue_entity(entity, bfq_bfqq_non_blocking_wait_rq(bfqq),
 				    false, false);
 	bfq_clear_bfqq_non_blocking_wait_rq(bfqq);
-- 
2.31.1


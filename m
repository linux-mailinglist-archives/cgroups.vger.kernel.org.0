Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBD545FDF8
	for <lists+cgroups@lfdr.de>; Sat, 27 Nov 2021 11:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354764AbhK0KEv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 27 Nov 2021 05:04:51 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:28111 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354079AbhK0KCm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 27 Nov 2021 05:02:42 -0500
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4J1Rpq2FLHz1DJNq;
        Sat, 27 Nov 2021 17:56:51 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 27 Nov 2021 17:59:27 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Sat, 27 Nov
 2021 17:59:26 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <paolo.valente@linaro.org>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH RFC 8/9] block, bfq: move forward __bfq_weights_tree_remove()
Date:   Sat, 27 Nov 2021 18:11:31 +0800
Message-ID: <20211127101132.486806-9-yukuai3@huawei.com>
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
 block/bfq-iosched.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index e3c31db4bffb..4239b3996e23 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -882,6 +882,10 @@ void bfq_weights_tree_remove(struct bfq_data *bfqd,
 {
 	struct bfq_entity *entity = bfqq->entity.parent;
 
+	bfqq->ref++;
+	__bfq_weights_tree_remove(bfqd, bfqq,
+				  &bfqd->queue_weights_tree);
+
 	for_each_entity(entity) {
 		struct bfq_sched_data *sd = entity->my_sched_data;
 
@@ -916,14 +920,7 @@ void bfq_weights_tree_remove(struct bfq_data *bfqd,
 		}
 	}
 
-	/*
-	 * Next function is invoked last, because it causes bfqq to be
-	 * freed if the following holds: bfqq is not in service and
-	 * has no dispatched request. DO NOT use bfqq after the next
-	 * function invocation.
-	 */
-	__bfq_weights_tree_remove(bfqd, bfqq,
-				  &bfqd->queue_weights_tree);
+	bfq_put_queue(bfqq);
 }
 
 /*
-- 
2.31.1


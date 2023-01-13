Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B96D6692D6
	for <lists+cgroups@lfdr.de>; Fri, 13 Jan 2023 10:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240805AbjAMJ06 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 Jan 2023 04:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240903AbjAMJZ6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 Jan 2023 04:25:58 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A3213DD0;
        Fri, 13 Jan 2023 01:19:50 -0800 (PST)
Received: from kwepemm600009.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NtbNL2NLGzqVHW;
        Fri, 13 Jan 2023 17:14:58 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 17:19:46 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <jack@suse.cz>, <tj@kernel.org>, <josef@toxicpanda.com>,
        <axboe@kernel.dk>, <paolo.valente@linaro.org>,
        <shinichiro.kawasaki@wdc.com>, <yukuai3@huawei.com>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai1@huaweicloud.com>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>
Subject: [PATCH] block, bfq: fix uaf for bfqq in bic_set_bfqq()
Date:   Fri, 13 Jan 2023 17:44:10 +0800
Message-ID: <20230113094410.2907223-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

After commit 64dc8c732f5c ("block, bfq: fix possible uaf for 'bfqq->bic'"),
bic->bfqq will be accessed in bic_set_bfqq(), however, in some context
bic->bfqq will be freed first, and bic_set_bfqq() is called with the freed
bic->bfqq.

Fix the problem by always freeing bfqq after bic_set_bfqq().

Fixes: 64dc8c732f5c ("block, bfq: fix possible uaf for 'bfqq->bic'")
Reported-and-tested-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-cgroup.c  | 2 +-
 block/bfq-iosched.c | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index a6e8da5f5cfd..feb13ac25557 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -749,8 +749,8 @@ static void bfq_sync_bfqq_move(struct bfq_data *bfqd,
 		 * old cgroup.
 		 */
 		bfq_put_cooperator(sync_bfqq);
-		bfq_release_process_ref(bfqd, sync_bfqq);
 		bic_set_bfqq(bic, NULL, true, act_idx);
+		bfq_release_process_ref(bfqd, sync_bfqq);
 	}
 }
 
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 815b884d6c5a..2ddf831221c4 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5581,9 +5581,11 @@ static void bfq_check_ioprio_change(struct bfq_io_cq *bic, struct bio *bio)
 
 	bfqq = bic_to_bfqq(bic, false, bfq_actuator_index(bfqd, bio));
 	if (bfqq) {
-		bfq_release_process_ref(bfqd, bfqq);
+		struct bfq_queue *old_bfqq = bfqq;
+
 		bfqq = bfq_get_queue(bfqd, bio, false, bic, true);
 		bic_set_bfqq(bic, bfqq, false, bfq_actuator_index(bfqd, bio));
+		bfq_release_process_ref(bfqd, old_bfqq);
 	}
 
 	bfqq = bic_to_bfqq(bic, true, bfq_actuator_index(bfqd, bio));
-- 
2.31.1


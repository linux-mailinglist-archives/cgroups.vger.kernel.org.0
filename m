Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34D85132E8
	for <lists+cgroups@lfdr.de>; Thu, 28 Apr 2022 13:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345758AbiD1L5r (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Apr 2022 07:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345738AbiD1L5o (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Apr 2022 07:57:44 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2938584EE0;
        Thu, 28 Apr 2022 04:54:30 -0700 (PDT)
Received: from kwepemi500026.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kpv9L50dKzGpPc;
        Thu, 28 Apr 2022 19:51:50 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500026.china.huawei.com (7.221.188.247) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 19:54:28 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 19:54:27 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <jack@suse.cz>, <paolo.valente@linaro.org>, <axboe@kernel.dk>,
        <tj@kernel.org>
CC:     <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next v5 3/3] block, bfq: do not idle if only one group is activated
Date:   Thu, 28 Apr 2022 20:08:37 +0800
Message-ID: <20220428120837.3737765-4-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220428120837.3737765-1-yukuai3@huawei.com>
References: <20220428120837.3737765-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Now that root group is counted into 'num_groups_with_busy_queues',
'num_groups_with_busy_queues > 0' is always true in
bfq_asymmetric_scenario(). Thus change the condition to '> 1'.

On the other hand, this change can enable concurrent sync io if only
one group is activated.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 609b4e894684..142e1ca4600f 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -812,7 +812,7 @@ bfq_pos_tree_add_move(struct bfq_data *bfqd, struct bfq_queue *bfqq)
  * much easier to maintain the needed state:
  * 1) all active queues have the same weight,
  * 2) all active queues belong to the same I/O-priority class,
- * 3) there are no active groups.
+ * 3) there are one active group at most.
  * In particular, the last condition is always true if hierarchical
  * support or the cgroups interface are not enabled, thus no state
  * needs to be maintained in this case.
@@ -844,7 +844,7 @@ static bool bfq_asymmetric_scenario(struct bfq_data *bfqd,
 
 	return varied_queue_weights || multiple_classes_busy
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
-	       || bfqd->num_groups_with_busy_queues > 0
+	       || bfqd->num_groups_with_busy_queues > 1
 #endif
 		;
 }
-- 
2.31.1


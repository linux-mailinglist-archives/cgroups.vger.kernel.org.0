Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5825117B6
	for <lists+cgroups@lfdr.de>; Wed, 27 Apr 2022 14:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbiD0Mg3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Apr 2022 08:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbiD0MgZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Apr 2022 08:36:25 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3CB4CD40;
        Wed, 27 Apr 2022 05:33:13 -0700 (PDT)
Received: from kwepemi100002.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KpJ2H1m2xzCs1M;
        Wed, 27 Apr 2022 20:28:39 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100002.china.huawei.com (7.221.188.188) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Apr 2022 20:33:11 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 20:33:11 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <jack@suse.cz>, <tj@kernel.org>, <axboe@kernel.dk>,
        <paolo.valente@linaro.org>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next v3 3/3] block, bfq: do not idle if only one group is activated
Date:   Wed, 27 Apr 2022 20:47:22 +0800
Message-ID: <20220427124722.48465-4-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220427124722.48465-1-yukuai3@huawei.com>
References: <20220427124722.48465-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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
---
 block/bfq-iosched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 609b4e894684..aeba9001da0b 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
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


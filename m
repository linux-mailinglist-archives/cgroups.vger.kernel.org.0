Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8D252F993
	for <lists+cgroups@lfdr.de>; Sat, 21 May 2022 09:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353974AbiEUHVz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 21 May 2022 03:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240838AbiEUHVv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 21 May 2022 03:21:51 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B70F4C423;
        Sat, 21 May 2022 00:21:50 -0700 (PDT)
Received: from kwepemi100019.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L4w4P3YCtzhYsK;
        Sat, 21 May 2022 15:21:09 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100019.china.huawei.com (7.221.188.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 21 May 2022 15:21:48 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 21 May
 2022 15:21:47 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <jack@suse.cz>, <axboe@kernel.dk>, <paolo.valente@linaro.org>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next v2 6/6] block, bfq: remove dead code for updating 'rq_in_driver'
Date:   Sat, 21 May 2022 15:35:23 +0800
Message-ID: <20220521073523.3118246-7-yukuai3@huawei.com>
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

Such code are not even compiled since they are inside marco "#if 0".

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index c0bc463d236c..be75bd9835f5 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2323,22 +2323,6 @@ static sector_t get_sdist(sector_t last_pos, struct request *rq)
 	return 0;
 }
 
-#if 0 /* Still not clear if we can do without next two functions */
-static void bfq_activate_request(struct request_queue *q, struct request *rq)
-{
-	struct bfq_data *bfqd = q->elevator->elevator_data;
-
-	bfqd->rq_in_driver++;
-}
-
-static void bfq_deactivate_request(struct request_queue *q, struct request *rq)
-{
-	struct bfq_data *bfqd = q->elevator->elevator_data;
-
-	bfqd->rq_in_driver--;
-}
-#endif
-
 static void bfq_remove_request(struct request_queue *q,
 			       struct request *rq)
 {
-- 
2.31.1


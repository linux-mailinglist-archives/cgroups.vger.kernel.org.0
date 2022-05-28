Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC60536B43
	for <lists+cgroups@lfdr.de>; Sat, 28 May 2022 08:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355896AbiE1GbN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 28 May 2022 02:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355837AbiE1GaY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 28 May 2022 02:30:24 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1482630F65;
        Fri, 27 May 2022 23:30:06 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L9BZP3CJFzgYDc;
        Sat, 28 May 2022 14:28:29 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 28 May 2022 14:30:03 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 28 May
 2022 14:30:03 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <mkoutny@suse.com>, <axboe@kernel.dk>,
        <ming.lei@redhat.com>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next v5 5/8] blk-throttle: use 'READ/WRITE' instead of '0/1'
Date:   Sat, 28 May 2022 14:43:27 +0800
Message-ID: <20220528064330.3471000-6-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220528064330.3471000-1-yukuai3@huawei.com>
References: <20220528064330.3471000-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Make the code easier to read, like everywhere else.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 94fd73e8b2d9..454a360f42e8 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -329,8 +329,8 @@ static struct bio *throtl_pop_queued(struct list_head *queued,
 /* init a service_queue, assumes the caller zeroed it */
 static void throtl_service_queue_init(struct throtl_service_queue *sq)
 {
-	INIT_LIST_HEAD(&sq->queued[0]);
-	INIT_LIST_HEAD(&sq->queued[1]);
+	INIT_LIST_HEAD(&sq->queued[READ]);
+	INIT_LIST_HEAD(&sq->queued[WRITE]);
 	sq->pending_tree = RB_ROOT_CACHED;
 	timer_setup(&sq->pending_timer, throtl_pending_timer_fn, 0);
 }
@@ -1150,7 +1150,7 @@ static int throtl_select_dispatch(struct throtl_service_queue *parent_sq)
 		nr_disp += throtl_dispatch_tg(tg);
 
 		sq = &tg->service_queue;
-		if (sq->nr_queued[0] || sq->nr_queued[1])
+		if (sq->nr_queued[READ] || sq->nr_queued[WRITE])
 			tg_update_disptime(tg);
 
 		if (nr_disp >= THROTL_QUANTUM)
-- 
2.31.1


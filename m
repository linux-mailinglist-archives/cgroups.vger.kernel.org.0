Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7499536B29
	for <lists+cgroups@lfdr.de>; Sat, 28 May 2022 08:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355933AbiE1Gaj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 28 May 2022 02:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355844AbiE1GaY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 28 May 2022 02:30:24 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8518D5DBF7;
        Fri, 27 May 2022 23:30:07 -0700 (PDT)
Received: from kwepemi500010.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L9BZR06MJzgYJN;
        Sat, 28 May 2022 14:28:30 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500010.china.huawei.com (7.221.188.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 28 May 2022 14:30:05 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 28 May
 2022 14:30:04 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <mkoutny@suse.com>, <axboe@kernel.dk>,
        <ming.lei@redhat.com>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next v5 7/8] blk-throttle: cleanup tg_update_disptime()
Date:   Sat, 28 May 2022 14:43:29 +0800
Message-ID: <20220528064330.3471000-8-yukuai3@huawei.com>
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

th_update_disptime() only need to adjust postion for 'tg' in
'parent_sq', there is no need to call throtl_enqueue/dequeue_tg().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index e6ae86d284b9..297ce54ceaa3 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -520,7 +520,6 @@ static void throtl_rb_erase(struct rb_node *n,
 {
 	rb_erase_cached(n, &parent_sq->pending_tree);
 	RB_CLEAR_NODE(n);
-	--parent_sq->nr_pending;
 }
 
 static void update_min_dispatch_time(struct throtl_service_queue *parent_sq)
@@ -572,7 +571,11 @@ static void throtl_enqueue_tg(struct throtl_grp *tg)
 static void throtl_dequeue_tg(struct throtl_grp *tg)
 {
 	if (tg->flags & THROTL_TG_PENDING) {
-		throtl_rb_erase(&tg->rb_node, tg->service_queue.parent_sq);
+		struct throtl_service_queue *parent_sq =
+			tg->service_queue.parent_sq;
+
+		throtl_rb_erase(&tg->rb_node, parent_sq);
+		--parent_sq->nr_pending;
 		tg->flags &= ~THROTL_TG_PENDING;
 	}
 }
@@ -1034,9 +1037,9 @@ static void tg_update_disptime(struct throtl_grp *tg)
 	disptime = jiffies + min_wait;
 
 	/* Update dispatch time */
-	throtl_dequeue_tg(tg);
+	throtl_rb_erase(&tg->rb_node, tg->service_queue.parent_sq);
 	tg->disptime = disptime;
-	throtl_enqueue_tg(tg);
+	tg_service_queue_add(tg);
 
 	/* see throtl_add_bio_tg() */
 	tg->flags &= ~THROTL_TG_WAS_EMPTY;
-- 
2.31.1


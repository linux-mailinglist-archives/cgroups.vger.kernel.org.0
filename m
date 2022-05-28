Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B75F536B28
	for <lists+cgroups@lfdr.de>; Sat, 28 May 2022 08:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355864AbiE1Gak (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 28 May 2022 02:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355854AbiE1GaY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 28 May 2022 02:30:24 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3F66007E;
        Fri, 27 May 2022 23:30:08 -0700 (PDT)
Received: from kwepemi500005.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L9BXl3LnNzRhW7;
        Sat, 28 May 2022 14:27:03 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500005.china.huawei.com (7.221.188.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 28 May 2022 14:30:06 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 28 May
 2022 14:30:05 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <mkoutny@suse.com>, <axboe@kernel.dk>,
        <ming.lei@redhat.com>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next v5 8/8] blk-throttle: clean up flag 'THROTL_TG_PENDING'
Date:   Sat, 28 May 2022 14:43:30 +0800
Message-ID: <20220528064330.3471000-9-yukuai3@huawei.com>
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

All related operations are inside 'queue_lock', there is no need to use
the flag, we only need to make sure throtl_enqueue_tg() is called when
the first bio is throttled, and throtl_dequeue_tg() is called when the
last throttled bio is dispatched.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 22 ++++++++--------------
 block/blk-throttle.h |  7 +++----
 2 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 297ce54ceaa3..fe7f01c61ba8 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -561,23 +561,16 @@ static void tg_service_queue_add(struct throtl_grp *tg)
 
 static void throtl_enqueue_tg(struct throtl_grp *tg)
 {
-	if (!(tg->flags & THROTL_TG_PENDING)) {
-		tg_service_queue_add(tg);
-		tg->flags |= THROTL_TG_PENDING;
-		tg->service_queue.parent_sq->nr_pending++;
-	}
+	tg_service_queue_add(tg);
+	tg->service_queue.parent_sq->nr_pending++;
 }
 
 static void throtl_dequeue_tg(struct throtl_grp *tg)
 {
-	if (tg->flags & THROTL_TG_PENDING) {
-		struct throtl_service_queue *parent_sq =
-			tg->service_queue.parent_sq;
+	struct throtl_service_queue *parent_sq = tg->service_queue.parent_sq;
 
-		throtl_rb_erase(&tg->rb_node, parent_sq);
-		--parent_sq->nr_pending;
-		tg->flags &= ~THROTL_TG_PENDING;
-	}
+	throtl_rb_erase(&tg->rb_node, parent_sq);
+	--parent_sq->nr_pending;
 }
 
 /* Call with queue lock held */
@@ -1015,8 +1008,9 @@ static void throtl_add_bio_tg(struct bio *bio, struct throtl_qnode *qn,
 
 	throtl_qnode_add_bio(bio, qn, &sq->queued[rw]);
 
+	if (!sq->nr_queued[READ] && !sq->nr_queued[WRITE])
+		throtl_enqueue_tg(tg);
 	sq->nr_queued[rw]++;
-	throtl_enqueue_tg(tg);
 }
 
 static void tg_update_disptime(struct throtl_grp *tg)
@@ -1371,7 +1365,7 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
 	throtl_start_new_slice(tg, READ, false);
 	throtl_start_new_slice(tg, WRITE, false);
 
-	if (tg->flags & THROTL_TG_PENDING) {
+	if (sq->nr_queued[READ] || sq->nr_queued[WRITE]) {
 		tg_update_disptime(tg);
 		throtl_schedule_next_dispatch(sq->parent_sq, true);
 	}
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index b8178e6b4d30..f68b95999f83 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -53,10 +53,9 @@ struct throtl_service_queue {
 };
 
 enum tg_state_flags {
-	THROTL_TG_PENDING	= 1 << 0,	/* on parent's pending tree */
-	THROTL_TG_WAS_EMPTY	= 1 << 1,	/* bio_lists[] became non-empty */
-	THROTL_TG_HAS_IOPS_LIMIT = 1 << 2,	/* tg has iops limit */
-	THROTL_TG_CANCELING	= 1 << 3,	/* starts to cancel bio */
+	THROTL_TG_WAS_EMPTY	= 1 << 0,	/* bio_lists[] became non-empty */
+	THROTL_TG_HAS_IOPS_LIMIT = 1 << 1,	/* tg has iops limit */
+	THROTL_TG_CANCELING	= 1 << 2,	/* starts to cancel bio */
 };
 
 enum {
-- 
2.31.1


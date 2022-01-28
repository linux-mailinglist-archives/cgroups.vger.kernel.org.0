Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380BC49F52E
	for <lists+cgroups@lfdr.de>; Fri, 28 Jan 2022 09:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347340AbiA1Iej (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Jan 2022 03:34:39 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:30318 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347313AbiA1Iej (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Jan 2022 03:34:39 -0500
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JlW2J6CM8zbkCQ;
        Fri, 28 Jan 2022 16:33:44 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500024.china.huawei.com (7.221.188.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 28 Jan 2022 16:34:36 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 28 Jan
 2022 16:34:35 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <ming.lei@redhat.com>, <tj@kernel.org>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH v7 1/2] blk-throtl: introduce a new flag THROTL_TG_CANCELING
Date:   Fri, 28 Jan 2022 16:45:21 +0800
Message-ID: <20220128084522.3169961-2-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220128084522.3169961-1-yukuai3@huawei.com>
References: <20220128084522.3169961-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

If the new flag is set, then the throtl_grp will stop throttling bios.
Prepare to canceling all throttled bios if the disk is gone.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 7c462c006b26..abc5e506c72d 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -43,8 +43,12 @@
 static struct workqueue_struct *kthrotld_workqueue;
 
 enum tg_state_flags {
-	THROTL_TG_PENDING	= 1 << 0,	/* on parent's pending tree */
-	THROTL_TG_WAS_EMPTY	= 1 << 1,	/* bio_lists[] became non-empty */
+	/* on parent's pending tree */
+	THROTL_TG_PENDING	= 1 << 0,
+	/* bio_lists[] became non-empty */
+	THROTL_TG_WAS_EMPTY	= 1 << 1,
+	/* starts to cancel all bios, will be set if the disk is deleted */
+	THROTL_TG_CANCELING	= 1 << 2,
 };
 
 #define rb_entry_tg(node)	rb_entry((node), struct throtl_grp, rb_node)
@@ -871,7 +875,8 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
 	       bio != throtl_peek_queued(&tg->service_queue.queued[rw]));
 
 	/* If tg->bps = -1, then BW is unlimited */
-	if (bps_limit == U64_MAX && iops_limit == UINT_MAX) {
+	if ((bps_limit == U64_MAX && iops_limit == UINT_MAX) ||
+	    tg->flags & THROTL_TG_CANCELING) {
 		if (wait)
 			*wait = 0;
 		return true;
@@ -974,6 +979,9 @@ static void tg_update_disptime(struct throtl_grp *tg)
 	unsigned long read_wait = -1, write_wait = -1, min_wait = -1, disptime;
 	struct bio *bio;
 
+	if (tg->flags & THROTL_TG_CANCELING)
+		goto update;
+
 	bio = throtl_peek_queued(&sq->queued[READ]);
 	if (bio)
 		tg_may_dispatch(tg, bio, &read_wait);
@@ -983,9 +991,10 @@ static void tg_update_disptime(struct throtl_grp *tg)
 		tg_may_dispatch(tg, bio, &write_wait);
 
 	min_wait = min(read_wait, write_wait);
-	disptime = jiffies + min_wait;
 
+update:
 	/* Update dispatch time */
+	disptime = jiffies + min_wait;
 	throtl_dequeue_tg(tg);
 	tg->disptime = disptime;
 	throtl_enqueue_tg(tg);
-- 
2.31.1


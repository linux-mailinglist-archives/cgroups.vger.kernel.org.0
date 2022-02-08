Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06A54AD704
	for <lists+cgroups@lfdr.de>; Tue,  8 Feb 2022 12:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359431AbiBHLba (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Feb 2022 06:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236625AbiBHLWQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Feb 2022 06:22:16 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769A0C03FEC0;
        Tue,  8 Feb 2022 03:22:12 -0800 (PST)
Received: from kwepemi100023.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JtL8k2YPDzZfSH;
        Tue,  8 Feb 2022 19:17:58 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100023.china.huawei.com (7.221.188.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 19:22:09 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 8 Feb
 2022 19:22:08 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <ming.lei@redhat.com>, <tj@kernel.org>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH v8] block: cancel all throttled bios in del_gendisk()
Date:   Tue, 8 Feb 2022 19:38:08 +0800
Message-ID: <20220208113808.1401601-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

Throttled bios can't be issued after del_gendisk() is done, thus
it's better to cancel them immediately rather than waiting for
throttle is done.

For example, if user thread is throttled with low bps while it's
issuing large io, and the device is deleted. The user thread will
wait for a long time for io to return.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
Changes in v8:
 - fold two patches into one
Changes in v7:
 - use the new solution as suggested by Ming.

 block/blk-throttle.c | 49 ++++++++++++++++++++++++++++++++++++++++----
 block/blk-throttle.h |  2 ++
 block/genhd.c        |  2 ++
 3 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 7c462c006b26..557d20796157 100644
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
@@ -1763,6 +1772,38 @@ static bool throtl_hierarchy_can_upgrade(struct throtl_grp *tg)
 	return false;
 }
 
+void blk_throtl_cancel_bios(struct request_queue *q)
+{
+	struct cgroup_subsys_state *pos_css;
+	struct blkcg_gq *blkg;
+
+	spin_lock_irq(&q->queue_lock);
+	/*
+	 * queue_lock is held, rcu lock is not needed here technically.
+	 * However, rcu lock is still held to emphasize that following
+	 * path need RCU protection and to prevent warning from lockdep.
+	 */
+	rcu_read_lock();
+	blkg_for_each_descendant_post(blkg, pos_css, q->root_blkg) {
+		struct throtl_grp *tg = blkg_to_tg(blkg);
+		struct throtl_service_queue *sq = &tg->service_queue;
+
+		/*
+		 * Set disptime in the past to make sure
+		 * throtl_select_dispatch() won't exit without dispatching.
+		 */
+		tg->disptime = jiffies - 1;
+		/*
+		 * Set the flag to make sure throtl_pending_timer_fn() won't
+		 * stop until all throttled bios are dispatched.
+		 */
+		blkg_to_tg(blkg)->flags |= THROTL_TG_CANCELING;
+		throtl_schedule_pending_timer(sq, jiffies + 1);
+	}
+	rcu_read_unlock();
+	spin_unlock_irq(&q->queue_lock);
+}
+
 static bool throtl_can_upgrade(struct throtl_data *td,
 	struct throtl_grp *this_tg)
 {
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index 175f03abd9e4..2ae467ac17ea 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -160,12 +160,14 @@ static inline void blk_throtl_exit(struct request_queue *q) { }
 static inline void blk_throtl_register_queue(struct request_queue *q) { }
 static inline void blk_throtl_charge_bio_split(struct bio *bio) { }
 static inline bool blk_throtl_bio(struct bio *bio) { return false; }
+static inline void blk_throtl_cancel_bios(struct request_queue *q) { }
 #else /* CONFIG_BLK_DEV_THROTTLING */
 int blk_throtl_init(struct request_queue *q);
 void blk_throtl_exit(struct request_queue *q);
 void blk_throtl_register_queue(struct request_queue *q);
 void blk_throtl_charge_bio_split(struct bio *bio);
 bool __blk_throtl_bio(struct bio *bio);
+void blk_throtl_cancel_bios(struct request_queue *q);
 static inline bool blk_throtl_bio(struct bio *bio)
 {
 	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
diff --git a/block/genhd.c b/block/genhd.c
index 9589d1d59afa..6acc98cd0365 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -29,6 +29,7 @@
 #include "blk.h"
 #include "blk-mq-sched.h"
 #include "blk-rq-qos.h"
+#include "blk-throttle.h"
 
 static struct kobject *block_depr;
 
@@ -625,6 +626,7 @@ void del_gendisk(struct gendisk *disk)
 
 	blk_mq_freeze_queue_wait(q);
 
+	blk_throtl_cancel_bios(disk->queue);
 	rq_qos_exit(q);
 	blk_sync_queue(q);
 	blk_flush_integrity();
-- 
2.31.1


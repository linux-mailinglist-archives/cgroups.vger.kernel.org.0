Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E7A49F530
	for <lists+cgroups@lfdr.de>; Fri, 28 Jan 2022 09:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347345AbiA1Iek (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Jan 2022 03:34:40 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:30319 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347329AbiA1Iej (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Jan 2022 03:34:39 -0500
Received: from kwepemi500023.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JlW2K48rdzbkJ7;
        Fri, 28 Jan 2022 16:33:45 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500023.china.huawei.com (7.221.188.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 28 Jan 2022 16:34:37 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 28 Jan
 2022 16:34:36 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <ming.lei@redhat.com>, <tj@kernel.org>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH v7 2/2] block: cancel all throttled bios in del_gendisk()
Date:   Fri, 28 Jan 2022 16:45:22 +0800
Message-ID: <20220128084522.3169961-3-yukuai3@huawei.com>
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

Throttled bios can't be issued after del_gendisk() is done, thus
it's better to cancel them immediately rather than waiting for
throttle is done.

For example, if user thread is throttled with low bps while it's
issuing large io, and the device is deleted. The user thread will
wait for a long time for io to return.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 32 ++++++++++++++++++++++++++++++++
 block/blk-throttle.h |  2 ++
 block/genhd.c        |  2 ++
 3 files changed, 36 insertions(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index abc5e506c72d..3280b8559ea7 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1772,6 +1772,38 @@ static bool throtl_hierarchy_can_upgrade(struct throtl_grp *tg)
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


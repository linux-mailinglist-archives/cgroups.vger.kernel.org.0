Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97DBF489A1B
	for <lists+cgroups@lfdr.de>; Mon, 10 Jan 2022 14:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbiAJNhZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Jan 2022 08:37:25 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:31084 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbiAJNgu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Jan 2022 08:36:50 -0500
Received: from kwepemi100004.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JXZXB6hr3z1FCfV;
        Mon, 10 Jan 2022 21:33:14 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100004.china.huawei.com (7.221.188.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 10 Jan 2022 21:36:48 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 10 Jan
 2022 21:36:47 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <mkoutny@suse.com>, <paulmck@kernel.org>, <tj@kernel.org>,
        <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH v6 2/2] block: cancel all throttled bios in del_gendisk()
Date:   Mon, 10 Jan 2022 21:47:58 +0800
Message-ID: <20220110134758.2233758-3-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220110134758.2233758-1-yukuai3@huawei.com>
References: <20220110134758.2233758-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Noted this patch is mainly from revertion of commit 32e3374304c7
("blk-throttle: remove tg_drain_bios") and commit b77412372b68
("blk-throttle: remove blk_throtl_drain").

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 77 ++++++++++++++++++++++++++++++++++++++++++++
 block/blk-throttle.h |  2 ++
 block/genhd.c        |  2 ++
 3 files changed, 81 insertions(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index fdd57878e862..49e783d6b0d4 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2256,6 +2256,83 @@ void blk_throtl_bio_endio(struct bio *bio)
 }
 #endif
 
+/*
+ * Dispatch all bios from all children tg's queued on @parent_sq.  On
+ * return, @parent_sq is guaranteed to not have any active children tg's
+ * and all bios from previously active tg's are on @parent_sq->bio_lists[].
+ */
+static void tg_drain_bios(struct throtl_service_queue *parent_sq)
+{
+	struct throtl_grp *tg;
+
+	while ((tg = throtl_rb_first(parent_sq))) {
+		struct throtl_service_queue *sq = &tg->service_queue;
+		struct bio *bio;
+
+		throtl_dequeue_tg(tg);
+
+		while ((bio = throtl_peek_queued(&sq->queued[READ])))
+			tg_dispatch_one_bio(tg, bio_data_dir(bio));
+		while ((bio = throtl_peek_queued(&sq->queued[WRITE])))
+			tg_dispatch_one_bio(tg, bio_data_dir(bio));
+	}
+}
+
+/**
+ * blk_throtl_cancel_bios - cancel throttled bios
+ * @q: request_queue to cancel throttled bios for
+ *
+ * This function is called to error all currently throttled bios on @q.
+ */
+void blk_throtl_cancel_bios(struct request_queue *q)
+{
+	struct throtl_data *td = q->td;
+	struct bio_list bio_list_on_stack;
+	struct blkcg_gq *blkg;
+	struct cgroup_subsys_state *pos_css;
+	struct bio *bio;
+	int rw;
+
+	bio_list_init(&bio_list_on_stack);
+
+	/*
+	 * hold queue_lock to prevent concurrent with dispatching
+	 * throttled bios by timer.
+	 */
+	spin_lock_irq(&q->queue_lock);
+
+	/*
+	 * queue_lock is held, rcu lock is not needed here technically.
+	 * However, rcu lock is still held to emphasize that following
+	 * path need RCU protection and to prevent warning from lockdep.
+	 */
+	rcu_read_lock();
+
+	/*
+	 * Drain each tg while doing post-order walk on the blkg tree, so
+	 * that all bios are propagated to td->service_queue.  It'd be
+	 * better to walk service_queue tree directly but blkg walk is
+	 * easier.
+	 */
+	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg)
+		tg_drain_bios(&blkg_to_tg(blkg)->service_queue);
+
+	/* finally, transfer bios from top-level tg's into the td */
+	tg_drain_bios(&td->service_queue);
+
+	/* all bios now should be in td->service_queue, cancel them */
+	for (rw = READ; rw <= WRITE; rw++)
+		while ((bio = throtl_pop_queued(&td->service_queue.queued[rw],
+						NULL)))
+			bio_list_add(&bio_list_on_stack, bio);
+
+	rcu_read_unlock();
+	spin_unlock_irq(&q->queue_lock);
+	if (!bio_list_empty(&bio_list_on_stack))
+		while ((bio = bio_list_pop(&bio_list_on_stack)))
+			bio_io_error(bio);
+}
+
 int blk_throtl_init(struct request_queue *q)
 {
 	struct throtl_data *td;
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index 175f03abd9e4..9d67d5139954 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -160,12 +160,14 @@ static inline void blk_throtl_exit(struct request_queue *q) { }
 static inline void blk_throtl_register_queue(struct request_queue *q) { }
 static inline void blk_throtl_charge_bio_split(struct bio *bio) { }
 static inline bool blk_throtl_bio(struct bio *bio) { return false; }
+#define blk_throtl_cancel_bios(q)  do { } while (0)
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
index c5392cc24d37..1d138f0ae26a 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -28,6 +28,7 @@
 
 #include "blk.h"
 #include "blk-rq-qos.h"
+#include "blk-throttle.h"
 
 static struct kobject *block_depr;
 
@@ -622,6 +623,7 @@ void del_gendisk(struct gendisk *disk)
 
 	blk_mq_freeze_queue_wait(q);
 
+	blk_throtl_cancel_bios(q);
 	rq_qos_exit(q);
 	blk_sync_queue(q);
 	blk_flush_integrity();
-- 
2.31.1


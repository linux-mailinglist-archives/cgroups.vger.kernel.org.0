Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A2845FDDD
	for <lists+cgroups@lfdr.de>; Sat, 27 Nov 2021 11:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353731AbhK0KEI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 27 Nov 2021 05:04:08 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:28110 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353783AbhK0KCG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 27 Nov 2021 05:02:06 -0500
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4J1Rp56tk8z1DH9w;
        Sat, 27 Nov 2021 17:56:13 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 27 Nov 2021 17:58:50 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Sat, 27 Nov
 2021 17:58:49 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <hch@infradead.org>, <tj@kernel.org>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH 3/4] blk-throtl: introduce blk_throtl_cancel_bios()
Date:   Sat, 27 Nov 2021 18:10:58 +0800
Message-ID: <20211127101059.477405-4-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211127101059.477405-1-yukuai3@huawei.com>
References: <20211127101059.477405-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This function is used to cancel all throttled bios. Noted this
modification is mainly from revertion of commit b77412372b68
("blk-throttle: remove blk_throtl_drain").

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 37 +++++++++++++++++++++++++++++++++++++
 block/blk-throttle.h |  2 ++
 2 files changed, 39 insertions(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 25822c88bea1..b31ae8a2c8b5 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2280,6 +2280,43 @@ static void tg_drain_bios(struct throtl_service_queue *parent_sq)
 	}
 }
 
+/**
+ * blk_throtl_cancel_bios - cancel throttled bios
+ * @q: request_queue to cancel throttled bios for
+ *
+ * This function is called to error all currently throttled bios on @q.
+ */
+void blk_throtl_cancel_bios(struct request_queue *q)
+{
+	struct throtl_data *td = q->td;
+	struct blkcg_gq *blkg;
+	struct cgroup_subsys_state *pos_css;
+	struct bio *bio;
+	int rw;
+
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
+	rcu_read_unlock();
+
+	/* all bios now should be in td->service_queue, cancel them */
+	for (rw = READ; rw <= WRITE; rw++)
+		while ((bio = throtl_pop_queued(&td->service_queue.queued[rw],
+						NULL)))
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
-- 
2.31.1


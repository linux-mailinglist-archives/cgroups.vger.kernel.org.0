Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD29414933
	for <lists+cgroups@lfdr.de>; Wed, 22 Sep 2021 14:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbhIVMnO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Sep 2021 08:43:14 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:16229 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235986AbhIVMnN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Sep 2021 08:43:13 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HDyZ76MvWz1DH7j;
        Wed, 22 Sep 2021 20:40:31 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Wed, 22 Sep 2021 20:41:41 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Wed, 22
 Sep 2021 20:41:41 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <tj@kernel.org>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH 3/4] blk-throtl: introduce blk_throtl_cancel_bios()
Date:   Wed, 22 Sep 2021 20:51:14 +0800
Message-ID: <20210922125115.381752-4-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210922125115.381752-1-yukuai3@huawei.com>
References: <20210922125115.381752-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This function is used to cancel all throttled bios when queue is
dying. Noted this modification is mainly from revertion of commit
b77412372b68 ("blk-throttle: remove blk_throtl_drain").

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 39 +++++++++++++++++++++++++++++++++++++++
 block/blk.h          |  2 ++
 2 files changed, 41 insertions(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 3892ead7a0b5..4227dcf2dd3b 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2435,6 +2435,45 @@ static void tg_drain_bios(struct throtl_service_queue *parent_sq)
 	}
 }
 
+/**
+ * blk_throtl_cancel_bios - cancel throttled bios
+ * @q: request_queue to cancel throttled bios for
+ *
+ * This function is called when queue is dying, error all currently
+ * throttled bios on @q so that user threads that are waiting for the bios
+ * can exit.
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
diff --git a/block/blk.h b/block/blk.h
index 7d2a0ba7ed21..c407581a3a19 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -287,12 +287,14 @@ int create_task_io_context(struct task_struct *task, gfp_t gfp_mask, int node);
  * Internal throttling interface
  */
 #ifdef CONFIG_BLK_DEV_THROTTLING
+extern void blk_throtl_cancel_bios(struct request_queue *q);
 extern int blk_throtl_init(struct request_queue *q);
 extern void blk_throtl_exit(struct request_queue *q);
 extern void blk_throtl_register_queue(struct request_queue *q);
 extern void blk_throtl_charge_bio_split(struct bio *bio);
 bool blk_throtl_bio(struct bio *bio);
 #else /* CONFIG_BLK_DEV_THROTTLING */
+static inline void blk_throtl_cancel_bios(struct request_queue *q) { }
 static inline int blk_throtl_init(struct request_queue *q) { return 0; }
 static inline void blk_throtl_exit(struct request_queue *q) { }
 static inline void blk_throtl_register_queue(struct request_queue *q) { }
-- 
2.31.1


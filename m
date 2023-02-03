Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C269D689CA6
	for <lists+cgroups@lfdr.de>; Fri,  3 Feb 2023 16:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbjBCPFK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Feb 2023 10:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbjBCPFK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Feb 2023 10:05:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564F3A2A73;
        Fri,  3 Feb 2023 07:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Z4+eYKKIU86N9JKEd9ObxAtv2j3yPOLIFRRNAL9Yp0Q=; b=XFegjYntOpBC2oNketml6Si1fd
        cVpzJL363ZxcO0fbYYLCYI8FVhrW246DyWLErBUvBVZmxbMz7+P1SVx4CpvTXI/MA8gkKmTAqLfNq
        +85jaeFCHlGnuYe85PduBSAlrrY+DhCISY/vbJeYHdmWR+Fe+M7zKRRcKBL5D0cN17ZBG41jFFiBM
        xYtpUCvfMvBvph0t7zmq86emWqeE6vl/m6PxNMLtP7KkFsKml2U1lhGrh4p1JYCF9YwYu7KB92lNC
        iWOUW/GHueiTCr9u7E4yfK1ozTvQJLFsoGhW5TNhWI0pUe1byKI0it68zfusQ2ji0yaagpRYa+yos
        oW3UevpQ==;
Received: from [2001:4bb8:19a:272a:910:bb67:7287:f956] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNxcU-002aFo-8J; Fri, 03 Feb 2023 15:04:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.de>
Subject: [PATCH 15/19] blk-rq-qos: store a gendisk instead of request_queue in struct rq_qos
Date:   Fri,  3 Feb 2023 16:03:56 +0100
Message-Id: <20230203150400.3199230-16-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230203150400.3199230-1-hch@lst.de>
References: <20230203150400.3199230-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This is what about half of the users already want, and it's only going to
grow more.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-iocost.c     | 12 ++++++------
 block/blk-iolatency.c  | 14 +++++++-------
 block/blk-mq-debugfs.c | 10 ++++------
 block/blk-rq-qos.c     |  4 ++--
 block/blk-rq-qos.h     |  2 +-
 block/blk-wbt.c        | 16 +++++++---------
 6 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 6f1da7883905b3..a2e9bf30039bcd 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -669,7 +669,7 @@ static struct ioc *q_to_ioc(struct request_queue *q)
 
 static const char __maybe_unused *ioc_name(struct ioc *ioc)
 {
-	struct gendisk *disk = ioc->rqos.q->disk;
+	struct gendisk *disk = ioc->rqos.disk;
 
 	if (!disk)
 		return "<unknown>";
@@ -808,11 +808,11 @@ static int ioc_autop_idx(struct ioc *ioc)
 	u64 now_ns;
 
 	/* rotational? */
-	if (!blk_queue_nonrot(ioc->rqos.q))
+	if (!blk_queue_nonrot(ioc->rqos.disk->queue))
 		return AUTOP_HDD;
 
 	/* handle SATA SSDs w/ broken NCQ */
-	if (blk_queue_depth(ioc->rqos.q) == 1)
+	if (blk_queue_depth(ioc->rqos.disk->queue) == 1)
 		return AUTOP_SSD_QD1;
 
 	/* use one of the normal ssd sets */
@@ -2649,7 +2649,7 @@ static void ioc_rqos_throttle(struct rq_qos *rqos, struct bio *bio)
 	if (use_debt) {
 		iocg_incur_debt(iocg, abs_cost, &now);
 		if (iocg_kick_delay(iocg, &now))
-			blkcg_schedule_throttle(rqos->q->disk,
+			blkcg_schedule_throttle(rqos->disk,
 					(bio->bi_opf & REQ_SWAP) == REQ_SWAP);
 		iocg_unlock(iocg, ioc_locked, &flags);
 		return;
@@ -2750,7 +2750,7 @@ static void ioc_rqos_merge(struct rq_qos *rqos, struct request *rq,
 	if (likely(!list_empty(&iocg->active_list))) {
 		iocg_incur_debt(iocg, abs_cost, &now);
 		if (iocg_kick_delay(iocg, &now))
-			blkcg_schedule_throttle(rqos->q->disk,
+			blkcg_schedule_throttle(rqos->disk,
 					(bio->bi_opf & REQ_SWAP) == REQ_SWAP);
 	} else {
 		iocg_commit_bio(iocg, bio, abs_cost, cost);
@@ -2821,7 +2821,7 @@ static void ioc_rqos_exit(struct rq_qos *rqos)
 {
 	struct ioc *ioc = rqos_to_ioc(rqos);
 
-	blkcg_deactivate_policy(rqos->q, &blkcg_policy_iocost);
+	blkcg_deactivate_policy(rqos->disk->queue, &blkcg_policy_iocost);
 
 	spin_lock_irq(&ioc->lock);
 	ioc->running = IOC_STOP;
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index f6aeb3d3fdae59..8e1e43bbde6f0b 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -292,7 +292,7 @@ static void __blkcg_iolatency_throttle(struct rq_qos *rqos,
 	unsigned use_delay = atomic_read(&lat_to_blkg(iolat)->use_delay);
 
 	if (use_delay)
-		blkcg_schedule_throttle(rqos->q->disk, use_memdelay);
+		blkcg_schedule_throttle(rqos->disk, use_memdelay);
 
 	/*
 	 * To avoid priority inversions we want to just take a slot if we are
@@ -330,7 +330,7 @@ static void scale_cookie_change(struct blk_iolatency *blkiolat,
 				struct child_latency_info *lat_info,
 				bool up)
 {
-	unsigned long qd = blkiolat->rqos.q->nr_requests;
+	unsigned long qd = blkiolat->rqos.disk->queue->nr_requests;
 	unsigned long scale = scale_amount(qd, up);
 	unsigned long old = atomic_read(&lat_info->scale_cookie);
 	unsigned long max_scale = qd << 1;
@@ -372,7 +372,7 @@ static void scale_cookie_change(struct blk_iolatency *blkiolat,
  */
 static void scale_change(struct iolatency_grp *iolat, bool up)
 {
-	unsigned long qd = iolat->blkiolat->rqos.q->nr_requests;
+	unsigned long qd = iolat->blkiolat->rqos.disk->queue->nr_requests;
 	unsigned long scale = scale_amount(qd, up);
 	unsigned long old = iolat->max_depth;
 
@@ -646,7 +646,7 @@ static void blkcg_iolatency_exit(struct rq_qos *rqos)
 
 	timer_shutdown_sync(&blkiolat->timer);
 	flush_work(&blkiolat->enable_work);
-	blkcg_deactivate_policy(rqos->q, &blkcg_policy_iolatency);
+	blkcg_deactivate_policy(rqos->disk->queue, &blkcg_policy_iolatency);
 	kfree(blkiolat);
 }
 
@@ -665,7 +665,7 @@ static void blkiolatency_timer_fn(struct timer_list *t)
 
 	rcu_read_lock();
 	blkg_for_each_descendant_pre(blkg, pos_css,
-				     blkiolat->rqos.q->root_blkg) {
+				     blkiolat->rqos.disk->queue->root_blkg) {
 		struct iolatency_grp *iolat;
 		struct child_latency_info *lat_info;
 		unsigned long flags;
@@ -749,9 +749,9 @@ static void blkiolatency_enable_work_fn(struct work_struct *work)
 	 */
 	enabled = atomic_read(&blkiolat->enable_cnt);
 	if (enabled != blkiolat->enabled) {
-		blk_mq_freeze_queue(blkiolat->rqos.q);
+		blk_mq_freeze_queue(blkiolat->rqos.disk->queue);
 		blkiolat->enabled = enabled;
-		blk_mq_unfreeze_queue(blkiolat->rqos.q);
+		blk_mq_unfreeze_queue(blkiolat->rqos.disk->queue);
 	}
 }
 
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index bd942341b6382f..b01818f8e216e3 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -813,9 +813,9 @@ static const char *rq_qos_id_to_name(enum rq_qos_id id)
 
 void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
 {
-	lockdep_assert_held(&rqos->q->debugfs_mutex);
+	lockdep_assert_held(&rqos->disk->queue->debugfs_mutex);
 
-	if (!rqos->q->debugfs_dir)
+	if (!rqos->disk->queue->debugfs_dir)
 		return;
 	debugfs_remove_recursive(rqos->debugfs_dir);
 	rqos->debugfs_dir = NULL;
@@ -823,7 +823,7 @@ void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
 
 void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 {
-	struct request_queue *q = rqos->q;
+	struct request_queue *q = rqos->disk->queue;
 	const char *dir_name = rq_qos_id_to_name(rqos->id);
 
 	lockdep_assert_held(&q->debugfs_mutex);
@@ -835,9 +835,7 @@ void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 		q->rqos_debugfs_dir = debugfs_create_dir("rqos",
 							 q->debugfs_dir);
 
-	rqos->debugfs_dir = debugfs_create_dir(dir_name,
-					       rqos->q->rqos_debugfs_dir);
-
+	rqos->debugfs_dir = debugfs_create_dir(dir_name, q->rqos_debugfs_dir);
 	debugfs_create_files(rqos->debugfs_dir, rqos, rqos->ops->debugfs_attrs);
 }
 
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 8e83734cfe8dbc..d8cc820a365e3a 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -300,7 +300,7 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
 {
 	struct request_queue *q = disk->queue;
 
-	rqos->q = q;
+	rqos->disk = disk;
 	rqos->id = id;
 	rqos->ops = ops;
 
@@ -337,7 +337,7 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
 
 void rq_qos_del(struct rq_qos *rqos)
 {
-	struct request_queue *q = rqos->q;
+	struct request_queue *q = rqos->disk->queue;
 	struct rq_qos **cur;
 
 	/*
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 2b7b668479f71a..b02a1a3d33a89e 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -26,7 +26,7 @@ struct rq_wait {
 
 struct rq_qos {
 	const struct rq_qos_ops *ops;
-	struct request_queue *q;
+	struct gendisk *disk;
 	enum rq_qos_id id;
 	struct rq_qos *next;
 #ifdef CONFIG_BLK_DEBUG_FS
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 1a78d54c8152b0..e49a4868453276 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -165,7 +165,7 @@ static void wb_timestamp(struct rq_wb *rwb, unsigned long *var)
  */
 static bool wb_recent_wait(struct rq_wb *rwb)
 {
-	struct bdi_writeback *wb = &rwb->rqos.q->disk->bdi->wb;
+	struct bdi_writeback *wb = &rwb->rqos.disk->bdi->wb;
 
 	return time_before(jiffies, wb->dirty_sleep + HZ);
 }
@@ -312,7 +312,7 @@ enum {
 
 static int latency_exceeded(struct rq_wb *rwb, struct blk_rq_stat *stat)
 {
-	struct backing_dev_info *bdi = rwb->rqos.q->disk->bdi;
+	struct backing_dev_info *bdi = rwb->rqos.disk->bdi;
 	struct rq_depth *rqd = &rwb->rq_depth;
 	u64 thislat;
 
@@ -365,7 +365,7 @@ static int latency_exceeded(struct rq_wb *rwb, struct blk_rq_stat *stat)
 
 static void rwb_trace_step(struct rq_wb *rwb, const char *msg)
 {
-	struct backing_dev_info *bdi = rwb->rqos.q->disk->bdi;
+	struct backing_dev_info *bdi = rwb->rqos.disk->bdi;
 	struct rq_depth *rqd = &rwb->rq_depth;
 
 	trace_wbt_step(bdi, msg, rqd->scale_step, rwb->cur_win_nsec,
@@ -435,13 +435,12 @@ static void wb_timer_fn(struct blk_stat_callback *cb)
 	unsigned int inflight = wbt_inflight(rwb);
 	int status;
 
-	if (!rwb->rqos.q->disk)
+	if (!rwb->rqos.disk)
 		return;
 
 	status = latency_exceeded(rwb, cb->stat);
 
-	trace_wbt_timer(rwb->rqos.q->disk->bdi, status, rqd->scale_step,
-			inflight);
+	trace_wbt_timer(rwb->rqos.disk->bdi, status, rqd->scale_step, inflight);
 
 	/*
 	 * If we exceeded the latency target, step down. If we did not,
@@ -779,16 +778,15 @@ static int wbt_data_dir(const struct request *rq)
 
 static void wbt_queue_depth_changed(struct rq_qos *rqos)
 {
-	RQWB(rqos)->rq_depth.queue_depth = blk_queue_depth(rqos->q);
+	RQWB(rqos)->rq_depth.queue_depth = blk_queue_depth(rqos->disk->queue);
 	wbt_update_limits(RQWB(rqos));
 }
 
 static void wbt_exit(struct rq_qos *rqos)
 {
 	struct rq_wb *rwb = RQWB(rqos);
-	struct request_queue *q = rqos->q;
 
-	blk_stat_remove_callback(q, rwb->cb);
+	blk_stat_remove_callback(rqos->disk->queue, rwb->cb);
 	blk_stat_free_callback(rwb->cb);
 	kfree(rwb);
 }
-- 
2.39.0


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C324566D7C3
	for <lists+cgroups@lfdr.de>; Tue, 17 Jan 2023 09:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbjAQIN4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Jan 2023 03:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236021AbjAQIN3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Jan 2023 03:13:29 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9081529E1E;
        Tue, 17 Jan 2023 00:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=PTrSdtrrFCTNt5QEBug34y3/Y0QuN2pyLp7l/cA/COY=; b=vUq49c9R0cI0VQQpwQSq8gpuZ5
        f06mX1QP3tETVZDmVO3w7vuc++cVZkZK7gxJ5QlM0DrmcDrzpBb7EkdFdnmix2gJCMbZUV+z9NLhW
        ZBrJBl2djB1tc9YQ6c6ZyrqAC5h+ruzWAcJSm9WYecQSaNDUG6IA3VI7cldPvHv9gSu8xYttd3bwX
        BGwUdM6jAgtIHux6CZUNYWkFxdmcz8P6K4CR8Go6kGnJmtzO7vhCKmPDByJALPlKYmbGmKq3Uewid
        KxzhDs+nRxUmBe+uSUZVri0IhOd7BEY591hDL9oz5gvi1hx+8T7dV88n/s5/HJDa8NsG6zyRO8ylx
        HjqZS8Sg==;
Received: from [2001:4bb8:19a:2039:eaa2:3b9e:be2e:bd2a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHh5w-00DHlK-8L; Tue, 17 Jan 2023 08:13:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH 09/15] blk-rq-qos: make rq_qos_add and rq_qos_del more useful
Date:   Tue, 17 Jan 2023 09:12:51 +0100
Message-Id: <20230117081257.3089859-10-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230117081257.3089859-1-hch@lst.de>
References: <20230117081257.3089859-1-hch@lst.de>
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

Switch to passing a gendisk, and make rq_qos_add initialize all required
fields and drop the not required q argument from rq_qos_del.  Also move
the code out of line given how large it is.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-iocost.c    | 13 ++-------
 block/blk-iolatency.c | 14 +++------
 block/blk-rq-qos.c    | 67 +++++++++++++++++++++++++++++++++++++++++++
 block/blk-rq-qos.h    | 62 ++-------------------------------------
 block/blk-wbt.c       |  5 +---
 5 files changed, 78 insertions(+), 83 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 6f39ca99e9d76f..9b5c0d23c9ce8b 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2836,9 +2836,7 @@ static struct rq_qos_ops ioc_rqos_ops = {
 
 static int blk_iocost_init(struct gendisk *disk)
 {
-	struct request_queue *q = disk->queue;
 	struct ioc *ioc;
-	struct rq_qos *rqos;
 	int i, cpu, ret;
 
 	ioc = kzalloc(sizeof(*ioc), GFP_KERNEL);
@@ -2861,11 +2859,6 @@ static int blk_iocost_init(struct gendisk *disk)
 		local64_set(&ccs->rq_wait_ns, 0);
 	}
 
-	rqos = &ioc->rqos;
-	rqos->id = RQ_QOS_COST;
-	rqos->ops = &ioc_rqos_ops;
-	rqos->q = q;
-
 	spin_lock_init(&ioc->lock);
 	timer_setup(&ioc->timer, ioc_timer_fn, 0);
 	INIT_LIST_HEAD(&ioc->active_iocgs);
@@ -2889,17 +2882,17 @@ static int blk_iocost_init(struct gendisk *disk)
 	 * called before policy activation completion, can't assume that the
 	 * target bio has an iocg associated and need to test for NULL iocg.
 	 */
-	ret = rq_qos_add(q, rqos);
+	ret = rq_qos_add(&ioc->rqos, disk, RQ_QOS_COST, &ioc_rqos_ops);
 	if (ret)
 		goto err_free_ioc;
 
-	ret = blkcg_activate_policy(q, &blkcg_policy_iocost);
+	ret = blkcg_activate_policy(disk->queue, &blkcg_policy_iocost);
 	if (ret)
 		goto err_del_qos;
 	return 0;
 
 err_del_qos:
-	rq_qos_del(q, rqos);
+	rq_qos_del(&ioc->rqos);
 err_free_ioc:
 	free_percpu(ioc->pcpu_stat);
 	kfree(ioc);
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index b55eac2cf91944..1c394bd77aa0b4 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -757,24 +757,18 @@ static void blkiolatency_enable_work_fn(struct work_struct *work)
 
 int blk_iolatency_init(struct gendisk *disk)
 {
-	struct request_queue *q = disk->queue;
 	struct blk_iolatency *blkiolat;
-	struct rq_qos *rqos;
 	int ret;
 
 	blkiolat = kzalloc(sizeof(*blkiolat), GFP_KERNEL);
 	if (!blkiolat)
 		return -ENOMEM;
 
-	rqos = &blkiolat->rqos;
-	rqos->id = RQ_QOS_LATENCY;
-	rqos->ops = &blkcg_iolatency_ops;
-	rqos->q = q;
-
-	ret = rq_qos_add(q, rqos);
+	ret = rq_qos_add(&blkiolat->rqos, disk, RQ_QOS_LATENCY,
+			 &blkcg_iolatency_ops);
 	if (ret)
 		goto err_free;
-	ret = blkcg_activate_policy(q, &blkcg_policy_iolatency);
+	ret = blkcg_activate_policy(disk->queue, &blkcg_policy_iolatency);
 	if (ret)
 		goto err_qos_del;
 
@@ -784,7 +778,7 @@ int blk_iolatency_init(struct gendisk *disk)
 	return 0;
 
 err_qos_del:
-	rq_qos_del(q, rqos);
+	rq_qos_del(&blkiolat->rqos);
 err_free:
 	kfree(blkiolat);
 	return ret;
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 88f0fe7dcf5451..14bee1bd761362 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -294,3 +294,70 @@ void rq_qos_exit(struct request_queue *q)
 		rqos->ops->exit(rqos);
 	}
 }
+
+int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
+		struct rq_qos_ops *ops)
+{
+	struct request_queue *q = disk->queue;
+
+	rqos->q = q;
+	rqos->id = id;
+	rqos->ops = ops;
+
+	/*
+	 * No IO can be in-flight when adding rqos, so freeze queue, which
+	 * is fine since we only support rq_qos for blk-mq queue.
+	 *
+	 * Reuse ->queue_lock for protecting against other concurrent
+	 * rq_qos adding/deleting
+	 */
+	blk_mq_freeze_queue(q);
+
+	spin_lock_irq(&q->queue_lock);
+	if (rq_qos_id(q, rqos->id))
+		goto ebusy;
+	rqos->next = q->rq_qos;
+	q->rq_qos = rqos;
+	spin_unlock_irq(&q->queue_lock);
+
+	blk_mq_unfreeze_queue(q);
+
+	if (rqos->ops->debugfs_attrs) {
+		mutex_lock(&q->debugfs_mutex);
+		blk_mq_debugfs_register_rqos(rqos);
+		mutex_unlock(&q->debugfs_mutex);
+	}
+
+	return 0;
+ebusy:
+	spin_unlock_irq(&q->queue_lock);
+	blk_mq_unfreeze_queue(q);
+	return -EBUSY;
+}
+
+void rq_qos_del(struct rq_qos *rqos)
+{
+	struct request_queue *q = rqos->q;
+	struct rq_qos **cur;
+
+	/*
+	 * See comment in rq_qos_add() about freezing queue & using
+	 * ->queue_lock.
+	 */
+	blk_mq_freeze_queue(q);
+
+	spin_lock_irq(&q->queue_lock);
+	for (cur = &q->rq_qos; *cur; cur = &(*cur)->next) {
+		if (*cur == rqos) {
+			*cur = rqos->next;
+			break;
+		}
+	}
+	spin_unlock_irq(&q->queue_lock);
+
+	blk_mq_unfreeze_queue(q);
+
+	mutex_lock(&q->debugfs_mutex);
+	blk_mq_debugfs_unregister_rqos(rqos);
+	mutex_unlock(&q->debugfs_mutex);
+}
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 1ef1f7d4bc3cbc..22552785aa31ed 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -85,65 +85,9 @@ static inline void rq_wait_init(struct rq_wait *rq_wait)
 	init_waitqueue_head(&rq_wait->wait);
 }
 
-static inline int rq_qos_add(struct request_queue *q, struct rq_qos *rqos)
-{
-	/*
-	 * No IO can be in-flight when adding rqos, so freeze queue, which
-	 * is fine since we only support rq_qos for blk-mq queue.
-	 *
-	 * Reuse ->queue_lock for protecting against other concurrent
-	 * rq_qos adding/deleting
-	 */
-	blk_mq_freeze_queue(q);
-
-	spin_lock_irq(&q->queue_lock);
-	if (rq_qos_id(q, rqos->id))
-		goto ebusy;
-	rqos->next = q->rq_qos;
-	q->rq_qos = rqos;
-	spin_unlock_irq(&q->queue_lock);
-
-	blk_mq_unfreeze_queue(q);
-
-	if (rqos->ops->debugfs_attrs) {
-		mutex_lock(&q->debugfs_mutex);
-		blk_mq_debugfs_register_rqos(rqos);
-		mutex_unlock(&q->debugfs_mutex);
-	}
-
-	return 0;
-ebusy:
-	spin_unlock_irq(&q->queue_lock);
-	blk_mq_unfreeze_queue(q);
-	return -EBUSY;
-
-}
-
-static inline void rq_qos_del(struct request_queue *q, struct rq_qos *rqos)
-{
-	struct rq_qos **cur;
-
-	/*
-	 * See comment in rq_qos_add() about freezing queue & using
-	 * ->queue_lock.
-	 */
-	blk_mq_freeze_queue(q);
-
-	spin_lock_irq(&q->queue_lock);
-	for (cur = &q->rq_qos; *cur; cur = &(*cur)->next) {
-		if (*cur == rqos) {
-			*cur = rqos->next;
-			break;
-		}
-	}
-	spin_unlock_irq(&q->queue_lock);
-
-	blk_mq_unfreeze_queue(q);
-
-	mutex_lock(&q->debugfs_mutex);
-	blk_mq_debugfs_unregister_rqos(rqos);
-	mutex_unlock(&q->debugfs_mutex);
-}
+int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
+		struct rq_qos_ops *ops);
+void rq_qos_del(struct rq_qos *rqos);
 
 typedef bool (acquire_inflight_cb_t)(struct rq_wait *rqw, void *private_data);
 typedef void (cleanup_cb_t)(struct rq_wait *rqw, void *private_data);
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 473ae72befaf1a..97149a4f10e600 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -855,9 +855,6 @@ int wbt_init(struct gendisk *disk)
 	for (i = 0; i < WBT_NUM_RWQ; i++)
 		rq_wait_init(&rwb->rq_wait[i]);
 
-	rwb->rqos.id = RQ_QOS_WBT;
-	rwb->rqos.ops = &wbt_rqos_ops;
-	rwb->rqos.q = q;
 	rwb->last_comp = rwb->last_issue = jiffies;
 	rwb->win_nsec = RWB_WINDOW_NSEC;
 	rwb->enable_state = WBT_STATE_ON_DEFAULT;
@@ -870,7 +867,7 @@ int wbt_init(struct gendisk *disk)
 	/*
 	 * Assign rwb and add the stats callback.
 	 */
-	ret = rq_qos_add(q, &rwb->rqos);
+	ret = rq_qos_add(&rwb->rqos, q->disk, RQ_QOS_WBT, &wbt_rqos_ops);
 	if (ret)
 		goto err_free;
 
-- 
2.39.0


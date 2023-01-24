Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16E0679178
	for <lists+cgroups@lfdr.de>; Tue, 24 Jan 2023 07:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjAXG6P (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Jan 2023 01:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbjAXG6O (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Jan 2023 01:58:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDB32D6C;
        Mon, 23 Jan 2023 22:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=NSEGg4hu+yYGIYyriP9UunThT4gHvFThnRQUpfjPPA0=; b=jnlQEPKsdpsMWwXqeunS85L5kx
        MzqzXMMMu/VV3SrENNTE+WMwxhG5M6Y28Zn/WG4ZIiQZEWzLR2KEf7d/Vr7tMVXWb8SuaaoFE+Z+1
        zADFrEpaLWCgQxgLnB24+q+9BVQ9lizLwLz6guXX8bt43l8dU0L/6yPeo03El3XCtKBr+XkrHT4Fj
        Kb7kFcKubWerbTy7fPASO3wo2dMHqKF7mqD5VDXNTISPiUdXjMDvJlRFsO2NbdOu8aXvdWZYYQTH+
        DGh4XaJTsbB9nA0zWw28LMBaqlwL6ZRiN2cu7Q/CZPpC33nQ0590cd5bND6UQ2qS+vl0sQXpLHBPk
        SE5cb/7A==;
Received: from [2001:4bb8:19a:27af:ea4c:1aa8:8f64:2866] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKDFr-002aWJ-Du; Tue, 24 Jan 2023 06:58:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.de>
Subject: [PATCH 12/15] blk-cgroup: pass a gendisk to blkcg_{de,}activate_policy
Date:   Tue, 24 Jan 2023 07:57:12 +0100
Message-Id: <20230124065716.152286-13-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230124065716.152286-1-hch@lst.de>
References: <20230124065716.152286-1-hch@lst.de>
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

Prepare for storing the blkcg information in the gendisk instead of
the request_queue.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
---
 block/bfq-cgroup.c    |  2 +-
 block/bfq-iosched.c   |  2 +-
 block/blk-cgroup.c    | 21 +++++++++++----------
 block/blk-cgroup.h    |  9 ++++-----
 block/blk-iocost.c    |  4 ++--
 block/blk-iolatency.c |  4 ++--
 block/blk-ioprio.c    |  4 ++--
 block/blk-throttle.c  |  4 ++--
 8 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 72a033776722c9..b1b8eca99d988f 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -1293,7 +1293,7 @@ struct bfq_group *bfq_create_group_hierarchy(struct bfq_data *bfqd, int node)
 {
 	int ret;
 
-	ret = blkcg_activate_policy(bfqd->queue, &blkcg_policy_bfq);
+	ret = blkcg_activate_policy(bfqd->queue->disk, &blkcg_policy_bfq);
 	if (ret)
 		return NULL;
 
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 68062243f2c142..eda3a838f3c3fd 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -7155,7 +7155,7 @@ static void bfq_exit_queue(struct elevator_queue *e)
 	bfqg_and_blkg_put(bfqd->root_group);
 
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
-	blkcg_deactivate_policy(bfqd->queue, &blkcg_policy_bfq);
+	blkcg_deactivate_policy(bfqd->queue->disk, &blkcg_policy_bfq);
 #else
 	spin_lock_irq(&bfqd->lock);
 	bfq_put_async_queues(bfqd, bfqd->root_group);
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 603e911d1350db..43cd02631162f8 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1362,14 +1362,14 @@ struct cgroup_subsys io_cgrp_subsys = {
 EXPORT_SYMBOL_GPL(io_cgrp_subsys);
 
 /**
- * blkcg_activate_policy - activate a blkcg policy on a request_queue
- * @q: request_queue of interest
+ * blkcg_activate_policy - activate a blkcg policy on a gendisk
+ * @disk: gendisk of interest
  * @pol: blkcg policy to activate
  *
- * Activate @pol on @q.  Requires %GFP_KERNEL context.  @q goes through
+ * Activate @pol on @disk.  Requires %GFP_KERNEL context.  @disk goes through
  * bypass mode to populate its blkgs with policy_data for @pol.
  *
- * Activation happens with @q bypassed, so nobody would be accessing blkgs
+ * Activation happens with @disk bypassed, so nobody would be accessing blkgs
  * from IO path.  Update of each blkg is protected by both queue and blkcg
  * locks so that holding either lock and testing blkcg_policy_enabled() is
  * always enough for dereferencing policy data.
@@ -1377,9 +1377,9 @@ EXPORT_SYMBOL_GPL(io_cgrp_subsys);
  * The caller is responsible for synchronizing [de]activations and policy
  * [un]registerations.  Returns 0 on success, -errno on failure.
  */
-int blkcg_activate_policy(struct request_queue *q,
-			  const struct blkcg_policy *pol)
+int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 {
+	struct request_queue *q = disk->queue;
 	struct blkg_policy_data *pd_prealloc = NULL;
 	struct blkcg_gq *blkg, *pinned_blkg = NULL;
 	int ret;
@@ -1473,16 +1473,17 @@ int blkcg_activate_policy(struct request_queue *q,
 EXPORT_SYMBOL_GPL(blkcg_activate_policy);
 
 /**
- * blkcg_deactivate_policy - deactivate a blkcg policy on a request_queue
- * @q: request_queue of interest
+ * blkcg_deactivate_policy - deactivate a blkcg policy on a gendisk
+ * @disk: gendisk of interest
  * @pol: blkcg policy to deactivate
  *
- * Deactivate @pol on @q.  Follows the same synchronization rules as
+ * Deactivate @pol on @disk.  Follows the same synchronization rules as
  * blkcg_activate_policy().
  */
-void blkcg_deactivate_policy(struct request_queue *q,
+void blkcg_deactivate_policy(struct gendisk *disk,
 			     const struct blkcg_policy *pol)
 {
+	struct request_queue *q = disk->queue;
 	struct blkcg_gq *blkg;
 
 	if (!blkcg_policy_enabled(q, pol))
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 85b267234823ab..e9e0c00d13d64d 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -190,9 +190,8 @@ void blkcg_exit_disk(struct gendisk *disk);
 /* Blkio controller policy registration */
 int blkcg_policy_register(struct blkcg_policy *pol);
 void blkcg_policy_unregister(struct blkcg_policy *pol);
-int blkcg_activate_policy(struct request_queue *q,
-			  const struct blkcg_policy *pol);
-void blkcg_deactivate_policy(struct request_queue *q,
+int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol);
+void blkcg_deactivate_policy(struct gendisk *disk,
 			     const struct blkcg_policy *pol);
 
 const char *blkg_dev_name(struct blkcg_gq *blkg);
@@ -491,9 +490,9 @@ static inline int blkcg_init_disk(struct gendisk *disk) { return 0; }
 static inline void blkcg_exit_disk(struct gendisk *disk) { }
 static inline int blkcg_policy_register(struct blkcg_policy *pol) { return 0; }
 static inline void blkcg_policy_unregister(struct blkcg_policy *pol) { }
-static inline int blkcg_activate_policy(struct request_queue *q,
+static inline int blkcg_activate_policy(struct gendisk *disk,
 					const struct blkcg_policy *pol) { return 0; }
-static inline void blkcg_deactivate_policy(struct request_queue *q,
+static inline void blkcg_deactivate_policy(struct gendisk *disk,
 					   const struct blkcg_policy *pol) { }
 
 static inline struct blkg_policy_data *blkg_to_pd(struct blkcg_gq *blkg,
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index a2e9bf30039bcd..078b7770951962 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2821,7 +2821,7 @@ static void ioc_rqos_exit(struct rq_qos *rqos)
 {
 	struct ioc *ioc = rqos_to_ioc(rqos);
 
-	blkcg_deactivate_policy(rqos->disk->queue, &blkcg_policy_iocost);
+	blkcg_deactivate_policy(rqos->disk, &blkcg_policy_iocost);
 
 	spin_lock_irq(&ioc->lock);
 	ioc->running = IOC_STOP;
@@ -2893,7 +2893,7 @@ static int blk_iocost_init(struct gendisk *disk)
 	if (ret)
 		goto err_free_ioc;
 
-	ret = blkcg_activate_policy(disk->queue, &blkcg_policy_iocost);
+	ret = blkcg_activate_policy(disk, &blkcg_policy_iocost);
 	if (ret)
 		goto err_del_qos;
 	return 0;
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 8e1e43bbde6f0b..39853fc5c2b02f 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -646,7 +646,7 @@ static void blkcg_iolatency_exit(struct rq_qos *rqos)
 
 	timer_shutdown_sync(&blkiolat->timer);
 	flush_work(&blkiolat->enable_work);
-	blkcg_deactivate_policy(rqos->disk->queue, &blkcg_policy_iolatency);
+	blkcg_deactivate_policy(rqos->disk, &blkcg_policy_iolatency);
 	kfree(blkiolat);
 }
 
@@ -768,7 +768,7 @@ int blk_iolatency_init(struct gendisk *disk)
 			 &blkcg_iolatency_ops);
 	if (ret)
 		goto err_free;
-	ret = blkcg_activate_policy(disk->queue, &blkcg_policy_iolatency);
+	ret = blkcg_activate_policy(disk, &blkcg_policy_iolatency);
 	if (ret)
 		goto err_qos_del;
 
diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
index 8bb6b8eba4cee8..8194826cc824bc 100644
--- a/block/blk-ioprio.c
+++ b/block/blk-ioprio.c
@@ -204,12 +204,12 @@ void blkcg_set_ioprio(struct bio *bio)
 
 void blk_ioprio_exit(struct gendisk *disk)
 {
-	blkcg_deactivate_policy(disk->queue, &ioprio_policy);
+	blkcg_deactivate_policy(disk, &ioprio_policy);
 }
 
 int blk_ioprio_init(struct gendisk *disk)
 {
-	return blkcg_activate_policy(disk->queue, &ioprio_policy);
+	return blkcg_activate_policy(disk, &ioprio_policy);
 }
 
 static int __init ioprio_init(void)
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index f802d8f9099430..efc0a9092c6942 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2395,7 +2395,7 @@ int blk_throtl_init(struct gendisk *disk)
 	td->low_downgrade_time = jiffies;
 
 	/* activate policy */
-	ret = blkcg_activate_policy(q, &blkcg_policy_throtl);
+	ret = blkcg_activate_policy(disk, &blkcg_policy_throtl);
 	if (ret) {
 		free_percpu(td->latency_buckets[READ]);
 		free_percpu(td->latency_buckets[WRITE]);
@@ -2411,7 +2411,7 @@ void blk_throtl_exit(struct gendisk *disk)
 	BUG_ON(!q->td);
 	del_timer_sync(&q->td->service_queue.pending_timer);
 	throtl_shutdown_wq(q);
-	blkcg_deactivate_policy(q, &blkcg_policy_throtl);
+	blkcg_deactivate_policy(disk, &blkcg_policy_throtl);
 	free_percpu(q->td->latency_buckets[READ]);
 	free_percpu(q->td->latency_buckets[WRITE]);
 	kfree(q->td);
-- 
2.39.0


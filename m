Return-Path: <cgroups+bounces-14594-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECFlGa3hp2mrlAAAu9opvQ
	(envelope-from <cgroups+bounces-14594-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 08:39:25 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFFB1FBB4E
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 08:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 63AF93051ABA
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2026 07:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC6C371869;
	Wed,  4 Mar 2026 07:38:32 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A481036F438;
	Wed,  4 Mar 2026 07:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772609912; cv=none; b=pM68EDtKSjAGxOwcRE+ASfI4FW9ZTtEXfob8AJYrvFvw7DFiwNGkI2KNrsEGtJJI2xXpReR/qferHKhmgOFZ/bxfGtjVExh763Xg7zyNscL7qY+yv0OUocBpHpziZoNS3AUtX9/Z2GjACe/lOqu9XN31bm19DY6dErroeJR09gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772609912; c=relaxed/simple;
	bh=koV0sJD4Z1/UqnRiMVYBYj17B8YK+Mf46MVKcY/HxNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IuUjKg9bIQHzeMOJSXXU0sAeujqdYgT+xFvjhx2MhwTrMR/DU2f9m7YwFQSVyUTE20ZVvexxsPQKu4xjpB942Qri3RnWVHEv1pOzjWJxUHYX7sZzcrWgAy9yG5hDN+OXmOS0gUmGCI9Oew3o1WN0QSrlQXe/a+2oXnNxHhXEtUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21DF7C19423;
	Wed,  4 Mar 2026 07:38:29 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zheng Qixing <zhengqixing@huawei.com>,
	Ming Lei <ming.lei@redhat.com>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v3 7/7] blk-rq-qos: move rq_qos_mutex acquisition inside rq_qos_add/del
Date: Wed,  4 Mar 2026 15:38:08 +0800
Message-ID: <20260304073809.3438679-8-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260304073809.3438679-1-yukuai@fnnas.com>
References: <20260304073809.3438679-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1FFFB1FBB4E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-14594-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[fnnas.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yukuai@fnnas.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.991];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fnnas.com:mid,fnnas.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

The current rq_qos_mutex handling has an awkward pattern where callers
must acquire the mutex before calling rq_qos_add()/rq_qos_del(), and
blkg_conf_open_bdev_frozen() had to release and re-acquire the mutex
around queue freezing to maintain proper locking order (freeze queue
before mutex).

On the other hand, with rq_qos_mutex held after blkg_conf_prep(), there
are many possible deadlocks:

- allocating memory with GFP_KERNEL, like blk_throtl_init();
- allocating percpu memory, like pd_alloc_fn() for iocost/iolatency;

This patch refactors the locking by:

1. Moving queue freeze and rq_qos_mutex acquisition inside
   rq_qos_add()/rq_qos_del(), with the correct order: freeze first,
   then acquire mutex.

2. Removing external mutex handling from wbt_init() since rq_qos_add()
   now handles it internally.

3. Removing rq_qos_mutex handling from blkg_conf_open_bdev() entirely,
   making it only responsible for parsing MAJ:MIN and opening the bdev.

4. Removing blkg_conf_open_bdev_frozen() and blkg_conf_exit_frozen()
   functions which are no longer needed.

5. Updating ioc_qos_write() to use the simpler blkg_conf_open_bdev()
   and blkg_conf_exit() functions.

This eliminates the release-and-reacquire pattern and makes
rq_qos_add()/rq_qos_del() self-contained, which is cleaner and reduces
complexity. Each function now properly manages its own locking with
the correct order: queue freeze → mutex acquire → modify → mutex
release → queue unfreeze.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 block/blk-cgroup.c    | 50 -------------------------------------------
 block/blk-cgroup.h    |  2 --
 block/blk-iocost.c    | 11 ++++------
 block/blk-iolatency.c |  5 -----
 block/blk-rq-qos.c    | 31 ++++++++++++++++-----------
 block/blk-wbt.c       |  2 --
 6 files changed, 22 insertions(+), 79 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 1620be75f124..02ef8f60f759 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -802,10 +802,8 @@ int blkg_conf_open_bdev(struct blkg_conf_ctx *ctx)
 		return -ENODEV;
 	}
 
-	mutex_lock(&bdev->bd_queue->rq_qos_mutex);
 	if (!disk_live(bdev->bd_disk)) {
 		blkdev_put_no_open(bdev);
-		mutex_unlock(&bdev->bd_queue->rq_qos_mutex);
 		return -ENODEV;
 	}
 
@@ -813,38 +811,6 @@ int blkg_conf_open_bdev(struct blkg_conf_ctx *ctx)
 	ctx->bdev = bdev;
 	return 0;
 }
-/*
- * Similar to blkg_conf_open_bdev, but additionally freezes the queue,
- * ensures the correct locking order between freeze queue and q->rq_qos_mutex.
- *
- * This function returns negative error on failure. On success it returns
- * memflags which must be saved and later passed to blkg_conf_exit_frozen
- * for restoring the memalloc scope.
- */
-unsigned long __must_check blkg_conf_open_bdev_frozen(struct blkg_conf_ctx *ctx)
-{
-	int ret;
-	unsigned long memflags;
-
-	if (ctx->bdev)
-		return -EINVAL;
-
-	ret = blkg_conf_open_bdev(ctx);
-	if (ret < 0)
-		return ret;
-	/*
-	 * At this point, we haven’t started protecting anything related to QoS,
-	 * so we release q->rq_qos_mutex here, which was first acquired in blkg_
-	 * conf_open_bdev. Later, we re-acquire q->rq_qos_mutex after freezing
-	 * the queue to maintain the correct locking order.
-	 */
-	mutex_unlock(&ctx->bdev->bd_queue->rq_qos_mutex);
-
-	memflags = blk_mq_freeze_queue(ctx->bdev->bd_queue);
-	mutex_lock(&ctx->bdev->bd_queue->rq_qos_mutex);
-
-	return memflags;
-}
 
 /**
  * blkg_conf_prep - parse and prepare for per-blkg config update
@@ -978,7 +944,6 @@ EXPORT_SYMBOL_GPL(blkg_conf_prep);
  */
 void blkg_conf_exit(struct blkg_conf_ctx *ctx)
 	__releases(&ctx->bdev->bd_queue->queue_lock)
-	__releases(&ctx->bdev->bd_queue->rq_qos_mutex)
 {
 	if (ctx->blkg) {
 		spin_unlock_irq(&bdev_get_queue(ctx->bdev)->queue_lock);
@@ -986,7 +951,6 @@ void blkg_conf_exit(struct blkg_conf_ctx *ctx)
 	}
 
 	if (ctx->bdev) {
-		mutex_unlock(&ctx->bdev->bd_queue->rq_qos_mutex);
 		blkdev_put_no_open(ctx->bdev);
 		ctx->body = NULL;
 		ctx->bdev = NULL;
@@ -994,20 +958,6 @@ void blkg_conf_exit(struct blkg_conf_ctx *ctx)
 }
 EXPORT_SYMBOL_GPL(blkg_conf_exit);
 
-/*
- * Similar to blkg_conf_exit, but also unfreezes the queue. Should be used
- * when blkg_conf_open_bdev_frozen is used to open the bdev.
- */
-void blkg_conf_exit_frozen(struct blkg_conf_ctx *ctx, unsigned long memflags)
-{
-	if (ctx->bdev) {
-		struct request_queue *q = ctx->bdev->bd_queue;
-
-		blkg_conf_exit(ctx);
-		blk_mq_unfreeze_queue(q, memflags);
-	}
-}
-
 static void blkg_iostat_add(struct blkg_iostat *dst, struct blkg_iostat *src)
 {
 	int i;
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 1cce3294634d..d4e7f78ba545 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -219,11 +219,9 @@ struct blkg_conf_ctx {
 
 void blkg_conf_init(struct blkg_conf_ctx *ctx, char *input);
 int blkg_conf_open_bdev(struct blkg_conf_ctx *ctx);
-unsigned long blkg_conf_open_bdev_frozen(struct blkg_conf_ctx *ctx);
 int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		   struct blkg_conf_ctx *ctx);
 void blkg_conf_exit(struct blkg_conf_ctx *ctx);
-void blkg_conf_exit_frozen(struct blkg_conf_ctx *ctx, unsigned long memflags);
 
 /**
  * bio_issue_as_root_blkg - see if this bio needs to be issued as root blkg
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index ef543d163d46..104a9a9f563f 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3220,16 +3220,13 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	u32 qos[NR_QOS_PARAMS];
 	bool enable, user;
 	char *body, *p;
-	unsigned long memflags;
 	int ret;
 
 	blkg_conf_init(&ctx, input);
 
-	memflags = blkg_conf_open_bdev_frozen(&ctx);
-	if (IS_ERR_VALUE(memflags)) {
-		ret = memflags;
+	ret = blkg_conf_open_bdev(&ctx);
+	if (ret)
 		goto err;
-	}
 
 	body = ctx.body;
 	disk = ctx.bdev->bd_disk;
@@ -3346,14 +3343,14 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 
 	blk_mq_unquiesce_queue(disk->queue);
 
-	blkg_conf_exit_frozen(&ctx, memflags);
+	blkg_conf_exit(&ctx);
 	return nbytes;
 einval:
 	spin_unlock_irq(&ioc->lock);
 	blk_mq_unquiesce_queue(disk->queue);
 	ret = -EINVAL;
 err:
-	blkg_conf_exit_frozen(&ctx, memflags);
+	blkg_conf_exit(&ctx);
 	return ret;
 }
 
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index f7434278cd29..3f454fb3ff51 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -842,11 +842,6 @@ static ssize_t iolatency_set_limit(struct kernfs_open_file *of, char *buf,
 	if (ret)
 		goto out;
 
-	/*
-	 * blk_iolatency_init() may fail after rq_qos_add() succeeds which can
-	 * confuse iolat_rq_qos() test. Make the test and init atomic.
-	 */
-	lockdep_assert_held(&ctx.bdev->bd_queue->rq_qos_mutex);
 	if (!iolat_rq_qos(ctx.bdev->bd_queue))
 		ret = blk_iolatency_init(ctx.bdev->bd_disk);
 	if (ret)
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 85cf74402a09..fe96183bcc75 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -327,8 +327,7 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
 {
 	struct request_queue *q = disk->queue;
 	unsigned int memflags;
-
-	lockdep_assert_held(&q->rq_qos_mutex);
+	int ret = 0;
 
 	rqos->disk = disk;
 	rqos->id = id;
@@ -337,20 +336,24 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
 	/*
 	 * No IO can be in-flight when adding rqos, so freeze queue, which
 	 * is fine since we only support rq_qos for blk-mq queue.
+	 *
+	 * Acquire rq_qos_mutex after freezing the queue to ensure proper
+	 * locking order.
 	 */
 	memflags = blk_mq_freeze_queue(q);
+	mutex_lock(&q->rq_qos_mutex);
 
-	if (rq_qos_id(q, rqos->id))
-		goto ebusy;
-	rqos->next = q->rq_qos;
-	q->rq_qos = rqos;
-	blk_queue_flag_set(QUEUE_FLAG_QOS_ENABLED, q);
+	if (rq_qos_id(q, rqos->id)) {
+		ret = -EBUSY;
+	} else {
+		rqos->next = q->rq_qos;
+		q->rq_qos = rqos;
+		blk_queue_flag_set(QUEUE_FLAG_QOS_ENABLED, q);
+	}
 
+	mutex_unlock(&q->rq_qos_mutex);
 	blk_mq_unfreeze_queue(q, memflags);
-	return 0;
-ebusy:
-	blk_mq_unfreeze_queue(q, memflags);
-	return -EBUSY;
+	return ret;
 }
 
 void rq_qos_del(struct rq_qos *rqos)
@@ -359,9 +362,9 @@ void rq_qos_del(struct rq_qos *rqos)
 	struct rq_qos **cur;
 	unsigned int memflags;
 
-	lockdep_assert_held(&q->rq_qos_mutex);
-
 	memflags = blk_mq_freeze_queue(q);
+	mutex_lock(&q->rq_qos_mutex);
+
 	for (cur = &q->rq_qos; *cur; cur = &(*cur)->next) {
 		if (*cur == rqos) {
 			*cur = rqos->next;
@@ -370,5 +373,7 @@ void rq_qos_del(struct rq_qos *rqos)
 	}
 	if (!q->rq_qos)
 		blk_queue_flag_clear(QUEUE_FLAG_QOS_ENABLED, q);
+
+	mutex_unlock(&q->rq_qos_mutex);
 	blk_mq_unfreeze_queue(q, memflags);
 }
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 6dba71e87387..dde03b9ea074 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -961,9 +961,7 @@ static int wbt_init(struct gendisk *disk, struct rq_wb *rwb)
 	/*
 	 * Assign rwb and add the stats callback.
 	 */
-	mutex_lock(&q->rq_qos_mutex);
 	ret = rq_qos_add(&rwb->rqos, disk, RQ_QOS_WBT, &wbt_rqos_ops);
-	mutex_unlock(&q->rq_qos_mutex);
 	if (ret)
 		return ret;
 
-- 
2.51.0



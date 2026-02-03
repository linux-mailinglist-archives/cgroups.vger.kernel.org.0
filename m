Return-Path: <cgroups+bounces-13631-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJKxFretgWn0IQMAu9opvQ
	(envelope-from <cgroups+bounces-13631-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Feb 2026 09:11:35 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03138D60C7
	for <lists+cgroups@lfdr.de>; Tue, 03 Feb 2026 09:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 286E13116E8D
	for <lists+cgroups@lfdr.de>; Tue,  3 Feb 2026 08:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E74392C5F;
	Tue,  3 Feb 2026 08:06:30 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF58392C32;
	Tue,  3 Feb 2026 08:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770105990; cv=none; b=fkq4JJxvwzz7AeBHpxQljooUV9bDWtV/T3/nly/25DD75DUtizIT6OM2TqVPJRAEuuaq84il2QcTwEUYt7ci6Bu1ZYbVQFM7i/xQcqFASnaLlXt57NDLfXRw4GYgIHXA7sI+iRLhkBAWOSYZ3ph9QUvPCobmlzRCE9WPe9cI2XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770105990; c=relaxed/simple;
	bh=IALjKEOLR0+k6Jpr19pd2DLmBqx2bWcQEj5oCCFwaJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LMTgdo2GcfsyHGOYt4EdRYLoDvE2FnmhYMGr8Ql7j7PLeu+LDD16ia/APyYT3KyrqP6k+jT7h/WCZ2JlGVKTnb5jdQyNw/sRKNjegYQl+5+RTEimMFykT3O0UhEHXvk5jbvVuaQdXcSrcNZwHW9DO3tCsb4s/38ky0YeLhCiLz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73485C116D0;
	Tue,  3 Feb 2026 08:06:27 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai@fnnas.com,
	zhengqixing@huawei.com,
	mkoutny@suse.com,
	hch@infradead.org,
	ming.lei@redhat.com,
	nilay@linux.ibm.com
Subject: [PATCH v2 7/7] blk-rq-qos: move rq_qos_mutex acquisition inside rq_qos_add/del
Date: Tue,  3 Feb 2026 16:06:02 +0800
Message-ID: <20260203080602.726505-8-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260203080602.726505-1-yukuai@fnnas.com>
References: <20260203080602.726505-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13631-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[fnnas.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yukuai@fnnas.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fnnas.com:mid,fnnas.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 03138D60C7
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
 block/blk-cgroup.c | 50 ----------------------------------------------
 block/blk-cgroup.h |  2 --
 block/blk-iocost.c | 11 ++++------
 block/blk-rq-qos.c | 31 ++++++++++++++++------------
 block/blk-wbt.c    |  2 --
 5 files changed, 22 insertions(+), 74 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 7fcb216917d0..d17d2b44df43 100644
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
index 1415f2bf8611..a636dea27270 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -960,9 +960,7 @@ static int wbt_init(struct gendisk *disk, struct rq_wb *rwb)
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



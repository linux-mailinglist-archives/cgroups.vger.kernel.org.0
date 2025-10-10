Return-Path: <cgroups+bounces-10648-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C52CBCC539
	for <lists+cgroups@lfdr.de>; Fri, 10 Oct 2025 11:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1C423C83FE
	for <lists+cgroups@lfdr.de>; Fri, 10 Oct 2025 09:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BBB275AFE;
	Fri, 10 Oct 2025 09:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGveJ0K3"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27A428153A;
	Fri, 10 Oct 2025 09:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760087747; cv=none; b=SF/lkeYZQpxULZVZaYZwtpV/0Tk9lYVdGCrz3UHV4a3/yjH8gT1Z1jmGY0SYl723VrwtIQHyVpocPi/+twSrtLStr1i1St2SpMZt0+N5ByAcxL/3K4Qvb87MQLVMmEQV/Ef39bv8Bzn/P6XS17WDlNSeuTxRea1e8GvsEANKSxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760087747; c=relaxed/simple;
	bh=cJvhoPRiXOlxs+zH/XVaJ4God3JTKZGfA+vj8Ps5Zvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cxFBwBQ997lFr6AXS0cTQT4uQh59+9unSuJf3dcICH1dXowUzs1GErzHqM8YO8T47V0yYbSTT2c1O5/ZSQ/V+8tccYbNPT//vOYMYQHcnyb2VRnSMk6vTKSFYns8HvhX6NsGgxvdKnwSExNecGc4cX8yhHce1OUkh+eRSZyPF+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGveJ0K3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919E7C4CEF1;
	Fri, 10 Oct 2025 09:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760087746;
	bh=cJvhoPRiXOlxs+zH/XVaJ4God3JTKZGfA+vj8Ps5Zvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tGveJ0K3n9rjtc9cLpwOOkTxehk838nZLm/2mI3EY2pKs8/pdEzRwM1lST9GyRequ
	 Z9Cglgz0UXnPaTS8DNnpXmgjB9nroM3FMi0Ry9OZW61u8ufYcZAVIBfjtU6/URgOHs
	 BcJJA/xXtUTstv5ota6E0RsByeGbsVF/RDGHfR4UUkvZRmbupT3ebNwZg11P1OKLKf
	 05QYAz+9Z7mtIkWhUwHFX52gnNTNTD4X/eUaRnhKIXDhiEpgULHajRIvLCCLy2Hid2
	 hSbjoKqHP86kLB7bvNLzS/8yyqrzGL7eTBuushkecsl0cQUTN0OThYkxiojnv/S6Qz
	 4vT1hKFRznFiA==
From: Yu Kuai <yukuai@kernel.org>
To: axboe@kernel.dk,
	tj@kernel.org,
	linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	nilay@linux.ibm.com,
	bvanassche@acm.org,
	ming.lei@redhat.com,
	hch@lst.de
Cc: linux-kernel@vger.kernel.org,
	Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH v2 19/19] blk-cgroup: remove unsed blkg configuration helpers
Date: Fri, 10 Oct 2025 17:14:44 +0800
Message-ID: <20251010091446.3048529-20-yukuai@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010091446.3048529-1-yukuai@kernel.org>
References: <20251010091446.3048529-1-yukuai@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Yu Kuai <yukuai3@huawei.com>

Remove followings helpers that is now unused:

- blkg_conf_open_bdev()
- blkg_conf_open_bdev_frozen()
- blkg_conf_prep()
- blkg_conf_exit()
- blkg_conf_exit_frozen()

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-cgroup.c | 224 +--------------------------------------------
 block/blk-cgroup.h |   6 --
 2 files changed, 1 insertion(+), 229 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 4b7324c1d0d5..d93654334854 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -729,8 +729,7 @@ EXPORT_SYMBOL_GPL(__blkg_prfill_u64);
  * @input: input string
  *
  * Initialize @ctx which can be used to parse blkg config input string @input.
- * Once initialized, @ctx can be used with blkg_conf_open_bdev() and
- * blkg_conf_prep(), and must be cleaned up with blkg_conf_exit().
+ * Once initialized, @ctx can be used with blkg_conf_start().
  */
 void blkg_conf_init(struct blkg_conf_ctx *ctx, char *input)
 {
@@ -738,92 +737,6 @@ void blkg_conf_init(struct blkg_conf_ctx *ctx, char *input)
 }
 EXPORT_SYMBOL_GPL(blkg_conf_init);
 
-/**
- * blkg_conf_open_bdev - parse and open bdev for per-blkg config update
- * @ctx: blkg_conf_ctx initialized with blkg_conf_init()
- *
- * Parse the device node prefix part, MAJ:MIN, of per-blkg config update from
- * @ctx->input and get and store the matching bdev in @ctx->bdev. @ctx->body is
- * set to point past the device node prefix.
- *
- * This function may be called multiple times on @ctx and the extra calls become
- * NOOPs. blkg_conf_prep() implicitly calls this function. Use this function
- * explicitly if bdev access is needed without resolving the blkcg / policy part
- * of @ctx->input. Returns -errno on error.
- */
-int blkg_conf_open_bdev(struct blkg_conf_ctx *ctx)
-{
-	char *input = ctx->input;
-	unsigned int major, minor;
-	struct block_device *bdev;
-	int key_len;
-
-	if (ctx->bdev)
-		return 0;
-
-	if (sscanf(input, "%u:%u%n", &major, &minor, &key_len) != 2)
-		return -EINVAL;
-
-	input += key_len;
-	if (!isspace(*input))
-		return -EINVAL;
-	input = skip_spaces(input);
-
-	bdev = blkdev_get_no_open(MKDEV(major, minor), false);
-	if (!bdev)
-		return -ENODEV;
-	if (bdev_is_partition(bdev)) {
-		blkdev_put_no_open(bdev);
-		return -ENODEV;
-	}
-
-	mutex_lock(&bdev->bd_queue->rq_qos_mutex);
-	if (!disk_live(bdev->bd_disk)) {
-		blkdev_put_no_open(bdev);
-		mutex_unlock(&bdev->bd_queue->rq_qos_mutex);
-		return -ENODEV;
-	}
-
-	ctx->body = input;
-	ctx->bdev = bdev;
-	return 0;
-}
-/*
- * Similar to blkg_conf_open_bdev, but additionally freezes the queue,
- * acquires q->elevator_lock, and ensures the correct locking order
- * between q->elevator_lock and q->rq_qos_mutex.
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
-	 * the queue and acquiring q->elevator_lock to maintain the correct
-	 * locking order.
-	 */
-	mutex_unlock(&ctx->bdev->bd_queue->rq_qos_mutex);
-
-	memflags = blk_mq_freeze_queue(ctx->bdev->bd_queue);
-	mutex_lock(&ctx->bdev->bd_queue->elevator_lock);
-	mutex_lock(&ctx->bdev->bd_queue->rq_qos_mutex);
-
-	return memflags;
-}
-
 void blkg_conf_end(struct blkg_conf_ctx *ctx)
 {
 	struct request_queue *q = bdev_get_queue(ctx->bdev);
@@ -885,141 +798,6 @@ int blkg_conf_start(struct blkcg *blkcg, struct blkg_conf_ctx *ctx)
 }
 EXPORT_SYMBOL_GPL(blkg_conf_start);
 
-/**
- * blkg_conf_prep - parse and prepare for per-blkg config update
- * @blkcg: target block cgroup
- * @pol: target policy
- * @ctx: blkg_conf_ctx initialized with blkg_conf_init()
- *
- * Parse per-blkg config update from @ctx->input and initialize @ctx
- * accordingly. On success, @ctx->body points to the part of @ctx->input
- * following MAJ:MIN, @ctx->bdev points to the target block device and
- * @ctx->blkg to the blkg being configured.
- *
- * blkg_conf_open_bdev() may be called on @ctx beforehand. On success, this
- * function returns with queue lock held and must be followed by
- * blkg_conf_exit().
- */
-int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
-		   struct blkg_conf_ctx *ctx)
-	__acquires(&bdev->bd_queue->blkcg_mutex)
-{
-	struct gendisk *disk;
-	struct request_queue *q;
-	struct blkcg_gq *blkg;
-	int ret;
-
-	ret = blkg_conf_open_bdev(ctx);
-	if (ret)
-		return ret;
-
-	disk = ctx->bdev->bd_disk;
-	q = disk->queue;
-
-	/* Prevent concurrent with blkcg_deactivate_policy() */
-	mutex_lock(&q->blkcg_mutex);
-
-	if (!blkcg_policy_enabled(q, pol)) {
-		ret = -EOPNOTSUPP;
-		goto fail_unlock;
-	}
-
-	blkg = blkg_lookup(blkcg, q);
-	if (blkg)
-		goto success;
-
-	/*
-	 * Create blkgs walking down from blkcg_root to @blkcg, so that all
-	 * non-root blkgs have access to their parents.
-	 */
-	while (true) {
-		struct blkcg *pos = blkcg;
-		struct blkcg *parent;
-
-		parent = blkcg_parent(blkcg);
-		while (parent && !blkg_lookup(parent, q)) {
-			pos = parent;
-			parent = blkcg_parent(parent);
-		}
-
-		if (!blkcg_policy_enabled(q, pol)) {
-			ret = -EOPNOTSUPP;
-			goto fail_unlock;
-		}
-
-		blkg = blkg_lookup(pos, q);
-		if (!blkg) {
-			blkg = blkg_create(pos, disk);
-			if (IS_ERR(blkg)) {
-				ret = PTR_ERR(blkg);
-				goto fail_unlock;
-			}
-		}
-
-		if (pos == blkcg)
-			goto success;
-	}
-success:
-	ctx->blkg = blkg;
-	return 0;
-
-fail_unlock:
-	mutex_unlock(&q->blkcg_mutex);
-	/*
-	 * If queue was bypassing, we should retry.  Do so after a
-	 * short msleep().  It isn't strictly necessary but queue
-	 * can be bypassing for some time and it's always nice to
-	 * avoid busy looping.
-	 */
-	if (ret == -EBUSY) {
-		msleep(10);
-		ret = restart_syscall();
-	}
-	return ret;
-}
-EXPORT_SYMBOL_GPL(blkg_conf_prep);
-
-/**
- * blkg_conf_exit - clean up per-blkg config update
- * @ctx: blkg_conf_ctx initialized with blkg_conf_init()
- *
- * Clean up after per-blkg config update. This function must be called on all
- * blkg_conf_ctx's initialized with blkg_conf_init().
- */
-void blkg_conf_exit(struct blkg_conf_ctx *ctx)
-	__releases(&ctx->bdev->bd_queue->blkcg_mutex)
-	__releases(&ctx->bdev->bd_queue->rq_qos_mutex)
-{
-	if (ctx->blkg) {
-		mutex_unlock(&bdev_get_queue(ctx->bdev)->blkcg_mutex);
-		ctx->blkg = NULL;
-	}
-
-	if (ctx->bdev) {
-		mutex_unlock(&ctx->bdev->bd_queue->rq_qos_mutex);
-		blkdev_put_no_open(ctx->bdev);
-		ctx->body = NULL;
-		ctx->bdev = NULL;
-	}
-}
-EXPORT_SYMBOL_GPL(blkg_conf_exit);
-
-/*
- * Similar to blkg_conf_exit, but also unfreezes the queue and releases
- * q->elevator_lock. Should be used when blkg_conf_open_bdev_frozen
- * is used to open the bdev.
- */
-void blkg_conf_exit_frozen(struct blkg_conf_ctx *ctx, unsigned long memflags)
-{
-	if (ctx->bdev) {
-		struct request_queue *q = ctx->bdev->bd_queue;
-
-		blkg_conf_exit(ctx);
-		mutex_unlock(&q->elevator_lock);
-		blk_mq_unfreeze_queue(q, memflags);
-	}
-}
-
 static void blkg_iostat_add(struct blkg_iostat *dst, struct blkg_iostat *src)
 {
 	int i;
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index c3d16d52c275..aec801255821 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -221,12 +221,6 @@ struct blkg_conf_ctx {
 };
 
 void blkg_conf_init(struct blkg_conf_ctx *ctx, char *input);
-int blkg_conf_open_bdev(struct blkg_conf_ctx *ctx);
-unsigned long blkg_conf_open_bdev_frozen(struct blkg_conf_ctx *ctx);
-int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
-		   struct blkg_conf_ctx *ctx);
-void blkg_conf_exit(struct blkg_conf_ctx *ctx);
-void blkg_conf_exit_frozen(struct blkg_conf_ctx *ctx, unsigned long memflags);
 void blkg_conf_end(struct blkg_conf_ctx *ctx);
 int blkg_conf_start(struct blkcg *blkcg, struct blkg_conf_ctx *ctx);
 
-- 
2.51.0



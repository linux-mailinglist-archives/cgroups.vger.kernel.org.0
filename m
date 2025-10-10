Return-Path: <cgroups+bounces-10642-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD717BCC4FA
	for <lists+cgroups@lfdr.de>; Fri, 10 Oct 2025 11:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6BCE5409BF
	for <lists+cgroups@lfdr.de>; Fri, 10 Oct 2025 09:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292E327381B;
	Fri, 10 Oct 2025 09:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UiO1TqJi"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D038F274B53;
	Fri, 10 Oct 2025 09:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760087729; cv=none; b=QldSlcdBUG7ITHYdH2daajBNIS3GgJKBxrYliN/vHJAN8Qj0vIBpgSIIHe5J0QqOBLrTdmmDmDGj5YKbm4yRfgjwek4315jEtPfOW5xCyVaDBpMpnUhbG5cLYDeyNtdw8WOst+H5mcsSoj9ZbFJ0NmkPCUT3ytgNvkLC6Dj76Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760087729; c=relaxed/simple;
	bh=32Ngjeq6kVC94iP3qBSCEC2DfH54K3j4MhShjpr2/Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ju/xBcRtfmxjBARxgICNgc6a43di7J3y2v7TYIpSSGRKA6tepXid44EwsPQLDqo1yjIZo7F/zQ6AD/nMsixzBBCaSxaN2bkOHUbJuoVxINuqsyyO3iwt4UfxLVkbcnyVFOjK8YHCYvay8v51/5VPPf1ERDLfph+4wG/L6vrbQok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UiO1TqJi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819D8C4CEF8;
	Fri, 10 Oct 2025 09:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760087729;
	bh=32Ngjeq6kVC94iP3qBSCEC2DfH54K3j4MhShjpr2/Wc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UiO1TqJiladMMYbFS5lPrCL+ogJQKeMfrxvfYp7mmZIuEpn5elzgbd2w2ZBrXW84F
	 VtfpfBZQnTDl032+0TxDgjgFf6v1MUi5aAf9VFwVJmWSqf59kwg1kfDQD5AUaNQgPf
	 /ntqMLA5bzZa/Bdp3Wh+T8IvMnxW2rUauj7Wl/Y0qjwri+5jgFtS3XBvTsVSav7rt7
	 yaEvhkoP2V3S6IvhZ/I/qsgLrplj8zuOAwr3KXfO8wryeAM5XxzAakKHwsXXl5Q1h3
	 P4O/lbWYW12zjVtkMCrNyRlpyiMjHm+C7h1uByIzBIs6ppZoW2ZWzLvyw29jp7461h
	 xVMYLjSqSyIOg==
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
Subject: [PATCH v2 13/19] blk-cgroup: add new blkg configuration helpers
Date: Fri, 10 Oct 2025 17:14:38 +0800
Message-ID: <20251010091446.3048529-14-yukuai@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010091446.3048529-1-yukuai@kernel.org>
References: <20251010091446.3048529-1-yukuai@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yu Kuai <yukuai3@huawei.com>

Currently there are many helpers to be used in different cases:

- blkg_conf_open_bdev()
- blkg_conf_open_bdev_frozen()
- blkg_conf_prep()
- blkg_conf_exit()
- blkg_conf_exit_frozen()

This patch introduce two new helpers:

- blkg_conf_start()
- blkg_conf_end()

And following patches will convert all blkcg policy to use this two
helpers.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-cgroup.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++
 block/blk-cgroup.h |  3 +++
 2 files changed, 64 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 3c23d2d1e237..63089ae269cb 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -824,6 +824,67 @@ unsigned long __must_check blkg_conf_open_bdev_frozen(struct blkg_conf_ctx *ctx)
 	return memflags;
 }
 
+void blkg_conf_end(struct blkg_conf_ctx *ctx)
+{
+	struct request_queue *q = bdev_get_queue(ctx->bdev);
+
+	mutex_unlock(&q->blkcg_mutex);
+	mutex_unlock(&q->rq_qos_mutex);
+	mutex_unlock(&q->elevator_lock);
+	blk_mq_unfreeze_queue(q, ctx->memflags);
+	blkdev_put_no_open(ctx->bdev);
+}
+EXPORT_SYMBOL_GPL(blkg_conf_end);
+
+int blkg_conf_start(struct blkcg *blkcg, struct blkg_conf_ctx *ctx)
+{
+	char *input = ctx->input;
+	unsigned int major, minor;
+	struct block_device *bdev;
+	struct request_queue *q;
+	int key_len;
+
+	if (sscanf(input, "%u:%u%n", &major, &minor, &key_len) != 2)
+		return -EINVAL;
+
+	input += key_len;
+	if (!isspace(*input))
+		return -EINVAL;
+
+	input = skip_spaces(input);
+	bdev = blkdev_get_no_open(MKDEV(major, minor), false);
+	if (!bdev)
+		return -ENODEV;
+
+	if (bdev_is_partition(bdev)) {
+		blkdev_put_no_open(bdev);
+		return -ENODEV;
+	}
+
+	if (!disk_live(bdev->bd_disk)) {
+		blkdev_put_no_open(bdev);
+		return -ENODEV;
+	}
+
+	ctx->body = input;
+	ctx->bdev = bdev;
+	ctx->memflags = blk_mq_freeze_queue(ctx->bdev->bd_queue);
+	
+	q = bdev->bd_queue;
+	mutex_lock(&q->elevator_lock);
+	mutex_lock(&q->rq_qos_mutex);
+	mutex_lock(&q->blkcg_mutex);
+
+	ctx->blkg = blkg_lookup_create(blkcg, bdev->bd_disk);
+	if (!ctx->blkg) {
+		blkg_conf_end(ctx);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(blkg_conf_start);
+
 /**
  * blkg_conf_prep - parse and prepare for per-blkg config update
  * @blkcg: target block cgroup
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 540be30aebcd..e7868989befb 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -217,6 +217,7 @@ struct blkg_conf_ctx {
 	char				*body;
 	struct block_device		*bdev;
 	struct blkcg_gq			*blkg;
+	unsigned long			memflags;
 };
 
 void blkg_conf_init(struct blkg_conf_ctx *ctx, char *input);
@@ -226,6 +227,8 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		   struct blkg_conf_ctx *ctx);
 void blkg_conf_exit(struct blkg_conf_ctx *ctx);
 void blkg_conf_exit_frozen(struct blkg_conf_ctx *ctx, unsigned long memflags);
+void blkg_conf_end(struct blkg_conf_ctx *ctx);
+int blkg_conf_start(struct blkcg *blkcg, struct blkg_conf_ctx *ctx);
 
 /**
  * bio_issue_as_root_blkg - see if this bio needs to be issued as root blkg
-- 
2.51.0



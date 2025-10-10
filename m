Return-Path: <cgroups+bounces-10647-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CE2BCC52D
	for <lists+cgroups@lfdr.de>; Fri, 10 Oct 2025 11:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CD755422E1
	for <lists+cgroups@lfdr.de>; Fri, 10 Oct 2025 09:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E69280A20;
	Fri, 10 Oct 2025 09:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SraVnF5N"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CEC275AF3;
	Fri, 10 Oct 2025 09:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760087743; cv=none; b=bfgD34A2NkEYumAQ/rmSNjY7jHQjVtHMhY0g827atzF9WefKASMC7YwvMBAqG2KkatOkUbuoybCMjpl0GRjLKS94J1B6jIIMeAOyt7YpM0WcgXUrDq49fjkiMdVzLBchEVUyqOZtoipNI2MoXpHEWFlHZA3vpKvUgc0fJFXaMdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760087743; c=relaxed/simple;
	bh=oKPt0bnqcsiByTXgVTcFXXKhtQ5JAVyT2nx9cy0X76Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jsoy0Vn3Es6SH5nw1M3ZrabSO7S1mFTVvvjd500fTomfp5NTM7xVxnNbSo5bSLR0hmF9VSl0fooHxgCFUYMbCzRznCmGlFBcrf+3ZZu1a9gi74284H6ZEtBYUkaDizE8Ly/3qZ0XM2Nj8MzvOZO6vLEAkhlLd3PJ9lhJrsy9PRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SraVnF5N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E737C4CEF8;
	Fri, 10 Oct 2025 09:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760087743;
	bh=oKPt0bnqcsiByTXgVTcFXXKhtQ5JAVyT2nx9cy0X76Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SraVnF5NyLo2wRyBwtzb2jLADe9dt/JNLTGOovcsgNAx39qzYE6BVqPBlxbgq2kZn
	 FUArqWYrqUHeeW8hgK48jHbV5R1qOtBmqR3BggSVL7w2SiDS/ipk3/VGg++POXTn1D
	 pSDP7Uog9NKX8piecLSkFb4tXShtJPO6a9ITeoThjcLdex6W6AwT2nekIVkBm7J4l2
	 BQbNRY5aO5qQMEyxLZDOj/IcbVvJ6jjf0gW6iFZhRCqeV/25SZE+we4Eriuj5Aasdh
	 UVnwLVAlFp7RMokD8gUVo89G4ZFwkW4OBh7y37an0JApPReVGcBWvakw6xY9cSKbhw
	 p/J4odtoS9UTQ==
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
Subject: [PATCH v2 18/19] blk-iocost: convert to use blkg_conf_{start, end}
Date: Fri, 10 Oct 2025 17:14:43 +0800
Message-ID: <20251010091446.3048529-19-yukuai@kernel.org>
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

No functional changes are intended, make code cleaner.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-iocost.c | 47 +++++++++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 3593547930cc..de3862acb297 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2931,7 +2931,7 @@ static int blk_iocost_init(struct gendisk *disk)
 	if (ret)
 		goto err_free_ioc;
 
-	ret = blkcg_activate_policy(disk, &blkcg_policy_iocost);
+	ret = __blkcg_activate_policy(disk, &blkcg_policy_iocost);
 	if (ret)
 		goto err_del_qos;
 	return 0;
@@ -3140,12 +3140,15 @@ static ssize_t ioc_weight_write(struct kernfs_open_file *of, char *buf,
 	}
 
 	blkg_conf_init(&ctx, buf);
-
-	ret = blkg_conf_prep(blkcg, &blkcg_policy_iocost, &ctx);
+	ret = blkg_conf_start(blkcg, &ctx);
 	if (ret)
-		goto err;
+		return ret;
 
 	iocg = blkg_to_iocg(ctx.blkg);
+	if (!iocg) {
+		ret = -EOPNOTSUPP;
+		goto err;
+	}
 
 	if (!strncmp(ctx.body, "default", 7)) {
 		v = 0;
@@ -3162,13 +3165,13 @@ static ssize_t ioc_weight_write(struct kernfs_open_file *of, char *buf,
 	weight_updated(iocg, &now);
 	spin_unlock(&iocg->ioc->lock);
 
-	blkg_conf_exit(&ctx);
+	blkg_conf_end(&ctx);
 	return nbytes;
 
 einval:
 	ret = -EINVAL;
 err:
-	blkg_conf_exit(&ctx);
+	blkg_conf_end(&ctx);
 	return ret;
 }
 
@@ -3226,22 +3229,19 @@ static const match_table_t qos_tokens = {
 static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 			     size_t nbytes, loff_t off)
 {
+	struct blkcg *blkcg = css_to_blkcg(of_css(of));
 	struct blkg_conf_ctx ctx;
 	struct gendisk *disk;
 	struct ioc *ioc;
 	u32 qos[NR_QOS_PARAMS];
 	bool enable, user;
 	char *body, *p;
-	unsigned long memflags;
 	int ret;
 
 	blkg_conf_init(&ctx, input);
-
-	memflags = blkg_conf_open_bdev_frozen(&ctx);
-	if (IS_ERR_VALUE(memflags)) {
-		ret = memflags;
-		goto err;
-	}
+	ret = blkg_conf_start(blkcg, &ctx);
+	if (ret)
+		return ret;
 
 	body = ctx.body;
 	disk = ctx.bdev->bd_disk;
@@ -3358,14 +3358,14 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 
 	blk_mq_unquiesce_queue(disk->queue);
 
-	blkg_conf_exit_frozen(&ctx, memflags);
+	blkg_conf_end(&ctx);
 	return nbytes;
 einval:
 	spin_unlock_irq(&ioc->lock);
 	blk_mq_unquiesce_queue(disk->queue);
 	ret = -EINVAL;
 err:
-	blkg_conf_exit_frozen(&ctx, memflags);
+	blkg_conf_end(&ctx);
 	return ret;
 }
 
@@ -3418,9 +3418,9 @@ static const match_table_t i_lcoef_tokens = {
 static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 				    size_t nbytes, loff_t off)
 {
+	struct blkcg *blkcg = css_to_blkcg(of_css(of));
 	struct blkg_conf_ctx ctx;
 	struct request_queue *q;
-	unsigned int memflags;
 	struct ioc *ioc;
 	u64 u[NR_I_LCOEFS];
 	bool user;
@@ -3428,10 +3428,9 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 	int ret;
 
 	blkg_conf_init(&ctx, input);
-
-	ret = blkg_conf_open_bdev(&ctx);
+	ret = blkg_conf_start(blkcg, &ctx);
 	if (ret)
-		goto err;
+		return ret;
 
 	body = ctx.body;
 	q = bdev_get_queue(ctx.bdev);
@@ -3448,10 +3447,9 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 		ioc = q_to_ioc(q);
 	}
 
-	memflags = blk_mq_freeze_queue(q);
 	blk_mq_quiesce_queue(q);
-
 	spin_lock_irq(&ioc->lock);
+
 	memcpy(u, ioc->params.i_lcoefs, sizeof(u));
 	user = ioc->user_cost_model;
 
@@ -3500,20 +3498,17 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 	spin_unlock_irq(&ioc->lock);
 
 	blk_mq_unquiesce_queue(q);
-	blk_mq_unfreeze_queue(q, memflags);
 
-	blkg_conf_exit(&ctx);
+	blkg_conf_end(&ctx);
 	return nbytes;
 
 einval:
 	spin_unlock_irq(&ioc->lock);
-
 	blk_mq_unquiesce_queue(q);
-	blk_mq_unfreeze_queue(q, memflags);
 
 	ret = -EINVAL;
 err:
-	blkg_conf_exit(&ctx);
+	blkg_conf_end(&ctx);
 	return ret;
 }
 
-- 
2.51.0



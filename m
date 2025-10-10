Return-Path: <cgroups+bounces-10640-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0EABCC472
	for <lists+cgroups@lfdr.de>; Fri, 10 Oct 2025 11:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 081171891352
	for <lists+cgroups@lfdr.de>; Fri, 10 Oct 2025 09:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112BF27A108;
	Fri, 10 Oct 2025 09:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnTi/k5P"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59C4279DCA;
	Fri, 10 Oct 2025 09:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760087724; cv=none; b=gFHmU3XxzsqzePE5cfEZj7TXcvoEusnBlpmz+v0WQVxjw5aTzHZ2tr2JV3TrrIo8Rz0DmOHoiEeV1pbcs/ZrhkD0txT5PL6CGpKCk2PxT1P2DiKJ2RwCV8/SzWo32FWvd9rQSjfoDdLm1cBvKWb1ZknypZ4/GAcky5x0CmD7Y8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760087724; c=relaxed/simple;
	bh=dgOaZ/uKuIlh4HsZq71ap9uemZ6G88FXxt+VuJD2VbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rmklA8GAmB0CoeE3vKtnfIjcsLwqHwOV4ckl+fVx9tWCAfAkx37If5ffAsLTvaQtAo5WtzBF/bGKevw+SLuaLcPbqvgl10UkZXoulkgWEybAsxKhljooKqhCUVVKKtx8M7tBCDwcaG7YSNtbgZ3ieOnd2mZnbWTl5bZQVQ/UOWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnTi/k5P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8F7C4CEF1;
	Fri, 10 Oct 2025 09:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760087721;
	bh=dgOaZ/uKuIlh4HsZq71ap9uemZ6G88FXxt+VuJD2VbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VnTi/k5PmvFW0PJ8JRh7NEFR3O+tv2saE2jydMaVaCKcJ55iCQE4PZt9Q6YED2Gio
	 Gw4QJruEKhKB7L+FkaW/eh44Q7RYDJXqdzauJCMPvAKmU6ErlmyXi2b42h8rY9ygD0
	 oafXI0yop0rl1EbLnKwcgapQCfBBcA5NMc2WKeyTelhA91+VIFUzEmR53E8L8M62Py
	 8ci81r2yWhIz4sxYQmkFIZKgI2VHMcahxvs2HVZ9bMuhjChmmIvz4H2vy2RI24uh+e
	 OE/6XA+Ql5S639MXXE0VEoTOO4/c/dw36P9HllfPgBO6fdrd2mD1oB0pf2evr2/kqn
	 0zvwlsXmq1asQ==
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
Subject: [PATCH v2 10/19] blk-cgroup: remove radix_tree_preload()
Date: Fri, 10 Oct 2025 17:14:35 +0800
Message-ID: <20251010091446.3048529-11-yukuai@kernel.org>
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

Now that blkcg_mutex is used to protect blkgs, memory allocation no
longer need to be non-blocking, this is not needed.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-cgroup.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index b8bb2f3506aa..030499d70543 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -894,16 +894,10 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 			goto fail_unlock;
 		}
 
-		if (radix_tree_preload(GFP_KERNEL)) {
-			blkg_free(new_blkg);
-			ret = -ENOMEM;
-			goto fail_unlock;
-		}
-
 		if (!blkcg_policy_enabled(q, pol)) {
 			blkg_free(new_blkg);
 			ret = -EOPNOTSUPP;
-			goto fail_preloaded;
+			goto fail_unlock;
 		}
 
 		blkg = blkg_lookup(pos, q);
@@ -913,12 +907,10 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 			blkg = blkg_create(pos, disk, new_blkg);
 			if (IS_ERR(blkg)) {
 				ret = PTR_ERR(blkg);
-				goto fail_preloaded;
+				goto fail_unlock;
 			}
 		}
 
-		radix_tree_preload_end();
-
 		if (pos == blkcg)
 			goto success;
 	}
@@ -926,8 +918,6 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	ctx->blkg = blkg;
 	return 0;
 
-fail_preloaded:
-	radix_tree_preload_end();
 fail_unlock:
 	mutex_unlock(&q->blkcg_mutex);
 	/*
@@ -1480,14 +1470,12 @@ int blkcg_init_disk(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
 	struct blkcg_gq *new_blkg, *blkg;
-	bool preloaded;
 
 	new_blkg = blkg_alloc(&blkcg_root, disk, GFP_KERNEL);
 	if (!new_blkg)
 		return -ENOMEM;
 
 	mutex_lock(&q->blkcg_mutex);
-	preloaded = !radix_tree_preload(GFP_NOIO);
 
 	/* Make sure the root blkg exists. */
 	blkg = blkg_create(&blkcg_root, disk, new_blkg);
@@ -1495,16 +1483,12 @@ int blkcg_init_disk(struct gendisk *disk)
 		goto err_unlock;
 	q->root_blkg = blkg;
 
-	if (preloaded)
-		radix_tree_preload_end();
 	mutex_unlock(&q->blkcg_mutex);
 
 	return 0;
 
 err_unlock:
 	mutex_unlock(&q->blkcg_mutex);
-	if (preloaded)
-		radix_tree_preload_end();
 	return PTR_ERR(blkg);
 }
 
-- 
2.51.0



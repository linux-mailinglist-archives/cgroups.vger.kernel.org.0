Return-Path: <cgroups+bounces-10644-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABC2BCC50C
	for <lists+cgroups@lfdr.de>; Fri, 10 Oct 2025 11:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D3133BA879
	for <lists+cgroups@lfdr.de>; Fri, 10 Oct 2025 09:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A525726E6F9;
	Fri, 10 Oct 2025 09:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfULuDq4"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3D727E05E;
	Fri, 10 Oct 2025 09:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760087735; cv=none; b=aCckvdRJLU+jZvamzvvrhmkMSM7mFqPuRgfXWy/w8dMQfjNk8LGN/Z05YN30trc60/g5yiQLnXTitIuXFemIRuUdSXblrS/fC/qWm6C6v7Vjzm//huqRXehC2q8B+wfHzplfs5I5uSqiytJHX9+pqHJ8EmeNN//VD4VFdnjJtD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760087735; c=relaxed/simple;
	bh=YmIrw+qqi3d4FLmLcRKt5MeMqkVsyFUH1PLrM/RP3/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6kii8D1AELOGUWwwrpexuQwoO8cw0SV8Pf8FkMq0REDGbePQEffB2La/AY0zntgpvdJ36DfzpBIFsd2KNPr1mxnBRTPXHhqQL/DIKQvASahlECxNppBtYMXt0RtpP9BLB3k80HCMgeXrVEWbLawXGpw3lpU3hKpM5ddnSuaQJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfULuDq4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0EFC4CEF8;
	Fri, 10 Oct 2025 09:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760087735;
	bh=YmIrw+qqi3d4FLmLcRKt5MeMqkVsyFUH1PLrM/RP3/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HfULuDq4zdrUW3jqwerVDBxyp7PyhXsT+t3m+v7971AxCj6X/B3MNrAA0fax+OMP2
	 SNIj4rmQrXpxZGRVfa1I30dWVtNGj+3tIjTnvowTypk86JCQ+d365qA0y5FU4QjSil
	 qdJqpRTYXLF3V/S0yqPQs97X8KaCPMCK6W7YHjSUI7xulMArD3ulf8lx3LEV9+X3Mi
	 yna/9tRYeOxpXhpFPyLOyLaQKDyN7A5pLTWbbsscPvBXJJeHzRhvfELxg0bYbHJEui
	 q93unoniByosnpax+Yu63m0r6c1o1SL0e91M/2WPadRVDYXVmlBLbTjZuiCzjNSOFJ
	 48pA2ORfUuw+A==
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
Subject: [PATCH v2 15/19] blk-throttle: convert to use blkg_conf_{start, end}
Date: Fri, 10 Oct 2025 17:14:40 +0800
Message-ID: <20251010091446.3048529-16-yukuai@kernel.org>
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
 block/blk-throttle.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 7feaa2ef0a6b..761499feed5e 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1326,7 +1326,6 @@ static int blk_throtl_init(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
 	struct throtl_data *td;
-	unsigned int memflags;
 	int ret;
 
 	td = kzalloc_node(sizeof(*td), GFP_KERNEL, q->node);
@@ -1337,14 +1336,13 @@ static int blk_throtl_init(struct gendisk *disk)
 	INIT_WORK(&td->dispatch_work, blk_throtl_dispatch_work_fn);
 	throtl_service_queue_init(&td->service_queue);
 
-	memflags = blk_mq_freeze_queue(disk->queue);
 	blk_mq_quiesce_queue(disk->queue);
 
 	q->td = td;
 	td->queue = q;
 
 	/* activate policy, blk_throtl_activated() will return true */
-	ret = blkcg_activate_policy(disk, &blkcg_policy_throtl);
+	ret = __blkcg_activate_policy(disk, &blkcg_policy_throtl);
 	if (ret) {
 		q->td = NULL;
 		kfree(td);
@@ -1361,7 +1359,6 @@ static int blk_throtl_init(struct gendisk *disk)
 
 out:
 	blk_mq_unquiesce_queue(disk->queue);
-	blk_mq_unfreeze_queue(disk->queue, memflags);
 
 	return ret;
 }
@@ -1377,10 +1374,9 @@ static ssize_t tg_set_conf(struct kernfs_open_file *of,
 	u64 v;
 
 	blkg_conf_init(&ctx, buf);
-
-	ret = blkg_conf_open_bdev(&ctx);
+	ret = blkg_conf_start(blkcg, &ctx);
 	if (ret)
-		goto out_finish;
+		return ret;
 
 	if (!blk_throtl_activated(ctx.bdev->bd_queue)) {
 		ret = blk_throtl_init(ctx.bdev->bd_disk);
@@ -1388,10 +1384,6 @@ static ssize_t tg_set_conf(struct kernfs_open_file *of,
 			goto out_finish;
 	}
 
-	ret = blkg_conf_prep(blkcg, &blkcg_policy_throtl, &ctx);
-	if (ret)
-		goto out_finish;
-
 	ret = -EINVAL;
 	if (sscanf(ctx.body, "%llu", &v) != 1)
 		goto out_finish;
@@ -1408,8 +1400,9 @@ static ssize_t tg_set_conf(struct kernfs_open_file *of,
 
 	tg_conf_updated(tg, false);
 	ret = 0;
+
 out_finish:
-	blkg_conf_exit(&ctx);
+	blkg_conf_end(&ctx);
 	return ret ?: nbytes;
 }
 
@@ -1561,10 +1554,9 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 	int ret;
 
 	blkg_conf_init(&ctx, buf);
-
-	ret = blkg_conf_open_bdev(&ctx);
+	ret = blkg_conf_start(blkcg, &ctx);
 	if (ret)
-		goto out_finish;
+		return ret;
 
 	if (!blk_throtl_activated(ctx.bdev->bd_queue)) {
 		ret = blk_throtl_init(ctx.bdev->bd_disk);
@@ -1572,10 +1564,6 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 			goto out_finish;
 	}
 
-	ret = blkg_conf_prep(blkcg, &blkcg_policy_throtl, &ctx);
-	if (ret)
-		goto out_finish;
-
 	tg = blkg_to_tg(ctx.blkg);
 	tg_update_carryover(tg);
 
@@ -1626,8 +1614,9 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 
 	tg_conf_updated(tg, false);
 	ret = 0;
+
 out_finish:
-	blkg_conf_exit(&ctx);
+	blkg_conf_end(&ctx);
 	return ret ?: nbytes;
 }
 
-- 
2.51.0



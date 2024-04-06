Return-Path: <cgroups+bounces-2351-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B7D89A9A5
	for <lists+cgroups@lfdr.de>; Sat,  6 Apr 2024 10:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B620B2834AE
	for <lists+cgroups@lfdr.de>; Sat,  6 Apr 2024 08:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156B923772;
	Sat,  6 Apr 2024 08:09:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B833F22EF8;
	Sat,  6 Apr 2024 08:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712390955; cv=none; b=SIC6imFsN3jBdC97M4X70HKAlLHvSnXgdSS8GD9Mmzv0u2gYip4DhZYUW11apoS1n2iqO00FFuipFIX0sxYFMliWxHyml0UBZdKmSEWwRJ3rMhsN5dSZc6boifmGE3OL3CLyR4JPz5P0wKlcETGfmslFxrGG4fxXlklp6PKup00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712390955; c=relaxed/simple;
	bh=wTUt1zlSK0M746ZO+xcUeqwViG+nxeL9MF8pN5h8K7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b0xTqTnoUFmPyUWFoVykcMYtupZcwowPuLZ3VxhPH3tWMl3kVch1jo8Z7yIJkrBKrV7rXKn1stLKstuXgn98uICZI+LNuoJzXftU6NOcQ/iVuWFGxr3xZBGz/QlmPw5q4r6NX3/0nfS4dWuE9SdlmJFT+iqgmwP/R6CgSeDcWk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VBSg64v9fz4f3jqt;
	Sat,  6 Apr 2024 16:09:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id F3D171A016E;
	Sat,  6 Apr 2024 16:09:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxAjAxFmnZTkJA--.2125S6;
	Sat, 06 Apr 2024 16:09:10 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	chenhuacai@kernel.org,
	tj@kernel.org,
	josef@toxicpanda.com,
	jhs@mojatatu.com,
	svenjoac@gmx.de,
	raven@themaw.net,
	pctammela@mojatatu.com,
	yukuai3@huawei.com,
	qde@naccy.de,
	zhaotianrui@loongson.cn
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	cgroups@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH RFC v2 2/6] blk-throttle: delay initialization until configuration
Date: Sat,  6 Apr 2024 16:00:55 +0800
Message-Id: <20240406080059.2248314-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240406080059.2248314-1-yukuai1@huaweicloud.com>
References: <20240406080059.2248314-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxAjAxFmnZTkJA--.2125S6
X-Coremail-Antispam: 1UD129KBjvJXoWxtF18Zr4kCF13GrWfXr4Utwb_yoWxuw43pF
	W3ur45t3y0qrsF9F45tr45JFW3Kws7K34fC393GrWayr42vwn0qF1qvr18ZFZ5AFs7uF43
	Ar4DJrs8KF18u3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOJPEUUUU
	U
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Other cgroup policy like bfq, iocost are lazy-initialized when they are
configured for the first time for the device, but blk-throttle is
initialized unconditionally from blkcg_init_disk().

Delay initialization of blk-throttle as well, to save some cpu and
memory overhead if it's not configured.

Noted that once it's initialized, it can't be destroyed until disk
removal, even if it's disabled. And following patches will support
to destroy blk-throttle after it's disabled.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-cgroup.c   |   6 ---
 block/blk-sysfs.c    |   1 -
 block/blk-throttle.c | 114 +++++++++++++++++++++++++++----------------
 block/blk-throttle.h |  10 ++--
 4 files changed, 78 insertions(+), 53 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index bdbb557feb5a..b5e626a16758 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1441,14 +1441,8 @@ int blkcg_init_disk(struct gendisk *disk)
 	if (ret)
 		goto err_destroy_all;
 
-	ret = blk_throtl_init(disk);
-	if (ret)
-		goto err_ioprio_exit;
-
 	return 0;
 
-err_ioprio_exit:
-	blk_ioprio_exit(disk);
 err_destroy_all:
 	blkg_destroy_all(disk);
 	return ret;
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 674c5c602364..1e2a0b18360c 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -807,7 +807,6 @@ int blk_register_queue(struct gendisk *disk)
 
 	blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
 	wbt_enable_default(disk);
-	blk_throtl_register(disk);
 
 	/* Now everything is ready and send out KOBJ_ADD uevent */
 	kobject_uevent(&disk->queue_kobj, KOBJ_ADD);
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 1e45e48564f4..acb2758f45ef 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1213,6 +1213,53 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
 	}
 }
 
+static int blk_throtl_init(struct gendisk *disk)
+{
+	struct request_queue *q = disk->queue;
+	struct throtl_data *td;
+	int ret;
+
+	td = kzalloc_node(sizeof(*td), GFP_KERNEL, q->node);
+	if (!td)
+		return -ENOMEM;
+
+	INIT_WORK(&td->dispatch_work, blk_throtl_dispatch_work_fn);
+	throtl_service_queue_init(&td->service_queue);
+
+	/*
+	 * freeze queue before setting q->td, so that IO path won't see
+	 * q->td while policy is not activated yet.
+	 */
+	blk_mq_freeze_queue(disk->queue);
+	blk_mq_quiesce_queue(disk->queue);
+
+	q->td = td;
+	td->queue = q;
+
+	/* activate policy */
+	ret = blkcg_activate_policy(disk, &blkcg_policy_throtl);
+	if (ret) {
+		q->td = NULL;
+		kfree(td);
+		goto out;
+	}
+
+	if (blk_queue_nonrot(q))
+		td->throtl_slice = DFL_THROTL_SLICE_SSD;
+	else
+		td->throtl_slice = DFL_THROTL_SLICE_HD;
+	td->track_bio_latency = !queue_is_mq(q);
+	if (!td->track_bio_latency)
+		blk_stat_enable_accounting(q);
+
+out:
+	blk_mq_unquiesce_queue(disk->queue);
+	blk_mq_unfreeze_queue(disk->queue);
+
+	return ret;
+}
+
+
 static ssize_t tg_set_conf(struct kernfs_open_file *of,
 			   char *buf, size_t nbytes, loff_t off, bool is_u64)
 {
@@ -1224,6 +1271,16 @@ static ssize_t tg_set_conf(struct kernfs_open_file *of,
 
 	blkg_conf_init(&ctx, buf);
 
+	ret = blkg_conf_open_bdev(&ctx);
+	if (ret)
+		goto out_finish;
+
+	if (!ctx.bdev->bd_queue->td) {
+		ret = blk_throtl_init(ctx.bdev->bd_disk);
+		if (ret)
+			goto out_finish;
+	}
+
 	ret = blkg_conf_prep(blkcg, &blkcg_policy_throtl, &ctx);
 	if (ret)
 		goto out_finish;
@@ -1388,6 +1445,16 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 
 	blkg_conf_init(&ctx, buf);
 
+	ret = blkg_conf_open_bdev(&ctx);
+	if (ret)
+		goto out_finish;
+
+	if (!ctx.bdev->bd_queue->td) {
+		ret = blk_throtl_init(ctx.bdev->bd_disk);
+		if (ret)
+			goto out_finish;
+	}
+
 	ret = blkg_conf_prep(blkcg, &blkcg_policy_throtl, &ctx);
 	if (ret)
 		goto out_finish;
@@ -1480,6 +1547,9 @@ void blk_throtl_cancel_bios(struct gendisk *disk)
 	struct cgroup_subsys_state *pos_css;
 	struct blkcg_gq *blkg;
 
+	if (!q->td)
+		return;
+
 	spin_lock_irq(&q->queue_lock);
 	/*
 	 * queue_lock is held, rcu lock is not needed here technically.
@@ -1609,57 +1679,19 @@ bool __blk_throtl_bio(struct bio *bio)
 	return throttled;
 }
 
-int blk_throtl_init(struct gendisk *disk)
-{
-	struct request_queue *q = disk->queue;
-	struct throtl_data *td;
-	int ret;
-
-	td = kzalloc_node(sizeof(*td), GFP_KERNEL, q->node);
-	if (!td)
-		return -ENOMEM;
-
-	INIT_WORK(&td->dispatch_work, blk_throtl_dispatch_work_fn);
-	throtl_service_queue_init(&td->service_queue);
-
-	q->td = td;
-	td->queue = q;
-
-	/* activate policy */
-	ret = blkcg_activate_policy(disk, &blkcg_policy_throtl);
-	if (ret)
-		kfree(td);
-	return ret;
-}
-
 void blk_throtl_exit(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
 
-	BUG_ON(!q->td);
+	if (!q->td)
+		return;
+
 	del_timer_sync(&q->td->service_queue.pending_timer);
 	throtl_shutdown_wq(q);
 	blkcg_deactivate_policy(disk, &blkcg_policy_throtl);
 	kfree(q->td);
 }
 
-void blk_throtl_register(struct gendisk *disk)
-{
-	struct request_queue *q = disk->queue;
-	struct throtl_data *td;
-
-	td = q->td;
-	BUG_ON(!td);
-
-	if (blk_queue_nonrot(q))
-		td->throtl_slice = DFL_THROTL_SLICE_SSD;
-	else
-		td->throtl_slice = DFL_THROTL_SLICE_HD;
-	td->track_bio_latency = !queue_is_mq(q);
-	if (!td->track_bio_latency)
-		blk_stat_enable_accounting(q);
-}
-
 static int __init throtl_init(void)
 {
 	kthrotld_workqueue = alloc_workqueue("kthrotld", WQ_MEM_RECLAIM, 0);
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index 32503fd83a84..e7f5562a32e9 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -150,23 +150,23 @@ static inline struct throtl_grp *blkg_to_tg(struct blkcg_gq *blkg)
  * Internal throttling interface
  */
 #ifndef CONFIG_BLK_DEV_THROTTLING
-static inline int blk_throtl_init(struct gendisk *disk) { return 0; }
 static inline void blk_throtl_exit(struct gendisk *disk) { }
-static inline void blk_throtl_register(struct gendisk *disk) { }
 static inline bool blk_throtl_bio(struct bio *bio) { return false; }
 static inline void blk_throtl_cancel_bios(struct gendisk *disk) { }
 #else /* CONFIG_BLK_DEV_THROTTLING */
-int blk_throtl_init(struct gendisk *disk);
 void blk_throtl_exit(struct gendisk *disk);
-void blk_throtl_register(struct gendisk *disk);
 bool __blk_throtl_bio(struct bio *bio);
 void blk_throtl_cancel_bios(struct gendisk *disk);
 
 static inline bool blk_should_throtl(struct bio *bio)
 {
-	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
+	struct throtl_grp *tg;
 	int rw = bio_data_dir(bio);
 
+	if (!bio->bi_bdev->bd_queue->td)
+		return false;
+
+	tg = blkg_to_tg(bio->bi_blkg);
 	if (!cgroup_subsys_on_dfl(io_cgrp_subsys)) {
 		if (!bio_flagged(bio, BIO_CGROUP_ACCT)) {
 			bio_set_flag(bio, BIO_CGROUP_ACCT);
-- 
2.39.2



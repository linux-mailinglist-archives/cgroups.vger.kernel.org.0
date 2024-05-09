Return-Path: <cgroups+bounces-2833-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 675638C0F8C
	for <lists+cgroups@lfdr.de>; Thu,  9 May 2024 14:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89DEF1C2210F
	for <lists+cgroups@lfdr.de>; Thu,  9 May 2024 12:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682C014C5A5;
	Thu,  9 May 2024 12:21:22 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114C814BF8A;
	Thu,  9 May 2024 12:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715257282; cv=none; b=phNKpPxQSVVRKncplpcVoviuqh3RqaeUPqUYYpb5fIN0ThbLA7p5Bo209i/wk//seeF7oManvBtSBAqJO0+GwimHUhKilM+w6LWEzcSAz3xUrYXVFATaayjc2IInJesF1tc7iowiYIULjqR6yCBCr/3rSJn8YUMGhjG4uaS71yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715257282; c=relaxed/simple;
	bh=308FGi6sINTHvW0UGT2CgIkUWpEneBxLT4MBh0p/WyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LDSRe2e4vK+7tkwemQZx9bhSjoSyJoZbVziZ8IqhA663JB6khtmXH5nOQ89pxVUJ4fHNlTMoDvg25SNK08Z+5wArSol4kN+HRZlrqYqm//0XFVFdwgd8DR72kgBhaSez66tHR0wFmkDnmArnM4LBoUaPK5IFBb77jOAFga3q6VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VZrhl2HLYz4f3lXF;
	Thu,  9 May 2024 20:21:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A6ACD1A017D;
	Thu,  9 May 2024 20:21:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHZQ63vzxm7lfBMA--.51358S6;
	Thu, 09 May 2024 20:21:16 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	chenhuacai@kernel.org,
	tj@kernel.org,
	josef@toxicpanda.com,
	victor@mojatatu.com,
	raven@themaw.net,
	yukuai3@huawei.com,
	twoerner@gmail.com,
	zhaotianrui@loongson.cn,
	svenjoac@gmx.de,
	jhs@mojatatu.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	cgroups@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH for-6.10/block 2/2] blk-throttle: delay initialization until configuration
Date: Thu,  9 May 2024 20:11:07 +0800
Message-Id: <20240509121107.3195568-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240509121107.3195568-1-yukuai1@huaweicloud.com>
References: <20240509121107.3195568-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHZQ63vzxm7lfBMA--.51358S6
X-Coremail-Antispam: 1UD129KBjvJXoWxtF18Zr4kCF13GrWfGFWfZrb_yoW3JF48pF
	W3ur45t3y0qrs7uFW5tr15JFW3Kws7GryfC393Cry3tr42vwn0qF1qvr18ZFZ5AFs7CF43
	Ar4Dtr4DKF18C3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJw
	CI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbdOz7UU
	UUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Other cgroup policy like bfq, iocost are lazy-initialized when they are
configured for the first time for the device, but blk-throttle is
initialized unconditionally from blkcg_init_disk().

Delay initialization of blk-throttle as well, to save some cpu and
memory overhead if it's not configured.

Noted that once it's initialized, it can't be destroyed until disk
removal, even if it's disabled.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-cgroup.c   |   6 ---
 block/blk-sysfs.c    |   1 -
 block/blk-throttle.c | 114 +++++++++++++++++++++++++++----------------
 block/blk-throttle.h |  20 ++++++--
 4 files changed, 88 insertions(+), 53 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 8598e4591e79..5e1f10525677 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1440,14 +1440,8 @@ int blkcg_init_disk(struct gendisk *disk)
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
index 8796c350b33d..f0f9314ab65c 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -807,7 +807,6 @@ int blk_register_queue(struct gendisk *disk)
 
 	blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
 	wbt_enable_default(disk);
-	blk_throtl_register(disk);
 
 	/* Now everything is ready and send out KOBJ_ADD uevent */
 	kobject_uevent(&disk->queue_kobj, KOBJ_ADD);
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index d907040859f9..80aaca18bfb0 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1211,6 +1211,53 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
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
+	 * Freeze queue before activating policy, to synchronize with IO path,
+	 * which is protected by 'q_usage_counter'.
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
@@ -1222,6 +1269,16 @@ static ssize_t tg_set_conf(struct kernfs_open_file *of,
 
 	blkg_conf_init(&ctx, buf);
 
+	ret = blkg_conf_open_bdev(&ctx);
+	if (ret)
+		goto out_finish;
+
+	if (!blk_throtl_activated(ctx.bdev->bd_queue)) {
+		ret = blk_throtl_init(ctx.bdev->bd_disk);
+		if (ret)
+			goto out_finish;
+	}
+
 	ret = blkg_conf_prep(blkcg, &blkcg_policy_throtl, &ctx);
 	if (ret)
 		goto out_finish;
@@ -1396,6 +1453,16 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 
 	blkg_conf_init(&ctx, buf);
 
+	ret = blkg_conf_open_bdev(&ctx);
+	if (ret)
+		goto out_finish;
+
+	if (!blk_throtl_activated(ctx.bdev->bd_queue)) {
+		ret = blk_throtl_init(ctx.bdev->bd_disk);
+		if (ret)
+			goto out_finish;
+	}
+
 	ret = blkg_conf_prep(blkcg, &blkcg_policy_throtl, &ctx);
 	if (ret)
 		goto out_finish;
@@ -1488,6 +1555,9 @@ void blk_throtl_cancel_bios(struct gendisk *disk)
 	struct cgroup_subsys_state *pos_css;
 	struct blkcg_gq *blkg;
 
+	if (!blk_throtl_activated(q))
+		return;
+
 	spin_lock_irq(&q->queue_lock);
 	/*
 	 * queue_lock is held, rcu lock is not needed here technically.
@@ -1617,57 +1687,19 @@ bool __blk_throtl_bio(struct bio *bio)
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
+	if (!blk_throtl_activated(q))
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
index 32503fd83a84..393c3d134b96 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -150,23 +150,33 @@ static inline struct throtl_grp *blkg_to_tg(struct blkcg_gq *blkg)
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
 
+static inline bool blk_throtl_activated(struct request_queue *q)
+{
+	return q->td != NULL;
+}
+
 static inline bool blk_should_throtl(struct bio *bio)
 {
-	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
+	struct throtl_grp *tg;
 	int rw = bio_data_dir(bio);
 
+	/*
+	 * This is called under bio_queue_enter(), and it's synchronized with
+	 * the activation of blk-throtl, which is protected by
+	 * blk_mq_freeze_queue().
+	 */
+	if (!blk_throtl_activated(bio->bi_bdev->bd_queue))
+		return false;
+
+	tg = blkg_to_tg(bio->bi_blkg);
 	if (!cgroup_subsys_on_dfl(io_cgrp_subsys)) {
 		if (!bio_flagged(bio, BIO_CGROUP_ACCT)) {
 			bio_set_flag(bio, BIO_CGROUP_ACCT);
-- 
2.39.2



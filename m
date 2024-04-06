Return-Path: <cgroups+bounces-2356-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D3B89A9B3
	for <lists+cgroups@lfdr.de>; Sat,  6 Apr 2024 10:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F6771C212FB
	for <lists+cgroups@lfdr.de>; Sat,  6 Apr 2024 08:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DABE37142;
	Sat,  6 Apr 2024 08:09:18 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6001EB40;
	Sat,  6 Apr 2024 08:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712390958; cv=none; b=Phn7jkf0/H2VoAvg0dG9wiOOd1uEoZGKiMus81JjZw8P4YJboedNOoiicSOA1eqiCzjEkd0lPeVIGk6lvKbVfVdnfF/K6C7Byjd0Ta6rZbr0g1GifiyXMXUV4n0LkMIr04vAqUys9YwTdILjC1p83N+v5lvgj6STyTsOr72Oxks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712390958; c=relaxed/simple;
	bh=y/WrU/OEcl5D+L2Pl2z0VOhvYq4DtNWAPdMONi5KRaM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PXsZfTX4kr/ZsuNSpVry3Ta24enQpzCYfqNyc+BqIftev1QOAytjwvO+zDX+cIF+1ZIJ+KJVx6AgI56UZ4W9Dp5udj0Tw+ayTxbx9Dd/KGB9aWl0jeHu25uRpauVlNN9iH6oJvLtth8mVZWm54sLULBrVagZ571/u7VhnE66beo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VBSg433H9z4f3lWD;
	Sat,  6 Apr 2024 16:09:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E070B1A0568;
	Sat,  6 Apr 2024 16:09:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxAjAxFmnZTkJA--.2125S9;
	Sat, 06 Apr 2024 16:09:12 +0800 (CST)
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
Subject: [PATCH RFC v2 5/6] blk-throttle: support to destroy throtl_data when blk-throttle is disabled
Date: Sat,  6 Apr 2024 16:00:58 +0800
Message-Id: <20240406080059.2248314-6-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgDHlxAjAxFmnZTkJA--.2125S9
X-Coremail-Antispam: 1UD129KBjvJXoWxZr1DKFyfury3tF1rCF4rXwb_yoWrGrWUpF
	W5Aw45t3y0qrsFgry3tr1UJFWakws7Jry7J393G3yftF42v34DWF1kZFy0vFWfAF97WF43
	CryktrW7GF18GrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQ
	SdkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Currently once blk-throttle is enabled, it can't be destroyed until disk
removal, even it's disabled.

Also prepare to support building it as kernel module.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 65 +++++++++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 22 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index b371442131fe..5c16be07a594 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -28,6 +28,7 @@
 
 /* A workqueue to queue throttle related work */
 static struct workqueue_struct *kthrotld_workqueue;
+static DECLARE_WAIT_QUEUE_HEAD(destroy_wait);
 
 #define rb_entry_tg(node)	rb_entry((node), struct throtl_grp, rb_node)
 
@@ -906,6 +907,11 @@ static void start_parent_slice_with_credit(struct throtl_grp *child_tg,
 
 }
 
+static bool td_has_io(struct throtl_data *td)
+{
+	return td->nr_queued[READ] + td->nr_queued[WRITE] != 0;
+}
+
 static void tg_dispatch_one_bio(struct throtl_grp *tg, bool rw)
 {
 	struct throtl_service_queue *sq = &tg->service_queue;
@@ -941,6 +947,8 @@ static void tg_dispatch_one_bio(struct throtl_grp *tg, bool rw)
 				     &parent_sq->queued[rw]);
 		BUG_ON(tg->td->nr_queued[rw] <= 0);
 		tg->td->nr_queued[rw]--;
+		if (!td_has_io(tg->td))
+			wake_up(&destroy_wait);
 	}
 
 	throtl_trim_slice(tg, rw);
@@ -1268,6 +1276,31 @@ static int blk_throtl_init(struct gendisk *disk)
 	return ret;
 }
 
+void blk_throtl_exit(struct gendisk *disk)
+{
+	struct request_queue *q = disk->queue;
+
+	if (!q->td)
+		return;
+
+	del_timer_sync(&q->td->service_queue.pending_timer);
+	cancel_work_sync(&q->td->dispatch_work);
+	blkcg_deactivate_policy(disk, &blkcg_policy_throtl);
+	kfree(q->td);
+	q->td = NULL;
+}
+
+static void blk_throtl_destroy(struct gendisk *disk)
+{
+	struct throtl_data *td = disk->queue->td;
+
+	/*
+	 * There are no rules, all throttled BIO should be dispatched
+	 * immediately.
+	 */
+	wait_event(destroy_wait, !td_has_io(td));
+	blk_throtl_exit(disk);
+}
 
 static ssize_t tg_set_conf(struct kernfs_open_file *of,
 			   char *buf, size_t nbytes, loff_t off, bool is_u64)
@@ -1308,7 +1341,11 @@ static ssize_t tg_set_conf(struct kernfs_open_file *of,
 	else
 		*(unsigned int *)((void *)tg + of_cft(of)->private) = v;
 
-	tg_conf_updated(tg, false);
+	blkg_conf_exit_blkg(&ctx);
+
+	if (!tg_conf_updated(tg, false))
+		blk_throtl_destroy(ctx.bdev->bd_disk);
+
 	ret = 0;
 out_finish:
 	blkg_conf_exit(&ctx);
@@ -1516,7 +1553,11 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 	tg->iops[READ] = v[2];
 	tg->iops[WRITE] = v[3];
 
-	tg_conf_updated(tg, false);
+	blkg_conf_exit_blkg(&ctx);
+
+	if (!tg_conf_updated(tg, false))
+		blk_throtl_destroy(ctx.bdev->bd_disk);
+
 	ret = 0;
 out_finish:
 	blkg_conf_exit(&ctx);
@@ -1533,13 +1574,6 @@ static struct cftype throtl_files[] = {
 	{ }	/* terminate */
 };
 
-static void throtl_shutdown_wq(struct request_queue *q)
-{
-	struct throtl_data *td = q->td;
-
-	cancel_work_sync(&td->dispatch_work);
-}
-
 struct blkcg_policy blkcg_policy_throtl = {
 	.dfl_cftypes		= throtl_files,
 	.legacy_cftypes		= throtl_legacy_files,
@@ -1688,19 +1722,6 @@ bool __blk_throtl_bio(struct bio *bio)
 	return throttled;
 }
 
-void blk_throtl_exit(struct gendisk *disk)
-{
-	struct request_queue *q = disk->queue;
-
-	if (!q->td)
-		return;
-
-	del_timer_sync(&q->td->service_queue.pending_timer);
-	throtl_shutdown_wq(q);
-	blkcg_deactivate_policy(disk, &blkcg_policy_throtl);
-	kfree(q->td);
-}
-
 static int __init throtl_init(void)
 {
 	kthrotld_workqueue = alloc_workqueue("kthrotld", WQ_MEM_RECLAIM, 0);
-- 
2.39.2



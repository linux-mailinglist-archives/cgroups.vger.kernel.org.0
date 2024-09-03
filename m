Return-Path: <cgroups+bounces-4679-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BDE969F6D
	for <lists+cgroups@lfdr.de>; Tue,  3 Sep 2024 15:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF4EE1C23BA4
	for <lists+cgroups@lfdr.de>; Tue,  3 Sep 2024 13:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3792C1BA;
	Tue,  3 Sep 2024 13:53:30 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7202A1D3;
	Tue,  3 Sep 2024 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725371610; cv=none; b=Hyxt48dEqKONKJH5zaDk1466F3BuNoelK/J/rKpzqBIcMBY/is+zEW3srlqs6beYAnJFcrnoWx/CmtsLmEy/Rawc2DCV0QXzu4XG2SUW0cgCtl99mmF4Ck9QeGKm/RJJEXg5GgA09Cdq++D77i8tRgePA01cVekn9N/HlZx2WcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725371610; c=relaxed/simple;
	bh=mOHqSBCGfoGqsl9rxTgfLkUkSCG2LYjrcFdiWH34Pq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U6yTyDuPf/Thv+/N4iJLRxNHXiiZxO8lYD6R4jcp06kTJSwz+xoGw83PXu3WLcvp5QNNaJ3PZd7Bk7Y+vLQaRuN83O55PnJd4JKgtUniwRWzmBM1pEidcMJBStOXgxsXkv6+coXdm7XiQCOzDY4qSzxTZESThu68KRx7AGtGl7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WynBs6Llrz4f3kq0;
	Tue,  3 Sep 2024 21:53:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2447E1A018D;
	Tue,  3 Sep 2024 21:53:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDH+sbNFNdmiUgjAQ--.58276S6;
	Tue, 03 Sep 2024 21:53:19 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH for-6.12 2/2] blk-throttle: support prioritized processing of metadata
Date: Tue,  3 Sep 2024 21:51:49 +0800
Message-Id: <20240903135149.271857-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240903135149.271857-1-yukuai1@huaweicloud.com>
References: <20240903135149.271857-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDH+sbNFNdmiUgjAQ--.58276S6
X-Coremail-Antispam: 1UD129KBjvJXoWxJF4UtryrCF1Uuw15tr47urg_yoWrXryDpr
	WfCrW5Kws5JFsrKwsI9F1UXa4fKan7Xr98J3s3JrW3A3W7Zrn8WFn0yryFyFWrAF9rGF4a
	9rs0qr95CF1UGrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AK
	xVWUtVW8ZwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUczV8UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Currently, blk-throttle handle all IO fifo, hence if data IO is
throttled and then meta IO is dispatched, the meta IO will have to wait
for the data IO, causing priority inversion problems.

This patch support to handle metadata first and then pay debt while
throttling data.

Test script: use cgroup v1 to throttle root cgroup, then create new
dir and file while write back is throttled

test() {
  mkdir /mnt/test/xxx
  touch /mnt/test/xxx/1
  sync /mnt/test/xxx
  sync /mnt/test/xxx
}

mkfs.ext4 -F /dev/nvme0n1 -E lazy_itable_init=0,lazy_journal_init=0
mount /dev/nvme0n1 /mnt/test

echo "259:0 $((1024*1024))" > /sys/fs/cgroup/blkio/blkio.throttle.write_bps_device
dd if=/dev/zero of=/mnt/test/foo1 bs=16M count=1 conv=fdatasync status=none &
sleep 4

time test
echo "259:0 0" > /sys/fs/cgroup/blkio/blkio.throttle.write_bps_device

sleep 1
umount /dev/nvme0n1

Test result: time cost for creating new dir and file
before this patch:  14s
after this patch:   0.1s

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 65 +++++++++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 22 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index eb859c44c9f3..9c5bbd261724 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1595,6 +1595,22 @@ void blk_throtl_cancel_bios(struct gendisk *disk)
 	spin_unlock_irq(&q->queue_lock);
 }
 
+static bool tg_within_limit(struct throtl_grp *tg, struct bio *bio, bool rw)
+{
+	/* throtl is FIFO - if bios are already queued, should queue */
+	if (tg->service_queue.nr_queued[rw])
+		return false;
+
+	return tg_may_dispatch(tg, bio, NULL);
+}
+
+static void tg_dispatch_in_debt(struct throtl_grp *tg, struct bio *bio, bool rw)
+{
+	if (!bio_flagged(bio, BIO_BPS_THROTTLED))
+		tg->carryover_bytes[rw] -= throtl_bio_data_size(bio);
+	tg->carryover_ios[rw]--;
+}
+
 bool __blk_throtl_bio(struct bio *bio)
 {
 	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
@@ -1611,29 +1627,34 @@ bool __blk_throtl_bio(struct bio *bio)
 	sq = &tg->service_queue;
 
 	while (true) {
-		/* throtl is FIFO - if bios are already queued, should queue */
-		if (sq->nr_queued[rw])
+		if (tg_within_limit(tg, bio, rw)) {
+			/* within limits, let's charge and dispatch directly */
+			throtl_charge_bio(tg, bio);
+
+			/*
+			 * We need to trim slice even when bios are not being
+			 * queued otherwise it might happen that a bio is not
+			 * queued for a long time and slice keeps on extending
+			 * and trim is not called for a long time. Now if limits
+			 * are reduced suddenly we take into account all the IO
+			 * dispatched so far at new low rate and * newly queued
+			 * IO gets a really long dispatch time.
+			 *
+			 * So keep on trimming slice even if bio is not queued.
+			 */
+			throtl_trim_slice(tg, rw);
+		} else if (bio_issue_as_root_blkg(bio)) {
+			/*
+			 * IOs which may cause priority inversions are
+			 * dispatched directly, even if they're over limit.
+			 * Debts are handled by carryover_bytes/ios while
+			 * calculating wait time.
+			 */
+			tg_dispatch_in_debt(tg, bio, rw);
+		} else {
+			/* if above limits, break to queue */
 			break;
-
-		/* if above limits, break to queue */
-		if (!tg_may_dispatch(tg, bio, NULL))
-			break;
-
-		/* within limits, let's charge and dispatch directly */
-		throtl_charge_bio(tg, bio);
-
-		/*
-		 * We need to trim slice even when bios are not being queued
-		 * otherwise it might happen that a bio is not queued for
-		 * a long time and slice keeps on extending and trim is not
-		 * called for a long time. Now if limits are reduced suddenly
-		 * we take into account all the IO dispatched so far at new
-		 * low rate and * newly queued IO gets a really long dispatch
-		 * time.
-		 *
-		 * So keep on trimming slice even if bio is not queued.
-		 */
-		throtl_trim_slice(tg, rw);
+		}
 
 		/*
 		 * @bio passed through this layer without being throttled.
-- 
2.39.2



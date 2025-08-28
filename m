Return-Path: <cgroups+bounces-9456-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D77B3949C
	for <lists+cgroups@lfdr.de>; Thu, 28 Aug 2025 09:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4AF7174500
	for <lists+cgroups@lfdr.de>; Thu, 28 Aug 2025 07:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD142DAFDF;
	Thu, 28 Aug 2025 07:06:24 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5A828C84C;
	Thu, 28 Aug 2025 07:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756364784; cv=none; b=IqAMNiJnJSTDTNLPRY5KoXap71sHXox5hwBH1VrAzStceIrlqCQOTqlx+hjjrBb/lvzBlcH1OCsh/MQidz73YeL4O7Eqrnz70zb7SNKcLCH495twVXXLIO0m5/9jbd0AMydgj+svEwWutKk5rVL9degzmYGkdZ0Yc0MwDcECUE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756364784; c=relaxed/simple;
	bh=IF9FRuyhwt8/weoXuNrc6K4wAiDV12eN7q1aKAqto20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YHvqM8BQO/S2Xg1v1nk6Y/Ik7TV2pt7TpBD6Eu3uW/GkEysnvK5EGM+Zrg/8R6u0KDoCsivQKt9HAA7e/WOiegy6yf4GKchILmUhNKqGIQRaxzvHPgc4K44x+XvLm8uMrgv8L8HNDYRiwUC1KrJxFT7VqgeG8avTJN3/YpeL1vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cCC9g1N2WzYQtxl;
	Thu, 28 Aug 2025 15:06:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B28731A1CE7;
	Thu, 28 Aug 2025 15:06:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCn8Izh_69o_X89Ag--.14658S7;
	Thu, 28 Aug 2025 15:06:13 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	tj@kernel.org,
	josef@toxicpanda.com,
	song@kernel.org,
	neil@brown.name,
	akpm@linux-foundation.org,
	hch@infradead.org,
	colyli@kernel.org,
	hare@suse.de,
	tieren@fnnas.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH RFC v2 03/10] md/raid1: convert to use bio_submit_split_bioset()
Date: Thu, 28 Aug 2025 14:57:26 +0800
Message-Id: <20250828065733.556341-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250828065733.556341-1-yukuai1@huaweicloud.com>
References: <20250828065733.556341-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn8Izh_69o_X89Ag--.14658S7
X-Coremail-Antispam: 1UD129KBjvJXoWxGr4kZry7GFW5Zw1UXFyDtrb_yoW5KFWUpw
	4YgaySgrWUJFZ09w4DJayq9a4rAF1FgrW7ArWxJ3s7WFnFvrZxKF4UXrWFqr98uryru3sr
	Aw1kCr4Uua17tFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjTRM6wCDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

On the one hand unify bio split code, prepare to fix disordered split
IO; On the other hand fix missing blkcg_bio_issue_init() and
trace_block_split() for split IO.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid1.c | 35 ++++++++++++++---------------------
 drivers/md/raid1.h |  4 +++-
 2 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 408c26398321..70ec5df43346 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1317,7 +1317,7 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
 	struct raid1_info *mirror;
 	struct bio *read_bio;
 	int max_sectors;
-	int rdisk, error;
+	int rdisk;
 	bool r1bio_existed = !!r1_bio;
 
 	/*
@@ -1376,16 +1376,13 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
 	}
 
 	if (max_sectors < bio_sectors(bio)) {
-		struct bio *split = bio_split(bio, max_sectors,
-					      gfp, &conf->bio_split);
-
-		if (IS_ERR(split)) {
-			error = PTR_ERR(split);
+		bio = bio_submit_split_bioset(bio, max_sectors,
+					      &conf->bio_split);
+		if (!bio) {
+			set_bit(R1BIO_Returned, &r1_bio->state);
 			goto err_handle;
 		}
-		bio_chain(split, bio);
-		submit_bio_noacct(bio);
-		bio = split;
+
 		r1_bio->master_bio = bio;
 		r1_bio->sectors = max_sectors;
 	}
@@ -1413,7 +1410,6 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
 
 err_handle:
 	atomic_dec(&mirror->rdev->nr_pending);
-	bio->bi_status = errno_to_blk_status(error);
 	set_bit(R1BIO_Uptodate, &r1_bio->state);
 	raid_end_bio_io(r1_bio);
 }
@@ -1457,7 +1453,7 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 {
 	struct r1conf *conf = mddev->private;
 	struct r1bio *r1_bio;
-	int i, disks, k, error;
+	int i, disks, k;
 	unsigned long flags;
 	int first_clone;
 	int max_sectors;
@@ -1562,7 +1558,8 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 				 * the benefit.
 				 */
 				if (bio->bi_opf & REQ_ATOMIC) {
-					error = -EIO;
+					bio->bi_status =
+						errno_to_blk_status(-EIO);
 					goto err_handle;
 				}
 
@@ -1584,16 +1581,13 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 		max_sectors = min_t(int, max_sectors,
 				    BIO_MAX_VECS * (PAGE_SIZE >> 9));
 	if (max_sectors < bio_sectors(bio)) {
-		struct bio *split = bio_split(bio, max_sectors,
-					      GFP_NOIO, &conf->bio_split);
-
-		if (IS_ERR(split)) {
-			error = PTR_ERR(split);
+		bio = bio_submit_split_bioset(bio, max_sectors,
+					      &conf->bio_split);
+		if (!bio) {
+			set_bit(R1BIO_Returned, &r1_bio->state);
 			goto err_handle;
 		}
-		bio_chain(split, bio);
-		submit_bio_noacct(bio);
-		bio = split;
+
 		r1_bio->master_bio = bio;
 		r1_bio->sectors = max_sectors;
 	}
@@ -1683,7 +1677,6 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 		}
 	}
 
-	bio->bi_status = errno_to_blk_status(error);
 	set_bit(R1BIO_Uptodate, &r1_bio->state);
 	raid_end_bio_io(r1_bio);
 }
diff --git a/drivers/md/raid1.h b/drivers/md/raid1.h
index d236ef179cfb..64548057583b 100644
--- a/drivers/md/raid1.h
+++ b/drivers/md/raid1.h
@@ -178,7 +178,9 @@ enum r1bio_state {
  * any write was successful.  Otherwise we call when
  * any write-behind write succeeds, otherwise we call
  * with failure when last write completes (and all failed).
- * Record that bi_end_io was called with this flag...
+ *
+ * And for bio_split errors, record that bi_end_io was called with
+ * this flag...
  */
 	R1BIO_Returned,
 /* If a write for this request means we can clear some
-- 
2.39.2



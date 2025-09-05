Return-Path: <cgroups+bounces-9730-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EB8B44F0A
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 09:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 212E55A347E
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 07:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AD52F4A01;
	Fri,  5 Sep 2025 07:16:02 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478C82D7DC5;
	Fri,  5 Sep 2025 07:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757056562; cv=none; b=kZpJlG4fTPr4wec1YVlf7i5Y4pBlWPwnP/al6J6/lYAhG6dxIa1ZIPYgJ3qGuZ9NtTao6jWz4hWfVxu4J5YaiSDxHwKS1Ss8feq7RTTia3WyXu3CWVwxUWsZKsds0SAyWlS6St2oX+nqJxPOfxFMyx6KrjkjO5O9uObdePYjBAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757056562; c=relaxed/simple;
	bh=5dWc5YdXwWg/UnNqXsrxJ6bwzXTvzx8pd+A54vBhg4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nYMRWIwGzkPVGQyZYDZR6dltSh59rGV4vwlLRVOA39BCzmTisUzcNGlT6sjqYHMbTdZf83U5aMb672eL8/CX/AOVZf5SXbD1eCFFyna6wEJ/cUfTmYZWT7yzYbXAOxcCKHHb+S/dcMl8db86UL/JUjq5rewyJ2IwXGOgTU6hA84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cJ71B1kR0zKHM0V;
	Fri,  5 Sep 2025 15:15:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 354B21A0F6F;
	Fri,  5 Sep 2025 15:15:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAncIwkjrpowYbQBQ--.23573S12;
	Fri, 05 Sep 2025 15:15:57 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: hch@infradead.org,
	colyli@kernel.org,
	hare@suse.de,
	dlemoal@kernel.org,
	tieren@fnnas.com,
	bvanassche@acm.org,
	axboe@kernel.dk,
	tj@kernel.org,
	josef@toxicpanda.com,
	song@kernel.org,
	yukuai3@huawei.com,
	satyat@google.com,
	ebiggers@google.com,
	kmo@daterainc.com,
	akpm@linux-foundation.org,
	neil@brown.name
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH for-6.18/block 08/16] md/raid1: convert to use bio_submit_split_bioset()
Date: Fri,  5 Sep 2025 15:06:35 +0800
Message-Id: <20250905070643.2533483-9-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250905070643.2533483-1-yukuai1@huaweicloud.com>
References: <20250905070643.2533483-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAncIwkjrpowYbQBQ--.23573S12
X-Coremail-Antispam: 1UD129KBjvJXoWxJFWUtr4UXrWxtF45Xw4DXFb_yoWrXrW3pw
	42g3yIgrWUJFZY9w1DJayq9a4rAa4YgrW7ArWxJwn7WFnFvwsxKF4UXrWFgF98urW5u3sr
	Jw1kAr4Uu3W2gFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUI-eODUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Unify bio split code, and prepare to fix reordered split IO.

Noted that bio_submit_split_bioset() can fail the original bio directly
by split error, set R1BIO_Returned in this case to notify raid_end_bio_io()
that the original bio is returned already.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid1.c | 38 +++++++++++---------------------------
 drivers/md/raid1.h |  4 +++-
 2 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 29edb7b548f3..f8434049f9b1 100644
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
@@ -1376,18 +1376,13 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
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
-		trace_block_split(split, bio->bi_iter.bi_sector);
-		submit_bio_noacct(bio);
-		bio = split;
 		r1_bio->master_bio = bio;
 		r1_bio->sectors = max_sectors;
 	}
@@ -1415,8 +1410,6 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
 
 err_handle:
 	atomic_dec(&mirror->rdev->nr_pending);
-	bio->bi_status = errno_to_blk_status(error);
-	set_bit(R1BIO_Uptodate, &r1_bio->state);
 	raid_end_bio_io(r1_bio);
 }
 
@@ -1459,7 +1452,7 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 {
 	struct r1conf *conf = mddev->private;
 	struct r1bio *r1_bio;
-	int i, disks, k, error;
+	int i, disks, k;
 	unsigned long flags;
 	int first_clone;
 	int max_sectors;
@@ -1563,10 +1556,8 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 				 * complexity of supporting that is not worth
 				 * the benefit.
 				 */
-				if (bio->bi_opf & REQ_ATOMIC) {
-					error = -EIO;
+				if (bio->bi_opf & REQ_ATOMIC)
 					goto err_handle;
-				}
 
 				good_sectors = first_bad - r1_bio->sector;
 				if (good_sectors < max_sectors)
@@ -1586,18 +1577,13 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
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
-		trace_block_split(split, bio->bi_iter.bi_sector);
-		submit_bio_noacct(bio);
-		bio = split;
 		r1_bio->master_bio = bio;
 		r1_bio->sectors = max_sectors;
 	}
@@ -1687,8 +1673,6 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 		}
 	}
 
-	bio->bi_status = errno_to_blk_status(error);
-	set_bit(R1BIO_Uptodate, &r1_bio->state);
 	raid_end_bio_io(r1_bio);
 }
 
diff --git a/drivers/md/raid1.h b/drivers/md/raid1.h
index d236ef179cfb..2ebe35aaa534 100644
--- a/drivers/md/raid1.h
+++ b/drivers/md/raid1.h
@@ -178,7 +178,9 @@ enum r1bio_state {
  * any write was successful.  Otherwise we call when
  * any write-behind write succeeds, otherwise we call
  * with failure when last write completes (and all failed).
- * Record that bi_end_io was called with this flag...
+ *
+ * And for bio_split errors, record that bi_end_io was called
+ * with this flag...
  */
 	R1BIO_Returned,
 /* If a write for this request means we can clear some
-- 
2.39.2



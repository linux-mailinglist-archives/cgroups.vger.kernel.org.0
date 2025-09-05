Return-Path: <cgroups+bounces-9732-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEADFB44F14
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 09:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A9163B6BF9
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 07:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EDE2F83A7;
	Fri,  5 Sep 2025 07:16:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A752D94B9;
	Fri,  5 Sep 2025 07:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757056564; cv=none; b=sqOf9ldf9cwmHZElxsyfWtflWSXXJwzooAO6NbTR1ASaH+9TVAV3st+vSySqbCxQnij/C0DuHB+BVLvIiUXnUjAGDLDo3N31RdfK9a9iD12SFDoOx+9hAe9n6acyTVVsL6nBqXSUK95bl/r18OHWtveg2WWS2hSJ+5LtW+yPpf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757056564; c=relaxed/simple;
	bh=jpqrNUiqJawdiRgM8h04oN2+Kg436UodZUIIvURzNRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=riJ6CuBZ45C8VZ7z7XNWsivH6NqlC8Xx2tQRta6+4a+Rk9+syttzBJPNIfOM5Iq4Fzq2x1YdXGPXj8X2Jbi7XqQDpZ3DtbR02izm3ZibeI10fwJlXcTD7eQdXQDy88C2cggXUvTJSDc2rFRPP+eC2EJNuQCCRYZC7XwW8QohXTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cJ71F3crRzYQtyj;
	Fri,  5 Sep 2025 15:16:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id F3B9A1A0F77;
	Fri,  5 Sep 2025 15:15:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAncIwkjrpowYbQBQ--.23573S14;
	Fri, 05 Sep 2025 15:15:59 +0800 (CST)
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
Subject: [PATCH for-6.18/block 10/16] md/raid10: convert read/write to use bio_submit_split_bioset()
Date: Fri,  5 Sep 2025 15:06:37 +0800
Message-Id: <20250905070643.2533483-11-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAncIwkjrpowYbQBQ--.23573S14
X-Coremail-Antispam: 1UD129KBjvJXoWxJFWUtr4UXF4fZr4xuryUKFg_yoWrXF47pr
	WagFs7KrW5JFsY9w4DJayq9asYy34qgrW3A3yxJw1kW3Z2vrs8KF1UX3yFgFy5uFW5ury3
	Xwn5CrWUCw4qqFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUI-eODUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Unify bio split code, prepare to fix reordered split IO, the error path
is modified a bit, however no functional changes are intended:

- bio_submit_split_bioset() can fail the original bio directly
  by split error, set R10BIO_Uptodate in this case to notify
  raid_end_bio_io() that the original bio is returned already.
- set R10BIO_Uptodate and set error value to -EIO is useless now,
  for r10_bio without R10BIO_Uptodate, -EIO will be returned for
  original bio.

And discard is not handled, because discard is only split for
unaligned head and tail, and this can be considered slow path, the
reorder here does not matter much.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid10.c | 42 +++++++++++++-----------------------------
 1 file changed, 13 insertions(+), 29 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index a775a1317635..69477be91b26 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1156,7 +1156,6 @@ static void raid10_read_request(struct mddev *mddev, struct bio *bio,
 	int slot = r10_bio->read_slot;
 	struct md_rdev *err_rdev = NULL;
 	gfp_t gfp = GFP_NOIO;
-	int error;
 
 	if (slot >= 0 && r10_bio->devs[slot].rdev) {
 		/*
@@ -1205,19 +1204,15 @@ static void raid10_read_request(struct mddev *mddev, struct bio *bio,
 				   rdev->bdev,
 				   (unsigned long long)r10_bio->sector);
 	if (max_sectors < bio_sectors(bio)) {
-		struct bio *split = bio_split(bio, max_sectors,
-					      gfp, &conf->bio_split);
-		if (IS_ERR(split)) {
-			error = PTR_ERR(split);
+		allow_barrier(conf);
+		bio = bio_submit_split_bioset(bio, max_sectors,
+					      &conf->bio_split);
+		wait_barrier(conf, false);
+		if (!bio) {
+			set_bit(R10BIO_Returned, &r10_bio->state);
 			goto err_handle;
 		}
 
-		bio_chain(split, bio);
-		trace_block_split(split, bio->bi_iter.bi_sector);
-		allow_barrier(conf);
-		submit_bio_noacct(bio);
-		wait_barrier(conf, false);
-		bio = split;
 		r10_bio->master_bio = bio;
 		r10_bio->sectors = max_sectors;
 	}
@@ -1245,8 +1240,6 @@ static void raid10_read_request(struct mddev *mddev, struct bio *bio,
 	return;
 err_handle:
 	atomic_dec(&rdev->nr_pending);
-	bio->bi_status = errno_to_blk_status(error);
-	set_bit(R10BIO_Uptodate, &r10_bio->state);
 	raid_end_bio_io(r10_bio);
 }
 
@@ -1355,7 +1348,6 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 	int i, k;
 	sector_t sectors;
 	int max_sectors;
-	int error;
 
 	if ((mddev_is_clustered(mddev) &&
 	     mddev->cluster_ops->area_resyncing(mddev, WRITE,
@@ -1469,10 +1461,8 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 				 * complexity of supporting that is not worth
 				 * the benefit.
 				 */
-				if (bio->bi_opf & REQ_ATOMIC) {
-					error = -EIO;
+				if (bio->bi_opf & REQ_ATOMIC)
 					goto err_handle;
-				}
 
 				good_sectors = first_bad - dev_sector;
 				if (good_sectors < max_sectors)
@@ -1493,19 +1483,15 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 		r10_bio->sectors = max_sectors;
 
 	if (r10_bio->sectors < bio_sectors(bio)) {
-		struct bio *split = bio_split(bio, r10_bio->sectors,
-					      GFP_NOIO, &conf->bio_split);
-		if (IS_ERR(split)) {
-			error = PTR_ERR(split);
+		allow_barrier(conf);
+		bio = bio_submit_split_bioset(bio, r10_bio->sectors,
+					      &conf->bio_split);
+		wait_barrier(conf, false);
+		if (!bio) {
+			set_bit(R10BIO_Returned, &r10_bio->state);
 			goto err_handle;
 		}
 
-		bio_chain(split, bio);
-		trace_block_split(split, bio->bi_iter.bi_sector);
-		allow_barrier(conf);
-		submit_bio_noacct(bio);
-		wait_barrier(conf, false);
-		bio = split;
 		r10_bio->master_bio = bio;
 	}
 
@@ -1537,8 +1523,6 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 		}
 	}
 
-	bio->bi_status = errno_to_blk_status(error);
-	set_bit(R10BIO_Uptodate, &r10_bio->state);
 	raid_end_bio_io(r10_bio);
 }
 
-- 
2.39.2



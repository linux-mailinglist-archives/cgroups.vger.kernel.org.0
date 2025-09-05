Return-Path: <cgroups+bounces-9727-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F51FB44F00
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 09:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FFA31C8378B
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 07:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A9B2EFDBD;
	Fri,  5 Sep 2025 07:16:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C41425A357;
	Fri,  5 Sep 2025 07:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757056560; cv=none; b=TFgR41wBzqWroxPS8Xi5kciGhVO1jHGxqm5l6yJFiPVK6LZgt9w/aU6/m8IiSW7XXC4kHG6muefVjVf/hLqDo9Js14CSGBGhNTyk/qP3rgsAX8RukA9X2XSGBfe7ir659g97uILdArDGmHYIwuRAj+CuFXA52ts9R1Oibae/hnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757056560; c=relaxed/simple;
	bh=4PIvSvFqlu3tFPy+HF9M4PUdQy4CX36cNIRuNqeG50g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NVc8rE7bbu6KsCJdW+H5XMD+RiH75GUDRBY+oG9KZ0G72gYjIX4LwAFPs0JCnTujG5i7QsJZjT/1FZz+fLwQP3T+F2DZPMzN3ATwcjmIUO3Foq+CFIbE9udwR3Q9hjvQ4c6eCdxrGnRlHo7h2CO1iK9YX7K7MWpio6byDx9lyL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cJ7165wnvzKHMYq;
	Fri,  5 Sep 2025 15:15:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C1CBF1A0DA0;
	Fri,  5 Sep 2025 15:15:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAncIwkjrpowYbQBQ--.23573S8;
	Fri, 05 Sep 2025 15:15:54 +0800 (CST)
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
Subject: [PATCH for-6.18/block 04/16] md: fix mssing blktrace bio split events
Date: Fri,  5 Sep 2025 15:06:31 +0800
Message-Id: <20250905070643.2533483-5-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAncIwkjrpowYbQBQ--.23573S8
X-Coremail-Antispam: 1UD129KBjvJXoWxur17AF4xAFW8ZryUXw4UCFg_yoWrZw1xpw
	4jvFy3Z3y5GrZ09wsrZFW2kas5J3WqgrWUCFWxJws7Z3ZrZF9rKa1UXFyFqr909F15Wa47
	Jr1DC3y7Cr1jqr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUI-eODUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

If bio is split by internal handling like chunksize or badblocks, the
corresponding trace_block_split() is missing, resulting in blktrace
inability to catch BIO split events and making it harder to analyze the
BIO sequence.

Cc: stable@vger.kernel.org
Fixes: 4b1faf931650 ("block: Kill bio_pair_split()")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/md/md-linear.c | 1 +
 drivers/md/raid0.c     | 4 ++++
 drivers/md/raid1.c     | 4 ++++
 drivers/md/raid10.c    | 8 ++++++++
 drivers/md/raid5.c     | 2 ++
 5 files changed, 19 insertions(+)

diff --git a/drivers/md/md-linear.c b/drivers/md/md-linear.c
index 5d9b08115375..59d7963c7843 100644
--- a/drivers/md/md-linear.c
+++ b/drivers/md/md-linear.c
@@ -266,6 +266,7 @@ static bool linear_make_request(struct mddev *mddev, struct bio *bio)
 		}
 
 		bio_chain(split, bio);
+		trace_block_split(split, bio->bi_iter.bi_sector);
 		submit_bio_noacct(bio);
 		bio = split;
 	}
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index f1d8811a542a..1ba7d0c090f7 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -472,7 +472,9 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 			bio_endio(bio);
 			return;
 		}
+
 		bio_chain(split, bio);
+		trace_block_split(split, bio->bi_iter.bi_sector);
 		submit_bio_noacct(bio);
 		bio = split;
 		end = zone->zone_end;
@@ -620,7 +622,9 @@ static bool raid0_make_request(struct mddev *mddev, struct bio *bio)
 			bio_endio(bio);
 			return true;
 		}
+
 		bio_chain(split, bio);
+		trace_block_split(split, bio->bi_iter.bi_sector);
 		raid0_map_submit_bio(mddev, bio);
 		bio = split;
 	}
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 408c26398321..29edb7b548f3 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1383,7 +1383,9 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
 			error = PTR_ERR(split);
 			goto err_handle;
 		}
+
 		bio_chain(split, bio);
+		trace_block_split(split, bio->bi_iter.bi_sector);
 		submit_bio_noacct(bio);
 		bio = split;
 		r1_bio->master_bio = bio;
@@ -1591,7 +1593,9 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 			error = PTR_ERR(split);
 			goto err_handle;
 		}
+
 		bio_chain(split, bio);
+		trace_block_split(split, bio->bi_iter.bi_sector);
 		submit_bio_noacct(bio);
 		bio = split;
 		r1_bio->master_bio = bio;
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index b60c30bfb6c7..859c40a5ecf4 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1209,7 +1209,9 @@ static void raid10_read_request(struct mddev *mddev, struct bio *bio,
 			error = PTR_ERR(split);
 			goto err_handle;
 		}
+
 		bio_chain(split, bio);
+		trace_block_split(split, bio->bi_iter.bi_sector);
 		allow_barrier(conf);
 		submit_bio_noacct(bio);
 		wait_barrier(conf, false);
@@ -1495,7 +1497,9 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 			error = PTR_ERR(split);
 			goto err_handle;
 		}
+
 		bio_chain(split, bio);
+		trace_block_split(split, bio->bi_iter.bi_sector);
 		allow_barrier(conf);
 		submit_bio_noacct(bio);
 		wait_barrier(conf, false);
@@ -1679,7 +1683,9 @@ static int raid10_handle_discard(struct mddev *mddev, struct bio *bio)
 			bio_endio(bio);
 			return 0;
 		}
+
 		bio_chain(split, bio);
+		trace_block_split(split, bio->bi_iter.bi_sector);
 		allow_barrier(conf);
 		/* Resend the fist split part */
 		submit_bio_noacct(split);
@@ -1694,7 +1700,9 @@ static int raid10_handle_discard(struct mddev *mddev, struct bio *bio)
 			bio_endio(bio);
 			return 0;
 		}
+
 		bio_chain(split, bio);
+		trace_block_split(split, bio->bi_iter.bi_sector);
 		allow_barrier(conf);
 		/* Resend the second split part */
 		submit_bio_noacct(bio);
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 023649fe2476..0fb838879844 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5475,8 +5475,10 @@ static struct bio *chunk_aligned_read(struct mddev *mddev, struct bio *raid_bio)
 
 	if (sectors < bio_sectors(raid_bio)) {
 		struct r5conf *conf = mddev->private;
+
 		split = bio_split(raid_bio, sectors, GFP_NOIO, &conf->bio_split);
 		bio_chain(split, raid_bio);
+		trace_block_split(split, raid_bio->bi_iter.bi_sector);
 		submit_bio_noacct(raid_bio);
 		raid_bio = split;
 	}
-- 
2.39.2



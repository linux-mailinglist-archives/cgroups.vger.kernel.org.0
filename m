Return-Path: <cgroups+bounces-9373-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CE1B33B7A
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 11:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D44FA7A4620
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 09:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121C02D3EFB;
	Mon, 25 Aug 2025 09:45:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EA82C0F7E;
	Mon, 25 Aug 2025 09:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756115134; cv=none; b=tGeZ+zmjCVaZafnqRYJfMgFZI06vplGH2cbaB0CHrxEoe2GquweBbL/MvH/2Mz4i9W4jI3Yo5eny9fV6zaowsFUgAiO8DYWU6bqPjirqVr/FSEw7polNhnTD9whqz/HrDfXMQ4xx0+lab5npGv/dmXXaJ6CorPhMlWhfHlAWWpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756115134; c=relaxed/simple;
	bh=+Zd0GaFHRFBuWMcYQJ9Xfws2YiVhvqbjue6U79Groy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AWVMjumsrjsKrw4IpTtBvFxUgV1EJwziTgGBA6wzYwsE4n55QV+5mt0keIKsC0H8M5vCDzGwnj47RCYcGjTnRxl5US4Am9iCD3npDN4kKk2iGp/ouvroj1xWQqxUrWr28ZV3JFTGtrL7nXqtJXbsCGimBoEkCAmfJTHxJ6d7aag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c9Qrp1pp2zKHNL2;
	Mon, 25 Aug 2025 17:45:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CE8761A1C95;
	Mon, 25 Aug 2025 17:45:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAXYIy1MKxonJnxAA--.44975S8;
	Mon, 25 Aug 2025 17:45:29 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: hch@infradead.org,
	colyli@kernel.org,
	hare@suse.de,
	tieren@fnnas.com,
	axboe@kernel.dk,
	tj@kernel.org,
	josef@toxicpanda.com,
	song@kernel.org,
	yukuai3@huawei.com,
	akpm@linux-foundation.org,
	neil@brown.name
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH RFC 4/7] md/raid10: convert read/write to use bio_submit_split()
Date: Mon, 25 Aug 2025 17:36:57 +0800
Message-Id: <20250825093700.3731633-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250825093700.3731633-1-yukuai1@huaweicloud.com>
References: <20250825093700.3731633-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXYIy1MKxonJnxAA--.44975S8
X-Coremail-Antispam: 1UD129KBjvJXoWxGr4kWr1fWw1DAr45ZFy7Wrg_yoWrur4Up3
	yag3WSkrW5JFsa9w1DJayDuasYy340grW7A3yxJwn7W3ZIvrs8KF1UX3yFqr98uFy5ur9r
	X3WkZr4UCayqqF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0pRiF4iUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

On the one hand unify bio split code, prepare to fix disordered split
IO; On the other hand fix missing blkcg_bio_issue_init() and
trace_block_split() for split IO.

Noted discard is not handled, because discard is only splited for
unaligned head and tail.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid10.c | 53 ++++++++++++++++++++-------------------------
 drivers/md/raid10.h |  1 +
 2 files changed, 24 insertions(+), 30 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index b60c30bfb6c7..b8777661307b 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -322,10 +322,12 @@ static void raid_end_bio_io(struct r10bio *r10_bio)
 	struct bio *bio = r10_bio->master_bio;
 	struct r10conf *conf = r10_bio->mddev->private;
 
-	if (!test_bit(R10BIO_Uptodate, &r10_bio->state))
-		bio->bi_status = BLK_STS_IOERR;
+	if (!test_and_set_bit(R10BIO_Returned, &r10_bio->state)) {
+		if (!test_bit(R10BIO_Uptodate, &r10_bio->state))
+			bio->bi_status = BLK_STS_IOERR;
+		bio_endio(bio);
+	}
 
-	bio_endio(bio);
 	/*
 	 * Wake up any possible resync thread that waits for the device
 	 * to go idle.
@@ -1154,7 +1156,6 @@ static void raid10_read_request(struct mddev *mddev, struct bio *bio,
 	int slot = r10_bio->read_slot;
 	struct md_rdev *err_rdev = NULL;
 	gfp_t gfp = GFP_NOIO;
-	int error;
 
 	if (slot >= 0 && r10_bio->devs[slot].rdev) {
 		/*
@@ -1203,17 +1204,16 @@ static void raid10_read_request(struct mddev *mddev, struct bio *bio,
 				   rdev->bdev,
 				   (unsigned long long)r10_bio->sector);
 	if (max_sectors < bio_sectors(bio)) {
-		struct bio *split = bio_split(bio, max_sectors,
-					      gfp, &conf->bio_split);
-		if (IS_ERR(split)) {
-			error = PTR_ERR(split);
-			goto err_handle;
-		}
-		bio_chain(split, bio);
 		allow_barrier(conf);
-		submit_bio_noacct(bio);
+		bio = bio_submit_split(bio, max_sectors, &conf->bio_split);
 		wait_barrier(conf, false);
-		bio = split;
+
+		if (!bio) {
+			set_bit(R10BIO_Returned, &r10_bio->state);
+			goto err_handle;
+		}
+
+		bio->bi_opf &= ~REQ_NOMERGE;
 		r10_bio->master_bio = bio;
 		r10_bio->sectors = max_sectors;
 	}
@@ -1239,10 +1239,9 @@ static void raid10_read_request(struct mddev *mddev, struct bio *bio,
 	mddev_trace_remap(mddev, read_bio, r10_bio->sector);
 	submit_bio_noacct(read_bio);
 	return;
+
 err_handle:
 	atomic_dec(&rdev->nr_pending);
-	bio->bi_status = errno_to_blk_status(error);
-	set_bit(R10BIO_Uptodate, &r10_bio->state);
 	raid_end_bio_io(r10_bio);
 }
 
@@ -1351,7 +1350,6 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 	int i, k;
 	sector_t sectors;
 	int max_sectors;
-	int error;
 
 	if ((mddev_is_clustered(mddev) &&
 	     mddev->cluster_ops->area_resyncing(mddev, WRITE,
@@ -1465,10 +1463,8 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
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
@@ -1489,17 +1485,16 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 		r10_bio->sectors = max_sectors;
 
 	if (r10_bio->sectors < bio_sectors(bio)) {
-		struct bio *split = bio_split(bio, r10_bio->sectors,
-					      GFP_NOIO, &conf->bio_split);
-		if (IS_ERR(split)) {
-			error = PTR_ERR(split);
-			goto err_handle;
-		}
-		bio_chain(split, bio);
 		allow_barrier(conf);
-		submit_bio_noacct(bio);
+		bio = bio_submit_split(bio, r10_bio->sectors, &conf->bio_split);
 		wait_barrier(conf, false);
-		bio = split;
+
+		if (!bio) {
+			set_bit(R10BIO_Returned, &r10_bio->state);
+			goto err_handle;
+		}
+
+		bio->bi_opf &= ~REQ_NOMERGE;
 		r10_bio->master_bio = bio;
 	}
 
@@ -1531,8 +1526,6 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 		}
 	}
 
-	bio->bi_status = errno_to_blk_status(error);
-	set_bit(R10BIO_Uptodate, &r10_bio->state);
 	raid_end_bio_io(r10_bio);
 }
 
diff --git a/drivers/md/raid10.h b/drivers/md/raid10.h
index 3f16ad6904a9..cc167e708125 100644
--- a/drivers/md/raid10.h
+++ b/drivers/md/raid10.h
@@ -165,6 +165,7 @@ enum r10bio_state {
  * so that raid10d knows what to do with them.
  */
 	R10BIO_ReadError,
+	R10BIO_Returned,
 /* If a write for this request means we can clear some
  * known-bad-block records, we set this flag.
  */
-- 
2.39.2



Return-Path: <cgroups+bounces-9371-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55781B33B71
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 11:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 704D13B7505
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 09:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137662D29D9;
	Mon, 25 Aug 2025 09:45:34 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFF42C3254;
	Mon, 25 Aug 2025 09:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756115133; cv=none; b=I4WoXg160p9vQpW0HAffgjy7LKChkoBU2zzBvBy6I8mlrhaHRAxSBy079Jw4UAJAjq0yIf1mB5QfoR7s+u38Xyd6vkvblJNbFlDPemxiZ0+1u2fWESmYTIAqpQHB7DGFjnx5t3EYu0wzCg3uxOpWE6cLY+CZoJS2Tw479LRj0Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756115133; c=relaxed/simple;
	bh=X22YaUjiEkOMtkXKh2Lb2TGbzXLathpEPi3Ls3O9JP4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QKzJ3cr0/fiblewvfpcG4YzRT1dIHZt0mr/uspRdJmaZ8Jf5d3cCLP/nbZ1ys1XSsd/1n4Q1RBnsbLBipGtpHwhq9cBlafW0OV4Ykvswjt9kIlteyzuYaTBClD6TmRiKRn4NBDJnpLoCcELwTycH+w2Or26jL8y2QogBXyn2Idc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c9Qrp4PdqzYQvj9;
	Mon, 25 Aug 2025 17:45:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 24BE11A1088;
	Mon, 25 Aug 2025 17:45:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAXYIy1MKxonJnxAA--.44975S7;
	Mon, 25 Aug 2025 17:45:28 +0800 (CST)
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
Subject: [PATCH RFC 3/7] md/raid1: convert to use bio_submit_split()
Date: Mon, 25 Aug 2025 17:36:56 +0800
Message-Id: <20250825093700.3731633-4-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAXYIy1MKxonJnxAA--.44975S7
X-Coremail-Antispam: 1UD129KBjvJXoWxGr4DuFWUKw48Zr15tr4DCFg_yoW5Cr1fpr
	4Yga1IgrWUJFZYgws8Jayq9as5AF1qgrW7ArWxJ3s7WFnFv3sxKF4UWryFqryruFy5u3sr
	Aw1kAr4DCa17tFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2
	KfnxnUUI43ZEXa7VUUbAw7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

On the one hand unify bio split code, prepare to fix disordered split
IO; On the other hand fix missing blkcg_bio_issue_init() and
trace_block_split() for split IO.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid1.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 408c26398321..95196c8749f9 100644
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
+		bio = bio_submit_split(bio, max_sectors,&conf->bio_split);
+		if (!bio) {
+			set_bit(R1BIO_Returned, &r1_bio->state);
 			goto err_handle;
 		}
-		bio_chain(split, bio);
-		submit_bio_noacct(bio);
-		bio = split;
+
+		bio->bi_opf &= ~REQ_NOMERGE;
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
+		bio = bio_submit_split(bio, max_sectors, &conf->bio_split);
+		if (!bio) {
+			set_bit(R1BIO_Returned, &r1_bio->state);
 			goto err_handle;
 		}
-		bio_chain(split, bio);
-		submit_bio_noacct(bio);
-		bio = split;
+
+		bio->bi_opf &= ~REQ_NOMERGE;
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
-- 
2.39.2



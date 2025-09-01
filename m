Return-Path: <cgroups+bounces-9532-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1405B3D7A8
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 05:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F72179948
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 03:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC3E258ED8;
	Mon,  1 Sep 2025 03:41:23 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2930523D7E6;
	Mon,  1 Sep 2025 03:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756698083; cv=none; b=iAiRgA7doTD/ezza7m6GvdL9hPV884fs+irYbTcMDC3ZZwlgXx7AyC56vgNtG8mV4U7cz6wWAQ7QNbLizYgqBfxC8H/nResJNx9Sky8aXGmnBqrmEResBQF9YfumcJ8TjslGr989pR6B1fj0VF7ftf2Bv4rwY8kCScmldXgk70Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756698083; c=relaxed/simple;
	bh=M1kxzGWe+nxaYujl6+qi+TLF+NSf2Rn+4yfFQisHTlY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Iz6lBQXJ55S1EsgmqzJPNWkRxp1Q8yleQ7NS3zDlGlvsn9LXgaUyRpETKLkP1a4AWVohSS1w5acmj3Yw9tOAr/LCsuSmBKU+Z4apxRVXMTQ3GQC+zrMke+beSykOr22jtryqtcx5lH2aWQa0IrLNUjn6jQjCA+7Tn0oH5lAx2oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cFZRM1KL5zKHN5G;
	Mon,  1 Sep 2025 11:41:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 01B001A058E;
	Mon,  1 Sep 2025 11:41:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAncIzWFbVotmf1Aw--.38057S11;
	Mon, 01 Sep 2025 11:41:18 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: hch@infradead.org,
	colyli@kernel.org,
	hare@suse.de,
	dlemoal@kernel.org,
	tieren@fnnas.com,
	axboe@kernel.dk,
	tj@kernel.org,
	josef@toxicpanda.com,
	song@kernel.org,
	kmo@daterainc.com,
	satyat@google.com,
	ebiggers@google.com,
	neil@brown.name,
	akpm@linux-foundation.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH RFC v3 07/15] md/raid1: convert to use bio_submit_split_bioset()
Date: Mon,  1 Sep 2025 11:32:12 +0800
Message-Id: <20250901033220.42982-8-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250901033220.42982-1-yukuai1@huaweicloud.com>
References: <20250901033220.42982-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAncIzWFbVotmf1Aw--.38057S11
X-Coremail-Antispam: 1UD129KBjvJXoWxJFykZFy5uryDXF4xtF1rtFb_yoWrJFWrpw
	42gayIgrWUJFZY9w1DJayq9asYyas0grW7ArWxJwn7WFnFv39xKF4UXrWFqF98uFyF93sr
	Jw1kCr4Uu3W2qFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0pRiF4iUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Unify bio split code, and prepare to fix disordered split IO.

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



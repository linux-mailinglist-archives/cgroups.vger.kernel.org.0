Return-Path: <cgroups+bounces-9533-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40611B3D7AE
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 05:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05F6117A09B
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 03:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CE225F7A7;
	Mon,  1 Sep 2025 03:41:24 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AAC24DFF3;
	Mon,  1 Sep 2025 03:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756698084; cv=none; b=dgAPcGxpZSVZh62PJLhTl84YBtQdv1+YfruetCKdluownp6OohuEIpSiLe/sAgapEMI8so+hwjjuEciryy8SERm9sUNHvnKyWaOKtNMsPdUTXHNGXDpP3ERpMGtGHrB74B9lMwFUFA6F0KR/B72xkO5XTw1FB1CmztaII5ewGtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756698084; c=relaxed/simple;
	bh=PaSlShOFyaFFhgv8Aw9KiD7xl79EWpfx1xL/MadPq+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dR2Fq9aWDAtdRS9wEsfD15VdlOkDNdJ+xNa8aQKQhE4DyGvrqoqFIAs1Spi+mCOLRbOm2ytXj2aPZx0chMv68kk+Ykmv5jcZogICK5mUuBXEwltWB9nI0dSRnR0J/TIi6TGOL9VI7AnXoGcUQnTgLkS7A13j4ZnN8Yq6QNVsrAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cFZRQ0srDzYQvPX;
	Mon,  1 Sep 2025 11:41:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9ACAD1A1B2E;
	Mon,  1 Sep 2025 11:41:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAncIzWFbVotmf1Aw--.38057S13;
	Mon, 01 Sep 2025 11:41:20 +0800 (CST)
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
Subject: [PATCH RFC v3 09/15] md/raid10: convert read/write to use bio_submit_split_bioset()
Date: Mon,  1 Sep 2025 11:32:14 +0800
Message-Id: <20250901033220.42982-10-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAncIzWFbVotmf1Aw--.38057S13
X-Coremail-Antispam: 1UD129KBjvJXoWxJFykZF4kZF4Utr48GFykXwb_yoW5Kr43pr
	WagF4xKrW5JrsY9w4DJayq9asYy34vgrW7ArW7Jwn7Wan2vrs8KF1UXrWFqFy5uFy5urya
	qwn5CrWUCw4qvFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Unify bio split code, prepare to fix disordered split IO.

Noted discard is not handled, because discard is only split for
unaligned head and tail, and this can be considered slow path, the
disorder here does not matter much.

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



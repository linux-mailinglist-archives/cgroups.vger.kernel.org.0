Return-Path: <cgroups+bounces-9369-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C17B33B68
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 11:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D26B203315
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 09:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858E32D12F1;
	Mon, 25 Aug 2025 09:45:32 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B9A2C0F89;
	Mon, 25 Aug 2025 09:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756115132; cv=none; b=k154C41kvzT+2Z4HN625HC5wrhWLJlFZR2MfWxstttmUHUfVBKesClwRfRTllD4wmWLIrAmT++21AA3yCwtF/CjZYl67odsQ8fuGhXkyfPJ7Pj34WSQFqJKx0mdJ8zoFx6shSiouD+7a4xdHLgkyRdPx1vdj/oTP+2mxOlIYjq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756115132; c=relaxed/simple;
	bh=V8UqlYonaFpjyDrOre12ZnZAcqcI7ueaBnFbHt1JfFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mTF63E+FXIPCigSKth4ZbU2tfvTmZ11/E8OlJ/N/q7dX/qi+1nGSI2SGNUjwacxQ3ipVVU+8KBZIrgDHz+5eR9UUfvW2XhJo+pd8y/9O/w4EJejEjI0vZ4m8Vgs5WF0/rNzxs9Ea53dJavyu8c45Hjgm3s5DwV0MO4AHgKyKkxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c9Qrm10FgzKHNKY;
	Mon, 25 Aug 2025 17:45:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B47261A1C37;
	Mon, 25 Aug 2025 17:45:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAXYIy1MKxonJnxAA--.44975S5;
	Mon, 25 Aug 2025 17:45:27 +0800 (CST)
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
Subject: [PATCH RFC 1/7] block: export helper bio_submit_split()
Date: Mon, 25 Aug 2025 17:36:54 +0800
Message-Id: <20250825093700.3731633-2-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAXYIy1MKxonJnxAA--.44975S5
X-Coremail-Antispam: 1UD129KBjvJXoWxCF48Kr1rGF47Kry3Kw1Dtrb_yoWrtF1rpr
	4j9wn3JrZ5JFs2gwnxXa1UK3Zakay5ZrW5C3yxX39rArnxtwnrKF4xWr1rZFyFkrW5C345
	Jw1vkFW5C34UCFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjTRAb10DUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

No functional changes are intended, some drivers like mdraid will split
bio by internal processing, prepare to unify bio split codes.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-merge.c   | 60 +++++++++++++++++++++++++++++----------------
 include/linux/bio.h |  2 ++
 2 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 70d704615be5..c45d5e43e172 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -104,35 +104,49 @@ static unsigned int bio_allowed_max_sectors(const struct queue_limits *lim)
 	return round_down(UINT_MAX, lim->logical_block_size) >> SECTOR_SHIFT;
 }
 
-static struct bio *bio_submit_split(struct bio *bio, int split_sectors)
+/**
+ * bio_submit_split - Submit a bio, splitting it at a designated sector
+ * @bio:           the original bio to be submitted and split
+ * @split_sectors: the sector count (from the start of @bio) at which to split
+ * @bs:            the bio set used for allocating the new split bio
+ *
+ * The original bio is modified to contain the remaining sectors and submitted.
+ * The caller is responsible for submitting the returned bio.
+ *
+ * If succeed, the newly allocated bio representing the initial part will be
+ * returned, on failure NULL will be returned and original bio will fail.
+ */
+struct bio *bio_submit_split(struct bio *bio, int split_sectors,
+			     struct bio_set *bs)
 {
+	struct bio *split;
+
 	if (unlikely(split_sectors < 0))
 		goto error;
 
-	if (split_sectors) {
-		struct bio *split;
+	if (!split_sectors)
+		return bio;
 
-		split = bio_split(bio, split_sectors, GFP_NOIO,
-				&bio->bi_bdev->bd_disk->bio_split);
-		if (IS_ERR(split)) {
-			split_sectors = PTR_ERR(split);
-			goto error;
-		}
-		split->bi_opf |= REQ_NOMERGE;
-		blkcg_bio_issue_init(split);
-		bio_chain(split, bio);
-		trace_block_split(split, bio->bi_iter.bi_sector);
-		WARN_ON_ONCE(bio_zone_write_plugging(bio));
-		submit_bio_noacct(bio);
-		return split;
+	split = bio_split(bio, split_sectors, GFP_NOIO, bs);
+	if (IS_ERR(split)) {
+		split_sectors = PTR_ERR(split);
+		goto error;
 	}
 
-	return bio;
+	split->bi_opf |= REQ_NOMERGE;
+	blkcg_bio_issue_init(split);
+	bio_chain(split, bio);
+	trace_block_split(split, bio->bi_iter.bi_sector);
+	WARN_ON_ONCE(bio_zone_write_plugging(bio));
+	submit_bio_noacct(bio);
+	return split;
+
 error:
 	bio->bi_status = errno_to_blk_status(split_sectors);
 	bio_endio(bio);
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(bio_submit_split);
 
 struct bio *bio_split_discard(struct bio *bio, const struct queue_limits *lim,
 		unsigned *nsegs)
@@ -167,7 +181,8 @@ struct bio *bio_split_discard(struct bio *bio, const struct queue_limits *lim,
 	if (split_sectors > tmp)
 		split_sectors -= tmp;
 
-	return bio_submit_split(bio, split_sectors);
+	return bio_submit_split(bio, split_sectors,
+				&bio->bi_bdev->bd_disk->bio_split);
 }
 
 static inline unsigned int blk_boundary_sectors(const struct queue_limits *lim,
@@ -357,7 +372,8 @@ struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
 {
 	return bio_submit_split(bio,
 		bio_split_rw_at(bio, lim, nr_segs,
-			get_max_io_size(bio, lim) << SECTOR_SHIFT));
+			get_max_io_size(bio, lim) << SECTOR_SHIFT),
+			&bio->bi_bdev->bd_disk->bio_split);
 }
 
 /*
@@ -376,7 +392,8 @@ struct bio *bio_split_zone_append(struct bio *bio,
 			lim->max_zone_append_sectors << SECTOR_SHIFT);
 	if (WARN_ON_ONCE(split_sectors > 0))
 		split_sectors = -EINVAL;
-	return bio_submit_split(bio, split_sectors);
+	return bio_submit_split(bio, split_sectors,
+				&bio->bi_bdev->bd_disk->bio_split);
 }
 
 struct bio *bio_split_write_zeroes(struct bio *bio,
@@ -396,7 +413,8 @@ struct bio *bio_split_write_zeroes(struct bio *bio,
 		return bio;
 	if (bio_sectors(bio) <= max_sectors)
 		return bio;
-	return bio_submit_split(bio, max_sectors);
+	return bio_submit_split(bio, max_sectors,
+				&bio->bi_bdev->bd_disk->bio_split);
 }
 
 /**
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 46ffac5caab7..2233261be5e8 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -324,6 +324,8 @@ extern struct bio *bio_split(struct bio *bio, int sectors,
 			     gfp_t gfp, struct bio_set *bs);
 int bio_split_rw_at(struct bio *bio, const struct queue_limits *lim,
 		unsigned *segs, unsigned max_bytes);
+struct bio *bio_submit_split(struct bio *bio, int split_sectors,
+			     struct bio_set *bs);
 
 /**
  * bio_next_split - get next @sectors from a bio, splitting if necessary
-- 
2.39.2



Return-Path: <cgroups+bounces-9453-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC45B3948D
	for <lists+cgroups@lfdr.de>; Thu, 28 Aug 2025 09:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59B877C3845
	for <lists+cgroups@lfdr.de>; Thu, 28 Aug 2025 07:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DD62D29DF;
	Thu, 28 Aug 2025 07:06:23 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB18277C93;
	Thu, 28 Aug 2025 07:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756364782; cv=none; b=ZOF3VWCYMhlz/5YDM1BMiDnXlQxcTDXT50aQzM73TeqT/2xiPBt2/eEP54xDcyvufmc45+UCJNtTcRAgWx5BCnVmscogtCI8e4yOrNeew7eCOeehAKeS1tXJUPvUKtYEuTZb8n+hMM3U8n+RiXPB5Tdd39/afxMOQTTXfMb3awo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756364782; c=relaxed/simple;
	bh=wH17LVsEqdTzSuV3eiKKgaG/NstLeguQkw0M+ZoH+j0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CLqnXyN6kcPGIr7DXsyI6Zk95NhNQrOdngd8Tdudgze25W+BlcD9JTbOHx0zQ436W6d5ZuF+0Potahcq74f82K3REK0V+YY/c10ofP8mMJO4REcF8QR8r/XlK2Ht6XMwOZiRWbPK4dpX7h95HUCRxM3Qws2ecqkqZU+pJcMH7YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cCC9c4kZ1zKHM0S;
	Thu, 28 Aug 2025 15:06:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 55EBB1A152C;
	Thu, 28 Aug 2025 15:06:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCn8Izh_69o_X89Ag--.14658S5;
	Thu, 28 Aug 2025 15:06:12 +0800 (CST)
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
Subject: [PATCH RFC v2 01/10] block: factor out a helper bio_submit_split_bioset()
Date: Thu, 28 Aug 2025 14:57:24 +0800
Message-Id: <20250828065733.556341-2-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCn8Izh_69o_X89Ag--.14658S5
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4kKryDtryrCFy5tryrZwb_yoW5KFW3pr
	4a93WfGrWkJFs29wsxJ3W7Kas3KFZ0qrWUCay3G393JrnrtrsrKF18XrWFvr9YkrW5C3y3
	Jw1vkay5Ca1UArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I
	0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCa
	FVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
	Wlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
	6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr
	0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUv
	cSsGvfC2KfnxnUUI43ZEXa7sRMv31JUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

No functional changes are intended, some drivers like mdraid will split
bio by internal processing, prepare to unify bio split codes.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-merge.c      | 63 ++++++++++++++++++++++++++++--------------
 include/linux/blkdev.h |  2 ++
 2 files changed, 44 insertions(+), 21 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 70d704615be5..3d6dc9cc4f61 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -104,34 +104,55 @@ static unsigned int bio_allowed_max_sectors(const struct queue_limits *lim)
 	return round_down(UINT_MAX, lim->logical_block_size) >> SECTOR_SHIFT;
 }
 
+/**
+ * bio_submit_split_bioset - Submit a bio, splitting it at a designated sector
+ * @bio:		the original bio to be submitted and split
+ * @split_sectors:	the sector count at which to split
+ * @bs:			the bio set used for allocating the new split bio
+ *
+ * The original bio is modified to contain the remaining sectors and submitted.
+ * The caller is responsible for submitting the returned bio.
+ *
+ * If succeed, the newly allocated bio representing the initial part will be
+ * returned, on failure NULL will be returned and original bio will fail.
+ */
+struct bio *bio_submit_split_bioset(struct bio *bio, int split_sectors,
+				    struct bio_set *bs)
+{
+	struct bio *split = bio_split(bio, split_sectors, GFP_NOIO, bs);
+
+	if (IS_ERR(split)) {
+		bio->bi_status = errno_to_blk_status(PTR_ERR(split));
+		bio_endio(bio);
+		return NULL;
+	}
+
+	blkcg_bio_issue_init(split);
+	bio_chain(split, bio);
+	trace_block_split(split, bio->bi_iter.bi_sector);
+	WARN_ON_ONCE(bio_zone_write_plugging(bio));
+	submit_bio_noacct(bio);
+
+	return split;
+}
+EXPORT_SYMBOL_GPL(bio_submit_split_bioset);
+
 static struct bio *bio_submit_split(struct bio *bio, int split_sectors)
 {
-	if (unlikely(split_sectors < 0))
-		goto error;
+	if (unlikely(split_sectors < 0)) {
+		bio->bi_status = errno_to_blk_status(split_sectors);
+		bio_endio(bio);
+		return NULL;
+	}
 
 	if (split_sectors) {
-		struct bio *split;
-
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
+		bio = bio_submit_split_bioset(bio, split_sectors,
+					 &bio->bi_bdev->bd_disk->bio_split);
+		if (bio)
+			bio->bi_opf |= REQ_NOMERGE;
 	}
 
 	return bio;
-error:
-	bio->bi_status = errno_to_blk_status(split_sectors);
-	bio_endio(bio);
-	return NULL;
 }
 
 struct bio *bio_split_discard(struct bio *bio, const struct queue_limits *lim,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index fe1797bbec42..be4b3adf3989 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -999,6 +999,8 @@ extern int blk_register_queue(struct gendisk *disk);
 extern void blk_unregister_queue(struct gendisk *disk);
 void submit_bio_noacct(struct bio *bio);
 struct bio *bio_split_to_limits(struct bio *bio);
+struct bio *bio_submit_split_bioset(struct bio *bio, int split_sectors,
+				    struct bio_set *bs);
 
 extern int blk_lld_busy(struct request_queue *q);
 extern int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags);
-- 
2.39.2



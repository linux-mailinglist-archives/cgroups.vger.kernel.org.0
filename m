Return-Path: <cgroups+bounces-9529-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB469B3D79E
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 05:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46406189955A
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 03:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5592244671;
	Mon,  1 Sep 2025 03:41:21 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3175521D3F5;
	Mon,  1 Sep 2025 03:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756698081; cv=none; b=BzQ4wxIlyct72KfvFefjtOwF7+uAKi+3la3Cjm1OjWbJ8TcNl9KSEDF33smYI+qdPfgVJQEj2WdtFqlEkKHUu6z2Zl/PRgrQIOTjf37aGLeGVDYVOckJ6tUp3RffA/v7r/sPGcaDyTFCG0zYiecMQhJabiFfBF9b3hkthhPUK/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756698081; c=relaxed/simple;
	bh=ia9CS/Ek0AYKsfdsjpfTSVZ4WS+WKqDPnFv7i/9JKoo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f5YMbRiZqPwS+Qcm+pg3UQ79o21OiMZAqIQmLM60KI7G3YG9xf3Z+6w1NJ98Qq9IRgxGhKGGg0XUznGLgXTQ0dJW/kgXnJct4z/N90YJsFCfKOiOS5XJ3owplDbL1E1zW9g9R2RTdY5taz3wFgg9bB70+qp6nTUMzUpYrKSBaw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cFZRK40mqzKHMvT;
	Mon,  1 Sep 2025 11:41:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5F7971A12E4;
	Mon,  1 Sep 2025 11:41:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAncIzWFbVotmf1Aw--.38057S9;
	Mon, 01 Sep 2025 11:41:17 +0800 (CST)
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
Subject: [PATCH RFC v3 05/15] block: factor out a helper bio_submit_split_bioset()
Date: Mon,  1 Sep 2025 11:32:10 +0800
Message-Id: <20250901033220.42982-6-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAncIzWFbVotmf1Aw--.38057S9
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4kKryDtryrCFy5tryrZwb_yoW5Kw47pr
	4a9w1fGrWkJFs29wnxJ3W7tas3KFZ8ZrWUCay3G393JrnrtrsrKF10qryFvF9YkrW5C3y3
	Jw1vkay5Cw4UArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

No functional changes are intended, some drivers like mdraid will split
bio by internal processing, prepare to unify bio split codes.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-merge.c      | 63 ++++++++++++++++++++++++++++--------------
 include/linux/blkdev.h |  2 ++
 2 files changed, 44 insertions(+), 21 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 70d704615be5..e1afb07040c0 100644
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
+struct bio *bio_submit_split_bioset(struct bio *bio, unsigned int split_sectors,
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
index ca1dcf59cb32..eddcd15e7727 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1000,6 +1000,8 @@ extern int blk_register_queue(struct gendisk *disk);
 extern void blk_unregister_queue(struct gendisk *disk);
 void submit_bio_noacct(struct bio *bio);
 struct bio *bio_split_to_limits(struct bio *bio);
+struct bio *bio_submit_split_bioset(struct bio *bio, unsigned int split_sectors,
+				    struct bio_set *bs);
 
 extern int blk_lld_busy(struct request_queue *q);
 extern int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags);
-- 
2.39.2



Return-Path: <cgroups+bounces-9857-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFE9B50E4D
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 08:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6485560C98
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 06:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A78C30F524;
	Wed, 10 Sep 2025 06:40:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFAD30C631;
	Wed, 10 Sep 2025 06:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757486439; cv=none; b=Xwr06N3a3ig/tqWa/H3B8hZrUDh5lOt/+FPm00dQuWvOjR3ZoGW+SZl6umFpiMoGroHi7JOnQ89HbNycjYxuqsPymcpOnmMZIMi85TrOBfI+YTT8C1qzSKOxU/rPuwkGqO2A6OdUbTJUJVA61PKd5zi1GxW1I/fIXd7MYdfeMXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757486439; c=relaxed/simple;
	bh=2hN3wTON6wn2c/0wChGqgusqAmKBLB94eobibFCVrGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tKYVYqFBwGhbfxNh+hwoHnc9wGX4dgNEQ20mskU/KPrAUWgQnKR8UJ7VKpDNIv0wmTCPOeyIa2t7sGX+nYsqF0f0bOTEurIauz8hs80EkZCY8WHpfzwRTyWvZxGlCbnwhEy2PAu7Jyq7WBV/ik46XiIedP7VkrSczcHJSZMdDkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cMB040wJSzYQvRV;
	Wed, 10 Sep 2025 14:40:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 963421A11D5;
	Wed, 10 Sep 2025 14:40:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgB3wY1UHcFo3ZIJCA--.51912S18;
	Wed, 10 Sep 2025 14:40:34 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	hch@infradead.org,
	colyli@kernel.org,
	hare@suse.de,
	dlemoal@kernel.org,
	tieren@fnnas.com,
	bvanassche@acm.org,
	tj@kernel.org,
	josef@toxicpanda.com,
	song@kernel.org,
	satyat@google.com,
	ebiggers@google.com,
	kmo@daterainc.com,
	neil@brown.name,
	akpm@linux-foundation.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH v2 for-6.18/block 14/16] block: skip unnecessary checks for split bio
Date: Wed, 10 Sep 2025 14:30:54 +0800
Message-Id: <20250910063056.4159857-15-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250910063056.4159857-1-yukuai1@huaweicloud.com>
References: <20250910063056.4159857-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3wY1UHcFo3ZIJCA--.51912S18
X-Coremail-Antispam: 1UD129KBjvJXoW7tr1kAF45KrW3Zw47Gr4Uurg_yoW8uF1Upr
	W2g3WDCrW2gF4Y9ay5ta17Ja4F9a1DKr1ru3yfCrWayrnxur97KF4vvrW0vrna9r4fCrZ8
	Zrn7K34UCr45uFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07jIPfQUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Lots of checks are already done while submitting this bio the first
time, and there is no need to check them again when this bio is
resubmitted after split.

Hence open code should_fail_bio() and blk_throtl_bio() that are still
necessary from submit_bio_split_bioset().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c  | 2 +-
 block/blk-merge.c | 6 +++++-
 block/blk.h       | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 83c262a3dfd9..1021a09c5958 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -539,7 +539,7 @@ static inline void bio_check_ro(struct bio *bio)
 	}
 }
 
-static noinline int should_fail_bio(struct bio *bio)
+int should_fail_bio(struct bio *bio)
 {
 	if (should_fail_request(bdev_whole(bio->bi_bdev), bio->bi_iter.bi_size))
 		return -EIO;
diff --git a/block/blk-merge.c b/block/blk-merge.c
index f680ccf81864..c16f4bdf251f 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -130,7 +130,11 @@ struct bio *bio_submit_split_bioset(struct bio *bio, unsigned int split_sectors,
 	bio_chain(split, bio);
 	trace_block_split(split, bio->bi_iter.bi_sector);
 	WARN_ON_ONCE(bio_zone_write_plugging(bio));
-	submit_bio_noacct(bio);
+
+	if (should_fail_bio(bio))
+		bio_io_error(bio);
+	else if (!blk_throtl_bio(bio))
+		submit_bio_noacct_nocheck(bio);
 
 	return split;
 }
diff --git a/block/blk.h b/block/blk.h
index 41397688b941..694ae6c9bb0f 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -616,6 +616,7 @@ extern const struct address_space_operations def_blk_aops;
 int disk_register_independent_access_ranges(struct gendisk *disk);
 void disk_unregister_independent_access_ranges(struct gendisk *disk);
 
+int should_fail_bio(struct bio *bio);
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 bool should_fail_request(struct block_device *part, unsigned int bytes);
 #else /* CONFIG_FAIL_MAKE_REQUEST */
-- 
2.39.2



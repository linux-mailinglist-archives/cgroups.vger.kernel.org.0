Return-Path: <cgroups+bounces-9735-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2F1B44F1F
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 09:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D46FC5A4AF6
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 07:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FEC2FAC08;
	Fri,  5 Sep 2025 07:16:07 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ABC2F8BC3;
	Fri,  5 Sep 2025 07:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757056567; cv=none; b=C8wdGbx0yp/Loa+WFAwDIAcZb9wHoh8jclyMoXs9w5tSO5fjXnHvcvAWsXoysJvq9Cl9ly2IPcSrv8fFdr4/LxMWe2dTtMAbcRneBQpN70qu8odgVd7obT25jQAH6Y5SgDvjB4HYfJBvNqgZipXE5RVsjwH8o3s7GOHNOrxbheo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757056567; c=relaxed/simple;
	bh=0GmGi+d5dfAPLEDOJBUFkMc27dBVoFx1i6mGKHNyo24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cNwKgCTj+Wm7CBjX1wpx/RoC7vdZwiJM4dctNmPTTorqrlobDSLhUO6pGVviBKE5kF+wKA4ETDQo4udece9PcdlJklieiAX8XTTOmx8cR0pob227FsWK8ZXW1V+t/+IGEK2SsO2QkS3QxB6JnHBeGyjMUL2nXO8DUB6Fv5xhFZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cJ71H3K0LzKHMqX;
	Fri,  5 Sep 2025 15:16:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6B4061A147F;
	Fri,  5 Sep 2025 15:16:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAncIwkjrpowYbQBQ--.23573S18;
	Fri, 05 Sep 2025 15:16:03 +0800 (CST)
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
Subject: [PATCH for-6.18/block 14/16] block: skip unnecessary checks for split bio
Date: Fri,  5 Sep 2025 15:06:41 +0800
Message-Id: <20250905070643.2533483-15-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAncIwkjrpowYbQBQ--.23573S18
X-Coremail-Antispam: 1UD129KBjvJXoW7tr1kAF45KrW3Zw47Gr4Uurg_yoW8ur1Upr
	yIg3Z8CrW2gF4j9an8ta17Ja4F93WDKr4ru3yfC3yayrnxur97KF4vvryFyr9a9r4fCrWk
	Zrn7K34UCr45CFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
index 51fe4ed5b7c0..c411045fcf03 100644
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
index 0268deb22268..18cc3c2afdd4 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -615,6 +615,7 @@ extern const struct address_space_operations def_blk_aops;
 int disk_register_independent_access_ranges(struct gendisk *disk);
 void disk_unregister_independent_access_ranges(struct gendisk *disk);
 
+int should_fail_bio(struct bio *bio);
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 bool should_fail_request(struct block_device *part, unsigned int bytes);
 #else /* CONFIG_FAIL_MAKE_REQUEST */
-- 
2.39.2



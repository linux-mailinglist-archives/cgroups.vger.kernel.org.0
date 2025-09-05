Return-Path: <cgroups+bounces-9737-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4234FB44F2B
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 09:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72DE41C86695
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 07:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9F92FD1BC;
	Fri,  5 Sep 2025 07:16:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC32D2F998E;
	Fri,  5 Sep 2025 07:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757056573; cv=none; b=JPwDDH+9NY4LulUn4T7TQsqGXHLVVZW0RDJRqMlvhvT6553HuJzzie2nl133dwNholD4O37eQ1RQiz7elJsmT7Aph79yglUsmtwoflC9K7UpOikziWYZUncD7xoDqs3urDm2l3iKJvPfZNaFPbDVC8jNueEZQi41dpPWyuFbpF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757056573; c=relaxed/simple;
	bh=zCwuK8dJpH3ZAnOhb3RF+CRrX8TXAPb+Q+iAIMUJTAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mYex2JrO/04iy9tzhSW1HyVhZJTx+yHrAHZ+JQMCBAxUraqrVnF6N/hqAyCK87AxgxjPDs4FqeaoZYWmt8AREUtQMTLNOCUH8+Ynh9QJKu6wv7nHbg8yGhjJe/jUeoB8A6R9WyvgklyHIb5Yzd2hw5XiDbPKno4hw2Iveck9K+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cJ71P1YdHzKHMbR;
	Fri,  5 Sep 2025 15:16:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2B1A21A104B;
	Fri,  5 Sep 2025 15:16:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAncIwkjrpowYbQBQ--.23573S20;
	Fri, 05 Sep 2025 15:16:08 +0800 (CST)
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
Subject: [PATCH for-6.18/block 16/16] md/raid0: convert raid0_make_request() to use bio_submit_split_bioset()
Date: Fri,  5 Sep 2025 15:06:43 +0800
Message-Id: <20250905070643.2533483-17-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAncIwkjrpowYbQBQ--.23573S20
X-Coremail-Antispam: 1UD129KBjvJXoW7JFy5Kr4DAF4DKw1xCryrXrb_yoW8JF1Dpw
	sxWFW3Z3yUJFsY9wsrJas2va4rAFyjgrWUCFZrXw4kWrn2vrnFkw4Yq34FqFy5ArWrC3s8
	Jw1qkrsxC3WUJrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Currently, raid0_make_request() will remap the original bio to underlying
disks to prevent reordered IO. Now that bio_submit_split_bioset() will put
original bio to the head of current->bio_list, it's safe converting to use
this helper and bio will still be ordered.

CC: Jan Kara <jack@suse.cz>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid0.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index ca08ec2e1f27..adc9e68d064d 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -607,19 +607,10 @@ static bool raid0_make_request(struct mddev *mddev, struct bio *bio)
 		 : sector_div(sector, chunk_sects));
 
 	if (sectors < bio_sectors(bio)) {
-		struct bio *split = bio_split(bio, sectors, GFP_NOIO,
+		bio = bio_submit_split_bioset(bio, sectors,
 					      &mddev->bio_set);
-
-		if (IS_ERR(split)) {
-			bio->bi_status = errno_to_blk_status(PTR_ERR(split));
-			bio_endio(bio);
+		if (!bio)
 			return true;
-		}
-
-		bio_chain(split, bio);
-		trace_block_split(split, bio->bi_iter.bi_sector);
-		raid0_map_submit_bio(mddev, bio);
-		bio = split;
 	}
 
 	raid0_map_submit_bio(mddev, bio);
-- 
2.39.2



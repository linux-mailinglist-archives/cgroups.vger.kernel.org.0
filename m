Return-Path: <cgroups+bounces-9733-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA586B44F1C
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 09:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1F251C85C67
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 07:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF392F90C9;
	Fri,  5 Sep 2025 07:16:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A27A2580ED;
	Fri,  5 Sep 2025 07:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757056565; cv=none; b=F2CXtVrNtweQzvujs+OTMrtU3wt2iXIwabLskv+T4IRwzyg5GERYAPmsj7gVxsAvo0FJU9WQDF0BLAbFlvDrGpmSr4AaGMMTvwj4FEO/eEyFZWLTOd7nPr9WaT9jBZohJt4bgITZhnC6QGwUiEVa1xROPAfJM8OMTJ5/WxD1eUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757056565; c=relaxed/simple;
	bh=k6y2BqMOOx+6h3atd47hPTSPjD71UyAAiAJMUYXh3HI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lIXJ6p7fW5ifflm+j5c+Ix9ps9H1r2xBzwYQ+6PkyjP8MUyJlkALXOg3NNY7SOFxKFwRv/m6CgFaAxXZ7F8hEYkzUydTh1w9dqJz4o5crPei6gLWhLQwlMqhJP1xL8jymSb5XuwLq8GoJIeBVJJPKgYXWBP2F4B5BpYseqbfQQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cJ71G2b9yzYQtsh;
	Fri,  5 Sep 2025 15:16:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D0BB51A1360;
	Fri,  5 Sep 2025 15:16:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAncIwkjrpowYbQBQ--.23573S15;
	Fri, 05 Sep 2025 15:16:00 +0800 (CST)
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
Subject: [PATCH for-6.18/block 11/16] md/raid5: convert to use bio_submit_split_bioset()
Date: Fri,  5 Sep 2025 15:06:38 +0800
Message-Id: <20250905070643.2533483-12-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAncIwkjrpowYbQBQ--.23573S15
X-Coremail-Antispam: 1UD129KBjvJXoW7WFW7Zw1ktw1kAF45ZF48Crg_yoW8Grykpw
	sIgry7XrW5JrZ09wsxt3yDKFyrta4DWrZ7trWxXw1fK3Z2vFnrKa45X3yFqF15AFWrKry7
	Aw1kJr1UC3W7KFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUI-eODUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Unify bio split code, prepare to fix reordered split IO.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid5.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 0fb838879844..3c9825ad3f07 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5468,7 +5468,6 @@ static int raid5_read_one_chunk(struct mddev *mddev, struct bio *raid_bio)
 
 static struct bio *chunk_aligned_read(struct mddev *mddev, struct bio *raid_bio)
 {
-	struct bio *split;
 	sector_t sector = raid_bio->bi_iter.bi_sector;
 	unsigned chunk_sects = mddev->chunk_sectors;
 	unsigned sectors = chunk_sects - (sector & (chunk_sects-1));
@@ -5476,11 +5475,10 @@ static struct bio *chunk_aligned_read(struct mddev *mddev, struct bio *raid_bio)
 	if (sectors < bio_sectors(raid_bio)) {
 		struct r5conf *conf = mddev->private;
 
-		split = bio_split(raid_bio, sectors, GFP_NOIO, &conf->bio_split);
-		bio_chain(split, raid_bio);
-		trace_block_split(split, raid_bio->bi_iter.bi_sector);
-		submit_bio_noacct(raid_bio);
-		raid_bio = split;
+		raid_bio = bio_submit_split_bioset(raid_bio, sectors,
+						   &conf->bio_split);
+		if (!raid_bio)
+			return NULL;
 	}
 
 	if (!raid5_read_one_chunk(mddev, raid_bio))
-- 
2.39.2



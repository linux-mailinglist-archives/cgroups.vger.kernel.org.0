Return-Path: <cgroups+bounces-9370-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AC4B33B6B
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 11:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3ED74803F6
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 09:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F7A2D193F;
	Mon, 25 Aug 2025 09:45:33 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9125A2C15A5;
	Mon, 25 Aug 2025 09:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756115132; cv=none; b=LurdT1rc9T2cDR5pRSgM1V2I6eYKmGumMaEJGXrQ914xcpBJpV73rsSLjh8WRYGzKJGoMTKp0Srp/d419Qq6f0jCDSgPT/aI1rNffDuFDSO+GeEGBiQY+aYKElPITCoZRHimMzzFXcqPZ0zc6KjbjBGNzhh32D/sWmGAhOF3+uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756115132; c=relaxed/simple;
	bh=fJYF4Nf5ATfwWZdatndbzlCs3ZbeJ7Yr612QdgFXfLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T3U3mmcSQ8uhQazYkaXdM3pQERP+vhpGdvyp9odbzQ3A7ZuMqmzrVPmYVxP18Rz6PsvynszY5r7OwiwaJqvr3ktKjFFuDNIDEL1c5IDslePtV6nN2+KTfwJx0UzcU8DrO/DEspy3Yy8Ur/Y2SEXsr+JCrZFeXDVfmedz8o0b2lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c9Qrn6QTYzYQvgT;
	Mon, 25 Aug 2025 17:45:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6DF0E1A1C47;
	Mon, 25 Aug 2025 17:45:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAXYIy1MKxonJnxAA--.44975S6;
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
Subject: [PATCH RFC 2/7] md/raid0: convert raid0_handle_discard() to use bio_submit_split()
Date: Mon, 25 Aug 2025 17:36:55 +0800
Message-Id: <20250825093700.3731633-3-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAXYIy1MKxonJnxAA--.44975S6
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWUury8Aw4rJw1xCF45ZFb_yoW8Ar15p3
	9xWa4avrW8Grs09wsrAa42gas5Ja48WrW7GFZrJ393JF98Zryqkr45Kry8XFyUCryIka4D
	J3WkAasxCryDJrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2
	KfnxnUUI43ZEXa7sRREfO5UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

On the one hand unify bio split code, prepare to fix disordered split
IO; On the other hand fix missing blkcg_bio_issue_init() and
trace_block_split() for split IO.

Noted raid0_make_request() already fix disordered split IO by
319ff40a5427 ("md/raid0: Fix performance regression for large sequential
writes"), by convert bio to underlying disks before submit_bio_noacct(),
with the respect md_submit_bio() already split by sectors, and
raid0_make_request() will split at most once for unaligned IO. This is a
bit hacky and we'll convert this to solution in general later.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid0.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index f1d8811a542a..19b5faf238b7 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -463,21 +463,17 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 	zone = find_zone(conf, &start);
 
 	if (bio_end_sector(bio) > zone->zone_end) {
-		struct bio *split = bio_split(bio,
-			zone->zone_end - bio->bi_iter.bi_sector, GFP_NOIO,
-			&mddev->bio_set);
-
-		if (IS_ERR(split)) {
-			bio->bi_status = errno_to_blk_status(PTR_ERR(split));
-			bio_endio(bio);
+		bio = bio_submit_split(bio,
+				zone->zone_end - bio->bi_iter.bi_sector,
+				&mddev->bio_set);
+		if (!bio)
 			return;
-		}
-		bio_chain(split, bio);
-		submit_bio_noacct(bio);
-		bio = split;
+
+		bio->bi_opf &= ~REQ_NOMERGE;
 		end = zone->zone_end;
-	} else
+	} else {
 		end = bio_end_sector(bio);
+	}
 
 	orig_end = end;
 	if (zone != conf->strip_zone)
-- 
2.39.2



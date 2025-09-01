Return-Path: <cgroups+bounces-9530-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5ACB3D7A2
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 05:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA0233BC06C
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 03:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87273253B58;
	Mon,  1 Sep 2025 03:41:22 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E9922D7B9;
	Mon,  1 Sep 2025 03:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756698082; cv=none; b=VkaNHPMiETXouOurf/GpA1d4fauY5w+k4oYvpp4tk6a1YwghsueBy9nBo/e6n6h0djL7G36MiHLESxq1bN2r1Jsz24RatJH3oLfKepEghGKEkHiq3d8pwz8RTzx5nUMpz0oyUyMxXGdoL9Cg799yZLxh+YRXiGpJH2Z8O8McCE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756698082; c=relaxed/simple;
	bh=FXmWGb+H+rs5F5W54UcdydezHRpFhg7ownTZdKpauuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LiVvUQ3atVMqCkqL3/AmjyFjkJlPtlA9wMo68FhAo0jdXOT7aQ9hyYOljrlDaiImoqLi4s6u0KO/iiOragI7QjjNz7+V6c2IxhTfL2bBNZHFSvKXtlztqpZ2LJl9ekr4zh7VBXakbpJMYC7Zzm89RaU0iuAtCm7IhwBoBdAo/34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cFZRL2lWZzKHN5C;
	Mon,  1 Sep 2025 11:41:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 304071A0F97;
	Mon,  1 Sep 2025 11:41:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAncIzWFbVotmf1Aw--.38057S10;
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
Subject: [PATCH RFC v3 06/15] md/raid0: convert raid0_handle_discard() to use bio_submit_split_bioset()
Date: Mon,  1 Sep 2025 11:32:11 +0800
Message-Id: <20250901033220.42982-7-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAncIzWFbVotmf1Aw--.38057S10
X-Coremail-Antispam: 1UD129KBjvJXoW7WFWxCF1rJr4xAF1xAFyrJFb_yoW8Wry3p3
	9xua4aqrW8Grs0939rAa42gas5Ja4DWrWUGFZrX3yxGFy7Zr1qkw4UtryrXFy5CrySka4U
	X3WkAasxG34DXrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Unify bio split code, and prepare to fix disordered split IO

Noted commit 319ff40a5427 ("md/raid0: Fix performance regression for large
sequential writes") already fix disordered split IO by converting bio to
underlying disks before submit_bio_noacct(), with the respect
md_submit_bio() already split by sectors, and raid0_make_request() will
split at most once for unaligned IO. This is a bit hacky and we'll convert
this to solution in general later.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid0.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index 1ba7d0c090f7..99f7839b4e96 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -463,23 +463,16 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 	zone = find_zone(conf, &start);
 
 	if (bio_end_sector(bio) > zone->zone_end) {
-		struct bio *split = bio_split(bio,
-			zone->zone_end - bio->bi_iter.bi_sector, GFP_NOIO,
-			&mddev->bio_set);
-
-		if (IS_ERR(split)) {
-			bio->bi_status = errno_to_blk_status(PTR_ERR(split));
-			bio_endio(bio);
+		bio = bio_submit_split_bioset(
+				bio, zone->zone_end - bio->bi_iter.bi_sector,
+				&mddev->bio_set);
+		if (!bio)
 			return;
-		}
 
-		bio_chain(split, bio);
-		trace_block_split(split, bio->bi_iter.bi_sector);
-		submit_bio_noacct(bio);
-		bio = split;
 		end = zone->zone_end;
-	} else
+	} else {
 		end = bio_end_sector(bio);
+	}
 
 	orig_end = end;
 	if (zone != conf->strip_zone)
-- 
2.39.2



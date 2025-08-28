Return-Path: <cgroups+bounces-9454-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 109EEB39491
	for <lists+cgroups@lfdr.de>; Thu, 28 Aug 2025 09:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFDD77C4578
	for <lists+cgroups@lfdr.de>; Thu, 28 Aug 2025 07:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A562D640E;
	Thu, 28 Aug 2025 07:06:23 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4756F28AAE6;
	Thu, 28 Aug 2025 07:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756364783; cv=none; b=dxNa6fxFgqdz5otSrJyKLqK+vPsieJeSwRpVq35/3fLlWVPLdDA2Z9fQAiTohcc6Cg1khGIyUARIV1p+8VlQdWcZyQi7oKkYcP+UKon1Ui9IIx29cHchICzTKBf9jsZ5XWlwSSchTPCiMttzzUkC2pnEY/Mtd0lKC6qTfIDVbRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756364783; c=relaxed/simple;
	bh=5O1B7b89iGEBHu2bvA5JVFnmeA3QOqrQVqczmlePPEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XfpSe3Ko4+zDuM03ZvfwAWoNJ5dxo0bMO7NdNjRDhpsn7VL/2eUtlG0JUI7yaGCYgPj44Kdd5Iu9afJUNJBHq60kj+2yqQruiKUYIxb/TfQHqMQzB+gqjO8nRWrWo4s2OCVqHhVkGgsl4eHuNaMyGEWHjduxrkwpQxBydu2Qa9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cCC9f3bv4zYQtx9;
	Thu, 28 Aug 2025 15:06:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 075E41A1EC2;
	Thu, 28 Aug 2025 15:06:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCn8Izh_69o_X89Ag--.14658S6;
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
Subject: [PATCH RFC v2 02/10] md/raid0: convert raid0_handle_discard() to use bio_submit_split_bioset()
Date: Thu, 28 Aug 2025 14:57:25 +0800
Message-Id: <20250828065733.556341-3-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCn8Izh_69o_X89Ag--.14658S6
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWUuryUCr47tF1fWw4xtFb_yoW8WFyfpw
	sxWa4aqrW8KrsYk39Fva42gas5Ja48WrWUGFZrX393GFy8Zryqkr45KryrXFy5CryIka4D
	X3WkAasxGr1DArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjTRNiSHDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

On the one hand unify bio split code, prepare to fix disordered split
IO; On the other hand fix missing blkcg_bio_issue_init() and
trace_block_split() for split IO.

Noted commit 319ff40a5427 ("md/raid0: Fix performance regression for large
sequential writes") already fix disordered split IO by converting bio to
underlying disks before submit_bio_noacct(), with the respect
md_submit_bio() already split by sectors, and raid0_make_request() will
split at most once for unaligned IO. This is a bit hacky and we'll convert
this to solution in general later.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid0.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index f1d8811a542a..4dcc5133d679 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -463,21 +463,16 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 	zone = find_zone(conf, &start);
 
 	if (bio_end_sector(bio) > zone->zone_end) {
-		struct bio *split = bio_split(bio,
-			zone->zone_end - bio->bi_iter.bi_sector, GFP_NOIO,
-			&mddev->bio_set);
-
-		if (IS_ERR(split)) {
-			bio->bi_status = errno_to_blk_status(PTR_ERR(split));
-			bio_endio(bio);
+		bio = bio_submit_split_bioset(bio,
+				zone->zone_end - bio->bi_iter.bi_sector,
+				&mddev->bio_set);
+		if (!bio)
 			return;
-		}
-		bio_chain(split, bio);
-		submit_bio_noacct(bio);
-		bio = split;
+
 		end = zone->zone_end;
-	} else
+	} else {
 		end = bio_end_sector(bio);
+	}
 
 	orig_end = end;
 	if (zone != conf->strip_zone)
-- 
2.39.2



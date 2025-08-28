Return-Path: <cgroups+bounces-9458-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35791B394A1
	for <lists+cgroups@lfdr.de>; Thu, 28 Aug 2025 09:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 687241894C9B
	for <lists+cgroups@lfdr.de>; Thu, 28 Aug 2025 07:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD952E7BD0;
	Thu, 28 Aug 2025 07:06:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC3F2D7384;
	Thu, 28 Aug 2025 07:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756364785; cv=none; b=PKW98BvaPAWVIBkDqlNuoae6CDtQDwSLVHidvLYVtTZNiKPYzKLmNU+N31w6LbeeBEh4aRZW92/V5wWMly8MNMwUH5Z7l+95sNomsqi5Jpy6TyCftAqdqv4SYGZHhvGOr9S2cUctONe/bhagsYzI9d93l/aWQvyfZ6rJd68vXy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756364785; c=relaxed/simple;
	bh=8faEDZAsiayJKUvTcrNQ8JGAk3d6wvPqqpSY/Ku2L9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D3ZWGrUQi6Gf1UYXJSEPfDJ8ZX4QwRs3vzXT0nQMm3qDFukEHyzTimSU2mlfrnAq0x8k2/jCTUQAGv+Bo/k24N6z0V+wuskRU/k6KxfZeL9U3OwzHd0QxMNvqz5RsOy+dmFGQ7x55+MIsvfYBCUKfKvnGbY57R5IadAeXAl6uPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cCC9g3LfWzKHMdy;
	Thu, 28 Aug 2025 15:06:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 267041A1563;
	Thu, 28 Aug 2025 15:06:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCn8Izh_69o_X89Ag--.14658S9;
	Thu, 28 Aug 2025 15:06:14 +0800 (CST)
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
Subject: [PATCH RFC v2 05/10] md/raid5: convert to use bio_submit_split_bioset()
Date: Thu, 28 Aug 2025 14:57:28 +0800
Message-Id: <20250828065733.556341-6-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCn8Izh_69o_X89Ag--.14658S9
X-Coremail-Antispam: 1UD129KBjvJXoW7AFW8KFWUWr4xur45Xw48tFb_yoW8JFWDpw
	sIgry3XrW5JrZ09wsIq3yDKas5ta4UWrZ7trWxX343Ga92vF9rKay5X34FqF15AFWrK342
	vw1kJr15CF1UKFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0pRQJ5wUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

On the one hand unify bio split code, prepare to fix disordered split
IO; On the other hand fix missing blkcg_bio_issue_init() and
trace_block_split() for split IO.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid5.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 023649fe2476..3c9825ad3f07 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5468,17 +5468,17 @@ static int raid5_read_one_chunk(struct mddev *mddev, struct bio *raid_bio)
 
 static struct bio *chunk_aligned_read(struct mddev *mddev, struct bio *raid_bio)
 {
-	struct bio *split;
 	sector_t sector = raid_bio->bi_iter.bi_sector;
 	unsigned chunk_sects = mddev->chunk_sectors;
 	unsigned sectors = chunk_sects - (sector & (chunk_sects-1));
 
 	if (sectors < bio_sectors(raid_bio)) {
 		struct r5conf *conf = mddev->private;
-		split = bio_split(raid_bio, sectors, GFP_NOIO, &conf->bio_split);
-		bio_chain(split, raid_bio);
-		submit_bio_noacct(raid_bio);
-		raid_bio = split;
+
+		raid_bio = bio_submit_split_bioset(raid_bio, sectors,
+						   &conf->bio_split);
+		if (!raid_bio)
+			return NULL;
 	}
 
 	if (!raid5_read_one_chunk(mddev, raid_bio))
-- 
2.39.2



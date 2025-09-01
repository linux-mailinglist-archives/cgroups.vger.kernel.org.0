Return-Path: <cgroups+bounces-9534-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B4BB3D7B2
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 05:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835283BCF55
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 03:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB58263C75;
	Mon,  1 Sep 2025 03:41:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4751325785F;
	Mon,  1 Sep 2025 03:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756698085; cv=none; b=Q9Bh5qX6iCk9hHyXL9afoP1ZiSUKoSjyXMlMhj982p6r/A1h7o0os8hcJarHtswjJr+RilTrAS3+DF2JPem7h2l0zMWc49QkMr40IORPfqLTl56uZ/dB+gB2DXb9WQ0di+VqJJd2z7+CkZmI/CPUFJzGrCd3Bv27+i0stkltUXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756698085; c=relaxed/simple;
	bh=Wu4QY81oNY/aSgeMpX1XfaTn73TQKAMk41aGvqzWwaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VB2sZATeEgPOOLuZVWEu+ItHq+Ba7CNLdPL9LHIxCEs5Ubd4aH5gse0dv5rg+WrkEZbsJHC51Nj0z5fFyJakrVl3xhy8ppxbC3bpnqxEqD7WdtVdV8Z+MotdI3rjbWswnujlHEaMUe/4vzH887JxixPbe7SCiq/1mANkKih2AKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cFZRP4LkBzKHN6d;
	Mon,  1 Sep 2025 11:41:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 683C61A0FA5;
	Mon,  1 Sep 2025 11:41:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAncIzWFbVotmf1Aw--.38057S14;
	Mon, 01 Sep 2025 11:41:21 +0800 (CST)
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
Subject: [PATCH RFC v3 10/15] md/raid5: convert to use bio_submit_split_bioset()
Date: Mon,  1 Sep 2025 11:32:15 +0800
Message-Id: <20250901033220.42982-11-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAncIzWFbVotmf1Aw--.38057S14
X-Coremail-Antispam: 1UD129KBjvJXoW7WFW7Zw17GF4rZF1DAFyxKrg_yoW8GrWUpw
	sIgry7XrW5JrZ09wsxt3yDKa4rta4DWrZ7trWxXw1fK3Z2vFnrKa45X3yFqF15AFWrKry7
	Aw1kJr1UC3WUKFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0pRiF4iUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Unify bio split code, prepare to fix disordered split IO.

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



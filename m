Return-Path: <cgroups+bounces-9462-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1EBB394B4
	for <lists+cgroups@lfdr.de>; Thu, 28 Aug 2025 09:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67F917A5E4A
	for <lists+cgroups@lfdr.de>; Thu, 28 Aug 2025 07:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154452F90C4;
	Thu, 28 Aug 2025 07:06:27 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB982E0926;
	Thu, 28 Aug 2025 07:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756364786; cv=none; b=IUDViwiJJZ6BcY8R2fOB9Z3dOV8CIlX2jM5G2IWoNIJJcrEu1gcvq2sf+00PTtwVKb67B2lGUqSlKAlq3XnOMgMTL3vUk5Z7lFOAjnlN8IXHYSlTZSzp66Co7Iu+25KZ36p032L/yaHON60WD8ERIuWWfR2KzFl2dYDZIthR268=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756364786; c=relaxed/simple;
	bh=6TEA25eGN7fuAf5CCqC+94Hz9adMfptwklPnQsNQtXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fDO4m2beLmBEOshl3duqlHY4nqTjHhbtKsdDxYqLKjlG/AZDxdTseLaBelg9pjCaUI5CxLh8ea+134SFm7eccTghcMtRl2TU+8TYBeXKzw3tkx3A2OkxcSt2VdkMbmCtGw4luzsKOROlRsEaIpm334aaS9d/w4jpLMmKafXMuLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cCC9j4FTKzKHMSf;
	Thu, 28 Aug 2025 15:06:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 43BC41A1208;
	Thu, 28 Aug 2025 15:06:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCn8Izh_69o_X89Ag--.14658S12;
	Thu, 28 Aug 2025 15:06:16 +0800 (CST)
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
Subject: [PATCH RFC v2 08/10] block: skip unnecessary checks for split bio
Date: Thu, 28 Aug 2025 14:57:31 +0800
Message-Id: <20250828065733.556341-9-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCn8Izh_69o_X89Ag--.14658S12
X-Coremail-Antispam: 1UD129KBjvJXoW7tr1kAF4xWrW8ZrWDZFy3XFb_yoW8uw4kpr
	Wa93W3CrZFgF4xuwsrXa17tasYk3WkKr4UXayfZr4YyFnI9wn7K3W8Zry0vr9Y9r4fCFZ8
	Ar1kKrW7Gr4UWFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Lots of checks are already done while submitting this bio the first
time, and there is no need to check them again when this bio is
resubmitted after split.

Hence factor out a helper submit_split_bio_noacct() for resubmitting
bio after splitting, only should_fail_bio() and blk_throtl_bio() are
keeped.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-core.c  | 15 +++++++++++++++
 block/blk-merge.c |  2 +-
 block/blk.h       |  1 +
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 4201504158a1..37836446f365 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -765,6 +765,21 @@ static blk_status_t blk_validate_atomic_write_op_size(struct request_queue *q,
 	return BLK_STS_OK;
 }
 
+void submit_split_bio_noacct(struct bio *bio)
+{
+	might_sleep();
+
+	if (should_fail_bio(bio)) {
+		bio_io_error(bio);
+		return;
+	}
+
+	if (blk_throtl_bio(bio))
+		return;
+
+	submit_bio_noacct_nocheck(bio);
+}
+
 /**
  * submit_bio_noacct - re-submit a bio to the block device layer for I/O
  * @bio:  The bio describing the location in memory and on the device.
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 3d6dc9cc4f61..fa2c3d98b277 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -131,7 +131,7 @@ struct bio *bio_submit_split_bioset(struct bio *bio, int split_sectors,
 	bio_chain(split, bio);
 	trace_block_split(split, bio->bi_iter.bi_sector);
 	WARN_ON_ONCE(bio_zone_write_plugging(bio));
-	submit_bio_noacct(bio);
+	submit_split_bio_noacct(bio);
 
 	return split;
 }
diff --git a/block/blk.h b/block/blk.h
index 46f566f9b126..80375374ef55 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -54,6 +54,7 @@ bool blk_queue_start_drain(struct request_queue *q);
 bool __blk_freeze_queue_start(struct request_queue *q,
 			      struct task_struct *owner);
 int __bio_queue_enter(struct request_queue *q, struct bio *bio);
+void submit_split_bio_noacct(struct bio *bio);
 void submit_bio_noacct_nocheck(struct bio *bio);
 void bio_await_chain(struct bio *bio);
 
-- 
2.39.2



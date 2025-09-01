Return-Path: <cgroups+bounces-9537-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB57B3D7C0
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 05:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DCBA3AD9DF
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 03:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889E426D4CA;
	Mon,  1 Sep 2025 03:41:27 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21CF2673B0;
	Mon,  1 Sep 2025 03:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756698087; cv=none; b=N1Vqs2WxLB7XCwv9Cxj/5Pt6yFAsoqtcG0jGeWPrzMRXyaCBTVVHLFWA6fnBq6ioD5agC0FciOU+NBQQF876V757gETs7i4eF22qo+ARkaOcWaB6PFZB9NHyyOVg3HV7RIp0odd1o+bCae/uiqC7KGNzzoH59fkLMGSUOisMQpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756698087; c=relaxed/simple;
	bh=FE15yZ087OBXVSTydBbLAXVcqYQitv0ePQ4JgBHuNeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tsb9zZVwH8gYUxDoaDgQ0wqxrXMvlD4+GdJEFbUiynFm+4ijUoo3077TIeJ3mpeBMvyEqhwHt3ON88sQhiEdZ5B1YZNzX/WyxKN22RqT0xcYZSDbvYm19g4SQJ8jfdIv/WQhIGC1WLX5pOHfDjxp0BJ2CJ3toPWfeL1Zl4vJBsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cFZRT2XpGzYQvPk;
	Mon,  1 Sep 2025 11:41:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D041E1A0FC3;
	Mon,  1 Sep 2025 11:41:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAncIzWFbVotmf1Aw--.38057S17;
	Mon, 01 Sep 2025 11:41:23 +0800 (CST)
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
Subject: [PATCH RFC v3 13/15] block: skip unnecessary checks for split bio
Date: Mon,  1 Sep 2025 11:32:18 +0800
Message-Id: <20250901033220.42982-14-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAncIzWFbVotmf1Aw--.38057S17
X-Coremail-Antispam: 1UD129KBjvJXoW7tr1kAF4xWrW8ZrWkGFWxZwb_yoW8tFy5pr
	WYg3W5CrZFgF4fuwsrJ3W7tF9Yk3WkKr4UXayfZrs0yrnxurnrK3WkZry0qr9Y9r4fCrZ8
	Ar1kKFWUGr4UGFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Lots of checks are already done while submitting this bio the first
time, and there is no need to check them again when this bio is
resubmitted after split.

Hence factor out a helper submit_split_bio_noacct() for resubmitting
bio after splitting, only should_fail_bio() and blk_throtl_bio() are
kept.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-core.c  | 16 ++++++++++++++++
 block/blk-merge.c |  2 +-
 block/blk.h       |  1 +
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 4201504158a1..ea194a1a5b2c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -765,6 +765,22 @@ static blk_status_t blk_validate_atomic_write_op_size(struct request_queue *q,
 	return BLK_STS_OK;
 }
 
+/* resubmit a bio after split, see bio_submit_split_bioset() */
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
index e1afb07040c0..4feeaab0d3db 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -131,7 +131,7 @@ struct bio *bio_submit_split_bioset(struct bio *bio, unsigned int split_sectors,
 	bio_chain(split, bio);
 	trace_block_split(split, bio->bi_iter.bi_sector);
 	WARN_ON_ONCE(bio_zone_write_plugging(bio));
-	submit_bio_noacct(bio);
+	submit_split_bio_noacct(bio);
 
 	return split;
 }
diff --git a/block/blk.h b/block/blk.h
index 0268deb22268..68bf637ab7ca 100644
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



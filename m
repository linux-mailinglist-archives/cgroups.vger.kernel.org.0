Return-Path: <cgroups+bounces-9850-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32263B50E2D
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 08:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B5E01C27C0D
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 06:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A88130BBB7;
	Wed, 10 Sep 2025 06:40:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7407C309EF8;
	Wed, 10 Sep 2025 06:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757486435; cv=none; b=A9Eew0f10LHLynnQwAtWoDgzSnXBZ6OEiLuxCdtG6Fxy1OmN8uUajRshS4tjZlXHOeAgZtEqP8/fhYhCmlUuHP4PfFeD8ft6BfkFDGM3DwuVXvug0eJFmWP28E7j7zYcRygmTNBS2q7s4Z5uz9x8dqV6XU/OFOrR9tA7qCN+SCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757486435; c=relaxed/simple;
	bh=/zk+bxCb6Zb9hvBYssvYSJTRAViS8Qf5GjYQrRnB7hs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HPmZB5TCH9btgnO074SI7CccJ7MMy64KXF7nvfbWwGYM6LEDUtIIEdJ5BAAxffRH1SmOZvEh+VQkErwwKtTU0+MX9f9BU8CsbMs6vOzOmvizZAUoH2H1fSuXa6/XiazkRKilxlkacIyYcYgxxIpKdO3Yccr4rmaXLkS2bJrOyGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cM9zt6JPKzYQvRH;
	Wed, 10 Sep 2025 14:40:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5FE021A0E99;
	Wed, 10 Sep 2025 14:40:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgB3wY1UHcFo3ZIJCA--.51912S7;
	Wed, 10 Sep 2025 14:40:25 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	hch@infradead.org,
	colyli@kernel.org,
	hare@suse.de,
	dlemoal@kernel.org,
	tieren@fnnas.com,
	bvanassche@acm.org,
	tj@kernel.org,
	josef@toxicpanda.com,
	song@kernel.org,
	satyat@google.com,
	ebiggers@google.com,
	kmo@daterainc.com,
	neil@brown.name,
	akpm@linux-foundation.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH v2 for-6.18/block 03/16] blk-mq: add QUEUE_FLAG_BIO_ISSUE_TIME
Date: Wed, 10 Sep 2025 14:30:43 +0800
Message-Id: <20250910063056.4159857-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250910063056.4159857-1-yukuai1@huaweicloud.com>
References: <20250910063056.4159857-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3wY1UHcFo3ZIJCA--.51912S7
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1kCry5AF1fCrWkJryDAwb_yoW5CrWfpa
	95KF1Ik342gF4xWF48ta13A3WUGr4vgry7CF90k3yruw1Igr17XF1kAF1UtFWkurs7Ar45
	Xr1xtF9Ygry5W3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU04x
	RDUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

bio->issue_time_ns is initialized for every bio, however, it's only used
by blk-iolatency. Add a new queue_flag and only set this flag when
blk-iolatency is enabled, so that extra blk_time_get_ns() can be saved
for disks that blk-iolatency is not enabled.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-iolatency.c  | 5 +++++
 block/blk-mq-debugfs.c | 1 +
 block/blk-mq.c         | 8 +++++---
 include/linux/blkdev.h | 1 +
 4 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 554b191a6892..45bd18f68541 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -742,10 +742,15 @@ static void blkiolatency_enable_work_fn(struct work_struct *work)
 	 */
 	enabled = atomic_read(&blkiolat->enable_cnt);
 	if (enabled != blkiolat->enabled) {
+		struct request_queue *q = blkiolat->rqos.disk->queue;
 		unsigned int memflags;
 
 		memflags = blk_mq_freeze_queue(blkiolat->rqos.disk->queue);
 		blkiolat->enabled = enabled;
+		if (enabled)
+			blk_queue_flag_set(QUEUE_FLAG_BIO_ISSUE_TIME, q);
+		else
+			blk_queue_flag_clear(QUEUE_FLAG_BIO_ISSUE_TIME, q);
 		blk_mq_unfreeze_queue(blkiolat->rqos.disk->queue, memflags);
 	}
 }
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 32c65efdda46..4896525b1c05 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -96,6 +96,7 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(DISABLE_WBT_DEF),
 	QUEUE_FLAG_NAME(NO_ELV_SWITCH),
 	QUEUE_FLAG_NAME(QOS_ENABLED),
+	QUEUE_FLAG_NAME(BIO_ISSUE_TIME),
 };
 #undef QUEUE_FLAG_NAME
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2c0c8ead7080..31cc743ffad7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -396,10 +396,12 @@ static inline void blk_mq_rq_time_init(struct request *rq, u64 alloc_time_ns)
 #endif
 }
 
-static inline void blk_mq_bio_issue_init(struct bio *bio)
+static inline void blk_mq_bio_issue_init(struct request_queue *q,
+					 struct bio *bio)
 {
 #ifdef CONFIG_BLK_CGROUP
-	bio->issue_time_ns = blk_time_get_ns();
+	if (test_bit(QUEUE_FLAG_BIO_ISSUE_TIME, &q->queue_flags))
+		bio->issue_time_ns = blk_time_get_ns();
 #endif
 }
 
@@ -3175,7 +3177,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	if (!bio_integrity_prep(bio))
 		goto queue_exit;
 
-	blk_mq_bio_issue_init(bio);
+	blk_mq_bio_issue_init(q, bio);
 	if (blk_mq_attempt_bio_merge(q, bio, nr_segs))
 		goto queue_exit;
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c8cb08b2ed29..7c542b1851fa 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -657,6 +657,7 @@ enum {
 	QUEUE_FLAG_DISABLE_WBT_DEF,	/* for sched to disable/enable wbt */
 	QUEUE_FLAG_NO_ELV_SWITCH,	/* can't switch elevator any more */
 	QUEUE_FLAG_QOS_ENABLED,		/* qos is enabled */
+	QUEUE_FLAG_BIO_ISSUE_TIME,	/* record bio->issue_time_ns */
 	QUEUE_FLAG_MAX
 };
 
-- 
2.39.2



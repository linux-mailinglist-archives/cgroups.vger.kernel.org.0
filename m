Return-Path: <cgroups+bounces-9725-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3977DB44EF6
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 09:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D44711C832CE
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 07:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868E02E9EC8;
	Fri,  5 Sep 2025 07:15:58 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F59227A46E;
	Fri,  5 Sep 2025 07:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757056558; cv=none; b=i5D0F0AjZZP73vY1j9SHHmL1ijuumQHJVbbdWAJDGrAgYGvO51MP6x2FnaX96QB7qXSQekh5vNgO8rRxhrZ+6lzKD35CV9LiGlSnd51ig29Lit3TNEb7V6u3ZcWiRS6TfzrLs4wthDev5ZbUoynYoJuDqnJyxwdM7FaMICjKye0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757056558; c=relaxed/simple;
	bh=VYzVi/Ux+8GR0sfiDKmwI1xaxSC0ct186gPGpcyhj7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=buuCnFfqRx/KtPW3O/An+FxPP8hJP9If5WzwYO7cpW25RxVEcK+zuH7vasGKdSG9nGvKLvS07j9uxgeY8n0YIC1aat89iaOYVpuQilAUk9kqjIXBmn90u8ebIb/eUzM+Y66jVH00vOoYSq5i1fLY4u0mrCBlHbjZxH68O/spiLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cJ71733ZJzYQtpY;
	Fri,  5 Sep 2025 15:15:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DF7F51A0D93;
	Fri,  5 Sep 2025 15:15:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAncIwkjrpowYbQBQ--.23573S7;
	Fri, 05 Sep 2025 15:15:53 +0800 (CST)
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
Subject: [PATCH for-6.18/block 03/16] blk-mq: add QUEUE_FLAG_BIO_ISSUE_TIME
Date: Fri,  5 Sep 2025 15:06:30 +0800
Message-Id: <20250905070643.2533483-4-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAncIwkjrpowYbQBQ--.23573S7
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1fZw4Dur17CF1xZw1kZrb_yoW5XryUpa
	95KF92k342gr4xXF18ta13A3WUGws0gr17CFn0kw45Zw1xWr17Xr1vyF1UtaykursxArWY
	qryxtFykWry5WrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
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
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jx
	CztUUUUU=
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
 block/blk-mq.c         | 4 +++-
 include/linux/blkdev.h | 1 +
 4 files changed, 10 insertions(+), 1 deletion(-)

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
index d2538683c83d..eaa18536333f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3168,7 +3168,9 @@ void blk_mq_submit_bio(struct bio *bio)
 	if (!bio_integrity_prep(bio))
 		goto queue_exit;
 
-	bio->issue_time_ns = blk_time_get_ns();
+	if (test_bit(QUEUE_FLAG_BIO_ISSUE_TIME, &q->queue_flags))
+		bio->issue_time_ns = blk_time_get_ns();
+
 	if (blk_mq_attempt_bio_merge(q, bio, nr_segs))
 		goto queue_exit;
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 7709d55adc23..3c3b64684d14 100644
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



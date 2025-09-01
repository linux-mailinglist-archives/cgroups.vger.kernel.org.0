Return-Path: <cgroups+bounces-9525-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E3EB3D78D
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 05:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F873A2B6E
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 03:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56188221F0C;
	Mon,  1 Sep 2025 03:41:19 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AFA1FE451;
	Mon,  1 Sep 2025 03:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756698079; cv=none; b=Rdson8YvN5UtmLUwgw/pnUeHJz2nUvreGy7OCaQOYLaqM3/xcTOeP2qdxch5HXHYc7OJjGk/Ge0v8jmYAHqHBR300gezFiryJCBUdA4Q6gyn23q5nwi9P9LUSxSnGVpMTCOyiHUMF8OQFV3ucd+6gNWhZf1sjmyNEGiylG6l5QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756698079; c=relaxed/simple;
	bh=7tG15BGdKC0093jcyclxFd41gv8UDQyPd2oR15d9o/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QrlLifVn9+EQclmp2AGLkLuZGn6DejqNo0xZ8f2jgNuqfEH/tFOEf2qqTGhm1Fofo2PixOZf1iDSh5Ck+7TPIACc5wUhmjrukFuihdo3UP1tBZ/I/9kQb2qH3ANzCHGWJGWP4edAw7SN35Lp8JyDYSPxtdzev0xyTxfBTopTa9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cFZRH1239zKHN4l;
	Mon,  1 Sep 2025 11:41:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id EDA941A1AF4;
	Mon,  1 Sep 2025 11:41:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAncIzWFbVotmf1Aw--.38057S6;
	Mon, 01 Sep 2025 11:41:14 +0800 (CST)
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
Subject: [PATCH RFC v3 02/15] block: add QUEUE_FLAG_BIO_ISSUE
Date: Mon,  1 Sep 2025 11:32:07 +0800
Message-Id: <20250901033220.42982-3-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAncIzWFbVotmf1Aw--.38057S6
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1Dur1kGF15urWDJr1kZrb_yoW5Jw1Dp3
	98WFn7G342gr4DXF18K3WDZw18Gw4v9ry3C34Ykr45Ar4xWr1xXF1vvF4DtFykursrArW5
	Xr18Kr95K345W3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjTRRCJPDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

blkcg_bio_issue_init() is called for every bio, while initialized
bio_issue_time is only used by io-latency. Add a new queue_flag and
only set this flag when io-latency is initialized, so that extra
blk_time_get_ns() from blkcg_bio_issue_init() can be saved for disks
that io-latency is not enabled.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-cgroup.h     | 5 ++++-
 block/blk-iolatency.c  | 1 +
 block/blk-mq-debugfs.c | 1 +
 include/linux/blkdev.h | 1 +
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index d73204d27d72..93e8a9fa76fe 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -372,7 +372,10 @@ static inline void blkg_put(struct blkcg_gq *blkg)
 
 static inline void blkcg_bio_issue_init(struct bio *bio)
 {
-	bio->issue_time_ns = blk_time_get_ns();
+	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
+
+	if (test_bit(QUEUE_FLAG_BIO_ISSUE, &q->queue_flags))
+		bio->issue_time_ns = blk_time_get_ns();
 }
 
 static inline void blkcg_use_delay(struct blkcg_gq *blkg)
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 554b191a6892..c9b3bd12c87c 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -767,6 +767,7 @@ static int blk_iolatency_init(struct gendisk *disk)
 	if (ret)
 		goto err_qos_del;
 
+	blk_queue_flag_set(QUEUE_FLAG_BIO_ISSUE, disk->queue);
 	timer_setup(&blkiolat->timer, blkiolatency_timer_fn, 0);
 	INIT_WORK(&blkiolat->enable_work, blkiolatency_enable_work_fn);
 
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 32c65efdda46..b192647456e1 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -96,6 +96,7 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(DISABLE_WBT_DEF),
 	QUEUE_FLAG_NAME(NO_ELV_SWITCH),
 	QUEUE_FLAG_NAME(QOS_ENABLED),
+	QUEUE_FLAG_NAME(BIO_ISSUE),
 };
 #undef QUEUE_FLAG_NAME
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index fe1797bbec42..ca1dcf59cb32 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -657,6 +657,7 @@ enum {
 	QUEUE_FLAG_DISABLE_WBT_DEF,	/* for sched to disable/enable wbt */
 	QUEUE_FLAG_NO_ELV_SWITCH,	/* can't switch elevator any more */
 	QUEUE_FLAG_QOS_ENABLED,		/* qos is enabled */
+	QUEUE_FLAG_BIO_ISSUE,		/* track bio issue time */
 	QUEUE_FLAG_MAX
 };
 
-- 
2.39.2



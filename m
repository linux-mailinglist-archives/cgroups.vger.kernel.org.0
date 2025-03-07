Return-Path: <cgroups+bounces-6884-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 647D7A56339
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 10:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36AC43B2250
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 09:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81C31DE2CC;
	Fri,  7 Mar 2025 09:06:38 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A117199E94;
	Fri,  7 Mar 2025 09:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741338398; cv=none; b=Ad8SnuB66UBXgRNyYGbcSgD2ffyVhwVHuEQ1iNpni7UWGp8+FGOSJrpxGEPx4BJmqJNhG46IV4SveobgtC8o/W8ZbnopACg5aXf+w+u9dIKlUOYo6F8sC3ST15Se3qtJy/aPUTHpecN9BMpXFBSZkMjreban4i6CwXU4fqGyVn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741338398; c=relaxed/simple;
	bh=HGOVik4p9v3ak8rxb1sEyoauH9teQ1vQw9f36MUssQM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HyR48n+klyxFkwlEIWzDR/LuZfSFzJ4/VOo6iLTg9jWOV7cKadgsE8Ape6J8hyJfM/9br2Ia8JeDAB/DJ9Ooi0NyrjwI2AaB+eJUKLr7ZDmF476tDezPCZXrhixt/L+uWKyzZ/X6PV2kV1qbF4G30lXRuXUoH+oc/9yqvxgD5N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Z8L4H3YMtz4f3jXP;
	Fri,  7 Mar 2025 17:06:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AA2451A0ACF;
	Fri,  7 Mar 2025 17:06:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAni18St8pnW0QrFw--.36042S4;
	Fri, 07 Mar 2025 17:06:28 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: ming.lei@redhat.com,
	axboe@kernel.dk,
	tj@kernel.org,
	josef@toxicpanda.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH] blk-throttle: support io merge over iops_limit
Date: Fri,  7 Mar 2025 17:01:52 +0800
Message-Id: <20250307090152.4095551-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAni18St8pnW0QrFw--.36042S4
X-Coremail-Antispam: 1UD129KBjvJXoW3AFy3WF15XF48KF4xAFy8Grg_yoWxWw18pF
	WjyF4UAws7XF4vgFZ8J3WfJFWFqwsrA343G3y5Gw4fAFnIgrn5tF1kZryFvFW0vFZ3uFZ7
	AF1IgwnrGF48trJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Commit 9f5ede3c01f9 ("block: throttle split bio in case of iops limit")
support to account split IO for iops limit, because block layer provides
io accounting against split bio.

However, io merge is still not handled, while block layer doesn't
account merged io for iops. Fix this problem by decreasing io_disp
if bio is merged, and following IO can use the extra budget. If io merge
concurrent with iops throttling, it's not handled if one more or one
less bio is dispatched, this is fine because as long as new slice is not
started, blk-throttle already preserve one extra slice for deviation,
and it's not worth it to handle the case that iops_limit rate is less than
one per slice.

A regression test will be added for this case [1], before this patch,
the test will fail:

+++ /root/blktests-mainline/results/nodev/throtl/007.out.bad
@@ -1,4 +1,4 @@
 Running throtl/007
 1
-1
+11
 Test complete

[1] https://lore.kernel.org/all/20250307080318.3860858-2-yukuai1@huaweicloud.com/

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-merge.c    |  3 +++
 block/blk-throttle.c | 20 ++++++++++----------
 block/blk-throttle.h | 19 +++++++++++++++++--
 3 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 15cd231d560c..8dc7add7c31e 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -988,6 +988,7 @@ enum bio_merge_status bio_attempt_back_merge(struct request *req,
 
 	trace_block_bio_backmerge(bio);
 	rq_qos_merge(req->q, req, bio);
+	blk_throtl_bio_merge(req->q, bio);
 
 	if ((req->cmd_flags & REQ_FAILFAST_MASK) != ff)
 		blk_rq_set_mixed_merge(req);
@@ -1025,6 +1026,7 @@ static enum bio_merge_status bio_attempt_front_merge(struct request *req,
 
 	trace_block_bio_frontmerge(bio);
 	rq_qos_merge(req->q, req, bio);
+	blk_throtl_bio_merge(req->q, bio);
 
 	if ((req->cmd_flags & REQ_FAILFAST_MASK) != ff)
 		blk_rq_set_mixed_merge(req);
@@ -1055,6 +1057,7 @@ static enum bio_merge_status bio_attempt_discard_merge(struct request_queue *q,
 		goto no_merge;
 
 	rq_qos_merge(q, req, bio);
+	blk_throtl_bio_merge(q, bio);
 
 	req->biotail->bi_next = bio;
 	req->biotail = bio;
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 91dab43c65ab..9fd613c79caa 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -477,7 +477,7 @@ static inline void throtl_start_new_slice_with_credit(struct throtl_grp *tg,
 		bool rw, unsigned long start)
 {
 	tg->bytes_disp[rw] = 0;
-	tg->io_disp[rw] = 0;
+	atomic_set(&tg->io_disp[rw], 0);
 
 	/*
 	 * Previous slice has expired. We must have trimmed it after last
@@ -500,7 +500,7 @@ static inline void throtl_start_new_slice(struct throtl_grp *tg, bool rw,
 {
 	if (clear) {
 		tg->bytes_disp[rw] = 0;
-		tg->io_disp[rw] = 0;
+		atomic_set(&tg->io_disp[rw], 0);
 	}
 	tg->slice_start[rw] = jiffies;
 	tg->slice_end[rw] = jiffies + tg->td->throtl_slice;
@@ -623,10 +623,10 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
 	else
 		tg->bytes_disp[rw] = 0;
 
-	if ((int)tg->io_disp[rw] >= io_trim)
-		tg->io_disp[rw] -= io_trim;
+	if (atomic_read(&tg->io_disp[rw]) >= io_trim)
+		atomic_sub(io_trim, &tg->io_disp[rw]);
 	else
-		tg->io_disp[rw] = 0;
+		atomic_set(&tg->io_disp[rw], 0);
 
 	tg->slice_start[rw] += time_elapsed;
 
@@ -655,9 +655,9 @@ static void __tg_update_carryover(struct throtl_grp *tg, bool rw,
 			tg->bytes_disp[rw];
 	if (iops_limit != UINT_MAX)
 		*ios = calculate_io_allowed(iops_limit, jiffy_elapsed) -
-			tg->io_disp[rw];
+			atomic_read(&tg->io_disp[rw]);
 	tg->bytes_disp[rw] -= *bytes;
-	tg->io_disp[rw] -= *ios;
+	atomic_sub(*ios, &tg->io_disp[rw]);
 }
 
 static void tg_update_carryover(struct throtl_grp *tg)
@@ -691,7 +691,7 @@ static unsigned long tg_within_iops_limit(struct throtl_grp *tg, struct bio *bio
 	/* Round up to the next throttle slice, wait time must be nonzero */
 	jiffy_elapsed_rnd = roundup(jiffy_elapsed + 1, tg->td->throtl_slice);
 	io_allowed = calculate_io_allowed(iops_limit, jiffy_elapsed_rnd);
-	if (io_allowed > 0 && tg->io_disp[rw] + 1 <= io_allowed)
+	if (io_allowed > 0 && atomic_read(&tg->io_disp[rw]) + 1 <= io_allowed)
 		return 0;
 
 	/* Calc approx time to dispatch */
@@ -815,7 +815,7 @@ static void throtl_charge_bio(struct throtl_grp *tg, struct bio *bio)
 	if (!bio_flagged(bio, BIO_BPS_THROTTLED))
 		tg->bytes_disp[rw] += bio_size;
 
-	tg->io_disp[rw]++;
+	atomic_inc(&tg->io_disp[rw]);
 }
 
 /**
@@ -1679,7 +1679,7 @@ bool __blk_throtl_bio(struct bio *bio)
 		   rw == READ ? 'R' : 'W',
 		   tg->bytes_disp[rw], bio->bi_iter.bi_size,
 		   tg_bps_limit(tg, rw),
-		   tg->io_disp[rw], tg_iops_limit(tg, rw),
+		   atomic_read(&tg->io_disp[rw]), tg_iops_limit(tg, rw),
 		   sq->nr_queued[READ], sq->nr_queued[WRITE]);
 
 	td->nr_queued[rw]++;
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index 7964cc041e06..7e5f50c6bb19 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -104,7 +104,7 @@ struct throtl_grp {
 	/* Number of bytes dispatched in current slice */
 	int64_t bytes_disp[2];
 	/* Number of bio's dispatched in current slice */
-	int io_disp[2];
+	atomic_t io_disp[2];
 
 	/*
 	 * The following two fields are updated when new configuration is
@@ -144,6 +144,8 @@ static inline struct throtl_grp *blkg_to_tg(struct blkcg_gq *blkg)
 static inline void blk_throtl_exit(struct gendisk *disk) { }
 static inline bool blk_throtl_bio(struct bio *bio) { return false; }
 static inline void blk_throtl_cancel_bios(struct gendisk *disk) { }
+static inline void blk_throtl_bio_merge(struct request_queue *q,
+					struct bio *bio) { }
 #else /* CONFIG_BLK_DEV_THROTTLING */
 void blk_throtl_exit(struct gendisk *disk);
 bool __blk_throtl_bio(struct bio *bio);
@@ -189,12 +191,25 @@ static inline bool blk_should_throtl(struct bio *bio)
 
 static inline bool blk_throtl_bio(struct bio *bio)
 {
-
 	if (!blk_should_throtl(bio))
 		return false;
 
 	return __blk_throtl_bio(bio);
 }
+
+static inline void blk_throtl_bio_merge(struct request_queue *q,
+					struct bio *bio)
+{
+	struct throtl_grp *tg;
+	int rw = bio_data_dir(bio);
+
+	if (!blk_throtl_activated(bio->bi_bdev->bd_queue))
+		return;
+
+	tg = blkg_to_tg(bio->bi_blkg);
+	if (tg->has_rules_iops[rw])
+		atomic_dec(&tg->io_disp[rw]);
+}
 #endif /* CONFIG_BLK_DEV_THROTTLING */
 
 #endif
-- 
2.39.2



Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1301D59CF5A
	for <lists+cgroups@lfdr.de>; Tue, 23 Aug 2022 05:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239956AbiHWDUJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Aug 2022 23:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239941AbiHWDUH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 22 Aug 2022 23:20:07 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E674DB66;
        Mon, 22 Aug 2022 20:20:05 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MBZFH2NQHzlkb5;
        Tue, 23 Aug 2022 11:18:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP1 (Coremail) with SMTP id cCh0CgDXkO1fRwRj66O+Ag--.4888S5;
        Tue, 23 Aug 2022 11:20:03 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     axboe@kernel.dk, tj@kernel.org, ming.lei@redhat.com,
        mkoutny@suse.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH v8 1/4] blk-throttle: fix that io throttle can only work for single bio
Date:   Tue, 23 Aug 2022 11:31:27 +0800
Message-Id: <20220823033130.874230-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220823033130.874230-1-yukuai1@huaweicloud.com>
References: <20220823033130.874230-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDXkO1fRwRj66O+Ag--.4888S5
X-Coremail-Antispam: 1UD129KBjvJXoWxtFW8Xry3tFW8Zr4ktF15CFg_yoW3Zw4UpF
        yxuFWkWr4kGrsFgr1DJF1I9Fy8JF48Ary5ArZxGw4SvF1akrnrtFn7Zr10yFyY9FZxCayD
        ZF1vk3srCa1UGrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
        xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUqAp5UUUUU
        =
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Test scripts:
cd /sys/fs/cgroup/blkio/
echo "8:0 1024" > blkio.throttle.write_bps_device
echo $$ > cgroup.procs
dd if=/dev/zero of=/dev/sda bs=10k count=1 oflag=direct &
dd if=/dev/zero of=/dev/sda bs=10k count=1 oflag=direct &

Test result:
10240 bytes (10 kB, 10 KiB) copied, 10.0134 s, 1.0 kB/s
10240 bytes (10 kB, 10 KiB) copied, 10.0135 s, 1.0 kB/s

The problem is that the second bio is finished after 10s instead of 20s.

Root cause:
1) second bio will be flagged:

__blk_throtl_bio
 while (true) {
  ...
  if (sq->nr_queued[rw]) -> some bio is throttled already
   break
 };
 bio_set_flag(bio, BIO_THROTTLED); -> flag the bio

2) flagged bio will be dispatched without waiting:

throtl_dispatch_tg
 tg_may_dispatch
  tg_with_in_bps_limit
   if (bps_limit == U64_MAX || bio_flagged(bio, BIO_THROTTLED))
    *wait = 0; -> wait time is zero
    return true;

commit 9f5ede3c01f9 ("block: throttle split bio in case of iops limit")
support to count split bios for iops limit, thus it adds flagged bio
checking in tg_with_in_bps_limit() so that split bios will only count
once for bps limit, however, it introduce a new problem that io throttle
won't work if multiple bios are throttled.

In order to fix the problem, two flags BIO_IOPS/BPS_THROTTLED is used,
thus iops and bps can be treated separately for split bio:

1) for bps limit, original bio already flagged, nothing need to be done.
2) for iops limit, original bio already flagged, and the flag should be
   cleared before resubmitting the original bio.

Noted this patch also remove the code to set flag in __bio_clone(), it's
introduced in commit 111be8839817 ("block-throttle: avoid double
charge"), and author thinks split bio can be resubmited and throttled
again, which is wrong because split bio will continue to dispatch from
caller.

Fixes: 9f5ede3c01f9 ("block: throttle split bio in case of iops limit")
Cc: <stable@vger.kernel.org>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bio.c               |  2 --
 block/blk-merge.c         |  7 +++++++
 block/blk-throttle.c      | 23 +++++++++++++----------
 block/blk-throttle.h      |  6 +++---
 include/linux/bio.h       |  6 ++++--
 include/linux/blk_types.h |  6 ++++--
 6 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 3d3a2678fea2..77e3b764a078 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -760,8 +760,6 @@ EXPORT_SYMBOL(bio_put);
 static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
 {
 	bio_set_flag(bio, BIO_CLONED);
-	if (bio_flagged(bio_src, BIO_THROTTLED))
-		bio_set_flag(bio, BIO_THROTTLED);
 	bio->bi_ioprio = bio_src->bi_ioprio;
 	bio->bi_iter = bio_src->bi_iter;
 
diff --git a/block/blk-merge.c b/block/blk-merge.c
index ff04e9290715..10330bb038ca 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -358,6 +358,13 @@ struct bio *__bio_split_to_limits(struct bio *bio, struct queue_limits *lim,
 		blkcg_bio_issue_init(split);
 		bio_chain(split, bio);
 		trace_block_split(split, bio->bi_iter.bi_sector);
+
+		/*
+		 * original bio will be resubmited and throttled again, clear
+		 * the iops flag so that it can be count again for iops limit.
+		 */
+		if (bio_flagged(bio, BIO_IOPS_THROTTLED))
+			bio_clear_flag(bio, BIO_IOPS_THROTTLED);
 		submit_bio_noacct(bio);
 		return split;
 	}
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index e47506a8ef47..f3c9dcab63e2 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -762,7 +762,7 @@ static bool tg_with_in_iops_limit(struct throtl_grp *tg, struct bio *bio,
 	unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
 	u64 tmp;
 
-	if (iops_limit == UINT_MAX) {
+	if (iops_limit == UINT_MAX || bio_flagged(bio, BIO_IOPS_THROTTLED)) {
 		if (wait)
 			*wait = 0;
 		return true;
@@ -811,7 +811,7 @@ static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
 	unsigned int bio_size = throtl_bio_data_size(bio);
 
 	/* no need to throttle if this bio's bytes have been accounted */
-	if (bps_limit == U64_MAX || bio_flagged(bio, BIO_THROTTLED)) {
+	if (bps_limit == U64_MAX || bio_flagged(bio, BIO_BPS_THROTTLED)) {
 		if (wait)
 			*wait = 0;
 		return true;
@@ -921,13 +921,11 @@ static void throtl_charge_bio(struct throtl_grp *tg, struct bio *bio)
 	unsigned int bio_size = throtl_bio_data_size(bio);
 
 	/* Charge the bio to the group */
-	if (!bio_flagged(bio, BIO_THROTTLED)) {
+	if (!bio_flagged(bio, BIO_BPS_THROTTLED)) {
 		tg->bytes_disp[rw] += bio_size;
 		tg->last_bytes_disp[rw] += bio_size;
 	}
 
-	tg->io_disp[rw]++;
-	tg->last_io_disp[rw]++;
 
 	/*
 	 * BIO_THROTTLED is used to prevent the same bio to be throttled
@@ -935,8 +933,10 @@ static void throtl_charge_bio(struct throtl_grp *tg, struct bio *bio)
 	 * second time when it eventually gets issued.  Set it when a bio
 	 * is being charged to a tg.
 	 */
-	if (!bio_flagged(bio, BIO_THROTTLED))
-		bio_set_flag(bio, BIO_THROTTLED);
+	if (!bio_flagged(bio, BIO_IOPS_THROTTLED)) {
+		tg->io_disp[rw]++;
+		tg->last_io_disp[rw]++;
+	}
 }
 
 /**
@@ -1026,6 +1026,8 @@ static void tg_dispatch_one_bio(struct throtl_grp *tg, bool rw)
 	sq->nr_queued[rw]--;
 
 	throtl_charge_bio(tg, bio);
+	bio_set_flag(bio, BIO_BPS_THROTTLED);
+	bio_set_flag(bio, BIO_IOPS_THROTTLED);
 
 	/*
 	 * If our parent is another tg, we just need to transfer @bio to
@@ -2159,8 +2161,11 @@ bool __blk_throtl_bio(struct bio *bio)
 		qn = &tg->qnode_on_parent[rw];
 		sq = sq->parent_sq;
 		tg = sq_to_tg(sq);
-		if (!tg)
+		if (!tg) {
+			bio_set_flag(bio, BIO_BPS_THROTTLED);
+			bio_set_flag(bio, BIO_IOPS_THROTTLED);
 			goto out_unlock;
+		}
 	}
 
 	/* out-of-limit, queue to @tg */
@@ -2189,8 +2194,6 @@ bool __blk_throtl_bio(struct bio *bio)
 	}
 
 out_unlock:
-	bio_set_flag(bio, BIO_THROTTLED);
-
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 	if (throttled || !td->track_bio_latency)
 		bio->bi_issue.value |= BIO_ISSUE_THROTL_SKIP_LATENCY;
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index c1b602996127..45c6f3c1dfe0 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -174,9 +174,9 @@ static inline bool blk_throtl_bio(struct bio *bio)
 {
 	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
 
-	/* no need to throttle bps any more if the bio has been throttled */
-	if (bio_flagged(bio, BIO_THROTTLED) &&
-	    !(tg->flags & THROTL_TG_HAS_IOPS_LIMIT))
+	/* no need to throttle any more if the bio has been throttled */
+	if (bio_flagged(bio, BIO_BPS_THROTTLED) &&
+	    bio_flagged(bio, BIO_IOPS_THROTTLED))
 		return false;
 
 	if (!tg->has_rules[bio_data_dir(bio)])
diff --git a/include/linux/bio.h b/include/linux/bio.h
index ca22b06700a9..8ab014af163d 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -508,8 +508,10 @@ static inline void bio_clone_blkg_association(struct bio *dst,
 static inline void bio_set_dev(struct bio *bio, struct block_device *bdev)
 {
 	bio_clear_flag(bio, BIO_REMAPPED);
-	if (bio->bi_bdev != bdev)
-		bio_clear_flag(bio, BIO_THROTTLED);
+	if (bio->bi_bdev != bdev) {
+		bio_clear_flag(bio, BIO_BPS_THROTTLED);
+		bio_clear_flag(bio, BIO_IOPS_THROTTLED);
+	}
 	bio->bi_bdev = bdev;
 	bio_associate_blkg(bio);
 }
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 1ef99790f6ed..d37cdafa2a07 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -325,8 +325,10 @@ enum {
 	BIO_QUIET,		/* Make BIO Quiet */
 	BIO_CHAIN,		/* chained bio, ->bi_remaining in effect */
 	BIO_REFFED,		/* bio has elevated ->bi_cnt */
-	BIO_THROTTLED,		/* This bio has already been subjected to
-				 * throttling rules. Don't do it again. */
+	BIO_BPS_THROTTLED,	/* This bio has already been subjected to
+				 * bps throttling rules. Don't do it again. */
+	BIO_IOPS_THROTTLED,	/* This bio has already been subjected to
+				 * iops throttling rules. Don't do it again. */
 	BIO_TRACE_COMPLETION,	/* bio_endio() should trace the final completion
 				 * of this bio. */
 	BIO_CGROUP_ACCT,	/* has been accounted to a cgroup */
-- 
2.31.1


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8485A40E8
	for <lists+cgroups@lfdr.de>; Mon, 29 Aug 2022 04:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiH2CL2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 28 Aug 2022 22:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiH2CL0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 28 Aug 2022 22:11:26 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14F63AE78;
        Sun, 28 Aug 2022 19:11:23 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MGDQt2gV6zKFkP;
        Mon, 29 Aug 2022 10:09:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP2 (Coremail) with SMTP id Syh0CgAnenNFIAxjqVZKAA--.51100S5;
        Mon, 29 Aug 2022 10:11:21 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     axboe@kernel.dk, tj@kernel.org, mkoutny@suse.com,
        ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH v9 1/4] blk-throttle: fix that io throttle can only work for single bio
Date:   Mon, 29 Aug 2022 10:22:37 +0800
Message-Id: <20220829022240.3348319-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220829022240.3348319-1-yukuai1@huaweicloud.com>
References: <20220829022240.3348319-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAnenNFIAxjqVZKAA--.51100S5
X-Coremail-Antispam: 1UD129KBjvJXoWxtFW8Xry3tw4xZr1rXr45trb_yoWxXr13pF
        yxuFWkGr4DGr4qgr1DKF129FW8J3yUCry5ArW3GF4SvF1akrnrtrn7ur18ArWY9FZIka9r
        ZFn5KrWfCayUJ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
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

In order to fix the problem, handle iops/bps limit in different ways:

1) for iops limit, there is no flag to record if the bio is throttled,
   and iops is always applied.
2) for bps limit, original bio will be flagged with BIO_BPS_THROTTLED,
   and io throttle will ignore bio with the flag.

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
 block/blk-throttle.c      | 20 ++++++--------------
 block/blk-throttle.h      |  2 +-
 include/linux/bio.h       |  2 +-
 include/linux/blk_types.h |  2 +-
 5 files changed, 9 insertions(+), 19 deletions(-)

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
 
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 47142a1dd102..7a4c815e0f23 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -814,7 +814,7 @@ static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
 	unsigned int bio_size = throtl_bio_data_size(bio);
 
 	/* no need to throttle if this bio's bytes have been accounted */
-	if (bps_limit == U64_MAX || bio_flagged(bio, BIO_THROTTLED)) {
+	if (bps_limit == U64_MAX || bio_flagged(bio, BIO_BPS_THROTTLED)) {
 		if (wait)
 			*wait = 0;
 		return true;
@@ -924,22 +924,13 @@ static void throtl_charge_bio(struct throtl_grp *tg, struct bio *bio)
 	unsigned int bio_size = throtl_bio_data_size(bio);
 
 	/* Charge the bio to the group */
-	if (!bio_flagged(bio, BIO_THROTTLED)) {
+	if (!bio_flagged(bio, BIO_BPS_THROTTLED)) {
 		tg->bytes_disp[rw] += bio_size;
 		tg->last_bytes_disp[rw] += bio_size;
 	}
 
 	tg->io_disp[rw]++;
 	tg->last_io_disp[rw]++;
-
-	/*
-	 * BIO_THROTTLED is used to prevent the same bio to be throttled
-	 * more than once as a throttled bio will go through blk-throtl the
-	 * second time when it eventually gets issued.  Set it when a bio
-	 * is being charged to a tg.
-	 */
-	if (!bio_flagged(bio, BIO_THROTTLED))
-		bio_set_flag(bio, BIO_THROTTLED);
 }
 
 /**
@@ -1029,6 +1020,7 @@ static void tg_dispatch_one_bio(struct throtl_grp *tg, bool rw)
 	sq->nr_queued[rw]--;
 
 	throtl_charge_bio(tg, bio);
+	bio_set_flag(bio, BIO_BPS_THROTTLED);
 
 	/*
 	 * If our parent is another tg, we just need to transfer @bio to
@@ -2162,8 +2154,10 @@ bool __blk_throtl_bio(struct bio *bio)
 		qn = &tg->qnode_on_parent[rw];
 		sq = sq->parent_sq;
 		tg = sq_to_tg(sq);
-		if (!tg)
+		if (!tg) {
+			bio_set_flag(bio, BIO_BPS_THROTTLED);
 			goto out_unlock;
+		}
 	}
 
 	/* out-of-limit, queue to @tg */
@@ -2192,8 +2186,6 @@ bool __blk_throtl_bio(struct bio *bio)
 	}
 
 out_unlock:
-	bio_set_flag(bio, BIO_THROTTLED);
-
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 	if (throttled || !td->track_bio_latency)
 		bio->bi_issue.value |= BIO_ISSUE_THROTL_SKIP_LATENCY;
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index c1b602996127..ee7299e6dea9 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -175,7 +175,7 @@ static inline bool blk_throtl_bio(struct bio *bio)
 	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
 
 	/* no need to throttle bps any more if the bio has been throttled */
-	if (bio_flagged(bio, BIO_THROTTLED) &&
+	if (bio_flagged(bio, BIO_BPS_THROTTLED) &&
 	    !(tg->flags & THROTL_TG_HAS_IOPS_LIMIT))
 		return false;
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index ca22b06700a9..2c5806997bbf 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -509,7 +509,7 @@ static inline void bio_set_dev(struct bio *bio, struct block_device *bdev)
 {
 	bio_clear_flag(bio, BIO_REMAPPED);
 	if (bio->bi_bdev != bdev)
-		bio_clear_flag(bio, BIO_THROTTLED);
+		bio_clear_flag(bio, BIO_BPS_THROTTLED);
 	bio->bi_bdev = bdev;
 	bio_associate_blkg(bio);
 }
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 1ef99790f6ed..41afb4cfb9b0 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -325,7 +325,7 @@ enum {
 	BIO_QUIET,		/* Make BIO Quiet */
 	BIO_CHAIN,		/* chained bio, ->bi_remaining in effect */
 	BIO_REFFED,		/* bio has elevated ->bi_cnt */
-	BIO_THROTTLED,		/* This bio has already been subjected to
+	BIO_BPS_THROTTLED,	/* This bio has already been subjected to
 				 * throttling rules. Don't do it again. */
 	BIO_TRACE_COMPLETION,	/* bio_endio() should trace the final completion
 				 * of this bio. */
-- 
2.31.1


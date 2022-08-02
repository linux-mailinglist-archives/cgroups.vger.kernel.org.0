Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85696587D84
	for <lists+cgroups@lfdr.de>; Tue,  2 Aug 2022 15:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236953AbiHBNwm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 2 Aug 2022 09:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236730AbiHBNwe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 2 Aug 2022 09:52:34 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB0525C61;
        Tue,  2 Aug 2022 06:52:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4LxxGd3rLJz6R5Mt;
        Tue,  2 Aug 2022 21:51:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgDXLsMQLOlivtl0AA--.20757S5;
        Tue, 02 Aug 2022 21:52:21 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, mkoutny@suse.com, axboe@kernel.dk,
        ming.lei@redhat.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH v7 1/9] blk-throttle: fix that io throttle can only work for single bio
Date:   Tue,  2 Aug 2022 22:04:07 +0800
Message-Id: <20220802140415.2960284-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220802140415.2960284-1-yukuai1@huaweicloud.com>
References: <20220802140415.2960284-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDXLsMQLOlivtl0AA--.20757S5
X-Coremail-Antispam: 1UD129KBjvJXoWxXF45Ww1DJw1UCF1kZry8uFg_yoW5Kw47pF
        WxGFZ8Wr4kWrsrtrs8JF1IvFWrt3yrAr98Gay3Ga13Ars0grn0grn7urWF93y3uF9xuayv
        vrn2gr97Ca1UGrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
1) second bio will be flaged:

__blk_throtl_bio
 while (true) {
  ...
  if (sq->nr_queued[rw]) -> some bio is throttled already
   break
 };
 bio_set_flag(bio, BIO_THROTTLED); -> flag the bio

2) flaged bio will be dispatched without waiting:

throtl_dispatch_tg
 tg_may_dispatch
  tg_with_in_bps_limit
   if (bps_limit == U64_MAX || bio_flagged(bio, BIO_THROTTLED))
    *wait = 0; -> wait time is zero
    return true;

commit 9f5ede3c01f9 ("block: throttle split bio in case of iops limit")
support to count splited bios for iops limit, thus it adds flaged bio
checking in tg_with_in_bps_limit() so that splited bios will only count
once for bps limit, however, it introduce a new problem that io throttle
won't work if multiple bios are throttled.

In order to fix the problem, at first, don't skip flaged bio in
tg_with_in_bps_limit(), however, this will break that splited bios should
only count once for bps limit. And this patch tries to avoid
over-accounting by decrementing it first in __blk_throtl_bio(), and
then counting it again while dispatching it.

Fixes: 9f5ede3c01f9 ("block: throttle split bio in case of iops limit")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-throttle.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 9f5fe62afff9..2957e2c643f4 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -811,7 +811,7 @@ static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
 	unsigned int bio_size = throtl_bio_data_size(bio);
 
 	/* no need to throttle if this bio's bytes have been accounted */
-	if (bps_limit == U64_MAX || bio_flagged(bio, BIO_THROTTLED)) {
+	if (bps_limit == U64_MAX) {
 		if (wait)
 			*wait = 0;
 		return true;
@@ -921,11 +921,8 @@ static void throtl_charge_bio(struct throtl_grp *tg, struct bio *bio)
 	unsigned int bio_size = throtl_bio_data_size(bio);
 
 	/* Charge the bio to the group */
-	if (!bio_flagged(bio, BIO_THROTTLED)) {
-		tg->bytes_disp[rw] += bio_size;
-		tg->last_bytes_disp[rw] += bio_size;
-	}
-
+	tg->bytes_disp[rw] += bio_size;
+	tg->last_bytes_disp[rw] += bio_size;
 	tg->io_disp[rw]++;
 	tg->last_io_disp[rw]++;
 
@@ -2121,6 +2118,23 @@ bool __blk_throtl_bio(struct bio *bio)
 			tg->last_low_overflow_time[rw] = jiffies;
 		throtl_downgrade_check(tg);
 		throtl_upgrade_check(tg);
+
+		/*
+		 * Splited bios can be re-entered because iops limit should be
+		 * counted again, however, bps limit should not. Since bps limit
+		 * will be counted again while dispatching it, compensate the
+		 * over-accounting here. Noted that compensation can fail if
+		 * new slice is started.
+		 */
+		if (bio_flagged(bio, BIO_THROTTLED)) {
+			unsigned int bio_size = throtl_bio_data_size(bio);
+
+			if (tg->bytes_disp[rw] >= bio_size)
+				tg->bytes_disp[rw] -= bio_size;
+			if (tg->last_bytes_disp[rw] >= bio_size)
+				tg->last_bytes_disp[rw] -= bio_size;
+		}
+
 		/* throtl is FIFO - if bios are already queued, should queue */
 		if (sq->nr_queued[rw])
 			break;
-- 
2.31.1


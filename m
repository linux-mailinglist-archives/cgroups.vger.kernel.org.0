Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1B8562FC5
	for <lists+cgroups@lfdr.de>; Fri,  1 Jul 2022 11:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbiGAJWF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 1 Jul 2022 05:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbiGAJWD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 1 Jul 2022 05:22:03 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB01958FE2;
        Fri,  1 Jul 2022 02:22:00 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4LZ8p46fM3zlC0g;
        Fri,  1 Jul 2022 17:21:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgB32mm1vL5i6ab6AA--.40529S5;
        Fri, 01 Jul 2022 17:21:58 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, mkoutny@suse.com, axboe@kernel.dk,
        ming.lei@redhat.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH RESEND v6 1/8] blk-throttle: fix that io throttle can only work for single bio
Date:   Fri,  1 Jul 2022 17:34:34 +0800
Message-Id: <20220701093441.885741-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220701093441.885741-1-yukuai1@huaweicloud.com>
References: <20220701093441.885741-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgB32mm1vL5i6ab6AA--.40529S5
X-Coremail-Antispam: 1UD129KBjvJXoWxury3tryUAw1fZF4xAry7Jrb_yoW5Aw13pF
        yxCFZ8Ww4kWrsrKrs5JF1SgFyrtw4rJr98G3y3G3W3Aws8Wrn0gry7urWFkayruF93ua4q
        vr1qgr9rGF1UGFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPj14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWUJVWUGwAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
        xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU58nYUUUU
        U
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

commit 9f5ede3c01f9 ("block: throttle split bio in case of iops limit")
introduce a new problem, for example:

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
This is because if some bios are already queued, current bio is queued
directly and the flag 'BIO_THROTTLED' is set. And later, when former
bios are dispatched, this bio will be dispatched without waiting at all,
this is due to tg_with_in_bps_limit() return 0 for this bio.

In order to fix the problem, don't skip flaged bio in
tg_with_in_bps_limit(), and for the problem that split bio can be
double accounted, compensate the over-accounting in __blk_throtl_bio().

Fixes: 9f5ede3c01f9 ("block: throttle split bio in case of iops limit")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-throttle.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 139b2d7a99e2..5c1d1c4d8188 100644
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
 
@@ -2121,6 +2118,21 @@ bool __blk_throtl_bio(struct bio *bio)
 			tg->last_low_overflow_time[rw] = jiffies;
 		throtl_downgrade_check(tg);
 		throtl_upgrade_check(tg);
+
+		/*
+		 * re-entered bio has accounted bytes already, so try to
+		 * compensate previous over-accounting. However, if new
+		 * slice is started, just forget it.
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


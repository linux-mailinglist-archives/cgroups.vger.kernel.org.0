Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCEF562D20
	for <lists+cgroups@lfdr.de>; Fri,  1 Jul 2022 09:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbiGAHzR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 1 Jul 2022 03:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235578AbiGAHzP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 1 Jul 2022 03:55:15 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6126D573;
        Fri,  1 Jul 2022 00:55:12 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4LZ6SW3YxGz6R4XJ;
        Fri,  1 Jul 2022 15:35:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgAXFWgIpL5igL73AA--.48972S9;
        Fri, 01 Jul 2022 15:36:44 +0800 (CST)
From:   Yu Kuai <yukuai3@huawei.com>
To:     tj@kernel.org, mkoutny@suse.com, axboe@kernel.dk,
        ming.lei@redhat.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH v6 4/8] blk-throttle: fix io hung due to config updates
Date:   Fri,  1 Jul 2022 15:49:19 +0800
Message-Id: <20220701074923.657426-6-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220701074923.657426-1-yukuai3@huawei.com>
References: <20220701074923.657426-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgAXFWgIpL5igL73AA--.48972S9
X-Coremail-Antispam: 1UD129KBjvJXoW3AFy8Ary3tw1kKF45GryDJrb_yoWxuF1kpr
        WrCw4Yqa1UX3Z3KFZxXrnIkFWFqws7ZFy3J3y3Ga1Fka15Gr1ktFn8ZrW5tayxCF97uayI
        vrnFqF9IkF4jvrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUQ2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1j6r18M7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7Iv64x0x7Aq67IIx4CEVc8vx2IErcIFxwACI4
        02YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCF04k20xvEw4C26cxK6c8Ij28I
        cwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8V
        AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
        14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFE_MUUUUU
Sender: yukuai1@huaweicloud.com
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

If new configuration is submitted while a bio is throttled, then new
waiting time is recalculated regardless that the bio might aready wait
for some time:

tg_conf_updated
 throtl_start_new_slice
  tg_update_disptime
  throtl_schedule_next_dispatch

Then io hung can be triggered by always submmiting new configuration
before the throttled bio is dispatched.

Fix the problem by respecting the time that throttled bio aready waited.
In order to do that, add new fields to record how many bytes/io already
waited, and use it to calculate wait time for throttled bio under new
configuration.

Some simple test:
1)
cd /sys/fs/cgroup/blkio/
echo $$ > cgroup.procs
echo "8:0 2048" > blkio.throttle.write_bps_device
{
        sleep 2
        echo "8:0 1024" > blkio.throttle.write_bps_device
} &
dd if=/dev/zero of=/dev/sda bs=8k count=1 oflag=direct

2)
cd /sys/fs/cgroup/blkio/
echo $$ > cgroup.procs
echo "8:0 1024" > blkio.throttle.write_bps_device
{
        sleep 4
        echo "8:0 2048" > blkio.throttle.write_bps_device
} &
dd if=/dev/zero of=/dev/sda bs=8k count=1 oflag=direct

test results: io finish time
	before this patch	with this patch
1)	10s			6s
2)	8s			6s

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
---
 block/blk-throttle.c | 58 +++++++++++++++++++++++++++++++++++++++-----
 block/blk-throttle.h |  9 +++++++
 2 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 8612a071305e..7b09b48577ba 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -639,6 +639,8 @@ static inline void throtl_start_new_slice_with_credit(struct throtl_grp *tg,
 {
 	tg->bytes_disp[rw] = 0;
 	tg->io_disp[rw] = 0;
+	tg->bytes_skipped[rw] = 0;
+	tg->io_skipped[rw] = 0;
 
 	/*
 	 * Previous slice has expired. We must have trimmed it after last
@@ -656,12 +658,17 @@ static inline void throtl_start_new_slice_with_credit(struct throtl_grp *tg,
 		   tg->slice_end[rw], jiffies);
 }
 
-static inline void throtl_start_new_slice(struct throtl_grp *tg, bool rw)
+static inline void throtl_start_new_slice(struct throtl_grp *tg, bool rw,
+					  bool clear_skipped)
 {
 	tg->bytes_disp[rw] = 0;
 	tg->io_disp[rw] = 0;
 	tg->slice_start[rw] = jiffies;
 	tg->slice_end[rw] = jiffies + tg->td->throtl_slice;
+	if (clear_skipped) {
+		tg->bytes_skipped[rw] = 0;
+		tg->io_skipped[rw] = 0;
+	}
 
 	throtl_log(&tg->service_queue,
 		   "[%c] new slice start=%lu end=%lu jiffies=%lu",
@@ -783,6 +790,41 @@ static u64 calculate_bytes_allowed(u64 bps_limit, unsigned long jiffy_elapsed)
 	return mul_u64_u64_div_u64(bps_limit, (u64)jiffy_elapsed, (u64)HZ);
 }
 
+static void __tg_update_skipped(struct throtl_grp *tg, bool rw)
+{
+	unsigned long jiffy_elapsed = jiffies - tg->slice_start[rw];
+	u64 bps_limit = tg_bps_limit(tg, rw);
+	u32 iops_limit = tg_iops_limit(tg, rw);
+
+	/*
+	 * Following calculation won't overflow as long as bios that are
+	 * dispatched later won't preempt already throttled bios. Even if such
+	 * overflow do happen, there should be no problem because we are using
+	 * unsigned here, and bytes_skipped/io_skipped will be updated
+	 * correctly.
+	 */
+	if (bps_limit != U64_MAX)
+		tg->bytes_skipped[rw] +=
+			calculate_bytes_allowed(bps_limit, jiffy_elapsed) -
+			tg->bytes_disp[rw];
+	if (iops_limit != UINT_MAX)
+		tg->io_skipped[rw] +=
+			calculate_io_allowed(iops_limit, jiffy_elapsed) -
+			tg->io_disp[rw];
+}
+
+static void tg_update_skipped(struct throtl_grp *tg)
+{
+	if (tg->service_queue.nr_queued[READ])
+		__tg_update_skipped(tg, READ);
+	if (tg->service_queue.nr_queued[WRITE])
+		__tg_update_skipped(tg, WRITE);
+
+	throtl_log(&tg->service_queue, "%s: %llu %llu %u %u\n", __func__,
+		   tg->bytes_skipped[READ], tg->bytes_skipped[WRITE],
+		   tg->io_skipped[READ], tg->io_skipped[WRITE]);
+}
+
 static bool tg_with_in_iops_limit(struct throtl_grp *tg, struct bio *bio,
 				  u32 iops_limit, unsigned long *wait)
 {
@@ -800,7 +842,8 @@ static bool tg_with_in_iops_limit(struct throtl_grp *tg, struct bio *bio,
 
 	/* Round up to the next throttle slice, wait time must be nonzero */
 	jiffy_elapsed_rnd = roundup(jiffy_elapsed + 1, tg->td->throtl_slice);
-	io_allowed = calculate_io_allowed(iops_limit, jiffy_elapsed_rnd);
+	io_allowed = calculate_io_allowed(iops_limit, jiffy_elapsed_rnd) +
+		     tg->io_skipped[rw];
 	if (tg->io_disp[rw] + 1 <= io_allowed) {
 		if (wait)
 			*wait = 0;
@@ -837,7 +880,8 @@ static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
 		jiffy_elapsed_rnd = tg->td->throtl_slice;
 
 	jiffy_elapsed_rnd = roundup(jiffy_elapsed_rnd, tg->td->throtl_slice);
-	bytes_allowed = calculate_bytes_allowed(bps_limit, jiffy_elapsed_rnd);
+	bytes_allowed = calculate_bytes_allowed(bps_limit, jiffy_elapsed_rnd) +
+			tg->bytes_skipped[rw];
 	if (tg->bytes_disp[rw] + bio_size <= bytes_allowed) {
 		if (wait)
 			*wait = 0;
@@ -898,7 +942,7 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
 	 * slice and it should be extended instead.
 	 */
 	if (throtl_slice_used(tg, rw) && !(tg->service_queue.nr_queued[rw]))
-		throtl_start_new_slice(tg, rw);
+		throtl_start_new_slice(tg, rw, true);
 	else {
 		if (time_before(tg->slice_end[rw],
 		    jiffies + tg->td->throtl_slice))
@@ -1327,8 +1371,8 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
 	 * that a group's limit are dropped suddenly and we don't want to
 	 * account recently dispatched IO with new low rate.
 	 */
-	throtl_start_new_slice(tg, READ);
-	throtl_start_new_slice(tg, WRITE);
+	throtl_start_new_slice(tg, READ, false);
+	throtl_start_new_slice(tg, WRITE, false);
 
 	if (tg->flags & THROTL_TG_PENDING) {
 		tg_update_disptime(tg);
@@ -1356,6 +1400,7 @@ static ssize_t tg_set_conf(struct kernfs_open_file *of,
 		v = U64_MAX;
 
 	tg = blkg_to_tg(ctx.blkg);
+	tg_update_skipped(tg);
 
 	if (is_u64)
 		*(u64 *)((void *)tg + of_cft(of)->private) = v;
@@ -1542,6 +1587,7 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 		return ret;
 
 	tg = blkg_to_tg(ctx.blkg);
+	tg_update_skipped(tg);
 
 	v[0] = tg->bps_conf[READ][index];
 	v[1] = tg->bps_conf[WRITE][index];
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index c1b602996127..371d624af845 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -115,6 +115,15 @@ struct throtl_grp {
 	uint64_t bytes_disp[2];
 	/* Number of bio's dispatched in current slice */
 	unsigned int io_disp[2];
+	/*
+	 * The following two fields are used to calculate new wait time for
+	 * throttled bio when new configuration is submmited.
+	 *
+	 * Number of bytes will be skipped in current slice
+	 */
+	uint64_t bytes_skipped[2];
+	/* Number of bio will be skipped in current slice */
+	unsigned int io_skipped[2];
 
 	unsigned long last_low_overflow_time[2];
 
-- 
2.31.1


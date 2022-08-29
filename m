Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5155A40F3
	for <lists+cgroups@lfdr.de>; Mon, 29 Aug 2022 04:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiH2CLb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 28 Aug 2022 22:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiH2CL1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 28 Aug 2022 22:11:27 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FB93B954;
        Sun, 28 Aug 2022 19:11:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MGDQv4wXNzKHSn;
        Mon, 29 Aug 2022 10:09:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP2 (Coremail) with SMTP id Syh0CgAnenNFIAxjqVZKAA--.51100S8;
        Mon, 29 Aug 2022 10:11:22 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     axboe@kernel.dk, tj@kernel.org, mkoutny@suse.com,
        ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH v9 4/4] blk-throttle: fix io hung due to configuration updates
Date:   Mon, 29 Aug 2022 10:22:40 +0800
Message-Id: <20220829022240.3348319-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220829022240.3348319-1-yukuai1@huaweicloud.com>
References: <20220829022240.3348319-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAnenNFIAxjqVZKAA--.51100S8
X-Coremail-Antispam: 1UD129KBjvJXoW3GFyDGr1DGF4kKry5CrW8tFb_yoWxtw43pF
        WFkan0qw45Xan7KFZxC3Z0yay0qws7Jry3J3y7Gr1rAF1YkryktFn8ZrWYyay8AF97ua1I
        vw1qgF9xCF42vrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
        kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
        4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQSdkU
        UUUU=
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

If new configuration is submitted while a bio is throttled, then new
waiting time is recalculated regardless that the bio might already wait
for some time:

tg_conf_updated
 throtl_start_new_slice
  tg_update_disptime
  throtl_schedule_next_dispatch

Then io hung can be triggered by always submmiting new configuration
before the throttled bio is dispatched.

Fix the problem by respecting the time that throttled bio already waited.
In order to do that, add new fields to record how many bytes/io are
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
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-throttle.c | 58 +++++++++++++++++++++++++++++++++++++++-----
 block/blk-throttle.h |  9 +++++++
 2 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 04c72d3283a5..7179b5cd42dc 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -642,6 +642,8 @@ static inline void throtl_start_new_slice_with_credit(struct throtl_grp *tg,
 {
 	tg->bytes_disp[rw] = 0;
 	tg->io_disp[rw] = 0;
+	tg->carryover_bytes[rw] = 0;
+	tg->carryover_ios[rw] = 0;
 
 	/*
 	 * Previous slice has expired. We must have trimmed it after last
@@ -659,12 +661,17 @@ static inline void throtl_start_new_slice_with_credit(struct throtl_grp *tg,
 		   tg->slice_end[rw], jiffies);
 }
 
-static inline void throtl_start_new_slice(struct throtl_grp *tg, bool rw)
+static inline void throtl_start_new_slice(struct throtl_grp *tg, bool rw,
+					  bool clear_carryover)
 {
 	tg->bytes_disp[rw] = 0;
 	tg->io_disp[rw] = 0;
 	tg->slice_start[rw] = jiffies;
 	tg->slice_end[rw] = jiffies + tg->td->throtl_slice;
+	if (clear_carryover) {
+		tg->carryover_bytes[rw] = 0;
+		tg->carryover_ios[rw] = 0;
+	}
 
 	throtl_log(&tg->service_queue,
 		   "[%c] new slice start=%lu end=%lu jiffies=%lu",
@@ -786,6 +793,41 @@ static u64 calculate_bytes_allowed(u64 bps_limit, unsigned long jiffy_elapsed)
 	return mul_u64_u64_div_u64(bps_limit, (u64)jiffy_elapsed, (u64)HZ);
 }
 
+static void __tg_update_carryover(struct throtl_grp *tg, bool rw)
+{
+	unsigned long jiffy_elapsed = jiffies - tg->slice_start[rw];
+	u64 bps_limit = tg_bps_limit(tg, rw);
+	u32 iops_limit = tg_iops_limit(tg, rw);
+
+	/*
+	 * If config is updated while bios are still throttled, calculate and
+	 * accumulate how many bytes/ios are waited across changes. And
+	 * carryover_bytes/ios will be used to calculate new wait time under new
+	 * configuration.
+	 */
+	if (bps_limit != U64_MAX)
+		tg->carryover_bytes[rw] +=
+			calculate_bytes_allowed(bps_limit, jiffy_elapsed) -
+			tg->bytes_disp[rw];
+	if (iops_limit != UINT_MAX)
+		tg->carryover_ios[rw] +=
+			calculate_io_allowed(iops_limit, jiffy_elapsed) -
+			tg->io_disp[rw];
+}
+
+static void tg_update_carryover(struct throtl_grp *tg)
+{
+	if (tg->service_queue.nr_queued[READ])
+		__tg_update_carryover(tg, READ);
+	if (tg->service_queue.nr_queued[WRITE])
+		__tg_update_carryover(tg, WRITE);
+
+	/* see comments in struct throtl_grp for meaning of these fields. */
+	throtl_log(&tg->service_queue, "%s: %llu %llu %u %u\n", __func__,
+		   tg->carryover_bytes[READ], tg->carryover_bytes[WRITE],
+		   tg->carryover_ios[READ], tg->carryover_ios[WRITE]);
+}
+
 static bool tg_within_iops_limit(struct throtl_grp *tg, struct bio *bio,
 				 u32 iops_limit, unsigned long *wait)
 {
@@ -803,7 +845,8 @@ static bool tg_within_iops_limit(struct throtl_grp *tg, struct bio *bio,
 
 	/* Round up to the next throttle slice, wait time must be nonzero */
 	jiffy_elapsed_rnd = roundup(jiffy_elapsed + 1, tg->td->throtl_slice);
-	io_allowed = calculate_io_allowed(iops_limit, jiffy_elapsed_rnd);
+	io_allowed = calculate_io_allowed(iops_limit, jiffy_elapsed_rnd) +
+		     tg->carryover_ios[rw];
 	if (tg->io_disp[rw] + 1 <= io_allowed) {
 		if (wait)
 			*wait = 0;
@@ -840,7 +883,8 @@ static bool tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
 		jiffy_elapsed_rnd = tg->td->throtl_slice;
 
 	jiffy_elapsed_rnd = roundup(jiffy_elapsed_rnd, tg->td->throtl_slice);
-	bytes_allowed = calculate_bytes_allowed(bps_limit, jiffy_elapsed_rnd);
+	bytes_allowed = calculate_bytes_allowed(bps_limit, jiffy_elapsed_rnd) +
+			tg->carryover_bytes[rw];
 	if (tg->bytes_disp[rw] + bio_size <= bytes_allowed) {
 		if (wait)
 			*wait = 0;
@@ -901,7 +945,7 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
 	 * slice and it should be extended instead.
 	 */
 	if (throtl_slice_used(tg, rw) && !(tg->service_queue.nr_queued[rw]))
-		throtl_start_new_slice(tg, rw);
+		throtl_start_new_slice(tg, rw, true);
 	else {
 		if (time_before(tg->slice_end[rw],
 		    jiffies + tg->td->throtl_slice))
@@ -1325,8 +1369,8 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
 	 * that a group's limit are dropped suddenly and we don't want to
 	 * account recently dispatched IO with new low rate.
 	 */
-	throtl_start_new_slice(tg, READ);
-	throtl_start_new_slice(tg, WRITE);
+	throtl_start_new_slice(tg, READ, false);
+	throtl_start_new_slice(tg, WRITE, false);
 
 	if (tg->flags & THROTL_TG_PENDING) {
 		tg_update_disptime(tg);
@@ -1354,6 +1398,7 @@ static ssize_t tg_set_conf(struct kernfs_open_file *of,
 		v = U64_MAX;
 
 	tg = blkg_to_tg(ctx.blkg);
+	tg_update_carryover(tg);
 
 	if (is_u64)
 		*(u64 *)((void *)tg + of_cft(of)->private) = v;
@@ -1540,6 +1585,7 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 		return ret;
 
 	tg = blkg_to_tg(ctx.blkg);
+	tg_update_carryover(tg);
 
 	v[0] = tg->bps_conf[READ][index];
 	v[1] = tg->bps_conf[WRITE][index];
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index ee7299e6dea9..66b4292b1b92 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -121,6 +121,15 @@ struct throtl_grp {
 	uint64_t last_bytes_disp[2];
 	unsigned int last_io_disp[2];
 
+	/*
+	 * The following two fields are updated when new configuration is
+	 * submitted while some bios are still throttled, they record how many
+	 * bytes/ios are waited already in previous configuration, and they will
+	 * be used to calculate wait time under new configuration.
+	 */
+	uint64_t carryover_bytes[2];
+	unsigned int carryover_ios[2];
+
 	unsigned long last_check_time;
 
 	unsigned long latency_target; /* us */
-- 
2.31.1


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C9A77D7B1
	for <lists+cgroups@lfdr.de>; Wed, 16 Aug 2023 03:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241053AbjHPBa4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Aug 2023 21:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241116AbjHPBay (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Aug 2023 21:30:54 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E062123;
        Tue, 15 Aug 2023 18:30:53 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RQVvY4wDNz4f3pG4;
        Wed, 16 Aug 2023 09:30:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAH5KbHJtxkQuVAAw--.55976S7;
        Wed, 16 Aug 2023 09:30:50 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        yukuai3@huawei.com, mkoutny@suse.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next v2 3/4] blk-throttle: use calculate_io/bytes_allowed() for throtl_trim_slice()
Date:   Wed, 16 Aug 2023 09:27:07 +0800
Message-Id: <20230816012708.1193747-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230816012708.1193747-1-yukuai1@huaweicloud.com>
References: <20230816012708.1193747-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAH5KbHJtxkQuVAAw--.55976S7
X-Coremail-Antispam: 1UD129KBjvJXoWxur1UJF1DXryxXF4rAr43KFg_yoWrGrykpr
        WfAF42grs5Xas7tFW3Awn0yayrCwnxJFyUJ3y3Xr9YyFWUAFy8GF1kAryUta4xAas7ua1f
        Aw1DZrn8Cr42yFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
        xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd8n5UUUUU
        =
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

There are no functional changes, just make the code cleaner.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 86 +++++++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 45 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 7c93144d03da..69a994156772 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -697,11 +697,40 @@ static bool throtl_slice_used(struct throtl_grp *tg, bool rw)
 	return true;
 }
 
+static unsigned int calculate_io_allowed(u32 iops_limit,
+					 unsigned long jiffy_elapsed)
+{
+	unsigned int io_allowed;
+	u64 tmp;
+
+	/*
+	 * jiffy_elapsed should not be a big value as minimum iops can be
+	 * 1 then at max jiffy elapsed should be equivalent of 1 second as we
+	 * will allow dispatch after 1 second and after that slice should
+	 * have been trimmed.
+	 */
+
+	tmp = (u64)iops_limit * jiffy_elapsed;
+	do_div(tmp, HZ);
+
+	if (tmp > UINT_MAX)
+		io_allowed = UINT_MAX;
+	else
+		io_allowed = tmp;
+
+	return io_allowed;
+}
+
+static u64 calculate_bytes_allowed(u64 bps_limit, unsigned long jiffy_elapsed)
+{
+	return mul_u64_u64_div_u64(bps_limit, (u64)jiffy_elapsed, (u64)HZ);
+}
+
 /* Trim the used slices and adjust slice start accordingly */
 static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
 {
-	unsigned long nr_slices, time_elapsed, io_trim;
-	u64 bytes_trim, tmp;
+	unsigned long time_elapsed, io_trim;
+	u64 bytes_trim;
 
 	BUG_ON(time_before(tg->slice_end[rw], tg->slice_start[rw]));
 
@@ -723,19 +752,14 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
 
 	throtl_set_slice_end(tg, rw, jiffies + tg->td->throtl_slice);
 
-	time_elapsed = jiffies - tg->slice_start[rw];
-
-	nr_slices = time_elapsed / tg->td->throtl_slice;
-
-	if (!nr_slices)
+	time_elapsed = rounddown(jiffies - tg->slice_start[rw],
+				 tg->td->throtl_slice);
+	if (!time_elapsed)
 		return;
-	tmp = tg_bps_limit(tg, rw) * tg->td->throtl_slice * nr_slices;
-	do_div(tmp, HZ);
-	bytes_trim = tmp;
-
-	io_trim = (tg_iops_limit(tg, rw) * tg->td->throtl_slice * nr_slices) /
-		HZ;
 
+	bytes_trim = calculate_bytes_allowed(tg_bps_limit(tg, rw),
+					     time_elapsed);
+	io_trim = calculate_io_allowed(tg_iops_limit(tg, rw), time_elapsed);
 	if (!bytes_trim && !io_trim)
 		return;
 
@@ -749,41 +773,13 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
 	else
 		tg->io_disp[rw] = 0;
 
-	tg->slice_start[rw] += nr_slices * tg->td->throtl_slice;
+	tg->slice_start[rw] += time_elapsed;
 
 	throtl_log(&tg->service_queue,
 		   "[%c] trim slice nr=%lu bytes=%llu io=%lu start=%lu end=%lu jiffies=%lu",
-		   rw == READ ? 'R' : 'W', nr_slices, bytes_trim, io_trim,
-		   tg->slice_start[rw], tg->slice_end[rw], jiffies);
-}
-
-static unsigned int calculate_io_allowed(u32 iops_limit,
-					 unsigned long jiffy_elapsed)
-{
-	unsigned int io_allowed;
-	u64 tmp;
-
-	/*
-	 * jiffy_elapsed should not be a big value as minimum iops can be
-	 * 1 then at max jiffy elapsed should be equivalent of 1 second as we
-	 * will allow dispatch after 1 second and after that slice should
-	 * have been trimmed.
-	 */
-
-	tmp = (u64)iops_limit * jiffy_elapsed;
-	do_div(tmp, HZ);
-
-	if (tmp > UINT_MAX)
-		io_allowed = UINT_MAX;
-	else
-		io_allowed = tmp;
-
-	return io_allowed;
-}
-
-static u64 calculate_bytes_allowed(u64 bps_limit, unsigned long jiffy_elapsed)
-{
-	return mul_u64_u64_div_u64(bps_limit, (u64)jiffy_elapsed, (u64)HZ);
+		   rw == READ ? 'R' : 'W', time_elapsed / tg->td->throtl_slice,
+		   bytes_trim, io_trim, tg->slice_start[rw], tg->slice_end[rw],
+		   jiffies);
 }
 
 static void __tg_update_carryover(struct throtl_grp *tg, bool rw)
-- 
2.39.2


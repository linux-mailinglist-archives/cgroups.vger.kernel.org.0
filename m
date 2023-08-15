Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1C477C553
	for <lists+cgroups@lfdr.de>; Tue, 15 Aug 2023 03:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbjHOBp1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Aug 2023 21:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbjHOBpG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Aug 2023 21:45:06 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0AE10F2;
        Mon, 14 Aug 2023 18:45:05 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RPvGM4fX2z4f40LJ;
        Tue, 15 Aug 2023 09:44:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgA3x6mb2NpkdnTyAg--.15945S7;
        Tue, 15 Aug 2023 09:45:02 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        yukuai3@huawei.com, mkoutny@suse.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next 3/4] blk-throttle: use calculate_io/bytes_allowed() for throtl_trim_slice()
Date:   Tue, 15 Aug 2023 09:41:22 +0800
Message-Id: <20230815014123.368929-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230815014123.368929-1-yukuai1@huaweicloud.com>
References: <20230815014123.368929-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA3x6mb2NpkdnTyAg--.15945S7
X-Coremail-Antispam: 1UD129KBjvJXoWxur1UJF1DXrW5AFWfJr1kKrg_yoWrJw45pr
        WfAF4jgrs5Xas7tFy3Awn0yayrCwsxXFyUJ3y3XF95AFWUAFy8GF1kAryUtayxAas7ua1f
        Aw1DZrn8Cr42yrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
        xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
        CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUojjgUUUU
        U
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
 block/blk-throttle.c | 81 +++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 43 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 7c93144d03da..e5296960c799 100644
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
 
@@ -749,7 +773,7 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
 	else
 		tg->io_disp[rw] = 0;
 
-	tg->slice_start[rw] += nr_slices * tg->td->throtl_slice;
+	tg->slice_start[rw] += time_elapsed;
 
 	throtl_log(&tg->service_queue,
 		   "[%c] trim slice nr=%lu bytes=%llu io=%lu start=%lu end=%lu jiffies=%lu",
@@ -757,35 +781,6 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
 		   tg->slice_start[rw], tg->slice_end[rw], jiffies);
 }
 
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
-}
-
 static void __tg_update_carryover(struct throtl_grp *tg, bool rw)
 {
 	unsigned long jiffy_elapsed = jiffies - tg->slice_start[rw];
-- 
2.39.2


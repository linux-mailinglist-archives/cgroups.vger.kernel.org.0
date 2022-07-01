Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF814562FC8
	for <lists+cgroups@lfdr.de>; Fri,  1 Jul 2022 11:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbiGAJWH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 1 Jul 2022 05:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbiGAJWD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 1 Jul 2022 05:22:03 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717AB59247;
        Fri,  1 Jul 2022 02:22:01 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4LZ8p56Jc4zlC1F;
        Fri,  1 Jul 2022 17:21:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgB32mm1vL5i6ab6AA--.40529S7;
        Fri, 01 Jul 2022 17:21:59 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, mkoutny@suse.com, axboe@kernel.dk,
        ming.lei@redhat.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH RESEND v6 3/8] blk-throttle: factor out code to calculate ios/bytes_allowed
Date:   Fri,  1 Jul 2022 17:34:36 +0800
Message-Id: <20220701093441.885741-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220701093441.885741-1-yukuai1@huaweicloud.com>
References: <20220701093441.885741-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgB32mm1vL5i6ab6AA--.40529S7
X-Coremail-Antispam: 1UD129KBjvJXoWxXF47XryDZr1kCr47tr1xuFg_yoW5ZrW5pr
        Z3Gr1jgF4rX3WftF13Jwn0vayrArn5AFyUJ3y3Xas5AF15CF1kJFn8ZrW0yay8ZF97ua1f
        Zw1Ut3ZrAr4UAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUP014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWUJVWUGwAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
        xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJw
        CI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbmiiDUU
        UUU==
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

No functional changes, new apis will be used in later patches to
calculate wait time for throttled bios while updating config.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 51 +++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index a89c62bef2fb..8612a071305e 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -754,33 +754,20 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
 		   tg->slice_start[rw], tg->slice_end[rw], jiffies);
 }
 
-static bool tg_with_in_iops_limit(struct throtl_grp *tg, struct bio *bio,
-				  u32 iops_limit, unsigned long *wait)
+static unsigned int calculate_io_allowed(u32 iops_limit,
+					 unsigned long jiffy_elapsed)
 {
-	bool rw = bio_data_dir(bio);
 	unsigned int io_allowed;
-	unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
 	u64 tmp;
 
-	if (iops_limit == UINT_MAX) {
-		if (wait)
-			*wait = 0;
-		return true;
-	}
-
-	jiffy_elapsed = jiffies - tg->slice_start[rw];
-
-	/* Round up to the next throttle slice, wait time must be nonzero */
-	jiffy_elapsed_rnd = roundup(jiffy_elapsed + 1, tg->td->throtl_slice);
-
 	/*
-	 * jiffy_elapsed_rnd should not be a big value as minimum iops can be
+	 * jiffy_elapsed should not be a big value as minimum iops can be
 	 * 1 then at max jiffy elapsed should be equivalent of 1 second as we
 	 * will allow dispatch after 1 second and after that slice should
 	 * have been trimmed.
 	 */
 
-	tmp = (u64)iops_limit * jiffy_elapsed_rnd;
+	tmp = (u64)iops_limit * jiffy_elapsed;
 	do_div(tmp, HZ);
 
 	if (tmp > UINT_MAX)
@@ -788,6 +775,32 @@ static bool tg_with_in_iops_limit(struct throtl_grp *tg, struct bio *bio,
 	else
 		io_allowed = tmp;
 
+	return io_allowed;
+}
+
+static u64 calculate_bytes_allowed(u64 bps_limit, unsigned long jiffy_elapsed)
+{
+	return mul_u64_u64_div_u64(bps_limit, (u64)jiffy_elapsed, (u64)HZ);
+}
+
+static bool tg_with_in_iops_limit(struct throtl_grp *tg, struct bio *bio,
+				  u32 iops_limit, unsigned long *wait)
+{
+	bool rw = bio_data_dir(bio);
+	unsigned int io_allowed;
+	unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
+
+	if (iops_limit == UINT_MAX) {
+		if (wait)
+			*wait = 0;
+		return true;
+	}
+
+	jiffy_elapsed = jiffies - tg->slice_start[rw];
+
+	/* Round up to the next throttle slice, wait time must be nonzero */
+	jiffy_elapsed_rnd = roundup(jiffy_elapsed + 1, tg->td->throtl_slice);
+	io_allowed = calculate_io_allowed(iops_limit, jiffy_elapsed_rnd);
 	if (tg->io_disp[rw] + 1 <= io_allowed) {
 		if (wait)
 			*wait = 0;
@@ -824,9 +837,7 @@ static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
 		jiffy_elapsed_rnd = tg->td->throtl_slice;
 
 	jiffy_elapsed_rnd = roundup(jiffy_elapsed_rnd, tg->td->throtl_slice);
-	bytes_allowed = mul_u64_u64_div_u64(bps_limit, (u64)jiffy_elapsed_rnd,
-					    (u64)HZ);
-
+	bytes_allowed = calculate_bytes_allowed(bps_limit, jiffy_elapsed_rnd);
 	if (tg->bytes_disp[rw] + bio_size <= bytes_allowed) {
 		if (wait)
 			*wait = 0;
-- 
2.31.1


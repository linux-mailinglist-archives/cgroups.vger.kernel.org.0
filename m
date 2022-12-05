Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7694B64220E
	for <lists+cgroups@lfdr.de>; Mon,  5 Dec 2022 04:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbiLED6F (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 4 Dec 2022 22:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiLED6B (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 4 Dec 2022 22:58:01 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74A5FD04;
        Sun,  4 Dec 2022 19:57:59 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NQVBV15wzz4f3nKw;
        Mon,  5 Dec 2022 11:57:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgDXfq1CbI1jRaRVBg--.57323S6;
        Mon, 05 Dec 2022 11:57:56 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, shikemeng@huawei.com,
        linfeilong@huawei.com, liuzhiqiang26@huawei.com
Subject: [PATCH v3 4/9] blk-throttle: correct calculation of wait time in tg_may_dispatch
Date:   Mon,  5 Dec 2022 19:57:04 +0800
Message-Id: <20221205115709.251489-5-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20221205115709.251489-1-shikemeng@huaweicloud.com>
References: <20221205115709.251489-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDXfq1CbI1jRaRVBg--.57323S6
X-Coremail-Antispam: 1UD129KBjvJXoWxWw1rJr1rtr13ZF43CrW5Awb_yoWrCFy3pF
        yxGr40gFWUXa1xKF1fJrnIkFyrtr18AF9rJ3y7W3sYyF15CF98GFn7ZrWFvFW7Zr97uan2
        v34qqasrCF4DAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
        FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3w
        A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
        3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
        CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU058n7UUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Kemeng Shi <shikemeng@huawei.com>

In C language, When executing "if (expression1 && expression2)" and
expression1 return false, the expression2 may not be executed.
For "tg_within_bps_limit(tg, bio, bps_limit, &bps_wait) &&
tg_within_iops_limit(tg, bio, iops_limit, &iops_wait))", if bps is
limited, tg_within_bps_limit will return false and
tg_within_iops_limit will not be called. So even bps and iops are
both limited, iops_wait will not be calculated and is always zero.
So wait time of iops is always ignored.

Fix this by always calling tg_within_bps_limit and tg_within_iops_limit
to get wait time for both bps and iops.

Observed that:
1. Wait time in tg_within_iops_limit/tg_within_bps_limit need always
be stored as wait argument is always passed.
2. wait time is stored to zero if iops/bps is limited otherwise non-zero
is stored.
Simpfy tg_within_iops_limit/tg_within_bps_limit by removing wait argument
and return wait time directly. Caller tg_may_dispatch checks if wait time
is zero to find if iops/bps is limited.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 block/blk-throttle.c | 38 +++++++++++++-------------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 75010110d481..d5b7a2354ad7 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -822,17 +822,15 @@ static void tg_update_carryover(struct throtl_grp *tg)
 		   tg->carryover_ios[READ], tg->carryover_ios[WRITE]);
 }
 
-static bool tg_within_iops_limit(struct throtl_grp *tg, struct bio *bio,
-				 u32 iops_limit, unsigned long *wait)
+static unsigned long tg_within_iops_limit(struct throtl_grp *tg, struct bio *bio,
+				 u32 iops_limit)
 {
 	bool rw = bio_data_dir(bio);
 	unsigned int io_allowed;
 	unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
 
 	if (iops_limit == UINT_MAX) {
-		if (wait)
-			*wait = 0;
-		return true;
+		return 0;
 	}
 
 	jiffy_elapsed = jiffies - tg->slice_start[rw];
@@ -842,21 +840,16 @@ static bool tg_within_iops_limit(struct throtl_grp *tg, struct bio *bio,
 	io_allowed = calculate_io_allowed(iops_limit, jiffy_elapsed_rnd) +
 		     tg->carryover_ios[rw];
 	if (tg->io_disp[rw] + 1 <= io_allowed) {
-		if (wait)
-			*wait = 0;
-		return true;
+		return 0;
 	}
 
 	/* Calc approx time to dispatch */
 	jiffy_wait = jiffy_elapsed_rnd - jiffy_elapsed;
-
-	if (wait)
-		*wait = jiffy_wait;
-	return false;
+	return jiffy_wait;
 }
 
-static bool tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
-				u64 bps_limit, unsigned long *wait)
+static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
+				u64 bps_limit)
 {
 	bool rw = bio_data_dir(bio);
 	u64 bytes_allowed, extra_bytes;
@@ -865,9 +858,7 @@ static bool tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
 
 	/* no need to throttle if this bio's bytes have been accounted */
 	if (bps_limit == U64_MAX || bio_flagged(bio, BIO_BPS_THROTTLED)) {
-		if (wait)
-			*wait = 0;
-		return true;
+		return 0;
 	}
 
 	jiffy_elapsed = jiffy_elapsed_rnd = jiffies - tg->slice_start[rw];
@@ -880,9 +871,7 @@ static bool tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
 	bytes_allowed = calculate_bytes_allowed(bps_limit, jiffy_elapsed_rnd) +
 			tg->carryover_bytes[rw];
 	if (tg->bytes_disp[rw] + bio_size <= bytes_allowed) {
-		if (wait)
-			*wait = 0;
-		return true;
+		return 0;
 	}
 
 	/* Calc approx time to dispatch */
@@ -897,9 +886,7 @@ static bool tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
 	 * up we did. Add that time also.
 	 */
 	jiffy_wait = jiffy_wait + (jiffy_elapsed_rnd - jiffy_elapsed);
-	if (wait)
-		*wait = jiffy_wait;
-	return false;
+	return jiffy_wait;
 }
 
 /*
@@ -947,8 +934,9 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
 				jiffies + tg->td->throtl_slice);
 	}
 
-	if (tg_within_bps_limit(tg, bio, bps_limit, &bps_wait) &&
-	    tg_within_iops_limit(tg, bio, iops_limit, &iops_wait)) {
+	bps_wait = tg_within_bps_limit(tg, bio, bps_limit);
+	iops_wait = tg_within_iops_limit(tg, bio, iops_limit);
+	if (bps_wait + iops_wait == 0) {
 		if (wait)
 			*wait = 0;
 		return true;
-- 
2.30.0


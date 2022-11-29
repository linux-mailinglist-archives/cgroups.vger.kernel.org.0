Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0439163B860
	for <lists+cgroups@lfdr.de>; Tue, 29 Nov 2022 04:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbiK2DB5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Nov 2022 22:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbiK2DB4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Nov 2022 22:01:56 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3CD45EF1;
        Mon, 28 Nov 2022 19:01:54 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NLnCq49DWzCqjJ;
        Tue, 29 Nov 2022 11:01:11 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 29 Nov
 2022 11:01:52 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <shikemeng@huawei.com>
Subject: [PATCH v2 04/10] blk-throttle: correct calculation of wait time in tg_may_dispatch
Date:   Tue, 29 Nov 2022 11:01:41 +0800
Message-ID: <20221129030147.27400-5-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20221129030147.27400-1-shikemeng@huawei.com>
References: <20221129030147.27400-1-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

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
---
 block/blk-throttle.c | 38 +++++++++++++-------------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index ee7dc1a0adfd..06e4193b064e 100644
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


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474CC25F4B8
	for <lists+cgroups@lfdr.de>; Mon,  7 Sep 2020 10:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgIGIMP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 7 Sep 2020 04:12:15 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:60363 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727970AbgIGIKi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 7 Sep 2020 04:10:38 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U88Pk5E_1599466230;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U88Pk5E_1599466230)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Sep 2020 16:10:30 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] blk-throttle: Avoid calculating bps/iops limitation repeatedly
Date:   Mon,  7 Sep 2020 16:10:16 +0800
Message-Id: <f04f6e4de7f39f7cf2b47ff49247857a41e68df9.1599458244.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1599458244.git.baolin.wang@linux.alibaba.com>
References: <cover.1599458244.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1599458244.git.baolin.wang@linux.alibaba.com>
References: <cover.1599458244.git.baolin.wang@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The tg_may_dispatch() will call tg_with_in_bps_limit() and
tg_with_in_iops_limit() to check if we can dispatch a bio or
not, which will calculate bps/iops limitation multiple times.
But tg_may_dispatch() is always called under queue lock, which
means the bps/iops limitation will not change in tg_may_dispatch().

So we can calculate the bps/iops limitation only once, and pass
them to tg_with_in_bps_limit() and tg_with_in_iops_limit() to
avoid calculating bps/iops limitation repeatedly.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/blk-throttle.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index ca9002d..8719e37 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -894,7 +894,7 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
 }
 
 static bool tg_with_in_iops_limit(struct throtl_grp *tg, struct bio *bio,
-				  unsigned long *wait)
+				  u32 iops_limit, unsigned long *wait)
 {
 	bool rw = bio_data_dir(bio);
 	unsigned int io_allowed;
@@ -913,7 +913,7 @@ static bool tg_with_in_iops_limit(struct throtl_grp *tg, struct bio *bio,
 	 * have been trimmed.
 	 */
 
-	tmp = (u64)tg_iops_limit(tg, rw) * jiffy_elapsed_rnd;
+	tmp = (u64)iops_limit * jiffy_elapsed_rnd;
 	do_div(tmp, HZ);
 
 	if (tmp > UINT_MAX)
@@ -936,7 +936,7 @@ static bool tg_with_in_iops_limit(struct throtl_grp *tg, struct bio *bio,
 }
 
 static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
-				 unsigned long *wait)
+				 u64 bps_limit, unsigned long *wait)
 {
 	bool rw = bio_data_dir(bio);
 	u64 bytes_allowed, extra_bytes, tmp;
@@ -951,7 +951,7 @@ static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
 
 	jiffy_elapsed_rnd = roundup(jiffy_elapsed_rnd, tg->td->throtl_slice);
 
-	tmp = tg_bps_limit(tg, rw) * jiffy_elapsed_rnd;
+	tmp = bps_limit * jiffy_elapsed_rnd;
 	do_div(tmp, HZ);
 	bytes_allowed = tmp;
 
@@ -963,7 +963,7 @@ static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
 
 	/* Calc approx time to dispatch */
 	extra_bytes = tg->bytes_disp[rw] + bio_size - bytes_allowed;
-	jiffy_wait = div64_u64(extra_bytes * HZ, tg_bps_limit(tg, rw));
+	jiffy_wait = div64_u64(extra_bytes * HZ, bps_limit);
 
 	if (!jiffy_wait)
 		jiffy_wait = 1;
@@ -987,6 +987,8 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
 {
 	bool rw = bio_data_dir(bio);
 	unsigned long bps_wait = 0, iops_wait = 0, max_wait = 0;
+	u64 bps_limit = tg_bps_limit(tg, rw);
+	u32 iops_limit = tg_iops_limit(tg, rw);
 
 	/*
  	 * Currently whole state machine of group depends on first bio
@@ -998,8 +1000,7 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
 	       bio != throtl_peek_queued(&tg->service_queue.queued[rw]));
 
 	/* If tg->bps = -1, then BW is unlimited */
-	if (tg_bps_limit(tg, rw) == U64_MAX &&
-	    tg_iops_limit(tg, rw) == UINT_MAX) {
+	if (bps_limit == U64_MAX && iops_limit == UINT_MAX) {
 		if (wait)
 			*wait = 0;
 		return true;
@@ -1021,8 +1022,8 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
 				jiffies + tg->td->throtl_slice);
 	}
 
-	if (tg_with_in_bps_limit(tg, bio, &bps_wait) &&
-	    tg_with_in_iops_limit(tg, bio, &iops_wait)) {
+	if (tg_with_in_bps_limit(tg, bio, bps_limit, &bps_wait) &&
+	    tg_with_in_iops_limit(tg, bio, iops_limit, &iops_wait)) {
 		if (wait)
 			*wait = 0;
 		return true;
-- 
1.8.3.1


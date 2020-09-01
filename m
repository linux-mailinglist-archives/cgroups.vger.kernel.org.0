Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22389259EA4
	for <lists+cgroups@lfdr.de>; Tue,  1 Sep 2020 20:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732162AbgIASzR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Sep 2020 14:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731819AbgIASyF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Sep 2020 14:54:05 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648F4C061245;
        Tue,  1 Sep 2020 11:54:03 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id n10so1749693qtv.3;
        Tue, 01 Sep 2020 11:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j8/MHtQnIWUZGz4ny60HkFTlkU4fit1K0ZbZqOii9ss=;
        b=i79+RILXC83YIcNxFkRKDBXVMxYXYhWO3kwo/JYJSe6wJY/kXeb/hvcaszKCRwozRc
         V/WOpFOZ25hnm6tx5GkOi7Q7r6F4e+CWuo8VV+pk7wF44mwqiXl3x7Pw/xs/BVZb83c1
         f67j13nEkyz064HpuEyqDhCg7Qj/4VZlFA9v5aCn9A5F8ziCmh336Dq5M5Br1bYAfuhj
         IisMtpx3WCJrnP0LQKH8X7Mw/b+dWa3E2lri3h5Yk62+AGPTFIKPVZFIR5ZKmORPuGRq
         xMETKtBfvbhX3CZBV7wzfSN4YkrAHQ78GORtw74nH+kSc9wJ5o6oPiQgrO3JyH9gSloU
         QFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=j8/MHtQnIWUZGz4ny60HkFTlkU4fit1K0ZbZqOii9ss=;
        b=iH+9xXmatwrHIrZyJk5UflAbCgcJKlW0l/WpH4Dias4AQjK4u0qndNC8g8Ge5/F+zp
         GZ8+SEi7ytmpFizOLL+xL4xjGQ+rRHlHk/KN2cBUMZgdQxsXQZAyeCjplDCfarEUoQCG
         ROUL19fpkRV1DOsKvHgF1JjhcC/OE40dvJ2q8Q0WbHutvp2AoTp8PdpAg2jmLO92m/SZ
         rNPuNTp6kUKH22jabkqAFgCHfyE102jYZtVG0zgm3MY2/oLQVkOpBV2uK8lUg7cR8LtT
         sdT8syTk4OyRQwy7zIB1iYin3oNSoRb9w4Qd/JSdFDWHrPWvRS31sZn7hvrEpnzt9StZ
         F6LQ==
X-Gm-Message-State: AOAM531dPU+yr83rm7+6U58PrJoxahOzsLeVe/zwMcqEBUPp/MRFbu2F
        0S8W9F8OfNIhBEpQQYoxpz7f3Mp3pVRojA==
X-Google-Smtp-Source: ABdhPJwpGcVGJyG0/nm08NjREu2jHRdZ7SqujXGhl0D0dGNMtZ5u7dc9T9dbT18vuo0/eUHCIAtAuA==
X-Received: by 2002:ac8:4d84:: with SMTP id a4mr3269979qtw.365.1598986442381;
        Tue, 01 Sep 2020 11:54:02 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a198])
        by smtp.gmail.com with ESMTPSA id 194sm2405798qke.36.2020.09.01.11.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 11:54:01 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, newella@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 19/27] blk-iocost: revamp donation amount determination
Date:   Tue,  1 Sep 2020 14:52:49 -0400
Message-Id: <20200901185257.645114-20-tj@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901185257.645114-1-tj@kernel.org>
References: <20200901185257.645114-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

iocost has various safety nets to combat inuse adjustment calculation
inaccuracies. With Andy's method implemented in transfer_surpluses(), inuse
adjustment calculations are now accurate and we can make donation amount
determinations accurate too.

* Stop keeping track of past usage history and using the maximum. Act on the
  immediate usage information.

* Remove donation constraints defined by SURPLUS_* constants. Donate
  whatever isn't used.

* Determine the donation amount so that the iocg will end up with
  MARGIN_TARGET_PCT budget at the end of the coming period assuming the same
  usage as the previous period. TARGET is set at 50% of period, which is the
  previous maximum. This provides smooth convergence for most repetitive IO
  patterns.

* Apply donation logic early at 20% budget. There's no risk in doing so as
  the calculation is based on the delta between the current budget and the
  target budget at the end of the coming period.

* Remove preemptive iocg activation for zero cost IOs. As donation can reach
  near zero now, the mere activation doesn't provide any protection anymore.
  In the unlikely case that this becomes a problem, the right solution is
  assigning appropriate costs for such IOs.

This significantly improves the donation determination logic while also
simplifying it. Now all donations are immediate, exact and smooth.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Andy Newell <newella@fb.com>
---
 block/blk-iocost.c | 133 +++++++++++++++++----------------------------
 1 file changed, 51 insertions(+), 82 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index ecc23b827e5d..694f1487208a 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -217,12 +217,14 @@ enum {
 	MAX_PERIOD		= USEC_PER_SEC,
 
 	/*
-	 * A cgroup's vtime can run 50% behind the device vtime, which
+	 * iocg->vtime is targeted at 50% behind the device vtime, which
 	 * serves as its IO credit buffer.  Surplus weight adjustment is
 	 * immediately canceled if the vtime margin runs below 10%.
 	 */
 	MARGIN_MIN_PCT		= 10,
-	MARGIN_MAX_PCT		= 50,
+	MARGIN_LOW_PCT		= 20,
+	MARGIN_TARGET_PCT	= 50,
+	MARGIN_MAX_PCT		= 100,
 
 	/* Have some play in timer operations */
 	TIMER_SLACK_PCT		= 1,
@@ -234,17 +236,6 @@ enum {
 	 */
 	VTIME_VALID_DUR		= 300 * USEC_PER_SEC,
 
-	/*
-	 * Remember the past three non-zero usages and use the max for
-	 * surplus calculation.  Three slots guarantee that we remember one
-	 * full period usage from the last active stretch even after
-	 * partial deactivation and re-activation periods.  Don't start
-	 * giving away weight before collecting two data points to prevent
-	 * hweight adjustments based on one partial activation period.
-	 */
-	NR_USAGE_SLOTS		= 3,
-	MIN_VALID_USAGES	= 2,
-
 	/* 1/64k is granular enough and can easily be handled w/ u32 */
 	WEIGHT_ONE		= 1 << 16,
 
@@ -280,14 +271,6 @@ enum {
 	/* don't let cmds which take a very long time pin lagging for too long */
 	MAX_LAGGING_PERIODS	= 10,
 
-	/*
-	 * If usage% * 1.25 + 2% is lower than hweight% by more than 3%,
-	 * donate the surplus.
-	 */
-	SURPLUS_SCALE_PCT	= 125,			/* * 125% */
-	SURPLUS_SCALE_ABS	= WEIGHT_ONE / 50,	/* + 2% */
-	SURPLUS_MIN_ADJ_DELTA	= WEIGHT_ONE / 33,	/* 3% */
-
 	/* switch iff the conditions are met for longer than this */
 	AUTOP_CYCLE_NSEC	= 10LLU * NSEC_PER_SEC,
 
@@ -376,6 +359,8 @@ struct ioc_params {
 
 struct ioc_margins {
 	s64				min;
+	s64				low;
+	s64				target;
 	s64				max;
 };
 
@@ -514,11 +499,7 @@ struct ioc_gq {
 	struct iocg_stat		desc_stat;
 	struct iocg_stat		last_stat;
 	u64				last_stat_abs_vusage;
-
-	/* usage is recorded as fractions of WEIGHT_ONE */
-	u32				usage_delta_us;
-	int				usage_idx;
-	u32				usages[NR_USAGE_SLOTS];
+	u64				usage_delta_us;
 
 	/* this iocg's depth in the hierarchy and ancestors including self */
 	int				level;
@@ -737,6 +718,8 @@ static void ioc_refresh_margins(struct ioc *ioc)
 	u64 vrate = atomic64_read(&ioc->vtime_rate);
 
 	margins->min = (period_us * MARGIN_MIN_PCT / 100) * vrate;
+	margins->low = (period_us * MARGIN_LOW_PCT / 100) * vrate;
+	margins->target = (period_us * MARGIN_TARGET_PCT / 100) * vrate;
 	margins->max = (period_us * MARGIN_MAX_PCT / 100) * vrate;
 }
 
@@ -1228,7 +1211,7 @@ static bool iocg_kick_delay(struct ioc_gq *iocg, struct ioc_now *now)
 		return false;
 	}
 	if (!atomic_read(&blkg->use_delay) &&
-	    time_before_eq64(vtime, now->vnow + ioc->margins.max))
+	    time_before_eq64(vtime, now->vnow + ioc->margins.target))
 		return false;
 
 	/* use delay */
@@ -1527,7 +1510,7 @@ static u32 hweight_after_donation(struct ioc_gq *iocg, u32 hwm, u32 usage,
 {
 	struct ioc *ioc = iocg->ioc;
 	u64 vtime = atomic64_read(&iocg->vtime);
-	s64 excess;
+	s64 excess, delta, target, new_hwi;
 
 	/* see whether minimum margin requirement is met */
 	if (waitqueue_active(&iocg->waitq) ||
@@ -1542,15 +1525,28 @@ static u32 hweight_after_donation(struct ioc_gq *iocg, u32 hwm, u32 usage,
 		vtime += excess;
 	}
 
-	/* add margin */
-	usage = DIV_ROUND_UP(usage * SURPLUS_SCALE_PCT, 100);
-	usage += SURPLUS_SCALE_ABS;
-
-	/* don't bother if the surplus is too small */
-	if (usage + SURPLUS_MIN_ADJ_DELTA > hwm)
-		return hwm;
+	/*
+	 * Let's say the distance between iocg's and device's vtimes as a
+	 * fraction of period duration is delta. Assuming that the iocg will
+	 * consume the usage determined above, we want to determine new_hwi so
+	 * that delta equals MARGIN_TARGET at the end of the next period.
+	 *
+	 * We need to execute usage worth of IOs while spending the sum of the
+	 * new budget (1 - MARGIN_TARGET) and the leftover from the last period
+	 * (delta):
+	 *
+	 *   usage = (1 - MARGIN_TARGET + delta) * new_hwi
+	 *
+	 * Therefore, the new_hwi is:
+	 *
+	 *   new_hwi = usage / (1 - MARGIN_TARGET + delta)
+	 */
+	delta = div64_s64(WEIGHT_ONE * (now->vnow - vtime),
+			  now->vnow - ioc->period_at_vtime);
+	target = WEIGHT_ONE * MARGIN_TARGET_PCT / 100;
+	new_hwi = div64_s64(WEIGHT_ONE * usage, WEIGHT_ONE - target + delta);
 
-	return usage;
+	return clamp_t(s64, new_hwi, 1, hwm);
 }
 
 /*
@@ -1812,7 +1808,7 @@ static void ioc_timer_fn(struct timer_list *timer)
 	u32 ppm_wthr = MILLION - ioc->params.qos[QOS_WPPM];
 	u32 missed_ppm[2], rq_wait_pct;
 	u64 period_vtime;
-	int prev_busy_level, i;
+	int prev_busy_level;
 
 	/* how were the latencies during the period? */
 	ioc_lat_stat(ioc, missed_ppm, &rq_wait_pct);
@@ -1857,11 +1853,10 @@ static void ioc_timer_fn(struct timer_list *timer)
 	}
 	commit_weights(ioc);
 
-	/* calc usages and see whether some weights need to be moved around */
+	/* calc usage and see whether some weights need to be moved around */
 	list_for_each_entry(iocg, &ioc->active_iocgs, active_list) {
-		u64 vdone, vtime, usage_us;
-		u32 hw_active, hw_inuse, usage;
-		int uidx, nr_valid;
+		u64 vdone, vtime, usage_us, usage_dur;
+		u32 usage, hw_active, hw_inuse;
 
 		/*
 		 * Collect unused and wind vtime closer to vnow to prevent
@@ -1886,15 +1881,11 @@ static void ioc_timer_fn(struct timer_list *timer)
 			nr_lagging++;
 
 		/*
-		 * Determine absolute usage factoring in pending and in-flight
-		 * IOs to avoid stalls and high-latency completions appearing as
-		 * idle.
+		 * Determine absolute usage factoring in in-flight IOs to avoid
+		 * high-latency completions appearing as idle.
 		 */
 		usage_us = iocg->usage_delta_us;
-		if (waitqueue_active(&iocg->waitq) && time_before64(vtime, now.vnow))
-			usage_us += DIV64_U64_ROUND_UP(
-				cost_to_abs_cost(now.vnow - vtime, hw_inuse),
-				now.vrate);
+
 		if (vdone != vtime) {
 			u64 inflight_us = DIV64_U64_ROUND_UP(
 				cost_to_abs_cost(vtime - vdone, hw_inuse),
@@ -1902,43 +1893,22 @@ static void ioc_timer_fn(struct timer_list *timer)
 			usage_us = max(usage_us, inflight_us);
 		}
 
-		/* convert to hweight based usage ratio and record */
-		uidx = (iocg->usage_idx + 1) % NR_USAGE_SLOTS;
-
-		if (time_after64(vtime, now.vnow - ioc->margins.min)) {
-			iocg->usage_idx = uidx;
-			iocg->usages[uidx] = WEIGHT_ONE;
-		} else if (usage_us) {
-			u64 started_at, dur;
-
-			if (time_after64(iocg->activated_at, ioc->period_at))
-				started_at = iocg->activated_at;
-			else
-				started_at = ioc->period_at;
-
-			dur = max_t(u64, now.now - started_at, 1);
+		/* convert to hweight based usage ratio */
+		if (time_after64(iocg->activated_at, ioc->period_at))
+			usage_dur = max_t(u64, now.now - iocg->activated_at, 1);
+		else
+			usage_dur = max_t(u64, now.now - ioc->period_at, 1);
 
-			iocg->usage_idx = uidx;
-			iocg->usages[uidx] = clamp_t(u32,
-				DIV64_U64_ROUND_UP(usage_us * WEIGHT_ONE, dur),
+		usage = clamp_t(u32,
+				DIV64_U64_ROUND_UP(usage_us * WEIGHT_ONE,
+						   usage_dur),
 				1, WEIGHT_ONE);
-		}
-
-		/* base the decision on max historical usage */
-		for (i = 0, usage = 0, nr_valid = 0; i < NR_USAGE_SLOTS; i++) {
-			if (iocg->usages[i]) {
-				usage = max(usage, iocg->usages[i]);
-				nr_valid++;
-			}
-		}
-		if (nr_valid < MIN_VALID_USAGES)
-			usage = WEIGHT_ONE;
 
 		/* see whether there's surplus vtime */
 		WARN_ON_ONCE(!list_empty(&iocg->surplus_list));
 		if (hw_inuse < hw_active ||
 		    (!waitqueue_active(&iocg->waitq) &&
-		     time_before64(vtime, now.vnow - ioc->margins.max))) {
+		     time_before64(vtime, now.vnow - ioc->margins.low))) {
 			u32 hwa, hwm, new_hwi;
 
 			/*
@@ -2175,15 +2145,14 @@ static void ioc_rqos_throttle(struct rq_qos *rqos, struct bio *bio)
 	if (!ioc->enabled || !iocg->level)
 		return;
 
-	/* always activate so that even 0 cost IOs get protected to some level */
-	if (!iocg_activate(iocg, &now))
-		return;
-
 	/* calculate the absolute vtime cost */
 	abs_cost = calc_vtime_cost(bio, iocg, false);
 	if (!abs_cost)
 		return;
 
+	if (!iocg_activate(iocg, &now))
+		return;
+
 	iocg->cursor = bio_end_sector(bio);
 
 	vtime = atomic64_read(&iocg->vtime);
-- 
2.26.2


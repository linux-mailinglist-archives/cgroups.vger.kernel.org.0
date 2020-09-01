Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75CD2259EA8
	for <lists+cgroups@lfdr.de>; Tue,  1 Sep 2020 20:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732131AbgIASzQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Sep 2020 14:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbgIASyP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Sep 2020 14:54:15 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89C4C061245;
        Tue,  1 Sep 2020 11:54:14 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id 60so1735493qtc.9;
        Tue, 01 Sep 2020 11:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ub30TeCAZwof0UjORTsGXysG7Mkcj3XZi2jYcPnWHuo=;
        b=EOFUZaMokh9VSlLVLwDg3BQQopVTEkqcrBcgAEAJPrvdFpOHJsMF5ArL0MQDPjByA2
         /7afAkwTzIlMavh50rj0mXzgsTTB94D2vgWtTRu0yxFyFiRg8iWrY0sbavaJQ+P9aNM9
         M7lMTVdR1nKWnJA9OsgYFJUbmmuPnS8QUkCc5cWN6k9R19gxPZfk8AeyrGdHvGDaiOXg
         H8Xh5QojFMVCIYUim8OtsHLtuZ6DaXY5EdRQ1gP9NK8/W3rE0nt6QxV0GO6vO3a1lSI4
         /Ok8sFHSaLUOOoT7+zDE9oDBkxXSxLoWPlOu11PUCYtqgMywE5RCyiU3PNcCorrot2ZV
         KRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ub30TeCAZwof0UjORTsGXysG7Mkcj3XZi2jYcPnWHuo=;
        b=DR65dehxN5C89jtsQnAH0bpGj0ilZjS38Bjmd0j//MlEpXEbWe+gziKl15x9dfIeCH
         Df6fNlVVsH5W26uLcQaGz+sVwdZSjbkaMg9En/4ho7q9z1c00XhL7o6ITFfj+lAElviR
         +GNInSYuty0sjPBFPkbM0qYSDSMlFacEj2LQdQpyQhCp3x7x8brykliUnDWBnfMPwxuC
         rEAoXY1/TmEAtkVY9zjkzb2vr055RsMtCyz0HXX8Cdhu3W+KXNg3TbZfsA8xuOFjsNEB
         Meisuy1HinqZSQT0MZ4N0AIYRVuh0HWR23Xn4UgE0MD7GMnxqDi1R7y8092MCsobkZ1E
         1GuQ==
X-Gm-Message-State: AOAM531jQqFkZJVf8l3xIoLHJ6Tddus2y+2MIvdK3oKum9hlDV5f1Nxd
        7m7Aq6hMQZp/JcPvC434y6s=
X-Google-Smtp-Source: ABdhPJzcdY+s0pFoRfRo3PwWsJpdkxghZE/12Mgcy3MXC6pe4QWP8xlegWAnzGVuAolTsUamIuo5pg==
X-Received: by 2002:ac8:6e99:: with SMTP id c25mr3245890qtv.324.1598986453892;
        Tue, 01 Sep 2020 11:54:13 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a198])
        by smtp.gmail.com with ESMTPSA id f13sm2457042qko.122.2020.09.01.11.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 11:54:13 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, newella@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 24/27] blk-iocost: implement vtime loss compensation
Date:   Tue,  1 Sep 2020 14:52:54 -0400
Message-Id: <20200901185257.645114-25-tj@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901185257.645114-1-tj@kernel.org>
References: <20200901185257.645114-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When an iocg accumulates too much vtime or gets deactivated, we throw away
some vtime, which lowers the overall device utilization. As the exact amount
which is being thrown away is known, we can compensate by accelerating the
vrate accordingly so that the extra vtime generated in the current period
matches what got lost.

This significantly improves work conservation when involving high weight
cgroups with intermittent and bursty IO patterns.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-iocost.c | 132 ++++++++++++++++++++++++++++++---------------
 1 file changed, 90 insertions(+), 42 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 2a95a081cf44..0270a504e6b5 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -224,20 +224,12 @@ enum {
 	MARGIN_MIN_PCT		= 10,
 	MARGIN_LOW_PCT		= 20,
 	MARGIN_TARGET_PCT	= 50,
-	MARGIN_MAX_PCT		= 100,
 
 	INUSE_ADJ_STEP_PCT	= 25,
 
 	/* Have some play in timer operations */
 	TIMER_SLACK_PCT		= 1,
 
-	/*
-	 * vtime can wrap well within a reasonable uptime when vrate is
-	 * consistently raised.  Don't trust recorded cgroup vtime if the
-	 * period counter indicates that it's older than 5mins.
-	 */
-	VTIME_VALID_DUR		= 300 * USEC_PER_SEC,
-
 	/* 1/64k is granular enough and can easily be handled w/ u32 */
 	WEIGHT_ONE		= 1 << 16,
 
@@ -395,7 +387,6 @@ struct ioc_margins {
 	s64				min;
 	s64				low;
 	s64				target;
-	s64				max;
 };
 
 struct ioc_missed {
@@ -432,6 +423,8 @@ struct ioc {
 
 	enum ioc_running		running;
 	atomic64_t			vtime_rate;
+	u64				vtime_base_rate;
+	s64				vtime_err;
 
 	seqcount_spinlock_t		period_seqcount;
 	u64				period_at;	/* wallclock starttime */
@@ -760,12 +753,11 @@ static void ioc_refresh_margins(struct ioc *ioc)
 {
 	struct ioc_margins *margins = &ioc->margins;
 	u32 period_us = ioc->period_us;
-	u64 vrate = atomic64_read(&ioc->vtime_rate);
+	u64 vrate = ioc->vtime_base_rate;
 
 	margins->min = (period_us * MARGIN_MIN_PCT / 100) * vrate;
 	margins->low = (period_us * MARGIN_LOW_PCT / 100) * vrate;
 	margins->target = (period_us * MARGIN_TARGET_PCT / 100) * vrate;
-	margins->max = (period_us * MARGIN_MAX_PCT / 100) * vrate;
 }
 
 /* latency Qos params changed, update period_us and all the dependent params */
@@ -831,8 +823,7 @@ static int ioc_autop_idx(struct ioc *ioc)
 		return idx;
 
 	/* step up/down based on the vrate */
-	vrate_pct = div64_u64(atomic64_read(&ioc->vtime_rate) * 100,
-			      VTIME_PER_USEC);
+	vrate_pct = div64_u64(ioc->vtime_base_rate * 100, VTIME_PER_USEC);
 	now_ns = ktime_get_ns();
 
 	if (p->too_fast_vrate_pct && p->too_fast_vrate_pct <= vrate_pct) {
@@ -940,6 +931,43 @@ static bool ioc_refresh_params(struct ioc *ioc, bool force)
 	return true;
 }
 
+/*
+ * When an iocg accumulates too much vtime or gets deactivated, we throw away
+ * some vtime, which lowers the overall device utilization. As the exact amount
+ * which is being thrown away is known, we can compensate by accelerating the
+ * vrate accordingly so that the extra vtime generated in the current period
+ * matches what got lost.
+ */
+static void ioc_refresh_vrate(struct ioc *ioc, struct ioc_now *now)
+{
+	s64 pleft = ioc->period_at + ioc->period_us - now->now;
+	s64 vperiod = ioc->period_us * ioc->vtime_base_rate;
+	s64 vcomp, vcomp_min, vcomp_max;
+
+	lockdep_assert_held(&ioc->lock);
+
+	/* we need some time left in this period */
+	if (pleft <= 0)
+		goto done;
+
+	/*
+	 * Calculate how much vrate should be adjusted to offset the error.
+	 * Limit the amount of adjustment and deduct the adjusted amount from
+	 * the error.
+	 */
+	vcomp = -div64_s64(ioc->vtime_err, pleft);
+	vcomp_min = -(ioc->vtime_base_rate >> 1);
+	vcomp_max = ioc->vtime_base_rate;
+	vcomp = clamp(vcomp, vcomp_min, vcomp_max);
+
+	ioc->vtime_err += vcomp * pleft;
+
+	atomic64_set(&ioc->vtime_rate, ioc->vtime_base_rate + vcomp);
+done:
+	/* bound how much error can accumulate */
+	ioc->vtime_err = clamp(ioc->vtime_err, -vperiod, vperiod);
+}
+
 /* take a snapshot of the current [v]time and vrate */
 static void ioc_now(struct ioc *ioc, struct ioc_now *now)
 {
@@ -1152,8 +1180,8 @@ static void weight_updated(struct ioc_gq *iocg, struct ioc_now *now)
 static bool iocg_activate(struct ioc_gq *iocg, struct ioc_now *now)
 {
 	struct ioc *ioc = iocg->ioc;
-	u64 last_period, cur_period, max_period_delta;
-	u64 vtime, vmin;
+	u64 last_period, cur_period;
+	u64 vtime, vtarget;
 	int i;
 
 	/*
@@ -1192,21 +1220,15 @@ static bool iocg_activate(struct ioc_gq *iocg, struct ioc_now *now)
 		goto fail_unlock;
 
 	/*
-	 * vtime may wrap when vrate is raised substantially due to
-	 * underestimated IO costs.  Look at the period and ignore its
-	 * vtime if the iocg has been idle for too long.  Also, cap the
-	 * budget it can start with to the margin.
+	 * Always start with the target budget. On deactivation, we throw away
+	 * anything above it.
 	 */
-	max_period_delta = DIV64_U64_ROUND_UP(VTIME_VALID_DUR, ioc->period_us);
+	vtarget = now->vnow - ioc->margins.target;
 	vtime = atomic64_read(&iocg->vtime);
-	vmin = now->vnow - ioc->margins.max;
 
-	if (last_period + max_period_delta < cur_period ||
-	    time_before64(vtime, vmin)) {
-		atomic64_add(vmin - vtime, &iocg->vtime);
-		atomic64_add(vmin - vtime, &iocg->done_vtime);
-		vtime = vmin;
-	}
+	atomic64_add(vtarget - vtime, &iocg->vtime);
+	atomic64_add(vtarget - vtime, &iocg->done_vtime);
+	vtime = vtarget;
 
 	/*
 	 * Activate, propagate weight and start period timer if not
@@ -1260,7 +1282,8 @@ static bool iocg_kick_delay(struct ioc_gq *iocg, struct ioc_now *now)
 	current_hweight(iocg, &hwa, NULL);
 	vover = atomic64_read(&iocg->vtime) +
 		abs_cost_to_cost(iocg->abs_vdebt, hwa) - now->vnow;
-	vover_pct = div64_s64(100 * vover, ioc->period_us * now->vrate);
+	vover_pct = div64_s64(100 * vover,
+			      ioc->period_us * ioc->vtime_base_rate);
 
 	if (vover_pct <= MIN_DELAY_THR_PCT)
 		new_delay = 0;
@@ -1421,7 +1444,8 @@ static void iocg_kick_waitq(struct ioc_gq *iocg, bool pay_debt,
 	/* determine next wakeup, add a timer margin to guarantee chunking */
 	vshortage = -ctx.vbudget;
 	expires = now->now_ns +
-		DIV64_U64_ROUND_UP(vshortage, now->vrate) * NSEC_PER_USEC;
+		DIV64_U64_ROUND_UP(vshortage, ioc->vtime_base_rate) *
+		NSEC_PER_USEC;
 	expires += ioc->timer_slack_ns;
 
 	/* if already active and close enough, don't bother */
@@ -1536,6 +1560,7 @@ static void iocg_build_inner_walk(struct ioc_gq *iocg,
 /* collect per-cpu counters and propagate the deltas to the parent */
 static void iocg_flush_stat_one(struct ioc_gq *iocg, struct ioc_now *now)
 {
+	struct ioc *ioc = iocg->ioc;
 	struct iocg_stat new_stat;
 	u64 abs_vusage = 0;
 	u64 vusage_delta;
@@ -1551,7 +1576,7 @@ static void iocg_flush_stat_one(struct ioc_gq *iocg, struct ioc_now *now)
 	vusage_delta = abs_vusage - iocg->last_stat_abs_vusage;
 	iocg->last_stat_abs_vusage = abs_vusage;
 
-	iocg->usage_delta_us = div64_u64(vusage_delta, now->vrate);
+	iocg->usage_delta_us = div64_u64(vusage_delta, ioc->vtime_base_rate);
 	iocg->local_stat.usage_us += iocg->usage_delta_us;
 
 	new_stat.usage_us =
@@ -1593,8 +1618,8 @@ static void iocg_flush_stat(struct list_head *target_iocgs, struct ioc_now *now)
  * capacity. @hwm is the upper bound and used to signal no donation. This
  * function also throws away @iocg's excess budget.
  */
-static u32 hweight_after_donation(struct ioc_gq *iocg, u32 hwm, u32 usage,
-				  struct ioc_now *now)
+static u32 hweight_after_donation(struct ioc_gq *iocg, u32 old_hwi, u32 hwm,
+				  u32 usage, struct ioc_now *now)
 {
 	struct ioc *ioc = iocg->ioc;
 	u64 vtime = atomic64_read(&iocg->vtime);
@@ -1609,12 +1634,13 @@ static u32 hweight_after_donation(struct ioc_gq *iocg, u32 hwm, u32 usage,
 	    time_after64(vtime, now->vnow - ioc->margins.min))
 		return hwm;
 
-	/* throw away excess above max */
-	excess = now->vnow - vtime - ioc->margins.max;
+	/* throw away excess above target */
+	excess = now->vnow - vtime - ioc->margins.target;
 	if (excess > 0) {
 		atomic64_add(excess, &iocg->vtime);
 		atomic64_add(excess, &iocg->done_vtime);
 		vtime += excess;
+		ioc->vtime_err -= div64_u64(excess * old_hwi, WEIGHT_ONE);
 	}
 
 	/*
@@ -1952,6 +1978,24 @@ static void ioc_timer_fn(struct timer_list *timer)
 				nr_debtors++;
 		} else if (iocg_is_idle(iocg)) {
 			/* no waiter and idle, deactivate */
+			u64 vtime = atomic64_read(&iocg->vtime);
+			s64 excess;
+
+			/*
+			 * @iocg has been inactive for a full duration and will
+			 * have a high budget. Account anything above target as
+			 * error and throw away. On reactivation, it'll start
+			 * with the target budget.
+			 */
+			excess = now.vnow - vtime - ioc->margins.target;
+			if (excess > 0) {
+				u32 old_hwi;
+
+				current_hweight(iocg, NULL, &old_hwi);
+				ioc->vtime_err -= div64_u64(excess * old_hwi,
+							    WEIGHT_ONE);
+			}
+
 			__propagate_weights(iocg, 0, 0, false, &now);
 			list_del_init(&iocg->active_list);
 		}
@@ -1997,7 +2041,7 @@ static void ioc_timer_fn(struct timer_list *timer)
 		if (vdone != vtime) {
 			u64 inflight_us = DIV64_U64_ROUND_UP(
 				cost_to_abs_cost(vtime - vdone, hw_inuse),
-				now.vrate);
+				ioc->vtime_base_rate);
 			usage_us = max(usage_us, inflight_us);
 		}
 
@@ -2017,16 +2061,16 @@ static void ioc_timer_fn(struct timer_list *timer)
 		if (hw_inuse < hw_active ||
 		    (!waitqueue_active(&iocg->waitq) &&
 		     time_before64(vtime, now.vnow - ioc->margins.low))) {
-			u32 hwa, hwm, new_hwi;
+			u32 hwa, old_hwi, hwm, new_hwi;
 
 			/*
 			 * Already donating or accumulated enough to start.
 			 * Determine the donation amount.
 			 */
-			current_hweight(iocg, &hwa, NULL);
+			current_hweight(iocg, &hwa, &old_hwi);
 			hwm = current_hweight_max(iocg);
-			new_hwi = hweight_after_donation(iocg, hwm, usage,
-							 &now);
+			new_hwi = hweight_after_donation(iocg, old_hwi, hwm,
+							 usage, &now);
 			if (new_hwi < hwm) {
 				iocg->hweight_donating = hwa;
 				iocg->hweight_after_donation = new_hwi;
@@ -2130,7 +2174,7 @@ static void ioc_timer_fn(struct timer_list *timer)
 	ioc->busy_level = clamp(ioc->busy_level, -1000, 1000);
 
 	if (ioc->busy_level > 0 || (ioc->busy_level < 0 && !nr_lagging)) {
-		u64 vrate = atomic64_read(&ioc->vtime_rate);
+		u64 vrate = ioc->vtime_base_rate;
 		u64 vrate_min = ioc->vrate_min, vrate_max = ioc->vrate_max;
 
 		/* rq_wait signal is always reliable, ignore user vrate_min */
@@ -2167,7 +2211,7 @@ static void ioc_timer_fn(struct timer_list *timer)
 		trace_iocost_ioc_vrate_adj(ioc, vrate, missed_ppm, rq_wait_pct,
 					   nr_lagging, nr_shortages);
 
-		atomic64_set(&ioc->vtime_rate, vrate);
+		ioc->vtime_base_rate = vrate;
 		ioc_refresh_margins(ioc);
 	} else if (ioc->busy_level != prev_busy_level || nr_lagging) {
 		trace_iocost_ioc_vrate_adj(ioc, atomic64_read(&ioc->vtime_rate),
@@ -2188,8 +2232,11 @@ static void ioc_timer_fn(struct timer_list *timer)
 			ioc_start_period(ioc, &now);
 		} else {
 			ioc->busy_level = 0;
+			ioc->vtime_err = 0;
 			ioc->running = IOC_IDLE;
 		}
+
+		ioc_refresh_vrate(ioc, &now);
 	}
 
 	spin_unlock_irq(&ioc->lock);
@@ -2628,6 +2675,7 @@ static int blk_iocost_init(struct request_queue *q)
 	INIT_LIST_HEAD(&ioc->active_iocgs);
 
 	ioc->running = IOC_IDLE;
+	ioc->vtime_base_rate = VTIME_PER_USEC;
 	atomic64_set(&ioc->vtime_rate, VTIME_PER_USEC);
 	seqcount_spinlock_init(&ioc->period_seqcount, &ioc->lock);
 	ioc->period_at = ktime_to_us(ktime_get());
@@ -2762,7 +2810,7 @@ static size_t ioc_pd_stat(struct blkg_policy_data *pd, char *buf, size_t size)
 
 	if (iocg->level == 0) {
 		unsigned vp10k = DIV64_U64_ROUND_CLOSEST(
-			atomic64_read(&ioc->vtime_rate) * 10000,
+			ioc->vtime_base_rate * 10000,
 			VTIME_PER_USEC);
 		pos += scnprintf(buf + pos, size - pos, " cost.vrate=%u.%02u",
 				  vp10k / 100, vp10k % 100);
-- 
2.26.2


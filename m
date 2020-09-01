Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E65A259EBB
	for <lists+cgroups@lfdr.de>; Tue,  1 Sep 2020 20:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731532AbgIAS4I (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Sep 2020 14:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729044AbgIASxj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Sep 2020 14:53:39 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E20C061244;
        Tue,  1 Sep 2020 11:53:38 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id g72so1994941qke.8;
        Tue, 01 Sep 2020 11:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xcYuTvF8Ohy5zqCuYMaFIj11Q2zNsOBhOJ0SKfeowWw=;
        b=U472/xr30n+SbYC13Z1ABZBICXE1a3uAeOZy4m9jfXvJ0GEn/+mmArddjWTHxfpc+T
         rPR8A7BR6WeTjug0pzT2S6Rgd7Tp5CS/eTH1SrSHqv6V/l1kZU2NtLemgBBOs2YtTPji
         y7pEcOOB6Dj01Px9M7V1Mv6SzlcY9rDk/fL0oqjvmRoHA+lXcBd8Si6IAVviWA1J337Y
         fPL3knFHOZao5V+4G5XWX65be0veARsi7FmjeRbtLhRjkbo0VRQA4Va0mFqnc7gT//oz
         1sgbxCh6XENhPrFl9UIvHaUIzsUB/PFcM0HnTM1EPrkBtHlr4Tnr3U2sZaSk2nsdw1aH
         rDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=xcYuTvF8Ohy5zqCuYMaFIj11Q2zNsOBhOJ0SKfeowWw=;
        b=iMWRULyudiveuicZyHNbnNcJ1YfuDofBxgoAydh+tEysFwNXsDKjbu3+vrhJ+lY09+
         X1484zTbL74dpFymsuLgF21pgLvZgW35+/uMMT08PWuryHBloT/vO9wxowObZc0EB2z9
         KgKBINQYIzW16t5XNmZMDkVQNwcGY7lTbHCQe5nIlWqFa61vyvLDI4TdFCmp68Kzqwyr
         B9fBRobB96z3wzHRXvdRtcj+PcEJVoQZH/AbVV78pEsephEzbYOQHx1tUMf9/ute0X91
         kGROkjN7CMjXpr+oxB5eaBdt85QDDweqo8Og+aNizZrPgPEWPcH4iKGmlEafCKgIJ02x
         EnjQ==
X-Gm-Message-State: AOAM531/4qxKfablc1kqnnVojE4DIoMFaY1NPx9HCUPmRNhjf7qkQiPF
        dP0SjTxE7vs3V6/oheFnhmQ=
X-Google-Smtp-Source: ABdhPJyeg7Zc6ub4xIR78TrlT1VcwiTxulMa2rR/4B9uimCW1OKTIRkFRkroDOreZHD1NXp/Nwhh6A==
X-Received: by 2002:a05:620a:211b:: with SMTP id l27mr41243qkl.56.1598986418000;
        Tue, 01 Sep 2020 11:53:38 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a198])
        by smtp.gmail.com with ESMTPSA id a3sm2427898qtj.21.2020.09.01.11.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 11:53:37 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, newella@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 11/27] blk-iocost: streamline vtime margin and timer slack handling
Date:   Tue,  1 Sep 2020 14:52:41 -0400
Message-Id: <20200901185257.645114-12-tj@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901185257.645114-1-tj@kernel.org>
References: <20200901185257.645114-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The margin handling was pretty inconsistent.

* ioc->margin_us and ioc->inuse_margin_vtime were used as vtime margin
  thresholds. However, the two are in different units with the former
  requiring conversion to vtime on use.

* iocg_kick_waitq() was using a quarter of WAITQ_TIMER_MARGIN_PCT of
  period_us as the timer slack - ~1.2%. While iocg_kick_delay() was using a
  quarter of ioc->margin_us - ~12.5%. There aren't strong reasons to use
  different values for the two.

This patch cleans up margin and timer slack handling:

* vtime margins are now recorded in ioc->margins.{min, max} on period
  duration changes and used consistently.

* Timer slack is now 1% of period_us and recorded in ioc->timer_slack_ns and
  used consistently for iocg_kick_waitq() and iocg_kick_delay().

The only functional change is shortening of timer slack. No meaningful
visible change is expected.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-iocost.c | 67 ++++++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 29 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index dc72cd965837..f36988657594 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -221,11 +221,11 @@ enum {
 	 * serves as its IO credit buffer.  Surplus weight adjustment is
 	 * immediately canceled if the vtime margin runs below 10%.
 	 */
-	MARGIN_PCT		= 50,
-	INUSE_MARGIN_PCT	= 10,
+	MARGIN_MIN_PCT		= 10,
+	MARGIN_MAX_PCT		= 50,
 
-	/* Have some play in waitq timer operations */
-	WAITQ_TIMER_MARGIN_PCT	= 5,
+	/* Have some play in timer operations */
+	TIMER_SLACK_PCT		= 1,
 
 	/*
 	 * vtime can wrap well within a reasonable uptime when vrate is
@@ -374,6 +374,11 @@ struct ioc_params {
 	u32				too_slow_vrate_pct;
 };
 
+struct ioc_margins {
+	s64				min;
+	s64				max;
+};
+
 struct ioc_missed {
 	local_t				nr_met;
 	local_t				nr_missed;
@@ -395,8 +400,9 @@ struct ioc {
 	bool				enabled;
 
 	struct ioc_params		params;
+	struct ioc_margins		margins;
 	u32				period_us;
-	u32				margin_us;
+	u32				timer_slack_ns;
 	u64				vrate_min;
 	u64				vrate_max;
 
@@ -415,7 +421,6 @@ struct ioc {
 	atomic64_t			cur_period;	/* inc'd each period */
 	int				busy_level;	/* saturation history */
 
-	u64				inuse_margin_vtime;
 	bool				weights_updated;
 	atomic_t			hweight_gen;	/* for lazy hweights */
 
@@ -678,6 +683,16 @@ static void iocg_commit_bio(struct ioc_gq *iocg, struct bio *bio, u64 cost)
 #define CREATE_TRACE_POINTS
 #include <trace/events/iocost.h>
 
+static void ioc_refresh_margins(struct ioc *ioc)
+{
+	struct ioc_margins *margins = &ioc->margins;
+	u32 period_us = ioc->period_us;
+	u64 vrate = atomic64_read(&ioc->vtime_rate);
+
+	margins->min = (period_us * MARGIN_MIN_PCT / 100) * vrate;
+	margins->max = (period_us * MARGIN_MAX_PCT / 100) * vrate;
+}
+
 /* latency Qos params changed, update period_us and all the dependent params */
 static void ioc_refresh_period_us(struct ioc *ioc)
 {
@@ -711,9 +726,10 @@ static void ioc_refresh_period_us(struct ioc *ioc)
 
 	/* calculate dependent params */
 	ioc->period_us = period_us;
-	ioc->margin_us = period_us * MARGIN_PCT / 100;
-	ioc->inuse_margin_vtime = DIV64_U64_ROUND_UP(
-			period_us * VTIME_PER_USEC * INUSE_MARGIN_PCT, 100);
+	ioc->timer_slack_ns = div64_u64(
+		(u64)period_us * NSEC_PER_USEC * TIMER_SLACK_PCT,
+		100);
+	ioc_refresh_margins(ioc);
 }
 
 static int ioc_autop_idx(struct ioc *ioc)
@@ -1031,7 +1047,7 @@ static bool iocg_activate(struct ioc_gq *iocg, struct ioc_now *now)
 {
 	struct ioc *ioc = iocg->ioc;
 	u64 last_period, cur_period, max_period_delta;
-	u64 vtime, vmargin, vmin;
+	u64 vtime, vmin;
 	int i;
 
 	/*
@@ -1077,8 +1093,7 @@ static bool iocg_activate(struct ioc_gq *iocg, struct ioc_now *now)
 	 */
 	max_period_delta = DIV64_U64_ROUND_UP(VTIME_VALID_DUR, ioc->period_us);
 	vtime = atomic64_read(&iocg->vtime);
-	vmargin = ioc->margin_us * now->vrate;
-	vmin = now->vnow - vmargin;
+	vmin = now->vnow - ioc->margins.max;
 
 	if (last_period + max_period_delta < cur_period ||
 	    time_before64(vtime, vmin)) {
@@ -1121,8 +1136,6 @@ static bool iocg_kick_delay(struct ioc_gq *iocg, struct ioc_now *now)
 	struct ioc *ioc = iocg->ioc;
 	struct blkcg_gq *blkg = iocg_to_blkg(iocg);
 	u64 vtime = atomic64_read(&iocg->vtime);
-	u64 vmargin = ioc->margin_us * now->vrate;
-	u64 margin_ns = ioc->margin_us * NSEC_PER_USEC;
 	u64 delta_ns, expires, oexpires;
 	u32 hw_inuse;
 
@@ -1142,7 +1155,7 @@ static bool iocg_kick_delay(struct ioc_gq *iocg, struct ioc_now *now)
 		return false;
 	}
 	if (!atomic_read(&blkg->use_delay) &&
-	    time_before_eq64(vtime, now->vnow + vmargin))
+	    time_before_eq64(vtime, now->vnow + ioc->margins.max))
 		return false;
 
 	/* use delay */
@@ -1154,11 +1167,11 @@ static bool iocg_kick_delay(struct ioc_gq *iocg, struct ioc_now *now)
 	/* if already active and close enough, don't bother */
 	oexpires = ktime_to_ns(hrtimer_get_softexpires(&iocg->delay_timer));
 	if (hrtimer_is_queued(&iocg->delay_timer) &&
-	    abs(oexpires - expires) <= margin_ns / 4)
+	    abs(oexpires - expires) <= ioc->timer_slack_ns)
 		return true;
 
 	hrtimer_start_range_ns(&iocg->delay_timer, ns_to_ktime(expires),
-			       margin_ns / 4, HRTIMER_MODE_ABS);
+			       ioc->timer_slack_ns, HRTIMER_MODE_ABS);
 	return true;
 }
 
@@ -1206,8 +1219,6 @@ static void iocg_kick_waitq(struct ioc_gq *iocg, struct ioc_now *now)
 {
 	struct ioc *ioc = iocg->ioc;
 	struct iocg_wake_ctx ctx = { .iocg = iocg };
-	u64 margin_ns = (u64)(ioc->period_us *
-			      WAITQ_TIMER_MARGIN_PCT / 100) * NSEC_PER_USEC;
 	u64 vdebt, vshortage, expires, oexpires;
 	s64 vbudget;
 	u32 hw_inuse;
@@ -1243,20 +1254,20 @@ static void iocg_kick_waitq(struct ioc_gq *iocg, struct ioc_now *now)
 	if (WARN_ON_ONCE(ctx.vbudget >= 0))
 		return;
 
-	/* determine next wakeup, add a quarter margin to guarantee chunking */
+	/* determine next wakeup, add a timer margin to guarantee chunking */
 	vshortage = -ctx.vbudget;
 	expires = now->now_ns +
 		DIV64_U64_ROUND_UP(vshortage, now->vrate) * NSEC_PER_USEC;
-	expires += margin_ns / 4;
+	expires += ioc->timer_slack_ns;
 
 	/* if already active and close enough, don't bother */
 	oexpires = ktime_to_ns(hrtimer_get_softexpires(&iocg->waitq_timer));
 	if (hrtimer_is_queued(&iocg->waitq_timer) &&
-	    abs(oexpires - expires) <= margin_ns / 4)
+	    abs(oexpires - expires) <= ioc->timer_slack_ns)
 		return;
 
 	hrtimer_start_range_ns(&iocg->waitq_timer, ns_to_ktime(expires),
-			       margin_ns / 4, HRTIMER_MODE_ABS);
+			       ioc->timer_slack_ns, HRTIMER_MODE_ABS);
 }
 
 static enum hrtimer_restart iocg_waitq_timer_fn(struct hrtimer *timer)
@@ -1399,7 +1410,7 @@ static void ioc_timer_fn(struct timer_list *timer)
 
 	/* calc usages and see whether some weights need to be moved around */
 	list_for_each_entry(iocg, &ioc->active_iocgs, active_list) {
-		u64 vdone, vtime, vusage, vmargin, vmin;
+		u64 vdone, vtime, vusage, vmin;
 		u32 hw_active, hw_inuse, usage;
 
 		/*
@@ -1450,8 +1461,7 @@ static void ioc_timer_fn(struct timer_list *timer)
 		}
 
 		/* see whether there's surplus vtime */
-		vmargin = ioc->margin_us * now.vrate;
-		vmin = now.vnow - vmargin;
+		vmin = now.vnow - ioc->margins.max;
 
 		iocg->has_surplus = false;
 
@@ -1623,8 +1633,7 @@ static void ioc_timer_fn(struct timer_list *timer)
 					   nr_surpluses);
 
 		atomic64_set(&ioc->vtime_rate, vrate);
-		ioc->inuse_margin_vtime = DIV64_U64_ROUND_UP(
-			ioc->period_us * vrate * INUSE_MARGIN_PCT, 100);
+		ioc_refresh_margins(ioc);
 	} else if (ioc->busy_level != prev_busy_level || nr_lagging) {
 		trace_iocost_ioc_vrate_adj(ioc, atomic64_read(&ioc->vtime_rate),
 					   missed_ppm, rq_wait_pct, nr_lagging,
@@ -1754,7 +1763,7 @@ static void ioc_rqos_throttle(struct rq_qos *rqos, struct bio *bio)
 	current_hweight(iocg, &hw_active, &hw_inuse);
 
 	if (hw_inuse < hw_active &&
-	    time_after_eq64(vtime + ioc->inuse_margin_vtime, now.vnow)) {
+	    time_after_eq64(vtime + ioc->margins.min, now.vnow)) {
 		TRACE_IOCG_PATH(inuse_reset, iocg, &now,
 				iocg->inuse, iocg->weight, hw_inuse, hw_active);
 		spin_lock_irq(&ioc->lock);
-- 
2.26.2


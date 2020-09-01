Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8526F259EA3
	for <lists+cgroups@lfdr.de>; Tue,  1 Sep 2020 20:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732177AbgIASzR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Sep 2020 14:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731873AbgIASyJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Sep 2020 14:54:09 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A875C061244;
        Tue,  1 Sep 2020 11:54:09 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id p65so1752064qtd.2;
        Tue, 01 Sep 2020 11:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/gDenaieQk48kIz1Dxz8dwvYLvZzUa/DeKiS9toAb8Q=;
        b=I4fY2NLjgj8385ru65Sz82/4IM7JXkJS+IiDLhMZnRa1Tm8osQSWfk67eSJlTm0WCY
         RsfNgkUCYEO9BIV5hOX7ClROxm8cXDqwo4JYghrGukEbGm5zv8EZYPJxaR5UtjOLjoJg
         xqtq9gC8dlItEeFrQU1a2LRw96Nu5Uc56fCWikDtVpDQUeZZbo9dqnCNao0Eim+yNIcF
         2/slpMVry900hho5fv/duDhqzbmF1mqk62JCtK2uFZc9Nl7iUmbU3ovM+aWZBSM9yL3W
         MMJfzTCvrZDbnLQlc2axXonMngqhlvUpEy4UT+5pD3vP9xzfTSAKRt9ZEiyGnFEyEZOM
         o7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=/gDenaieQk48kIz1Dxz8dwvYLvZzUa/DeKiS9toAb8Q=;
        b=I7V7CC+046XltnR1ogUsWN7gZO+UwLPurb0gQzy5tG5ke+7CRyay2gqjueC7U6jVuo
         /tUsSgtqCuKH11Igyuc9aobHSJTJYf7UQRgTaCdp9BKxf/aZJIkzZ1mhYAqMWjoeRADy
         9izZjw39wQSwEbf/Sae+hOGphGDdP1rEcNAgMjOdx5BwTB8+6TIwUElRy5in6UZs0msZ
         l4Pb0sjbFkm9Bv5AmJ/atwwvJZ/lTHAog94kxXnxbowxHjoEuPYmelHfPR3EnhTZrruW
         XxqsSTPLtxJypZCnhJbGwvEE3hjwKVOdWcGeZkOVEi7/BD9Uj3ZbHyXECaYkxWR1/not
         +72Q==
X-Gm-Message-State: AOAM532GUhCuhxNNQHlKgi16TpxoPWbluv7cmQl25d8+VtxL+oSlLXTy
        4+aY8e97n9Bm3PIMalvO+HY=
X-Google-Smtp-Source: ABdhPJy9ioj3LNs/HrM9mnBi6yF6W8z59cw20fGMRsDxSKvZBP4vdISCIzUgLsVvF+WfcFZzzEX0Ww==
X-Received: by 2002:ac8:6d0e:: with SMTP id o14mr3197641qtt.31.1598986448233;
        Tue, 01 Sep 2020 11:54:08 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a198])
        by smtp.gmail.com with ESMTPSA id i66sm2672276qkc.63.2020.09.01.11.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 11:54:07 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, newella@fb.com,
        Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 22/27] blk-iocost: implement delay adjustment hysteresis
Date:   Tue,  1 Sep 2020 14:52:52 -0400
Message-Id: <20200901185257.645114-23-tj@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901185257.645114-1-tj@kernel.org>
References: <20200901185257.645114-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Curently, iocost syncs the delay duration to the outstanding debt amount,
which seemed enough to protect the system from anon memory hogs. However,
that was mostly because the delay calcuation was using hweight_inuse which
quickly converges towards zero under debt for delay duration calculation,
often pusnishing debtors overly harshly for longer than deserved.

The previous patch fixed the delay calcuation and now the protection against
anonymous memory hogs isn't enough because the effect of delay is indirect
and non-linear and a huge amount of future debt can accumulate abruptly
while unthrottled.

This patch implements delay hysteresis so that delay is decayed
exponentially over time instead of getting cleared immediately as debt is
paid off. While the overall behavior is similar to the blk-cgroup
implementation used by blk-iolatency, a lot of the details are different and
due to the empirical nature of the mechanism, it's challenging to adapt the
mechanism for one controller without negatively impacting the other.

As the delay is gradually decayed now, there's no point in running it from
its own hrtimer. Periodic updates are now performed from ioc_timer_fn() and
the dedicated hrtimer is removed.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-cgroup.c |  23 ++++++---
 block/blk-iocost.c | 119 ++++++++++++++++++++++++++-------------------
 2 files changed, 86 insertions(+), 56 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index c195365c9817..d33dd6be1d9c 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1613,16 +1613,24 @@ static void blkcg_scale_delay(struct blkcg_gq *blkg, u64 now)
 static void blkcg_maybe_throttle_blkg(struct blkcg_gq *blkg, bool use_memdelay)
 {
 	unsigned long pflags;
+	bool clamp;
 	u64 now = ktime_to_ns(ktime_get());
 	u64 exp;
 	u64 delay_nsec = 0;
 	int tok;
 
 	while (blkg->parent) {
-		if (atomic_read(&blkg->use_delay)) {
+		int use_delay = atomic_read(&blkg->use_delay);
+
+		if (use_delay) {
+			u64 this_delay;
+
 			blkcg_scale_delay(blkg, now);
-			delay_nsec = max_t(u64, delay_nsec,
-					   atomic64_read(&blkg->delay_nsec));
+			this_delay = atomic64_read(&blkg->delay_nsec);
+			if (this_delay > delay_nsec) {
+				delay_nsec = this_delay;
+				clamp = use_delay > 0;
+			}
 		}
 		blkg = blkg->parent;
 	}
@@ -1634,10 +1642,13 @@ static void blkcg_maybe_throttle_blkg(struct blkcg_gq *blkg, bool use_memdelay)
 	 * Let's not sleep for all eternity if we've amassed a huge delay.
 	 * Swapping or metadata IO can accumulate 10's of seconds worth of
 	 * delay, and we want userspace to be able to do _something_ so cap the
-	 * delays at 1 second.  If there's 10's of seconds worth of delay then
-	 * the tasks will be delayed for 1 second for every syscall.
+	 * delays at 0.25s. If there's 10's of seconds worth of delay then the
+	 * tasks will be delayed for 0.25 second for every syscall. If
+	 * blkcg_set_delay() was used as indicated by negative use_delay, the
+	 * caller is responsible for regulating the range.
 	 */
-	delay_nsec = min_t(u64, delay_nsec, 250 * NSEC_PER_MSEC);
+	if (clamp)
+		delay_nsec = min_t(u64, delay_nsec, 250 * NSEC_PER_MSEC);
 
 	if (use_memdelay)
 		psi_memstall_enter(&pflags);
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index d2b69d87f3e7..9cb8f29f01f5 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -270,6 +270,31 @@ enum {
 	/* unbusy hysterisis */
 	UNBUSY_THR_PCT		= 75,
 
+	/*
+	 * The effect of delay is indirect and non-linear and a huge amount of
+	 * future debt can accumulate abruptly while unthrottled. Linearly scale
+	 * up delay as debt is going up and then let it decay exponentially.
+	 * This gives us quick ramp ups while delay is accumulating and long
+	 * tails which can help reducing the frequency of debt explosions on
+	 * unthrottle. The parameters are experimentally determined.
+	 *
+	 * The delay mechanism provides adequate protection and behavior in many
+	 * cases. However, this is far from ideal and falls shorts on both
+	 * fronts. The debtors are often throttled too harshly costing a
+	 * significant level of fairness and possibly total work while the
+	 * protection against their impacts on the system can be choppy and
+	 * unreliable.
+	 *
+	 * The shortcoming primarily stems from the fact that, unlike for page
+	 * cache, the kernel doesn't have well-defined back-pressure propagation
+	 * mechanism and policies for anonymous memory. Fully addressing this
+	 * issue will likely require substantial improvements in the area.
+	 */
+	MIN_DELAY_THR_PCT	= 500,
+	MAX_DELAY_THR_PCT	= 25000,
+	MIN_DELAY		= 250,
+	MAX_DELAY		= 250 * USEC_PER_MSEC,
+
 	/* don't let cmds which take a very long time pin lagging for too long */
 	MAX_LAGGING_PERIODS	= 10,
 
@@ -473,6 +498,10 @@ struct ioc_gq {
 	atomic64_t			done_vtime;
 	u64				abs_vdebt;
 
+	/* current delay in effect and when it started */
+	u64				delay;
+	u64				delay_at;
+
 	/*
 	 * The period this iocg was last active in.  Used for deactivation
 	 * and invalidating `vtime`.
@@ -495,7 +524,6 @@ struct ioc_gq {
 
 	struct wait_queue_head		waitq;
 	struct hrtimer			waitq_timer;
-	struct hrtimer			delay_timer;
 
 	/* timestamp at the latest activation */
 	u64				activated_at;
@@ -1204,58 +1232,50 @@ static bool iocg_kick_delay(struct ioc_gq *iocg, struct ioc_now *now)
 {
 	struct ioc *ioc = iocg->ioc;
 	struct blkcg_gq *blkg = iocg_to_blkg(iocg);
-	u64 vtime = atomic64_read(&iocg->vtime);
-	u64 delta_ns, expires, oexpires;
+	u64 tdelta, delay, new_delay;
+	s64 vover, vover_pct;
 	u32 hwa;
 
 	lockdep_assert_held(&iocg->waitq.lock);
 
-	/* debt-adjust vtime */
+	/* calculate the current delay in effect - 1/2 every second */
+	tdelta = now->now - iocg->delay_at;
+	if (iocg->delay)
+		delay = iocg->delay >> div64_u64(tdelta, USEC_PER_SEC);
+	else
+		delay = 0;
+
+	/* calculate the new delay from the debt amount */
 	current_hweight(iocg, &hwa, NULL);
-	vtime += abs_cost_to_cost(iocg->abs_vdebt, hwa);
+	vover = atomic64_read(&iocg->vtime) +
+		abs_cost_to_cost(iocg->abs_vdebt, hwa) - now->vnow;
+	vover_pct = div64_s64(100 * vover, ioc->period_us * now->vrate);
+
+	if (vover_pct <= MIN_DELAY_THR_PCT)
+		new_delay = 0;
+	else if (vover_pct >= MAX_DELAY_THR_PCT)
+		new_delay = MAX_DELAY;
+	else
+		new_delay = MIN_DELAY +
+			div_u64((MAX_DELAY - MIN_DELAY) *
+				(vover_pct - MIN_DELAY_THR_PCT),
+				MAX_DELAY_THR_PCT - MIN_DELAY_THR_PCT);
 
-	/*
-	 * Clear or maintain depending on the overage. Non-zero vdebt is what
-	 * guarantees that @iocg is online and future iocg_kick_delay() will
-	 * clear use_delay. Don't leave it on when there's no vdebt.
-	 */
-	if (!iocg->abs_vdebt || time_before_eq64(vtime, now->vnow)) {
-		blkcg_clear_delay(blkg);
-		return false;
+	/* pick the higher one and apply */
+	if (new_delay > delay) {
+		iocg->delay = new_delay;
+		iocg->delay_at = now->now;
+		delay = new_delay;
 	}
-	if (!atomic_read(&blkg->use_delay) &&
-	    time_before_eq64(vtime, now->vnow + ioc->margins.target))
-		return false;
-
-	/* use delay */
-	delta_ns = DIV64_U64_ROUND_UP(vtime - now->vnow,
-				      now->vrate) * NSEC_PER_USEC;
-	blkcg_set_delay(blkg, delta_ns);
-	expires = now->now_ns + delta_ns;
 
-	/* if already active and close enough, don't bother */
-	oexpires = ktime_to_ns(hrtimer_get_softexpires(&iocg->delay_timer));
-	if (hrtimer_is_queued(&iocg->delay_timer) &&
-	    abs(oexpires - expires) <= ioc->timer_slack_ns)
+	if (delay >= MIN_DELAY) {
+		blkcg_set_delay(blkg, delay * NSEC_PER_USEC);
 		return true;
-
-	hrtimer_start_range_ns(&iocg->delay_timer, ns_to_ktime(expires),
-			       ioc->timer_slack_ns, HRTIMER_MODE_ABS);
-	return true;
-}
-
-static enum hrtimer_restart iocg_delay_timer_fn(struct hrtimer *timer)
-{
-	struct ioc_gq *iocg = container_of(timer, struct ioc_gq, delay_timer);
-	struct ioc_now now;
-	unsigned long flags;
-
-	spin_lock_irqsave(&iocg->waitq.lock, flags);
-	ioc_now(iocg->ioc, &now);
-	iocg_kick_delay(iocg, &now);
-	spin_unlock_irqrestore(&iocg->waitq.lock, flags);
-
-	return HRTIMER_NORESTART;
+	} else {
+		iocg->delay = 0;
+		blkcg_clear_delay(blkg);
+		return false;
+	}
 }
 
 static void iocg_incur_debt(struct ioc_gq *iocg, u64 abs_cost,
@@ -1356,9 +1376,10 @@ static void iocg_kick_waitq(struct ioc_gq *iocg, bool pay_debt,
 		atomic64_add(vpay, &iocg->done_vtime);
 		iocg_pay_debt(iocg, abs_vpay, now);
 		vbudget -= vpay;
+	}
 
+	if (iocg->abs_vdebt || iocg->delay)
 		iocg_kick_delay(iocg, now);
-	}
 
 	/*
 	 * Debt can still be outstanding if we haven't paid all yet or the
@@ -1906,12 +1927,13 @@ static void ioc_timer_fn(struct timer_list *timer)
 	 */
 	list_for_each_entry_safe(iocg, tiocg, &ioc->active_iocgs, active_list) {
 		if (!waitqueue_active(&iocg->waitq) && !iocg->abs_vdebt &&
-		    !iocg_is_idle(iocg))
+		    !iocg->delay && !iocg_is_idle(iocg))
 			continue;
 
 		spin_lock(&iocg->waitq.lock);
 
-		if (waitqueue_active(&iocg->waitq) || iocg->abs_vdebt) {
+		if (waitqueue_active(&iocg->waitq) || iocg->abs_vdebt ||
+		    iocg->delay) {
 			/* might be oversleeping vtime / hweight changes, kick */
 			iocg_kick_waitq(iocg, true, &now);
 		} else if (iocg_is_idle(iocg)) {
@@ -2641,8 +2663,6 @@ static void ioc_pd_init(struct blkg_policy_data *pd)
 	init_waitqueue_head(&iocg->waitq);
 	hrtimer_init(&iocg->waitq_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
 	iocg->waitq_timer.function = iocg_waitq_timer_fn;
-	hrtimer_init(&iocg->delay_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	iocg->delay_timer.function = iocg_delay_timer_fn;
 
 	iocg->level = blkg->blkcg->css.cgroup->level;
 
@@ -2679,7 +2699,6 @@ static void ioc_pd_free(struct blkg_policy_data *pd)
 		spin_unlock_irqrestore(&ioc->lock, flags);
 
 		hrtimer_cancel(&iocg->waitq_timer);
-		hrtimer_cancel(&iocg->delay_timer);
 	}
 	free_percpu(iocg->pcpu_stat);
 	kfree(iocg);
-- 
2.26.2


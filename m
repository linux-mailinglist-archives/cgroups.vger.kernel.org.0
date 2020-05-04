Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F681C4A4A
	for <lists+cgroups@lfdr.de>; Tue,  5 May 2020 01:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgEDX16 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 May 2020 19:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbgEDX16 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 May 2020 19:27:58 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD40C061A0E;
        Mon,  4 May 2020 16:27:57 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f83so505038qke.13;
        Mon, 04 May 2020 16:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ip3zhTzFNO8GaDSRR5Xv3BK5YgA2YXgYzXwyja3RCNc=;
        b=uJZyLFH7OYZRQopRfg8qLOZSE+chPXLsRuaPH2UtwWV2adHuHG980H3af9BMlE2Fjb
         pqyFPQyiG6weqr2LIpMsxpcgeu2rij/dY+GAc7rOWgQasesMzK6EI9RehyqdQq7pUTPQ
         Z2jAhRNEZxvliEHRbRI0xQ9HNHbj6UI+9hZxr3jFBFFclkzKvoQHyPWuBATQXVpHtSe4
         +wFeEzG/1uLqh5N/MU4bgmFYBEcr9zYt+FOqSCWZLIATYXo10kR5oFNPZXrnw+OcivOJ
         P/XTWWbf1kEsdGGHH1X2lBNIKDrnDz8UL/7EWglUibLhiK3QbGi6Wp/97YiKdemTPg1R
         tXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=ip3zhTzFNO8GaDSRR5Xv3BK5YgA2YXgYzXwyja3RCNc=;
        b=LjV0WBnOYQNfxhrY4ufv/Jp2hoCbRgyh9kAxhQneYBKPkAA/eXmYk6NTOOpes58Kiu
         cHrvsqoFhhqym/kNoUfs6ihkEPT8LrP1PA7smJcE9SrrfIpVlwCJfLHu92XjmMckeAWX
         98jqSQxdhgnTXJhDsoXWF5XedbD6fW0mKSBzxKVGCpJ5sNAmySf+FtYIgmLJ4fmvSEwr
         vZogqx/09i3DLcD15eKTB7Xo2tOp9kg7Yz8BZUlhgn2Wob9Vu3kLEVSXb65mX31ai3Ji
         IrPVGODkJrC0zTn/qz0p0sztH8+U9OqdYnfxfpgszsk7G/TkrmRUS3hx17hosg9Ixqtz
         Cgyg==
X-Gm-Message-State: AGi0PuZNSMLkaJCkLa1JFA+n09Adjw4S2xSYn5GiVV7gqo7VbsffEpdi
        gQ3uSwa95AB3+AZmBqEG9AOFHLXq4sM=
X-Google-Smtp-Source: APiQypKcO3GAJ8hdRsEq35pFlniR0GDTRVzDZNCOUE05DlSMcNtW/HXuII4sRaSUy9Xd6HvScaKguA==
X-Received: by 2002:a05:620a:62c:: with SMTP id 12mr884394qkv.234.1588634876483;
        Mon, 04 May 2020 16:27:56 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:5ece])
        by smtp.gmail.com with ESMTPSA id i4sm424538qkh.66.2020.05.04.16.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 16:27:55 -0700 (PDT)
Date:   Mon, 4 May 2020 19:27:54 -0400
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org,
        Vlad Dmitriev <vvd@fb.com>
Subject: [block/for-5.7] iocost: protect iocg->abs_vdebt with iocg->waitq.lock
Message-ID: <20200504232754.GB3209250@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Subject: iocost: protect iocg->abs_vdebt with iocg->waitq.lock

abs_vdebt is an atomic_64 which tracks how much over budget a given cgroup
is and controls the activation of use_delay mechanism. Once a cgroup goes
over budget from forced IOs, it has to pay it back with its future budget.
The progress guarantee on debt paying comes from the iocg being active -
active iocgs are processed by the periodic timer, which ensures that as time
passes the debts dissipate and the iocg returns to normal operation.

However, both iocg activation and vdebt handling are asynchronous and a
sequence like the following may happen.

1. The iocg is in the process of being deactivated by the periodic timer.

2. A bio enters ioc_rqos_throttle(), calls iocg_activate() which returns
   without anything because it still sees that the iocg is already active.

3. The iocg is deactivated.

4. The bio from #2 is over budget but needs to be forced. It increases
   abs_vdebt and goes over the threshold and enables use_delay.

5. IO control is enabled for the iocg's subtree and now IOs are attributed
   to the descendant cgroups and the iocg itself no longer issues IOs.

This leaves the iocg with stuck abs_vdebt - it has debt but inactive and no
further IOs which can activate it. This can end up unduly punishing all the
descendants cgroups.

The usual throttling path has the same issue - the iocg must be active while
throttled to ensure that future event will wake it up - and solves the
problem by synchronizing the throttling path with a spinlock. abs_vdebt
handling is another form of overage handling and shares a lot of
characteristics including the fact that it isn't in the hottest path.

This patch fixes the above and other possible races by strictly
synchronizing abs_vdebt and use_delay handling with iocg->waitq.lock.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Vlad Dmitriev <vvd@fb.com>
Cc: stable@vger.kernel.org # v5.4+
Fixes: e1518f63f246 ("blk-iocost: Don't let merges push vtime into the future")
---
 block/blk-iocost.c             |  117 ++++++++++++++++++++++++-----------------
 tools/cgroup/iocost_monitor.py |    7 ++
 2 files changed, 77 insertions(+), 47 deletions(-)

--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -466,7 +466,7 @@ struct ioc_gq {
 	 */
 	atomic64_t			vtime;
 	atomic64_t			done_vtime;
-	atomic64_t			abs_vdebt;
+	u64				abs_vdebt;
 	u64				last_vtime;
 
 	/*
@@ -1142,7 +1142,7 @@ static void iocg_kick_waitq(struct ioc_g
 	struct iocg_wake_ctx ctx = { .iocg = iocg };
 	u64 margin_ns = (u64)(ioc->period_us *
 			      WAITQ_TIMER_MARGIN_PCT / 100) * NSEC_PER_USEC;
-	u64 abs_vdebt, vdebt, vshortage, expires, oexpires;
+	u64 vdebt, vshortage, expires, oexpires;
 	s64 vbudget;
 	u32 hw_inuse;
 
@@ -1152,18 +1152,15 @@ static void iocg_kick_waitq(struct ioc_g
 	vbudget = now->vnow - atomic64_read(&iocg->vtime);
 
 	/* pay off debt */
-	abs_vdebt = atomic64_read(&iocg->abs_vdebt);
-	vdebt = abs_cost_to_cost(abs_vdebt, hw_inuse);
+	vdebt = abs_cost_to_cost(iocg->abs_vdebt, hw_inuse);
 	if (vdebt && vbudget > 0) {
 		u64 delta = min_t(u64, vbudget, vdebt);
 		u64 abs_delta = min(cost_to_abs_cost(delta, hw_inuse),
-				    abs_vdebt);
+				    iocg->abs_vdebt);
 
 		atomic64_add(delta, &iocg->vtime);
 		atomic64_add(delta, &iocg->done_vtime);
-		atomic64_sub(abs_delta, &iocg->abs_vdebt);
-		if (WARN_ON_ONCE(atomic64_read(&iocg->abs_vdebt) < 0))
-			atomic64_set(&iocg->abs_vdebt, 0);
+		iocg->abs_vdebt -= abs_delta;
 	}
 
 	/*
@@ -1219,12 +1216,18 @@ static bool iocg_kick_delay(struct ioc_g
 	u64 expires, oexpires;
 	u32 hw_inuse;
 
+	lockdep_assert_held(&iocg->waitq.lock);
+
 	/* debt-adjust vtime */
 	current_hweight(iocg, NULL, &hw_inuse);
-	vtime += abs_cost_to_cost(atomic64_read(&iocg->abs_vdebt), hw_inuse);
+	vtime += abs_cost_to_cost(iocg->abs_vdebt, hw_inuse);
 
-	/* clear or maintain depending on the overage */
-	if (time_before_eq64(vtime, now->vnow)) {
+	/*
+	 * Clear or maintain depending on the overage. Non-zero vdebt is what
+	 * guarantees that @iocg is online and future iocg_kick_delay() will
+	 * clear use_delay. Don't leave it on when there's no vdebt.
+	 */
+	if (!iocg->abs_vdebt || time_before_eq64(vtime, now->vnow)) {
 		blkcg_clear_delay(blkg);
 		return false;
 	}
@@ -1258,9 +1261,12 @@ static enum hrtimer_restart iocg_delay_t
 {
 	struct ioc_gq *iocg = container_of(timer, struct ioc_gq, delay_timer);
 	struct ioc_now now;
+	unsigned long flags;
 
+	spin_lock_irqsave(&iocg->waitq.lock, flags);
 	ioc_now(iocg->ioc, &now);
 	iocg_kick_delay(iocg, &now, 0);
+	spin_unlock_irqrestore(&iocg->waitq.lock, flags);
 
 	return HRTIMER_NORESTART;
 }
@@ -1368,14 +1374,13 @@ static void ioc_timer_fn(struct timer_li
 	 * should have woken up in the last period and expire idle iocgs.
 	 */
 	list_for_each_entry_safe(iocg, tiocg, &ioc->active_iocgs, active_list) {
-		if (!waitqueue_active(&iocg->waitq) &&
-		    !atomic64_read(&iocg->abs_vdebt) && !iocg_is_idle(iocg))
+		if (!waitqueue_active(&iocg->waitq) && iocg->abs_vdebt &&
+		    !iocg_is_idle(iocg))
 			continue;
 
 		spin_lock(&iocg->waitq.lock);
 
-		if (waitqueue_active(&iocg->waitq) ||
-		    atomic64_read(&iocg->abs_vdebt)) {
+		if (waitqueue_active(&iocg->waitq) || iocg->abs_vdebt) {
 			/* might be oversleeping vtime / hweight changes, kick */
 			iocg_kick_waitq(iocg, &now);
 			iocg_kick_delay(iocg, &now, 0);
@@ -1718,28 +1723,49 @@ static void ioc_rqos_throttle(struct rq_
 	 * tests are racy but the races aren't systemic - we only miss once
 	 * in a while which is fine.
 	 */
-	if (!waitqueue_active(&iocg->waitq) &&
-	    !atomic64_read(&iocg->abs_vdebt) &&
+	if (!waitqueue_active(&iocg->waitq) && !iocg->abs_vdebt &&
 	    time_before_eq64(vtime + cost, now.vnow)) {
 		iocg_commit_bio(iocg, bio, cost);
 		return;
 	}
 
 	/*
-	 * We're over budget.  If @bio has to be issued regardless,
-	 * remember the abs_cost instead of advancing vtime.
-	 * iocg_kick_waitq() will pay off the debt before waking more IOs.
+	 * We activated above but w/o any synchronization. Deactivation is
+	 * synchronized with waitq.lock and we won't get deactivated as long
+	 * as we're waiting or has debt, so we're good if we're activated
+	 * here. In the unlikely case that we aren't, just issue the IO.
+	 */
+	spin_lock_irq(&iocg->waitq.lock);
+
+	if (unlikely(list_empty(&iocg->active_list))) {
+		spin_unlock_irq(&iocg->waitq.lock);
+		iocg_commit_bio(iocg, bio, cost);
+		return;
+	}
+
+	/*
+	 * We're over budget. If @bio has to be issued regardless, remember
+	 * the abs_cost instead of advancing vtime. iocg_kick_waitq() will pay
+	 * off the debt before waking more IOs.
+	 *
 	 * This way, the debt is continuously paid off each period with the
-	 * actual budget available to the cgroup.  If we just wound vtime,
-	 * we would incorrectly use the current hw_inuse for the entire
-	 * amount which, for example, can lead to the cgroup staying
-	 * blocked for a long time even with substantially raised hw_inuse.
+	 * actual budget available to the cgroup. If we just wound vtime, we
+	 * would incorrectly use the current hw_inuse for the entire amount
+	 * which, for example, can lead to the cgroup staying blocked for a
+	 * long time even with substantially raised hw_inuse.
+	 *
+	 * An iocg with vdebt should stay online so that the timer can keep
+	 * deducting its vdebt and [de]activate use_delay mechanism
+	 * accordingly. We don't want to race against the timer trying to
+	 * clear them and leave @iocg inactive w/ dangling use_delay heavily
+	 * penalizing the cgroup and its descendants.
 	 */
 	if (bio_issue_as_root_blkg(bio) || fatal_signal_pending(current)) {
-		atomic64_add(abs_cost, &iocg->abs_vdebt);
+		iocg->abs_vdebt += abs_cost;
 		if (iocg_kick_delay(iocg, &now, cost))
 			blkcg_schedule_throttle(rqos->q,
 					(bio->bi_opf & REQ_SWAP) == REQ_SWAP);
+		spin_unlock_irq(&iocg->waitq.lock);
 		return;
 	}
 
@@ -1756,20 +1782,6 @@ static void ioc_rqos_throttle(struct rq_
 	 * All waiters are on iocg->waitq and the wait states are
 	 * synchronized using waitq.lock.
 	 */
-	spin_lock_irq(&iocg->waitq.lock);
-
-	/*
-	 * We activated above but w/o any synchronization.  Deactivation is
-	 * synchronized with waitq.lock and we won't get deactivated as
-	 * long as we're waiting, so we're good if we're activated here.
-	 * In the unlikely case that we are deactivated, just issue the IO.
-	 */
-	if (unlikely(list_empty(&iocg->active_list))) {
-		spin_unlock_irq(&iocg->waitq.lock);
-		iocg_commit_bio(iocg, bio, cost);
-		return;
-	}
-
 	init_waitqueue_func_entry(&wait.wait, iocg_wake_fn);
 	wait.wait.private = current;
 	wait.bio = bio;
@@ -1801,6 +1813,7 @@ static void ioc_rqos_merge(struct rq_qos
 	struct ioc_now now;
 	u32 hw_inuse;
 	u64 abs_cost, cost;
+	unsigned long flags;
 
 	/* bypass if disabled or for root cgroup */
 	if (!ioc->enabled || !iocg->level)
@@ -1820,15 +1833,28 @@ static void ioc_rqos_merge(struct rq_qos
 		iocg->cursor = bio_end;
 
 	/*
-	 * Charge if there's enough vtime budget and the existing request
-	 * has cost assigned.  Otherwise, account it as debt.  See debt
-	 * handling in ioc_rqos_throttle() for details.
+	 * Charge if there's enough vtime budget and the existing request has
+	 * cost assigned.
 	 */
 	if (rq->bio && rq->bio->bi_iocost_cost &&
-	    time_before_eq64(atomic64_read(&iocg->vtime) + cost, now.vnow))
+	    time_before_eq64(atomic64_read(&iocg->vtime) + cost, now.vnow)) {
 		iocg_commit_bio(iocg, bio, cost);
-	else
-		atomic64_add(abs_cost, &iocg->abs_vdebt);
+		return;
+	}
+
+	/*
+	 * Otherwise, account it as debt if @iocg is online, which it should
+	 * be for the vast majority of cases. See debt handling in
+	 * ioc_rqos_throttle() for details.
+	 */
+	spin_lock_irqsave(&iocg->waitq.lock, flags);
+	if (likely(!list_empty(&iocg->active_list))) {
+		iocg->abs_vdebt += abs_cost;
+		iocg_kick_delay(iocg, &now, cost);
+	} else {
+		iocg_commit_bio(iocg, bio, cost);
+	}
+	spin_unlock_irqrestore(&iocg->waitq.lock, flags);
 }
 
 static void ioc_rqos_done_bio(struct rq_qos *rqos, struct bio *bio)
@@ -1998,7 +2024,6 @@ static void ioc_pd_init(struct blkg_poli
 	iocg->ioc = ioc;
 	atomic64_set(&iocg->vtime, now.vnow);
 	atomic64_set(&iocg->done_vtime, now.vnow);
-	atomic64_set(&iocg->abs_vdebt, 0);
 	atomic64_set(&iocg->active_period, atomic64_read(&ioc->cur_period));
 	INIT_LIST_HEAD(&iocg->active_list);
 	iocg->hweight_active = HWEIGHT_WHOLE;
--- a/tools/cgroup/iocost_monitor.py
+++ b/tools/cgroup/iocost_monitor.py
@@ -159,7 +159,12 @@ class IocgStat:
         else:
             self.inflight_pct = 0
 
-        self.debt_ms = iocg.abs_vdebt.counter.value_() / VTIME_PER_USEC / 1000
+        # vdebt used to be an atomic64_t and is now u64, support both
+        try:
+            self.debt_ms = iocg.abs_vdebt.counter.value_() / VTIME_PER_USEC / 1000
+        except:
+            self.debt_ms = iocg.abs_vdebt.value_() / VTIME_PER_USEC / 1000
+
         self.use_delay = blkg.use_delay.counter.value_()
         self.delay_ms = blkg.delay_nsec.counter.value_() / 1_000_000
 

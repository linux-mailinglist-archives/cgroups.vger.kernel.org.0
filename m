Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24FE1A927C
	for <lists+cgroups@lfdr.de>; Wed,  4 Sep 2019 21:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbfIDTqE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Sep 2019 15:46:04 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43568 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729677AbfIDTqD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Sep 2019 15:46:03 -0400
Received: by mail-qk1-f194.google.com with SMTP id m2so20785341qkd.10;
        Wed, 04 Sep 2019 12:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZJvcHGT5+ZK1nLs2NfUHYcJOsCB431R3Hn7hw0Oz7B8=;
        b=E0uqMjQRayYNy8veSJkjeJkP2qgDyGUTV4k/f6AyhPt+/1jGiXulUJyYomLTjgBaVU
         MIak9tyLL5QLx7o6wQ699v8gdPm2jLzcMrC8/1PqxPQEYyQZZyRvUr9KbUpkPx2e+fXn
         cUCCrv/pYQYuDRjzlLnWXlQv7zY0BBWoD1yCeSFwdRuyM+ERVdE0W2XOxr+BBKFLiyua
         FHO4Pyu3boOi5WI6b0WXNtrI/2xFvUoAof9YIe+TocItH4ZBEWUHwLy8KNgupBNwCaKA
         3jsIYT+WL7LKdzby6xjH8RvzFmY5pFbW5b3rDQZu7YPjvNCkGAGLBUi7RhkTAHhH7rqT
         Kb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=ZJvcHGT5+ZK1nLs2NfUHYcJOsCB431R3Hn7hw0Oz7B8=;
        b=Vaqp890WFDG1fN+ii+/4Fgyv/Zi+C6WWSr6rArX/Bwo9nM5VFuGMsg1sJuGSbVVnV9
         GL9UOuVfAtnGe5u2DQheUKZNczGd6O0CZKB6nSob7tuLukjA3QSYcxCdtSybaTDGuwXE
         lty28k7Yt6MPV++2ENlPJ8Uuu0aga+t0m8JNxjJbD9JN7tXmCh408I0UPqbAnV4jP4cs
         FZWNN6+cY7foMhDkTv0AIUxUBi3yh6T7qVwv6BI+yiydtIRyXNX/kzuMgElsYu7px1UU
         f4hszbEExCW91Ms779rBsFkriH2Jft4hw0z2S0306NI4shn0+N/t4GNMlz1E2KwMC01t
         vA4A==
X-Gm-Message-State: APjAAAUT4gVk+w3SYKtQzgIHiYpnOkdJjQS51qx3NqdQlzphWftty3gV
        Qyz60XaK31QMt4WnTDla+00=
X-Google-Smtp-Source: APXvYqwAccyHdhgbgFCLP2mOEbgNl6xGrrLLy5l4LEf/X3ptmN7K1gvWtWPlEy0nuDujNY5UcNvhlA==
X-Received: by 2002:a37:5187:: with SMTP id f129mr13390651qkb.382.1567626362436;
        Wed, 04 Sep 2019 12:46:02 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:33b1])
        by smtp.gmail.com with ESMTPSA id 64sm4710038qkk.63.2019.09.04.12.46.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 12:46:01 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@vger.kernel.org, cgroups@vger.kernel.org,
        newella@fb.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/5] blk-iocost: Account force-charged overage in absolute vtime
Date:   Wed,  4 Sep 2019 12:45:52 -0700
Message-Id: <20190904194556.2984857-2-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904194556.2984857-1-tj@kernel.org>
References: <20190904194556.2984857-1-tj@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently, when a bio needs to be force-charged and there isn't enough
budget, vtime is simply pushed into the future.  This means that the
cost of the whole bio is scaled using the current hweight and then
charged immediately.  Until the global vtime advances beyond this
future vtime, the cgroup won't be allowed to issue normal IOs.

This is incorrect and can lead to, for example, exploding vrate or
extended stalls if vrate range is constrained.  Consider the following
scenario.

1. A cgroup with a very low hweight runs out of budget.

2. A storm of swap-out happens on it.  All of them are scaled
   according to the current low hweight and charged to vtime pushing
   it to a far future.

3. All other cgroups go idle and now the above cgroup has access to
   the whole device.  However, because vtime is already wound using
   the past low hweight, what its current hweight is doesn't matter
   until global vtime catches up to the local vtime.

4. As a result, either vrate gets ramped up extremely or the IOs stall
   while the underlying device is idle.

This is because the hweight the overage is calculated at is different
from the hweight that it's being paid at.

Fix it by remembering the overage in absoulte vtime and continuously
paying with the actual budget according to the current hweight at each
period.

Note that non-forced bios which wait already remembers the cost in
absolute vtime.  This brings forced-bio accounting in line.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-iocost.c | 62 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 7 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 2aae8ec391ef..5b0c024ee5dd 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -469,6 +469,7 @@ struct ioc_gq {
 	 */
 	atomic64_t			vtime;
 	atomic64_t			done_vtime;
+	atomic64_t			abs_vdebt;
 	u64				last_vtime;
 
 	/*
@@ -653,13 +654,21 @@ static struct ioc_cgrp *blkcg_to_iocc(struct blkcg *blkcg)
 
 /*
  * Scale @abs_cost to the inverse of @hw_inuse.  The lower the hierarchical
- * weight, the more expensive each IO.
+ * weight, the more expensive each IO.  Must round up.
  */
 static u64 abs_cost_to_cost(u64 abs_cost, u32 hw_inuse)
 {
 	return DIV64_U64_ROUND_UP(abs_cost * HWEIGHT_WHOLE, hw_inuse);
 }
 
+/*
+ * The inverse of abs_cost_to_cost().  Must round up.
+ */
+static u64 cost_to_abs_cost(u64 cost, u32 hw_inuse)
+{
+	return DIV64_U64_ROUND_UP(cost * hw_inuse, HWEIGHT_WHOLE);
+}
+
 static void iocg_commit_bio(struct ioc_gq *iocg, struct bio *bio, u64 cost)
 {
 	bio->bi_iocost_cost = cost;
@@ -1132,16 +1141,36 @@ static void iocg_kick_waitq(struct ioc_gq *iocg, struct ioc_now *now)
 	struct iocg_wake_ctx ctx = { .iocg = iocg };
 	u64 margin_ns = (u64)(ioc->period_us *
 			      WAITQ_TIMER_MARGIN_PCT / 100) * NSEC_PER_USEC;
-	u64 vshortage, expires, oexpires;
+	u64 abs_vdebt, vdebt, vshortage, expires, oexpires;
+	s64 vbudget;
+	u32 hw_inuse;
 
 	lockdep_assert_held(&iocg->waitq.lock);
 
+	current_hweight(iocg, NULL, &hw_inuse);
+	vbudget = now->vnow - atomic64_read(&iocg->vtime);
+
+	/* pay off debt */
+	abs_vdebt = atomic64_read(&iocg->abs_vdebt);
+	vdebt = abs_cost_to_cost(abs_vdebt, hw_inuse);
+	if (vdebt && vbudget > 0) {
+		u64 delta = min_t(u64, vbudget, vdebt);
+		u64 abs_delta = min(cost_to_abs_cost(delta, hw_inuse),
+				    abs_vdebt);
+
+		atomic64_add(delta, &iocg->vtime);
+		atomic64_add(delta, &iocg->done_vtime);
+		atomic64_sub(abs_delta, &iocg->abs_vdebt);
+		if (WARN_ON_ONCE(atomic64_read(&iocg->abs_vdebt) < 0))
+			atomic64_set(&iocg->abs_vdebt, 0);
+	}
+
 	/*
 	 * Wake up the ones which are due and see how much vtime we'll need
 	 * for the next one.
 	 */
-	current_hweight(iocg, NULL, &ctx.hw_inuse);
-	ctx.vbudget = now->vnow - atomic64_read(&iocg->vtime);
+	ctx.hw_inuse = hw_inuse;
+	ctx.vbudget = vbudget - vdebt;
 	__wake_up_locked_key(&iocg->waitq, TASK_NORMAL, &ctx);
 	if (!waitqueue_active(&iocg->waitq))
 		return;
@@ -1187,6 +1216,11 @@ static void iocg_kick_delay(struct ioc_gq *iocg, struct ioc_now *now, u64 cost)
 	u64 vmargin = ioc->margin_us * now->vrate;
 	u64 margin_ns = ioc->margin_us * NSEC_PER_USEC;
 	u64 expires, oexpires;
+	u32 hw_inuse;
+
+	/* debt-adjust vtime */
+	current_hweight(iocg, NULL, &hw_inuse);
+	vtime += abs_cost_to_cost(atomic64_read(&iocg->abs_vdebt), hw_inuse);
 
 	/* clear or maintain depending on the overage */
 	if (time_before_eq64(vtime, now->vnow)) {
@@ -1332,12 +1366,14 @@ static void ioc_timer_fn(struct timer_list *timer)
 	 * should have woken up in the last period and expire idle iocgs.
 	 */
 	list_for_each_entry_safe(iocg, tiocg, &ioc->active_iocgs, active_list) {
-		if (!waitqueue_active(&iocg->waitq) && !iocg_is_idle(iocg))
+		if (!waitqueue_active(&iocg->waitq) &&
+		    !atomic64_read(&iocg->abs_vdebt) && !iocg_is_idle(iocg))
 			continue;
 
 		spin_lock(&iocg->waitq.lock);
 
-		if (waitqueue_active(&iocg->waitq)) {
+		if (waitqueue_active(&iocg->waitq) ||
+		    atomic64_read(&iocg->abs_vdebt)) {
 			/* might be oversleeping vtime / hweight changes, kick */
 			iocg_kick_waitq(iocg, &now);
 			iocg_kick_delay(iocg, &now, 0);
@@ -1673,13 +1709,24 @@ static void ioc_rqos_throttle(struct rq_qos *rqos, struct bio *bio)
 	 * in a while which is fine.
 	 */
 	if (!waitqueue_active(&iocg->waitq) &&
+	    !atomic64_read(&iocg->abs_vdebt) &&
 	    time_before_eq64(vtime + cost, now.vnow)) {
 		iocg_commit_bio(iocg, bio, cost);
 		return;
 	}
 
+	/*
+	 * We're over budget.  If @bio has to be issued regardless,
+	 * remember the abs_cost instead of advancing vtime.
+	 * iocg_kick_waitq() will pay off the debt before waking more IOs.
+	 * This way, the debt is continuously paid off each period with the
+	 * actual budget available to the cgroup.  If we just wound vtime,
+	 * we would incorrectly use the current hw_inuse for the entire
+	 * amount which, for example, can lead to the cgroup staying
+	 * blocked for a long time even with substantially raised hw_inuse.
+	 */
 	if (bio_issue_as_root_blkg(bio) || fatal_signal_pending(current)) {
-		iocg_commit_bio(iocg, bio, cost);
+		atomic64_add(abs_cost, &iocg->abs_vdebt);
 		iocg_kick_delay(iocg, &now, cost);
 		return;
 	}
@@ -1928,6 +1975,7 @@ static void ioc_pd_init(struct blkg_policy_data *pd)
 	iocg->ioc = ioc;
 	atomic64_set(&iocg->vtime, now.vnow);
 	atomic64_set(&iocg->done_vtime, now.vnow);
+	atomic64_set(&iocg->abs_vdebt, 0);
 	atomic64_set(&iocg->active_period, atomic64_read(&ioc->cur_period));
 	INIT_LIST_HEAD(&iocg->active_list);
 	iocg->hweight_active = HWEIGHT_WHOLE;
-- 
2.17.1


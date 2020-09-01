Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9064A259E83
	for <lists+cgroups@lfdr.de>; Tue,  1 Sep 2020 20:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731879AbgIASyT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Sep 2020 14:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730658AbgIASyH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Sep 2020 14:54:07 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B00C061247;
        Tue,  1 Sep 2020 11:54:07 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id w186so2017806qkd.1;
        Tue, 01 Sep 2020 11:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+znxVIecrtKWYGkcHEVPQEzgR+d5RoCk5v84S1Jw+o4=;
        b=u8k3gyyVQfI0XRNV9AWPq8hwbyDime6LlCDuZaJ01IWRgdaLnv7YDHECSM6iZomAIw
         fjfjRTGpdj+3Tdhgj/hhECaf8496rA2fnMqUPDgtQZpVWQfJpcpyCMtOGjFZclO6Qk7s
         AXZaEIFikWjrrrUQ+/BOER1BDdP3ObTKm0dQzeDKvNm0enFRLt/O2T4dHHFUviN+oCJ2
         WAG9oF0MpzzWTH1tXrIB31bMeez4gWypFnVnOyh+YHsd2LdRscAcQgRLV6GPzF95lUE1
         bKPpFsyE/oMdWk7sRWw7q6xjQ56pdAs8VjlsjzHz0KzpVhAowC3mIzJV08vt4RPFp+Ok
         QS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=+znxVIecrtKWYGkcHEVPQEzgR+d5RoCk5v84S1Jw+o4=;
        b=RFxQG94oPhM4Me6NXR1RzLCQXhiU6BMTliwE5EkVOALyKoqEc4WHGDzY/mWgIBCnT5
         Dd3Emg5w1SWTGs6evfWNVvaPIvJFI8oOdWmgOPGvZx+RKor0FtAhE1uUvd7uhycqZjL6
         7wmjGTGIcj9nPZFCKOO1/ZPAqPDRdYnfhNH/kpzA0wQsnFm+pscfHZd4258eH4ePJPSx
         Lo8pHZwAw8Md0AQ/5OZRT9R4SIEtmsDJZ4nA4iu9JKUu7KI80vQikiKN9rMmxaqhKogH
         igr/tjrI20+NsM6Cfehp4LRulV6PDZPIuyv8DnYr0dME0lGRukYT4ACaoHTzs4rML3WJ
         K/9A==
X-Gm-Message-State: AOAM532LrlzP2r7OMv6e1awNsrHfETYwjh/fHkIshKV9d8SCTGCpsOhN
        +UgHI1r/2kF8CjRzVUBQpwU=
X-Google-Smtp-Source: ABdhPJwxRJ6KXa/lhEd17sq4PINJmhS1dg/6HgW+DwKy+rk3PafNh0mIMLbYThae8p7DQ0MZAM55Vg==
X-Received: by 2002:a37:454d:: with SMTP id s74mr3401793qka.373.1598986446198;
        Tue, 01 Sep 2020 11:54:06 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a198])
        by smtp.gmail.com with ESMTPSA id y20sm2468314qkj.70.2020.09.01.11.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 11:54:05 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, newella@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 21/27] blk-iocost: revamp debt handling
Date:   Tue,  1 Sep 2020 14:52:51 -0400
Message-Id: <20200901185257.645114-22-tj@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901185257.645114-1-tj@kernel.org>
References: <20200901185257.645114-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Debt handling had several issues.

* How much inuse a debtor carries wasn't clearly defined. inuse would be
  driven down over time from not issuing IOs but it'd be better to clamp it
  to minimum immediately once in debt.

* How much can be paid off was determined by hweight_inuse. As inuse was
  driven down, the payment amount would fall together regardless of the
  debtor's active weight. This means that the debtors were punished harshly.

* ioc_rqos_merge() wasn't calling blkcg_schedule_throttle() after
  iocg_kick_delay().

This patch revamps debt handling so that

* Debt handling owns inuse for iocgs in debt and keeps them at zero.

* Payment amount is determined by hweight_active. This is more deterministic
  and safer than hweight_inuse but still far from ideal in that it doesn't
  factor in possible donations from other iocgs for debt payments. This
  likely needs further improvements in the future.

* iocg_rqos_merge() now calls blkcg_schedule_throttle() as necessary.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Andy Newell <newella@fb.com>
---
 block/blk-iocost.c | 117 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 93 insertions(+), 24 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index d09b4011449c..d2b69d87f3e7 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1206,13 +1206,13 @@ static bool iocg_kick_delay(struct ioc_gq *iocg, struct ioc_now *now)
 	struct blkcg_gq *blkg = iocg_to_blkg(iocg);
 	u64 vtime = atomic64_read(&iocg->vtime);
 	u64 delta_ns, expires, oexpires;
-	u32 hw_inuse;
+	u32 hwa;
 
 	lockdep_assert_held(&iocg->waitq.lock);
 
 	/* debt-adjust vtime */
-	current_hweight(iocg, NULL, &hw_inuse);
-	vtime += abs_cost_to_cost(iocg->abs_vdebt, hw_inuse);
+	current_hweight(iocg, &hwa, NULL);
+	vtime += abs_cost_to_cost(iocg->abs_vdebt, hwa);
 
 	/*
 	 * Clear or maintain depending on the overage. Non-zero vdebt is what
@@ -1258,6 +1258,47 @@ static enum hrtimer_restart iocg_delay_timer_fn(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
+static void iocg_incur_debt(struct ioc_gq *iocg, u64 abs_cost,
+			    struct ioc_now *now)
+{
+	struct iocg_pcpu_stat *gcs;
+
+	lockdep_assert_held(&iocg->ioc->lock);
+	lockdep_assert_held(&iocg->waitq.lock);
+	WARN_ON_ONCE(list_empty(&iocg->active_list));
+
+	/*
+	 * Once in debt, debt handling owns inuse. @iocg stays at the minimum
+	 * inuse donating all of it share to others until its debt is paid off.
+	 */
+	if (!iocg->abs_vdebt && abs_cost)
+		propagate_weights(iocg, iocg->active, 0, false, now);
+
+	iocg->abs_vdebt += abs_cost;
+
+	gcs = get_cpu_ptr(iocg->pcpu_stat);
+	local64_add(abs_cost, &gcs->abs_vusage);
+	put_cpu_ptr(gcs);
+}
+
+static void iocg_pay_debt(struct ioc_gq *iocg, u64 abs_vpay,
+			  struct ioc_now *now)
+{
+	lockdep_assert_held(&iocg->ioc->lock);
+	lockdep_assert_held(&iocg->waitq.lock);
+
+	/* make sure that nobody messed with @iocg */
+	WARN_ON_ONCE(list_empty(&iocg->active_list));
+	WARN_ON_ONCE(iocg->inuse > 1);
+
+	iocg->abs_vdebt -= min(abs_vpay, iocg->abs_vdebt);
+
+	/* if debt is paid in full, restore inuse */
+	if (!iocg->abs_vdebt)
+		propagate_weights(iocg, iocg->active, iocg->last_inuse,
+				  false, now);
+}
+
 static int iocg_wake_fn(struct wait_queue_entry *wq_entry, unsigned mode,
 			int flags, void *key)
 {
@@ -1296,26 +1337,25 @@ static void iocg_kick_waitq(struct ioc_gq *iocg, bool pay_debt,
 	struct iocg_wake_ctx ctx = { .iocg = iocg };
 	u64 vshortage, expires, oexpires;
 	s64 vbudget;
-	u32 hw_inuse;
+	u32 hwa;
 
 	lockdep_assert_held(&iocg->waitq.lock);
 
-	current_hweight(iocg, NULL, &hw_inuse);
+	current_hweight(iocg, &hwa, NULL);
 	vbudget = now->vnow - atomic64_read(&iocg->vtime);
 
 	/* pay off debt */
 	if (pay_debt && iocg->abs_vdebt && vbudget > 0) {
-		u64 vdebt = abs_cost_to_cost(iocg->abs_vdebt, hw_inuse);
-		u64 delta = min_t(u64, vbudget, vdebt);
-		u64 abs_delta = min(cost_to_abs_cost(delta, hw_inuse),
-				    iocg->abs_vdebt);
+		u64 abs_vbudget = cost_to_abs_cost(vbudget, hwa);
+		u64 abs_vpay = min_t(u64, abs_vbudget, iocg->abs_vdebt);
+		u64 vpay = abs_cost_to_cost(abs_vpay, hwa);
 
 		lockdep_assert_held(&ioc->lock);
 
-		atomic64_add(delta, &iocg->vtime);
-		atomic64_add(delta, &iocg->done_vtime);
-		iocg->abs_vdebt -= abs_delta;
-		vbudget -= vdebt;
+		atomic64_add(vpay, &iocg->vtime);
+		atomic64_add(vpay, &iocg->done_vtime);
+		iocg_pay_debt(iocg, abs_vpay, now);
+		vbudget -= vpay;
 
 		iocg_kick_delay(iocg, now);
 	}
@@ -1327,17 +1367,20 @@ static void iocg_kick_waitq(struct ioc_gq *iocg, bool pay_debt,
 	 * not positive.
 	 */
 	if (iocg->abs_vdebt) {
-		s64 vdebt = abs_cost_to_cost(iocg->abs_vdebt, hw_inuse);
+		s64 vdebt = abs_cost_to_cost(iocg->abs_vdebt, hwa);
 		vbudget = min_t(s64, 0, vbudget - vdebt);
 	}
 
 	/*
-	 * Wake up the ones which are due and see how much vtime we'll need
-	 * for the next one.
+	 * Wake up the ones which are due and see how much vtime we'll need for
+	 * the next one. As paying off debt restores hw_inuse, it must be read
+	 * after the above debt payment.
 	 */
-	ctx.hw_inuse = hw_inuse;
 	ctx.vbudget = vbudget;
+	current_hweight(iocg, NULL, &ctx.hw_inuse);
+
 	__wake_up_locked_key(&iocg->waitq, TASK_NORMAL, &ctx);
+
 	if (!waitqueue_active(&iocg->waitq))
 		return;
 	if (WARN_ON_ONCE(ctx.vbudget >= 0))
@@ -1525,6 +1568,10 @@ static u32 hweight_after_donation(struct ioc_gq *iocg, u32 hwm, u32 usage,
 	u64 vtime = atomic64_read(&iocg->vtime);
 	s64 excess, delta, target, new_hwi;
 
+	/* debt handling owns inuse for debtors */
+	if (iocg->abs_vdebt)
+		return 1;
+
 	/* see whether minimum margin requirement is met */
 	if (waitqueue_active(&iocg->waitq) ||
 	    time_after64(vtime, now->vnow - ioc->margins.min))
@@ -1798,6 +1845,18 @@ static void transfer_surpluses(struct list_head *surpluses, struct ioc_now *now)
 		struct ioc_gq *parent = iocg->ancestors[iocg->level - 1];
 		u32 inuse;
 
+		/*
+		 * In-debt iocgs participated in the donation calculation with
+		 * the minimum target hweight_inuse. Configuring inuse
+		 * accordingly would work fine but debt handling expects
+		 * @iocg->inuse stay at the minimum and we don't wanna
+		 * interfere.
+		 */
+		if (iocg->abs_vdebt) {
+			WARN_ON_ONCE(iocg->inuse > 1);
+			continue;
+		}
+
 		/* w' = s' * b' / b'_p, note that b' == b'_t for donating leaves */
 		inuse = DIV64_U64_ROUND_UP(
 			parent->child_adjusted_sum * iocg->hweight_after_donation,
@@ -2081,6 +2140,10 @@ static u64 adjust_inuse_and_calc_cost(struct ioc_gq *iocg, u64 vtime,
 	cost = abs_cost_to_cost(abs_cost, hwi);
 	margin = now->vnow - vtime - cost;
 
+	/* debt handling owns inuse for debtors */
+	if (iocg->abs_vdebt)
+		return cost;
+
 	/*
 	 * We only increase inuse during period and do so iff the margin has
 	 * deteriorated since the previous adjustment.
@@ -2092,7 +2155,7 @@ static u64 adjust_inuse_and_calc_cost(struct ioc_gq *iocg, u64 vtime,
 	spin_lock_irq(&ioc->lock);
 
 	/* we own inuse only when @iocg is in the normal active state */
-	if (list_empty(&iocg->active_list)) {
+	if (iocg->abs_vdebt || list_empty(&iocg->active_list)) {
 		spin_unlock_irq(&ioc->lock);
 		return cost;
 	}
@@ -2266,7 +2329,7 @@ static void ioc_rqos_throttle(struct rq_qos *rqos, struct bio *bio)
 	 * penalizing the cgroup and its descendants.
 	 */
 	if (use_debt) {
-		iocg->abs_vdebt += abs_cost;
+		iocg_incur_debt(iocg, abs_cost, &now);
 		if (iocg_kick_delay(iocg, &now))
 			blkcg_schedule_throttle(rqos->q,
 					(bio->bi_opf & REQ_SWAP) == REQ_SWAP);
@@ -2275,7 +2338,7 @@ static void ioc_rqos_throttle(struct rq_qos *rqos, struct bio *bio)
 	}
 
 	/* guarantee that iocgs w/ waiters have maximum inuse */
-	if (iocg->inuse != iocg->active) {
+	if (!iocg->abs_vdebt && iocg->inuse != iocg->active) {
 		if (!ioc_locked) {
 			iocg_unlock(iocg, false, &flags);
 			ioc_locked = true;
@@ -2363,14 +2426,20 @@ static void ioc_rqos_merge(struct rq_qos *rqos, struct request *rq,
 	 * be for the vast majority of cases. See debt handling in
 	 * ioc_rqos_throttle() for details.
 	 */
-	spin_lock_irqsave(&iocg->waitq.lock, flags);
+	spin_lock_irqsave(&ioc->lock, flags);
+	spin_lock(&iocg->waitq.lock);
+
 	if (likely(!list_empty(&iocg->active_list))) {
-		iocg->abs_vdebt += abs_cost;
-		iocg_kick_delay(iocg, &now);
+		iocg_incur_debt(iocg, abs_cost, &now);
+		if (iocg_kick_delay(iocg, &now))
+			blkcg_schedule_throttle(rqos->q,
+					(bio->bi_opf & REQ_SWAP) == REQ_SWAP);
 	} else {
 		iocg_commit_bio(iocg, bio, abs_cost, cost);
 	}
-	spin_unlock_irqrestore(&iocg->waitq.lock, flags);
+
+	spin_unlock(&iocg->waitq.lock);
+	spin_unlock_irqrestore(&ioc->lock, flags);
 }
 
 static void ioc_rqos_done_bio(struct rq_qos *rqos, struct bio *bio)
-- 
2.26.2


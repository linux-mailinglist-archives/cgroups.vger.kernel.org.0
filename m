Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1AB259E9B
	for <lists+cgroups@lfdr.de>; Tue,  1 Sep 2020 20:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732190AbgIASzR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Sep 2020 14:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgIASyF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Sep 2020 14:54:05 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46900C061246;
        Tue,  1 Sep 2020 11:54:05 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id u3so1993442qkd.9;
        Tue, 01 Sep 2020 11:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WI61poO+tzD6ywi3PUQTgApvGbiRc/GiQJ11KYgRf2E=;
        b=D4EA6c7IU9mdyulG2hG/aegFWrCtcIT7s/jikZcEyHYrWBIGjPk3dTa9i3gmPjT9ph
         1d6ecywOxoXmDAeCHr9mr0+Ef9L47eEdHn/gWU/iJUn49RTICL1Zj97zofr7CJUYD+cu
         J6XfqLAMSwnvJMy8lTkhVDnKrkmgYkfpNpkwUP9YxJmPHCs/rJQ9iXynJ30qTElmYrP6
         EZ/fJPEhjua7GSUKY3EbOXro8VkKSmt8arm2tde8NG1nHi3X0UnD+EaZMYq5UEjo90pm
         EkD5LXoDFIxyje5BBidcubv51ZFExuBbxEYRPdnuqVNcX+sTH7w1KhftrCW4I/6KQDku
         1tFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=WI61poO+tzD6ywi3PUQTgApvGbiRc/GiQJ11KYgRf2E=;
        b=LMBoD89Dk0frOBlLB2G1kVyJn7o91d+ZoX+qKMBTIs8hjbFUH6IMq+8S2ORUCFnnoP
         Yxc14MwBlLxPmURDc9xUoq/9WRDKA40L16cFx6QZvwZwJIybk/DoLaRPWQe8bc+HSDbM
         a3Pw1I1obMFU/cx2+KPxJF9DWUQx38jyjHDv3NcN1EykT6FUuOp9h4blJc/Kzy/UmrB6
         ceaxACgFF3+nB1mGhjB5Va9koj996IBOXuWfGueHTSoVFh9ApblDQiQ1IpRQve9Vvdg+
         U36qdCgR2+6hjs0zi1bP6mKFTNRa8UrUfd404k0AwDFcLOHC0XXrD1QD35NTFHUkLDms
         8uLw==
X-Gm-Message-State: AOAM53289r0G2oby0kKYqCpURneHeLoMcW21QIqL7kqBOI5AmbDepIMz
        TcLAgEPNl/aqETTLu33YSi8=
X-Google-Smtp-Source: ABdhPJysAO7acug8W6zpx4fqHqJAI5U9kXbT2/PMK313OsvrdYv1kqkvvEirm6512eTQQsRmIwjEBA==
X-Received: by 2002:a37:414f:: with SMTP id o76mr3237770qka.162.1598986444289;
        Tue, 01 Sep 2020 11:54:04 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a198])
        by smtp.gmail.com with ESMTPSA id j8sm2415814qth.90.2020.09.01.11.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 11:54:03 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, newella@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 20/27] blk-iocost: revamp in-period donation snapbacks
Date:   Tue,  1 Sep 2020 14:52:50 -0400
Message-Id: <20200901185257.645114-21-tj@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901185257.645114-1-tj@kernel.org>
References: <20200901185257.645114-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When the margin drops below the minimum on a donating iocg, donation is
immediately canceled in full. There are a couple shortcomings with the
current behavior.

* It's abrupt. A small temporary budget deficit can lead to a wide swing in
  weight allocation and a large surplus.

* It's open coded in the issue path but not implemented for the merge path.
  A series of merges at a low inuse can make the iocg incur debts and stall
  incorrectly.

This patch reimplements in-period donation snapbacks so that

* inuse adjustment and cost calculations are factored into
  adjust_inuse_and_calc_cost() which is called from both the issue and merge
  paths.

* Snapbacks are more gradual. It occurs in quarter steps.

* A snapback triggers if the margin goes below the low threshold and is
  lower than the budget at the time of the last adjustment.

* For the above, __propagate_weights() stores the margin in
  iocg->saved_margin. Move iocg->last_inuse storing together into
  __propagate_weights() for consistency.

* Full snapback is guaranteed when there are waiters.

* With precise donation and gradual snapbacks, inuse adjustments are now a
  lot more effective and the value of scaling inuse on weight changes isn't
  clear. Removed inuse scaling from weight_update().

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-iocost.c | 133 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 96 insertions(+), 37 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 694f1487208a..d09b4011449c 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -226,6 +226,8 @@ enum {
 	MARGIN_TARGET_PCT	= 50,
 	MARGIN_MAX_PCT		= 100,
 
+	INUSE_ADJ_STEP_PCT	= 25,
+
 	/* Have some play in timer operations */
 	TIMER_SLACK_PCT		= 1,
 
@@ -443,12 +445,17 @@ struct ioc_gq {
 	 *
 	 * `last_inuse` remembers `inuse` while an iocg is idle to persist
 	 * surplus adjustments.
+	 *
+	 * `inuse` may be adjusted dynamically during period. `saved_*` are used
+	 * to determine and track adjustments.
 	 */
 	u32				cfg_weight;
 	u32				weight;
 	u32				active;
 	u32				inuse;
+
 	u32				last_inuse;
+	s64				saved_margin;
 
 	sector_t			cursor;		/* to detect randio */
 
@@ -934,9 +941,11 @@ static void ioc_start_period(struct ioc *ioc, struct ioc_now *now)
 
 /*
  * Update @iocg's `active` and `inuse` to @active and @inuse, update level
- * weight sums and propagate upwards accordingly.
+ * weight sums and propagate upwards accordingly. If @save, the current margin
+ * is saved to be used as reference for later inuse in-period adjustments.
  */
-static void __propagate_weights(struct ioc_gq *iocg, u32 active, u32 inuse)
+static void __propagate_weights(struct ioc_gq *iocg, u32 active, u32 inuse,
+				bool save, struct ioc_now *now)
 {
 	struct ioc *ioc = iocg->ioc;
 	int lvl;
@@ -945,6 +954,10 @@ static void __propagate_weights(struct ioc_gq *iocg, u32 active, u32 inuse)
 
 	inuse = clamp_t(u32, inuse, 1, active);
 
+	iocg->last_inuse = iocg->inuse;
+	if (save)
+		iocg->saved_margin = now->vnow - atomic64_read(&iocg->vtime);
+
 	if (active == iocg->active && inuse == iocg->inuse)
 		return;
 
@@ -996,9 +1009,10 @@ static void commit_weights(struct ioc *ioc)
 	}
 }
 
-static void propagate_weights(struct ioc_gq *iocg, u32 active, u32 inuse)
+static void propagate_weights(struct ioc_gq *iocg, u32 active, u32 inuse,
+			      bool save, struct ioc_now *now)
 {
-	__propagate_weights(iocg, active, inuse);
+	__propagate_weights(iocg, active, inuse, save, now);
 	commit_weights(iocg->ioc);
 }
 
@@ -1082,7 +1096,7 @@ static u32 current_hweight_max(struct ioc_gq *iocg)
 	return max_t(u32, hwm, 1);
 }
 
-static void weight_updated(struct ioc_gq *iocg)
+static void weight_updated(struct ioc_gq *iocg, struct ioc_now *now)
 {
 	struct ioc *ioc = iocg->ioc;
 	struct blkcg_gq *blkg = iocg_to_blkg(iocg);
@@ -1093,9 +1107,7 @@ static void weight_updated(struct ioc_gq *iocg)
 
 	weight = iocg->cfg_weight ?: iocc->dfl_weight;
 	if (weight != iocg->weight && iocg->active)
-		propagate_weights(iocg, weight,
-				  DIV64_U64_ROUND_UP((u64)iocg->inuse * weight,
-						     iocg->weight));
+		propagate_weights(iocg, weight, iocg->inuse, true, now);
 	iocg->weight = weight;
 }
 
@@ -1165,8 +1177,9 @@ static bool iocg_activate(struct ioc_gq *iocg, struct ioc_now *now)
 	 */
 	iocg->hweight_gen = atomic_read(&ioc->hweight_gen) - 1;
 	list_add(&iocg->active_list, &ioc->active_iocgs);
+
 	propagate_weights(iocg, iocg->weight,
-			  iocg->last_inuse ?: iocg->weight);
+			  iocg->last_inuse ?: iocg->weight, true, now);
 
 	TRACE_IOCG_PATH(iocg_activate, iocg, now,
 			last_period, cur_period, vtime);
@@ -1789,7 +1802,7 @@ static void transfer_surpluses(struct list_head *surpluses, struct ioc_now *now)
 		inuse = DIV64_U64_ROUND_UP(
 			parent->child_adjusted_sum * iocg->hweight_after_donation,
 			parent->hweight_inuse);
-		__propagate_weights(iocg, iocg->active, inuse);
+		__propagate_weights(iocg, iocg->active, inuse, true, now);
 	}
 
 	/* walk list should be dissolved after use */
@@ -1844,8 +1857,7 @@ static void ioc_timer_fn(struct timer_list *timer)
 			iocg_kick_waitq(iocg, true, &now);
 		} else if (iocg_is_idle(iocg)) {
 			/* no waiter and idle, deactivate */
-			iocg->last_inuse = iocg->inuse;
-			__propagate_weights(iocg, 0, 0);
+			__propagate_weights(iocg, 0, 0, false, &now);
 			list_del_init(&iocg->active_list);
 		}
 
@@ -1925,7 +1937,7 @@ static void ioc_timer_fn(struct timer_list *timer)
 				list_add(&iocg->surplus_list, &surpluses);
 			} else {
 				__propagate_weights(iocg, iocg->active,
-						    iocg->active);
+						    iocg->active, true, &now);
 				nr_shortages++;
 			}
 		} else {
@@ -2055,6 +2067,50 @@ static void ioc_timer_fn(struct timer_list *timer)
 	spin_unlock_irq(&ioc->lock);
 }
 
+static u64 adjust_inuse_and_calc_cost(struct ioc_gq *iocg, u64 vtime,
+				      u64 abs_cost, struct ioc_now *now)
+{
+	struct ioc *ioc = iocg->ioc;
+	struct ioc_margins *margins = &ioc->margins;
+	u32 adj_step = DIV_ROUND_UP(iocg->active * INUSE_ADJ_STEP_PCT, 100);
+	u32 hwi;
+	s64 margin;
+	u64 cost, new_inuse;
+
+	current_hweight(iocg, NULL, &hwi);
+	cost = abs_cost_to_cost(abs_cost, hwi);
+	margin = now->vnow - vtime - cost;
+
+	/*
+	 * We only increase inuse during period and do so iff the margin has
+	 * deteriorated since the previous adjustment.
+	 */
+	if (margin >= iocg->saved_margin || margin >= margins->low ||
+	    iocg->inuse == iocg->active)
+		return cost;
+
+	spin_lock_irq(&ioc->lock);
+
+	/* we own inuse only when @iocg is in the normal active state */
+	if (list_empty(&iocg->active_list)) {
+		spin_unlock_irq(&ioc->lock);
+		return cost;
+	}
+
+	/* bump up inuse till @abs_cost fits in the existing budget */
+	new_inuse = iocg->inuse;
+	do {
+		new_inuse = new_inuse + adj_step;
+		propagate_weights(iocg, iocg->active, new_inuse, true, now);
+		current_hweight(iocg, NULL, &hwi);
+		cost = abs_cost_to_cost(abs_cost, hwi);
+	} while (time_after64(vtime + cost, now->vnow) &&
+		 iocg->inuse != iocg->active);
+
+	spin_unlock_irq(&ioc->lock);
+	return cost;
+}
+
 static void calc_vtime_cost_builtin(struct bio *bio, struct ioc_gq *iocg,
 				    bool is_merge, u64 *costp)
 {
@@ -2136,7 +2192,6 @@ static void ioc_rqos_throttle(struct rq_qos *rqos, struct bio *bio)
 	struct ioc_gq *iocg = blkg_to_iocg(blkg);
 	struct ioc_now now;
 	struct iocg_wait wait;
-	u32 hw_active, hw_inuse;
 	u64 abs_cost, cost, vtime;
 	bool use_debt, ioc_locked;
 	unsigned long flags;
@@ -2154,21 +2209,8 @@ static void ioc_rqos_throttle(struct rq_qos *rqos, struct bio *bio)
 		return;
 
 	iocg->cursor = bio_end_sector(bio);
-
 	vtime = atomic64_read(&iocg->vtime);
-	current_hweight(iocg, &hw_active, &hw_inuse);
-
-	if (hw_inuse < hw_active &&
-	    time_after_eq64(vtime + ioc->margins.min, now.vnow)) {
-		TRACE_IOCG_PATH(inuse_reset, iocg, &now,
-				iocg->inuse, iocg->weight, hw_inuse, hw_active);
-		spin_lock_irq(&ioc->lock);
-		propagate_weights(iocg, iocg->weight, iocg->weight);
-		spin_unlock_irq(&ioc->lock);
-		current_hweight(iocg, &hw_active, &hw_inuse);
-	}
-
-	cost = abs_cost_to_cost(abs_cost, hw_inuse);
+	cost = adjust_inuse_and_calc_cost(iocg, vtime, abs_cost, &now);
 
 	/*
 	 * If no one's waiting and within budget, issue right away.  The
@@ -2190,7 +2232,7 @@ static void ioc_rqos_throttle(struct rq_qos *rqos, struct bio *bio)
 	 */
 	use_debt = bio_issue_as_root_blkg(bio) || fatal_signal_pending(current);
 	ioc_locked = use_debt || READ_ONCE(iocg->abs_vdebt);
-
+retry_lock:
 	iocg_lock(iocg, ioc_locked, &flags);
 
 	/*
@@ -2232,6 +2274,17 @@ static void ioc_rqos_throttle(struct rq_qos *rqos, struct bio *bio)
 		return;
 	}
 
+	/* guarantee that iocgs w/ waiters have maximum inuse */
+	if (iocg->inuse != iocg->active) {
+		if (!ioc_locked) {
+			iocg_unlock(iocg, false, &flags);
+			ioc_locked = true;
+			goto retry_lock;
+		}
+		propagate_weights(iocg, iocg->active, iocg->active, true,
+				  &now);
+	}
+
 	/*
 	 * Append self to the waitq and schedule the wakeup timer if we're
 	 * the first waiter.  The timer duration is calculated based on the
@@ -2274,8 +2327,7 @@ static void ioc_rqos_merge(struct rq_qos *rqos, struct request *rq,
 	struct ioc *ioc = iocg->ioc;
 	sector_t bio_end = bio_end_sector(bio);
 	struct ioc_now now;
-	u32 hw_inuse;
-	u64 abs_cost, cost;
+	u64 vtime, abs_cost, cost;
 	unsigned long flags;
 
 	/* bypass if disabled or for root cgroup */
@@ -2287,8 +2339,9 @@ static void ioc_rqos_merge(struct rq_qos *rqos, struct request *rq,
 		return;
 
 	ioc_now(ioc, &now);
-	current_hweight(iocg, NULL, &hw_inuse);
-	cost = abs_cost_to_cost(abs_cost, hw_inuse);
+
+	vtime = atomic64_read(&iocg->vtime);
+	cost = adjust_inuse_and_calc_cost(iocg, vtime, abs_cost, &now);
 
 	/* update cursor if backmerging into the request at the cursor */
 	if (blk_rq_pos(rq) < bio_end &&
@@ -2530,7 +2583,7 @@ static void ioc_pd_init(struct blkg_policy_data *pd)
 	}
 
 	spin_lock_irqsave(&ioc->lock, flags);
-	weight_updated(iocg);
+	weight_updated(iocg, &now);
 	spin_unlock_irqrestore(&ioc->lock, flags);
 }
 
@@ -2544,7 +2597,10 @@ static void ioc_pd_free(struct blkg_policy_data *pd)
 		spin_lock_irqsave(&ioc->lock, flags);
 
 		if (!list_empty(&iocg->active_list)) {
-			propagate_weights(iocg, 0, 0);
+			struct ioc_now now;
+
+			ioc_now(ioc, &now);
+			propagate_weights(iocg, 0, 0, false, &now);
 			list_del_init(&iocg->active_list);
 		}
 
@@ -2612,6 +2668,7 @@ static ssize_t ioc_weight_write(struct kernfs_open_file *of, char *buf,
 	struct blkcg *blkcg = css_to_blkcg(of_css(of));
 	struct ioc_cgrp *iocc = blkcg_to_iocc(blkcg);
 	struct blkg_conf_ctx ctx;
+	struct ioc_now now;
 	struct ioc_gq *iocg;
 	u32 v;
 	int ret;
@@ -2632,7 +2689,8 @@ static ssize_t ioc_weight_write(struct kernfs_open_file *of, char *buf,
 
 			if (iocg) {
 				spin_lock_irq(&iocg->ioc->lock);
-				weight_updated(iocg);
+				ioc_now(iocg->ioc, &now);
+				weight_updated(iocg, &now);
 				spin_unlock_irq(&iocg->ioc->lock);
 			}
 		}
@@ -2658,7 +2716,8 @@ static ssize_t ioc_weight_write(struct kernfs_open_file *of, char *buf,
 
 	spin_lock(&iocg->ioc->lock);
 	iocg->cfg_weight = v * WEIGHT_ONE;
-	weight_updated(iocg);
+	ioc_now(iocg->ioc, &now);
+	weight_updated(iocg, &now);
 	spin_unlock(&iocg->ioc->lock);
 
 	blkg_conf_finish(&ctx);
-- 
2.26.2


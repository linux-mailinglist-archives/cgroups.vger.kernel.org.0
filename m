Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB2151A2A22
	for <lists+cgroups@lfdr.de>; Wed,  8 Apr 2020 22:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbgDHUPB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Apr 2020 16:15:01 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:47065 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbgDHUPB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Apr 2020 16:15:01 -0400
Received: by mail-qk1-f196.google.com with SMTP id g74so1616382qke.13;
        Wed, 08 Apr 2020 13:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=alpxsM/abPDA1/mjXIVosAx6OTqAHRRnuUUJrYCfVtA=;
        b=JpVYHe+hBeOTw/UTMJ/u+ltNZG1zrXA1nkJhyBcw0TYcodxkSu3qqPgDAfqxTlosIP
         IOZ+dxch6p+vEiT1gAAFKX2EpXlObPAyCG0QxBEYhMt4SYvbFV+cHfe1JRG4jMWTk2sk
         r0C9oHK2xMZ2Kn9/okBz1zl2KS9edOhYjNcbbQkQkrdwIEaXD5ANmrM00fH7D4c00TyI
         heTWDSRMSY/k1m80XCJg4Acf/XTG1grj4E/VO/ts8l3aJj6HTuptMFb89nXCCQ0cs2/t
         A6e3wnW4sTqACSK3k5UVcUH9Si3hsoIjWqxF/knUGaq1jDZpXsX75zLwOU1bodlZ1HTR
         r7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=alpxsM/abPDA1/mjXIVosAx6OTqAHRRnuUUJrYCfVtA=;
        b=q4J0zwxiZuhCSwtW8JSLmJsmt6dzsJe6DuBlcGZ2A7UX7T5RUNKx549y1YH0kYW4AN
         4fCbpYWkPk4zrgT2BIlH0tWPrbsRNbngZj/fjUOJE07Qpf8z5NtTr4i8w6fXc5FTQC25
         tQzT96vrvTDOjs+TmhUN6oMwoVEqJCq4PfUuVfTMLRTbEuEBUc5RREolreU+zQIw6Fpe
         qxtXVP/JQdy1R2f2hS36v7Qug4+L441DpgunQaDmdzm+9N0KqToawoOXRwlFfgFWjW3D
         CpuIs65/m8LvB6N0G6bsWRUxNlVWYmVSoSo6BTVo65bjNfQgwGXJ/FZMBJkaKz2Pwfqi
         VeIw==
X-Gm-Message-State: AGi0PubctY3mwVx2qJe/h06PwvJ6knE4VGb3aXyIuiqS+4S+D+aLaoEh
        vkZ9kgJIxC/hfnUDw+sgQ24=
X-Google-Smtp-Source: APiQypL7YKWZiJ/tElbRGmVG3Z4C+0a0XxHMonMtkzDlMd48yW5WfD8YFwmz19PfSGrNOJT9l4Qegw==
X-Received: by 2002:a05:620a:1084:: with SMTP id g4mr9196377qkk.52.1586376897570;
        Wed, 08 Apr 2020 13:14:57 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::36b2])
        by smtp.gmail.com with ESMTPSA id 65sm1701622qkf.79.2020.04.08.13.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 13:14:56 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@vger.kernel.org, cgroups@vger.kernel.org,
        newella@fb.com, josef@toxicpanda.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/5] blk-iocost: switch to fixed non-auto-decaying use_delay
Date:   Wed,  8 Apr 2020 16:14:46 -0400
Message-Id: <20200408201450.3959560-2-tj@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200408201450.3959560-1-tj@kernel.org>
References: <20200408201450.3959560-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The use_delay mechanism was introduced by blk-iolatency to hold memory
allocators accountable for the reclaim and other shared IOs they cause. The
duration of the delay is dynamically balanced between iolatency increasing the
value on each target miss and it auto-decaying as time passes and threads get
delayed on it.

While this works well for iolatency, iocost's control model isn't compatible
with it. There is no repeated "violation" events which can be balanced against
auto-decaying. iocost instead knows how much a given cgroup is over budget and
wants to prevent that cgroup from issuing IOs while over budget. Until now,
iocost has been adding the cost of force-issued IOs. However, this doesn't
reflect the amount which is already over budget and is simply not enough to
counter the auto-decaying allowing anon-memory leaking low priority cgroup to
go over its alloted share of IOs.

As auto-decaying doesn't make much sense for iocost, this patch introduces a
different mode of operation for use_delay - when blkcg_set_delay() are used
insted of blkcg_add/use_delay(), the delay duration is not auto-decayed until it
is explicitly cleared with blkcg_clear_delay(). iocost is updated to keep the
delay duration synchronized to the budget overage amount.

With this change, iocost can effectively police cgroups which generate
significant amount of force-issued IOs.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-cgroup.c         |  6 ++++++
 block/blk-iocost.c         | 23 ++++++++------------
 include/linux/blk-cgroup.h | 43 +++++++++++++++++++++++++++++---------
 3 files changed, 48 insertions(+), 24 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index c15a26096038..3ee9df979ff2 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1514,6 +1514,10 @@ static void blkcg_scale_delay(struct blkcg_gq *blkg, u64 now)
 {
 	u64 old = atomic64_read(&blkg->delay_start);
 
+	/* negative use_delay means no scaling, see blkcg_set_delay() */
+	if (atomic_read(&blkg->use_delay) < 0)
+		return;
+
 	/*
 	 * We only want to scale down every second.  The idea here is that we
 	 * want to delay people for min(delay_nsec, NSEC_PER_SEC) in a certain
@@ -1701,6 +1705,8 @@ void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay)
  */
 void blkcg_add_delay(struct blkcg_gq *blkg, u64 now, u64 delta)
 {
+	if (WARN_ON_ONCE(atomic_read(&blkg->use_delay) < 0))
+		return;
 	blkcg_scale_delay(blkg, now);
 	atomic64_add(delta, &blkg->delay_nsec);
 }
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index db35ee682294..a8e99ef76a08 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1209,14 +1209,14 @@ static enum hrtimer_restart iocg_waitq_timer_fn(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
-static bool iocg_kick_delay(struct ioc_gq *iocg, struct ioc_now *now, u64 cost)
+static bool iocg_kick_delay(struct ioc_gq *iocg, struct ioc_now *now)
 {
 	struct ioc *ioc = iocg->ioc;
 	struct blkcg_gq *blkg = iocg_to_blkg(iocg);
 	u64 vtime = atomic64_read(&iocg->vtime);
 	u64 vmargin = ioc->margin_us * now->vrate;
 	u64 margin_ns = ioc->margin_us * NSEC_PER_USEC;
-	u64 expires, oexpires;
+	u64 delta_ns, expires, oexpires;
 	u32 hw_inuse;
 
 	/* debt-adjust vtime */
@@ -1233,15 +1233,10 @@ static bool iocg_kick_delay(struct ioc_gq *iocg, struct ioc_now *now, u64 cost)
 		return false;
 
 	/* use delay */
-	if (cost) {
-		u64 cost_ns = DIV64_U64_ROUND_UP(cost * NSEC_PER_USEC,
-						 now->vrate);
-		blkcg_add_delay(blkg, now->now_ns, cost_ns);
-	}
-	blkcg_use_delay(blkg);
-
-	expires = now->now_ns + DIV64_U64_ROUND_UP(vtime - now->vnow,
-						   now->vrate) * NSEC_PER_USEC;
+	delta_ns = DIV64_U64_ROUND_UP(vtime - now->vnow,
+				      now->vrate) * NSEC_PER_USEC;
+	blkcg_set_delay(blkg, delta_ns);
+	expires = now->now_ns + delta_ns;
 
 	/* if already active and close enough, don't bother */
 	oexpires = ktime_to_ns(hrtimer_get_softexpires(&iocg->delay_timer));
@@ -1260,7 +1255,7 @@ static enum hrtimer_restart iocg_delay_timer_fn(struct hrtimer *timer)
 	struct ioc_now now;
 
 	ioc_now(iocg->ioc, &now);
-	iocg_kick_delay(iocg, &now, 0);
+	iocg_kick_delay(iocg, &now);
 
 	return HRTIMER_NORESTART;
 }
@@ -1378,7 +1373,7 @@ static void ioc_timer_fn(struct timer_list *timer)
 		    atomic64_read(&iocg->abs_vdebt)) {
 			/* might be oversleeping vtime / hweight changes, kick */
 			iocg_kick_waitq(iocg, &now);
-			iocg_kick_delay(iocg, &now, 0);
+			iocg_kick_delay(iocg, &now);
 		} else if (iocg_is_idle(iocg)) {
 			/* no waiter and idle, deactivate */
 			iocg->last_inuse = iocg->inuse;
@@ -1737,7 +1732,7 @@ static void ioc_rqos_throttle(struct rq_qos *rqos, struct bio *bio)
 	 */
 	if (bio_issue_as_root_blkg(bio) || fatal_signal_pending(current)) {
 		atomic64_add(abs_cost, &iocg->abs_vdebt);
-		if (iocg_kick_delay(iocg, &now, cost))
+		if (iocg_kick_delay(iocg, &now))
 			blkcg_schedule_throttle(rqos->q,
 					(bio->bi_opf & REQ_SWAP) == REQ_SWAP);
 		return;
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index e4a6949fd171..a95cd4c8a3fb 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -638,6 +638,8 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
 
 static inline void blkcg_use_delay(struct blkcg_gq *blkg)
 {
+	if (WARN_ON_ONCE(atomic_read(&blkg->use_delay) < 0))
+		return;
 	if (atomic_add_return(1, &blkg->use_delay) == 1)
 		atomic_inc(&blkg->blkcg->css.cgroup->congestion_count);
 }
@@ -646,6 +648,8 @@ static inline int blkcg_unuse_delay(struct blkcg_gq *blkg)
 {
 	int old = atomic_read(&blkg->use_delay);
 
+	if (WARN_ON_ONCE(old < 0))
+		return 0;
 	if (old == 0)
 		return 0;
 
@@ -670,20 +674,39 @@ static inline int blkcg_unuse_delay(struct blkcg_gq *blkg)
 	return 1;
 }
 
+/**
+ * blkcg_set_delay - Enable allocator delay mechanism with the specified delay amount
+ * @blkg: target blkg
+ * @delay: delay duration in nsecs
+ *
+ * When enabled with this function, the delay is not decayed and must be
+ * explicitly cleared with blkcg_clear_delay(). Must not be mixed with
+ * blkcg_[un]use_delay() and blkcg_add_delay() usages.
+ */
+static inline void blkcg_set_delay(struct blkcg_gq *blkg, u64 delay)
+{
+	int old = atomic_read(&blkg->use_delay);
+
+	/* We only want 1 person setting the congestion count for this blkg. */
+	if (!old && atomic_cmpxchg(&blkg->use_delay, old, -1) == old)
+		atomic_inc(&blkg->blkcg->css.cgroup->congestion_count);
+
+	atomic64_set(&blkg->delay_nsec, delay);
+}
+
+/**
+ * blkcg_clear_delay - Disable allocator delay mechanism
+ * @blkg: target blkg
+ *
+ * Disable use_delay mechanism. See blkcg_set_delay().
+ */
 static inline void blkcg_clear_delay(struct blkcg_gq *blkg)
 {
 	int old = atomic_read(&blkg->use_delay);
-	if (!old)
-		return;
+
 	/* We only want 1 person clearing the congestion count for this blkg. */
-	while (old) {
-		int cur = atomic_cmpxchg(&blkg->use_delay, old, 0);
-		if (cur == old) {
-			atomic_dec(&blkg->blkcg->css.cgroup->congestion_count);
-			break;
-		}
-		old = cur;
-	}
+	if (old && atomic_cmpxchg(&blkg->use_delay, old, 0) == old)
+		atomic_dec(&blkg->blkcg->css.cgroup->congestion_count);
 }
 
 void blkcg_add_delay(struct blkcg_gq *blkg, u64 now, u64 delta);
-- 
2.25.1


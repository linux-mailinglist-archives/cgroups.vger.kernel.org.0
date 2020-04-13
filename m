Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957DC1A69E7
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2020 18:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731543AbgDMQ2L (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Apr 2020 12:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731412AbgDMQ2H (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Apr 2020 12:28:07 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934B8C0A3BDC;
        Mon, 13 Apr 2020 09:28:06 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id q17so7308537qtp.4;
        Mon, 13 Apr 2020 09:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EDuQGOMVvT7vJ9dx+HQYmA7qvlQ1fW/fXGsJhnifUIg=;
        b=d0Fx3xEv33RKqDBpKlCR5cOoN8m6zAtngj0EXmSQnL48T8TommdYl5LHiVMDDT3cyq
         3GNhu/PrrbOby91Z63E8BYZnLXdh1YN+tmrlM2+t+eGCoRpiKdGEr9MxoQHNaXMVHUL5
         +fJCWF33JkVr0eDDdcdIuiWtE8IVl7aMMh8ogvQvaF7EEK3PQAgtlSYa7aZ/O7K9H8dD
         eaySWM9ulYrXAP5jrHDEP7idY6dQvEFNlOoSs8RLlNyo0Wb5aQyEUFCP3rF4XpmR5qgT
         0+V0rUzow43RTqsmdnPWB6Y8xfI5PiCLbX97VUjDMRahEU7pmNPPjKSuhjaCfVhHULV+
         R08g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=EDuQGOMVvT7vJ9dx+HQYmA7qvlQ1fW/fXGsJhnifUIg=;
        b=l4cqJ9jbD4rjHa3fqlpcv6jeE1ARApiK5Z78WBWqTcyrvD7lzVeBenezLzxOip3ByY
         dtDPWU2NmHxZE/m+uX7iYHNyLu+wkd65emroLTv2z28TQChSn5eVxtP/FA0pvXDMlUjb
         iwuLvjg1GUVe1X5tL9PIL6I7HyfOkqf+PKlDSCy6xL+lUNtQ0fxY2p54J5XumhBcFTRq
         6tov/drwNjb/4RVMTyDBtEilTHBmsuKsWrB7iM2S2AqcaUZ3hYbA+GrcZhqBfhhbVcyE
         klSS0Dqtufh8EMDS4PorrC9YgCbsTTqDmRzeu7GhInLEW0Iqy/m9NHn/IZXME2PG03ID
         6Vfw==
X-Gm-Message-State: AGi0PuZw1vDa5WlTD4/lNScWRSEDgzm2yQE7vEYJ8mpxLHaf792KvUAv
        Pv+opwZ9Xh4pbPWk1Gnx8zw=
X-Google-Smtp-Source: APiQypKCGG6qTQS/DXHKp331uf+LjnuULl0MdLiuu0cc89BKmHDBz3GyscZTkTTLACZtFFw1V0sSuw==
X-Received: by 2002:ac8:3403:: with SMTP id u3mr12424057qtb.274.1586795285464;
        Mon, 13 Apr 2020 09:28:05 -0700 (PDT)
Received: from localhost ([199.96.181.106])
        by smtp.gmail.com with ESMTPSA id y126sm8667350qke.28.2020.04.13.09.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 09:28:04 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org, newella@fb.com,
        josef@toxicpanda.com, asml.silence@gmail.com, ming.lei@redhat.com,
        bvanassche@acm.org, Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/4] blk-iocost: switch to fixed non-auto-decaying use_delay
Date:   Mon, 13 Apr 2020 12:27:55 -0400
Message-Id: <20200413162758.97252-2-tj@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200413162758.97252-1-tj@kernel.org>
References: <20200413162758.97252-1-tj@kernel.org>
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
index c5dc833212e1..0a63c6cbbcb1 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1530,6 +1530,10 @@ static void blkcg_scale_delay(struct blkcg_gq *blkg, u64 now)
 {
 	u64 old = atomic64_read(&blkg->delay_start);
 
+	/* negative use_delay means no scaling, see blkcg_set_delay() */
+	if (atomic_read(&blkg->use_delay) < 0)
+		return;
+
 	/*
 	 * We only want to scale down every second.  The idea here is that we
 	 * want to delay people for min(delay_nsec, NSEC_PER_SEC) in a certain
@@ -1717,6 +1721,8 @@ void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay)
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
index 35f8ffe92b70..3f0f51c4a571 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -629,6 +629,8 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
 
 static inline void blkcg_use_delay(struct blkcg_gq *blkg)
 {
+	if (WARN_ON_ONCE(atomic_read(&blkg->use_delay) < 0))
+		return;
 	if (atomic_add_return(1, &blkg->use_delay) == 1)
 		atomic_inc(&blkg->blkcg->css.cgroup->congestion_count);
 }
@@ -637,6 +639,8 @@ static inline int blkcg_unuse_delay(struct blkcg_gq *blkg)
 {
 	int old = atomic_read(&blkg->use_delay);
 
+	if (WARN_ON_ONCE(old < 0))
+		return 0;
 	if (old == 0)
 		return 0;
 
@@ -661,20 +665,39 @@ static inline int blkcg_unuse_delay(struct blkcg_gq *blkg)
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
2.25.2


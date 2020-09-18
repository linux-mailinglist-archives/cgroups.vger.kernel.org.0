Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3706C26EA1E
	for <lists+cgroups@lfdr.de>; Fri, 18 Sep 2020 02:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgIRApO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Sep 2020 20:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgIRApJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Sep 2020 20:45:09 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B880C061756;
        Thu, 17 Sep 2020 17:45:09 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id o5so4327891qke.12;
        Thu, 17 Sep 2020 17:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3VfMGSmp+708OVCB0V/rCITNRvHxvu/O226lr9+Sv6M=;
        b=G0EYqkC81T77PGGEYaNCMWDYz+gv2r9Qb5LDYOJ+IPNstZZa5g3bo2ZlOyOiuPCBCh
         X8nom7pA3onATBwoxojLEJzQV9qlb/bd5JjcYstQmQWHw2cw0K2CiEqfy6b3VLxBjwHS
         ZZSSeGSqJM0xHKi18lUTGZTgpG769TYc53BpjUVKOS5tQzTiDO93mXXmnE1BFaEzGFWB
         J3FNSSjj5LfRhCjQ+gVsADYyK2JDVWK3tBNNxqHdxvY86fYLDXKpSxnDnD7giQ4XA4Oq
         cTGqnrYHqu4cOtzO/J4gx/Sma/mBI97O4C4UhwEsQxVJD4HWtyZFuia4HQyneZ1SQZ4E
         3nJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3VfMGSmp+708OVCB0V/rCITNRvHxvu/O226lr9+Sv6M=;
        b=KlPQjE8Fo/Az/o6GsM00LY1B2gLRcNVkdZFryK8QJWrnl8KIhTueI8wjm1E0/GVVlm
         lhxEZBOEwSipFaPVFankDFdSMYV06GN7BYKMJPE+v2LDBlOQ1bYpUmWEUFKwzXU1nWSc
         MyOBA1MEYlJGeaF5ioT2wDikWabI2Cmu2d23Vp5UhXvVnL/DlE3zqpxJs9qGqMTFmL2H
         Mp6K4s8mCD8R8AMqVdIwRK1dtFSjy/GRBHjFKENfkgToF98JS4eVBRu9dz1TxNjLiWOE
         evK1yr2vS8TUZ95vNHNotwGVWgp77NRnYx/uFW4T8mwusWAkv2C+IuRFjj1/XCHwRJHj
         lBlw==
X-Gm-Message-State: AOAM532rk8xVbSwH7S5Jjs3VHVYK80RQbNp/eZCZb8kq5q7X93jKF8hn
        hDvZlUSAKo6zbOJLEi7WPHc=
X-Google-Smtp-Source: ABdhPJzbqgI4sz5Kd4ncKMIa6TPuapf0ORRDv1V3v/s447Mjk/b6EZRDHVWHhdGg/CWl6UpHtYjhiw==
X-Received: by 2002:a05:620a:545:: with SMTP id o5mr31602684qko.172.1600389908210;
        Thu, 17 Sep 2020 17:45:08 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:6893])
        by smtp.gmail.com with ESMTPSA id z37sm1069740qtz.67.2020.09.17.17.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 17:45:07 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/5] iocost: reimplement debt forgiveness using average usage
Date:   Thu, 17 Sep 2020 20:44:55 -0400
Message-Id: <20200918004456.593983-5-tj@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200918004456.593983-1-tj@kernel.org>
References: <20200918004456.593983-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Debt forgiveness logic was counting the number of consecutive !busy periods
as the trigger condition. While this usually works, it can easily be thrown
off by temporary fluctuations especially on configurations w/ short periods.

This patch reimplements debt forgiveness so that:

* Use the average usage over the forgiveness period instead of counting
  consecutive periods.

* Debt is reduced at around the target rate (1/2 every 100ms) regardless of
  ioc period duration.

* Usage threshold is raised to 50%. Combined with the preceding changes and
  the switch to average usage, this makes debt forgivness a lot more
  effective at reducing the amount of unnecessary idleness.

* Constants are renamed with DFGV_ prefix.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-iocost.c | 94 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 69 insertions(+), 25 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index ffcb78126ab7..9b1f94499432 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -287,9 +287,9 @@ enum {
 	MIN_DELAY		= 250,
 	MAX_DELAY		= 250 * USEC_PER_MSEC,
 
-	/* halve debts if total usage keeps staying under 25% for over 100ms */
-	DEBT_BUSY_USAGE_PCT	= 25,
-	DEBT_REDUCTION_IDLE_DUR	= 100 * USEC_PER_MSEC,
+	/* halve debts if avg usage over 100ms is under 50% */
+	DFGV_USAGE_PCT		= 50,
+	DFGV_PERIOD		= 100 * USEC_PER_MSEC,
 
 	/* don't let cmds which take a very long time pin lagging for too long */
 	MAX_LAGGING_PERIODS	= 10,
@@ -433,8 +433,10 @@ struct ioc {
 	bool				weights_updated;
 	atomic_t			hweight_gen;	/* for lazy hweights */
 
-	/* the last time debt cancel condition wasn't met */
-	u64				debt_busy_at;
+	/* debt forgivness */
+	u64				dfgv_period_at;
+	u64				dfgv_period_rem;
+	u64				dfgv_usage_us_sum;
 
 	u64				autop_too_fast_at;
 	u64				autop_too_slow_at;
@@ -1251,7 +1253,8 @@ static bool iocg_activate(struct ioc_gq *iocg, struct ioc_now *now)
 
 	if (ioc->running == IOC_IDLE) {
 		ioc->running = IOC_RUNNING;
-		ioc->debt_busy_at = now->now;
+		ioc->dfgv_period_at = now->now;
+		ioc->dfgv_period_rem = 0;
 		ioc_start_period(ioc, now);
 	}
 
@@ -1990,25 +1993,66 @@ static void transfer_surpluses(struct list_head *surpluses, struct ioc_now *now)
 static void ioc_forgive_debts(struct ioc *ioc, u64 usage_us_sum, int nr_debtors,
 			      struct ioc_now *now)
 {
-	if (ioc->busy_level < 0 ||
-	    div64_u64(100 * usage_us_sum, now->now - ioc->period_at) >=
-	    DEBT_BUSY_USAGE_PCT)
-		ioc->debt_busy_at = now->now;
-
-	if (nr_debtors &&
-	    now->now - ioc->debt_busy_at >= DEBT_REDUCTION_IDLE_DUR) {
-		struct ioc_gq *iocg;
-
-		list_for_each_entry(iocg, &ioc->active_iocgs, active_list) {
-			if (iocg->abs_vdebt) {
-				spin_lock(&iocg->waitq.lock);
-				iocg->abs_vdebt /= 2;
-				iocg->delay = 0; /* kick_waitq will recalc */
-				iocg_kick_waitq(iocg, true, now);
-				spin_unlock(&iocg->waitq.lock);
-			}
-		}
-		ioc->debt_busy_at = now->now;
+	struct ioc_gq *iocg;
+	u64 dur, usage_pct, nr_cycles;
+
+	/* if no debtor, reset the cycle */
+	if (!nr_debtors) {
+		ioc->dfgv_period_at = now->now;
+		ioc->dfgv_period_rem = 0;
+		ioc->dfgv_usage_us_sum = 0;
+		return;
+	}
+
+	/*
+	 * Debtors can pass through a lot of writes choking the device and we
+	 * don't want to be forgiving debts while the device is struggling from
+	 * write bursts. If we're missing latency targets, consider the device
+	 * fully utilized.
+	 */
+	if (ioc->busy_level > 0)
+		usage_us_sum = max_t(u64, usage_us_sum, ioc->period_us);
+
+	ioc->dfgv_usage_us_sum += usage_us_sum;
+	if (time_before64(now->now, ioc->dfgv_period_at + DFGV_PERIOD))
+		return;
+
+	/*
+	 * At least DFGV_PERIOD has passed since the last period. Calculate the
+	 * average usage and reset the period counters.
+	 */
+	dur = now->now - ioc->dfgv_period_at;
+	usage_pct = div64_u64(100 * ioc->dfgv_usage_us_sum, dur);
+
+	ioc->dfgv_period_at = now->now;
+	ioc->dfgv_usage_us_sum = 0;
+
+	/* if was too busy, reset everything */
+	if (usage_pct > DFGV_USAGE_PCT) {
+		ioc->dfgv_period_rem = 0;
+		return;
+	}
+
+	/*
+	 * Usage is lower than threshold. Let's forgive some debts. Debt
+	 * forgiveness runs off of the usual ioc timer but its period usually
+	 * doesn't match ioc's. Compensate the difference by performing the
+	 * reduction as many times as would fit in the duration since the last
+	 * run and carrying over the left-over duration in @ioc->dfgv_period_rem
+	 * - if ioc period is 75% of DFGV_PERIOD, one out of three consecutive
+	 * reductions is doubled.
+	 */
+	nr_cycles = dur + ioc->dfgv_period_rem;
+	ioc->dfgv_period_rem = do_div(nr_cycles, DFGV_PERIOD);
+
+	list_for_each_entry(iocg, &ioc->active_iocgs, active_list) {
+		if (!iocg->abs_vdebt)
+			continue;
+		spin_lock(&iocg->waitq.lock);
+		iocg->abs_vdebt >>= nr_cycles;
+		iocg->delay = 0; /* kick_waitq will recalc */
+		iocg_kick_waitq(iocg, true, now);
+		spin_unlock(&iocg->waitq.lock);
 	}
 }
 
-- 
2.26.2


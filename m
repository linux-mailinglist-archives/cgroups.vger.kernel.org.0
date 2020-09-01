Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5796259EA9
	for <lists+cgroups@lfdr.de>; Tue,  1 Sep 2020 20:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730723AbgIASzQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Sep 2020 14:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731874AbgIASyL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Sep 2020 14:54:11 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221C7C061249;
        Tue,  1 Sep 2020 11:54:11 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id b3so1725696qtg.13;
        Tue, 01 Sep 2020 11:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5UgoIrVUcwXACuCYd1cS80ywOzFHs5fY3NlOJo1IMJU=;
        b=d1BhVmQ+r2vM4ZCGNxytJ6sRkOxhcAKI98OMingTJiqDnyz/j5a9XSe3ok/dAbNH8j
         zms8uyQjXMnVVyYKZmWiZJ/wwTwlWWMHi7oRRHbYjLWdpvWXwjZopKrHfX5uWkT8Zwig
         mumwXLMcBAI+BvcJeUndRamVFjKVe1LXz+uh+oG3dzhGgPfCgL2fOzuuA2sZwrUNMKSG
         LdN/T0/Ju6ECBbJvIEotRusbWmhFZ4EbC0SeALRLGI92iqaHDWoAk7dvbICAybxD8Hnl
         3SxwcS+7fl31WP1yOefToo777+sEBmsgaDfe2mKJMBa3Rs6l7LhMjN0OQU05F+Dbf7DP
         wy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=5UgoIrVUcwXACuCYd1cS80ywOzFHs5fY3NlOJo1IMJU=;
        b=NaZww3sdLTXAg95eoABSPbIMuZq+X6OfA8pR2UR7sPyOt8vSslj03lHZfeFXzDvCl5
         Wj0wzBNpaMO1smCP8/M0+F9FAPTBCzCkthemhVWIQMCOmWgkQWys08//EKxQqpM2tAij
         XBcu1OQevUwlxO/scylmjX8dGo9SUu1FIy9xoIOnZv01ydR67ocQ50uEGYkIk6De/nSJ
         NRN5nbVZ4xdRefvb6v27pH/0EaeNyD7Z4d1RIKEu93UJaV8FhT/hC79zdvqD8BVcYNoy
         ZU2osnrD63JSh/Kt1sA3++Q6N+vvDy0Snz+JBYCRoh21zNIrBbMKARkfXYOojrikDExa
         4rRA==
X-Gm-Message-State: AOAM5303maDPu2/mCK8ngyGPqVjXgireERo7qRm8votSOxWO8W3NnmCs
        VcogYRdhlIp6adO+w1Q4MkM=
X-Google-Smtp-Source: ABdhPJxABrzIUmgvWAorSCTnHRblbapB7DxnIVnpOiQDJC/nlppjqKOVL++gwwuXfD1p/qGd2DadvA==
X-Received: by 2002:ac8:67d2:: with SMTP id r18mr3343177qtp.179.1598986450224;
        Tue, 01 Sep 2020 11:54:10 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a198])
        by smtp.gmail.com with ESMTPSA id k185sm2545673qkd.94.2020.09.01.11.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 11:54:09 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, newella@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 23/27] blk-iocost: halve debts if device stays idle
Date:   Tue,  1 Sep 2020 14:52:53 -0400
Message-Id: <20200901185257.645114-24-tj@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901185257.645114-1-tj@kernel.org>
References: <20200901185257.645114-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

A low weight iocg can amass a large amount of debt, for example, when
anonymous memory gets reclaimed aggressively. If the system has a lot of
memory paired with a slow IO device, the debt can span multiple seconds or
more. If there are no other subsequent IO issuers, the in-debt iocg may end
up blocked paying its debt while the IO device is idle.

This patch implements a mechanism to protect against such pathological
cases. If the device has been sufficiently idle for a substantial amount of
time, the debts are halved. The criteria are on the conservative side as we
want to resolve the rare extreme cases without impacting regular operation
by forgiving debts too readily.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-iocost.c | 49 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 9cb8f29f01f5..2a95a081cf44 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -295,6 +295,13 @@ enum {
 	MIN_DELAY		= 250,
 	MAX_DELAY		= 250 * USEC_PER_MSEC,
 
+	/*
+	 * Halve debts if total usage keeps staying under 25% w/o any shortages
+	 * for over 100ms.
+	 */
+	DEBT_BUSY_USAGE_PCT	= 25,
+	DEBT_REDUCTION_IDLE_DUR	= 100 * USEC_PER_MSEC,
+
 	/* don't let cmds which take a very long time pin lagging for too long */
 	MAX_LAGGING_PERIODS	= 10,
 
@@ -436,6 +443,9 @@ struct ioc {
 	bool				weights_updated;
 	atomic_t			hweight_gen;	/* for lazy hweights */
 
+	/* the last time debt cancel condition wasn't met */
+	u64				debt_busy_at;
+
 	u64				autop_too_fast_at;
 	u64				autop_too_slow_at;
 	int				autop_idx;
@@ -1216,6 +1226,7 @@ static bool iocg_activate(struct ioc_gq *iocg, struct ioc_now *now)
 
 	if (ioc->running == IOC_IDLE) {
 		ioc->running = IOC_RUNNING;
+		ioc->debt_busy_at = now->now;
 		ioc_start_period(ioc, now);
 	}
 
@@ -1896,7 +1907,8 @@ static void ioc_timer_fn(struct timer_list *timer)
 	struct ioc_gq *iocg, *tiocg;
 	struct ioc_now now;
 	LIST_HEAD(surpluses);
-	int nr_shortages = 0, nr_lagging = 0;
+	int nr_debtors = 0, nr_shortages = 0, nr_lagging = 0;
+	u64 usage_us_sum = 0;
 	u32 ppm_rthr = MILLION - ioc->params.qos[QOS_RPPM];
 	u32 ppm_wthr = MILLION - ioc->params.qos[QOS_WPPM];
 	u32 missed_ppm[2], rq_wait_pct;
@@ -1936,6 +1948,8 @@ static void ioc_timer_fn(struct timer_list *timer)
 		    iocg->delay) {
 			/* might be oversleeping vtime / hweight changes, kick */
 			iocg_kick_waitq(iocg, true, &now);
+			if (iocg->abs_vdebt)
+				nr_debtors++;
 		} else if (iocg_is_idle(iocg)) {
 			/* no waiter and idle, deactivate */
 			__propagate_weights(iocg, 0, 0, false, &now);
@@ -1978,6 +1992,7 @@ static void ioc_timer_fn(struct timer_list *timer)
 		 * high-latency completions appearing as idle.
 		 */
 		usage_us = iocg->usage_delta_us;
+		usage_us_sum += usage_us;
 
 		if (vdone != vtime) {
 			u64 inflight_us = DIV64_U64_ROUND_UP(
@@ -2036,6 +2051,38 @@ static void ioc_timer_fn(struct timer_list *timer)
 	list_for_each_entry_safe(iocg, tiocg, &surpluses, surplus_list)
 		list_del_init(&iocg->surplus_list);
 
+	/*
+	 * A low weight iocg can amass a large amount of debt, for example, when
+	 * anonymous memory gets reclaimed aggressively. If the system has a lot
+	 * of memory paired with a slow IO device, the debt can span multiple
+	 * seconds or more. If there are no other subsequent IO issuers, the
+	 * in-debt iocg may end up blocked paying its debt while the IO device
+	 * is idle.
+	 *
+	 * The following protects against such pathological cases. If the device
+	 * has been sufficiently idle for a substantial amount of time, the
+	 * debts are halved. The criteria are on the conservative side as we
+	 * want to resolve the rare extreme cases without impacting regular
+	 * operation by forgiving debts too readily.
+	 */
+	if (nr_shortages ||
+	    div64_u64(100 * usage_us_sum, now.now - ioc->period_at) >=
+	    DEBT_BUSY_USAGE_PCT)
+		ioc->debt_busy_at = now.now;
+
+	if (nr_debtors &&
+	    now.now - ioc->debt_busy_at >= DEBT_REDUCTION_IDLE_DUR) {
+		list_for_each_entry(iocg, &ioc->active_iocgs, active_list) {
+			if (iocg->abs_vdebt) {
+				spin_lock(&iocg->waitq.lock);
+				iocg->abs_vdebt /= 2;
+				iocg_kick_waitq(iocg, true, &now);
+				spin_unlock(&iocg->waitq.lock);
+			}
+		}
+		ioc->debt_busy_at = now.now;
+	}
+
 	/*
 	 * If q is getting clogged or we're missing too much, we're issuing
 	 * too much IO and should lower vtime rate.  If we're not missing
-- 
2.26.2


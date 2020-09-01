Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C8B259E88
	for <lists+cgroups@lfdr.de>; Tue,  1 Sep 2020 20:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731960AbgIASyd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Sep 2020 14:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731917AbgIASyW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Sep 2020 14:54:22 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E312C061245;
        Tue,  1 Sep 2020 11:54:21 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id 60so1735794qtc.9;
        Tue, 01 Sep 2020 11:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m+qTmQYuX+yoSNUOz4jTM/Jvux+Eq7PX2lLyJ9lYHRM=;
        b=XipZHXfU9XrCtlGklpOQGNXRadhcHdExtLsTEZL7t60433LLNu7tEHGjQqBqMC+iR7
         dzOZrvVvPn13/zRt1PKU3F9yOKmtRpSRDlUXyHHWyzh8LKcLYdSQ4C5U9dSjstz6fM0M
         j4gZRzS5tOd4+1i6w3lS3cx1sPdlhcRfer1SkYCs6qDq7Oi+WJoj+1xBKAZdM+qZd3XQ
         JnpfCe0cEXjxqluYe3gDlwQCygUtDoiivx5w4r914bM2z2dyq0ESorJJuIySt6s90gmS
         dVBA+q9jEx5wqCLzMbOcH/IX3zWUiR1PQnygRDH6WXwyH0wNqYOYCRbi0sFgurl8XLdC
         i9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=m+qTmQYuX+yoSNUOz4jTM/Jvux+Eq7PX2lLyJ9lYHRM=;
        b=snSnaJkGV5z1+i3jtjIcUK5f2qsbX2MDEmhG2ZTAFWHCbXtF4LGse1SPfn10pAw/7u
         NUIfYJmKAZ5vi89amZPe32U0v9vLq9vuTVnnSKBmCJ7CqPj34bs8q8wsF2kHAd8x/yg7
         NpT5QzX7z8FeqiBI2F3s+cmfssNHmxGQfRV7CJdxDqVykI5kMmvDVQkoYmVd3M014fyO
         kr6J5m8XXrTgqbJoz/wupnJnsC5UKKENi59Wk4e6jxpOgOT33lk0rArkHAYLWIHEDI/3
         5pbONgDR2Vw07y5QpVwInbwQnwrml9QKspeaN9Z6Aq+h9fRw4gZW+6ypKudMH4YjNwo6
         RNMg==
X-Gm-Message-State: AOAM530We733ZwdkFYv/5m3KzdSj5qudSNgUyTOaq2/SYE9ts7U0LteP
        5aDdrk3X8wjGNmkwg3/RQEs=
X-Google-Smtp-Source: ABdhPJzUspyaN4Tu+/SqUVmwCZWio6vGZQ+22rInJpzfHUowHkMwaTKle0jWv9IsEhZA4s2chmePNw==
X-Received: by 2002:ac8:6d32:: with SMTP id r18mr3346066qtu.246.1598986460695;
        Tue, 01 Sep 2020 11:54:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a198])
        by smtp.gmail.com with ESMTPSA id i65sm2409921qkf.126.2020.09.01.11.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 11:54:20 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, newella@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 26/27] blk-iocost: add three debug stat - cost.wait, indebt and indelay
Date:   Tue,  1 Sep 2020 14:52:56 -0400
Message-Id: <20200901185257.645114-27-tj@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901185257.645114-1-tj@kernel.org>
References: <20200901185257.645114-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

These are really cheap to collect and can be useful in debugging iocost
behavior. Add them as debug stats for now.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-iocost.c | 77 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 72 insertions(+), 5 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 9366527d8c12..fc897bb142bc 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -452,6 +452,9 @@ struct iocg_pcpu_stat {
 
 struct iocg_stat {
 	u64				usage_us;
+	u64				wait_us;
+	u64				indebt_us;
+	u64				indelay_us;
 };
 
 /* per device-cgroup pair */
@@ -538,6 +541,9 @@ struct ioc_gq {
 	struct iocg_stat		last_stat;
 	u64				last_stat_abs_vusage;
 	u64				usage_delta_us;
+	u64				wait_since;
+	u64				indebt_since;
+	u64				indelay_since;
 
 	/* this iocg's depth in the hierarchy and ancestors including self */
 	int				level;
@@ -1303,9 +1309,15 @@ static bool iocg_kick_delay(struct ioc_gq *iocg, struct ioc_now *now)
 	}
 
 	if (delay >= MIN_DELAY) {
+		if (!iocg->indelay_since)
+			iocg->indelay_since = now->now;
 		blkcg_set_delay(blkg, delay * NSEC_PER_USEC);
 		return true;
 	} else {
+		if (iocg->indelay_since) {
+			iocg->local_stat.indelay_us += now->now - iocg->indelay_since;
+			iocg->indelay_since = 0;
+		}
 		iocg->delay = 0;
 		blkcg_clear_delay(blkg);
 		return false;
@@ -1325,8 +1337,10 @@ static void iocg_incur_debt(struct ioc_gq *iocg, u64 abs_cost,
 	 * Once in debt, debt handling owns inuse. @iocg stays at the minimum
 	 * inuse donating all of it share to others until its debt is paid off.
 	 */
-	if (!iocg->abs_vdebt && abs_cost)
+	if (!iocg->abs_vdebt && abs_cost) {
+		iocg->indebt_since = now->now;
 		propagate_weights(iocg, iocg->active, 0, false, now);
+	}
 
 	iocg->abs_vdebt += abs_cost;
 
@@ -1348,9 +1362,13 @@ static void iocg_pay_debt(struct ioc_gq *iocg, u64 abs_vpay,
 	iocg->abs_vdebt -= min(abs_vpay, iocg->abs_vdebt);
 
 	/* if debt is paid in full, restore inuse */
-	if (!iocg->abs_vdebt)
+	if (!iocg->abs_vdebt) {
+		iocg->local_stat.indebt_us += now->now - iocg->indebt_since;
+		iocg->indebt_since = 0;
+
 		propagate_weights(iocg, iocg->active, iocg->last_inuse,
 				  false, now);
+	}
 }
 
 static int iocg_wake_fn(struct wait_queue_entry *wq_entry, unsigned mode,
@@ -1436,8 +1454,17 @@ static void iocg_kick_waitq(struct ioc_gq *iocg, bool pay_debt,
 
 	__wake_up_locked_key(&iocg->waitq, TASK_NORMAL, &ctx);
 
-	if (!waitqueue_active(&iocg->waitq))
+	if (!waitqueue_active(&iocg->waitq)) {
+		if (iocg->wait_since) {
+			iocg->local_stat.wait_us += now->now - iocg->wait_since;
+			iocg->wait_since = 0;
+		}
 		return;
+	}
+
+	if (!iocg->wait_since)
+		iocg->wait_since = now->now;
+
 	if (WARN_ON_ONCE(ctx.vbudget >= 0))
 		return;
 
@@ -1579,8 +1606,15 @@ static void iocg_flush_stat_one(struct ioc_gq *iocg, struct ioc_now *now)
 	iocg->usage_delta_us = div64_u64(vusage_delta, ioc->vtime_base_rate);
 	iocg->local_stat.usage_us += iocg->usage_delta_us;
 
+	/* propagate upwards */
 	new_stat.usage_us =
 		iocg->local_stat.usage_us + iocg->desc_stat.usage_us;
+	new_stat.wait_us =
+		iocg->local_stat.wait_us + iocg->desc_stat.wait_us;
+	new_stat.indebt_us =
+		iocg->local_stat.indebt_us + iocg->desc_stat.indebt_us;
+	new_stat.indelay_us =
+		iocg->local_stat.indelay_us + iocg->desc_stat.indelay_us;
 
 	/* propagate the deltas to the parent */
 	if (iocg->level > 0) {
@@ -1589,6 +1623,12 @@ static void iocg_flush_stat_one(struct ioc_gq *iocg, struct ioc_now *now)
 
 		parent_stat->usage_us +=
 			new_stat.usage_us - iocg->last_stat.usage_us;
+		parent_stat->wait_us +=
+			new_stat.wait_us - iocg->last_stat.wait_us;
+		parent_stat->indebt_us +=
+			new_stat.indebt_us - iocg->last_stat.indebt_us;
+		parent_stat->indelay_us +=
+			new_stat.indelay_us - iocg->last_stat.indelay_us;
 	}
 
 	iocg->last_stat = new_stat;
@@ -1961,8 +2001,6 @@ static void ioc_timer_fn(struct timer_list *timer)
 		return;
 	}
 
-	iocg_flush_stat(&ioc->active_iocgs, &now);
-
 	/*
 	 * Waiters determine the sleep durations based on the vrate they
 	 * saw at the time of sleep.  If vrate has increased, some waiters
@@ -1976,6 +2014,22 @@ static void ioc_timer_fn(struct timer_list *timer)
 
 		spin_lock(&iocg->waitq.lock);
 
+		/* flush wait and indebt stat deltas */
+		if (iocg->wait_since) {
+			iocg->local_stat.wait_us += now.now - iocg->wait_since;
+			iocg->wait_since = now.now;
+		}
+		if (iocg->indebt_since) {
+			iocg->local_stat.indebt_us +=
+				now.now - iocg->indebt_since;
+			iocg->indebt_since = now.now;
+		}
+		if (iocg->indelay_since) {
+			iocg->local_stat.indelay_us +=
+				now.now - iocg->indelay_since;
+			iocg->indelay_since = now.now;
+		}
+
 		if (waitqueue_active(&iocg->waitq) || iocg->abs_vdebt ||
 		    iocg->delay) {
 			/* might be oversleeping vtime / hweight changes, kick */
@@ -2010,6 +2064,12 @@ static void ioc_timer_fn(struct timer_list *timer)
 	}
 	commit_weights(ioc);
 
+	/*
+	 * Wait and indebt stat are flushed above and the donation calculation
+	 * below needs updated usage stat. Let's bring stat up-to-date.
+	 */
+	iocg_flush_stat(&ioc->active_iocgs, &now);
+
 	/* calc usage and see whether some weights need to be moved around */
 	list_for_each_entry(iocg, &ioc->active_iocgs, active_list) {
 		u64 vdone, vtime, usage_us, usage_dur;
@@ -2835,6 +2895,13 @@ static size_t ioc_pd_stat(struct blkg_policy_data *pd, char *buf, size_t size)
 	pos += scnprintf(buf + pos, size - pos, " cost.usage=%llu",
 			 iocg->last_stat.usage_us);
 
+	if (blkcg_debug_stats)
+		pos += scnprintf(buf + pos, size - pos,
+				 " cost.wait=%llu cost.indebt=%llu cost.indelay=%llu",
+				 iocg->last_stat.wait_us,
+				 iocg->last_stat.indebt_us,
+				 iocg->last_stat.indelay_us);
+
 	return pos;
 }
 
-- 
2.26.2


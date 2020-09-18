Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A4C26EA13
	for <lists+cgroups@lfdr.de>; Fri, 18 Sep 2020 02:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgIRApG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Sep 2020 20:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgIRApF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Sep 2020 20:45:05 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE42C06174A;
        Thu, 17 Sep 2020 17:45:05 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id w12so4366434qki.6;
        Thu, 17 Sep 2020 17:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j/zKXBEr6TfdKAVuGNBQ0JBMHe4IOIVvKgYa0IBCbeM=;
        b=V+eukaeBQ9EymY1UpurIpKChUF9k/7A5HpI5/TyACkajuXTHx7jxGZYyFFS4HHakSz
         nZTlahmQZU2BrlkbxdryiyrNSNTZYN4Q3cS8mMllkeSjCt7+ygWZm+WBsRa96E22GKe5
         xwSeNq6ftFaRDQL7gHjJLdFHKBTbIBQVfGKbckFdEYSDxBglwYcWuQKTeYHWD088XX0S
         gMX2DCEaHHGym14WixlbHcyFItlTD+EccCdxeRR0xJrR0LL6iCVD/CPf6FbLcnIIm7sN
         FGQH5TccRjAysF7Tn9HalVYbLkFf/Mp6HIuH1N2SbQevxwTI9QZPdSBR/24ktpX2WpAk
         SkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=j/zKXBEr6TfdKAVuGNBQ0JBMHe4IOIVvKgYa0IBCbeM=;
        b=YhSGKQ91xp8v2EKIywIbasQYArAtkXEYnzvMwX+ipCckuTZQFAOdLn+Q9C92vCr8MT
         EGAaC2wo/uRG5uwD/Ujh7u6vZACt2GTZYiiBgaKG1mZ5K9SXeO37P/sv4BeUSFkbCwpx
         rCaRzuMRj/Lxwhoa31q99DWKdJz1cIY13sNSVP/ZbfNVRdHkgYUwSTR/MU2E4ul/MxW8
         NglweU7R0w0+ZLaIh6CPbjSALa9cMaVgzJVV5qhcW5OH6Kuc0dmeMGbJAkaLrh+BGARw
         rj98krtKY2vQEdmEtj/XyBSH2X6QFL8FoMMw/eOwQyJIF6//iZtG3elDWjE8W+Kka7Aq
         6Ugg==
X-Gm-Message-State: AOAM533+ksn1rUl3itBRXC/A+8bEtPCaZp5CC0dLSz0dAJjMEQO0GCua
        A7ghUvu7KgwkI7f4l4kNlpE=
X-Google-Smtp-Source: ABdhPJx9F4osQFUKiKrsAy9zgGKkumTulERLM/MfTr25TsVyTtPN0lvPXXRmQ2S5tVuJqsJqx7wr0A==
X-Received: by 2002:a37:52c1:: with SMTP id g184mr8650621qkb.425.1600389904204;
        Thu, 17 Sep 2020 17:45:04 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:6893])
        by smtp.gmail.com with ESMTPSA id 85sm1032669qkn.64.2020.09.17.17.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 17:45:03 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/5] iocost: replace nr_shortages cond in ioc_forgive_debts() with busy_level one
Date:   Thu, 17 Sep 2020 20:44:53 -0400
Message-Id: <20200918004456.593983-3-tj@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200918004456.593983-1-tj@kernel.org>
References: <20200918004456.593983-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Debt reduction was blocked if any iocg was short on budget in the past
period to avoid reducing debts while some iocgs are saturated. However, this
ends up unnecessarily blocking debt reduction due to temporary local
imbalances when the device is generally being underutilized, while also
failing to block when the underlying device is overwhelmed and the usage
becomes low from high latency.

Given that debt accumulation mostly happens with swapout bursts which can
significantly deteriorate the underlying device's latency response, the
current logic is not great.

Let's replace it with ioc->busy_level based condition so that we block debt
reduction when the underlying device is being saturated. ioc_forgive_debts()
call is moved after busy_level determination.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-iocost.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index bbf30bb06c07..c0499c294da9 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -287,10 +287,7 @@ enum {
 	MIN_DELAY		= 250,
 	MAX_DELAY		= 250 * USEC_PER_MSEC,
 
-	/*
-	 * Halve debts if total usage keeps staying under 25% w/o any shortages
-	 * for over 100ms.
-	 */
+	/* halve debts if total usage keeps staying under 25% for over 100ms */
 	DEBT_BUSY_USAGE_PCT	= 25,
 	DEBT_REDUCTION_IDLE_DUR	= 100 * USEC_PER_MSEC,
 
@@ -1990,9 +1987,9 @@ static void transfer_surpluses(struct list_head *surpluses, struct ioc_now *now)
  * sufficiently idle for a while, the debts are halved.
  */
 static void ioc_forgive_debts(struct ioc *ioc, u64 usage_us_sum, int nr_debtors,
-			      int nr_shortages, struct ioc_now *now)
+			      struct ioc_now *now)
 {
-	if (nr_shortages ||
+	if (ioc->busy_level < 0 ||
 	    div64_u64(100 * usage_us_sum, now->now - ioc->period_at) >=
 	    DEBT_BUSY_USAGE_PCT)
 		ioc->debt_busy_at = now->now;
@@ -2205,8 +2202,6 @@ static void ioc_timer_fn(struct timer_list *timer)
 	list_for_each_entry_safe(iocg, tiocg, &surpluses, surplus_list)
 		list_del_init(&iocg->surplus_list);
 
-	ioc_forgive_debts(ioc, usage_us_sum, nr_debtors, nr_shortages, &now);
-
 	/*
 	 * If q is getting clogged or we're missing too much, we're issuing
 	 * too much IO and should lower vtime rate.  If we're not missing
@@ -2301,6 +2296,8 @@ static void ioc_timer_fn(struct timer_list *timer)
 
 	ioc_refresh_params(ioc, false);
 
+	ioc_forgive_debts(ioc, usage_us_sum, nr_debtors, &now);
+
 	/*
 	 * This period is done.  Move onto the next one.  If nothing's
 	 * going on with the device, stop the timer.
-- 
2.26.2


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D34A4BE8AA
	for <lists+cgroups@lfdr.de>; Thu, 26 Sep 2019 01:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfIYXDN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 Sep 2019 19:03:13 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44062 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfIYXDN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 Sep 2019 19:03:13 -0400
Received: by mail-qk1-f196.google.com with SMTP id u22so191460qkk.11;
        Wed, 25 Sep 2019 16:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+2s0oXR538dsUd5mHpXcur3xcbIHPtS2CMh60hp/fzM=;
        b=lirB5BC8U7A7hYKAMl7kBbxc6YJxcklp0YnCGMGTuWHyBImdAtixJC+AFZylYcBLG2
         g8hlcI40h40Ks1Y9AkE+Frij4whfpsgJzSBjJkQDI2LVIGiu+xxdPep+rQK7G2czxNPp
         bBCx1Vv+ddbACfvLlGig3qz6WPm5mJWE/8nm+uNcagUIluMY3PRYOPIkRzC5R8Pnmgz4
         tExhI0IiMCyAblozYrZ0X2Zdk32mmIjfckrx20gSLbRHYbFs+93Ga1G1+UFr5deF89Ta
         FBcaReTOPRiYyxAoVgH/pMHTmOp9w5zLvQ0Y8lnVKaNuj5J8HkvGZFa5Gd7SMQLVB5X6
         lUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+2s0oXR538dsUd5mHpXcur3xcbIHPtS2CMh60hp/fzM=;
        b=DolbGWu+V6AaKG7c6Uych8cHDN7PSXleBMHjSAWVJr7ROvFk2aWFwpNV+5KWp5B4bW
         PWyGc8lp0dZ5Q6hM075I5oHrASKHglVjRTD/vfWLatHxDJIOCohN86A3szGe0jYVGt7w
         B5SVdu9WtB33YGK9hc7LIW48cjCMrxqzR29uQJ7tGxopjSzcp6qAeMiLfQKb+yWI9hGI
         I2j2s4kI2NW2PJgB0j1Kxrm9Cc9S/2z1GJa/4ToxpPWuPy/b5FilaMPNYnCJXuW/RY8D
         kpiBzp1SmajmHI5dh1uU7NV02dTMYYtYz7/Up7A+lGBHHIWMtIlNzp06l008p8j4JGXZ
         tKiA==
X-Gm-Message-State: APjAAAVVzKSm9SpCIZOR9wJiK4SNyRQAwQF4uMxPT5ZCGRti64W/sFGr
        3bsmVqcWkt+TBbxbuXHK5uY=
X-Google-Smtp-Source: APXvYqz6X5CLZiRgdLEkLrgwcksoK5XgwtkoG+UNUHxhzTE3TndXVJwyw7Xkm6jDRldgFVN+VHl8fA==
X-Received: by 2002:a05:620a:15d2:: with SMTP id o18mr375515qkm.341.1569452591643;
        Wed, 25 Sep 2019 16:03:11 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:a001])
        by smtp.gmail.com with ESMTPSA id b26sm119056qkl.43.2019.09.25.16.03.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Sep 2019 16:03:11 -0700 (PDT)
Date:   Wed, 25 Sep 2019 16:03:09 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org
Subject: [PATCH 2/3 for-5.4/block] iocost: improve nr_lagging handling
Message-ID: <20190925230309.GJ2233839@devbig004.ftw2.facebook.com>
References: <20190925230207.GI2233839@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925230207.GI2233839@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Some IOs may span multiple periods.  As latencies are collected on
completion, the inbetween periods won't register them and may
incorrectly decide to increase vrate.  nr_lagging tracks these IOs to
avoid those situations.  Currently, whenever there are IOs which are
spanning from the previous period, busy_level is reset to 0 if
negative thus suppressing vrate increase.

This has the following two problems.

* When latency target percentiles aren't set, vrate adjustment should
  only be governed by queue depth depletion; however, the current code
  keeps nr_lagging active which pulls in latency results and can keep
  down vrate unexpectedly.

* When lagging condition is detected, it resets the entire negative
  busy_level.  This turned out to be way too aggressive on some
  devices which sometimes experience extended latencies on a small
  subset of commands.  In addition, a lagging IO will be accounted as
  latency target miss on completion anyway and resetting busy_level
  amplifies its impact unnecessarily.

This patch fixes the above two problems by disabling nr_lagging
counting when latency target percentiles aren't set and blocking vrate
increases when there are lagging IOs while leaving busy_level as-is.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-iocost.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1407,7 +1407,8 @@ static void ioc_timer_fn(struct timer_li
 		 * comparing vdone against period start.  If lagging behind
 		 * IOs from past periods, don't increase vrate.
 		 */
-		if (!atomic_read(&iocg_to_blkg(iocg)->use_delay) &&
+		if ((ppm_rthr != MILLION || ppm_wthr != MILLION) &&
+		    !atomic_read(&iocg_to_blkg(iocg)->use_delay) &&
 		    time_after64(vtime, vdone) &&
 		    time_after64(vtime, now.vnow -
 				 MAX_LAGGING_PERIODS * period_vtime) &&
@@ -1537,21 +1538,23 @@ skip_surplus_transfers:
 	    missed_ppm[WRITE] > ppm_wthr) {
 		ioc->busy_level = max(ioc->busy_level, 0);
 		ioc->busy_level++;
-	} else if (nr_lagging) {
-		ioc->busy_level = max(ioc->busy_level, 0);
-	} else if (nr_shortages && !nr_surpluses &&
-		   rq_wait_pct <= RQ_WAIT_BUSY_PCT * UNBUSY_THR_PCT / 100 &&
+	} else if (rq_wait_pct <= RQ_WAIT_BUSY_PCT * UNBUSY_THR_PCT / 100 &&
 		   missed_ppm[READ] <= ppm_rthr * UNBUSY_THR_PCT / 100 &&
 		   missed_ppm[WRITE] <= ppm_wthr * UNBUSY_THR_PCT / 100) {
-		ioc->busy_level = min(ioc->busy_level, 0);
-		ioc->busy_level--;
+		/* take action iff there is contention */
+		if (nr_shortages && !nr_lagging) {
+			ioc->busy_level = min(ioc->busy_level, 0);
+			/* redistribute surpluses first */
+			if (!nr_surpluses)
+				ioc->busy_level--;
+		}
 	} else {
 		ioc->busy_level = 0;
 	}
 
 	ioc->busy_level = clamp(ioc->busy_level, -1000, 1000);
 
-	if (ioc->busy_level) {
+	if (ioc->busy_level > 0 || (ioc->busy_level < 0 && !nr_lagging)) {
 		u64 vrate = atomic64_read(&ioc->vtime_rate);
 		u64 vrate_min = ioc->vrate_min, vrate_max = ioc->vrate_max;
 

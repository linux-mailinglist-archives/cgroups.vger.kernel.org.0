Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41524BE8A7
	for <lists+cgroups@lfdr.de>; Thu, 26 Sep 2019 01:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfIYXCY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 Sep 2019 19:02:24 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43125 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfIYXCY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 Sep 2019 19:02:24 -0400
Received: by mail-qk1-f194.google.com with SMTP id h126so195627qke.10;
        Wed, 25 Sep 2019 16:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=J6xx84NYBZMzyAcWsbF/M7RN9YSA/RHntuLBn1Nqazg=;
        b=SIfEzvpvUIu7/aCIY6SH2SkyCjOd9o0i5PqDvqyQHvE2InvTaTZQsVQCaxK5q1n/Cj
         yumJMyFWRX5aLUZd6WU9ijwVcG7VOjbiBe83nr6b6ydDBgYuXARTJf9DFAPC08+spzNo
         lUUQILezVaRYjlSnhG9eGY0RP1Hd2B2Vt9F8TaDReIT63toDYPKKzmTKEbTR868/tRhG
         AlAKT1UT4L82ewB5aZ1Sz017fFwxNLGqgxsyPmzjD7ZzoHFV7NWhiDpx9tVnBa86/yP+
         YgSGjq91jgvX1ZBsL/sJT2p9Dmg68iJXvjHCqi5Yt4gQ8UoZIivfDeKn7jA2r66/x0R5
         ou0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=J6xx84NYBZMzyAcWsbF/M7RN9YSA/RHntuLBn1Nqazg=;
        b=hPAp7SNGvOncwU8XdsEPoAA35NumTULvoxTqdRAyIx4/m2FizTJelAWE7Y6L0jSO0q
         EWa5CFV3blOH3eBtHh1H6T9jC+da9qJ+XKoSq5aYsFQC7wfU5RPL/Mto58BBJ4e0U4c8
         xPCJec/3mdfax7D/sLsRhl0mTvdqDVX0lAhdxyxF+1n86UEwen29KXcxl8RhQzbQUNFN
         5+KN9rJRCPxNf3DgH2niORDrY4oc5uDHLKYKtaY2qHuyMXkAPw96NyXiNKkWGTvY4IPN
         xXaAuFN0rDPHtlDStppFZ1DFAxJGTtwODzPh0tzyvsJ6ntl6l6ds5B7bzmyATTNET8ES
         hMeg==
X-Gm-Message-State: APjAAAWfKNdytNvl1XH6ZcOqZcupAD/LUMtK+Hl9sD2R2gZRYsxjkmYn
        fZLKYkgHRgEyTe8iTzf92Yg=
X-Google-Smtp-Source: APXvYqzlN0SByh/FHkgjqHVCuxYeLgWE2FPBsrHJAD9J0BHXXCNAE+h7pH/AOECmnivaxcM7ltQ9Ow==
X-Received: by 2002:a37:ef11:: with SMTP id j17mr391810qkk.1.1569452542573;
        Wed, 25 Sep 2019 16:02:22 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:a001])
        by smtp.gmail.com with ESMTPSA id c41sm301087qte.8.2019.09.25.16.02.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Sep 2019 16:02:20 -0700 (PDT)
Date:   Wed, 25 Sep 2019 16:02:07 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org
Subject: [PATCH 1/3 for-5.4/block] iocost: better trace vrate changes
Message-ID: <20190925230207.GI2233839@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

vrate_adj tracepoint traces vrate changes; however, it does so only
when busy_level is non-zero.  busy_level turning to zero can sometimes
be as interesting an event.  This patch also enables vrate_adj
tracepoint on other vrate related events - busy_level changes and
non-zero nr_lagging.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
Hello, Jens.

I've encountered vrate regulation issues while testing on a hard disk
machine.  These are three patches to improve vrate adj visibility and
fix the issue.

Thanks.

 block/blk-iocost.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1343,7 +1343,7 @@ static void ioc_timer_fn(struct timer_li
 	u32 ppm_wthr = MILLION - ioc->params.qos[QOS_WPPM];
 	u32 missed_ppm[2], rq_wait_pct;
 	u64 period_vtime;
-	int i;
+	int prev_busy_level, i;
 
 	/* how were the latencies during the period? */
 	ioc_lat_stat(ioc, missed_ppm, &rq_wait_pct);
@@ -1531,6 +1531,7 @@ skip_surplus_transfers:
 	 * and experiencing shortages but not surpluses, we're too stingy
 	 * and should increase vtime rate.
 	 */
+	prev_busy_level = ioc->busy_level;
 	if (rq_wait_pct > RQ_WAIT_BUSY_PCT ||
 	    missed_ppm[READ] > ppm_rthr ||
 	    missed_ppm[WRITE] > ppm_wthr) {
@@ -1592,6 +1593,10 @@ skip_surplus_transfers:
 		atomic64_set(&ioc->vtime_rate, vrate);
 		ioc->inuse_margin_vtime = DIV64_U64_ROUND_UP(
 			ioc->period_us * vrate * INUSE_MARGIN_PCT, 100);
+	} else if (ioc->busy_level != prev_busy_level || nr_lagging) {
+		trace_iocost_ioc_vrate_adj(ioc, atomic64_read(&ioc->vtime_rate),
+					   &missed_ppm, rq_wait_pct, nr_lagging,
+					   nr_shortages, nr_surpluses);
 	}
 
 	ioc_refresh_params(ioc, false);

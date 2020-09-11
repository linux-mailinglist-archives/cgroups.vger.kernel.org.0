Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C0026659B
	for <lists+cgroups@lfdr.de>; Fri, 11 Sep 2020 19:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgIKRII (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Sep 2020 13:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgIKRHu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Sep 2020 13:07:50 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B68C061573;
        Fri, 11 Sep 2020 10:07:50 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id v54so8405536qtj.7;
        Fri, 11 Sep 2020 10:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3AjEi6jGt52sCYG9BLpiLcsHH3zd+gAC/phsC2ntthU=;
        b=JKlox8HeF84wzkIcQoSdZMzb6i1aJWdpyWSIxiL7LCaduzfZgAyPT1sZm6in5FXwM3
         xltvN80oIihI4QVyN4BbUoIIm0zDriphHq19mOuPSJI2g9qrmVGZohyEsdMJtLtpHtOc
         RSRwl3VLVhpG7HoevUhSI6BwOe7mhYw2INhERcVs0y6HDwmUpEit9JJTs0yhFDeBDmlF
         AYScKSGInP3Nvlm+FOEy3T3KAoJxRLHBqxaW7bRPuFTAqdhRuEPPNoMA4lwalUsKsF3n
         yjnY9S3VXYUfS7NFcbWHPkwLZwjrwOFPADAqJGiY/GC8LCvsxv3Jo55+ke2Yeya9RnFv
         PDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=3AjEi6jGt52sCYG9BLpiLcsHH3zd+gAC/phsC2ntthU=;
        b=X6Xdt4gIuYjgL+Wjy4r18j55jEFsecpgDCwvruL2h+57J09usKcTr3M5T4hONFxlfB
         xKIIwF3KH8WmHrsNwjakyCG+kMag4AuQE9/ICM4FHK6L7lY5FdJMcBWRVBrkV5ibtkAk
         s+wOlZok8WreFOpnoh6CzOY7WCicowEKlmUNEjGNw53dxvoCQ19cQkySk4qB5pgI2tO6
         QHMR6XBZvBP7dunY4h61eEEwlwoLZG0GQTLB+CIUYmVbIOzlXRrg2SMuEKu2eCrKdPng
         TftIO1PHu7cFnl8MrdcdFcG1bXFBElLPgjMjpLZ7BRUFrhVhpv9WA88G0C1qElPEiib4
         FmEw==
X-Gm-Message-State: AOAM532xXnfIwFZE+VIXBB+6XBrzXaU+sQ0VCFutWXE2b2CL36TeQvHA
        3lZfoy0QoRzjb7226Prf/W0=
X-Google-Smtp-Source: ABdhPJw2XZ2JqhZOii91QI8Nz3t1nZXxSA3uEbROHyHtIu5JeI40jcWkws3m3ppPnakf3xviN8iqng==
X-Received: by 2002:aed:2f01:: with SMTP id l1mr2843206qtd.349.1599844069183;
        Fri, 11 Sep 2020 10:07:49 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:95ac])
        by smtp.gmail.com with ESMTPSA id h65sm3197291qtd.58.2020.09.11.10.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 10:07:47 -0700 (PDT)
Date:   Fri, 11 Sep 2020 13:07:46 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org
Subject: [PATCH block/for-next] blk-iocost: fix divide-by-zero in
 transfer_surpluses()
Message-ID: <20200911170746.GG4295@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Conceptually, root_iocg->hweight_donating must be less than WEIGHT_ONE but
all hweight calculations round up and thus it may end up >= WEIGHT_ONE
triggering divide-by-zero and other issues. Bound the value to avoid
surprises.

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: e08d02aa5fc9 ("blk-iocost: implement Andy's method for donation weight updates")
---
 block/blk-iocost.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index fc897bb142bcd..978753335370a 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1881,15 +1881,21 @@ static void transfer_surpluses(struct list_head *surpluses, struct ioc_now *now)
 
 	/*
 	 * Calculate the global donation rate (gamma) - the rate to adjust
-	 * non-donating budgets by. No need to use 64bit multiplication here as
-	 * the first operand is guaranteed to be smaller than WEIGHT_ONE
-	 * (1<<16).
+	 * non-donating budgets by.
+	 *
+	 * No need to use 64bit multiplication here as the first operand is
+	 * guaranteed to be smaller than WEIGHT_ONE (1<<16).
+	 *
+	 * We know that there are beneficiary nodes and the sum of the donating
+	 * hweights can't be whole; however, due to the round-ups during hweight
+	 * calculations, root_iocg->hweight_donating might still end up equal to
+	 * or greater than whole. Limit the range when calculating the divider.
 	 *
 	 * gamma = (1 - t_r') / (1 - t_r)
 	 */
 	gamma = DIV_ROUND_UP(
 		(WEIGHT_ONE - root_iocg->hweight_after_donation) * WEIGHT_ONE,
-		WEIGHT_ONE - root_iocg->hweight_donating);
+		WEIGHT_ONE - min_t(root_iocg->hweight_donating, WEIGHT_ONE - 1));
 
 	/*
 	 * Calculate adjusted hwi, child_adjusted_sum and inuse for the inner

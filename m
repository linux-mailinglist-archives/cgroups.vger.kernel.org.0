Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF706268F07
	for <lists+cgroups@lfdr.de>; Mon, 14 Sep 2020 17:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgINPG3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Sep 2020 11:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgINPFR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Sep 2020 11:05:17 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51127C06174A;
        Mon, 14 Sep 2020 08:05:17 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f142so333021qke.13;
        Mon, 14 Sep 2020 08:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=MwhoD2IsxPuM7wLbM0i6FSRjhQSYCwaNO02+PwwZFwI=;
        b=hj2b9XRbREKQ+sQk3KdHJ9qKJ/wirPnzOxDkqIAkGjUGWYNewcfCK/Z7n78c1zp8np
         xtjqO9I4lyHECVNCQi1LMx1mAeUDX84kSpB/SM3ReBDs4J6RgH29faPh/v3Rsm7StlAK
         xOrl5xFFo0tb3gX4J8z5hmS9pVBMkMdT2iMV+D7pJAv+UfXc0x24dq6sVeouNDnz0Yn/
         J26hK5gKW1e6k0ng4Gh62M5KQXjWM7IUC3ec0FE6jB3N9CRxVsrXO2p5G3TADdo6gIC6
         eTwZar7N5P2rGY67eotzjFM3OpJeplY2AXypg/5jDqiUBilJ2ERSBOAjO6/IIdeg9CUv
         wdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=MwhoD2IsxPuM7wLbM0i6FSRjhQSYCwaNO02+PwwZFwI=;
        b=OZtTWF5v1Qfj++CFgwIINSZ0S6RmV5vMmIEVx1ssIleEq5BIZG3/WgSh+S0GPEevYT
         MjYp5rsPi64F9sETe5iYYm3govEWPGTnf6RwL0vRHiXAYOwXsHk8GCbBUKTrWlTmEwae
         BfKh/l5y1BliYKXKJ134CvyD6teBlWKrthJd2aZ1ytMsmzfdthHsUIoKxl6lLclGZ+ak
         w7lfEzazf2nghYvNauX3WgWEs44jS/WEyyxD8lmZ625qBhrpN23W7KSROVxW+x6LaUpa
         GyToTSdx/hocno2kGGB1RpFVGy0gNUAOISJv8vRJW8e9i+T8BPFgMgC2qoAcLMvpmRjl
         Uf1g==
X-Gm-Message-State: AOAM531qIvlXqqrWHg7RsyNTLvRJwR5atAmIEY4+f1LQIDAimnx6p+gp
        gY96+A4Z22N/mQBVQFv1LdA=
X-Google-Smtp-Source: ABdhPJyB9YS6tyxfzJLHs3GtWMtDdBshxzWHI7GwmBNZV5EVnTVp8lRSOAHTZQIAAI+lGG+RGbAa1Q==
X-Received: by 2002:ae9:de85:: with SMTP id s127mr12471825qkf.59.1600095915610;
        Mon, 14 Sep 2020 08:05:15 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:c1e3])
        by smtp.gmail.com with ESMTPSA id y20sm14321815qkj.70.2020.09.14.08.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 08:05:14 -0700 (PDT)
Date:   Mon, 14 Sep 2020 11:05:13 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH block/for-next] iocost: fix infinite loop bug in
 adjust_inuse_and_calc_cost()
Message-ID: <20200914150513.GC865564@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

adjust_inuse_and_calc_cost() is responsible for reducing the amount of
donated weights dynamically in period as the budget runs low. Because we
don't want to do full donation calculation in period, we keep latching up
inuse by INUSE_ADJ_STEP_PCT of the active weight of the cgroup until the
resulting hweight_inuse is satisfactory.

Unfortunately, the adj_step calculation was reading the active weight before
acquiring ioc->lock. Because the current thread could have lost race to
activate the iocg to another thread before entering this function, it may
read the active weight as zero before acquiring ioc->lock. When this
happens, the adj_step is calculated as zero and the incremental adjustment
loop becomes an infinite one.

Fix it by fetching the active weight after acquiring ioc->lock.

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: b0853ab4a238 ("blk-iocost: revamp in-period donation snapbacks")
---
 block/blk-iocost.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 6e29b4dcf3566..ef9476fca1d8a 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2323,9 +2323,8 @@ static u64 adjust_inuse_and_calc_cost(struct ioc_gq *iocg, u64 vtime,
 {
 	struct ioc *ioc = iocg->ioc;
 	struct ioc_margins *margins = &ioc->margins;
-	u32 adj_step = DIV_ROUND_UP(iocg->active * INUSE_ADJ_STEP_PCT, 100);
 	u32 __maybe_unused old_inuse = iocg->inuse, __maybe_unused old_hwi;
-	u32 hwi;
+	u32 hwi, adj_step;
 	s64 margin;
 	u64 cost, new_inuse;
 
@@ -2354,8 +2353,15 @@ static u64 adjust_inuse_and_calc_cost(struct ioc_gq *iocg, u64 vtime,
 		return cost;
 	}
 
-	/* bump up inuse till @abs_cost fits in the existing budget */
+	/*
+	 * Bump up inuse till @abs_cost fits in the existing budget.
+	 * adj_step must be determined after acquiring ioc->lock - we might
+	 * have raced and lost to another thread for activation and could
+	 * be reading 0 iocg->active before ioc->lock which will lead to
+	 * infinite loop.
+	 */
 	new_inuse = iocg->inuse;
+	adj_step = DIV_ROUND_UP(iocg->active * INUSE_ADJ_STEP_PCT, 100);
 	do {
 		new_inuse = new_inuse + adj_step;
 		propagate_weights(iocg, iocg->active, new_inuse, true, now);

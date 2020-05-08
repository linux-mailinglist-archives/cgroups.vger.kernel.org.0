Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB931CBA54
	for <lists+cgroups@lfdr.de>; Sat,  9 May 2020 00:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgEHWA1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 May 2020 18:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727882AbgEHWA1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 May 2020 18:00:27 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D1AC05BD43
        for <cgroups@vger.kernel.org>; Fri,  8 May 2020 15:00:25 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id r26so12320826wmh.0
        for <cgroups@vger.kernel.org>; Fri, 08 May 2020 15:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2bZEmVPj4bBPSpoxrezTXCxfraC/gVscBnU3FXpehw0=;
        b=fdj9m72Ets8NDXsiWFaO7GJwzxJsctQZwipDjgjjrqAisSHYUDTubMx2iwb6ZF6wZE
         HDfLsfdeZoudSXm8OBhapUknILrelw007SvvkN0Z83/elWMsEzQM9hoiK/YUfDTPGz+8
         6Ry/cj8maY9eX6iBpRlqNXpBpQRqp4mIr/+C6w3NflOfIWlb+jsRO4I+aK9Rpd/0HSBl
         Rxk/TOa809u9NPoGKeCZWj8lj4/jgLH65OsWPDEJepHH4Suz6lNEeH2kd8RyQR84Icbq
         pfgYQYNSzqsfKu7sz8mt8Oc2tER9x8XEYsFYsV5kFxbGwjBTL4yEZRO/G3hP2Gbtnp0x
         A0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2bZEmVPj4bBPSpoxrezTXCxfraC/gVscBnU3FXpehw0=;
        b=BdMrIL0IOeBR1IY7AXLEuMY5Qa17uYnpQQf97pefQctGpuOaKH9s2xjrdSe7O9NVCe
         LUpj4NvVP3Gb24Z+XPU+dFmpIyHgRChd4A7Xr6JOsZTvXfCtbuM83zoM5KMjKQlpOqvg
         wv/1Xub4aYJsvgTk/zmob3viQ5ICeuUve8b7lXSECMSKZIbTn1rGpkf713gUyjVeZLAP
         ImaJ8CylJFGabxvBOX59V03OXkjLtxug8EQIMvPADvAn/qbXER59p235Ei7l1uAUjJyY
         xGJTSZ28fpVdmJUvcb/acoDoUiLsONowkiytK203oFrPRdajUJxcFlcEY05n/j4OfjRV
         aVuA==
X-Gm-Message-State: AGi0PuawHGa0c1FNDujMrjejIiDUWRRqQVVDgvb/74Bnd+12IvTAuXXU
        AsNe/rv2782noJArnE6lJ9TKeQ==
X-Google-Smtp-Source: APiQypJKMZoMXF612rYIHvPoDp5Nyo16pxH9Y1FrPnmdSPMAki5tS8NMGZCr1acYa5nOMcDC52GCrw==
X-Received: by 2002:a1c:23d4:: with SMTP id j203mr19502504wmj.49.1588975224308;
        Fri, 08 May 2020 15:00:24 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:7d6e:af57:ffe:3087])
        by smtp.gmail.com with ESMTPSA id h6sm14646878wmf.31.2020.05.08.15.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 15:00:23 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 4/4] blk-wbt: rename __wbt_update_limits to wbt_update_limits
Date:   Sat,  9 May 2020 00:00:15 +0200
Message-Id: <20200508220015.11528-5-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508220015.11528-1-guoqing.jiang@cloud.ionos.com>
References: <20200508220015.11528-1-guoqing.jiang@cloud.ionos.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Now let's rename __wbt_update_limits to wbt_update_limits after the
previous one is deleted.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 block/blk-wbt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 78bb624cce53..0fa615eefd52 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -405,7 +405,7 @@ static void wb_timer_fn(struct blk_stat_callback *cb)
 		rwb_arm_timer(rwb);
 }
 
-static void __wbt_update_limits(struct rq_wb *rwb)
+static void wbt_update_limits(struct rq_wb *rwb)
 {
 	struct rq_depth *rqd = &rwb->rq_depth;
 
@@ -433,7 +433,7 @@ void wbt_set_min_lat(struct request_queue *q, u64 val)
 		return;
 	RQWB(rqos)->min_lat_nsec = val;
 	RQWB(rqos)->enable_state = WBT_STATE_ON_MANUAL;
-	__wbt_update_limits(RQWB(rqos));
+	wbt_update_limits(RQWB(rqos));
 }
 
 
@@ -677,7 +677,7 @@ static int wbt_data_dir(const struct request *rq)
 static void wbt_queue_depth_changed(struct rq_qos *rqos)
 {
 	RQWB(rqos)->rq_depth.queue_depth = blk_queue_depth(rqos->q);
-	__wbt_update_limits(RQWB(rqos));
+	wbt_update_limits(RQWB(rqos));
 }
 
 static void wbt_exit(struct rq_qos *rqos)
@@ -835,7 +835,7 @@ int wbt_init(struct request_queue *q)
 	rwb->enable_state = WBT_STATE_ON_DEFAULT;
 	rwb->wc = 1;
 	rwb->rq_depth.default_depth = RWB_DEF_DEPTH;
-	__wbt_update_limits(rwb);
+	wbt_update_limits(rwb);
 
 	/*
 	 * Assign rwb and add the stats callback.
-- 
2.17.1


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010911CBA50
	for <lists+cgroups@lfdr.de>; Sat,  9 May 2020 00:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgEHWAZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 May 2020 18:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727110AbgEHWAY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 May 2020 18:00:24 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F82C05BD09
        for <cgroups@vger.kernel.org>; Fri,  8 May 2020 15:00:24 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u16so12269346wmc.5
        for <cgroups@vger.kernel.org>; Fri, 08 May 2020 15:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dPhyON5t2lsnMJZ8HYi8BZ7gzQdWEyhKhPMeJVZANdc=;
        b=dUQcdsq4s73ekjBnKr6uL+EYjUYek6QBStLy8HUJV0SiYzsM3N3K7iYsKDel+pfhgP
         WDM2In7qIiPDBRsSfOuvAm8ofB0bJkj1B8lS3ztan7fVynzuYTfKdxqA0bwQwj0xB5uZ
         HkBTqGamIv3aIqL8VqFYRCiuNgwbc1SulcPVeN63xZ30cvLq1F6Ixs4SVkR753AW5jDW
         45jZU3+g7AMe1ltqRboBgcShGyLe6ja1i8QnrPcKgm+XEk5XXgjsKyGpZJGnckaXMw4q
         CcCpUU+W4llxARrHFqg2hd69tozoZtd/jgn3AI7Y6XE9yUY7n6965AJm/ttoiMKdLLtc
         n+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dPhyON5t2lsnMJZ8HYi8BZ7gzQdWEyhKhPMeJVZANdc=;
        b=jJTquxE/fVlZsXGq7bfPmlhhNs+tNCmPtbQ8x0gqy/NMZbvehdgkHg5YZUX70xyAeE
         hf528G3B6Z+DnBEYGBbdEOfCijxmnrHFRtR8FGNhCFoFg3qlhD44eoNbAUB/26h3Xt3T
         RV3hB92mksfe0WnxfLSWVx1opErWhKEbKpQEw/N4Aby6ixWG9wORL4YhJkcAxOhIuUKv
         8wD+WONX+p4XVkp2fp4IeYrnWdQBUjD2K63CjgNTWSv85Th44Mwgi9v4E9zx7wsiDu09
         E6ZMdCcl2ctr6tv0S/f5nrITRXNjb/QwteiEeUCqxT2pbxEQfpB+sp+rI7yDVz9PCu9m
         hN0Q==
X-Gm-Message-State: AGi0PubDMRc5Ni3UPbl+FHdJ8UmbHBjlahr2ys5WhOHo7UvI7mGTJg+G
        /rNaTn/YMItSfKyzUxLYmZ13sCpp3Agd+g==
X-Google-Smtp-Source: APiQypJmiYVfsjfkrMaY/y70wh5rMb7vQUrnV/1GacNtlxMPipssrqTcDECB6zeqrq3aHVDymDUVCQ==
X-Received: by 2002:a1c:2846:: with SMTP id o67mr17314309wmo.23.1588975223026;
        Fri, 08 May 2020 15:00:23 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:7d6e:af57:ffe:3087])
        by smtp.gmail.com with ESMTPSA id h6sm14646878wmf.31.2020.05.08.15.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 15:00:22 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 3/4] blk-wbt: remove wbt_update_limits
Date:   Sat,  9 May 2020 00:00:14 +0200
Message-Id: <20200508220015.11528-4-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508220015.11528-1-guoqing.jiang@cloud.ionos.com>
References: <20200508220015.11528-1-guoqing.jiang@cloud.ionos.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

No one call this function after commit 2af2783f2ea4f ("rq-qos: get rid of
redundant wbt_update_limits()"), so remove it.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 block/blk-wbt.c | 8 --------
 block/blk-wbt.h | 4 ----
 2 files changed, 12 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 9cb082f38b93..78bb624cce53 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -418,14 +418,6 @@ static void __wbt_update_limits(struct rq_wb *rwb)
 	rwb_wake_all(rwb);
 }
 
-void wbt_update_limits(struct request_queue *q)
-{
-	struct rq_qos *rqos = wbt_rq_qos(q);
-	if (!rqos)
-		return;
-	__wbt_update_limits(RQWB(rqos));
-}
-
 u64 wbt_get_min_lat(struct request_queue *q)
 {
 	struct rq_qos *rqos = wbt_rq_qos(q);
diff --git a/block/blk-wbt.h b/block/blk-wbt.h
index 8e4e37660971..16bdc85b8df9 100644
--- a/block/blk-wbt.h
+++ b/block/blk-wbt.h
@@ -88,7 +88,6 @@ static inline unsigned int wbt_inflight(struct rq_wb *rwb)
 #ifdef CONFIG_BLK_WBT
 
 int wbt_init(struct request_queue *);
-void wbt_update_limits(struct request_queue *);
 void wbt_disable_default(struct request_queue *);
 void wbt_enable_default(struct request_queue *);
 
@@ -108,9 +107,6 @@ static inline int wbt_init(struct request_queue *q)
 {
 	return -EINVAL;
 }
-static inline void wbt_update_limits(struct request_queue *q)
-{
-}
 static inline void wbt_disable_default(struct request_queue *q)
 {
 }
-- 
2.17.1


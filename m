Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625E81CBA4C
	for <lists+cgroups@lfdr.de>; Sat,  9 May 2020 00:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgEHWAX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 May 2020 18:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727110AbgEHWAW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 May 2020 18:00:22 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9D3C05BD09
        for <cgroups@vger.kernel.org>; Fri,  8 May 2020 15:00:22 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l18so3635735wrn.6
        for <cgroups@vger.kernel.org>; Fri, 08 May 2020 15:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nqYXnG0hXHAuFcgizjaOL1g3/nTuWaq2pTGY70YFO3Y=;
        b=FTCqn59ZXMOJsVXSlArE/0ZWBGzr2XuYwLeHciwR5qzYZRXhR1EZ6Xfd6b7/r8ih0M
         CfN1XuLLM8m4AnYPs62BvH51dOTAR5+i1qZePVMFNuxE2GVd9zbIWN8A6W5SngNAMtbM
         rXu+yWKyHjiBcT5SBjH0ANMY+QMONbTD+tH6p8U1ZVzMs9ozYFw13Ur1sZDtPyNal6uH
         0Fa+wXY+SeyfRIIpUvbNP7+2IC8CiFsof1w9hIOZrSKNptintXW2VO0+TOZPoS4I/rdb
         4Q7/SUjABCOgY7csXNyxU5xVWEAZcuwTTrxKovuO8/bM3kThIQatghRykiVvYkEk+qrx
         QtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nqYXnG0hXHAuFcgizjaOL1g3/nTuWaq2pTGY70YFO3Y=;
        b=W9sBqxUck+pN6G+WkYU4NccmU2dJFImM9SMlPN7QkQLHw6TQnqZR7k4ZhjgzUld8uP
         6KiJHg64pHsx2xz44H4B7VGe3tdqTmJCvTgTdGf/+iJzaB/32wP0BrXVFcdqtUSBMd2h
         +Z4SzXt5ImhXu2UG3xr7BR8FwtLWZ4Z7HdCsfYk8y3MYDS1xo/uJkbVLnxcZVVcBiYuk
         fJuHJ5UqPwm7mlS4pgIS3XQQ4EEmRuvsIxhws6+BqdTNd6mLqLUq6vzVFrVstasGatmu
         Iu8MNSUkxZwiGAMc1H4bOe0DWYFhRrCUMvkmO7iKoMDScSEkFuGSFCs3mXQrQw9bmieM
         wYPw==
X-Gm-Message-State: AGi0PuZCDgPhUwt2LZBWzk/nDTojwkQlCdP94gIWhG5xZEYioLEwk29G
        9XlQR6ZvVGimHglhyMdSGdSoEKrE3+bn1Q==
X-Google-Smtp-Source: APiQypJwRrxLx7KWzivyRTGV5SfN9QEndr8trJgQGYOvCxRWdl1punApZNQc4CEaJ5V0au8REvTl3w==
X-Received: by 2002:adf:e64c:: with SMTP id b12mr4983758wrn.131.1588975221056;
        Fri, 08 May 2020 15:00:21 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:7d6e:af57:ffe:3087])
        by smtp.gmail.com with ESMTPSA id h6sm14646878wmf.31.2020.05.08.15.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 15:00:20 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 1/4] blk-throttle: remove blk_throtl_drain
Date:   Sat,  9 May 2020 00:00:12 +0200
Message-Id: <20200508220015.11528-2-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508220015.11528-1-guoqing.jiang@cloud.ionos.com>
References: <20200508220015.11528-1-guoqing.jiang@cloud.ionos.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

After the commit 5addeae1bedc4 ("blk-cgroup: remove blkcg_drain_queue"),
there is no caller of blk_throtl_drain, so let's remove it.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 block/blk-throttle.c | 41 -----------------------------------------
 block/blk.h          |  2 --
 2 files changed, 43 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 98233c9c65a8..0b2ce7fb77a7 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2380,47 +2380,6 @@ static void tg_drain_bios(struct throtl_service_queue *parent_sq)
 	}
 }
 
-/**
- * blk_throtl_drain - drain throttled bios
- * @q: request_queue to drain throttled bios for
- *
- * Dispatch all currently throttled bios on @q through ->make_request_fn().
- */
-void blk_throtl_drain(struct request_queue *q)
-	__releases(&q->queue_lock) __acquires(&q->queue_lock)
-{
-	struct throtl_data *td = q->td;
-	struct blkcg_gq *blkg;
-	struct cgroup_subsys_state *pos_css;
-	struct bio *bio;
-	int rw;
-
-	rcu_read_lock();
-
-	/*
-	 * Drain each tg while doing post-order walk on the blkg tree, so
-	 * that all bios are propagated to td->service_queue.  It'd be
-	 * better to walk service_queue tree directly but blkg walk is
-	 * easier.
-	 */
-	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg)
-		tg_drain_bios(&blkg_to_tg(blkg)->service_queue);
-
-	/* finally, transfer bios from top-level tg's into the td */
-	tg_drain_bios(&td->service_queue);
-
-	rcu_read_unlock();
-	spin_unlock_irq(&q->queue_lock);
-
-	/* all bios now should be in td->service_queue, issue them */
-	for (rw = READ; rw <= WRITE; rw++)
-		while ((bio = throtl_pop_queued(&td->service_queue.queued[rw],
-						NULL)))
-			generic_make_request(bio);
-
-	spin_lock_irq(&q->queue_lock);
-}
-
 int blk_throtl_init(struct request_queue *q)
 {
 	struct throtl_data *td;
diff --git a/block/blk.h b/block/blk.h
index 73bd3b1c6938..997459de47d0 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -307,12 +307,10 @@ int create_task_io_context(struct task_struct *task, gfp_t gfp_mask, int node);
  * Internal throttling interface
  */
 #ifdef CONFIG_BLK_DEV_THROTTLING
-extern void blk_throtl_drain(struct request_queue *q);
 extern int blk_throtl_init(struct request_queue *q);
 extern void blk_throtl_exit(struct request_queue *q);
 extern void blk_throtl_register_queue(struct request_queue *q);
 #else /* CONFIG_BLK_DEV_THROTTLING */
-static inline void blk_throtl_drain(struct request_queue *q) { }
 static inline int blk_throtl_init(struct request_queue *q) { return 0; }
 static inline void blk_throtl_exit(struct request_queue *q) { }
 static inline void blk_throtl_register_queue(struct request_queue *q) { }
-- 
2.17.1


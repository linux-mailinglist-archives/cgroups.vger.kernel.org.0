Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 714B211D17C
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2019 16:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbfLLPwa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Dec 2019 10:52:30 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34537 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbfLLPwa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Dec 2019 10:52:30 -0500
Received: by mail-lf1-f67.google.com with SMTP id l18so2093628lfc.1;
        Thu, 12 Dec 2019 07:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dpmXptq7OKBhaK+45aA6Sk+usjB5L4G2Vmog6jpDgyw=;
        b=odlBjnFPGX0ZO9arATJ1dR4Dz6rZUqHjHcaxZBNYqlZX2Z4Hg9kbk7mf7gpCD9kim7
         Cmv9vvmlMr0uHJlwOpcMeXOT0JQzjLoYWNu2yE0cE/wSbxyMxl7+JlaA770IfQFuXGgy
         Z6OCe241nCddn01WXs3uDHiub16yE45CSU6VJzBormOFoKGjCqi1KJ5a1YkhpcTHSIOv
         QRC/Jejx8czwzgsXG8nrYtutuCBil92CpOv0BbSKi7jKWGeRj9V1yMBKV1I9SSLLM3Tn
         9l7mUqDn1BR3A6cXZKDPp9edo1UqaB/gy9ZBCrJ05tR2KIXiUdFMlV332edd0CmZVM65
         qx2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dpmXptq7OKBhaK+45aA6Sk+usjB5L4G2Vmog6jpDgyw=;
        b=LDCJwTB3ZJuOA00DOBZfvMUeooHZf9S0CcJTEQASRIRfgeri6JP/4wE8eL41PO6mlc
         pdiEYMFOVVIEHeU5VThXT7IUOXOs4/+qAyydRnrBpCqQQpOQmVRPIhaspgVu0mKZfln8
         JPWDPuVJ0Pq5XRIvmzdPYPy39VlCldUFEGJx5Fsk3a8UtUQf7ubXFUt7Yr8ts1midPve
         EpKy4NvR6t3deBFLfEqjlt+FA19LAdt51gDzDH4SmQCnCtPHRqg6Zgl9/itVUZKTBtPn
         OyPCJIfml5ABizfuMo5Oi+RaqHqa+8oJivsJ6duV5llAuUGKTkzXuCZ4L8yuLkDG/Psc
         fr8A==
X-Gm-Message-State: APjAAAXkE7BZvpBTYU1GyeEYy8ENL+75/EjnYykyYpa66JOImMALg8pT
        uB4PsNqG/V0s6I3oMNO6HlDREr44hmY=
X-Google-Smtp-Source: APXvYqzFK4v4EprOD6qHgt4SYo7PSKA5G5ZJKA0TczYCgPK7+CLGPgYLsBnoMIF3Xc6+nibJ5bdsrQ==
X-Received: by 2002:a17:906:3796:: with SMTP id n22mr10391919ejc.222.1576165947318;
        Thu, 12 Dec 2019 07:52:27 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:1467:8db0:560a:58ea])
        by smtp.gmail.com with ESMTPSA id f25sm166950ejx.76.2019.12.12.07.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 07:52:26 -0800 (PST)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     tj@kernel.org, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH v2] blk-cgroup: remove blkcg_drain_queue
Date:   Thu, 12 Dec 2019 16:52:00 +0100
Message-Id: <20191212155200.13403-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Since blk_drain_queue had already been removed, so this function
is not needed anymore.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
v2 changes:
1. remove blkcg_drain_queue in header file.

 block/blk-cgroup.c         | 20 --------------------
 include/linux/blk-cgroup.h |  2 --
 2 files changed, 22 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 708dea92dac8..a229b94d5390 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1061,26 +1061,6 @@ int blkcg_init_queue(struct request_queue *q)
 	return PTR_ERR(blkg);
 }
 
-/**
- * blkcg_drain_queue - drain blkcg part of request_queue
- * @q: request_queue to drain
- *
- * Called from blk_drain_queue().  Responsible for draining blkcg part.
- */
-void blkcg_drain_queue(struct request_queue *q)
-{
-	lockdep_assert_held(&q->queue_lock);
-
-	/*
-	 * @q could be exiting and already have destroyed all blkgs as
-	 * indicated by NULL root_blkg.  If so, don't confuse policies.
-	 */
-	if (!q->root_blkg)
-		return;
-
-	blk_throtl_drain(q);
-}
-
 /**
  * blkcg_exit_queue - exit and release blkcg part of request_queue
  * @q: request_queue being released
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 19394c77ed99..e4a6949fd171 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -188,7 +188,6 @@ struct blkcg_gq *__blkg_lookup_create(struct blkcg *blkcg,
 struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
 				    struct request_queue *q);
 int blkcg_init_queue(struct request_queue *q);
-void blkcg_drain_queue(struct request_queue *q);
 void blkcg_exit_queue(struct request_queue *q);
 
 /* Blkio controller policy registration */
@@ -720,7 +719,6 @@ static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg, void *key) { ret
 static inline struct blkcg_gq *blk_queue_root_blkg(struct request_queue *q)
 { return NULL; }
 static inline int blkcg_init_queue(struct request_queue *q) { return 0; }
-static inline void blkcg_drain_queue(struct request_queue *q) { }
 static inline void blkcg_exit_queue(struct request_queue *q) { }
 static inline int blkcg_policy_register(struct blkcg_policy *pol) { return 0; }
 static inline void blkcg_policy_unregister(struct blkcg_policy *pol) { }
-- 
2.17.1


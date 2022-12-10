Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1540F649028
	for <lists+cgroups@lfdr.de>; Sat, 10 Dec 2022 19:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiLJSfD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 10 Dec 2022 13:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLJSfC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 10 Dec 2022 13:35:02 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A395413DE1;
        Sat, 10 Dec 2022 10:35:01 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so8206578pjm.2;
        Sat, 10 Dec 2022 10:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uY04nYXLVzuNbDq8d1mF0P2iWu8Vn/aqFvQdGInkT+U=;
        b=Q4Z+xbyvQLwy6YCSc3VKV/vv66l6CO/FJX6LLn1CZqXpM7GmPTER00jPUfsDLbpxQR
         NXxBhcjscA5Ksyai91lI8ZTKrgvdD4uGPeLTBSHhLQ1We78ZgiDjQgYuq/K1oxPXp269
         olUX7zXOKyl3iiosYHagArqjSc+/xUEUK+gom6eL4PLR4gKFa5127JmBOMa1iMdflG03
         0Tvbfcs6cDJS29KnFrDlSP9Zn1qD/q95LQOOrZo3keK1uT5eJzGTigCGJc8qbsaUVan/
         mp8hZLY/k20sWRXmcgTtBD4lnyJaKpqTJYwyimmtI8nBHV8WjiFA2HJrcS71uasFC8Yl
         vZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uY04nYXLVzuNbDq8d1mF0P2iWu8Vn/aqFvQdGInkT+U=;
        b=4Hx9pFy7zsGELBg5rX62wbed3FEodupm/3g8TRiQdmtDbegSS6GisZjeJMJbRWZRrd
         wM2Vxnav3sPCKwSoNQD+vR9nJp9p5KhLASrNjh+e+bG9dJkptBQC1xrm2xduLvpgyli4
         QVwX8BnY0APBAD5MAwuK2UPLXukry3R7Rn/Q9Tvfx/GqxCZfWAUPQUjKL6Mxbdzt3sIu
         lhsIm5VoGqv3nHn+tT/5QVfQqA66UnWnigWPAxNXEtLPazI3EeLCPoOM7wORTQqpaYyw
         Pln7ZYiE7/PjTPxg5MqaQiU0LEsMOXWI6IeXJ8lYtLiI4rW9LQ0OAt11DMk5FPfAOe8z
         2qpg==
X-Gm-Message-State: ANoB5plo0YIUzvJuRGwW8OS6Lz5Z9huanyqbzjYPeYrS+oAakQeXmh3y
        7Uh8IEBRgMkKc8fciMYNFa7PcZvTOKeF/Q==
X-Google-Smtp-Source: AA0mqf76RYscAg1y9pG9/V2uIzR4qfwCHDjtAQeDrqt0Ng4Drg0kpNnJL8CGXsSELP0WzP1fPI/sCA==
X-Received: by 2002:a05:6a20:4294:b0:a6:6d23:9fff with SMTP id o20-20020a056a20429400b000a66d239fffmr14533303pzj.14.1670697300942;
        Sat, 10 Dec 2022 10:35:00 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id u3-20020a170902e5c300b00189947bd9f7sm3305098plf.50.2022.12.10.10.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 10:35:00 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sat, 10 Dec 2022 08:34:59 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        darklight2357@icloud.com, Josef Bacik <josef@toxicpanda.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        cgroups@vger.kernel.org
Subject: [PATCH 2/2 block/for-6.2] blk-iolatency: Make initialization lazy
Message-ID: <Y5TRU2+s379DhUbj@slm.duckdns.org>
References: <Y5TQ5gm3O4HXrXR3@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5TQ5gm3O4HXrXR3@slm.duckdns.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Other rq_qos policies such as wbt and iocost are lazy-initialized when they
are configured for the first time for the device but iolatency is
initialized unconditionally from blkcg_init_disk() during gendisk init. Lazy
init is beneficial because rq_qos policies add runtime overhead when
initialized as every IO has to walk all registered rq_qos callbacks.

This patch switches iolatency to lazy initialization too so that it only
registered its rq_qos policy when it is first configured.

Note that there is a known race condition between blkcg config file writes
and del_gendisk() and this patch makes iolatency susceptible to it by
exposing the init path to race against the deletion path. However, that
problem already exists in iocost and is being worked on.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
---
Hello,

Tagged for-6.2 but this can easily go for the next merge window too.

Thanks.

 block/blk-cgroup.c    |    8 --------
 block/blk-iolatency.c |   36 ++++++++++++++++++++++++++++++++++--
 block/blk-rq-qos.h    |    2 +-
 block/blk.h           |    6 ------
 4 files changed, 35 insertions(+), 17 deletions(-)

--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -33,7 +33,6 @@
 #include "blk-cgroup.h"
 #include "blk-ioprio.h"
 #include "blk-throttle.h"
-#include "blk-rq-qos.h"
 
 /*
  * blkcg_pol_mutex protects blkcg_policy[] and policy [de]activation.
@@ -1300,14 +1299,8 @@ int blkcg_init_disk(struct gendisk *disk
 	if (ret)
 		goto err_ioprio_exit;
 
-	ret = blk_iolatency_init(disk);
-	if (ret)
-		goto err_throtl_exit;
-
 	return 0;
 
-err_throtl_exit:
-	blk_throtl_exit(disk);
 err_ioprio_exit:
 	blk_ioprio_exit(disk);
 err_destroy_all:
@@ -1323,7 +1316,6 @@ err_unlock:
 void blkcg_exit_disk(struct gendisk *disk)
 {
 	blkg_destroy_all(disk);
-	rq_qos_exit(disk->queue);
 	blk_throtl_exit(disk);
 }
 
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -755,7 +755,7 @@ static void blkiolatency_enable_work_fn(
 	}
 }
 
-int blk_iolatency_init(struct gendisk *disk)
+static int blk_iolatency_init(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
 	struct blk_iolatency *blkiolat;
@@ -830,6 +830,31 @@ static void iolatency_clear_scaling(stru
 	}
 }
 
+static int blk_iolatency_try_init(char *input)
+{
+	static DEFINE_MUTEX(init_mutex);
+	struct block_device *bdev;
+	int ret = 0;
+
+	bdev = blkcg_conf_open_bdev(&input);
+	if (IS_ERR(bdev))
+		return PTR_ERR(bdev);
+
+	/*
+	 * blk_iolatency_init() may fail after rq_qos_add() succeeds which can
+	 * confuse iolat_rq_qos() test. Make the test and init atomic.
+	 */
+	mutex_lock(&init_mutex);
+
+	if (!iolat_rq_qos(bdev->bd_queue))
+		ret = blk_iolatency_init(bdev->bd_disk);
+
+	mutex_unlock(&init_mutex);
+	blkdev_put_no_open(bdev);
+
+	return ret;
+}
+
 static ssize_t iolatency_set_limit(struct kernfs_open_file *of, char *buf,
 			     size_t nbytes, loff_t off)
 {
@@ -842,7 +867,14 @@ static ssize_t iolatency_set_limit(struc
 	u64 oldval;
 	int ret;
 
+retry:
 	ret = blkg_conf_prep(blkcg, &blkcg_policy_iolatency, buf, &ctx);
+	if (ret == -EOPNOTSUPP) {
+		ret = blk_iolatency_try_init(buf);
+		if (ret)
+			return ret;
+		goto retry;
+	}
 	if (ret)
 		return ret;
 
@@ -974,7 +1006,7 @@ static void iolatency_pd_init(struct blk
 {
 	struct iolatency_grp *iolat = pd_to_lat(pd);
 	struct blkcg_gq *blkg = lat_to_blkg(iolat);
-	struct rq_qos *rqos = blkcg_rq_qos(blkg->q);
+	struct rq_qos *rqos = iolat_rq_qos(blkg->q);
 	struct blk_iolatency *blkiolat = BLKIOLATENCY(rqos);
 	u64 now = ktime_to_ns(ktime_get());
 	int cpu;
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -74,7 +74,7 @@ static inline struct rq_qos *wbt_rq_qos(
 	return rq_qos_id(q, RQ_QOS_WBT);
 }
 
-static inline struct rq_qos *blkcg_rq_qos(struct request_queue *q)
+static inline struct rq_qos *iolat_rq_qos(struct request_queue *q)
 {
 	return rq_qos_id(q, RQ_QOS_LATENCY);
 }
--- a/block/blk.h
+++ b/block/blk.h
@@ -392,12 +392,6 @@ static inline struct bio *blk_queue_boun
 	return bio;
 }
 
-#ifdef CONFIG_BLK_CGROUP_IOLATENCY
-int blk_iolatency_init(struct gendisk *disk);
-#else
-static inline int blk_iolatency_init(struct gendisk *disk) { return 0; };
-#endif
-
 #ifdef CONFIG_BLK_DEV_ZONED
 void disk_free_zone_bitmaps(struct gendisk *disk);
 void disk_clear_zone_settings(struct gendisk *disk);

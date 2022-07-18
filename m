Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44750577D9A
	for <lists+cgroups@lfdr.de>; Mon, 18 Jul 2022 10:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbiGRIhF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Jul 2022 04:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbiGRIhF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 Jul 2022 04:37:05 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B692DE01C
        for <cgroups@vger.kernel.org>; Mon, 18 Jul 2022 01:37:03 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id p9so11072322pjd.3
        for <cgroups@vger.kernel.org>; Mon, 18 Jul 2022 01:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hrEyQGzrB3TAIf/TmXechjLg15TCHCdypY6rTcTiJ1Q=;
        b=aYzzebC8Nn5bqXlt1anYrWRRc1cd679atDrbMKEoimTgs6qL74K36w/o7x7Pmi/dm0
         9n3CklWEN8XA3oztwnzH1on4r1sQCcH14KQNK8+ivGYom3PtaHgLTS8LCg8kTqalcHE2
         0PKMiZecAeeTDeJKj4z8F/EL2zSKnFcSTX0slJm4O5/gFeezRQiV5NL/RNc/MoacC9ib
         bKo4svAeaNwGB6c1ArZoyD/OMA5EjGLLLMGqla2poqNgJNJfmZsaS1e2zHFMIzHsTHz1
         ToqEhZUV3mwCUx/me2EiUW7zruqe1ezj2xbb/mYQCKHrzo0EgjtZ5UyzzaagxJ4HiKdY
         rwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hrEyQGzrB3TAIf/TmXechjLg15TCHCdypY6rTcTiJ1Q=;
        b=fgk/J/sNGfpZUXBWhc3D1YmW988cI2sgYhMCa8DHTmjfd8rdpefsD/6J3I82hPzye2
         RY3CY8izQS2WZhfEIPCaLK8SGho4Mn5rTp+T54jjJpzRc301htbnH/Nut59yiJG+QSLg
         EJeagOCpfobM1s79k7hWLanvLbJbOpMXd/eMtDDy29PSwaOxJu6px1txwDO2Z+GdLlj3
         ElXE7vMG1r2J84qAGpSjShZFPcnOqr95qabEZGdyOsedaucpSiKvDv9+8CdB2nkWGPJY
         HpZ8atIf/JdX2upBDc7PSycAOMx43QRebtETjSWYFgtRZfPDyv4sHUcHSjdo1yR6b+Z5
         oByA==
X-Gm-Message-State: AJIora8v3DUPdUyQhE+aVs+9Zmb4ha8v38kR9IfU10rjRYUV79kjd8Y+
        RgTmDN8k1+q+GZcqkMXvFmEmrw==
X-Google-Smtp-Source: AGRyM1shMPa38M0T1/NNgVd+C25k5wuq8hvvwXh0UbSz0nvv2e7mPwkacDPoPodFXencByhxF9Gg7w==
X-Received: by 2002:a17:90b:17c4:b0:1f0:5541:f2a with SMTP id me4-20020a17090b17c400b001f055410f2amr31585924pjb.224.1658133423176;
        Mon, 18 Jul 2022 01:37:03 -0700 (PDT)
Received: from C02GD5ZHMD6R.bytedance.net ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902d88500b00163ffbc4f74sm8794752plz.49.2022.07.18.01.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 01:37:02 -0700 (PDT)
From:   Jinke Han <hanjinke.666@bytedance.com>
X-Google-Original-From: Jinke Han <hnajinke.666@bytedance>
To:     axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, hanjinke <hanjinke.666@bytedance.com>
Subject: [PATCH] block: don't allow the same type rq_qos add more than once
Date:   Mon, 18 Jul 2022 16:36:46 +0800
Message-Id: <20220718083646.67601-1-hanjinke.666@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: hanjinke <hanjinke.666@bytedance.com>

In our test of iocost, we encounttered some list add/del corrutions of
inner_walk list in ioc_timer_fn.
The resean can be descripted as follow:

cpu 0						cpu 1
ioc_qos_write					ioc_qos_write

ioc = q_to_ioc(bdev_get_queue(bdev));
if (!ioc) {
	ioc = kzalloc();			ioc = q_to_ioc(bdev_get_queue(bdev));
							if (!ioc) {
								ioc = kzalloc();
								...
								rq_qos_add(q, rqos);
							 }
	...
	rq_qos_add(q, rqos);
	...
}

When the io.cost.qos file is written by two cpu concurrently, rq_qos may
be added to one disk twice. In that case, there will be two iocs enabled
and running on one disk. They own different iocgs on their active list.
In the ioc_timer_fn function, because of the iocgs from two ioc have the
same root iocg, the root iocg's walk_list may be overwritten by each
other and this lead to list add/del corrutions in building or destorying
the inner_walk list.

And so far, the blk-rq-qos framework works in case that one instance for
one type rq_qos per queue by default. This patch make this explicit and
also fix the crash above.

Signed-off-by: hanjinke <hanjinke.666@bytedance.com>
---
 block/blk-iocost.c    |  7 ++++++-
 block/blk-iolatency.c |  6 +++++-
 block/blk-ioprio.c    |  5 +++++
 block/blk-rq-qos.h    | 11 ++++++++++-
 block/blk-wbt.c       |  8 +++++++-
 5 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 33a11ba971ea..2c41edc3fd70 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2886,7 +2886,12 @@ static int blk_iocost_init(struct request_queue *q)
 	 * called before policy activation completion, can't assume that the
 	 * target bio has an iocg associated and need to test for NULL iocg.
 	 */
-	rq_qos_add(q, rqos);
+	ret = rq_qos_add(q, rqos);
+	if (ret) {
+		free_percpu(ioc->pcpu_stat);
+		kfree(ioc);
+		return ret;
+	}
 	ret = blkcg_activate_policy(q, &blkcg_policy_iocost);
 	if (ret) {
 		rq_qos_del(q, rqos);
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 9568bf8dfe82..9a572439f326 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -773,7 +773,11 @@ int blk_iolatency_init(struct request_queue *q)
 	rqos->ops = &blkcg_iolatency_ops;
 	rqos->q = q;
 
-	rq_qos_add(q, rqos);
+	ret = rq_qos_add(q, rqos);
+	if (ret) {
+		kfree(blkiolat);
+		return ret;
+	}
 
 	ret = blkcg_activate_policy(q, &blkcg_policy_iolatency);
 	if (ret) {
diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
index 79e797f5d194..931bffdf0cab 100644
--- a/block/blk-ioprio.c
+++ b/block/blk-ioprio.c
@@ -251,6 +251,11 @@ int blk_ioprio_init(struct request_queue *q)
 	 * rq-qos callbacks.
 	 */
 	rq_qos_add(q, rqos);
+	if (ret) {
+		blkcg_deactivate_policy(q, &ioprio_policy);
+		kfree(blkioprio_blkg);
+		return ret;
+	}
 
 	return 0;
 }
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 0e46052b018a..bbc70cf21c9c 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -86,7 +86,7 @@ static inline void rq_wait_init(struct rq_wait *rq_wait)
 	init_waitqueue_head(&rq_wait->wait);
 }
 
-static inline void rq_qos_add(struct request_queue *q, struct rq_qos *rqos)
+static inline int rq_qos_add(struct request_queue *q, struct rq_qos *rqos)
 {
 	/*
 	 * No IO can be in-flight when adding rqos, so freeze queue, which
@@ -98,6 +98,8 @@ static inline void rq_qos_add(struct request_queue *q, struct rq_qos *rqos)
 	blk_mq_freeze_queue(q);
 
 	spin_lock_irq(&q->queue_lock);
+	if (rq_qos_id(q, rqos->id))
+		goto out;
 	rqos->next = q->rq_qos;
 	q->rq_qos = rqos;
 	spin_unlock_irq(&q->queue_lock);
@@ -109,6 +111,13 @@ static inline void rq_qos_add(struct request_queue *q, struct rq_qos *rqos)
 		blk_mq_debugfs_register_rqos(rqos);
 		mutex_unlock(&q->debugfs_mutex);
 	}
+
+	return 0;
+out:
+	spin_unlock_irq(&q->queue_lock);
+	blk_mq_unfreeze_queue(q);
+	return -EBUSY;
+
 }
 
 static inline void rq_qos_del(struct request_queue *q, struct rq_qos *rqos)
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 0c119be0e813..cc8f45929b31 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -820,6 +820,7 @@ int wbt_init(struct request_queue *q)
 {
 	struct rq_wb *rwb;
 	int i;
+	int ret;
 
 	rwb = kzalloc(sizeof(*rwb), GFP_KERNEL);
 	if (!rwb)
@@ -846,7 +847,12 @@ int wbt_init(struct request_queue *q)
 	/*
 	 * Assign rwb and add the stats callback.
 	 */
-	rq_qos_add(q, &rwb->rqos);
+	ret = rq_qos_add(q, &rwb->rqos);
+	if (ret) {
+		blk_stat_free_callback(rwb->cb);
+		kfree(rwb);
+		return ret;
+	}
 	blk_stat_add_callback(q, rwb->cb);
 
 	rwb->min_lat_nsec = wbt_default_latency_nsec(q);
-- 
2.20.1


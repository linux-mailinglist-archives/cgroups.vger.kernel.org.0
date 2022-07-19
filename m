Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462755793BE
	for <lists+cgroups@lfdr.de>; Tue, 19 Jul 2022 09:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbiGSHDR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Jul 2022 03:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbiGSHDP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Jul 2022 03:03:15 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434C63191C
        for <cgroups@vger.kernel.org>; Tue, 19 Jul 2022 00:03:14 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id z1so11149280plb.1
        for <cgroups@vger.kernel.org>; Tue, 19 Jul 2022 00:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lrrNHRWM7NP+3zb8IFTvMKgPvWnG7x306BJK3kdaz5g=;
        b=gSF+zaKOCHC74e9MjsTx+M3bHZSWBkw6yIO0SgtRd31uUqrk4B3Q1QJ2HLItKA1Aob
         2lfewUZxxeL8Zh+pG7ZtNKsaH0NjyhyuPCJvBOeTcNXbXcFnzNZMVcKxM+M/yA2mXlD/
         c3lEeTD11OdTl/npeekebAuUGfEmYGdgOfMMeRyifLa8xEmSUGKvexfdQ2B3Bwh6fEsT
         J/9knYWFj8h7vpntccbxdAm3Hgd26MbitIakjnZghWCnby8SV+oGsIVEAcnpVD3oU1To
         u6qxMMd0r8xPInVoPJ2PkVyI4rVsAZ4eL6za5HglT6CzLRo+x7Y9N9grCanzTpCIaziG
         Kr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lrrNHRWM7NP+3zb8IFTvMKgPvWnG7x306BJK3kdaz5g=;
        b=1jbwMQyGLztzL4Lyz2YwHsLL0otAVL7h4T+qpPh3R9cYtJmx8aanYkbnCQdPjKNsiS
         MsXoFarr3bQbB47pjaHHnNTcSzrJoPstEl9oUb0LvBxxPANzLpe+zi1gmWTHSx+VeDYh
         GYNaqiIXWd+XksAsdFupWEOiQeto3lyAtdUnv/SuCcfXbBqIK/FzMEzfdu+SJ8ayiS34
         rkqYJWVRSvb11WCLQPlSlky2mk9gnUBH2/fH7QH9dOmAzv9do5MD1XgRzDlyuSSkCm4i
         RuWDcnzLO8KW3zBWP+6yWadQGiK4G82c/EjjHaGZPBkClAYtutPq0wr7J4vzgfbUJwd4
         35KA==
X-Gm-Message-State: AJIora9RHg1/g4JxEmnnQ9cZ35BkD1yAFIFz61xEwrDzJCZNS/3XDFsw
        DoSa65H0ULvhpnLJuS6x1Uza0A==
X-Google-Smtp-Source: AGRyM1tFs87s6yDOR/LgyQq0dOntOjHc7y4BXG4H+msvLKei6lPfqJ6T0D4367NppCi1f3OK6MULUg==
X-Received: by 2002:a17:902:be16:b0:16d:b62:bc77 with SMTP id r22-20020a170902be1600b0016d0b62bc77mr1697742pls.74.1658214193731;
        Tue, 19 Jul 2022 00:03:13 -0700 (PDT)
Received: from C02GD5ZHMD6R.bytedance.net ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id y10-20020aa7942a000000b0052890d61628sm10605268pfo.60.2022.07.19.00.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 00:03:13 -0700 (PDT)
From:   Jinke Han <hanjinke.666@bytedance.com>
X-Google-Original-From: Jinke Han <hnajinke.666@bytedance>
To:     axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Jinke Han <hanjinke.666@bytedance.com>
Subject: [PATCH v2] block: don't allow the same type rq_qos add more than once
Date:   Tue, 19 Jul 2022 15:02:58 +0800
Message-Id: <20220719070258.25721-1-hanjinke.666@bytedance.com>
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

From: Jinke Han <hanjinke.666@bytedance.com>

In our test of iocost, we encounttered some list add/del corrutions of
inner_walk list in ioc_timer_fn.

The reason can be descripted as follow:
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

Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>
---
 block/blk-iocost.c    | 19 ++++++++++++-------
 block/blk-iolatency.c |  6 +++++-
 block/blk-ioprio.c    |  5 +++++
 block/blk-rq-qos.h    | 11 ++++++++++-
 block/blk-wbt.c       |  8 +++++++-
 5 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 33a11ba971ea..e058b51a4e63 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2886,15 +2886,20 @@ static int blk_iocost_init(struct request_queue *q)
 	 * called before policy activation completion, can't assume that the
 	 * target bio has an iocg associated and need to test for NULL iocg.
 	 */
-	rq_qos_add(q, rqos);
+	ret = rq_qos_add(q, rqos);
+	if (ret)
+		goto err_free_ioc;
+
 	ret = blkcg_activate_policy(q, &blkcg_policy_iocost);
-	if (ret) {
-		rq_qos_del(q, rqos);
-		free_percpu(ioc->pcpu_stat);
-		kfree(ioc);
-		return ret;
-	}
+	if (ret)
+		goto err_del_qos;
 	return 0;
+err_del_qos:
+	rq_qos_del(q, rqos);
+err_free_ioc:
+	free_percpu(ioc->pcpu_stat);
+	kfree(ioc);
+	return ret;
 }
 
 static struct blkcg_policy_data *ioc_cpd_alloc(gfp_t gfp)
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
index 0e46052b018a..08b856570ad1 100644
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
+		goto ebusy;
 	rqos->next = q->rq_qos;
 	q->rq_qos = rqos;
 	spin_unlock_irq(&q->queue_lock);
@@ -109,6 +111,13 @@ static inline void rq_qos_add(struct request_queue *q, struct rq_qos *rqos)
 		blk_mq_debugfs_register_rqos(rqos);
 		mutex_unlock(&q->debugfs_mutex);
 	}
+
+	return 0;
+ebusy:
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


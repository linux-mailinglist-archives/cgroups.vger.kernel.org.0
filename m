Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6807B689CA0
	for <lists+cgroups@lfdr.de>; Fri,  3 Feb 2023 16:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbjBCPEz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Feb 2023 10:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbjBCPEy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Feb 2023 10:04:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22522A0EA5;
        Fri,  3 Feb 2023 07:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=QVuu1nOT6KhYLzaFdV7PKoYSe2DeoePsCNAuWZ+5y9s=; b=vbMA/MMzZsWHZLJZ8oMZPxbigk
        Tmgprg91KGtC+otgtF1cb3JulAQznr51uBFMIH74atOVcSBCbQdy49EJxPJe+WldX4WtcvhiHeOsI
        S7RAIcPBM73CpMZpXNkiy4p+U6YyB14ls6F5llqBvnNAqxj9N7m+MCgdCQptsSd0Q1q93veqduJyS
        wTcl998ZMJ41BQ+kR0Im+9QjAosP+Icu3PkQCJpFc2jiRtrti4fndrLtRZkS1JWaaVHNCKPjCyfA8
        Y6JtMoa01vinqE1SELrj2PR5AB7WUAqfBFMGw0/Wmmh0kUGheKmvOjdGU6RuY8WsfE5Lx/HOBwCDU
        nddtjL3Q==;
Received: from [2001:4bb8:19a:272a:910:bb67:7287:f956] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNxcJ-002aCv-JI; Fri, 03 Feb 2023 15:04:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH 12/19] blk-rq-qos: move rq_qos_add and rq_qos_del out of line
Date:   Fri,  3 Feb 2023 16:03:53 +0100
Message-Id: <20230203150400.3199230-13-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230203150400.3199230-1-hch@lst.de>
References: <20230203150400.3199230-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

These two functions are rather larger and not in a fast path, so move
them out of line.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-rq-qos.c | 60 +++++++++++++++++++++++++++++++++++++++++++++
 block/blk-rq-qos.h | 61 ++--------------------------------------------
 2 files changed, 62 insertions(+), 59 deletions(-)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 88f0fe7dcf5451..aae98dcb01ebe7 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -294,3 +294,63 @@ void rq_qos_exit(struct request_queue *q)
 		rqos->ops->exit(rqos);
 	}
 }
+
+int rq_qos_add(struct request_queue *q, struct rq_qos *rqos)
+{
+	/*
+	 * No IO can be in-flight when adding rqos, so freeze queue, which
+	 * is fine since we only support rq_qos for blk-mq queue.
+	 *
+	 * Reuse ->queue_lock for protecting against other concurrent
+	 * rq_qos adding/deleting
+	 */
+	blk_mq_freeze_queue(q);
+
+	spin_lock_irq(&q->queue_lock);
+	if (rq_qos_id(q, rqos->id))
+		goto ebusy;
+	rqos->next = q->rq_qos;
+	q->rq_qos = rqos;
+	spin_unlock_irq(&q->queue_lock);
+
+	blk_mq_unfreeze_queue(q);
+
+	if (rqos->ops->debugfs_attrs) {
+		mutex_lock(&q->debugfs_mutex);
+		blk_mq_debugfs_register_rqos(rqos);
+		mutex_unlock(&q->debugfs_mutex);
+	}
+
+	return 0;
+ebusy:
+	spin_unlock_irq(&q->queue_lock);
+	blk_mq_unfreeze_queue(q);
+	return -EBUSY;
+
+}
+
+void rq_qos_del(struct request_queue *q, struct rq_qos *rqos)
+{
+	struct rq_qos **cur;
+
+	/*
+	 * See comment in rq_qos_add() about freezing queue & using
+	 * ->queue_lock.
+	 */
+	blk_mq_freeze_queue(q);
+
+	spin_lock_irq(&q->queue_lock);
+	for (cur = &q->rq_qos; *cur; cur = &(*cur)->next) {
+		if (*cur == rqos) {
+			*cur = rqos->next;
+			break;
+		}
+	}
+	spin_unlock_irq(&q->queue_lock);
+
+	blk_mq_unfreeze_queue(q);
+
+	mutex_lock(&q->debugfs_mutex);
+	blk_mq_debugfs_unregister_rqos(rqos);
+	mutex_unlock(&q->debugfs_mutex);
+}
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 1ef1f7d4bc3cbc..805eee8b031d00 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -85,65 +85,8 @@ static inline void rq_wait_init(struct rq_wait *rq_wait)
 	init_waitqueue_head(&rq_wait->wait);
 }
 
-static inline int rq_qos_add(struct request_queue *q, struct rq_qos *rqos)
-{
-	/*
-	 * No IO can be in-flight when adding rqos, so freeze queue, which
-	 * is fine since we only support rq_qos for blk-mq queue.
-	 *
-	 * Reuse ->queue_lock for protecting against other concurrent
-	 * rq_qos adding/deleting
-	 */
-	blk_mq_freeze_queue(q);
-
-	spin_lock_irq(&q->queue_lock);
-	if (rq_qos_id(q, rqos->id))
-		goto ebusy;
-	rqos->next = q->rq_qos;
-	q->rq_qos = rqos;
-	spin_unlock_irq(&q->queue_lock);
-
-	blk_mq_unfreeze_queue(q);
-
-	if (rqos->ops->debugfs_attrs) {
-		mutex_lock(&q->debugfs_mutex);
-		blk_mq_debugfs_register_rqos(rqos);
-		mutex_unlock(&q->debugfs_mutex);
-	}
-
-	return 0;
-ebusy:
-	spin_unlock_irq(&q->queue_lock);
-	blk_mq_unfreeze_queue(q);
-	return -EBUSY;
-
-}
-
-static inline void rq_qos_del(struct request_queue *q, struct rq_qos *rqos)
-{
-	struct rq_qos **cur;
-
-	/*
-	 * See comment in rq_qos_add() about freezing queue & using
-	 * ->queue_lock.
-	 */
-	blk_mq_freeze_queue(q);
-
-	spin_lock_irq(&q->queue_lock);
-	for (cur = &q->rq_qos; *cur; cur = &(*cur)->next) {
-		if (*cur == rqos) {
-			*cur = rqos->next;
-			break;
-		}
-	}
-	spin_unlock_irq(&q->queue_lock);
-
-	blk_mq_unfreeze_queue(q);
-
-	mutex_lock(&q->debugfs_mutex);
-	blk_mq_debugfs_unregister_rqos(rqos);
-	mutex_unlock(&q->debugfs_mutex);
-}
+int rq_qos_add(struct request_queue *q, struct rq_qos *rqos);
+void rq_qos_del(struct request_queue *q, struct rq_qos *rqos);
 
 typedef bool (acquire_inflight_cb_t)(struct rq_wait *rqw, void *private_data);
 typedef void (cleanup_cb_t)(struct rq_wait *rqw, void *private_data);
-- 
2.39.0


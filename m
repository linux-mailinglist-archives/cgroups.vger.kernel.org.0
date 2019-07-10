Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6028A64DC3
	for <lists+cgroups@lfdr.de>; Wed, 10 Jul 2019 22:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfGJUvt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 Jul 2019 16:51:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39956 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727917AbfGJUvr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 10 Jul 2019 16:51:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so1790301pgj.7;
        Wed, 10 Jul 2019 13:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JKWpADQRRd4cOHqFQiVbs/M0Dl+jEZ4tiWOCtZnmPQM=;
        b=SdtjWVkQh250bHyYw3SHxdON+2qnRJzzC7V9U5QRdPizFZ0UDpPxW6hPrYYWE1ILkZ
         YLV7Wb5H5zanBWfmfad6oFQmHGDXMJe3DKQZyJClOVIj91Fb1XY68X0oCsDkHDUjevMJ
         k3ezfpym+frm3+q9lkmtDva8o+3zKmQSPv7W2MmoMXqce+GieBpLhCEdu6fUbzRFNIBu
         qnFuJcGULszw/smK2K/uW9BOY1R7Ft3Zj3KNWTlRP3rBTsUbKD4lYIjf/E3U/gJN/yB6
         JKuVtLOerNKxM28/N9vmCX8o3MUvoIad9xlj2tVwprJpX7fcJ511sNz104wczjj1Jydp
         JTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=JKWpADQRRd4cOHqFQiVbs/M0Dl+jEZ4tiWOCtZnmPQM=;
        b=lj6GJB4JrbH+d0S8zczjW4Xao+N/qpBIy/nSd7ACMVaqYoWqgXgXfG3dPmnLvD6yNz
         XtKrpRRZo9wRNJ3sjMFJyQaEpdc2ueVF5TvztgFYSsgAmqLZJWi/fkC7n57tU3bLMiPc
         1CuyK97stmwKyrRAv0xhxMF+6R+a+7D0WLnhBHzKMkZLPKzcwiGaNJyi5hUQkdOc3TGW
         IigalVTZbMQOeSEwDYpDmt9Q2aibm7Kw10UL1tnmf0C302wPKgomL6+whQ9blxMzvjMH
         KIQRfqH2KVzeG1ZnPeMATtRD7kzitftGazX0WC/uRVKZCiQAeBnGvxPjBWUTP8kIoonq
         eySg==
X-Gm-Message-State: APjAAAWNmyRqbUYFSVPkiOMZoetosp433+rYUqOexr8aLmhc1KG8dTce
        D5hYPyP672ejR3I3Sdu/bv4=
X-Google-Smtp-Source: APXvYqzqE+O9wM4kJy7X9m0gX1RHCEvsWX5XL9OOFO0FGIJfYeLtTf5ur6n1mx0k0IYHXYSbR98uQw==
X-Received: by 2002:a63:e213:: with SMTP id q19mr233650pgh.180.1562791906703;
        Wed, 10 Jul 2019 13:51:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:2bbe])
        by smtp.gmail.com with ESMTPSA id h14sm3177198pfq.22.2019.07.10.13.51.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 13:51:46 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, newella@fb.com, clm@fb.com, josef@toxicpanda.com,
        dennisz@fb.com, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 05/10] block/rq_qos: implement rq_qos_ops->queue_depth_changed()
Date:   Wed, 10 Jul 2019 13:51:23 -0700
Message-Id: <20190710205128.1316483-6-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190710205128.1316483-1-tj@kernel.org>
References: <20190710205128.1316483-1-tj@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

wbt already gets queue depth changed notification through
wbt_set_queue_depth().  Generalize it into
rq_qos_ops->queue_depth_changed() so that other rq_qos policies can
easily hook into the events too.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-rq-qos.c   |  9 +++++++++
 block/blk-rq-qos.h   |  8 ++++++++
 block/blk-settings.c |  2 +-
 block/blk-wbt.c      | 18 ++++++++----------
 block/blk-wbt.h      |  4 ----
 5 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 7debcaf1ee53..fb11652348fc 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -101,6 +101,15 @@ void __rq_qos_done_bio(struct rq_qos *rqos, struct bio *bio)
 	} while (rqos);
 }
 
+void __rq_qos_queue_depth_changed(struct rq_qos *rqos)
+{
+	do {
+		if (rqos->ops->queue_depth_changed)
+			rqos->ops->queue_depth_changed(rqos);
+		rqos = rqos->next;
+	} while (rqos);
+}
+
 /*
  * Return true, if we can't increase the depth further by scaling
  */
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 8e426a8505b6..e15b6907b76d 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -41,6 +41,7 @@ struct rq_qos_ops {
 	void (*done)(struct rq_qos *, struct request *);
 	void (*done_bio)(struct rq_qos *, struct bio *);
 	void (*cleanup)(struct rq_qos *, struct bio *);
+	void (*queue_depth_changed)(struct rq_qos *);
 	void (*exit)(struct rq_qos *);
 	const struct blk_mq_debugfs_attr *debugfs_attrs;
 };
@@ -138,6 +139,7 @@ void __rq_qos_throttle(struct rq_qos *rqos, struct bio *bio);
 void __rq_qos_track(struct rq_qos *rqos, struct request *rq, struct bio *bio);
 void __rq_qos_merge(struct rq_qos *rqos, struct request *rq, struct bio *bio);
 void __rq_qos_done_bio(struct rq_qos *rqos, struct bio *bio);
+void __rq_qos_queue_depth_changed(struct rq_qos *rqos);
 
 static inline void rq_qos_cleanup(struct request_queue *q, struct bio *bio)
 {
@@ -194,6 +196,12 @@ static inline void rq_qos_merge(struct request_queue *q, struct request *rq,
 		__rq_qos_merge(q->rq_qos, rq, bio);
 }
 
+static inline void rq_qos_queue_depth_changed(struct request_queue *q)
+{
+	if (q->rq_qos)
+		__rq_qos_queue_depth_changed(q->rq_qos);
+}
+
 void rq_qos_exit(struct request_queue *);
 
 #endif
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 2ae348c101a0..df323ea448de 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -804,7 +804,7 @@ EXPORT_SYMBOL(blk_queue_update_dma_alignment);
 void blk_set_queue_depth(struct request_queue *q, unsigned int depth)
 {
 	q->queue_depth = depth;
-	wbt_set_queue_depth(q, depth);
+	rq_qos_queue_depth_changed(q);
 }
 EXPORT_SYMBOL(blk_set_queue_depth);
 
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 313f45a37e9d..8118f95a194b 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -629,15 +629,6 @@ static void wbt_requeue(struct rq_qos *rqos, struct request *rq)
 	}
 }
 
-void wbt_set_queue_depth(struct request_queue *q, unsigned int depth)
-{
-	struct rq_qos *rqos = wbt_rq_qos(q);
-	if (rqos) {
-		RQWB(rqos)->rq_depth.queue_depth = depth;
-		__wbt_update_limits(RQWB(rqos));
-	}
-}
-
 void wbt_set_write_cache(struct request_queue *q, bool write_cache_on)
 {
 	struct rq_qos *rqos = wbt_rq_qos(q);
@@ -689,6 +680,12 @@ static int wbt_data_dir(const struct request *rq)
 	return -1;
 }
 
+static void wbt_queue_depth_changed(struct rq_qos *rqos)
+{
+	RQWB(rqos)->rq_depth.queue_depth = blk_queue_depth(rqos->q);
+	__wbt_update_limits(RQWB(rqos));
+}
+
 static void wbt_exit(struct rq_qos *rqos)
 {
 	struct rq_wb *rwb = RQWB(rqos);
@@ -811,6 +808,7 @@ static struct rq_qos_ops wbt_rqos_ops = {
 	.requeue = wbt_requeue,
 	.done = wbt_done,
 	.cleanup = wbt_cleanup,
+	.queue_depth_changed = wbt_queue_depth_changed,
 	.exit = wbt_exit,
 #ifdef CONFIG_BLK_DEBUG_FS
 	.debugfs_attrs = wbt_debugfs_attrs,
@@ -853,7 +851,7 @@ int wbt_init(struct request_queue *q)
 
 	rwb->min_lat_nsec = wbt_default_latency_nsec(q);
 
-	wbt_set_queue_depth(q, blk_queue_depth(q));
+	wbt_queue_depth_changed(&rwb->rqos);
 	wbt_set_write_cache(q, test_bit(QUEUE_FLAG_WC, &q->queue_flags));
 
 	return 0;
diff --git a/block/blk-wbt.h b/block/blk-wbt.h
index f47218d5b3b2..8e4e37660971 100644
--- a/block/blk-wbt.h
+++ b/block/blk-wbt.h
@@ -95,7 +95,6 @@ void wbt_enable_default(struct request_queue *);
 u64 wbt_get_min_lat(struct request_queue *q);
 void wbt_set_min_lat(struct request_queue *q, u64 val);
 
-void wbt_set_queue_depth(struct request_queue *, unsigned int);
 void wbt_set_write_cache(struct request_queue *, bool);
 
 u64 wbt_default_latency_nsec(struct request_queue *);
@@ -118,9 +117,6 @@ static inline void wbt_disable_default(struct request_queue *q)
 static inline void wbt_enable_default(struct request_queue *q)
 {
 }
-static inline void wbt_set_queue_depth(struct request_queue *q, unsigned int depth)
-{
-}
 static inline void wbt_set_write_cache(struct request_queue *q, bool wc)
 {
 }
-- 
2.17.1


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6F11A0D3E
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2019 00:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfH1WGQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Aug 2019 18:06:16 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46115 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbfH1WGP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 28 Aug 2019 18:06:15 -0400
Received: by mail-qk1-f195.google.com with SMTP id p13so1151746qkg.13;
        Wed, 28 Aug 2019 15:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=85wyZs3HMu6iXK+wZ0W8BFNcrkDk5YmJ/FXIK4MM3S8=;
        b=cG+3/ed+q1RdEnqmWH4ftRcuxyp4xnZQof6cm/OxQXjNXAi+nZbBEnX10Jw0NfVdM/
         O9nEbP/1s2E7IfITAwQTVpdRRflbD/FAQK83XRL36CN8o8HwKTzka1Sny7JjJYreVXbA
         4rYCz2XdATy2L/df9Y743cFRjramsvYTkyDu5QoTrZTrpylaHzR4hB9NVfaoGSKfD+ME
         7iVYTTPjGExBhPoYs5HYXOjn5qKYoYoM1cj95smDJWQKRv4ztSF8H2y0h3fz7iVw2QFh
         7DJ1YBNI3TTW9LtcBctjZ7kYYWKeOwe8cWb3EhhKI82e/f3cST1zRbpMzdMyfE7I15fU
         hJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=85wyZs3HMu6iXK+wZ0W8BFNcrkDk5YmJ/FXIK4MM3S8=;
        b=b5lX1435WIterR4643kS06/mWyWCF944aWMKGdBZSFIfVksuaLTHS3QLNODfOB6Wv1
         R0qhG+H2o0Cpp2cs+5/3TyG0mDj5b1+SaivRibIt1JnpmpD5+e+KvSPh8danb4CmGbyV
         01oUtlZBIBbOCcsdq81NGRQe6mU1QGL8LX46PoTMsb6bi+0YZSqI/xS9yeDTVn3zPGQU
         rR6SSNjbi6T2iedRZBVCNhbVyvPxk0GrLzYZYVDlxuwpl22Gvmh8g2tRrzcsaS2wcXNk
         Jujr+13718a8m7lCQdyndz8tl8R12/tHTpGI0KRUMIwc/uUO/urdYL464X3lB0yvm2x3
         fZLQ==
X-Gm-Message-State: APjAAAUmrkSY4ydGjYfOxEs9ncQLGy5iHeJIMX5F7+I3oqLXnR6PL6f7
        d6KnvVBAR+Nl7FrP1cdbF4I=
X-Google-Smtp-Source: APXvYqy7/z2dUjl+mXRhpdeons/i/EZxNOJzaBdfT9TxPNEFa74lslcRCiGyFc6x+EqwdYa9bPooPA==
X-Received: by 2002:a05:620a:1134:: with SMTP id p20mr6459763qkk.434.1567029974498;
        Wed, 28 Aug 2019 15:06:14 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:c231])
        by smtp.gmail.com with ESMTPSA id c26sm19949qtk.93.2019.08.28.15.06.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 15:06:13 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, newella@fb.com, clm@fb.com, josef@toxicpanda.com,
        dennisz@fb.com, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 04/10] block/rq_qos: add rq_qos_merge()
Date:   Wed, 28 Aug 2019 15:05:54 -0700
Message-Id: <20190828220600.2527417-5-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828220600.2527417-1-tj@kernel.org>
References: <20190828220600.2527417-1-tj@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Add a merge hook for rq_qos.  This will be used by io.weight.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-core.c   | 4 ++++
 block/blk-rq-qos.c | 9 +++++++++
 block/blk-rq-qos.h | 9 +++++++++
 3 files changed, 22 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 77807a5d7f9e..875e8d105067 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -604,6 +604,7 @@ bool bio_attempt_back_merge(struct request *req, struct bio *bio,
 		return false;
 
 	trace_block_bio_backmerge(req->q, req, bio);
+	rq_qos_merge(req->q, req, bio);
 
 	if ((req->cmd_flags & REQ_FAILFAST_MASK) != ff)
 		blk_rq_set_mixed_merge(req);
@@ -625,6 +626,7 @@ bool bio_attempt_front_merge(struct request *req, struct bio *bio,
 		return false;
 
 	trace_block_bio_frontmerge(req->q, req, bio);
+	rq_qos_merge(req->q, req, bio);
 
 	if ((req->cmd_flags & REQ_FAILFAST_MASK) != ff)
 		blk_rq_set_mixed_merge(req);
@@ -650,6 +652,8 @@ bool bio_attempt_discard_merge(struct request_queue *q, struct request *req,
 	    blk_rq_get_max_sectors(req, blk_rq_pos(req)))
 		goto no_merge;
 
+	rq_qos_merge(q, req, bio);
+
 	req->biotail->bi_next = bio;
 	req->biotail = bio;
 	req->__data_len += bio->bi_iter.bi_size;
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 3954c0dc1443..f4eea78f5cc1 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -83,6 +83,15 @@ void __rq_qos_track(struct rq_qos *rqos, struct request *rq, struct bio *bio)
 	} while (rqos);
 }
 
+void __rq_qos_merge(struct rq_qos *rqos, struct request *rq, struct bio *bio)
+{
+	do {
+		if (rqos->ops->merge)
+			rqos->ops->merge(rqos, rq, bio);
+		rqos = rqos->next;
+	} while (rqos);
+}
+
 void __rq_qos_done_bio(struct rq_qos *rqos, struct bio *bio)
 {
 	do {
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 2300e038b9fa..8e426a8505b6 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -35,6 +35,7 @@ struct rq_qos {
 struct rq_qos_ops {
 	void (*throttle)(struct rq_qos *, struct bio *);
 	void (*track)(struct rq_qos *, struct request *, struct bio *);
+	void (*merge)(struct rq_qos *, struct request *, struct bio *);
 	void (*issue)(struct rq_qos *, struct request *);
 	void (*requeue)(struct rq_qos *, struct request *);
 	void (*done)(struct rq_qos *, struct request *);
@@ -135,6 +136,7 @@ void __rq_qos_issue(struct rq_qos *rqos, struct request *rq);
 void __rq_qos_requeue(struct rq_qos *rqos, struct request *rq);
 void __rq_qos_throttle(struct rq_qos *rqos, struct bio *bio);
 void __rq_qos_track(struct rq_qos *rqos, struct request *rq, struct bio *bio);
+void __rq_qos_merge(struct rq_qos *rqos, struct request *rq, struct bio *bio);
 void __rq_qos_done_bio(struct rq_qos *rqos, struct bio *bio);
 
 static inline void rq_qos_cleanup(struct request_queue *q, struct bio *bio)
@@ -185,6 +187,13 @@ static inline void rq_qos_track(struct request_queue *q, struct request *rq,
 		__rq_qos_track(q->rq_qos, rq, bio);
 }
 
+static inline void rq_qos_merge(struct request_queue *q, struct request *rq,
+				struct bio *bio)
+{
+	if (q->rq_qos)
+		__rq_qos_merge(q->rq_qos, rq, bio);
+}
+
 void rq_qos_exit(struct request_queue *);
 
 #endif
-- 
2.17.1


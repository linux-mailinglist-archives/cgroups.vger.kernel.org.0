Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8BC364DD7
	for <lists+cgroups@lfdr.de>; Wed, 10 Jul 2019 22:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfGJUwS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 Jul 2019 16:52:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39739 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727896AbfGJUvo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 10 Jul 2019 16:51:44 -0400
Received: by mail-pf1-f195.google.com with SMTP id j2so1641406pfe.6;
        Wed, 10 Jul 2019 13:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JIWlTDHRU3mjWfgflvhaa5vcE8JQAEkvNv7BJwQpcU4=;
        b=ko2iX2X5bcEWp600/qku8sen9UEgNgcKUWlCMJOwU399AGW5/bivrtNQrJL7HGj2sQ
         wDG9sMPdOFKvirT8KNF44f6g0g/iKzIQb6amaxQnVhfpuMYetdJX0pVfWRX/WPJfEkkR
         TyRhm0RdqBqowpzAyqV0Iq4FMbxplDiz2ny2QbYdge8ld2AYWulXV97GHTgygzhhg3H8
         xPG2mAJMvftGLkQgXk6YCclBNKT6qwbGguLE/Y3jCFSjT2WkSHYdk8Gv0PU82XmvKImR
         bPsEa4rFWcxAECpK3Scjg2Vi4qwdC/zVz4qYsWW1hR4vbIGkXPPm7zraSBf3mYe6d2qk
         +ltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=JIWlTDHRU3mjWfgflvhaa5vcE8JQAEkvNv7BJwQpcU4=;
        b=S+PjI8odAruFrLh3jHeb6q6WmHc9SPnv+TJNgNqWcCNPD8piVngV6gi7FWD+wJzd3R
         qLHJEk/cWaik2RbgWij94R0ZA0udRQoJGXskj3anvBxFERKC9WlifmYzukJuz13Iaf+y
         +sKhV5JfzMCgxNx3qw7R65R8n9jfVBz2qjIfVq22zjTvHUbh0IkX8rT9/RBjGhKYLyku
         fvrmu4rDFSc5BY34jAw/UG0mzh0SWuC8hlK8jXq0GFPUQ0V4F10JsS7jmX0CpIlAP4TS
         Wv001uAecSjCr14IxrlN86dWzN86iwH2Nhn82GOSfUTrZKIHPSI8N5IlGMjv6ZtU1XUw
         GfVA==
X-Gm-Message-State: APjAAAWXybMcQ+lT0iO2rWD1+2cKBzPe6JnWyb047GRV0vHw1YT9fZs4
        pW7C7xgp+Op1HeEZQCLiG2+LtLVXuZc=
X-Google-Smtp-Source: APXvYqzLUmGA4IjAo8d3P7aJvfwjy6fUo5BUTNFCtXR8zdG1EiK9k+yHvl6tJ056YMBZwoIZZxkm3g==
X-Received: by 2002:a65:654f:: with SMTP id a15mr206363pgw.73.1562791903957;
        Wed, 10 Jul 2019 13:51:43 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:2bbe])
        by smtp.gmail.com with ESMTPSA id g62sm3271010pje.11.2019.07.10.13.51.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 13:51:43 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, newella@fb.com, clm@fb.com, josef@toxicpanda.com,
        dennisz@fb.com, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 04/10] block/rq_qos: add rq_qos_merge()
Date:   Wed, 10 Jul 2019 13:51:22 -0700
Message-Id: <20190710205128.1316483-5-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190710205128.1316483-1-tj@kernel.org>
References: <20190710205128.1316483-1-tj@kernel.org>
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
index 260e36a2c343..4696a89ca039 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -601,6 +601,7 @@ bool bio_attempt_back_merge(struct request *req, struct bio *bio,
 		return false;
 
 	trace_block_bio_backmerge(req->q, req, bio);
+	rq_qos_merge(req->q, req, bio);
 
 	if ((req->cmd_flags & REQ_FAILFAST_MASK) != ff)
 		blk_rq_set_mixed_merge(req);
@@ -622,6 +623,7 @@ bool bio_attempt_front_merge(struct request *req, struct bio *bio,
 		return false;
 
 	trace_block_bio_frontmerge(req->q, req, bio);
+	rq_qos_merge(req->q, req, bio);
 
 	if ((req->cmd_flags & REQ_FAILFAST_MASK) != ff)
 		blk_rq_set_mixed_merge(req);
@@ -647,6 +649,8 @@ bool bio_attempt_discard_merge(struct request_queue *q, struct request *req,
 	    blk_rq_get_max_sectors(req, blk_rq_pos(req)))
 		goto no_merge;
 
+	rq_qos_merge(q, req, bio);
+
 	req->biotail->bi_next = bio;
 	req->biotail = bio;
 	req->__data_len += bio->bi_iter.bi_size;
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 659ccb8b693f..7debcaf1ee53 100644
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


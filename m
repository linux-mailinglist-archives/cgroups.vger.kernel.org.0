Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D83345195
	for <lists+cgroups@lfdr.de>; Fri, 14 Jun 2019 03:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfFNB4p (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Jun 2019 21:56:45 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40616 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfFNB4o (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Jun 2019 21:56:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id p184so384064pfp.7;
        Thu, 13 Jun 2019 18:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x9k+i8/yjn1FnDiqnqxeuqzHrHlaZhjhqT7rlMgp6Jo=;
        b=sNTdvHamDWegVotZF5FTov7T1Gxp3fJ0AXA/cpZtRV1WXzHSbuwE7f5eFwqTMl3K83
         lfhRlCSRcc+/atTEiEmKW84J7S46M1Blj5eVfGDlM3ro5BE5v7uSno4vY5L1cFO2+Ywe
         56MgJowlPT8gsjmuL+P/+tP/siy3DzHBUiQCt4f0q2JE3rq02Yapf0n4Cy1lje35xNhZ
         2aFiOWvrsxymR9r/LjwMzoKAjPZ/k4mWzoQUBcqgM2I/jDmJJQy9aIpd0MpxLKrako2q
         6E0cGc/R0Pj3fDUqbC4/AW5rRYKwmJA923N39FpivTFUZ9eluTC/8FtwEyB1WHhetpKm
         C/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=x9k+i8/yjn1FnDiqnqxeuqzHrHlaZhjhqT7rlMgp6Jo=;
        b=DONb7WwfB1Mf1r6LmoG+xwahb3Tv/HuX9sQNEPfJ86Ed6+Xzp+podYHgUg25K1n2hs
         NX2oyiN362JWAIHvz1xfk67KaxsGzfvzt5uE5RcPVuLyaYQkaAdZqCvkVFfJlVJTtFAA
         HWHSjo/8hhRf4mBllOOTuF0R5DWkASCZM7p0uHEGMpWTfVRldOq0bAPa5Yo3FlfYAW06
         acwVwK+DEcd3rww1oKuafgRtWcB1DAdSB5hAseU5DKV/xsQBPevNLzRgTUcK8gfbxx6u
         +dqZ/lxhRooGn9QKFmnkIb9LtuLLrc1GM61/nTw8HHYsetU8PzVssbKrv6TvY0J2tTvX
         42XQ==
X-Gm-Message-State: APjAAAW6Q/takuDpIPsYDcuzQ7CaZvUHYdPapqmY9aV4d3NE3aOQH509
        9sk18i4jSDJiZkU/LIuIP8MMRzX3
X-Google-Smtp-Source: APXvYqwN+b6fNv5DclHQ/nYyvabSb01H3lkt+uEJQOxBxc6NOYkRARjUbNH0oU2vF/EhHgCQN4wWwQ==
X-Received: by 2002:a17:90a:2648:: with SMTP id l66mr8319889pje.65.1560477403162;
        Thu, 13 Jun 2019 18:56:43 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:9d14])
        by smtp.gmail.com with ESMTPSA id e16sm1094106pga.11.2019.06.13.18.56.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 18:56:42 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, newella@fb.com, clm@fb.com, josef@toxicpanda.com,
        dennisz@fb.com, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: [PATCH 04/10] block/rq_qos: add rq_qos_merge()
Date:   Thu, 13 Jun 2019 18:56:14 -0700
Message-Id: <20190614015620.1587672-5-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614015620.1587672-1-tj@kernel.org>
References: <20190614015620.1587672-1-tj@kernel.org>
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
index aad32071fa67..1dcf679c4b44 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -559,6 +559,7 @@ bool bio_attempt_back_merge(struct request_queue *q, struct request *req,
 		return false;
 
 	trace_block_bio_backmerge(q, req, bio);
+	rq_qos_merge(q, req, bio);
 
 	if ((req->cmd_flags & REQ_FAILFAST_MASK) != ff)
 		blk_rq_set_mixed_merge(req);
@@ -580,6 +581,7 @@ bool bio_attempt_front_merge(struct request_queue *q, struct request *req,
 		return false;
 
 	trace_block_bio_frontmerge(q, req, bio);
+	rq_qos_merge(q, req, bio);
 
 	if ((req->cmd_flags & REQ_FAILFAST_MASK) != ff)
 		blk_rq_set_mixed_merge(req);
@@ -605,6 +607,8 @@ bool bio_attempt_discard_merge(struct request_queue *q, struct request *req,
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


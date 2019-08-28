Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 319B2A0D3F
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2019 00:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfH1WGU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Aug 2019 18:06:20 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42705 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbfH1WGU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 28 Aug 2019 18:06:20 -0400
Received: by mail-qk1-f196.google.com with SMTP id f13so1122971qkm.9;
        Wed, 28 Aug 2019 15:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KICYxWKT5dxQPbrCwvbX65RDkKc1Qm5xckGukET75uw=;
        b=hGSObE46mrzPGCerWrDrpt0b7WXeKGm/n3XDOQo+v8RG3F68dq2ll00C64WPj7mfL5
         GdDA5ZzVNIuL+kCHazgDanC19G4392qfBA1Xb7FZTFEfTmDn7yhciq/yEiqxFpcQHd3Z
         gOdcU067Z0at2ye7SUTC3sAIKBD2aTnYNvweQJfQ+XWQ03CAQS67/Gw6hCeIo7AVloZJ
         RIiOSpIPM/LmSpABoGyI+J1DL+Pozvqrcb1/uMgF+X5N+u1ODKlXCGxBvGxd9BjaTvax
         hAmAtuiJ5U6wBH0vmOwPUAatFI6M2rDtKPluGKhGO/nopDx3ejPNk2iLSF3khWNzinZg
         15IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=KICYxWKT5dxQPbrCwvbX65RDkKc1Qm5xckGukET75uw=;
        b=TWJ+w6dLc3De453B3EAbJW19aDXaJWMvENfQpWpPIkhhlvSeF0yArg2KEWFlGsqHG6
         bTAmMNn6XH0FuZ76yNBPzC+quN7FWCowVClcQT7TVlkbtxScRNb0AiakW/WbctgHv5VS
         ddPxtkYs5YN5TXLYrF3anhJNc/np2495jRAsq7/bm0yE8+ZSheMIk+9rdPd7KCaZJW9M
         7jzaf9tEjJWxmEcNWzt89LIJHc0aIvUOoDjONLBCTH61iy/Za/28vw8N39///nWJAH4Y
         riZqg/EJHFCAfOXl+SbQdElwdGMtUhuX6Cj7uc499AmISiRY6z6YREEQRgitv5+O6JfO
         zLMw==
X-Gm-Message-State: APjAAAWhVFhchFcYmQa7TxaFeHEsHDjp5Jc0Zek6ytfI4uewZ0gZ+TX1
        U7SXstI7x4ZSpNvo4Bn2v4w=
X-Google-Smtp-Source: APXvYqwNHL+b4MezoxJT1oFF0aYSPJlxJoHhK1UiDreYlHlNK+cXv+BR19VbpiAUMRQuqS0P2R6gKw==
X-Received: by 2002:a37:4747:: with SMTP id u68mr6491144qka.42.1567029978891;
        Wed, 28 Aug 2019 15:06:18 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:c231])
        by smtp.gmail.com with ESMTPSA id 1sm251429qko.73.2019.08.28.15.06.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 15:06:18 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, newella@fb.com, clm@fb.com, josef@toxicpanda.com,
        dennisz@fb.com, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 06/10] blkcg: s/RQ_QOS_CGROUP/RQ_QOS_LATENCY/
Date:   Wed, 28 Aug 2019 15:05:56 -0700
Message-Id: <20190828220600.2527417-7-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828220600.2527417-1-tj@kernel.org>
References: <20190828220600.2527417-1-tj@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

io.weight is gonna be another rq_qos cgroup mechanism.  Let's rename
RQ_QOS_CGROUP which is being used by io.latency to RQ_QOS_LATENCY in
preparation.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-iolatency.c | 2 +-
 block/blk-rq-qos.h    | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 46fa6449f4bb..c128d50cb410 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -725,7 +725,7 @@ int blk_iolatency_init(struct request_queue *q)
 		return -ENOMEM;
 
 	rqos = &blkiolat->rqos;
-	rqos->id = RQ_QOS_CGROUP;
+	rqos->id = RQ_QOS_LATENCY;
 	rqos->ops = &blkcg_iolatency_ops;
 	rqos->q = q;
 
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index e15b6907b76d..5f8b75826a98 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -14,7 +14,7 @@ struct blk_mq_debugfs_attr;
 
 enum rq_qos_id {
 	RQ_QOS_WBT,
-	RQ_QOS_CGROUP,
+	RQ_QOS_LATENCY,
 };
 
 struct rq_wait {
@@ -74,7 +74,7 @@ static inline struct rq_qos *wbt_rq_qos(struct request_queue *q)
 
 static inline struct rq_qos *blkcg_rq_qos(struct request_queue *q)
 {
-	return rq_qos_id(q, RQ_QOS_CGROUP);
+	return rq_qos_id(q, RQ_QOS_LATENCY);
 }
 
 static inline const char *rq_qos_id_to_name(enum rq_qos_id id)
@@ -82,8 +82,8 @@ static inline const char *rq_qos_id_to_name(enum rq_qos_id id)
 	switch (id) {
 	case RQ_QOS_WBT:
 		return "wbt";
-	case RQ_QOS_CGROUP:
-		return "cgroup";
+	case RQ_QOS_LATENCY:
+		return "latency";
 	}
 	return "unknown";
 }
-- 
2.17.1


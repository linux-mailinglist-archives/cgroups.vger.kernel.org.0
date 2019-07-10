Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4DA964DC4
	for <lists+cgroups@lfdr.de>; Wed, 10 Jul 2019 22:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfGJUvu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 Jul 2019 16:51:50 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38432 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbfGJUvu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 10 Jul 2019 16:51:50 -0400
Received: by mail-pl1-f193.google.com with SMTP id az7so1808591plb.5;
        Wed, 10 Jul 2019 13:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=71XE+8ODJ03XxqSz3E0bDacJC1DNJ713F4ArNQsk6XQ=;
        b=fJlw/q4EOSE55lGptT4ILP5eJqRMlwjvlHm9Lnxq8A2H57Dy2l+Biv0Rm7T7ppE86l
         U/pNVuyjMDYDNARByFr8OwL8b6b4TXfi8qg1zkWFjfOpfxMGWsHvPyMTGR8OSVVQZEXR
         QutYp7g/UT1nZ+ypt+AGGMN1jZGEUM1qfBfbYtIC7svhj/u11DvezJ/S60rA+kO6YMjp
         hYjekUxEsLJ6zvXHF9XxkhRfJzxyJiggwIs68l3zOz57M0T5a3EZzPh4M6U9G2Ravcj1
         KyiMOx2Y2buYwOuYLWRzxUPEgbnPa7NkAttz5RNnburL8sViDB5aPfA2TYECeVfZycqM
         1EGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=71XE+8ODJ03XxqSz3E0bDacJC1DNJ713F4ArNQsk6XQ=;
        b=gLe2gL9fpBTQq+Byy8JEntS7MuhYNXyeEFVA4sK6JzlJSDPXCuNYE623NQd+3Gvu/p
         fw+cyL7lJ0u3LIko23g8zlGLsIz71guX1bkkqNSPkEBtMn7hLlq2SYRc2rvkmddaHIAD
         RsHQ6AFAeOQXtHobrvlotiesu5DXWyR4zad3vd5WJDqiMqvFGLgv0AtBjlmdoGe6H6Hz
         D6SrD1uf6hwoBNi7IRVK7artbE43lm8hBNd/BamW/6v7Kj08N6af7F47mDVlNQO0t3Ki
         +8vKYbGKk3SLM1GW53FsHwmgZ+FKevL/Djnn9Glu/euCzpIYpO69JYTdzZx3gATqDqCb
         xrWg==
X-Gm-Message-State: APjAAAW0MUTGby10kEi9pVXKXxDBG698vjucOzjUGdH+o+JdFV+BNIWJ
        pyT3HG10LL04UjgtbFZvPgY=
X-Google-Smtp-Source: APXvYqyyT8NPjvfDYiMOHhTawoZe5pnxMdFhqS684M0VRso4/A0+uDXC6HCF5RQ8Q3SH1XObmDrYZw==
X-Received: by 2002:a17:902:23:: with SMTP id 32mr275929pla.34.1562791909278;
        Wed, 10 Jul 2019 13:51:49 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:2bbe])
        by smtp.gmail.com with ESMTPSA id x14sm4312729pfq.158.2019.07.10.13.51.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 13:51:48 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, newella@fb.com, clm@fb.com, josef@toxicpanda.com,
        dennisz@fb.com, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 06/10] blkcg: s/RQ_QOS_CGROUP/RQ_QOS_LATENCY/
Date:   Wed, 10 Jul 2019 13:51:24 -0700
Message-Id: <20190710205128.1316483-7-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190710205128.1316483-1-tj@kernel.org>
References: <20190710205128.1316483-1-tj@kernel.org>
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
index e613f89b37d3..5c53adbea3fa 100644
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


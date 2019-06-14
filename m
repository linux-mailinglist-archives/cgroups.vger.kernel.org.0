Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBF545184
	for <lists+cgroups@lfdr.de>; Fri, 14 Jun 2019 03:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfFNB4w (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Jun 2019 21:56:52 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44452 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfFNB4u (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Jun 2019 21:56:50 -0400
Received: by mail-pl1-f193.google.com with SMTP id t7so294053plr.11;
        Thu, 13 Jun 2019 18:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gqosCdj9OpU/EXk2GpDgDRqe9bikXWYuASzuXE6aksc=;
        b=LZRBEftl8pHb3JlVw9EXTNiKB32j5ZIGY5yrb5L3XZS8fYdZOYMA9L1fa6fKtN7CVD
         /OPdNZ54hpy/FZhAvt7lAOwiHP6WW+0zKCN4HrpwW/+L9Bi83LwphSV91l0nYM/5JGeT
         iaE4giJW5buF1sDUCez1A1nGTmW0O7XLQH0yHmq+oKa+MgHS8yf1Uypncw3vl7RDPDxT
         d3TQjac2zPh3jHYjbasqQoc8FXZ8+rtvpEuvMfDMubSCwKurO/1VXrR3GtHmZXmsXhc6
         SX7k5nOA5Vpsl60FqlXqDeE5J9wO+vcpoNkEenDQSvz/5MKuN/osaOTCo2JEhd5suq4P
         17Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=gqosCdj9OpU/EXk2GpDgDRqe9bikXWYuASzuXE6aksc=;
        b=cRUdFS9AGOyUd1uk5TpfLFBD23FF5ysWOCC44RepQP+w9xXqzma5gKllFx253GSvSj
         +oejmiVPLl0qhob/5w51+r0pgnX5UVHoKk08ZzPBdcDr7mXJGjndtK3jyRFoHn6wahYg
         sPglGB/08pPXxxxK3bm0nFRV2DibSPVe+gD3NZPOcLeU/OKCxyJpuQOV7ezi+zKi3Oo4
         jO4mPys47vZVizwoUwaEFp5Ra0vYaFVWpm7BSnz2nNZkXv0isL2sYafOG0nVQZPUSo+M
         rSPqqF7VyRFO8fQQ18L1Dm9i+xphABNROl5UdDbfmmlwK4sn7xfHbMNabswHsgooomoG
         vZhA==
X-Gm-Message-State: APjAAAV5gCCB+9bqs+LdSf42n7EzcEz8Iq96n6HmHHxzU83LBbtwP2JE
        5nfWsFtPtAxUrocRppGSGE2IlFF6
X-Google-Smtp-Source: APXvYqy6vtdTSyddQoCMEwb+44JT+fMq1+X/sUS5AKcqdBHjD1n6xxD13smG9KatJMHGroyxClffMQ==
X-Received: by 2002:a17:902:76c6:: with SMTP id j6mr65836349plt.263.1560477409705;
        Thu, 13 Jun 2019 18:56:49 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:9d14])
        by smtp.gmail.com with ESMTPSA id 14sm1023541pgp.37.2019.06.13.18.56.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 18:56:48 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, newella@fb.com, clm@fb.com, josef@toxicpanda.com,
        dennisz@fb.com, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: [PATCH 06/10] blkcg: s/RQ_QOS_CGROUP/RQ_QOS_LATENCY/
Date:   Thu, 13 Jun 2019 18:56:16 -0700
Message-Id: <20190614015620.1587672-7-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614015620.1587672-1-tj@kernel.org>
References: <20190614015620.1587672-1-tj@kernel.org>
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
index fa47a6485725..7d1dbe757063 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -744,7 +744,7 @@ int blk_iolatency_init(struct request_queue *q)
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


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4589E330CEB
	for <lists+cgroups@lfdr.de>; Mon,  8 Mar 2021 13:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhCHMAk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 8 Mar 2021 07:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbhCHMA3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 8 Mar 2021 07:00:29 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646B1C06174A;
        Mon,  8 Mar 2021 04:00:29 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id q204so6905578pfq.10;
        Mon, 08 Mar 2021 04:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=HYuShFUBkBZ/uay9hk4TebKYyzXODNV6658Oa603tVk=;
        b=m8HMdOdavHVDaiPc4cVKb2oSWRo5jyYxaGWzgE7lwQGf32xtFlT4MDVIG4KJzAXyxx
         SB6hQMvOZdvz/q1KqEpQeUDuDTxXZsOreoWBruOJA85v5rRiuaHdwa3vWVuf4FcBrfxM
         RRMKw/skzXDc4TPr18AQ8RnX1zaWM2mqXBd1XQYyMQHi+c1hbUvayaUGAAIhThjU1r4b
         6quKMSFEWxGWLl2tpX6IpRu42bdEDEiWxPvK32bGKMkkLltq3RiGAenPqPCdK7IOrMKV
         MMft//v3EtBcYezXZpEyCwrCn7Ai+uK1hUjfvNhGz7vypdWIj5pb+3AJ5KNcrUffhFcU
         0LMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=HYuShFUBkBZ/uay9hk4TebKYyzXODNV6658Oa603tVk=;
        b=X0MyYTGGKSaurdHGBSagjlAKUdwHZ7XEb2CFeXokYkdtb/jDVORTVBphlKPc/gfpyK
         E5XpMxI1goLKC6Y5wna1om/bFw+an0tobX8PKqnVNZbUY2HrCBM6UsBIVd9/IrL9Ql7+
         p1bSUjRehwiahc1gOmqqVj/WpYQd6z51nC0Wvv2pIZ+6w5S6h+0cGNefrJyzfUCGaJgq
         3hMJSCPr8DH1nGURGRiDEEKGIu/zQaNMs0/yzk/+MgGiegqSPrO7fnSDfzYBc3d3dmU/
         1oYtKdJV/qlEk4obxeDkQYOeO/SuFYBBnCUWGpDV+jdCUWrygqB2NNs2nJuOqGZdALHg
         DPJw==
X-Gm-Message-State: AOAM530FMBhOrr003S7HHj3ukHNmL0tcsqdoZ92b8+D+g5xcjDKwis9Z
        uihTYwY7Aa/go8RBqRnVA1E=
X-Google-Smtp-Source: ABdhPJxHOZ/j4ijl7txVvb2sc/4W0MItizg0gbyAUU9oZoLh43wxD0tvrk/+bOYEHFuqTh6zApW61Q==
X-Received: by 2002:a65:5281:: with SMTP id y1mr9194597pgp.12.1615204829039;
        Mon, 08 Mar 2021 04:00:29 -0800 (PST)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id mp19sm22570855pjb.2.2021.03.08.04.00.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Mar 2021 04:00:28 -0800 (PST)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/8] bfq: keep the minimun bandwidth for be_class
Date:   Mon,  8 Mar 2021 20:00:16 +0800
Message-Id: <60007c99598dc26b0e0c495120d829f96ea38dd2.1615203034.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1615203034.git.brookxu@tencent.com>
References: <cover.1615203034.git.brookxu@tencent.com>
In-Reply-To: <cover.1615203034.git.brookxu@tencent.com>
References: <cover.1615203034.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

From: Chunguang Xu <brookxu@tencent.com>

rt_class will preempt other classes, which may cause other
classes to starve to death. At present, idle_class has
alleviated the starvation problem through the minimum
bandwidth mechanism. Similarly, we should do the same for
be_class.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/bfq-iosched.c |  2 +-
 block/bfq-iosched.h |  9 +++++----
 block/bfq-wf2q.c    | 46 ++++++++++++++++++++++++++++-----------------
 3 files changed, 35 insertions(+), 22 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index ea9d7f6f4e3d..b639cdbb4192 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6539,7 +6539,7 @@ static void bfq_init_root_group(struct bfq_group *root_group,
 	root_group->rq_pos_tree = RB_ROOT;
 	for (i = 0; i < BFQ_IOPRIO_CLASSES; i++)
 		root_group->sched_data.service_tree[i] = BFQ_SERVICE_TREE_INIT;
-	root_group->sched_data.bfq_class_idle_last_service = jiffies;
+	root_group->sched_data.class_timeout_last_check = jiffies;
 }
 
 static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index a6f98e9e14b5..2fe7456aa7bc 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -13,7 +13,7 @@
 #include "blk-cgroup-rwstat.h"
 
 #define BFQ_IOPRIO_CLASSES	3
-#define BFQ_CL_IDLE_TIMEOUT	(HZ/5)
+#define BFQ_CLASS_TIMEOUT	(HZ/5)
 
 #define BFQ_MIN_WEIGHT			1
 #define BFQ_MAX_WEIGHT			1000
@@ -97,9 +97,10 @@ struct bfq_sched_data {
 	struct bfq_entity *next_in_service;
 	/* array of service trees, one per ioprio_class */
 	struct bfq_service_tree service_tree[BFQ_IOPRIO_CLASSES];
-	/* last time CLASS_IDLE was served */
-	unsigned long bfq_class_idle_last_service;
-
+	/* last time the class timeout was checked */
+	unsigned long class_timeout_last_check;
+	/* the position to start class timeout check next time */
+	unsigned int next_class_index;
 };
 
 /**
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 5ff0028920a2..0d10eb3ed555 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -1435,6 +1435,34 @@ __bfq_lookup_next_entity(struct bfq_service_tree *st, bool in_service)
 	return entity;
 }
 
+static int bfq_select_next_class(struct bfq_sched_data *sd)
+{
+	struct bfq_service_tree *st = sd->service_tree;
+	int i, class_idx, next_class = 0;
+	unsigned long last_check;
+
+	/*
+	 * we needed to guarantee a minimum bandwidth for each class (if
+	 * there is some active entity in this class). This should also
+	 * mitigate priority-inversion problems in case a low priority
+	 * task is holding file system resources.
+	 */
+	for (i = 0; i < BFQ_IOPRIO_CLASSES; i++) {
+		class_idx = (sd->next_class_index + i) % BFQ_IOPRIO_CLASSES;
+		last_check = sd->class_timeout_last_check;
+		if (time_is_before_jiffies(last_check + BFQ_CLASS_TIMEOUT)) {
+			sd->class_timeout_last_check = jiffies;
+			if (!RB_EMPTY_ROOT(&(st + class_idx)->active)) {
+				next_class = class_idx++;
+				class_idx %= BFQ_IOPRIO_CLASSES;
+				sd->next_class_index = class_idx;
+				break;
+			}
+		}
+	}
+	return next_class;
+}
+
 /**
  * bfq_lookup_next_entity - return the first eligible entity in @sd.
  * @sd: the sched_data.
@@ -1448,24 +1476,8 @@ static struct bfq_entity *bfq_lookup_next_entity(struct bfq_sched_data *sd,
 						 bool expiration)
 {
 	struct bfq_service_tree *st = sd->service_tree;
-	struct bfq_service_tree *idle_class_st = st + (BFQ_IOPRIO_CLASSES - 1);
 	struct bfq_entity *entity = NULL;
-	int class_idx = 0;
-
-	/*
-	 * Choose from idle class, if needed to guarantee a minimum
-	 * bandwidth to this class (and if there is some active entity
-	 * in idle class). This should also mitigate
-	 * priority-inversion problems in case a low priority task is
-	 * holding file system resources.
-	 */
-	if (time_is_before_jiffies(sd->bfq_class_idle_last_service +
-				   BFQ_CL_IDLE_TIMEOUT)) {
-		if (!RB_EMPTY_ROOT(&idle_class_st->active))
-			class_idx = BFQ_IOPRIO_CLASSES - 1;
-		/* About to be served if backlogged, or not yet backlogged */
-		sd->bfq_class_idle_last_service = jiffies;
-	}
+	int class_idx = bfq_select_next_class(sd);
 
 	/*
 	 * Find the next entity to serve for the highest-priority
-- 
2.30.0


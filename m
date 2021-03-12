Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD982338B26
	for <lists+cgroups@lfdr.de>; Fri, 12 Mar 2021 12:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbhCLLJV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Mar 2021 06:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbhCLLJB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 Mar 2021 06:09:01 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED06CC061574;
        Fri, 12 Mar 2021 03:09:00 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id r16so301910pfh.10;
        Fri, 12 Mar 2021 03:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=j0cc3FhyIkik1ZqjcQtP+JY263bu0AJPOx8K4+YzkWU=;
        b=PESSmFeV+dR08oaB+9e064Or+JEAcMV+WuNyyP/qM/X9qGtme4jCGFu7TJs4o2BSR2
         hKo5/U3IqDyD8di7CTWm/jxlKBsrlFAw6aTed3PLBO3fwsWDYWeJajNruMRQYe5YGvIu
         cuDkXz2Mb6X2Wn1cU4PQqT02SEpi5L3LpSbA/FmHAvEuSU0FcJ/GLURD1/14VzhZ13H8
         0CeVSNYx8g+B7dcz1rlcKzova4YJNiGLIFdgNfb8K2WzY3m4hblvlVqfM24F7n4yP8gz
         Bkn2m9JU4Kkhiw8DxBfuhWR8iGPf9G5b5TfPrWmbDFPWiI0B9cnhh1s1rcNYnPC3hqEv
         YyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=j0cc3FhyIkik1ZqjcQtP+JY263bu0AJPOx8K4+YzkWU=;
        b=qS80So8pE0B8kYJE72MjarYUqm1Jh74Q8ZJSHJEDJY0bFOsiX3jE5O9Ni6An7sGoVK
         YJOJoCId3gQmYpZS+A/coavMrgqQToBfD4u6hMNtlHD4iRK5/aYvdA2oA1ZoHlgmQqfU
         pNmKYxd4lAoKQWjr+1tJcF94TJgtfkhqYf/F18jWUWm2yzBceaEwH1IqVe3CbbGr5E5o
         cCjdI/MTd32yrJe3qSgwy7QKXqeHi0qpE0DKYL8ZII3U4sHTLvWxOhDHv7qZSBJEJ8Vy
         mfAlslIHxraZygH2kNC9zmpaKaqEdYdmOXATi6TPOZJGIW6NGA2o/tJesLl25SuB2hpW
         n6fA==
X-Gm-Message-State: AOAM531YUM2E/XaXavCBaO4W2K81QQ+7Lb4GyainCxkDuhzSgnaSebkA
        9geZxCDpLWaiOYFJp5sQmDQ=
X-Google-Smtp-Source: ABdhPJzU5XQyUYRFkKS9vKeaHY21ODg3DXsk5Q9T9gLwei5z5g2CuaFZEJ6++fDzOaB3B+0a9j8vag==
X-Received: by 2002:aa7:9a89:0:b029:200:1eed:1388 with SMTP id w9-20020aa79a890000b02902001eed1388mr5657428pfi.79.1615547340577;
        Fri, 12 Mar 2021 03:09:00 -0800 (PST)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id t5sm4942181pgl.89.2021.03.12.03.08.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Mar 2021 03:08:59 -0800 (PST)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 05/11] bfq: keep the minimun bandwidth for be_class
Date:   Fri, 12 Mar 2021 19:08:39 +0800
Message-Id: <189426afb7e3d2fa4e0c0df3c9037b2ed51f0fe5.1615527324.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1615517202.git.brookxu@tencent.com>
References: <cover.1615517202.git.brookxu@tencent.com>
In-Reply-To: <cover.1615527324.git.brookxu@tencent.com>
References: <cover.1615527324.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

rt_class will preempt other classes, which may cause other
classes to starve to death. At present, idle_class has
alleviated the starvation problem through the minimum
bandwidth mechanism. Similarly, we should do the same for
be_class.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/bfq-iosched.c |  6 +++--
 block/bfq-iosched.h | 11 ++++++---
 block/bfq-wf2q.c    | 59 ++++++++++++++++++++++++++++++++-------------
 3 files changed, 53 insertions(+), 23 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 91e903f1e550..ab00b664348c 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6542,9 +6542,11 @@ static void bfq_init_root_group(struct bfq_group *root_group,
 	root_group->bfqd = bfqd;
 #endif
 	root_group->rq_pos_tree = RB_ROOT;
-	for (i = 0; i < BFQ_IOPRIO_CLASSES; i++)
+	for (i = 0; i < BFQ_IOPRIO_CLASSES; i++) {
 		root_group->sched_data.service_tree[i] = BFQ_SERVICE_TREE_INIT;
-	root_group->sched_data.bfq_class_idle_last_service = jiffies;
+		root_group->sched_data.bfq_class_last_service[i] = jiffies;
+	}
+	root_group->sched_data.class_timeout_last_check = jiffies;
 }
 
 static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 3416a75f47da..de7301664ad3 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -13,7 +13,7 @@
 #include "blk-cgroup-rwstat.h"
 
 #define BFQ_IOPRIO_CLASSES	3
-#define BFQ_CL_IDLE_TIMEOUT	(HZ/5)
+#define BFQ_CLASS_TIMEOUT	(HZ/5)
 
 #define BFQ_MIN_WEIGHT			1
 #define BFQ_MAX_WEIGHT			1000
@@ -97,9 +97,12 @@ struct bfq_sched_data {
 	struct bfq_entity *next_in_service;
 	/* array of service trees, one per ioprio_class */
 	struct bfq_service_tree service_tree[BFQ_IOPRIO_CLASSES];
-	/* last time CLASS_IDLE was served */
-	unsigned long bfq_class_idle_last_service;
-
+	/* last time the class was served */
+	unsigned long bfq_class_last_service[BFQ_IOPRIO_CLASSES];
+	/* last time class timeout was checked */
+	unsigned long class_timeout_last_check;
+	/* next index to check class timeout */
+	unsigned int next_class_index;
 };
 
 /**
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 7405be960a92..0ac35fd4f2ab 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -1188,6 +1188,7 @@ bool __bfq_deactivate_entity(struct bfq_entity *entity, bool ins_into_idle_tree)
 {
 	struct bfq_sched_data *sd = entity->sched_data;
 	struct bfq_service_tree *st;
+	int idx = bfq_class_idx(entity);
 	bool is_in_service;
 
 	if (!entity->on_st_or_in_serv) /*
@@ -1227,6 +1228,7 @@ bool __bfq_deactivate_entity(struct bfq_entity *entity, bool ins_into_idle_tree)
 	else
 		bfq_idle_insert(st, entity);
 
+	sd->bfq_class_last_service[idx] = jiffies;
 	return true;
 }
 
@@ -1455,6 +1457,45 @@ __bfq_lookup_next_entity(struct bfq_service_tree *st, bool in_service)
 	return entity;
 }
 
+static int bfq_select_next_class(struct bfq_sched_data *sd)
+{
+	struct bfq_service_tree *st = sd->service_tree;
+	unsigned long last_check, last_serve;
+	int i, class_idx, next_class = 0;
+	bool found = false;
+
+	/*
+	 * we needed to guarantee a minimum bandwidth for each class (if
+	 * there is some active entity in this class). This should also
+	 * mitigate priority-inversion problems in case a low priority
+	 * task is holding file system resources.
+	 */
+	last_check = sd->class_timeout_last_check;
+	if (time_is_after_jiffies(last_check + BFQ_CLASS_TIMEOUT))
+		return next_class;
+
+	sd->class_timeout_last_check = jiffies;
+	for (i = 0; i < BFQ_IOPRIO_CLASSES; i++) {
+		class_idx = (sd->next_class_index + i) % BFQ_IOPRIO_CLASSES;
+		last_serve = sd->bfq_class_last_service[class_idx];
+
+		if (time_is_after_jiffies(last_serve + BFQ_CLASS_TIMEOUT))
+			continue;
+
+		if (!RB_EMPTY_ROOT(&(st + class_idx)->active)) {
+			if (found)
+				continue;
+
+			next_class = class_idx++;
+			class_idx %= BFQ_IOPRIO_CLASSES;
+			sd->next_class_index = class_idx;
+			found = true;
+		}
+		sd->bfq_class_last_service[class_idx] = jiffies;
+	}
+	return next_class;
+}
+
 /**
  * bfq_lookup_next_entity - return the first eligible entity in @sd.
  * @sd: the sched_data.
@@ -1468,24 +1509,8 @@ static struct bfq_entity *bfq_lookup_next_entity(struct bfq_sched_data *sd,
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


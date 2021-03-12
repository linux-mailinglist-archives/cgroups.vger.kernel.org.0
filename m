Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB19338B1E
	for <lists+cgroups@lfdr.de>; Fri, 12 Mar 2021 12:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbhCLLJT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Mar 2021 06:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234056AbhCLLIx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 Mar 2021 06:08:53 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAE6C061574;
        Fri, 12 Mar 2021 03:08:53 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id w34so14569336pga.8;
        Fri, 12 Mar 2021 03:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=T14uQktm+Sg7+gpVLlmca1QlgsLzohgO//zswTvqmzc=;
        b=qQDIP426SYd0JFMuLOjcjCvM4b7lir3T36QLUC/aPgXpKn0w4+ZiPKbzzaDVqbdx7S
         N2ig54PNAeA0G8Jal9Yrlp0BoyTf1wIDq6n51EfRR8jxA1nf6sCkh8/0ThlPy2gFMRt5
         EpwK+5oted7MknJGGmQI6Qx/xhmpdUVaPJIcdvtjMzaqLTdoX0+Y8LvH6VPnz764xmIr
         FCWG3oLX0ehAyAi0Vbl6tvCLEQHGgI9KF997kPOyyyluYVldm6i4l8UMT2s25LNfHEXe
         812ijlTGrWs3LvuPq6dOa24ceKqExR4JAK0WzFHETP8xN2NUjjtc5xjb6pHJTDXy1VWf
         pUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=T14uQktm+Sg7+gpVLlmca1QlgsLzohgO//zswTvqmzc=;
        b=JsVdS1BDvfVnO12XQgSUNkPQODBmDUj8QfUR0rbS+ccGBn/65HR2UncMiBdKWJRoLH
         9IS+lGIRM2E3oCT4RINvLzVjX4bN5YdgKfvSt2BGkgJjhdK3+lhl/QuTkBT5dgqdxLQm
         YafAWlquMpOhk9WRDlwC4fAXtvKipqd0g8juU0k5j00R68upnhb4pd7YRZQgkXFRSuAl
         a2cM4yEHQftD5vhfy6nCPW7cTp0rp52iC9Dg5FxHjpE+zYVw/NFdFzSOnOfMsWyYGOCq
         F9YJLiFSZZB9553jQrkiiVHOprr2AEFdFvju7DJJsVu0N6LD0LLwTXw//q9MUrB+Rghe
         UWcQ==
X-Gm-Message-State: AOAM530+k0bnKdlwnRyvkstE8OeYaSwiPZL/t66ozVRtGSETkr6cTj8n
        RyISTxrG9eJgl1zaNQYT7txJIGsAh1hvMg==
X-Google-Smtp-Source: ABdhPJxGJ91CMWXuEolUAbRKeimsUEu0lDGZMW8Y6/+awVo9HLGTSAc4MOY9yKwM8lgmK/iOOHXPNw==
X-Received: by 2002:a63:3182:: with SMTP id x124mr3570255pgx.317.1615547333186;
        Fri, 12 Mar 2021 03:08:53 -0800 (PST)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id t5sm4942181pgl.89.2021.03.12.03.08.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Mar 2021 03:08:52 -0800 (PST)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 02/11] bfq: convert the type of bfq_group.bfqd to bfq_data*
Date:   Fri, 12 Mar 2021 19:08:36 +0800
Message-Id: <856a594d70b9a43b911285ff192d892d664001b0.1615527324.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1615517202.git.brookxu@tencent.com>
References: <cover.1615517202.git.brookxu@tencent.com>
In-Reply-To: <cover.1615527324.git.brookxu@tencent.com>
References: <cover.1615527324.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Setting bfq_group.bfqd to void* type does not seem to make much sense.
This will cause unnecessary type conversion. Perhaps it would be better
to change it to bfq_data* type.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/bfq-cgroup.c  | 2 +-
 block/bfq-iosched.h | 2 +-
 block/bfq-wf2q.c    | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index a5f544acaa61..50d06c760194 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -224,7 +224,7 @@ void bfqg_stats_update_io_add(struct bfq_group *bfqg, struct bfq_queue *bfqq,
 {
 	blkg_rwstat_add(&bfqg->stats.queued, op, 1);
 	bfqg_stats_end_empty_time(&bfqg->stats);
-	if (!(bfqq == ((struct bfq_data *)bfqg->bfqd)->in_service_queue))
+	if (!(bfqq == bfqg->bfqd->in_service_queue))
 		bfqg_stats_set_start_group_wait_time(bfqg, bfqq_group(bfqq));
 }
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index a6f98e9e14b5..28d85903cf66 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -914,7 +914,7 @@ struct bfq_group {
 	struct bfq_entity entity;
 	struct bfq_sched_data sched_data;
 
-	void *bfqd;
+	struct bfq_data *bfqd;
 
 	struct bfq_queue *async_bfqq[2][IOPRIO_BE_NR];
 	struct bfq_queue *async_idle_bfqq;
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 5ff0028920a2..276f225f9c6e 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -498,7 +498,7 @@ static void bfq_active_insert(struct bfq_service_tree *st,
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
 	sd = entity->sched_data;
 	bfqg = container_of(sd, struct bfq_group, sched_data);
-	bfqd = (struct bfq_data *)bfqg->bfqd;
+	bfqd = bfqg->bfqd;
 #endif
 	if (bfqq)
 		list_add(&bfqq->bfqq_list, &bfqq->bfqd->active_list);
@@ -597,7 +597,7 @@ static void bfq_active_extract(struct bfq_service_tree *st,
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
 	sd = entity->sched_data;
 	bfqg = container_of(sd, struct bfq_group, sched_data);
-	bfqd = (struct bfq_data *)bfqg->bfqd;
+	bfqd = bfqg->bfqd;
 #endif
 	if (bfqq)
 		list_del(&bfqq->bfqq_list);
@@ -743,7 +743,7 @@ __bfq_entity_update_weight_prio(struct bfq_service_tree *old_st,
 		else {
 			sd = entity->my_sched_data;
 			bfqg = container_of(sd, struct bfq_group, sched_data);
-			bfqd = (struct bfq_data *)bfqg->bfqd;
+			bfqd = bfqg->bfqd;
 		}
 #endif
 
-- 
2.30.0


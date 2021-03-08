Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153BF330CF3
	for <lists+cgroups@lfdr.de>; Mon,  8 Mar 2021 13:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhCHMAm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 8 Mar 2021 07:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbhCHMAe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 8 Mar 2021 07:00:34 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEC5C06174A;
        Mon,  8 Mar 2021 04:00:34 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id b15so2897624pjb.0;
        Mon, 08 Mar 2021 04:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=gAfbhvGkPzPG0rraXenDrWcyqUN3oR0H7AbaTCt/P0M=;
        b=MhJxkrwtVPHN3jfh+JdW9vwPDs3s/SFzk1Ui4YFRSc8ZzPKHHdKlDh2ewhoOzvn7mL
         VYrhkmlvYPzF9zZJFInAr0qHaOLWm5ucixaLCRdwIevWkHM7dCj5xYhbLrshg99V44h8
         oeTyFI+q8JdnzqcYzJ1NtVlh5YHkkJGn0HuTFC9IBKHSYZj84dCwGIbxQ7/4+j9MOy6n
         RuzWLYaROtcG+Fx4v03FZchiNMH8VFbDXiwhNQJnzIuyO9LBaf8OboxQpt5Erau32d7j
         dAaBicVQGvcIwbKN4wKr1sOC3D5sl1X1Jqw8gefLyITKGW7WDkeh3jrM5mgmQjuMPH3Q
         ndIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=gAfbhvGkPzPG0rraXenDrWcyqUN3oR0H7AbaTCt/P0M=;
        b=Ach5mqih3Cli4UPKEw5OyuHl3UUwhkHYYUTkQJunkR65LLe+UsLX+Opm+Qe8OWvrn9
         5e3p3xxkuWTZBMoMe6I1pG7ta6utX7WEdfx0eE/NSVD2fJUF2ZN/DcWgloj+TaPXc+DS
         dVFRtP6EJBRJFkTWBQJmADE+tygkaef0EA3gnhouQUybvZs74443AQR+Zl2qLzPUPApE
         UpZ+CJdQsCpnHiK2Hz1KyzkZAPfBub8/4FCBKw2/cx/8Fizefhcx2R7JblPLqS0hVrCW
         fJDK0nFWq/MnN5N60bDfarXOxj2UqiQmkHapXyHwcUSxvgJegKgwhE0aOrY96H65t6dq
         1nYQ==
X-Gm-Message-State: AOAM531yebJahxSbJshZnoimTDdT52ZyJOyroq78O1bTaFNUET8fyS9h
        wzs2F9BTSl5cEPgRUIOJ9Ck=
X-Google-Smtp-Source: ABdhPJzK7h0jtzWWVzT2PZYIVwMwYkpEUeyLlAHAKHtozaJSbmklZ39vIITyWsAp0+6qXkQKPuCA9w==
X-Received: by 2002:a17:902:9783:b029:e5:bfa2:dc24 with SMTP id q3-20020a1709029783b02900e5bfa2dc24mr20793675plp.70.1615204833747;
        Mon, 08 Mar 2021 04:00:33 -0800 (PST)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id mp19sm22570855pjb.2.2021.03.08.04.00.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Mar 2021 04:00:33 -0800 (PST)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 6/8] bfq: convert the type of bfq_group.bfqd to bfq_data*
Date:   Mon,  8 Mar 2021 20:00:19 +0800
Message-Id: <f016f4d41815c12a8053ef938bb0e210e7c745bf.1615203034.git.brookxu@tencent.com>
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
index 0b0a3514a5d2..ab4bc410e635 100644
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
index d5c05d5f9714..ab44b10ece1d 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -916,7 +916,7 @@ struct bfq_group {
 	struct bfq_entity entity;
 	struct bfq_sched_data sched_data;
 
-	void *bfqd;
+	struct bfq_data *bfqd;
 
 	struct bfq_queue *async_bfqq[2][IOPRIO_BE_NR];
 	struct bfq_queue *async_idle_bfqq;
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 01172202b076..850a8e2f0bda 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -507,7 +507,7 @@ static void bfq_active_insert(struct bfq_service_tree *st,
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
 	sd = entity->sched_data;
 	bfqg = container_of(sd, struct bfq_group, sched_data);
-	bfqd = (struct bfq_data *)bfqg->bfqd;
+	bfqd = bfqg->bfqd;
 #endif
 	if (bfqq)
 		list_add(&bfqq->bfqq_list, &bfqq->bfqd->active_list);
@@ -606,7 +606,7 @@ static void bfq_active_extract(struct bfq_service_tree *st,
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
 	sd = entity->sched_data;
 	bfqg = container_of(sd, struct bfq_group, sched_data);
-	bfqd = (struct bfq_data *)bfqg->bfqd;
+	bfqd = bfqg->bfqd;
 #endif
 	if (bfqq)
 		list_del(&bfqq->bfqq_list);
@@ -752,7 +752,7 @@ __bfq_entity_update_weight_prio(struct bfq_service_tree *old_st,
 		else {
 			sd = entity->my_sched_data;
 			bfqg = container_of(sd, struct bfq_group, sched_data);
-			bfqd = (struct bfq_data *)bfqg->bfqd;
+			bfqd = bfqg->bfqd;
 		}
 #endif
 
-- 
2.30.0


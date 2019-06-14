Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1F4B4516F
	for <lists+cgroups@lfdr.de>; Fri, 14 Jun 2019 03:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfFNB4f (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Jun 2019 21:56:35 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34506 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfFNB4f (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Jun 2019 21:56:35 -0400
Received: by mail-pg1-f194.google.com with SMTP id p10so585246pgn.1;
        Thu, 13 Jun 2019 18:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UaPHH8JDcGKak+gHjtRMrmN2MEG5XRu5KmkEzKYucHQ=;
        b=t5jBUJHoeAqr/+0FT28ieRk7BwOPRcQJIIHyY8hnkwoy4p6BeHZ/XXHF84KtBcs1/K
         SsHPTWojNUd6CFEUWeTWQlMBzAQpn2kEJYrABsGfmCjkXmj8kgU1WXz//P2RaQvR5zC6
         B729XnqqKKURM/dl8yGHE5cN0PFM/zAnq8NFPgtM1L7fWi+tRdrnU+RjGSs3OCBN020g
         dlwGVqMj7EWrRiPJe/EQzDC2nNOofgVgw7q3g9Xh5bUWGUsj0sFrUhiZ6YwflJkVS0Rq
         GwrMmZGsr0FkTPWg+zQDLESHWd7dg7oht+nA96i83z1rkgCyFinFemJyFz1/P2oeMHpt
         xTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=UaPHH8JDcGKak+gHjtRMrmN2MEG5XRu5KmkEzKYucHQ=;
        b=tFacttHehnC20G64545hh/j0amg/5VieO4yFBKlo1QQFFiqvT/GsZ7ZSYkVFL64o0K
         c3yHCywzG5W+KmADfGFtp88VdpBOq7I3wlJJ/OnA8sCtsGtgnFdxM9Z6mFnlxVpd56+7
         4h1XWK9DEWO5pJ5429ETZOq7LZwjkUJSMFqWoggYLCLBUKvZAbI0fFsyi3AhF57P4zBv
         PLpRN2vO9uT9l5Ojl/TF/xHdVb38m0a9cd2NCJUivi/LAirC0yhg9gmHxW+VwGA9+E2R
         4so75WrOfMhZbMnFtZ/EdWoqWpthaW6VycFOiwgZUk4FxSkSpnG7YPptHR5wBwESlz/G
         wLEQ==
X-Gm-Message-State: APjAAAV4MBaF3GCPHQL0jKd9ef4zuJLvK9hvniYqcSRDmtLiI+u/xB4l
        2Pe7kasfV65WMKKv1G5vP10=
X-Google-Smtp-Source: APXvYqwtGOqBXQnQFJmkFlYg+0lgGOoUS3b1muTMxOwt/PF7YKviJETAUCremB5U6OrsBX/7cN5k5w==
X-Received: by 2002:a63:d07:: with SMTP id c7mr4272088pgl.394.1560477394341;
        Thu, 13 Jun 2019 18:56:34 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:9d14])
        by smtp.gmail.com with ESMTPSA id k3sm970663pju.27.2019.06.13.18.56.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 18:56:33 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, newella@fb.com, clm@fb.com, josef@toxicpanda.com,
        dennisz@fb.com, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: [PATCH 01/10] blkcg: pass @q and @blkcg into blkcg_pol_alloc_pd_fn()
Date:   Thu, 13 Jun 2019 18:56:11 -0700
Message-Id: <20190614015620.1587672-2-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614015620.1587672-1-tj@kernel.org>
References: <20190614015620.1587672-1-tj@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Instead of @node, pass in @q and @blkcg so that the alloc function has
more context.  This doesn't cause any behavior change and will be used
by io.weight implementation.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/bfq-cgroup.c         | 5 +++--
 block/blk-cgroup.c         | 6 +++---
 block/blk-iolatency.c      | 6 ++++--
 block/blk-throttle.c       | 6 ++++--
 include/linux/blk-cgroup.h | 3 ++-
 5 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index b3796a40a61a..4193172ad20f 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -425,11 +425,12 @@ static void bfq_cpd_free(struct blkcg_policy_data *cpd)
 	kfree(cpd_to_bfqgd(cpd));
 }
 
-static struct blkg_policy_data *bfq_pd_alloc(gfp_t gfp, int node)
+static struct blkg_policy_data *bfq_pd_alloc(gfp_t gfp, struct request_queue *q,
+					     struct blkcg *blkcg)
 {
 	struct bfq_group *bfqg;
 
-	bfqg = kzalloc_node(sizeof(*bfqg), gfp, node);
+	bfqg = kzalloc_node(sizeof(*bfqg), gfp, q->node);
 	if (!bfqg)
 		return NULL;
 
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 238d5d2d0691..30d3a0fbccac 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -174,7 +174,7 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
 			continue;
 
 		/* alloc per-policy data and attach it to blkg */
-		pd = pol->pd_alloc_fn(gfp_mask, q->node);
+		pd = pol->pd_alloc_fn(gfp_mask, q, blkcg);
 		if (!pd)
 			goto err_free;
 
@@ -1405,7 +1405,7 @@ int blkcg_activate_policy(struct request_queue *q,
 		blk_mq_freeze_queue(q);
 pd_prealloc:
 	if (!pd_prealloc) {
-		pd_prealloc = pol->pd_alloc_fn(GFP_KERNEL, q->node);
+		pd_prealloc = pol->pd_alloc_fn(GFP_KERNEL, q, &blkcg_root);
 		if (!pd_prealloc) {
 			ret = -ENOMEM;
 			goto out_bypass_end;
@@ -1421,7 +1421,7 @@ int blkcg_activate_policy(struct request_queue *q,
 		if (blkg->pd[pol->plid])
 			continue;
 
-		pd = pol->pd_alloc_fn(GFP_NOWAIT | __GFP_NOWARN, q->node);
+		pd = pol->pd_alloc_fn(GFP_NOWAIT | __GFP_NOWARN, q, &blkcg_root);
 		if (!pd)
 			swap(pd, pd_prealloc);
 		if (!pd) {
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 17896bb3aaf2..fa47a6485725 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -950,11 +950,13 @@ static size_t iolatency_pd_stat(struct blkg_policy_data *pd, char *buf,
 }
 
 
-static struct blkg_policy_data *iolatency_pd_alloc(gfp_t gfp, int node)
+static struct blkg_policy_data *iolatency_pd_alloc(gfp_t gfp,
+						   struct request_queue *q,
+						   struct blkcg *blkcg)
 {
 	struct iolatency_grp *iolat;
 
-	iolat = kzalloc_node(sizeof(*iolat), gfp, node);
+	iolat = kzalloc_node(sizeof(*iolat), gfp, q->node);
 	if (!iolat)
 		return NULL;
 	iolat->stats = __alloc_percpu_gfp(sizeof(struct latency_stat),
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 9ea7c0ecad10..3bb69a17c4b3 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -478,12 +478,14 @@ static void throtl_service_queue_init(struct throtl_service_queue *sq)
 	timer_setup(&sq->pending_timer, throtl_pending_timer_fn, 0);
 }
 
-static struct blkg_policy_data *throtl_pd_alloc(gfp_t gfp, int node)
+static struct blkg_policy_data *throtl_pd_alloc(gfp_t gfp,
+						struct request_queue *q,
+						struct blkcg *blkcg)
 {
 	struct throtl_grp *tg;
 	int rw;
 
-	tg = kzalloc_node(sizeof(*tg), gfp, node);
+	tg = kzalloc_node(sizeof(*tg), gfp, q->node);
 	if (!tg)
 		return NULL;
 
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index ffb2f88e87c6..1ed27977f88f 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -151,7 +151,8 @@ typedef struct blkcg_policy_data *(blkcg_pol_alloc_cpd_fn)(gfp_t gfp);
 typedef void (blkcg_pol_init_cpd_fn)(struct blkcg_policy_data *cpd);
 typedef void (blkcg_pol_free_cpd_fn)(struct blkcg_policy_data *cpd);
 typedef void (blkcg_pol_bind_cpd_fn)(struct blkcg_policy_data *cpd);
-typedef struct blkg_policy_data *(blkcg_pol_alloc_pd_fn)(gfp_t gfp, int node);
+typedef struct blkg_policy_data *(blkcg_pol_alloc_pd_fn)(gfp_t gfp,
+				struct request_queue *q, struct blkcg *blkcg);
 typedef void (blkcg_pol_init_pd_fn)(struct blkg_policy_data *pd);
 typedef void (blkcg_pol_online_pd_fn)(struct blkg_policy_data *pd);
 typedef void (blkcg_pol_offline_pd_fn)(struct blkg_policy_data *pd);
-- 
2.17.1


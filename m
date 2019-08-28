Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBA5A0D45
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2019 00:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfH1WGK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Aug 2019 18:06:10 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35163 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfH1WGJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 28 Aug 2019 18:06:09 -0400
Received: by mail-qt1-f194.google.com with SMTP id u34so1420061qte.2;
        Wed, 28 Aug 2019 15:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E79NtAzOgIUAizJwIesUtiv2mCB5ZP/4rNwX4GMcwPI=;
        b=aYzG7U0qx200TAfF6SANRqpsqmzCpyPAG6ywyYSvuykYASu2JfqjduSvQDq0IbeRh/
         Qygo2r9DYfVqyC/MO929R8Pz0U0y3Ijgwy856gR0/8/C/vAv0TAhwXKimEPwkppjV1C9
         EmbbgDfwv/x0e1SAuE3/QLuzafbLQCQrvkeyfQcu9/E0v84XvW5eKCUn4JjkmM88k1m9
         mt+jC2UUw1ckafk+3PxhG707zlguMjx+uEy6X/6bM3FVcJ/l+00fLe2GzdhiJ5Lj59sK
         5QrpyeR4p5hzEiF+ME0aA+UwrZg/jLzVnwSJ5cQ6yMvip/dick/WiQKYI1oeahebMC36
         Y+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=E79NtAzOgIUAizJwIesUtiv2mCB5ZP/4rNwX4GMcwPI=;
        b=Oa+jozsc6KJWw0lLWI7zs5jXR4CicYqvMS3aNxg5NnEsq9SkXyIizfh5wD2RxokNfG
         /e3nLzy/+ju0FQb2DicIvE7AtfKfIuLuYABV+zkq3TAIfWtDzaT/KCQUdB33fnI/kgpI
         rEFXzhj/iQ7wYd48UUGavgfGby09POxeIRB5xk5+cvvGp94zpeUetA4mq7sjDE6N/LEB
         MP1PM55bG2BAvV5ArLu/iRBi1RmTOCKE7iWwG9TZ9Rnd6VDtAvfx0cBEpbXXLmwEx2np
         XGjJGcXBrMv7dkdMT7Qr1KpkGVQ9YX79hyQzYWqEmVnLH7Cz3s2by/HQ/RjEOYEqdGES
         rlog==
X-Gm-Message-State: APjAAAWTfSWxQyo2nOFVNXhSh/u9CRncRyy7ZK+vkx46kD1P3Ei4a7Q3
        25NvPvBtKZyO0UWnNHHhfKc=
X-Google-Smtp-Source: APXvYqx9vU3VKTWbwI+ywDQtC5OCaqsdO0JrIAO9I1jKI5YTwkUUNkFnToF+7r2alN0q6k5ThAt0tw==
X-Received: by 2002:ac8:64a:: with SMTP id e10mr6635078qth.30.1567029968213;
        Wed, 28 Aug 2019 15:06:08 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:c231])
        by smtp.gmail.com with ESMTPSA id l8sm332778qti.65.2019.08.28.15.06.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 15:06:07 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, newella@fb.com, clm@fb.com, josef@toxicpanda.com,
        dennisz@fb.com, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 01/10] blkcg: pass @q and @blkcg into blkcg_pol_alloc_pd_fn()
Date:   Wed, 28 Aug 2019 15:05:51 -0700
Message-Id: <20190828220600.2527417-2-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828220600.2527417-1-tj@kernel.org>
References: <20190828220600.2527417-1-tj@kernel.org>
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
index 0f6cd688924f..e6fb537b4bfc 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -501,11 +501,12 @@ static void bfq_cpd_free(struct blkcg_policy_data *cpd)
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
index 55a7dc227dfb..6a82ca3fb5cf 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -175,7 +175,7 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
 			continue;
 
 		/* alloc per-policy data and attach it to blkg */
-		pd = pol->pd_alloc_fn(gfp_mask, q->node);
+		pd = pol->pd_alloc_fn(gfp_mask, q, blkcg);
 		if (!pd)
 			goto err_free;
 
@@ -1346,7 +1346,7 @@ int blkcg_activate_policy(struct request_queue *q,
 		blk_mq_freeze_queue(q);
 pd_prealloc:
 	if (!pd_prealloc) {
-		pd_prealloc = pol->pd_alloc_fn(GFP_KERNEL, q->node);
+		pd_prealloc = pol->pd_alloc_fn(GFP_KERNEL, q, &blkcg_root);
 		if (!pd_prealloc) {
 			ret = -ENOMEM;
 			goto out_bypass_end;
@@ -1362,7 +1362,7 @@ int blkcg_activate_policy(struct request_queue *q,
 		if (blkg->pd[pol->plid])
 			continue;
 
-		pd = pol->pd_alloc_fn(GFP_NOWAIT | __GFP_NOWARN, q->node);
+		pd = pol->pd_alloc_fn(GFP_NOWAIT | __GFP_NOWARN, q, &blkcg_root);
 		if (!pd)
 			swap(pd, pd_prealloc);
 		if (!pd) {
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 0fff7b56df0e..46fa6449f4bb 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -934,11 +934,13 @@ static size_t iolatency_pd_stat(struct blkg_policy_data *pd, char *buf,
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
index 8ab6c8153223..0445c998c377 100644
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
index 0bb79d858a13..261248e88eb1 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -149,7 +149,8 @@ typedef struct blkcg_policy_data *(blkcg_pol_alloc_cpd_fn)(gfp_t gfp);
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


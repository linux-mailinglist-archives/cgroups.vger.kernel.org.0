Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09CB689CAA
	for <lists+cgroups@lfdr.de>; Fri,  3 Feb 2023 16:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbjBCPFR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Feb 2023 10:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbjBCPFR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Feb 2023 10:05:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0F2A2A48;
        Fri,  3 Feb 2023 07:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=iqxzzCJmHhLIZQm1tJj+TSbgjJAKy0k/QNFyAF6ZNsA=; b=tWx0Clz9w3UeM3V1h1z8TfnqgD
        4GVjoHs+9BmxPoHEiAwWjM0hN66RuSZyb3VFfnIojDqSFpF7Js1WcfiZ09vCCRyftl3FPbr6ouCkD
        G8b+KmsJShhF1aPpIOaA5TeNBucLG7CCcG+mrJA14eSqwO8BWo7Z/lf8ErdNqIa4bf/XTbUFSZluf
        qAKg6rN2ZDMtXvgLiHX1+zczPml0fcrg61riR7cc67u8ElPsHVCgdFiZUBqNK3EX6y/Q52VvucAHn
        0A2x26TTFroMzOcMtUxPBPwS55hwR14Z+zlcuKRB3/fjDqyPvC/1FA8uFdL630F7Cm0SeVi7tz+dP
        l6a+Q9Rw==;
Received: from [2001:4bb8:19a:272a:910:bb67:7287:f956] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNxcb-002aHk-K0; Fri, 03 Feb 2023 15:05:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.de>
Subject: [PATCH 17/19] blk-cgroup: pass a gendisk to pd_alloc_fn
Date:   Fri,  3 Feb 2023 16:03:58 +0100
Message-Id: <20230203150400.3199230-18-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230203150400.3199230-1-hch@lst.de>
References: <20230203150400.3199230-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

No need to the request_queue here, pass a gendisk and extract the
node ids from that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/bfq-cgroup.c    |  6 +++---
 block/blk-cgroup.c    | 10 +++++-----
 block/blk-cgroup.h    |  4 ++--
 block/blk-iocost.c    |  7 ++++---
 block/blk-iolatency.c |  7 +++----
 block/blk-ioprio.c    |  2 +-
 block/blk-throttle.c  |  7 +++----
 7 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 032c14f0451a1d..37333c164ed458 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -513,12 +513,12 @@ static void bfq_cpd_free(struct blkcg_policy_data *cpd)
 	kfree(cpd_to_bfqgd(cpd));
 }
 
-static struct blkg_policy_data *bfq_pd_alloc(gfp_t gfp, struct request_queue *q,
-					     struct blkcg *blkcg)
+static struct blkg_policy_data *bfq_pd_alloc(struct gendisk *disk,
+		struct blkcg *blkcg, gfp_t gfp)
 {
 	struct bfq_group *bfqg;
 
-	bfqg = kzalloc_node(sizeof(*bfqg), gfp, q->node);
+	bfqg = kzalloc_node(sizeof(*bfqg), gfp, disk->node_id);
 	if (!bfqg)
 		return NULL;
 
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index c20929bce8125c..fc264b15588210 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -276,7 +276,7 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
 			continue;
 
 		/* alloc per-policy data and attach it to blkg */
-		pd = pol->pd_alloc_fn(gfp_mask, disk->queue, blkcg);
+		pd = pol->pd_alloc_fn(disk, blkcg, gfp_mask);
 		if (!pd)
 			goto out_free_pds;
 		blkg->pd[i] = pd;
@@ -1432,8 +1432,8 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 			pd = pd_prealloc;
 			pd_prealloc = NULL;
 		} else {
-			pd = pol->pd_alloc_fn(GFP_NOWAIT | __GFP_NOWARN, q,
-					      blkg->blkcg);
+			pd = pol->pd_alloc_fn(disk, blkg->blkcg,
+					      GFP_NOWAIT | __GFP_NOWARN);
 		}
 
 		if (!pd) {
@@ -1450,8 +1450,8 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 
 			if (pd_prealloc)
 				pol->pd_free_fn(pd_prealloc);
-			pd_prealloc = pol->pd_alloc_fn(GFP_KERNEL, q,
-						       blkg->blkcg);
+			pd_prealloc = pol->pd_alloc_fn(disk, blkg->blkcg,
+						       GFP_KERNEL);
 			if (pd_prealloc)
 				goto retry;
 			else
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 27068faa2cd086..3d9e42c519db86 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -154,8 +154,8 @@ typedef struct blkcg_policy_data *(blkcg_pol_alloc_cpd_fn)(gfp_t gfp);
 typedef void (blkcg_pol_init_cpd_fn)(struct blkcg_policy_data *cpd);
 typedef void (blkcg_pol_free_cpd_fn)(struct blkcg_policy_data *cpd);
 typedef void (blkcg_pol_bind_cpd_fn)(struct blkcg_policy_data *cpd);
-typedef struct blkg_policy_data *(blkcg_pol_alloc_pd_fn)(gfp_t gfp,
-				struct request_queue *q, struct blkcg *blkcg);
+typedef struct blkg_policy_data *(blkcg_pol_alloc_pd_fn)(struct gendisk *disk,
+		struct blkcg *blkcg, gfp_t gfp);
 typedef void (blkcg_pol_init_pd_fn)(struct blkg_policy_data *pd);
 typedef void (blkcg_pol_online_pd_fn)(struct blkg_policy_data *pd);
 typedef void (blkcg_pol_offline_pd_fn)(struct blkg_policy_data *pd);
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 078b7770951962..7a2dc9dc8e3ba0 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2923,13 +2923,14 @@ static void ioc_cpd_free(struct blkcg_policy_data *cpd)
 	kfree(container_of(cpd, struct ioc_cgrp, cpd));
 }
 
-static struct blkg_policy_data *ioc_pd_alloc(gfp_t gfp, struct request_queue *q,
-					     struct blkcg *blkcg)
+static struct blkg_policy_data *ioc_pd_alloc(struct gendisk *disk,
+		struct blkcg *blkcg, gfp_t gfp)
 {
 	int levels = blkcg->css.cgroup->level + 1;
 	struct ioc_gq *iocg;
 
-	iocg = kzalloc_node(struct_size(iocg, ancestors, levels), gfp, q->node);
+	iocg = kzalloc_node(struct_size(iocg, ancestors, levels), gfp,
+			    disk->node_id);
 	if (!iocg)
 		return NULL;
 
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 39853fc5c2b02f..bc0d217f5c1723 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -946,13 +946,12 @@ static void iolatency_pd_stat(struct blkg_policy_data *pd, struct seq_file *s)
 			iolat->max_depth, avg_lat, cur_win);
 }
 
-static struct blkg_policy_data *iolatency_pd_alloc(gfp_t gfp,
-						   struct request_queue *q,
-						   struct blkcg *blkcg)
+static struct blkg_policy_data *iolatency_pd_alloc(struct gendisk *disk,
+		struct blkcg *blkcg, gfp_t gfp)
 {
 	struct iolatency_grp *iolat;
 
-	iolat = kzalloc_node(sizeof(*iolat), gfp, q->node);
+	iolat = kzalloc_node(sizeof(*iolat), gfp, disk->node_id);
 	if (!iolat)
 		return NULL;
 	iolat->stats = __alloc_percpu_gfp(sizeof(struct latency_stat),
diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
index 8194826cc824bc..055529b9b92bab 100644
--- a/block/blk-ioprio.c
+++ b/block/blk-ioprio.c
@@ -116,7 +116,7 @@ static ssize_t ioprio_set_prio_policy(struct kernfs_open_file *of, char *buf,
 }
 
 static struct blkg_policy_data *
-ioprio_alloc_pd(gfp_t gfp, struct request_queue *q, struct blkcg *blkcg)
+ioprio_alloc_pd(struct gendisk *disk, struct blkcg *blkcg, gfp_t gfp)
 {
 	struct ioprio_blkg *ioprio_blkg;
 
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index efc0a9092c6942..74bb1e753ea09d 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -335,14 +335,13 @@ static void throtl_service_queue_init(struct throtl_service_queue *sq)
 	timer_setup(&sq->pending_timer, throtl_pending_timer_fn, 0);
 }
 
-static struct blkg_policy_data *throtl_pd_alloc(gfp_t gfp,
-						struct request_queue *q,
-						struct blkcg *blkcg)
+static struct blkg_policy_data *throtl_pd_alloc(struct gendisk *disk,
+		struct blkcg *blkcg, gfp_t gfp)
 {
 	struct throtl_grp *tg;
 	int rw;
 
-	tg = kzalloc_node(sizeof(*tg), gfp, q->node);
+	tg = kzalloc_node(sizeof(*tg), gfp, disk->node_id);
 	if (!tg)
 		return NULL;
 
-- 
2.39.0


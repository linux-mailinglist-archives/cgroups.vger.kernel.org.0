Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B043866D7B5
	for <lists+cgroups@lfdr.de>; Tue, 17 Jan 2023 09:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbjAQINR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Jan 2023 03:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236014AbjAQINO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Jan 2023 03:13:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C7E166F9;
        Tue, 17 Jan 2023 00:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=0h3jlFMFVJThqWU4xQh90uvBp2yH+YeY8C3BOmxch4Y=; b=N/IIlA/NMxpHf0+mBHRKDnb6lL
        Vl7t5mitGa7Zt2iaMf4qrZB6e6iqiM5nwtkjlhOVeypMsqZZ3G0v0fCjVJvROvJOIW7YCARKxIgH8
        IDqloRtL/cwh+l8kanx5gRpc86Qt20YpKRTdtFSNRMqU40N4o9rh82KXm5FMTo1N9hA8HgxsxVMoj
        lWpXXq+xIGvUs3YWZb9H32HOVQ1vDeBQSf9Yyi2MlHF9R3//sThQs/IQWOShaU7uEY9HlpQw1P/op
        Oe3TWu3OJbGvQcVo0FJCM8a2cGAowqvhAhWRpJLsU6Sa4Nr5GvNt3uTdqBCob47tc02W5LE7sy1YD
        ER1sGPrA==;
Received: from [2001:4bb8:19a:2039:eaa2:3b9e:be2e:bd2a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHh5i-00DHiD-OU; Tue, 17 Jan 2023 08:13:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH 04/15] blk-cgroup: pin the gendisk in struct blkcg_gq
Date:   Tue, 17 Jan 2023 09:12:46 +0100
Message-Id: <20230117081257.3089859-5-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230117081257.3089859-1-hch@lst.de>
References: <20230117081257.3089859-1-hch@lst.de>
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

Currently each blkcg_gq holds a request_queue reference, which is what
is used in the policies.  But a lot of these interface will move over to
use a gendisk, so store a disk in strut blkcg_gq and hold a reference to
it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bfq-cgroup.c        |  6 +++---
 block/blk-cgroup-rwstat.c |  2 +-
 block/blk-cgroup.c        | 29 +++++++++++++----------------
 block/blk-cgroup.h        | 11 +++++------
 block/blk-iocost.c        |  2 +-
 block/blk-iolatency.c     |  4 ++--
 block/blk-throttle.c      |  4 ++--
 7 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index a6e8da5f5cfdc1..72a033776722c9 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -407,7 +407,7 @@ static void bfqg_stats_xfer_dead(struct bfq_group *bfqg)
 
 	parent = bfqg_parent(bfqg);
 
-	lockdep_assert_held(&bfqg_to_blkg(bfqg)->q->queue_lock);
+	lockdep_assert_held(&bfqg_to_blkg(bfqg)->disk->queue->queue_lock);
 
 	if (unlikely(!parent))
 		return;
@@ -538,7 +538,7 @@ static void bfq_pd_init(struct blkg_policy_data *pd)
 {
 	struct blkcg_gq *blkg = pd_to_blkg(pd);
 	struct bfq_group *bfqg = blkg_to_bfqg(blkg);
-	struct bfq_data *bfqd = blkg->q->elevator->elevator_data;
+	struct bfq_data *bfqd = blkg->disk->queue->elevator->elevator_data;
 	struct bfq_entity *entity = &bfqg->entity;
 	struct bfq_group_data *d = blkcg_to_bfqgd(blkg->blkcg);
 
@@ -1203,7 +1203,7 @@ static u64 bfqg_prfill_stat_recursive(struct seq_file *sf,
 	struct cgroup_subsys_state *pos_css;
 	u64 sum = 0;
 
-	lockdep_assert_held(&blkg->q->queue_lock);
+	lockdep_assert_held(&blkg->disk->queue->queue_lock);
 
 	rcu_read_lock();
 	blkg_for_each_descendant_pre(pos_blkg, pos_css, blkg) {
diff --git a/block/blk-cgroup-rwstat.c b/block/blk-cgroup-rwstat.c
index 3304e841df7ce9..b8b8c82e667a3b 100644
--- a/block/blk-cgroup-rwstat.c
+++ b/block/blk-cgroup-rwstat.c
@@ -107,7 +107,7 @@ void blkg_rwstat_recursive_sum(struct blkcg_gq *blkg, struct blkcg_policy *pol,
 	struct cgroup_subsys_state *pos_css;
 	unsigned int i;
 
-	lockdep_assert_held(&blkg->q->queue_lock);
+	lockdep_assert_held(&blkg->disk->queue->queue_lock);
 
 	memset(sum, 0, sizeof(*sum));
 	rcu_read_lock();
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 30d493b43f9272..f5a634ed098db0 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -131,8 +131,8 @@ static void blkg_free(struct blkcg_gq *blkg)
 		if (blkg->pd[i])
 			blkcg_policy[i]->pd_free_fn(blkg->pd[i]);
 
-	if (blkg->q)
-		blk_put_queue(blkg->q);
+	if (blkg->disk)
+		put_disk(blkg->disk);
 	free_percpu(blkg->iostat_cpu);
 	percpu_ref_exit(&blkg->refcnt);
 	kfree(blkg);
@@ -245,10 +245,9 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
 	if (!blkg->iostat_cpu)
 		goto err_free;
 
-	if (!blk_get_queue(disk->queue))
-		goto err_free;
+	get_device(disk_to_dev(disk));
 
-	blkg->q = disk->queue;
+	blkg->disk = disk;
 	INIT_LIST_HEAD(&blkg->q_node);
 	spin_lock_init(&blkg->async_bio_lock);
 	bio_list_init(&blkg->async_bios);
@@ -443,7 +442,7 @@ static void blkg_destroy(struct blkcg_gq *blkg)
 	struct blkcg *blkcg = blkg->blkcg;
 	int i;
 
-	lockdep_assert_held(&blkg->q->queue_lock);
+	lockdep_assert_held(&blkg->disk->queue->queue_lock);
 	lockdep_assert_held(&blkcg->lock);
 
 	/* Something wrong if we are trying to remove same group twice */
@@ -459,7 +458,7 @@ static void blkg_destroy(struct blkcg_gq *blkg)
 
 	blkg->online = false;
 
-	radix_tree_delete(&blkcg->blkg_tree, blkg->q->id);
+	radix_tree_delete(&blkcg->blkg_tree, blkg->disk->queue->id);
 	list_del_init(&blkg->q_node);
 	hlist_del_init_rcu(&blkg->blkcg_node);
 
@@ -547,9 +546,7 @@ static int blkcg_reset_stats(struct cgroup_subsys_state *css,
 
 const char *blkg_dev_name(struct blkcg_gq *blkg)
 {
-	if (!blkg->q->disk || !blkg->q->disk->bdi->dev)
-		return NULL;
-	return bdi_dev_name(blkg->q->disk->bdi);
+	return bdi_dev_name(blkg->disk->bdi);
 }
 
 /**
@@ -581,10 +578,10 @@ void blkcg_print_blkgs(struct seq_file *sf, struct blkcg *blkcg,
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
-		spin_lock_irq(&blkg->q->queue_lock);
-		if (blkcg_policy_enabled(blkg->q, pol))
+		spin_lock_irq(&blkg->disk->queue->queue_lock);
+		if (blkcg_policy_enabled(blkg->disk->queue, pol))
 			total += prfill(sf, blkg->pd[pol->plid], data);
-		spin_unlock_irq(&blkg->q->queue_lock);
+		spin_unlock_irq(&blkg->disk->queue->queue_lock);
 	}
 	rcu_read_unlock();
 
@@ -1008,9 +1005,9 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
-		spin_lock_irq(&blkg->q->queue_lock);
+		spin_lock_irq(&blkg->disk->queue->queue_lock);
 		blkcg_print_one_stat(blkg, sf);
-		spin_unlock_irq(&blkg->q->queue_lock);
+		spin_unlock_irq(&blkg->disk->queue->queue_lock);
 	}
 	rcu_read_unlock();
 	return 0;
@@ -1080,7 +1077,7 @@ static void blkcg_destroy_blkgs(struct blkcg *blkcg)
 	while (!hlist_empty(&blkcg->blkg_list)) {
 		struct blkcg_gq *blkg = hlist_entry(blkcg->blkg_list.first,
 						struct blkcg_gq, blkcg_node);
-		struct request_queue *q = blkg->q;
+		struct request_queue *q = blkg->disk->queue;
 
 		if (need_resched() || !spin_trylock(&q->queue_lock)) {
 			/*
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index f126fe36001eb3..85b267234823ab 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -53,8 +53,7 @@ struct blkg_iostat_set {
 
 /* association between a blk cgroup and a request queue */
 struct blkcg_gq {
-	/* Pointer to the associated request_queue */
-	struct request_queue		*q;
+	struct gendisk			*disk;
 	struct list_head		q_node;
 	struct hlist_node		blkcg_node;
 	struct blkcg			*blkcg;
@@ -251,11 +250,11 @@ static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg,
 		return q->root_blkg;
 
 	blkg = rcu_dereference(blkcg->blkg_hint);
-	if (blkg && blkg->q == q)
+	if (blkg && blkg->disk->queue == q)
 		return blkg;
 
 	blkg = radix_tree_lookup(&blkcg->blkg_tree, q->id);
-	if (blkg && blkg->q != q)
+	if (blkg && blkg->disk->queue != q)
 		blkg = NULL;
 	return blkg;
 }
@@ -355,7 +354,7 @@ static inline void blkg_put(struct blkcg_gq *blkg)
 #define blkg_for_each_descendant_pre(d_blkg, pos_css, p_blkg)		\
 	css_for_each_descendant_pre((pos_css), &(p_blkg)->blkcg->css)	\
 		if (((d_blkg) = blkg_lookup(css_to_blkcg(pos_css),	\
-					    (p_blkg)->q)))
+					    (p_blkg)->disk->queue)))
 
 /**
  * blkg_for_each_descendant_post - post-order walk of a blkg's descendants
@@ -370,7 +369,7 @@ static inline void blkg_put(struct blkcg_gq *blkg)
 #define blkg_for_each_descendant_post(d_blkg, pos_css, p_blkg)		\
 	css_for_each_descendant_post((pos_css), &(p_blkg)->blkcg->css)	\
 		if (((d_blkg) = blkg_lookup(css_to_blkcg(pos_css),	\
-					    (p_blkg)->q)))
+					    (p_blkg)->disk->queue)))
 
 bool __blkcg_punt_bio_submit(struct bio *bio);
 
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 6955605629e4f8..3b965d6b037970 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2946,7 +2946,7 @@ static void ioc_pd_init(struct blkg_policy_data *pd)
 {
 	struct ioc_gq *iocg = pd_to_iocg(pd);
 	struct blkcg_gq *blkg = pd_to_blkg(&iocg->pd);
-	struct ioc *ioc = q_to_ioc(blkg->q);
+	struct ioc *ioc = q_to_ioc(blkg->disk->queue);
 	struct ioc_now now;
 	struct blkcg_gq *tblkg;
 	unsigned long flags;
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index ecdc1074183625..b55eac2cf91944 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -974,12 +974,12 @@ static void iolatency_pd_init(struct blkg_policy_data *pd)
 {
 	struct iolatency_grp *iolat = pd_to_lat(pd);
 	struct blkcg_gq *blkg = lat_to_blkg(iolat);
-	struct rq_qos *rqos = blkcg_rq_qos(blkg->q);
+	struct rq_qos *rqos = blkcg_rq_qos(blkg->disk->queue);
 	struct blk_iolatency *blkiolat = BLKIOLATENCY(rqos);
 	u64 now = ktime_to_ns(ktime_get());
 	int cpu;
 
-	if (blk_queue_nonrot(blkg->q))
+	if (blk_queue_nonrot(blkg->disk->queue))
 		iolat->ssd = true;
 	else
 		iolat->ssd = false;
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 6fb5a2f9e1eed5..f802d8f9099430 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -388,7 +388,7 @@ static void throtl_pd_init(struct blkg_policy_data *pd)
 {
 	struct throtl_grp *tg = pd_to_tg(pd);
 	struct blkcg_gq *blkg = tg_to_blkg(tg);
-	struct throtl_data *td = blkg->q->td;
+	struct throtl_data *td = blkg->disk->queue->td;
 	struct throtl_service_queue *sq = &tg->service_queue;
 
 	/*
@@ -1175,7 +1175,7 @@ static void throtl_pending_timer_fn(struct timer_list *t)
 
 	/* throtl_data may be gone, so figure out request queue by blkg */
 	if (tg)
-		q = tg->pd.blkg->q;
+		q = tg->pd.blkg->disk->queue;
 	else
 		q = td->queue;
 
-- 
2.39.0


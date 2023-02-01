Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C61C686726
	for <lists+cgroups@lfdr.de>; Wed,  1 Feb 2023 14:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjBANls (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Feb 2023 08:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjBANlr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Feb 2023 08:41:47 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA30F4B896;
        Wed,  1 Feb 2023 05:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=nDX2y8PuMhm6Bw7i3C06myFNCn7+Mc7rQfYFFjbsQoY=; b=4AHuVRwZx5Tps5SWMxAa+FvbY5
        COuMLi28z9qybRPC7717AcgbLty1xDzqVevQCZcUH0dUGX4L1SB356Mw49odqUDQlAMgD7enlmgtr
        Z8LXHCRecA8xeByvJrkywgIiWX0CxNi7BNBFU0nj3SJ/bmVRLGpjLOkgo/aVgpNVfPN29p0NtYZeH
        sQvf4ovBlVfQ21XD91duo5/nVCPmfPomcuOOxDmOeEYgRmCVoJ1cCclXrjWIGqtkxFTFWo/iD38Xm
        EtpYOi8wX1jfRI1KQv4XwbFI37PyAhu/jffDUZEoLyx7vH3vswrH0NRQnHuahD/ry3TRM5uwBHqUi
        yJsdFHyQ==;
Received: from [2001:4bb8:19a:272a:3635:31c6:c223:d428] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNDMs-00C7Ut-U4; Wed, 01 Feb 2023 13:41:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.de>
Subject: [PATCH 06/19] blk-cgroup: pin the gendisk in struct blkcg_gq
Date:   Wed,  1 Feb 2023 14:41:10 +0100
Message-Id: <20230201134123.2656505-7-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230201134123.2656505-1-hch@lst.de>
References: <20230201134123.2656505-1-hch@lst.de>
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
is used in the policies.  But a lot of these interfaces will move over to
use a gendisk, so store a disk in struct blkcg_gq and hold a reference to
it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
---
 block/bfq-cgroup.c        |  6 +++---
 block/blk-cgroup-rwstat.c |  2 +-
 block/blk-cgroup.c        | 35 +++++++++++++++++------------------
 block/blk-cgroup.h        | 11 +++++------
 block/blk-iocost.c        |  2 +-
 block/blk-iolatency.c     |  4 ++--
 block/blk-throttle.c      |  4 ++--
 7 files changed, 31 insertions(+), 33 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index b42956ab555068..1d4a3f15049bda 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -405,7 +405,7 @@ static void bfqg_stats_xfer_dead(struct bfq_group *bfqg)
 
 	parent = bfqg_parent(bfqg);
 
-	lockdep_assert_held(&bfqg_to_blkg(bfqg)->q->queue_lock);
+	lockdep_assert_held(&bfqg_to_blkg(bfqg)->disk->queue->queue_lock);
 
 	if (unlikely(!parent))
 		return;
@@ -536,7 +536,7 @@ static void bfq_pd_init(struct blkg_policy_data *pd)
 {
 	struct blkcg_gq *blkg = pd_to_blkg(pd);
 	struct bfq_group *bfqg = blkg_to_bfqg(blkg);
-	struct bfq_data *bfqd = blkg->q->elevator->elevator_data;
+	struct bfq_data *bfqd = blkg->disk->queue->elevator->elevator_data;
 	struct bfq_entity *entity = &bfqg->entity;
 	struct bfq_group_data *d = blkcg_to_bfqgd(blkg->blkcg);
 
@@ -1201,7 +1201,7 @@ static u64 bfqg_prfill_stat_recursive(struct seq_file *sf,
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
index 0b3226cbf3f25d..0e368387497d27 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -116,7 +116,6 @@ static bool blkcg_policy_enabled(struct request_queue *q,
 
 static void blkg_free(struct blkcg_gq *blkg)
 {
-	struct request_queue *q = blkg->q;
 	int i;
 
 	/*
@@ -126,16 +125,16 @@ static void blkg_free(struct blkcg_gq *blkg)
 	 * blkcg_mutex is used to synchronize blkg_free_workfn() and
 	 * blkcg_deactivate_policy().
 	 */
-	mutex_lock(&q->blkcg_mutex);
+	mutex_lock(&blkg->disk->queue->blkcg_mutex);
 	for (i = 0; i < BLKCG_MAX_POLS; i++)
 		if (blkg->pd[i])
 			blkcg_policy[i]->pd_free_fn(blkg->pd[i]);
 	if (blkg->parent)
 		blkg_put(blkg->parent);
 	list_del_init(&blkg->q_node);
-	mutex_unlock(&q->blkcg_mutex);
+	mutex_unlock(&blkg->disk->queue->blkcg_mutex);
 
-	blk_put_queue(q);
+	put_disk(blkg->disk);
 	free_percpu(blkg->iostat_cpu);
 	percpu_ref_exit(&blkg->refcnt);
 	kfree(blkg);
@@ -251,10 +250,12 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
 	blkg->iostat_cpu = alloc_percpu_gfp(struct blkg_iostat_set, gfp_mask);
 	if (!blkg->iostat_cpu)
 		goto out_exit_refcnt;
-	if (!blk_get_queue(disk->queue))
+
+	if (test_bit(GD_DEAD, &disk->state))
 		goto out_free_iostat;
+	get_device(disk_to_dev(disk));
+	blkg->disk = disk;
 
-	blkg->q = disk->queue;
 	INIT_LIST_HEAD(&blkg->q_node);
 	spin_lock_init(&blkg->async_bio_lock);
 	bio_list_init(&blkg->async_bios);
@@ -290,7 +291,7 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
 	while (--i >= 0)
 		if (blkg->pd[i])
 			blkcg_policy[i]->pd_free_fn(blkg->pd[i]);
-	blk_put_queue(disk->queue);
+	put_disk(blkg->disk);
 out_free_iostat:
 	free_percpu(blkg->iostat_cpu);
 out_exit_refcnt:
@@ -461,7 +462,7 @@ static void blkg_destroy(struct blkcg_gq *blkg)
 	struct blkcg *blkcg = blkg->blkcg;
 	int i;
 
-	lockdep_assert_held(&blkg->q->queue_lock);
+	lockdep_assert_held(&blkg->disk->queue->queue_lock);
 	lockdep_assert_held(&blkcg->lock);
 
 	/*
@@ -485,7 +486,7 @@ static void blkg_destroy(struct blkcg_gq *blkg)
 
 	blkg->online = false;
 
-	radix_tree_delete(&blkcg->blkg_tree, blkg->q->id);
+	radix_tree_delete(&blkcg->blkg_tree, blkg->disk->queue->id);
 	hlist_del_init_rcu(&blkg->blkcg_node);
 
 	/*
@@ -572,9 +573,7 @@ static int blkcg_reset_stats(struct cgroup_subsys_state *css,
 
 const char *blkg_dev_name(struct blkcg_gq *blkg)
 {
-	if (!blkg->q->disk)
-		return NULL;
-	return bdi_dev_name(blkg->q->disk->bdi);
+	return bdi_dev_name(blkg->disk->bdi);
 }
 
 /**
@@ -606,10 +605,10 @@ void blkcg_print_blkgs(struct seq_file *sf, struct blkcg *blkcg,
 
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
 
@@ -1033,9 +1032,9 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 
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
@@ -1105,7 +1104,7 @@ static void blkcg_destroy_blkgs(struct blkcg *blkcg)
 	while (!hlist_empty(&blkcg->blkg_list)) {
 		struct blkcg_gq *blkg = hlist_entry(blkcg->blkg_list.first,
 						struct blkcg_gq, blkcg_node);
-		struct request_queue *q = blkg->q;
+		struct request_queue *q = blkg->disk->queue;
 
 		if (need_resched() || !spin_trylock(&q->queue_lock)) {
 			/*
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index b13ee84f358e85..996572a9a0b72e 100644
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
@@ -255,11 +254,11 @@ static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg,
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
@@ -359,7 +358,7 @@ static inline void blkg_put(struct blkcg_gq *blkg)
 #define blkg_for_each_descendant_pre(d_blkg, pos_css, p_blkg)		\
 	css_for_each_descendant_pre((pos_css), &(p_blkg)->blkcg->css)	\
 		if (((d_blkg) = blkg_lookup(css_to_blkcg(pos_css),	\
-					    (p_blkg)->q)))
+					    (p_blkg)->disk->queue)))
 
 /**
  * blkg_for_each_descendant_post - post-order walk of a blkg's descendants
@@ -374,7 +373,7 @@ static inline void blkg_put(struct blkcg_gq *blkg)
 #define blkg_for_each_descendant_post(d_blkg, pos_css, p_blkg)		\
 	css_for_each_descendant_post((pos_css), &(p_blkg)->blkcg->css)	\
 		if (((d_blkg) = blkg_lookup(css_to_blkcg(pos_css),	\
-					    (p_blkg)->q)))
+					    (p_blkg)->disk->queue)))
 
 bool __blkcg_punt_bio_submit(struct bio *bio);
 
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 9694394ed883c4..a2b4e7146be5f1 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2953,7 +2953,7 @@ static void ioc_pd_init(struct blkg_policy_data *pd)
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


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A22696CFE
	for <lists+cgroups@lfdr.de>; Tue, 14 Feb 2023 19:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjBNSd0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Feb 2023 13:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBNSdZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Feb 2023 13:33:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC1D6A4D;
        Tue, 14 Feb 2023 10:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=c5sx/j3Pm/Nr82jxMHgJb+Us5CWrjkXUV63jGLxRO+s=; b=rFPna/wq6Ak2i2gvEirmtdGpjp
        Qk4DPwAugcp1bOg+S+3ekSuQ0z93VB5tUoXZDITmXYnhySCkaHDh48cIDuQLtmXiPTDctdHDXtmra
        kPU4OlmsNC2iwWDvYFzPp3kztjTyTX82acKb+UOQ6ggoQ+chZgP1cHySZM3vjxn52uvUUj/5wepTn
        uVCKRmw0nQ69pw5oxsH3WLIwSZIJ0f7YfMmmKGkVXnIgZg81UxxbXPTKlEctvtKlIPUTE1Oy6PDof
        FKtV70IlWW7+UD41vppWzWaytVQw4blBJD512e5dw8nqFQxzlB1zsd23nDZ7nrxMJZJF+FYOMZMxX
        DiBNJlRA==;
Received: from [2001:4bb8:181:6771:29b8:d178:cc31:6d8f] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pS07D-003Bbc-LF; Tue, 14 Feb 2023 18:33:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     Ming Lei <ming.lei@redhat.com>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH 1/5] Revert "blk-cgroup: move the cgroup information to struct gendisk"
Date:   Tue, 14 Feb 2023 19:33:04 +0100
Message-Id: <20230214183308.1658775-2-hch@lst.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214183308.1658775-1-hch@lst.de>
References: <20230214183308.1658775-1-hch@lst.de>
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

This reverts commit 3f13ab7c80fdb0ada86a8e3e818960bc1ccbaa59 as a patch
it depends on caused a few problems.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bfq-cgroup.c     |  4 +--
 block/blk-cgroup.c     | 66 +++++++++++++++++++++---------------------
 block/blk-cgroup.h     |  4 +--
 block/blk-iolatency.c  |  2 +-
 block/blk-throttle.c   | 16 ++++------
 include/linux/blkdev.h | 12 ++++----
 6 files changed, 50 insertions(+), 54 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 624530643a05cd..935a497b5dedb3 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -999,7 +999,7 @@ void bfq_end_wr_async(struct bfq_data *bfqd)
 {
 	struct blkcg_gq *blkg;
 
-	list_for_each_entry(blkg, &bfqd->queue->disk->blkg_list, entry) {
+	list_for_each_entry(blkg, &bfqd->queue->blkg_list, q_node) {
 		struct bfq_group *bfqg = blkg_to_bfqg(blkg);
 
 		bfq_end_wr_async_queues(bfqd, bfqg);
@@ -1293,7 +1293,7 @@ struct bfq_group *bfq_create_group_hierarchy(struct bfq_data *bfqd, int node)
 	if (ret)
 		return NULL;
 
-	return blkg_to_bfqg(bfqd->queue->disk->root_blkg);
+	return blkg_to_bfqg(bfqd->queue->root_blkg);
 }
 
 struct blkcg_policy blkcg_policy_bfq = {
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 935028912e7abf..1653786644eab1 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -108,10 +108,10 @@ static struct cgroup_subsys_state *blkcg_css(void)
 	return task_css(current, io_cgrp_id);
 }
 
-static bool blkcg_policy_enabled(struct gendisk *disk,
+static bool blkcg_policy_enabled(struct request_queue *q,
 				 const struct blkcg_policy *pol)
 {
-	return pol && test_bit(pol->plid, disk->blkcg_pols);
+	return pol && test_bit(pol->plid, q->blkcg_pols);
 }
 
 static void blkg_free_workfn(struct work_struct *work)
@@ -123,18 +123,18 @@ static void blkg_free_workfn(struct work_struct *work)
 	/*
 	 * pd_free_fn() can also be called from blkcg_deactivate_policy(),
 	 * in order to make sure pd_free_fn() is called in order, the deletion
-	 * of the list blkg->entry is delayed to here from blkg_destroy(), and
+	 * of the list blkg->q_node is delayed to here from blkg_destroy(), and
 	 * blkcg_mutex is used to synchronize blkg_free_workfn() and
 	 * blkcg_deactivate_policy().
 	 */
-	mutex_lock(&blkg->disk->blkcg_mutex);
+	mutex_lock(&blkg->disk->queue->blkcg_mutex);
 	for (i = 0; i < BLKCG_MAX_POLS; i++)
 		if (blkg->pd[i])
 			blkcg_policy[i]->pd_free_fn(blkg->pd[i]);
 	if (blkg->parent)
 		blkg_put(blkg->parent);
-	list_del_init(&blkg->entry);
-	mutex_unlock(&blkg->disk->blkcg_mutex);
+	list_del_init(&blkg->q_node);
+	mutex_unlock(&blkg->disk->queue->blkcg_mutex);
 
 	put_disk(blkg->disk);
 	free_percpu(blkg->iostat_cpu);
@@ -269,7 +269,7 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
 	get_device(disk_to_dev(disk));
 	blkg->disk = disk;
 
-	INIT_LIST_HEAD(&blkg->entry);
+	INIT_LIST_HEAD(&blkg->q_node);
 	spin_lock_init(&blkg->async_bio_lock);
 	bio_list_init(&blkg->async_bios);
 	INIT_WORK(&blkg->async_bio_work, blkg_async_bio_workfn);
@@ -285,7 +285,7 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
 		struct blkcg_policy *pol = blkcg_policy[i];
 		struct blkg_policy_data *pd;
 
-		if (!blkcg_policy_enabled(disk, pol))
+		if (!blkcg_policy_enabled(disk->queue, pol))
 			continue;
 
 		/* alloc per-policy data and attach it to blkg */
@@ -371,7 +371,7 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
 	ret = radix_tree_insert(&blkcg->blkg_tree, disk->queue->id, blkg);
 	if (likely(!ret)) {
 		hlist_add_head_rcu(&blkg->blkcg_node, &blkcg->blkg_list);
-		list_add(&blkg->entry, &disk->blkg_list);
+		list_add(&blkg->q_node, &disk->queue->blkg_list);
 
 		for (i = 0; i < BLKCG_MAX_POLS; i++) {
 			struct blkcg_policy *pol = blkcg_policy[i];
@@ -444,7 +444,7 @@ static struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
 	while (true) {
 		struct blkcg *pos = blkcg;
 		struct blkcg *parent = blkcg_parent(blkcg);
-		struct blkcg_gq *ret_blkg = disk->root_blkg;
+		struct blkcg_gq *ret_blkg = q->root_blkg;
 
 		while (parent) {
 			blkg = blkg_lookup(parent, disk);
@@ -526,7 +526,7 @@ static void blkg_destroy_all(struct gendisk *disk)
 
 restart:
 	spin_lock_irq(&q->queue_lock);
-	list_for_each_entry_safe(blkg, n, &disk->blkg_list, entry) {
+	list_for_each_entry_safe(blkg, n, &q->blkg_list, q_node) {
 		struct blkcg *blkcg = blkg->blkcg;
 
 		spin_lock(&blkcg->lock);
@@ -545,7 +545,7 @@ static void blkg_destroy_all(struct gendisk *disk)
 		}
 	}
 
-	disk->root_blkg = NULL;
+	q->root_blkg = NULL;
 	spin_unlock_irq(&q->queue_lock);
 }
 
@@ -620,7 +620,7 @@ void blkcg_print_blkgs(struct seq_file *sf, struct blkcg *blkcg,
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
 		spin_lock_irq(&blkg->disk->queue->queue_lock);
-		if (blkcg_policy_enabled(blkg->disk, pol))
+		if (blkcg_policy_enabled(blkg->disk->queue, pol))
 			total += prfill(sf, blkg->pd[pol->plid], data);
 		spin_unlock_irq(&blkg->disk->queue->queue_lock);
 	}
@@ -728,7 +728,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	rcu_read_lock();
 	spin_lock_irq(&q->queue_lock);
 
-	if (!blkcg_policy_enabled(disk, pol)) {
+	if (!blkcg_policy_enabled(q, pol)) {
 		ret = -EOPNOTSUPP;
 		goto fail_unlock;
 	}
@@ -771,7 +771,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		rcu_read_lock();
 		spin_lock_irq(&q->queue_lock);
 
-		if (!blkcg_policy_enabled(disk, pol)) {
+		if (!blkcg_policy_enabled(q, pol)) {
 			blkg_free(new_blkg);
 			ret = -EOPNOTSUPP;
 			goto fail_preloaded;
@@ -951,7 +951,7 @@ static void blkcg_fill_root_iostats(void)
 	class_dev_iter_init(&iter, &block_class, NULL, &disk_type);
 	while ((dev = class_dev_iter_next(&iter))) {
 		struct block_device *bdev = dev_to_bdev(dev);
-		struct blkcg_gq *blkg = bdev->bd_disk->root_blkg;
+		struct blkcg_gq *blkg = bdev->bd_disk->queue->root_blkg;
 		struct blkg_iostat tmp;
 		int cpu;
 		unsigned long flags;
@@ -1298,8 +1298,8 @@ int blkcg_init_disk(struct gendisk *disk)
 	bool preloaded;
 	int ret;
 
-	INIT_LIST_HEAD(&disk->blkg_list);
-	mutex_init(&disk->blkcg_mutex);
+	INIT_LIST_HEAD(&q->blkg_list);
+	mutex_init(&q->blkcg_mutex);
 
 	new_blkg = blkg_alloc(&blkcg_root, disk, GFP_KERNEL);
 	if (!new_blkg)
@@ -1313,7 +1313,7 @@ int blkcg_init_disk(struct gendisk *disk)
 	blkg = blkg_create(&blkcg_root, disk, new_blkg);
 	if (IS_ERR(blkg))
 		goto err_unlock;
-	disk->root_blkg = blkg;
+	q->root_blkg = blkg;
 	spin_unlock_irq(&q->queue_lock);
 
 	if (preloaded)
@@ -1426,7 +1426,7 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 	struct blkcg_gq *blkg, *pinned_blkg = NULL;
 	int ret;
 
-	if (blkcg_policy_enabled(disk, pol))
+	if (blkcg_policy_enabled(q, pol))
 		return 0;
 
 	if (queue_is_mq(q))
@@ -1435,7 +1435,7 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 	spin_lock_irq(&q->queue_lock);
 
 	/* blkg_list is pushed at the head, reverse walk to allocate parents first */
-	list_for_each_entry_reverse(blkg, &disk->blkg_list, entry) {
+	list_for_each_entry_reverse(blkg, &q->blkg_list, q_node) {
 		struct blkg_policy_data *pd;
 
 		if (blkg->pd[pol->plid])
@@ -1480,16 +1480,16 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 
 	/* all allocated, init in the same order */
 	if (pol->pd_init_fn)
-		list_for_each_entry_reverse(blkg, &disk->blkg_list, entry)
+		list_for_each_entry_reverse(blkg, &q->blkg_list, q_node)
 			pol->pd_init_fn(blkg->pd[pol->plid]);
 
-	list_for_each_entry_reverse(blkg, &disk->blkg_list, entry) {
+	list_for_each_entry_reverse(blkg, &q->blkg_list, q_node) {
 		if (pol->pd_online_fn)
 			pol->pd_online_fn(blkg->pd[pol->plid]);
 		blkg->pd[pol->plid]->online = true;
 	}
 
-	__set_bit(pol->plid, disk->blkcg_pols);
+	__set_bit(pol->plid, q->blkcg_pols);
 	ret = 0;
 
 	spin_unlock_irq(&q->queue_lock);
@@ -1505,7 +1505,7 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 enomem:
 	/* alloc failed, nothing's initialized yet, free everything */
 	spin_lock_irq(&q->queue_lock);
-	list_for_each_entry(blkg, &disk->blkg_list, entry) {
+	list_for_each_entry(blkg, &q->blkg_list, q_node) {
 		struct blkcg *blkcg = blkg->blkcg;
 
 		spin_lock(&blkcg->lock);
@@ -1535,18 +1535,18 @@ void blkcg_deactivate_policy(struct gendisk *disk,
 	struct request_queue *q = disk->queue;
 	struct blkcg_gq *blkg;
 
-	if (!blkcg_policy_enabled(disk, pol))
+	if (!blkcg_policy_enabled(q, pol))
 		return;
 
 	if (queue_is_mq(q))
 		blk_mq_freeze_queue(q);
 
-	mutex_lock(&disk->blkcg_mutex);
+	mutex_lock(&q->blkcg_mutex);
 	spin_lock_irq(&q->queue_lock);
 
-	__clear_bit(pol->plid, disk->blkcg_pols);
+	__clear_bit(pol->plid, q->blkcg_pols);
 
-	list_for_each_entry(blkg, &disk->blkg_list, entry) {
+	list_for_each_entry(blkg, &q->blkg_list, q_node) {
 		struct blkcg *blkcg = blkg->blkcg;
 
 		spin_lock(&blkcg->lock);
@@ -1560,7 +1560,7 @@ void blkcg_deactivate_policy(struct gendisk *disk,
 	}
 
 	spin_unlock_irq(&q->queue_lock);
-	mutex_unlock(&disk->blkcg_mutex);
+	mutex_unlock(&q->blkcg_mutex);
 
 	if (queue_is_mq(q))
 		blk_mq_unfreeze_queue(q);
@@ -1957,7 +1957,7 @@ static inline struct blkcg_gq *blkg_tryget_closest(struct bio *bio,
  * Associate @bio with the blkg found by combining the css's blkg and the
  * request_queue of the @bio.  An association failure is handled by walking up
  * the blkg tree.  Therefore, the blkg associated can be anything between @blkg
- * and disk->root_blkg.  This situation only happens when a cgroup is dying and
+ * and q->root_blkg.  This situation only happens when a cgroup is dying and
  * then the remaining bios will spill to the closest alive blkg.
  *
  * A reference will be taken on the blkg and will be released when @bio is
@@ -1972,8 +1972,8 @@ void bio_associate_blkg_from_css(struct bio *bio,
 	if (css && css->parent) {
 		bio->bi_blkg = blkg_tryget_closest(bio, css);
 	} else {
-		blkg_get(bio->bi_bdev->bd_disk->root_blkg);
-		bio->bi_blkg = bio->bi_bdev->bd_disk->root_blkg;
+		blkg_get(bdev_get_queue(bio->bi_bdev)->root_blkg);
+		bio->bi_blkg = bdev_get_queue(bio->bi_bdev)->root_blkg;
 	}
 }
 EXPORT_SYMBOL_GPL(bio_associate_blkg_from_css);
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index e442b406ca0da6..151f24de253985 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -54,7 +54,7 @@ struct blkg_iostat_set {
 /* association between a blk cgroup and a request queue */
 struct blkcg_gq {
 	struct gendisk			*disk;
-	struct list_head		entry;
+	struct list_head		q_node;
 	struct hlist_node		blkcg_node;
 	struct blkcg			*blkcg;
 
@@ -250,7 +250,7 @@ static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg,
 	WARN_ON_ONCE(!rcu_read_lock_held());
 
 	if (blkcg == &blkcg_root)
-		return disk->root_blkg;
+		return disk->queue->root_blkg;
 
 	blkg = rcu_dereference(blkcg->blkg_hint);
 	if (blkg && blkg->disk == disk)
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 5d5aa1e526b742..bc0d217f5c1723 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -665,7 +665,7 @@ static void blkiolatency_timer_fn(struct timer_list *t)
 
 	rcu_read_lock();
 	blkg_for_each_descendant_pre(blkg, pos_css,
-				     blkiolat->rqos.disk->root_blkg) {
+				     blkiolat->rqos.disk->queue->root_blkg) {
 		struct iolatency_grp *iolat;
 		struct child_latency_info *lat_info;
 		unsigned long flags;
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index e7bd7050d68402..21c8d5e871eac9 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -451,8 +451,7 @@ static void blk_throtl_update_limit_valid(struct throtl_data *td)
 	bool low_valid = false;
 
 	rcu_read_lock();
-	blkg_for_each_descendant_post(blkg, pos_css,
-			td->queue->disk->root_blkg) {
+	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg) {
 		struct throtl_grp *tg = blkg_to_tg(blkg);
 
 		if (tg->bps[READ][LIMIT_LOW] || tg->bps[WRITE][LIMIT_LOW] ||
@@ -1181,7 +1180,7 @@ static void throtl_pending_timer_fn(struct timer_list *t)
 
 	spin_lock_irq(&q->queue_lock);
 
-	if (!q->disk->root_blkg)
+	if (!q->root_blkg)
 		goto out_unlock;
 
 	if (throtl_can_upgrade(td, NULL))
@@ -1323,8 +1322,7 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
 	 * blk-throttle.
 	 */
 	blkg_for_each_descendant_pre(blkg, pos_css,
-			global ? tg->td->queue->disk->root_blkg :
-			tg_to_blkg(tg)) {
+			global ? tg->td->queue->root_blkg : tg_to_blkg(tg)) {
 		struct throtl_grp *this_tg = blkg_to_tg(blkg);
 		struct throtl_grp *parent_tg;
 
@@ -1719,7 +1717,7 @@ void blk_throtl_cancel_bios(struct gendisk *disk)
 	 * path need RCU protection and to prevent warning from lockdep.
 	 */
 	rcu_read_lock();
-	blkg_for_each_descendant_post(blkg, pos_css, disk->root_blkg) {
+	blkg_for_each_descendant_post(blkg, pos_css, q->root_blkg) {
 		struct throtl_grp *tg = blkg_to_tg(blkg);
 		struct throtl_service_queue *sq = &tg->service_queue;
 
@@ -1873,8 +1871,7 @@ static bool throtl_can_upgrade(struct throtl_data *td,
 		return false;
 
 	rcu_read_lock();
-	blkg_for_each_descendant_post(blkg, pos_css,
-			td->queue->disk->root_blkg) {
+	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg) {
 		struct throtl_grp *tg = blkg_to_tg(blkg);
 
 		if (tg == this_tg)
@@ -1920,8 +1917,7 @@ static void throtl_upgrade_state(struct throtl_data *td)
 	td->low_upgrade_time = jiffies;
 	td->scale = 0;
 	rcu_read_lock();
-	blkg_for_each_descendant_post(blkg, pos_css,
-			td->queue->disk->root_blkg) {
+	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg) {
 		struct throtl_grp *tg = blkg_to_tg(blkg);
 		struct throtl_service_queue *sq = &tg->service_queue;
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 79aec4ebadb9e0..b9637d63e6f024 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -163,12 +163,6 @@ struct gendisk {
 	struct timer_rand_state *random;
 	atomic_t sync_io;		/* RAID */
 	struct disk_events *ev;
-#ifdef CONFIG_BLK_CGROUP
-	DECLARE_BITMAP		(blkcg_pols, BLKCG_MAX_POLS);
-	struct blkcg_gq		*root_blkg;
-	struct list_head	blkg_list;
-	struct mutex		blkcg_mutex;
-#endif /* CONFIG_BLK_CGROUP */
 #ifdef  CONFIG_BLK_DEV_INTEGRITY
 	struct kobject integrity_kobj;
 #endif	/* CONFIG_BLK_DEV_INTEGRITY */
@@ -487,6 +481,12 @@ struct request_queue {
 	struct blk_mq_tags	*sched_shared_tags;
 
 	struct list_head	icq_list;
+#ifdef CONFIG_BLK_CGROUP
+	DECLARE_BITMAP		(blkcg_pols, BLKCG_MAX_POLS);
+	struct blkcg_gq		*root_blkg;
+	struct list_head	blkg_list;
+	struct mutex		blkcg_mutex;
+#endif
 
 	struct queue_limits	limits;
 
-- 
2.39.1


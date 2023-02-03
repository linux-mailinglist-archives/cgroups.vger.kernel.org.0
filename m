Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE0D689CAF
	for <lists+cgroups@lfdr.de>; Fri,  3 Feb 2023 16:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbjBCPF2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Feb 2023 10:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbjBCPF1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Feb 2023 10:05:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC7AA703A;
        Fri,  3 Feb 2023 07:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=cxweqdA+/zT5pKf1SAPGWsgdRCoydge3wCpi1UnSLqU=; b=JYZMa5EokVdugGYRjwp+aoI8hp
        2S21dZrq9wlWqUGSKP0Tq2AIR4WzjOGIR7Xu/uXkkjXF+ANFBarcFbWDJl6QY470AZoz+FXdeCPpd
        mgZZRA57exmlUEUNVLOAtgCv+hbAs3/eBgbZ7CY7OHD0x6zdATgP3Y/JDL85dzWrHWwQkmFPKOLPK
        DxBDoYyvB2XfdTsqPKgGFn1KOfFoygCC+h3Lvm2YtskJabNlSeNvVFnY3+Q9H4tL4NystVQ3+Y2Z+
        kZBJTCMH7fGTUsqH2MKtViS6NdOgkJdQxw2iA7FuGUmrSZxgXQZfobzLUrqO7G9EYxHWXPECOEgR/
        KkDJ0HPg==;
Received: from [2001:4bb8:19a:272a:910:bb67:7287:f956] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNxcj-002aKW-0F; Fri, 03 Feb 2023 15:05:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.de>
Subject: [PATCH 19/19] blk-cgroup: move the cgroup information to struct gendisk
Date:   Fri,  3 Feb 2023 16:04:00 +0100
Message-Id: <20230203150400.3199230-20-hch@lst.de>
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

cgroup information only makes sense on a live gendisk that allows
file system I/O (which includes the raw block device).  So move over
the cgroup related members.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/bfq-cgroup.c     |  4 +--
 block/blk-cgroup.c     | 66 +++++++++++++++++++++---------------------
 block/blk-cgroup.h     |  4 +--
 block/blk-iolatency.c  |  2 +-
 block/blk-throttle.c   | 16 ++++++----
 include/linux/blkdev.h | 12 ++++----
 6 files changed, 54 insertions(+), 50 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 37333c164ed458..4fdbbec71647f9 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -1001,7 +1001,7 @@ void bfq_end_wr_async(struct bfq_data *bfqd)
 {
 	struct blkcg_gq *blkg;
 
-	list_for_each_entry(blkg, &bfqd->queue->blkg_list, q_node) {
+	list_for_each_entry(blkg, &bfqd->queue->disk->blkg_list, entry) {
 		struct bfq_group *bfqg = blkg_to_bfqg(blkg);
 
 		bfq_end_wr_async_queues(bfqd, bfqg);
@@ -1295,7 +1295,7 @@ struct bfq_group *bfq_create_group_hierarchy(struct bfq_data *bfqd, int node)
 	if (ret)
 		return NULL;
 
-	return blkg_to_bfqg(bfqd->queue->root_blkg);
+	return blkg_to_bfqg(bfqd->queue->disk->root_blkg);
 }
 
 struct blkcg_policy blkcg_policy_bfq = {
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 45a683e88bcac1..8faeca6022bea0 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -108,10 +108,10 @@ static struct cgroup_subsys_state *blkcg_css(void)
 	return task_css(current, io_cgrp_id);
 }
 
-static bool blkcg_policy_enabled(struct request_queue *q,
+static bool blkcg_policy_enabled(struct gendisk *disk,
 				 const struct blkcg_policy *pol)
 {
-	return pol && test_bit(pol->plid, q->blkcg_pols);
+	return pol && test_bit(pol->plid, disk->blkcg_pols);
 }
 
 static void blkg_free(struct blkcg_gq *blkg)
@@ -121,18 +121,18 @@ static void blkg_free(struct blkcg_gq *blkg)
 	/*
 	 * pd_free_fn() can also be called from blkcg_deactivate_policy(),
 	 * in order to make sure pd_free_fn() is called in order, the deletion
-	 * of the list blkg->q_node is delayed to here from blkg_destroy(), and
+	 * of the list blkg->entry is delayed to here from blkg_destroy(), and
 	 * blkcg_mutex is used to synchronize blkg_free_workfn() and
 	 * blkcg_deactivate_policy().
 	 */
-	mutex_lock(&blkg->disk->queue->blkcg_mutex);
+	mutex_lock(&blkg->disk->blkcg_mutex);
 	for (i = 0; i < BLKCG_MAX_POLS; i++)
 		if (blkg->pd[i])
 			blkcg_policy[i]->pd_free_fn(blkg->pd[i]);
 	if (blkg->parent)
 		blkg_put(blkg->parent);
-	list_del_init(&blkg->q_node);
-	mutex_unlock(&blkg->disk->queue->blkcg_mutex);
+	list_del_init(&blkg->entry);
+	mutex_unlock(&blkg->disk->blkcg_mutex);
 
 	put_disk(blkg->disk);
 	free_percpu(blkg->iostat_cpu);
@@ -256,7 +256,7 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
 	get_device(disk_to_dev(disk));
 	blkg->disk = disk;
 
-	INIT_LIST_HEAD(&blkg->q_node);
+	INIT_LIST_HEAD(&blkg->entry);
 	spin_lock_init(&blkg->async_bio_lock);
 	bio_list_init(&blkg->async_bios);
 	INIT_WORK(&blkg->async_bio_work, blkg_async_bio_workfn);
@@ -272,7 +272,7 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
 		struct blkcg_policy *pol = blkcg_policy[i];
 		struct blkg_policy_data *pd;
 
-		if (!blkcg_policy_enabled(disk->queue, pol))
+		if (!blkcg_policy_enabled(disk, pol))
 			continue;
 
 		/* alloc per-policy data and attach it to blkg */
@@ -358,7 +358,7 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
 	ret = radix_tree_insert(&blkcg->blkg_tree, disk->queue->id, blkg);
 	if (likely(!ret)) {
 		hlist_add_head_rcu(&blkg->blkcg_node, &blkcg->blkg_list);
-		list_add(&blkg->q_node, &disk->queue->blkg_list);
+		list_add(&blkg->entry, &disk->blkg_list);
 
 		for (i = 0; i < BLKCG_MAX_POLS; i++) {
 			struct blkcg_policy *pol = blkcg_policy[i];
@@ -430,7 +430,7 @@ static struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
 	while (true) {
 		struct blkcg *pos = blkcg;
 		struct blkcg *parent = blkcg_parent(blkcg);
-		struct blkcg_gq *ret_blkg = q->root_blkg;
+		struct blkcg_gq *ret_blkg = disk->root_blkg;
 
 		while (parent) {
 			blkg = blkg_lookup(parent, disk);
@@ -512,7 +512,7 @@ static void blkg_destroy_all(struct gendisk *disk)
 
 restart:
 	spin_lock_irq(&q->queue_lock);
-	list_for_each_entry_safe(blkg, n, &q->blkg_list, q_node) {
+	list_for_each_entry_safe(blkg, n, &disk->blkg_list, entry) {
 		struct blkcg *blkcg = blkg->blkcg;
 
 		spin_lock(&blkcg->lock);
@@ -531,7 +531,7 @@ static void blkg_destroy_all(struct gendisk *disk)
 		}
 	}
 
-	q->root_blkg = NULL;
+	disk->root_blkg = NULL;
 	spin_unlock_irq(&q->queue_lock);
 }
 
@@ -606,7 +606,7 @@ void blkcg_print_blkgs(struct seq_file *sf, struct blkcg *blkcg,
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
 		spin_lock_irq(&blkg->disk->queue->queue_lock);
-		if (blkcg_policy_enabled(blkg->disk->queue, pol))
+		if (blkcg_policy_enabled(blkg->disk, pol))
 			total += prfill(sf, blkg->pd[pol->plid], data);
 		spin_unlock_irq(&blkg->disk->queue->queue_lock);
 	}
@@ -714,7 +714,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	rcu_read_lock();
 	spin_lock_irq(&q->queue_lock);
 
-	if (!blkcg_policy_enabled(q, pol)) {
+	if (!blkcg_policy_enabled(disk, pol)) {
 		ret = -EOPNOTSUPP;
 		goto fail_unlock;
 	}
@@ -757,7 +757,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		rcu_read_lock();
 		spin_lock_irq(&q->queue_lock);
 
-		if (!blkcg_policy_enabled(q, pol)) {
+		if (!blkcg_policy_enabled(disk, pol)) {
 			blkg_free(new_blkg);
 			ret = -EOPNOTSUPP;
 			goto fail_preloaded;
@@ -937,7 +937,7 @@ static void blkcg_fill_root_iostats(void)
 	class_dev_iter_init(&iter, &block_class, NULL, &disk_type);
 	while ((dev = class_dev_iter_next(&iter))) {
 		struct block_device *bdev = dev_to_bdev(dev);
-		struct blkcg_gq *blkg = bdev->bd_disk->queue->root_blkg;
+		struct blkcg_gq *blkg = bdev->bd_disk->root_blkg;
 		struct blkg_iostat tmp;
 		int cpu;
 		unsigned long flags;
@@ -1284,8 +1284,8 @@ int blkcg_init_disk(struct gendisk *disk)
 	bool preloaded;
 	int ret;
 
-	INIT_LIST_HEAD(&q->blkg_list);
-	mutex_init(&q->blkcg_mutex);
+	INIT_LIST_HEAD(&disk->blkg_list);
+	mutex_init(&disk->blkcg_mutex);
 
 	new_blkg = blkg_alloc(&blkcg_root, disk, GFP_KERNEL);
 	if (!new_blkg)
@@ -1299,7 +1299,7 @@ int blkcg_init_disk(struct gendisk *disk)
 	blkg = blkg_create(&blkcg_root, disk, new_blkg);
 	if (IS_ERR(blkg))
 		goto err_unlock;
-	q->root_blkg = blkg;
+	disk->root_blkg = blkg;
 	spin_unlock_irq(&q->queue_lock);
 
 	if (preloaded)
@@ -1412,7 +1412,7 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 	struct blkcg_gq *blkg, *pinned_blkg = NULL;
 	int ret;
 
-	if (blkcg_policy_enabled(q, pol))
+	if (blkcg_policy_enabled(disk, pol))
 		return 0;
 
 	if (queue_is_mq(q))
@@ -1421,7 +1421,7 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 	spin_lock_irq(&q->queue_lock);
 
 	/* blkg_list is pushed at the head, reverse walk to allocate parents first */
-	list_for_each_entry_reverse(blkg, &q->blkg_list, q_node) {
+	list_for_each_entry_reverse(blkg, &disk->blkg_list, entry) {
 		struct blkg_policy_data *pd;
 
 		if (blkg->pd[pol->plid])
@@ -1466,16 +1466,16 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 
 	/* all allocated, init in the same order */
 	if (pol->pd_init_fn)
-		list_for_each_entry_reverse(blkg, &q->blkg_list, q_node)
+		list_for_each_entry_reverse(blkg, &disk->blkg_list, entry)
 			pol->pd_init_fn(blkg->pd[pol->plid]);
 
-	list_for_each_entry_reverse(blkg, &q->blkg_list, q_node) {
+	list_for_each_entry_reverse(blkg, &disk->blkg_list, entry) {
 		if (pol->pd_online_fn)
 			pol->pd_online_fn(blkg->pd[pol->plid]);
 		blkg->pd[pol->plid]->online = true;
 	}
 
-	__set_bit(pol->plid, q->blkcg_pols);
+	__set_bit(pol->plid, disk->blkcg_pols);
 	ret = 0;
 
 	spin_unlock_irq(&q->queue_lock);
@@ -1491,7 +1491,7 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 enomem:
 	/* alloc failed, nothing's initialized yet, free everything */
 	spin_lock_irq(&q->queue_lock);
-	list_for_each_entry(blkg, &q->blkg_list, q_node) {
+	list_for_each_entry(blkg, &disk->blkg_list, entry) {
 		struct blkcg *blkcg = blkg->blkcg;
 
 		spin_lock(&blkcg->lock);
@@ -1521,18 +1521,18 @@ void blkcg_deactivate_policy(struct gendisk *disk,
 	struct request_queue *q = disk->queue;
 	struct blkcg_gq *blkg;
 
-	if (!blkcg_policy_enabled(q, pol))
+	if (!blkcg_policy_enabled(disk, pol))
 		return;
 
 	if (queue_is_mq(q))
 		blk_mq_freeze_queue(q);
 
-	mutex_lock(&q->blkcg_mutex);
+	mutex_lock(&disk->blkcg_mutex);
 	spin_lock_irq(&q->queue_lock);
 
-	__clear_bit(pol->plid, q->blkcg_pols);
+	__clear_bit(pol->plid, disk->blkcg_pols);
 
-	list_for_each_entry(blkg, &q->blkg_list, q_node) {
+	list_for_each_entry(blkg, &disk->blkg_list, entry) {
 		struct blkcg *blkcg = blkg->blkcg;
 
 		spin_lock(&blkcg->lock);
@@ -1546,7 +1546,7 @@ void blkcg_deactivate_policy(struct gendisk *disk,
 	}
 
 	spin_unlock_irq(&q->queue_lock);
-	mutex_unlock(&q->blkcg_mutex);
+	mutex_unlock(&disk->blkcg_mutex);
 
 	if (queue_is_mq(q))
 		blk_mq_unfreeze_queue(q);
@@ -1943,7 +1943,7 @@ static inline struct blkcg_gq *blkg_tryget_closest(struct bio *bio,
  * Associate @bio with the blkg found by combining the css's blkg and the
  * request_queue of the @bio.  An association failure is handled by walking up
  * the blkg tree.  Therefore, the blkg associated can be anything between @blkg
- * and q->root_blkg.  This situation only happens when a cgroup is dying and
+ * and disk->root_blkg.  This situation only happens when a cgroup is dying and
  * then the remaining bios will spill to the closest alive blkg.
  *
  * A reference will be taken on the blkg and will be released when @bio is
@@ -1958,8 +1958,8 @@ void bio_associate_blkg_from_css(struct bio *bio,
 	if (css && css->parent) {
 		bio->bi_blkg = blkg_tryget_closest(bio, css);
 	} else {
-		blkg_get(bdev_get_queue(bio->bi_bdev)->root_blkg);
-		bio->bi_blkg = bdev_get_queue(bio->bi_bdev)->root_blkg;
+		blkg_get(bio->bi_bdev->bd_disk->root_blkg);
+		bio->bi_blkg = bio->bi_bdev->bd_disk->root_blkg;
 	}
 }
 EXPORT_SYMBOL_GPL(bio_associate_blkg_from_css);
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 151f24de253985..e442b406ca0da6 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -54,7 +54,7 @@ struct blkg_iostat_set {
 /* association between a blk cgroup and a request queue */
 struct blkcg_gq {
 	struct gendisk			*disk;
-	struct list_head		q_node;
+	struct list_head		entry;
 	struct hlist_node		blkcg_node;
 	struct blkcg			*blkcg;
 
@@ -250,7 +250,7 @@ static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg,
 	WARN_ON_ONCE(!rcu_read_lock_held());
 
 	if (blkcg == &blkcg_root)
-		return disk->queue->root_blkg;
+		return disk->root_blkg;
 
 	blkg = rcu_dereference(blkcg->blkg_hint);
 	if (blkg && blkg->disk == disk)
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index bc0d217f5c1723..5d5aa1e526b742 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -665,7 +665,7 @@ static void blkiolatency_timer_fn(struct timer_list *t)
 
 	rcu_read_lock();
 	blkg_for_each_descendant_pre(blkg, pos_css,
-				     blkiolat->rqos.disk->queue->root_blkg) {
+				     blkiolat->rqos.disk->root_blkg) {
 		struct iolatency_grp *iolat;
 		struct child_latency_info *lat_info;
 		unsigned long flags;
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 74bb1e753ea09d..902203bdddb4b4 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -451,7 +451,8 @@ static void blk_throtl_update_limit_valid(struct throtl_data *td)
 	bool low_valid = false;
 
 	rcu_read_lock();
-	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg) {
+	blkg_for_each_descendant_post(blkg, pos_css,
+			td->queue->disk->root_blkg) {
 		struct throtl_grp *tg = blkg_to_tg(blkg);
 
 		if (tg->bps[READ][LIMIT_LOW] || tg->bps[WRITE][LIMIT_LOW] ||
@@ -1180,7 +1181,7 @@ static void throtl_pending_timer_fn(struct timer_list *t)
 
 	spin_lock_irq(&q->queue_lock);
 
-	if (!q->root_blkg)
+	if (!q->disk->root_blkg)
 		goto out_unlock;
 
 	if (throtl_can_upgrade(td, NULL))
@@ -1322,7 +1323,8 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
 	 * blk-throttle.
 	 */
 	blkg_for_each_descendant_pre(blkg, pos_css,
-			global ? tg->td->queue->root_blkg : tg_to_blkg(tg)) {
+			global ? tg->td->queue->disk->root_blkg :
+			tg_to_blkg(tg)) {
 		struct throtl_grp *this_tg = blkg_to_tg(blkg);
 		struct throtl_grp *parent_tg;
 
@@ -1717,7 +1719,7 @@ void blk_throtl_cancel_bios(struct gendisk *disk)
 	 * path need RCU protection and to prevent warning from lockdep.
 	 */
 	rcu_read_lock();
-	blkg_for_each_descendant_post(blkg, pos_css, q->root_blkg) {
+	blkg_for_each_descendant_post(blkg, pos_css, disk->root_blkg) {
 		struct throtl_grp *tg = blkg_to_tg(blkg);
 		struct throtl_service_queue *sq = &tg->service_queue;
 
@@ -1871,7 +1873,8 @@ static bool throtl_can_upgrade(struct throtl_data *td,
 		return false;
 
 	rcu_read_lock();
-	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg) {
+	blkg_for_each_descendant_post(blkg, pos_css,
+			td->queue->disk->root_blkg) {
 		struct throtl_grp *tg = blkg_to_tg(blkg);
 
 		if (tg == this_tg)
@@ -1917,7 +1920,8 @@ static void throtl_upgrade_state(struct throtl_data *td)
 	td->low_upgrade_time = jiffies;
 	td->scale = 0;
 	rcu_read_lock();
-	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg) {
+	blkg_for_each_descendant_post(blkg, pos_css,
+			td->queue->disk->root_blkg) {
 		struct throtl_grp *tg = blkg_to_tg(blkg);
 		struct throtl_service_queue *sq = &tg->service_queue;
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b9637d63e6f024..79aec4ebadb9e0 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -163,6 +163,12 @@ struct gendisk {
 	struct timer_rand_state *random;
 	atomic_t sync_io;		/* RAID */
 	struct disk_events *ev;
+#ifdef CONFIG_BLK_CGROUP
+	DECLARE_BITMAP		(blkcg_pols, BLKCG_MAX_POLS);
+	struct blkcg_gq		*root_blkg;
+	struct list_head	blkg_list;
+	struct mutex		blkcg_mutex;
+#endif /* CONFIG_BLK_CGROUP */
 #ifdef  CONFIG_BLK_DEV_INTEGRITY
 	struct kobject integrity_kobj;
 #endif	/* CONFIG_BLK_DEV_INTEGRITY */
@@ -481,12 +487,6 @@ struct request_queue {
 	struct blk_mq_tags	*sched_shared_tags;
 
 	struct list_head	icq_list;
-#ifdef CONFIG_BLK_CGROUP
-	DECLARE_BITMAP		(blkcg_pols, BLKCG_MAX_POLS);
-	struct blkcg_gq		*root_blkg;
-	struct list_head	blkg_list;
-	struct mutex		blkcg_mutex;
-#endif
 
 	struct queue_limits	limits;
 
-- 
2.39.0


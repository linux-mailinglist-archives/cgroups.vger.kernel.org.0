Return-Path: <cgroups+bounces-10441-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CAAB9E0A8
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 10:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AA0F17BAC5
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 08:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30952EA475;
	Thu, 25 Sep 2025 08:25:55 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E310270569;
	Thu, 25 Sep 2025 08:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758788755; cv=none; b=WCucI2yQ3NynNfcvJPIrQ63WY4a09aHXmqopwMJbM8jotKIdybLh74K1vPaq7GxiIl4wRjR4LeZdu97M91U/A1qJlaDj3aUoqxElL/q8gUflC3xEupHCa6ooPugr2QyaWlAObgfDTs9gksuqqDudPZdn5n2/2i7NuaDA22qLYY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758788755; c=relaxed/simple;
	bh=K7Rv4zutg+2whFGHvQhmGru64tM6cIhGwtaN6VZysmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pgoOwiPwLttzcSSPUKsW3bkR9MuV4UR+n/ntQeg15c8zWbdHzZamnsYrPts7BAyI3w+Pam3x/sn20zimTy8soDHyTw2PHnG2Peroxuh+1FW8PJEcioO3yPTnU0TtGLtDfJgMPsHQ+P1Qr6HrG1VyrbHZcWBRaE6iE89k5bd6vz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cXRcQ6k4xzKHN4c;
	Thu, 25 Sep 2025 16:25:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C5CF01A1063;
	Thu, 25 Sep 2025 16:25:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCna2OH_NRodTcIAw--.12615S11;
	Thu, 25 Sep 2025 16:25:50 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: tj@kernel.org,
	ming.lei@redhat.com,
	nilay@linux.ibm.com,
	hch@lst.de,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	akpm@linux-foundation.org,
	vgoyal@redhat.com
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH 07/10] blk-cgroup: convert to protect blkgs with blkcg_mutex
Date: Thu, 25 Sep 2025 16:15:22 +0800
Message-Id: <20250925081525.700639-8-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250925081525.700639-1-yukuai1@huaweicloud.com>
References: <20250925081525.700639-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCna2OH_NRodTcIAw--.12615S11
X-Coremail-Antispam: 1UD129KBjvAXoW3tF4kJFyfGFW3AF15KrWDtwb_yoW8GF13Ko
	WfZ3yI93Z5Ww40qF93tr4qyrZ5C3ykK3yrXrn5Cr4rua1xJa4jv347JF13Ka4fuFySkr10
	qFy8J3sYga18JF4Dn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOV7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
	Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
	84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJV
	WxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE
	3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
	x0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
	JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2
	ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIY
	CTnIWIevJa73UjIFyTuYvjTRNdb1DUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

With previous modifications, queue_lock no longer grabbed under other
spinlocks and rcu for protecting blkgs, it's ok convert to blkcg_mutex
directly.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-cgroup.c  |   6 +--
 block/bfq-iosched.c |   8 ++--
 block/blk-cgroup.c  | 104 ++++++++++++++------------------------------
 block/blk-cgroup.h  |   6 +--
 4 files changed, 42 insertions(+), 82 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 9fb9f3533150..8af471d565d9 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -405,7 +405,7 @@ static void bfqg_stats_xfer_dead(struct bfq_group *bfqg)
 
 	parent = bfqg_parent(bfqg);
 
-	lockdep_assert_held(&bfqg_to_blkg(bfqg)->q->queue_lock);
+	lockdep_assert_held(&bfqg_to_blkg(bfqg)->q->blkcg_mutex);
 
 	if (unlikely(!parent))
 		return;
@@ -866,7 +866,7 @@ static void bfq_reparent_active_queues(struct bfq_data *bfqd,
  *		    and reparent its children entities.
  * @pd: descriptor of the policy going offline.
  *
- * blkio already grabs the queue_lock for us, so no need to use
+ * blkio already grabs the blkcg_mtuex for us, so no need to use
  * RCU-based magic
  */
 static void bfq_pd_offline(struct blkg_policy_data *pd)
@@ -1139,7 +1139,7 @@ static u64 bfqg_prfill_stat_recursive(struct seq_file *sf,
 	struct cgroup_subsys_state *pos_css;
 	u64 sum = 0;
 
-	lockdep_assert_held(&blkg->q->queue_lock);
+	lockdep_assert_held(&blkg->q->blkcg_mutex);
 
 	rcu_read_lock();
 	blkg_for_each_descendant_pre(pos_blkg, pos_css, blkg) {
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index a77b98187370..4ffbe4383dd2 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5266,7 +5266,7 @@ static void bfq_update_dispatch_stats(struct request_queue *q,
 	 * In addition, the following queue lock guarantees that
 	 * bfqq_group(bfqq) exists as well.
 	 */
-	spin_lock_irq(&q->queue_lock);
+	mutex_lock(&q->blkcg_mutex);
 	if (idle_timer_disabled)
 		/*
 		 * Since the idle timer has been disabled,
@@ -5285,7 +5285,7 @@ static void bfq_update_dispatch_stats(struct request_queue *q,
 		bfqg_stats_set_start_empty_time(bfqg);
 		bfqg_stats_update_io_remove(bfqg, rq->cmd_flags);
 	}
-	spin_unlock_irq(&q->queue_lock);
+	mutex_unlock(&q->blkcg_mutex);
 }
 #else
 static inline void bfq_update_dispatch_stats(struct request_queue *q,
@@ -6218,11 +6218,11 @@ static void bfq_update_insert_stats(struct request_queue *q,
 	 * In addition, the following queue lock guarantees that
 	 * bfqq_group(bfqq) exists as well.
 	 */
-	spin_lock_irq(&q->queue_lock);
+	mutex_lock(&q->blkcg_mutex);
 	bfqg_stats_update_io_add(bfqq_group(bfqq), bfqq, cmd_flags);
 	if (idle_timer_disabled)
 		bfqg_stats_update_idle_time(bfqq_group(bfqq));
-	spin_unlock_irq(&q->queue_lock);
+	mutex_unlock(&q->blkcg_mutex);
 }
 #else
 static inline void bfq_update_insert_stats(struct request_queue *q,
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 795efb5ccb5e..280f29a713b6 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -130,9 +130,7 @@ static void blkg_free_workfn(struct work_struct *work)
 			blkcg_policy[i]->pd_free_fn(blkg->pd[i]);
 	if (blkg->parent)
 		blkg_put(blkg->parent);
-	spin_lock_irq(&q->queue_lock);
 	list_del_init(&blkg->q_node);
-	spin_unlock_irq(&q->queue_lock);
 	mutex_unlock(&q->blkcg_mutex);
 
 	blk_put_queue(q);
@@ -372,7 +370,7 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
 	struct blkcg_gq *blkg;
 	int i, ret;
 
-	lockdep_assert_held(&disk->queue->queue_lock);
+	lockdep_assert_held(&disk->queue->blkcg_mutex);
 
 	/* request_queue is dying, do not create/recreate a blkg */
 	if (blk_queue_dying(disk->queue)) {
@@ -457,7 +455,7 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
  * Lookup blkg for the @blkcg - @disk pair.  If it doesn't exist, try to
  * create one.  blkg creation is performed recursively from blkcg_root such
  * that all non-root blkg's have access to the parent blkg.  This function
- * should be called under RCU read lock and takes @disk->queue->queue_lock.
+ * should be called under RCU read lock and takes @disk->queue->blkcg_mutex.
  *
  * Returns the blkg or the closest blkg if blkg_create() fails as it walks
  * down from root.
@@ -517,7 +515,7 @@ static void blkg_destroy(struct blkcg_gq *blkg)
 	struct blkcg *blkcg = blkg->blkcg;
 	int i;
 
-	lockdep_assert_held(&blkg->q->queue_lock);
+	lockdep_assert_held(&blkg->q->blkcg_mutex);
 	lockdep_assert_held(&blkcg->lock);
 
 	/*
@@ -546,8 +544,8 @@ static void blkg_destroy(struct blkcg_gq *blkg)
 
 	/*
 	 * Both setting lookup hint to and clearing it from @blkg are done
-	 * under queue_lock.  If it's not pointing to @blkg now, it never
-	 * will.  Hint assignment itself can race safely.
+	 * under q->blkcg_mutex and blkcg->lock.  If it's not pointing to @blkg
+	 * now, it never will. Hint assignment itself can race safely.
 	 */
 	if (rcu_access_pointer(blkcg->blkg_hint) == blkg)
 		rcu_assign_pointer(blkcg->blkg_hint, NULL);
@@ -567,25 +565,20 @@ static void blkg_destroy_all(struct gendisk *disk)
 	int i;
 
 restart:
-	spin_lock_irq(&q->queue_lock);
+	mutex_lock(&q->blkcg_mutex);
 	list_for_each_entry(blkg, &q->blkg_list, q_node) {
 		struct blkcg *blkcg = blkg->blkcg;
 
 		if (hlist_unhashed(&blkg->blkcg_node))
 			continue;
 
-		spin_lock(&blkcg->lock);
+		spin_lock_irq(&blkcg->lock);
 		blkg_destroy(blkg);
-		spin_unlock(&blkcg->lock);
+		spin_unlock_irq(&blkcg->lock);
 
-		/*
-		 * in order to avoid holding the spin lock for too long, release
-		 * it when a batch of blkgs are destroyed.
-		 */
 		if (!(--count)) {
 			count = BLKG_DESTROY_BATCH_SIZE;
-			spin_unlock_irq(&q->queue_lock);
-			cond_resched();
+			mutex_unlock(&q->blkcg_mutex);
 			goto restart;
 		}
 	}
@@ -603,7 +596,7 @@ static void blkg_destroy_all(struct gendisk *disk)
 	}
 
 	q->root_blkg = NULL;
-	spin_unlock_irq(&q->queue_lock);
+	mutex_unlock(&q->blkcg_mutex);
 }
 
 static void blkg_iostat_set(struct blkg_iostat *dst, struct blkg_iostat *src)
@@ -853,7 +846,7 @@ unsigned long __must_check blkg_conf_open_bdev_frozen(struct blkg_conf_ctx *ctx)
  */
 int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		   struct blkg_conf_ctx *ctx)
-	__acquires(&bdev->bd_queue->queue_lock)
+	__acquires(&bdev->bd_queue->blkcg_mutex)
 {
 	struct gendisk *disk;
 	struct request_queue *q;
@@ -869,7 +862,6 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 
 	/* Prevent concurrent with blkcg_deactivate_policy() */
 	mutex_lock(&q->blkcg_mutex);
-	spin_lock_irq(&q->queue_lock);
 
 	if (!blkcg_policy_enabled(q, pol)) {
 		ret = -EOPNOTSUPP;
@@ -895,23 +887,18 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 			parent = blkcg_parent(parent);
 		}
 
-		/* Drop locks to do new blkg allocation with GFP_KERNEL. */
-		spin_unlock_irq(&q->queue_lock);
-
 		new_blkg = blkg_alloc(pos, disk, GFP_NOIO);
 		if (unlikely(!new_blkg)) {
 			ret = -ENOMEM;
-			goto fail_exit;
+			goto fail_unlock;
 		}
 
 		if (radix_tree_preload(GFP_KERNEL)) {
 			blkg_free(new_blkg);
 			ret = -ENOMEM;
-			goto fail_exit;
+			goto fail_unlock;
 		}
 
-		spin_lock_irq(&q->queue_lock);
-
 		if (!blkcg_policy_enabled(q, pol)) {
 			blkg_free(new_blkg);
 			ret = -EOPNOTSUPP;
@@ -935,15 +922,12 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 			goto success;
 	}
 success:
-	mutex_unlock(&q->blkcg_mutex);
 	ctx->blkg = blkg;
 	return 0;
 
 fail_preloaded:
 	radix_tree_preload_end();
 fail_unlock:
-	spin_unlock_irq(&q->queue_lock);
-fail_exit:
 	mutex_unlock(&q->blkcg_mutex);
 	/*
 	 * If queue was bypassing, we should retry.  Do so after a
@@ -967,11 +951,11 @@ EXPORT_SYMBOL_GPL(blkg_conf_prep);
  * blkg_conf_ctx's initialized with blkg_conf_init().
  */
 void blkg_conf_exit(struct blkg_conf_ctx *ctx)
-	__releases(&ctx->bdev->bd_queue->queue_lock)
+	__releases(&ctx->bdev->bd_queue->blkcg_mutex)
 	__releases(&ctx->bdev->bd_queue->rq_qos_mutex)
 {
 	if (ctx->blkg) {
-		spin_unlock_irq(&bdev_get_queue(ctx->bdev)->queue_lock);
+		mutex_unlock(&bdev_get_queue(ctx->bdev)->blkcg_mutex);
 		ctx->blkg = NULL;
 	}
 
@@ -1318,13 +1302,13 @@ static void blkcg_destroy_blkgs(struct blkcg *blkcg)
 	while ((blkg = blkcg_get_first_blkg(blkcg))) {
 		struct request_queue *q = blkg->q;
 
-		spin_lock_irq(&q->queue_lock);
-		spin_lock(&blkcg->lock);
+		mutex_lock(&q->blkcg_mutex);
+		spin_lock_irq(&blkcg->lock);
 
 		blkg_destroy(blkg);
 
-		spin_unlock(&blkcg->lock);
-		spin_unlock_irq(&q->queue_lock);
+		spin_unlock_irq(&blkcg->lock);
+		mutex_unlock(&q->blkcg_mutex);
 
 		blkg_put(blkg);
 		cond_resched();
@@ -1501,24 +1485,23 @@ int blkcg_init_disk(struct gendisk *disk)
 	if (!new_blkg)
 		return -ENOMEM;
 
-	preloaded = !radix_tree_preload(GFP_KERNEL);
+	mutex_lock(&q->blkcg_mutex);
+	preloaded = !radix_tree_preload(GFP_NOIO);
 
 	/* Make sure the root blkg exists. */
-	/* spin_lock_irq can serve as RCU read-side critical section. */
-	spin_lock_irq(&q->queue_lock);
 	blkg = blkg_create(&blkcg_root, disk, new_blkg);
 	if (IS_ERR(blkg))
 		goto err_unlock;
 	q->root_blkg = blkg;
-	spin_unlock_irq(&q->queue_lock);
 
 	if (preloaded)
 		radix_tree_preload_end();
+	mutex_unlock(&q->blkcg_mutex);
 
 	return 0;
 
 err_unlock:
-	spin_unlock_irq(&q->queue_lock);
+	mutex_unlock(&q->blkcg_mutex);
 	if (preloaded)
 		radix_tree_preload_end();
 	return PTR_ERR(blkg);
@@ -1595,8 +1578,7 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 
 	if (queue_is_mq(q))
 		memflags = blk_mq_freeze_queue(q);
-retry:
-	spin_lock_irq(&q->queue_lock);
+	mutex_lock(&q->blkcg_mutex);
 
 	/* blkg_list is pushed at the head, reverse walk to initialize parents first */
 	list_for_each_entry_reverse(blkg, &q->blkg_list, q_node) {
@@ -1605,36 +1587,17 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 		if (blkg->pd[pol->plid])
 			continue;
 
-		/* If prealloc matches, use it; otherwise try GFP_NOWAIT */
+		/* If prealloc matches, use it */
 		if (blkg == pinned_blkg) {
 			pd = pd_prealloc;
 			pd_prealloc = NULL;
 		} else {
 			pd = pol->pd_alloc_fn(disk, blkg->blkcg,
-					      GFP_NOWAIT);
+					      GFP_NOIO);
 		}
 
-		if (!pd) {
-			/*
-			 * GFP_NOWAIT failed.  Free the existing one and
-			 * prealloc for @blkg w/ GFP_KERNEL.
-			 */
-			if (pinned_blkg)
-				blkg_put(pinned_blkg);
-			blkg_get(blkg);
-			pinned_blkg = blkg;
-
-			spin_unlock_irq(&q->queue_lock);
-
-			if (pd_prealloc)
-				pol->pd_free_fn(pd_prealloc);
-			pd_prealloc = pol->pd_alloc_fn(disk, blkg->blkcg,
-						       GFP_KERNEL);
-			if (pd_prealloc)
-				goto retry;
-			else
-				goto enomem;
-		}
+		if (!pd)
+			goto enomem;
 
 		spin_lock(&blkg->blkcg->lock);
 
@@ -1655,8 +1618,8 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 	__set_bit(pol->plid, q->blkcg_pols);
 	ret = 0;
 
-	spin_unlock_irq(&q->queue_lock);
 out:
+	mutex_unlock(&q->blkcg_mutex);
 	if (queue_is_mq(q))
 		blk_mq_unfreeze_queue(q, memflags);
 	if (pinned_blkg)
@@ -1667,7 +1630,6 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 
 enomem:
 	/* alloc failed, take down everything */
-	spin_lock_irq(&q->queue_lock);
 	list_for_each_entry(blkg, &q->blkg_list, q_node) {
 		struct blkcg *blkcg = blkg->blkcg;
 		struct blkg_policy_data *pd;
@@ -1683,7 +1645,7 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 		}
 		spin_unlock(&blkcg->lock);
 	}
-	spin_unlock_irq(&q->queue_lock);
+
 	ret = -ENOMEM;
 	goto out;
 }
@@ -1711,7 +1673,6 @@ void blkcg_deactivate_policy(struct gendisk *disk,
 		memflags = blk_mq_freeze_queue(q);
 
 	mutex_lock(&q->blkcg_mutex);
-	spin_lock_irq(&q->queue_lock);
 
 	__clear_bit(pol->plid, q->blkcg_pols);
 
@@ -1728,7 +1689,6 @@ void blkcg_deactivate_policy(struct gendisk *disk,
 		spin_unlock(&blkcg->lock);
 	}
 
-	spin_unlock_irq(&q->queue_lock);
 	mutex_unlock(&q->blkcg_mutex);
 
 	if (queue_is_mq(q))
@@ -2118,11 +2078,11 @@ static inline struct blkcg_gq *blkg_tryget_closest(struct bio *bio,
 	 * Fast path failed, we're probably issuing IO in this cgroup the first
 	 * time, hold lock to create new blkg.
 	 */
-	spin_lock_irq(&q->queue_lock);
+	mutex_lock(&q->blkcg_mutex);
 	blkg = blkg_lookup_create(blkcg, bio->bi_bdev->bd_disk);
 	if (blkg)
 		blkg = blkg_lookup_tryget(blkg);
-	spin_unlock_irq(&q->queue_lock);
+	mutex_unlock(&q->blkcg_mutex);
 
 	return blkg;
 }
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 1cce3294634d..60c1da02f437 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -261,7 +261,7 @@ static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg,
 		return q->root_blkg;
 
 	blkg = rcu_dereference_check(blkcg->blkg_hint,
-			lockdep_is_held(&q->queue_lock));
+			lockdep_is_held(&q->blkcg_mutex));
 	if (blkg && blkg->q == q)
 		return blkg;
 
@@ -345,8 +345,8 @@ static inline void blkg_put(struct blkcg_gq *blkg)
  * @p_blkg: target blkg to walk descendants of
  *
  * Walk @c_blkg through the descendants of @p_blkg.  Must be used with RCU
- * read locked.  If called under either blkcg or queue lock, the iteration
- * is guaranteed to include all and only online blkgs.  The caller may
+ * read locked.  If called under either blkcg->lock or q->blkcg_mutex, the
+ * iteration is guaranteed to include all and only online blkgs.  The caller may
  * update @pos_css by calling css_rightmost_descendant() to skip subtree.
  * @p_blkg is included in the iteration and the first node to be visited.
  */
-- 
2.39.2



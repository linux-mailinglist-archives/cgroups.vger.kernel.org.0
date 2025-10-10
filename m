Return-Path: <cgroups+bounces-10638-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D86A0BCC4B8
	for <lists+cgroups@lfdr.de>; Fri, 10 Oct 2025 11:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E7AD4240AC
	for <lists+cgroups@lfdr.de>; Fri, 10 Oct 2025 09:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E015F278779;
	Fri, 10 Oct 2025 09:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9h37Oef"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8717B276028;
	Fri, 10 Oct 2025 09:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760087718; cv=none; b=mhZcN3E/FK6o6aX5g5cDvZz3sG3+HTF1QeRaDSiQ1l3FzZ+qqXDpQWcTKhVb3BY147pGzGBhnP10nTlA1RBjqEQ/A2JK28Qv/RtMaAz9WrY5zmasj1L0HFhzqbc/+02Yp14fTtU4f0YNtHrsh5bxGzuxGGsKIvCWnWkWNdNCVQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760087718; c=relaxed/simple;
	bh=uYE/yAafPPuAnGJJP42MriRS+/0j7WIjEApVU97Vx54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGZFLrCReTIjkUWtcmP3IB5NfKPFEpJkAsOu7JkVPjJsUZ0YtTGlFZg0VIoMwWAUQ4SXlLwtVaAmv5RXi5beFvblNxjJxy2gUp3S1rufi+FkLEZOeAhPqQaEpBVxuoxr64ljMX9poJOKrhemA/dWFbMRk5hBr/ZisdH2mkeJy5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9h37Oef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00FEC4CEFE;
	Fri, 10 Oct 2025 09:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760087718;
	bh=uYE/yAafPPuAnGJJP42MriRS+/0j7WIjEApVU97Vx54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S9h37OefhinypiSuMwFvj4JTG8mIMiQaEKqxpdYJQOF2vl2hEP7AsBeKYQBVDK2iC
	 xUZp4UJvGoCmQjimy1a7zOS8BIEzq39BIG6JBBkdmxUf3J5ymHLTKqD+BsEKflPw9Y
	 tXfmfzzM7KGMEzkm0UJFa/DdqiP3WMBRgBxVeyA30MVqMDQLaa8GNq42z17bE4M0Qf
	 aIC0XcPqUjIKXbARnn4nR1UBf3yO2eMQwF6eNeVlODFkAq7dRaeTn92ctXWzZ7sGiB
	 i1r4BBfEEn1VXMsIwsOAya5Y4ZB+9xcBcTV5lxj5jG62FmnUJc/zpkcPzAUO8WO104
	 EUtXaBwjyWlkw==
From: Yu Kuai <yukuai@kernel.org>
To: axboe@kernel.dk,
	tj@kernel.org,
	linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	nilay@linux.ibm.com,
	bvanassche@acm.org,
	ming.lei@redhat.com,
	hch@lst.de
Cc: linux-kernel@vger.kernel.org,
	Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH v2 09/19] blk-cgroup: convert to protect blkgs with blkcg_mutex
Date: Fri, 10 Oct 2025 17:14:34 +0800
Message-ID: <20251010091446.3048529-10-yukuai@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010091446.3048529-1-yukuai@kernel.org>
References: <20251010091446.3048529-1-yukuai@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index a7e705d98751..43790ae91b57 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -405,7 +405,7 @@ static void bfqg_stats_xfer_dead(struct bfq_group *bfqg)
 
 	parent = bfqg_parent(bfqg);
 
-	lockdep_assert_held(&bfqg_to_blkg(bfqg)->q->queue_lock);
+	lockdep_assert_held(&bfqg_to_blkg(bfqg)->q->blkcg_mutex);
 
 	if (unlikely(!parent))
 		return;
@@ -872,7 +872,7 @@ static void bfq_reparent_active_queues(struct bfq_data *bfqd,
  *		    and reparent its children entities.
  * @pd: descriptor of the policy going offline.
  *
- * blkio already grabs the queue_lock for us, so no need to use
+ * blkio already grabs the blkcg_mtuex for us, so no need to use
  * RCU-based magic
  */
 static void bfq_pd_offline(struct blkg_policy_data *pd)
@@ -1145,7 +1145,7 @@ static u64 bfqg_prfill_stat_recursive(struct seq_file *sf,
 	struct cgroup_subsys_state *pos_css;
 	u64 sum = 0;
 
-	lockdep_assert_held(&blkg->q->queue_lock);
+	lockdep_assert_held(&blkg->q->blkcg_mutex);
 
 	rcu_read_lock();
 	blkg_for_each_descendant_pre(pos_blkg, pos_css, blkg) {
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 86309828e235..3350c9b22eb4 100644
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
index 99edf15ce525..b8bb2f3506aa 100644
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
@@ -854,7 +847,7 @@ unsigned long __must_check blkg_conf_open_bdev_frozen(struct blkg_conf_ctx *ctx)
  */
 int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		   struct blkg_conf_ctx *ctx)
-	__acquires(&bdev->bd_queue->queue_lock)
+	__acquires(&bdev->bd_queue->blkcg_mutex)
 {
 	struct gendisk *disk;
 	struct request_queue *q;
@@ -870,7 +863,6 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 
 	/* Prevent concurrent with blkcg_deactivate_policy() */
 	mutex_lock(&q->blkcg_mutex);
-	spin_lock_irq(&q->queue_lock);
 
 	if (!blkcg_policy_enabled(q, pol)) {
 		ret = -EOPNOTSUPP;
@@ -896,23 +888,18 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
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
@@ -936,15 +923,12 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
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
@@ -968,11 +952,11 @@ EXPORT_SYMBOL_GPL(blkg_conf_prep);
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
 
@@ -1319,13 +1303,13 @@ static void blkcg_destroy_blkgs(struct blkcg *blkcg)
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
@@ -1502,24 +1486,23 @@ int blkcg_init_disk(struct gendisk *disk)
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
@@ -1596,8 +1579,7 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 
 	if (queue_is_mq(q))
 		memflags = blk_mq_freeze_queue(q);
-retry:
-	spin_lock_irq(&q->queue_lock);
+	mutex_lock(&q->blkcg_mutex);
 
 	/* blkg_list is pushed at the head, reverse walk to initialize parents first */
 	list_for_each_entry_reverse(blkg, &q->blkg_list, q_node) {
@@ -1606,36 +1588,17 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
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
 
@@ -1656,8 +1619,8 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 	__set_bit(pol->plid, q->blkcg_pols);
 	ret = 0;
 
-	spin_unlock_irq(&q->queue_lock);
 out:
+	mutex_unlock(&q->blkcg_mutex);
 	if (queue_is_mq(q))
 		blk_mq_unfreeze_queue(q, memflags);
 	if (pinned_blkg)
@@ -1668,7 +1631,6 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 
 enomem:
 	/* alloc failed, take down everything */
-	spin_lock_irq(&q->queue_lock);
 	list_for_each_entry(blkg, &q->blkg_list, q_node) {
 		struct blkcg *blkcg = blkg->blkcg;
 		struct blkg_policy_data *pd;
@@ -1684,7 +1646,7 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 		}
 		spin_unlock(&blkcg->lock);
 	}
-	spin_unlock_irq(&q->queue_lock);
+
 	ret = -ENOMEM;
 	goto out;
 }
@@ -1712,7 +1674,6 @@ void blkcg_deactivate_policy(struct gendisk *disk,
 		memflags = blk_mq_freeze_queue(q);
 
 	mutex_lock(&q->blkcg_mutex);
-	spin_lock_irq(&q->queue_lock);
 
 	__clear_bit(pol->plid, q->blkcg_pols);
 
@@ -1729,7 +1690,6 @@ void blkcg_deactivate_policy(struct gendisk *disk,
 		spin_unlock(&blkcg->lock);
 	}
 
-	spin_unlock_irq(&q->queue_lock);
 	mutex_unlock(&q->blkcg_mutex);
 
 	if (queue_is_mq(q))
@@ -2119,11 +2079,11 @@ static inline struct blkcg_gq *blkg_tryget_closest(struct bio *bio,
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
index fd206d1fa3c9..540be30aebcd 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -263,7 +263,7 @@ static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg,
 		return q->root_blkg;
 
 	blkg = rcu_dereference_check(blkcg->blkg_hint,
-			lockdep_is_held(&q->queue_lock));
+			lockdep_is_held(&q->blkcg_mutex));
 	if (blkg && blkg->q == q)
 		return blkg;
 
@@ -347,8 +347,8 @@ static inline void blkg_put(struct blkcg_gq *blkg)
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
2.51.0



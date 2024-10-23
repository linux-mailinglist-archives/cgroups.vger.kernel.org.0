Return-Path: <cgroups+bounces-5189-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5209AC0E7
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2024 10:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF686284CB6
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2024 08:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFBC157495;
	Wed, 23 Oct 2024 08:00:55 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21AB14D70F;
	Wed, 23 Oct 2024 08:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729670455; cv=none; b=gAxxMmmFtENfGMaP7BSZPj1xZgGZLlSuMNKU6P360jSlDJMKdtEbvyan4dmbmM6LdMAIBfd5na/L5qES7zLVavS397gT/1/E5svRv+V/16FFp55E81ilvbCZycopQuThCtD9J4awj9CihgDFJjHLgBcDuppdCc/g2t44w+UzwMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729670455; c=relaxed/simple;
	bh=m0dvD1lqdMm8GtG6vkWHLcvMWDfGWIs1/Fg7eJ2l6bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y81CYIGwFw/oVHh1x5ntNn1RnyBv6jcffmtCNOuHlyLNF4VaVa+Dz5sNcTg//lwcGqHSOVdYp/z378ZzS4U5TlONd2kNRw/IVA0pVt7wgkPdNadMIsM6RAqw5Km2Ki0TW2Q34o62/qKlrrvlqH/Qfwzb217JuuxS+DX5BpB50s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=mblankhorst.nl; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mblankhorst.nl
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: intel-xe@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Friedrich Vock <friedrich.vock@gmx.de>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH 3/7] drm/ttm: Handle cgroup based eviction in TTM
Date: Wed, 23 Oct 2024 09:52:56 +0200
Message-ID: <20241023075302.27194-4-maarten.lankhorst@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241023075302.27194-1-maarten.lankhorst@linux.intel.com>
References: <20241023075302.27194-1-maarten.lankhorst@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cgroup resource allocation has to be handled in TTM, so -EAGAIN from
cgroups can be converted into -ENOSPC, and the limitcg can be properly
evicted in ttm code.

When hitting a resource limit through -EAGAIN, the cgroup for which the
limit is hit is also returned. This allows eviction to delete only from
cgroups which are a subgroup of the current cgroup.

The returned CSS is used to determine if eviction is valuable for a
given resource, and allows TTM to only target specific resources to
lower memory usage.

Co-developed-by: Friedrich Vock <friedrich.vock@gmx.de>
Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
Co-developed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
---
 drivers/gpu/drm/ttm/tests/ttm_bo_test.c       | 18 +++---
 .../gpu/drm/ttm/tests/ttm_bo_validate_test.c  |  4 +-
 drivers/gpu/drm/ttm/tests/ttm_resource_test.c |  2 +-
 drivers/gpu/drm/ttm/ttm_bo.c                  | 57 ++++++++++++++++---
 drivers/gpu/drm/ttm/ttm_resource.c            | 24 +++++++-
 include/drm/ttm/ttm_resource.h                | 16 +++++-
 6 files changed, 98 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c b/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
index 3139fd9128d84..f8f20d2f61740 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
@@ -258,13 +258,13 @@ static void ttm_bo_unreserve_basic(struct kunit *test)
 	bo = ttm_bo_kunit_init(test, test->priv, BO_SIZE, NULL);
 	bo->priority = bo_prio;
 
-	err = ttm_resource_alloc(bo, place, &res1);
+	err = ttm_resource_alloc(bo, place, &res1, NULL);
 	KUNIT_ASSERT_EQ(test, err, 0);
 
 	bo->resource = res1;
 
 	/* Add a dummy resource to populate LRU */
-	ttm_resource_alloc(bo, place, &res2);
+	ttm_resource_alloc(bo, place, &res2, NULL);
 
 	dma_resv_lock(bo->base.resv, NULL);
 	ttm_bo_unreserve(bo);
@@ -300,12 +300,12 @@ static void ttm_bo_unreserve_pinned(struct kunit *test)
 	dma_resv_lock(bo->base.resv, NULL);
 	ttm_bo_pin(bo);
 
-	err = ttm_resource_alloc(bo, place, &res1);
+	err = ttm_resource_alloc(bo, place, &res1, NULL);
 	KUNIT_ASSERT_EQ(test, err, 0);
 	bo->resource = res1;
 
 	/* Add a dummy resource to the pinned list */
-	err = ttm_resource_alloc(bo, place, &res2);
+	err = ttm_resource_alloc(bo, place, &res2, NULL);
 	KUNIT_ASSERT_EQ(test, err, 0);
 	KUNIT_ASSERT_EQ(test,
 			list_is_last(&res2->lru.link, &priv->ttm_dev->unevictable), 1);
@@ -355,7 +355,7 @@ static void ttm_bo_unreserve_bulk(struct kunit *test)
 	ttm_bo_set_bulk_move(bo1, &lru_bulk_move);
 	dma_resv_unlock(bo1->base.resv);
 
-	err = ttm_resource_alloc(bo1, place, &res1);
+	err = ttm_resource_alloc(bo1, place, &res1, NULL);
 	KUNIT_ASSERT_EQ(test, err, 0);
 	bo1->resource = res1;
 
@@ -363,7 +363,7 @@ static void ttm_bo_unreserve_bulk(struct kunit *test)
 	ttm_bo_set_bulk_move(bo2, &lru_bulk_move);
 	dma_resv_unlock(bo2->base.resv);
 
-	err = ttm_resource_alloc(bo2, place, &res2);
+	err = ttm_resource_alloc(bo2, place, &res2, NULL);
 	KUNIT_ASSERT_EQ(test, err, 0);
 	bo2->resource = res2;
 
@@ -401,7 +401,7 @@ static void ttm_bo_put_basic(struct kunit *test)
 	bo = ttm_bo_kunit_init(test, test->priv, BO_SIZE, NULL);
 	bo->type = ttm_bo_type_device;
 
-	err = ttm_resource_alloc(bo, place, &res);
+	err = ttm_resource_alloc(bo, place, &res, NULL);
 	KUNIT_ASSERT_EQ(test, err, 0);
 	bo->resource = res;
 
@@ -518,7 +518,7 @@ static void ttm_bo_pin_unpin_resource(struct kunit *test)
 
 	bo = ttm_bo_kunit_init(test, test->priv, BO_SIZE, NULL);
 
-	err = ttm_resource_alloc(bo, place, &res);
+	err = ttm_resource_alloc(bo, place, &res, NULL);
 	KUNIT_ASSERT_EQ(test, err, 0);
 	bo->resource = res;
 
@@ -569,7 +569,7 @@ static void ttm_bo_multiple_pin_one_unpin(struct kunit *test)
 
 	bo = ttm_bo_kunit_init(test, test->priv, BO_SIZE, NULL);
 
-	err = ttm_resource_alloc(bo, place, &res);
+	err = ttm_resource_alloc(bo, place, &res, NULL);
 	KUNIT_ASSERT_EQ(test, err, 0);
 	bo->resource = res;
 
diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
index 1adf18481ea05..3148f5d3dbd66 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
@@ -542,7 +542,7 @@ static void ttm_bo_validate_no_placement_signaled(struct kunit *test)
 		bo->ttm = old_tt;
 	}
 
-	err = ttm_resource_alloc(bo, place, &bo->resource);
+	err = ttm_resource_alloc(bo, place, &bo->resource, NULL);
 	KUNIT_EXPECT_EQ(test, err, 0);
 	KUNIT_ASSERT_EQ(test, man->usage, size);
 
@@ -603,7 +603,7 @@ static void ttm_bo_validate_no_placement_not_signaled(struct kunit *test)
 	bo = ttm_bo_kunit_init(test, test->priv, size, NULL);
 	bo->type = params->bo_type;
 
-	err = ttm_resource_alloc(bo, place, &bo->resource);
+	err = ttm_resource_alloc(bo, place, &bo->resource, NULL);
 	KUNIT_EXPECT_EQ(test, err, 0);
 
 	placement = kunit_kzalloc(test, sizeof(*placement), GFP_KERNEL);
diff --git a/drivers/gpu/drm/ttm/tests/ttm_resource_test.c b/drivers/gpu/drm/ttm/tests/ttm_resource_test.c
index a9f4b81921c3c..e6ea2bd01f07a 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_resource_test.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_resource_test.c
@@ -302,7 +302,7 @@ static void ttm_sys_man_free_basic(struct kunit *test)
 	res = kunit_kzalloc(test, sizeof(*res), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, res);
 
-	ttm_resource_alloc(bo, place, &res);
+	ttm_resource_alloc(bo, place, &res, NULL);
 
 	man = ttm_manager_type(priv->devs->ttm_dev, mem_type);
 	man->func->free(man, res);
diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 48c5365efca1c..5bdebfdc95e92 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -42,6 +42,7 @@
 #include <linux/file.h>
 #include <linux/module.h>
 #include <linux/atomic.h>
+#include <linux/cgroup_dev.h>
 #include <linux/dma-resv.h>
 
 #include "ttm_module.h"
@@ -447,7 +448,7 @@ int ttm_bo_evict_first(struct ttm_device *bdev, struct ttm_resource_manager *man
 	struct ttm_buffer_object *bo;
 	struct ttm_resource *res;
 	unsigned int mem_type;
-	int ret = 0;
+	int ret;
 
 	spin_lock(&bdev->lru_lock);
 	res = ttm_resource_manager_first(man, &cursor);
@@ -499,14 +500,28 @@ struct ttm_bo_evict_walk {
 	struct ttm_resource **res;
 	/** @evicted: Number of successful evictions. */
 	unsigned long evicted;
+
+	/** @limit_pool: Which pool limit we should test against */
+	struct dev_cgroup_pool_state *limit_pool;
+	/** @try_low: Whether we should attempt to evict BO's with low watermark threshold */
+	bool try_low;
+	/** @hit_low: If we cannot evict a bo when @try_low is false (first pass) */
+	bool hit_low;
 };
 
 static s64 ttm_bo_evict_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *bo)
 {
 	struct ttm_bo_evict_walk *evict_walk =
 		container_of(walk, typeof(*evict_walk), walk);
+	struct ttm_resource_manager *man =
+			ttm_manager_type(bo->bdev, bo->resource->mem_type);
 	s64 lret;
 
+	if (!dev_cgroup_state_evict_valuable(man->cgdev, man->cgidx,
+					     evict_walk->limit_pool, bo->resource->css,
+					     evict_walk->try_low, &evict_walk->hit_low))
+		return 0;
+
 	if (bo->pin_count || !bo->bdev->funcs->eviction_valuable(bo, evict_walk->place))
 		return 0;
 
@@ -524,7 +539,7 @@ static s64 ttm_bo_evict_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *
 	evict_walk->evicted++;
 	if (evict_walk->res)
 		lret = ttm_resource_alloc(evict_walk->evictor, evict_walk->place,
-					  evict_walk->res);
+					  evict_walk->res, NULL);
 	if (lret == 0)
 		return 1;
 out:
@@ -545,7 +560,8 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev,
 			      struct ttm_buffer_object *evictor,
 			      struct ttm_operation_ctx *ctx,
 			      struct ww_acquire_ctx *ticket,
-			      struct ttm_resource **res)
+			      struct ttm_resource **res,
+			      struct dev_cgroup_pool_state *limit_pool)
 {
 	struct ttm_bo_evict_walk evict_walk = {
 		.walk = {
@@ -556,22 +572,39 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev,
 		.place = place,
 		.evictor = evictor,
 		.res = res,
+		.limit_pool = limit_pool,
 	};
 	s64 lret;
 
 	evict_walk.walk.trylock_only = true;
 	lret = ttm_lru_walk_for_evict(&evict_walk.walk, bdev, man, 1);
+
+	/* One more attempt if we hit low limit? */
+	if (!lret && evict_walk.hit_low) {
+		evict_walk.try_low = true;
+		lret = ttm_lru_walk_for_evict(&evict_walk.walk, bdev, man, 1);
+	}
 	if (lret || !ticket)
 		goto out;
 
+	/* Reset low limit */
+	evict_walk.try_low = evict_walk.hit_low = false;
 	/* If ticket-locking, repeat while making progress. */
 	evict_walk.walk.trylock_only = false;
+
+retry:
 	do {
 		/* The walk may clear the evict_walk.walk.ticket field */
 		evict_walk.walk.ticket = ticket;
 		evict_walk.evicted = 0;
 		lret = ttm_lru_walk_for_evict(&evict_walk.walk, bdev, man, 1);
 	} while (!lret && evict_walk.evicted);
+
+	/* We hit the low limit? Try once more */
+	if (!lret && evict_walk.hit_low && !evict_walk.try_low) {
+		evict_walk.try_low = true;
+		goto retry;
+	}
 out:
 	if (lret < 0)
 		return lret;
@@ -689,6 +722,7 @@ static int ttm_bo_alloc_resource(struct ttm_buffer_object *bo,
 
 	for (i = 0; i < placement->num_placement; ++i) {
 		const struct ttm_place *place = &placement->placement[i];
+		struct dev_cgroup_pool_state *limit_pool = NULL;
 		struct ttm_resource_manager *man;
 		bool may_evict;
 
@@ -701,15 +735,20 @@ static int ttm_bo_alloc_resource(struct ttm_buffer_object *bo,
 			continue;
 
 		may_evict = (force_space && place->mem_type != TTM_PL_SYSTEM);
-		ret = ttm_resource_alloc(bo, place, res);
+		ret = ttm_resource_alloc(bo, place, res, force_space ? &limit_pool : NULL);
 		if (ret) {
-			if (ret != -ENOSPC)
+			if (ret != -ENOSPC && ret != -EAGAIN) {
+				dev_cgroup_pool_state_put(limit_pool);
 				return ret;
-			if (!may_evict)
+			}
+			if (!may_evict) {
+				dev_cgroup_pool_state_put(limit_pool);
 				continue;
+			}
 
 			ret = ttm_bo_evict_alloc(bdev, man, place, bo, ctx,
-						 ticket, res);
+						 ticket, res, limit_pool);
+			dev_cgroup_pool_state_put(limit_pool);
 			if (ret == -EBUSY)
 				continue;
 			if (ret)
@@ -1056,6 +1095,8 @@ struct ttm_bo_swapout_walk {
 	struct ttm_lru_walk walk;
 	/** @gfp_flags: The gfp flags to use for ttm_tt_swapout() */
 	gfp_t gfp_flags;
+
+	bool hit_low, evict_low;
 };
 
 static s64
@@ -1106,7 +1147,7 @@ ttm_bo_swapout_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *bo)
 
 		memset(&hop, 0, sizeof(hop));
 		place.mem_type = TTM_PL_SYSTEM;
-		ret = ttm_resource_alloc(bo, &place, &evict_mem);
+		ret = ttm_resource_alloc(bo, &place, &evict_mem, NULL);
 		if (ret)
 			goto out;
 
diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
index a87665eb28a62..93190f7330b5c 100644
--- a/drivers/gpu/drm/ttm/ttm_resource.c
+++ b/drivers/gpu/drm/ttm/ttm_resource.c
@@ -26,6 +26,7 @@
 #include <linux/io-mapping.h>
 #include <linux/iosys-map.h>
 #include <linux/scatterlist.h>
+#include <linux/cgroup_dev.h>
 
 #include <drm/ttm/ttm_bo.h>
 #include <drm/ttm/ttm_placement.h>
@@ -350,15 +351,29 @@ EXPORT_SYMBOL(ttm_resource_fini);
 
 int ttm_resource_alloc(struct ttm_buffer_object *bo,
 		       const struct ttm_place *place,
-		       struct ttm_resource **res_ptr)
+		       struct ttm_resource **res_ptr,
+		       struct dev_cgroup_pool_state **ret_limit_pool)
 {
 	struct ttm_resource_manager *man =
 		ttm_manager_type(bo->bdev, place->mem_type);
+	struct dev_cgroup_pool_state *pool = NULL;
 	int ret;
 
+	if (man->cgdev) {
+		ret = dev_cgroup_try_charge(man->cgdev, man->cgidx,
+					    bo->base.size, &pool, ret_limit_pool);
+		if (ret)
+			return ret;
+	}
+
 	ret = man->func->alloc(man, bo, place, res_ptr);
-	if (ret)
+	if (ret) {
+		if (pool)
+			dev_cgroup_uncharge(pool, man->cgidx, bo->base.size);
 		return ret;
+	}
+
+	(*res_ptr)->css = pool;
 
 	spin_lock(&bo->bdev->lru_lock);
 	ttm_resource_add_bulk_move(*res_ptr, bo);
@@ -370,6 +385,7 @@ EXPORT_SYMBOL_FOR_TESTS_ONLY(ttm_resource_alloc);
 void ttm_resource_free(struct ttm_buffer_object *bo, struct ttm_resource **res)
 {
 	struct ttm_resource_manager *man;
+	struct dev_cgroup_pool_state *pool;
 
 	if (!*res)
 		return;
@@ -377,9 +393,13 @@ void ttm_resource_free(struct ttm_buffer_object *bo, struct ttm_resource **res)
 	spin_lock(&bo->bdev->lru_lock);
 	ttm_resource_del_bulk_move(*res, bo);
 	spin_unlock(&bo->bdev->lru_lock);
+
+	pool = (*res)->css;
 	man = ttm_manager_type(bo->bdev, (*res)->mem_type);
 	man->func->free(man, *res);
 	*res = NULL;
+	if (man->cgdev)
+		dev_cgroup_uncharge(pool, man->cgidx, bo->base.size);
 }
 EXPORT_SYMBOL(ttm_resource_free);
 
diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ttm_resource.h
index be034be56ba1b..12ff4b66c6f7d 100644
--- a/include/drm/ttm/ttm_resource.h
+++ b/include/drm/ttm/ttm_resource.h
@@ -38,6 +38,7 @@
 #define TTM_MAX_BO_PRIORITY	4U
 #define TTM_NUM_MEM_TYPES 8
 
+struct dev_cgroup_device;
 struct ttm_device;
 struct ttm_resource_manager;
 struct ttm_resource;
@@ -211,6 +212,15 @@ struct ttm_resource_manager {
 	 * bdev->lru_lock.
 	 */
 	uint64_t usage;
+
+	/**
+	 * @cgdev: dev_cgroup_device used for memory accounting, if not NULL.
+	 */
+	struct dev_cgroup_device *cgdev;
+	/**
+	 * @cgidx: Resource index used by this resource manager for cgroup accounting
+	 */
+	u32 cgidx;
 };
 
 /**
@@ -239,6 +249,7 @@ struct ttm_bus_placement {
  * @placement: Placement flags.
  * @bus: Placement on io bus accessible to the CPU
  * @bo: weak reference to the BO, protected by ttm_device::lru_lock
+ * @css: cgroup state this resource is charged to
  *
  * Structure indicating the placement and space resources used by a
  * buffer object.
@@ -251,6 +262,8 @@ struct ttm_resource {
 	struct ttm_bus_placement bus;
 	struct ttm_buffer_object *bo;
 
+	struct dev_cgroup_pool_state *css;
+
 	/**
 	 * @lru: Least recently used list, see &ttm_resource_manager.lru
 	 */
@@ -432,7 +445,8 @@ void ttm_resource_fini(struct ttm_resource_manager *man,
 
 int ttm_resource_alloc(struct ttm_buffer_object *bo,
 		       const struct ttm_place *place,
-		       struct ttm_resource **res);
+		       struct ttm_resource **res,
+		       struct dev_cgroup_pool_state **ret_limit_pool);
 void ttm_resource_free(struct ttm_buffer_object *bo, struct ttm_resource **res);
 bool ttm_resource_intersects(struct ttm_device *bdev,
 			     struct ttm_resource *res,
-- 
2.45.2



Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E80750721
	for <lists+cgroups@lfdr.de>; Wed, 12 Jul 2023 13:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjGLLvp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jul 2023 07:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233536AbjGLLvX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jul 2023 07:51:23 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3B430E6;
        Wed, 12 Jul 2023 04:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689162590; x=1720698590;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pTDsHp5N+DNZ4FPD2rGEEDX1s4pQgY6qlebjQjJtQfU=;
  b=WMbWPw1hUyitUaAzkRV0k1RUs9bhAfD3A5b7ShEVTkzNAnkiUBr+PHx3
   eoGYUmVUbR7AtSiNDZ3VzgIQu18ExOQmbiwhst1NIU/wbNm0hUKYjDze5
   xMUGpol3Qimm/jE3tnlYLxwjrDou3bu929iJih07IpNlTrt3zQ0v32aY6
   Hz1rPo5EW0WJM/UuA7w0B0S4ez2oqpHwjG9SaZnL4HZ1cJ9uNMCjN+0mr
   It6u41IUf0pMkRdT0CYW+ZmIl/gUlnr4Ik325zd56OMt5bRxbLi8N+neO
   p3RBAwhxrw60WYnudP7LuU8RJ+z4jHwchyfsKZcr8tdcvN/Cm62y+eepD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="344469441"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="344469441"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 04:47:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="866094186"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="866094186"
Received: from eamonnob-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.213.237.202])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 04:47:17 -0700
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To:     Intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@chromium.org>,
        "T . J . Mercier" <tjmercier@google.com>, Kenny.Ho@amd.com,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Brian Welty <brian.welty@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: [PATCH 17/17] drm/i915: Wire up to the drm cgroup memory stats
Date:   Wed, 12 Jul 2023 12:46:05 +0100
Message-Id: <20230712114605.519432-18-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230712114605.519432-1-tvrtko.ursulin@linux.intel.com>
References: <20230712114605.519432-1-tvrtko.ursulin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

Simply refactor the existing helpers which collate the data for fdinfo
and share them with thin drm cgroup controller callbacks.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
---
 drivers/gpu/drm/i915/i915_driver.c     |   4 +
 drivers/gpu/drm/i915/i915_drm_client.c | 183 ++++++++++++++++---------
 drivers/gpu/drm/i915/i915_drm_client.h |  11 +-
 3 files changed, 129 insertions(+), 69 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index 3b9d47c2097b..a299edc9eb79 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -1795,6 +1795,10 @@ static const struct drm_ioctl_desc i915_ioctls[] = {
 static const struct drm_cgroup_ops i915_drm_cgroup_ops = {
 	.active_time_us = i915_drm_cgroup_get_active_time_us,
 	.signal_budget = i915_drm_cgroup_signal_budget,
+
+	.num_memory_regions	= i915_drm_cgroup_num_memory_regions,
+	.memory_region_name	= i915_drm_cgroup_memory_region_name,
+	.memory_stats		= i915_drm_cgroup_memory_stats,
 };
 #endif
 
diff --git a/drivers/gpu/drm/i915/i915_drm_client.c b/drivers/gpu/drm/i915/i915_drm_client.c
index 9be007b10523..c54b1ac753c6 100644
--- a/drivers/gpu/drm/i915/i915_drm_client.c
+++ b/drivers/gpu/drm/i915/i915_drm_client.c
@@ -29,7 +29,7 @@ struct i915_drm_client *i915_drm_client_alloc(void)
 	kref_init(&client->kref);
 	spin_lock_init(&client->ctx_lock);
 	INIT_LIST_HEAD(&client->ctx_list);
-#ifdef CONFIG_PROC_FS
+#if defined(CONFIG_PROC_FS) || defined(CONFIG_CGROUP_DRM)
 	spin_lock_init(&client->objects_lock);
 	INIT_LIST_HEAD(&client->objects_list);
 #endif
@@ -46,6 +46,89 @@ void __i915_drm_client_free(struct kref *kref)
 }
 
 #if defined(CONFIG_PROC_FS) || defined(CONFIG_CGROUP_DRM)
+static void
+obj_meminfo(struct drm_i915_gem_object *obj,
+	    struct drm_memory_stats *stats,
+	    unsigned int num)
+{
+	struct intel_memory_region *mr;
+	u64 sz = obj->base.size;
+	enum intel_region_id id;
+	unsigned int i;
+
+	/* Attribute size and shared to all possible memory regions. */
+	for (i = 0; i < obj->mm.n_placements; i++) {
+		mr = obj->mm.placements[i];
+		id = mr->id;
+
+		if (WARN_ON_ONCE(id >= num))
+			return;
+
+		if (obj->base.handle_count > 1)
+			stats[id].shared += sz;
+		else
+			stats[id].private += sz;
+	}
+
+	/* Attribute other categories to only the current region. */
+	mr = obj->mm.region;
+	if (mr)
+		id = mr->id;
+	else
+		id = INTEL_REGION_SMEM;
+
+	if (WARN_ON_ONCE(id >= num))
+		return;
+
+	if (!obj->mm.n_placements) {
+		if (obj->base.handle_count > 1)
+			stats[id].shared += sz;
+		else
+			stats[id].private += sz;
+	}
+
+	if (i915_gem_object_has_pages(obj)) {
+		stats[id].resident += sz;
+
+		if (!dma_resv_test_signaled(obj->base.resv,
+					    dma_resv_usage_rw(true)))
+			stats[id].active += sz;
+		else if (i915_gem_object_is_shrinkable(obj) &&
+			 obj->mm.madv == I915_MADV_DONTNEED)
+			stats[id].purgeable += sz;
+	}
+}
+
+static void
+memory_stats(struct drm_file *file,
+	     struct drm_memory_stats *stats,
+	     unsigned int num)
+{
+	struct drm_i915_file_private *fpriv = file->driver_priv;
+	struct i915_drm_client *client = fpriv->client;
+	struct drm_i915_gem_object *obj;
+	struct list_head *pos;
+	unsigned int id;
+
+	/* Public objects. */
+	spin_lock(&file->table_lock);
+	idr_for_each_entry(&file->object_idr, obj, id)
+		obj_meminfo(obj, stats, num);
+	spin_unlock(&file->table_lock);
+
+	/* Internal objects. */
+	rcu_read_lock();
+	list_for_each_rcu(pos, &client->objects_list) {
+		obj = i915_gem_object_get_rcu(list_entry(pos, typeof(*obj),
+							 client_link));
+		if (!obj)
+			continue;
+		obj_meminfo(obj, stats, num);
+		i915_gem_object_put(obj);
+	}
+	rcu_read_unlock();
+}
+
 static const char * const uabi_class_names[] = {
 	[I915_ENGINE_CLASS_RENDER] = "render",
 	[I915_ENGINE_CLASS_COPY] = "copy",
@@ -255,83 +338,47 @@ int i915_drm_cgroup_signal_budget(struct drm_file *file, u64 usage, u64 budget)
 
 	return ret;
 }
+
+unsigned int i915_drm_cgroup_num_memory_regions(const struct drm_device *dev)
+{
+	return INTEL_REGION_UNKNOWN;
+}
+
+const char *i915_drm_cgroup_memory_region_name(const struct drm_device *dev,
+					       unsigned int index)
+{
+	const struct drm_i915_private *i915 = to_i915(dev);
+
+	if (index < ARRAY_SIZE(i915->mm.regions)) {
+		struct intel_memory_region *mr = i915->mm.regions[index];
+
+		if (mr)
+			return mr->name;
+	}
+
+	return NULL;
+}
+
+unsigned int i915_drm_cgroup_memory_stats(struct drm_file *file,
+					  struct drm_memory_stats *stats,
+					  unsigned int num)
+{
+	memory_stats(file, stats, num);
+
+	return DRM_GEM_OBJECT_RESIDENT | DRM_GEM_OBJECT_PURGEABLE;
+}
 #endif
 
 #ifdef CONFIG_PROC_FS
-static void
-obj_meminfo(struct drm_i915_gem_object *obj,
-	    struct drm_memory_stats stats[INTEL_REGION_UNKNOWN])
-{
-	struct intel_memory_region *mr;
-	u64 sz = obj->base.size;
-	enum intel_region_id id;
-	unsigned int i;
-
-	/* Attribute size and shared to all possible memory regions. */
-	for (i = 0; i < obj->mm.n_placements; i++) {
-		mr = obj->mm.placements[i];
-		id = mr->id;
-
-		if (obj->base.handle_count > 1)
-			stats[id].shared += sz;
-		else
-			stats[id].private += sz;
-	}
-
-	/* Attribute other categories to only the current region. */
-	mr = obj->mm.region;
-	if (mr)
-		id = mr->id;
-	else
-		id = INTEL_REGION_SMEM;
-
-	if (!obj->mm.n_placements) {
-		if (obj->base.handle_count > 1)
-			stats[id].shared += sz;
-		else
-			stats[id].private += sz;
-	}
-
-	if (i915_gem_object_has_pages(obj)) {
-		stats[id].resident += sz;
-
-		if (!dma_resv_test_signaled(obj->base.resv,
-					    dma_resv_usage_rw(true)))
-			stats[id].active += sz;
-		else if (i915_gem_object_is_shrinkable(obj) &&
-			 obj->mm.madv == I915_MADV_DONTNEED)
-			stats[id].purgeable += sz;
-	}
-}
-
 static void show_meminfo(struct drm_printer *p, struct drm_file *file)
 {
 	struct drm_memory_stats stats[INTEL_REGION_UNKNOWN] = {};
 	struct drm_i915_file_private *fpriv = file->driver_priv;
-	struct i915_drm_client *client = fpriv->client;
 	struct drm_i915_private *i915 = fpriv->i915;
-	struct drm_i915_gem_object *obj;
 	struct intel_memory_region *mr;
-	struct list_head *pos;
 	unsigned int id;
 
-	/* Public objects. */
-	spin_lock(&file->table_lock);
-	idr_for_each_entry(&file->object_idr, obj, id)
-		obj_meminfo(obj, stats);
-	spin_unlock(&file->table_lock);
-
-	/* Internal objects. */
-	rcu_read_lock();
-	list_for_each_rcu(pos, &client->objects_list) {
-		obj = i915_gem_object_get_rcu(list_entry(pos, typeof(*obj),
-							 client_link));
-		if (!obj)
-			continue;
-		obj_meminfo(obj, stats);
-		i915_gem_object_put(obj);
-	}
-	rcu_read_unlock();
+	memory_stats(file, stats, ARRAY_SIZE(stats));
 
 	for_each_memory_region(mr, i915, id)
 		drm_print_memory_stats(p,
@@ -382,7 +429,9 @@ void i915_drm_client_fdinfo(struct drm_printer *p, struct drm_file *file)
 	for (i = 0; i < ARRAY_SIZE(uabi_class_names); i++)
 		show_client_class(p, i915, file_priv->client, i);
 }
+#endif
 
+#if defined(CONFIG_PROC_FS) || defined(CONFIG_CGROUP_DRM)
 void i915_drm_client_add_object(struct i915_drm_client *client,
 				struct drm_i915_gem_object *obj)
 {
diff --git a/drivers/gpu/drm/i915/i915_drm_client.h b/drivers/gpu/drm/i915/i915_drm_client.h
index 6eadc9596b8f..8b34be25e887 100644
--- a/drivers/gpu/drm/i915/i915_drm_client.h
+++ b/drivers/gpu/drm/i915/i915_drm_client.h
@@ -29,7 +29,7 @@ struct i915_drm_client {
 	spinlock_t ctx_lock; /* For add/remove from ctx_list. */
 	struct list_head ctx_list; /* List of contexts belonging to client. */
 
-#ifdef CONFIG_PROC_FS
+#if defined(CONFIG_PROC_FS) || defined(CONFIG_CGROUP_DRM)
 	/**
 	 * @objects_lock: lock protecting @objects_list
 	 */
@@ -74,7 +74,7 @@ struct i915_drm_client *i915_drm_client_alloc(void);
 
 void i915_drm_client_fdinfo(struct drm_printer *p, struct drm_file *file);
 
-#ifdef CONFIG_PROC_FS
+#if defined(CONFIG_PROC_FS) || defined(CONFIG_CGROUP_DRM)
 void i915_drm_client_add_object(struct i915_drm_client *client,
 				struct drm_i915_gem_object *obj);
 bool i915_drm_client_remove_object(struct drm_i915_gem_object *obj);
@@ -101,4 +101,11 @@ u64 i915_drm_cgroup_get_active_time_us(struct drm_file *file);
 int i915_drm_cgroup_signal_budget(struct drm_file *file,
 				  u64 usage, u64 budget);
 
+unsigned int i915_drm_cgroup_num_memory_regions(const struct drm_device *);
+const char *i915_drm_cgroup_memory_region_name(const struct drm_device *,
+					       unsigned int index);
+unsigned int i915_drm_cgroup_memory_stats(struct drm_file *,
+					  struct drm_memory_stats *,
+					  unsigned int num);
+
 #endif /* !__I915_DRM_CLIENT_H__ */
-- 
2.39.2


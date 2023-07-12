Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3169D750715
	for <lists+cgroups@lfdr.de>; Wed, 12 Jul 2023 13:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbjGLLvM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jul 2023 07:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbjGLLup (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jul 2023 07:50:45 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39C11998;
        Wed, 12 Jul 2023 04:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689162554; x=1720698554;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mbUDZguU3/3ubuVhjLVfeypXgwnwUhCLLRTeHmZzUr0=;
  b=XWTNZXE1szVvhFIaW0J5kGvKLIRB7WdwHG/Rsasn38lyC6o1BTIfUNX7
   58WOqVGCuxvWtsJKaYJfYuQ9RqUZQ0xssFByvzrUtQnPTWFtK3mKECRMk
   FJhd3ghG2Hnyysvwe3w93L7dQEpH8mSP89q8FC/yj/TaLhHLZIDZMCR1o
   vLbtIiIjJ4d92o1RlXzyEC+GZJFG1nUR0lB2XwCTv/wNAZwYlqgc8Yh/i
   QSXKYGINJfUtwm4VZiaYsJXqFpwMgAMnK9dvOj6kC3ySJv5bNWasn+vES
   vtS/o9lLAblXx9icYDfJaBu0IvIiGNzc4lIY3VrUMLgQp5P4epVwn4bDm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="344469362"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="344469362"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 04:47:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="866094156"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="866094156"
Received: from eamonnob-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.213.237.202])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 04:47:02 -0700
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
Subject: [PATCH 13/17] drm/i915: Wire up with drm controller GPU time query
Date:   Wed, 12 Jul 2023 12:46:01 +0100
Message-Id: <20230712114605.519432-14-tvrtko.ursulin@linux.intel.com>
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

Implement the drm_cgroup_ops->active_time_us callback.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
---
 drivers/gpu/drm/i915/i915_driver.c     |   8 ++
 drivers/gpu/drm/i915/i915_drm_client.c | 116 ++++++++++++++++++-------
 drivers/gpu/drm/i915/i915_drm_client.h |   2 +
 3 files changed, 94 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index 294b022de22b..62a544d17659 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -1791,6 +1791,12 @@ static const struct drm_ioctl_desc i915_ioctls[] = {
 	DRM_IOCTL_DEF_DRV(I915_GEM_VM_DESTROY, i915_gem_vm_destroy_ioctl, DRM_RENDER_ALLOW),
 };
 
+#ifdef CONFIG_CGROUP_DRM
+static const struct drm_cgroup_ops i915_drm_cgroup_ops = {
+	.active_time_us = i915_drm_cgroup_get_active_time_us,
+};
+#endif
+
 /*
  * Interface history:
  *
@@ -1820,6 +1826,8 @@ static const struct drm_driver i915_drm_driver = {
 	.postclose = i915_driver_postclose,
 	.show_fdinfo = PTR_IF(IS_ENABLED(CONFIG_PROC_FS), i915_drm_client_fdinfo),
 
+	.cg_ops = PTR_IF(IS_ENABLED(CONFIG_CGROUP_DRM), &i915_drm_cgroup_ops),
+
 	.gem_prime_import = i915_gem_prime_import,
 
 	.dumb_create = i915_gem_dumb_create,
diff --git a/drivers/gpu/drm/i915/i915_drm_client.c b/drivers/gpu/drm/i915/i915_drm_client.c
index 9e7a6075ee25..c3298beb094a 100644
--- a/drivers/gpu/drm/i915/i915_drm_client.c
+++ b/drivers/gpu/drm/i915/i915_drm_client.c
@@ -44,6 +44,86 @@ void __i915_drm_client_free(struct kref *kref)
 	kfree(client);
 }
 
+#if defined(CONFIG_PROC_FS) || defined(CONFIG_CGROUP_DRM)
+static const char * const uabi_class_names[] = {
+	[I915_ENGINE_CLASS_RENDER] = "render",
+	[I915_ENGINE_CLASS_COPY] = "copy",
+	[I915_ENGINE_CLASS_VIDEO] = "video",
+	[I915_ENGINE_CLASS_VIDEO_ENHANCE] = "video-enhance",
+	[I915_ENGINE_CLASS_COMPUTE] = "compute",
+};
+
+static u64 busy_add(struct i915_gem_context *ctx, unsigned int class)
+{
+	struct i915_gem_engines_iter it;
+	struct intel_context *ce;
+	u64 total = 0;
+
+	for_each_gem_engine(ce, rcu_dereference(ctx->engines), it) {
+		if (ce->engine->uabi_class != class)
+			continue;
+
+		total += intel_context_get_total_runtime_ns(ce);
+	}
+
+	return total;
+}
+
+static u64 get_class_active_ns(struct i915_drm_client *client,
+			       struct drm_i915_private *i915,
+			       unsigned int class,
+			       unsigned int *capacity)
+{
+	struct i915_gem_context *ctx;
+	u64 total;
+
+	*capacity = i915->engine_uabi_class_count[class];
+	if (!*capacity)
+		return 0;
+
+	total = atomic64_read(&client->past_runtime[class]);
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(ctx, &client->ctx_list, client_link)
+		total += busy_add(ctx, class);
+	rcu_read_unlock();
+
+	return total;
+}
+
+static bool supports_stats(struct drm_i915_private *i915)
+{
+	return GRAPHICS_VER(i915) >= 8;
+}
+#endif
+
+#if defined(CONFIG_CGROUP_DRM)
+u64 i915_drm_cgroup_get_active_time_us(struct drm_file *file)
+{
+	struct drm_i915_file_private *fpriv = file->driver_priv;
+	struct i915_drm_client *client = fpriv->client;
+	struct drm_i915_private *i915 = fpriv->i915;
+	unsigned int i;
+	u64 busy = 0;
+
+	if (!supports_stats(i915))
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(uabi_class_names); i++) {
+		unsigned int capacity;
+		u64 b;
+
+		b = get_class_active_ns(client, i915, i, &capacity);
+		if (capacity) {
+			b = DIV_ROUND_UP_ULL(b, capacity * 1000);
+			busy += b;
+		}
+	}
+
+	return busy;
+}
+#endif
+
 #ifdef CONFIG_PROC_FS
 static void
 obj_meminfo(struct drm_i915_gem_object *obj,
@@ -128,44 +208,16 @@ static void show_meminfo(struct drm_printer *p, struct drm_file *file)
 				       mr->name);
 }
 
-static const char * const uabi_class_names[] = {
-	[I915_ENGINE_CLASS_RENDER] = "render",
-	[I915_ENGINE_CLASS_COPY] = "copy",
-	[I915_ENGINE_CLASS_VIDEO] = "video",
-	[I915_ENGINE_CLASS_VIDEO_ENHANCE] = "video-enhance",
-	[I915_ENGINE_CLASS_COMPUTE] = "compute",
-};
-
-static u64 busy_add(struct i915_gem_context *ctx, unsigned int class)
-{
-	struct i915_gem_engines_iter it;
-	struct intel_context *ce;
-	u64 total = 0;
-
-	for_each_gem_engine(ce, rcu_dereference(ctx->engines), it) {
-		if (ce->engine->uabi_class != class)
-			continue;
-
-		total += intel_context_get_total_runtime_ns(ce);
-	}
-
-	return total;
-}
-
 static void
 show_client_class(struct drm_printer *p,
 		  struct drm_i915_private *i915,
 		  struct i915_drm_client *client,
 		  unsigned int class)
 {
-	const unsigned int capacity = i915->engine_uabi_class_count[class];
-	u64 total = atomic64_read(&client->past_runtime[class]);
-	struct i915_gem_context *ctx;
+	unsigned int capacity;
+	u64 total;
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(ctx, &client->ctx_list, client_link)
-		total += busy_add(ctx, class);
-	rcu_read_unlock();
+	total = get_class_active_ns(client, i915, class, &capacity);
 
 	if (capacity)
 		drm_printf(p, "drm-engine-%s:\t%llu ns\n",
@@ -191,7 +243,7 @@ void i915_drm_client_fdinfo(struct drm_printer *p, struct drm_file *file)
 
 	show_meminfo(p, file);
 
-	if (GRAPHICS_VER(i915) < 8)
+	if (!supports_stats(i915))
 		return;
 
 	for (i = 0; i < ARRAY_SIZE(uabi_class_names); i++)
diff --git a/drivers/gpu/drm/i915/i915_drm_client.h b/drivers/gpu/drm/i915/i915_drm_client.h
index 69cedfcd3d69..e0b143890e69 100644
--- a/drivers/gpu/drm/i915/i915_drm_client.h
+++ b/drivers/gpu/drm/i915/i915_drm_client.h
@@ -90,4 +90,6 @@ i915_drm_client_add_context_objects(struct i915_drm_client *client,
 }
 #endif
 
+u64 i915_drm_cgroup_get_active_time_us(struct drm_file *file);
+
 #endif /* !__I915_DRM_CLIENT_H__ */
-- 
2.39.2


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E327506DC
	for <lists+cgroups@lfdr.de>; Wed, 12 Jul 2023 13:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbjGLLtT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jul 2023 07:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbjGLLtB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jul 2023 07:49:01 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80391FEC;
        Wed, 12 Jul 2023 04:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689162495; x=1720698495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XfUgp3jiW7e0qUQq7cL+ROu1HZblCNZEW5a5U/4B3Zw=;
  b=AtNUt514oaV7Qkjp45zIJ9ZxGUYeESbbIfJxx6VZVyFE8UuFPRuRXXxo
   80F7iwxm2/FaIgIktUQ5VE9c4ewSa9ngZk2MkRh4fXFDm/a7Rp93UKdsf
   0W9k5eMkqtl6HrU6hRYpX6AzE0NqlZGD8CcrrqMp3HM3PjApBkN0p2xmX
   J7/RaBd8shLNjc0Nic7aPF2PQI62w6bphs6px4tticFKf2YDxcQ4PORaP
   jEhUCCOtzUvmjELlYl4iTD5zXmb9TGThYwXFAdwXn8TdykGfu+2rGN3LT
   StHw28nwuo7OkME6yJoHFXOeACi+/tD7XEZPtP238dQ2U6/DbKqr0695N
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="344469145"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="344469145"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 04:46:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="866094096"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="866094096"
Received: from eamonnob-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.213.237.202])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 04:46:31 -0700
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
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Aravind Iddamsetty <aravind.iddamsetty@intel.com>,
        Rob Clark <robdclark@gmail.com>
Subject: [PATCH 05/17] drm/i915: Implement fdinfo memory stats printing
Date:   Wed, 12 Jul 2023 12:45:53 +0100
Message-Id: <20230712114605.519432-6-tvrtko.ursulin@linux.intel.com>
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

Use the newly added drm_print_memory_stats helper to show memory
utilisation of our objects in drm/driver specific fdinfo output.

To collect the stats we walk the per memory regions object lists
and accumulate object size into the respective drm_memory_stats
categories.

Objects with multiple possible placements are reported in multiple
regions for total and shared sizes, while other categories are
counted only for the currently active region.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Aravind Iddamsetty <aravind.iddamsetty@intel.com>
Cc: Rob Clark <robdclark@gmail.com>
---
 drivers/gpu/drm/i915/i915_drm_client.c | 85 ++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/gpu/drm/i915/i915_drm_client.c b/drivers/gpu/drm/i915/i915_drm_client.c
index a61356012df8..9e7a6075ee25 100644
--- a/drivers/gpu/drm/i915/i915_drm_client.c
+++ b/drivers/gpu/drm/i915/i915_drm_client.c
@@ -45,6 +45,89 @@ void __i915_drm_client_free(struct kref *kref)
 }
 
 #ifdef CONFIG_PROC_FS
+static void
+obj_meminfo(struct drm_i915_gem_object *obj,
+	    struct drm_memory_stats stats[INTEL_REGION_UNKNOWN])
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
+static void show_meminfo(struct drm_printer *p, struct drm_file *file)
+{
+	struct drm_memory_stats stats[INTEL_REGION_UNKNOWN] = {};
+	struct drm_i915_file_private *fpriv = file->driver_priv;
+	struct i915_drm_client *client = fpriv->client;
+	struct drm_i915_private *i915 = fpriv->i915;
+	struct drm_i915_gem_object *obj;
+	struct intel_memory_region *mr;
+	struct list_head *pos;
+	unsigned int id;
+
+	/* Public objects. */
+	spin_lock(&file->table_lock);
+	idr_for_each_entry(&file->object_idr, obj, id)
+		obj_meminfo(obj, stats);
+	spin_unlock(&file->table_lock);
+
+	/* Internal objects. */
+	rcu_read_lock();
+	list_for_each_rcu(pos, &client->objects_list) {
+		obj = i915_gem_object_get_rcu(list_entry(pos, typeof(*obj),
+							 client_link));
+		if (!obj)
+			continue;
+		obj_meminfo(obj, stats);
+		i915_gem_object_put(obj);
+	}
+	rcu_read_unlock();
+
+	for_each_memory_region(mr, i915, id)
+		drm_print_memory_stats(p,
+				       &stats[id],
+				       DRM_GEM_OBJECT_RESIDENT |
+				       DRM_GEM_OBJECT_PURGEABLE,
+				       mr->name);
+}
+
 static const char * const uabi_class_names[] = {
 	[I915_ENGINE_CLASS_RENDER] = "render",
 	[I915_ENGINE_CLASS_COPY] = "copy",
@@ -106,6 +189,8 @@ void i915_drm_client_fdinfo(struct drm_printer *p, struct drm_file *file)
 	 * ******************************************************************
 	 */
 
+	show_meminfo(p, file);
+
 	if (GRAPHICS_VER(i915) < 8)
 		return;
 
-- 
2.39.2


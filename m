Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DA66F53E5
	for <lists+cgroups@lfdr.de>; Wed,  3 May 2023 11:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjECJAS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 3 May 2023 05:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjECJAR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 3 May 2023 05:00:17 -0400
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10B410D9;
        Wed,  3 May 2023 02:00:14 -0700 (PDT)
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To:     dri-devel@lists.freedesktop.org, cgroups@vger.kernel.org,
        intel-xe@lists.freedesktop.org
Cc:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: [RFC PATCH 4/4] drm/xe: Add support for the drm cgroup
Date:   Wed,  3 May 2023 10:35:00 +0200
Message-Id: <20230503083500.645848-5-maarten.lankhorst@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230503083500.645848-1-maarten.lankhorst@linux.intel.com>
References: <20230503083500.645848-1-maarten.lankhorst@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Add some code to implement basic support for the vram0, vram1 and stolen
memory regions.

I fear the try_charge code should probably be done inside TTM. This
code should interact with the shrinker, but for a simple RFC it's good
enough.

Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_device.c             |  4 ++++
 drivers/gpu/drm/xe/xe_device_types.h       |  4 ++++
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c       | 21 +++++++++++++++++++--
 drivers/gpu/drm/xe/xe_ttm_vram_mgr_types.h |  5 +++++
 4 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 45d6e5ff47fd..f0a5af15a662 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -291,6 +291,10 @@ int xe_device_probe(struct xe_device *xe)
 	/* Allocate and map stolen after potential VRAM resize */
 	xe_ttm_stolen_mgr_init(xe);
 
+	err = drmmcg_register_device(&xe->drm, &xe->cg);
+	if (err)
+		goto err_irq_shutdown;
+
 	/*
 	 * Now that GT is initialized (TTM in particular),
 	 * we can try to init display, and inherit the initial fb.
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 1cb404e48aaa..04b85060cbec 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -12,6 +12,8 @@
 #include <drm/drm_file.h>
 #include <drm/ttm/ttm_device.h>
 
+#include <linux/cgroup_drm.h>
+
 #include "xe_gt_types.h"
 #include "xe_platform_types.h"
 #include "xe_step_types.h"
@@ -55,6 +57,8 @@ struct xe_device {
 	/** @drm: drm device */
 	struct drm_device drm;
 
+	struct drmcgroup_device cg;
+
 	/** @info: device info */
 	struct intel_device_info {
 		/** @graphics_name: graphics IP name */
diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
index 73836b9b7fed..263cd4ef7b6d 100644
--- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
+++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
@@ -50,6 +50,7 @@ static int xe_ttm_vram_mgr_new(struct ttm_resource_manager *man,
 			       struct ttm_resource **res)
 {
 	struct xe_ttm_vram_mgr *mgr = to_xe_ttm_vram_mgr(man);
+	struct xe_device *xe = ttm_to_xe_device(tbo->bdev);
 	struct xe_ttm_vram_mgr_resource *vres;
 	struct drm_buddy *mm = &mgr->mm;
 	u64 size, remaining_size, min_page_size;
@@ -116,9 +117,8 @@ static int xe_ttm_vram_mgr_new(struct ttm_resource_manager *man,
 
 	mutex_lock(&mgr->lock);
 	if (lpfn <= mgr->visible_size >> PAGE_SHIFT && size > mgr->visible_avail) {
-		mutex_unlock(&mgr->lock);
 		err = -ENOSPC;
-		goto error_fini;
+		goto error_unlock;
 	}
 
 	if (place->fpfn + (size >> PAGE_SHIFT) != place->lpfn &&
@@ -129,6 +129,10 @@ static int xe_ttm_vram_mgr_new(struct ttm_resource_manager *man,
 		lpfn = max_t(unsigned long, place->fpfn + (size >> PAGE_SHIFT), lpfn);
 	}
 
+	err = drmcg_try_charge(&vres->cg, &xe->cg, mgr->mem_type, vres->base.size);
+	if (err)
+		goto error_unlock;
+
 	remaining_size = size;
 	do {
 		/*
@@ -197,6 +201,8 @@ static int xe_ttm_vram_mgr_new(struct ttm_resource_manager *man,
 
 error_free_blocks:
 	drm_buddy_free_list(mm, &vres->blocks);
+	drmcg_uncharge(vres->cg, &xe->cg, mgr->mem_type, vres->base.size);
+error_unlock:
 	mutex_unlock(&mgr->lock);
 error_fini:
 	ttm_resource_fini(man, &vres->base);
@@ -211,6 +217,7 @@ static void xe_ttm_vram_mgr_del(struct ttm_resource_manager *man,
 	struct xe_ttm_vram_mgr_resource *vres =
 		to_xe_ttm_vram_mgr_resource(res);
 	struct xe_ttm_vram_mgr *mgr = to_xe_ttm_vram_mgr(man);
+	struct xe_device *xe = ttm_to_xe_device(man->bdev);
 	struct drm_buddy *mm = &mgr->mm;
 
 	mutex_lock(&mgr->lock);
@@ -218,6 +225,7 @@ static void xe_ttm_vram_mgr_del(struct ttm_resource_manager *man,
 	mgr->visible_avail += vres->used_visible_size;
 	mutex_unlock(&mgr->lock);
 
+	drmcg_uncharge(vres->cg, &xe->cg, mgr->mem_type, vres->base.size);
 	ttm_resource_fini(man, res);
 
 	kfree(vres);
@@ -337,6 +345,15 @@ int __xe_ttm_vram_mgr_init(struct xe_device *xe, struct xe_ttm_vram_mgr *mgr,
 	struct ttm_resource_manager *man = &mgr->manager;
 	int err;
 
+	xe->cg.regions[mem_type].size = size;
+
+	if (mem_type == XE_PL_STOLEN) {
+		xe->cg.regions[mem_type].name = "stolen";
+	} else {
+		xe->cg.regions[mem_type].name =
+			mem_type == XE_PL_VRAM0 ? "vram0" : "vram1";
+	}
+
 	man->func = &xe_ttm_vram_mgr_func;
 	mgr->mem_type = mem_type;
 	mutex_init(&mgr->lock);
diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr_types.h b/drivers/gpu/drm/xe/xe_ttm_vram_mgr_types.h
index 3d9417ff7434..232585d7ae69 100644
--- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr_types.h
+++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr_types.h
@@ -9,6 +9,8 @@
 #include <drm/drm_buddy.h>
 #include <drm/ttm/ttm_device.h>
 
+struct drmcgroup_state;
+
 struct xe_gt;
 
 /**
@@ -47,6 +49,9 @@ struct xe_ttm_vram_mgr_resource {
 	u64 used_visible_size;
 	/** @flags: flags associated with the resource */
 	unsigned long flags;
+
+	/** @cg: cgroup this resource is charged to */
+	struct drmcgroup_state *cg;
 };
 
 #endif
-- 
2.34.1


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACC1E108AE
	for <lists+cgroups@lfdr.de>; Wed,  1 May 2019 16:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfEAODI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 May 2019 10:03:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:3043 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbfEAODI (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 1 May 2019 10:03:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 May 2019 07:03:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,417,1549958400"; 
   d="scan'208";a="145141419"
Received: from nperf12.hd.intel.com ([10.127.88.161])
  by fmsmga008.fm.intel.com with ESMTP; 01 May 2019 07:03:06 -0700
From:   Brian Welty <brian.welty@intel.com>
To:     cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        ChunMing Zhou <David1.Zhou@amd.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>
Subject: [RFC PATCH 5/5] drm/i915: Use memory cgroup for enforcing device memory limit
Date:   Wed,  1 May 2019 10:04:38 -0400
Message-Id: <20190501140438.9506-6-brian.welty@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190501140438.9506-1-brian.welty@intel.com>
References: <20190501140438.9506-1-brian.welty@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

i915 driver now includes DRIVER_CGROUPS in feature bits.

To charge device memory allocations, we need to (1) identify appropriate
cgroup to charge (currently decided at object creation time), and (2)
make the charging call at the time that memory pages are being allocated.

For (1), see prior DRM patch which associates current task's cgroup with
GEM objects as they are created.  That cgroup will be charged/uncharged
for all paging activity against the GEM object.

For (2), we call mem_cgroup_try_charge_direct() in .get_pages callback
for the GEM object type.  Uncharging is done in .put_pages when the
memory is marked such that it can be evicted.  The try_charge() call will
fail with -ENOMEM if the current memory allocation will exceed the cgroup
device memory maximum, and allow for driver to perform memory reclaim.

Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: dri-devel@lists.freedesktop.org
Cc: Matt Roper <matthew.d.roper@intel.com>
Signed-off-by: Brian Welty <brian.welty@intel.com>
---
 drivers/gpu/drm/i915/i915_drv.c            |  2 +-
 drivers/gpu/drm/i915/intel_memory_region.c | 24 ++++++++++++++++++----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
index 5a0a59922cb4..4d496c3c3681 100644
--- a/drivers/gpu/drm/i915/i915_drv.c
+++ b/drivers/gpu/drm/i915/i915_drv.c
@@ -3469,7 +3469,7 @@ static struct drm_driver driver = {
 	 * deal with them for Intel hardware.
 	 */
 	.driver_features =
-	    DRIVER_GEM | DRIVER_PRIME |
+	    DRIVER_GEM | DRIVER_PRIME | DRIVER_CGROUPS |
 	    DRIVER_RENDER | DRIVER_MODESET | DRIVER_ATOMIC | DRIVER_SYNCOBJ,
 	.release = i915_driver_release,
 	.open = i915_driver_open,
diff --git a/drivers/gpu/drm/i915/intel_memory_region.c b/drivers/gpu/drm/i915/intel_memory_region.c
index 813ff83c132b..e4ac5e4d4857 100644
--- a/drivers/gpu/drm/i915/intel_memory_region.c
+++ b/drivers/gpu/drm/i915/intel_memory_region.c
@@ -53,6 +53,8 @@ i915_memory_region_put_pages_buddy(struct drm_i915_gem_object *obj,
 	mutex_unlock(&obj->memory_region->mm_lock);
 
 	obj->mm.dirty = false;
+	mem_cgroup_uncharge_direct(obj->base.memcg,
+				   obj->base.size >> PAGE_SHIFT);
 }
 
 int
@@ -65,19 +67,29 @@ i915_memory_region_get_pages_buddy(struct drm_i915_gem_object *obj)
 	struct scatterlist *sg;
 	unsigned int sg_page_sizes;
 	unsigned long n_pages;
+	int err;
 
 	GEM_BUG_ON(!IS_ALIGNED(size, mem->mm.min_size));
 	GEM_BUG_ON(!list_empty(&obj->blocks));
 
+	err = mem_cgroup_try_charge_direct(obj->base.memcg, size >> PAGE_SHIFT);
+	if (err) {
+		DRM_DEBUG("MEMCG: try_charge failed for %lld\n", size);
+		return err;
+	}
+
 	st = kmalloc(sizeof(*st), GFP_KERNEL);
-	if (!st)
-		return -ENOMEM;
+	if (!st) {
+		err = -ENOMEM;
+		goto err_uncharge;
+	}
 
 	n_pages = div64_u64(size, mem->mm.min_size);
 
 	if (sg_alloc_table(st, n_pages, GFP_KERNEL)) {
 		kfree(st);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto err_uncharge;
 	}
 
 	sg = st->sgl;
@@ -161,7 +173,11 @@ i915_memory_region_get_pages_buddy(struct drm_i915_gem_object *obj)
 err_free_blocks:
 	memory_region_free_pages(obj, st);
 	mutex_unlock(&mem->mm_lock);
-	return -ENXIO;
+	err = -ENXIO;
+err_uncharge:
+	mem_cgroup_uncharge_direct(obj->base.memcg,
+				   obj->base.size >> PAGE_SHIFT);
+	return err;
 }
 
 int i915_memory_region_init_buddy(struct intel_memory_region *mem)
-- 
2.21.0


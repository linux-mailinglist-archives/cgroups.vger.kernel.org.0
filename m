Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFEDC30532C
	for <lists+cgroups@lfdr.de>; Wed, 27 Jan 2021 07:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbhA0DKO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Jan 2021 22:10:14 -0500
Received: from mga03.intel.com ([134.134.136.65]:28863 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbhAZVrr (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 26 Jan 2021 16:47:47 -0500
IronPort-SDR: m45oUdgmB/aZrmxezzuTfathneEVcRkS3F5jFAFLOhzTx4eteEmMdSwKM8QdxtgUae20JsuVV+
 LwKbgHunB9mQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="180056570"
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="180056570"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 13:44:37 -0800
IronPort-SDR: mYnmEKpeuO6WzUZ+VqUfEZoCLGgLnNVRdsnqkI9kHOqYXasjUVc8ONVGKSZVdtN0WcB9l6Bhut
 EMTwDuPgUGOQ==
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="362139905"
Received: from nvishwa1-desk.sc.intel.com ([172.25.29.76])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 26 Jan 2021 13:44:37 -0800
From:   Brian Welty <brian.welty@intel.com>
To:     Brian Welty <brian.welty@intel.com>, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Kenny Ho <Kenny.Ho@amd.com>, amd-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx@lists.freedesktop.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Eero Tamminen <eero.t.tamminen@intel.com>
Subject: [RFC PATCH 8/9] drm/gem: Associate GEM objects with drm cgroup
Date:   Tue, 26 Jan 2021 13:46:25 -0800
Message-Id: <20210126214626.16260-9-brian.welty@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210126214626.16260-1-brian.welty@intel.com>
References: <20210126214626.16260-1-brian.welty@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patch adds tracking of which cgroup to make charges against for a
given GEM object.  We associate the current task's cgroup with GEM objects
as they are created.  First user of this is for charging DRM cgroup for
device memory allocations.  The intended behavior is for device drivers to
make the cgroup charging calls at the time that backing store is allocated
or deallocated for the object.

Exported functions are provided for charging memory allocations for a
GEM object to DRM cgroup. To aid in debugging, we store how many bytes
have been charged inside the GEM object.  Add helpers for setting and
clearing the object's associated cgroup which will check that charges are
not being leaked.

For shared objects, this may make the charge against a cgroup that is
potentially not the same cgroup as the process using the memory.  Based
on the memory cgroup's discussion of "memory ownership", this seems
acceptable [1].

[1] https://www.kernel.org/doc/Documentation/cgroup-v2.txt, "Memory Ownership"

Signed-off-by: Brian Welty <brian.welty@intel.com>
---
 drivers/gpu/drm/drm_gem.c | 89 +++++++++++++++++++++++++++++++++++++++
 include/drm/drm_gem.h     | 17 ++++++++
 2 files changed, 106 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index c2ce78c4edc3..a12da41eaafe 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -29,6 +29,7 @@
 #include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/uaccess.h>
+#include <linux/cgroup_drm.h>
 #include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/module.h>
@@ -112,6 +113,89 @@ drm_gem_init(struct drm_device *dev)
 	return drmm_add_action(dev, drm_gem_init_release, NULL);
 }
 
+/**
+ * drm_gem_object_set_cgroup - associate GEM object with a cgroup
+ * @obj: GEM object which is being associated with a cgroup
+ * @task: task associated with process control group to use
+ *
+ * This will acquire a reference on cgroup and use for charging GEM
+ * memory allocations.
+ * This helper could be extended in future to migrate charges to another
+ * cgroup, print warning if this usage occurs.
+ */
+void drm_gem_object_set_cgroup(struct drm_gem_object *obj,
+			       struct task_struct *task)
+{
+	/* if object has existing cgroup, we migrate the charge... */
+	if (obj->drmcg) {
+		pr_warn("DRM: need to migrate cgroup charge of %lld\n",
+			atomic64_read(&obj->drmcg_bytes_charged));
+	}
+	obj->drmcg = drmcg_get(task);
+}
+EXPORT_SYMBOL(drm_gem_object_set_cgroup);
+
+/**
+ * drm_gem_object_unset_cgroup - clear GEM object's associated cgroup
+ * @obj: GEM object
+ *
+ * This will release a reference on cgroup.
+ */
+void drm_gem_object_unset_cgroup(struct drm_gem_object *obj)
+{
+	WARN_ON(atomic64_read(&obj->drmcg_bytes_charged));
+	drmcg_put(obj->drmcg);
+}
+EXPORT_SYMBOL(drm_gem_object_unset_cgroup);
+
+/**
+ * drm_gem_object_charge_mem - try charging size bytes to DRM cgroup
+ * @obj: GEM object which is being charged
+ * @size: number of bytes to charge
+ *
+ * Try to charge @size bytes to GEM object's associated DRM cgroup.  This
+ * will fail if a successful charge would cause the current device memory
+ * usage to go above the cgroup's GPU memory maximum limit.
+ *
+ * Returns 0 on success.  Otherwise, an error code is returned.
+ */
+int drm_gem_object_charge_mem(struct drm_gem_object *obj, u64 size)
+{
+	int ret;
+
+	ret = drm_cgroup_try_charge(obj->drmcg, obj->dev,
+				    DRMCG_TYPE_MEM_CURRENT, size);
+	if (!ret)
+		atomic64_add(size, &obj->drmcg_bytes_charged);
+	return ret;
+}
+EXPORT_SYMBOL(drm_gem_object_charge_mem);
+
+/**
+ * drm_gem_object_uncharge_mem - uncharge size bytes from DRM cgroup
+ * @obj: GEM object which is being uncharged
+ * @size: number of bytes to uncharge
+ *
+ * Uncharge @size bytes from the DRM cgroup associated with specified
+ * GEM object.
+ *
+ * Returns 0 on success.  Otherwise, an error code is returned.
+ */
+void drm_gem_object_uncharge_mem(struct drm_gem_object *obj, u64 size)
+{
+	u64 charged = atomic64_read(&obj->drmcg_bytes_charged);
+
+	if (WARN_ON(!charged))
+		return;
+	if (WARN_ON(size > charged))
+		size = charged;
+
+	atomic64_sub(size, &obj->drmcg_bytes_charged);
+	drm_cgroup_uncharge(obj->drmcg, obj->dev, DRMCG_TYPE_MEM_CURRENT,
+			    size);
+}
+EXPORT_SYMBOL(drm_gem_object_uncharge_mem);
+
 /**
  * drm_gem_object_init - initialize an allocated shmem-backed GEM object
  * @dev: drm_device the object should be initialized for
@@ -156,6 +240,8 @@ void drm_gem_private_object_init(struct drm_device *dev,
 	obj->dev = dev;
 	obj->filp = NULL;
 
+	drm_gem_object_set_cgroup(obj, current);
+
 	kref_init(&obj->refcount);
 	obj->handle_count = 0;
 	obj->size = size;
@@ -950,6 +1036,9 @@ drm_gem_object_release(struct drm_gem_object *obj)
 
 	dma_resv_fini(&obj->_resv);
 	drm_gem_free_mmap_offset(obj);
+
+	/* Release reference on cgroup used with GEM object charging */
+	drm_gem_object_unset_cgroup(obj);
 }
 EXPORT_SYMBOL(drm_gem_object_release);
 
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 240049566592..06ea10fc17bc 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -37,6 +37,7 @@
 #include <linux/kref.h>
 #include <linux/dma-resv.h>
 
+#include <drm/drm_cgroup.h>
 #include <drm/drm_vma_manager.h>
 
 struct dma_buf_map;
@@ -222,6 +223,17 @@ struct drm_gem_object {
 	 */
 	struct file *filp;
 
+	/**
+	 * @drmcg:
+	 *
+	 * cgroup used for charging GEM object page allocations against. This
+	 * is set to the current cgroup during GEM object creation.
+	 * Charging policy is up to the DRM driver to implement and should be
+	 * charged when allocating backing store from device memory.
+	 */
+	struct drmcg *drmcg;
+	atomic64_t drmcg_bytes_charged;
+
 	/**
 	 * @vma_node:
 	 *
@@ -417,4 +429,9 @@ int drm_gem_fence_array_add_implicit(struct xarray *fence_array,
 int drm_gem_dumb_map_offset(struct drm_file *file, struct drm_device *dev,
 			    u32 handle, u64 *offset);
 
+void drm_gem_object_set_cgroup(struct drm_gem_object *obj,
+			       struct task_struct *task);
+void drm_gem_object_unset_cgroup(struct drm_gem_object *obj);
+int drm_gem_object_charge_mem(struct drm_gem_object *obj, u64 size);
+void drm_gem_object_uncharge_mem(struct drm_gem_object *obj, u64 size);
 #endif /* __DRM_GEM_H__ */
-- 
2.20.1


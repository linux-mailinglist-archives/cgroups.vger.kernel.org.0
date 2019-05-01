Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E460108AD
	for <lists+cgroups@lfdr.de>; Wed,  1 May 2019 16:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfEAODG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 May 2019 10:03:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:3043 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbfEAODG (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 1 May 2019 10:03:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 May 2019 07:03:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,417,1549958400"; 
   d="scan'208";a="145141415"
Received: from nperf12.hd.intel.com ([10.127.88.161])
  by fmsmga008.fm.intel.com with ESMTP; 01 May 2019 07:03:04 -0700
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
Subject: [RFC PATCH 4/5] drm: Add memory cgroup registration and DRIVER_CGROUPS feature bit
Date:   Wed,  1 May 2019 10:04:37 -0400
Message-Id: <20190501140438.9506-5-brian.welty@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190501140438.9506-1-brian.welty@intel.com>
References: <20190501140438.9506-1-brian.welty@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

With new cgroups per-device framework, registration with memory cgroup
subsystem can allow us to enforce limit for allocation of device memory
against process cgroups.

This patch adds new driver feature bit, DRIVER_CGROUPS, such that DRM
will register the device with cgroups. Doing so allows device drivers to
charge memory allocations to device-specific state within the cgroup.

Note, this is only for GEM objects allocated from device memory.
Memory charging for GEM objects using system memory is already handled
by the mm subsystem charing the normal (non-device) memory cgroup.

To charge device memory allocations, we need to (1) identify appropriate
cgroup to charge (currently decided at object creation time), and (2)
make the charging call at the time that memory pages are being allocated.
Above is one policy, and this is open for debate if this is the right
choice.

For (1), we associate the current task's cgroup with GEM objects as they
are created.  That cgroup will be charged/uncharged for all paging
activity against the GEM object.  Note, if the process is not part of a
memory cgroup, then this returns NULL and no charging will occur.
For shared objects, this may make the charge against a cgroup that is
potentially not the same cgroup as the process using the memory.  Based
on the memory cgroup's discussion of "memory ownership", this seems
acceptable [1].  For (2), this is for device drivers to implement within
appropriate page allocation logic.

[1] https://www.kernel.org/doc/Documentation/cgroup-v2.txt, "Memory Ownership"

Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: dri-devel@lists.freedesktop.org
Cc: Matt Roper <matthew.d.roper@intel.com>
Signed-off-by: Brian Welty <brian.welty@intel.com>
---
 drivers/gpu/drm/drm_drv.c | 12 ++++++++++++
 drivers/gpu/drm/drm_gem.c |  7 +++++++
 include/drm/drm_device.h  |  3 +++
 include/drm/drm_drv.h     |  8 ++++++++
 include/drm/drm_gem.h     | 11 +++++++++++
 5 files changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 862621494a93..890bd3c0e63e 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -28,6 +28,7 @@
 
 #include <linux/debugfs.h>
 #include <linux/fs.h>
+#include <linux/memcontrol.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/mount.h>
@@ -987,6 +988,12 @@ int drm_dev_register(struct drm_device *dev, unsigned long flags)
 	if (ret)
 		goto err_minors;
 
+	if (dev->dev && drm_core_check_feature(dev, DRIVER_CGROUPS)) {
+		ret = mem_cgroup_device_register(dev->dev, &dev->memcg_id);
+		if (ret)
+			goto err_minors;
+	}
+
 	dev->registered = true;
 
 	if (dev->driver->load) {
@@ -1009,6 +1016,8 @@ int drm_dev_register(struct drm_device *dev, unsigned long flags)
 	goto out_unlock;
 
 err_minors:
+	if (dev->memcg_id)
+		mem_cgroup_device_unregister(dev->memcg_id);
 	remove_compat_control_link(dev);
 	drm_minor_unregister(dev, DRM_MINOR_PRIMARY);
 	drm_minor_unregister(dev, DRM_MINOR_RENDER);
@@ -1052,6 +1061,9 @@ void drm_dev_unregister(struct drm_device *dev)
 
 	drm_legacy_rmmaps(dev);
 
+	if (dev->memcg_id)
+		mem_cgroup_device_unregister(dev->memcg_id);
+
 	remove_compat_control_link(dev);
 	drm_minor_unregister(dev, DRM_MINOR_PRIMARY);
 	drm_minor_unregister(dev, DRM_MINOR_RENDER);
diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 50de138c89e0..966fbd701deb 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -38,6 +38,7 @@
 #include <linux/dma-buf.h>
 #include <linux/mem_encrypt.h>
 #include <linux/pagevec.h>
+#include <linux/memcontrol.h>
 #include <drm/drmP.h>
 #include <drm/drm_vma_manager.h>
 #include <drm/drm_gem.h>
@@ -281,6 +282,9 @@ drm_gem_handle_delete(struct drm_file *filp, u32 handle)
 	if (IS_ERR_OR_NULL(obj))
 		return -EINVAL;
 
+	/* Release reference on cgroup used with GEM object charging */
+	mem_cgroup_put(obj->memcg);
+
 	/* Release driver's reference and decrement refcount. */
 	drm_gem_object_release_handle(handle, obj, filp);
 
@@ -410,6 +414,9 @@ drm_gem_handle_create_tail(struct drm_file *file_priv,
 			goto err_revoke;
 	}
 
+	/* Acquire reference on cgroup for charging GEM memory allocations */
+	obj->memcg = mem_cgroup_device_from_task(dev->memcg_id, current);
+
 	*handlep = handle;
 	return 0;
 
diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
index 7f9ef709b2b6..9859f2289066 100644
--- a/include/drm/drm_device.h
+++ b/include/drm/drm_device.h
@@ -190,6 +190,9 @@ struct drm_device {
 	 */
 	int irq;
 
+	/* @memcg_id: cgroup subsys (memcg) index for our device state */
+	unsigned long memcg_id;
+
 	/**
 	 * @vblank_disable_immediate:
 	 *
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 5cc7f728ec73..13b0e0b9527f 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -92,6 +92,14 @@ enum drm_driver_feature {
 	 */
 	DRIVER_SYNCOBJ                  = BIT(5),
 
+	/**
+	 * @DRIVER_CGROUPS:
+	 *
+	 * Driver supports and requests DRM to register with cgroups during
+	 * drm_dev_register().
+	 */
+	DRIVER_CGROUPS			= BIT(6),
+
 	/* IMPORTANT: Below are all the legacy flags, add new ones above. */
 
 	/**
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 5047c7ee25f5..ca90ea512e45 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -34,6 +34,7 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#include <linux/memcontrol.h>
 #include <linux/kref.h>
 #include <linux/reservation.h>
 
@@ -202,6 +203,16 @@ struct drm_gem_object {
 	 */
 	struct file *filp;
 
+	/**
+	 * @memcg:
+	 *
+	 * cgroup used for charging GEM object page allocations against. This
+	 * is set to the current cgroup during GEM object creation.
+	 * Charging policy is up to each DRM driver to decide, but intent is to
+	 * charge during page allocation and use for device memory only.
+	 */
+	struct mem_cgroup *memcg;
+
 	/**
 	 * @vma_node:
 	 *
-- 
2.21.0


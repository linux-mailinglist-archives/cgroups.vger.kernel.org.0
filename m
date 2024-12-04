Return-Path: <cgroups+bounces-5756-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADE59E3C5A
	for <lists+cgroups@lfdr.de>; Wed,  4 Dec 2024 15:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B17D8B257D7
	for <lists+cgroups@lfdr.de>; Wed,  4 Dec 2024 13:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917A11F668E;
	Wed,  4 Dec 2024 13:53:23 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916771CCEF6;
	Wed,  4 Dec 2024 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733320403; cv=none; b=DvkydvobNQX1xilQNkDjrZ/DI4QCBPqiwreelep6HaU5grdw1pNx0X/bYK2zN5/8yAm50SYXdhu67kKBqI5CkAPXfvp3jfKT+s9dRr/KnDK76WSqiqATkhZtZxHYQVNdr/kaOITclz4wpybh+KdheVIMJqKimeb4S9SUIWAXuuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733320403; c=relaxed/simple;
	bh=QelODbrUSKs3fbbbWhiWgqgeBvwKNSJxqDNPAxBWVOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9bVhQbN2azzY969xRJMF5UQEQbFvyNgoekCetac6Tt36iklZe1ZPX8Fdn3aOvTqNhCrxrFS8xZSjLVxLkuyQi+oAaCKi7UVF1qvXuZIh7L315oyNKofm7kIWPVyvSA1ImMZaLCR36VyhJyNJiVneCnTbsveYyJN498Fz8jLc1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lankhorst.se; spf=none smtp.mailfrom=mblankhorst.nl; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mblankhorst.nl
From: Maarten Lankhorst <dev@lankhorst.se>
To: linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Friedrich Vock <friedrich.vock@gmx.de>,
	Maxime Ripard <mripard@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [PATCH v2 2/7] drm/drv: Add drmm managed registration helper for dmem cgroups.
Date: Wed,  4 Dec 2024 14:44:02 +0100
Message-ID: <20241204134410.1161769-3-dev@lankhorst.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204134410.1161769-1-dev@lankhorst.se>
References: <20241204134410.1161769-1-dev@lankhorst.se>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxime Ripard <mripard@kernel.org>

Drivers will need to register dmem regions at probe time, so let's
give them a drm-managed helper.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/gpu/drm/drm_drv.c | 32 ++++++++++++++++++++++++++++++++
 include/drm/drm_drv.h     |  5 +++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index c2c172eb25df7..3cf440eee8a2a 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -26,6 +26,7 @@
  * DEALINGS IN THE SOFTWARE.
  */
 
+#include <linux/cgroup_dmem.h>
 #include <linux/debugfs.h>
 #include <linux/fs.h>
 #include <linux/module.h>
@@ -820,6 +821,37 @@ void drm_dev_put(struct drm_device *dev)
 }
 EXPORT_SYMBOL(drm_dev_put);
 
+static void drmm_cg_unregister_region(struct drm_device *dev, void *arg)
+{
+	dmem_cgroup_unregister_region(arg);
+}
+
+/**
+ * drmm_cgroup_register_region - Register a region of a DRM device to cgroups
+ * @dev: device for region
+ * @region_name: Region name for registering
+ * @size: Size of region in bytes
+ *
+ * This decreases the ref-count of @dev by one. The device is destroyed if the
+ * ref-count drops to zero.
+ */
+struct dmem_cgroup_region *drmm_cgroup_register_region(struct drm_device *dev, const char *region_name, u64 size)
+{
+	struct dmem_cgroup_region *region;
+	int ret;
+
+	region = dmem_cgroup_register_region(size, "drm/%s/%s", dev->unique, region_name);
+	if (IS_ERR_OR_NULL(region))
+		return region;
+
+	ret = drmm_add_action_or_reset(dev, drmm_cg_unregister_region, region);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return region;
+}
+EXPORT_SYMBOL_GPL(drmm_cgroup_register_region);
+
 static int create_compat_control_link(struct drm_device *dev)
 {
 	struct drm_minor *minor;
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 1bbbcb8e2d231..7dd49d9ab5058 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -34,6 +34,7 @@
 
 #include <drm/drm_device.h>
 
+struct dmem_cgroup_region;
 struct drm_fb_helper;
 struct drm_fb_helper_surface_size;
 struct drm_file;
@@ -438,6 +439,10 @@ void *__devm_drm_dev_alloc(struct device *parent,
 			   const struct drm_driver *driver,
 			   size_t size, size_t offset);
 
+struct dmem_cgroup_region *
+drmm_cgroup_register_region(struct drm_device *dev,
+			    const char *region_name, u64 size);
+
 /**
  * devm_drm_dev_alloc - Resource managed allocation of a &drm_device instance
  * @parent: Parent device object
-- 
2.43.0



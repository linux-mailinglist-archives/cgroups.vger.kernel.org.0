Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E510304F6A
	for <lists+cgroups@lfdr.de>; Wed, 27 Jan 2021 04:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbhA0DJj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Jan 2021 22:09:39 -0500
Received: from mga03.intel.com ([134.134.136.65]:28863 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbhAZVqp (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 26 Jan 2021 16:46:45 -0500
IronPort-SDR: FETV6FTF+vAYxcaP2OibwJCg5tivi8lShWOD3bsd+kkFypTgYS8laan2p7ppKsxEeXlkWsHhn8
 wY/DMJU03HUw==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="180056559"
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="180056559"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 13:44:37 -0800
IronPort-SDR: 2ae6tLysyhXYthrpXKJY7bn1HEolCNzb8kVzjeOw1gYWAb9q6U2u4NBMDYgFtUTNzIk+XORYCO
 RuLb09byOB9A==
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="362139891"
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
Subject: [RFC PATCH 3/9] drm, cgroup: Initialize drmcg properties
Date:   Tue, 26 Jan 2021 13:46:20 -0800
Message-Id: <20210126214626.16260-4-brian.welty@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210126214626.16260-1-brian.welty@intel.com>
References: <20210126214626.16260-1-brian.welty@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Kenny Ho <Kenny.Ho@amd.com>

drmcg initialization involves allocating a per cgroup, per device data
structure and setting the defaults.  There are two entry points for
drmcg init:

1) When struct drmcg is created via css_alloc, initialization is done
  for each device

2) When DRM devices are created after drmcgs are created, per
  device drmcg data structure is allocated at the beginning of
  DRM device creation such that drmcg can begin tracking usage
  statistics

Entry point #2 usually applies to the root cgroup since it can be
created before DRM devices are available.  The drmcg controller will go
through all existing drm cgroups and initialize them with the new device
accordingly.

Extending Kenny's original work, this has been simplified some and
the custom_init callback has been removed. (Brian)

Signed-off-by Kenny Ho <Kenny.Ho@amd.com>
Signed-off-by: Brian Welty <brian.welty@intel.com>
---
 drivers/gpu/drm/drm_drv.c  |  3 ++
 include/drm/drm_cgroup.h   | 17 +++++++
 include/drm/drm_device.h   |  7 +++
 include/linux/cgroup_drm.h | 13 ++++++
 kernel/cgroup/drm.c        | 95 +++++++++++++++++++++++++++++++++++++-
 5 files changed, 134 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 3b940926d672..dac742445b38 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -570,6 +570,7 @@ static void drm_dev_init_release(struct drm_device *dev, void *res)
 	/* Prevent use-after-free in drm_managed_release when debugging is
 	 * enabled. Slightly awkward, but can't really be helped. */
 	dev->dev = NULL;
+	mutex_destroy(&dev->drmcg_mutex);
 	mutex_destroy(&dev->master_mutex);
 	mutex_destroy(&dev->clientlist_mutex);
 	mutex_destroy(&dev->filelist_mutex);
@@ -612,6 +613,7 @@ static int drm_dev_init(struct drm_device *dev,
 	mutex_init(&dev->filelist_mutex);
 	mutex_init(&dev->clientlist_mutex);
 	mutex_init(&dev->master_mutex);
+	mutex_init(&dev->drmcg_mutex);
 
 	ret = drmm_add_action(dev, drm_dev_init_release, NULL);
 	if (ret)
@@ -652,6 +654,7 @@ static int drm_dev_init(struct drm_device *dev,
 	if (ret)
 		goto err;
 
+	drmcg_device_early_init(dev);
 	return 0;
 
 err:
diff --git a/include/drm/drm_cgroup.h b/include/drm/drm_cgroup.h
index 530c9a0b3238..43caf1b6a0de 100644
--- a/include/drm/drm_cgroup.h
+++ b/include/drm/drm_cgroup.h
@@ -4,6 +4,17 @@
 #ifndef __DRM_CGROUP_H__
 #define __DRM_CGROUP_H__
 
+#include <drm/drm_file.h>
+
+struct drm_device;
+
+/**
+ * Per DRM device properties for DRM cgroup controller for the purpose
+ * of storing per device defaults
+ */
+struct drmcg_props {
+};
+
 #ifdef CONFIG_CGROUP_DRM
 
 void drmcg_bind(struct drm_minor (*(*acq_dm)(unsigned int minor_id)),
@@ -15,6 +26,8 @@ void drmcg_register_dev(struct drm_device *dev);
 
 void drmcg_unregister_dev(struct drm_device *dev);
 
+void drmcg_device_early_init(struct drm_device *device);
+
 #else
 
 static inline void drmcg_bind(
@@ -35,5 +48,9 @@ static inline void drmcg_unregister_dev(struct drm_device *dev)
 {
 }
 
+static inline void drmcg_device_early_init(struct drm_device *device)
+{
+}
+
 #endif /* CONFIG_CGROUP_DRM */
 #endif /* __DRM_CGROUP_H__ */
diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
index d647223e8390..1cdccc9a653c 100644
--- a/include/drm/drm_device.h
+++ b/include/drm/drm_device.h
@@ -8,6 +8,7 @@
 
 #include <drm/drm_hashtab.h>
 #include <drm/drm_mode_config.h>
+#include <drm/drm_cgroup.h>
 
 struct drm_driver;
 struct drm_minor;
@@ -318,6 +319,12 @@ struct drm_device {
 	 */
 	struct drm_fb_helper *fb_helper;
 
+        /** \name DRM Cgroup */
+	/*@{ */
+	struct mutex drmcg_mutex;
+	struct drmcg_props drmcg_props;
+	/*@} */
+
 	/* Everything below here is for legacy driver, never use! */
 	/* private: */
 #if IS_ENABLED(CONFIG_DRM_LEGACY)
diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
index 307bb75db248..50f055804400 100644
--- a/include/linux/cgroup_drm.h
+++ b/include/linux/cgroup_drm.h
@@ -12,11 +12,19 @@
 
 #ifdef CONFIG_CGROUP_DRM
 
+/**
+ * Per DRM cgroup, per device resources (such as statistics and limits)
+ */
+struct drmcg_device_resource {
+	/* for per device stats */
+};
+
 /**
  * The DRM cgroup controller data structure.
  */
 struct drmcg {
 	struct cgroup_subsys_state	css;
+	struct drmcg_device_resource	*dev_resources[MAX_DRM_DEV];
 };
 
 /**
@@ -40,6 +48,8 @@ static inline struct drmcg *css_to_drmcg(struct cgroup_subsys_state *css)
  */
 static inline struct drmcg *drmcg_get(struct task_struct *task)
 {
+	if (!cgroup_subsys_enabled(gpu_cgrp_subsys))
+		return NULL;
 	return css_to_drmcg(task_get_css(task, gpu_cgrp_id));
 }
 
@@ -70,6 +80,9 @@ static inline struct drmcg *drmcg_parent(struct drmcg *cg)
 
 #else /* CONFIG_CGROUP_DRM */
 
+struct drmcg_device_resource {
+};
+
 struct drmcg {
 };
 
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
index 061bb9c458e4..836929c27de8 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -1,11 +1,15 @@
 // SPDX-License-Identifier: MIT
-// Copyright 2019 Advanced Micro Devices, Inc.
+/*
+ * Copyright 2019 Advanced Micro Devices, Inc.
+ * Copyright © 2021 Intel Corporation
+ */
 #include <linux/bitmap.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/cgroup.h>
 #include <linux/cgroup_drm.h>
 #include <drm/drm_file.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_device.h>
 #include <drm/drm_cgroup.h>
 
@@ -54,6 +58,26 @@ void drmcg_unbind(void)
 }
 EXPORT_SYMBOL(drmcg_unbind);
 
+/* caller must hold dev->drmcg_mutex */
+static inline int init_drmcg_single(struct drmcg *drmcg, struct drm_device *dev)
+{
+	int minor = dev->primary->index;
+	struct drmcg_device_resource *ddr = drmcg->dev_resources[minor];
+
+	if (ddr == NULL) {
+		ddr = kzalloc(sizeof(struct drmcg_device_resource),
+			GFP_KERNEL);
+
+		if (!ddr)
+			return -ENOMEM;
+	}
+
+	/* set defaults here */
+	drmcg->dev_resources[minor] = ddr;
+
+	return 0;
+}
+
 /**
  * drmcg_register_dev - register a DRM device for usage in drm cgroup
  * @dev: DRM device
@@ -137,23 +161,61 @@ static int drm_minor_for_each(int (*fn)(int id, void *p, void *data),
 	return rc;
 }
 
+static int drmcg_css_free_fn(int id, void *ptr, void *data)
+{
+	struct drm_minor *minor = ptr;
+	struct drmcg *drmcg = data;
+
+	if (minor->type != DRM_MINOR_PRIMARY)
+		return 0;
+
+	kfree(drmcg->dev_resources[minor->index]);
+
+	return 0;
+}
+
 static void drmcg_css_free(struct cgroup_subsys_state *css)
 {
 	struct drmcg *drmcg = css_to_drmcg(css);
 
+	drm_minor_for_each(&drmcg_css_free_fn, drmcg);
+
 	kfree(drmcg);
 }
 
+static int init_drmcg_fn(int id, void *ptr, void *data)
+{
+	struct drm_minor *minor = ptr;
+	struct drmcg *drmcg = data;
+	int rc;
+
+	if (minor->type != DRM_MINOR_PRIMARY)
+		return 0;
+
+	mutex_lock(&minor->dev->drmcg_mutex);
+	rc = init_drmcg_single(drmcg, minor->dev);
+	mutex_unlock(&minor->dev->drmcg_mutex);
+
+	return rc;
+}
+
 static struct cgroup_subsys_state *
 drmcg_css_alloc(struct cgroup_subsys_state *parent_css)
 {
 	struct drmcg *parent = css_to_drmcg(parent_css);
 	struct drmcg *drmcg;
+	int rc;
 
 	drmcg = kzalloc(sizeof(struct drmcg), GFP_KERNEL);
 	if (!drmcg)
 		return ERR_PTR(-ENOMEM);
 
+	rc = drm_minor_for_each(&init_drmcg_fn, drmcg);
+	if (rc) {
+		drmcg_css_free(&drmcg->css);
+		return ERR_PTR(rc);
+	}
+
 	if (!parent)
 		root_drmcg = drmcg;
 
@@ -171,3 +233,34 @@ struct cgroup_subsys gpu_cgrp_subsys = {
 	.legacy_cftypes	= files,
 	.dfl_cftypes	= files,
 };
+
+/**
+ * drmcg_device_early_init - initialize device specific resources for DRM cgroups
+ * @dev: the target DRM device
+ *
+ * Allocate and initialize device specific resources for existing DRM cgroups.
+ * Typically only the root cgroup exists before the initialization of @dev.
+ */
+void drmcg_device_early_init(struct drm_device *dev)
+{
+	struct cgroup_subsys_state *pos;
+
+	if (root_drmcg == NULL)
+		return;
+
+	/* init cgroups created before registration (i.e. root cgroup) */
+	rcu_read_lock();
+	css_for_each_descendant_pre(pos, &root_drmcg->css) {
+		css_get(pos);
+		rcu_read_unlock();
+
+		mutex_lock(&dev->drmcg_mutex);
+		init_drmcg_single(css_to_drmcg(pos), dev);
+		mutex_unlock(&dev->drmcg_mutex);
+
+		rcu_read_lock();
+		css_put(pos);
+	}
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL(drmcg_device_early_init);
-- 
2.20.1


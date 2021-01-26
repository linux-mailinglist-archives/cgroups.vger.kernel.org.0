Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D24304F65
	for <lists+cgroups@lfdr.de>; Wed, 27 Jan 2021 04:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbhA0DJp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Jan 2021 22:09:45 -0500
Received: from mga03.intel.com ([134.134.136.65]:29044 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbhAZVrK (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 26 Jan 2021 16:47:10 -0500
IronPort-SDR: sGnFJlUmKs0LYYIIrtuWSGZYD6CwxrnG7V3nOveSvRkjlYaE2EAHUwaXCcC3HoFBk/W1JQxJ4C
 Ni/xleOU+R2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="180056562"
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="180056562"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 13:44:37 -0800
IronPort-SDR: FzYxckzEHP5AdU4pW4zaw6I6XIsoOUFpNykAB8xd8wufq1tt23CgscMqeq1nTB5dJOAYHtw4fS
 WSyezQdLOLIA==
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="362139897"
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
Subject: [RFC PATCH 5/9] drmcg: Add support for device memory accounting via page counter
Date:   Tue, 26 Jan 2021 13:46:22 -0800
Message-Id: <20210126214626.16260-6-brian.welty@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210126214626.16260-1-brian.welty@intel.com>
References: <20210126214626.16260-1-brian.welty@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Here we introduce a general purpose drm_cgroup_try_charge and uncharge
pair of functions. This is modelled after the existing RDMA cgroup controller,
and the idea is for these functions to be used for charging/uncharging all
current and future DRM resource controls.

Two new controls are added in order to allow DRM device drivers to expose
memories attached to the device for purposes of memory accounting and
enforcing allocation limit.

Following controls are introduced and are intended to provide equivalent
behavior and functionality where possible as the MEM controller:

  memory.current
      Read-only value, displays current device memory usage for all DRM
      device memory in terms of allocated physical backing store.

  memory.max
      Read-write value, displays the maximum memory usage limit of device
      memory. If memory usage reaches this limit, then subsequent memory
      allocations will fail.

The expectation is that the DRM device driver simply lets allocations fail
when memory.max is reached.  Future work might be to introduce the device
memory concept of memory.high or memory.low controls, such that DRM device
might be able to invoke memory eviction when these lower threshold are hit.

With provided charging functions, support for memory accounting/charging
is functional.  The intent is for DRM device drivers to charge against
memory.current as device memory is physically allocated.   Implementation is
simplified by making use of page counters underneath.  Nested cgroups will
correctly maintain the parent for the memory page counters, such that
hierarchial charging to parent's memory.current is supported.

Note, this is only for tracking of allocations from device-backed memory.
Memory charging for objects that are backed by system memory is already
handled by the mm subsystem and existing memory accounting controls.

Signed-off-by: Brian Welty <brian.welty@intel.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  29 ++++-
 include/drm/drm_cgroup.h                |  20 ++++
 include/linux/cgroup_drm.h              |   4 +-
 kernel/cgroup/drm.c                     | 145 +++++++++++++++++++++++-
 4 files changed, 191 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index b099e1d71098..405912710b3a 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2171,8 +2171,35 @@ of GPU-related resources.
 GPU Interface Files
 ~~~~~~~~~~~~~~~~~~~~
 
-TODO
+GPU controller supports usage of multiple DRM devices within a cgroup.
+As such, for all interface files, output is keyed by device major:minor
+and is not ordered.
 
+The first set of control files are for regulating the accounting and
+allocation of memories attached to DRM devices.  The controls are intended
+to provide equivalent behavior and functionality where possible as the
+MEM controller.  All memory amounts are in bytes.
+
+  memory.current
+        Read-only value, displays current device memory usage for the DRM
+        device memory in terms of allocated physical backing store.
+
+  memory.max
+        Read-write value, displays the maximum memory usage limit for the
+        DRM device memory.  If memory usage reaches this limit,
+        subsequent device memory allocations will fail.
+
+While some DRM devices may be capable to present multiple memory segments
+to the user, the intent with above controls is to aggregate all user
+allocatable backing store.  Any support for multiple memory segments is
+left as future work.
+
+The expectation is that the DRM device driver simply lets allocations fail
+when memory.max is reached.  Future work might be to introduce the device
+memory concept of memory.high or memory.low controls.  When these lower
+thresholds are hit, this would then allow the DRM device driver to invoke
+some equivalent to OOM-killer or forced memory eviction for the device
+backed memory in order to attempt to free additional space.
 
 Misc
 ----
diff --git a/include/drm/drm_cgroup.h b/include/drm/drm_cgroup.h
index 12526def9fbf..8b4c4e798b11 100644
--- a/include/drm/drm_cgroup.h
+++ b/include/drm/drm_cgroup.h
@@ -8,6 +8,7 @@
 #include <drm/drm_file.h>
 
 struct drm_device;
+struct drmcg;
 
 /**
  * Per DRM device properties for DRM cgroup controller for the purpose
@@ -17,6 +18,8 @@ struct drmcg_props {
 };
 
 enum drmcg_res_type {
+	DRMCG_TYPE_MEM_CURRENT,
+	DRMCG_TYPE_MEM_MAX,
 	__DRMCG_TYPE_LAST,
 };
 
@@ -33,6 +36,11 @@ void drmcg_unregister_dev(struct drm_device *dev);
 
 void drmcg_device_early_init(struct drm_device *device);
 
+int drm_cgroup_try_charge(struct drmcg *drmcg, struct drm_device *dev,
+			  enum drmcg_res_type type, u64 usage);
+void drm_cgroup_uncharge(struct drmcg *drmcg, struct drm_device *dev,
+			 enum drmcg_res_type type, u64 usage);
+
 #else
 
 static inline void drmcg_bind(
@@ -57,5 +65,17 @@ static inline void drmcg_device_early_init(struct drm_device *device)
 {
 }
 
+static inline
+int drm_cgroup_try_charge(struct drmcg *drmcg, struct drm_device *dev,
+			  enum drmcg_res_type res, u64 usage)
+{
+	return 0;
+}
+
+static inline
+void drm_cgroup_uncharge(struct drmcg *drmcg,struct drm_device *dev,
+			 enum drmcg_res_type type, u64 usage)
+{
+}
 #endif /* CONFIG_CGROUP_DRM */
 #endif /* __DRM_CGROUP_H__ */
diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
index 50f055804400..3570636473cf 100644
--- a/include/linux/cgroup_drm.h
+++ b/include/linux/cgroup_drm.h
@@ -1,10 +1,12 @@
 /* SPDX-License-Identifier: MIT
  * Copyright 2019 Advanced Micro Devices, Inc.
+ * Copyright © 2021 Intel Corporation
  */
 #ifndef _CGROUP_DRM_H
 #define _CGROUP_DRM_H
 
 #include <linux/cgroup.h>
+#include <linux/page_counter.h>
 #include <drm/drm_file.h>
 
 /* limit defined per the way drm_minor_alloc operates */
@@ -16,7 +18,7 @@
  * Per DRM cgroup, per device resources (such as statistics and limits)
  */
 struct drmcg_device_resource {
-	/* for per device stats */
+	struct page_counter memory;
 };
 
 /**
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
index aece11faa0bc..bec41f343208 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -64,6 +64,7 @@ EXPORT_SYMBOL(drmcg_unbind);
 static inline int init_drmcg_single(struct drmcg *drmcg, struct drm_device *dev)
 {
 	int minor = dev->primary->index;
+	struct drmcg_device_resource *parent_ddr = NULL;
 	struct drmcg_device_resource *ddr = drmcg->dev_resources[minor];
 
 	if (ddr == NULL) {
@@ -74,7 +75,12 @@ static inline int init_drmcg_single(struct drmcg *drmcg, struct drm_device *dev)
 			return -ENOMEM;
 	}
 
+	if (drmcg_parent(drmcg))
+		parent_ddr = drmcg_parent(drmcg)->dev_resources[minor];
+
 	/* set defaults here */
+	page_counter_init(&ddr->memory,
+			  parent_ddr ? &parent_ddr->memory : NULL);
 	drmcg->dev_resources[minor] = ddr;
 
 	return 0;
@@ -212,6 +218,13 @@ drmcg_css_alloc(struct cgroup_subsys_state *parent_css)
 	if (!drmcg)
 		return ERR_PTR(-ENOMEM);
 
+	/*
+	 * parent is normally set upon return in caller, but set here as
+	 * is needed by init_drmcg_single so resource initialization can
+	 * associate with parent for hierarchial charging
+	 */
+	drmcg->css.parent = parent_css;
+
 	rc = drm_minor_for_each(&init_drmcg_fn, drmcg);
 	if (rc) {
 		drmcg_css_free(&drmcg->css);
@@ -231,6 +244,10 @@ static int drmcg_apply_value(struct drmcg_device_resource *ddr,
 	unsigned long val;
 
 	switch (type) {
+	case DRMCG_TYPE_MEM_MAX:
+		ret = page_counter_memparse(buf, "max", &val);
+		if (!ret)
+			ret = page_counter_set_max(&ddr->memory, val);
 	default:
 		break;
 	}
@@ -253,10 +270,21 @@ static int drmcg_seq_show_fn(int id, void *ptr, void *data)
 	if (ddr == NULL)
 		return 0;
 
-	seq_printf(sf, "%d:%d ", DRM_MAJOR, minor->index);
 	switch (type) {
+	case DRMCG_TYPE_MEM_CURRENT:
+		seq_printf(sf, "%d:%d %ld\n",
+			   DRM_MAJOR, minor->index,
+			   page_counter_read(&ddr->memory) * PAGE_SIZE);
+		break;
+	case DRMCG_TYPE_MEM_MAX:
+		seq_printf(sf, "%d:%d ", DRM_MAJOR, minor->index);
+		if (ddr->memory.max == PAGE_COUNTER_MAX)
+			seq_printf(sf, "max\n");
+		else
+			seq_printf(sf, "%ld\n", ddr->memory.max * PAGE_SIZE);
+		break;
 	default:
-		seq_puts(sf, "\n");
+		seq_printf(sf, "%d:%d\n", DRM_MAJOR, minor->index);
 		break;
 	}
 
@@ -268,6 +296,17 @@ static int drmcg_seq_show(struct seq_file *sf, void *v)
 	return drm_minor_for_each(&drmcg_seq_show_fn, sf);
 }
 
+static int drmcg_parse_input(const char *buf, enum drmcg_res_type type,
+			     int *minor, char *sattr)
+{
+	if (sscanf(buf,
+		   __stringify(DRM_MAJOR)":%u %255[^\t\n]",
+		   minor, sattr) != 2)
+		return -EINVAL;
+
+	return 0;
+}
+
 static ssize_t drmcg_write(struct kernfs_open_file *of, char *buf,
 			   size_t nbytes, loff_t off)
 {
@@ -284,9 +323,7 @@ static ssize_t drmcg_write(struct kernfs_open_file *of, char *buf,
 	while (!ret && limits != NULL) {
 		line =  strsep(&limits, "\n");
 
-		if (sscanf(line,
-			__stringify(DRM_MAJOR)":%u %255[^\t\n]",
-							&minor, sattr) != 2) {
+		if (drmcg_parse_input(line, type, &minor, sattr)) {
 			pr_err("drmcg: error parsing %s ", cft_name);
 			pr_cont_cgroup_name(drmcg->css.cgroup);
 			pr_cont("\n");
@@ -325,6 +362,18 @@ static ssize_t drmcg_write(struct kernfs_open_file *of, char *buf,
 }
 
 struct cftype files[] = {
+	{
+		.name = "memory.current",
+		.seq_show = drmcg_seq_show,
+		.private = DRMCG_TYPE_MEM_CURRENT,
+	},
+	{
+		.name = "memory.max",
+		.seq_show = drmcg_seq_show,
+		.write = drmcg_write,
+		.private = DRMCG_TYPE_MEM_MAX,
+		.flags = CFTYPE_NOT_ON_ROOT
+	},
 	{ }	/* terminate */
 };
 
@@ -366,3 +415,89 @@ void drmcg_device_early_init(struct drm_device *dev)
 	rcu_read_unlock();
 }
 EXPORT_SYMBOL(drmcg_device_early_init);
+
+/**
+ * drm_cgroup_try_charge - try charging against drmcg resource
+ * @drmcg: DRM cgroup to charge
+ * @dev: associated DRM device
+ * @type: which resource type to charge
+ * @usage: usage to be charged
+ *
+ * For @type of DRMCG_TYPE_MEM_CURRENT:
+ * Try to charge @usage bytes to specified DRM cgroup.  This will fail if
+ * a successful charge would cause the current device memory usage to go
+ * above the maximum limit.  On failure, the caller (DRM device driver) may
+ * choose to enact some form of memory reclaim, but the exact behavior is left
+ * to the DRM device driver to define.
+ *
+ * Returns 0 on success.  Otherwise, an error code is returned.
+ */
+int drm_cgroup_try_charge(struct drmcg *drmcg, struct drm_device *dev,
+			  enum drmcg_res_type type, u64 usage)
+{
+	struct drmcg_device_resource *res;
+	struct page_counter *counter;
+	int err = -ENOMEM;
+	u64 nr_pages;
+
+	if (!drmcg)
+		return 0;
+
+	res = drmcg->dev_resources[dev->primary->index];
+	if (!res)
+		return -EINVAL;
+
+	switch (type) {
+	case DRMCG_TYPE_MEM_CURRENT:
+		nr_pages = usage >> PAGE_SHIFT;
+		if (page_counter_try_charge(&res->memory, nr_pages,
+					    &counter)) {
+			css_get_many(&drmcg->css, nr_pages);
+			err = 0;
+		}
+		break;
+	default:
+		err = -EINVAL;
+		break;
+	}
+
+	return err;
+}
+EXPORT_SYMBOL(drm_cgroup_try_charge);
+
+/**
+ * drm_cgroup_uncharge - uncharge resource usage from drmcg
+ * @drmcg: DRM cgroup to uncharge
+ * @dev: associated DRM device
+ * @type: which resource type to uncharge
+ * @usage: usage to be uncharged
+ *
+ * Action for each @type:
+ * DRMCG_TYPE_MEM_CURRENT: Uncharge @usage bytes from specified DRM cgroup.
+ *
+ * Returns 0 on success.  Otherwise, an error code is returned.
+ */
+void drm_cgroup_uncharge(struct drmcg *drmcg, struct drm_device *dev,
+			 enum drmcg_res_type type, u64 usage)
+{
+	struct drmcg_device_resource *res;
+	u64 nr_pages;
+
+	if (!drmcg)
+		return;
+
+	res = drmcg->dev_resources[dev->primary->index];
+	if (!res)
+		return;
+
+	switch (type) {
+	case DRMCG_TYPE_MEM_CURRENT:
+		nr_pages = usage >> PAGE_SHIFT;
+		page_counter_uncharge(&res->memory, nr_pages);
+		css_put_many(&drmcg->css, nr_pages);
+		break;
+	default:
+		break;
+	}
+}
+EXPORT_SYMBOL(drm_cgroup_uncharge);
-- 
2.20.1


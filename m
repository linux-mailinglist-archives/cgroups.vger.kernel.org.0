Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13842304F64
	for <lists+cgroups@lfdr.de>; Wed, 27 Jan 2021 04:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbhA0DJm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Jan 2021 22:09:42 -0500
Received: from mga03.intel.com ([134.134.136.65]:28968 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbhAZVrH (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 26 Jan 2021 16:47:07 -0500
IronPort-SDR: goaoabE2KyQjBeUrq6RGdlMGTrCgS9ZnFo0WPVMCaZo+jSiaJ55F7ty84UYAUntwKLTZQBmULQ
 LaO+jCVMaEyw==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="180056561"
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="180056561"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 13:44:37 -0800
IronPort-SDR: OfkL2jyeVJD0ADEkQs01vPNC8EYhXhZqLWDvifr1sAW3vHpmZx6di1vf+NueX71l7Z9hPJ6sGc
 DsdvaaXNBPZw==
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="362139893"
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
Subject: [RFC PATCH 4/9] drmcg: Add skeleton seq_show and write for drmcg files
Date:   Tue, 26 Jan 2021 13:46:21 -0800
Message-Id: <20210126214626.16260-5-brian.welty@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210126214626.16260-1-brian.welty@intel.com>
References: <20210126214626.16260-1-brian.welty@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Add basic .seq_show and .write functions for use with DRM cgroup control
files.  This is based on original work from Kenny Ho and extracted from
patches [1] and [2].  Has been simplified to remove having different file
types and functions for each.

[1] https://lists.freedesktop.org/archives/dri-devel/2020-February/254986.html
[2] https://lists.freedesktop.org/archives/dri-devel/2020-February/254990.html

Co-developed-by: Kenny Ho <Kenny.Ho@amd.com>
Signed-off-by: Brian Welty <brian.welty@intel.com>
---
 include/drm/drm_cgroup.h |   5 ++
 kernel/cgroup/drm.c      | 102 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/include/drm/drm_cgroup.h b/include/drm/drm_cgroup.h
index 43caf1b6a0de..12526def9fbf 100644
--- a/include/drm/drm_cgroup.h
+++ b/include/drm/drm_cgroup.h
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: MIT
  * Copyright 2019 Advanced Micro Devices, Inc.
+ * Copyright © 2021 Intel Corporation
  */
 #ifndef __DRM_CGROUP_H__
 #define __DRM_CGROUP_H__
@@ -15,6 +16,10 @@ struct drm_device;
 struct drmcg_props {
 };
 
+enum drmcg_res_type {
+	__DRMCG_TYPE_LAST,
+};
+
 #ifdef CONFIG_CGROUP_DRM
 
 void drmcg_bind(struct drm_minor (*(*acq_dm)(unsigned int minor_id)),
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
index 836929c27de8..aece11faa0bc 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -5,6 +5,7 @@
  */
 #include <linux/bitmap.h>
 #include <linux/mutex.h>
+#include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/cgroup.h>
 #include <linux/cgroup_drm.h>
@@ -12,6 +13,7 @@
 #include <drm/drm_drv.h>
 #include <drm/drm_device.h>
 #include <drm/drm_cgroup.h>
+#include <drm/drm_ioctl.h>
 
 static struct drmcg *root_drmcg __read_mostly;
 
@@ -222,6 +224,106 @@ drmcg_css_alloc(struct cgroup_subsys_state *parent_css)
 	return &drmcg->css;
 }
 
+static int drmcg_apply_value(struct drmcg_device_resource *ddr,
+			     enum drmcg_res_type type, char *buf)
+{
+	int ret = 0;
+	unsigned long val;
+
+	switch (type) {
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static int drmcg_seq_show_fn(int id, void *ptr, void *data)
+{
+	struct drm_minor *minor = ptr;
+	struct seq_file *sf = data;
+	struct drmcg *drmcg = css_to_drmcg(seq_css(sf));
+	enum drmcg_res_type type = seq_cft(sf)->private;
+	struct drmcg_device_resource *ddr;
+
+	if (minor->type != DRM_MINOR_PRIMARY)
+		return 0;
+
+	ddr = drmcg->dev_resources[minor->index];
+	if (ddr == NULL)
+		return 0;
+
+	seq_printf(sf, "%d:%d ", DRM_MAJOR, minor->index);
+	switch (type) {
+	default:
+		seq_puts(sf, "\n");
+		break;
+	}
+
+	return 0;
+}
+
+static int drmcg_seq_show(struct seq_file *sf, void *v)
+{
+	return drm_minor_for_each(&drmcg_seq_show_fn, sf);
+}
+
+static ssize_t drmcg_write(struct kernfs_open_file *of, char *buf,
+			   size_t nbytes, loff_t off)
+{
+	struct drmcg *drmcg = css_to_drmcg(of_css(of));
+	enum drmcg_res_type type = of_cft(of)->private;
+	char *cft_name = of_cft(of)->name;
+	char *limits = strstrip(buf);
+	struct drmcg_device_resource *ddr;
+	struct drm_minor *dm;
+	char *line;
+	char sattr[256];
+	int minor, ret = 0;
+
+	while (!ret && limits != NULL) {
+		line =  strsep(&limits, "\n");
+
+		if (sscanf(line,
+			__stringify(DRM_MAJOR)":%u %255[^\t\n]",
+							&minor, sattr) != 2) {
+			pr_err("drmcg: error parsing %s ", cft_name);
+			pr_cont_cgroup_name(drmcg->css.cgroup);
+			pr_cont("\n");
+
+			continue;
+		}
+
+		mutex_lock(&drmcg_mutex);
+		if (acquire_drm_minor)
+			dm = acquire_drm_minor(minor);
+		else
+			dm = NULL;
+		mutex_unlock(&drmcg_mutex);
+
+		if (IS_ERR_OR_NULL(dm)) {
+			pr_err("drmcg: invalid minor %d for %s ",
+					minor, cft_name);
+			pr_cont_cgroup_name(drmcg->css.cgroup);
+			pr_cont("\n");
+
+			continue;
+		}
+
+		mutex_lock(&dm->dev->drmcg_mutex);
+		ddr = drmcg->dev_resources[minor];
+		ret = drmcg_apply_value(ddr, type, sattr);
+		mutex_unlock(&dm->dev->drmcg_mutex);
+
+		mutex_lock(&drmcg_mutex);
+		if (put_drm_dev)
+			put_drm_dev(dm->dev); /* release from acquire_drm_minor */
+		mutex_unlock(&drmcg_mutex);
+	}
+
+	return ret ?: nbytes;
+}
+
 struct cftype files[] = {
 	{ }	/* terminate */
 };
-- 
2.20.1


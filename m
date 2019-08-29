Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 494EAA1157
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2019 08:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfH2GFs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Aug 2019 02:05:48 -0400
Received: from mail-eopbgr770071.outbound.protection.outlook.com ([40.107.77.71]:3910
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726973AbfH2GFs (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 29 Aug 2019 02:05:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbM2WRs5ttAz78pAfNQ0P0VTlRgZ1/WsFdlPqYU59XbqZLCNwhHazGd81a208k7nzRvfvF3HVEl76Clt8phSqtJvpjW/Mvitx026lzXakeOm6pYOgkH37pGYqVhG8VZryEO3NrXa8AFfBhVSMAkWYKXVHhGSyt7wI7cUYP6eQ45XtyaFW2uauhrNP/73gI9UuLvg7q6ZLXiMEap8XDZ5syAYqDg0L0KA3koKOlcA7V6WsDnR36+g1r1PXmVwLRx4C/ikCoNzfF+D2GHJWvCSopl7d9YcCBaXte10lHpGvR5AqlLC9Sg8aTsMlAawoAyHIADXSPtHKUuf6hzIQVs1/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiGfUj8lkzJ3n79e6BUomcC2im3IgVaCAfZ0em4K9D8=;
 b=ZjOLopLwh88IcqEhrliRwCXAY8Oso0OJBqvMmKNP/v0LsLULPFMwNRRmvzLez09gs1U9ZQm7eD7jPj+oGSeYGsDEU8V2Ps0vxoLw4hri/D5NIq/A6u7649LM9xjdu4oqIDLd8/39V2X5bZ8nZwpZgF7jEuyeyaevoqaQd3g29EI4n/ETBBjaJnPbYWZRat9+HEzgCbt6l7mDqiAmPF7emlld2c7qla0JwrLVvN/USEKcvtNKLlu9ai6i9uKcxl7dc6cGv8Jz/D9rAKUd6VFNnq+eYI0W1PlJvE+v8Mj3LrxyXKRYQD7g5wkgDKnIQe1CgIzskQDToEFS/hh1U+2Nqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=cray.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiGfUj8lkzJ3n79e6BUomcC2im3IgVaCAfZ0em4K9D8=;
 b=F/85A8BHfYyS56NNQGmsnJiRuymDFnEkRRnIlR2at9P/ddHTF36pJ3QIv/Dt2oo65OGFs5x3KtCxzSwI6CpNPeK0sUjayLPvx2uhSJDs3ivetA4yeuSnTZLeo5mwfRT3jF7e2fRBaZaRUFsiQUTnbxwnxHYDbRdlm+9bepu/aWE=
Received: from CH2PR12CA0015.namprd12.prod.outlook.com (2603:10b6:610:57::25)
 by SN6PR12MB2717.namprd12.prod.outlook.com (2603:10b6:805:70::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.20; Thu, 29 Aug
 2019 06:05:46 +0000
Received: from CO1NAM03FT045.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::202) by CH2PR12CA0015.outlook.office365.com
 (2603:10b6:610:57::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.18 via Frontend
 Transport; Thu, 29 Aug 2019 06:05:45 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; cray.com; dkim=none (message not signed)
 header.d=none;cray.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 CO1NAM03FT045.mail.protection.outlook.com (10.152.81.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2220.16 via Frontend Transport; Thu, 29 Aug 2019 06:05:45 +0000
Received: from kho-5039A.amd.com (10.180.168.240) by SATLEXCHOV01.amd.com
 (10.181.40.71) with Microsoft SMTP Server id 14.3.389.1; Thu, 29 Aug 2019
 01:05:43 -0500
From:   Kenny Ho <Kenny.Ho@amd.com>
To:     <y2kenny@gmail.com>, <cgroups@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <tj@kernel.org>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <felix.kuehling@amd.com>,
        <joseph.greathouse@amd.com>, <jsparks@cray.com>,
        <lkaplan@cray.com>, <daniel@ffwll.ch>
CC:     Kenny Ho <Kenny.Ho@amd.com>
Subject: [PATCH RFC v4 03/16] drm, cgroup: Initialize drmcg properties
Date:   Thu, 29 Aug 2019 02:05:20 -0400
Message-ID: <20190829060533.32315-4-Kenny.Ho@amd.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829060533.32315-1-Kenny.Ho@amd.com>
References: <20190829060533.32315-1-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(376002)(39860400002)(2980300002)(428003)(189003)(199004)(446003)(186003)(2616005)(486006)(11346002)(14444005)(336012)(47776003)(2201001)(7696005)(76176011)(51416003)(86362001)(305945005)(476003)(126002)(4326008)(426003)(26005)(1076003)(2906002)(50226002)(356004)(6666004)(53416004)(36756003)(8676002)(478600001)(81166006)(53936002)(81156014)(5660300002)(2870700001)(8936002)(70206006)(110136005)(48376002)(316002)(70586007)(50466002)(921003)(1121003)(83996005)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2717;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 025f64c5-f4e2-4352-6e51-08d72c46ee75
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328);SRVR:SN6PR12MB2717;
X-MS-TrafficTypeDiagnostic: SN6PR12MB2717:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2717AE16324919432844661683A20@SN6PR12MB2717.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-Forefront-PRVS: 0144B30E41
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ae3ZS0U59ft24Xab2IS6lz3xxMxUxvKQO6r80983KE0Cv+6IcXReai3gTT45vWyRRlQpiNwZisNksgY07+uPCcp+rSh9/xSW7T0F4Xjqe6YTM73Jv2g4K9T5MIqTivTweMdGgDk9zk6fNx/UMxbbfNBwfTP23oHZ/TTKvR0gMZq8dCQRCzMYLxyFnIH0ksvGarTP0X69rXYn42Mc0esN6xuNZNXLScVU2BSO0lkL6by7aZcKJeRg9uw0Y7cKsu60SvKtYMFUoELQKhckvikcN+FW6gb73iq/1JSAGpDjTjwph4UcyZXVsw1jw1T4qW4XcBkBWs/ZkRL+fulWR7/SfzSPo1SFdd5gA5iqmKWqir3Hep8td949cTn0AjW53c198ogfl2b4l7etTTr6fz3l6C5wbVAr9kUi6GhEEs2Ii5k=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2019 06:05:45.2968
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 025f64c5-f4e2-4352-6e51-08d72c46ee75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2717
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

drmcg initialization involves allocating a per cgroup, per device data
structure and setting the defaults.  There are two entry points for
drmcg init:

1) When struct drmcg is created via css_alloc, initialization is done
for each device

2) When DRM devices are created after drmcgs are created
  a) Per device drmcg data structure is allocated at the beginning of
  DRM device creation such that drmcg can begin tracking usage
  statistics
  b) At the end of DRM device creation, drmcg_device_update is called in
  case device specific defaults need to be applied.

Entry point #2 usually applies to the root cgroup since it can be
created before DRM devices are available.  The drmcg controller will go
through all existing drm cgroups and initialize them with the new device
accordingly.

Change-Id: I908ee6975ea0585e4c30eafde4599f87094d8c65
Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>
---
 drivers/gpu/drm/drm_drv.c  |   7 +++
 include/drm/drm_cgroup.h   |  27 ++++++++
 include/drm/drm_device.h   |   7 +++
 include/drm/drm_drv.h      |   9 +++
 include/linux/cgroup_drm.h |  13 ++++
 kernel/cgroup/drm.c        | 123 +++++++++++++++++++++++++++++++++++++
 6 files changed, 186 insertions(+)
 create mode 100644 include/drm/drm_cgroup.h

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 000cddabd970..94265eba68ca 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -37,6 +37,7 @@
 #include <drm/drm_client.h>
 #include <drm/drm_drv.h>
 #include <drm/drmP.h>
+#include <drm/drm_cgroup.h>
 
 #include "drm_crtc_internal.h"
 #include "drm_legacy.h"
@@ -672,6 +673,7 @@ int drm_dev_init(struct drm_device *dev,
 	mutex_init(&dev->filelist_mutex);
 	mutex_init(&dev->clientlist_mutex);
 	mutex_init(&dev->master_mutex);
+	mutex_init(&dev->drmcg_mutex);
 
 	dev->anon_inode = drm_fs_inode_new();
 	if (IS_ERR(dev->anon_inode)) {
@@ -708,6 +710,7 @@ int drm_dev_init(struct drm_device *dev,
 	if (ret)
 		goto err_setunique;
 
+	drmcg_device_early_init(dev);
 	return 0;
 
 err_setunique:
@@ -722,6 +725,7 @@ int drm_dev_init(struct drm_device *dev,
 	drm_fs_inode_free(dev->anon_inode);
 err_free:
 	put_device(dev->dev);
+	mutex_destroy(&dev->drmcg_mutex);
 	mutex_destroy(&dev->master_mutex);
 	mutex_destroy(&dev->clientlist_mutex);
 	mutex_destroy(&dev->filelist_mutex);
@@ -798,6 +802,7 @@ void drm_dev_fini(struct drm_device *dev)
 
 	put_device(dev->dev);
 
+	mutex_destroy(&dev->drmcg_mutex);
 	mutex_destroy(&dev->master_mutex);
 	mutex_destroy(&dev->clientlist_mutex);
 	mutex_destroy(&dev->filelist_mutex);
@@ -1008,6 +1013,8 @@ int drm_dev_register(struct drm_device *dev, unsigned long flags)
 		 dev->dev ? dev_name(dev->dev) : "virtual device",
 		 dev->primary->index);
 
+	drmcg_device_update(dev);
+
 	goto out_unlock;
 
 err_minors:
diff --git a/include/drm/drm_cgroup.h b/include/drm/drm_cgroup.h
new file mode 100644
index 000000000000..bef9f9245924
--- /dev/null
+++ b/include/drm/drm_cgroup.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: MIT
+ * Copyright 2019 Advanced Micro Devices, Inc.
+ */
+#ifndef __DRM_CGROUP_H__
+#define __DRM_CGROUP_H__
+
+/**
+ * Per DRM device properties for DRM cgroup controller for the purpose
+ * of storing per device defaults
+ */
+struct drmcg_props {
+};
+
+#ifdef CONFIG_CGROUP_DRM
+
+void drmcg_device_update(struct drm_device *device);
+void drmcg_device_early_init(struct drm_device *device);
+#else
+static inline void drmcg_device_update(struct drm_device *device)
+{
+}
+
+static inline void drmcg_device_early_init(struct drm_device *device)
+{
+}
+#endif /* CONFIG_CGROUP_DRM */
+#endif /* __DRM_CGROUP_H__ */
diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
index 7f9ef709b2b6..5d7d779a5083 100644
--- a/include/drm/drm_device.h
+++ b/include/drm/drm_device.h
@@ -8,6 +8,7 @@
 
 #include <drm/drm_hashtab.h>
 #include <drm/drm_mode_config.h>
+#include <drm/drm_cgroup.h>
 
 struct drm_driver;
 struct drm_minor;
@@ -304,6 +305,12 @@ struct drm_device {
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
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 24f8d054c570..c8a37a08d98d 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -660,6 +660,15 @@ struct drm_driver {
 			    struct drm_device *dev,
 			    uint32_t handle);
 
+	/**
+	 * @drmcg_custom_init
+	 *
+	 * Optional callback used to initialize drm cgroup per device properties
+	 * such as resource limit defaults.
+	 */
+	void (*drmcg_custom_init)(struct drm_device *dev,
+			struct drmcg_props *props);
+
 	/**
 	 * @gem_vm_ops: Driver private ops for this object
 	 */
diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
index 971166f9dd78..4ecd44f2ac27 100644
--- a/include/linux/cgroup_drm.h
+++ b/include/linux/cgroup_drm.h
@@ -6,13 +6,26 @@
 
 #ifdef CONFIG_CGROUP_DRM
 
+#include <linux/mutex.h>
 #include <linux/cgroup.h>
+#include <drm/drm_file.h>
+
+/* limit defined per the way drm_minor_alloc operates */
+#define MAX_DRM_DEV (64 * DRM_MINOR_RENDER)
+
+/**
+ * Per DRM cgroup, per device resources (such as statistics and limits)
+ */
+struct drmcg_device_resource {
+	/* for per device stats */
+};
 
 /**
  * The DRM cgroup controller data structure.
  */
 struct drmcg {
 	struct cgroup_subsys_state	css;
+	struct drmcg_device_resource	*dev_resources[MAX_DRM_DEV];
 };
 
 /**
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
index e97861b3cb30..135fdcdc4b51 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -1,28 +1,103 @@
 // SPDX-License-Identifier: MIT
 // Copyright 2019 Advanced Micro Devices, Inc.
+#include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/cgroup.h>
+#include <linux/fs.h>
+#include <linux/seq_file.h>
+#include <linux/mutex.h>
 #include <linux/cgroup_drm.h>
+#include <linux/kernel.h>
+#include <drm/drm_file.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_device.h>
+#include <drm/drm_cgroup.h>
+
+/* global mutex for drmcg across all devices */
+static DEFINE_MUTEX(drmcg_mutex);
 
 static struct drmcg *root_drmcg __read_mostly;
 
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
+	mutex_lock(&dev->drmcg_mutex);
+	drmcg->dev_resources[minor] = ddr;
+
+	/* set defaults here */
+
+	mutex_unlock(&dev->drmcg_mutex);
+	return 0;
+}
+
+static int init_drmcg_fn(int id, void *ptr, void *data)
+{
+	struct drm_minor *minor = ptr;
+	struct drmcg *drmcg = data;
+
+	if (minor->type != DRM_MINOR_PRIMARY)
+		return 0;
+
+	return init_drmcg_single(drmcg, minor->dev);
+}
+
+static inline int init_drmcg(struct drmcg *drmcg, struct drm_device *dev)
+{
+	if (dev != NULL)
+		return init_drmcg_single(drmcg, dev);
+
+	return drm_minor_for_each(&init_drmcg_fn, drmcg);
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
 
+	rc = init_drmcg(drmcg, NULL);
+	if (rc) {
+		drmcg_css_free(&drmcg->css);
+		return ERR_PTR(rc);
+	}
+
 	if (!parent)
 		root_drmcg = drmcg;
 
@@ -40,3 +115,51 @@ struct cgroup_subsys drm_cgrp_subsys = {
 	.legacy_cftypes	= files,
 	.dfl_cftypes	= files,
 };
+
+static inline void drmcg_update_cg_tree(struct drm_device *dev)
+{
+	/* init cgroups created before registration (i.e. root cgroup) */
+	if (root_drmcg != NULL) {
+		struct cgroup_subsys_state *pos;
+		struct drmcg *child;
+
+		rcu_read_lock();
+		css_for_each_descendant_pre(pos, &root_drmcg->css) {
+			child = css_to_drmcg(pos);
+			init_drmcg(child, dev);
+		}
+		rcu_read_unlock();
+	}
+}
+
+/**
+ * drmcg_device_update - update DRM cgroups defaults
+ * @dev: the target DRM device
+ *
+ * If @dev has a drmcg_custom_init for the DRM cgroup controller, it will be called
+ * to set device specific defaults and set the initial values for all existing
+ * cgroups created prior to @dev become available.
+ */
+void drmcg_device_update(struct drm_device *dev)
+{
+	if (dev->driver->drmcg_custom_init)
+	{
+		dev->driver->drmcg_custom_init(dev, &dev->drmcg_props);
+
+		drmcg_update_cg_tree(dev);
+	}
+}
+EXPORT_SYMBOL(drmcg_device_update);
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
+	drmcg_update_cg_tree(dev);
+}
+EXPORT_SYMBOL(drmcg_device_early_init);
-- 
2.22.0


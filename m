Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C44F193FF
	for <lists+cgroups@lfdr.de>; Thu,  9 May 2019 23:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfEIVEv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 May 2019 17:04:51 -0400
Received: from mail-eopbgr810083.outbound.protection.outlook.com ([40.107.81.83]:27156
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727088AbfEIVEu (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 9 May 2019 17:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQLJJ8Yh38Q57nt87ttc/UN4TMRcEVVhzIf4fqMum0I=;
 b=HP7Cc6OIKyuVxgHGDZp6Jj4eWORS/dMXpecLkpRWjUBrAIva+/w7why5AJkg36/opzT5OCyMZNwd50sn6Usu/IoZGNupl3BjtFrdKzD2RSxwU1bNoYggPc2WZQdEOOlGPZoorEOsEGcVews9a855OSMelUHwiabDVko519oT2/A=
Received: from MWHPR12CA0032.namprd12.prod.outlook.com (2603:10b6:301:2::18)
 by BN7PR12MB2658.namprd12.prod.outlook.com (2603:10b6:408:29::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1856.12; Thu, 9 May
 2019 21:04:46 +0000
Received: from CO1NAM03FT005.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::205) by MWHPR12CA0032.outlook.office365.com
 (2603:10b6:301:2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1878.21 via Frontend
 Transport; Thu, 9 May 2019 21:04:46 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV02.amd.com (165.204.84.17) by
 CO1NAM03FT005.mail.protection.outlook.com (10.152.80.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1856.11 via Frontend Transport; Thu, 9 May 2019 21:04:46 +0000
Received: from kho-5039A.amd.com (10.180.168.240) by SATLEXCHOV02.amd.com
 (10.181.40.72) with Microsoft SMTP Server id 14.3.389.1; Thu, 9 May 2019
 16:04:43 -0500
From:   Kenny Ho <Kenny.Ho@amd.com>
To:     <y2kenny@gmail.com>, <Kenny.Ho@amd.com>, <cgroups@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <tj@kernel.org>, <sunnanyong@huawei.com>,
        <alexander.deucher@amd.com>, <brian.welty@intel.com>
Subject: [RFC PATCH v2 2/5] cgroup: Add mechanism to register DRM devices
Date:   Thu, 9 May 2019 17:04:07 -0400
Message-ID: <20190509210410.5471-3-Kenny.Ho@amd.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509210410.5471-1-Kenny.Ho@amd.com>
References: <20181120185814.13362-1-Kenny.Ho@amd.com>
 <20190509210410.5471-1-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(39860400002)(346002)(2980300002)(428003)(199004)(189003)(72206003)(47776003)(305945005)(48376002)(50466002)(478600001)(5660300002)(11346002)(316002)(70586007)(70206006)(50226002)(51416003)(7696005)(76176011)(2870700001)(110136005)(2906002)(53936002)(6666004)(356004)(1076003)(14444005)(446003)(36756003)(186003)(77096007)(476003)(2616005)(2201001)(336012)(426003)(86362001)(53416004)(486006)(8936002)(81166006)(81156014)(8676002)(126002)(26005)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2658;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31415bab-964f-444d-e0da-08d6d4c1f766
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328);SRVR:BN7PR12MB2658;
X-MS-TrafficTypeDiagnostic: BN7PR12MB2658:
X-Microsoft-Antispam-PRVS: <BN7PR12MB26588BC89ECAD8FF7929722083330@BN7PR12MB2658.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-Forefront-PRVS: 003245E729
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: g2PtkT3bEYSwvzNjkNT2oNOitOeg67m36U7LBlLd3Oo0Uv5gmzv+L47TWBVCe+4n77/YYQ/BzdVW4fgcidp+WglDlv8d7mQ3QXNi6rmMlLvKUTDp6Cht5+TDpCSKMMI6iW3VIYDLITGC8/N0GPEvrbfuBj1q9aeIKSCeYvpQBbS5YlYXEphbLzsaWc91yPibNoPaEtXvCHKYtmFSdb9gU2shBgSGZY6Cb9rxmbLuAvdzOAznaU+nbBSK/2XGvOpwtwKYfKLdSVNr4pfswQxh8P8XzKZLgfplacHLqobmg96K38EUmY/eEOkEODDpVXJDYKY29/6vWpoBeLJedDhQthmQcHE6UUAkTZFVLVhVt+c4pL34AuxMBWH2hU2zOYJrUqhv3dDVkTLEoK7jYomM/NUbXLpfDFgHHmsxpOgMWCU=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2019 21:04:46.0952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31415bab-964f-444d-e0da-08d6d4c1f766
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2658
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Change-Id: I908ee6975ea0585e4c30eafde4599f87094d8c65
Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>
---
 include/drm/drm_cgroup.h   |  24 ++++++++
 include/linux/cgroup_drm.h |  10 ++++
 kernel/cgroup/drm.c        | 118 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 151 insertions(+), 1 deletion(-)
 create mode 100644 include/drm/drm_cgroup.h

diff --git a/include/drm/drm_cgroup.h b/include/drm/drm_cgroup.h
new file mode 100644
index 000000000000..ddb9eab64360
--- /dev/null
+++ b/include/drm/drm_cgroup.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: MIT
+ * Copyright 2019 Advanced Micro Devices, Inc.
+ */
+#ifndef __DRM_CGROUP_H__
+#define __DRM_CGROUP_H__
+
+#ifdef CONFIG_CGROUP_DRM
+
+int drmcgrp_register_device(struct drm_device *device);
+
+int drmcgrp_unregister_device(struct drm_device *device);
+
+#else
+static inline int drmcgrp_register_device(struct drm_device *device)
+{
+	return 0;
+}
+
+static inline int drmcgrp_unregister_device(struct drm_device *device)
+{
+	return 0;
+}
+#endif /* CONFIG_CGROUP_DRM */
+#endif /* __DRM_CGROUP_H__ */
diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
index 121001be1230..d7ccf434ca6b 100644
--- a/include/linux/cgroup_drm.h
+++ b/include/linux/cgroup_drm.h
@@ -6,10 +6,20 @@
 
 #ifdef CONFIG_CGROUP_DRM
 
+#include <linux/mutex.h>
 #include <linux/cgroup.h>
+#include <drm/drm_file.h>
+
+/* limit defined per the way drm_minor_alloc operates */
+#define MAX_DRM_DEV (64 * DRM_MINOR_RENDER)
+
+struct drmcgrp_device_resource {
+	/* for per device stats */
+};
 
 struct drmcgrp {
 	struct cgroup_subsys_state	css;
+	struct drmcgrp_device_resource	*dev_resources[MAX_DRM_DEV];
 };
 
 static inline struct drmcgrp *css_drmcgrp(struct cgroup_subsys_state *css)
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
index 620c887d6d24..f9ef4bf042d8 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -1,16 +1,79 @@
 // SPDX-License-Identifier: MIT
 // Copyright 2019 Advanced Micro Devices, Inc.
+#include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/cgroup.h>
+#include <linux/fs.h>
+#include <linux/seq_file.h>
+#include <linux/mutex.h>
 #include <linux/cgroup_drm.h>
+#include <drm/drm_device.h>
+#include <drm/drm_cgroup.h>
+
+static DEFINE_MUTEX(drmcgrp_mutex);
+
+struct drmcgrp_device {
+	struct drm_device	*dev;
+	struct mutex		mutex;
+};
+
+/* indexed by drm_minor for access speed */
+static struct drmcgrp_device	*known_drmcgrp_devs[MAX_DRM_DEV];
+
+static int max_minor;
+
 
 static struct drmcgrp *root_drmcgrp __read_mostly;
 
 static void drmcgrp_css_free(struct cgroup_subsys_state *css)
 {
 	struct drmcgrp *drmcgrp = css_drmcgrp(css);
+	int i;
+
+	for (i = 0; i <= max_minor; i++) {
+		if (drmcgrp->dev_resources[i] != NULL)
+			kfree(drmcgrp->dev_resources[i]);
+	}
+
+	kfree(drmcgrp);
+}
+
+static inline int init_drmcgrp_single(struct drmcgrp *drmcgrp, int i)
+{
+	struct drmcgrp_device_resource *ddr = drmcgrp->dev_resources[i];
+
+	if (ddr == NULL) {
+		ddr = kzalloc(sizeof(struct drmcgrp_device_resource),
+			GFP_KERNEL);
+
+		if (!ddr)
+			return -ENOMEM;
+
+		drmcgrp->dev_resources[i] = ddr;
+	}
+
+	/* set defaults here */
+
+	return 0;
+}
+
+static inline int init_drmcgrp(struct drmcgrp *drmcgrp, struct drm_device *dev)
+{
+	int rc = 0;
+	int i;
+
+	if (dev != NULL) {
+		rc = init_drmcgrp_single(drmcgrp, dev->primary->index);
+		return rc;
+	}
+
+	for (i = 0; i <= max_minor; i++) {
+		rc = init_drmcgrp_single(drmcgrp, i);
+		if (rc)
+			return rc;
+	}
 
-	kfree(css_drmcgrp(css));
+	return 0;
 }
 
 static struct cgroup_subsys_state *
@@ -18,11 +81,18 @@ drmcgrp_css_alloc(struct cgroup_subsys_state *parent_css)
 {
 	struct drmcgrp *parent = css_drmcgrp(parent_css);
 	struct drmcgrp *drmcgrp;
+	int rc;
 
 	drmcgrp = kzalloc(sizeof(struct drmcgrp), GFP_KERNEL);
 	if (!drmcgrp)
 		return ERR_PTR(-ENOMEM);
 
+	rc = init_drmcgrp(drmcgrp, NULL);
+	if (rc) {
+		drmcgrp_css_free(&drmcgrp->css);
+		return ERR_PTR(rc);
+	}
+
 	if (!parent)
 		root_drmcgrp = drmcgrp;
 
@@ -40,3 +110,49 @@ struct cgroup_subsys drm_cgrp_subsys = {
 	.legacy_cftypes	= files,
 	.dfl_cftypes	= files,
 };
+
+int drmcgrp_register_device(struct drm_device *dev)
+{
+	struct drmcgrp_device *ddev;
+	struct cgroup_subsys_state *pos;
+	struct drmcgrp *child;
+
+	ddev = kzalloc(sizeof(struct drmcgrp_device), GFP_KERNEL);
+	if (!ddev)
+		return -ENOMEM;
+
+	ddev->dev = dev;
+	mutex_init(&ddev->mutex);
+
+	mutex_lock(&drmcgrp_mutex);
+	known_drmcgrp_devs[dev->primary->index] = ddev;
+	max_minor = max(max_minor, dev->primary->index);
+	mutex_unlock(&drmcgrp_mutex);
+
+	/* init cgroups created before registration (i.e. root cgroup) */
+	if (root_drmcgrp != NULL) {
+		init_drmcgrp(root_drmcgrp, dev);
+
+		rcu_read_lock();
+		css_for_each_child(pos, &root_drmcgrp->css) {
+			child = css_drmcgrp(pos);
+			init_drmcgrp(child, dev);
+		}
+		rcu_read_unlock();
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(drmcgrp_register_device);
+
+int drmcgrp_unregister_device(struct drm_device *dev)
+{
+	mutex_lock(&drmcgrp_mutex);
+
+	kfree(known_drmcgrp_devs[dev->primary->index]);
+	known_drmcgrp_devs[dev->primary->index] = NULL;
+
+	mutex_unlock(&drmcgrp_mutex);
+	return 0;
+}
+EXPORT_SYMBOL(drmcgrp_unregister_device);
-- 
2.21.0


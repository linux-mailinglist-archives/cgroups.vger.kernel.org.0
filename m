Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACD156D28
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2019 17:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfFZPFe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jun 2019 11:05:34 -0400
Received: from mail-eopbgr820075.outbound.protection.outlook.com ([40.107.82.75]:60164
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727516AbfFZPFe (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 26 Jun 2019 11:05:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=HUXXqqu0kxTvH5uUzySLJGGpSb1mELi57Xgi7WiJlicZ+4hQqPGI7hwCfGS8eq1vajFkO2HjOn7l/k+Opfpb7Odkow+JFCLC8+rDGKP+R0VB03piR0Su30ZJ5M/4EZuV2drxW3g/Q8225FVuqnjRWXl0nf4Gh0uyoXiDn4J2nYE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SU1hgST+JyNKTp1qUXKZfbLnqt+3iOdlQlRhiWUMa8A=;
 b=kk6EhZ36rYx/uhElp1NqMo6WjTbZG3RLt9WEHXwXtgMOn8UUX2JxuqGm83MRhLdEDUqG36/usn7vezXS24Ac57iSb6zJtd9Enw+Gf1qTRe2g7hnQYMAJjc/ht2YfeDMtDi/ysnTCjMQXtUhQaEhIpEhdIMOJ2ia6/qw3/0B43b4=
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=amd.com;dmarc=permerror action=none
 header.from=amd.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SU1hgST+JyNKTp1qUXKZfbLnqt+3iOdlQlRhiWUMa8A=;
 b=PC9IPDIPiGWL4fv2rTuWQhtkyOuc6u/SbEi/trh6n9Ty3Cv0m4xTboC81oNrr8t7PBOOpjEgO5pXgF/72m53o/qYxRTn6OMEtS/8niSZ36PBJ8wQVOQHosskEaB3wmgIBBETRWJxwdRFtmf4eZEQM8n7eOyomQQhqaHmUGyHvOI=
Received: from MWHPR12CA0065.namprd12.prod.outlook.com (2603:10b6:300:103::27)
 by CY4PR1201MB0022.namprd12.prod.outlook.com (2603:10b6:910:1e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16; Wed, 26 Jun
 2019 15:05:31 +0000
Received: from DM3NAM03FT041.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::207) by MWHPR12CA0065.outlook.office365.com
 (2603:10b6:300:103::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2008.16 via Frontend
 Transport; Wed, 26 Jun 2019 15:05:31 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV02.amd.com (165.204.84.17) by
 DM3NAM03FT041.mail.protection.outlook.com (10.152.83.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2032.15 via Frontend Transport; Wed, 26 Jun 2019 15:05:30 +0000
Received: from kho-5039A.amd.com (10.180.168.240) by SATLEXCHOV02.amd.com
 (10.181.40.72) with Microsoft SMTP Server id 14.3.389.1; Wed, 26 Jun 2019
 10:05:27 -0500
From:   Kenny Ho <Kenny.Ho@amd.com>
To:     <y2kenny@gmail.com>, <cgroups@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <tj@kernel.org>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <joseph.greathouse@amd.com>,
        <jsparks@cray.com>, <lkaplan@cray.com>
CC:     Kenny Ho <Kenny.Ho@amd.com>
Subject: [RFC PATCH v3 02/11] cgroup: Add mechanism to register DRM devices
Date:   Wed, 26 Jun 2019 11:05:13 -0400
Message-ID: <20190626150522.11618-3-Kenny.Ho@amd.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626150522.11618-1-Kenny.Ho@amd.com>
References: <20190626150522.11618-1-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(136003)(346002)(2980300002)(428003)(189003)(199004)(2616005)(70206006)(2906002)(476003)(126002)(2870700001)(70586007)(426003)(48376002)(50466002)(81156014)(81166006)(8676002)(5660300002)(186003)(446003)(11346002)(1076003)(8936002)(14444005)(7696005)(53936002)(51416003)(76176011)(36756003)(4326008)(86362001)(336012)(2201001)(316002)(72206003)(77096007)(486006)(68736007)(50226002)(478600001)(110136005)(26005)(6666004)(305945005)(356004)(47776003)(53416004)(921003)(1121003)(83996005)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR1201MB0022;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f08f7153-441d-475c-41ca-08d6fa47bb4a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:CY4PR1201MB0022;
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0022:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB002277E9A7B5902473A76D6183E20@CY4PR1201MB0022.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-Forefront-PRVS: 00808B16F3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: KGbLAE0tBLpuLQNwJ6iLFYVhQh+kYpaRWptQsCzct5wrmi/NGU2OVisfY/8wMqjKB7BYkQruSNVB1F+g5OF288CZSP/hFK5TGrr6fYXH2DNjGe46QtbkM4Xwt866EH+YV6d2vi7T5vt3RMKk8m2WbDufvMJkCKK/VodkKrYrhv34ubQEtWP19A4ksa12B1w2aY6hxXibRdpUfJksT3TJGwHJJdRb5Yq8qy0MV3RGJLi1m1vs/6hUSRBif+3AdYt2m4ydz9Av4zQeWMB2bzG7l3J3vSU8kzjOYjYvNG4/DFYq2/hOEzxC70SIfP0f+U2RtTLIBUzqEkdmo9KUQ2b/efZtXaOJzYYLzGpl4UFswdmYbzf1wrTxp4XEtUfFSkp93S3D1Sf3buaNUpCy2lHYEU/S24QIUBuy/r5N8ZGME4s=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2019 15:05:30.5677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f08f7153-441d-475c-41ca-08d6fa47bb4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0022
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Change-Id: I908ee6975ea0585e4c30eafde4599f87094d8c65
Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>
---
 include/drm/drm_cgroup.h   |  24 ++++++++
 include/linux/cgroup_drm.h |  10 ++++
 kernel/cgroup/drm.c        | 116 +++++++++++++++++++++++++++++++++++++
 3 files changed, 150 insertions(+)
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
index 9928e60037a5..27497f786c93 100644
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
index 66cb1dda023d..7da6e0d93991 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -1,28 +1,99 @@
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
 
 	kfree(drmcgrp);
 }
 
+static inline int init_drmcgrp_single(struct drmcgrp *drmcgrp, int minor)
+{
+	struct drmcgrp_device_resource *ddr = drmcgrp->dev_resources[minor];
+
+	if (ddr == NULL) {
+		ddr = kzalloc(sizeof(struct drmcgrp_device_resource),
+			GFP_KERNEL);
+
+		if (!ddr)
+			return -ENOMEM;
+
+		drmcgrp->dev_resources[minor] = ddr;
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
+
+	return 0;
+}
+
 static struct cgroup_subsys_state *
 drmcgrp_css_alloc(struct cgroup_subsys_state *parent_css)
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
 
@@ -40,3 +111,48 @@ struct cgroup_subsys drm_cgrp_subsys = {
 	.legacy_cftypes	= files,
 	.dfl_cftypes	= files,
 };
+
+int drmcgrp_register_device(struct drm_device *dev)
+{
+	struct drmcgrp_device *ddev;
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
+		struct cgroup_subsys_state *pos;
+		struct drmcgrp *child;
+
+		rcu_read_lock();
+		css_for_each_descendant_pre(pos, &root_drmcgrp->css) {
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


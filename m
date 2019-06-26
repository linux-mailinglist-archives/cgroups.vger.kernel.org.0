Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EECA756D26
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2019 17:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfFZPFd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jun 2019 11:05:33 -0400
Received: from mail-eopbgr750059.outbound.protection.outlook.com ([40.107.75.59]:24449
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727481AbfFZPFd (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 26 Jun 2019 11:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8Vkkh6EI+Jvy+fTB+fueJFxoa5pBliRjRlepUuST+I=;
 b=mKcJYS/q+sq1YxpbmeiFzXFZ/qgWUbH/8UQ6pqPYJrtGqBG8nRqyk5MsQlFr/7OfhxFIyzv498EdF+OlAFn+PYelqyHMv6Rzd2zgL2PInLKFf6LCbU0Ht+ML7y/fMRm5LMCYXBEje6j9pesUN0UsHD0iRsGK+zaHzOUBA9Lv6+s=
Received: from MWHPR12CA0058.namprd12.prod.outlook.com (2603:10b6:300:103::20)
 by CY4PR1201MB0021.namprd12.prod.outlook.com (2603:10b6:910:1a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16; Wed, 26 Jun
 2019 15:05:30 +0000
Received: from DM3NAM03FT041.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::209) by MWHPR12CA0058.outlook.office365.com
 (2603:10b6:300:103::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2008.16 via Frontend
 Transport; Wed, 26 Jun 2019 15:05:30 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV02.amd.com (165.204.84.17) by
 DM3NAM03FT041.mail.protection.outlook.com (10.152.83.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2032.15 via Frontend Transport; Wed, 26 Jun 2019 15:05:29 +0000
Received: from kho-5039A.amd.com (10.180.168.240) by SATLEXCHOV02.amd.com
 (10.181.40.72) with Microsoft SMTP Server id 14.3.389.1; Wed, 26 Jun 2019
 10:05:26 -0500
From:   Kenny Ho <Kenny.Ho@amd.com>
To:     <y2kenny@gmail.com>, <cgroups@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <tj@kernel.org>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <joseph.greathouse@amd.com>,
        <jsparks@cray.com>, <lkaplan@cray.com>
CC:     Kenny Ho <Kenny.Ho@amd.com>
Subject: [RFC PATCH v3 01/11] cgroup: Introduce cgroup for drm subsystem
Date:   Wed, 26 Jun 2019 11:05:12 -0400
Message-ID: <20190626150522.11618-2-Kenny.Ho@amd.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626150522.11618-1-Kenny.Ho@amd.com>
References: <20190626150522.11618-1-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(136003)(2980300002)(428003)(189003)(199004)(2616005)(77096007)(81156014)(26005)(186003)(8936002)(305945005)(2201001)(53936002)(86362001)(8676002)(81166006)(36756003)(2870700001)(50226002)(4326008)(110136005)(47776003)(316002)(5024004)(14444005)(53416004)(356004)(5660300002)(50466002)(6666004)(2906002)(48376002)(1076003)(7696005)(72206003)(426003)(76176011)(11346002)(70586007)(446003)(70206006)(478600001)(476003)(486006)(51416003)(68736007)(126002)(336012)(921003)(1121003)(83996005)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR1201MB0021;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a14e9f9e-d050-4a0d-5060-08d6fa47ba88
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:CY4PR1201MB0021;
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0021:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB00219720F8CD3DAC8950E16583E20@CY4PR1201MB0021.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 00808B16F3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: +Qeg+w7YJ5KoXzLpoJo0Xvde4SYeofwx/Mt3lKrz/vdX4bdCJBULC1/VBCWiKJlb7wyw/MV1r6m5UFm4Bi3wOO2L6ojkjTK6zdGR6vBCdWpA79bcQhjr8NRgBBY3u6qXFPU88meIGv4Xoyzv43wWCuyZCD1Z8AmF0zNdHwS7PWiodNjeOYeTogK0cR4CYzzO9jighKNAP9maKL21AgMGxCMUV6Z1QBgzftvoxZ2yifLnqD7wUoWmhBKLe19sfimsmLmJ+ewmj4zaRPAehRxeRZ/Ud0H+OM9JGK70ZRqCWeodvTWkJT6lQhILKT1rJTEZZImWCul8MWsaJluBDYawSrUUAHgjeEp5KbtvgXGIYLuZuDIB4iqPlFrOkn88lxxReaE6Qu/SPIP6K5bGSUiEmwH1v1LkJeB5wQLuxLXHWH4=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2019 15:05:29.3147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a14e9f9e-d050-4a0d-5060-08d6fa47ba88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0021
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Change-Id: I6830d3990f63f0c13abeba29b1d330cf28882831
Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>
---
 include/linux/cgroup_drm.h    | 76 +++++++++++++++++++++++++++++++++++
 include/linux/cgroup_subsys.h |  4 ++
 init/Kconfig                  |  5 +++
 kernel/cgroup/Makefile        |  1 +
 kernel/cgroup/drm.c           | 42 +++++++++++++++++++
 5 files changed, 128 insertions(+)
 create mode 100644 include/linux/cgroup_drm.h
 create mode 100644 kernel/cgroup/drm.c

diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
new file mode 100644
index 000000000000..9928e60037a5
--- /dev/null
+++ b/include/linux/cgroup_drm.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: MIT
+ * Copyright 2019 Advanced Micro Devices, Inc.
+ */
+#ifndef _CGROUP_DRM_H
+#define _CGROUP_DRM_H
+
+#ifdef CONFIG_CGROUP_DRM
+
+#include <linux/cgroup.h>
+
+struct drmcgrp {
+	struct cgroup_subsys_state	css;
+};
+
+static inline struct drmcgrp *css_drmcgrp(struct cgroup_subsys_state *css)
+{
+	return css ? container_of(css, struct drmcgrp, css) : NULL;
+}
+
+static inline struct drmcgrp *drmcgrp_from(struct task_struct *task)
+{
+	return css_drmcgrp(task_get_css(task, drm_cgrp_id));
+}
+
+static inline struct drmcgrp *get_drmcgrp(struct task_struct *task)
+{
+	struct cgroup_subsys_state *css = task_get_css(task, drm_cgrp_id);
+
+	if (css)
+		css_get(css);
+
+	return css_drmcgrp(css);
+}
+
+static inline void put_drmcgrp(struct drmcgrp *drmcgrp)
+{
+	if (drmcgrp)
+		css_put(&drmcgrp->css);
+}
+
+static inline struct drmcgrp *parent_drmcgrp(struct drmcgrp *cg)
+{
+	return css_drmcgrp(cg->css.parent);
+}
+
+#else /* CONFIG_CGROUP_DRM */
+
+struct drmcgrp {
+};
+
+static inline struct drmcgrp *css_drmcgrp(struct cgroup_subsys_state *css)
+{
+	return NULL;
+}
+
+static inline struct drmcgrp *drmcgrp_from(struct task_struct *task)
+{
+	return NULL;
+}
+
+static inline struct drmcgrp *get_drmcgrp(struct task_struct *task)
+{
+	return NULL;
+}
+
+static inline void put_drmcgrp(struct drmcgrp *drmcgrp)
+{
+}
+
+static inline struct drmcgrp *parent_drmcgrp(struct drmcgrp *cg)
+{
+	return NULL;
+}
+
+#endif	/* CONFIG_CGROUP_DRM */
+#endif	/* _CGROUP_DRM_H */
diff --git a/include/linux/cgroup_subsys.h b/include/linux/cgroup_subsys.h
index acb77dcff3b4..ddedad809e8b 100644
--- a/include/linux/cgroup_subsys.h
+++ b/include/linux/cgroup_subsys.h
@@ -61,6 +61,10 @@ SUBSYS(pids)
 SUBSYS(rdma)
 #endif
 
+#if IS_ENABLED(CONFIG_CGROUP_DRM)
+SUBSYS(drm)
+#endif
+
 /*
  * The following subsystems are not supported on the default hierarchy.
  */
diff --git a/init/Kconfig b/init/Kconfig
index d47cb77a220e..0b0f112eb23b 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -839,6 +839,11 @@ config CGROUP_RDMA
 	  Attaching processes with active RDMA resources to the cgroup
 	  hierarchy is allowed even if can cross the hierarchy's limit.
 
+config CGROUP_DRM
+	bool "DRM controller (EXPERIMENTAL)"
+	help
+	  Provides accounting and enforcement of resources in the DRM subsystem.
+
 config CGROUP_FREEZER
 	bool "Freezer controller"
 	help
diff --git a/kernel/cgroup/Makefile b/kernel/cgroup/Makefile
index bfcdae896122..6af14bd93050 100644
--- a/kernel/cgroup/Makefile
+++ b/kernel/cgroup/Makefile
@@ -4,5 +4,6 @@ obj-y := cgroup.o rstat.o namespace.o cgroup-v1.o
 obj-$(CONFIG_CGROUP_FREEZER) += freezer.o
 obj-$(CONFIG_CGROUP_PIDS) += pids.o
 obj-$(CONFIG_CGROUP_RDMA) += rdma.o
+obj-$(CONFIG_CGROUP_DRM) += drm.o
 obj-$(CONFIG_CPUSETS) += cpuset.o
 obj-$(CONFIG_CGROUP_DEBUG) += debug.o
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
new file mode 100644
index 000000000000..66cb1dda023d
--- /dev/null
+++ b/kernel/cgroup/drm.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: MIT
+// Copyright 2019 Advanced Micro Devices, Inc.
+#include <linux/slab.h>
+#include <linux/cgroup.h>
+#include <linux/cgroup_drm.h>
+
+static struct drmcgrp *root_drmcgrp __read_mostly;
+
+static void drmcgrp_css_free(struct cgroup_subsys_state *css)
+{
+	struct drmcgrp *drmcgrp = css_drmcgrp(css);
+
+	kfree(drmcgrp);
+}
+
+static struct cgroup_subsys_state *
+drmcgrp_css_alloc(struct cgroup_subsys_state *parent_css)
+{
+	struct drmcgrp *parent = css_drmcgrp(parent_css);
+	struct drmcgrp *drmcgrp;
+
+	drmcgrp = kzalloc(sizeof(struct drmcgrp), GFP_KERNEL);
+	if (!drmcgrp)
+		return ERR_PTR(-ENOMEM);
+
+	if (!parent)
+		root_drmcgrp = drmcgrp;
+
+	return &drmcgrp->css;
+}
+
+struct cftype files[] = {
+	{ }	/* terminate */
+};
+
+struct cgroup_subsys drm_cgrp_subsys = {
+	.css_alloc	= drmcgrp_css_alloc,
+	.css_free	= drmcgrp_css_free,
+	.early_init	= false,
+	.legacy_cftypes	= files,
+	.dfl_cftypes	= files,
+};
-- 
2.21.0


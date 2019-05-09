Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D14A193FE
	for <lists+cgroups@lfdr.de>; Thu,  9 May 2019 23:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfEIVEu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 May 2019 17:04:50 -0400
Received: from mail-eopbgr760057.outbound.protection.outlook.com ([40.107.76.57]:15493
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725992AbfEIVEt (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 9 May 2019 17:04:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YOVKDWqtsp3YOBhGBQhAAXk2OeBSRU2dQNs+Dfx/+U=;
 b=tXUFCw7oPwjifIZLe81w7Zc2oACV/bgrI6ivuuvl9Nv61IWawG9tdQmXwk1H8HYE1luoEj8fDQa1BiLUrgk06OPa1gqGuORgmDwh9VeJOptZHFipyafKxZQZom82DJA3WMPqx+uQ77/VQ+vFg1ZxFa6LyXtvyd71kyW28qUbSYw=
Received: from MWHPR12CA0034.namprd12.prod.outlook.com (2603:10b6:301:2::20)
 by DM5PR1201MB0060.namprd12.prod.outlook.com (2603:10b6:4:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1856.15; Thu, 9 May
 2019 21:04:45 +0000
Received: from CO1NAM03FT005.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::201) by MWHPR12CA0034.outlook.office365.com
 (2603:10b6:301:2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1878.21 via Frontend
 Transport; Thu, 9 May 2019 21:04:45 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV02.amd.com (165.204.84.17) by
 CO1NAM03FT005.mail.protection.outlook.com (10.152.80.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1856.11 via Frontend Transport; Thu, 9 May 2019 21:04:44 +0000
Received: from kho-5039A.amd.com (10.180.168.240) by SATLEXCHOV02.amd.com
 (10.181.40.72) with Microsoft SMTP Server id 14.3.389.1; Thu, 9 May 2019
 16:04:42 -0500
From:   Kenny Ho <Kenny.Ho@amd.com>
To:     <y2kenny@gmail.com>, <Kenny.Ho@amd.com>, <cgroups@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <tj@kernel.org>, <sunnanyong@huawei.com>,
        <alexander.deucher@amd.com>, <brian.welty@intel.com>
Subject: [RFC PATCH v2 1/5] cgroup: Introduce cgroup for drm subsystem
Date:   Thu, 9 May 2019 17:04:06 -0400
Message-ID: <20190509210410.5471-2-Kenny.Ho@amd.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509210410.5471-1-Kenny.Ho@amd.com>
References: <20181120185814.13362-1-Kenny.Ho@amd.com>
 <20190509210410.5471-1-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(136003)(39860400002)(2980300002)(428003)(189003)(199004)(478600001)(47776003)(1076003)(72206003)(50226002)(81166006)(81156014)(8676002)(8936002)(6666004)(356004)(14444005)(305945005)(53416004)(5024004)(2616005)(476003)(11346002)(446003)(86362001)(126002)(486006)(426003)(186003)(26005)(77096007)(48376002)(110136005)(50466002)(5660300002)(2201001)(336012)(53936002)(68736007)(7696005)(2870700001)(76176011)(51416003)(2906002)(70586007)(70206006)(316002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR1201MB0060;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 601a1d46-a0f3-4dd8-addd-08d6d4c1f6bd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328);SRVR:DM5PR1201MB0060;
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0060:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB00600348694940E6A69F2BD183330@DM5PR1201MB0060.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 003245E729
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: /g/WIAAD+T/l6ZZpl8UZgSVYU8UKyRJEQ2kup3NZhBuClnD15gSy+XTg/vMLcQH1/9LRwXLVh2rDQ3H6GBCk4vsHZ9FfhGc853lKtJC2V48bNfrsjseWUQY9GrqKj9WZDijgjKLX94s/H5mNu5hlKlK83Eyyq4LZarImXXaPSIiuqX/FOIRq9PAB71egCxsF0aj9zy2v4/dmGOmuwLiuQY5DMiELMpi3UTec3PXspWwrX3GRyZwAxss+mDboeUdxDkYx04HbNKf7ecWRGnF5xoIRrsr60MqBMCuLTsIDiOaHgQgBRTLuC4WZqTJPHWg1nTsUww7Sys0CMchhs+IfX8OhqKNNq3NT8rLQ7+BWQ+vPcXRstOZvgAcJJ9m0qvK/6oE+D6EUlzG4YSpkHbh40jRejMEOiVqtiaPwRlOWgo0=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2019 21:04:44.9608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 601a1d46-a0f3-4dd8-addd-08d6d4c1f6bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0060
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Change-Id: I6830d3990f63f0c13abeba29b1d330cf28882831
Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>
---
 include/linux/cgroup_drm.h    | 32 ++++++++++++++++++++++++++
 include/linux/cgroup_subsys.h |  4 ++++
 init/Kconfig                  |  5 +++++
 kernel/cgroup/Makefile        |  1 +
 kernel/cgroup/drm.c           | 42 +++++++++++++++++++++++++++++++++++
 5 files changed, 84 insertions(+)
 create mode 100644 include/linux/cgroup_drm.h
 create mode 100644 kernel/cgroup/drm.c

diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
new file mode 100644
index 000000000000..121001be1230
--- /dev/null
+++ b/include/linux/cgroup_drm.h
@@ -0,0 +1,32 @@
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
+static inline struct drmcgrp *get_drmcgrp(struct task_struct *task)
+{
+	return css_drmcgrp(task_get_css(task, drm_cgrp_id));
+}
+
+
+static inline struct drmcgrp *parent_drmcgrp(struct drmcgrp *cg)
+{
+	return css_drmcgrp(cg->css.parent);
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
index 000000000000..620c887d6d24
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
+	kfree(css_drmcgrp(css));
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


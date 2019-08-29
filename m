Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAE33A1158
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2019 08:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfH2GFt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Aug 2019 02:05:49 -0400
Received: from mail-eopbgr790085.outbound.protection.outlook.com ([40.107.79.85]:60313
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726069AbfH2GFs (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 29 Aug 2019 02:05:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOOnm65+8DVPzLNgLBopgvAcbKfSblTKWX3+6e8qFKcVEa3Qjdw+yJaFvjPcNApWuWvKahl6l89xJv3Wu3Ipu6R3WH8q4VJRe7asX0GUw6/E4K38kCKIOuPMF9FODPqHj3UR3V2WGQ5A4nK7U8pB2jDBvE58tnsZJ4/tnGYPTQKXvjju2DHQQSdxVMPVX5m4k8GRVicfPj69WipF/56LDZzemx5yTRyVUyPq2YuwLofFW/DkXHQiqcI4INLBsRqDmWL4/l7IUCtYZEGXjk9ATq0jul6/I7ZP/hHVWCh/6NBe9qB+eH3+9+32wyrpz7vztGky9cJtUq4i6ILqmGMS6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6EPMox26fU5F2yp9AcfPra6fm+DXi302zWJUO9/tUM=;
 b=Y4/QAdTMqcZcaWOG8AxWXLRLc1qJnPhIkHlI/ycqtJrVY0BdfLZtqbejheSms6oXfqpdCB+BYabRqWsP6m/zoPxB7PJIcZS2meDEpvm0yQ5u9rABzMgiLfRZK+iHAzQcWCZy0EtXwW5a+9KsVkr9sos1EnAREpLGh7+49/IQiiBt5nSPpOpp068mLpLBz+/xlZl2Ba7l7VLGG0e3fCekrQ5NwSTaFvLbmKQfpvpXhtPT58YS3ie+byyinkOwzn2eCsHbtZzMPQvW1pxMW6kiwdmEkNsY2J8LmTO0XBkVlCvwEwJ956KcHUoANgMFntKb6FoCACX8hpYet0f0ONu2IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=cray.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6EPMox26fU5F2yp9AcfPra6fm+DXi302zWJUO9/tUM=;
 b=DIgzN0K2bhawl7vChxfradlfciqZ6J/8jD8900FSQAicN0F0nOZY3Coo5B6M+iHKZf4O9jjb1nQipqvK56BJwaM/wWGBDL9b+bzgnrNTG2unukKc9rCbpvsXr7incVH+ZeEutYfiPdKh/NcTO/wIX7AjQnhbA/ey31ABYtfk1UM=
Received: from CH2PR12CA0005.namprd12.prod.outlook.com (2603:10b6:610:57::15)
 by BN6PR12MB1267.namprd12.prod.outlook.com (2603:10b6:404:17::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.20; Thu, 29 Aug
 2019 06:05:44 +0000
Received: from CO1NAM03FT045.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::200) by CH2PR12CA0005.outlook.office365.com
 (2603:10b6:610:57::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.18 via Frontend
 Transport; Thu, 29 Aug 2019 06:05:44 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; cray.com; dkim=none (message not signed)
 header.d=none;cray.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 CO1NAM03FT045.mail.protection.outlook.com (10.152.81.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2220.16 via Frontend Transport; Thu, 29 Aug 2019 06:05:44 +0000
Received: from kho-5039A.amd.com (10.180.168.240) by SATLEXCHOV01.amd.com
 (10.181.40.71) with Microsoft SMTP Server id 14.3.389.1; Thu, 29 Aug 2019
 01:05:42 -0500
From:   Kenny Ho <Kenny.Ho@amd.com>
To:     <y2kenny@gmail.com>, <cgroups@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <tj@kernel.org>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <felix.kuehling@amd.com>,
        <joseph.greathouse@amd.com>, <jsparks@cray.com>,
        <lkaplan@cray.com>, <daniel@ffwll.ch>
CC:     Kenny Ho <Kenny.Ho@amd.com>
Subject: [PATCH RFC v4 02/16] cgroup: Introduce cgroup for drm subsystem
Date:   Thu, 29 Aug 2019 02:05:19 -0400
Message-ID: <20190829060533.32315-3-Kenny.Ho@amd.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829060533.32315-1-Kenny.Ho@amd.com>
References: <20190829060533.32315-1-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(346002)(136003)(396003)(2980300002)(428003)(199004)(189003)(5660300002)(86362001)(47776003)(6666004)(356004)(1076003)(478600001)(2201001)(2870700001)(2906002)(316002)(70206006)(70586007)(50466002)(110136005)(48376002)(53416004)(426003)(36756003)(4326008)(305945005)(53936002)(8936002)(8676002)(81156014)(186003)(51416003)(2616005)(11346002)(446003)(476003)(76176011)(5024004)(14444005)(7696005)(126002)(486006)(81166006)(50226002)(336012)(26005)(921003)(1121003)(2101003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1267;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: caf341a5-4743-4ef4-28f8-08d72c46edc3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328);SRVR:BN6PR12MB1267;
X-MS-TrafficTypeDiagnostic: BN6PR12MB1267:
X-Microsoft-Antispam-PRVS: <BN6PR12MB12672D332DBBA12243361DBC83A20@BN6PR12MB1267.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0144B30E41
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Is/OMQpFy8pXu8KcjTArZldv4Mepd09Di21K+1ZZUrYFaLZsNuhyelAmGqu2ykIjMd1C69MRUZEdDGdwzBy4M5LCkRZBVcByyzHTHc4erqEhhDplPuPRHHpuZu0zLbhsacZdAmK72BECH10jMuVcXqvr61dmYuTkVMCRPBp39mtel+FFs2y8PQGMnBtZWKDPrwxYx6X7XXQPwdIk+E8A5yBCMiEVJ5HFVzfVGoz3/+Bx+a6ZIltSmZdp2Ino2SoBoTSQd7hIEnIfI4NEfuqWYrk2KEb7J6j5AdTd/37rRUePlxRSubCR/Guk9oRRwvCf22yAP6lUs9LMskDCAqOfc17QVfxmCyowP7cprFguhYtboCQoSewjRLTczGrZYKzctrJrbuAnIvl4q+a1A0J5OQgfMeMV//7ua9hsVtxlprg=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2019 06:05:44.1292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caf341a5-4743-4ef4-28f8-08d72c46edc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1267
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

With the increased importance of machine learning, data science and
other cloud-based applications, GPUs are already in production use in
data centers today.  Existing GPU resource management is very coarse
grain, however, as sysadmins are only able to distribute workload on a
per-GPU basis.  An alternative is to use GPU virtualization (with or
without SRIOV) but it generally acts on the entire GPU instead of the
specific resources in a GPU.  With a drm cgroup controller, we can
enable alternate, fine-grain, sub-GPU resource management (in addition
to what may be available via GPU virtualization.)

Change-Id: I6830d3990f63f0c13abeba29b1d330cf28882831
Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 18 ++++-
 Documentation/cgroup-v1/drm.rst         |  1 +
 include/linux/cgroup_drm.h              | 92 +++++++++++++++++++++++++
 include/linux/cgroup_subsys.h           |  4 ++
 init/Kconfig                            |  5 ++
 kernel/cgroup/Makefile                  |  1 +
 kernel/cgroup/drm.c                     | 42 +++++++++++
 7 files changed, 161 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/cgroup-v1/drm.rst
 create mode 100644 include/linux/cgroup_drm.h
 create mode 100644 kernel/cgroup/drm.c

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 88e746074252..2936423a3fd5 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -61,8 +61,10 @@ v1 is available under Documentation/cgroup-v1/.
      5-6. Device
      5-7. RDMA
        5-7-1. RDMA Interface Files
-     5-8. Misc
-       5-8-1. perf_event
+     5-8. DRM
+       5-8-1. DRM Interface Files
+     5-9. Misc
+       5-9-1. perf_event
      5-N. Non-normative information
        5-N-1. CPU controller root cgroup process behaviour
        5-N-2. IO controller root cgroup process behaviour
@@ -1889,6 +1891,18 @@ RDMA Interface Files
 	  ocrdma1 hca_handle=1 hca_object=23
 
 
+DRM
+---
+
+The "drm" controller regulates the distribution and accounting of
+of DRM (Direct Rendering Manager) and GPU-related resources.
+
+DRM Interface Files
+~~~~~~~~~~~~~~~~~~~~
+
+TODO
+
+
 Misc
 ----
 
diff --git a/Documentation/cgroup-v1/drm.rst b/Documentation/cgroup-v1/drm.rst
new file mode 100644
index 000000000000..5f5658e1f5ed
--- /dev/null
+++ b/Documentation/cgroup-v1/drm.rst
@@ -0,0 +1 @@
+Please see ../cgroup-v2.rst for details
diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
new file mode 100644
index 000000000000..971166f9dd78
--- /dev/null
+++ b/include/linux/cgroup_drm.h
@@ -0,0 +1,92 @@
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
+/**
+ * The DRM cgroup controller data structure.
+ */
+struct drmcg {
+	struct cgroup_subsys_state	css;
+};
+
+/**
+ * css_to_drmcg - get the corresponding drmcg ref from a cgroup_subsys_state
+ * @css: the target cgroup_subsys_state
+ *
+ * Return: DRM cgroup that contains the @css
+ */
+static inline struct drmcg *css_to_drmcg(struct cgroup_subsys_state *css)
+{
+	return css ? container_of(css, struct drmcg, css) : NULL;
+}
+
+/**
+ * drmcg_get - get the drmcg reference that a task belongs to
+ * @task: the target task
+ *
+ * This increase the reference count of the css that the @task belongs to
+ *
+ * Return: reference to the DRM cgroup the task belongs to
+ */
+static inline struct drmcg *drmcg_get(struct task_struct *task)
+{
+	return css_to_drmcg(task_get_css(task, drm_cgrp_id));
+}
+
+/**
+ * drmcg_put - put a drmcg reference
+ * @drmcg: the target drmcg
+ *
+ * Put a reference obtained via drmcg_get
+ */
+static inline void drmcg_put(struct drmcg *drmcg)
+{
+	if (drmcg)
+		css_put(&drmcg->css);
+}
+
+/**
+ * drmcg_parent - find the parent of a drm cgroup
+ * @cg: the target drmcg
+ *
+ * This does not increase the reference count of the parent cgroup
+ *
+ * Return: parent DRM cgroup of @cg
+ */
+static inline struct drmcg *drmcg_parent(struct drmcg *cg)
+{
+	return css_to_drmcg(cg->css.parent);
+}
+
+#else /* CONFIG_CGROUP_DRM */
+
+struct drmcg {
+};
+
+static inline struct drmcg *css_to_drmcg(struct cgroup_subsys_state *css)
+{
+	return NULL;
+}
+
+static inline struct drmcg *drmcg_get(struct task_struct *task)
+{
+	return NULL;
+}
+
+static inline void drmcg_put(struct drmcg *drmcg)
+{
+}
+
+static inline struct drmcg *drmcg_parent(struct drmcg *cg)
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
index 8b9ffe236e4f..01d3453f6e04 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -876,6 +876,11 @@ config CGROUP_RDMA
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
index 5d7a76bfbbb7..31f186f58121 100644
--- a/kernel/cgroup/Makefile
+++ b/kernel/cgroup/Makefile
@@ -4,5 +4,6 @@ obj-y := cgroup.o rstat.o namespace.o cgroup-v1.o freezer.o
 obj-$(CONFIG_CGROUP_FREEZER) += legacy_freezer.o
 obj-$(CONFIG_CGROUP_PIDS) += pids.o
 obj-$(CONFIG_CGROUP_RDMA) += rdma.o
+obj-$(CONFIG_CGROUP_DRM) += drm.o
 obj-$(CONFIG_CPUSETS) += cpuset.o
 obj-$(CONFIG_CGROUP_DEBUG) += debug.o
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
new file mode 100644
index 000000000000..e97861b3cb30
--- /dev/null
+++ b/kernel/cgroup/drm.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: MIT
+// Copyright 2019 Advanced Micro Devices, Inc.
+#include <linux/slab.h>
+#include <linux/cgroup.h>
+#include <linux/cgroup_drm.h>
+
+static struct drmcg *root_drmcg __read_mostly;
+
+static void drmcg_css_free(struct cgroup_subsys_state *css)
+{
+	struct drmcg *drmcg = css_to_drmcg(css);
+
+	kfree(drmcg);
+}
+
+static struct cgroup_subsys_state *
+drmcg_css_alloc(struct cgroup_subsys_state *parent_css)
+{
+	struct drmcg *parent = css_to_drmcg(parent_css);
+	struct drmcg *drmcg;
+
+	drmcg = kzalloc(sizeof(struct drmcg), GFP_KERNEL);
+	if (!drmcg)
+		return ERR_PTR(-ENOMEM);
+
+	if (!parent)
+		root_drmcg = drmcg;
+
+	return &drmcg->css;
+}
+
+struct cftype files[] = {
+	{ }	/* terminate */
+};
+
+struct cgroup_subsys drm_cgrp_subsys = {
+	.css_alloc	= drmcg_css_alloc,
+	.css_free	= drmcg_css_free,
+	.early_init	= false,
+	.legacy_cftypes	= files,
+	.dfl_cftypes	= files,
+};
-- 
2.22.0


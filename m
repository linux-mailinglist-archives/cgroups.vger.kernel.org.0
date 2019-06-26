Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9F356D2E
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2019 17:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfFZPFj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jun 2019 11:05:39 -0400
Received: from mail-eopbgr780089.outbound.protection.outlook.com ([40.107.78.89]:52992
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727481AbfFZPFj (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 26 Jun 2019 11:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGJmMWvDHBXJZc2j0yJEgM7sgSWqL2bpZcdMgnZsWmA=;
 b=jdSrJKl00lATT1IA7nk4YbLG/2IANEzC52vgh+ByZJY3NKnmFUte2RLua/SduKII5Nden/zAWSTyPIjyV5cmGgp9oaOk13Tj6fdXwRw8FCSdU81Wa8F7ONsDhIIeHvJNTzvWOp0LRZLPjXoCeFKprp9oFL1/LNnI+O91B9f5qqE=
Received: from MWHPR12CA0055.namprd12.prod.outlook.com (2603:10b6:300:103::17)
 by MWHPR12MB1711.namprd12.prod.outlook.com (2603:10b6:300:10a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.13; Wed, 26 Jun
 2019 15:05:34 +0000
Received: from DM3NAM03FT041.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::203) by MWHPR12CA0055.outlook.office365.com
 (2603:10b6:300:103::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2008.16 via Frontend
 Transport; Wed, 26 Jun 2019 15:05:34 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV02.amd.com (165.204.84.17) by
 DM3NAM03FT041.mail.protection.outlook.com (10.152.83.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2032.15 via Frontend Transport; Wed, 26 Jun 2019 15:05:33 +0000
Received: from kho-5039A.amd.com (10.180.168.240) by SATLEXCHOV02.amd.com
 (10.181.40.72) with Microsoft SMTP Server id 14.3.389.1; Wed, 26 Jun 2019
 10:05:29 -0500
From:   Kenny Ho <Kenny.Ho@amd.com>
To:     <y2kenny@gmail.com>, <cgroups@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <tj@kernel.org>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <joseph.greathouse@amd.com>,
        <jsparks@cray.com>, <lkaplan@cray.com>
CC:     Kenny Ho <Kenny.Ho@amd.com>
Subject: [RFC PATCH v3 04/11] drm, cgroup: Add total GEM buffer allocation limit
Date:   Wed, 26 Jun 2019 11:05:15 -0400
Message-ID: <20190626150522.11618-5-Kenny.Ho@amd.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626150522.11618-1-Kenny.Ho@amd.com>
References: <20190626150522.11618-1-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(396003)(346002)(2980300002)(428003)(199004)(189003)(53936002)(336012)(50226002)(126002)(476003)(2616005)(70586007)(86362001)(426003)(486006)(2201001)(70206006)(47776003)(446003)(11346002)(81156014)(8676002)(8936002)(81166006)(478600001)(36756003)(305945005)(1076003)(68736007)(4326008)(53416004)(72206003)(186003)(77096007)(2906002)(110136005)(50466002)(26005)(48376002)(316002)(6666004)(356004)(76176011)(30864003)(5660300002)(2870700001)(7696005)(51416003)(14444005)(921003)(2101003)(1121003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1711;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3c0d4b3-0a47-44b6-74a8-08d6fa47bcff
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:MWHPR12MB1711;
X-MS-TrafficTypeDiagnostic: MWHPR12MB1711:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1711471DEF3B3D55919CB0B183E20@MWHPR12MB1711.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:792;
X-Forefront-PRVS: 00808B16F3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: n9VJU1Jp72gK+6Gu/nmG4RhU2jk8ilFigdmvrl9z6cU6ykc3J8VlhJEsgTdcWMo7nhCuVwtlwFGoN4WCL6tNijRW1yzlZU5eR7XMzKt2v7TwlXewm+iRHl2byYzF1WXfq0uiZxhSn4t4wDzHGOF6HANeekmfawhEjg+STNPSQfIaZGtgeJ0FnFJpca0xmSmlpy05gh4OZgzIgH3K21uHKUX5C/aN+wOCo5dRWq1+3Cbwo7KM1uXuiZAJa5mqN3ZgtQSlcOtaU1jJXIdadzR+T04oGcAYU0hTronboL9v3sihWCUTo04PQ7C4K9wCqwJh2APbBfRNBUP8ay82x/tGg4rrBrMD40z4MHA1wUxXdkDTW9rPGjNIfUwbR4IYgUVMNs3xGFzBDW63qo0fhq3ymkhItYdXLAbvJZL1V9scaAA=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2019 15:05:33.4850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c0d4b3-0a47-44b6-74a8-08d6fa47bcff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1711
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The drm resource being measured and limited here is the GEM buffer
objects.  User applications allocate and free these buffers.  In
addition, a process can allocate a buffer and share it with another
process.  The consumer of a shared buffer can also outlive the
allocator of the buffer.

For the purpose of cgroup accounting and limiting, ownership of the
buffer is deemed to be the cgroup for which the allocating process
belongs to.  There is one cgroup limit per drm device.

In order to prevent the buffer outliving the cgroup that owns it, a
process is prevented from importing buffers that are not own by the
process' cgroup or the ancestors of the process' cgroup.  In other
words, in order for a buffer to be shared between two cgroups, the
buffer must be created by the common ancestors of the cgroups.

drm.buffer.stats
        A read-only flat-keyed file which exists on all cgroups.  Each
        entry is keyed by the drm device's major:minor.

        Total GEM buffer allocation in bytes.

drm.buffer.default
        A read-only flat-keyed file which exists on the root cgroup.
        Each entry is keyed by the drm device's major:minor.

        Default limits on the total GEM buffer allocation in bytes.

drm.buffer.max
        A read-write flat-keyed file which exists on all cgroups.  Each
        entry is keyed by the drm device's major:minor.

        Per device limits on the total GEM buffer allocation in byte.
        This is a hard limit.  Attempts in allocating beyond the cgroup
        limit will result in ENOMEM.  Shorthand understood by memparse
        (such as k, m, g) can be used.

        Set allocation limit for /dev/dri/card1 to 1GB
        echo "226:1 1g" > drm.buffer.total.max

        Set allocation limit for /dev/dri/card0 to 512MB
        echo "226:0 512m" > drm.buffer.total.max

Change-Id: I4c249d06d45ec709d6481d4cbe87c5168545c5d0
Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |   4 +
 drivers/gpu/drm/drm_gem.c                  |   8 +
 drivers/gpu/drm/drm_prime.c                |   9 +
 include/drm/drm_cgroup.h                   |  34 ++-
 include/drm/drm_gem.h                      |  11 +
 include/linux/cgroup_drm.h                 |   2 +
 kernel/cgroup/drm.c                        | 321 +++++++++++++++++++++
 7 files changed, 387 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 93b2c5a48a71..b4c078b7ad63 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -34,6 +34,7 @@
 #include <drm/drmP.h>
 #include <drm/amdgpu_drm.h>
 #include <drm/drm_cache.h>
+#include <drm/drm_cgroup.h>
 #include "amdgpu.h"
 #include "amdgpu_trace.h"
 #include "amdgpu_amdkfd.h"
@@ -446,6 +447,9 @@ static int amdgpu_bo_do_create(struct amdgpu_device *adev,
 	if (!amdgpu_bo_validate_size(adev, size, bp->domain))
 		return -ENOMEM;
 
+	if (!drmcgrp_bo_can_allocate(current, adev->ddev, size))
+		return -ENOMEM;
+
 	*bo_ptr = NULL;
 
 	acc_size = ttm_bo_dma_acc_size(&adev->mman.bdev, size,
diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 6a80db077dc6..e20c1034bf2b 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -37,10 +37,12 @@
 #include <linux/shmem_fs.h>
 #include <linux/dma-buf.h>
 #include <linux/mem_encrypt.h>
+#include <linux/cgroup_drm.h>
 #include <drm/drmP.h>
 #include <drm/drm_vma_manager.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_print.h>
+#include <drm/drm_cgroup.h>
 #include "drm_internal.h"
 
 /** @file drm_gem.c
@@ -154,6 +156,9 @@ void drm_gem_private_object_init(struct drm_device *dev,
 	obj->handle_count = 0;
 	obj->size = size;
 	drm_vma_node_reset(&obj->vma_node);
+
+	obj->drmcgrp = get_drmcgrp(current);
+	drmcgrp_chg_bo_alloc(obj->drmcgrp, dev, size);
 }
 EXPORT_SYMBOL(drm_gem_private_object_init);
 
@@ -804,6 +809,9 @@ drm_gem_object_release(struct drm_gem_object *obj)
 	if (obj->filp)
 		fput(obj->filp);
 
+	drmcgrp_unchg_bo_alloc(obj->drmcgrp, obj->dev, obj->size);
+	put_drmcgrp(obj->drmcgrp);
+
 	drm_gem_free_mmap_offset(obj);
 }
 EXPORT_SYMBOL(drm_gem_object_release);
diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 231e3f6d5f41..eeb612116810 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -32,6 +32,7 @@
 #include <drm/drm_prime.h>
 #include <drm/drm_gem.h>
 #include <drm/drmP.h>
+#include <drm/drm_cgroup.h>
 
 #include "drm_internal.h"
 
@@ -794,6 +795,7 @@ int drm_gem_prime_fd_to_handle(struct drm_device *dev,
 {
 	struct dma_buf *dma_buf;
 	struct drm_gem_object *obj;
+	struct drmcgrp *drmcgrp = drmcgrp_from(current);
 	int ret;
 
 	dma_buf = dma_buf_get(prime_fd);
@@ -818,6 +820,13 @@ int drm_gem_prime_fd_to_handle(struct drm_device *dev,
 		goto out_unlock;
 	}
 
+	/* only allow bo from the same cgroup or its ancestor to be imported */
+	if (drmcgrp != NULL &&
+			!drmcgrp_is_self_or_ancestor(drmcgrp, obj->drmcgrp)) {
+		ret = -EACCES;
+		goto out_unlock;
+	}
+
 	if (obj->dma_buf) {
 		WARN_ON(obj->dma_buf != dma_buf);
 	} else {
diff --git a/include/drm/drm_cgroup.h b/include/drm/drm_cgroup.h
index ddb9eab64360..8711b7c5f7bf 100644
--- a/include/drm/drm_cgroup.h
+++ b/include/drm/drm_cgroup.h
@@ -4,12 +4,20 @@
 #ifndef __DRM_CGROUP_H__
 #define __DRM_CGROUP_H__
 
+#include <linux/cgroup_drm.h>
+
 #ifdef CONFIG_CGROUP_DRM
 
 int drmcgrp_register_device(struct drm_device *device);
-
 int drmcgrp_unregister_device(struct drm_device *device);
-
+bool drmcgrp_is_self_or_ancestor(struct drmcgrp *self,
+		struct drmcgrp *relative);
+void drmcgrp_chg_bo_alloc(struct drmcgrp *drmcgrp, struct drm_device *dev,
+		size_t size);
+void drmcgrp_unchg_bo_alloc(struct drmcgrp *drmcgrp, struct drm_device *dev,
+		size_t size);
+bool drmcgrp_bo_can_allocate(struct task_struct *task, struct drm_device *dev,
+		size_t size);
 #else
 static inline int drmcgrp_register_device(struct drm_device *device)
 {
@@ -20,5 +28,27 @@ static inline int drmcgrp_unregister_device(struct drm_device *device)
 {
 	return 0;
 }
+
+static inline bool drmcgrp_is_self_or_ancestor(struct drmcgrp *self,
+		struct drmcgrp *relative)
+{
+	return false;
+}
+
+static inline void drmcgrp_chg_bo_alloc(struct drmcgrp *drmcgrp,
+		struct drm_device *dev,	size_t size)
+{
+}
+
+static inline void drmcgrp_unchg_bo_alloc(struct drmcgrp *drmcgrp,
+		struct drm_device *dev,	size_t size)
+{
+}
+
+static inline bool drmcgrp_bo_can_allocate(struct task_struct *task,
+		struct drm_device *dev,	size_t size)
+{
+	return true;
+}
 #endif /* CONFIG_CGROUP_DRM */
 #endif /* __DRM_CGROUP_H__ */
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index c95727425284..09d1c69a3f0c 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -272,6 +272,17 @@ struct drm_gem_object {
 	 *
 	 */
 	const struct drm_gem_object_funcs *funcs;
+
+	/**
+	 * @drmcgrp:
+	 *
+	 * DRM cgroup this GEM object belongs to.
+	 *
+	 * This is used to track and limit the amount of GEM objects a user
+	 * can allocate.  Since GEM objects can be shared, this is also used
+	 * to ensure GEM objects are only shared within the same cgroup.
+	 */
+	struct drmcgrp *drmcgrp;
 };
 
 /**
diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
index 27497f786c93..efa019666f1c 100644
--- a/include/linux/cgroup_drm.h
+++ b/include/linux/cgroup_drm.h
@@ -15,6 +15,8 @@
 
 struct drmcgrp_device_resource {
 	/* for per device stats */
+	s64			bo_stats_total_allocated;
+	s64			bo_limits_total_allocated;
 };
 
 struct drmcgrp {
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
index 7da6e0d93991..cfc1fe74dca3 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -9,6 +9,7 @@
 #include <linux/cgroup_drm.h>
 #include <linux/kernel.h>
 #include <drm/drm_device.h>
+#include <drm/drm_ioctl.h>
 #include <drm/drm_cgroup.h>
 
 static DEFINE_MUTEX(drmcgrp_mutex);
@@ -16,6 +17,26 @@ static DEFINE_MUTEX(drmcgrp_mutex);
 struct drmcgrp_device {
 	struct drm_device	*dev;
 	struct mutex		mutex;
+
+	s64			bo_limits_total_allocated_default;
+};
+
+#define DRMCG_CTF_PRIV_SIZE 3
+#define DRMCG_CTF_PRIV_MASK GENMASK((DRMCG_CTF_PRIV_SIZE - 1), 0)
+#define DRMCG_CTF_PRIV(res_type, f_type)  ((res_type) <<\
+		DRMCG_CTF_PRIV_SIZE | (f_type))
+#define DRMCG_CTF_PRIV2RESTYPE(priv) ((priv) >> DRMCG_CTF_PRIV_SIZE)
+#define DRMCG_CTF_PRIV2FTYPE(priv) ((priv) & DRMCG_CTF_PRIV_MASK)
+
+
+enum drmcgrp_res_type {
+	DRMCGRP_TYPE_BO_TOTAL,
+};
+
+enum drmcgrp_file_type {
+	DRMCGRP_FTYPE_STATS,
+	DRMCGRP_FTYPE_LIMIT,
+	DRMCGRP_FTYPE_DEFAULT,
 };
 
 /* indexed by drm_minor for access speed */
@@ -54,6 +75,10 @@ static inline int init_drmcgrp_single(struct drmcgrp *drmcgrp, int minor)
 	}
 
 	/* set defaults here */
+	if (known_drmcgrp_devs[minor] != NULL) {
+		ddr->bo_limits_total_allocated =
+		  known_drmcgrp_devs[minor]->bo_limits_total_allocated_default;
+	}
 
 	return 0;
 }
@@ -100,7 +125,225 @@ drmcgrp_css_alloc(struct cgroup_subsys_state *parent_css)
 	return &drmcgrp->css;
 }
 
+static inline void drmcgrp_print_stats(struct drmcgrp_device_resource *ddr,
+		struct seq_file *sf, enum drmcgrp_res_type type)
+{
+	if (ddr == NULL) {
+		seq_puts(sf, "\n");
+		return;
+	}
+
+	switch (type) {
+	case DRMCGRP_TYPE_BO_TOTAL:
+		seq_printf(sf, "%lld\n", ddr->bo_stats_total_allocated);
+		break;
+	default:
+		seq_puts(sf, "\n");
+		break;
+	}
+}
+
+static inline void drmcgrp_print_limits(struct drmcgrp_device_resource *ddr,
+		struct seq_file *sf, enum drmcgrp_res_type type)
+{
+	if (ddr == NULL) {
+		seq_puts(sf, "\n");
+		return;
+	}
+
+	switch (type) {
+	case DRMCGRP_TYPE_BO_TOTAL:
+		seq_printf(sf, "%lld\n", ddr->bo_limits_total_allocated);
+		break;
+	default:
+		seq_puts(sf, "\n");
+		break;
+	}
+}
+
+static inline void drmcgrp_print_default(struct drmcgrp_device *ddev,
+		struct seq_file *sf, enum drmcgrp_res_type type)
+{
+	if (ddev == NULL) {
+		seq_puts(sf, "\n");
+		return;
+	}
+
+	switch (type) {
+	case DRMCGRP_TYPE_BO_TOTAL:
+		seq_printf(sf, "%lld\n",
+				ddev->bo_limits_total_allocated_default);
+		break;
+	default:
+		seq_puts(sf, "\n");
+		break;
+	}
+}
+
+int drmcgrp_bo_show(struct seq_file *sf, void *v)
+{
+	struct drmcgrp *drmcgrp = css_drmcgrp(seq_css(sf));
+	struct drmcgrp_device_resource *ddr = NULL;
+	enum drmcgrp_file_type f_type =
+		DRMCG_CTF_PRIV2FTYPE(seq_cft(sf)->private);
+	enum drmcgrp_res_type type =
+		DRMCG_CTF_PRIV2RESTYPE(seq_cft(sf)->private);
+	struct drmcgrp_device *ddev;
+	int i;
+
+	for (i = 0; i <= max_minor; i++) {
+		ddr = drmcgrp->dev_resources[i];
+		ddev = known_drmcgrp_devs[i];
+
+		seq_printf(sf, "%d:%d ", DRM_MAJOR, i);
+
+		switch (f_type) {
+		case DRMCGRP_FTYPE_STATS:
+			drmcgrp_print_stats(ddr, sf, type);
+			break;
+		case DRMCGRP_FTYPE_LIMIT:
+			drmcgrp_print_limits(ddr, sf, type);
+			break;
+		case DRMCGRP_FTYPE_DEFAULT:
+			drmcgrp_print_default(ddev, sf, type);
+			break;
+		default:
+			seq_puts(sf, "\n");
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static inline void drmcgrp_pr_cft_err(const struct drmcgrp *drmcgrp,
+		const char *cft_name, int minor)
+{
+	pr_err("drmcgrp: error parsing %s, minor %d ",
+			cft_name, minor);
+	pr_cont_cgroup_name(drmcgrp->css.cgroup);
+	pr_cont("\n");
+}
+
+static inline int drmcgrp_process_limit_val(char *sval, bool is_mem,
+			s64 def_val, s64 max_val, s64 *ret_val)
+{
+	int rc = strcmp("max", sval);
+
+
+	if (!rc)
+		*ret_val = max_val;
+	else {
+		rc = strcmp("default", sval);
+
+		if (!rc)
+			*ret_val = def_val;
+	}
+
+	if (rc) {
+		if (is_mem) {
+			*ret_val = memparse(sval, NULL);
+			rc = 0;
+		} else {
+			rc = kstrtoll(sval, 0, ret_val);
+		}
+	}
+
+	if (*ret_val > max_val)
+		*ret_val = max_val;
+
+	return rc;
+}
+
+ssize_t drmcgrp_bo_limit_write(struct kernfs_open_file *of, char *buf,
+		size_t nbytes, loff_t off)
+{
+	struct drmcgrp *drmcgrp = css_drmcgrp(of_css(of));
+	struct drmcgrp *parent = parent_drmcgrp(drmcgrp);
+	enum drmcgrp_res_type type =
+		DRMCG_CTF_PRIV2RESTYPE(of_cft(of)->private);
+	char *cft_name = of_cft(of)->name;
+	char *limits = strstrip(buf);
+	struct drmcgrp_device *ddev;
+	struct drmcgrp_device_resource *ddr;
+	char *line;
+	char sattr[256];
+	s64 val;
+	s64 p_max;
+	int rc;
+	int minor;
+
+	while (limits != NULL) {
+		line =  strsep(&limits, "\n");
+
+		if (sscanf(line,
+			__stringify(DRM_MAJOR)":%u %255[^\t\n]",
+							&minor, sattr) != 2) {
+			pr_err("drmcgrp: error parsing %s ", cft_name);
+			pr_cont_cgroup_name(drmcgrp->css.cgroup);
+			pr_cont("\n");
+
+			continue;
+		}
+
+		if (minor < 0 || minor > max_minor) {
+			pr_err("drmcgrp: invalid minor %d for %s ",
+					minor, cft_name);
+			pr_cont_cgroup_name(drmcgrp->css.cgroup);
+			pr_cont("\n");
+
+			continue;
+		}
+
+		ddr = drmcgrp->dev_resources[minor];
+		ddev = known_drmcgrp_devs[minor];
+		switch (type) {
+		case DRMCGRP_TYPE_BO_TOTAL:
+			p_max = parent == NULL ? S64_MAX :
+				parent->dev_resources[minor]->
+				bo_limits_total_allocated;
+
+			rc = drmcgrp_process_limit_val(sattr, true,
+				ddev->bo_limits_total_allocated_default,
+				p_max,
+				&val);
+
+			if (rc || val < 0) {
+				drmcgrp_pr_cft_err(drmcgrp, cft_name, minor);
+				continue;
+			}
+
+			ddr->bo_limits_total_allocated = val;
+			break;
+		default:
+			break;
+		}
+	}
+
+	return nbytes;
+}
+
 struct cftype files[] = {
+	{
+		.name = "buffer.total.stats",
+		.seq_show = drmcgrp_bo_show,
+		.private = DRMCG_CTF_PRIV(DRMCGRP_TYPE_BO_TOTAL,
+						DRMCGRP_FTYPE_STATS),
+	},
+	{
+		.name = "buffer.total.default",
+		.seq_show = drmcgrp_bo_show,
+		.flags = CFTYPE_ONLY_ON_ROOT,
+		.private = DRMCG_CTF_PRIV(DRMCGRP_TYPE_BO_TOTAL,
+						DRMCGRP_FTYPE_DEFAULT),
+	},
+	{
+		.name = "buffer.total.max",
+		.write = drmcgrp_bo_limit_write,
+		.seq_show = drmcgrp_bo_show,
+		.private = DRMCG_CTF_PRIV(DRMCGRP_TYPE_BO_TOTAL,
+						DRMCGRP_FTYPE_LIMIT),
+	},
 	{ }	/* terminate */
 };
 
@@ -121,6 +364,8 @@ int drmcgrp_register_device(struct drm_device *dev)
 		return -ENOMEM;
 
 	ddev->dev = dev;
+	ddev->bo_limits_total_allocated_default = S64_MAX;
+
 	mutex_init(&ddev->mutex);
 
 	mutex_lock(&drmcgrp_mutex);
@@ -156,3 +401,79 @@ int drmcgrp_unregister_device(struct drm_device *dev)
 	return 0;
 }
 EXPORT_SYMBOL(drmcgrp_unregister_device);
+
+bool drmcgrp_is_self_or_ancestor(struct drmcgrp *self, struct drmcgrp *relative)
+{
+	for (; self != NULL; self = parent_drmcgrp(self))
+		if (self == relative)
+			return true;
+
+	return false;
+}
+EXPORT_SYMBOL(drmcgrp_is_self_or_ancestor);
+
+bool drmcgrp_bo_can_allocate(struct task_struct *task, struct drm_device *dev,
+		size_t size)
+{
+	struct drmcgrp *drmcgrp = drmcgrp_from(task);
+	struct drmcgrp_device_resource *ddr;
+	struct drmcgrp_device_resource *d;
+	int devIdx = dev->primary->index;
+	bool result = true;
+	s64 delta = 0;
+
+	if (drmcgrp == NULL || drmcgrp == root_drmcgrp)
+		return true;
+
+	ddr = drmcgrp->dev_resources[devIdx];
+	mutex_lock(&known_drmcgrp_devs[devIdx]->mutex);
+	for ( ; drmcgrp != root_drmcgrp; drmcgrp = parent_drmcgrp(drmcgrp)) {
+		d = drmcgrp->dev_resources[devIdx];
+		delta = d->bo_limits_total_allocated -
+				d->bo_stats_total_allocated;
+
+		if (delta <= 0 || size > delta) {
+			result = false;
+			break;
+		}
+	}
+	mutex_unlock(&known_drmcgrp_devs[devIdx]->mutex);
+
+	return result;
+}
+EXPORT_SYMBOL(drmcgrp_bo_can_allocate);
+
+void drmcgrp_chg_bo_alloc(struct drmcgrp *drmcgrp, struct drm_device *dev,
+		size_t size)
+{
+	struct drmcgrp_device_resource *ddr;
+	int devIdx = dev->primary->index;
+
+	if (drmcgrp == NULL || known_drmcgrp_devs[devIdx] == NULL)
+		return;
+
+	mutex_lock(&known_drmcgrp_devs[devIdx]->mutex);
+	for ( ; drmcgrp != NULL; drmcgrp = parent_drmcgrp(drmcgrp)) {
+		ddr = drmcgrp->dev_resources[devIdx];
+
+		ddr->bo_stats_total_allocated += (s64)size;
+	}
+	mutex_unlock(&known_drmcgrp_devs[devIdx]->mutex);
+}
+EXPORT_SYMBOL(drmcgrp_chg_bo_alloc);
+
+void drmcgrp_unchg_bo_alloc(struct drmcgrp *drmcgrp, struct drm_device *dev,
+		size_t size)
+{
+	int devIdx = dev->primary->index;
+
+	if (drmcgrp == NULL || known_drmcgrp_devs[devIdx] == NULL)
+		return;
+
+	mutex_lock(&known_drmcgrp_devs[devIdx]->mutex);
+	for ( ; drmcgrp != NULL; drmcgrp = parent_drmcgrp(drmcgrp))
+		drmcgrp->dev_resources[devIdx]->bo_stats_total_allocated
+			-= (s64)size;
+	mutex_unlock(&known_drmcgrp_devs[devIdx]->mutex);
+}
+EXPORT_SYMBOL(drmcgrp_unchg_bo_alloc);
-- 
2.21.0


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14AE456D32
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2019 17:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbfFZPFn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jun 2019 11:05:43 -0400
Received: from mail-eopbgr760045.outbound.protection.outlook.com ([40.107.76.45]:19461
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727481AbfFZPFn (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 26 Jun 2019 11:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NCdNe76QYSnO5DSBCCWD+xVVU3Fpx5WL0Ju2T0zdds=;
 b=shldbPvohzi3h+tSsi7sY2vX//gbf4Nze4tmxdgZKxKsuLi8zd8bOYiJvlTIueiRIIz5i/Zu8I+WWol8cbHfw8SQq1fiPEfF7oKzvbXp5M5xnytJTQTiSV27Ni+0tOo6U7bY8//31AaCT3yXtpmDtWmknUfJsNwY2DVdgk2gj80=
Received: from MWHPR12CA0068.namprd12.prod.outlook.com (2603:10b6:300:103::30)
 by MWHPR1201MB0030.namprd12.prod.outlook.com (2603:10b6:301:53::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16; Wed, 26 Jun
 2019 15:05:38 +0000
Received: from DM3NAM03FT041.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::209) by MWHPR12CA0068.outlook.office365.com
 (2603:10b6:300:103::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2008.16 via Frontend
 Transport; Wed, 26 Jun 2019 15:05:38 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV02.amd.com (165.204.84.17) by
 DM3NAM03FT041.mail.protection.outlook.com (10.152.83.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2032.15 via Frontend Transport; Wed, 26 Jun 2019 15:05:37 +0000
Received: from kho-5039A.amd.com (10.180.168.240) by SATLEXCHOV02.amd.com
 (10.181.40.72) with Microsoft SMTP Server id 14.3.389.1; Wed, 26 Jun 2019
 10:05:31 -0500
From:   Kenny Ho <Kenny.Ho@amd.com>
To:     <y2kenny@gmail.com>, <cgroups@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <tj@kernel.org>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <joseph.greathouse@amd.com>,
        <jsparks@cray.com>, <lkaplan@cray.com>
CC:     Kenny Ho <Kenny.Ho@amd.com>
Subject: [RFC PATCH v3 07/11] drm, cgroup: Add TTM buffer allocation stats
Date:   Wed, 26 Jun 2019 11:05:18 -0400
Message-ID: <20190626150522.11618-8-Kenny.Ho@amd.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626150522.11618-1-Kenny.Ho@amd.com>
References: <20190626150522.11618-1-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(39860400002)(346002)(2980300002)(428003)(199004)(189003)(126002)(2616005)(476003)(30864003)(68736007)(6666004)(486006)(356004)(76176011)(8936002)(2201001)(4326008)(5660300002)(426003)(50226002)(36756003)(336012)(1076003)(446003)(77096007)(11346002)(186003)(14444005)(316002)(110136005)(50466002)(48376002)(7696005)(81166006)(2906002)(47776003)(2870700001)(53416004)(53936002)(72206003)(51416003)(81156014)(305945005)(8676002)(478600001)(86362001)(70206006)(26005)(70586007)(921003)(1121003)(2101003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB0030;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed8f9b89-2dbb-4798-4c5c-08d6fa47bf83
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:MWHPR1201MB0030;
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0030:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB00306780686E51A031F0863383E20@MWHPR1201MB0030.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 00808B16F3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 7JUfSxVgabMi2euTBF1CO/QHEMDeN6T9BuCU6ECbkLjlgxMaUadAH8alhhR5KWf6eVjPmchAJm5JcoHq6mgVqX9M/awMa/oa7S9BZXUYJgvZJ3Tcv/tCIODJrQzmAGzxAcFxce2+JCN3+l2DvYR3rXQFI1hbl3BfTvY0DTwsAD+SxnokX02zkYhGoEkFivqXXYEQU/lPJXjcmqQaYWZ3S0AlLaizG1g63bxFQyfPFIQBhU/MikQhWsTUxyLyORj0N+EKXaN7kKjUyk807+VKfos4v4OkfAcAle1GMrTFi3aNpeLirIzgmmcY1NkqOUbSH3vF5cLYYCdc+6k1Pht2TV58TmZSA/Dfvfn0/IyI7nu+OXSFZQbi6ofjErR5IJumY6LHMKtGSdWmZik0SsmAQf0018BLV6ZBdGlij36tcJM=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2019 15:05:37.4593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed8f9b89-2dbb-4798-4c5c-08d6fa47bf83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0030
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The drm resource being measured is the TTM (Translation Table Manager)
buffers.  TTM manages different types of memory that a GPU might access.
These memory types include dedicated Video RAM (VRAM) and host/system
memory accessible through IOMMU (GART/GTT).  TTM is currently used by
multiple drm drivers (amd, ast, bochs, cirrus, hisilicon, maga200,
nouveau, qxl, virtio, vmwgfx.)

drm.memory.stats
        A read-only nested-keyed file which exists on all cgroups.
        Each entry is keyed by the drm device's major:minor.  The
        following nested keys are defined.

          ======         =============================================
          system         Host/system memory
          tt             Host memory used by the drm device (GTT/GART)
          vram           Video RAM used by the drm device
          priv           Other drm device, vendor specific memory
          ======         =============================================

        Reading returns the following::

        226:0 system=0 tt=0 vram=0 priv=0
        226:1 system=0 tt=9035776 vram=17768448 priv=16809984
        226:2 system=0 tt=9035776 vram=17768448 priv=16809984

drm.memory.evict.stats
        A read-only flat-keyed file which exists on all cgroups.  Each
        entry is keyed by the drm device's major:minor.

        Total number of evictions.

Change-Id: Ice2c4cc845051229549bebeb6aa2d7d6153bdf6a
Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |   3 +-
 drivers/gpu/drm/ttm/ttm_bo.c            |  30 +++++++
 drivers/gpu/drm/ttm/ttm_bo_util.c       |   4 +
 include/drm/drm_cgroup.h                |  19 ++++
 include/drm/ttm/ttm_bo_api.h            |   2 +
 include/drm/ttm/ttm_bo_driver.h         |   8 ++
 include/linux/cgroup_drm.h              |   4 +
 kernel/cgroup/drm.c                     | 113 ++++++++++++++++++++++++
 8 files changed, 182 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index e9ecc3953673..a8dfc78ed45f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1678,8 +1678,9 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	mutex_init(&adev->mman.gtt_window_lock);
 
 	/* No others user of address space so set it to 0 */
-	r = ttm_bo_device_init(&adev->mman.bdev,
+	r = ttm_bo_device_init_tmp(&adev->mman.bdev,
 			       &amdgpu_bo_driver,
+			       adev->ddev,
 			       adev->ddev->anon_inode->i_mapping,
 			       adev->need_dma32);
 	if (r) {
diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 2845fceb2fbd..e9f70547f0ad 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -34,6 +34,7 @@
 #include <drm/ttm/ttm_module.h>
 #include <drm/ttm/ttm_bo_driver.h>
 #include <drm/ttm/ttm_placement.h>
+#include <drm/drm_cgroup.h>
 #include <linux/jiffies.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
@@ -42,6 +43,7 @@
 #include <linux/module.h>
 #include <linux/atomic.h>
 #include <linux/reservation.h>
+#include <linux/cgroup_drm.h>
 
 static void ttm_bo_global_kobj_release(struct kobject *kobj);
 
@@ -151,6 +153,10 @@ static void ttm_bo_release_list(struct kref *list_kref)
 	struct ttm_bo_device *bdev = bo->bdev;
 	size_t acc_size = bo->acc_size;
 
+	if (bo->bdev->ddev != NULL) // TODO: remove after ddev initiazlied for all
+		drmcgrp_unchg_mem(bo);
+	put_drmcgrp(bo->drmcgrp);
+
 	BUG_ON(kref_read(&bo->list_kref));
 	BUG_ON(kref_read(&bo->kref));
 	BUG_ON(atomic_read(&bo->cpu_writers));
@@ -353,6 +359,8 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_object *bo,
 		if (bo->mem.mem_type == TTM_PL_SYSTEM) {
 			if (bdev->driver->move_notify)
 				bdev->driver->move_notify(bo, evict, mem);
+			if (bo->bdev->ddev != NULL) // TODO: remove after ddev initiazlied for all
+				drmcgrp_mem_track_move(bo, evict, mem);
 			bo->mem = *mem;
 			mem->mm_node = NULL;
 			goto moved;
@@ -361,6 +369,8 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_object *bo,
 
 	if (bdev->driver->move_notify)
 		bdev->driver->move_notify(bo, evict, mem);
+	if (bo->bdev->ddev != NULL) // TODO: remove after ddev initiazlied for all
+		drmcgrp_mem_track_move(bo, evict, mem);
 
 	if (!(old_man->flags & TTM_MEMTYPE_FLAG_FIXED) &&
 	    !(new_man->flags & TTM_MEMTYPE_FLAG_FIXED))
@@ -374,6 +384,8 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_object *bo,
 		if (bdev->driver->move_notify) {
 			swap(*mem, bo->mem);
 			bdev->driver->move_notify(bo, false, mem);
+			if (bo->bdev->ddev != NULL) // TODO: remove after ddev initiazlied for all
+				drmcgrp_mem_track_move(bo, evict, mem);
 			swap(*mem, bo->mem);
 		}
 
@@ -1275,6 +1287,10 @@ int ttm_bo_init_reserved(struct ttm_bo_device *bdev,
 		WARN_ON(!locked);
 	}
 
+	bo->drmcgrp = get_drmcgrp(current);
+	if (bo->bdev->ddev != NULL) // TODO: remove after ddev initiazlied for all
+		drmcgrp_chg_mem(bo);
+
 	if (likely(!ret))
 		ret = ttm_bo_validate(bo, placement, ctx);
 
@@ -1666,6 +1682,20 @@ int ttm_bo_device_init(struct ttm_bo_device *bdev,
 }
 EXPORT_SYMBOL(ttm_bo_device_init);
 
+/* TODO merge with official function when implementation finalized*/
+int ttm_bo_device_init_tmp(struct ttm_bo_device *bdev,
+		struct ttm_bo_driver *driver,
+		struct drm_device *ddev,
+		struct address_space *mapping,
+		bool need_dma32)
+{
+	int ret = ttm_bo_device_init(bdev, driver, mapping, need_dma32);
+
+	bdev->ddev = ddev;
+	return ret;
+}
+EXPORT_SYMBOL(ttm_bo_device_init_tmp);
+
 /*
  * buffer object vm functions.
  */
diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index 895d77d799e4..4ed7847c21f4 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -32,6 +32,7 @@
 #include <drm/ttm/ttm_bo_driver.h>
 #include <drm/ttm/ttm_placement.h>
 #include <drm/drm_vma_manager.h>
+#include <drm/drm_cgroup.h>
 #include <linux/io.h>
 #include <linux/highmem.h>
 #include <linux/wait.h>
@@ -522,6 +523,9 @@ static int ttm_buffer_object_transfer(struct ttm_buffer_object *bo,
 	ret = reservation_object_trylock(fbo->base.resv);
 	WARN_ON(!ret);
 
+	if (bo->bdev->ddev != NULL) // TODO: remove after ddev initiazlied for all
+		drmcgrp_chg_mem(bo);
+
 	*new_obj = &fbo->base;
 	return 0;
 }
diff --git a/include/drm/drm_cgroup.h b/include/drm/drm_cgroup.h
index 8711b7c5f7bf..48ab5450cf17 100644
--- a/include/drm/drm_cgroup.h
+++ b/include/drm/drm_cgroup.h
@@ -5,6 +5,7 @@
 #define __DRM_CGROUP_H__
 
 #include <linux/cgroup_drm.h>
+#include <drm/ttm/ttm_bo_api.h>
 
 #ifdef CONFIG_CGROUP_DRM
 
@@ -18,6 +19,11 @@ void drmcgrp_unchg_bo_alloc(struct drmcgrp *drmcgrp, struct drm_device *dev,
 		size_t size);
 bool drmcgrp_bo_can_allocate(struct task_struct *task, struct drm_device *dev,
 		size_t size);
+void drmcgrp_chg_mem(struct ttm_buffer_object *tbo);
+void drmcgrp_unchg_mem(struct ttm_buffer_object *tbo);
+void drmcgrp_mem_track_move(struct ttm_buffer_object *old_bo, bool evict,
+		struct ttm_mem_reg *new_mem);
+
 #else
 static inline int drmcgrp_register_device(struct drm_device *device)
 {
@@ -50,5 +56,18 @@ static inline bool drmcgrp_bo_can_allocate(struct task_struct *task,
 {
 	return true;
 }
+
+static inline void drmcgrp_chg_mem(struct ttm_buffer_object *tbo)
+{
+}
+
+static inline void drmcgrp_unchg_mem(struct ttm_buffer_object *tbo)
+{
+}
+
+static inline void drmcgrp_mem_track_move(struct ttm_buffer_object *old_bo,
+		bool evict, struct ttm_mem_reg *new_mem)
+{
+}
 #endif /* CONFIG_CGROUP_DRM */
 #endif /* __DRM_CGROUP_H__ */
diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/ttm_bo_api.h
index 49d9cdfc58f2..ae1bb6daec81 100644
--- a/include/drm/ttm/ttm_bo_api.h
+++ b/include/drm/ttm/ttm_bo_api.h
@@ -128,6 +128,7 @@ struct ttm_tt;
  * struct ttm_buffer_object
  *
  * @bdev: Pointer to the buffer object device structure.
+ * @drmcgrp: DRM cgroup this object belongs to.
  * @type: The bo type.
  * @destroy: Destruction function. If NULL, kfree is used.
  * @num_pages: Actual number of pages.
@@ -174,6 +175,7 @@ struct ttm_buffer_object {
 	 */
 
 	struct ttm_bo_device *bdev;
+	struct drmcgrp *drmcgrp;
 	enum ttm_bo_type type;
 	void (*destroy) (struct ttm_buffer_object *);
 	unsigned long num_pages;
diff --git a/include/drm/ttm/ttm_bo_driver.h b/include/drm/ttm/ttm_bo_driver.h
index c008346c2401..4cbcb41e5aa9 100644
--- a/include/drm/ttm/ttm_bo_driver.h
+++ b/include/drm/ttm/ttm_bo_driver.h
@@ -30,6 +30,7 @@
 #ifndef _TTM_BO_DRIVER_H_
 #define _TTM_BO_DRIVER_H_
 
+#include <drm/drm_device.h>
 #include <drm/drm_mm.h>
 #include <drm/drm_vma_manager.h>
 #include <linux/workqueue.h>
@@ -442,6 +443,7 @@ extern struct ttm_bo_global {
  * @driver: Pointer to a struct ttm_bo_driver struct setup by the driver.
  * @man: An array of mem_type_managers.
  * @vma_manager: Address space manager
+ * @ddev: Pointer to struct drm_device that this ttm_bo_device belongs to
  * lru_lock: Spinlock that protects the buffer+device lru lists and
  * ddestroy lists.
  * @dev_mapping: A pointer to the struct address_space representing the
@@ -460,6 +462,7 @@ struct ttm_bo_device {
 	struct ttm_bo_global *glob;
 	struct ttm_bo_driver *driver;
 	struct ttm_mem_type_manager man[TTM_NUM_MEM_TYPES];
+	struct drm_device *ddev;
 
 	/*
 	 * Protected by internal locks.
@@ -598,6 +601,11 @@ int ttm_bo_device_init(struct ttm_bo_device *bdev,
 		       struct address_space *mapping,
 		       bool need_dma32);
 
+int ttm_bo_device_init_tmp(struct ttm_bo_device *bdev,
+		       struct ttm_bo_driver *driver,
+		       struct drm_device *ddev,
+		       struct address_space *mapping,
+		       bool need_dma32);
 /**
  * ttm_bo_unmap_virtual
  *
diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
index e4400b21ab8e..141bea06f74c 100644
--- a/include/linux/cgroup_drm.h
+++ b/include/linux/cgroup_drm.h
@@ -9,6 +9,7 @@
 #include <linux/mutex.h>
 #include <linux/cgroup.h>
 #include <drm/drm_file.h>
+#include <drm/ttm/ttm_placement.h>
 
 /* limit defined per the way drm_minor_alloc operates */
 #define MAX_DRM_DEV (64 * DRM_MINOR_RENDER)
@@ -22,6 +23,9 @@ struct drmcgrp_device_resource {
 	size_t			bo_limits_peak_allocated;
 
 	s64			bo_stats_count_allocated;
+
+	s64			mem_stats[TTM_PL_PRIV+1];
+	s64			mem_stats_evict;
 };
 
 struct drmcgrp {
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
index 9144f93b851f..5aee42a628c1 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -8,6 +8,8 @@
 #include <linux/mutex.h>
 #include <linux/cgroup_drm.h>
 #include <linux/kernel.h>
+#include <drm/ttm/ttm_bo_api.h>
+#include <drm/ttm/ttm_bo_driver.h>
 #include <drm/drm_device.h>
 #include <drm/drm_ioctl.h>
 #include <drm/drm_cgroup.h>
@@ -34,6 +36,8 @@ enum drmcgrp_res_type {
 	DRMCGRP_TYPE_BO_TOTAL,
 	DRMCGRP_TYPE_BO_PEAK,
 	DRMCGRP_TYPE_BO_COUNT,
+	DRMCGRP_TYPE_MEM,
+	DRMCGRP_TYPE_MEM_EVICT,
 };
 
 enum drmcgrp_file_type {
@@ -42,6 +46,13 @@ enum drmcgrp_file_type {
 	DRMCGRP_FTYPE_DEFAULT,
 };
 
+static char const *ttm_placement_names[] = {
+	[TTM_PL_SYSTEM] = "system",
+	[TTM_PL_TT]     = "tt",
+	[TTM_PL_VRAM]   = "vram",
+	[TTM_PL_PRIV]   = "priv",
+};
+
 /* indexed by drm_minor for access speed */
 static struct drmcgrp_device	*known_drmcgrp_devs[MAX_DRM_DEV];
 
@@ -134,6 +145,7 @@ drmcgrp_css_alloc(struct cgroup_subsys_state *parent_css)
 static inline void drmcgrp_print_stats(struct drmcgrp_device_resource *ddr,
 		struct seq_file *sf, enum drmcgrp_res_type type)
 {
+	int i;
 	if (ddr == NULL) {
 		seq_puts(sf, "\n");
 		return;
@@ -149,6 +161,16 @@ static inline void drmcgrp_print_stats(struct drmcgrp_device_resource *ddr,
 	case DRMCGRP_TYPE_BO_COUNT:
 		seq_printf(sf, "%lld\n", ddr->bo_stats_count_allocated);
 		break;
+	case DRMCGRP_TYPE_MEM:
+		for (i = 0; i <= TTM_PL_PRIV; i++) {
+			seq_printf(sf, "%s=%lld ", ttm_placement_names[i],
+					ddr->mem_stats[i]);
+		}
+		seq_puts(sf, "\n");
+		break;
+	case DRMCGRP_TYPE_MEM_EVICT:
+		seq_printf(sf, "%lld\n", ddr->mem_stats_evict);
+		break;
 	default:
 		seq_puts(sf, "\n");
 		break;
@@ -406,6 +428,18 @@ struct cftype files[] = {
 		.private = DRMCG_CTF_PRIV(DRMCGRP_TYPE_BO_COUNT,
 						DRMCGRP_FTYPE_STATS),
 	},
+	{
+		.name = "memory.stats",
+		.seq_show = drmcgrp_bo_show,
+		.private = DRMCG_CTF_PRIV(DRMCGRP_TYPE_MEM,
+						DRMCGRP_FTYPE_STATS),
+	},
+	{
+		.name = "memory.evict.stats",
+		.seq_show = drmcgrp_bo_show,
+		.private = DRMCG_CTF_PRIV(DRMCGRP_TYPE_MEM_EVICT,
+						DRMCGRP_FTYPE_STATS),
+	},
 	{ }	/* terminate */
 };
 
@@ -555,3 +589,82 @@ void drmcgrp_unchg_bo_alloc(struct drmcgrp *drmcgrp, struct drm_device *dev,
 	mutex_unlock(&known_drmcgrp_devs[devIdx]->mutex);
 }
 EXPORT_SYMBOL(drmcgrp_unchg_bo_alloc);
+
+void drmcgrp_chg_mem(struct ttm_buffer_object *tbo)
+{
+	struct drm_device *dev = tbo->bdev->ddev;
+	struct drmcgrp *drmcgrp = tbo->drmcgrp;
+	int devIdx = dev->primary->index;
+	s64 size = (s64)(tbo->mem.size);
+	int mem_type = tbo->mem.mem_type;
+	struct drmcgrp_device_resource *ddr;
+
+	if (drmcgrp == NULL || known_drmcgrp_devs[devIdx] == NULL)
+		return;
+
+	mem_type = mem_type > TTM_PL_PRIV ? TTM_PL_PRIV : mem_type;
+
+	mutex_lock(&known_drmcgrp_devs[devIdx]->mutex);
+	for ( ; drmcgrp != NULL; drmcgrp = parent_drmcgrp(drmcgrp)) {
+		ddr = drmcgrp->dev_resources[devIdx];
+		ddr->mem_stats[mem_type] += size;
+	}
+	mutex_unlock(&known_drmcgrp_devs[devIdx]->mutex);
+}
+EXPORT_SYMBOL(drmcgrp_chg_mem);
+
+void drmcgrp_unchg_mem(struct ttm_buffer_object *tbo)
+{
+	struct drm_device *dev = tbo->bdev->ddev;
+	struct drmcgrp *drmcgrp = tbo->drmcgrp;
+	int devIdx = dev->primary->index;
+	s64 size = (s64)(tbo->mem.size);
+	int mem_type = tbo->mem.mem_type;
+	struct drmcgrp_device_resource *ddr;
+
+	if (drmcgrp == NULL || known_drmcgrp_devs[devIdx] == NULL)
+		return;
+
+	mem_type = mem_type > TTM_PL_PRIV ? TTM_PL_PRIV : mem_type;
+
+	mutex_lock(&known_drmcgrp_devs[devIdx]->mutex);
+	for ( ; drmcgrp != NULL; drmcgrp = parent_drmcgrp(drmcgrp)) {
+		ddr = drmcgrp->dev_resources[devIdx];
+		ddr->mem_stats[mem_type] -= size;
+	}
+	mutex_unlock(&known_drmcgrp_devs[devIdx]->mutex);
+}
+EXPORT_SYMBOL(drmcgrp_unchg_mem);
+
+void drmcgrp_mem_track_move(struct ttm_buffer_object *old_bo, bool evict,
+		struct ttm_mem_reg *new_mem)
+{
+	struct drm_device *dev = old_bo->bdev->ddev;
+	struct drmcgrp *drmcgrp = old_bo->drmcgrp;
+	s64 move_in_bytes = (s64)(old_bo->mem.size);
+	int devIdx = dev->primary->index;
+	int old_mem_type = old_bo->mem.mem_type;
+	int new_mem_type = new_mem->mem_type;
+	struct drmcgrp_device_resource *ddr;
+	struct drmcgrp_device *known_dev;
+
+	known_dev = known_drmcgrp_devs[devIdx];
+
+	if (drmcgrp == NULL || known_dev == NULL)
+		return;
+
+	old_mem_type = old_mem_type > TTM_PL_PRIV ? TTM_PL_PRIV : old_mem_type;
+	new_mem_type = new_mem_type > TTM_PL_PRIV ? TTM_PL_PRIV : new_mem_type;
+
+	mutex_lock(&known_dev->mutex);
+	for ( ; drmcgrp != NULL; drmcgrp = parent_drmcgrp(drmcgrp)) {
+		ddr = drmcgrp->dev_resources[devIdx];
+		ddr->mem_stats[old_mem_type] -= move_in_bytes;
+		ddr->mem_stats[new_mem_type] += move_in_bytes;
+
+		if (evict)
+			ddr->mem_stats_evict++;
+	}
+	mutex_unlock(&known_dev->mutex);
+}
+EXPORT_SYMBOL(drmcgrp_mem_track_move);
-- 
2.21.0


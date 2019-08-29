Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9018BA1165
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2019 08:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfH2GGA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Aug 2019 02:06:00 -0400
Received: from mail-eopbgr730046.outbound.protection.outlook.com ([40.107.73.46]:15744
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727421AbfH2GF7 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 29 Aug 2019 02:05:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhTmVvyIu1nB6KwyY3OBwKOayGU2m7RWZdISg6lxhN/JJYljvIGitMrkNV2zbY1EcrTr3HMArEetnyo+6NiKfQHiGRFVk3BptqL7H8x1au4YFEgcuTxuMRD14P2PWary6C10U/Q981LTM0VXyTacn05F6uW0dOhFA1ct41jqk14kUlGqXraiGFtsmq7wT4J3CDg64TRULIE9mJS/iNy3OqK8/hnb2+8zIyDRTZREuha8/Xw01j66V/bRmwGMo2yJMNccnu/J7BYhKEkMVkiMirzeY9zlsFELtA/bAaGckF8gqD/AsrG3dLgNUuZnK1KousEtO95VfkeF8mvkOMVQJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKzfvEyoQivPmWaSxM7+Za14b0lSX5ghR9kEEatplRI=;
 b=oGCJkcmBalLtxa4IZLKgj7jdMSv64fgHf9LNABbbXcV3VNM7ZJcBGNjcmzfaB+W2V0GuFH/aOrRK/zlaO8oIKABTHuDBQWco2XJSp/8zNj6dpOdGYJqXkYbTBn/svRftShFeCY+TxY5soGDW2N7FF+2Eu8jYZNkYGtM4/5aNxD+i+80fAlDktQrch/8phn41MZmbDyQD8KeDgzC4saSoQwNZgQkYux74Q/JlLuKtlukVvtCsGLjvKE8sDSuy8hnoB+dCzvZK87TaOQ00CrkTLG/fLXxSYFipdho/5zR4ixSQS8r4iS1v6kyr3jcdFymdfCpM+JPfW/wbhOEEnN2qxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=cray.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKzfvEyoQivPmWaSxM7+Za14b0lSX5ghR9kEEatplRI=;
 b=hXw/5uoqx60r93El6Pr3aMr6q92VXSAgfdQmtAwPMH6eSNabSfcMpJjMgYzqqGF72xwbp6Xx7erjCwdRcD6FR6ROQZYFsaHIr0rGZkvWdc5GADTPax2576KVztQj8CgPrJk1a/BTDFjRqnq463C5+JQ6jpJ2DbTGxHxjOFxJGg4=
Received: from CH2PR12CA0005.namprd12.prod.outlook.com (2603:10b6:610:57::15)
 by MWHPR12MB1279.namprd12.prod.outlook.com (2603:10b6:300:d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.16; Thu, 29 Aug
 2019 06:05:54 +0000
Received: from CO1NAM03FT045.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::200) by CH2PR12CA0005.outlook.office365.com
 (2603:10b6:610:57::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.18 via Frontend
 Transport; Thu, 29 Aug 2019 06:05:54 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; cray.com; dkim=none (message not signed)
 header.d=none;cray.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 CO1NAM03FT045.mail.protection.outlook.com (10.152.81.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2220.16 via Frontend Transport; Thu, 29 Aug 2019 06:05:53 +0000
Received: from kho-5039A.amd.com (10.180.168.240) by SATLEXCHOV01.amd.com
 (10.181.40.71) with Microsoft SMTP Server id 14.3.389.1; Thu, 29 Aug 2019
 01:05:48 -0500
From:   Kenny Ho <Kenny.Ho@amd.com>
To:     <y2kenny@gmail.com>, <cgroups@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <tj@kernel.org>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <felix.kuehling@amd.com>,
        <joseph.greathouse@amd.com>, <jsparks@cray.com>,
        <lkaplan@cray.com>, <daniel@ffwll.ch>
CC:     Kenny Ho <Kenny.Ho@amd.com>
Subject: [PATCH RFC v4 09/16] drm, cgroup: Add TTM buffer allocation stats
Date:   Thu, 29 Aug 2019 02:05:26 -0400
Message-ID: <20190829060533.32315-10-Kenny.Ho@amd.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829060533.32315-1-Kenny.Ho@amd.com>
References: <20190829060533.32315-1-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(136003)(376002)(396003)(2980300002)(428003)(199004)(189003)(30864003)(47776003)(336012)(110136005)(5660300002)(81156014)(81166006)(86362001)(8676002)(53936002)(2870700001)(426003)(1076003)(486006)(70586007)(70206006)(2616005)(2201001)(446003)(476003)(126002)(7696005)(51416003)(11346002)(50466002)(48376002)(14444005)(186003)(4326008)(316002)(53416004)(36756003)(2906002)(76176011)(8936002)(356004)(6666004)(305945005)(26005)(478600001)(50226002)(921003)(83996005)(2101003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1279;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b57e034-e76f-459b-ef0c-08d72c46f3ac
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328);SRVR:MWHPR12MB1279;
X-MS-TrafficTypeDiagnostic: MWHPR12MB1279:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1279A3E64E24E1D3C56C662083A20@MWHPR12MB1279.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-Forefront-PRVS: 0144B30E41
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ifLbnhZkj4CSISBRhk0Yho88KRt/p+YH3igEmblrvppJVf4KTH6dIGGtZxjRxZuN0SzU8UB+eh6g1a2X5G3uFnFz72DajykEwOyqaL3VVfoGduBQ7Sgz6YDKPAZE2qf+uYyzBKk8k083UIXlFxJXByVN7NOWUPEoh58dUJD/AuxgS5zL9dHdl7Dstbve8+LlKVmBNv9od9Qdg/6j2SmUEezk8KbdqdCcEA+7FcKwF2uowC/fS9uSrxfoXc5gGvAW8XmcWUT7g+X5TAExPoZvSA5ITfWXELD3xZo7e71df4tw2pXaHXOBTisg49ZfA3i1z3B4HnXwXuNNLzJojSpFijmTfp0PSgqEuaHwF0sYCEb3KC8kgq9tObSwS4ReNR2QWRe2UKM7NDUCgxqGkMuRqFqjR8TbOb3+1Ne1YlVI30Q=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2019 06:05:53.9313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b57e034-e76f-459b-ef0c-08d72c46f3ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1279
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
 include/drm/drm_cgroup.h                |  19 +++++
 include/drm/ttm/ttm_bo_api.h            |   2 +
 include/drm/ttm/ttm_bo_driver.h         |   8 ++
 include/linux/cgroup_drm.h              |   6 ++
 kernel/cgroup/drm.c                     | 108 ++++++++++++++++++++++++
 8 files changed, 179 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index cfcbbdc39656..463e015e8694 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1720,8 +1720,9 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
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
index 58c403eda04e..a0e9ce46baf3 100644
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
+		drmcg_unchg_mem(bo);
+	drmcg_put(bo->drmcg);
+
 	BUG_ON(kref_read(&bo->list_kref));
 	BUG_ON(kref_read(&bo->kref));
 	BUG_ON(atomic_read(&bo->cpu_writers));
@@ -360,6 +366,8 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_object *bo,
 		if (bo->mem.mem_type == TTM_PL_SYSTEM) {
 			if (bdev->driver->move_notify)
 				bdev->driver->move_notify(bo, evict, mem);
+			if (bo->bdev->ddev != NULL) // TODO: remove after ddev initiazlied for all
+				drmcg_mem_track_move(bo, evict, mem);
 			bo->mem = *mem;
 			mem->mm_node = NULL;
 			goto moved;
@@ -368,6 +376,8 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_object *bo,
 
 	if (bdev->driver->move_notify)
 		bdev->driver->move_notify(bo, evict, mem);
+	if (bo->bdev->ddev != NULL) // TODO: remove after ddev initiazlied for all
+		drmcg_mem_track_move(bo, evict, mem);
 
 	if (!(old_man->flags & TTM_MEMTYPE_FLAG_FIXED) &&
 	    !(new_man->flags & TTM_MEMTYPE_FLAG_FIXED))
@@ -381,6 +391,8 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_object *bo,
 		if (bdev->driver->move_notify) {
 			swap(*mem, bo->mem);
 			bdev->driver->move_notify(bo, false, mem);
+			if (bo->bdev->ddev != NULL) // TODO: remove after ddev initiazlied for all
+				drmcg_mem_track_move(bo, evict, mem);
 			swap(*mem, bo->mem);
 		}
 
@@ -1355,6 +1367,10 @@ int ttm_bo_init_reserved(struct ttm_bo_device *bdev,
 		WARN_ON(!locked);
 	}
 
+	bo->drmcg = drmcg_get(current);
+	if (bo->bdev->ddev != NULL) // TODO: remove after ddev initiazlied for all
+		drmcg_chg_mem(bo);
+
 	if (likely(!ret))
 		ret = ttm_bo_validate(bo, placement, ctx);
 
@@ -1747,6 +1763,20 @@ int ttm_bo_device_init(struct ttm_bo_device *bdev,
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
index 895d77d799e4..15acd2c0720e 100644
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
+		drmcg_chg_mem(bo);
+
 	*new_obj = &fbo->base;
 	return 0;
 }
diff --git a/include/drm/drm_cgroup.h b/include/drm/drm_cgroup.h
index d61b90beded5..7d63f73a5375 100644
--- a/include/drm/drm_cgroup.h
+++ b/include/drm/drm_cgroup.h
@@ -5,6 +5,7 @@
 #define __DRM_CGROUP_H__
 
 #include <linux/cgroup_drm.h>
+#include <drm/ttm/ttm_bo_api.h>
 
 /**
  * Per DRM device properties for DRM cgroup controller for the purpose
@@ -25,6 +26,11 @@ bool drmcg_try_chg_bo_alloc(struct drmcg *drmcg, struct drm_device *dev,
 		size_t size);
 void drmcg_unchg_bo_alloc(struct drmcg *drmcg, struct drm_device *dev,
 		size_t size);
+void drmcg_chg_mem(struct ttm_buffer_object *tbo);
+void drmcg_unchg_mem(struct ttm_buffer_object *tbo);
+void drmcg_mem_track_move(struct ttm_buffer_object *old_bo, bool evict,
+		struct ttm_mem_reg *new_mem);
+
 #else
 static inline void drmcg_device_update(struct drm_device *device)
 {
@@ -43,5 +49,18 @@ static inline void drmcg_unchg_bo_alloc(struct drmcg *drmcg,
 		struct drm_device *dev,	size_t size)
 {
 }
+
+static inline void drmcg_chg_mem(struct ttm_buffer_object *tbo)
+{
+}
+
+static inline void drmcg_unchg_mem(struct ttm_buffer_object *tbo)
+{
+}
+
+static inline void drmcg_mem_track_move(struct ttm_buffer_object *old_bo,
+		bool evict, struct ttm_mem_reg *new_mem)
+{
+}
 #endif /* CONFIG_CGROUP_DRM */
 #endif /* __DRM_CGROUP_H__ */
diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/ttm_bo_api.h
index 49d9cdfc58f2..839936ab358c 100644
--- a/include/drm/ttm/ttm_bo_api.h
+++ b/include/drm/ttm/ttm_bo_api.h
@@ -128,6 +128,7 @@ struct ttm_tt;
  * struct ttm_buffer_object
  *
  * @bdev: Pointer to the buffer object device structure.
+ * @drmcg: DRM cgroup this object belongs to.
  * @type: The bo type.
  * @destroy: Destruction function. If NULL, kfree is used.
  * @num_pages: Actual number of pages.
@@ -174,6 +175,7 @@ struct ttm_buffer_object {
 	 */
 
 	struct ttm_bo_device *bdev;
+	struct drmcg *drmcg;
 	enum ttm_bo_type type;
 	void (*destroy) (struct ttm_buffer_object *);
 	unsigned long num_pages;
diff --git a/include/drm/ttm/ttm_bo_driver.h b/include/drm/ttm/ttm_bo_driver.h
index c9b8ba492f24..e1a805d65b83 100644
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
index 87a2566c9fdd..4c2794c9333d 100644
--- a/include/linux/cgroup_drm.h
+++ b/include/linux/cgroup_drm.h
@@ -9,6 +9,7 @@
 #include <linux/mutex.h>
 #include <linux/cgroup.h>
 #include <drm/drm_file.h>
+#include <drm/ttm/ttm_placement.h>
 
 /* limit defined per the way drm_minor_alloc operates */
 #define MAX_DRM_DEV (64 * DRM_MINOR_RENDER)
@@ -17,6 +18,8 @@ enum drmcg_res_type {
 	DRMCG_TYPE_BO_TOTAL,
 	DRMCG_TYPE_BO_PEAK,
 	DRMCG_TYPE_BO_COUNT,
+	DRMCG_TYPE_MEM,
+	DRMCG_TYPE_MEM_EVICT,
 	__DRMCG_TYPE_LAST,
 };
 
@@ -32,6 +35,9 @@ struct drmcg_device_resource {
 	s64			bo_limits_peak_allocated;
 
 	s64			bo_stats_count_allocated;
+
+	s64			mem_stats[TTM_PL_PRIV+1];
+	s64			mem_stats_evict;
 };
 
 /**
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
index 2f54bff291e5..4960a8d1e8f4 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -10,6 +10,8 @@
 #include <linux/kernel.h>
 #include <drm/drm_file.h>
 #include <drm/drm_drv.h>
+#include <drm/ttm/ttm_bo_api.h>
+#include <drm/ttm/ttm_bo_driver.h>
 #include <drm/drm_device.h>
 #include <drm/drm_ioctl.h>
 #include <drm/drm_cgroup.h>
@@ -31,6 +33,13 @@ enum drmcg_file_type {
 	DRMCG_FTYPE_DEFAULT,
 };
 
+static char const *ttm_placement_names[] = {
+	[TTM_PL_SYSTEM] = "system",
+	[TTM_PL_TT]     = "tt",
+	[TTM_PL_VRAM]   = "vram",
+	[TTM_PL_PRIV]   = "priv",
+};
+
 static struct drmcg *root_drmcg __read_mostly;
 
 static int drmcg_css_free_fn(int id, void *ptr, void *data)
@@ -127,6 +136,7 @@ drmcg_css_alloc(struct cgroup_subsys_state *parent_css)
 static void drmcg_print_stats(struct drmcg_device_resource *ddr,
 		struct seq_file *sf, enum drmcg_res_type type)
 {
+	int i;
 	if (ddr == NULL) {
 		seq_puts(sf, "\n");
 		return;
@@ -142,6 +152,16 @@ static void drmcg_print_stats(struct drmcg_device_resource *ddr,
 	case DRMCG_TYPE_BO_COUNT:
 		seq_printf(sf, "%lld\n", ddr->bo_stats_count_allocated);
 		break;
+	case DRMCG_TYPE_MEM:
+		for (i = 0; i <= TTM_PL_PRIV; i++) {
+			seq_printf(sf, "%s=%lld ", ttm_placement_names[i],
+					ddr->mem_stats[i]);
+		}
+		seq_puts(sf, "\n");
+		break;
+	case DRMCG_TYPE_MEM_EVICT:
+		seq_printf(sf, "%lld\n", ddr->mem_stats_evict);
+		break;
 	default:
 		seq_puts(sf, "\n");
 		break;
@@ -411,6 +431,18 @@ struct cftype files[] = {
 		.private = DRMCG_CTF_PRIV(DRMCG_TYPE_BO_COUNT,
 						DRMCG_FTYPE_STATS),
 	},
+	{
+		.name = "memory.stats",
+		.seq_show = drmcg_seq_show,
+		.private = DRMCG_CTF_PRIV(DRMCG_TYPE_MEM,
+						DRMCG_FTYPE_STATS),
+	},
+	{
+		.name = "memory.evict.stats",
+		.seq_show = drmcg_seq_show,
+		.private = DRMCG_CTF_PRIV(DRMCG_TYPE_MEM_EVICT,
+						DRMCG_FTYPE_STATS),
+	},
 	{ }	/* terminate */
 };
 
@@ -566,3 +598,79 @@ void drmcg_unchg_bo_alloc(struct drmcg *drmcg, struct drm_device *dev,
 	mutex_unlock(&dev->drmcg_mutex);
 }
 EXPORT_SYMBOL(drmcg_unchg_bo_alloc);
+
+void drmcg_chg_mem(struct ttm_buffer_object *tbo)
+{
+	struct drm_device *dev = tbo->bdev->ddev;
+	struct drmcg *drmcg = tbo->drmcg;
+	int devIdx = dev->primary->index;
+	s64 size = (s64)(tbo->mem.size);
+	int mem_type = tbo->mem.mem_type;
+	struct drmcg_device_resource *ddr;
+
+	if (drmcg == NULL)
+		return;
+
+	mem_type = mem_type > TTM_PL_PRIV ? TTM_PL_PRIV : mem_type;
+
+	mutex_lock(&dev->drmcg_mutex);
+	for ( ; drmcg != NULL; drmcg = drmcg_parent(drmcg)) {
+		ddr = drmcg->dev_resources[devIdx];
+		ddr->mem_stats[mem_type] += size;
+	}
+	mutex_unlock(&dev->drmcg_mutex);
+}
+EXPORT_SYMBOL(drmcg_chg_mem);
+
+void drmcg_unchg_mem(struct ttm_buffer_object *tbo)
+{
+	struct drm_device *dev = tbo->bdev->ddev;
+	struct drmcg *drmcg = tbo->drmcg;
+	int devIdx = dev->primary->index;
+	s64 size = (s64)(tbo->mem.size);
+	int mem_type = tbo->mem.mem_type;
+	struct drmcg_device_resource *ddr;
+
+	if (drmcg == NULL)
+		return;
+
+	mem_type = mem_type > TTM_PL_PRIV ? TTM_PL_PRIV : mem_type;
+
+	mutex_lock(&dev->drmcg_mutex);
+	for ( ; drmcg != NULL; drmcg = drmcg_parent(drmcg)) {
+		ddr = drmcg->dev_resources[devIdx];
+		ddr->mem_stats[mem_type] -= size;
+	}
+	mutex_unlock(&dev->drmcg_mutex);
+}
+EXPORT_SYMBOL(drmcg_unchg_mem);
+
+void drmcg_mem_track_move(struct ttm_buffer_object *old_bo, bool evict,
+		struct ttm_mem_reg *new_mem)
+{
+	struct drm_device *dev = old_bo->bdev->ddev;
+	struct drmcg *drmcg = old_bo->drmcg;
+	s64 move_in_bytes = (s64)(old_bo->mem.size);
+	int devIdx = dev->primary->index;
+	int old_mem_type = old_bo->mem.mem_type;
+	int new_mem_type = new_mem->mem_type;
+	struct drmcg_device_resource *ddr;
+
+	if (drmcg == NULL)
+		return;
+
+	old_mem_type = old_mem_type > TTM_PL_PRIV ? TTM_PL_PRIV : old_mem_type;
+	new_mem_type = new_mem_type > TTM_PL_PRIV ? TTM_PL_PRIV : new_mem_type;
+
+	mutex_lock(&dev->drmcg_mutex);
+	for ( ; drmcg != NULL; drmcg = drmcg_parent(drmcg)) {
+		ddr = drmcg->dev_resources[devIdx];
+		ddr->mem_stats[old_mem_type] -= move_in_bytes;
+		ddr->mem_stats[new_mem_type] += move_in_bytes;
+
+		if (evict)
+			ddr->mem_stats_evict++;
+	}
+	mutex_unlock(&dev->drmcg_mutex);
+}
+EXPORT_SYMBOL(drmcg_mem_track_move);
-- 
2.22.0


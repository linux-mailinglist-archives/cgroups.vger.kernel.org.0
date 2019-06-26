Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C31956D36
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2019 17:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbfFZPFr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jun 2019 11:05:47 -0400
Received: from mail-eopbgr800085.outbound.protection.outlook.com ([40.107.80.85]:38432
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728048AbfFZPFr (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 26 Jun 2019 11:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPdJwmAonW3a1g9HlpEnwq04DKEXm+oNCf0zke7Z7V4=;
 b=hebrl0QzOfRnTlWa/nhikfzTf0Q8cu6RvZXBVnLUkdsCtE7nQrboN4mBpS5FKiNyG7+4Oh1lC9tSXi+Mb/LH/6vsQa3FlQsBPYHeoBg/2LGzwySeF48WK2iU8DPSeIgzm834RZpl0tI7forOKIs8LgieruyRng/MkCBOLlKiZ9M=
Received: from MWHPR12CA0058.namprd12.prod.outlook.com (2603:10b6:300:103::20)
 by MWHPR1201MB0031.namprd12.prod.outlook.com (2603:10b6:301:57::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16; Wed, 26 Jun
 2019 15:05:43 +0000
Received: from DM3NAM03FT041.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::209) by MWHPR12CA0058.outlook.office365.com
 (2603:10b6:300:103::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2008.16 via Frontend
 Transport; Wed, 26 Jun 2019 15:05:43 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV02.amd.com (165.204.84.17) by
 DM3NAM03FT041.mail.protection.outlook.com (10.152.83.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2032.15 via Frontend Transport; Wed, 26 Jun 2019 15:05:43 +0000
Received: from kho-5039A.amd.com (10.180.168.240) by SATLEXCHOV02.amd.com
 (10.181.40.72) with Microsoft SMTP Server id 14.3.389.1; Wed, 26 Jun 2019
 10:05:35 -0500
From:   Kenny Ho <Kenny.Ho@amd.com>
To:     <y2kenny@gmail.com>, <cgroups@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <tj@kernel.org>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <joseph.greathouse@amd.com>,
        <jsparks@cray.com>, <lkaplan@cray.com>
CC:     Kenny Ho <Kenny.Ho@amd.com>
Subject: [RFC PATCH v3 11/11] drm, cgroup: Allow more aggressive memory reclaim
Date:   Wed, 26 Jun 2019 11:05:22 -0400
Message-ID: <20190626150522.11618-12-Kenny.Ho@amd.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626150522.11618-1-Kenny.Ho@amd.com>
References: <20190626150522.11618-1-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(136003)(376002)(2980300002)(428003)(199004)(189003)(51416003)(76176011)(4326008)(77096007)(26005)(7696005)(6666004)(305945005)(356004)(70206006)(70586007)(2201001)(5660300002)(316002)(36756003)(110136005)(86362001)(14444005)(8676002)(8936002)(81156014)(81166006)(53416004)(50226002)(2870700001)(53936002)(476003)(486006)(68736007)(50466002)(478600001)(48376002)(2906002)(72206003)(1076003)(11346002)(186003)(47776003)(446003)(426003)(336012)(2616005)(126002)(921003)(83996005)(1121003)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB0031;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbefd543-283b-42f1-4815-08d6fa47c2ab
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:MWHPR1201MB0031;
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0031:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB00313889CC856FF40C44BA0683E20@MWHPR1201MB0031.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 00808B16F3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 0kuf7AhBCipjPdrqM/uCajaxKOQDlW8M2AA/1yKGyHW/iLEE9qc/Svq8qynkCVqhib2RAOYA47A5Dzl+ElhyAuntRi/fDi/4H43XvfzcrvjnkMdENpryP4dmEA4FyfT/AVdNeMpGcnHiY0UIveFMO6INAsWKPkX+NmTBGZF8pFoFwOmSG35bpR8rOPZBdDyVZ/wmmyb9hiXTW9pZ8jgQQNH+sqTYM7vdOhDy9wOt8oGwVvdg4Gd2iUrSjB8aiPKlumRrGFwzag0L9WGRGf2xMDl3VjXzNyHr03cPzbfZjBIcDaguShpItLmFGhQYoq7yloZVntgssTGdxX/zvqMREeLp6b+DHr+FSw1TV6wPE8oyXa5UAn7rdB5f+VHoOx+EmpXyC3uWeCdKlT5QtYDAdaqJQa0QxG1tWv2pRSO3hhQ=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2019 15:05:43.0257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbefd543-283b-42f1-4815-08d6fa47c2ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0031
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Allow DRM TTM memory manager to register a work_struct, such that, when
a drmcgrp is under memory pressure, memory reclaiming can be triggered
immediately.

Change-Id: I25ac04e2db9c19ff12652b88ebff18b44b2706d8
Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c    | 47 +++++++++++++++++++++++++++++++++
 include/drm/drm_cgroup.h        | 14 ++++++++++
 include/drm/ttm/ttm_bo_driver.h |  2 ++
 kernel/cgroup/drm.c             | 33 +++++++++++++++++++++++
 4 files changed, 96 insertions(+)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 79c530f4a198..5fc3bc5bd4c5 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -1509,6 +1509,44 @@ int ttm_bo_evict_mm(struct ttm_bo_device *bdev, unsigned mem_type)
 }
 EXPORT_SYMBOL(ttm_bo_evict_mm);
 
+static void ttm_bo_reclaim_wq(struct work_struct *work)
+{
+	struct ttm_operation_ctx ctx = {
+		.interruptible = false,
+		.no_wait_gpu = false,
+		.flags = TTM_OPT_FLAG_FORCE_ALLOC
+	};
+	struct ttm_mem_type_manager *man =
+	    container_of(work, struct ttm_mem_type_manager, reclaim_wq);
+	struct ttm_bo_device *bdev = man->bdev;
+	struct dma_fence *fence;
+	int mem_type;
+	int ret;
+
+	for (mem_type = 0; mem_type < TTM_NUM_MEM_TYPES; mem_type++)
+		if (&bdev->man[mem_type] == man)
+			break;
+
+	BUG_ON(mem_type >= TTM_NUM_MEM_TYPES);
+
+	if (!drmcgrp_mem_pressure_scan(bdev, mem_type))
+		return;
+
+	ret = ttm_mem_evict_first(bdev, mem_type, NULL, &ctx);
+	if (ret)
+		return;
+
+	spin_lock(&man->move_lock);
+	fence = dma_fence_get(man->move);
+	spin_unlock(&man->move_lock);
+
+	if (fence) {
+		ret = dma_fence_wait(fence, false);
+		dma_fence_put(fence);
+	}
+
+}
+
 int ttm_bo_init_mm(struct ttm_bo_device *bdev, unsigned type,
 			unsigned long p_size)
 {
@@ -1543,6 +1581,13 @@ int ttm_bo_init_mm(struct ttm_bo_device *bdev, unsigned type,
 		INIT_LIST_HEAD(&man->lru[i]);
 	man->move = NULL;
 
+	pr_err("drmcgrp %p type %d\n", bdev->ddev, type);
+
+	if (type <= TTM_PL_VRAM) {
+		INIT_WORK(&man->reclaim_wq, ttm_bo_reclaim_wq);
+		drmcgrp_register_device_mm(bdev->ddev, type, &man->reclaim_wq);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL(ttm_bo_init_mm);
@@ -1620,6 +1665,8 @@ int ttm_bo_device_release(struct ttm_bo_device *bdev)
 		man = &bdev->man[i];
 		if (man->has_type) {
 			man->use_type = false;
+			drmcgrp_unregister_device_mm(bdev->ddev, i);
+			cancel_work_sync(&man->reclaim_wq);
 			if ((i != TTM_PL_SYSTEM) && ttm_bo_clean_mm(bdev, i)) {
 				ret = -EBUSY;
 				pr_err("DRM memory manager type %d is not clean\n",
diff --git a/include/drm/drm_cgroup.h b/include/drm/drm_cgroup.h
index 360c1e6c809f..134d6e5475f3 100644
--- a/include/drm/drm_cgroup.h
+++ b/include/drm/drm_cgroup.h
@@ -5,6 +5,7 @@
 #define __DRM_CGROUP_H__
 
 #include <linux/cgroup_drm.h>
+#include <linux/workqueue.h>
 #include <drm/ttm/ttm_bo_api.h>
 #include <drm/ttm/ttm_bo_driver.h>
 
@@ -12,6 +13,9 @@
 
 int drmcgrp_register_device(struct drm_device *device);
 int drmcgrp_unregister_device(struct drm_device *device);
+void drmcgrp_register_device_mm(struct drm_device *dev, unsigned type,
+		struct work_struct *wq);
+void drmcgrp_unregister_device_mm(struct drm_device *dev, unsigned type);
 bool drmcgrp_is_self_or_ancestor(struct drmcgrp *self,
 		struct drmcgrp *relative);
 void drmcgrp_chg_bo_alloc(struct drmcgrp *drmcgrp, struct drm_device *dev,
@@ -40,6 +44,16 @@ static inline int drmcgrp_unregister_device(struct drm_device *device)
 	return 0;
 }
 
+static inline void drmcgrp_register_device_mm(struct drm_device *dev,
+		unsigned type, struct work_struct *wq)
+{
+}
+
+static inline void drmcgrp_unregister_device_mm(struct drm_device *dev,
+		unsigned type)
+{
+}
+
 static inline bool drmcgrp_is_self_or_ancestor(struct drmcgrp *self,
 		struct drmcgrp *relative)
 {
diff --git a/include/drm/ttm/ttm_bo_driver.h b/include/drm/ttm/ttm_bo_driver.h
index 4cbcb41e5aa9..0956ca7888fc 100644
--- a/include/drm/ttm/ttm_bo_driver.h
+++ b/include/drm/ttm/ttm_bo_driver.h
@@ -205,6 +205,8 @@ struct ttm_mem_type_manager {
 	 * Protected by @move_lock.
 	 */
 	struct dma_fence *move;
+
+	struct work_struct reclaim_wq;
 };
 
 /**
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
index 1ce13db36ce9..985a89e849d3 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -31,6 +31,8 @@ struct drmcgrp_device {
 	s64			mem_bw_avg_bytes_per_us_default;
 
 	s64			mem_highs_default[TTM_PL_PRIV+1];
+
+	struct work_struct	*mem_reclaim_wq[TTM_PL_PRIV];
 };
 
 #define DRMCG_CTF_PRIV_SIZE 3
@@ -793,6 +795,31 @@ int drmcgrp_unregister_device(struct drm_device *dev)
 }
 EXPORT_SYMBOL(drmcgrp_unregister_device);
 
+void drmcgrp_register_device_mm(struct drm_device *dev, unsigned type,
+		struct work_struct *wq)
+{
+	if (dev == NULL || dev->primary->index > max_minor
+			|| type >= TTM_PL_PRIV)
+		return;
+
+	mutex_lock(&drmcgrp_mutex);
+	known_drmcgrp_devs[dev->primary->index]->mem_reclaim_wq[type] = wq;
+	mutex_unlock(&drmcgrp_mutex);
+}
+EXPORT_SYMBOL(drmcgrp_register_device_mm);
+
+void drmcgrp_unregister_device_mm(struct drm_device *dev, unsigned type)
+{
+	if (dev == NULL || dev->primary->index > max_minor
+			|| type >= TTM_PL_PRIV)
+		return;
+
+	mutex_lock(&drmcgrp_mutex);
+	known_drmcgrp_devs[dev->primary->index]->mem_reclaim_wq[type] = NULL;
+	mutex_unlock(&drmcgrp_mutex);
+}
+EXPORT_SYMBOL(drmcgrp_unregister_device_mm);
+
 bool drmcgrp_is_self_or_ancestor(struct drmcgrp *self, struct drmcgrp *relative)
 {
 	for (; self != NULL; self = parent_drmcgrp(self))
@@ -1004,6 +1031,12 @@ void drmcgrp_mem_track_move(struct ttm_buffer_object *old_bo, bool evict,
 
 		ddr->mem_bw_stats[DRMCGRP_MEM_BW_ATTR_BYTE_CREDIT]
 			-= move_in_bytes;
+
+		if (known_dev->mem_reclaim_wq[new_mem_type] != NULL &&
+                        ddr->mem_stats[new_mem_type] >
+				ddr->mem_highs[new_mem_type])
+			schedule_work(
+				known_dev->mem_reclaim_wq[new_mem_type]);
 	}
 	mutex_unlock(&known_dev->mutex);
 }
-- 
2.21.0


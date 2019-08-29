Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1DDDA1168
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2019 08:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfH2GGC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Aug 2019 02:06:02 -0400
Received: from mail-eopbgr690055.outbound.protection.outlook.com ([40.107.69.55]:5442
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727454AbfH2GGC (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 29 Aug 2019 02:06:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GcJrligq6rLBD9DhQb607bxS8BZ+WpVnfcu/aSsV/8JSlnd65l+wWwqhC5hHDxnHAFMfAhwBwa+8qyY/6yCIdzIrRd90bvFPDaESe7ycAITDjfBFi0Nr+xNYFRYwOmgABGS3i35/An/uV9WPLEokwiuL9qjz9pXaI72PDPWwGaGqiZ8pFku+s9DYXRhpo3Q35XQmvgZjuNBgZlsK79pg1tulPkNWmMBFv+e2GwZNPax3HiVmWMo3XKC/KIbJF4Nn16JYqHNmfJIlyjiZvKsiR1xORcmwf1PHoGR5XKxDF9mILBr/e64X1ie6krCZhvC0Jynm7OEJckNgQ/4326h0ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IO2xv2gzU6vk63jLoZO3k7qrATQypyFZjz78wXseTdE=;
 b=KwB//Y+MSz3TDttwTca87m7OVSlsBcXYVHa1xERo8ipW7rBZss8WEHPHvB1EfjIrLbUVD8KCoMx1x/W5Xqcw0gMp49SAVh6Ekeiwh4yfDaSyYTYxBhchG98eJT0EzxKyP/HqlmMVaJehJK2cdPCuNm4vd1NknRCKptiNp8ZbmZ7S1gQUajrEgN72c71Tzq2UpazigA9QUUDzzP+6NmVmP35A6heheFIyJQi9TeTYkKIXszsiEI07doCAmZm0ckRk6WwxgZgNJU91I+6Rtvip1uOjOQ+PHRZtZWLw+mrnD4GT1tj1xiOvNTDazSpuyBCUGLiWw0BRc0WFQQkZrBrIOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=cray.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IO2xv2gzU6vk63jLoZO3k7qrATQypyFZjz78wXseTdE=;
 b=Ns2AhLarkMuARJWOnQKmvok/CxPEYyqYr078vD7aoK0qCyVG0N00VKwxkaYAYgkxhO8/Huu1/R1hROC4fKZYWLGJ3+IuZ1UckC4lb1jXDKyO24y5HIX/PORk6WYYWAd1bBd8X9MPTJlOsv/CRc7aDNkfTGOQfjBhPGisXii6New=
Received: from CH2PR12CA0011.namprd12.prod.outlook.com (2603:10b6:610:57::21)
 by BYAPR12MB2712.namprd12.prod.outlook.com (2603:10b6:a03:68::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.21; Thu, 29 Aug
 2019 06:06:00 +0000
Received: from CO1NAM03FT045.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::208) by CH2PR12CA0011.outlook.office365.com
 (2603:10b6:610:57::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.18 via Frontend
 Transport; Thu, 29 Aug 2019 06:05:59 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; cray.com; dkim=none (message not signed)
 header.d=none;cray.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 CO1NAM03FT045.mail.protection.outlook.com (10.152.81.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2220.16 via Frontend Transport; Thu, 29 Aug 2019 06:05:59 +0000
Received: from kho-5039A.amd.com (10.180.168.240) by SATLEXCHOV01.amd.com
 (10.181.40.71) with Microsoft SMTP Server id 14.3.389.1; Thu, 29 Aug 2019
 01:05:51 -0500
From:   Kenny Ho <Kenny.Ho@amd.com>
To:     <y2kenny@gmail.com>, <cgroups@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <tj@kernel.org>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <felix.kuehling@amd.com>,
        <joseph.greathouse@amd.com>, <jsparks@cray.com>,
        <lkaplan@cray.com>, <daniel@ffwll.ch>
CC:     Kenny Ho <Kenny.Ho@amd.com>
Subject: [PATCH RFC v4 13/16] drm, cgroup: Allow more aggressive memory reclaim
Date:   Thu, 29 Aug 2019 02:05:30 -0400
Message-ID: <20190829060533.32315-14-Kenny.Ho@amd.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829060533.32315-1-Kenny.Ho@amd.com>
References: <20190829060533.32315-1-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(396003)(346002)(39860400002)(2980300002)(428003)(189003)(199004)(126002)(2906002)(476003)(446003)(11346002)(2616005)(486006)(478600001)(305945005)(426003)(50466002)(336012)(8936002)(48376002)(70206006)(2870700001)(50226002)(81166006)(81156014)(186003)(26005)(8676002)(14444005)(53936002)(70586007)(2201001)(316002)(110136005)(4326008)(1076003)(86362001)(47776003)(76176011)(5660300002)(7696005)(51416003)(6666004)(356004)(53416004)(36756003)(921003)(1121003)(83996005)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2712;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95fa5cc6-0246-4803-3b6c-08d72c46f6ca
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328);SRVR:BYAPR12MB2712;
X-MS-TrafficTypeDiagnostic: BYAPR12MB2712:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2712B6D6D7894FCA0BB9049883A20@BYAPR12MB2712.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0144B30E41
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: /WRCUPaJn2Euda3fBQ5PWoBQHYjdmfZilm2hwrout1B6ENedVwUZpKNt5PkY/30ZecbD+jJ+qFf/pmll9OfH/UfCAcW4K5psWizKs91tX+Hrn55iWa8ROoyqcMS8aqlw2nH+XizWpkVgfizwZ8HZ3CoxDZXxvlzl7z97sJeAbdzJcnHBkcKsxGlBotWSwxyfrvX4o3r3IceJHHCY3QvvMt5h0ZKW7Au5Qq1ltVN7awyqNB/HwNI+uAFmJaGPX9XYtCWNWINPK0nEcYWXARFTx/ahmH5aIxCXs6ZGm23GtfWbCHKwg1gJBmAUQLN/JjwSrRHZzKOrSQ/JvvifpR+Hf4tY37b/aGIV7ReOLpIjOgdprQEHhq9OszSSlvkkaYzq4M29rikBh+pD0C6s4XMNSkJf7vG5+ernlLvJOOIZm1w=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2019 06:05:59.1572
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95fa5cc6-0246-4803-3b6c-08d72c46f6ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2712
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
 drivers/gpu/drm/ttm/ttm_bo.c    | 49 +++++++++++++++++++++++++++++++++
 include/drm/drm_cgroup.h        | 16 +++++++++++
 include/drm/ttm/ttm_bo_driver.h |  2 ++
 kernel/cgroup/drm.c             | 30 ++++++++++++++++++++
 4 files changed, 97 insertions(+)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index d7e3d3128ebb..72efae694b7e 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -1590,6 +1590,46 @@ int ttm_bo_evict_mm(struct ttm_bo_device *bdev, unsigned mem_type)
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
+	WARN_ON(mem_type >= TTM_NUM_MEM_TYPES);
+	if (mem_type >= TTM_NUM_MEM_TYPES)
+		return;
+
+	if (!drmcg_mem_pressure_scan(bdev, mem_type))
+		return;
+
+	ret = ttm_mem_evict_first(bdev, mem_type, NULL, &ctx, NULL);
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
@@ -1624,6 +1664,13 @@ int ttm_bo_init_mm(struct ttm_bo_device *bdev, unsigned type,
 		INIT_LIST_HEAD(&man->lru[i]);
 	man->move = NULL;
 
+	pr_err("drmcg %p type %d\n", bdev->ddev, type);
+
+	if (type <= TTM_PL_VRAM) {
+		INIT_WORK(&man->reclaim_wq, ttm_bo_reclaim_wq);
+		drmcg_register_device_mm(bdev->ddev, type, &man->reclaim_wq);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL(ttm_bo_init_mm);
@@ -1701,6 +1748,8 @@ int ttm_bo_device_release(struct ttm_bo_device *bdev)
 		man = &bdev->man[i];
 		if (man->has_type) {
 			man->use_type = false;
+			drmcg_unregister_device_mm(bdev->ddev, i);
+			cancel_work_sync(&man->reclaim_wq);
 			if ((i != TTM_PL_SYSTEM) && ttm_bo_clean_mm(bdev, i)) {
 				ret = -EBUSY;
 				pr_err("DRM memory manager type %d is not clean\n",
diff --git a/include/drm/drm_cgroup.h b/include/drm/drm_cgroup.h
index c11df388fdf2..6d9707e1eb72 100644
--- a/include/drm/drm_cgroup.h
+++ b/include/drm/drm_cgroup.h
@@ -5,6 +5,7 @@
 #define __DRM_CGROUP_H__
 
 #include <linux/cgroup_drm.h>
+#include <linux/workqueue.h>
 #include <drm/ttm/ttm_bo_api.h>
 #include <drm/ttm/ttm_bo_driver.h>
 
@@ -25,12 +26,17 @@ struct drmcg_props {
 	s64			mem_bw_avg_bytes_per_us_default;
 
 	s64			mem_highs_default[TTM_PL_PRIV+1];
+
+	struct work_struct	*mem_reclaim_wq[TTM_PL_PRIV];
 };
 
 #ifdef CONFIG_CGROUP_DRM
 
 void drmcg_device_update(struct drm_device *device);
 void drmcg_device_early_init(struct drm_device *device);
+void drmcg_register_device_mm(struct drm_device *dev, unsigned int type,
+		struct work_struct *wq);
+void drmcg_unregister_device_mm(struct drm_device *dev, unsigned int type);
 bool drmcg_try_chg_bo_alloc(struct drmcg *drmcg, struct drm_device *dev,
 		size_t size);
 void drmcg_unchg_bo_alloc(struct drmcg *drmcg, struct drm_device *dev,
@@ -53,6 +59,16 @@ static inline void drmcg_device_early_init(struct drm_device *device)
 {
 }
 
+static inline void drmcg_register_device_mm(struct drm_device *dev,
+		unsigned int type, struct work_struct *wq)
+{
+}
+
+static inline void drmcg_unregister_device_mm(struct drm_device *dev,
+		unsigned int type)
+{
+}
+
 static inline void drmcg_try_chg_bo_alloc(struct drmcg *drmcg,
 		struct drm_device *dev,	size_t size)
 {
diff --git a/include/drm/ttm/ttm_bo_driver.h b/include/drm/ttm/ttm_bo_driver.h
index e1a805d65b83..529cef92bcf6 100644
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
index 04fb9a398740..0ea7f0619e25 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -804,6 +804,29 @@ void drmcg_device_early_init(struct drm_device *dev)
 }
 EXPORT_SYMBOL(drmcg_device_early_init);
 
+void drmcg_register_device_mm(struct drm_device *dev, unsigned int type,
+		struct work_struct *wq)
+{
+	if (dev == NULL || type >= TTM_PL_PRIV)
+		return;
+
+	mutex_lock(&drmcg_mutex);
+	dev->drmcg_props.mem_reclaim_wq[type] = wq;
+	mutex_unlock(&drmcg_mutex);
+}
+EXPORT_SYMBOL(drmcg_register_device_mm);
+
+void drmcg_unregister_device_mm(struct drm_device *dev, unsigned int type)
+{
+	if (dev == NULL || type >= TTM_PL_PRIV)
+		return;
+
+	mutex_lock(&drmcg_mutex);
+	dev->drmcg_props.mem_reclaim_wq[type] = NULL;
+	mutex_unlock(&drmcg_mutex);
+}
+EXPORT_SYMBOL(drmcg_unregister_device_mm);
+
 /**
  * drmcg_try_chg_bo_alloc - charge GEM buffer usage for a device and cgroup
  * @drmcg: the DRM cgroup to be charged to
@@ -1013,6 +1036,13 @@ void drmcg_mem_track_move(struct ttm_buffer_object *old_bo, bool evict,
 
 		ddr->mem_bw_stats[DRMCG_MEM_BW_ATTR_BYTE_CREDIT]
 			-= move_in_bytes;
+
+		if (dev->drmcg_props.mem_reclaim_wq[new_mem_type]
+			!= NULL &&
+			ddr->mem_stats[new_mem_type] >
+				ddr->mem_highs[new_mem_type])
+			schedule_work(dev->
+				drmcg_props.mem_reclaim_wq[new_mem_type]);
 	}
 	mutex_unlock(&dev->drmcg_mutex);
 }
-- 
2.22.0


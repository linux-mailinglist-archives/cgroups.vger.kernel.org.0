Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94CF056D3A
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2019 17:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbfFZPFt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jun 2019 11:05:49 -0400
Received: from mail-eopbgr780048.outbound.protection.outlook.com ([40.107.78.48]:6332
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727481AbfFZPFt (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 26 Jun 2019 11:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oA+woenpRbe1Zgy3xOyhHWwJ0Gxu8eSf8BMZ79JRyzE=;
 b=OF21V8WaYoat59d72PJA/eZc+0mpdXfSvaVwB6bYCzH1E0v1w6Hoaq46N/fIhzv0CKkCedAnKbjuTOW1wc89sTZf3CqZBamRC977xsZ780RgrfoJ0924JFYgLArub1XguOA8+MHbf/N5XZzO2Qh+ITWAVTUMD2kVCNJ6ymBLrcE=
Received: from MWHPR12CA0055.namprd12.prod.outlook.com (2603:10b6:300:103::17)
 by BN6PR12MB1698.namprd12.prod.outlook.com (2603:10b6:404:106::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16; Wed, 26 Jun
 2019 15:05:42 +0000
Received: from DM3NAM03FT041.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::201) by MWHPR12CA0055.outlook.office365.com
 (2603:10b6:300:103::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2008.16 via Frontend
 Transport; Wed, 26 Jun 2019 15:05:42 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV02.amd.com (165.204.84.17) by
 DM3NAM03FT041.mail.protection.outlook.com (10.152.83.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2032.15 via Frontend Transport; Wed, 26 Jun 2019 15:05:41 +0000
Received: from kho-5039A.amd.com (10.180.168.240) by SATLEXCHOV02.amd.com
 (10.181.40.72) with Microsoft SMTP Server id 14.3.389.1; Wed, 26 Jun 2019
 10:05:34 -0500
From:   Kenny Ho <Kenny.Ho@amd.com>
To:     <y2kenny@gmail.com>, <cgroups@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <tj@kernel.org>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <joseph.greathouse@amd.com>,
        <jsparks@cray.com>, <lkaplan@cray.com>
CC:     Kenny Ho <Kenny.Ho@amd.com>
Subject: [RFC PATCH v3 10/11] drm, cgroup: Add soft VRAM limit
Date:   Wed, 26 Jun 2019 11:05:21 -0400
Message-ID: <20190626150522.11618-11-Kenny.Ho@amd.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626150522.11618-1-Kenny.Ho@amd.com>
References: <20190626150522.11618-1-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(2980300002)(428003)(199004)(189003)(77096007)(26005)(81166006)(4326008)(186003)(14444005)(2870700001)(2906002)(81156014)(72206003)(8936002)(53416004)(76176011)(336012)(8676002)(5660300002)(48376002)(36756003)(50466002)(11346002)(7696005)(51416003)(305945005)(446003)(486006)(126002)(478600001)(68736007)(2616005)(50226002)(426003)(356004)(6666004)(2201001)(53936002)(70206006)(70586007)(110136005)(1076003)(47776003)(476003)(316002)(86362001)(921003)(1121003)(2101003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1698;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc379476-ba7b-453b-cff7-08d6fa47c1c4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:BN6PR12MB1698;
X-MS-TrafficTypeDiagnostic: BN6PR12MB1698:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1698314A0EF1FC484351DD1583E20@BN6PR12MB1698.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-Forefront-PRVS: 00808B16F3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: AFkfT3amTcCK0u27+u/T7mW3vek0UF5Oa+n9PI8VueRn9h562iN2cT61ZRCpFj2JqCXNOKhHBsSWDWeZaoSrpzWkiUWiuq6QtuHjppTAUZnwMnvkyTAOXiUxJC7nbCaBWnRTl2H/M6LTG863vg/DraU26IK2oj4H72Fj0DoXw9+MHcW4ZJl9/40G3meNwIw0rU+oV7e+MaJHZhfwYPOEEwzr+n1U+ODWjKnr2I3Q5e1UB8odYSpc9lL2B2YDrFoXVkfK22lYt9kzF4XctXKd2HPrmVIEx4K1y/zRyGInCkEX1t0QRnrM9bT8qmIcyfbAlzgAXLzT1tAYW+0Q4KpklThJsV0MjbmeEopZ8+MyFZy09ocnDiyo5kYXjUiV9ZJNjags4n3HOew7RmOs32ka3h8PWCvVcZT927AuKo6D4+c=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2019 15:05:41.4012
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc379476-ba7b-453b-cff7-08d6fa47c1c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1698
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The drm resource being limited is the TTM (Translation Table Manager)
buffers.  TTM manages different types of memory that a GPU might access.
These memory types include dedicated Video RAM (VRAM) and host/system
memory accessible through IOMMU (GART/GTT).  TTM is currently used by
multiple drm drivers (amd, ast, bochs, cirrus, hisilicon, maga200,
nouveau, qxl, virtio, vmwgfx.)

TTM buffers belonging to drm cgroups under memory pressure will be
selected to be evicted first.

drm.memory.high
        A read-write nested-keyed file which exists on all cgroups.
        Each entry is keyed by the drm device's major:minor.  The
        following nested keys are defined.

          ====         =============================================
          vram         Video RAM soft limit for a drm device in byte
          ====         =============================================

        Reading returns the following::

        226:0 vram=0
        226:1 vram=17768448
        226:2 vram=17768448

drm.memory.default
        A read-only nested-keyed file which exists on the root cgroup.
        Each entry is keyed by the drm device's major:minor.  The
        following nested keys are defined.

          ====         ===============================
          vram         Video RAM default limit in byte
          ====         ===============================

        Reading returns the following::

        226:0 vram=0
        226:1 vram=17768448
        226:2 vram=17768448

Change-Id: I7988e28a453b53140b40a28c176239acbc81d491
Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c |   7 ++
 include/drm/drm_cgroup.h     |  15 ++++
 include/linux/cgroup_drm.h   |   2 +
 kernel/cgroup/drm.c          | 145 +++++++++++++++++++++++++++++++++++
 4 files changed, 169 insertions(+)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index f06c2b9d8a4a..79c530f4a198 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -806,12 +806,19 @@ static int ttm_mem_evict_first(struct ttm_bo_device *bdev,
 	struct ttm_mem_type_manager *man = &bdev->man[mem_type];
 	struct ttm_buffer_object *bo = NULL;
 	bool locked = false;
+        bool check_drmcgrp;
 	unsigned i;
 	int ret;
 
+	check_drmcgrp = drmcgrp_mem_pressure_scan(bdev, mem_type);
+
 	spin_lock(&glob->lru_lock);
 	for (i = 0; i < TTM_MAX_BO_PRIORITY; ++i) {
 		list_for_each_entry(bo, &man->lru[i], lru) {
+			if (check_drmcgrp &&
+				!drmcgrp_mem_should_evict(bo, mem_type))
+				continue;
+
 			if (!ttm_bo_evict_swapout_allowable(bo, ctx, &locked))
 				continue;
 
diff --git a/include/drm/drm_cgroup.h b/include/drm/drm_cgroup.h
index 9b1dbd6a4eca..360c1e6c809f 100644
--- a/include/drm/drm_cgroup.h
+++ b/include/drm/drm_cgroup.h
@@ -6,6 +6,7 @@
 
 #include <linux/cgroup_drm.h>
 #include <drm/ttm/ttm_bo_api.h>
+#include <drm/ttm/ttm_bo_driver.h>
 
 #ifdef CONFIG_CGROUP_DRM
 
@@ -25,6 +26,8 @@ void drmcgrp_mem_track_move(struct ttm_buffer_object *old_bo, bool evict,
 		struct ttm_mem_reg *new_mem);
 unsigned int drmcgrp_get_mem_bw_period_in_us(struct ttm_buffer_object *tbo);
 bool drmcgrp_mem_can_move(struct ttm_buffer_object *tbo);
+bool drmcgrp_mem_pressure_scan(struct ttm_bo_device *bdev, unsigned type);
+bool drmcgrp_mem_should_evict(struct ttm_buffer_object *tbo, unsigned type);
 
 #else
 static inline int drmcgrp_register_device(struct drm_device *device)
@@ -82,5 +85,17 @@ static inline bool drmcgrp_mem_can_move(struct ttm_buffer_object *tbo)
 {
 	return true;
 }
+
+static inline bool drmcgrp_mem_pressure_scan(struct ttm_bo_device *bdev,
+		unsigned type)
+{
+	return false;
+}
+
+static inline bool drmcgrp_mem_should_evict(struct ttm_buffer_object *tbo,
+		unsigned type)
+{
+	return true;
+}
 #endif /* CONFIG_CGROUP_DRM */
 #endif /* __DRM_CGROUP_H__ */
diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
index 94828da2104a..52ef02eaac70 100644
--- a/include/linux/cgroup_drm.h
+++ b/include/linux/cgroup_drm.h
@@ -35,6 +35,8 @@ struct drmcgrp_device_resource {
 
 	s64			mem_stats[TTM_PL_PRIV+1];
 	s64			mem_peaks[TTM_PL_PRIV+1];
+	s64			mem_highs[TTM_PL_PRIV+1];
+	bool			mem_pressure[TTM_PL_PRIV+1];
 	s64			mem_stats_evict;
 
 	s64			mem_bw_stats_last_update_us;
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
index bbc6612200a4..1ce13db36ce9 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -29,6 +29,8 @@ struct drmcgrp_device {
 
 	s64			mem_bw_bytes_in_period_default;
 	s64			mem_bw_avg_bytes_per_us_default;
+
+	s64			mem_highs_default[TTM_PL_PRIV+1];
 };
 
 #define DRMCG_CTF_PRIV_SIZE 3
@@ -114,6 +116,8 @@ static inline int init_drmcgrp_single(struct drmcgrp *drmcgrp, int minor)
 
 	/* set defaults here */
 	if (known_drmcgrp_devs[minor] != NULL) {
+		int i;
+
 		ddr->bo_limits_total_allocated =
 		  known_drmcgrp_devs[minor]->bo_limits_total_allocated_default;
 
@@ -125,6 +129,11 @@ static inline int init_drmcgrp_single(struct drmcgrp *drmcgrp, int minor)
 
 		ddr->mem_bw_limits_avg_bytes_per_us =
 		  known_drmcgrp_devs[minor]->mem_bw_avg_bytes_per_us_default;
+
+		for (i = 0; i <= TTM_PL_PRIV; i++) {
+			ddr->mem_highs[i] =
+			known_drmcgrp_devs[minor]->mem_highs_default[i];
+		}
 	}
 
 	return 0;
@@ -274,6 +283,11 @@ static inline void drmcgrp_print_limits(struct drmcgrp_device_resource *ddr,
 	case DRMCGRP_TYPE_BO_PEAK:
 		seq_printf(sf, "%zu\n", ddr->bo_limits_peak_allocated);
 		break;
+	case DRMCGRP_TYPE_MEM:
+		seq_printf(sf, "%s=%lld\n",
+				ttm_placement_names[TTM_PL_VRAM],
+				ddr->mem_highs[TTM_PL_VRAM]);
+		break;
 	case DRMCGRP_TYPE_BANDWIDTH_PERIOD_BURST:
 		seq_printf(sf, "%lld\n",
 			known_drmcgrp_devs[minor]->mem_bw_limits_period_in_us);
@@ -308,6 +322,11 @@ static inline void drmcgrp_print_default(struct drmcgrp_device *ddev,
 		seq_printf(sf, "%zu\n",
 				ddev->bo_limits_peak_allocated_default);
 		break;
+	case DRMCGRP_TYPE_MEM:
+		seq_printf(sf, "%s=%lld\n",
+				ttm_placement_names[TTM_PL_VRAM],
+				ddev->mem_highs_default[TTM_PL_VRAM]);
+		break;
 	case DRMCGRP_TYPE_BANDWIDTH_PERIOD_BURST:
 		seq_printf(sf, "%lld\n",
 				ddev->mem_bw_limits_period_in_us_default);
@@ -552,6 +571,38 @@ ssize_t drmcgrp_bo_limit_write(struct kernfs_open_file *of, char *buf,
 				}
 			}
 			break;
+		case DRMCGRP_TYPE_MEM:
+			nested = strstrip(sattr);
+
+			while (nested != NULL) {
+				attr = strsep(&nested, " ");
+
+				if (sscanf(attr, "vram=%s",
+					 sval) == 1) {
+					p_max = parent == NULL ? S64_MAX :
+						parent->
+						dev_resources[minor]->
+						mem_highs[TTM_PL_VRAM];
+
+					rc = drmcgrp_process_limit_val(sval,
+						true,
+						ddev->
+						mem_highs_default[TTM_PL_VRAM],
+						p_max,
+						&val);
+
+					if (rc || val < 0) {
+						drmcgrp_pr_cft_err(drmcgrp,
+								cft_name,
+								minor);
+						continue;
+					}
+
+					ddr->mem_highs[TTM_PL_VRAM]=val;
+					continue;
+				}
+			}
+			break;
 		default:
 			break;
 		}
@@ -624,6 +675,20 @@ struct cftype files[] = {
 		.seq_show = drmcgrp_bo_show,
 		.private = DRMCG_CTF_PRIV(DRMCGRP_TYPE_MEM_PEAK,
 						DRMCGRP_FTYPE_STATS),
+        },
+	{
+		.name = "memory.default",
+		.seq_show = drmcgrp_bo_show,
+		.flags = CFTYPE_ONLY_ON_ROOT,
+		.private = DRMCG_CTF_PRIV(DRMCGRP_TYPE_MEM,
+						DRMCGRP_FTYPE_DEFAULT),
+	},
+	{
+		.name = "memory.high",
+		.write = drmcgrp_bo_limit_write,
+		.seq_show = drmcgrp_bo_show,
+		.private = DRMCG_CTF_PRIV(DRMCGRP_TYPE_MEM,
+						DRMCGRP_FTYPE_LIMIT),
 	},
 	{
 		.name = "burst_bw_period_in_us",
@@ -674,6 +739,7 @@ struct cgroup_subsys drm_cgrp_subsys = {
 int drmcgrp_register_device(struct drm_device *dev)
 {
 	struct drmcgrp_device *ddev;
+	int i;
 
 	ddev = kzalloc(sizeof(struct drmcgrp_device), GFP_KERNEL);
 	if (!ddev)
@@ -687,6 +753,10 @@ int drmcgrp_register_device(struct drm_device *dev)
 	ddev->mem_bw_bytes_in_period_default = S64_MAX;
 	ddev->mem_bw_avg_bytes_per_us_default = 65536;
 
+	for (i = 0; i <= TTM_PL_PRIV; i++) {
+		ddev->mem_highs_default[i] = S64_MAX;
+	}
+
 	mutex_init(&ddev->mutex);
 
 	mutex_lock(&drmcgrp_mutex);
@@ -991,3 +1061,78 @@ bool drmcgrp_mem_can_move(struct ttm_buffer_object *tbo)
 	return result;
 }
 EXPORT_SYMBOL(drmcgrp_mem_can_move);
+
+static inline void drmcgrp_mem_set_pressure(struct drmcgrp *drmcgrp,
+		int devIdx, unsigned mem_type, bool pressure_val)
+{
+	struct drmcgrp_device_resource *ddr;
+	struct cgroup_subsys_state *pos;
+	struct drmcgrp *node;
+
+	css_for_each_descendant_pre(pos, &drmcgrp->css) {
+		node = css_drmcgrp(pos);
+		ddr = node->dev_resources[devIdx];
+		ddr->mem_pressure[mem_type] = pressure_val;
+	}
+}
+
+static inline bool drmcgrp_mem_check(struct drmcgrp *drmcgrp, int devIdx,
+		unsigned mem_type)
+{
+	struct drmcgrp_device_resource *ddr = drmcgrp->dev_resources[devIdx];
+
+	/* already under pressure, no need to check and set */
+	if (ddr->mem_pressure[mem_type])
+		return true;
+
+	if (ddr->mem_stats[mem_type] >= ddr->mem_highs[mem_type]) {
+		drmcgrp_mem_set_pressure(drmcgrp, devIdx, mem_type, true);
+		return true;
+	}
+
+	return false;
+}
+
+bool drmcgrp_mem_pressure_scan(struct ttm_bo_device *bdev, unsigned type)
+{
+	struct drm_device *dev = bdev->ddev;
+	struct cgroup_subsys_state *pos;
+	struct drmcgrp *node;
+	int devIdx;
+	bool result = false;
+
+	//TODO replace with BUG_ON
+	if (dev == NULL || type != TTM_PL_VRAM) /* only vram limit for now */
+		return false;
+
+	devIdx = dev->primary->index;
+
+	type = type > TTM_PL_PRIV ? TTM_PL_PRIV : type;
+
+	rcu_read_lock();
+	drmcgrp_mem_set_pressure(root_drmcgrp, devIdx, type, false);
+
+	css_for_each_descendant_pre(pos, &root_drmcgrp->css) {
+		node = css_drmcgrp(pos);
+		result |= drmcgrp_mem_check(node, devIdx, type);
+	}
+	rcu_read_unlock();
+
+	return result;
+}
+EXPORT_SYMBOL(drmcgrp_mem_pressure_scan);
+
+bool drmcgrp_mem_should_evict(struct ttm_buffer_object *tbo, unsigned type)
+{
+	struct drm_device *dev = tbo->bdev->ddev;
+	int devIdx;
+
+	//TODO replace with BUG_ON
+	if (dev == NULL)
+		return true;
+
+	devIdx = dev->primary->index;
+
+	return tbo->drmcgrp->dev_resources[devIdx]->mem_pressure[type];
+}
+EXPORT_SYMBOL(drmcgrp_mem_should_evict);
-- 
2.21.0


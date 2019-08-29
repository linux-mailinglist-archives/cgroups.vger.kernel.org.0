Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2139A1170
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2019 08:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfH2GGG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Aug 2019 02:06:06 -0400
Received: from mail-eopbgr680069.outbound.protection.outlook.com ([40.107.68.69]:4375
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727421AbfH2GGG (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 29 Aug 2019 02:06:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yf92rdb0hBGvt0i/Af9xZ4koRw/6KHI+N7Ckw7CFn6NP6TChbQy84HJ9RzoSZRa1eilJIkIFKofyGncezdlIOoJzXHShse8CMLQxLTq9O9QaOGBNFlZqAizugpChAQ31/fnwA87MQFFRDaTAe7y6dooIrvO6R8J8f57kUErcFgwrNHTKZv3YQFx+LOIolt8Cbjtp4872VwzGWSu0tTfYWKlq1IEZI/rLmTsEwqVjjafG5YM6nIaRFbEqECTHSmCVfiQSx2ysLFcW7bHrjmlr6xIfijJluh7MJZ22I//VuXZ7ALtFUa1MDJ3esROqXdh/5oVCz9g+OldSLid2Sz0ayg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zg7tXbM7Idim2K75amETOc2+muRuSenAneZKe+szmmc=;
 b=Wy7zen/RoC9yPd4cX5tFt9ORIxBH3QAVwA04BJ6CTpb4m9tGUE6Req0OJBKXCVRlLkREmOk6o2FBBB9Yhdrx0oVGg4cnJd/Lx3dVU9p7JkZcc33ucN3jMS3bD6LmcdHKE6k427M8i8DUL7hT4mNNWCBTpZDqYM35l2u1fRBmLRTWis8h6f+UpSuVCADBJTYbL0yhpjEfn60yvRNPGFjux+Gk4QvYzhK+655w3X20yrPcAqoXO94rj55ZPv/kjZL/dskJLiOAWUSxS6xd+Xof8TfUI8hAtXsgzbTY+1aqZZtBbJvWc0tDZvJSQb6651hpbJOsiwjWkigMhuF4fYKN3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=cray.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zg7tXbM7Idim2K75amETOc2+muRuSenAneZKe+szmmc=;
 b=0QNqFTM+FHh2qwnrv3laThUB+9LVNQ3PcVxv4ClyrjNYikIYdKl/UTQVl6mio2X8dgERxvUZoF+hHMmQNHOjrqwLbq05lNmSt3Qe5hMc16WpbR3fFEwO+28PZDSD99tOx/lCIcxHptd1CZ61T139lkur5/sYN5dftfsi5g2DInY=
Received: from CH2PR12CA0005.namprd12.prod.outlook.com (2603:10b6:610:57::15)
 by MWHPR12MB1279.namprd12.prod.outlook.com (2603:10b6:300:d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.16; Thu, 29 Aug
 2019 06:05:58 +0000
Received: from CO1NAM03FT045.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::200) by CH2PR12CA0005.outlook.office365.com
 (2603:10b6:610:57::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.18 via Frontend
 Transport; Thu, 29 Aug 2019 06:05:58 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; cray.com; dkim=none (message not signed)
 header.d=none;cray.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 CO1NAM03FT045.mail.protection.outlook.com (10.152.81.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2220.16 via Frontend Transport; Thu, 29 Aug 2019 06:05:57 +0000
Received: from kho-5039A.amd.com (10.180.168.240) by SATLEXCHOV01.amd.com
 (10.181.40.71) with Microsoft SMTP Server id 14.3.389.1; Thu, 29 Aug 2019
 01:05:50 -0500
From:   Kenny Ho <Kenny.Ho@amd.com>
To:     <y2kenny@gmail.com>, <cgroups@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <tj@kernel.org>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <felix.kuehling@amd.com>,
        <joseph.greathouse@amd.com>, <jsparks@cray.com>,
        <lkaplan@cray.com>, <daniel@ffwll.ch>
CC:     Kenny Ho <Kenny.Ho@amd.com>
Subject: [PATCH RFC v4 12/16] drm, cgroup: Add soft VRAM limit
Date:   Thu, 29 Aug 2019 02:05:29 -0400
Message-ID: <20190829060533.32315-13-Kenny.Ho@amd.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829060533.32315-1-Kenny.Ho@amd.com>
References: <20190829060533.32315-1-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(136003)(376002)(396003)(2980300002)(428003)(199004)(189003)(47776003)(336012)(110136005)(5660300002)(81156014)(81166006)(86362001)(8676002)(53936002)(2870700001)(426003)(1076003)(486006)(70586007)(70206006)(2616005)(2201001)(446003)(476003)(126002)(7696005)(51416003)(11346002)(50466002)(48376002)(14444005)(186003)(4326008)(316002)(53416004)(36756003)(2906002)(76176011)(8936002)(356004)(6666004)(305945005)(26005)(478600001)(50226002)(921003)(83996005)(2101003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1279;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d49c2571-cf70-4fc6-7b28-08d72c46f5fd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328);SRVR:MWHPR12MB1279;
X-MS-TrafficTypeDiagnostic: MWHPR12MB1279:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1279C8DA0FD6F802192E6C0383A20@MWHPR12MB1279.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-Forefront-PRVS: 0144B30E41
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: zb1H/lAmVMbsZa/bbYODf9OFwcsxXTsEd3ZMd2bD6HkJYJLbub8RIzCf3X/RMOGsS2MFf8g0W98vsjuqGcFFjylUAcjyyz5yKBG6AJ57T4gmBaOjr09BjTSICEEOy0gmwOnB9omvd2wj4d+1xGnL8imHWb+WC0VTSrGMZ1spmynK2Yn6QXklDbwI0Ytkrr9NphqmPwQbhg9/4YjPCMOFrO0fnBwGwoXx8yr1a48oP3xqz7/T0ySOVbADWTc0GG7c7TQ6iuQMcWIfX+Imn/hnT6eD9sowKw7kNT5UiPpQ33pIT/wxZ8Yt7+uQ2dzVN0UWW17DICwG2fHUSr+/0OMy4yrDbLqsag9PfY4f0zF3N0MVO7DWdmXAS9Nm1fwJ5PIwH6h9ArPrDFoxZNpRaAPm11Jnvt2LmK7CHUx2KTVJcXE=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2019 06:05:57.9474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d49c2571-cf70-4fc6-7b28-08d72c46f5fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1279
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
 include/drm/drm_cgroup.h     |  17 +++++
 include/linux/cgroup_drm.h   |   2 +
 kernel/cgroup/drm.c          | 135 +++++++++++++++++++++++++++++++++++
 4 files changed, 161 insertions(+)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 32eee85f3641..d7e3d3128ebb 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -853,14 +853,21 @@ static int ttm_mem_evict_first(struct ttm_bo_device *bdev,
 	struct ttm_bo_global *glob = bdev->glob;
 	struct ttm_mem_type_manager *man = &bdev->man[mem_type];
 	bool locked = false;
+	bool check_drmcg;
 	unsigned i;
 	int ret;
 
+	check_drmcg = drmcg_mem_pressure_scan(bdev, mem_type);
+
 	spin_lock(&glob->lru_lock);
 	for (i = 0; i < TTM_MAX_BO_PRIORITY; ++i) {
 		list_for_each_entry(bo, &man->lru[i], lru) {
 			bool busy;
 
+			if (check_drmcg &&
+				!drmcg_mem_should_evict(bo, mem_type))
+				continue;
+
 			if (!ttm_bo_evict_swapout_allowable(bo, ctx, &locked,
 							    &busy)) {
 				if (busy && !busy_bo &&
diff --git a/include/drm/drm_cgroup.h b/include/drm/drm_cgroup.h
index 9ce0d54e6bd8..c11df388fdf2 100644
--- a/include/drm/drm_cgroup.h
+++ b/include/drm/drm_cgroup.h
@@ -6,6 +6,7 @@
 
 #include <linux/cgroup_drm.h>
 #include <drm/ttm/ttm_bo_api.h>
+#include <drm/ttm/ttm_bo_driver.h>
 
 /**
  * Per DRM device properties for DRM cgroup controller for the purpose
@@ -22,6 +23,8 @@ struct drmcg_props {
 
 	s64			mem_bw_bytes_in_period_default;
 	s64			mem_bw_avg_bytes_per_us_default;
+
+	s64			mem_highs_default[TTM_PL_PRIV+1];
 };
 
 #ifdef CONFIG_CGROUP_DRM
@@ -38,6 +41,8 @@ void drmcg_mem_track_move(struct ttm_buffer_object *old_bo, bool evict,
 		struct ttm_mem_reg *new_mem);
 unsigned int drmcg_get_mem_bw_period_in_us(struct ttm_buffer_object *tbo);
 bool drmcg_mem_can_move(struct ttm_buffer_object *tbo);
+bool drmcg_mem_pressure_scan(struct ttm_bo_device *bdev, unsigned int type);
+bool drmcg_mem_should_evict(struct ttm_buffer_object *tbo, unsigned int type);
 
 #else
 static inline void drmcg_device_update(struct drm_device *device)
@@ -81,5 +86,17 @@ static inline bool drmcg_mem_can_move(struct ttm_buffer_object *tbo)
 {
 	return true;
 }
+
+static inline bool drmcg_mem_pressure_scan(struct ttm_bo_device *bdev,
+		unsigned int type)
+{
+	return false;
+}
+
+static inline bool drmcg_mem_should_evict(struct ttm_buffer_object *tbo,
+		unsigned int type)
+{
+	return true;
+}
 #endif /* CONFIG_CGROUP_DRM */
 #endif /* __DRM_CGROUP_H__ */
diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
index 27809a583bf2..c56cfe74d1a6 100644
--- a/include/linux/cgroup_drm.h
+++ b/include/linux/cgroup_drm.h
@@ -50,6 +50,8 @@ struct drmcg_device_resource {
 
 	s64			mem_stats[TTM_PL_PRIV+1];
 	s64			mem_peaks[TTM_PL_PRIV+1];
+	s64			mem_highs[TTM_PL_PRIV+1];
+	bool			mem_pressure[TTM_PL_PRIV+1];
 	s64			mem_stats_evict;
 
 	s64			mem_bw_stats_last_update_us;
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
index ab962a277e58..04fb9a398740 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -80,6 +80,7 @@ static inline int init_drmcg_single(struct drmcg *drmcg, struct drm_device *dev)
 {
 	int minor = dev->primary->index;
 	struct drmcg_device_resource *ddr = drmcg->dev_resources[minor];
+	int i;
 
 	if (ddr == NULL) {
 		ddr = kzalloc(sizeof(struct drmcg_device_resource),
@@ -108,6 +109,12 @@ static inline int init_drmcg_single(struct drmcg *drmcg, struct drm_device *dev)
 	ddr->mem_bw_limits_avg_bytes_per_us =
 		dev->drmcg_props.mem_bw_avg_bytes_per_us_default;
 
+	ddr->mem_bw_limits_avg_bytes_per_us =
+		dev->drmcg_props.mem_bw_avg_bytes_per_us_default;
+
+	for (i = 0; i <= TTM_PL_PRIV; i++)
+		ddr->mem_highs[i] = dev->drmcg_props.mem_highs_default[i];
+
 	mutex_unlock(&dev->drmcg_mutex);
 	return 0;
 }
@@ -257,6 +264,11 @@ static void drmcg_print_limits(struct drmcg_device_resource *ddr,
 	case DRMCG_TYPE_BO_PEAK:
 		seq_printf(sf, "%lld\n", ddr->bo_limits_peak_allocated);
 		break;
+	case DRMCG_TYPE_MEM:
+		seq_printf(sf, "%s=%lld\n",
+				ttm_placement_names[TTM_PL_VRAM],
+				ddr->mem_highs[TTM_PL_VRAM]);
+		break;
 	case DRMCG_TYPE_BANDWIDTH_PERIOD_BURST:
 		seq_printf(sf, "%lld\n",
 			dev->drmcg_props.mem_bw_limits_period_in_us);
@@ -286,6 +298,11 @@ static void drmcg_print_default(struct drmcg_props *props,
 		seq_printf(sf, "%lld\n",
 			props->bo_limits_peak_allocated_default);
 		break;
+	case DRMCG_TYPE_MEM:
+		seq_printf(sf, "%s=%lld\n",
+				ttm_placement_names[TTM_PL_VRAM],
+				props->mem_highs_default[TTM_PL_VRAM]);
+		break;
 	case DRMCG_TYPE_BANDWIDTH_PERIOD_BURST:
 		seq_printf(sf, "%lld\n",
 			props->mem_bw_limits_period_in_us_default);
@@ -461,6 +478,29 @@ static void drmcg_nested_limit_parse(struct kernfs_open_file *of,
 				continue;
 			}
 			break; /* DRMCG_TYPE_BANDWIDTH */
+		case DRMCG_TYPE_MEM:
+			if (strncmp(sname, ttm_placement_names[TTM_PL_VRAM],
+						256) == 0) {
+				p_max = parent == NULL ? S64_MAX :
+					parent->dev_resources[minor]->
+					mem_highs[TTM_PL_VRAM];
+
+				rc = drmcg_process_limit_s64_val(sval, true,
+					props->mem_highs_default[TTM_PL_VRAM],
+					p_max, &val);
+
+				if (rc || val < 0) {
+					drmcg_pr_cft_err(drmcg, rc, cft_name,
+							minor);
+					continue;
+				}
+
+				drmcg_value_apply(dev,
+						&ddr->mem_highs[TTM_PL_VRAM],
+						val);
+				continue;
+			}
+			break; /* DRMCG_TYPE_MEM */
 		default:
 			break;
 		} /* switch (type) */
@@ -565,6 +605,7 @@ static ssize_t drmcg_limit_write(struct kernfs_open_file *of, char *buf,
 			drmcg_mem_burst_bw_stats_reset(dm->dev);
 			break;
 		case DRMCG_TYPE_BANDWIDTH:
+		case DRMCG_TYPE_MEM:
 			drmcg_nested_limit_parse(of, dm->dev, sattr);
 			break;
 		default:
@@ -641,6 +682,20 @@ struct cftype files[] = {
 		.private = DRMCG_CTF_PRIV(DRMCG_TYPE_MEM_PEAK,
 						DRMCG_FTYPE_STATS),
 	},
+	{
+		.name = "memory.default",
+		.seq_show = drmcg_seq_show,
+		.flags = CFTYPE_ONLY_ON_ROOT,
+		.private = DRMCG_CTF_PRIV(DRMCG_TYPE_MEM,
+						DRMCG_FTYPE_DEFAULT),
+	},
+	{
+		.name = "memory.high",
+		.write = drmcg_limit_write,
+		.seq_show = drmcg_seq_show,
+		.private = DRMCG_CTF_PRIV(DRMCG_TYPE_MEM,
+						DRMCG_FTYPE_LIMIT),
+	},
 	{
 		.name = "burst_bw_period_in_us",
 		.write = drmcg_limit_write,
@@ -731,6 +786,8 @@ EXPORT_SYMBOL(drmcg_device_update);
  */
 void drmcg_device_early_init(struct drm_device *dev)
 {
+	int i;
+
 	dev->drmcg_props.limit_enforced = false;
 
 	dev->drmcg_props.bo_limits_total_allocated_default = S64_MAX;
@@ -740,6 +797,9 @@ void drmcg_device_early_init(struct drm_device *dev)
 	dev->drmcg_props.mem_bw_bytes_in_period_default = S64_MAX;
 	dev->drmcg_props.mem_bw_avg_bytes_per_us_default = 65536;
 
+	for (i = 0; i <= TTM_PL_PRIV; i++)
+		dev->drmcg_props.mem_highs_default[i] = S64_MAX;
+
 	drmcg_update_cg_tree(dev);
 }
 EXPORT_SYMBOL(drmcg_device_early_init);
@@ -1008,3 +1068,78 @@ bool drmcg_mem_can_move(struct ttm_buffer_object *tbo)
 	return result;
 }
 EXPORT_SYMBOL(drmcg_mem_can_move);
+
+static inline void drmcg_mem_set_pressure(struct drmcg *drmcg,
+		int devIdx, unsigned int mem_type, bool pressure_val)
+{
+	struct drmcg_device_resource *ddr;
+	struct cgroup_subsys_state *pos;
+	struct drmcg *node;
+
+	css_for_each_descendant_pre(pos, &drmcg->css) {
+		node = css_to_drmcg(pos);
+		ddr = node->dev_resources[devIdx];
+		ddr->mem_pressure[mem_type] = pressure_val;
+	}
+}
+
+static inline bool drmcg_mem_check(struct drmcg *drmcg, int devIdx,
+		unsigned int mem_type)
+{
+	struct drmcg_device_resource *ddr = drmcg->dev_resources[devIdx];
+
+	/* already under pressure, no need to check and set */
+	if (ddr->mem_pressure[mem_type])
+		return true;
+
+	if (ddr->mem_stats[mem_type] >= ddr->mem_highs[mem_type]) {
+		drmcg_mem_set_pressure(drmcg, devIdx, mem_type, true);
+		return true;
+	}
+
+	return false;
+}
+
+bool drmcg_mem_pressure_scan(struct ttm_bo_device *bdev, unsigned int type)
+{
+	struct drm_device *dev = bdev->ddev;
+	struct cgroup_subsys_state *pos;
+	struct drmcg *node;
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
+	drmcg_mem_set_pressure(root_drmcg, devIdx, type, false);
+
+	css_for_each_descendant_pre(pos, &root_drmcg->css) {
+		node = css_to_drmcg(pos);
+		result |= drmcg_mem_check(node, devIdx, type);
+	}
+	rcu_read_unlock();
+
+	return result;
+}
+EXPORT_SYMBOL(drmcg_mem_pressure_scan);
+
+bool drmcg_mem_should_evict(struct ttm_buffer_object *tbo, unsigned int type)
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
+	return tbo->drmcg->dev_resources[devIdx]->mem_pressure[type];
+}
+EXPORT_SYMBOL(drmcg_mem_should_evict);
-- 
2.22.0


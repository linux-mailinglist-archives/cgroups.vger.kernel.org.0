Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFE956D3D
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2019 17:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfFZPFu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jun 2019 11:05:50 -0400
Received: from mail-eopbgr800044.outbound.protection.outlook.com ([40.107.80.44]:4919
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727218AbfFZPFu (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 26 Jun 2019 11:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qL16NkCpzCCNgM1RShu3+2nusaksV+Bt3h/GVWUML9Y=;
 b=p+uz/Pc+C6+h9f+KbTTWERsw4MGpv2x/XwYVx0RjA4zHzCn3JlTiATJ0plaz7x3xt8AsA6ZmECFjZbM589kKIxzIG1EGP6nqsdGjRspFDgKDhPnFRChN1qdz2o/jZ61MX12p8BMoDSyUAm18PmRJjz5tUK6Sh//Bu2TQPaxWaC0=
Received: from MWHPR12CA0068.namprd12.prod.outlook.com (2603:10b6:300:103::30)
 by BN6PR12MB1747.namprd12.prod.outlook.com (2603:10b6:404:106::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16; Wed, 26 Jun
 2019 15:05:40 +0000
Received: from DM3NAM03FT041.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::209) by MWHPR12CA0068.outlook.office365.com
 (2603:10b6:300:103::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2008.16 via Frontend
 Transport; Wed, 26 Jun 2019 15:05:40 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV02.amd.com (165.204.84.17) by
 DM3NAM03FT041.mail.protection.outlook.com (10.152.83.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2032.15 via Frontend Transport; Wed, 26 Jun 2019 15:05:39 +0000
Received: from kho-5039A.amd.com (10.180.168.240) by SATLEXCHOV02.amd.com
 (10.181.40.72) with Microsoft SMTP Server id 14.3.389.1; Wed, 26 Jun 2019
 10:05:33 -0500
From:   Kenny Ho <Kenny.Ho@amd.com>
To:     <y2kenny@gmail.com>, <cgroups@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <tj@kernel.org>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <joseph.greathouse@amd.com>,
        <jsparks@cray.com>, <lkaplan@cray.com>
CC:     Kenny Ho <Kenny.Ho@amd.com>
Subject: [RFC PATCH v3 09/11] drm, cgroup: Add per cgroup bw measure and control
Date:   Wed, 26 Jun 2019 11:05:20 -0400
Message-ID: <20190626150522.11618-10-Kenny.Ho@amd.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626150522.11618-1-Kenny.Ho@amd.com>
References: <20190626150522.11618-1-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(136003)(2980300002)(428003)(199004)(189003)(336012)(76176011)(81166006)(68736007)(316002)(110136005)(77096007)(186003)(26005)(70206006)(50226002)(81156014)(8676002)(48376002)(11346002)(5660300002)(51416003)(7696005)(2870700001)(50466002)(426003)(446003)(2616005)(476003)(47776003)(126002)(305945005)(4326008)(486006)(478600001)(356004)(6666004)(2906002)(2201001)(86362001)(53936002)(30864003)(53416004)(72206003)(70586007)(8936002)(36756003)(14444005)(1076003)(921003)(83996005)(2101003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1747;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f05948a7-e4a4-47e0-8690-08d6fa47c0ca
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:BN6PR12MB1747;
X-MS-TrafficTypeDiagnostic: BN6PR12MB1747:
X-Microsoft-Antispam-PRVS: <BN6PR12MB17472E526DA835465AE2FBF283E20@BN6PR12MB1747.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-Forefront-PRVS: 00808B16F3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 0jJdzuji2tQICouQ+JuRNLLOgMMKGLh3VVNcnpOE66mzuKbqbkSTu/09i1Nv+TYNQ58TelUKkW0mDFBoXxd7h3KDPG5uVBxKrS5wsiEZ+o9+2FZT+8I9Wavng6+RMTh8vQCKTrgXN+SnVo5F3bcVGuhmGC5uBj/P/oJo1OThqab1MrnrfPrXGE5nM0T0jCb1ktuzqMcDp+rzXOT1tR3qH558jylnh05StyKiP/Qo7TK+06ni3/b9XYJ+ahQ8fkdEeo/jPe8gnlssBX0HMWJZZpzDxBsTlVQ6H9r8GpV+bCB4Oh8y5jHn23AGEx0WcKeYlDPz8cdsBAqR/B7CUxdNpgZsuLWcLrUjDuuI5S/OVdl5Qj8iR86V6fZohF70ypwFv7BntOc+XefFH6uVdt1ixHWabXyJl/5EiTHqOikDyII=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2019 15:05:39.9143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f05948a7-e4a4-47e0-8690-08d6fa47c0ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1747
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The bandwidth is measured by keeping track of the amount of bytes moved
by ttm within a time period.  We defined two type of bandwidth: burst
and average.  Average bandwidth is calculated by dividing the total
amount of bytes moved within a cgroup by the lifetime of the cgroup.
Burst bandwidth is similar except that the byte and time measurement is
reset after a user configurable period.

The bandwidth control is best effort since it is done on a per move
basis instead of per byte.  The bandwidth is limited by delaying the
move of a buffer.  The bandwidth limit can be exceeded when the next
move is larger than the remaining allowance.

drm.burst_bw_period_in_us
        A read-write flat-keyed file which exists on the root cgroup.
        Each entry is keyed by the drm device's major:minor.

        Length of a period use to measure burst bandwidth in us.
        One period per device.

drm.burst_bw_period_in_us.default
        A read-only flat-keyed file which exists on the root cgroup.
        Each entry is keyed by the drm device's major:minor.

        Default length of a period in us (one per device.)

drm.bandwidth.stats
        A read-only nested-keyed file which exists on all cgroups.
        Each entry is keyed by the drm device's major:minor.  The
        following nested keys are defined.

          =================     ======================================
          burst_byte_per_us     Burst bandwidth
          avg_bytes_per_us      Average bandwidth
          moved_byte            Amount of byte moved within a period
          accum_us              Amount of time accumulated in a period
          total_moved_byte      Byte moved within the cgroup lifetime
          total_accum_us        Cgroup lifetime in us
          byte_credit           Available byte credit to limit avg bw
          =================     ======================================

        Reading returns the following::
        226:1 burst_byte_per_us=23 avg_bytes_per_us=0 moved_byte=2244608
        accum_us=95575 total_moved_byte=45899776 total_accum_us=201634590
        byte_credit=13214278590464
        226:2 burst_byte_per_us=10 avg_bytes_per_us=219 moved_byte=430080
        accum_us=39350 total_moved_byte=65518026752 total_accum_us=298337721
        byte_credit=9223372036854644735

drm.bandwidth.high
        A read-write nested-keyed file which exists on all cgroups.
        Each entry is keyed by the drm device's major:minor.  The
        following nested keys are defined.

          ================  =======================================
          bytes_in_period   Burst limit per period in byte
          avg_bytes_per_us  Average bandwidth limit in bytes per us
          ================  =======================================

        Reading returns the following::

        226:1 bytes_in_period=9223372036854775807 avg_bytes_per_us=65536
        226:2 bytes_in_period=9223372036854775807 avg_bytes_per_us=65536

drm.bandwidth.default
        A read-only nested-keyed file which exists on the root cgroup.
        Each entry is keyed by the drm device's major:minor.  The
        following nested keys are defined.

          ================  ========================================
          bytes_in_period   Default burst limit per period in byte
          avg_bytes_per_us  Default average bw limit in bytes per us
          ================  ========================================

        Reading returns the following::

        226:1 bytes_in_period=9223372036854775807 avg_bytes_per_us=65536
        226:2 bytes_in_period=9223372036854775807 avg_bytes_per_us=65536

Change-Id: Ie573491325ccc16535bb943e7857f43bd0962add
Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c |   7 +
 include/drm/drm_cgroup.h     |  13 ++
 include/linux/cgroup_drm.h   |  14 ++
 kernel/cgroup/drm.c          | 309 ++++++++++++++++++++++++++++++++++-
 4 files changed, 340 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index e9f70547f0ad..f06c2b9d8a4a 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -36,6 +36,7 @@
 #include <drm/ttm/ttm_placement.h>
 #include <drm/drm_cgroup.h>
 #include <linux/jiffies.h>
+#include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
@@ -1176,6 +1177,12 @@ int ttm_bo_validate(struct ttm_buffer_object *bo,
 	 * Check whether we need to move buffer.
 	 */
 	if (!ttm_bo_mem_compat(placement, &bo->mem, &new_flags)) {
+		unsigned int move_delay = drmcgrp_get_mem_bw_period_in_us(bo);
+		move_delay /= 2000; /* check every half period in ms*/
+		while (bo->bdev->ddev != NULL && !drmcgrp_mem_can_move(bo)) {
+			msleep(move_delay);
+		}
+
 		ret = ttm_bo_move_buffer(bo, placement, ctx);
 		if (ret)
 			return ret;
diff --git a/include/drm/drm_cgroup.h b/include/drm/drm_cgroup.h
index 48ab5450cf17..9b1dbd6a4eca 100644
--- a/include/drm/drm_cgroup.h
+++ b/include/drm/drm_cgroup.h
@@ -23,6 +23,8 @@ void drmcgrp_chg_mem(struct ttm_buffer_object *tbo);
 void drmcgrp_unchg_mem(struct ttm_buffer_object *tbo);
 void drmcgrp_mem_track_move(struct ttm_buffer_object *old_bo, bool evict,
 		struct ttm_mem_reg *new_mem);
+unsigned int drmcgrp_get_mem_bw_period_in_us(struct ttm_buffer_object *tbo);
+bool drmcgrp_mem_can_move(struct ttm_buffer_object *tbo);
 
 #else
 static inline int drmcgrp_register_device(struct drm_device *device)
@@ -69,5 +71,16 @@ static inline void drmcgrp_mem_track_move(struct ttm_buffer_object *old_bo,
 		bool evict, struct ttm_mem_reg *new_mem)
 {
 }
+
+static inline unsigned int drmcgrp_get_mem_bw_period_in_us(
+		struct ttm_buffer_object *tbo)
+{
+	return 0;
+}
+
+static inline bool drmcgrp_mem_can_move(struct ttm_buffer_object *tbo)
+{
+	return true;
+}
 #endif /* CONFIG_CGROUP_DRM */
 #endif /* __DRM_CGROUP_H__ */
diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
index 922529641df5..94828da2104a 100644
--- a/include/linux/cgroup_drm.h
+++ b/include/linux/cgroup_drm.h
@@ -14,6 +14,15 @@
 /* limit defined per the way drm_minor_alloc operates */
 #define MAX_DRM_DEV (64 * DRM_MINOR_RENDER)
 
+enum drmcgrp_mem_bw_attr {
+    DRMCGRP_MEM_BW_ATTR_BYTE_MOVED, /* for calulating 'instantaneous' bw */
+    DRMCGRP_MEM_BW_ATTR_ACCUM_US,  /* for calulating 'instantaneous' bw */
+    DRMCGRP_MEM_BW_ATTR_TOTAL_BYTE_MOVED,
+    DRMCGRP_MEM_BW_ATTR_TOTAL_ACCUM_US,
+    DRMCGRP_MEM_BW_ATTR_BYTE_CREDIT,
+    __DRMCGRP_MEM_BW_ATTR_LAST,
+};
+
 struct drmcgrp_device_resource {
 	/* for per device stats */
 	s64			bo_stats_total_allocated;
@@ -27,6 +36,11 @@ struct drmcgrp_device_resource {
 	s64			mem_stats[TTM_PL_PRIV+1];
 	s64			mem_peaks[TTM_PL_PRIV+1];
 	s64			mem_stats_evict;
+
+	s64			mem_bw_stats_last_update_us;
+	s64			mem_bw_stats[__DRMCGRP_MEM_BW_ATTR_LAST];
+	s64			mem_bw_limits_bytes_in_period;
+	s64			mem_bw_limits_avg_bytes_per_us;
 };
 
 struct drmcgrp {
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
index 5f5fa6a2b068..bbc6612200a4 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -7,6 +7,7 @@
 #include <linux/seq_file.h>
 #include <linux/mutex.h>
 #include <linux/cgroup_drm.h>
+#include <linux/ktime.h>
 #include <linux/kernel.h>
 #include <drm/ttm/ttm_bo_api.h>
 #include <drm/ttm/ttm_bo_driver.h>
@@ -22,6 +23,12 @@ struct drmcgrp_device {
 
 	s64			bo_limits_total_allocated_default;
 	size_t			bo_limits_peak_allocated_default;
+
+	s64			mem_bw_limits_period_in_us;
+	s64			mem_bw_limits_period_in_us_default;
+
+	s64			mem_bw_bytes_in_period_default;
+	s64			mem_bw_avg_bytes_per_us_default;
 };
 
 #define DRMCG_CTF_PRIV_SIZE 3
@@ -39,6 +46,8 @@ enum drmcgrp_res_type {
 	DRMCGRP_TYPE_MEM,
 	DRMCGRP_TYPE_MEM_EVICT,
 	DRMCGRP_TYPE_MEM_PEAK,
+	DRMCGRP_TYPE_BANDWIDTH,
+	DRMCGRP_TYPE_BANDWIDTH_PERIOD_BURST,
 };
 
 enum drmcgrp_file_type {
@@ -54,6 +63,17 @@ static char const *ttm_placement_names[] = {
 	[TTM_PL_PRIV]   = "priv",
 };
 
+static char const *mem_bw_attr_names[] = {
+	[DRMCGRP_MEM_BW_ATTR_BYTE_MOVED] = "moved_byte",
+	[DRMCGRP_MEM_BW_ATTR_ACCUM_US] = "accum_us",
+	[DRMCGRP_MEM_BW_ATTR_TOTAL_BYTE_MOVED] = "total_moved_byte",
+	[DRMCGRP_MEM_BW_ATTR_TOTAL_ACCUM_US] = "total_accum_us",
+	[DRMCGRP_MEM_BW_ATTR_BYTE_CREDIT] = "byte_credit",
+};
+
+#define MEM_BW_LIMITS_NAME_AVG "avg_bytes_per_us"
+#define MEM_BW_LIMITS_NAME_BURST "bytes_in_period"
+
 /* indexed by drm_minor for access speed */
 static struct drmcgrp_device	*known_drmcgrp_devs[MAX_DRM_DEV];
 
@@ -86,6 +106,9 @@ static inline int init_drmcgrp_single(struct drmcgrp *drmcgrp, int minor)
 		if (!ddr)
 			return -ENOMEM;
 
+		ddr->mem_bw_stats_last_update_us = ktime_to_us(ktime_get());
+		ddr->mem_bw_stats[DRMCGRP_MEM_BW_ATTR_ACCUM_US] = 1;
+
 		drmcgrp->dev_resources[minor] = ddr;
 	}
 
@@ -96,6 +119,12 @@ static inline int init_drmcgrp_single(struct drmcgrp *drmcgrp, int minor)
 
 		ddr->bo_limits_peak_allocated =
 		  known_drmcgrp_devs[minor]->bo_limits_peak_allocated_default;
+
+		ddr->mem_bw_limits_bytes_in_period =
+		  known_drmcgrp_devs[minor]->mem_bw_bytes_in_period_default;
+
+		ddr->mem_bw_limits_avg_bytes_per_us =
+		  known_drmcgrp_devs[minor]->mem_bw_avg_bytes_per_us_default;
 	}
 
 	return 0;
@@ -143,6 +172,26 @@ drmcgrp_css_alloc(struct cgroup_subsys_state *parent_css)
 	return &drmcgrp->css;
 }
 
+static inline void drmcgrp_mem_burst_bw_stats_reset(struct drm_device *dev)
+{
+	struct cgroup_subsys_state *pos;
+	struct drmcgrp *node;
+	struct drmcgrp_device_resource *ddr;
+	int devIdx;
+
+	devIdx =  dev->primary->index;
+
+	rcu_read_lock();
+	css_for_each_descendant_pre(pos, &root_drmcgrp->css) {
+		node = css_drmcgrp(pos);
+		ddr = node->dev_resources[devIdx];
+
+		ddr->mem_bw_stats[DRMCGRP_MEM_BW_ATTR_ACCUM_US] = 1;
+		ddr->mem_bw_stats[DRMCGRP_MEM_BW_ATTR_BYTE_MOVED] = 0;
+	}
+	rcu_read_unlock();
+}
+
 static inline void drmcgrp_print_stats(struct drmcgrp_device_resource *ddr,
 		struct seq_file *sf, enum drmcgrp_res_type type)
 {
@@ -179,6 +228,31 @@ static inline void drmcgrp_print_stats(struct drmcgrp_device_resource *ddr,
 		}
 		seq_puts(sf, "\n");
 		break;
+	case DRMCGRP_TYPE_BANDWIDTH:
+		if (ddr->mem_bw_stats[DRMCGRP_MEM_BW_ATTR_ACCUM_US] == 0)
+			seq_puts(sf, "burst_byte_per_us=NaN ");
+		else
+			seq_printf(sf, "burst_byte_per_us=%lld ",
+				ddr->mem_bw_stats[
+				DRMCGRP_MEM_BW_ATTR_BYTE_MOVED]/
+				ddr->mem_bw_stats[
+				DRMCGRP_MEM_BW_ATTR_ACCUM_US]);
+
+		if (ddr->mem_bw_stats[DRMCGRP_MEM_BW_ATTR_TOTAL_ACCUM_US] == 0)
+			seq_puts(sf, "avg_bytes_per_us=NaN ");
+		else
+			seq_printf(sf, "avg_bytes_per_us=%lld ",
+				ddr->mem_bw_stats[
+				DRMCGRP_MEM_BW_ATTR_TOTAL_BYTE_MOVED]/
+				ddr->mem_bw_stats[
+				DRMCGRP_MEM_BW_ATTR_TOTAL_ACCUM_US]);
+
+		for (i = 0; i < __DRMCGRP_MEM_BW_ATTR_LAST; i++) {
+			seq_printf(sf, "%s=%lld ", mem_bw_attr_names[i],
+					ddr->mem_bw_stats[i]);
+		}
+		seq_puts(sf, "\n");
+		break;
 	default:
 		seq_puts(sf, "\n");
 		break;
@@ -186,9 +260,9 @@ static inline void drmcgrp_print_stats(struct drmcgrp_device_resource *ddr,
 }
 
 static inline void drmcgrp_print_limits(struct drmcgrp_device_resource *ddr,
-		struct seq_file *sf, enum drmcgrp_res_type type)
+		struct seq_file *sf, enum drmcgrp_res_type type, int minor)
 {
-	if (ddr == NULL) {
+	if (ddr == NULL || known_drmcgrp_devs[minor] == NULL) {
 		seq_puts(sf, "\n");
 		return;
 	}
@@ -200,6 +274,17 @@ static inline void drmcgrp_print_limits(struct drmcgrp_device_resource *ddr,
 	case DRMCGRP_TYPE_BO_PEAK:
 		seq_printf(sf, "%zu\n", ddr->bo_limits_peak_allocated);
 		break;
+	case DRMCGRP_TYPE_BANDWIDTH_PERIOD_BURST:
+		seq_printf(sf, "%lld\n",
+			known_drmcgrp_devs[minor]->mem_bw_limits_period_in_us);
+		break;
+	case DRMCGRP_TYPE_BANDWIDTH:
+		seq_printf(sf, "%s=%lld %s=%lld\n",
+				MEM_BW_LIMITS_NAME_BURST,
+				ddr->mem_bw_limits_bytes_in_period,
+				MEM_BW_LIMITS_NAME_AVG,
+				ddr->mem_bw_limits_avg_bytes_per_us);
+		break;
 	default:
 		seq_puts(sf, "\n");
 		break;
@@ -223,6 +308,17 @@ static inline void drmcgrp_print_default(struct drmcgrp_device *ddev,
 		seq_printf(sf, "%zu\n",
 				ddev->bo_limits_peak_allocated_default);
 		break;
+	case DRMCGRP_TYPE_BANDWIDTH_PERIOD_BURST:
+		seq_printf(sf, "%lld\n",
+				ddev->mem_bw_limits_period_in_us_default);
+		break;
+	case DRMCGRP_TYPE_BANDWIDTH:
+		seq_printf(sf, "%s=%lld %s=%lld\n",
+				MEM_BW_LIMITS_NAME_BURST,
+				ddev->mem_bw_bytes_in_period_default,
+				MEM_BW_LIMITS_NAME_AVG,
+				ddev->mem_bw_avg_bytes_per_us_default);
+		break;
 	default:
 		seq_puts(sf, "\n");
 		break;
@@ -251,7 +347,7 @@ int drmcgrp_bo_show(struct seq_file *sf, void *v)
 			drmcgrp_print_stats(ddr, sf, type);
 			break;
 		case DRMCGRP_FTYPE_LIMIT:
-			drmcgrp_print_limits(ddr, sf, type);
+			drmcgrp_print_limits(ddr, sf, type, i);
 			break;
 		case DRMCGRP_FTYPE_DEFAULT:
 			drmcgrp_print_default(ddev, sf, type);
@@ -317,6 +413,9 @@ ssize_t drmcgrp_bo_limit_write(struct kernfs_open_file *of, char *buf,
 	struct drmcgrp_device_resource *ddr;
 	char *line;
 	char sattr[256];
+	char sval[256];
+	char *nested;
+	char *attr;
 	s64 val;
 	s64 p_max;
 	int rc;
@@ -381,6 +480,78 @@ ssize_t drmcgrp_bo_limit_write(struct kernfs_open_file *of, char *buf,
 
 			ddr->bo_limits_peak_allocated = val;
 			break;
+		case DRMCGRP_TYPE_BANDWIDTH_PERIOD_BURST:
+			rc = drmcgrp_process_limit_val(sattr, false,
+				ddev->mem_bw_limits_period_in_us_default,
+				S64_MAX,
+				&val);
+
+			if (rc || val < 2000) {
+				drmcgrp_pr_cft_err(drmcgrp, cft_name, minor);
+				continue;
+			}
+
+			ddev->mem_bw_limits_period_in_us= val;
+			drmcgrp_mem_burst_bw_stats_reset(ddev->dev);
+			break;
+		case DRMCGRP_TYPE_BANDWIDTH:
+			nested = strstrip(sattr);
+
+			while (nested != NULL) {
+				attr = strsep(&nested, " ");
+
+				if (sscanf(attr, MEM_BW_LIMITS_NAME_BURST"=%s",
+							sval) == 1) {
+					p_max = parent == NULL ? S64_MAX :
+						parent->
+						dev_resources[minor]->
+						mem_bw_limits_bytes_in_period;
+
+					rc = drmcgrp_process_limit_val(sval,
+						true,
+						ddev->
+						mem_bw_bytes_in_period_default,
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
+					ddr->mem_bw_limits_bytes_in_period=val;
+					continue;
+				}
+
+				if (sscanf(attr, MEM_BW_LIMITS_NAME_AVG"=%s",
+							sval) == 1) {
+					p_max = parent == NULL ? S64_MAX :
+						parent->
+						dev_resources[minor]->
+						mem_bw_limits_avg_bytes_per_us;
+
+					rc = drmcgrp_process_limit_val(sval,
+						true,
+						ddev->
+					      mem_bw_avg_bytes_per_us_default,
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
+					ddr->
+					mem_bw_limits_avg_bytes_per_us=val;
+					continue;
+				}
+			}
+			break;
 		default:
 			break;
 		}
@@ -454,6 +625,41 @@ struct cftype files[] = {
 		.private = DRMCG_CTF_PRIV(DRMCGRP_TYPE_MEM_PEAK,
 						DRMCGRP_FTYPE_STATS),
 	},
+	{
+		.name = "burst_bw_period_in_us",
+		.write = drmcgrp_bo_limit_write,
+		.seq_show = drmcgrp_bo_show,
+		.flags = CFTYPE_ONLY_ON_ROOT,
+		.private = DRMCG_CTF_PRIV(DRMCGRP_TYPE_BANDWIDTH_PERIOD_BURST,
+						DRMCGRP_FTYPE_LIMIT),
+	},
+	{
+		.name = "burst_bw_period_in_us.default",
+		.seq_show = drmcgrp_bo_show,
+		.flags = CFTYPE_ONLY_ON_ROOT,
+		.private = DRMCG_CTF_PRIV(DRMCGRP_TYPE_BANDWIDTH_PERIOD_BURST,
+						DRMCGRP_FTYPE_DEFAULT),
+	},
+	{
+		.name = "bandwidth.stats",
+		.seq_show = drmcgrp_bo_show,
+		.private = DRMCG_CTF_PRIV(DRMCGRP_TYPE_BANDWIDTH,
+						DRMCGRP_FTYPE_STATS),
+	},
+	{
+		.name = "bandwidth.high",
+		.write = drmcgrp_bo_limit_write,
+		.seq_show = drmcgrp_bo_show,
+		.private = DRMCG_CTF_PRIV(DRMCGRP_TYPE_BANDWIDTH,
+						DRMCGRP_FTYPE_LIMIT),
+	},
+	{
+		.name = "bandwidth.default",
+		.seq_show = drmcgrp_bo_show,
+		.flags = CFTYPE_ONLY_ON_ROOT,
+		.private = DRMCG_CTF_PRIV(DRMCGRP_TYPE_BANDWIDTH,
+						DRMCGRP_FTYPE_DEFAULT),
+	},
 	{ }	/* terminate */
 };
 
@@ -476,6 +682,10 @@ int drmcgrp_register_device(struct drm_device *dev)
 	ddev->dev = dev;
 	ddev->bo_limits_total_allocated_default = S64_MAX;
 	ddev->bo_limits_peak_allocated_default = SIZE_MAX;
+	ddev->mem_bw_limits_period_in_us_default = 200000;
+	ddev->mem_bw_limits_period_in_us = 200000;
+	ddev->mem_bw_bytes_in_period_default = S64_MAX;
+	ddev->mem_bw_avg_bytes_per_us_default = 65536;
 
 	mutex_init(&ddev->mutex);
 
@@ -652,6 +862,27 @@ void drmcgrp_unchg_mem(struct ttm_buffer_object *tbo)
 }
 EXPORT_SYMBOL(drmcgrp_unchg_mem);
 
+static inline void drmcgrp_mem_bw_accum(s64 time_us,
+		struct drmcgrp_device_resource *ddr)
+{
+	s64 increment_us = time_us - ddr->mem_bw_stats_last_update_us;
+	s64 new_credit = ddr->mem_bw_limits_avg_bytes_per_us * increment_us;
+
+	ddr->mem_bw_stats[DRMCGRP_MEM_BW_ATTR_ACCUM_US]
+		+= increment_us;
+	ddr->mem_bw_stats[DRMCGRP_MEM_BW_ATTR_TOTAL_ACCUM_US]
+		+= increment_us;
+
+	if ((S64_MAX - new_credit) >
+			ddr->mem_bw_stats[DRMCGRP_MEM_BW_ATTR_BYTE_CREDIT])
+		ddr->mem_bw_stats[DRMCGRP_MEM_BW_ATTR_BYTE_CREDIT]
+			+= new_credit;
+	else
+		ddr->mem_bw_stats[DRMCGRP_MEM_BW_ATTR_BYTE_CREDIT] = S64_MAX;
+
+	ddr->mem_bw_stats_last_update_us = time_us;
+}
+
 void drmcgrp_mem_track_move(struct ttm_buffer_object *old_bo, bool evict,
 		struct ttm_mem_reg *new_mem)
 {
@@ -661,6 +892,7 @@ void drmcgrp_mem_track_move(struct ttm_buffer_object *old_bo, bool evict,
 	int devIdx = dev->primary->index;
 	int old_mem_type = old_bo->mem.mem_type;
 	int new_mem_type = new_mem->mem_type;
+	s64 time_us;
 	struct drmcgrp_device_resource *ddr;
 	struct drmcgrp_device *known_dev;
 
@@ -672,6 +904,14 @@ void drmcgrp_mem_track_move(struct ttm_buffer_object *old_bo, bool evict,
 	old_mem_type = old_mem_type > TTM_PL_PRIV ? TTM_PL_PRIV : old_mem_type;
 	new_mem_type = new_mem_type > TTM_PL_PRIV ? TTM_PL_PRIV : new_mem_type;
 
+	if (root_drmcgrp->dev_resources[devIdx] != NULL &&
+			root_drmcgrp->dev_resources[devIdx]->
+			mem_bw_stats[DRMCGRP_MEM_BW_ATTR_ACCUM_US] >=
+			known_dev->mem_bw_limits_period_in_us)
+		drmcgrp_mem_burst_bw_stats_reset(dev);
+
+	time_us = ktime_to_us(ktime_get());
+
 	mutex_lock(&known_dev->mutex);
 	for ( ; drmcgrp != NULL; drmcgrp = parent_drmcgrp(drmcgrp)) {
 		ddr = drmcgrp->dev_resources[devIdx];
@@ -684,7 +924,70 @@ void drmcgrp_mem_track_move(struct ttm_buffer_object *old_bo, bool evict,
 
 		if (evict)
 			ddr->mem_stats_evict++;
+
+		drmcgrp_mem_bw_accum(time_us, ddr);
+
+		ddr->mem_bw_stats[DRMCGRP_MEM_BW_ATTR_BYTE_MOVED]
+			+= move_in_bytes;
+		ddr->mem_bw_stats[DRMCGRP_MEM_BW_ATTR_TOTAL_BYTE_MOVED]
+			+= move_in_bytes;
+
+		ddr->mem_bw_stats[DRMCGRP_MEM_BW_ATTR_BYTE_CREDIT]
+			-= move_in_bytes;
 	}
 	mutex_unlock(&known_dev->mutex);
 }
 EXPORT_SYMBOL(drmcgrp_mem_track_move);
+
+unsigned int drmcgrp_get_mem_bw_period_in_us(struct ttm_buffer_object *tbo)
+{
+	int devIdx;
+
+	//TODO replace with BUG_ON
+	if (tbo->bdev->ddev == NULL)
+		return 0;
+
+	devIdx = tbo->bdev->ddev->primary->index;
+
+	return (unsigned int) known_drmcgrp_devs[devIdx]->
+		mem_bw_limits_period_in_us;
+}
+EXPORT_SYMBOL(drmcgrp_get_mem_bw_period_in_us);
+
+bool drmcgrp_mem_can_move(struct ttm_buffer_object *tbo)
+{
+	struct drm_device *dev = tbo->bdev->ddev;
+	struct drmcgrp *drmcgrp = tbo->drmcgrp;
+	int devIdx = dev->primary->index;
+	s64 time_us;
+	struct drmcgrp_device_resource *ddr;
+	bool result = true;
+
+	if (root_drmcgrp->dev_resources[devIdx] != NULL &&
+			root_drmcgrp->dev_resources[devIdx]->
+			mem_bw_stats[DRMCGRP_MEM_BW_ATTR_ACCUM_US] >=
+			known_drmcgrp_devs[devIdx]->
+			mem_bw_limits_period_in_us)
+		drmcgrp_mem_burst_bw_stats_reset(dev);
+
+	time_us = ktime_to_us(ktime_get());
+
+	mutex_lock(&known_drmcgrp_devs[devIdx]->mutex);
+	for ( ; drmcgrp != NULL; drmcgrp = parent_drmcgrp(drmcgrp)) {
+		ddr = drmcgrp->dev_resources[devIdx];
+
+		drmcgrp_mem_bw_accum(time_us, ddr);
+
+		if (result &&
+			(ddr->mem_bw_stats[DRMCGRP_MEM_BW_ATTR_BYTE_MOVED]
+			 >= ddr->mem_bw_limits_bytes_in_period ||
+			ddr->mem_bw_stats[DRMCGRP_MEM_BW_ATTR_BYTE_CREDIT]
+			 <= 0)) {
+			result = false;
+		}
+	}
+	mutex_unlock(&known_drmcgrp_devs[devIdx]->mutex);
+
+	return result;
+}
+EXPORT_SYMBOL(drmcgrp_mem_can_move);
-- 
2.21.0


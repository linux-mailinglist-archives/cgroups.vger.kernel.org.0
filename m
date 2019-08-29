Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76F8AA116A
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2019 08:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfH2GGD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Aug 2019 02:06:03 -0400
Received: from mail-eopbgr790084.outbound.protection.outlook.com ([40.107.79.84]:32480
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727437AbfH2GGC (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 29 Aug 2019 02:06:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Achh8SohtSDVEjT+ED4d2EfbhzLYZWiJEFZyRJ/cnczqpNsN2lYB0T3Fwx6OrWvFWyChMNWo524zvmFD5TTzRebn69In0YFfrniIu1cv9ilp//9Cq9FNOtnaHsEQqvQM5rW4mZaa57IMA6Fkvq1RGEbDnHnqOZrE4Lzv8odGUAmT8frBrfKUZysdhIiTzngTPi+K3HzSnlTngVVW2dobmcnmhgHuzIjlwykk/QrKFtHweeCE7FfYQaiXB82npY10l6HmlFUmcOblja+L8vvpLsk4X2HiY/aWvyFTVNqzmajV53+ANzdtL8seK1NJXDo/gWwGb0t6t6O9oKwb6zxqBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aByQ3g8rw8uK5GkiDzLLdxItnWnzAPBvty1600CQzyU=;
 b=Xuebz19k4eRgaaSeb4Vm9ctG3msggeAbzk7DzK1OFtQ0SiO5c9AOXsXMGNXtPFtNC81+8mLIEejLwffrGZPxVCnNXsxtk5KKUPPFXzTNgz5dQudszp0POsrvlfgA+uQm0/8zXe4jW8L3THg6FeBo7vP+ttr8/T5mxckiySQCw4Ajp3F8jybU9dHfzpWdhb/6F3dTrCW8+U/Xki8iI08JSxZUxR2Z11tSVpmF9hP3FwpUxW2B6Fhbzwh4YwDctSPaVT0h1mPfcU/AUZDh5bLq/WODYpvlZEAz/bw2sfa2pGSLck19zTQi7MUf/sbF86AzHD8KNZWQe7NsTr9JzySFPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=cray.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aByQ3g8rw8uK5GkiDzLLdxItnWnzAPBvty1600CQzyU=;
 b=fm0xk+/KMRbUJZ/n2Ei5eVYogoXsm4ra2HIjxbraL1dL0xXnj2RD7U47UcT1DVw8vGnuMgEkDkiHyYMFdwPMyjal/ZmavhMc0mqCe+5vn2qmoK9/+Tc58sThycKA/hrymI8bscMlFpcG89NcpJy03UcIDsQ7qUAHPAjSUkb6kZw=
Received: from CH2PR12CA0005.namprd12.prod.outlook.com (2603:10b6:610:57::15)
 by BN6PR12MB1267.namprd12.prod.outlook.com (2603:10b6:404:17::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.20; Thu, 29 Aug
 2019 06:05:57 +0000
Received: from CO1NAM03FT045.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::200) by CH2PR12CA0005.outlook.office365.com
 (2603:10b6:610:57::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.18 via Frontend
 Transport; Thu, 29 Aug 2019 06:05:57 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; cray.com; dkim=none (message not signed)
 header.d=none;cray.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 CO1NAM03FT045.mail.protection.outlook.com (10.152.81.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2220.16 via Frontend Transport; Thu, 29 Aug 2019 06:05:56 +0000
Received: from kho-5039A.amd.com (10.180.168.240) by SATLEXCHOV01.amd.com
 (10.181.40.71) with Microsoft SMTP Server id 14.3.389.1; Thu, 29 Aug 2019
 01:05:49 -0500
From:   Kenny Ho <Kenny.Ho@amd.com>
To:     <y2kenny@gmail.com>, <cgroups@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <tj@kernel.org>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <felix.kuehling@amd.com>,
        <joseph.greathouse@amd.com>, <jsparks@cray.com>,
        <lkaplan@cray.com>, <daniel@ffwll.ch>
CC:     Kenny Ho <Kenny.Ho@amd.com>
Subject: [PATCH RFC v4 11/16] drm, cgroup: Add per cgroup bw measure and control
Date:   Thu, 29 Aug 2019 02:05:28 -0400
Message-ID: <20190829060533.32315-12-Kenny.Ho@amd.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829060533.32315-1-Kenny.Ho@amd.com>
References: <20190829060533.32315-1-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(4636009)(376002)(39860400002)(346002)(136003)(396003)(2980300002)(428003)(199004)(189003)(5660300002)(86362001)(47776003)(6666004)(356004)(30864003)(1076003)(478600001)(2201001)(2870700001)(2906002)(316002)(70206006)(70586007)(50466002)(110136005)(48376002)(53416004)(426003)(36756003)(4326008)(305945005)(53936002)(8936002)(8676002)(81156014)(186003)(51416003)(2616005)(11346002)(446003)(476003)(76176011)(14444005)(7696005)(126002)(486006)(81166006)(50226002)(336012)(26005)(921003)(1121003)(2101003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1267;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3ef719f-10be-4e09-4beb-08d72c46f565
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328);SRVR:BN6PR12MB1267;
X-MS-TrafficTypeDiagnostic: BN6PR12MB1267:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1267842D5B4FF79AAF5AA7A683A20@BN6PR12MB1267.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-Forefront-PRVS: 0144B30E41
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: w9/3OEuu3j/B00+Rm+G2QSoRWoFYqt5/2S3fQxGb+HFNT5sR4FzAMpRoAf1NaqLDGLfOH933huFclguB0iTHWzBVYLFmb6py8IO9X/KUMMaR/1KkmOsvwuPpjLwajaNoRvz+eoDqZiPoFYlgtpnNS0iylTBxHC/lyZDXMgso9xYvBE0Mp8gKSMDNCLeZPzOBiqcx//U3gcVxY/Vcwjqf7Tmu7vqXlPI7im0AN/Tmt3/aPcw61one/EejchIDj/5zG2SXZEdLcMUcWPONeEeUIT/MburChUxxTDmolPAXqrbTKsI1pl7dgpb5yBoCobxCGilvndqhXB2w+jA3x/yoASCpAcefZXtM7n7bnUkF4o53CjP21/6wXCxxBjt5Hzapvh7JfWAXl5L9B4Xft8mWzJ1kl5Zl+yt0pH74wZ24wd0=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2019 06:05:56.9470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ef719f-10be-4e09-4beb-08d72c46f565
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1267
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
 include/drm/drm_cgroup.h     |  19 +++
 include/linux/cgroup_drm.h   |  16 ++
 kernel/cgroup/drm.c          | 319 ++++++++++++++++++++++++++++++++++-
 4 files changed, 359 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index a0e9ce46baf3..32eee85f3641 100644
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
@@ -1256,6 +1257,12 @@ int ttm_bo_validate(struct ttm_buffer_object *bo,
 	 * Check whether we need to move buffer.
 	 */
 	if (!ttm_bo_mem_compat(placement, &bo->mem, &new_flags)) {
+		unsigned int move_delay = drmcg_get_mem_bw_period_in_us(bo);
+
+		move_delay /= 2000; /* check every half period in ms*/
+		while (bo->bdev->ddev != NULL && !drmcg_mem_can_move(bo))
+			msleep(move_delay);
+
 		ret = ttm_bo_move_buffer(bo, placement, ctx);
 		if (ret)
 			return ret;
diff --git a/include/drm/drm_cgroup.h b/include/drm/drm_cgroup.h
index 7d63f73a5375..9ce0d54e6bd8 100644
--- a/include/drm/drm_cgroup.h
+++ b/include/drm/drm_cgroup.h
@@ -16,6 +16,12 @@ struct drmcg_props {
 
 	s64			bo_limits_total_allocated_default;
 	s64			bo_limits_peak_allocated_default;
+
+	s64			mem_bw_limits_period_in_us;
+	s64			mem_bw_limits_period_in_us_default;
+
+	s64			mem_bw_bytes_in_period_default;
+	s64			mem_bw_avg_bytes_per_us_default;
 };
 
 #ifdef CONFIG_CGROUP_DRM
@@ -30,6 +36,8 @@ void drmcg_chg_mem(struct ttm_buffer_object *tbo);
 void drmcg_unchg_mem(struct ttm_buffer_object *tbo);
 void drmcg_mem_track_move(struct ttm_buffer_object *old_bo, bool evict,
 		struct ttm_mem_reg *new_mem);
+unsigned int drmcg_get_mem_bw_period_in_us(struct ttm_buffer_object *tbo);
+bool drmcg_mem_can_move(struct ttm_buffer_object *tbo);
 
 #else
 static inline void drmcg_device_update(struct drm_device *device)
@@ -62,5 +70,16 @@ static inline void drmcg_mem_track_move(struct ttm_buffer_object *old_bo,
 		bool evict, struct ttm_mem_reg *new_mem)
 {
 }
+
+static inline unsigned int drmcg_get_mem_bw_period_in_us(
+		struct ttm_buffer_object *tbo)
+{
+	return 0;
+}
+
+static inline bool drmcg_mem_can_move(struct ttm_buffer_object *tbo)
+{
+	return true;
+}
 #endif /* CONFIG_CGROUP_DRM */
 #endif /* __DRM_CGROUP_H__ */
diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
index 9579e2a0b71d..27809a583bf2 100644
--- a/include/linux/cgroup_drm.h
+++ b/include/linux/cgroup_drm.h
@@ -14,6 +14,15 @@
 /* limit defined per the way drm_minor_alloc operates */
 #define MAX_DRM_DEV (64 * DRM_MINOR_RENDER)
 
+enum drmcg_mem_bw_attr {
+	DRMCG_MEM_BW_ATTR_BYTE_MOVED, /* for calulating 'instantaneous' bw */
+	DRMCG_MEM_BW_ATTR_ACCUM_US,  /* for calulating 'instantaneous' bw */
+	DRMCG_MEM_BW_ATTR_TOTAL_BYTE_MOVED,
+	DRMCG_MEM_BW_ATTR_TOTAL_ACCUM_US,
+	DRMCG_MEM_BW_ATTR_BYTE_CREDIT,
+	__DRMCG_MEM_BW_ATTR_LAST,
+};
+
 enum drmcg_res_type {
 	DRMCG_TYPE_BO_TOTAL,
 	DRMCG_TYPE_BO_PEAK,
@@ -21,6 +30,8 @@ enum drmcg_res_type {
 	DRMCG_TYPE_MEM,
 	DRMCG_TYPE_MEM_EVICT,
 	DRMCG_TYPE_MEM_PEAK,
+	DRMCG_TYPE_BANDWIDTH,
+	DRMCG_TYPE_BANDWIDTH_PERIOD_BURST,
 	__DRMCG_TYPE_LAST,
 };
 
@@ -40,6 +51,11 @@ struct drmcg_device_resource {
 	s64			mem_stats[TTM_PL_PRIV+1];
 	s64			mem_peaks[TTM_PL_PRIV+1];
 	s64			mem_stats_evict;
+
+	s64			mem_bw_stats_last_update_us;
+	s64			mem_bw_stats[__DRMCG_MEM_BW_ATTR_LAST];
+	s64			mem_bw_limits_bytes_in_period;
+	s64			mem_bw_limits_avg_bytes_per_us;
 };
 
 /**
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
index 899dc44722c3..ab962a277e58 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -7,6 +7,7 @@
 #include <linux/seq_file.h>
 #include <linux/mutex.h>
 #include <linux/cgroup_drm.h>
+#include <linux/ktime.h>
 #include <linux/kernel.h>
 #include <drm/drm_file.h>
 #include <drm/drm_drv.h>
@@ -40,6 +41,17 @@ static char const *ttm_placement_names[] = {
 	[TTM_PL_PRIV]   = "priv",
 };
 
+static char const *mem_bw_attr_names[] = {
+	[DRMCG_MEM_BW_ATTR_BYTE_MOVED] = "moved_byte",
+	[DRMCG_MEM_BW_ATTR_ACCUM_US] = "accum_us",
+	[DRMCG_MEM_BW_ATTR_TOTAL_BYTE_MOVED] = "total_moved_byte",
+	[DRMCG_MEM_BW_ATTR_TOTAL_ACCUM_US] = "total_accum_us",
+	[DRMCG_MEM_BW_ATTR_BYTE_CREDIT] = "byte_credit",
+};
+
+#define MEM_BW_LIMITS_NAME_AVG "avg_bytes_per_us"
+#define MEM_BW_LIMITS_NAME_BURST "bytes_in_period"
+
 static struct drmcg *root_drmcg __read_mostly;
 
 static int drmcg_css_free_fn(int id, void *ptr, void *data)
@@ -75,6 +87,9 @@ static inline int init_drmcg_single(struct drmcg *drmcg, struct drm_device *dev)
 
 		if (!ddr)
 			return -ENOMEM;
+
+		ddr->mem_bw_stats_last_update_us = ktime_to_us(ktime_get());
+		ddr->mem_bw_stats[DRMCG_MEM_BW_ATTR_ACCUM_US] = 1;
 	}
 
 	mutex_lock(&dev->drmcg_mutex);
@@ -87,6 +102,12 @@ static inline int init_drmcg_single(struct drmcg *drmcg, struct drm_device *dev)
 	ddr->bo_limits_peak_allocated =
 		dev->drmcg_props.bo_limits_peak_allocated_default;
 
+	ddr->mem_bw_limits_bytes_in_period =
+		dev->drmcg_props.mem_bw_bytes_in_period_default;
+
+	ddr->mem_bw_limits_avg_bytes_per_us =
+		dev->drmcg_props.mem_bw_avg_bytes_per_us_default;
+
 	mutex_unlock(&dev->drmcg_mutex);
 	return 0;
 }
@@ -133,6 +154,26 @@ drmcg_css_alloc(struct cgroup_subsys_state *parent_css)
 	return &drmcg->css;
 }
 
+static inline void drmcg_mem_burst_bw_stats_reset(struct drm_device *dev)
+{
+	struct cgroup_subsys_state *pos;
+	struct drmcg *node;
+	struct drmcg_device_resource *ddr;
+	int devIdx;
+
+	devIdx =  dev->primary->index;
+
+	rcu_read_lock();
+	css_for_each_descendant_pre(pos, &root_drmcg->css) {
+		node = css_to_drmcg(pos);
+		ddr = node->dev_resources[devIdx];
+
+		ddr->mem_bw_stats[DRMCG_MEM_BW_ATTR_ACCUM_US] = 1;
+		ddr->mem_bw_stats[DRMCG_MEM_BW_ATTR_BYTE_MOVED] = 0;
+	}
+	rcu_read_unlock();
+}
+
 static void drmcg_print_stats(struct drmcg_device_resource *ddr,
 		struct seq_file *sf, enum drmcg_res_type type)
 {
@@ -169,6 +210,31 @@ static void drmcg_print_stats(struct drmcg_device_resource *ddr,
 		}
 		seq_puts(sf, "\n");
 		break;
+	case DRMCG_TYPE_BANDWIDTH:
+		if (ddr->mem_bw_stats[DRMCG_MEM_BW_ATTR_ACCUM_US] == 0)
+			seq_puts(sf, "burst_byte_per_us=NaN ");
+		else
+			seq_printf(sf, "burst_byte_per_us=%lld ",
+				ddr->mem_bw_stats[
+				DRMCG_MEM_BW_ATTR_BYTE_MOVED]/
+				ddr->mem_bw_stats[
+				DRMCG_MEM_BW_ATTR_ACCUM_US]);
+
+		if (ddr->mem_bw_stats[DRMCG_MEM_BW_ATTR_TOTAL_ACCUM_US] == 0)
+			seq_puts(sf, "avg_bytes_per_us=NaN ");
+		else
+			seq_printf(sf, "avg_bytes_per_us=%lld ",
+				ddr->mem_bw_stats[
+				DRMCG_MEM_BW_ATTR_TOTAL_BYTE_MOVED]/
+				ddr->mem_bw_stats[
+				DRMCG_MEM_BW_ATTR_TOTAL_ACCUM_US]);
+
+		for (i = 0; i < __DRMCG_MEM_BW_ATTR_LAST; i++) {
+			seq_printf(sf, "%s=%lld ", mem_bw_attr_names[i],
+					ddr->mem_bw_stats[i]);
+		}
+		seq_puts(sf, "\n");
+		break;
 	default:
 		seq_puts(sf, "\n");
 		break;
@@ -176,7 +242,8 @@ static void drmcg_print_stats(struct drmcg_device_resource *ddr,
 }
 
 static void drmcg_print_limits(struct drmcg_device_resource *ddr,
-		struct seq_file *sf, enum drmcg_res_type type)
+		struct seq_file *sf, enum drmcg_res_type type,
+		struct drm_device *dev)
 {
 	if (ddr == NULL) {
 		seq_puts(sf, "\n");
@@ -190,6 +257,17 @@ static void drmcg_print_limits(struct drmcg_device_resource *ddr,
 	case DRMCG_TYPE_BO_PEAK:
 		seq_printf(sf, "%lld\n", ddr->bo_limits_peak_allocated);
 		break;
+	case DRMCG_TYPE_BANDWIDTH_PERIOD_BURST:
+		seq_printf(sf, "%lld\n",
+			dev->drmcg_props.mem_bw_limits_period_in_us);
+		break;
+	case DRMCG_TYPE_BANDWIDTH:
+		seq_printf(sf, "%s=%lld %s=%lld\n",
+				MEM_BW_LIMITS_NAME_BURST,
+				ddr->mem_bw_limits_bytes_in_period,
+				MEM_BW_LIMITS_NAME_AVG,
+				ddr->mem_bw_limits_avg_bytes_per_us);
+		break;
 	default:
 		seq_puts(sf, "\n");
 		break;
@@ -208,6 +286,17 @@ static void drmcg_print_default(struct drmcg_props *props,
 		seq_printf(sf, "%lld\n",
 			props->bo_limits_peak_allocated_default);
 		break;
+	case DRMCG_TYPE_BANDWIDTH_PERIOD_BURST:
+		seq_printf(sf, "%lld\n",
+			props->mem_bw_limits_period_in_us_default);
+		break;
+	case DRMCG_TYPE_BANDWIDTH:
+		seq_printf(sf, "%s=%lld %s=%lld\n",
+				MEM_BW_LIMITS_NAME_BURST,
+				props->mem_bw_bytes_in_period_default,
+				MEM_BW_LIMITS_NAME_AVG,
+				props->mem_bw_avg_bytes_per_us_default);
+		break;
 	default:
 		seq_puts(sf, "\n");
 		break;
@@ -237,7 +326,7 @@ static int drmcg_seq_show_fn(int id, void *ptr, void *data)
 		drmcg_print_stats(ddr, sf, type);
 		break;
 	case DRMCG_FTYPE_LIMIT:
-		drmcg_print_limits(ddr, sf, type);
+		drmcg_print_limits(ddr, sf, type, minor->dev);
 		break;
 	case DRMCG_FTYPE_DEFAULT:
 		drmcg_print_default(&minor->dev->drmcg_props, sf, type);
@@ -301,6 +390,83 @@ static void drmcg_value_apply(struct drm_device *dev, s64 *dst, s64 val)
 	mutex_unlock(&dev->drmcg_mutex);
 }
 
+static void drmcg_nested_limit_parse(struct kernfs_open_file *of,
+		struct drm_device *dev, char *attrs)
+{
+	enum drmcg_res_type type =
+		DRMCG_CTF_PRIV2RESTYPE(of_cft(of)->private);
+	struct drmcg *drmcg = css_to_drmcg(of_css(of));
+	struct drmcg *parent = drmcg_parent(drmcg);
+	struct drmcg_props *props = &dev->drmcg_props;
+	char *cft_name = of_cft(of)->name;
+	int minor = dev->primary->index;
+	char *nested = strstrip(attrs);
+	struct drmcg_device_resource *ddr =
+		drmcg->dev_resources[minor];
+	char *attr;
+	char sname[256];
+	char sval[256];
+	s64 val;
+	s64 p_max;
+	int rc;
+
+	while (nested != NULL) {
+		attr = strsep(&nested, " ");
+
+		if (sscanf(attr, "%255[^=]=%255[^=]", sname, sval) != 2)
+			continue;
+
+		switch (type) {
+		case DRMCG_TYPE_BANDWIDTH:
+			if (strncmp(sname, MEM_BW_LIMITS_NAME_BURST, 256)
+					== 0) {
+				p_max = parent == NULL ? S64_MAX :
+					parent->dev_resources[minor]->
+					mem_bw_limits_bytes_in_period;
+
+				rc = drmcg_process_limit_s64_val(sval, true,
+					props->mem_bw_bytes_in_period_default,
+					p_max, &val);
+
+				if (rc || val < 0) {
+					drmcg_pr_cft_err(drmcg, rc, cft_name,
+							minor);
+					continue;
+				}
+
+				drmcg_value_apply(dev,
+					&ddr->mem_bw_limits_bytes_in_period,
+					val);
+				continue;
+			}
+
+			if (strncmp(sname, MEM_BW_LIMITS_NAME_AVG, 256) == 0) {
+				p_max = parent == NULL ? S64_MAX :
+					parent->dev_resources[minor]->
+					mem_bw_limits_avg_bytes_per_us;
+
+				rc = drmcg_process_limit_s64_val(sval, true,
+					props->mem_bw_avg_bytes_per_us_default,
+					p_max, &val);
+
+				if (rc || val < 0) {
+					drmcg_pr_cft_err(drmcg, rc, cft_name,
+							minor);
+					continue;
+				}
+
+				drmcg_value_apply(dev,
+					&ddr->mem_bw_limits_avg_bytes_per_us,
+					val);
+				continue;
+			}
+			break; /* DRMCG_TYPE_BANDWIDTH */
+		default:
+			break;
+		} /* switch (type) */
+	}
+}
+
 static ssize_t drmcg_limit_write(struct kernfs_open_file *of, char *buf,
 		size_t nbytes, loff_t off)
 {
@@ -382,6 +548,25 @@ static ssize_t drmcg_limit_write(struct kernfs_open_file *of, char *buf,
 			drmcg_value_apply(dm->dev,
 					&ddr->bo_limits_peak_allocated, val);
 			break;
+		case DRMCG_TYPE_BANDWIDTH_PERIOD_BURST:
+			rc = drmcg_process_limit_s64_val(sattr, false,
+				props->mem_bw_limits_period_in_us_default,
+				S64_MAX,
+				&val);
+
+			if (rc || val < 2000) {
+				drmcg_pr_cft_err(drmcg, rc, cft_name, minor);
+				break;
+			}
+
+			drmcg_value_apply(dm->dev,
+					&props->mem_bw_limits_period_in_us,
+					val);
+			drmcg_mem_burst_bw_stats_reset(dm->dev);
+			break;
+		case DRMCG_TYPE_BANDWIDTH:
+			drmcg_nested_limit_parse(of, dm->dev, sattr);
+			break;
 		default:
 			break;
 		}
@@ -456,6 +641,41 @@ struct cftype files[] = {
 		.private = DRMCG_CTF_PRIV(DRMCG_TYPE_MEM_PEAK,
 						DRMCG_FTYPE_STATS),
 	},
+	{
+		.name = "burst_bw_period_in_us",
+		.write = drmcg_limit_write,
+		.seq_show = drmcg_seq_show,
+		.flags = CFTYPE_ONLY_ON_ROOT,
+		.private = DRMCG_CTF_PRIV(DRMCG_TYPE_BANDWIDTH_PERIOD_BURST,
+						DRMCG_FTYPE_LIMIT),
+	},
+	{
+		.name = "burst_bw_period_in_us.default",
+		.seq_show = drmcg_seq_show,
+		.flags = CFTYPE_ONLY_ON_ROOT,
+		.private = DRMCG_CTF_PRIV(DRMCG_TYPE_BANDWIDTH_PERIOD_BURST,
+						DRMCG_FTYPE_DEFAULT),
+	},
+	{
+		.name = "bandwidth.stats",
+		.seq_show = drmcg_seq_show,
+		.private = DRMCG_CTF_PRIV(DRMCG_TYPE_BANDWIDTH,
+						DRMCG_FTYPE_STATS),
+	},
+	{
+		.name = "bandwidth.high",
+		.write = drmcg_limit_write,
+		.seq_show = drmcg_seq_show,
+		.private = DRMCG_CTF_PRIV(DRMCG_TYPE_BANDWIDTH,
+						DRMCG_FTYPE_LIMIT),
+	},
+	{
+		.name = "bandwidth.default",
+		.seq_show = drmcg_seq_show,
+		.flags = CFTYPE_ONLY_ON_ROOT,
+		.private = DRMCG_CTF_PRIV(DRMCG_TYPE_BANDWIDTH,
+						DRMCG_FTYPE_DEFAULT),
+	},
 	{ }	/* terminate */
 };
 
@@ -515,6 +735,10 @@ void drmcg_device_early_init(struct drm_device *dev)
 
 	dev->drmcg_props.bo_limits_total_allocated_default = S64_MAX;
 	dev->drmcg_props.bo_limits_peak_allocated_default = S64_MAX;
+	dev->drmcg_props.mem_bw_limits_period_in_us_default = 200000;
+	dev->drmcg_props.mem_bw_limits_period_in_us = 200000;
+	dev->drmcg_props.mem_bw_bytes_in_period_default = S64_MAX;
+	dev->drmcg_props.mem_bw_avg_bytes_per_us_default = 65536;
 
 	drmcg_update_cg_tree(dev);
 }
@@ -660,6 +884,27 @@ void drmcg_unchg_mem(struct ttm_buffer_object *tbo)
 }
 EXPORT_SYMBOL(drmcg_unchg_mem);
 
+static inline void drmcg_mem_bw_accum(s64 time_us,
+		struct drmcg_device_resource *ddr)
+{
+	s64 increment_us = time_us - ddr->mem_bw_stats_last_update_us;
+	s64 new_credit = ddr->mem_bw_limits_avg_bytes_per_us * increment_us;
+
+	ddr->mem_bw_stats[DRMCG_MEM_BW_ATTR_ACCUM_US]
+		+= increment_us;
+	ddr->mem_bw_stats[DRMCG_MEM_BW_ATTR_TOTAL_ACCUM_US]
+		+= increment_us;
+
+	if ((S64_MAX - new_credit) >
+			ddr->mem_bw_stats[DRMCG_MEM_BW_ATTR_BYTE_CREDIT])
+		ddr->mem_bw_stats[DRMCG_MEM_BW_ATTR_BYTE_CREDIT]
+			+= new_credit;
+	else
+		ddr->mem_bw_stats[DRMCG_MEM_BW_ATTR_BYTE_CREDIT] = S64_MAX;
+
+	ddr->mem_bw_stats_last_update_us = time_us;
+}
+
 void drmcg_mem_track_move(struct ttm_buffer_object *old_bo, bool evict,
 		struct ttm_mem_reg *new_mem)
 {
@@ -669,6 +914,7 @@ void drmcg_mem_track_move(struct ttm_buffer_object *old_bo, bool evict,
 	int devIdx = dev->primary->index;
 	int old_mem_type = old_bo->mem.mem_type;
 	int new_mem_type = new_mem->mem_type;
+	s64 time_us;
 	struct drmcg_device_resource *ddr;
 
 	if (drmcg == NULL)
@@ -677,6 +923,14 @@ void drmcg_mem_track_move(struct ttm_buffer_object *old_bo, bool evict,
 	old_mem_type = old_mem_type > TTM_PL_PRIV ? TTM_PL_PRIV : old_mem_type;
 	new_mem_type = new_mem_type > TTM_PL_PRIV ? TTM_PL_PRIV : new_mem_type;
 
+	if (root_drmcg->dev_resources[devIdx] != NULL &&
+			root_drmcg->dev_resources[devIdx]->
+			mem_bw_stats[DRMCG_MEM_BW_ATTR_ACCUM_US] >=
+			dev->drmcg_props.mem_bw_limits_period_in_us)
+		drmcg_mem_burst_bw_stats_reset(dev);
+
+	time_us = ktime_to_us(ktime_get());
+
 	mutex_lock(&dev->drmcg_mutex);
 	for ( ; drmcg != NULL; drmcg = drmcg_parent(drmcg)) {
 		ddr = drmcg->dev_resources[devIdx];
@@ -689,7 +943,68 @@ void drmcg_mem_track_move(struct ttm_buffer_object *old_bo, bool evict,
 
 		if (evict)
 			ddr->mem_stats_evict++;
+
+		drmcg_mem_bw_accum(time_us, ddr);
+
+		ddr->mem_bw_stats[DRMCG_MEM_BW_ATTR_BYTE_MOVED]
+			+= move_in_bytes;
+		ddr->mem_bw_stats[DRMCG_MEM_BW_ATTR_TOTAL_BYTE_MOVED]
+			+= move_in_bytes;
+
+		ddr->mem_bw_stats[DRMCG_MEM_BW_ATTR_BYTE_CREDIT]
+			-= move_in_bytes;
 	}
 	mutex_unlock(&dev->drmcg_mutex);
 }
 EXPORT_SYMBOL(drmcg_mem_track_move);
+
+unsigned int drmcg_get_mem_bw_period_in_us(struct ttm_buffer_object *tbo)
+{
+	struct drmcg_props *props;
+
+	//TODO replace with BUG_ON
+	if (tbo->bdev->ddev == NULL)
+		return 0;
+
+	props = &tbo->bdev->ddev->drmcg_props;
+
+	return (unsigned int) props->mem_bw_limits_period_in_us;
+}
+EXPORT_SYMBOL(drmcg_get_mem_bw_period_in_us);
+
+bool drmcg_mem_can_move(struct ttm_buffer_object *tbo)
+{
+	struct drm_device *dev = tbo->bdev->ddev;
+	struct drmcg *drmcg = tbo->drmcg;
+	int devIdx = dev->primary->index;
+	s64 time_us;
+	struct drmcg_device_resource *ddr;
+	bool result = true;
+
+	if (root_drmcg->dev_resources[devIdx] != NULL &&
+			root_drmcg->dev_resources[devIdx]->
+			mem_bw_stats[DRMCG_MEM_BW_ATTR_ACCUM_US] >=
+			dev->drmcg_props.mem_bw_limits_period_in_us)
+		drmcg_mem_burst_bw_stats_reset(dev);
+
+	time_us = ktime_to_us(ktime_get());
+
+	mutex_lock(&dev->drmcg_mutex);
+	for ( ; drmcg != NULL; drmcg = drmcg_parent(drmcg)) {
+		ddr = drmcg->dev_resources[devIdx];
+
+		drmcg_mem_bw_accum(time_us, ddr);
+
+		if (result &&
+			(ddr->mem_bw_stats[DRMCG_MEM_BW_ATTR_BYTE_MOVED]
+			 >= ddr->mem_bw_limits_bytes_in_period ||
+			ddr->mem_bw_stats[DRMCG_MEM_BW_ATTR_BYTE_CREDIT]
+			 <= 0)) {
+			result = false;
+		}
+	}
+	mutex_unlock(&dev->drmcg_mutex);
+
+	return result;
+}
+EXPORT_SYMBOL(drmcg_mem_can_move);
-- 
2.22.0


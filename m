Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5156A116F
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2019 08:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfH2GGG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Aug 2019 02:06:06 -0400
Received: from mail-eopbgr750073.outbound.protection.outlook.com ([40.107.75.73]:48278
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727455AbfH2GGF (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 29 Aug 2019 02:06:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8ZcEto80o7CO4llpG8AdgVpdT1QE5AIdyQJYFEiS0TMqusHz6PckhjMT3cOK0z8Ux7wt+PsvhL8NMIfDdt7LObLvyG2CwWvqslTBjGZJOQt9qPv/GxxA/nWeQ1pe2f0AztrX0Y3lTSwjJiwk1nejwIwl7NZBKasG7vuP6aBfddTqaP/ZFCeXoU/a8IPitnjDW/QbNvAJCdhA16V0peXyR/oWnUaCkX5HOoJy3sfPz7TqkOjCBlJXBIFppx2+VPPyno4pSo7Ik8JmWqLDV7EXjDQkxEIHIEm1rd2Xy1A+nhGg0PVspdtBzkapVJzPoyP/qei/PodJ5ONhSQACtByyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ikXulXvozVVaCx939FypgkWNr6qLB3Y+IHRVJ4CTwE=;
 b=ZTSX2S1gKqqsVoqO+trWGAvFHvPMuEdHE3kAAHzpJCGmq04yPS9hEUqZE48TgHzXzxL+DyKoty6p4uTRHUWb4Xo4v0jPccQTMfmaw8rloESo8qIOvhd/HPp0Harqk6bVN1hWwiCXkgik9nNhGTHVstZ/YYhiosNyWprqucv4r8gVTs6uc7KS1hsfByJ00rvNgOk0XacFPUepuCf6XCXltGpBkwMjOX4KIf7Ag/JZUJz389BGi41OUSzGLWSDrlm9Tg1GsLnjXJNhGDUEKAEFHv4cHz6+gtT4L9DCearjO2O7vi9cUEt/73RncK7DbHgsi5CGg7/1hUKaQ1qmIpBy6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=cray.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ikXulXvozVVaCx939FypgkWNr6qLB3Y+IHRVJ4CTwE=;
 b=4iy0hcSiV+Du/n5wqf9P3CYUtSIrR+0Zv5XONhWnq9l0fVAgl1/y4YJi9Ta+1h6zVfYiz3kOoeRQoK+/dDFReLLhXjGi+yfF5x9aRaYHjhUED9Y4cfgFg6ubMqRmYaWCFLikd7a389b3OIpA4V9UE2WfD6q0+tRc2ggXJv39Z4o=
Received: from CH2PR12CA0011.namprd12.prod.outlook.com (2603:10b6:610:57::21)
 by MWHPR12MB1280.namprd12.prod.outlook.com (2603:10b6:300:12::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2178.19; Thu, 29 Aug
 2019 06:06:01 +0000
Received: from CO1NAM03FT045.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::208) by CH2PR12CA0011.outlook.office365.com
 (2603:10b6:610:57::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.18 via Frontend
 Transport; Thu, 29 Aug 2019 06:06:01 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; cray.com; dkim=none (message not signed)
 header.d=none;cray.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 CO1NAM03FT045.mail.protection.outlook.com (10.152.81.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2220.16 via Frontend Transport; Thu, 29 Aug 2019 06:06:00 +0000
Received: from kho-5039A.amd.com (10.180.168.240) by SATLEXCHOV01.amd.com
 (10.181.40.71) with Microsoft SMTP Server id 14.3.389.1; Thu, 29 Aug 2019
 01:05:52 -0500
From:   Kenny Ho <Kenny.Ho@amd.com>
To:     <y2kenny@gmail.com>, <cgroups@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <tj@kernel.org>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <felix.kuehling@amd.com>,
        <joseph.greathouse@amd.com>, <jsparks@cray.com>,
        <lkaplan@cray.com>, <daniel@ffwll.ch>
CC:     Kenny Ho <Kenny.Ho@amd.com>
Subject: [PATCH RFC v4 14/16] drm, cgroup: Introduce lgpu as DRM cgroup resource
Date:   Thu, 29 Aug 2019 02:05:31 -0400
Message-ID: <20190829060533.32315-15-Kenny.Ho@amd.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829060533.32315-1-Kenny.Ho@amd.com>
References: <20190829060533.32315-1-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(4636009)(396003)(39860400002)(376002)(346002)(136003)(2980300002)(428003)(199004)(189003)(51416003)(76176011)(14444005)(5660300002)(53936002)(486006)(2906002)(4326008)(126002)(478600001)(2870700001)(7696005)(2616005)(86362001)(11346002)(1076003)(476003)(110136005)(2201001)(30864003)(26005)(47776003)(53416004)(36756003)(81156014)(8936002)(81166006)(8676002)(446003)(305945005)(70206006)(316002)(356004)(6666004)(50466002)(48376002)(336012)(426003)(70586007)(186003)(50226002)(921003)(2101003)(83996005)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1280;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 728853de-7870-4644-1edd-08d72c46f7a3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328);SRVR:MWHPR12MB1280;
X-MS-TrafficTypeDiagnostic: MWHPR12MB1280:
X-Microsoft-Antispam-PRVS: <MWHPR12MB12804AC5F0A1FE4431D8108683A20@MWHPR12MB1280.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-Forefront-PRVS: 0144B30E41
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: OQiAUAD/sew0X+5bSOOrWAiBbP81EZyenvO0dfezMW0Y0lU+ttNjKJbv1l9EYZhYSu+EMQPKOR/feJfQF4iVtKjxnFXkwlwDJ8nKlSMWvh/9At53Y2m49DTSjjIETjxwqiesOBC98W0oxoMUloaBGdtVXAMDlOecnRJ+lY5obzh9Mkv+H8F0uKb2PdsWDEWJG1ObUseXZtEZL1ktCQxawsjzU9SrL3OBFZLls2BucI2gRmsiwW0ofS/OGDv7dykq4v0txsb+iuK2R8C4/8OG7XLXSN9xpvrCjTiRSTdeDfnBpJsArCMAJnCPkMNWLnRJ6zM6L2dlDGydPrTIGVZjT7zv0er9/7+eedmnrcMD1CeqZyjepYC75zicEHgQJ56HFo5wv17S/QxXZTQGBbqizjIzO4+NP44PLK37OPj4yfI=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2019 06:06:00.6213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 728853de-7870-4644-1edd-08d72c46f7a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1280
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

drm.lgpu
        A read-write nested-keyed file which exists on all cgroups.
        Each entry is keyed by the DRM device's major:minor.

        lgpu stands for logical GPU, it is an abstraction used to
        subdivide a physical DRM device for the purpose of resource
        management.

        The lgpu is a discrete quantity that is device specific (i.e.
        some DRM devices may have 64 lgpus while others may have 100
        lgpus.)  The lgpu is a single quantity with two representations
        denoted by the following nested keys.

          =====     ========================================
          count     Representing lgpu as anonymous resource
          list      Representing lgpu as named resource
          =====     ========================================

        For example:
        226:0 count=256 list=0-255
        226:1 count=4 list=0,2,4,6
        226:2 count=32 list=32-63

        lgpu is represented by a bitmap and uses the bitmap_parselist
        kernel function so the list key input format is a
        comma-separated list of decimal numbers and ranges.

        Consecutively set bits are shown as two hyphen-separated decimal
        numbers, the smallest and largest bit numbers set in the range.
        Optionally each range can be postfixed to denote that only parts
        of it should be set.  The range will divided to groups of
        specific size.
        Syntax: range:used_size/group_size
        Example: 0-1023:2/256 ==> 0,1,256,257,512,513,768,769

        The count key is the hamming weight / hweight of the bitmap.

        Both count and list accept the max and default keywords.

        Some DRM devices may only support lgpu as anonymous resources.
        In such case, the significance of the position of the set bits
        in list will be ignored.

        This lgpu resource supports the 'allocation' resource
        distribution model.

Change-Id: I1afcacf356770930c7f925df043e51ad06ceb98e
Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  46 ++++++++
 include/drm/drm_cgroup.h                |   4 +
 include/linux/cgroup_drm.h              |   6 ++
 kernel/cgroup/drm.c                     | 135 ++++++++++++++++++++++++
 4 files changed, 191 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 87a195133eaa..57f18469bd76 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1958,6 +1958,52 @@ DRM Interface Files
 	Set largest allocation for /dev/dri/card1 to 4MB
 	echo "226:1 4m" > drm.buffer.peak.max
 
+  drm.lgpu
+	A read-write nested-keyed file which exists on all cgroups.
+	Each entry is keyed by the DRM device's major:minor.
+
+	lgpu stands for logical GPU, it is an abstraction used to
+	subdivide a physical DRM device for the purpose of resource
+	management.
+
+	The lgpu is a discrete quantity that is device specific (i.e.
+	some DRM devices may have 64 lgpus while others may have 100
+	lgpus.)  The lgpu is a single quantity with two representations
+	denoted by the following nested keys.
+
+	  =====     ========================================
+	  count     Representing lgpu as anonymous resource
+	  list      Representing lgpu as named resource
+	  =====     ========================================
+
+	For example:
+	226:0 count=256 list=0-255
+	226:1 count=4 list=0,2,4,6
+	226:2 count=32 list=32-63
+
+	lgpu is represented by a bitmap and uses the bitmap_parselist
+	kernel function so the list key input format is a
+	comma-separated list of decimal numbers and ranges.
+
+	Consecutively set bits are shown as two hyphen-separated decimal
+	numbers, the smallest and largest bit numbers set in the range.
+	Optionally each range can be postfixed to denote that only parts
+	of it should be set.  The range will divided to groups of
+	specific size.
+	Syntax: range:used_size/group_size
+	Example: 0-1023:2/256 ==> 0,1,256,257,512,513,768,769
+
+	The count key is the hamming weight / hweight of the bitmap.
+
+	Both count and list accept the max and default keywords.
+
+	Some DRM devices may only support lgpu as anonymous resources.
+	In such case, the significance of the position of the set bits
+	in list will be ignored.
+
+	This lgpu resource supports the 'allocation' resource
+	distribution model.
+
 GEM Buffer Ownership
 ~~~~~~~~~~~~~~~~~~~~
 
diff --git a/include/drm/drm_cgroup.h b/include/drm/drm_cgroup.h
index 6d9707e1eb72..a8d6be0b075b 100644
--- a/include/drm/drm_cgroup.h
+++ b/include/drm/drm_cgroup.h
@@ -6,6 +6,7 @@
 
 #include <linux/cgroup_drm.h>
 #include <linux/workqueue.h>
+#include <linux/types.h>
 #include <drm/ttm/ttm_bo_api.h>
 #include <drm/ttm/ttm_bo_driver.h>
 
@@ -28,6 +29,9 @@ struct drmcg_props {
 	s64			mem_highs_default[TTM_PL_PRIV+1];
 
 	struct work_struct	*mem_reclaim_wq[TTM_PL_PRIV];
+
+	int			lgpu_capacity;
+        DECLARE_BITMAP(lgpu_slots, MAX_DRMCG_LGPU_CAPACITY);
 };
 
 #ifdef CONFIG_CGROUP_DRM
diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
index c56cfe74d1a6..7b1cfc4ce4c3 100644
--- a/include/linux/cgroup_drm.h
+++ b/include/linux/cgroup_drm.h
@@ -14,6 +14,8 @@
 /* limit defined per the way drm_minor_alloc operates */
 #define MAX_DRM_DEV (64 * DRM_MINOR_RENDER)
 
+#define MAX_DRMCG_LGPU_CAPACITY 256
+
 enum drmcg_mem_bw_attr {
 	DRMCG_MEM_BW_ATTR_BYTE_MOVED, /* for calulating 'instantaneous' bw */
 	DRMCG_MEM_BW_ATTR_ACCUM_US,  /* for calulating 'instantaneous' bw */
@@ -32,6 +34,7 @@ enum drmcg_res_type {
 	DRMCG_TYPE_MEM_PEAK,
 	DRMCG_TYPE_BANDWIDTH,
 	DRMCG_TYPE_BANDWIDTH_PERIOD_BURST,
+	DRMCG_TYPE_LGPU,
 	__DRMCG_TYPE_LAST,
 };
 
@@ -58,6 +61,9 @@ struct drmcg_device_resource {
 	s64			mem_bw_stats[__DRMCG_MEM_BW_ATTR_LAST];
 	s64			mem_bw_limits_bytes_in_period;
 	s64			mem_bw_limits_avg_bytes_per_us;
+
+	s64			lgpu_used;
+	DECLARE_BITMAP(lgpu_allocated, MAX_DRMCG_LGPU_CAPACITY);
 };
 
 /**
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
index 0ea7f0619e25..18c4368e2c29 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -9,6 +9,7 @@
 #include <linux/cgroup_drm.h>
 #include <linux/ktime.h>
 #include <linux/kernel.h>
+#include <linux/bitmap.h>
 #include <drm/drm_file.h>
 #include <drm/drm_drv.h>
 #include <drm/ttm/ttm_bo_api.h>
@@ -52,6 +53,9 @@ static char const *mem_bw_attr_names[] = {
 #define MEM_BW_LIMITS_NAME_AVG "avg_bytes_per_us"
 #define MEM_BW_LIMITS_NAME_BURST "bytes_in_period"
 
+#define LGPU_LIMITS_NAME_LIST "list"
+#define LGPU_LIMITS_NAME_COUNT "count"
+
 static struct drmcg *root_drmcg __read_mostly;
 
 static int drmcg_css_free_fn(int id, void *ptr, void *data)
@@ -115,6 +119,10 @@ static inline int init_drmcg_single(struct drmcg *drmcg, struct drm_device *dev)
 	for (i = 0; i <= TTM_PL_PRIV; i++)
 		ddr->mem_highs[i] = dev->drmcg_props.mem_highs_default[i];
 
+	bitmap_copy(ddr->lgpu_allocated, dev->drmcg_props.lgpu_slots,
+			MAX_DRMCG_LGPU_CAPACITY);
+	ddr->lgpu_used = bitmap_weight(ddr->lgpu_allocated, MAX_DRMCG_LGPU_CAPACITY);
+
 	mutex_unlock(&dev->drmcg_mutex);
 	return 0;
 }
@@ -280,6 +288,14 @@ static void drmcg_print_limits(struct drmcg_device_resource *ddr,
 				MEM_BW_LIMITS_NAME_AVG,
 				ddr->mem_bw_limits_avg_bytes_per_us);
 		break;
+	case DRMCG_TYPE_LGPU:
+		seq_printf(sf, "%s=%lld %s=%*pbl\n",
+				LGPU_LIMITS_NAME_COUNT,
+				ddr->lgpu_used,
+				LGPU_LIMITS_NAME_LIST,
+				dev->drmcg_props.lgpu_capacity,
+				ddr->lgpu_allocated);
+		break;
 	default:
 		seq_puts(sf, "\n");
 		break;
@@ -314,6 +330,15 @@ static void drmcg_print_default(struct drmcg_props *props,
 				MEM_BW_LIMITS_NAME_AVG,
 				props->mem_bw_avg_bytes_per_us_default);
 		break;
+	case DRMCG_TYPE_LGPU:
+		seq_printf(sf, "%s=%d %s=%*pbl\n",
+				LGPU_LIMITS_NAME_COUNT,
+				bitmap_weight(props->lgpu_slots,
+					props->lgpu_capacity),
+				LGPU_LIMITS_NAME_LIST,
+				props->lgpu_capacity,
+				props->lgpu_slots);
+		break;
 	default:
 		seq_puts(sf, "\n");
 		break;
@@ -407,9 +432,21 @@ static void drmcg_value_apply(struct drm_device *dev, s64 *dst, s64 val)
 	mutex_unlock(&dev->drmcg_mutex);
 }
 
+static void drmcg_lgpu_values_apply(struct drm_device *dev,
+		struct drmcg_device_resource *ddr, unsigned long *val)
+{
+
+	mutex_lock(&dev->drmcg_mutex);
+	bitmap_copy(ddr->lgpu_allocated, val, MAX_DRMCG_LGPU_CAPACITY);
+	ddr->lgpu_used = bitmap_weight(ddr->lgpu_allocated, MAX_DRMCG_LGPU_CAPACITY);
+	mutex_unlock(&dev->drmcg_mutex);
+}
+
 static void drmcg_nested_limit_parse(struct kernfs_open_file *of,
 		struct drm_device *dev, char *attrs)
 {
+	DECLARE_BITMAP(tmp_bitmap, MAX_DRMCG_LGPU_CAPACITY);
+	DECLARE_BITMAP(chk_bitmap, MAX_DRMCG_LGPU_CAPACITY);
 	enum drmcg_res_type type =
 		DRMCG_CTF_PRIV2RESTYPE(of_cft(of)->private);
 	struct drmcg *drmcg = css_to_drmcg(of_css(of));
@@ -501,6 +538,83 @@ static void drmcg_nested_limit_parse(struct kernfs_open_file *of,
 				continue;
 			}
 			break; /* DRMCG_TYPE_MEM */
+		case DRMCG_TYPE_LGPU:
+			if (strncmp(sname, LGPU_LIMITS_NAME_LIST, 256) &&
+				strncmp(sname, LGPU_LIMITS_NAME_COUNT, 256) )
+				continue;
+
+                        if (!strcmp("max", sval) ||
+					!strcmp("default", sval)) {
+				if (parent != NULL)
+					drmcg_lgpu_values_apply(dev, ddr,
+						parent->dev_resources[minor]->
+						lgpu_allocated);
+				else
+					drmcg_lgpu_values_apply(dev, ddr,
+						props->lgpu_slots);
+
+				continue;
+			}
+
+			if (strncmp(sname, LGPU_LIMITS_NAME_COUNT, 256) == 0) {
+				p_max = parent == NULL ? props->lgpu_capacity:
+					bitmap_weight(
+					parent->dev_resources[minor]->
+					lgpu_allocated, props->lgpu_capacity);
+
+				rc = drmcg_process_limit_s64_val(sval,
+					false, p_max, p_max, &val);
+
+				if (rc || val < 0) {
+					drmcg_pr_cft_err(drmcg, rc, cft_name,
+							minor);
+					continue;
+				}
+
+				bitmap_zero(tmp_bitmap,
+						MAX_DRMCG_LGPU_CAPACITY);
+				bitmap_set(tmp_bitmap, 0, val);
+			}
+
+			if (strncmp(sname, LGPU_LIMITS_NAME_LIST, 256) == 0) {
+				rc = bitmap_parselist(sval, tmp_bitmap,
+						MAX_DRMCG_LGPU_CAPACITY);
+
+				if (rc) {
+					drmcg_pr_cft_err(drmcg, rc, cft_name,
+							minor);
+					continue;
+				}
+
+                        	bitmap_andnot(chk_bitmap, tmp_bitmap,
+					props->lgpu_slots,
+					MAX_DRMCG_LGPU_CAPACITY);
+
+                        	if (!bitmap_empty(chk_bitmap,
+						MAX_DRMCG_LGPU_CAPACITY)) {
+					drmcg_pr_cft_err(drmcg, 0, cft_name,
+							minor);
+					continue;
+				}
+			}
+
+
+                        if (parent != NULL) {
+				bitmap_and(chk_bitmap, tmp_bitmap,
+				parent->dev_resources[minor]->lgpu_allocated,
+				props->lgpu_capacity);
+
+				if (bitmap_empty(chk_bitmap,
+						props->lgpu_capacity)) {
+					drmcg_pr_cft_err(drmcg, 0,
+							cft_name, minor);
+					continue;
+				}
+			}
+
+			drmcg_lgpu_values_apply(dev, ddr, tmp_bitmap);
+
+			break; /* DRMCG_TYPE_LGPU */
 		default:
 			break;
 		} /* switch (type) */
@@ -606,6 +720,7 @@ static ssize_t drmcg_limit_write(struct kernfs_open_file *of, char *buf,
 			break;
 		case DRMCG_TYPE_BANDWIDTH:
 		case DRMCG_TYPE_MEM:
+		case DRMCG_TYPE_LGPU:
 			drmcg_nested_limit_parse(of, dm->dev, sattr);
 			break;
 		default:
@@ -731,6 +846,20 @@ struct cftype files[] = {
 		.private = DRMCG_CTF_PRIV(DRMCG_TYPE_BANDWIDTH,
 						DRMCG_FTYPE_DEFAULT),
 	},
+	{
+		.name = "lgpu",
+		.seq_show = drmcg_seq_show,
+		.write = drmcg_limit_write,
+		.private = DRMCG_CTF_PRIV(DRMCG_TYPE_LGPU,
+						DRMCG_FTYPE_LIMIT),
+	},
+	{
+		.name = "lgpu.default",
+		.seq_show = drmcg_seq_show,
+		.flags = CFTYPE_ONLY_ON_ROOT,
+		.private = DRMCG_CTF_PRIV(DRMCG_TYPE_LGPU,
+						DRMCG_FTYPE_DEFAULT),
+	},
 	{ }	/* terminate */
 };
 
@@ -744,6 +873,10 @@ struct cgroup_subsys drm_cgrp_subsys = {
 
 static inline void drmcg_update_cg_tree(struct drm_device *dev)
 {
+        bitmap_zero(dev->drmcg_props.lgpu_slots, MAX_DRMCG_LGPU_CAPACITY);
+        bitmap_fill(dev->drmcg_props.lgpu_slots,
+			dev->drmcg_props.lgpu_capacity);
+
 	/* init cgroups created before registration (i.e. root cgroup) */
 	if (root_drmcg != NULL) {
 		struct cgroup_subsys_state *pos;
@@ -800,6 +933,8 @@ void drmcg_device_early_init(struct drm_device *dev)
 	for (i = 0; i <= TTM_PL_PRIV; i++)
 		dev->drmcg_props.mem_highs_default[i] = S64_MAX;
 
+	dev->drmcg_props.lgpu_capacity = MAX_DRMCG_LGPU_CAPACITY;
+
 	drmcg_update_cg_tree(dev);
 }
 EXPORT_SYMBOL(drmcg_device_early_init);
-- 
2.22.0


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE917A115E
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2019 08:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfH2GFz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Aug 2019 02:05:55 -0400
Received: from mail-eopbgr680088.outbound.protection.outlook.com ([40.107.68.88]:63812
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727421AbfH2GFy (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 29 Aug 2019 02:05:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuozhqWmwnYWnN1XJHVe3I+JhFLq4hjA1BEDJ8fhf08e0EowDiXcORAOSKONovsVc5YidLPai6aRXwAyDn33At3BNL5qvqG+ZiPUdk/FsdgViKxMGmr8R0o+yQmt0XK9QyziK4BiNFuq/XzBy979dgRJPoDGD/BhwxRxwurGY5rW/4R12747VFQlhVgjPQ7wcyhvlkgB+maTfyZOwFqEqmTSwmYbXAGMBbd2UFO5nC2FbJ4LeOtYtOQgzIDlCAogULNm7Y0aX59dYlAmE6A+aD91SEdZrcdd/8qqQjKu0/hGcuevZUSFAV2LLwiIcPluQiVdQ8VxgIz7W546JBdjGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKhzoLgZxeM7iusXzsHrw8m/DlzNrtrmWedO5N3GvHw=;
 b=LxNlaprt9kvrXjATWz2PogezDh4OaKlAiqWkYiX2Uf3n1jqGaPnU7WRTkP+Hg07lgpPaQPd/Ed0ikgaxrhvNxAnBFgmc4LlqKmHvTwF5P9Fdws3T3WBK4EVr4ChlZoPg+hsdiSuO+TBNYRa0ZfDJNSccZEn3S1uRHlXFhtFmLoRWa2ycBwSx96QMASkSOJJUCyPbWH1xzVHx+oaTbng7HQ/lVCMZx/k0826DQrSdTlIoqrRQY9VVL3s9BGN8CuvV9l4Vz5Xh+i0AF8mGtKhueG0iz5CJz6XVc2h5P5jVfm4IhjIdAJ4RAr0EA0nQhJUD+dSMMAhhaqaG8LqWQBOEsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=cray.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKhzoLgZxeM7iusXzsHrw8m/DlzNrtrmWedO5N3GvHw=;
 b=jlX0t/NMX3p+u0eG62Ai64Re9Pag5VLEWHabMyCRlNmlk/uBTGiQYfYrATfQ/IbTeXi8nEM8liZE9UYEWPhu+I7ZwWeQo9C2J5hhR920I8N667yUKmIxGvO88oquGJZapZ6YMxroq7bxI+NddEDZ+cpfJ0H4X4x4daehuBfBGds=
Received: from CH2PR12CA0005.namprd12.prod.outlook.com (2603:10b6:610:57::15)
 by SN6PR12MB2719.namprd12.prod.outlook.com (2603:10b6:805:70::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.19; Thu, 29 Aug
 2019 06:05:52 +0000
Received: from CO1NAM03FT045.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::200) by CH2PR12CA0005.outlook.office365.com
 (2603:10b6:610:57::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.18 via Frontend
 Transport; Thu, 29 Aug 2019 06:05:51 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; cray.com; dkim=none (message not signed)
 header.d=none;cray.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 CO1NAM03FT045.mail.protection.outlook.com (10.152.81.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2220.16 via Frontend Transport; Thu, 29 Aug 2019 06:05:51 +0000
Received: from kho-5039A.amd.com (10.180.168.240) by SATLEXCHOV01.amd.com
 (10.181.40.71) with Microsoft SMTP Server id 14.3.389.1; Thu, 29 Aug 2019
 01:05:47 -0500
From:   Kenny Ho <Kenny.Ho@amd.com>
To:     <y2kenny@gmail.com>, <cgroups@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <tj@kernel.org>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <felix.kuehling@amd.com>,
        <joseph.greathouse@amd.com>, <jsparks@cray.com>,
        <lkaplan@cray.com>, <daniel@ffwll.ch>
CC:     Kenny Ho <Kenny.Ho@amd.com>
Subject: [PATCH RFC v4 08/16] drm, cgroup: Add peak GEM buffer allocation limit
Date:   Thu, 29 Aug 2019 02:05:25 -0400
Message-ID: <20190829060533.32315-9-Kenny.Ho@amd.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829060533.32315-1-Kenny.Ho@amd.com>
References: <20190829060533.32315-1-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(346002)(376002)(2980300002)(428003)(189003)(199004)(486006)(476003)(2616005)(126002)(426003)(478600001)(11346002)(356004)(6666004)(8936002)(50226002)(110136005)(305945005)(336012)(26005)(53936002)(186003)(50466002)(446003)(5660300002)(51416003)(2870700001)(7696005)(2906002)(76176011)(81166006)(81156014)(8676002)(36756003)(1076003)(4326008)(70586007)(70206006)(14444005)(48376002)(86362001)(2201001)(53416004)(316002)(47776003)(921003)(2101003)(83996005)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2719;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64e18461-bd51-4153-1b2a-08d72c46f224
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328);SRVR:SN6PR12MB2719;
X-MS-TrafficTypeDiagnostic: SN6PR12MB2719:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2719BF370A536EA025B04AC083A20@SN6PR12MB2719.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0144B30E41
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: jZjWmcrUS2GdN6TRCVLVzIreA6NP7lm5mt8y1jfliOmjcEw9oModdR0xODpy8vdJQACDvz2xaxwDTM6sPkbKrNwuPLT2d/SuiIk8tY7PGtnUEYJWhlJiCSzv2ktS55dVcrJJwJ4Q57Bt62z9Us99AJixDF896GRTM4I1/VqYLENxvMFNXoiXEOyjVqsS5CXaFCLNkbKR4f8oFm642NAj9B4pdoLZ/jskjvCgU9U/LNcwkvFBAOlbkPC+8IYeXmlfybYh1rSSPP8lc3LFTCVRnsowja/rL70Ex7Wlsjfnrm9SZ2Ost3N62SOUWksiLdu7vI1J+eG5ESDdoQgiEKj1n3Y2Bg+UVSuQ1Ymr1/tisnsa5t0CTtP/ZrKFMbp/OQaCI1fOcNj6+DYblx5fdggkv4P/B0x3DFCSZw3iREsAKY4=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2019 06:05:51.4757
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e18461-bd51-4153-1b2a-08d72c46f224
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2719
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

drm.buffer.peak.default
        A read-only flat-keyed file which exists on the root cgroup.
        Each entry is keyed by the drm device's major:minor.

        Default limits on the largest GEM buffer allocation in bytes.

drm.buffer.peak.max
        A read-write flat-keyed file which exists on all cgroups.  Each
        entry is keyed by the drm device's major:minor.

        Per device limits on the largest GEM buffer allocation in bytes.
        This is a hard limit.  Attempts in allocating beyond the cgroup
        limit will result in ENOMEM.  Shorthand understood by memparse
        (such as k, m, g) can be used.

        Set largest allocation for /dev/dri/card1 to 4MB
        echo "226:1 4m" > drm.buffer.peak.max

Change-Id: I0830d56775568e1cf215b56cc892d5e7945e9f25
Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 18 ++++++++++
 include/drm/drm_cgroup.h                |  1 +
 include/linux/cgroup_drm.h              |  1 +
 kernel/cgroup/drm.c                     | 48 +++++++++++++++++++++++++
 4 files changed, 68 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index e8fac2684179..87a195133eaa 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1940,6 +1940,24 @@ DRM Interface Files
 	Set allocation limit for /dev/dri/card0 to 512MB
 	echo "226:0 512m" > drm.buffer.total.max
 
+  drm.buffer.peak.default
+	A read-only flat-keyed file which exists on the root cgroup.
+	Each entry is keyed by the drm device's major:minor.
+
+	Default limits on the largest GEM buffer allocation in bytes.
+    
+  drm.buffer.peak.max
+	A read-write flat-keyed file which exists on all cgroups.  Each
+	entry is keyed by the drm device's major:minor.
+
+	Per device limits on the largest GEM buffer allocation in bytes.
+	This is a hard limit.  Attempts in allocating beyond the cgroup
+	limit will result in ENOMEM.  Shorthand understood by memparse
+	(such as k, m, g) can be used.
+
+	Set largest allocation for /dev/dri/card1 to 4MB
+	echo "226:1 4m" > drm.buffer.peak.max
+
 GEM Buffer Ownership
 ~~~~~~~~~~~~~~~~~~~~
 
diff --git a/include/drm/drm_cgroup.h b/include/drm/drm_cgroup.h
index 49c5d35ff6e1..d61b90beded5 100644
--- a/include/drm/drm_cgroup.h
+++ b/include/drm/drm_cgroup.h
@@ -14,6 +14,7 @@ struct drmcg_props {
 	bool			limit_enforced;
 
 	s64			bo_limits_total_allocated_default;
+	s64			bo_limits_peak_allocated_default;
 };
 
 #ifdef CONFIG_CGROUP_DRM
diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
index eb54e56f20ae..87a2566c9fdd 100644
--- a/include/linux/cgroup_drm.h
+++ b/include/linux/cgroup_drm.h
@@ -29,6 +29,7 @@ struct drmcg_device_resource {
 	s64			bo_limits_total_allocated;
 
 	s64			bo_stats_peak_allocated;
+	s64			bo_limits_peak_allocated;
 
 	s64			bo_stats_count_allocated;
 };
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
index 7161fa40e156..2f54bff291e5 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -75,6 +75,9 @@ static inline int init_drmcg_single(struct drmcg *drmcg, struct drm_device *dev)
 	ddr->bo_limits_total_allocated =
 		dev->drmcg_props.bo_limits_total_allocated_default;
 
+	ddr->bo_limits_peak_allocated =
+		dev->drmcg_props.bo_limits_peak_allocated_default;
+
 	mutex_unlock(&dev->drmcg_mutex);
 	return 0;
 }
@@ -157,6 +160,9 @@ static void drmcg_print_limits(struct drmcg_device_resource *ddr,
 	case DRMCG_TYPE_BO_TOTAL:
 		seq_printf(sf, "%lld\n", ddr->bo_limits_total_allocated);
 		break;
+	case DRMCG_TYPE_BO_PEAK:
+		seq_printf(sf, "%lld\n", ddr->bo_limits_peak_allocated);
+		break;
 	default:
 		seq_puts(sf, "\n");
 		break;
@@ -171,6 +177,10 @@ static void drmcg_print_default(struct drmcg_props *props,
 		seq_printf(sf, "%lld\n",
 			props->bo_limits_total_allocated_default);
 		break;
+	case DRMCG_TYPE_BO_PEAK:
+		seq_printf(sf, "%lld\n",
+			props->bo_limits_peak_allocated_default);
+		break;
 	default:
 		seq_puts(sf, "\n");
 		break;
@@ -327,6 +337,24 @@ static ssize_t drmcg_limit_write(struct kernfs_open_file *of, char *buf,
 			drmcg_value_apply(dm->dev,
 					&ddr->bo_limits_total_allocated, val);
 			break;
+		case DRMCG_TYPE_BO_PEAK:
+			p_max = parent == NULL ? S64_MAX :
+				parent->dev_resources[minor]->
+				bo_limits_peak_allocated;
+
+			rc = drmcg_process_limit_s64_val(sattr, true,
+				props->bo_limits_peak_allocated_default,
+				p_max,
+				&val);
+
+			if (rc || val < 0) {
+				drmcg_pr_cft_err(drmcg, rc, cft_name, minor);
+				break;
+			}
+
+			drmcg_value_apply(dm->dev,
+					&ddr->bo_limits_peak_allocated, val);
+			break;
 		default:
 			break;
 		}
@@ -363,6 +391,20 @@ struct cftype files[] = {
 		.private = DRMCG_CTF_PRIV(DRMCG_TYPE_BO_PEAK,
 						DRMCG_FTYPE_STATS),
 	},
+	{
+		.name = "buffer.peak.default",
+		.seq_show = drmcg_seq_show,
+		.flags = CFTYPE_ONLY_ON_ROOT,
+		.private = DRMCG_CTF_PRIV(DRMCG_TYPE_BO_PEAK,
+						DRMCG_FTYPE_DEFAULT),
+	},
+	{
+		.name = "buffer.peak.max",
+		.write = drmcg_limit_write,
+		.seq_show = drmcg_seq_show,
+		.private = DRMCG_CTF_PRIV(DRMCG_TYPE_BO_PEAK,
+						DRMCG_FTYPE_LIMIT),
+	},
 	{
 		.name = "buffer.count.stats",
 		.seq_show = drmcg_seq_show,
@@ -427,6 +469,7 @@ void drmcg_device_early_init(struct drm_device *dev)
 	dev->drmcg_props.limit_enforced = false;
 
 	dev->drmcg_props.bo_limits_total_allocated_default = S64_MAX;
+	dev->drmcg_props.bo_limits_peak_allocated_default = S64_MAX;
 
 	drmcg_update_cg_tree(dev);
 }
@@ -466,6 +509,11 @@ bool drmcg_try_chg_bo_alloc(struct drmcg *drmcg, struct drm_device *dev,
 				result = false;
 				break;
 			}
+
+			if (ddr->bo_limits_peak_allocated < size) {
+				result = false;
+				break;
+			}
 		}
 	}
 
-- 
2.22.0


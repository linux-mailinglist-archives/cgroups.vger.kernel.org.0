Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99CE356D2C
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2019 17:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfFZPFi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jun 2019 11:05:38 -0400
Received: from mail-eopbgr780049.outbound.protection.outlook.com ([40.107.78.49]:15136
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727543AbfFZPFh (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 26 Jun 2019 11:05:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83ikolpppUs7rb6wD292y/uDlNku2ipE9H78xsGZVLY=;
 b=qWCIdD1En8PCvDN3XCiX8sPRI32ouDpgyBEUGh2Q9901Rjz8wM10AObUlHCs71r0+YYhW4luuyQcIN8u/tuYviLZqsj4NncjDlKXvlF3zVukwYclW9eWXH/kQjswuj2rwQivNBcOj4QWUMAXoOzOiWNrbnxNz+7x8U/pqjLVB9E=
Received: from MWHPR12CA0063.namprd12.prod.outlook.com (10.175.47.153) by
 DM5PR1201MB0028.namprd12.prod.outlook.com (10.174.109.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Wed, 26 Jun 2019 15:05:35 +0000
Received: from DM3NAM03FT041.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::204) by MWHPR12CA0063.outlook.office365.com
 (2603:10b6:300:103::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2008.16 via Frontend
 Transport; Wed, 26 Jun 2019 15:05:35 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV02.amd.com (165.204.84.17) by
 DM3NAM03FT041.mail.protection.outlook.com (10.152.83.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2032.15 via Frontend Transport; Wed, 26 Jun 2019 15:05:35 +0000
Received: from kho-5039A.amd.com (10.180.168.240) by SATLEXCHOV02.amd.com
 (10.181.40.72) with Microsoft SMTP Server id 14.3.389.1; Wed, 26 Jun 2019
 10:05:30 -0500
From:   Kenny Ho <Kenny.Ho@amd.com>
To:     <y2kenny@gmail.com>, <cgroups@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <tj@kernel.org>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <joseph.greathouse@amd.com>,
        <jsparks@cray.com>, <lkaplan@cray.com>
CC:     Kenny Ho <Kenny.Ho@amd.com>
Subject: [RFC PATCH v3 05/11] drm, cgroup: Add peak GEM buffer allocation limit
Date:   Wed, 26 Jun 2019 11:05:16 -0400
Message-ID: <20190626150522.11618-6-Kenny.Ho@amd.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626150522.11618-1-Kenny.Ho@amd.com>
References: <20190626150522.11618-1-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(136003)(376002)(2980300002)(428003)(189003)(199004)(6666004)(76176011)(110136005)(72206003)(5660300002)(53936002)(51416003)(4326008)(70206006)(26005)(77096007)(1076003)(86362001)(186003)(70586007)(7696005)(316002)(336012)(356004)(2201001)(81166006)(8936002)(446003)(11346002)(8676002)(53416004)(426003)(2870700001)(2906002)(68736007)(81156014)(36756003)(478600001)(14444005)(48376002)(50466002)(47776003)(305945005)(486006)(50226002)(476003)(126002)(2616005)(921003)(83996005)(1121003)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR1201MB0028;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40444587-89c9-42a7-2fa7-08d6fa47bddd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:DM5PR1201MB0028;
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0028:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0028B950469A7EC10E4DF4D083E20@DM5PR1201MB0028.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 00808B16F3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: hWiUcZJUbTuEKKY0rFU/eXpzpgxXOyaESh+mhgiT4jTeizTsm3/HqvpdthkFT461hqkFOe0L2jURyWHl9jews9Wk0LnVIREAU6wstSXTHonlbwPMk+h8VrBYhBNlLRDyUzw++G/Yq58wTrBVEkNEDQ3XcGcfltiB7MdDKBro51IPLb8SQxD1pnU+hcyG3C27rlzQuf2vZaWlqMe9i/T/3CrxfGGALecQHqouEQ58WjAGbbLhYLeyWTBgwr7ng0Su40Vg4VdPT3zQ2XnhCCofFoiBzGOJsXxFY0pbYA1JcD9lG7n4JHIyc0AM0dLuxu/1tDVEuk0tCKe1iUIiGis5przfTM4nRcFbrkSIOQhFgBadRN3sgBSq/BB1EvhoTAtgMU6sP+Tu8MphhmASj7vRRTC16cZuTOo6hIjvbmc2lAM=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2019 15:05:35.0422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40444587-89c9-42a7-2fa7-08d6fa47bddd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0028
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

drm.buffer.peak.stats
        A read-only flat-keyed file which exists on all cgroups.  Each
        entry is keyed by the drm device's major:minor.

        Largest GEM buffer allocated in bytes.

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
 include/linux/cgroup_drm.h |  3 ++
 kernel/cgroup/drm.c        | 61 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
index efa019666f1c..126c156ffd70 100644
--- a/include/linux/cgroup_drm.h
+++ b/include/linux/cgroup_drm.h
@@ -17,6 +17,9 @@ struct drmcgrp_device_resource {
 	/* for per device stats */
 	s64			bo_stats_total_allocated;
 	s64			bo_limits_total_allocated;
+
+	size_t			bo_stats_peak_allocated;
+	size_t			bo_limits_peak_allocated;
 };
 
 struct drmcgrp {
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
index cfc1fe74dca3..265008197654 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -19,6 +19,7 @@ struct drmcgrp_device {
 	struct mutex		mutex;
 
 	s64			bo_limits_total_allocated_default;
+	size_t			bo_limits_peak_allocated_default;
 };
 
 #define DRMCG_CTF_PRIV_SIZE 3
@@ -31,6 +32,7 @@ struct drmcgrp_device {
 
 enum drmcgrp_res_type {
 	DRMCGRP_TYPE_BO_TOTAL,
+	DRMCGRP_TYPE_BO_PEAK,
 };
 
 enum drmcgrp_file_type {
@@ -78,6 +80,9 @@ static inline int init_drmcgrp_single(struct drmcgrp *drmcgrp, int minor)
 	if (known_drmcgrp_devs[minor] != NULL) {
 		ddr->bo_limits_total_allocated =
 		  known_drmcgrp_devs[minor]->bo_limits_total_allocated_default;
+
+		ddr->bo_limits_peak_allocated =
+		  known_drmcgrp_devs[minor]->bo_limits_peak_allocated_default;
 	}
 
 	return 0;
@@ -137,6 +142,9 @@ static inline void drmcgrp_print_stats(struct drmcgrp_device_resource *ddr,
 	case DRMCGRP_TYPE_BO_TOTAL:
 		seq_printf(sf, "%lld\n", ddr->bo_stats_total_allocated);
 		break;
+	case DRMCGRP_TYPE_BO_PEAK:
+		seq_printf(sf, "%zu\n", ddr->bo_stats_peak_allocated);
+		break;
 	default:
 		seq_puts(sf, "\n");
 		break;
@@ -155,6 +163,9 @@ static inline void drmcgrp_print_limits(struct drmcgrp_device_resource *ddr,
 	case DRMCGRP_TYPE_BO_TOTAL:
 		seq_printf(sf, "%lld\n", ddr->bo_limits_total_allocated);
 		break;
+	case DRMCGRP_TYPE_BO_PEAK:
+		seq_printf(sf, "%zu\n", ddr->bo_limits_peak_allocated);
+		break;
 	default:
 		seq_puts(sf, "\n");
 		break;
@@ -174,6 +185,10 @@ static inline void drmcgrp_print_default(struct drmcgrp_device *ddev,
 		seq_printf(sf, "%lld\n",
 				ddev->bo_limits_total_allocated_default);
 		break;
+	case DRMCGRP_TYPE_BO_PEAK:
+		seq_printf(sf, "%zu\n",
+				ddev->bo_limits_peak_allocated_default);
+		break;
 	default:
 		seq_puts(sf, "\n");
 		break;
@@ -315,6 +330,23 @@ ssize_t drmcgrp_bo_limit_write(struct kernfs_open_file *of, char *buf,
 
 			ddr->bo_limits_total_allocated = val;
 			break;
+		case DRMCGRP_TYPE_BO_PEAK:
+			p_max = parent == NULL ? SIZE_MAX :
+				parent->dev_resources[minor]->
+				bo_limits_peak_allocated;
+
+			rc = drmcgrp_process_limit_val(sattr, true,
+				ddev->bo_limits_peak_allocated_default,
+				p_max,
+				&val);
+
+			if (rc || val < 0) {
+				drmcgrp_pr_cft_err(drmcgrp, cft_name, minor);
+				continue;
+			}
+
+			ddr->bo_limits_peak_allocated = val;
+			break;
 		default:
 			break;
 		}
@@ -344,6 +376,26 @@ struct cftype files[] = {
 		.private = DRMCG_CTF_PRIV(DRMCGRP_TYPE_BO_TOTAL,
 						DRMCGRP_FTYPE_LIMIT),
 	},
+	{
+		.name = "buffer.peak.stats",
+		.seq_show = drmcgrp_bo_show,
+		.private = DRMCG_CTF_PRIV(DRMCGRP_TYPE_BO_PEAK,
+						DRMCGRP_FTYPE_STATS),
+	},
+	{
+		.name = "buffer.peak.default",
+		.seq_show = drmcgrp_bo_show,
+		.flags = CFTYPE_ONLY_ON_ROOT,
+		.private = DRMCG_CTF_PRIV(DRMCGRP_TYPE_BO_PEAK,
+						DRMCGRP_FTYPE_DEFAULT),
+	},
+	{
+		.name = "buffer.peak.max",
+		.write = drmcgrp_bo_limit_write,
+		.seq_show = drmcgrp_bo_show,
+		.private = DRMCG_CTF_PRIV(DRMCGRP_TYPE_BO_PEAK,
+						DRMCGRP_FTYPE_LIMIT),
+	},
 	{ }	/* terminate */
 };
 
@@ -365,6 +417,7 @@ int drmcgrp_register_device(struct drm_device *dev)
 
 	ddev->dev = dev;
 	ddev->bo_limits_total_allocated_default = S64_MAX;
+	ddev->bo_limits_peak_allocated_default = SIZE_MAX;
 
 	mutex_init(&ddev->mutex);
 
@@ -436,6 +489,11 @@ bool drmcgrp_bo_can_allocate(struct task_struct *task, struct drm_device *dev,
 			result = false;
 			break;
 		}
+
+		if (d->bo_limits_peak_allocated < size) {
+			result = false;
+			break;
+		}
 	}
 	mutex_unlock(&known_drmcgrp_devs[devIdx]->mutex);
 
@@ -457,6 +515,9 @@ void drmcgrp_chg_bo_alloc(struct drmcgrp *drmcgrp, struct drm_device *dev,
 		ddr = drmcgrp->dev_resources[devIdx];
 
 		ddr->bo_stats_total_allocated += (s64)size;
+
+		if (ddr->bo_stats_peak_allocated < (size_t)size)
+			ddr->bo_stats_peak_allocated = (size_t)size;
 	}
 	mutex_unlock(&known_drmcgrp_devs[devIdx]->mutex);
 }
-- 
2.21.0


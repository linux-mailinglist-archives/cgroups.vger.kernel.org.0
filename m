Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA12B19404
	for <lists+cgroups@lfdr.de>; Thu,  9 May 2019 23:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfEIVE4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 May 2019 17:04:56 -0400
Received: from mail-eopbgr690081.outbound.protection.outlook.com ([40.107.69.81]:21078
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725992AbfEIVE4 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 9 May 2019 17:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxfB8umjujUKa550IKO39yIy4Zl3LfD2QKKjPG+Msgg=;
 b=HrrTuh25eUqPy979GWkxIFXJfHBliSGPxA5Znv5LY26uJbRRjiJnHwBo8TrRrQJ7dQdJkWyODzSTCh6JZmKkft8d7h4C3gmAYtykObX/labk6S+VzRSWaYzWewNkUz3S1FncpDZc3MLMGhLpzJgmjSXcA9ASA+TPhVY0lpqBFUk=
Received: from MWHPR12CA0042.namprd12.prod.outlook.com (2603:10b6:301:2::28)
 by MWHPR1201MB0061.namprd12.prod.outlook.com (2603:10b6:301:54::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1856.11; Thu, 9 May
 2019 21:04:53 +0000
Received: from CO1NAM03FT005.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::202) by MWHPR12CA0042.outlook.office365.com
 (2603:10b6:301:2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1878.20 via Frontend
 Transport; Thu, 9 May 2019 21:04:53 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV02.amd.com (165.204.84.17) by
 CO1NAM03FT005.mail.protection.outlook.com (10.152.80.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1856.11 via Frontend Transport; Thu, 9 May 2019 21:04:53 +0000
Received: from kho-5039A.amd.com (10.180.168.240) by SATLEXCHOV02.amd.com
 (10.181.40.72) with Microsoft SMTP Server id 14.3.389.1; Thu, 9 May 2019
 16:04:45 -0500
From:   Kenny Ho <Kenny.Ho@amd.com>
To:     <y2kenny@gmail.com>, <Kenny.Ho@amd.com>, <cgroups@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <tj@kernel.org>, <sunnanyong@huawei.com>,
        <alexander.deucher@amd.com>, <brian.welty@intel.com>
Subject: [RFC PATCH v2 5/5] drm, cgroup: Add peak GEM buffer allocation limit
Date:   Thu, 9 May 2019 17:04:10 -0400
Message-ID: <20190509210410.5471-6-Kenny.Ho@amd.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509210410.5471-1-Kenny.Ho@amd.com>
References: <20181120185814.13362-1-Kenny.Ho@amd.com>
 <20190509210410.5471-1-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(396003)(376002)(2980300002)(428003)(199004)(189003)(81156014)(81166006)(8936002)(68736007)(36756003)(72206003)(50466002)(1076003)(50226002)(8676002)(476003)(478600001)(53936002)(53416004)(48376002)(14444005)(5660300002)(2870700001)(446003)(305945005)(2906002)(11346002)(426003)(2616005)(126002)(6666004)(356004)(336012)(47776003)(7696005)(51416003)(486006)(2201001)(76176011)(77096007)(86362001)(26005)(70206006)(316002)(186003)(70586007)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB0061;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e055f11-83d4-4e02-854b-08d6d4c1fb93
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328);SRVR:MWHPR1201MB0061;
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0061:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0061CDFC7D079C2C432087AB83330@MWHPR1201MB0061.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 003245E729
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Ps+ODp0IwguOyY+6VgoeC6NjqACH/9+Iy5YkyFC3G/Z4ugfx18vukJobaCQuSvrk6poMA9Xgs1lUk3k6Y1m0hdzuZ2KknrYAlrLT0xhUq3+d0//gRSyG/7NE/el0tzFW4D4z+sK4KeYQo0n175Q0C6yAIg5NRoyBvcZFUAlmZ4/bRWGY7sQkiulrQOlwrY4lbhWE57oIoOjWK3011AgpmPkTkF8FPmsJOFY0AnbVqBp4hgga88L84hZ2SaRuNQhSW5o90NPw3lSh17oGeo3+0Hp+Su2FLk4Aoam33blsxzVpuXYZjBN+BJ4HM1IVLiHKKpVH6crSLZCa35uWfBsDRe54TbNNaPC5A9gAp4vPW+mfslruZALM5eUAGk+hjoSfxOhSEgm6vVsaaz9d5WzXA4SDtfDezCU+fbNBrK4bpuA=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2019 21:04:53.1137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e055f11-83d4-4e02-854b-08d6d4c1fb93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0061
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This new drmcgrp resource limits the largest GEM buffer that can be
allocated in a cgroup.

Change-Id: I0830d56775568e1cf215b56cc892d5e7945e9f25
Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>
---
 include/linux/cgroup_drm.h |  2 ++
 kernel/cgroup/drm.c        | 59 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
index fe14ba7bb1cf..57c07a148975 100644
--- a/include/linux/cgroup_drm.h
+++ b/include/linux/cgroup_drm.h
@@ -16,8 +16,10 @@
 struct drmcgrp_device_resource {
 	/* for per device stats */
 	s64			bo_stats_total_allocated;
+	size_t			bo_stats_peak_allocated;
 
 	s64			bo_limits_total_allocated;
+	size_t			bo_limits_peak_allocated;
 };
 
 struct drmcgrp {
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
index bc3abff09113..5c7e1b8059ce 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -17,6 +17,7 @@ struct drmcgrp_device {
 	struct mutex		mutex;
 
 	s64			bo_limits_total_allocated_default;
+	size_t			bo_limits_peak_allocated_default;
 };
 
 #define DRMCG_CTF_PRIV_SIZE 3
@@ -24,6 +25,7 @@ struct drmcgrp_device {
 
 enum drmcgrp_res_type {
 	DRMCGRP_TYPE_BO_TOTAL,
+	DRMCGRP_TYPE_BO_PEAK,
 };
 
 enum drmcgrp_file_type {
@@ -72,6 +74,9 @@ static inline int init_drmcgrp_single(struct drmcgrp *drmcgrp, int i)
 	if (known_drmcgrp_devs[i] != NULL) {
 		ddr->bo_limits_total_allocated =
 		  known_drmcgrp_devs[i]->bo_limits_total_allocated_default;
+
+		ddr->bo_limits_peak_allocated =
+		  known_drmcgrp_devs[i]->bo_limits_peak_allocated_default;
 	}
 
 	return 0;
@@ -131,6 +136,9 @@ static inline void drmcgrp_print_stats(struct drmcgrp_device_resource *ddr,
 	case DRMCGRP_TYPE_BO_TOTAL:
 		seq_printf(sf, "%lld\n", ddr->bo_stats_total_allocated);
 		break;
+	case DRMCGRP_TYPE_BO_PEAK:
+		seq_printf(sf, "%zu\n", ddr->bo_stats_peak_allocated);
+		break;
 	default:
 		seq_puts(sf, "\n");
 		break;
@@ -149,6 +157,9 @@ static inline void drmcgrp_print_limits(struct drmcgrp_device_resource *ddr,
 	case DRMCGRP_TYPE_BO_TOTAL:
 		seq_printf(sf, "%lld\n", ddr->bo_limits_total_allocated);
 		break;
+	case DRMCGRP_TYPE_BO_PEAK:
+		seq_printf(sf, "%zu\n", ddr->bo_limits_peak_allocated);
+		break;
 	default:
 		seq_puts(sf, "\n");
 		break;
@@ -167,6 +178,9 @@ static inline void drmcgrp_print_default(struct drmcgrp_device *ddev,
 	case DRMCGRP_TYPE_BO_TOTAL:
 		seq_printf(sf, "%lld\n", ddev->bo_limits_total_allocated_default);
 		break;
+	case DRMCGRP_TYPE_BO_PEAK:
+		seq_printf(sf, "%zu\n", ddev->bo_limits_peak_allocated_default);
+		break;
 	default:
 		seq_puts(sf, "\n");
 		break;
@@ -182,6 +196,11 @@ static inline void drmcgrp_print_help(int cardNum, struct seq_file *sf,
 		"Total amount of buffer allocation in bytes for card%d\n",
 		cardNum);
 		break;
+	case DRMCGRP_TYPE_BO_PEAK:
+		seq_printf(sf,
+		"Largest buffer allocation in bytes for card%d\n",
+		cardNum);
+		break;
 	default:
 		seq_puts(sf, "\n");
 		break;
@@ -254,6 +273,10 @@ ssize_t drmcgrp_bo_limit_write(struct kernfs_open_file *of, char *buf,
                                 if (val < 0) continue;
 				ddr->bo_limits_total_allocated = val;
 				break;
+			case DRMCGRP_TYPE_BO_PEAK:
+                                if (val < 0) continue;
+				ddr->bo_limits_peak_allocated = val;
+				break;
 			default:
 				break;
 			}
@@ -300,6 +323,33 @@ struct cftype files[] = {
 		.private = (DRMCGRP_TYPE_BO_TOTAL << DRMCG_CTF_PRIV_SIZE) |
 			DRMCGRP_FTYPE_MAX,
 	},
+	{
+		.name = "buffer.peak.stats",
+		.seq_show = drmcgrp_bo_show,
+		.private = (DRMCGRP_TYPE_BO_PEAK << DRMCG_CTF_PRIV_SIZE) |
+			DRMCGRP_FTYPE_STATS,
+	},
+	{
+		.name = "buffer.peak.default",
+		.seq_show = drmcgrp_bo_show,
+		.flags = CFTYPE_ONLY_ON_ROOT,
+		.private = (DRMCGRP_TYPE_BO_PEAK << DRMCG_CTF_PRIV_SIZE) |
+			DRMCGRP_FTYPE_DEFAULT,
+	},
+	{
+		.name = "buffer.peak.help",
+		.seq_show = drmcgrp_bo_show,
+		.flags = CFTYPE_ONLY_ON_ROOT,
+		.private = (DRMCGRP_TYPE_BO_PEAK << DRMCG_CTF_PRIV_SIZE) |
+			DRMCGRP_FTYPE_HELP,
+	},
+	{
+		.name = "buffer.peak.max",
+		.write = drmcgrp_bo_limit_write,
+		.seq_show = drmcgrp_bo_show,
+		.private = (DRMCGRP_TYPE_BO_PEAK << DRMCG_CTF_PRIV_SIZE) |
+			DRMCGRP_FTYPE_MAX,
+	},
 	{ }	/* terminate */
 };
 
@@ -323,6 +373,7 @@ int drmcgrp_register_device(struct drm_device *dev)
 
 	ddev->dev = dev;
 	ddev->bo_limits_total_allocated_default = S64_MAX;
+	ddev->bo_limits_peak_allocated_default = SIZE_MAX;
 
 	mutex_init(&ddev->mutex);
 
@@ -393,6 +444,11 @@ bool drmcgrp_bo_can_allocate(struct task_struct *task, struct drm_device *dev,
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
 
@@ -414,6 +470,9 @@ void drmcgrp_chg_bo_alloc(struct drmcgrp *drmcgrp, struct drm_device *dev,
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


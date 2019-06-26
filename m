Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C816756D2F
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2019 17:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfFZPFk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jun 2019 11:05:40 -0400
Received: from mail-eopbgr750087.outbound.protection.outlook.com ([40.107.75.87]:4342
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727543AbfFZPFk (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 26 Jun 2019 11:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oy70+PsSIFW3ia6hp19FBTQnzI35FoEFw66qRWkUfP8=;
 b=uJfjBQ+Xvo2Juc0ogtNJZAPsvKsUmZFBlTjLia6ENxHTcskhU+1cdO/4RWOOW5qBnX8u4O9nN/CeT0UE33XcMPBppI2ATKWLmWXeUrdOBmuCbfHVMalarqlLNO621/W2fT+8CUJTjotND0xD2dL5kOANDiscdmJvyndzPEhtqoo=
Received: from MWHPR12CA0058.namprd12.prod.outlook.com (2603:10b6:300:103::20)
 by CY4PR12MB1751.namprd12.prod.outlook.com (2603:10b6:903:121::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16; Wed, 26 Jun
 2019 15:05:37 +0000
Received: from DM3NAM03FT041.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::209) by MWHPR12CA0058.outlook.office365.com
 (2603:10b6:300:103::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2008.16 via Frontend
 Transport; Wed, 26 Jun 2019 15:05:36 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV02.amd.com (165.204.84.17) by
 DM3NAM03FT041.mail.protection.outlook.com (10.152.83.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2032.15 via Frontend Transport; Wed, 26 Jun 2019 15:05:36 +0000
Received: from kho-5039A.amd.com (10.180.168.240) by SATLEXCHOV02.amd.com
 (10.181.40.72) with Microsoft SMTP Server id 14.3.389.1; Wed, 26 Jun 2019
 10:05:31 -0500
From:   Kenny Ho <Kenny.Ho@amd.com>
To:     <y2kenny@gmail.com>, <cgroups@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <tj@kernel.org>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <joseph.greathouse@amd.com>,
        <jsparks@cray.com>, <lkaplan@cray.com>
CC:     Kenny Ho <Kenny.Ho@amd.com>
Subject: [RFC PATCH v3 06/11] drm, cgroup: Add GEM buffer allocation count stats
Date:   Wed, 26 Jun 2019 11:05:17 -0400
Message-ID: <20190626150522.11618-7-Kenny.Ho@amd.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626150522.11618-1-Kenny.Ho@amd.com>
References: <20190626150522.11618-1-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(376002)(396003)(2980300002)(428003)(199004)(189003)(53416004)(426003)(77096007)(36756003)(26005)(5660300002)(336012)(186003)(2201001)(70586007)(70206006)(86362001)(47776003)(8936002)(68736007)(4326008)(8676002)(110136005)(316002)(1076003)(81156014)(81166006)(72206003)(478600001)(486006)(50466002)(76176011)(305945005)(50226002)(2616005)(48376002)(476003)(126002)(11346002)(6666004)(446003)(2906002)(53936002)(7696005)(51416003)(14444005)(356004)(2870700001)(921003)(1121003)(2101003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1751;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77ed1547-d3dc-44cd-e4b1-08d6fa47be98
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:CY4PR12MB1751;
X-MS-TrafficTypeDiagnostic: CY4PR12MB1751:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1751D3D5B555690FF5B3CCFB83E20@CY4PR12MB1751.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 00808B16F3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: +XMNoG4oqpvuqahA2k6RjT4YJDlnccDQJToDnhvOiKarrneRZXcLuDqSxQ6rshwCYlpbIw98mPW8xVYWGK09AfJI3I7dxIetzOQ9tjvnHHEq3ovbV1rr10VhzgWXBaV0WHMx2MqRA7QKbIUHu+LhJlc+LkgP1fp4JvWO7mDfBeOi+5b8lNHyEap8WUBnhV0GlBqQWwr/SwqQ1l2XYWglXN43OJ6HcAEi8g0kq2VGBoRuwrvGKVWv3mC9X4ZsQ3AnAQ/XXrRzaErKLJPOnuyJ8Zc0KASRtH+wdkNuzQnWFvq4+G/sFpXV5X8ZeAzcL/BA5AvXhVqC892SBIBJ3J3esxTEL4ZvJw0YAlu7iPqLd6kTiChJXvcQ1xs81KxJY6FYd2Y9Mt46e40pIqqZr39YTm7+QCLO2OSkvlDGbDPHylM=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2019 15:05:36.2493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ed1547-d3dc-44cd-e4b1-08d6fa47be98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1751
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

drm.buffer.count.stats
        A read-only flat-keyed file which exists on all cgroups.  Each
        entry is keyed by the drm device's major:minor.

        Total number of GEM buffer allocated.

Change-Id: Id3e1809d5fee8562e47a7d2b961688956d844ec6
Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>
---
 include/linux/cgroup_drm.h |  2 ++
 kernel/cgroup/drm.c        | 23 ++++++++++++++++++++---
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
index 126c156ffd70..e4400b21ab8e 100644
--- a/include/linux/cgroup_drm.h
+++ b/include/linux/cgroup_drm.h
@@ -20,6 +20,8 @@ struct drmcgrp_device_resource {
 
 	size_t			bo_stats_peak_allocated;
 	size_t			bo_limits_peak_allocated;
+
+	s64			bo_stats_count_allocated;
 };
 
 struct drmcgrp {
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
index 265008197654..9144f93b851f 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -33,6 +33,7 @@ struct drmcgrp_device {
 enum drmcgrp_res_type {
 	DRMCGRP_TYPE_BO_TOTAL,
 	DRMCGRP_TYPE_BO_PEAK,
+	DRMCGRP_TYPE_BO_COUNT,
 };
 
 enum drmcgrp_file_type {
@@ -145,6 +146,9 @@ static inline void drmcgrp_print_stats(struct drmcgrp_device_resource *ddr,
 	case DRMCGRP_TYPE_BO_PEAK:
 		seq_printf(sf, "%zu\n", ddr->bo_stats_peak_allocated);
 		break;
+	case DRMCGRP_TYPE_BO_COUNT:
+		seq_printf(sf, "%lld\n", ddr->bo_stats_count_allocated);
+		break;
 	default:
 		seq_puts(sf, "\n");
 		break;
@@ -396,6 +400,12 @@ struct cftype files[] = {
 		.private = DRMCG_CTF_PRIV(DRMCGRP_TYPE_BO_PEAK,
 						DRMCGRP_FTYPE_LIMIT),
 	},
+	{
+		.name = "buffer.count.stats",
+		.seq_show = drmcgrp_bo_show,
+		.private = DRMCG_CTF_PRIV(DRMCGRP_TYPE_BO_COUNT,
+						DRMCGRP_FTYPE_STATS),
+	},
 	{ }	/* terminate */
 };
 
@@ -518,6 +528,8 @@ void drmcgrp_chg_bo_alloc(struct drmcgrp *drmcgrp, struct drm_device *dev,
 
 		if (ddr->bo_stats_peak_allocated < (size_t)size)
 			ddr->bo_stats_peak_allocated = (size_t)size;
+
+		ddr->bo_stats_count_allocated++;
 	}
 	mutex_unlock(&known_drmcgrp_devs[devIdx]->mutex);
 }
@@ -526,15 +538,20 @@ EXPORT_SYMBOL(drmcgrp_chg_bo_alloc);
 void drmcgrp_unchg_bo_alloc(struct drmcgrp *drmcgrp, struct drm_device *dev,
 		size_t size)
 {
+	struct drmcgrp_device_resource *ddr;
 	int devIdx = dev->primary->index;
 
 	if (drmcgrp == NULL || known_drmcgrp_devs[devIdx] == NULL)
 		return;
 
 	mutex_lock(&known_drmcgrp_devs[devIdx]->mutex);
-	for ( ; drmcgrp != NULL; drmcgrp = parent_drmcgrp(drmcgrp))
-		drmcgrp->dev_resources[devIdx]->bo_stats_total_allocated
-			-= (s64)size;
+	for ( ; drmcgrp != NULL; drmcgrp = parent_drmcgrp(drmcgrp)) {
+		ddr = drmcgrp->dev_resources[devIdx];
+
+		ddr->bo_stats_total_allocated -= (s64)size;
+
+		ddr->bo_stats_count_allocated--;
+	}
 	mutex_unlock(&known_drmcgrp_devs[devIdx]->mutex);
 }
 EXPORT_SYMBOL(drmcgrp_unchg_bo_alloc);
-- 
2.21.0


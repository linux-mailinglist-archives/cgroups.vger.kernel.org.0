Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 017C256D31
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2019 17:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfFZPFm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jun 2019 11:05:42 -0400
Received: from mail-eopbgr780078.outbound.protection.outlook.com ([40.107.78.78]:6784
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728047AbfFZPFm (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 26 Jun 2019 11:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1V3DSHiL6emfOa52C6ir4zWzrOls98N76v201ss0MIY=;
 b=jhIGRbtrGqdtPIIgBw999Ft4O1R2LDhrnaDbnRYYE0ypwIjwatEtaqKuhEjMJdoNRO9JZXWcSRxpHwneQ4IWCeUrlWsB6pkTPHWOMirklcJWVDtc1sP5FUrvzB2ycI1TV8lnz76ORgPn6alIjObaln78KiU6nTghx5bR9HWjagQ=
Received: from MWHPR12CA0058.namprd12.prod.outlook.com (2603:10b6:300:103::20)
 by CY4PR12MB1701.namprd12.prod.outlook.com (2603:10b6:903:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16; Wed, 26 Jun
 2019 15:05:39 +0000
Received: from DM3NAM03FT041.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::209) by MWHPR12CA0058.outlook.office365.com
 (2603:10b6:300:103::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2008.16 via Frontend
 Transport; Wed, 26 Jun 2019 15:05:39 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV02.amd.com (165.204.84.17) by
 DM3NAM03FT041.mail.protection.outlook.com (10.152.83.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2032.15 via Frontend Transport; Wed, 26 Jun 2019 15:05:38 +0000
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
Subject: [RFC PATCH v3 08/11] drm, cgroup: Add TTM buffer peak usage stats
Date:   Wed, 26 Jun 2019 11:05:19 -0400
Message-ID: <20190626150522.11618-9-Kenny.Ho@amd.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626150522.11618-1-Kenny.Ho@amd.com>
References: <20190626150522.11618-1-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(39860400002)(2980300002)(428003)(189003)(199004)(110136005)(186003)(26005)(77096007)(316002)(4326008)(70586007)(70206006)(5660300002)(51416003)(7696005)(50466002)(53936002)(47776003)(86362001)(36756003)(2201001)(48376002)(76176011)(53416004)(8936002)(81166006)(14444005)(68736007)(72206003)(305945005)(81156014)(8676002)(2870700001)(486006)(2906002)(6666004)(478600001)(1076003)(356004)(476003)(126002)(426003)(50226002)(336012)(2616005)(446003)(11346002)(921003)(83996005)(2101003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1701;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cbdd77e-30bf-47f3-0f36-08d6fa47c01f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:CY4PR12MB1701;
X-MS-TrafficTypeDiagnostic: CY4PR12MB1701:
X-Microsoft-Antispam-PRVS: <CY4PR12MB17013AE43CD2A7C0E5335EE583E20@CY4PR12MB1701.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 00808B16F3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: wI8Jq3oRrXKJO6ZGXAfL0HdaLcEjwXUPls+9ZTrADgy4rHhIQDtrucjv4SbSpHm22pb2sUEpAWhziVlfSGU/EyL4JUsaLQ7E9pxItC+cBTaV7NpOsQsHNWy6OfuVueyjBVhXZqLLqhhEhH1CDvby3sWxmd5DWQpNKZ4dpxAIwyzVBXzISkhZ9SIUucsYZ8L2NIVfl0yvCWlzmzOyVEWWmSziK7vpoedyrOOVJoT47i8yBmTy7/wc4kP2HpUYG0+KdRcf7p0YUI0nme9nt8ftP48sxv9WXk/XLcX1BkMAEkcin/GezSnfHJatxp3qcg0t+xKBFe+Dr5kf8JhNZrHczWPy12JHmw8jJ85rly9WP9XLbgPQyaM0eFodfnDe7OG9IKlsC/KCNLPB5C92scJkHYm0P05Qb/OWt4sgXCW/44c=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2019 15:05:38.8373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbdd77e-30bf-47f3-0f36-08d6fa47c01f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1701
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

drm.memory.peak.stats
        A read-only nested-keyed file which exists on all cgroups.
        Each entry is keyed by the drm device's major:minor.  The
        following nested keys are defined.

          ======         ==============================================
          system         Peak host memory used
          tt             Peak host memory used by the device (GTT/GART)
          vram           Peak Video RAM used by the drm device
          priv           Other drm device specific memory peak usage
          ======         ==============================================

        Reading returns the following::

        226:0 system=0 tt=0 vram=0 priv=0
        226:1 system=0 tt=9035776 vram=17768448 priv=16809984
        226:2 system=0 tt=9035776 vram=17768448 priv=16809984

Change-Id: I986e44533848f66411465bdd52105e78105a709a
Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>
---
 include/linux/cgroup_drm.h |  1 +
 kernel/cgroup/drm.c        | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
index 141bea06f74c..922529641df5 100644
--- a/include/linux/cgroup_drm.h
+++ b/include/linux/cgroup_drm.h
@@ -25,6 +25,7 @@ struct drmcgrp_device_resource {
 	s64			bo_stats_count_allocated;
 
 	s64			mem_stats[TTM_PL_PRIV+1];
+	s64			mem_peaks[TTM_PL_PRIV+1];
 	s64			mem_stats_evict;
 };
 
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
index 5aee42a628c1..5f5fa6a2b068 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -38,6 +38,7 @@ enum drmcgrp_res_type {
 	DRMCGRP_TYPE_BO_COUNT,
 	DRMCGRP_TYPE_MEM,
 	DRMCGRP_TYPE_MEM_EVICT,
+	DRMCGRP_TYPE_MEM_PEAK,
 };
 
 enum drmcgrp_file_type {
@@ -171,6 +172,13 @@ static inline void drmcgrp_print_stats(struct drmcgrp_device_resource *ddr,
 	case DRMCGRP_TYPE_MEM_EVICT:
 		seq_printf(sf, "%lld\n", ddr->mem_stats_evict);
 		break;
+	case DRMCGRP_TYPE_MEM_PEAK:
+		for (i = 0; i <= TTM_PL_PRIV; i++) {
+			seq_printf(sf, "%s=%lld ", ttm_placement_names[i],
+					ddr->mem_peaks[i]);
+		}
+		seq_puts(sf, "\n");
+		break;
 	default:
 		seq_puts(sf, "\n");
 		break;
@@ -440,6 +448,12 @@ struct cftype files[] = {
 		.private = DRMCG_CTF_PRIV(DRMCGRP_TYPE_MEM_EVICT,
 						DRMCGRP_FTYPE_STATS),
 	},
+	{
+		.name = "memory.peaks.stats",
+		.seq_show = drmcgrp_bo_show,
+		.private = DRMCG_CTF_PRIV(DRMCGRP_TYPE_MEM_PEAK,
+						DRMCGRP_FTYPE_STATS),
+	},
 	{ }	/* terminate */
 };
 
@@ -608,6 +622,8 @@ void drmcgrp_chg_mem(struct ttm_buffer_object *tbo)
 	for ( ; drmcgrp != NULL; drmcgrp = parent_drmcgrp(drmcgrp)) {
 		ddr = drmcgrp->dev_resources[devIdx];
 		ddr->mem_stats[mem_type] += size;
+		ddr->mem_peaks[mem_type] = max(ddr->mem_peaks[mem_type],
+				ddr->mem_stats[mem_type]);
 	}
 	mutex_unlock(&known_drmcgrp_devs[devIdx]->mutex);
 }
@@ -662,6 +678,10 @@ void drmcgrp_mem_track_move(struct ttm_buffer_object *old_bo, bool evict,
 		ddr->mem_stats[old_mem_type] -= move_in_bytes;
 		ddr->mem_stats[new_mem_type] += move_in_bytes;
 
+		ddr->mem_peaks[new_mem_type] = max(
+				ddr->mem_peaks[new_mem_type],
+				ddr->mem_stats[new_mem_type]);
+
 		if (evict)
 			ddr->mem_stats_evict++;
 	}
-- 
2.21.0


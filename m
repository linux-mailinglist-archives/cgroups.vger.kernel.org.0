Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F212DA1163
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2019 08:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfH2GF7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Aug 2019 02:05:59 -0400
Received: from mail-eopbgr690085.outbound.protection.outlook.com ([40.107.69.85]:5376
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727443AbfH2GF7 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 29 Aug 2019 02:05:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P60zMQj+bQj4QjvRocDDnveHdK+D9t82WtmwIXh9jWdhL384CiVfc8DZCIl5kC9OGSXD63Pl1crwRzDPTEGsGN+yGNmrSBV05afPsb+F3voP9Cb07x7c54GShNekQVuv19noCMUb2X4wqvYGSonkmYpl2vPc9YLetQV4s5BO2jF2nHHCKweuqURsDhTSmuBkgIYoml5UX6XyONvEgtBn9JRg5UhOkMA7xNm1oYCHFySw79D7WmsHYdWF2lrHWh78cpa8+iqCp740V501iqol4w+dC2ezf34KpDRbWJCAvBbvEeRe5XltyXzYQlU9jJO4rXPj+u1Bk06vLgEylwNL9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSYRmemse+JptUHNNHUIBq5v/9pLXrIRh71iG7WhWWk=;
 b=QiCITqSXNfFVlMCFf4MJhf7QGo6u5hEzA2+hb+YkPPOS/csxAT2QPSvYhrZa+99zm8eDW9/o2qwhbvP0xdc/uMjnJK1R1BrzbfTtyZLMUWtzVY73xWepbcdcw8oExdcjKgXy47u1k/a/McMWCjQyjDLME3gk0ROyOVI+gMtDSnsQcbmjCbrAqGJHE+9xfzU47XrnAnArrSE5t6TuurzuAa4YE+g1tLuA0YovGPESv4ay+ft+2smQQggctycCq3kB2++IpMK8iWv7OPLxR+2EqOSoBAij4qqqpAgfJBgIp5lVMXqVO8XxC8sxy9YGQLkL8hOo6q57owpzAIgjuDOFXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=cray.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSYRmemse+JptUHNNHUIBq5v/9pLXrIRh71iG7WhWWk=;
 b=MPsxzYwkwNnhTYZP1Ai5kIvOhvqJWMi4TD8pv1ehjhNtrDJ1AX6T2EseXMD5wkLagQSV421/0XKHQqmY49DWybnSL7nOf7qh6U/rCDgB7V/NmPNHEpcTPoNzLFJ9AygP2To6yd/aDZEZy+N8JrIfoh1cmwQLS5e6m8HHxuHpcaw=
Received: from CH2PR12CA0011.namprd12.prod.outlook.com (2603:10b6:610:57::21)
 by BYAPR12MB2712.namprd12.prod.outlook.com (2603:10b6:a03:68::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.21; Thu, 29 Aug
 2019 06:05:56 +0000
Received: from CO1NAM03FT045.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::208) by CH2PR12CA0011.outlook.office365.com
 (2603:10b6:610:57::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.18 via Frontend
 Transport; Thu, 29 Aug 2019 06:05:55 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; cray.com; dkim=none (message not signed)
 header.d=none;cray.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 CO1NAM03FT045.mail.protection.outlook.com (10.152.81.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2220.16 via Frontend Transport; Thu, 29 Aug 2019 06:05:55 +0000
Received: from kho-5039A.amd.com (10.180.168.240) by SATLEXCHOV01.amd.com
 (10.181.40.71) with Microsoft SMTP Server id 14.3.389.1; Thu, 29 Aug 2019
 01:05:48 -0500
From:   Kenny Ho <Kenny.Ho@amd.com>
To:     <y2kenny@gmail.com>, <cgroups@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <tj@kernel.org>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <felix.kuehling@amd.com>,
        <joseph.greathouse@amd.com>, <jsparks@cray.com>,
        <lkaplan@cray.com>, <daniel@ffwll.ch>
CC:     Kenny Ho <Kenny.Ho@amd.com>
Subject: [PATCH RFC v4 10/16] drm, cgroup: Add TTM buffer peak usage stats
Date:   Thu, 29 Aug 2019 02:05:27 -0400
Message-ID: <20190829060533.32315-11-Kenny.Ho@amd.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829060533.32315-1-Kenny.Ho@amd.com>
References: <20190829060533.32315-1-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(396003)(346002)(39860400002)(2980300002)(428003)(189003)(199004)(126002)(2906002)(476003)(446003)(11346002)(2616005)(486006)(478600001)(305945005)(426003)(50466002)(336012)(8936002)(48376002)(70206006)(2870700001)(50226002)(81166006)(81156014)(186003)(26005)(8676002)(14444005)(53936002)(70586007)(2201001)(316002)(110136005)(4326008)(1076003)(86362001)(47776003)(76176011)(5660300002)(7696005)(51416003)(6666004)(356004)(53416004)(36756003)(921003)(1121003)(83996005)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2712;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b54cefe8-ef75-4b19-6c00-08d72c46f466
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328);SRVR:BYAPR12MB2712;
X-MS-TrafficTypeDiagnostic: BYAPR12MB2712:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2712FC6165DCBBC6F4F6081D83A20@BYAPR12MB2712.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0144B30E41
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: oUHkZpezSqzK6Stn8Fg7f7GgTkTE5ieEf3SQ9YCqWy/5UfHXn5MYm2Ch6tWkt6eNMLw5D22rM7WzO52WcCP3e/6Z/s3kQCR+lLkyBqheTMYIIH7jwFSjWrDde3M87IUwTu+lmnKgMJcQZHnbhh+xmKl9a2gDpIm2odUnX7tXD2E7VCDezSR87lfUWUbY1ivoj4zVciXaVfI2XiY/U51E8TfYU3qdKBxA5HIGY5dFhDo+++4QvCB6Wki/ROJlO2emcuH9AhEiYiz6mIONSVdtJi63mNbgt36qGOcfV4P/kg72wC/vprIHD0sYMpSlodsFRDbpSDKh8/taKOZxJ5rPf1xlYkW5LAYbyahIr/Ed93VMQf9A5w3E3K0MLyZP9mKHkt6EuoSB3v+FTj1usWkUj9NlWw7woVpNK9P2KqpTLtw=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2019 06:05:55.1880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b54cefe8-ef75-4b19-6c00-08d72c46f466
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2712
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
 include/linux/cgroup_drm.h |  2 ++
 kernel/cgroup/drm.c        | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
index 4c2794c9333d..9579e2a0b71d 100644
--- a/include/linux/cgroup_drm.h
+++ b/include/linux/cgroup_drm.h
@@ -20,6 +20,7 @@ enum drmcg_res_type {
 	DRMCG_TYPE_BO_COUNT,
 	DRMCG_TYPE_MEM,
 	DRMCG_TYPE_MEM_EVICT,
+	DRMCG_TYPE_MEM_PEAK,
 	__DRMCG_TYPE_LAST,
 };
 
@@ -37,6 +38,7 @@ struct drmcg_device_resource {
 	s64			bo_stats_count_allocated;
 
 	s64			mem_stats[TTM_PL_PRIV+1];
+	s64			mem_peaks[TTM_PL_PRIV+1];
 	s64			mem_stats_evict;
 };
 
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
index 4960a8d1e8f4..899dc44722c3 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -162,6 +162,13 @@ static void drmcg_print_stats(struct drmcg_device_resource *ddr,
 	case DRMCG_TYPE_MEM_EVICT:
 		seq_printf(sf, "%lld\n", ddr->mem_stats_evict);
 		break;
+	case DRMCG_TYPE_MEM_PEAK:
+		for (i = 0; i <= TTM_PL_PRIV; i++) {
+			seq_printf(sf, "%s=%lld ", ttm_placement_names[i],
+					ddr->mem_peaks[i]);
+		}
+		seq_puts(sf, "\n");
+		break;
 	default:
 		seq_puts(sf, "\n");
 		break;
@@ -443,6 +450,12 @@ struct cftype files[] = {
 		.private = DRMCG_CTF_PRIV(DRMCG_TYPE_MEM_EVICT,
 						DRMCG_FTYPE_STATS),
 	},
+	{
+		.name = "memory.peaks.stats",
+		.seq_show = drmcg_seq_show,
+		.private = DRMCG_CTF_PRIV(DRMCG_TYPE_MEM_PEAK,
+						DRMCG_FTYPE_STATS),
+	},
 	{ }	/* terminate */
 };
 
@@ -617,6 +630,8 @@ void drmcg_chg_mem(struct ttm_buffer_object *tbo)
 	for ( ; drmcg != NULL; drmcg = drmcg_parent(drmcg)) {
 		ddr = drmcg->dev_resources[devIdx];
 		ddr->mem_stats[mem_type] += size;
+		ddr->mem_peaks[mem_type] = max(ddr->mem_peaks[mem_type],
+				ddr->mem_stats[mem_type]);
 	}
 	mutex_unlock(&dev->drmcg_mutex);
 }
@@ -668,6 +683,10 @@ void drmcg_mem_track_move(struct ttm_buffer_object *old_bo, bool evict,
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
2.22.0


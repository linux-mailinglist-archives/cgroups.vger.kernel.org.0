Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62286A115C
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2019 08:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfH2GFx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Aug 2019 02:05:53 -0400
Received: from mail-eopbgr740044.outbound.protection.outlook.com ([40.107.74.44]:3200
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727398AbfH2GFx (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 29 Aug 2019 02:05:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=im8NVAFjE1M5AsM98gB+adyJp2zh7aQj5WF5vZZUSemmfdy/7BaSkJ0RWpZAVOzDUS1DcZ7X7rEy2oM/iNpcGoyKUkwHa7z35FvtrZzUlrVfx60C+t//BDx972TOEoj4Q77K2QX5T5ifXgu7VMVWIRoIU5ihliaCUGl+OaKrs7tTIs+XB2JuOgSbV94tabRliQurPwTtVrBpVIRejK36FOyFi6JKVny4qo5V6SLzVAConQg1bVWORnnYLJXpMGnQHCOykIiKjTVXHb6FIwktHutbRvvFtxeXWOGrHZFlau/TXIj5DIbfW4QQjTaZVrS77VwaMDDetmDN7kE04v12Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuU3MD5G/KwGyScm4WY/+nb67CVxHL9Q8cXeaMI9nno=;
 b=Bmv5uZbEwoz7K9RKYkfOnsFOWFR2NlnOmbGyR2Kc+sp/GOXTlXal5tBn/Kz2SZMs7LK6v1XZKGYWlanD/9ZJQ6co507ySfYL7fZGPn15mieih8nTQ/QQENKkGExmnk9Y4SlX1DJhWwC1id3CtyorKxnUvPp2goK/teW8S90kXzHODJTcCw1+cB0MJ6nm0WEeqB5XePjekeD2PsBqhPqJApFXpudhz3wLS1JTiosyEnyjgSah/YoIRQxh9TBcr63n+PRS74/u7bjFMkbTNix/Y56BUD+Wtmbu0rowoysbVrJ2S2uzne0gL3JsGbJ7CpDlouNjp7pYJcmKbfP7hN4tfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=cray.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuU3MD5G/KwGyScm4WY/+nb67CVxHL9Q8cXeaMI9nno=;
 b=v+w/3TNRyMI/pOQ27dHWhM92m0fPeo7cp/AoLkIkFjtIxANizkFrQRwdisrN/yYH/oPNGvnV6yjGJiIXlgxj6VU6d5hIfnGYV64/NyPf6AOIvuCNnH2d9SGuXGAr2Bli0SZqKacTP2sdRxYPgykPu7f+HMicL1KwMyjVYPi+MXA=
Received: from CH2PR12CA0005.namprd12.prod.outlook.com (2603:10b6:610:57::15)
 by DM5PR12MB1274.namprd12.prod.outlook.com (2603:10b6:3:78::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2178.18; Thu, 29 Aug
 2019 06:05:49 +0000
Received: from CO1NAM03FT045.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::200) by CH2PR12CA0005.outlook.office365.com
 (2603:10b6:610:57::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.18 via Frontend
 Transport; Thu, 29 Aug 2019 06:05:49 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; cray.com; dkim=none (message not signed)
 header.d=none;cray.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 CO1NAM03FT045.mail.protection.outlook.com (10.152.81.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2220.16 via Frontend Transport; Thu, 29 Aug 2019 06:05:48 +0000
Received: from kho-5039A.amd.com (10.180.168.240) by SATLEXCHOV01.amd.com
 (10.181.40.71) with Microsoft SMTP Server id 14.3.389.1; Thu, 29 Aug 2019
 01:05:45 -0500
From:   Kenny Ho <Kenny.Ho@amd.com>
To:     <y2kenny@gmail.com>, <cgroups@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <tj@kernel.org>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <felix.kuehling@amd.com>,
        <joseph.greathouse@amd.com>, <jsparks@cray.com>,
        <lkaplan@cray.com>, <daniel@ffwll.ch>
CC:     Kenny Ho <Kenny.Ho@amd.com>
Subject: [PATCH RFC v4 06/16] drm, cgroup: Add GEM buffer allocation count stats
Date:   Thu, 29 Aug 2019 02:05:23 -0400
Message-ID: <20190829060533.32315-7-Kenny.Ho@amd.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829060533.32315-1-Kenny.Ho@amd.com>
References: <20190829060533.32315-1-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(396003)(39860400002)(136003)(2980300002)(428003)(199004)(189003)(186003)(47776003)(81166006)(81156014)(26005)(2906002)(2870700001)(11346002)(53936002)(70206006)(316002)(476003)(8936002)(14444005)(6666004)(7696005)(51416003)(356004)(478600001)(76176011)(53416004)(305945005)(70586007)(50466002)(86362001)(486006)(48376002)(5660300002)(4326008)(126002)(2616005)(50226002)(446003)(110136005)(36756003)(1076003)(2201001)(336012)(426003)(8676002)(921003)(2101003)(1121003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1274;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32447f36-cf7d-44e3-ad31-08d72c46f09d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328);SRVR:DM5PR12MB1274;
X-MS-TrafficTypeDiagnostic: DM5PR12MB1274:
X-Microsoft-Antispam-PRVS: <DM5PR12MB12746DF3BD9394FD6BA03A6C83A20@DM5PR12MB1274.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0144B30E41
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 5ATGvrApfPfk/JJjeEjh6ymii2NrqmC+wTZx8m9aoa9Li2SP+PVsRtPwXaEBWl1D7R488p/lDk/k6XZhUQjiDMaROaMjv3jv7N3swE5MHIDA1aTZ4oNSsQ3tGGPOUK+C/X69kiIHla/rUPMbCN00n1BtpAyOQcsBCSRMAU+NhyMSqx7O+c7AG0oPivdKDWmeNEstjZH6wwtIwo/bJAng3ruqhUdvQlLs40I3tZBDVxtckgEJNBpE8DMSKIHY16BIgH0Yv30pzv0fZdqOw6bCOHoJOgcUuiNOTUKKm0yZ1sZma5AriJJJ9B098wkBZzE7YUtXh55JLYmLaVGU8bzzYsH/w5u0K8qRrbj1FdxqTVQq3lAEi25simORrik10Hvx9qlyI66cZm/dj/7btDyYhCQ5WhuzPBORwj9WkQFHLb0=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2019 06:05:48.9206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32447f36-cf7d-44e3-ad31-08d72c46f09d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1274
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
 Documentation/admin-guide/cgroup-v2.rst |  6 ++++++
 include/linux/cgroup_drm.h              |  3 +++
 kernel/cgroup/drm.c                     | 22 +++++++++++++++++++---
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 8588a0ffc69d..4dc72339a9b6 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1913,6 +1913,12 @@ DRM Interface Files
 
 	Largest (high water mark) GEM buffer allocated in bytes.
 
+  drm.buffer.count.stats
+	A read-only flat-keyed file which exists on all cgroups.  Each
+	entry is keyed by the drm device's major:minor.
+
+	Total number of GEM buffer allocated.
+
 GEM Buffer Ownership
 ~~~~~~~~~~~~~~~~~~~~
 
diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
index 974d390cfa4f..972f7aa975b5 100644
--- a/include/linux/cgroup_drm.h
+++ b/include/linux/cgroup_drm.h
@@ -16,6 +16,7 @@
 enum drmcg_res_type {
 	DRMCG_TYPE_BO_TOTAL,
 	DRMCG_TYPE_BO_PEAK,
+	DRMCG_TYPE_BO_COUNT,
 	__DRMCG_TYPE_LAST,
 };
 
@@ -27,6 +28,8 @@ struct drmcg_device_resource {
 	s64			bo_stats_total_allocated;
 
 	s64			bo_stats_peak_allocated;
+
+	s64			bo_stats_count_allocated;
 };
 
 /**
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
index 0bf5b95668c4..85e46ece4a82 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -132,6 +132,9 @@ static void drmcg_print_stats(struct drmcg_device_resource *ddr,
 	case DRMCG_TYPE_BO_PEAK:
 		seq_printf(sf, "%lld\n", ddr->bo_stats_peak_allocated);
 		break;
+	case DRMCG_TYPE_BO_COUNT:
+		seq_printf(sf, "%lld\n", ddr->bo_stats_count_allocated);
+		break;
 	default:
 		seq_puts(sf, "\n");
 		break;
@@ -186,6 +189,12 @@ struct cftype files[] = {
 		.private = DRMCG_CTF_PRIV(DRMCG_TYPE_BO_PEAK,
 						DRMCG_FTYPE_STATS),
 	},
+	{
+		.name = "buffer.count.stats",
+		.seq_show = drmcg_seq_show,
+		.private = DRMCG_CTF_PRIV(DRMCG_TYPE_BO_COUNT,
+						DRMCG_FTYPE_STATS),
+	},
 	{ }	/* terminate */
 };
 
@@ -272,6 +281,8 @@ void drmcg_chg_bo_alloc(struct drmcg *drmcg, struct drm_device *dev,
 
 		if (ddr->bo_stats_peak_allocated < (s64)size)
 			ddr->bo_stats_peak_allocated = (s64)size;
+
+		ddr->bo_stats_count_allocated++;
 	}
 	mutex_unlock(&dev->drmcg_mutex);
 }
@@ -289,15 +300,20 @@ EXPORT_SYMBOL(drmcg_chg_bo_alloc);
 void drmcg_unchg_bo_alloc(struct drmcg *drmcg, struct drm_device *dev,
 		size_t size)
 {
+	struct drmcg_device_resource *ddr;
 	int devIdx = dev->primary->index;
 
 	if (drmcg == NULL)
 		return;
 
 	mutex_lock(&dev->drmcg_mutex);
-	for ( ; drmcg != NULL; drmcg = drmcg_parent(drmcg))
-		drmcg->dev_resources[devIdx]->bo_stats_total_allocated
-			-= (s64)size;
+	for ( ; drmcg != NULL; drmcg = drmcg_parent(drmcg)) {
+		ddr = drmcg->dev_resources[devIdx];
+
+		ddr->bo_stats_total_allocated -= (s64)size;
+
+		ddr->bo_stats_count_allocated--;
+	}
 	mutex_unlock(&dev->drmcg_mutex);
 }
 EXPORT_SYMBOL(drmcg_unchg_bo_alloc);
-- 
2.22.0


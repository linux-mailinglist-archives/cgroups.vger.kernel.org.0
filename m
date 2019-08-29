Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94368A116D
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2019 08:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfH2GGF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Aug 2019 02:06:05 -0400
Received: from mail-eopbgr730054.outbound.protection.outlook.com ([40.107.73.54]:56352
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726069AbfH2GGD (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 29 Aug 2019 02:06:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBuRjwJCzGUUBJZCCQ74Iq/c6lhLLjrizY7gZPeOIw+emp/FOGtXMzxYRDTBnP/i1wYO5XWPxcNEvuThcOlDPmrOr658eBNO0K0Rynos9JXPszEpNqHolpMHXP3fKFjKVQsry1hOgdpbGp9vWNsLMMbeAxcPYAQP4D4oNbNplrkKSo4R1UJzmlPWpVzrabkAne0+8lzXsGfcz8A1CtX6Kp6pmbVDLmtpVKHoktwk5IxNP9I+TQUw3+MOjUC/QBuIulogXXTs50DqnK0YBQHMMPcoIkciHglQ8j90rwIDkppsWg/c7pv/CV2oMBIavVhOKj6CKaoPt8oynpvXP36Gpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUTefRHhP4jPk7HjUkR/MCUopIKc0hLAEG/HgFFHU9k=;
 b=HHSUYJaynJcMpFJNf9Cr+QYZ21ioyqd7V/VTlmrJZ+AAnvl0hxmIcDRwYx+AN/vfdUwrzsEJQHvP43RiuTeC5p3/yDVwKjflXYLQCCcSmeK8yh5QRqDJTYOj2Ys7uvOJRDKmBqZbUUkAqQo5V0pwdxG/9+PPAyVyLtXURsz2Vq9+oez2Oly0cRmEapqpM9RZPBMGLpIKpWk/5vHQwmZvsWq/qC1wBwnhJfPfEXrRR0PwzEVy67dHO5b/86ahk+yYLjxGark1Fy1mUdxl/XcwV1VKCbT7LCBm9/LGJV9f4ZHlYBACLu6o2IcKnxBosTWwT1b/mj/P9RO4P0bYZNxAtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=cray.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUTefRHhP4jPk7HjUkR/MCUopIKc0hLAEG/HgFFHU9k=;
 b=jzN+mFFc+4qYtHsla0OEKe6D2wdCWUaDHzLWG1MacGiGMvwRFwfjAFZlCCdj7B8DxMvqJp425EksZ7z7zOgbBjzIs8icunjae/poGS6MbJ1gFUeOvgJ7cjshpAeimyC0P4KJVxY0UV17Z+qElRvQ8tQmXCgSjaUepAG4t0rv3xg=
Received: from CH2PR12CA0005.namprd12.prod.outlook.com (2603:10b6:610:57::15)
 by DM6PR12MB2715.namprd12.prod.outlook.com (2603:10b6:5:4a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.21; Thu, 29 Aug
 2019 06:05:48 +0000
Received: from CO1NAM03FT045.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::200) by CH2PR12CA0005.outlook.office365.com
 (2603:10b6:610:57::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.18 via Frontend
 Transport; Thu, 29 Aug 2019 06:05:48 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; cray.com; dkim=none (message not signed)
 header.d=none;cray.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 CO1NAM03FT045.mail.protection.outlook.com (10.152.81.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2220.16 via Frontend Transport; Thu, 29 Aug 2019 06:05:47 +0000
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
Subject: [PATCH RFC v4 05/16] drm, cgroup: Add peak GEM buffer allocation stats
Date:   Thu, 29 Aug 2019 02:05:22 -0400
Message-ID: <20190829060533.32315-6-Kenny.Ho@amd.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829060533.32315-1-Kenny.Ho@amd.com>
References: <20190829060533.32315-1-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(346002)(376002)(396003)(2980300002)(428003)(199004)(189003)(6666004)(5660300002)(2870700001)(11346002)(478600001)(2201001)(86362001)(2616005)(1076003)(186003)(36756003)(26005)(70586007)(81166006)(336012)(476003)(126002)(356004)(81156014)(70206006)(47776003)(486006)(53936002)(76176011)(48376002)(305945005)(446003)(426003)(2906002)(4326008)(316002)(8936002)(51416003)(7696005)(53416004)(14444005)(50226002)(50466002)(8676002)(110136005)(921003)(83996005)(2101003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2715;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca76ff9d-9db3-4111-832c-08d72c46f000
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328);SRVR:DM6PR12MB2715;
X-MS-TrafficTypeDiagnostic: DM6PR12MB2715:
X-Microsoft-Antispam-PRVS: <DM6PR12MB27154493C51CA0D3E26A7B2D83A20@DM6PR12MB2715.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0144B30E41
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 0XM5WBzGTx5oyxJL4ThUvtNyfVdJQT+9HZj6FIfo9Lt+T2MGu8sERR+OMKA5rkx49ngJRhzijBAGVVzhEGelxnatHFzdSQPu2V5p5tvQr8ZE6tOXuZMhHvBEcivPcaz2dGCFv3hvuSKTcTU9/Z8TWAjzP2UF4wYOD7OMQjbfWjpqV5Ov8CSQUtxqj76Q6HjQ7rMNTDZ7U883movIFZcnKbcNzw5RuqFIPqNhrk8bMXNMcxBOnjhDBL63gZggut6o/fXCBj8tBHiINuwrCC9YHCN/40dTjrWVvEZGaA3gB8CekE6aRqkw33mZj8/BOaN0McmFrmuYglo6rkF9PmkflX1yPvaKam9X0+oH7tF/Ug27ECu//wFyoGTRcwff2ukJsYGsQptSYgHbFc8sWXKi77YA8DxN430CxbGiCxyEkf0=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2019 06:05:47.8790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca76ff9d-9db3-4111-832c-08d72c46f000
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2715
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

drm.buffer.peak.stats
        A read-only flat-keyed file which exists on all cgroups.  Each
        entry is keyed by the drm device's major:minor.

        Largest (high water mark) GEM buffer allocated in bytes.

Change-Id: I79e56222151a3d33a76a61ba0097fe93ebb3449f
Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  6 ++++++
 include/linux/cgroup_drm.h              |  3 +++
 kernel/cgroup/drm.c                     | 12 ++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 0e29d136e2f9..8588a0ffc69d 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1907,6 +1907,12 @@ DRM Interface Files
 
 	Total GEM buffer allocation in bytes.
 
+  drm.buffer.peak.stats
+	A read-only flat-keyed file which exists on all cgroups.  Each
+	entry is keyed by the drm device's major:minor.
+
+	Largest (high water mark) GEM buffer allocated in bytes.
+
 GEM Buffer Ownership
 ~~~~~~~~~~~~~~~~~~~~
 
diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
index 1d8a7f2cdb4e..974d390cfa4f 100644
--- a/include/linux/cgroup_drm.h
+++ b/include/linux/cgroup_drm.h
@@ -15,6 +15,7 @@
 
 enum drmcg_res_type {
 	DRMCG_TYPE_BO_TOTAL,
+	DRMCG_TYPE_BO_PEAK,
 	__DRMCG_TYPE_LAST,
 };
 
@@ -24,6 +25,8 @@ enum drmcg_res_type {
 struct drmcg_device_resource {
 	/* for per device stats */
 	s64			bo_stats_total_allocated;
+
+	s64			bo_stats_peak_allocated;
 };
 
 /**
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
index 87ae9164d8d8..0bf5b95668c4 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -129,6 +129,9 @@ static void drmcg_print_stats(struct drmcg_device_resource *ddr,
 	case DRMCG_TYPE_BO_TOTAL:
 		seq_printf(sf, "%lld\n", ddr->bo_stats_total_allocated);
 		break;
+	case DRMCG_TYPE_BO_PEAK:
+		seq_printf(sf, "%lld\n", ddr->bo_stats_peak_allocated);
+		break;
 	default:
 		seq_puts(sf, "\n");
 		break;
@@ -177,6 +180,12 @@ struct cftype files[] = {
 		.private = DRMCG_CTF_PRIV(DRMCG_TYPE_BO_TOTAL,
 						DRMCG_FTYPE_STATS),
 	},
+	{
+		.name = "buffer.peak.stats",
+		.seq_show = drmcg_seq_show,
+		.private = DRMCG_CTF_PRIV(DRMCG_TYPE_BO_PEAK,
+						DRMCG_FTYPE_STATS),
+	},
 	{ }	/* terminate */
 };
 
@@ -260,6 +269,9 @@ void drmcg_chg_bo_alloc(struct drmcg *drmcg, struct drm_device *dev,
 		ddr = drmcg->dev_resources[devIdx];
 
 		ddr->bo_stats_total_allocated += (s64)size;
+
+		if (ddr->bo_stats_peak_allocated < (s64)size)
+			ddr->bo_stats_peak_allocated = (s64)size;
 	}
 	mutex_unlock(&dev->drmcg_mutex);
 }
-- 
2.22.0


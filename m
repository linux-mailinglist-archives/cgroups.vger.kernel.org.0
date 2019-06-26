Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D62B56D29
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2019 17:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfFZPFe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jun 2019 11:05:34 -0400
Received: from mail-eopbgr780085.outbound.protection.outlook.com ([40.107.78.85]:56240
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727481AbfFZPFe (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 26 Jun 2019 11:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0p3P4yVdgVx46kHS0E6T83+GWZwfheVmXlIy09vAgIk=;
 b=BJvEOfUZzCWXKzkhai4oFHWv2Yhu22FMzt3u6I+s1v1YWSx6ycTjGv44xtk2cUHWlH2Bc7rql0aUQsU/WNzp/W+g5oflAHZ15ibobYjwas1KCpVNEQtW2ADHKDiHEfzVPbTTm5T+vG+2OP5EUMBAl2BFLHnQVdsdg2bPtbb6rSE=
Received: from MWHPR12CA0063.namprd12.prod.outlook.com (10.175.47.153) by
 DM5PR1201MB0028.namprd12.prod.outlook.com (10.174.109.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Wed, 26 Jun 2019 15:05:33 +0000
Received: from DM3NAM03FT041.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::204) by MWHPR12CA0063.outlook.office365.com
 (2603:10b6:300:103::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2008.16 via Frontend
 Transport; Wed, 26 Jun 2019 15:05:32 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV02.amd.com (165.204.84.17) by
 DM3NAM03FT041.mail.protection.outlook.com (10.152.83.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2032.15 via Frontend Transport; Wed, 26 Jun 2019 15:05:31 +0000
Received: from kho-5039A.amd.com (10.180.168.240) by SATLEXCHOV02.amd.com
 (10.181.40.72) with Microsoft SMTP Server id 14.3.389.1; Wed, 26 Jun 2019
 10:05:28 -0500
From:   Kenny Ho <Kenny.Ho@amd.com>
To:     <y2kenny@gmail.com>, <cgroups@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <tj@kernel.org>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <joseph.greathouse@amd.com>,
        <jsparks@cray.com>, <lkaplan@cray.com>
CC:     Kenny Ho <Kenny.Ho@amd.com>
Subject: [RFC PATCH v3 03/11] drm/amdgpu: Register AMD devices for DRM cgroup
Date:   Wed, 26 Jun 2019 11:05:14 -0400
Message-ID: <20190626150522.11618-4-Kenny.Ho@amd.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626150522.11618-1-Kenny.Ho@amd.com>
References: <20190626150522.11618-1-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(136003)(376002)(2980300002)(428003)(189003)(199004)(6666004)(76176011)(110136005)(72206003)(5660300002)(53936002)(51416003)(4326008)(70206006)(26005)(77096007)(1076003)(86362001)(186003)(70586007)(7696005)(316002)(336012)(356004)(2201001)(81166006)(8936002)(446003)(11346002)(8676002)(53416004)(426003)(2870700001)(2906002)(68736007)(81156014)(36756003)(478600001)(48376002)(50466002)(47776003)(305945005)(486006)(50226002)(476003)(126002)(2616005)(921003)(83996005)(1121003)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR1201MB0028;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7b2eeb1-c104-40a8-0e6b-08d6fa47bc0a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:DM5PR1201MB0028;
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0028:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0028E78E3ACD336A8F9CF7A683E20@DM5PR1201MB0028.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-Forefront-PRVS: 00808B16F3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: TuCmM08DqKMLJyKydIc52jYl4x3WFKzX6X6mgvW8UH/27BrK31SNwH9UTXV3F+aCfiJ03cco0iVqFEmLxwgzuAROZ0KoxhfVigED+HJuBLC4a4/qKnMg8t/a+3ZjHmOeKlHrWJaS87sRobQnAEi4CmZ201fHn+xVv2i+tMKxnM12pjktVH/jsg5qm7cdk4k0DpTRL4Xn/1LiqN+qNZ+80X6Nhp9o8AdGbP2KMx6k8vsBYzZTWv1KvB8G8Y9OaKywVeIvSBuIKbuZGQPltd67cZYTTeHYVj7O28lOJ3U4WAk5vzCD087skZXAlEyyV5XZ6xGAm3M2kzjTiOExcRBjTW/mc3EykVJt81lZETv+aUi+tB/mGfkvbSpHsS+auJ5kWP7I9ixFI4gai8Wd+WxWuPrx7TPHFig6Yma4BOwUYbI=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2019 15:05:31.8847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b2eeb1-c104-40a8-0e6b-08d6fa47bc0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0028
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Change-Id: I3750fc657b956b52750a36cb303c54fa6a265b44
Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index da7b4fe8ade3..2568fd730161 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -28,6 +28,7 @@
 #include <drm/drmP.h>
 #include "amdgpu.h"
 #include <drm/amdgpu_drm.h>
+#include <drm/drm_cgroup.h>
 #include "amdgpu_sched.h"
 #include "amdgpu_uvd.h"
 #include "amdgpu_vce.h"
@@ -97,6 +98,7 @@ void amdgpu_driver_unload_kms(struct drm_device *dev)
 
 	amdgpu_device_fini(adev);
 
+	drmcgrp_unregister_device(dev);
 done_free:
 	kfree(adev);
 	dev->dev_private = NULL;
@@ -141,6 +143,8 @@ int amdgpu_driver_load_kms(struct drm_device *dev, unsigned long flags)
 	struct amdgpu_device *adev;
 	int r, acpi_status;
 
+	drmcgrp_register_device(dev);
+
 #ifdef CONFIG_DRM_AMDGPU_SI
 	if (!amdgpu_si_support) {
 		switch (flags & AMD_ASIC_MASK) {
-- 
2.21.0


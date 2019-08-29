Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1306A1155
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2019 08:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbfH2GFq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Aug 2019 02:05:46 -0400
Received: from mail-eopbgr760058.outbound.protection.outlook.com ([40.107.76.58]:58388
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726069AbfH2GFq (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 29 Aug 2019 02:05:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJQR3P6n2DB47SQcCQJWKgvD0foToBUrBqol451/uhxWVLBiNvRhTD+cShp469jC+1jJr1quc+a/ujvk+e4nM9WkJxJwKwjW0RK0lMPZ7dNW7i7XLCS4g+aaZkEosFWX7AUoDcRA2i2Sc2Y+fjJO7at3bZiMDKxzLx9xigKMPOn69Q7bQahgdrKM9zUYG2caYVVLIatExMGGaDQaM4u6iQUJKis8LfXo6iwut6cJqVjmAVDHEiQcrPYlXYc7+pFODUeUeIM1cJutCO9PyEmG0Q4MXOwhTLlPPHSDIJes5caKCz4N/kb258Qx57Vj3lLwUSlt2tDngEj1DA8mDyqP7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDylsBT88o7NNWQhKnnCNGmH7Pj90ESfRt5IG8rGzKs=;
 b=JzSYGib96pScn9ovK0zsD7AuKsMZWNBfG7YvxoSdOhJMyCkqbU414O3oIGjJqRz4RuOQ751MLIe0If05wHFZQ6aHW5D6wiYJO2PaVtew2T9zliWX1T4f95GuShHPhVWWwgcXHGaXCSk2W643uUaDuF74mXc1gPZOZqYIaFLcAQhqGsHnxMG3EdNfaDhRMACoBH+76o7t/yyzySZ02dc65WOrsi3WU9tThoLcfdlEqesN2GhTMqlf1krpOPxtTeXgRPHrod/yll1deo5A4NqKhnnTZMWJWdXD+mIDOFezGbeDt8LFF7fWcS49oQJa/iJu4Tgw7rfH9lpeVONhR39zMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=cray.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDylsBT88o7NNWQhKnnCNGmH7Pj90ESfRt5IG8rGzKs=;
 b=EIS246rBjUHgDzjtmeD3q5CfYwr1c4tbSJ29PYyA9al1OFUnASliG2jy8h/NiPP0dXv3+P0C7GUMqzZgY9yTgd4X/xxFlafBwnNjKoqY4c+RSBNOz6JOjRFwuPiZrAe8+cMzLY+NCYJY7LawZaH3QUe8VvTSD+rsdcv1QkcZb20=
Received: from CH2PR12CA0005.namprd12.prod.outlook.com (2603:10b6:610:57::15)
 by BN7PR12MB2707.namprd12.prod.outlook.com (2603:10b6:408:2f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.20; Thu, 29 Aug
 2019 06:05:43 +0000
Received: from CO1NAM03FT045.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::200) by CH2PR12CA0005.outlook.office365.com
 (2603:10b6:610:57::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.18 via Frontend
 Transport; Thu, 29 Aug 2019 06:05:43 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; cray.com; dkim=none (message not signed)
 header.d=none;cray.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 CO1NAM03FT045.mail.protection.outlook.com (10.152.81.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2220.16 via Frontend Transport; Thu, 29 Aug 2019 06:05:42 +0000
Received: from kho-5039A.amd.com (10.180.168.240) by SATLEXCHOV01.amd.com
 (10.181.40.71) with Microsoft SMTP Server id 14.3.389.1; Thu, 29 Aug 2019
 01:05:41 -0500
From:   Kenny Ho <Kenny.Ho@amd.com>
To:     <y2kenny@gmail.com>, <cgroups@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <tj@kernel.org>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <felix.kuehling@amd.com>,
        <joseph.greathouse@amd.com>, <jsparks@cray.com>,
        <lkaplan@cray.com>, <daniel@ffwll.ch>
CC:     Kenny Ho <Kenny.Ho@amd.com>
Subject: [PATCH RFC v4 01/16] drm: Add drm_minor_for_each
Date:   Thu, 29 Aug 2019 02:05:18 -0400
Message-ID: <20190829060533.32315-2-Kenny.Ho@amd.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829060533.32315-1-Kenny.Ho@amd.com>
References: <20190829060533.32315-1-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(376002)(39860400002)(396003)(2980300002)(428003)(189003)(199004)(1076003)(6666004)(356004)(14444005)(50226002)(70586007)(5660300002)(446003)(426003)(76176011)(53416004)(51416003)(7696005)(305945005)(50466002)(478600001)(48376002)(86362001)(81166006)(81156014)(2201001)(8676002)(36756003)(8936002)(2870700001)(47776003)(2906002)(70206006)(336012)(110136005)(26005)(486006)(186003)(126002)(476003)(2616005)(11346002)(53936002)(316002)(4326008)(921003)(83996005)(1121003)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2707;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97bacf29-fa3f-4cd0-e6eb-08d72c46ecee
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328);SRVR:BN7PR12MB2707;
X-MS-TrafficTypeDiagnostic: BN7PR12MB2707:
X-Microsoft-Antispam-PRVS: <BN7PR12MB27073191400EC7D2A4EEC30083A20@BN7PR12MB2707.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 0144B30E41
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: we+OnEohfE4nnBrZKjoZVMhoKQiOwrBfXKbkgRlIVGrNOOCqKr9OUq6IziPEeDea5DI3xZ4AF6fOolyXGGFUSjf73z+TIkQtALl5Zd9vtthEAq9aeVVriSZkQf8vJiQ4H/G/4Gzc9Z4JlvOSVMiswiqpyNcpCnvXqh4v7MTeYkFtvxjrUIMsGH8I10vwiTprr1aMK0EF2OZ6VDdEqX9lGYMOPF1i/wlFavGIsTgORdBr5iKbLAqNA69IXqUzA3xbP2mWmwfTX/yDeKT35xb/2fMbevEtUOZ5j1MYDCT9avDJt4TJ4QCAyr28ptEOWFqZBaan95w3RPOssdpVvJiunkI1J+dwawzK8FgI4XxMZ2NYsN0ncOdXmmexV/Cox+b2GAYTrntt2650GO/CB4ev5gKcPm4hBI1FLmFf0bxNyiM=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2019 06:05:42.7419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97bacf29-fa3f-4cd0-e6eb-08d72c46ecee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2707
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

To allow other subsystems to iterate through all stored DRM minors and
act upon them.

Also exposes drm_minor_acquire and drm_minor_release for other subsystem
to handle drm_minor.  DRM cgroup controller is the initial consumer of
this new features.

Change-Id: I7c4b67ce6b31f06d1037b03435386ff5b8144ca5
Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>
---
 drivers/gpu/drm/drm_drv.c      | 19 +++++++++++++++++++
 drivers/gpu/drm/drm_internal.h |  4 ----
 include/drm/drm_drv.h          |  4 ++++
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 862621494a93..000cddabd970 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -254,11 +254,13 @@ struct drm_minor *drm_minor_acquire(unsigned int minor_id)
 
 	return minor;
 }
+EXPORT_SYMBOL(drm_minor_acquire);
 
 void drm_minor_release(struct drm_minor *minor)
 {
 	drm_dev_put(minor->dev);
 }
+EXPORT_SYMBOL(drm_minor_release);
 
 /**
  * DOC: driver instance overview
@@ -1078,6 +1080,23 @@ int drm_dev_set_unique(struct drm_device *dev, const char *name)
 }
 EXPORT_SYMBOL(drm_dev_set_unique);
 
+/**
+ * drm_minor_for_each - Iterate through all stored DRM minors
+ * @fn: Function to be called for each pointer.
+ * @data: Data passed to callback function.
+ *
+ * The callback function will be called for each @drm_minor entry, passing
+ * the minor, the entry and @data.
+ *
+ * If @fn returns anything other than %0, the iteration stops and that
+ * value is returned from this function.
+ */
+int drm_minor_for_each(int (*fn)(int id, void *p, void *data), void *data)
+{
+	return idr_for_each(&drm_minors_idr, fn, data);
+}
+EXPORT_SYMBOL(drm_minor_for_each);
+
 /*
  * DRM Core
  * The DRM core module initializes all global DRM objects and makes them
diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
index e19ac7ca602d..6bfad76f8e78 100644
--- a/drivers/gpu/drm/drm_internal.h
+++ b/drivers/gpu/drm/drm_internal.h
@@ -54,10 +54,6 @@ void drm_prime_destroy_file_private(struct drm_prime_file_private *prime_fpriv);
 void drm_prime_remove_buf_handle_locked(struct drm_prime_file_private *prime_fpriv,
 					struct dma_buf *dma_buf);
 
-/* drm_drv.c */
-struct drm_minor *drm_minor_acquire(unsigned int minor_id);
-void drm_minor_release(struct drm_minor *minor);
-
 /* drm_vblank.c */
 void drm_vblank_disable_and_save(struct drm_device *dev, unsigned int pipe);
 void drm_vblank_cleanup(struct drm_device *dev);
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 68ca736c548d..24f8d054c570 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -799,5 +799,9 @@ static inline bool drm_drv_uses_atomic_modeset(struct drm_device *dev)
 
 int drm_dev_set_unique(struct drm_device *dev, const char *name);
 
+int drm_minor_for_each(int (*fn)(int id, void *p, void *data), void *data);
+
+struct drm_minor *drm_minor_acquire(unsigned int minor_id);
+void drm_minor_release(struct drm_minor *minor);
 
 #endif
-- 
2.22.0


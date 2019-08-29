Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3ECEA115D
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2019 08:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfH2GFy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Aug 2019 02:05:54 -0400
Received: from mail-eopbgr720084.outbound.protection.outlook.com ([40.107.72.84]:57712
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727418AbfH2GFx (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 29 Aug 2019 02:05:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vaz14vo3Q6bPFP7zF8uqGICI6I+Q/jzLVu0emk2+9kFr11JngzfOfUDRg4GzjKDofAG5f+JRuNc04/RYeaezG50UlqNoPm/5v21gOTwknsnHhvVytJ94HGNTh4KWv6o+jjxXtqqlDJ9ELRsZttq3Z7XhqYhtRZx+s5eh/foWeLLz8S5aKWa8zmNFZ2xAN1zYgFRUA9UXuN/T9aKt3151ktl/o43y2g3dN2ydMBpYkUGaPJska97VLDlcBejsvx1IrNQ5gSDTwkz2DGqrkA3XVPTklWXo3P0j/yP10Ipfd5azXS+9XJez7By57uYbzcL441wGhRe+FLkVaGjqkZA+DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwhrrpfnjRvIn1W1p0TIz3hJIBNex6hm3VEN6TfrWdI=;
 b=JntC1zxX+J2FfdkzPCOeTqxQDbTJEQlr9OEjGbqY1MfcKcWWtnoILmB7xouLdcdScYG7hYzsGn7DiAs8Z8sJt/l5awyiNH4QOPlJ+1KVznP4JPuYBT+EEgCSC+//h3u80TeT2Rqd3aORYDZi5x9PD5G87MPVkUNDfJ13vxkdPuP6cecB/sjGv1Dv9HF9tHt2mBrN2CRNRfdzie20ZyV6D4Dl7xSdUr1qgmGQWRfY7/gdrLmYDp+EYNGACOmvKBH2Af0zLKpNXsxtrGQbVenSDb+CeChkIuRWxPcPphfDjSLzGqxUTgLs8tT8Ji5sKwoDWjTrThenY7UOl4mu+B2kPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=cray.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwhrrpfnjRvIn1W1p0TIz3hJIBNex6hm3VEN6TfrWdI=;
 b=liTNHPrtqrcLks7OIjXZM3b2T0kLSGtTvqF56hi69Xunots8APtgqkn4+anOejaEayR1oJfkJlhcfV4vFeptAl+S+m1MXkqwfjEW5txHmExH0ep0E+XfsjFONcPX6xUpOidchfhRwgd6Rnq4jliB0xf0igC1sa0xbIaqEMkW7GA=
Received: from CH2PR12CA0005.namprd12.prod.outlook.com (2603:10b6:610:57::15)
 by CY4PR12MB1272.namprd12.prod.outlook.com (2603:10b6:903:3e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2178.16; Thu, 29 Aug
 2019 06:05:51 +0000
Received: from CO1NAM03FT045.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::200) by CH2PR12CA0005.outlook.office365.com
 (2603:10b6:610:57::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.18 via Frontend
 Transport; Thu, 29 Aug 2019 06:05:50 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; cray.com; dkim=none (message not signed)
 header.d=none;cray.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 CO1NAM03FT045.mail.protection.outlook.com (10.152.81.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2220.16 via Frontend Transport; Thu, 29 Aug 2019 06:05:50 +0000
Received: from kho-5039A.amd.com (10.180.168.240) by SATLEXCHOV01.amd.com
 (10.181.40.71) with Microsoft SMTP Server id 14.3.389.1; Thu, 29 Aug 2019
 01:05:46 -0500
From:   Kenny Ho <Kenny.Ho@amd.com>
To:     <y2kenny@gmail.com>, <cgroups@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <tj@kernel.org>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <felix.kuehling@amd.com>,
        <joseph.greathouse@amd.com>, <jsparks@cray.com>,
        <lkaplan@cray.com>, <daniel@ffwll.ch>
CC:     Kenny Ho <Kenny.Ho@amd.com>
Subject: [PATCH RFC v4 07/16] drm, cgroup: Add total GEM buffer allocation limit
Date:   Thu, 29 Aug 2019 02:05:24 -0400
Message-ID: <20190829060533.32315-8-Kenny.Ho@amd.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829060533.32315-1-Kenny.Ho@amd.com>
References: <20190829060533.32315-1-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(346002)(396003)(39860400002)(2980300002)(428003)(199004)(189003)(47776003)(336012)(478600001)(30864003)(126002)(81166006)(5660300002)(70586007)(53416004)(70206006)(186003)(86362001)(305945005)(486006)(11346002)(446003)(426003)(76176011)(48376002)(50466002)(36756003)(2906002)(476003)(2616005)(8676002)(7696005)(1076003)(14444005)(50226002)(2870700001)(26005)(356004)(51416003)(4326008)(6666004)(316002)(110136005)(2201001)(53936002)(81156014)(8936002)(921003)(2101003)(83996005)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1272;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 534f0e73-4cf3-4450-5871-08d72c46f16a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328);SRVR:CY4PR12MB1272;
X-MS-TrafficTypeDiagnostic: CY4PR12MB1272:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1272343F355D0A7D1AE4988483A20@CY4PR12MB1272.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 0144B30E41
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: JYFNtGPowROq6GC7cP3zlUzpxK0oLEJR7Gt7Ruy07/TriY38vDkZ0rtwwAtFjdtIQljt2BULQq5ktXTRv2lgoczFTXlUrcSUja3Q2W/kDzgYNPY2iwDMfRbN5zBw74pPQLRVZ2Qg6rcBl2jW2xKxNdqoGvo8s3L9NNTNXTbmtJM2k0cItzEah+vdgLlATUKKdsFzkNZaKpmjgs809FGLDq9IBYFlgiF8FIXdoCcsvMS+DZQMk7KNxq2XcMOsA6dn9DanYcPlsVvosMviY0zYVqJxQg7EVb5jo+YtXhQFXF4jqermJj9b583xuVMGsbsyujhYjR8kL9F9CTtEsIDKtCDQoGSqC67IcErmCSdigJF3iWgxjhT4NMI9D/63vFxzIUF1BWZ2zFVmGVjZNT2kMpBHgjAFbs+i1X1RT0v6/zs=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2019 06:05:50.2776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 534f0e73-4cf3-4450-5871-08d72c46f16a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1272
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The drm resource being limited here is the GEM buffer objects.  User
applications allocate and free these buffers.  In addition, a process
can allocate a buffer and share it with another process.  The consumer
of a shared buffer can also outlive the allocator of the buffer.

For the purpose of cgroup accounting and limiting, ownership of the
buffer is deemed to be the cgroup for which the allocating process
belongs to.  There is one cgroup limit per drm device.

The limiting functionality is added to the previous stats collection
function.  The drm_gem_private_object_init is modified to have a return
value to allow failure due to cgroup limit.

The try_chg function only fails if the DRM cgroup properties has
limit_enforced set to true for the DRM device.  This is to allow the DRM
cgroup controller to collect usage stats without enforcing the limits.

drm.buffer.default
        A read-only flat-keyed file which exists on the root cgroup.
        Each entry is keyed by the drm device's major:minor.

        Default limits on the total GEM buffer allocation in bytes.

drm.buffer.max
        A read-write flat-keyed file which exists on all cgroups.  Each
        entry is keyed by the drm device's major:minor.

        Per device limits on the total GEM buffer allocation in byte.
        This is a hard limit.  Attempts in allocating beyond the cgroup
        limit will result in ENOMEM.  Shorthand understood by memparse
        (such as k, m, g) can be used.

        Set allocation limit for /dev/dri/card1 to 1GB
        echo "226:1 1g" > drm.buffer.total.max

        Set allocation limit for /dev/dri/card0 to 512MB
        echo "226:0 512m" > drm.buffer.total.max

Change-Id: I96e0b7add4d331ed8bb267b3c9243d360c6e9903
Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>
---
 Documentation/admin-guide/cgroup-v2.rst    |  21 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |   6 +-
 drivers/gpu/drm/drm_gem.c                  |  11 +-
 include/drm/drm_cgroup.h                   |   7 +-
 include/drm/drm_gem.h                      |   2 +-
 include/linux/cgroup_drm.h                 |   1 +
 kernel/cgroup/drm.c                        | 221 ++++++++++++++++++++-
 8 files changed, 260 insertions(+), 17 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 4dc72339a9b6..e8fac2684179 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1919,6 +1919,27 @@ DRM Interface Files
 
 	Total number of GEM buffer allocated.
 
+  drm.buffer.default
+	A read-only flat-keyed file which exists on the root cgroup.
+	Each entry is keyed by the drm device's major:minor.
+
+	Default limits on the total GEM buffer allocation in bytes.
+
+  drm.buffer.max
+	A read-write flat-keyed file which exists on all cgroups.  Each
+	entry is keyed by the drm device's major:minor.
+
+	Per device limits on the total GEM buffer allocation in byte.
+	This is a hard limit.  Attempts in allocating beyond the cgroup
+	limit will result in ENOMEM.  Shorthand understood by memparse
+	(such as k, m, g) can be used.
+
+	Set allocation limit for /dev/dri/card1 to 1GB
+	echo "226:1 1g" > drm.buffer.total.max
+
+	Set allocation limit for /dev/dri/card0 to 512MB
+	echo "226:0 512m" > drm.buffer.total.max
+
 GEM Buffer Ownership
 ~~~~~~~~~~~~~~~~~~~~
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index c0bbd3aa0558..163a4fbf0611 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1395,6 +1395,12 @@ amdgpu_get_crtc_scanout_position(struct drm_device *dev, unsigned int pipe,
 						  stime, etime, mode);
 }
 
+static void amdgpu_drmcg_custom_init(struct drm_device *dev,
+	struct drmcg_props *props)
+{
+	props->limit_enforced = true;
+}
+
 static struct drm_driver kms_driver = {
 	.driver_features =
 	    DRIVER_USE_AGP | DRIVER_ATOMIC |
@@ -1431,6 +1437,8 @@ static struct drm_driver kms_driver = {
 	.gem_prime_vunmap = amdgpu_gem_prime_vunmap,
 	.gem_prime_mmap = amdgpu_gem_prime_mmap,
 
+	.drmcg_custom_init = amdgpu_drmcg_custom_init,
+
 	.name = DRIVER_NAME,
 	.desc = DRIVER_DESC,
 	.date = DRIVER_DATE,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 989b7b55cb2e..b1bd66be3e1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -34,6 +34,7 @@
 #include <drm/drmP.h>
 #include <drm/amdgpu_drm.h>
 #include <drm/drm_cache.h>
+#include <drm/drm_cgroup.h>
 #include "amdgpu.h"
 #include "amdgpu_trace.h"
 #include "amdgpu_amdkfd.h"
@@ -454,7 +455,10 @@ static int amdgpu_bo_do_create(struct amdgpu_device *adev,
 	bo = kzalloc(sizeof(struct amdgpu_bo), GFP_KERNEL);
 	if (bo == NULL)
 		return -ENOMEM;
-	drm_gem_private_object_init(adev->ddev, &bo->gem_base, size);
+	if (!drm_gem_private_object_init(adev->ddev, &bo->gem_base, size)) {
+		kfree(bo);
+		return -ENOMEM;
+	}
 	INIT_LIST_HEAD(&bo->shadow_list);
 	bo->vm_bo = NULL;
 	bo->preferred_domains = bp->preferred_domain ? bp->preferred_domain :
diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 517b71a6f4d4..7887f153ab83 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -145,11 +145,17 @@ EXPORT_SYMBOL(drm_gem_object_init);
  * no GEM provided backing store. Instead the caller is responsible for
  * backing the object and handling it.
  */
-void drm_gem_private_object_init(struct drm_device *dev,
+bool drm_gem_private_object_init(struct drm_device *dev,
 				 struct drm_gem_object *obj, size_t size)
 {
 	BUG_ON((size & (PAGE_SIZE - 1)) != 0);
 
+	obj->drmcg = drmcg_get(current);
+	if (!drmcg_try_chg_bo_alloc(obj->drmcg, dev, size)) {
+		drmcg_put(obj->drmcg);
+		obj->drmcg = NULL;
+		return false;
+	}
 	obj->dev = dev;
 	obj->filp = NULL;
 
@@ -162,8 +168,7 @@ void drm_gem_private_object_init(struct drm_device *dev,
 
 	drm_vma_node_reset(&obj->vma_node);
 
-	obj->drmcg = drmcg_get(current);
-	drmcg_chg_bo_alloc(obj->drmcg, dev, size);
+	return true;
 }
 EXPORT_SYMBOL(drm_gem_private_object_init);
 
diff --git a/include/drm/drm_cgroup.h b/include/drm/drm_cgroup.h
index 1fa37d1ad44c..49c5d35ff6e1 100644
--- a/include/drm/drm_cgroup.h
+++ b/include/drm/drm_cgroup.h
@@ -11,13 +11,16 @@
  * of storing per device defaults
  */
 struct drmcg_props {
+	bool			limit_enforced;
+
+	s64			bo_limits_total_allocated_default;
 };
 
 #ifdef CONFIG_CGROUP_DRM
 
 void drmcg_device_update(struct drm_device *device);
 void drmcg_device_early_init(struct drm_device *device);
-void drmcg_chg_bo_alloc(struct drmcg *drmcg, struct drm_device *dev,
+bool drmcg_try_chg_bo_alloc(struct drmcg *drmcg, struct drm_device *dev,
 		size_t size);
 void drmcg_unchg_bo_alloc(struct drmcg *drmcg, struct drm_device *dev,
 		size_t size);
@@ -30,7 +33,7 @@ static inline void drmcg_device_early_init(struct drm_device *device)
 {
 }
 
-static inline void drmcg_chg_bo_alloc(struct drmcg *drmcg,
+static inline void drmcg_try_chg_bo_alloc(struct drmcg *drmcg,
 		struct drm_device *dev,	size_t size)
 {
 }
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 6047968bdd17..2bf0c0962ddf 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -334,7 +334,7 @@ void drm_gem_object_release(struct drm_gem_object *obj);
 void drm_gem_object_free(struct kref *kref);
 int drm_gem_object_init(struct drm_device *dev,
 			struct drm_gem_object *obj, size_t size);
-void drm_gem_private_object_init(struct drm_device *dev,
+bool drm_gem_private_object_init(struct drm_device *dev,
 				 struct drm_gem_object *obj, size_t size);
 void drm_gem_vm_open(struct vm_area_struct *vma);
 void drm_gem_vm_close(struct vm_area_struct *vma);
diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
index 972f7aa975b5..eb54e56f20ae 100644
--- a/include/linux/cgroup_drm.h
+++ b/include/linux/cgroup_drm.h
@@ -26,6 +26,7 @@ enum drmcg_res_type {
 struct drmcg_device_resource {
 	/* for per device stats */
 	s64			bo_stats_total_allocated;
+	s64			bo_limits_total_allocated;
 
 	s64			bo_stats_peak_allocated;
 
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
index 85e46ece4a82..7161fa40e156 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -27,6 +27,8 @@ static DEFINE_MUTEX(drmcg_mutex);
 
 enum drmcg_file_type {
 	DRMCG_FTYPE_STATS,
+	DRMCG_FTYPE_LIMIT,
+	DRMCG_FTYPE_DEFAULT,
 };
 
 static struct drmcg *root_drmcg __read_mostly;
@@ -70,6 +72,8 @@ static inline int init_drmcg_single(struct drmcg *drmcg, struct drm_device *dev)
 	drmcg->dev_resources[minor] = ddr;
 
 	/* set defaults here */
+	ddr->bo_limits_total_allocated =
+		dev->drmcg_props.bo_limits_total_allocated_default;
 
 	mutex_unlock(&dev->drmcg_mutex);
 	return 0;
@@ -141,6 +145,38 @@ static void drmcg_print_stats(struct drmcg_device_resource *ddr,
 	}
 }
 
+static void drmcg_print_limits(struct drmcg_device_resource *ddr,
+		struct seq_file *sf, enum drmcg_res_type type)
+{
+	if (ddr == NULL) {
+		seq_puts(sf, "\n");
+		return;
+	}
+
+	switch (type) {
+	case DRMCG_TYPE_BO_TOTAL:
+		seq_printf(sf, "%lld\n", ddr->bo_limits_total_allocated);
+		break;
+	default:
+		seq_puts(sf, "\n");
+		break;
+	}
+}
+
+static void drmcg_print_default(struct drmcg_props *props,
+		struct seq_file *sf, enum drmcg_res_type type)
+{
+	switch (type) {
+	case DRMCG_TYPE_BO_TOTAL:
+		seq_printf(sf, "%lld\n",
+			props->bo_limits_total_allocated_default);
+		break;
+	default:
+		seq_puts(sf, "\n");
+		break;
+	}
+}
+
 static int drmcg_seq_show_fn(int id, void *ptr, void *data)
 {
 	struct drm_minor *minor = ptr;
@@ -163,6 +199,12 @@ static int drmcg_seq_show_fn(int id, void *ptr, void *data)
 	case DRMCG_FTYPE_STATS:
 		drmcg_print_stats(ddr, sf, type);
 		break;
+	case DRMCG_FTYPE_LIMIT:
+		drmcg_print_limits(ddr, sf, type);
+		break;
+	case DRMCG_FTYPE_DEFAULT:
+		drmcg_print_default(&minor->dev->drmcg_props, sf, type);
+		break;
 	default:
 		seq_puts(sf, "\n");
 		break;
@@ -176,6 +218,124 @@ int drmcg_seq_show(struct seq_file *sf, void *v)
 	return drm_minor_for_each(&drmcg_seq_show_fn, sf);
 }
 
+static void drmcg_pr_cft_err(const struct drmcg *drmcg,
+		int rc, const char *cft_name, int minor)
+{
+	pr_err("drmcg: error parsing %s, minor %d, rc %d ",
+			cft_name, minor, rc);
+	pr_cont_cgroup_name(drmcg->css.cgroup);
+	pr_cont("\n");
+}
+
+static int drmcg_process_limit_s64_val(char *sval, bool is_mem,
+			s64 def_val, s64 max_val, s64 *ret_val)
+{
+	int rc = strcmp("max", sval);
+
+
+	if (!rc)
+		*ret_val = max_val;
+	else {
+		rc = strcmp("default", sval);
+
+		if (!rc)
+			*ret_val = def_val;
+	}
+
+	if (rc) {
+		if (is_mem) {
+			*ret_val = memparse(sval, NULL);
+			rc = 0;
+		} else {
+			rc = kstrtoll(sval, 0, ret_val);
+		}
+	}
+
+	if (*ret_val > max_val)
+		rc = -EINVAL;
+
+	return rc;
+}
+
+static void drmcg_value_apply(struct drm_device *dev, s64 *dst, s64 val)
+{
+	mutex_lock(&dev->drmcg_mutex);
+	*dst = val;
+	mutex_unlock(&dev->drmcg_mutex);
+}
+
+static ssize_t drmcg_limit_write(struct kernfs_open_file *of, char *buf,
+		size_t nbytes, loff_t off)
+{
+	struct drmcg *drmcg = css_to_drmcg(of_css(of));
+	struct drmcg *parent = drmcg_parent(drmcg);
+	enum drmcg_res_type type =
+		DRMCG_CTF_PRIV2RESTYPE(of_cft(of)->private);
+	char *cft_name = of_cft(of)->name;
+	char *limits = strstrip(buf);
+	struct drmcg_device_resource *ddr;
+	struct drmcg_props *props;
+	struct drm_minor *dm;
+	char *line;
+	char sattr[256];
+	s64 val;
+	s64 p_max;
+	int rc;
+	int minor;
+
+	while (limits != NULL) {
+		line =  strsep(&limits, "\n");
+
+		if (sscanf(line,
+			__stringify(DRM_MAJOR)":%u %255[^\t\n]",
+							&minor, sattr) != 2) {
+			pr_err("drmcg: error parsing %s ", cft_name);
+			pr_cont_cgroup_name(drmcg->css.cgroup);
+			pr_cont("\n");
+
+			continue;
+		}
+
+		dm = drm_minor_acquire(minor);
+		if (IS_ERR(dm)) {
+			pr_err("drmcg: invalid minor %d for %s ",
+					minor, cft_name);
+			pr_cont_cgroup_name(drmcg->css.cgroup);
+			pr_cont("\n");
+
+			continue;
+		}
+
+		ddr = drmcg->dev_resources[minor];
+		props = &dm->dev->drmcg_props;
+		switch (type) {
+		case DRMCG_TYPE_BO_TOTAL:
+			p_max = parent == NULL ? S64_MAX :
+				parent->dev_resources[minor]->
+				bo_limits_total_allocated;
+
+			rc = drmcg_process_limit_s64_val(sattr, true,
+				props->bo_limits_total_allocated_default,
+				p_max,
+				&val);
+
+			if (rc || val < 0) {
+				drmcg_pr_cft_err(drmcg, rc, cft_name, minor);
+				break;
+			}
+
+			drmcg_value_apply(dm->dev,
+					&ddr->bo_limits_total_allocated, val);
+			break;
+		default:
+			break;
+		}
+		drm_dev_put(dm->dev); /* release from drm_minor_acquire */
+	}
+
+	return nbytes;
+}
+
 struct cftype files[] = {
 	{
 		.name = "buffer.total.stats",
@@ -183,6 +343,20 @@ struct cftype files[] = {
 		.private = DRMCG_CTF_PRIV(DRMCG_TYPE_BO_TOTAL,
 						DRMCG_FTYPE_STATS),
 	},
+	{
+		.name = "buffer.total.default",
+		.seq_show = drmcg_seq_show,
+		.flags = CFTYPE_ONLY_ON_ROOT,
+		.private = DRMCG_CTF_PRIV(DRMCG_TYPE_BO_TOTAL,
+						DRMCG_FTYPE_DEFAULT),
+	},
+	{
+		.name = "buffer.total.max",
+		.write = drmcg_limit_write,
+		.seq_show = drmcg_seq_show,
+		.private = DRMCG_CTF_PRIV(DRMCG_TYPE_BO_TOTAL,
+						DRMCG_FTYPE_LIMIT),
+	},
 	{
 		.name = "buffer.peak.stats",
 		.seq_show = drmcg_seq_show,
@@ -250,12 +424,16 @@ EXPORT_SYMBOL(drmcg_device_update);
  */
 void drmcg_device_early_init(struct drm_device *dev)
 {
+	dev->drmcg_props.limit_enforced = false;
+
+	dev->drmcg_props.bo_limits_total_allocated_default = S64_MAX;
+
 	drmcg_update_cg_tree(dev);
 }
 EXPORT_SYMBOL(drmcg_device_early_init);
 
 /**
- * drmcg_chg_bo_alloc - charge GEM buffer usage for a device and cgroup
+ * drmcg_try_chg_bo_alloc - charge GEM buffer usage for a device and cgroup
  * @drmcg: the DRM cgroup to be charged to
  * @dev: the device the usage should be charged to
  * @size: size of the GEM buffer to be accounted for
@@ -264,29 +442,52 @@ EXPORT_SYMBOL(drmcg_device_early_init);
  * for the utilization.  This should not be called when the buffer is shared (
  * the GEM buffer's reference count being incremented.)
  */
-void drmcg_chg_bo_alloc(struct drmcg *drmcg, struct drm_device *dev,
+bool drmcg_try_chg_bo_alloc(struct drmcg *drmcg, struct drm_device *dev,
 		size_t size)
 {
 	struct drmcg_device_resource *ddr;
 	int devIdx = dev->primary->index;
+	struct drmcg_props *props = &dev->drmcg_props;
+	struct drmcg *drmcg_cur = drmcg;
+	bool result = true;
+	s64 delta = 0;
 
 	if (drmcg == NULL)
-		return;
+		return true;
 
 	mutex_lock(&dev->drmcg_mutex);
-	for ( ; drmcg != NULL; drmcg = drmcg_parent(drmcg)) {
-		ddr = drmcg->dev_resources[devIdx];
+        if (props->limit_enforced) {
+		for ( ; drmcg != NULL; drmcg = drmcg_parent(drmcg)) {
+			ddr = drmcg->dev_resources[devIdx];
+			delta = ddr->bo_limits_total_allocated -
+					ddr->bo_stats_total_allocated;
+
+			if (delta <= 0 || size > delta) {
+				result = false;
+				break;
+			}
+		}
+	}
+
+	drmcg = drmcg_cur;
+
+	if (result || !props->limit_enforced) {
+		for ( ; drmcg != NULL; drmcg = drmcg_parent(drmcg)) {
+			ddr = drmcg->dev_resources[devIdx];
 
-		ddr->bo_stats_total_allocated += (s64)size;
+			ddr->bo_stats_total_allocated += (s64)size;
 
-		if (ddr->bo_stats_peak_allocated < (s64)size)
-			ddr->bo_stats_peak_allocated = (s64)size;
+			if (ddr->bo_stats_peak_allocated < (s64)size)
+				ddr->bo_stats_peak_allocated = (s64)size;
 
-		ddr->bo_stats_count_allocated++;
+			ddr->bo_stats_count_allocated++;
+		}
 	}
 	mutex_unlock(&dev->drmcg_mutex);
+
+	return result;
 }
-EXPORT_SYMBOL(drmcg_chg_bo_alloc);
+EXPORT_SYMBOL(drmcg_try_chg_bo_alloc);
 
 /**
  * drmcg_unchg_bo_alloc -
-- 
2.22.0


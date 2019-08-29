Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAE9A115A
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2019 08:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfH2GFv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Aug 2019 02:05:51 -0400
Received: from mail-eopbgr790085.outbound.protection.outlook.com ([40.107.79.85]:60313
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727398AbfH2GFu (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 29 Aug 2019 02:05:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mehXuf/EqzUZX6MVhNLUjSCEKz3DKqk222a7KINoWhQXx8mCrDwYpIFdixke/I+9ALjaXuyuQytoAdmuQST8fyBsqlgtbeBSDpz3yQOKQ1hA2eoi0EztBG7n4M769+Q+D4vLP8AG/XnvMq5BHiBhZJ43Qnq4uNQ9KMdbMR+a75r/Ct3G+6Unt2zgtOCxfxTYIZaQdMXMSvkWGNMPEemWcIAZcmMKlblZbQygPyweKP5K5gb9q8BNt6jETSa8XmgdrmyHOHTqk65yiFgqNSZiJ81g6iYw4O4fUBmUOQftfsCrQa5TwX7SUqXFvdzqD/siQgWQpy/EJHzxiszIVcwn8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRyHhzF2uLSJ6aT6RZhce1jet+jmyq43CdAF0JtrtH4=;
 b=MbYEri5rSeqYytu0bmiIeXwB96cK5bO7q+Cw33hk1X0N8+ZATRpIY6Jw1rG6QY3lJLAyAKi5+VXNM1OymxHZ5tvh4bDQQkaQPmc5pC9If/27sNnwfT07hjpBVAb12NkF3s+u9Uv6YtUNeizhocmAfgCZC2x4ymgc7E7WM+h9RdIE51TN1IZyIJudLqIkceprz4hfBgALYPdsxM4/SGBCJhcTiEXYepKcbcSZW5XDrieByqzVy0SlXNVZclsvTL/WuSVPzLvzUDcLnJxN/PQZ1ZmYvpFs858jefVqOCbwleS14ptNvsgcsBA13jlojPFBqPQy9Et+toAkye9WOfP1kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=cray.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRyHhzF2uLSJ6aT6RZhce1jet+jmyq43CdAF0JtrtH4=;
 b=nBRPt5jwdem5DaTUn0zHT+1v+xg9h/uVLGGkBYEnX5PH1Vwwmi7EU1yIVL13Kbs0i1kjmoZ605lHyFyMrK2WQSzueUb/ibe16m6lPyT6kZF6Ol/hXd4mb+K0g6KrvI/szxcThvzgqXmoAe3knWgxYl8aA0ds0uk1Oz0ac0ffXqI=
Received: from CH2PR12CA0005.namprd12.prod.outlook.com (2603:10b6:610:57::15)
 by BN6PR12MB1267.namprd12.prod.outlook.com (2603:10b6:404:17::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.20; Thu, 29 Aug
 2019 06:05:47 +0000
Received: from CO1NAM03FT045.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::200) by CH2PR12CA0005.outlook.office365.com
 (2603:10b6:610:57::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.18 via Frontend
 Transport; Thu, 29 Aug 2019 06:05:47 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; cray.com; dkim=none (message not signed)
 header.d=none;cray.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 CO1NAM03FT045.mail.protection.outlook.com (10.152.81.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2220.16 via Frontend Transport; Thu, 29 Aug 2019 06:05:46 +0000
Received: from kho-5039A.amd.com (10.180.168.240) by SATLEXCHOV01.amd.com
 (10.181.40.71) with Microsoft SMTP Server id 14.3.389.1; Thu, 29 Aug 2019
 01:05:44 -0500
From:   Kenny Ho <Kenny.Ho@amd.com>
To:     <y2kenny@gmail.com>, <cgroups@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <tj@kernel.org>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <felix.kuehling@amd.com>,
        <joseph.greathouse@amd.com>, <jsparks@cray.com>,
        <lkaplan@cray.com>, <daniel@ffwll.ch>
CC:     Kenny Ho <Kenny.Ho@amd.com>
Subject: [PATCH RFC v4 04/16] drm, cgroup: Add total GEM buffer allocation stats
Date:   Thu, 29 Aug 2019 02:05:21 -0400
Message-ID: <20190829060533.32315-5-Kenny.Ho@amd.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829060533.32315-1-Kenny.Ho@amd.com>
References: <20190829060533.32315-1-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(346002)(136003)(396003)(2980300002)(428003)(199004)(189003)(5660300002)(86362001)(47776003)(6666004)(356004)(30864003)(1076003)(478600001)(2201001)(2870700001)(2906002)(316002)(70206006)(70586007)(50466002)(110136005)(48376002)(53416004)(426003)(36756003)(4326008)(305945005)(53936002)(8936002)(8676002)(81156014)(186003)(51416003)(2616005)(11346002)(446003)(476003)(76176011)(14444005)(7696005)(126002)(486006)(81166006)(50226002)(336012)(26005)(921003)(1121003)(2101003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1267;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd245b17-da3e-4103-db9a-08d72c46ef65
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328);SRVR:BN6PR12MB1267;
X-MS-TrafficTypeDiagnostic: BN6PR12MB1267:
X-Microsoft-Antispam-PRVS: <BN6PR12MB12674CE15963E0389373EEBC83A20@BN6PR12MB1267.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0144B30E41
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: WVUb01NJ6EipNhyM+dH+tyIL7TKIGcz77bREr3F6tdG/9+iQazYZ05a4PJ0k69dzlUGWTbwQOAJqOdo/crGgSKn7i89BUBWZKcZ4enxqTa9Uc9cHndgGtK2WjTol8Gwa/0O2N9V3KMJZiOVuPL/mL9s/bVeTQh4nhDAAgx6jTbfjXtrnEc2Rb+QrZHJpNEjqLtdY5ZORIJA8Tg5Q5I/Aob4wn0yATJyDv7y5YRHBg71U0uaXqFuor6RMxl7NuYqGAAy8gTCuvIsUKgWIe6c8Q8i+KECNRb8DU6iiKbipu7tt6KoQUAbxbZxLQ6wRXBK+KlDB/d3HG+2zOj6ei2tiqoV5QUW+lRtGdHMP8xXCLrtD/vNgCg/JV9Imfy4AYTNXYnG/5mGL4D214169I3NXbdNo7x66hitIh9y6S7pPE/4=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2019 06:05:46.7233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd245b17-da3e-4103-db9a-08d72c46ef65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1267
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The drm resource being measured here is the GEM buffer objects.  User
applications allocate and free these buffers.  In addition, a process
can allocate a buffer and share it with another process.  The consumer
of a shared buffer can also outlive the allocator of the buffer.

For the purpose of cgroup accounting and limiting, ownership of the
buffer is deemed to be the cgroup for which the allocating process
belongs to.  There is one cgroup stats per drm device.  Each allocation
is charged to the owning cgroup as well as all its ancestors.

Similar to the memory cgroup, migrating a process to a different cgroup
does not move the GEM buffer usages that the process started while in
previous cgroup, to the new cgroup.

The following is an example to illustrate some of the operations.  Given
the following cgroup hierarchy (The letters are cgroup names with R
being the root cgroup.  The numbers in brackets are processes.  The
processes are placed with cgroup's 'No Internal Process Constraint' in
mind, so no process is placed in cgroup B.)

R (4, 5) ------ A (6)
 \
  B ---- C (7,8)
   \
    D (9)

Here is a list of operation and the associated effect on the size
track by the cgroups (for simplicity, each buffer is 1 unit in size.)

==  ==  ==  ==  ==  ===================================================
R   A   B   C   D   Ops
==  ==  ==  ==  ==  ===================================================
1   0   0   0   0   4 allocated a buffer
1   0   0   0   0   4 shared a buffer with 5
1   0   0   0   0   4 shared a buffer with 9
2   0   1   0   1   9 allocated a buffer
3   0   2   1   1   7 allocated a buffer
3   0   2   1   1   7 shared a buffer with 8
3   0   2   1   1   7 sharing with 9
3   0   2   1   1   7 release a buffer
3   0   2   1   1   7 migrate to cgroup D
3   0   2   1   1   9 release a buffer from 7
2   0   1   0   1   8 release a buffer from 7 (last ref to shared buf)
==  ==  ==  ==  ==  ===================================================

drm.buffer.stats
        A read-only flat-keyed file which exists on all cgroups.  Each
        entry is keyed by the drm device's major:minor.

        Total GEM buffer allocation in bytes.

Change-Id: I9d662ec50d64bb40a37dbf47f018b2f3a1c033ad
Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  50 +++++++++-
 drivers/gpu/drm/drm_gem.c               |   9 ++
 include/drm/drm_cgroup.h                |  16 +++
 include/drm/drm_gem.h                   |  11 +++
 include/linux/cgroup_drm.h              |   6 ++
 kernel/cgroup/drm.c                     | 126 ++++++++++++++++++++++++
 6 files changed, 217 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 2936423a3fd5..0e29d136e2f9 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -63,6 +63,7 @@ v1 is available under Documentation/cgroup-v1/.
        5-7-1. RDMA Interface Files
      5-8. DRM
        5-8-1. DRM Interface Files
+       5-8-2. GEM Buffer Ownership
      5-9. Misc
        5-9-1. perf_event
      5-N. Non-normative information
@@ -1900,7 +1901,54 @@ of DRM (Direct Rendering Manager) and GPU-related resources.
 DRM Interface Files
 ~~~~~~~~~~~~~~~~~~~~
 
-TODO
+  drm.buffer.stats
+	A read-only flat-keyed file which exists on all cgroups.  Each
+	entry is keyed by the drm device's major:minor.
+
+	Total GEM buffer allocation in bytes.
+
+GEM Buffer Ownership
+~~~~~~~~~~~~~~~~~~~~
+
+For the purpose of cgroup accounting and limiting, ownership of the
+buffer is deemed to be the cgroup for which the allocating process
+belongs to.  There is one cgroup stats per drm device.  Each allocation
+is charged to the owning cgroup as well as all its ancestors.
+
+Similar to the memory cgroup, migrating a process to a different cgroup
+does not move the GEM buffer usages that the process started while in
+previous cgroup, to the new cgroup.
+
+The following is an example to illustrate some of the operations.  Given
+the following cgroup hierarchy (The letters are cgroup names with R
+being the root cgroup.  The numbers in brackets are processes.  The
+processes are placed with cgroup's 'No Internal Process Constraint' in
+mind, so no process is placed in cgroup B.)
+
+R (4, 5) ------ A (6)
+ \
+  B ---- C (7,8)
+   \
+    D (9)
+
+Here is a list of operation and the associated effect on the size
+track by the cgroups (for simplicity, each buffer is 1 unit in size.)
+
+==  ==  ==  ==  ==  ===================================================
+R   A   B   C   D   Ops
+==  ==  ==  ==  ==  ===================================================
+1   0   0   0   0   4 allocated a buffer
+1   0   0   0   0   4 shared a buffer with 5
+1   0   0   0   0   4 shared a buffer with 9
+2   0   1   0   1   9 allocated a buffer
+3   0   2   1   1   7 allocated a buffer
+3   0   2   1   1   7 shared a buffer with 8
+3   0   2   1   1   7 sharing with 9
+3   0   2   1   1   7 release a buffer
+3   0   2   1   1   7 migrate to cgroup D
+3   0   2   1   1   9 release a buffer from 7
+2   0   1   0   1   8 release a buffer from 7 (last ref to shared buf)
+==  ==  ==  ==  ==  ===================================================
 
 
 Misc
diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 50de138c89e0..517b71a6f4d4 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -38,10 +38,12 @@
 #include <linux/dma-buf.h>
 #include <linux/mem_encrypt.h>
 #include <linux/pagevec.h>
+#include <linux/cgroup_drm.h>
 #include <drm/drmP.h>
 #include <drm/drm_vma_manager.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_print.h>
+#include <drm/drm_cgroup.h>
 #include "drm_internal.h"
 
 /** @file drm_gem.c
@@ -159,6 +161,9 @@ void drm_gem_private_object_init(struct drm_device *dev,
 		obj->resv = &obj->_resv;
 
 	drm_vma_node_reset(&obj->vma_node);
+
+	obj->drmcg = drmcg_get(current);
+	drmcg_chg_bo_alloc(obj->drmcg, dev, size);
 }
 EXPORT_SYMBOL(drm_gem_private_object_init);
 
@@ -950,6 +955,10 @@ drm_gem_object_release(struct drm_gem_object *obj)
 		fput(obj->filp);
 
 	reservation_object_fini(&obj->_resv);
+
+	drmcg_unchg_bo_alloc(obj->drmcg, obj->dev, obj->size);
+	drmcg_put(obj->drmcg);
+
 	drm_gem_free_mmap_offset(obj);
 }
 EXPORT_SYMBOL(drm_gem_object_release);
diff --git a/include/drm/drm_cgroup.h b/include/drm/drm_cgroup.h
index bef9f9245924..1fa37d1ad44c 100644
--- a/include/drm/drm_cgroup.h
+++ b/include/drm/drm_cgroup.h
@@ -4,6 +4,8 @@
 #ifndef __DRM_CGROUP_H__
 #define __DRM_CGROUP_H__
 
+#include <linux/cgroup_drm.h>
+
 /**
  * Per DRM device properties for DRM cgroup controller for the purpose
  * of storing per device defaults
@@ -15,6 +17,10 @@ struct drmcg_props {
 
 void drmcg_device_update(struct drm_device *device);
 void drmcg_device_early_init(struct drm_device *device);
+void drmcg_chg_bo_alloc(struct drmcg *drmcg, struct drm_device *dev,
+		size_t size);
+void drmcg_unchg_bo_alloc(struct drmcg *drmcg, struct drm_device *dev,
+		size_t size);
 #else
 static inline void drmcg_device_update(struct drm_device *device)
 {
@@ -23,5 +29,15 @@ static inline void drmcg_device_update(struct drm_device *device)
 static inline void drmcg_device_early_init(struct drm_device *device)
 {
 }
+
+static inline void drmcg_chg_bo_alloc(struct drmcg *drmcg,
+		struct drm_device *dev,	size_t size)
+{
+}
+
+static inline void drmcg_unchg_bo_alloc(struct drmcg *drmcg,
+		struct drm_device *dev,	size_t size)
+{
+}
 #endif /* CONFIG_CGROUP_DRM */
 #endif /* __DRM_CGROUP_H__ */
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 5047c7ee25f5..6047968bdd17 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -291,6 +291,17 @@ struct drm_gem_object {
 	 *
 	 */
 	const struct drm_gem_object_funcs *funcs;
+
+	/**
+	 * @drmcg:
+	 *
+	 * DRM cgroup this GEM object belongs to.
+	 *
+	 * This is used to track and limit the amount of GEM objects a user
+	 * can allocate.  Since GEM objects can be shared, this is also used
+	 * to ensure GEM objects are only shared within the same cgroup.
+	 */
+	struct drmcg *drmcg;
 };
 
 /**
diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
index 4ecd44f2ac27..1d8a7f2cdb4e 100644
--- a/include/linux/cgroup_drm.h
+++ b/include/linux/cgroup_drm.h
@@ -13,11 +13,17 @@
 /* limit defined per the way drm_minor_alloc operates */
 #define MAX_DRM_DEV (64 * DRM_MINOR_RENDER)
 
+enum drmcg_res_type {
+	DRMCG_TYPE_BO_TOTAL,
+	__DRMCG_TYPE_LAST,
+};
+
 /**
  * Per DRM cgroup, per device resources (such as statistics and limits)
  */
 struct drmcg_device_resource {
 	/* for per device stats */
+	s64			bo_stats_total_allocated;
 };
 
 /**
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
index 135fdcdc4b51..87ae9164d8d8 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -11,11 +11,24 @@
 #include <drm/drm_file.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_device.h>
+#include <drm/drm_ioctl.h>
 #include <drm/drm_cgroup.h>
 
 /* global mutex for drmcg across all devices */
 static DEFINE_MUTEX(drmcg_mutex);
 
+#define DRMCG_CTF_PRIV_SIZE 3
+#define DRMCG_CTF_PRIV_MASK GENMASK((DRMCG_CTF_PRIV_SIZE - 1), 0)
+#define DRMCG_CTF_PRIV(res_type, f_type)  ((res_type) <<\
+		DRMCG_CTF_PRIV_SIZE | (f_type))
+#define DRMCG_CTF_PRIV2RESTYPE(priv) ((priv) >> DRMCG_CTF_PRIV_SIZE)
+#define DRMCG_CTF_PRIV2FTYPE(priv) ((priv) & DRMCG_CTF_PRIV_MASK)
+
+
+enum drmcg_file_type {
+	DRMCG_FTYPE_STATS,
+};
+
 static struct drmcg *root_drmcg __read_mostly;
 
 static int drmcg_css_free_fn(int id, void *ptr, void *data)
@@ -104,7 +117,66 @@ drmcg_css_alloc(struct cgroup_subsys_state *parent_css)
 	return &drmcg->css;
 }
 
+static void drmcg_print_stats(struct drmcg_device_resource *ddr,
+		struct seq_file *sf, enum drmcg_res_type type)
+{
+	if (ddr == NULL) {
+		seq_puts(sf, "\n");
+		return;
+	}
+
+	switch (type) {
+	case DRMCG_TYPE_BO_TOTAL:
+		seq_printf(sf, "%lld\n", ddr->bo_stats_total_allocated);
+		break;
+	default:
+		seq_puts(sf, "\n");
+		break;
+	}
+}
+
+static int drmcg_seq_show_fn(int id, void *ptr, void *data)
+{
+	struct drm_minor *minor = ptr;
+	struct seq_file *sf = data;
+	struct drmcg *drmcg = css_to_drmcg(seq_css(sf));
+	enum drmcg_file_type f_type =
+		DRMCG_CTF_PRIV2FTYPE(seq_cft(sf)->private);
+	enum drmcg_res_type type =
+		DRMCG_CTF_PRIV2RESTYPE(seq_cft(sf)->private);
+	struct drmcg_device_resource *ddr;
+
+	if (minor->type != DRM_MINOR_PRIMARY)
+		return 0;
+
+	ddr = drmcg->dev_resources[minor->index];
+
+	seq_printf(sf, "%d:%d ", DRM_MAJOR, minor->index);
+
+	switch (f_type) {
+	case DRMCG_FTYPE_STATS:
+		drmcg_print_stats(ddr, sf, type);
+		break;
+	default:
+		seq_puts(sf, "\n");
+		break;
+	}
+
+	return 0;
+}
+
+int drmcg_seq_show(struct seq_file *sf, void *v)
+{
+	return drm_minor_for_each(&drmcg_seq_show_fn, sf);
+}
+
 struct cftype files[] = {
+	{
+		.name = "buffer.total.stats",
+		.seq_show = drmcg_seq_show,
+		.private = DRMCG_CTF_PRIV(DRMCG_TYPE_BO_TOTAL,
+						DRMCG_FTYPE_STATS),
+	},
 	{ }	/* terminate */
 };
 
@@ -163,3 +235,57 @@ void drmcg_device_early_init(struct drm_device *dev)
 	drmcg_update_cg_tree(dev);
 }
 EXPORT_SYMBOL(drmcg_device_early_init);
+
+/**
+ * drmcg_chg_bo_alloc - charge GEM buffer usage for a device and cgroup
+ * @drmcg: the DRM cgroup to be charged to
+ * @dev: the device the usage should be charged to
+ * @size: size of the GEM buffer to be accounted for
+ *
+ * This function should be called when a new GEM buffer is allocated to account
+ * for the utilization.  This should not be called when the buffer is shared (
+ * the GEM buffer's reference count being incremented.)
+ */
+void drmcg_chg_bo_alloc(struct drmcg *drmcg, struct drm_device *dev,
+		size_t size)
+{
+	struct drmcg_device_resource *ddr;
+	int devIdx = dev->primary->index;
+
+	if (drmcg == NULL)
+		return;
+
+	mutex_lock(&dev->drmcg_mutex);
+	for ( ; drmcg != NULL; drmcg = drmcg_parent(drmcg)) {
+		ddr = drmcg->dev_resources[devIdx];
+
+		ddr->bo_stats_total_allocated += (s64)size;
+	}
+	mutex_unlock(&dev->drmcg_mutex);
+}
+EXPORT_SYMBOL(drmcg_chg_bo_alloc);
+
+/**
+ * drmcg_unchg_bo_alloc -
+ * @drmcg: the DRM cgroup to uncharge from
+ * @dev: the device the usage should be removed from
+ * @size: size of the GEM buffer to be accounted for
+ *
+ * This function should be called when the GEM buffer is about to be freed (
+ * not simply when the GEM buffer's reference count is being decremented.)
+ */
+void drmcg_unchg_bo_alloc(struct drmcg *drmcg, struct drm_device *dev,
+		size_t size)
+{
+	int devIdx = dev->primary->index;
+
+	if (drmcg == NULL)
+		return;
+
+	mutex_lock(&dev->drmcg_mutex);
+	for ( ; drmcg != NULL; drmcg = drmcg_parent(drmcg))
+		drmcg->dev_resources[devIdx]->bo_stats_total_allocated
+			-= (s64)size;
+	mutex_unlock(&dev->drmcg_mutex);
+}
+EXPORT_SYMBOL(drmcg_unchg_bo_alloc);
-- 
2.22.0


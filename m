Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6D40A1172
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2019 08:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfH2GGL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Aug 2019 02:06:11 -0400
Received: from mail-eopbgr790044.outbound.protection.outlook.com ([40.107.79.44]:31664
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727522AbfH2GGK (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 29 Aug 2019 02:06:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCb5dBeod9oJlZ2bdI6k9CRkK4AOZmwZRNBeHqIrai/Imap8B9K2aSP2OE3kpiy4S+cxYW8cR8sUXJGcD8vs00Ns45w56wx8xG52GSpGYRGX2fEGwHFtri2DtV/jckUwZ9oXuzMQCWIeQkueitPgRMTTwg3wiPsrgLyqOtJloEHLwbVejgjViUvFxPxkfNOZ67pSVw19YPAGKLtKcf6l7Bza0b36peUhyunPdS5JB92m0dUvqylUlRIM0E9X56qDdWjcEd+6olMX/QsJtNsnbQ00zkXNfxgq3+EuVERSXiuC6+V4h/CqkVG4NHQjlYzlE/JGGRXCo8jqdvvHwdyJXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIa2TlfOaEpLObifkD5JDIqeDLfDxJ6AINWi5bSAaGo=;
 b=ZjZtiD5rk4nMhZ6BnzSAW9TW/CEiXjUryBF/YQx1U43UQLPALIqkYvCecohSzstG+6xXqyT+qK+kH/cCO/u6UmZ1EpMvi859nMDwp+wM4xaUGYKK4Ea6VIQObWKxn/AOvmqTNkEZ+F9Mewp6+ZrinHCKOgbuTZLKeibM3zys8bPLOz21HbPe8mPSKNQBblxEpY1cty/oTS0MUhRZExWO382LAcgW7qaNWWm4PP6MuLmlx2r3Zy6q7wTGb4dDeDAn1TqPeleqZNIJdzDhJZLQAbvGEvnb2WQOEcEHEZB7CHvHhHLBDTUihfyVFwqx5I9p/t9mbCHoH6Yd2L9mCtJIsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=cray.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIa2TlfOaEpLObifkD5JDIqeDLfDxJ6AINWi5bSAaGo=;
 b=gyUcqceHqU8fONALcrLqaWQqg/x96Sz77VauJmvTDyDrFwInWQkzveEIPmIs3NcrJYnuC2Xbpxg/+r4YM+bPxntZMs7D8b6jW1tgXM/Y0Au5GY3tNQclxMmJcL3DZvvFOf7hnyftyVxIWOVE0k+xSws6O6NDLNgpEE3Kr7hW1xg=
Received: from CH2PR12CA0005.namprd12.prod.outlook.com (2603:10b6:610:57::15)
 by BN6PR12MB1267.namprd12.prod.outlook.com (2603:10b6:404:17::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.20; Thu, 29 Aug
 2019 06:06:04 +0000
Received: from CO1NAM03FT045.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::200) by CH2PR12CA0005.outlook.office365.com
 (2603:10b6:610:57::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.18 via Frontend
 Transport; Thu, 29 Aug 2019 06:06:04 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; cray.com; dkim=none (message not signed)
 header.d=none;cray.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 CO1NAM03FT045.mail.protection.outlook.com (10.152.81.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2220.16 via Frontend Transport; Thu, 29 Aug 2019 06:06:03 +0000
Received: from kho-5039A.amd.com (10.180.168.240) by SATLEXCHOV01.amd.com
 (10.181.40.71) with Microsoft SMTP Server id 14.3.389.1; Thu, 29 Aug 2019
 01:05:53 -0500
From:   Kenny Ho <Kenny.Ho@amd.com>
To:     <y2kenny@gmail.com>, <cgroups@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <tj@kernel.org>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <felix.kuehling@amd.com>,
        <joseph.greathouse@amd.com>, <jsparks@cray.com>,
        <lkaplan@cray.com>, <daniel@ffwll.ch>
CC:     Kenny Ho <Kenny.Ho@amd.com>
Subject: [PATCH RFC v4 16/16] drm/amdgpu: Integrate with DRM cgroup
Date:   Thu, 29 Aug 2019 02:05:33 -0400
Message-ID: <20190829060533.32315-17-Kenny.Ho@amd.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829060533.32315-1-Kenny.Ho@amd.com>
References: <20190829060533.32315-1-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(4636009)(376002)(39860400002)(346002)(136003)(396003)(2980300002)(428003)(199004)(189003)(5660300002)(86362001)(47776003)(6666004)(356004)(1076003)(478600001)(2201001)(2870700001)(2906002)(316002)(70206006)(70586007)(50466002)(110136005)(48376002)(53416004)(426003)(36756003)(4326008)(305945005)(53936002)(8936002)(8676002)(81156014)(186003)(51416003)(2616005)(11346002)(446003)(476003)(76176011)(14444005)(7696005)(126002)(486006)(81166006)(50226002)(336012)(26005)(921003)(1121003)(2101003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1267;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd4e2dbb-9942-4172-8e08-08d72c46f95d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328);SRVR:BN6PR12MB1267;
X-MS-TrafficTypeDiagnostic: BN6PR12MB1267:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1267699B745A16EAE026730283A20@BN6PR12MB1267.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0144B30E41
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: EQVhlXOyUFvAWJGK27QD0WY1qdZ3vGuO+Wb3v4Sh5Oz5jEOBw2OwqxXNi4U8g/gS/k1/bclhuWBQEbXzhz8OKui1yJ7BBEqdB+vPKOzTjOLpuvmd1NR3EaqTDFa3MmTO4MCERqrv3APbtcnR9G21zz1dyUwXtJIpMbGTHVozmW3+JwUtyh6iPtxoGNnLImjAX+IPhAIyeGaDvy8b755mLxQA4DvcEHh6j6ZCTmXxIHVTHZfSGjvu7RFmZEaoUuHi5TkJMrAg2zoeyO/n6n/vRKYfcaGtYlf8xTo4QAtB10aC3+LfHE169HWv8woVIVEUg6dGEOSv/cLPJepTXHn1k41Q62dQCOhYO4JgQtRhiCwhWCIPhOlA6wzdorn3Psviuq5izqaL11dyctQwFe7Nr+dVqW7h4gqoSSwyAl1nTRs=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2019 06:06:03.4601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4e2dbb-9942-4172-8e08-08d72c46f95d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1267
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The number of logical gpu (lgpu) is defined to be the number of compute
unit (CU) for a device.  The lgpu allocation limit only applies to
compute workload for the moment (enforced via kfd queue creation.)  Any
cu_mask update is validated against the availability of the compute unit
as defined by the drmcg the kfd process belongs to.

Change-Id: I69a57452c549173a1cd623c30dc57195b3b6563e
Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  21 +++
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |   6 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   3 +
 .../amd/amdkfd/kfd_process_queue_manager.c    | 140 ++++++++++++++++++
 5 files changed, 174 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 55cb1b2094fd..369915337213 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -198,6 +198,10 @@ uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct kgd_dev *dst, struct kgd_dev *s
 		valid;							\
 	})
 
+int amdgpu_amdkfd_update_cu_mask_for_process(struct task_struct *task,
+		struct amdgpu_device *adev, unsigned long *lgpu_bitmap,
+		unsigned int nbits);
+
 /* GPUVM API */
 int amdgpu_amdkfd_gpuvm_create_process_vm(struct kgd_dev *kgd, unsigned int pasid,
 					void **vm, void **process_info,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 163a4fbf0611..8abeffdd2e5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1398,9 +1398,29 @@ amdgpu_get_crtc_scanout_position(struct drm_device *dev, unsigned int pipe,
 static void amdgpu_drmcg_custom_init(struct drm_device *dev,
 	struct drmcg_props *props)
 {
+	struct amdgpu_device *adev = dev->dev_private;
+
+	props->lgpu_capacity = adev->gfx.cu_info.number;
+
 	props->limit_enforced = true;
 }
 
+static void amdgpu_drmcg_limit_updated(struct drm_device *dev,
+		struct task_struct *task, struct drmcg_device_resource *ddr,
+		enum drmcg_res_type res_type)
+{
+	struct amdgpu_device *adev = dev->dev_private;
+
+	switch (res_type) {
+	case DRMCG_TYPE_LGPU:
+		amdgpu_amdkfd_update_cu_mask_for_process(task, adev,
+                        ddr->lgpu_allocated, dev->drmcg_props.lgpu_capacity);
+		break;
+	default:
+		break;
+	}
+}
+
 static struct drm_driver kms_driver = {
 	.driver_features =
 	    DRIVER_USE_AGP | DRIVER_ATOMIC |
@@ -1438,6 +1458,7 @@ static struct drm_driver kms_driver = {
 	.gem_prime_mmap = amdgpu_gem_prime_mmap,
 
 	.drmcg_custom_init = amdgpu_drmcg_custom_init,
+	.drmcg_limit_updated = amdgpu_drmcg_limit_updated,
 
 	.name = DRIVER_NAME,
 	.desc = DRIVER_DESC,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 138c70454e2b..fa765b803f97 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -450,6 +450,12 @@ static int kfd_ioctl_set_cu_mask(struct file *filp, struct kfd_process *p,
 		return -EFAULT;
 	}
 
+	if (!pqm_drmcg_lgpu_validate(p, args->queue_id, properties.cu_mask, cu_mask_size)) {
+		pr_debug("CU mask not permitted by DRM Cgroup");
+		kfree(properties.cu_mask);
+		return -EACCES;
+	}
+
 	mutex_lock(&p->mutex);
 
 	retval = pqm_set_cu_mask(&p->pqm, args->queue_id, &properties);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 8b0eee5b3521..88881bec7550 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1038,6 +1038,9 @@ int pqm_get_wave_state(struct process_queue_manager *pqm,
 		       u32 *ctl_stack_used_size,
 		       u32 *save_area_used_size);
 
+bool pqm_drmcg_lgpu_validate(struct kfd_process *p, int qid, u32 *cu_mask,
+		unsigned int cu_mask_size);
+
 int amdkfd_fence_wait_timeout(unsigned int *fence_addr,
 				unsigned int fence_value,
 				unsigned int timeout_ms);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 7e6c3ee82f5b..a896de290307 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -23,9 +23,11 @@
 
 #include <linux/slab.h>
 #include <linux/list.h>
+#include <linux/cgroup_drm.h>
 #include "kfd_device_queue_manager.h"
 #include "kfd_priv.h"
 #include "kfd_kernel_queue.h"
+#include "amdgpu.h"
 #include "amdgpu_amdkfd.h"
 
 static inline struct process_queue_node *get_queue_by_qid(
@@ -167,6 +169,7 @@ static int create_cp_queue(struct process_queue_manager *pqm,
 				struct queue_properties *q_properties,
 				struct file *f, unsigned int qid)
 {
+	struct drmcg *drmcg;
 	int retval;
 
 	/* Doorbell initialized in user space*/
@@ -180,6 +183,36 @@ static int create_cp_queue(struct process_queue_manager *pqm,
 	if (retval != 0)
 		return retval;
 
+
+	drmcg = drmcg_get(pqm->process->lead_thread);
+	if (drmcg) {
+		struct amdgpu_device *adev;
+		struct drmcg_device_resource *ddr;
+		int mask_size;
+		u32 *mask;
+
+		adev = (struct amdgpu_device *) dev->kgd;
+
+		mask_size = adev->ddev->drmcg_props.lgpu_capacity;
+		mask = kzalloc(sizeof(u32) * round_up(mask_size, 32),
+				GFP_KERNEL);
+
+		if (!mask) {
+			drmcg_put(drmcg);
+			uninit_queue(*q);
+			return -ENOMEM;
+		}
+
+		ddr = drmcg->dev_resources[adev->ddev->primary->index];
+
+		bitmap_to_arr32(mask, ddr->lgpu_allocated, mask_size);
+
+		(*q)->properties.cu_mask_count = mask_size;
+		(*q)->properties.cu_mask = mask;
+
+		drmcg_put(drmcg);
+	}
+
 	(*q)->device = dev;
 	(*q)->process = pqm->process;
 
@@ -495,6 +528,113 @@ int pqm_get_wave_state(struct process_queue_manager *pqm,
 						       save_area_used_size);
 }
 
+bool pqm_drmcg_lgpu_validate(struct kfd_process *p, int qid, u32 *cu_mask,
+		unsigned int cu_mask_size)
+{
+	DECLARE_BITMAP(curr_mask, MAX_DRMCG_LGPU_CAPACITY);
+	struct drmcg_device_resource *ddr;
+	struct process_queue_node *pqn;
+	struct amdgpu_device *adev;
+	struct drmcg *drmcg;
+	bool result;
+
+	if (cu_mask_size > MAX_DRMCG_LGPU_CAPACITY)
+		return false;
+
+	bitmap_from_arr32(curr_mask, cu_mask, cu_mask_size);
+
+	pqn = get_queue_by_qid(&p->pqm, qid);
+	if (!pqn)
+		return false;
+
+	adev = (struct amdgpu_device *)pqn->q->device->kgd;
+
+	drmcg = drmcg_get(p->lead_thread);
+	ddr = drmcg->dev_resources[adev->ddev->primary->index];
+
+	if (bitmap_subset(curr_mask, ddr->lgpu_allocated,
+				MAX_DRMCG_LGPU_CAPACITY))
+		result = true;
+	else
+		result = false;
+
+	drmcg_put(drmcg);
+
+	return result;
+}
+
+int amdgpu_amdkfd_update_cu_mask_for_process(struct task_struct *task,
+		struct amdgpu_device *adev, unsigned long *lgpu_bm,
+		unsigned int lgpu_bm_size)
+{
+	struct kfd_dev *kdev = adev->kfd.dev;
+	struct process_queue_node *pqn;
+	struct kfd_process *kfdproc;
+	size_t size_in_bytes;
+	u32 *cu_mask;
+	int rc = 0;
+
+	if ((lgpu_bm_size % 32) != 0) {
+		pr_warn("lgpu_bm_size %d must be a multiple of 32",
+				lgpu_bm_size);
+		return -EINVAL;
+	}
+
+	kfdproc = kfd_get_process(task);
+
+	if (IS_ERR(kfdproc))
+		return -ESRCH;
+
+	size_in_bytes = sizeof(u32) * round_up(lgpu_bm_size, 32);
+
+	mutex_lock(&kfdproc->mutex);
+	list_for_each_entry(pqn, &kfdproc->pqm.queues, process_queue_list) {
+		if (pqn->q && pqn->q->device == kdev) {
+			/* update cu_mask accordingly */
+			cu_mask = kzalloc(size_in_bytes, GFP_KERNEL);
+			if (!cu_mask) {
+				rc = -ENOMEM;
+				break;
+			}
+
+			if (pqn->q->properties.cu_mask) {
+				DECLARE_BITMAP(curr_mask,
+						MAX_DRMCG_LGPU_CAPACITY);
+
+				if (pqn->q->properties.cu_mask_count >
+						lgpu_bm_size) {
+					rc = -EINVAL;
+					kfree(cu_mask);
+					break;
+				}
+
+				bitmap_from_arr32(curr_mask,
+						pqn->q->properties.cu_mask,
+						pqn->q->properties.cu_mask_count);
+
+				bitmap_and(curr_mask, curr_mask, lgpu_bm,
+						lgpu_bm_size);
+
+				bitmap_to_arr32(cu_mask, curr_mask,
+						lgpu_bm_size);
+
+				kfree(curr_mask);
+			} else
+				bitmap_to_arr32(cu_mask, lgpu_bm,
+						lgpu_bm_size);
+
+			pqn->q->properties.cu_mask = cu_mask;
+			pqn->q->properties.cu_mask_count = lgpu_bm_size;
+
+			rc = pqn->q->device->dqm->ops.update_queue(
+					pqn->q->device->dqm, pqn->q);
+		}
+	}
+	mutex_unlock(&kfdproc->mutex);
+
+	return rc;
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 int pqm_debugfs_mqds(struct seq_file *m, void *data)
-- 
2.22.0


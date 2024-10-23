Return-Path: <cgroups+bounces-5185-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060659AC0B5
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2024 09:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F7A1C2305F
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2024 07:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0486155CBA;
	Wed, 23 Oct 2024 07:53:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0241553AB;
	Wed, 23 Oct 2024 07:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729669993; cv=none; b=oHk9cHzjU9lfZZGuBg2QMxwpp/0tEUjyCguwRaS9iaePMKwPDiq5Ry7utx6CZXsq/h7lgBsZQZk+hYLbM0QJkdVHx7mraWgvFjUT+UkOLpLxHSi39G85iny4jQ4Wp1rB12PMU3LImkAyfyXrGPS7OnYa8WzHvLI4f43/8Js3SeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729669993; c=relaxed/simple;
	bh=6wx6m7b3LpTq5cjrGt/P0vlcWWB/mVDETDZIq/SASZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4TDfXu8UCBMQja84i0ydJgcPZQNqb02IT2HepJfN40MHvtMaYR6f0SJOeBPiTg38LaOu8auijGx4Az4ZId6kBKtFDdQTIw6/MVXJPCVzGT0CUu5zGSXCThLX9LvZFeajWaUcN5uwaiU78pI2YVXd+Qj28S6X9tvFNHW7gDpP9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=mblankhorst.nl; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mblankhorst.nl
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: intel-xe@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Friedrich Vock <friedrich.vock@gmx.de>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH 5/7] drm/amdgpu: Add cgroups implementation
Date: Wed, 23 Oct 2024 09:52:58 +0200
Message-ID: <20241023075302.27194-6-maarten.lankhorst@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241023075302.27194-1-maarten.lankhorst@linux.intel.com>
References: <20241023075302.27194-1-maarten.lankhorst@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to xe, enable some simple management of VRAM only.

Co-developed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h          | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c      | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 6 ++++++
 3 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 9b1e0ede05a45..27c11e43f8e9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -43,6 +43,7 @@
 #include "amdgpu_ctx.h"
 
 #include <linux/atomic.h>
+#include <linux/cgroup_dev.h>
 #include <linux/wait.h>
 #include <linux/list.h>
 #include <linux/kref.h>
@@ -835,6 +836,7 @@ struct amdgpu_device {
 	struct device			*dev;
 	struct pci_dev			*pdev;
 	struct drm_device		ddev;
+	struct dev_cgroup_device		cg;
 
 #ifdef CONFIG_DRM_AMD_ACP
 	struct amdgpu_acp		acp;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 74adb983ab03e..3f6554c7aac2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1874,6 +1874,12 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		return r;
 	}
 
+	r = drmm_cgroup_register_device(adev_to_drm(adev), &adev->cg);
+	if (r) {
+		DRM_ERROR("Failed initializing cgroup allocator.\n");
+		return r;
+	}
+
 	/* Change the size here instead of the init above so only lpfn is affected */
 	amdgpu_ttm_set_buffer_funcs_status(adev, false);
 #ifdef CONFIG_64BIT
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 7d26a962f811c..44d560bef5b7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -927,6 +927,12 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
 		DRM_INFO("Setup dummy vram mgr\n");
 	}
 
+	adev->cg.regions[0].size = adev->gmc.real_vram_size;
+	adev->cg.regions[0].name = "vram";
+	adev->cg.num_regions++;
+	man->cgdev = &adev->cg;
+	man->cgidx = 0;
+
 	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_VRAM, &mgr->manager);
 	ttm_resource_manager_set_used(man, true);
 	return 0;
-- 
2.45.2



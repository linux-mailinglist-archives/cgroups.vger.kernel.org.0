Return-Path: <cgroups+bounces-3405-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E886291ABC9
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 17:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A34C8282BB0
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 15:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F769199254;
	Thu, 27 Jun 2024 15:48:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04196199224;
	Thu, 27 Jun 2024 15:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719503294; cv=none; b=BR/7GlWs1V5Yyaibsc7n2XSNLOZM/nn34yeZa4ize2bLTID6VHPPTQV8wk/mT/9sfaafnbfnf/tUm4WDt0NMFZIUCJ9+BDhdj7urkL/Z46ZfKOWBLodk2wlbQlYIIOSQpSEHxf5gCCnrM5y/kbr4yv15955BiTyTg8HFwQszUkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719503294; c=relaxed/simple;
	bh=oUxs0ABia3BOg6tVOld2iqcgnuLCzfKg6pl4cOPY9us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hiss0YvnrtVBM7l9W5V4F3P3UOjPqm/WIdrVcH2zRouqv3ZoPc7O2+XwMRovdBAJgfKUFsZJI16VT9GQZezf55xfecBFl49hPhfkJPRPw1tcjsY6VUicwocxEo3LOlaKe0PLfHA6VQq3OFBAWLQr1R/C71oBMxKg9hPVRmJ2VkY=
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
	Andrew Morton <akpm@linux-foundation.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Friedrich Vock <friedrich.vock@gmx.de>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	amd-gfx@lists.freedesktop.org
Subject: [RFC PATCH 5/6] drm/amdgpu: Add cgroups implementation
Date: Thu, 27 Jun 2024 17:47:24 +0200
Message-ID: <20240627154754.74828-6-maarten.lankhorst@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627154754.74828-1-maarten.lankhorst@linux.intel.com>
References: <20240627154754.74828-1-maarten.lankhorst@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to xe, enable some simple management of VRAM only.

Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h          | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c      | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 6 ++++++
 3 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index f87d53e183c3..9ec55f05bfd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -43,6 +43,7 @@
 #include "amdgpu_ctx.h"
 
 #include <linux/atomic.h>
+#include <linux/cgroup_drm.h>
 #include <linux/wait.h>
 #include <linux/list.h>
 #include <linux/kref.h>
@@ -836,6 +837,7 @@ struct amdgpu_device {
 	struct device			*dev;
 	struct pci_dev			*pdev;
 	struct drm_device		ddev;
+	struct drmcgroup_device		cg;
 
 #ifdef CONFIG_DRM_AMD_ACP
 	struct amdgpu_acp		acp;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index e785f128411d..1afe28016d40 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1856,6 +1856,12 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		return r;
 	}
 
+	r = drmmcg_register_device(adev_to_drm(adev), &adev->cg);
+	if (r) {
+		DRM_ERROR("Failed initializing cgroup allocator.\n");
+		return r;
+	}
+
 	/* Change the size here instead of the init above so only lpfn is affected */
 	amdgpu_ttm_set_buffer_funcs_status(adev, false);
 #ifdef CONFIG_64BIT
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 6c30eceec896..b207af0bff3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -895,6 +895,12 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
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



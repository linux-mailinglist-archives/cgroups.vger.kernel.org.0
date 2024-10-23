Return-Path: <cgroups+bounces-5188-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 082259AC0E3
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2024 10:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6CA81F21394
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2024 08:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D36156F55;
	Wed, 23 Oct 2024 08:00:55 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20D81448DF;
	Wed, 23 Oct 2024 08:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729670454; cv=none; b=o66SPs3bwLrqTewNxqvTW07TqVct6HP/gKIlTsFISeALjqgH2LHvq07zn3q6b8CPdCk4Y9ypVz1yvYJplFpQP5PkWVcpgC9r+9I8ZXBg/+LM6nS9ENsEDJTjXT2ULTp0uhb6bdomoegLIe5EkbMYleU3GvkFWSG3EQrAjUfDLWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729670454; c=relaxed/simple;
	bh=V1JOK+lIAYlU0PIMxHPHYmNpDgq3+c+7OYFMUa5+PlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xqg0bqo/DA1rsGDl/cooawDs4sssjdX8/nzauSaxcLQSFVmYRcyihXa41j5/camig7gm5OxRfCzv1qxiVnuoPJv9J845TB4A4YCwh/fu37dSiEghE3A//mjTRUaC2XiZk+VTYi+2W5131XpVPqV0kclAy2MHWfFM34lONQtSpWA=
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
Subject: [PATCH 4/7] drm/xe: Implement cgroup for vram
Date: Wed, 23 Oct 2024 09:52:57 +0200
Message-ID: <20241023075302.27194-5-maarten.lankhorst@linux.intel.com>
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

Add vram based cgroup eviction to Xe.
Most hardware with VRAM uses TTM for its management, and can be
similarly trivially enabled.

Co-developed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_device.c       |  4 ++++
 drivers/gpu/drm/xe/xe_device_types.h |  4 ++++
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c | 10 ++++++++++
 3 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 51bb9d875268f..cb4b2013eb808 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -726,6 +726,10 @@ int xe_device_probe(struct xe_device *xe)
 	/* Allocate and map stolen after potential VRAM resize */
 	xe_ttm_stolen_mgr_init(xe);
 
+	err = drmm_cgroup_register_device(&xe->drm, &xe->cg);
+	if (err)
+		goto err;
+
 	/*
 	 * Now that GT is initialized (TTM in particular),
 	 * we can try to init display, and inherit the initial fb.
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 85bede4dd6461..0401b4fe6f645 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -7,6 +7,7 @@
 #define _XE_DEVICE_TYPES_H_
 
 #include <linux/pci.h>
+#include <linux/cgroup_dev.h>
 
 #include <drm/drm_device.h>
 #include <drm/drm_file.h>
@@ -257,6 +258,9 @@ struct xe_device {
 	/** @devcoredump: device coredump */
 	struct xe_devcoredump devcoredump;
 
+	/** @cg: device cgroup bookkeeping */
+	struct dev_cgroup_device cg;
+
 	/** @info: device info */
 	struct intel_device_info {
 		/** @info.platform_name: platform name */
diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
index 423b261ea7430..cb463be53f4bc 100644
--- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
+++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
@@ -339,6 +339,16 @@ int __xe_ttm_vram_mgr_init(struct xe_device *xe, struct xe_ttm_vram_mgr *mgr,
 	struct ttm_resource_manager *man = &mgr->manager;
 	int err;
 
+	if (mem_type != XE_PL_STOLEN) {
+		int cgregion = xe->cg.num_regions++;
+
+		xe->cg.regions[cgregion].size = size;
+		xe->cg.regions[cgregion].name =
+			mem_type == XE_PL_VRAM0 ? "vram0" : "vram1";
+		man->cgdev = &xe->cg;
+		man->cgidx = cgregion;
+	}
+
 	man->func = &xe_ttm_vram_mgr_func;
 	mgr->mem_type = mem_type;
 	mutex_init(&mgr->lock);
-- 
2.45.2



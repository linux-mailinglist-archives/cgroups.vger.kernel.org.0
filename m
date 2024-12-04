Return-Path: <cgroups+bounces-5753-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D179F9E3B88
	for <lists+cgroups@lfdr.de>; Wed,  4 Dec 2024 14:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96A76285E3A
	for <lists+cgroups@lfdr.de>; Wed,  4 Dec 2024 13:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8FC1E0E18;
	Wed,  4 Dec 2024 13:44:27 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17621DFE1E;
	Wed,  4 Dec 2024 13:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733319866; cv=none; b=WS92T1ppHqU4cm+sLFu1E1BfqtxV56dD2ZM4kubmfJTuVqpvcOndeSutG25q+3rZrRRS15hQKtO5f7mojhmNoPluxv0TQVDnnvwwNSf/ndqKAUSZQOEM6tHeIKiou6rjnP7CTcR9rMrymMeeO1stnquTaz9hR73t9c6u7RQaT8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733319866; c=relaxed/simple;
	bh=GN3wl70fzI/9qRoIrW148xySg7joMZwESyLvaLXIApM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rtJLoOD5lE0ZxPRIvDsG7f2ejErNlbCtcrR47PbZBfJ4qmm61BuM+5VVFR8yNsjoZRzVR27yIQG4S+ShJysmer8163bbAtTB5zepdNf+mmSsbP28VhyOe7E81Ah9aLLyCtfqM3ApBjSSqC5lE9GHGapYhdohK59r8mIuGch3/9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lankhorst.se; spf=none smtp.mailfrom=mblankhorst.nl; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mblankhorst.nl
From: Maarten Lankhorst <dev@lankhorst.se>
To: linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Friedrich Vock <friedrich.vock@gmx.de>,
	Maxime Ripard <mripard@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [PATCH v2 5/7] drm/amdgpu: Add cgroups implementation
Date: Wed,  4 Dec 2024 14:44:05 +0100
Message-ID: <20241204134410.1161769-6-dev@lankhorst.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204134410.1161769-1-dev@lankhorst.se>
References: <20241204134410.1161769-1-dev@lankhorst.se>
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
Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 7d26a962f811c..f1703a746cadd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -24,6 +24,7 @@
 
 #include <linux/dma-mapping.h>
 #include <drm/ttm/ttm_range_manager.h>
+#include <drm/drm_drv.h>
 
 #include "amdgpu.h"
 #include "amdgpu_vm.h"
@@ -908,6 +909,9 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
 	struct ttm_resource_manager *man = &mgr->manager;
 	int err;
 
+	man->cg = drmm_cgroup_register_region(adev_to_drm(adev), "vram", adev->gmc.real_vram_size);
+	if (IS_ERR(man->cg))
+		return PTR_ERR(man->cg);
 	ttm_resource_manager_init(man, &adev->mman.bdev,
 				  adev->gmc.real_vram_size);
 
-- 
2.43.0



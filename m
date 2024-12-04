Return-Path: <cgroups+bounces-5755-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FA09E3B8B
	for <lists+cgroups@lfdr.de>; Wed,  4 Dec 2024 14:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC852285E19
	for <lists+cgroups@lfdr.de>; Wed,  4 Dec 2024 13:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB95B1F1316;
	Wed,  4 Dec 2024 13:44:27 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B170B1DFE15;
	Wed,  4 Dec 2024 13:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733319867; cv=none; b=gcrB6+SmKJG3FsMDzFBVPK4B8kG8hy26CpI1odhX8lQbcubRqKGC2kjAWBVEtCqJqv6VUzSQJaU+Zv7DDZiCrwmffheW9wMEYejhGGhkd3sA7fVv0XFaCRRj3A5x0h/10kQkXbKgybY7v5K4Pxn2efKwIeSDImYbfR2GZat+QFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733319867; c=relaxed/simple;
	bh=Xak1XccIYr9xqA3K8i6quLqHM4KzCpvfAZWZO18WlM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K3CRg15mo+iAj5GPQkCOMYWFVnY1nQWanZ2uQkU+E3JPjGG0FcJ0QezJz2n7Hq0XRpYbsKxq48e5rG1D/Z9akM4ew3VG//Su9MPcYKOStQfdTITTcr+J66upHGzNgeN8/DWx2polywnRoLTQFYw3WyoqvWI9pZbVUc40qr7sFcQ=
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
Subject: [PATCH v2 6/7] drm/xe: Hack to test with mapped pages instead of vram.
Date: Wed,  4 Dec 2024 14:44:06 +0100
Message-ID: <20241204134410.1161769-7-dev@lankhorst.se>
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

We will probably want to make this a proper region in TTM for
everything, so that we can charge VRAM twice, once for mapped
in sysmem, once for mapped in vram. That way we don't need to
deal with evict failing from lack of available memory in mapped.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/gpu/drm/xe/xe_ttm_sys_mgr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_ttm_sys_mgr.c b/drivers/gpu/drm/xe/xe_ttm_sys_mgr.c
index 9844a8edbfe19..5450caaef52ad 100644
--- a/drivers/gpu/drm/xe/xe_ttm_sys_mgr.c
+++ b/drivers/gpu/drm/xe/xe_ttm_sys_mgr.c
@@ -11,6 +11,7 @@
 #include <drm/ttm/ttm_placement.h>
 #include <drm/ttm/ttm_range_manager.h>
 #include <drm/ttm/ttm_tt.h>
+#include <drm/drm_drv.h>
 
 #include "xe_bo.h"
 #include "xe_gt.h"
@@ -112,6 +113,10 @@ int xe_ttm_sys_mgr_init(struct xe_device *xe)
 	/* TTM limits allocation of all TTM devices by 50% of system memory */
 	gtt_size /= 2;
 
+	man->cg = drmm_cgroup_register_region(&xe->drm, "mapped", gtt_size);
+	if (IS_ERR(man->cg))
+		return PTR_ERR(man->cg);
+
 	man->use_tt = true;
 	man->func = &xe_ttm_sys_mgr_func;
 	ttm_resource_manager_init(man, &xe->ttm, gtt_size >> PAGE_SHIFT);
-- 
2.43.0



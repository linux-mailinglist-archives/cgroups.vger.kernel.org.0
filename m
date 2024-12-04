Return-Path: <cgroups+bounces-5757-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B589E3BBA
	for <lists+cgroups@lfdr.de>; Wed,  4 Dec 2024 14:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EC151644D1
	for <lists+cgroups@lfdr.de>; Wed,  4 Dec 2024 13:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E701F668C;
	Wed,  4 Dec 2024 13:53:23 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917671F666A;
	Wed,  4 Dec 2024 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733320403; cv=none; b=NUJa7QkD1oQTGcULkJTtvRMWhD80+/5XjehAAS8kl+PFAa9JffcGpMe6xp9D+rK3xjuWa5AlhW4Cz+HRjewSuNFGeGDRcYEAjaRuQejYW7/xF7ex1VBPga5LoLAoDv/xXcWQE06VwckDFsaOmwRrCo3bpW3ODedr5DuZ7aW8rNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733320403; c=relaxed/simple;
	bh=GIwdFJJPvtSLrhir3NZrvBk+WjaZYHX/SzE1gNK/0AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QSyBUZAEG92bxnjirhot4e0EqKpo23V9QDlvVH9OX9VSc+67v6skk2TVEsbDURlZf5C3E7eFsBMpBD1+m5pAOTlAxjwpDEzQ9OO5st29uWwC6QskRVGqt+FcFu5wqFl19/DJzF2sFrFv0KIMcTSpJVY2TQiQHqqjvvPaFFFh3kM=
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
Subject: [PATCH v2 4/7] drm/xe: Implement cgroup for vram
Date: Wed,  4 Dec 2024 14:44:04 +0100
Message-ID: <20241204134410.1161769-5-dev@lankhorst.se>
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

Add vram based cgroup eviction to Xe.
Most hardware with VRAM uses TTM for its management, and can be
similarly trivially enabled.

Co-developed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
index c95728c45ea48..f4a16e5fa7700 100644
--- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
+++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
@@ -5,6 +5,7 @@
  */
 
 #include <drm/drm_managed.h>
+#include <drm/drm_drv.h>
 
 #include <drm/ttm/ttm_placement.h>
 #include <drm/ttm/ttm_range_manager.h>
@@ -311,6 +312,13 @@ int __xe_ttm_vram_mgr_init(struct xe_device *xe, struct xe_ttm_vram_mgr *mgr,
 	struct ttm_resource_manager *man = &mgr->manager;
 	int err;
 
+	if (mem_type != XE_PL_STOLEN) {
+		const char *name = mem_type == XE_PL_VRAM0 ? "vram0" : "vram1";
+		man->cg = drmm_cgroup_register_region(&xe->drm, name, size);
+		if (IS_ERR(man->cg))
+			return PTR_ERR(man->cg);
+	}
+
 	man->func = &xe_ttm_vram_mgr_func;
 	mgr->mem_type = mem_type;
 	mutex_init(&mgr->lock);
-- 
2.43.0



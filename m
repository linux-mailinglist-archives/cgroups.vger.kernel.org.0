Return-Path: <cgroups+bounces-5754-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034879E3B89
	for <lists+cgroups@lfdr.de>; Wed,  4 Dec 2024 14:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5B6D165573
	for <lists+cgroups@lfdr.de>; Wed,  4 Dec 2024 13:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B941E3DFA;
	Wed,  4 Dec 2024 13:44:27 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE4C8827;
	Wed,  4 Dec 2024 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733319867; cv=none; b=LfTZtSBn3/1nUJWq8sR15v/ZDim1rBDeE98/jzp38GVvTmvht4xahVl8aJ6KYmHM+wY9rsxjou57qTCpkKPYpoylhaN5hLltEF+rx+WGNUDK0xFcWMxWJFflw9x0KGBV2KCbDk7T1Lb7pV3uEFdHvabAbyoOUijllfAo24G/CeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733319867; c=relaxed/simple;
	bh=I9cRCosP71yDh0ePXjHoMCpw6t56q2zBrveZE7ey8wA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pAKSbHcuIkuRf+HbODhzofXMnQ20NagRmhntEXCMvnj5zyrSZLZOcLDvtu9c3iYa9Pt5N4dwJkJ9MFTf9ArrNbEUvmuk4Y9ee8/s9rwWUKr8c9uWQA90Qa+EXZ8evn/lYxB5Fup0gjsBo7QuSt8HzzJPQpjfV1PAigmebmxVVhk=
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
Subject: [PATCH v2 7/7] drm/gem: Add cgroup memory accounting for VRAM helper.
Date: Wed,  4 Dec 2024 14:44:07 +0100
Message-ID: <20241204134410.1161769-8-dev@lankhorst.se>
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

From: Maxime Ripard <mripard@kernel.org>

This allows any driver using the VRAM helper to set limits on VRAM using
cgroup.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/gpu/drm/drm_gem_vram_helper.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index 22b1fe9c03b81..70979523ee984 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -925,6 +925,7 @@ EXPORT_SYMBOL(drm_vram_mm_debugfs_init);
 static int drm_vram_mm_init(struct drm_vram_mm *vmm, struct drm_device *dev,
 			    uint64_t vram_base, size_t vram_size)
 {
+	struct ttm_resource_manager *man;
 	int ret;
 
 	vmm->vram_base = vram_base;
@@ -939,8 +940,20 @@ static int drm_vram_mm_init(struct drm_vram_mm *vmm, struct drm_device *dev,
 
 	ret = ttm_range_man_init(&vmm->bdev, TTM_PL_VRAM,
 				 false, vram_size >> PAGE_SHIFT);
-	if (ret)
+	if (ret) {
+		ttm_device_fini(&vmm->bdev);
 		return ret;
+	}
+
+	man = ttm_manager_type(&vmm->bdev, TTM_PL_VRAM);
+	man->cg = drmm_register_region(dev, "vram", size);
+	if (IS_ERR(man->cg)) {
+		ret = PTR_ERR(man->cg);
+
+		ttm_range_man_fini(&vmm->bdev, TTM_PL_VRAM);
+		ttm_device_fini(&vmm->bdev);
+		return ret;
+	}
 
 	return 0;
 }
-- 
2.43.0



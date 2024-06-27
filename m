Return-Path: <cgroups+bounces-3406-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4CC91ABCA
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 17:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B4C4282FC7
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 15:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD4419938A;
	Thu, 27 Jun 2024 15:48:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62DF199249;
	Thu, 27 Jun 2024 15:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719503294; cv=none; b=fSy30mrVa4PicSRSUreAe2CVQMARQpz322AkqNaWnw1je5ptKc/8zfLigNbGqfTE1B23+CympKmq1RsXgsq07ZKcCaQ+djK7F0iThhXSc21Gqc4kXKXKK4UgB4zk0wzV4HeSL2GBQJomBmyANZi2XDKZcb2bC6kr13qm6K61JAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719503294; c=relaxed/simple;
	bh=Ug7/0LSxnMXTm6BkMSSPHGcN/GxtqUHC2G1ZRj/ewGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjN6/3yYv/Wum7UpHRGV+6S6j2bQdrMF13LWPCVhY7gFf9VodD50zzhy7DoWnljU6LkJODuZOarImOM8PST7enm8R3Xnu5qNclMim4X2aOfeKNotIwsamyrRjc/NRnBtdRqZR37ds4JuxEhzej0ENQpwFjl7v8P+4+nsRV6ksv0=
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
	Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Friedrich Vock <friedrich.vock@gmx.de>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 6/6] drm/xe: Hack to test with mapped pages instead of vram.
Date: Thu, 27 Jun 2024 17:47:25 +0200
Message-ID: <20240627154754.74828-7-maarten.lankhorst@linux.intel.com>
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

We will probably want to make this a proper region in TTM for
everything, so that we can charge VRAM twice, once for mapped
in sysmem, once for mapped in vram. That way we don't need to
deal with evict failing from lack of available memory in mapped.

Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_ttm_sys_mgr.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_ttm_sys_mgr.c b/drivers/gpu/drm/xe/xe_ttm_sys_mgr.c
index 9844a8edbfe1..20fa8ec8925e 100644
--- a/drivers/gpu/drm/xe/xe_ttm_sys_mgr.c
+++ b/drivers/gpu/drm/xe/xe_ttm_sys_mgr.c
@@ -101,6 +101,18 @@ static void ttm_sys_mgr_fini(struct drm_device *drm, void *arg)
 	ttm_set_driver_manager(&xe->ttm, XE_PL_TT, NULL);
 }
 
+static inline void apply_cg(struct xe_device *xe,
+			    struct ttm_resource_manager *man,
+			    u64 gtt_size)
+{
+	int cgregion = xe->cg.num_regions++;
+
+	xe->cg.regions[cgregion].size = gtt_size;
+	xe->cg.regions[cgregion].name = "mapped";
+	man->cgdev = &xe->cg;
+	man->cgidx = cgregion;
+
+}
 int xe_ttm_sys_mgr_init(struct xe_device *xe)
 {
 	struct ttm_resource_manager *man = &xe->mem.sys_mgr;
@@ -116,6 +128,8 @@ int xe_ttm_sys_mgr_init(struct xe_device *xe)
 	man->func = &xe_ttm_sys_mgr_func;
 	ttm_resource_manager_init(man, &xe->ttm, gtt_size >> PAGE_SHIFT);
 	ttm_set_driver_manager(&xe->ttm, XE_PL_TT, man);
+	apply_cg(xe, man, gtt_size);
+
 	ttm_resource_manager_set_used(man, true);
 	return drmm_add_action_or_reset(&xe->drm, ttm_sys_mgr_fini, xe);
 }
-- 
2.45.2



Return-Path: <cgroups+bounces-5187-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 844639AC0B9
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2024 09:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4592B284B85
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2024 07:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95137156C70;
	Wed, 23 Oct 2024 07:53:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFD415533F;
	Wed, 23 Oct 2024 07:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729669994; cv=none; b=LEgK8LZCH7Z1cK+0ddZjqlNaAQwTpjMmIC3lkni9lhJSyDTsu4xTrlL9OBjAjbHv10+uHWpoi7cKR5MZ/WdZ8VLIuDCBF5eA2cZ/9IytHKq34dzwhGQuQyoxDhlyxkiJZnZJ7iruLyOWHDpxcD4ibmCD8As9QHcOleTvgYspEx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729669994; c=relaxed/simple;
	bh=kF0cGGT5Zw8IUILOhiJIE9jUErlG2idxCLXD48N8ZlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHtfAgcGZAAUqIEiT4YmRzSicHkmeqg/2Ocr07rZ0jKUteqZLYgn2cD3m7gPwyykF1RRBtk2tN7Ax1blsQPUuTkYYSQ31yGx0KQU5KGmyUBEGBUcTMf/+8G9wOWCqW9Cn5Nxi7PZwVsvL8BsQROv0amPeyX6IbT8HBQU+AX2TFk=
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
Subject: [PATCH 6/7] [HACK] drm/xe: Hack to test with mapped pages instead of vram.
Date: Wed, 23 Oct 2024 09:52:59 +0200
Message-ID: <20241023075302.27194-7-maarten.lankhorst@linux.intel.com>
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

We will probably want to make this a proper region in TTM for
everything, so that we can charge VRAM twice, once for mapped
in sysmem, once for mapped in vram. That way we don't need to
deal with evict failing from lack of available memory in mapped.

Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/xe/xe_ttm_sys_mgr.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_ttm_sys_mgr.c b/drivers/gpu/drm/xe/xe_ttm_sys_mgr.c
index 9844a8edbfe19..20fa8ec8925ef 100644
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



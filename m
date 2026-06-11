Return-Path: <cgroups+bounces-16868-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /JCqOA7yKmpdzwMAu9opvQ
	(envelope-from <cgroups+bounces-16868-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 19:36:14 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 821A467409A
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 19:36:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=D72zsxin;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16868-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16868-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C815F3047740
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 17:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C17A4BCADF;
	Thu, 11 Jun 2026 17:33:50 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8FF4A3409;
	Thu, 11 Jun 2026 17:33:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781199229; cv=none; b=pNoCv8Nwk43PMNIWe+8hY6Cd2kfS5mQa14FJZv5PY1kjwB5xEWsp6FxAtq0Exki3FddjLX0w39SN25u1CgrcZdx1hfsMhBLoIv9vh7+YxsXCePw+HfGtVZZu715iJAq1ypNXvujx8JWrAZ+meXroQQi2wkrMR9aUAvAM2XM0WPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781199229; c=relaxed/simple;
	bh=j0LFqFDMM+mkQ5KenBd9BFas8ZBxm6v3GaG5SybWrEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LyaRiJwWt3Di/EEsA4zIyESiEmnlmeiAGR+B8W5jMskcQTpSkxexPbWRgOlwZKIzR2MPHfnnL3VvrKIM+aRu6ekCsUByzD0+G5H9Lr851z2wu4+/3ut/fTWGq5js6LejjYEzn+Ay2h/CR6bR9y/nZNR7c39evRIpLF5ToK5jlVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D72zsxin; arc=none smtp.client-ip=198.175.65.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781199226; x=1812735226;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j0LFqFDMM+mkQ5KenBd9BFas8ZBxm6v3GaG5SybWrEo=;
  b=D72zsxinoTSRHgKsjG3UOlQoUxHYEgMN/ohoAKxkP8wFJKo5XQYio5GZ
   swQAE64wXwbtJpT7JoCqhYI+hswQfZAqt4eLSL1sSaMibJrQbHae1XxYx
   /cAAD4hrmB4kpTF55PnLWgfw7jPsPOXH6K36jhQXkakH5Kr9TpLgZJT1j
   z9WLpxzUPICe/WyRQ7fYmXDr6yFVQJQwwKvz+e/8T9wUd/6Co3KVxhBJC
   WZX0kWamWnjkFmMDuRtLmkhyJR0cgXbBfJGNO4virEQmGhNcfaZSRxIBB
   BJfiuBMW9Ec6wx776/VgFdHyrleJU10GBV6zkyuOohKoyvbQ3r22RbLgT
   w==;
X-CSE-ConnectionGUID: 7lCz5MSaQ2+bKKuLWPuBmg==
X-CSE-MsgGUID: 3VE9cuoBQteSTL5sSb9amQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81761991"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="81761991"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 10:33:46 -0700
X-CSE-ConnectionGUID: UMi9u30UQ9C157QApI19Og==
X-CSE-MsgGUID: iNLHiI9qSqSYa9125rwBzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="240214945"
Received: from amilburn-desk.amilburn-desk (HELO fedora) ([10.245.244.169])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 10:33:41 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Natalie Vock <natalie.vock@gmx.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Tejun Heo <tj@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org,
	Huang Rui <ray.huang@amd.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/6] cgroup/dmem: Introduce struct dmem_cgroup_init for region initialization
Date: Thu, 11 Jun 2026 19:32:57 +0200
Message-ID: <20260611173301.17473-3-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611173301.17473-1-thomas.hellstrom@linux.intel.com>
References: <20260611173301.17473-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16868-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[thomas.hellstrom@linux.intel.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS(0.00)[m:intel-xe@lists.freedesktop.org,m:thomas.hellstrom@linux.intel.com,m:natalie.vock@gmx.de,m:hannes@cmpxchg.org,m:tj@kernel.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:ray.huang@amd.com,m:matthew.brost@intel.com,m:matthew.auld@intel.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:simona@ffwll.ch,m:airlied@gmail.com,m:christian.koenig@amd.com,m:alexander.deucher@amd.com,m:rodrigo.vivi@intel.com,m:dri-devel@lists.freedesktop.org,m:amd-gfx@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux.intel.com,gmx.de,cmpxchg.org,kernel.org,suse.com,vger.kernel.org,amd.com,intel.com,suse.de,ffwll.ch,gmail.com,lists.freedesktop.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,linux.intel.com:mid,linux.intel.com:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 821A467409A

Replace the bare u64 size argument to dmem_cgroup_register_region() and
drmm_cgroup_register_region() with a const struct dmem_cgroup_init *
pointer. The struct currently carries only the size field, but using a
struct makes the API extensible: future callers can supply additional
initialization parameters without adding more positional arguments.

Update all in-tree callers (amdgpu, xe) to use a compound-literal
initializer.

v5:
- Commit introduced.

Assisted-by: GitHub_Copilot:claude-sonnet-4.6
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c |  6 +++++-
 drivers/gpu/drm/drm_drv.c                    |  8 +++++---
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c         |  7 ++++++-
 include/drm/drm_drv.h                        |  4 +++-
 include/linux/cgroup_dmem.h                  | 16 +++++++++++++---
 kernel/cgroup/dmem.c                         | 10 ++++++----
 6 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index ac3f71d77140..08f05c3aed1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -23,6 +23,7 @@
  */
 
 #include <linux/dma-mapping.h>
+#include <linux/cgroup_dmem.h>
 #include <drm/ttm/ttm_range_manager.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_buddy.h>
@@ -932,7 +933,10 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
 	if (err)
 		return err;
 
-	man->cg = drmm_cgroup_register_region(adev_to_drm(adev), "vram", adev->gmc.real_vram_size);
+	man->cg = drmm_cgroup_register_region(adev_to_drm(adev), "vram",
+					      &(struct dmem_cgroup_init){
+						.size = adev->gmc.real_vram_size,
+					      });
 	if (IS_ERR(man->cg))
 		return PTR_ERR(man->cg);
 
diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 1ff0bf7cba6a..3c570f9393b9 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -960,17 +960,19 @@ static void drmm_cg_unregister_region(struct drm_device *dev, void *arg)
  * drmm_cgroup_register_region - Register a region of a DRM device to cgroups
  * @dev: device for region
  * @region_name: Region name for registering
- * @size: Size of region in bytes
+ * @init: Initialization parameters for the region.
  *
  * This decreases the ref-count of @dev by one. The device is destroyed if the
  * ref-count drops to zero.
  */
-struct dmem_cgroup_region *drmm_cgroup_register_region(struct drm_device *dev, const char *region_name, u64 size)
+struct dmem_cgroup_region *
+drmm_cgroup_register_region(struct drm_device *dev, const char *region_name,
+			    const struct dmem_cgroup_init *init)
 {
 	struct dmem_cgroup_region *region;
 	int ret;
 
-	region = dmem_cgroup_register_region(size, "drm/%s/%s", dev->unique, region_name);
+	region = dmem_cgroup_register_region(init, "drm/%s/%s", dev->unique, region_name);
 	if (IS_ERR_OR_NULL(region))
 		return region;
 
diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
index b518f7dec680..308fda4248eb 100644
--- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
+++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
@@ -4,6 +4,8 @@
  * Copyright (C) 2021-2022 Red Hat
  */
 
+#include <linux/cgroup_dmem.h>
+
 #include <drm/drm_managed.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_buddy.h>
@@ -303,7 +305,10 @@ int __xe_ttm_vram_mgr_init(struct xe_device *xe, struct xe_ttm_vram_mgr *mgr,
 	int err;
 
 	name = mem_type == XE_PL_VRAM0 ? "vram0" : "vram1";
-	man->cg = drmm_cgroup_register_region(&xe->drm, name, size);
+	man->cg = drmm_cgroup_register_region(&xe->drm, name,
+					      &(struct dmem_cgroup_init){
+						.size = size,
+					      });
 	if (IS_ERR(man->cg))
 		return PTR_ERR(man->cg);
 
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index e09559495c5b..b23830494ed4 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -34,6 +34,7 @@
 
 #include <drm/drm_device.h>
 
+struct dmem_cgroup_init;
 struct dmem_cgroup_region;
 struct drm_fb_helper;
 struct drm_fb_helper_surface_size;
@@ -433,7 +434,8 @@ void *__devm_drm_dev_alloc(struct device *parent,
 
 struct dmem_cgroup_region *
 drmm_cgroup_register_region(struct drm_device *dev,
-			    const char *region_name, u64 size);
+			    const char *region_name,
+			    const struct dmem_cgroup_init *init);
 
 /**
  * devm_drm_dev_alloc - Resource managed allocation of a &drm_device instance
diff --git a/include/linux/cgroup_dmem.h b/include/linux/cgroup_dmem.h
index dd4869f1d736..d9eab8a2c1ee 100644
--- a/include/linux/cgroup_dmem.h
+++ b/include/linux/cgroup_dmem.h
@@ -14,8 +14,18 @@ struct dmem_cgroup_pool_state;
 /* Opaque definition of a cgroup region, used internally */
 struct dmem_cgroup_region;
 
+/**
+ * struct dmem_cgroup_init - Initialization parameters for a dmem cgroup region.
+ * @size: Size of the region in bytes.
+ */
+struct dmem_cgroup_init {
+	u64 size;
+};
+
 #if IS_ENABLED(CONFIG_CGROUP_DMEM)
-struct dmem_cgroup_region *dmem_cgroup_register_region(u64 size, const char *name_fmt, ...) __printf(2,3);
+struct dmem_cgroup_region *
+dmem_cgroup_register_region(const struct dmem_cgroup_init *init,
+			    const char *name_fmt, ...) __printf(2, 3);
 void dmem_cgroup_unregister_region(struct dmem_cgroup_region *region);
 int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, u64 size,
 			   struct dmem_cgroup_pool_state **ret_pool,
@@ -27,8 +37,8 @@ bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
 
 void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state *pool);
 #else
-static inline __printf(2,3) struct dmem_cgroup_region *
-dmem_cgroup_register_region(u64 size, const char *name_fmt, ...)
+static inline __printf(2, 3) struct dmem_cgroup_region *
+dmem_cgroup_register_region(const struct dmem_cgroup_init *init, const char *name_fmt, ...)
 {
 	return NULL;
 }
diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 6430c7ce1e03..d12c8543f3fe 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -502,7 +502,7 @@ EXPORT_SYMBOL_GPL(dmem_cgroup_unregister_region);
 
 /**
  * dmem_cgroup_register_region() - Register a regions for dev cgroup.
- * @size: Size of region to register, in bytes.
+ * @init: Initialization parameters for the region.
  * @fmt: Region parameters to register
  *
  * This function registers a node in the dmem cgroup with the
@@ -511,13 +511,15 @@ EXPORT_SYMBOL_GPL(dmem_cgroup_unregister_region);
  *
  * Return: NULL or a struct on success, PTR_ERR on failure.
  */
-struct dmem_cgroup_region *dmem_cgroup_register_region(u64 size, const char *fmt, ...)
+struct dmem_cgroup_region *
+dmem_cgroup_register_region(const struct dmem_cgroup_init *init,
+			    const char *fmt, ...)
 {
 	struct dmem_cgroup_region *ret;
 	char *region_name;
 	va_list ap;
 
-	if (!size)
+	if (!init || !init->size)
 		return NULL;
 
 	va_start(ap, fmt);
@@ -534,7 +536,7 @@ struct dmem_cgroup_region *dmem_cgroup_register_region(u64 size, const char *fmt
 
 	INIT_LIST_HEAD(&ret->pools);
 	ret->name = region_name;
-	ret->size = size;
+	ret->size = init->size;
 	kref_init(&ret->ref);
 
 	spin_lock(&dmemcg_lock);
-- 
2.54.0



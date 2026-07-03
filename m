Return-Path: <cgroups+bounces-17466-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 65oxFne1R2pzdwAAu9opvQ
	(envelope-from <cgroups+bounces-17466-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 03 Jul 2026 15:13:27 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C62E5702B8B
	for <lists+cgroups@lfdr.de>; Fri, 03 Jul 2026 15:13:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=kFPw6Eu7;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17466-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17466-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C8223094004
	for <lists+cgroups@lfdr.de>; Fri,  3 Jul 2026 13:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943993D5671;
	Fri,  3 Jul 2026 13:06:41 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4113D47AA;
	Fri,  3 Jul 2026 13:06:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783084001; cv=none; b=gM57jB1hQWZjaS/eyWFCIzrCAnsD3BjR1bTwn4YLOctFeDnsAoIx+7unxNWfPIZF0oAo5GhYFIWp1I/bUI3eb/BUuGmRKn8PfGCEeS2icckaPYQBHyg9f0prkLoIb+xf1Tb7dU50lUKYUZtTThsFdeZPT65uELla0ND2w4ErEUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783084001; c=relaxed/simple;
	bh=j0LFqFDMM+mkQ5KenBd9BFas8ZBxm6v3GaG5SybWrEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AaRzvFVG0h21SaFfO7C11Z3R6GF568YuKjq1kkKN/nBZFJDQYgyhyzbXsgrQsjxDWeVrTGCA8cPO75Qs7DeU22l865TNp5ErPdubmec2miBlHiwLXeZvbr44aOuEp+UDN2MBGJDR2aO+5tXGnV+xANxpROu/i3UYXFly91GcIhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kFPw6Eu7; arc=none smtp.client-ip=198.175.65.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783084000; x=1814620000;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j0LFqFDMM+mkQ5KenBd9BFas8ZBxm6v3GaG5SybWrEo=;
  b=kFPw6Eu7M0AixEbJ7t1+/05TFwQPdSyXtMPNe6kOwqzwF4tTE8I0Bw1i
   +HukVSSXjIRsoIp0oOdkGxzSHukV1M6dWhyCSPWwtq4F6mU6o0qMvu8ww
   vVMrqN2aUwmffJVSBJEgJHHYa78W1w4CBV8sBM/U0tZNTZgjECo7TeI+Z
   5HJqAC4ROzfWP8Rj9nyfpbLDmTeysj1lO7uKzmYW4zu47PuV6c5H4PXbX
   hrPO4OLtPoBsr1D+3RUDmdfG/RWNa6OXzWqacozLEbW+8jRy7nFhtJzei
   WA5OzsAYwops3Y8YID8adMmYXqnBbosqTb5bjYCSGE80ScOx8CC95KQo/
   Q==;
X-CSE-ConnectionGUID: yQSfVVGmQwSyJmbfuGN2nw==
X-CSE-MsgGUID: 1JumQRLKSGi/G9h/meacvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="83702308"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="83702308"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 06:06:39 -0700
X-CSE-ConnectionGUID: HHatr+bZTUWgLrptRTef2g==
X-CSE-MsgGUID: GW1b/rBfT66u4D+pZ3r6IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="283199579"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO fedora) ([10.245.245.146])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 06:06:35 -0700
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
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/6] cgroup/dmem: Introduce struct dmem_cgroup_init for region initialization
Date: Fri,  3 Jul 2026 15:05:37 +0200
Message-ID: <20260703130541.2686-3-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703130541.2686-1-thomas.hellstrom@linux.intel.com>
References: <20260703130541.2686-1-thomas.hellstrom@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17466-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[thomas.hellstrom@linux.intel.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:intel-xe@lists.freedesktop.org,m:thomas.hellstrom@linux.intel.com,m:natalie.vock@gmx.de,m:hannes@cmpxchg.org,m:tj@kernel.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:ray.huang@amd.com,m:matthew.brost@intel.com,m:matthew.auld@intel.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:simona@ffwll.ch,m:airlied@gmail.com,m:christian.koenig@amd.com,m:cascardo@igalia.com,m:alexander.deucher@amd.com,m:rodrigo.vivi@intel.com,m:dri-devel@lists.freedesktop.org,m:amd-gfx@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux.intel.com,gmx.de,cmpxchg.org,kernel.org,suse.com,vger.kernel.org,amd.com,intel.com,suse.de,ffwll.ch,gmail.com,igalia.com,lists.freedesktop.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.intel.com:mid,linux.intel.com:from_mime,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C62E5702B8B

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



Return-Path: <cgroups+bounces-16859-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tFo+DbTFKmrNwgMAu9opvQ
	(envelope-from <cgroups+bounces-16859-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 16:27:00 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 97913672B5C
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 16:26:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=WiB+jbzX;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16859-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-16859-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7F4F3112F2C
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 14:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4BF410D38;
	Thu, 11 Jun 2026 14:23:36 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36EC3FBB68;
	Thu, 11 Jun 2026 14:23:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781187816; cv=none; b=N0z8qxSJRQBfFEFn4+cgQPSv9XcJmqKuyfN17dHegqN1NV5i7RYC2ZvlxRGTuFDaGO2trrbF+pMCH7oE/i73snJVxN6ZWcTpEJTtNMYMEbKjhpdcCHrQQ4jOWk8fCcPiKv84WF3Ccu0FO9qIuZ80ePSK5e6YtkSGgwgey9eZQUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781187816; c=relaxed/simple;
	bh=awhOvbKuIT8kazUlxYlfnhoiupJ7K7wXsTHZirjffKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WQVSWUD3T1utw3XLH2Ftdm79LEabypbTScerQjKgaDWrou1rbNCyv8UMWtgNa9hUnPXo0RxXHoo5BbiHG1BYPDtKgZoqXajTD7sN/wSf9cOpxgQ24JbF7uC0TYcyHLfe9Ul1fXdMYS/cohSPgpx4PPga2y1JhwaCtZkpbV32uB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WiB+jbzX; arc=none smtp.client-ip=198.175.65.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781187814; x=1812723814;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=awhOvbKuIT8kazUlxYlfnhoiupJ7K7wXsTHZirjffKQ=;
  b=WiB+jbzXBKvo/3F4nGa5kye/nDu88kXFJfCNDm7jftZ/hL9EBpCmAO+f
   OKIlrjkSi0iiF3wwAtFAjRd3p79PqWHlLEAwPlGvdphiR+yr7sbBVvTlf
   8Fxcdub5zPUtGaY904Z8Fb6IwbG4X7ehs/gETtuJaR2OmWHoi9twEUTJf
   ALkuwDhwJyCbPYlDn3AqyELZ8lw1bft9CJwQqtEYd9hnN9JNbhMQ00klQ
   5q1Iq+hQkbcYe/ga//yih6cpgHKXQrraBKw2ISf1DUPSBaIM3RRS4te3/
   CYDpR6PeSBkpvREtK8Mjjt1uIzTidfR8awyp0/Zh9KPGPeF6ElrLYav98
   A==;
X-CSE-ConnectionGUID: Df5XlSXMSy+/93xo1990/g==
X-CSE-MsgGUID: c+MrapyfQZKhOrU7ooomrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81983462"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="81983462"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 07:23:34 -0700
X-CSE-ConnectionGUID: 7XeEKXDxQ/a37dPKAsAtfw==
X-CSE-MsgGUID: zK/aDci3QaeXjSjER8BUcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="284574385"
Received: from amilburn-desk.amilburn-desk (HELO fedora) ([10.245.244.169])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 07:23:30 -0700
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
Subject: [PATCH v5 6/6] drm/amdgpu: Wire up dmem cgroup reclaim for VRAM manager
Date: Thu, 11 Jun 2026 16:22:42 +0200
Message-ID: <20260611142242.2529-7-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611142242.2529-1-thomas.hellstrom@linux.intel.com>
References: <20260611142242.2529-1-thomas.hellstrom@linux.intel.com>
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
	TAGGED_FROM(0.00)[bounces-16859-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,linux.intel.com:from_mime,intel.com:dkim,intel.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 97913672B5C

Register the VRAM manager with the dmem cgroup reclaim infrastructure
so that lowering dmem.max below current VRAM usage triggers TTM
eviction rather than failing with -EBUSY.

Guard place->flags in amdgpu_ttm_bo_eviction_valuable() against NULL,
as the TTM reclaim path passes a NULL place in cgroup drain mode.

v3:
- Rebased on fix for uninitialized list and buddy allocator on the
  drmm_cgroup_register_region() error path.

v5:
- Rebased on the introduction of struct dmem_cgroup_init.
- Clear the reclaim callback in amdgpu_vram_mgr_fini() to prevent
  use-after-free if cgroup reclaim is triggered after driver unbind
  while userspace holds an open DRM file descriptor. (Sashiko-bot)
- Switch from drmm_cgroup_register_region() to the raw
  dmem_cgroup_register_region() and store the region in
  amdgpu_vram_mgr.cg_region. Explicitly call
  dmem_cgroup_unregister_region() at the top of amdgpu_vram_mgr_fini()
  before any manager teardown, draining in-flight reclaim callbacks via
  the rwsem before the manager is destroyed. This is required because
  amdgpu's vram manager fini is called explicitly during driver unbind,
  which may precede the DRM device release and thus precede any
  drmm-based cleanup. (Sashiko-bot)

Assisted-by: GitHub_Copilot:claude-sonnet-4.6
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 29 ++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h |  2 ++
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 2740de94e93c..8cbcd33f51a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1488,7 +1488,7 @@ static bool amdgpu_ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,
 	dma_resv_for_each_fence(&resv_cursor, bo->base.resv,
 				DMA_RESV_USAGE_BOOKKEEP, f) {
 		if (amdkfd_fence_check_mm(f, current->mm) &&
-		    !(place->flags & TTM_PL_FLAG_CONTIGUOUS))
+		    !(place && (place->flags & TTM_PL_FLAG_CONTIGUOUS)))
 			return false;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 08f05c3aed1d..ee98b963e84a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -906,6 +906,10 @@ static const struct ttm_resource_manager_func amdgpu_vram_mgr_func = {
 	.debug	= amdgpu_vram_mgr_debug
 };
 
+static const struct dmem_cgroup_ops amdgpu_vram_mgr_dmem_ops = {
+	.reclaim = ttm_resource_manager_dmem_reclaim,
+};
+
 /**
  * amdgpu_vram_mgr_init - init VRAM manager and DRM MM
  *
@@ -917,6 +921,7 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_vram_mgr *mgr = &adev->mman.vram_mgr;
 	struct ttm_resource_manager *man = &mgr->manager;
+	struct dmem_cgroup_region *cg;
 	int err;
 
 	ttm_resource_manager_init(man, &adev->mman.bdev,
@@ -933,12 +938,15 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
 	if (err)
 		return err;
 
-	man->cg = drmm_cgroup_register_region(adev_to_drm(adev), "vram",
-					      &(struct dmem_cgroup_init){
-						.size = adev->gmc.real_vram_size,
-					      });
-	if (IS_ERR(man->cg))
-		return PTR_ERR(man->cg);
+	cg = dmem_cgroup_register_region(&(struct dmem_cgroup_init){
+					     .size = adev->gmc.real_vram_size,
+					     .ops = &amdgpu_vram_mgr_dmem_ops,
+					     .reclaim_priv = man,
+					 }, "vram");
+	if (IS_ERR(cg))
+		return PTR_ERR(cg);
+
+	ttm_resource_manager_set_dmem_region(man, cg);
 
 	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_VRAM, &mgr->manager);
 	ttm_resource_manager_set_used(man, true);
@@ -960,6 +968,15 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev)
 	int ret;
 	struct amdgpu_vram_reservation *rsv, *temp;
 
+	/*
+	 * Drain any in-flight dmem cgroup reclaim callbacks and remove the
+	 * region from the global list before tearing down the manager.
+	 * This must happen first so no reclaim callback can access the
+	 * manager after this point.
+	 */
+	dmem_cgroup_unregister_region(mgr->cg_region);
+	mgr->cg_region = NULL;
+
 	ttm_resource_manager_set_used(man, false);
 
 	ret = ttm_resource_manager_evict_all(&adev->mman.bdev, man);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
index 429a21a2e9b2..07103cddb335 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
@@ -36,6 +36,8 @@ struct amdgpu_vram_mgr {
 	atomic64_t vis_usage;
 	u64 default_page_size;
 	struct list_head allocated_vres_list;
+	/** @cg_region: dmem cgroup region for VRAM; unregistered in fini. */
+	struct dmem_cgroup_region *cg_region;
 };
 
 struct amdgpu_vres_task {
-- 
2.54.0



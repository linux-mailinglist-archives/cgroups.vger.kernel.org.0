Return-Path: <cgroups+bounces-16872-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qVN0Fw/3KmqT0AMAu9opvQ
	(envelope-from <cgroups+bounces-16872-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 19:57:35 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 714E2674392
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 19:57:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=P1bXVYbK;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16872-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16872-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F45733D61DA
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 17:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3849E3F20FC;
	Thu, 11 Jun 2026 17:34:17 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F163BD63C;
	Thu, 11 Jun 2026 17:34:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781199256; cv=none; b=puiKBlVxZFYaUZvppAWybB/y++ozg0n/RJ3Fd5eU70lblw2LruJlCtyMcXAaE7nzP7NzLBHAG4ntTTRzHKP6FcTIUWH5ILT/Qphf9QMTPYEjmypGmAerX/uI02pv7kptZpSD1LTEPfkcPmsYdr4tFf+e2zdBb6jcog8T1j7ScC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781199256; c=relaxed/simple;
	bh=ehXRCUxZHzT0gPzymwAFYt0y4yuQwS8QBY9sglfja+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AqLMpZcaDpn3UuLZCI8dfvEcIGmldp2aQXHxDHmcQ0ZP9svSlbiQ2EQme1jhI2b9MNtBIrwQTk2vJ1dF6TXGaC6TgyUbN6u5MaiF480cgaAxquP3IKgIblc0szVu2feyiepT9+80owVt8qjDv+sCuzHiZjLgnnM5WhjpPA5XLDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P1bXVYbK; arc=none smtp.client-ip=198.175.65.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781199251; x=1812735251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ehXRCUxZHzT0gPzymwAFYt0y4yuQwS8QBY9sglfja+Q=;
  b=P1bXVYbK8DeOLFU8aDNWih6s3BzS42rBNy5x0NsyEcwQWn96vjaEccuQ
   vz5CjEl7xP0XF9svuGTE8VFo187ZtjNeRIHSeMhakcyHf+sCQAr7/CjD3
   zWmsvrJi8hmFF3B7Ixz4Z3MPN5+IhPYfwPOyAJhmUtRwFWrGSfcs/sKsR
   EKdGZwqecHtWPeRVfeKTlUQ0ojjIIKUAgtMkbjqiuy9xQvrl7i7drNFBO
   zs5PIT2rXdvIDTDr2hds9/XhyRbD+oxTXADleTaEnO+uPcgI+kypq2nFH
   ydgLmdF+b3eZ2vZBQyyDgTRrQVmqU/g3LIzkc0Esg0O+VlIsKpFP/+1aC
   g==;
X-CSE-ConnectionGUID: rlf6ogZtRFm70JToarvjVQ==
X-CSE-MsgGUID: u09P54FOR2S/DmzDaOqrvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81762086"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="81762086"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 10:34:04 -0700
X-CSE-ConnectionGUID: yygnBND/RpG4ikPTD1Z5yA==
X-CSE-MsgGUID: b8XnppjdSr6yazD40fOQtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="240215055"
Received: from amilburn-desk.amilburn-desk (HELO fedora) ([10.245.244.169])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 10:33:59 -0700
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
Subject: [PATCH v6 6/6] drm/amdgpu: Wire up dmem cgroup reclaim for VRAM manager
Date: Thu, 11 Jun 2026 19:33:01 +0200
Message-ID: <20260611173301.17473-7-thomas.hellstrom@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16872-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,linux.intel.com:mid,linux.intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 714E2674392

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
  amdgpu_vram_mgr.cg_region. Call dmem_cgroup_unregister_region()
  in amdgpu_vram_mgr_fini() after ttm_resource_manager_evict_all()
  to drain in-flight reclaim callbacks, and clear man->cg afterwards.
  This is required because amdgpu's vram manager fini is called
  explicitly during driver unbind, which may precede the DRM device
  release and thus precede any drmm-based cleanup. (Sashiko-bot)

v6:
- Fix mgr->cg_region never being assigned, so
  dmem_cgroup_unregister_region() in fini silently no-ops on NULL
  and leaks the region. (Sashiko-bot)
- Reorder fini to call set_used(false) and evict_all() before
  dmem_cgroup_unregister_region(), so ttm_resource_free() can
  uncharge via man->cg during eviction; clear man->cg after
  unregister. (Sashiko-bot)

Assisted-by: GitHub_Copilot:claude-sonnet-4.6
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 31 ++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h |  2 ++
 3 files changed, 28 insertions(+), 7 deletions(-)

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
index 08f05c3aed1d..2250bab0970d 100644
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
@@ -933,12 +938,16 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
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
+	mgr->cg_region = cg;
+	ttm_resource_manager_set_dmem_region(man, cg);
 
 	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_VRAM, &mgr->manager);
 	ttm_resource_manager_set_used(man, true);
@@ -966,6 +975,16 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev)
 	if (ret)
 		return;
 
+	/*
+	 * Drain any in-flight dmem cgroup reclaim callbacks and remove the
+	 * region from the global list.  This must happen after evict_all()
+	 * so that ttm_resource_free() can still uncharge via man->cg while
+	 * BOs are being evicted.
+	 */
+	dmem_cgroup_unregister_region(mgr->cg_region);
+	mgr->cg_region = NULL;
+	man->cg = NULL;
+
 	mutex_lock(&mgr->lock);
 	list_for_each_entry_safe(rsv, temp, &mgr->reservations_pending, blocks)
 		kfree(rsv);
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



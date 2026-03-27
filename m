Return-Path: <cgroups+bounces-15072-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4H9mDJY+xmm7HgUAu9opvQ
	(envelope-from <cgroups+bounces-15072-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 27 Mar 2026 09:23:50 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 878D4340E29
	for <lists+cgroups@lfdr.de>; Fri, 27 Mar 2026 09:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93927310AD1E
	for <lists+cgroups@lfdr.de>; Fri, 27 Mar 2026 08:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5936F3D5645;
	Fri, 27 Mar 2026 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eqP5k36H"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42AD3D6CDA;
	Fri, 27 Mar 2026 08:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774599423; cv=none; b=a4sN0ri3kTI36izkiPlRgIgcHkXJlEEHHpzN1op5+wjWp7yxMrv/azDYzqMQL4e3d8VD3kWwxYNV7RsDNYrYq+8huiNKXn2AbAfliTmRwnZcGP+f7yp40zF8vt7oMPCQZgK/BlHu84EoH5fxmIcoF4dlPxawsCsN7PmlKiNdF4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774599423; c=relaxed/simple;
	bh=HTA3piuPUkYAg53mnACGm0nngNvxcbWu8yTBneObip4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uzL3QvYrrlstPZ1sp+bZJr91zgZbWJPPAf26zwsvYBNBhuuKMjv79qoBbrpKEAoAJ2XMTqcyEpxfmOhw9zb27s2iJFvfZnxcwCGFuk0fWMH0yoe5lVpL51XunjNMapGqxsbkW61RrwT8yKZihTgiqk4A1j30XVkjTp+b4JuwVXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eqP5k36H; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774599421; x=1806135421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HTA3piuPUkYAg53mnACGm0nngNvxcbWu8yTBneObip4=;
  b=eqP5k36HDOhRKalyxfr7IEhG8P4+RlVP3G9wdnZvx+0S/g9+DzXXfhD/
   NkDxq1i8bmMB7rnjxLV+5dJ+5bgk0dn9Tpt01EUbhuIGD+oxDFbk4OKHp
   q1K8YsRcmOmpn5X7/KYbvDltsUmKSrDjQlGnpt0CeB93eWWarw0q9UhkZ
   qfAE4WQyKi1oSRE10Xyv/Dp+GBAcZKr6GDH66AGpzws2YiCNx16lJcBx8
   J3xDJAbTZPfVEPjoPOrHxm37LvKVlm6jpJQf2aQwHd15+ti6f69pLDB+z
   Dr7Y2Hyp4gFrVPFQhKYiSLwPulu3Oa8IPPRUjLydJoaHQzna3djblb4Un
   Q==;
X-CSE-ConnectionGUID: dBT46hNFQkS8QCZU9tKdGw==
X-CSE-MsgGUID: F+zum+RsTl+F1IxAktMmPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75784115"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="75784115"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 01:17:00 -0700
X-CSE-ConnectionGUID: zwrmvJYGTSW6CDJ7eAFMLw==
X-CSE-MsgGUID: N96fdPgUSZuFfu878NRbRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="255747969"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO fedora) ([10.245.244.146])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 01:16:55 -0700
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
Subject: [PATCH 5/5] drm/amdgpu: Wire up dmem cgroup reclaim for VRAM manager
Date: Fri, 27 Mar 2026 09:16:00 +0100
Message-ID: <20260327081600.4885-6-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327081600.4885-1-thomas.hellstrom@linux.intel.com>
References: <20260327081600.4885-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15072-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[linux.intel.com,gmx.de,cmpxchg.org,kernel.org,suse.com,vger.kernel.org,amd.com,intel.com,suse.de,ffwll.ch,gmail.com,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 878D4340E29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Register the VRAM manager with the dmem cgroup reclaim infrastructure
so that lowering dmem.max below current VRAM usage triggers TTM
eviction rather than failing with -EBUSY.

Guard place->flags in amdgpu_ttm_bo_eviction_valuable() against NULL,
as the TTM reclaim path passes a NULL place in cgroup drain mode.

Assisted-by: GitHub Copilot:claude-sonnet-4.6
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 10 +++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index b4ab309bf08a..cd83f30a30f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1491,7 +1491,7 @@ static bool amdgpu_ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,
 	dma_resv_for_each_fence(&resv_cursor, bo->base.resv,
 				DMA_RESV_USAGE_BOOKKEEP, f) {
 		if (amdkfd_fence_check_mm(f, current->mm) &&
-		    !(place->flags & TTM_PL_FLAG_CONTIGUOUS))
+		    !(place && (place->flags & TTM_PL_FLAG_CONTIGUOUS)))
 			return false;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 2a241a5b12c4..5987b1b9ec09 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -916,14 +916,18 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_vram_mgr *mgr = &adev->mman.vram_mgr;
 	struct ttm_resource_manager *man = &mgr->manager;
+	struct dmem_cgroup_region *cg;
 	int err;
 
-	man->cg = drmm_cgroup_register_region(adev_to_drm(adev), "vram", adev->gmc.real_vram_size);
-	if (IS_ERR(man->cg))
-		return PTR_ERR(man->cg);
 	ttm_resource_manager_init(man, &adev->mman.bdev,
 				  adev->gmc.real_vram_size);
 
+	cg = drmm_cgroup_register_region(adev_to_drm(adev), "vram",
+					 adev->gmc.real_vram_size);
+	if (IS_ERR(cg))
+		return PTR_ERR(cg);
+	ttm_resource_manager_set_dmem_region(man, cg);
+
 	mutex_init(&mgr->lock);
 	INIT_LIST_HEAD(&mgr->reservations_pending);
 	INIT_LIST_HEAD(&mgr->reserved_pages);
-- 
2.53.0



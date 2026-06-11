Return-Path: <cgroups+bounces-16866-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zy2FHeHxKmpVzwMAu9opvQ
	(envelope-from <cgroups+bounces-16866-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 19:35:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECA2674089
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 19:35:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=L+coYNi4;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16866-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-16866-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 681F730507E8
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 17:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B325E4BC02C;
	Thu, 11 Jun 2026 17:33:40 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB02C48A2BF;
	Thu, 11 Jun 2026 17:33:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781199219; cv=none; b=OeTUR3veaH4ZwOVlJly56lWaYou354OEt6o8G1Q2pWxRpljEax7FuV/c5fh+4kURlyrTGDQ0/6JCsDtQW8dZYf8BQidufVH5o0MA9JwNwhdVdci3ecaHWgMQ+HQhsQM1myVkZDyQ/CXIi5vxMQeDjQWOyotr7Iue49CSaG1ilkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781199219; c=relaxed/simple;
	bh=6He+tBzVj0Eg86MRD+R3GAwd0sEYNSEPvIuXnvHmn1k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h8PbUx5ZAjnjhJopW/0CRDc+4E+3SIlYJyHQ/gCbllbNcL60rBG/0ETwfvePZimbRsKR6A5BIF6FM2gRr9OFUWgfeXnOL8JETKpmKUI+y/EPMBtn4PznjnjTS/yg5729GGR7jMccjHYSPwjLGlDElVuD0MZ4rIgGg5Z+xMNEWpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L+coYNi4; arc=none smtp.client-ip=198.175.65.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781199217; x=1812735217;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6He+tBzVj0Eg86MRD+R3GAwd0sEYNSEPvIuXnvHmn1k=;
  b=L+coYNi4ej7dZbLV60fD8mwAr1j8Fd1pI4MCzr7mfzZKfq9S1U0DFmdG
   f3NeW5WFTk9EAXoJtgN5IEot7cGfvEUgMWnR2KafkA3mh5JwJJ4GoJrcs
   WbZkAVMfn8aAcsz+pnT7u18ozu1vyXTAprWuWHYHxVI/MlAj5at++MQrP
   Bnw71xA2zJ0GsRDxgjCFzmSQ/K9FUUMk7QWF7nDD/jLcroS/3XfTUJwUT
   MOHy7QRaBVZ4ihN01phw28CApf9zhctgLYjzaX7eVOPxgYvCyjbntI+yX
   Ycoz0P+YjU2TFJBnZXhLLDw7swhUWGnhvdFCDhJs6i7Sk4Vwfwxa8l5bx
   g==;
X-CSE-ConnectionGUID: U7tYhQqeR+SB46uJij2jHQ==
X-CSE-MsgGUID: CWy9ctDfRJi8Udd00b3V7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81761960"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="81761960"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 10:33:36 -0700
X-CSE-ConnectionGUID: qUV7rFJ2RF6bbu4WvKaflQ==
X-CSE-MsgGUID: fgFhwKR/RoaeICORiqloGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="240214915"
Received: from amilburn-desk.amilburn-desk (HELO fedora) ([10.245.244.169])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 10:33:31 -0700
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
Subject: [PATCH v6 0/6] [PATCH v6 0/6] Add reclaim to the dmem cgroup controller
Date: Thu, 11 Jun 2026 19:32:55 +0200
Message-ID: <20260611173301.17473-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.54.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16866-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[patchwork.freedesktop.org:url,linux.intel.com:mid,linux.intel.com:from_mime,intel.com:dkim,intel.com:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0ECA2674089

When writing a "max" limit lower than the current usage, the
existing code silently failed. This series aims to improve
on that by returning -EBUSY on failure and also attempt
to synchronously reclaim device memory to push the usage
under the new max limit to avoid the error.

Patch 1 fixes a pre-existing amdgpu_vram_mgr_init() error path
Patch 2 introduces struct dmem_cgroup_init for extensible region
      registration.
Patch 3 implements and documents a reclaim callback interface
      for the dmem controller.
Patch 4 implements a TTM reclaim callback.
Patches 5-6 hook up the reclaim callback to the dmem cgroup-aware
      drivers xe and amdgpu.

v2:
- Remove the error propagation that was in a previous series (Maarten)
- A number of updates in patch 1. See its commit message for
  details (Maarten)

v3:
- Add patch 1 fixing a pre-existing amdgpu_vram_mgr_init() error path
  bug where drmm_cgroup_register_region() was called before
  INIT_LIST_HEAD() and gpu_buddy_init(), causing a kernel panic on
  failure. (Sashiko-bot)
- Use an rwsem to protect reclaim callback registration and region
  unregister against concurrent reclaim invocations. (Sashiko-bot)
- Fix ttm_resource_manager_set_dmem_region() storing an error pointer
  in man->cg unconditionally. (Sashiko-bot)
- Fix kernel-doc function name format for ttm_bo_evict_cgroup() and
  ttm_resource_manager_set_dmem_region().

v4:
- Rebased on drm-tip; dropped the XE_PL_STOLEN guard in the xe patch
  as stolen memory uses a separate TTM manager.

v5:
- Add patch 2 introducing struct dmem_cgroup_init to make the
  dmem_cgroup_register_region() API extensible without adding positional
  arguments in the future.
- Use nonblock=true in reset_all_resource_limits() to avoid sleeping
  inside rcu_read_lock() in dmemcs_offline(). (Sashiko-bot)
- Compare usage against the truncated limit stored in cnt.max, not the
  original u64. (Sashiko-bot)
- Use DMEM_MAX_RECLAIM_RETRIES (16) retry budget instead of 5, matching
  the memcg controller; only -ENOSPC (no progress) counts against the
  budget, other errors abort immediately.
- Handle NULL region in ttm_resource_manager_set_dmem_region() to clear
  the reclaim callback, preventing use-after-free when the manager is
  torn down while the dmem region outlives it. (Sashiko-bot)
- Return 0 on any eviction progress; reserve -ENOSPC for zero progress.
- Clear the reclaim callback in xe and amdgpu fini paths to prevent
  use-after-free after driver unbind with open DRM file descriptors.
  (Sashiko-bot)
- Register xe fini devres action before drmm_cgroup_register_region()
  so LIFO teardown runs unregister first, draining callbacks before the
  manager is destroyed. (Sashiko-bot)
- Switch amdgpu to explicit dmem_cgroup_unregister_region() at the top
  of amdgpu_vram_mgr_fini() before any manager teardown, since amdgpu's
  fini is called explicitly during driver unbind before drmm cleanup.
  (Sashiko-bot)
- Wrap the xe reclaim callback with drm_dev_enter()/drm_dev_exit() to
  prevent TTM reclaim from running after driver unbind.

v6:
- Move the ops check inside down_read() in set_resource_max(), guarded
  by region->unregistered, to close a UAF race against
  dmem_cgroup_unregister_region(). (Sashiko-bot)
- Fix dmem_cgroup_ops->reclaim docstring: -ENOSPC is retried up to
  DMEM_MAX_RECLAIM_RETRIES times, not an immediate stop. (Sashiko-bot)
- Fix mgr->cg_region never being assigned in amdgpu_vram_mgr_init(),
  causing dmem_cgroup_unregister_region() in fini to silently no-op.
  (Sashiko-bot)
- Reorder amdgpu_vram_mgr_fini() to call set_used(false) and
  evict_all() before dmem_cgroup_unregister_region(), so
  ttm_resource_free() can uncharge via man->cg during eviction; clear
  man->cg after unregister. (Sashiko-bot)

User-space tests are at
https://patchwork.freedesktop.org/series/163935/

Test-with: 20260428065411.4222-1-thomas.hellstrom@linux.intel.com

Thomas Hellström (6):
  drm/amdgpu: Fix init ordering in amdgpu_vram_mgr_init()
  cgroup/dmem: Introduce struct dmem_cgroup_init for region initialization
  cgroup/dmem: Add reclaim callback for lowering max below current usage
  drm/ttm: Hook up a cgroup-aware reclaim callback for the dmem
    controller
  drm/xe: Wire up dmem cgroup reclaim for VRAM manager
  drm/amdgpu: Wire up dmem cgroup reclaim for VRAM manager

 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c |  30 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h |   2 +
 drivers/gpu/drm/drm_drv.c                    |   8 +-
 drivers/gpu/drm/ttm/ttm_bo.c                 |  95 +++++++++++++++++++-
 drivers/gpu/drm/ttm/ttm_bo_util.c            |   3 +-
 drivers/gpu/drm/ttm/ttm_resource.c           |  50 +++++++++++
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c         |  53 +++++++++--
 include/drm/drm_drv.h                        |   4 +-
 include/drm/ttm/ttm_bo.h                     |  10 +++
 include/drm/ttm/ttm_resource.h               |   7 ++
 include/linux/cgroup_dmem.h                  |  38 +++++++-
 kernel/cgroup/dmem.c                         | 129 ++++++++++++++++++++++++---
 13 files changed, 396 insertions(+), 35 deletions(-)

-- 
2.54.0

Thomas Hellström (6):
  drm/amdgpu: Fix init ordering in amdgpu_vram_mgr_init()
  cgroup/dmem: Introduce struct dmem_cgroup_init for region
    initialization
  cgroup/dmem: Add reclaim callback for lowering max below current usage
  drm/ttm: Hook up a cgroup-aware reclaim callback for the dmem
    controller
  drm/xe: Wire up dmem cgroup reclaim for VRAM manager
  drm/amdgpu: Wire up dmem cgroup reclaim for VRAM manager

 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c |  30 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h |   2 +
 drivers/gpu/drm/drm_drv.c                    |   8 +-
 drivers/gpu/drm/ttm/ttm_bo.c                 |  95 +++++++++++++-
 drivers/gpu/drm/ttm/ttm_bo_util.c            |   3 +-
 drivers/gpu/drm/ttm/ttm_resource.c           |  50 +++++++
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c         |  53 +++++++-
 include/drm/drm_drv.h                        |   4 +-
 include/drm/ttm/ttm_bo.h                     |  10 ++
 include/drm/ttm/ttm_resource.h               |   7 +
 include/linux/cgroup_dmem.h                  |  38 +++++-
 kernel/cgroup/dmem.c                         | 129 +++++++++++++++++--
 13 files changed, 396 insertions(+), 35 deletions(-)

-- 
2.54.0



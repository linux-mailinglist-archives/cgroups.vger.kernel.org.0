Return-Path: <cgroups+bounces-15823-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBbcORrlAmpEyQEAu9opvQ
	(envelope-from <cgroups+bounces-15823-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 10:30:18 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C4C51CB91
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 10:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4022330903BF
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 08:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7D0492508;
	Tue, 12 May 2026 08:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JEiChFYf"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1FB492186;
	Tue, 12 May 2026 08:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778574275; cv=none; b=LS8DqOHa0IJTOQfl3GnGhTs4Rdp+C5rO55MwzIdk8zP8uCbz4YUtfsLe88m5iyOJrjQHc/0sTsO5oDFtRXH0oX7rbrY/imQESVK0bRZrI0XYQYda1qIalVtV2QHIx7GF1AsHv0YWMDsz7CfX2wkd5MQqcPYiGLlUveHXZas0/FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778574275; c=relaxed/simple;
	bh=xc0h2c0hTybRTSZ+FW2dCypjXJeU1NQ2RPW7zVtWjvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lmIS5j0QquV+LbRbSClQZ9D/DcRJG7Uq0pr6IxGgZ7IIhdbLmF7fwPbOUHR6yebSNWYrmpBhbCTMNzHEiPzacJt98w0aEW1xiXEuoBiOnQm6AeG9yIjf+T/hlb7Dl8zXzoA/7IhKw3F4qOUk1n66AQVMDXh9QcrmQVvd2QH0VPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JEiChFYf; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778574272; x=1810110272;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xc0h2c0hTybRTSZ+FW2dCypjXJeU1NQ2RPW7zVtWjvI=;
  b=JEiChFYfpoeQSGEhgVDzKC3eoHMW6lLu4TkajUTlK5fL117broR4ILkf
   jtUrz+mEgJh/YOk486soopxSt92r7K6bh8ybZtXeA8HAZLkMvIO7YF6zB
   vmk7eszyzALERsWqdKkHIlsnlCC2HN3Q4q+FtVHKQjj/DOmInFEs6icd8
   O0Y4CKlAaYm6yko1E5CDg97+qFf8vSsRW9oepPi/o/jj3PWur6via3ktb
   ZCnX2/UCKpcdluqUCX9CploBw8KlvTtILb8MULEcT20derEdMQ8S6Iz3b
   4LMrDaMwGm34G8l3g6buviRgWpAqjrhsl8mJVbpXisATFyrJkEi0LG6TA
   Q==;
X-CSE-ConnectionGUID: BRTlxmR8TOOsc3hJVOG4Xw==
X-CSE-MsgGUID: TvyA3r63Q4qnfbpCAKL10w==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79194946"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="79194946"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 01:24:31 -0700
X-CSE-ConnectionGUID: qJawPWxjTCKRJOtEr5rDnw==
X-CSE-MsgGUID: wG9sh6JfR2urEwoB3UyDsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="237945499"
Received: from vpanait-mobl.ger.corp.intel.com (HELO fedora) ([10.245.245.172])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 01:24:24 -0700
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
Subject: [PATCH v4 0/5] Add reclaim to the dmem cgroup controller
Date: Tue, 12 May 2026 10:24:01 +0200
Message-ID: <20260512082406.44470-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 38C4C51CB91
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15823-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.intel.com:mid,intel.com:email,intel.com:dkim,patchwork.freedesktop.org:url]
X-Rspamd-Action: no action

When writing a "max" limit lower than the current usage, the
existing code silently failed. This series aims to improve
on that by returning -EBUSY on failure and also attempt
to synchronously reclaim device memory to push the usage
under the new max limit to avoid the error.

Patch 1 fixes a pre-existing amdgpu_vram_mgr_init() error path
Patch 2 implements and documents a reclaim callback interface
      for the dmem controller.
Patch 3 implements a TTM reclaim callback.
Patch 4-5 hooks up the reclaim callback to the dmem cgroups-
      aware drivers xe and amdgpu.

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

User-space tests are at
https://patchwork.freedesktop.org/series/163935/

Test-with: 20260428065411.4222-1-thomas.hellstrom@linux.intel.com

Thomas Hellström (5):
  drm/amdgpu: Fix init ordering in amdgpu_vram_mgr_init()
  cgroup/dmem: Add reclaim callback for lowering max below current usage
  drm/ttm: Hook up a cgroup-aware reclaim callback for the dmem
    controller
  drm/xe: Wire up dmem cgroup reclaim for VRAM manager
  drm/amdgpu: Wire up dmem cgroup reclaim for VRAM manager

 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c |  10 +-
 drivers/gpu/drm/ttm/ttm_bo.c                 |  95 ++++++++++++++++-
 drivers/gpu/drm/ttm/ttm_bo_util.c            |   3 +-
 drivers/gpu/drm/ttm/ttm_resource.c           |  37 +++++++
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c         |  14 ++-
 include/drm/ttm/ttm_bo.h                     |  10 ++
 include/drm/ttm/ttm_resource.h               |   4 +
 include/linux/cgroup_dmem.h                  |  24 +++++
 kernel/cgroup/dmem.c                         | 106 +++++++++++++++++--
 10 files changed, 283 insertions(+), 22 deletions(-)

-- 
2.54.0



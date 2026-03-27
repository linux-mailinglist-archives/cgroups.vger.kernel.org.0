Return-Path: <cgroups+bounces-15067-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DGRBxk+xmm7HgUAu9opvQ
	(envelope-from <cgroups+bounces-15067-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 27 Mar 2026 09:21:45 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B87340DEE
	for <lists+cgroups@lfdr.de>; Fri, 27 Mar 2026 09:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0689F30E986C
	for <lists+cgroups@lfdr.de>; Fri, 27 Mar 2026 08:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971E03D3D1A;
	Fri, 27 Mar 2026 08:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IjPAppD9"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40A93D34B8;
	Fri, 27 Mar 2026 08:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774599399; cv=none; b=Qn+tz5ea+UJQCZ/VmLj3rxwYSJMVIHuJobbQUW/DBp3lDyY1N+Zb0NTe/9q1NjlXbJGYDr93g621b3JI1jfUwvftTS0yW6NKJ4O8LaUqmMHA261/lfavtIztm5tNzysaIGsG8NEfvRuSLVOtPwnw734Z4nnOFxek35Q11Bfvecg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774599399; c=relaxed/simple;
	bh=VWKC7WfF9sq0UPoXI/VTX8BADLs4AZocKbls3bQOtDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d0Y9opLC5DGH4BDfffk0+dgo4JAX+8aWo1rSSl/IM0cQOz5a+rr0MXU+T1DRiktWG3Z3UFuMP/FZBZ0jwZmrmiszIroHDLK2gCW7hexOyADdi+ogIKXAQzCjg3PK+6zwn7kR+PWekAQYXPbfNn8u1PtLr7XarV0+GoEfurKIYHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IjPAppD9; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774599396; x=1806135396;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VWKC7WfF9sq0UPoXI/VTX8BADLs4AZocKbls3bQOtDg=;
  b=IjPAppD9IltDznlhQAQ8c1kPCFSczHWmPf9jvhmE5Ssek8kMGpWrNhms
   AVOmMkVYl7SZ8mzXBCFWPEVT8gpcS7O6FhIWrN2KfmcaisTqiL7ZVkE1v
   FsgXZX/WrJ3uED7t7+Qu+UGK/czZ2X1jU8ZYdZRKf0vLmN8GrsNiadp91
   bv3TDEs/p1eB7OHLI6vHXx6XqHmnhgu90Mufs4Ii9yZGrqnUfq3TQwVkc
   iX9I0JEUE2Bc0iTfpgTFAurdRfD5zXI5LNOFUsBrIwVAZhIJv5SEKqwN3
   c+PpCCcwfAsXqYMzJnOm6A2/Nc/23CQVOjDFbKyRIZsOknhN8aS2uIPjW
   Q==;
X-CSE-ConnectionGUID: pI654IuASY6VLUyNuAl6Fw==
X-CSE-MsgGUID: jbEMKyyiQE6C32Cr+Gp8OA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75784013"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="75784013"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 01:16:34 -0700
X-CSE-ConnectionGUID: NcH4tAOxSSul0MwY0s8pQQ==
X-CSE-MsgGUID: 0XW60LgxTiaGYZloM+zPAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="255747866"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO fedora) ([10.245.244.146])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 01:16:29 -0700
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
Subject: [PATCH 0/5] Add reclaim to the dmem cgroup controller
Date: Fri, 27 Mar 2026 09:15:55 +0100
Message-ID: <20260327081600.4885-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15067-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 74B87340DEE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When writing a "max" limit lower than the current usage, the
existing code silently failed. This series aims to improve
on that by returning -EBUSY on failure and also attempt
to synchronously reclaim device memory to push the usage
under the new max limit to avoid the error.

Patch 1 implements error propagation.
Patch 2 implements and documents a reclaim callback interface
      for the dmem controller.
Patch 3 implements a TTM reclaim callback.
Patch 4-5 hooks up the reclaim callback to the dmem cgroups-
      aware drivers xe and amdgpu.

Thomas Hellström (5):
  cgroup/dmem: Return error when setting max below current usage
  cgroup/dmem: Add reclaim callback for lowering max below current usage
  drm/ttm: Hook up a cgroup-aware reclaim callback for the dmem
    controller
  drm/xe: Wire up dmem cgroup reclaim for VRAM manager
  drm/amdgpu: Wire up dmem cgroup reclaim for VRAM manager

 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c |  10 +-
 drivers/gpu/drm/ttm/ttm_bo.c                 |  95 ++++++++++++++++-
 drivers/gpu/drm/ttm/ttm_bo_util.c            |   3 +-
 drivers/gpu/drm/ttm/ttm_resource.c           |  36 +++++++
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c         |  19 ++--
 include/drm/ttm/ttm_bo.h                     |  10 ++
 include/drm/ttm/ttm_resource.h               |   4 +
 include/linux/cgroup_dmem.h                  |  11 ++
 kernel/cgroup/dmem.c                         | 102 ++++++++++++++++---
 10 files changed, 265 insertions(+), 27 deletions(-)

-- 
2.53.0



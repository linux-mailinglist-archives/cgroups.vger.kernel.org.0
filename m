Return-Path: <cgroups+bounces-15523-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCOqKXlo8GkITAEAu9opvQ
	(envelope-from <cgroups+bounces-15523-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 09:57:45 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E668447F69E
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 09:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FB483179903
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 07:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E483D5643;
	Tue, 28 Apr 2026 07:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MjaAb7W9"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A3C3CD8BB;
	Tue, 28 Apr 2026 07:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777361510; cv=none; b=ENBc8OU062SjM4zinRVGYaXAcK3A5noTKwn7xwFDlEJVn1yQheDVW2jHqSHHJ4sPxl1PHoRTifX+Qo19ub99AUffRXsFe3sfaPJY/Tuk6hh5kvsV+iq8secR8XOqVIpEE2tdazd7wq4HdojCvDhs5tQFqx9X+018zWtzUGiYatA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777361510; c=relaxed/simple;
	bh=0nO5YZfpp/CkW4P3+yc1h3ASEGri6Ld8zhG3/Yy56Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O6LZ0UIBx6nTBzR2PSfCEqWtddYb35DSaYfRA67A3GUd2hcbMieF3DtQMWNRrYOyWlyVdMiTcWy9o+ObCcbFbe+RPzG/oDouSR26RSHANhppbQFDLhezAoHWV07rFTHYhPqpwOF7fQSLIC4tzVKIYiJ3VzJhaLtbTlHQrNT8P54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MjaAb7W9; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777361509; x=1808897509;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0nO5YZfpp/CkW4P3+yc1h3ASEGri6Ld8zhG3/Yy56Ys=;
  b=MjaAb7W9mBqMdnHJ3Yz2vN/lFkc1MVcoupvEVZh9rIBKWC/+7H/X5gCj
   XrMOwjSR0ptiX5Sfxdj2V0vTyyhikquHlHDOrGNWzL1j6ZePIppn1wimF
   7246s0yeFJZ9GZctsm9KXie0LmmnvCvZAvUSTwXe+r+O641uceKyMNWhD
   w2vCa+VT/tJV9KI9PCTNmaViZwVASQhhQfHzE3lwq/3CaKFxV/h9I0ekh
   lD/6hTnM8K4ws08+uKBS4w4rhfTwAp/NgWXIb7ZjGIBfyNrRaUa5wCckd
   voRjUozTrPFWyODqwBtxiGSq+WBFHzntJScG8ItvBc+EmyNG6tKsythOZ
   w==;
X-CSE-ConnectionGUID: eH9LwTJaSx6DyvvSDJM3RA==
X-CSE-MsgGUID: dg3F5tqGTg2y9p/wls4GIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="103722040"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="103722040"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 00:31:48 -0700
X-CSE-ConnectionGUID: IEBGS0tDRa2Uzv/wJhDGpw==
X-CSE-MsgGUID: IqHp+U6OS1++dE6+uQauCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="230716249"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO fedora) ([10.245.244.161])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 00:31:43 -0700
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
Subject: [PATCH v2 0/4] Add reclaim to the dmem cgroup controller
Date: Tue, 28 Apr 2026 09:31:12 +0200
Message-ID: <20260428073116.15687-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E668447F69E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15523-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,patchwork.freedesktop.org:url]

When writing a "max" limit lower than the current usage, the
existing code silently failed. This series aims to improve
on that by returning -EBUSY on failure and also attempt
to synchronously reclaim device memory to push the usage
under the new max limit to avoid the error.

Patch 1 implements and documents a reclaim callback interface
      for the dmem controller.
Patch 2 implements a TTM reclaim callback.
Patch 3-4 hooks up the reclaim callback to the dmem cgroups-
      aware drivers xe and amdgpu.

v2:
- Remove the error propagation that was in a previous series (Maarten)
- A number of updates in patch 1. See its commit message for
  details (Maarten)

User-space tests are at
https://patchwork.freedesktop.org/series/163935/

Test-with: 20260428065411.4222-1-thomas.hellstrom@linux.intel.com

Thomas Hellström (4):
  cgroup/dmem: Add reclaim callback for lowering max below current usage
  drm/ttm: Hook up a cgroup-aware reclaim callback for the dmem
    controller
  drm/xe: Wire up dmem cgroup reclaim for VRAM manager
  drm/amdgpu: Wire up dmem cgroup reclaim for VRAM manager

 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 10 ++-
 drivers/gpu/drm/ttm/ttm_bo.c                 | 95 +++++++++++++++++++-
 drivers/gpu/drm/ttm/ttm_bo_util.c            |  3 +-
 drivers/gpu/drm/ttm/ttm_resource.c           | 36 ++++++++
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c         | 19 ++--
 include/drm/ttm/ttm_bo.h                     | 10 +++
 include/drm/ttm/ttm_resource.h               |  4 +
 include/linux/cgroup_dmem.h                  | 11 +++
 kernel/cgroup/dmem.c                         | 83 +++++++++++++++--
 10 files changed, 249 insertions(+), 24 deletions(-)

-- 
2.53.0



Return-Path: <cgroups+bounces-5759-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 325CE9E3BC1
	for <lists+cgroups@lfdr.de>; Wed,  4 Dec 2024 14:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07A30164003
	for <lists+cgroups@lfdr.de>; Wed,  4 Dec 2024 13:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD781F7583;
	Wed,  4 Dec 2024 13:53:24 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917C21F6673;
	Wed,  4 Dec 2024 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733320404; cv=none; b=WkqK45/Vxe5ZMbla10UgL95JCfeYC6C7gw5knKWnP//XVWD+rrE5/0V89wciOjRhpYmEHqhSOFIhEe1gP1EC4q5TSZvPC7vwRbtmbQQMGLlPS7Avw+gM0++mZhSnhNf/NBFe0L3fyndpW6U0vLcKv42GzsqZWCQZa+G/mKHzkDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733320404; c=relaxed/simple;
	bh=PEDJuVP8trf41FCvKtNf3IJuUbqCJyuI8yDfBms9yGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HlMyGczg2NGEJ0MxlT398T/Jsf9Oe75K3APw1awEYOviZhPXjvdiNpC/OwV/uSiSbGjgxPjIz3vyFEOxNQmrZhfmOrRcMtZOIQIHb7ye8a8xvE0LYRqayEdp32bCnv/ws7Xzo8vbDY2bBcm+0NGS5GVbW5F3Il27rlrOycfLArY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lankhorst.se; spf=none smtp.mailfrom=mblankhorst.nl; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mblankhorst.nl
From: Maarten Lankhorst <dev@lankhorst.se>
To: linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Friedrich Vock <friedrich.vock@gmx.de>,
	Maxime Ripard <mripard@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [PATCH v2 0/7] kernel/cgroups: Add "dmem" memory accounting cgroup.
Date: Wed,  4 Dec 2024 14:44:00 +0100
Message-ID: <20241204134410.1161769-1-dev@lankhorst.se>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New update. Instead of calling it the 'dev' cgroup, it's now the 'dmem' cgroup.

Because it only deals with memory regions, the UAPI has been updated to use dmem.min/low/max/current, and to make the API cleaner, the names are changed too.

dmem.current could contain a line like:
"drm/0000:03:00.0/vram0 1073741824"

But I think using "drm/card0/vram0" instead of PCIID would perhaps be good too. I'm open to changing it to that based on feedback.

I've created an IGT test for min and max, and found the changes
from Friedrich Vock sent as feedback were needed.
I've integrated those into the first patch.

Maarten Lankhorst (5):
  kernel/cgroup: Add "dmem" memory accounting cgroup
  drm/ttm: Handle cgroup based eviction in TTM
  drm/xe: Implement cgroup for vram
  drm/amdgpu: Add cgroups implementation
  drm/xe: Hack to test with mapped pages instead of vram.

Maxime Ripard (2):
  drm/drv: Add drmm managed registration helper for dmem cgroups.
  drm/gem: Add cgroup memory accounting for VRAM helper.

 Documentation/admin-guide/cgroup-v2.rst       |  58 +-
 Documentation/core-api/cgroup.rst             |   9 +
 Documentation/core-api/index.rst              |   1 +
 Documentation/gpu/drm-compute.rst             |  54 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c  |   4 +
 drivers/gpu/drm/drm_drv.c                     |  32 +
 drivers/gpu/drm/drm_gem_vram_helper.c         |  15 +-
 drivers/gpu/drm/ttm/tests/ttm_bo_test.c       |  18 +-
 .../gpu/drm/ttm/tests/ttm_bo_validate_test.c  |   4 +-
 drivers/gpu/drm/ttm/tests/ttm_resource_test.c |   2 +-
 drivers/gpu/drm/ttm/ttm_bo.c                  |  54 +-
 drivers/gpu/drm/ttm/ttm_resource.c            |  23 +-
 drivers/gpu/drm/xe/xe_ttm_sys_mgr.c           |   5 +
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c          |   8 +
 include/drm/drm_drv.h                         |   5 +
 include/drm/ttm/ttm_resource.h                |  12 +-
 include/linux/cgroup_dmem.h                   |  67 ++
 include/linux/cgroup_subsys.h                 |   4 +
 include/linux/page_counter.h                  |   2 +-
 init/Kconfig                                  |  10 +
 kernel/cgroup/Makefile                        |   1 +
 kernel/cgroup/dmem.c                          | 861 ++++++++++++++++++
 mm/page_counter.c                             |   4 +-
 23 files changed, 1219 insertions(+), 34 deletions(-)
 create mode 100644 Documentation/core-api/cgroup.rst
 create mode 100644 Documentation/gpu/drm-compute.rst
 create mode 100644 include/linux/cgroup_dmem.h
 create mode 100644 kernel/cgroup/dmem.c

-- 
2.43.0


Return-Path: <cgroups+bounces-5191-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E429AC0EB
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2024 10:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B98C2843AA
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2024 08:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0945F15855D;
	Wed, 23 Oct 2024 08:00:56 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D220515252D;
	Wed, 23 Oct 2024 08:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729670455; cv=none; b=bF9z/GLRJGi+gd3Bhi/nAAl4i0rvPMYFZFp20XIbMcw+h8Ob9y7K+dBNHnN4cdOaK3goePMJ+gI0y23mGuEAO2DCAKuvAP0PqEaKh/49Tyzj0YnELxNaK8XTp5x69M+3q8qooNGFtFlQY6ANf17BWkZ2SrCcoyiHRBT97NbZo0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729670455; c=relaxed/simple;
	bh=+I1MpiSIGPrZm4UzkZXzNpXx59jNZA5bBmVOMC9xRvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rVbnWKnnqPnbNJHEzQuP/m/Ixvb+yrv5OD9gTp3DEdOG8cppGPrCxwMNsa8j0ALH8/Y0BcMppJ/Muv88UdhlqeH0drqTru5UaO5q+ydCHs8/+7XfI7nJ9tVdIKNXtZKWQwZ+kdomKZNMmNXqabV8iR7XKnNF/zhIVZOedNK5oRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=mblankhorst.nl; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mblankhorst.nl
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: intel-xe@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Friedrich Vock <friedrich.vock@gmx.de>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH 0/7] kernel/cgroups: Add "dev" memory accounting cgroup.
Date: Wed, 23 Oct 2024 09:52:53 +0200
Message-ID: <20241023075302.27194-1-maarten.lankhorst@linux.intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New submission!
I've added documentation for each call, and integrated the renaming from
drm cgroup to dev cgroup, based on maxime ripard's work.

Maxime has been testing this with dma-buf heaps and v4l2 too, and it seems to work.
In the initial submission, I've decided to only add the smallest enablement possible,
to have less chance of breaking things.

The API has been changed slightly, from "$name region.$regionname=$limit" in a file called
dev.min/low/max to "$subsystem/$name $regionname=$limit" in a file called dev.region.min/low/max.

This hopefully allows us to perhaps extend the API later on with the possibility to
set scheduler weights on the device, like in

https://blogs.igalia.com/tursulin/drm-scheduling-cgroup-controller/

Maarten Lankhorst (5):
  kernel/cgroup: Add "dev" memory accounting cgroup
  drm/ttm: Handle cgroup based eviction in TTM
  drm/xe: Implement cgroup for vram
  drm/amdgpu: Add cgroups implementation
  [HACK] drm/xe: Hack to test with mapped pages instead of vram.

Maxime Ripard (2):
  drm/drv: Add drmm cgroup registration for dev cgroups.
  [DISCUSSION] drm/gem: Add cgroup memory accounting

 Documentation/admin-guide/cgroup-v2.rst       |  51 +
 Documentation/core-api/cgroup.rst             |   9 +
 Documentation/core-api/index.rst              |   1 +
 Documentation/gpu/drm-compute.rst             |  54 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c  |   6 +
 drivers/gpu/drm/drm_drv.c                     |  32 +-
 drivers/gpu/drm/drm_gem.c                     |   4 +
 drivers/gpu/drm/drm_gem_dma_helper.c          |   4 +
 drivers/gpu/drm/ttm/tests/ttm_bo_test.c       |  18 +-
 .../gpu/drm/ttm/tests/ttm_bo_validate_test.c  |   4 +-
 drivers/gpu/drm/ttm/tests/ttm_resource_test.c |   2 +-
 drivers/gpu/drm/ttm/ttm_bo.c                  |  57 +-
 drivers/gpu/drm/ttm/ttm_resource.c            |  24 +-
 drivers/gpu/drm/xe/xe_device.c                |   4 +
 drivers/gpu/drm/xe/xe_device_types.h          |   4 +
 drivers/gpu/drm/xe/xe_ttm_sys_mgr.c           |  14 +
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c          |  10 +
 include/drm/drm_device.h                      |   4 +
 include/drm/drm_drv.h                         |   4 +
 include/drm/drm_gem.h                         |   2 +
 include/drm/ttm/ttm_resource.h                |  16 +-
 include/linux/cgroup_dev.h                    |  91 ++
 include/linux/cgroup_subsys.h                 |   4 +
 include/linux/page_counter.h                  |   2 +-
 init/Kconfig                                  |   7 +
 kernel/cgroup/Makefile                        |   1 +
 kernel/cgroup/dev.c                           | 893 ++++++++++++++++++
 mm/page_counter.c                             |   4 +-
 30 files changed, 1307 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/core-api/cgroup.rst
 create mode 100644 Documentation/gpu/drm-compute.rst
 create mode 100644 include/linux/cgroup_dev.h
 create mode 100644 kernel/cgroup/dev.c

-- 
2.45.2



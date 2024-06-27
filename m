Return-Path: <cgroups+bounces-3407-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 714B591AC03
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 17:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F074D28338D
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 15:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CEC199230;
	Thu, 27 Jun 2024 15:57:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3451991C9;
	Thu, 27 Jun 2024 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719503874; cv=none; b=VnrAX87LHVBLxFJXt2kaLxwVKOJ6fXnpMHosyoEnSgROXIbmPJwrmEe3tNbV+d387A/AfmN+F6lqDnfVwPpAAhYPLykowUjuKUkSV82KIhKvG5Cj0LXu/xo8GRoDV9A7kT/XG0FoVdVMeAJ1KGrYykps6k1XH26OfBJbcRw+D6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719503874; c=relaxed/simple;
	bh=fkv99D0lVc7kZeZmF+D68WSywx12m1T0X27+aOLqWVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nw2LPu08Z+cRYEb9jKUCtdz03tEZ0jLjdORJGKLjz4kNp6z6sj0iXbxvQA2E9B+FLdf9e0OFuOXzJB4tIbJSdAejuZFiFzjgOFmicNhOOcSVwtzLQhxn7slSuHLk8IJ7C/2BKYnju8g//+tfkS0wh0KzpxWqSTvK1fvzmedgJCI=
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
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [RFC PATCH 0/6] DRM resource management cgroup, try 2.
Date: Thu, 27 Jun 2024 17:47:19 +0200
Message-ID: <20240627154754.74828-1-maarten.lankhorst@linux.intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey,

A new version of my attempt at managing VRAM through cgroups.
Even though it's called the DRM resource management cgroup, it would be trivial
to rename it to devmem or whatever, since there is nothing DRM specific about it.

This series allows setting limits on VRAM similar to system memory,
with min/low/max limits.
This allows various cgroups to have their own limits for usage.

It sounds very abstract, but it can be used to prioritise the foreground
application (by setting low), or hard partition memory so multiple processes
sharing a single GPU use a proportional amount of memory each in a fair way,
or to prevent long running compute jobs from having their memory evicted.

This is a minimal proof of concept to get discussion going again. It works,
but it only tracks active use of VRAM. In the ideal world, we would track
it better in a way that also integrates better with the memory cgroup
controller. Ideally for every VRAM allocation, we would know we could push
it out to swap if needed, charging the original process not the process evicting.

I'm hoping to restart the discussion, so that we can plug the holes and finally move forward.

New in this version:
- Complete rewrite using page_counter.
- Support setting min/low/max, respected in the same way as memory cgroup.
  (Could be useful to add/allow high? To go over limit for temporary bindings
   during eviction on GART.)
- Locking reworked. Fastpath should now be lockless with RCU.
- Add a second implementation for AMD, to show how easy it is to make it work.
  (Should we completely move this to TTM instead?)
- TTM now always respects min/low when evicting, bailing out with -ENOSPC instead
  where required.

I'm hoping for some good feedback on the path forward for upstreaming. I feel this
version has a lot better chance of being upstreamed than the previous. It should
be a lot more scalable thanks to the usage of RCU and page_counter.

Cheers,
Maarten

Maarten Lankhorst (6):
  mm/page_counter: Move calculating protection values to page_counter
  drm/cgroup: Add memory accounting DRM cgroup
  drm/ttm: Handle cgroup based eviction in TTM
  drm/xe: Implement cgroup for vram
  drm/amdgpu: Add cgroups implementation
  drm/xe: Hack to test with mapped pages instead of vram.

 Documentation/admin-guide/cgroup-v2.rst       |  51 ++
 Documentation/gpu/drm-compute.rst             |  54 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c  |   6 +
 drivers/gpu/drm/ttm/tests/ttm_bo_test.c       |  18 +-
 drivers/gpu/drm/ttm/tests/ttm_resource_test.c |   2 +-
 drivers/gpu/drm/ttm/ttm_bo.c                  |  38 +-
 drivers/gpu/drm/ttm/ttm_resource.c            |  28 +-
 drivers/gpu/drm/xe/xe_device.c                |   4 +
 drivers/gpu/drm/xe/xe_device_types.h          |   4 +
 drivers/gpu/drm/xe/xe_ttm_sys_mgr.c           |  14 +
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c          |  10 +
 include/drm/ttm/ttm_bo.h                      |   3 +-
 include/drm/ttm/ttm_resource.h                |  16 +-
 include/linux/cgroup_drm.h                    | 115 +++
 include/linux/cgroup_subsys.h                 |   4 +
 include/linux/page_counter.h                  |   4 +
 init/Kconfig                                  |   7 +
 kernel/cgroup/Makefile                        |   1 +
 kernel/cgroup/drm.c                           | 813 ++++++++++++++++++
 mm/memcontrol.c                               | 154 +---
 mm/page_counter.c                             | 173 ++++
 23 files changed, 1355 insertions(+), 172 deletions(-)
 create mode 100644 Documentation/gpu/drm-compute.rst
 create mode 100644 include/linux/cgroup_drm.h
 create mode 100644 kernel/cgroup/drm.c

-- 
2.45.2



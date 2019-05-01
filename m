Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0317108A7
	for <lists+cgroups@lfdr.de>; Wed,  1 May 2019 16:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfEAODB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 May 2019 10:03:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:3043 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbfEAODB (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 1 May 2019 10:03:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 May 2019 07:03:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,417,1549958400"; 
   d="scan'208";a="145141383"
Received: from nperf12.hd.intel.com ([10.127.88.161])
  by fmsmga008.fm.intel.com with ESMTP; 01 May 2019 07:02:58 -0700
From:   Brian Welty <brian.welty@intel.com>
To:     cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        ChunMing Zhou <David1.Zhou@amd.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>
Subject: [RFC PATCH 0/5] cgroup support for GPU devices
Date:   Wed,  1 May 2019 10:04:33 -0400
Message-Id: <20190501140438.9506-1-brian.welty@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

In containerized or virtualized environments, there is desire to have
controls in place for resources that can be consumed by users of a GPU
device.  This RFC patch series proposes a framework for integrating 
use of existing cgroup controllers into device drivers.
The i915 driver is updated in this series as our primary use case to
leverage this framework and to serve as an example for discussion.

The patch series enables device drivers to use cgroups to control the
following resources within a GPU (or other accelerator device):
*  control allocation of device memory (reuse of memcg)
and with future work, we could extend to:
*  track and control share of GPU time (reuse of cpu/cpuacct)
*  apply mask of allowed execution engines (reuse of cpusets)

Instead of introducing a new cgroup subsystem for GPU devices, a new
framework is proposed to allow devices to register with existing cgroup
controllers, which creates per-device cgroup_subsys_state within the
cgroup.  This gives device drivers their own private cgroup controls
(such as memory limits or other parameters) to be applied to device
resources instead of host system resources.
Device drivers (GPU or other) are then able to reuse the existing cgroup
controls, instead of inventing similar ones.

Per-device controls would be exposed in cgroup filesystem as:
    mount/<cgroup_name>/<subsys_name>.devices/<dev_name>/<subsys_files>
such as (for example):
    mount/<cgroup_name>/memory.devices/<dev_name>/memory.max
    mount/<cgroup_name>/memory.devices/<dev_name>/memory.current
    mount/<cgroup_name>/cpu.devices/<dev_name>/cpu.stat
    mount/<cgroup_name>/cpu.devices/<dev_name>/cpu.weight

The drm/i915 patch in this series is based on top of other RFC work [1]
for i915 device memory support.

AMD [2] and Intel [3] have proposed related work in this area within the
last few years, listed below as reference.  This new RFC reuses existing
cgroup controllers and takes a different approach than prior work.

Finally, some potential discussion points for this series:
* merge proposed <subsys_name>.devices into a single devices directory?
* allow devices to have multiple registrations for subsets of resources?
* document a 'common charging policy' for device drivers to follow?

[1] https://patchwork.freedesktop.org/series/56683/
[2] https://lists.freedesktop.org/archives/dri-devel/2018-November/197106.html
[3] https://lists.freedesktop.org/archives/intel-gfx/2018-January/153156.html


Brian Welty (5):
  cgroup: Add cgroup_subsys per-device registration framework
  cgroup: Change kernfs_node for directories to store
    cgroup_subsys_state
  memcg: Add per-device support to memory cgroup subsystem
  drm: Add memory cgroup registration and DRIVER_CGROUPS feature bit
  drm/i915: Use memory cgroup for enforcing device memory limit

 drivers/gpu/drm/drm_drv.c                  |  12 +
 drivers/gpu/drm/drm_gem.c                  |   7 +
 drivers/gpu/drm/i915/i915_drv.c            |   2 +-
 drivers/gpu/drm/i915/intel_memory_region.c |  24 +-
 include/drm/drm_device.h                   |   3 +
 include/drm/drm_drv.h                      |   8 +
 include/drm/drm_gem.h                      |  11 +
 include/linux/cgroup-defs.h                |  28 ++
 include/linux/cgroup.h                     |   3 +
 include/linux/memcontrol.h                 |  10 +
 kernel/cgroup/cgroup-v1.c                  |  10 +-
 kernel/cgroup/cgroup.c                     | 310 ++++++++++++++++++---
 mm/memcontrol.c                            | 183 +++++++++++-
 13 files changed, 552 insertions(+), 59 deletions(-)

-- 
2.21.0


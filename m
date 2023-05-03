Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6F46F53A7
	for <lists+cgroups@lfdr.de>; Wed,  3 May 2023 10:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjECIuS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 3 May 2023 04:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjECIuR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 3 May 2023 04:50:17 -0400
X-Greylist: delayed 301 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 03 May 2023 01:50:15 PDT
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E0110D9;
        Wed,  3 May 2023 01:50:14 -0700 (PDT)
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To:     dri-devel@lists.freedesktop.org, cgroups@vger.kernel.org,
        intel-xe@lists.freedesktop.org
Cc:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: [RFC PATCH 0/4]  Add support for DRM cgroup memory accounting.
Date:   Wed,  3 May 2023 10:34:56 +0200
Message-Id: <20230503083500.645848-1-maarten.lankhorst@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

RFC as I'm looking for comments.

For long running compute, it can be beneficial to partition the GPU memory
between cgroups, so each cgroup can use its maximum amount of memory without
interfering with other scheduled jobs. Done properly, this can alleviate the
need for eviction, which might result in a job being terminated if the GPU
doesn't support mid-thread preemption or recoverable page faults.

This is done by adding a bunch of knobs to cgroup:
drm.capacity: Shows maximum capacity of each resource region.
drm.max: Display or limit max amount of memory.
drm.current: Current amount of memory in use.

TTM has not been made cgroup aware yet, so instead of evicting from
the current cgroup to stay within the cgroup limits, it simply returns
the error -ENOSPC to userspace.

I've used Tvrtko's cgroup controller series as a base, but it implemented
scheduling weight, not memory accounting, so I only ended up keeping the
base patch.

Xe is not upstream yet, so the driver specific patch will only apply on
https://gitlab.freedesktop.org/drm/xe/kernel

Maarten Lankhorst (3):
  drm/cgroup: Add memory accounting to DRM cgroup
  drm/ttm: Handle -EAGAIN in ttm_resource_alloc as -ENOSPC.
  drm/xe: Add support for the drm cgroup

Tvrtko Ursulin (1):
  cgroup: Add the DRM cgroup controller

 Documentation/admin-guide/cgroup-v2.rst    |  46 ++
 Documentation/gpu/drm-compute.rst          |  54 ++
 drivers/gpu/drm/ttm/ttm_bo.c               |   4 +-
 drivers/gpu/drm/xe/xe_device.c             |   4 +
 drivers/gpu/drm/xe/xe_device_types.h       |   4 +
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c       |  21 +-
 drivers/gpu/drm/xe/xe_ttm_vram_mgr_types.h |   5 +
 include/linux/cgroup_drm.h                 |  90 ++++
 include/linux/cgroup_subsys.h              |   4 +
 init/Kconfig                               |   7 +
 kernel/cgroup/Makefile                     |   1 +
 kernel/cgroup/drm.c                        | 557 +++++++++++++++++++++
 12 files changed, 794 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/gpu/drm-compute.rst
 create mode 100644 include/linux/cgroup_drm.h
 create mode 100644 kernel/cgroup/drm.c

-- 
2.34.1


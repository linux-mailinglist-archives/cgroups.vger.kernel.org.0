Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 942401157F
	for <lists+cgroups@lfdr.de>; Thu,  2 May 2019 10:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbfEBIei (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 May 2019 04:34:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbfEBIei (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 2 May 2019 04:34:38 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2857820873;
        Thu,  2 May 2019 08:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556786076;
        bh=MQjRhogQLnzUq3Lldq3yF0nYV1BdOcxeJjuqAcrDwDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SbgCz/Ciyhy9PYlonWt+ep9RVgw8J2IFnpExiZTS5DqSsrl7BV3EvScRoeQcunY8K
         gkHyue9SwLa/sINCO1qPNZEAsamW8wbTXuAttdzB52fzyO/zsBr82g7MzLfowj53gJ
         4JRjWY9yKbREVMzC396iMWRTv9obSvTVIbdZHr+E=
Date:   Thu, 2 May 2019 11:34:33 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Brian Welty <brian.welty@intel.com>
Cc:     cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
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
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        ChunMing Zhou <David1.Zhou@amd.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>
Subject: Re: [RFC PATCH 0/5] cgroup support for GPU devices
Message-ID: <20190502083433.GP7676@mtr-leonro.mtl.com>
References: <20190501140438.9506-1-brian.welty@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501140438.9506-1-brian.welty@intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 01, 2019 at 10:04:33AM -0400, Brian Welty wrote:
> In containerized or virtualized environments, there is desire to have
> controls in place for resources that can be consumed by users of a GPU
> device.  This RFC patch series proposes a framework for integrating
> use of existing cgroup controllers into device drivers.
> The i915 driver is updated in this series as our primary use case to
> leverage this framework and to serve as an example for discussion.
>
> The patch series enables device drivers to use cgroups to control the
> following resources within a GPU (or other accelerator device):
> *  control allocation of device memory (reuse of memcg)

Count us (Mellanox) too, our RDMA devices are exposing special and
limited in size device memory to the users and we would like to provide
an option to use cgroup to control its exposure.

> and with future work, we could extend to:
> *  track and control share of GPU time (reuse of cpu/cpuacct)
> *  apply mask of allowed execution engines (reuse of cpusets)
>
> Instead of introducing a new cgroup subsystem for GPU devices, a new
> framework is proposed to allow devices to register with existing cgroup
> controllers, which creates per-device cgroup_subsys_state within the
> cgroup.  This gives device drivers their own private cgroup controls
> (such as memory limits or other parameters) to be applied to device
> resources instead of host system resources.
> Device drivers (GPU or other) are then able to reuse the existing cgroup
> controls, instead of inventing similar ones.
>
> Per-device controls would be exposed in cgroup filesystem as:
>     mount/<cgroup_name>/<subsys_name>.devices/<dev_name>/<subsys_files>
> such as (for example):
>     mount/<cgroup_name>/memory.devices/<dev_name>/memory.max
>     mount/<cgroup_name>/memory.devices/<dev_name>/memory.current
>     mount/<cgroup_name>/cpu.devices/<dev_name>/cpu.stat
>     mount/<cgroup_name>/cpu.devices/<dev_name>/cpu.weight
>
> The drm/i915 patch in this series is based on top of other RFC work [1]
> for i915 device memory support.
>
> AMD [2] and Intel [3] have proposed related work in this area within the
> last few years, listed below as reference.  This new RFC reuses existing
> cgroup controllers and takes a different approach than prior work.
>
> Finally, some potential discussion points for this series:
> * merge proposed <subsys_name>.devices into a single devices directory?
> * allow devices to have multiple registrations for subsets of resources?
> * document a 'common charging policy' for device drivers to follow?
>
> [1] https://patchwork.freedesktop.org/series/56683/
> [2] https://lists.freedesktop.org/archives/dri-devel/2018-November/197106.html
> [3] https://lists.freedesktop.org/archives/intel-gfx/2018-January/153156.html
>
>
> Brian Welty (5):
>   cgroup: Add cgroup_subsys per-device registration framework
>   cgroup: Change kernfs_node for directories to store
>     cgroup_subsys_state
>   memcg: Add per-device support to memory cgroup subsystem
>   drm: Add memory cgroup registration and DRIVER_CGROUPS feature bit
>   drm/i915: Use memory cgroup for enforcing device memory limit
>
>  drivers/gpu/drm/drm_drv.c                  |  12 +
>  drivers/gpu/drm/drm_gem.c                  |   7 +
>  drivers/gpu/drm/i915/i915_drv.c            |   2 +-
>  drivers/gpu/drm/i915/intel_memory_region.c |  24 +-
>  include/drm/drm_device.h                   |   3 +
>  include/drm/drm_drv.h                      |   8 +
>  include/drm/drm_gem.h                      |  11 +
>  include/linux/cgroup-defs.h                |  28 ++
>  include/linux/cgroup.h                     |   3 +
>  include/linux/memcontrol.h                 |  10 +
>  kernel/cgroup/cgroup-v1.c                  |  10 +-
>  kernel/cgroup/cgroup.c                     | 310 ++++++++++++++++++---
>  mm/memcontrol.c                            | 183 +++++++++++-
>  13 files changed, 552 insertions(+), 59 deletions(-)
>
> --
> 2.21.0
>

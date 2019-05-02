Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76A36124BA
	for <lists+cgroups@lfdr.de>; Fri,  3 May 2019 00:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfEBWsN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 May 2019 18:48:13 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33547 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfEBWsN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 May 2019 18:48:13 -0400
Received: by mail-oi1-f195.google.com with SMTP id l1so3085746oib.0;
        Thu, 02 May 2019 15:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/WKHdnz38BeGL2pjuVKVInpoD4DDdnvc5veO1RpWfD0=;
        b=lKkyAyPK+yQFL7c/rX2h7OTRgVgCfGIA3jxuxf0M3WS5KnZpTp8Mykm0JON9M6qmOF
         30RUqUAUZnZXXZ56qm2hLdvg6D1Psc4W/Y3OoXcZI7QxDQ0zn9C+HqN544+NErubH6Rw
         XJm9/tXR6XQawJT3hvz8sYAAZfKW8NOb+Z1DGTxnr8snyHMop8e80SKJpOuMMnzGi215
         nkeBQ0z5As131KYmogi2xGm1lFCfd+O7ajJgqaIybuACpod0//VhJ13cWDX1xSHC2ZnA
         Rh+r2wlqbLEKsWw9wSjkO4K4Ch3fAorDgZGsOwHCpg084Xzfptn6ptbHxrxct0Pvphjq
         9DRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/WKHdnz38BeGL2pjuVKVInpoD4DDdnvc5veO1RpWfD0=;
        b=mgTKYqiKIU2uGZ6UmULnuaWrdzv21xpTqVSzFJuqZP1pVU/AOlT7LgcvN/CaCSj5bE
         OgWW9jt1ykFXNMasuDS4EdvhfQwxi+NwBgnIT8yn37edmZ6VY8m6WM96EqsrvhL89kik
         IzePCoy6BO7Shp48GTObYyQLeCS66pBOsV86DG4TLLLGW7xPx98MAnT6O/KFcysuNcQc
         cc+uvg5I3F+3m05W6rko6q6+3jwsj71cuA2UT5Hhmgw4wX1iBs4O0zpYCci4VdhgRh1v
         KPbJcB+yJT0OZdkbzWg66bOVStByLtvv1cNiZhXqlkVPHt7IqkfqbflFkcO0PL2PHwic
         651Q==
X-Gm-Message-State: APjAAAUlO+2GTuKcoTVj0sbZy6d9iDzNtNxEyj6iPT9E+zW1Nk+DFSz3
        1ZEoyr6I5EbVWPo9kaZu5tQp3GCQZZ8NiqDsiA8=
X-Google-Smtp-Source: APXvYqx956/X+reg4oVrDOUcjV7/RLFZT10w3z+8wYApEAreW5PVj2U3DhgtoypbznWBNzSrhUtmkdshwuUO1i5ipOo=
X-Received: by 2002:aca:d90a:: with SMTP id q10mr4133282oig.65.1556837292174;
 Thu, 02 May 2019 15:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190501140438.9506-1-brian.welty@intel.com> <20190502083433.GP7676@mtr-leonro.mtl.com>
In-Reply-To: <20190502083433.GP7676@mtr-leonro.mtl.com>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Thu, 2 May 2019 18:48:00 -0400
Message-ID: <CAOWid-cYknxeTQvP9vQf3-i3Cpux+bs7uBs7_o-YMFjVCo19bg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] cgroup support for GPU devices
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Brian Welty <brian.welty@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Parav Pandit <parav@mellanox.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        dri-devel@lists.freedesktop.org, Michal Hocko <mhocko@kernel.org>,
        linux-mm@kvack.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Li Zefan <lizefan@huawei.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> Count us (Mellanox) too, our RDMA devices are exposing special and
> limited in size device memory to the users and we would like to provide
> an option to use cgroup to control its exposure.
Doesn't RDMA already has a separate cgroup?  Why not implement it there?


> > and with future work, we could extend to:
> > *  track and control share of GPU time (reuse of cpu/cpuacct)
> > *  apply mask of allowed execution engines (reuse of cpusets)
> >
> > Instead of introducing a new cgroup subsystem for GPU devices, a new
> > framework is proposed to allow devices to register with existing cgroup
> > controllers, which creates per-device cgroup_subsys_state within the
> > cgroup.  This gives device drivers their own private cgroup controls
> > (such as memory limits or other parameters) to be applied to device
> > resources instead of host system resources.
> > Device drivers (GPU or other) are then able to reuse the existing cgroup
> > controls, instead of inventing similar ones.
> >
> > Per-device controls would be exposed in cgroup filesystem as:
> >     mount/<cgroup_name>/<subsys_name>.devices/<dev_name>/<subsys_files>
> > such as (for example):
> >     mount/<cgroup_name>/memory.devices/<dev_name>/memory.max
> >     mount/<cgroup_name>/memory.devices/<dev_name>/memory.current
> >     mount/<cgroup_name>/cpu.devices/<dev_name>/cpu.stat
> >     mount/<cgroup_name>/cpu.devices/<dev_name>/cpu.weight
> >
> > The drm/i915 patch in this series is based on top of other RFC work [1]
> > for i915 device memory support.
> >
> > AMD [2] and Intel [3] have proposed related work in this area within the
> > last few years, listed below as reference.  This new RFC reuses existing
> > cgroup controllers and takes a different approach than prior work.
> >
> > Finally, some potential discussion points for this series:
> > * merge proposed <subsys_name>.devices into a single devices directory?
> > * allow devices to have multiple registrations for subsets of resources?
> > * document a 'common charging policy' for device drivers to follow?
> >
> > [1] https://patchwork.freedesktop.org/series/56683/
> > [2] https://lists.freedesktop.org/archives/dri-devel/2018-November/197106.html
> > [3] https://lists.freedesktop.org/archives/intel-gfx/2018-January/153156.html
> >
> >
> > Brian Welty (5):
> >   cgroup: Add cgroup_subsys per-device registration framework
> >   cgroup: Change kernfs_node for directories to store
> >     cgroup_subsys_state
> >   memcg: Add per-device support to memory cgroup subsystem
> >   drm: Add memory cgroup registration and DRIVER_CGROUPS feature bit
> >   drm/i915: Use memory cgroup for enforcing device memory limit
> >
> >  drivers/gpu/drm/drm_drv.c                  |  12 +
> >  drivers/gpu/drm/drm_gem.c                  |   7 +
> >  drivers/gpu/drm/i915/i915_drv.c            |   2 +-
> >  drivers/gpu/drm/i915/intel_memory_region.c |  24 +-
> >  include/drm/drm_device.h                   |   3 +
> >  include/drm/drm_drv.h                      |   8 +
> >  include/drm/drm_gem.h                      |  11 +
> >  include/linux/cgroup-defs.h                |  28 ++
> >  include/linux/cgroup.h                     |   3 +
> >  include/linux/memcontrol.h                 |  10 +
> >  kernel/cgroup/cgroup-v1.c                  |  10 +-
> >  kernel/cgroup/cgroup.c                     | 310 ++++++++++++++++++---
> >  mm/memcontrol.c                            | 183 +++++++++++-
> >  13 files changed, 552 insertions(+), 59 deletions(-)
> >
> > --
> > 2.21.0
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

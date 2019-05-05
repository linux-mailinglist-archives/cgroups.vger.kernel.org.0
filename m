Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A26BD1402C
	for <lists+cgroups@lfdr.de>; Sun,  5 May 2019 16:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbfEEOVn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 5 May 2019 10:21:43 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41545 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfEEOVn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 5 May 2019 10:21:43 -0400
Received: by mail-oi1-f194.google.com with SMTP id b17so539873oie.8;
        Sun, 05 May 2019 07:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IQqSIA7uD5M0wQf7Hipk4HlzkvDnQtg0hg1zEHr33zY=;
        b=AWQlbU8VoVdVOq3fIViQl9WYLUDY46SLhaBmW9Msab5SMYgL0D5pHgqnoecO4JXrdp
         2K/zjn5/HgnHS3DI4TKeICobLr5jNn3MZFF8AWGvOzgMQvaFxHj0UersObHSwzbqjCHU
         kXFFzOlrutozkLHx0JC/PEftOVW4BUW7jl9QNtEAmrYuDNdqb7lyNN17WYTdeLCmWnPy
         UnxDtMS+e3G9oMwruAOb/RYs10NL5OqNm6D+D7hRvzETt/45lB6Xuk6D+wbdv1aVOktJ
         iYhmorWgDXqeGGDkgoGwbfAGo4MEe7F2Ixq+NKElGpK8fo9OAlyHVml2Qc8WS9v2A1Yi
         1sNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IQqSIA7uD5M0wQf7Hipk4HlzkvDnQtg0hg1zEHr33zY=;
        b=GTbLaNDC4zAXfV2Su1OaE8jJv/WijE+JDuvK4xh2nneD741w1qwbm/1p4MyOB0utgl
         /09UZ7MLyzU+/p5ZmRMoXgV252lp4QQQxSU75l4kaHVFRXuHGK6TCU06t/2ezJJ/2PEg
         GiFum7wdJjUzoxO/I/t7/Vrc76bcM5B9YprNUpXIB6yagVxos+01UbTWlczxdxkkIlDP
         pVX/hwKyTNRfzsTnufs/MCvREb5mE9VZyxvuufYddbHv9pB8xrBfyt8Lus68eF+G8Ul/
         YMkvpxG0P6DLMrjpZSGIXfeXlcBg5UXD5lf7n46vsNetwpr7pWC0aiyhCw9AhXp4ef1J
         ksHQ==
X-Gm-Message-State: APjAAAWrV8GNJmgrKkqoKlmiiQw7FxRpfgxr79mVYbjIuBHlSkzY7lzX
        5TBo1513mawxH403/P9cnsD53leC9x4T98cCCUI=
X-Google-Smtp-Source: APXvYqxtCTlnFpaog3a+ume/+CFEM0o9HMexE6GdSPSB//kAtVjADF27eCZpP5vpBUt2GA/SlUqk8VsrOlucOhccchs=
X-Received: by 2002:aca:72c9:: with SMTP id p192mr5372420oic.164.1557066102015;
 Sun, 05 May 2019 07:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190501140438.9506-1-brian.welty@intel.com> <20190502083433.GP7676@mtr-leonro.mtl.com>
 <CAOWid-cYknxeTQvP9vQf3-i3Cpux+bs7uBs7_o-YMFjVCo19bg@mail.gmail.com>
 <bb001de0-e4e5-6b3f-7ced-9d0fb329635b@intel.com> <20190505071436.GD6938@mtr-leonro.mtl.com>
In-Reply-To: <20190505071436.GD6938@mtr-leonro.mtl.com>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Sun, 5 May 2019 10:21:30 -0400
Message-ID: <CAOWid-di8kcC2bYKq1KJo+rWfVjwQ13mcVRjaBjhFRzTO=c16Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] cgroup support for GPU devices
To:     Leon Romanovsky <leon@kernel.org>
Cc:     "Welty, Brian" <brian.welty@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Parav Pandit <parav@mellanox.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org,
        "J??r??me Glisse" <jglisse@redhat.com>,
        dri-devel@lists.freedesktop.org, Michal Hocko <mhocko@kernel.org>,
        linux-mm@kvack.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Li Zefan <lizefan@huawei.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        "Christian K??nig" <christian.koenig@amd.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        kenny.ho@amd.com, Harish.Kasiviswanathan@amd.com, daniel@ffwll.ch
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, May 5, 2019 at 3:14 AM Leon Romanovsky <leon@kernel.org> wrote:
> > > Doesn't RDMA already has a separate cgroup?  Why not implement it there?
> > >
> >
> > Hi Kenny, I can't answer for Leon, but I'm hopeful he agrees with rationale
> > I gave in the cover letter.  Namely, to implement in rdma controller, would
> > mean duplicating existing memcg controls there.
>
> Exactly, I didn't feel comfortable to add notion of "device memory"
> to RDMA cgroup and postponed that decision to later point of time.
> RDMA operates with verbs objects and all our user space API is based around
> that concept. At the end, system administrator will have hard time to
> understand the differences between memcg and RDMA memory.
Interesting.  I actually don't understand this part (I worked in
devops/sysadmin side of things but never with rdma.)  Don't
applications that use rdma require some awareness of rdma (I mean, you
mentioned verbs and objects... or do they just use regular malloc for
buffer allocation and then send it through some function?)  As a user,
I would have this question: why do I need to configure some part of
rdma resources under rdma cgroup while other part of rdma resources in
a different, seemingly unrelated cgroups.

I think we need to be careful about drawing the line between
duplication and over couplings between subsystems.  I have other
thoughts and concerns and I will try to organize them into a response
in the next few days.

Regards,
Kenny


> >
> > Is AMD interested in collaborating to help shape this framework?
> > It is intended to be device-neutral, so could be leveraged by various
> > types of devices.
> > If you have an alternative solution well underway, then maybe
> > we can work together to merge our efforts into one.
> > In the end, the DRM community is best served with common solution.
> >
> >
> > >
> > >>> and with future work, we could extend to:
> > >>> *  track and control share of GPU time (reuse of cpu/cpuacct)
> > >>> *  apply mask of allowed execution engines (reuse of cpusets)
> > >>>
> > >>> Instead of introducing a new cgroup subsystem for GPU devices, a new
> > >>> framework is proposed to allow devices to register with existing cgroup
> > >>> controllers, which creates per-device cgroup_subsys_state within the
> > >>> cgroup.  This gives device drivers their own private cgroup controls
> > >>> (such as memory limits or other parameters) to be applied to device
> > >>> resources instead of host system resources.
> > >>> Device drivers (GPU or other) are then able to reuse the existing cgroup
> > >>> controls, instead of inventing similar ones.
> > >>>
> > >>> Per-device controls would be exposed in cgroup filesystem as:
> > >>>     mount/<cgroup_name>/<subsys_name>.devices/<dev_name>/<subsys_files>
> > >>> such as (for example):
> > >>>     mount/<cgroup_name>/memory.devices/<dev_name>/memory.max
> > >>>     mount/<cgroup_name>/memory.devices/<dev_name>/memory.current
> > >>>     mount/<cgroup_name>/cpu.devices/<dev_name>/cpu.stat
> > >>>     mount/<cgroup_name>/cpu.devices/<dev_name>/cpu.weight
> > >>>
> > >>> The drm/i915 patch in this series is based on top of other RFC work [1]
> > >>> for i915 device memory support.
> > >>>
> > >>> AMD [2] and Intel [3] have proposed related work in this area within the
> > >>> last few years, listed below as reference.  This new RFC reuses existing
> > >>> cgroup controllers and takes a different approach than prior work.
> > >>>
> > >>> Finally, some potential discussion points for this series:
> > >>> * merge proposed <subsys_name>.devices into a single devices directory?
> > >>> * allow devices to have multiple registrations for subsets of resources?
> > >>> * document a 'common charging policy' for device drivers to follow?
> > >>>
> > >>> [1] https://patchwork.freedesktop.org/series/56683/
> > >>> [2] https://lists.freedesktop.org/archives/dri-devel/2018-November/197106.html
> > >>> [3] https://lists.freedesktop.org/archives/intel-gfx/2018-January/153156.html
> > >>>
> > >>>
> > >>> Brian Welty (5):
> > >>>   cgroup: Add cgroup_subsys per-device registration framework
> > >>>   cgroup: Change kernfs_node for directories to store
> > >>>     cgroup_subsys_state
> > >>>   memcg: Add per-device support to memory cgroup subsystem
> > >>>   drm: Add memory cgroup registration and DRIVER_CGROUPS feature bit
> > >>>   drm/i915: Use memory cgroup for enforcing device memory limit
> > >>>
> > >>>  drivers/gpu/drm/drm_drv.c                  |  12 +
> > >>>  drivers/gpu/drm/drm_gem.c                  |   7 +
> > >>>  drivers/gpu/drm/i915/i915_drv.c            |   2 +-
> > >>>  drivers/gpu/drm/i915/intel_memory_region.c |  24 +-
> > >>>  include/drm/drm_device.h                   |   3 +
> > >>>  include/drm/drm_drv.h                      |   8 +
> > >>>  include/drm/drm_gem.h                      |  11 +
> > >>>  include/linux/cgroup-defs.h                |  28 ++
> > >>>  include/linux/cgroup.h                     |   3 +
> > >>>  include/linux/memcontrol.h                 |  10 +
> > >>>  kernel/cgroup/cgroup-v1.c                  |  10 +-
> > >>>  kernel/cgroup/cgroup.c                     | 310 ++++++++++++++++++---
> > >>>  mm/memcontrol.c                            | 183 +++++++++++-
> > >>>  13 files changed, 552 insertions(+), 59 deletions(-)
> > >>>
> > >>> --
> > >>> 2.21.0
> > >>>
> > >> _______________________________________________
> > >> dri-devel mailing list
> > >> dri-devel@lists.freedesktop.org
> > >> https://lists.freedesktop.org/mailman/listinfo/dri-devel

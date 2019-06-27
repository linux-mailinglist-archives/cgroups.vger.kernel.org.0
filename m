Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A18DE57D13
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2019 09:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfF0HYT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Jun 2019 03:24:19 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35266 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfF0HYS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Jun 2019 03:24:18 -0400
Received: by mail-oi1-f195.google.com with SMTP id a127so853563oii.2
        for <cgroups@vger.kernel.org>; Thu, 27 Jun 2019 00:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vJTfTEMll+MNGYhhC9o5sIe3hWf91gFIsBeAH0xMWvM=;
        b=SYe/QftDPkjv9qlPk0V/KNtmUFqVdDQH64JhiX8vBzF4HEp0uOGckLVk+7fxLkv6rs
         jW30KahGZ5sulWFuNYbjxG8GrspMCHsw9hLSyD9Yw6DCGcau6A4nDNWvG4gLapUD72I+
         5MyLttAf4CjHcGsL/sw+bqv+k6vVEPDeGIdO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vJTfTEMll+MNGYhhC9o5sIe3hWf91gFIsBeAH0xMWvM=;
        b=T3UqMD2zM1OeV0B6+pNqGUMNUDoNHIEVgIsUl8c/kZcrGhCxA+R+WIzdWLnxnrN9I8
         uG31h7PJhO/P7+A8XoP5yfcp5qgBlfmkT51+Z5JswfnImYjQPsH9Abomll3oLIT+XAyP
         F8vy5wjsazKXC33HXlK0uafMjShhdGyV6V8K2mmGOeHba6QMIHKNz5fPkemsfeo4ohuV
         2E8fJavmv0Y0DypAiJ95rsa15yiDEwJcj0VrrKaBoGC8pF7IZWTYtkSGrl5PYMX85TLq
         zSNp/fZndTS723WVmT5PTDBt92aIzGdntSPbTS84RIY/NL60deSGNOZu/BE/0GiEW/wq
         OIyg==
X-Gm-Message-State: APjAAAX/+ZSB7y5Du9KaYMd4ipfGySlOfrGS861oX3q/O6t1WyUhgtRR
        VmGsSUCLejTfJboGdCbGVeaxcP0o/+cCPdNcdjvT/w==
X-Google-Smtp-Source: APXvYqyKTgrvIQMP4S38qosYsB1dy2S42n/ehXpYdPmYLRGXqWU7LtmHSyzAmxrGbKAFQ4UxeDIeG4vTSS/7P+Cc6lI=
X-Received: by 2002:a54:4f89:: with SMTP id g9mr1514874oiy.110.1561620257749;
 Thu, 27 Jun 2019 00:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190626150522.11618-1-Kenny.Ho@amd.com>
In-Reply-To: <20190626150522.11618-1-Kenny.Ho@amd.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 27 Jun 2019 09:24:06 +0200
Message-ID: <CAKMK7uFq7qCpzXqrD4o8Vw_dOwt=ny_oS7TRZFsANpPdC604vw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/11] new cgroup controller for gpu/drm subsystem
To:     Kenny Ho <Kenny.Ho@amd.com>, Jerome Glisse <jglisse@redhat.com>
Cc:     Kenny Ho <y2kenny@gmail.com>, cgroups@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Tejun Heo <tj@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        joseph.greathouse@amd.com, jsparks@cray.com, lkaplan@cray.com
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 26, 2019 at 5:05 PM Kenny Ho <Kenny.Ho@amd.com> wrote:
> This is a follow up to the RFC I made previously to introduce a cgroup
> controller for the GPU/DRM subsystem [v1,v2].  The goal is to be able to
> provide resource management to GPU resources using things like container.
> The cover letter from v1 is copied below for reference.
>
> [v1]: https://lists.freedesktop.org/archives/dri-devel/2018-November/197106.html
> [v2]: https://www.spinics.net/lists/cgroups/msg22074.html
>
> v3:
> Base on feedbacks on v2:
> * removed .help type file from v2
> * conform to cgroup convention for default and max handling
> * conform to cgroup convention for addressing device specific limits (with major:minor)
> New function:
> * adopted memparse for memory size related attributes
> * added macro to marshall drmcgrp cftype private  (DRMCG_CTF_PRIV, etc.)
> * added ttm buffer usage stats (per cgroup, for system, tt, vram.)
> * added ttm buffer usage limit (per cgroup, for vram.)
> * added per cgroup bandwidth stats and limiting (burst and average bandwidth)
>
> v2:
> * Removed the vendoring concepts
> * Add limit to total buffer allocation
> * Add limit to the maximum size of a buffer allocation
>
> v1: cover letter
>
> The purpose of this patch series is to start a discussion for a generic cgroup
> controller for the drm subsystem.  The design proposed here is a very early one.
> We are hoping to engage the community as we develop the idea.
>
>
> Backgrounds
> ==========
> Control Groups/cgroup provide a mechanism for aggregating/partitioning sets of
> tasks, and all their future children, into hierarchical groups with specialized
> behaviour, such as accounting/limiting the resources which processes in a cgroup
> can access[1].  Weights, limits, protections, allocations are the main resource
> distribution models.  Existing cgroup controllers includes cpu, memory, io,
> rdma, and more.  cgroup is one of the foundational technologies that enables the
> popular container application deployment and management method.
>
> Direct Rendering Manager/drm contains code intended to support the needs of
> complex graphics devices. Graphics drivers in the kernel may make use of DRM
> functions to make tasks like memory management, interrupt handling and DMA
> easier, and provide a uniform interface to applications.  The DRM has also
> developed beyond traditional graphics applications to support compute/GPGPU
> applications.
>
>
> Motivations
> =========
> As GPU grow beyond the realm of desktop/workstation graphics into areas like
> data center clusters and IoT, there are increasing needs to monitor and regulate
> GPU as a resource like cpu, memory and io.
>
> Matt Roper from Intel began working on similar idea in early 2018 [2] for the
> purpose of managing GPU priority using the cgroup hierarchy.  While that
> particular use case may not warrant a standalone drm cgroup controller, there
> are other use cases where having one can be useful [3].  Monitoring GPU
> resources such as VRAM and buffers, CU (compute unit [AMD's nomenclature])/EU
> (execution unit [Intel's nomenclature]), GPU job scheduling [4] can help
> sysadmins get a better understanding of the applications usage profile.  Further
> usage regulations of the aforementioned resources can also help sysadmins
> optimize workload deployment on limited GPU resources.
>
> With the increased importance of machine learning, data science and other
> cloud-based applications, GPUs are already in production use in data centers
> today [5,6,7].  Existing GPU resource management is very course grain, however,
> as sysadmins are only able to distribute workload on a per-GPU basis [8].  An
> alternative is to use GPU virtualization (with or without SRIOV) but it
> generally acts on the entire GPU instead of the specific resources in a GPU.
> With a drm cgroup controller, we can enable alternate, fine-grain, sub-GPU
> resource management (in addition to what may be available via GPU
> virtualization.)
>
> In addition to production use, the DRM cgroup can also help with testing
> graphics application robustness by providing a mean to artificially limit DRM
> resources availble to the applications.
>
>
> Challenges
> ========
> While there are common infrastructure in DRM that is shared across many vendors
> (the scheduler [4] for example), there are also aspects of DRM that are vendor
> specific.  To accommodate this, we borrowed the mechanism used by the cgroup to
> handle different kinds of cgroup controller.
>
> Resources for DRM are also often device (GPU) specific instead of system
> specific and a system may contain more than one GPU.  For this, we borrowed some
> of the ideas from RDMA cgroup controller.

Another question I have: What about HMM? With the device memory zone
the core mm will be a lot more involved in managing that, but I also
expect that we'll have classic buffer-based management for a long time
still. So these need to work together, and I fear slightly that we'll
have memcg and drmcg fighting over the same pieces a bit perhaps?

Adding Jerome, maybe he has some thoughts on this.
-Daniel

> Approach
> =======
> To experiment with the idea of a DRM cgroup, we would like to start with basic
> accounting and statistics, then continue to iterate and add regulating
> mechanisms into the driver.
>
> [1] https://www.kernel.org/doc/Documentation/cgroup-v1/cgroups.txt
> [2] https://lists.freedesktop.org/archives/intel-gfx/2018-January/153156.html
> [3] https://www.spinics.net/lists/cgroups/msg20720.html
> [4] https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/scheduler
> [5] https://kubernetes.io/docs/tasks/manage-gpus/scheduling-gpus/
> [6] https://blog.openshift.com/gpu-accelerated-sql-queries-with-postgresql-pg-strom-in-openshift-3-10/
> [7] https://github.com/RadeonOpenCompute/k8s-device-plugin
> [8] https://github.com/kubernetes/kubernetes/issues/52757
>
> Kenny Ho (11):
>   cgroup: Introduce cgroup for drm subsystem
>   cgroup: Add mechanism to register DRM devices
>   drm/amdgpu: Register AMD devices for DRM cgroup
>   drm, cgroup: Add total GEM buffer allocation limit
>   drm, cgroup: Add peak GEM buffer allocation limit
>   drm, cgroup: Add GEM buffer allocation count stats
>   drm, cgroup: Add TTM buffer allocation stats
>   drm, cgroup: Add TTM buffer peak usage stats
>   drm, cgroup: Add per cgroup bw measure and control
>   drm, cgroup: Add soft VRAM limit
>   drm, cgroup: Allow more aggressive memory reclaim
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |    4 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |    4 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |    3 +-
>  drivers/gpu/drm/drm_gem.c                  |    8 +
>  drivers/gpu/drm/drm_prime.c                |    9 +
>  drivers/gpu/drm/ttm/ttm_bo.c               |   91 ++
>  drivers/gpu/drm/ttm/ttm_bo_util.c          |    4 +
>  include/drm/drm_cgroup.h                   |  115 ++
>  include/drm/drm_gem.h                      |   11 +
>  include/drm/ttm/ttm_bo_api.h               |    2 +
>  include/drm/ttm/ttm_bo_driver.h            |   10 +
>  include/linux/cgroup_drm.h                 |  114 ++
>  include/linux/cgroup_subsys.h              |    4 +
>  init/Kconfig                               |    5 +
>  kernel/cgroup/Makefile                     |    1 +
>  kernel/cgroup/drm.c                        | 1171 ++++++++++++++++++++
>  16 files changed, 1555 insertions(+), 1 deletion(-)
>  create mode 100644 include/drm/drm_cgroup.h
>  create mode 100644 include/linux/cgroup_drm.h
>  create mode 100644 kernel/cgroup/drm.c
>
> --
> 2.21.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch

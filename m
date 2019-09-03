Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA20BA6360
	for <lists+cgroups@lfdr.de>; Tue,  3 Sep 2019 10:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfICICY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Sep 2019 04:02:24 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33720 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfICICX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Sep 2019 04:02:23 -0400
Received: by mail-ed1-f68.google.com with SMTP id o9so6063660edq.0
        for <cgroups@vger.kernel.org>; Tue, 03 Sep 2019 01:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wIH4Hu7Vd1sqhXRFLV0EpA711TT7Xv+eYOWl+2Fupbc=;
        b=lFyg/xM7/M/kafno7zc7zGCs850lFqdULeIshGDR6eIhLMrqwtrABdhafSKII8n8o3
         5BSFhbHcYkc6I8RHgUzZjHmxQQvjVncVSZ/IrgmnnnXh4/DKbWDeGd9sr3DbpvPul6/0
         C+ZkCjIwlyfM6vOZDoSzSVtUjYa6oYaCW4WVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wIH4Hu7Vd1sqhXRFLV0EpA711TT7Xv+eYOWl+2Fupbc=;
        b=ONhsXSgcmIKVDg75Pilas+R33s4B1/DN11dqRFiWozDeVDTDephcvYk8RI4xi84I1l
         mVCGwIFBE6+gGEz/z4w3jHM2p8oyA4AnqfDy5mQnC18vX/IKFXNJ19zMZKb6/TTDqbKO
         lAA1vjgtFcmZh5/Jef3wnwg3s8unZqqhgjj+ps5CnMCPJDNfXSvrtaK55M+P7Ju+7++8
         9Fsu8B5JMF4zoPL43JfNYNQ+6Q69IJcwG+DcQRosAs+MXnlOeAWKe3vLN6IwDu3s034a
         2q479HUbAOLFiqU0EOUTUiWX5uwkoApfbV03JvraH1Bbjju9eE4MQX6AiHMaLpuplp2q
         M2Bw==
X-Gm-Message-State: APjAAAVw0lAZOFeBpMr6fIF9CCq36Vgq1ZnnAk+YTZmhISnInRSQ1pfk
        NvjW+3GPWFV2mQ6OmorkMfAEJA==
X-Google-Smtp-Source: APXvYqwF5d1PUXlTjcv4BY+aWcpbHm+kj2NnZjPDJzEjVr7sa6XBVoynpHZ0e5J8RSXAm6ZrDbAfrQ==
X-Received: by 2002:a50:88c5:: with SMTP id d63mr34376794edd.122.1567497740448;
        Tue, 03 Sep 2019 01:02:20 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id a36sm2181762edc.58.2019.09.03.01.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 01:02:19 -0700 (PDT)
Date:   Tue, 3 Sep 2019 10:02:17 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Kenny Ho <Kenny.Ho@amd.com>
Cc:     y2kenny@gmail.com, cgroups@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        tj@kernel.org, alexander.deucher@amd.com, christian.koenig@amd.com,
        felix.kuehling@amd.com, joseph.greathouse@amd.com,
        jsparks@cray.com, lkaplan@cray.com, daniel@ffwll.ch
Subject: Re: [PATCH RFC v4 00/16] new cgroup controller for gpu/drm subsystem
Message-ID: <20190903080217.GL2112@phenom.ffwll.local>
References: <20190829060533.32315-1-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829060533.32315-1-Kenny.Ho@amd.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Aug 29, 2019 at 02:05:17AM -0400, Kenny Ho wrote:
> This is a follow up to the RFC I made previously to introduce a cgroup
> controller for the GPU/DRM subsystem [v1,v2,v3].  The goal is to be able to
> provide resource management to GPU resources using things like container.  
> 
> With this RFC v4, I am hoping to have some consensus on a merge plan.  I believe
> the GEM related resources (drm.buffer.*) introduced in previous RFC and,
> hopefully, the logical GPU concept (drm.lgpu.*) introduced in this RFC are
> uncontroversial and ready to move out of RFC and into a more formal review.  I
> will continue to work on the memory backend resources (drm.memory.*).
> 
> The cover letter from v1 is copied below for reference.
> 
> [v1]: https://lists.freedesktop.org/archives/dri-devel/2018-November/197106.html
> [v2]: https://www.spinics.net/lists/cgroups/msg22074.html
> [v3]: https://lists.freedesktop.org/archives/amd-gfx/2019-June/036026.html

So looking at all this doesn't seem to have changed much, and the old
discussion didn't really conclude anywhere (aside from some details).

One more open though that crossed my mind, having read a ton of ttm again
recently: How does this all interact with ttm global limits? I'd say the
ttm global limits is the ur-cgroups we have in drm, and not looking at
that seems kinda bad.
-Daniel

> 
> v4:
> Unchanged (no review needed)
> * drm.memory.*/ttm resources (Patch 9-13, I am still working on memory bandwidth
> and shrinker)
> Base on feedbacks on v3:
> * update nominclature to drmcg
> * embed per device drmcg properties into drm_device
> * split GEM buffer related commits into stats and limit
> * rename function name to align with convention
> * combined buffer accounting and check into a try_charge function
> * support buffer stats without limit enforcement
> * removed GEM buffer sharing limitation
> * updated documentations
> New features:
> * introducing logical GPU concept
> * example implementation with AMD KFD
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
> 
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
> Kenny Ho (16):
>   drm: Add drm_minor_for_each
>   cgroup: Introduce cgroup for drm subsystem
>   drm, cgroup: Initialize drmcg properties
>   drm, cgroup: Add total GEM buffer allocation stats
>   drm, cgroup: Add peak GEM buffer allocation stats
>   drm, cgroup: Add GEM buffer allocation count stats
>   drm, cgroup: Add total GEM buffer allocation limit
>   drm, cgroup: Add peak GEM buffer allocation limit
>   drm, cgroup: Add TTM buffer allocation stats
>   drm, cgroup: Add TTM buffer peak usage stats
>   drm, cgroup: Add per cgroup bw measure and control
>   drm, cgroup: Add soft VRAM limit
>   drm, cgroup: Allow more aggressive memory reclaim
>   drm, cgroup: Introduce lgpu as DRM cgroup resource
>   drm, cgroup: add update trigger after limit change
>   drm/amdgpu: Integrate with DRM cgroup
> 
>  Documentation/admin-guide/cgroup-v2.rst       |  163 +-
>  Documentation/cgroup-v1/drm.rst               |    1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |    4 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   29 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |    6 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |    3 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |    6 +
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |    3 +
>  .../amd/amdkfd/kfd_process_queue_manager.c    |  140 ++
>  drivers/gpu/drm/drm_drv.c                     |   26 +
>  drivers/gpu/drm/drm_gem.c                     |   16 +-
>  drivers/gpu/drm/drm_internal.h                |    4 -
>  drivers/gpu/drm/ttm/ttm_bo.c                  |   93 ++
>  drivers/gpu/drm/ttm/ttm_bo_util.c             |    4 +
>  include/drm/drm_cgroup.h                      |  122 ++
>  include/drm/drm_device.h                      |    7 +
>  include/drm/drm_drv.h                         |   23 +
>  include/drm/drm_gem.h                         |   13 +-
>  include/drm/ttm/ttm_bo_api.h                  |    2 +
>  include/drm/ttm/ttm_bo_driver.h               |   10 +
>  include/linux/cgroup_drm.h                    |  151 ++
>  include/linux/cgroup_subsys.h                 |    4 +
>  init/Kconfig                                  |    5 +
>  kernel/cgroup/Makefile                        |    1 +
>  kernel/cgroup/drm.c                           | 1367 +++++++++++++++++
>  25 files changed, 2193 insertions(+), 10 deletions(-)
>  create mode 100644 Documentation/cgroup-v1/drm.rst
>  create mode 100644 include/drm/drm_cgroup.h
>  create mode 100644 include/linux/cgroup_drm.h
>  create mode 100644 kernel/cgroup/drm.c
> 
> -- 
> 2.22.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

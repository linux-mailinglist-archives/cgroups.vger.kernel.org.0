Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 468B719D4A
	for <lists+cgroups@lfdr.de>; Fri, 10 May 2019 14:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfEJMbv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 May 2019 08:31:51 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33450 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbfEJMbv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 May 2019 08:31:51 -0400
Received: by mail-wm1-f66.google.com with SMTP id c66so1218237wme.0
        for <cgroups@vger.kernel.org>; Fri, 10 May 2019 05:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=EQY4uwQj1WgFw8LLjh7dFTKB6G9R/Xpl3wCAFu8cKvY=;
        b=TzryiSZ6CXZ8NdpL9oOcYdIyY5asKUQKHCDpMnS4Wn5TnfYPv2tTwGrM8BTdMbCJgF
         FguUoXzMDo3cQAJAMFfMPnjkBul3ei5L12ulwhXau1R/yp34dGAkBd8X/JhcU6CpDHbA
         CuKLyZKZENUUXH64FfsqxJN05uGDB2CspJ+1/0P0yZCGirpYdEMVDTuaxWPm20k0mzAd
         gh23HB/4joSeiCI0SOfDho0/H22ApYeb7/9ndiHFYKxQcZNDNpUkVr+tjg1DHq7rV9Jh
         rJRzwJhzYLaW7w+63+lDYCYxUwRqNvXdAwWYQPyl/bHeSp7RMPkUVyqSOXos5pFlQeOd
         4eWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=EQY4uwQj1WgFw8LLjh7dFTKB6G9R/Xpl3wCAFu8cKvY=;
        b=BTa7uswKV2lx7AOOcGVPm2nDfCVcN6+dlVP4hs3Y5TnYQh7gZ+bUGw0nKpCOzX5TP+
         5vvKgJg7wRWE7i36xw+u/GW52nDobOAwmzeGfNx5OuScD8ryZrfqz/uPPHkJB4xwpIIV
         OS0Zg0MkCkHH05L8nmB5x7oqDxeNO/xW/e/ySP/LsUDz0XpgWtQjwE9ehNpHgHZrTdZ7
         Vde5ZlDHHf3hjKiZT8H8r/UF1AsBnBgoBlBo3Xk2UDXQpgenQR4fwyji/8cmtE+4n4e2
         sruMBHuZHjAP5G/kjoRsIuO8Whrz1CihL7aY09sFR6cGT+jdaV+vg4qadcsETyxUVEIC
         2rHA==
X-Gm-Message-State: APjAAAUAN/iVK83ETplML+JLXu/Q1nCFujli59ojE+O8cOSOQ1svMcY/
        WfR2n8daaNbz5CXwTncJd30=
X-Google-Smtp-Source: APXvYqzrkKeyENtP4zmmyD5HupAJeDe0gun1AC7tq0txrtpruCyHvkyEy6/U51l9/35E/PvjEgWdRA==
X-Received: by 2002:a1c:2e88:: with SMTP id u130mr6688708wmu.54.1557491508940;
        Fri, 10 May 2019 05:31:48 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id d3sm9206283wmf.46.2019.05.10.05.31.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 05:31:48 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [RFC PATCH v2 0/5] new cgroup controller for gpu/drm subsystem
To:     Kenny Ho <Kenny.Ho@amd.com>, y2kenny@gmail.com,
        cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, tj@kernel.org,
        sunnanyong@huawei.com, alexander.deucher@amd.com,
        brian.welty@intel.com
References: <20181120185814.13362-1-Kenny.Ho@amd.com>
 <20190509210410.5471-1-Kenny.Ho@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <00c14f11-4c25-2108-546e-04a2721d2cfa@gmail.com>
Date:   Fri, 10 May 2019 14:31:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509210410.5471-1-Kenny.Ho@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

That looks better than I thought it would be.

I think it is a good approach to try to add a global limit first and 
when that's working go ahead with limiting device specific resources.

The only major issue I can see is on patch #4, see there for further 
details.

Christian.

Am 09.05.19 um 23:04 schrieb Kenny Ho:
> This is a follow up to the RFC I made last november to introduce a cgroup controller for the GPU/DRM subsystem [a].  The goal is to be able to provide resource management to GPU resources using things like container.  The cover letter from v1 is copied below for reference.
>
> Usage examples:
> // set limit for card1 to 1GB
> sed -i '2s/.*/1073741824/' /sys/fs/cgroup/<cgroup>/drm.buffer.total.max
>
> // set limit for card0 to 512MB
> sed -i '1s/.*/536870912/' /sys/fs/cgroup/<cgroup>/drm.buffer.total.max
>
>
> v2:
> * Removed the vendoring concepts
> * Add limit to total buffer allocation
> * Add limit to the maximum size of a buffer allocation
>
> TODO: process migration
> TODO: documentations
>
> [a]: https://lists.freedesktop.org/archives/dri-devel/2018-November/197106.html
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
> Kenny Ho (5):
>    cgroup: Introduce cgroup for drm subsystem
>    cgroup: Add mechanism to register DRM devices
>    drm/amdgpu: Register AMD devices for DRM cgroup
>    drm, cgroup: Add total GEM buffer allocation limit
>    drm, cgroup: Add peak GEM buffer allocation limit
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |   4 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |   4 +
>   drivers/gpu/drm/drm_gem.c                  |   7 +
>   drivers/gpu/drm/drm_prime.c                |   9 +
>   include/drm/drm_cgroup.h                   |  54 +++
>   include/drm/drm_gem.h                      |  11 +
>   include/linux/cgroup_drm.h                 |  47 ++
>   include/linux/cgroup_subsys.h              |   4 +
>   init/Kconfig                               |   5 +
>   kernel/cgroup/Makefile                     |   1 +
>   kernel/cgroup/drm.c                        | 497 +++++++++++++++++++++
>   11 files changed, 643 insertions(+)
>   create mode 100644 include/drm/drm_cgroup.h
>   create mode 100644 include/linux/cgroup_drm.h
>   create mode 100644 kernel/cgroup/drm.c
>


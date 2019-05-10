Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97FA619FD4
	for <lists+cgroups@lfdr.de>; Fri, 10 May 2019 17:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfEJPHe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 May 2019 11:07:34 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37278 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfEJPHe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 May 2019 11:07:34 -0400
Received: by mail-ot1-f66.google.com with SMTP id r10so5130006otd.4
        for <cgroups@vger.kernel.org>; Fri, 10 May 2019 08:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6KbiBBZ7ZM7RTV80AP0G7wsgbLZR8pTJS1Q99/v7I3c=;
        b=mrNnNzjM2bb2PAFcCC/WS4dCqJyE9jSHwX14K8iMqhkdxvf0UjbSIUHAvyb7FAiYeY
         Z6oTySKPdm6BM98UHjpXo7gjNHP7trEDACWwTldvXwfQliH96QawYP3EUCgs+RUzPLub
         OoO1gfrY+LxPkBUAOCBzatWvqIRdSmsEcrMdLlWwBDeyG0znVVPesxSfjTm+YwL5yOQk
         fq8KBFdg5DX7/qFqVBzMqxMMW4XnZpLO5XQw/ASyALu7GllCAqKQfXrZaNOIkInLA63I
         vSYSOrkxGT+xsCncCr3RQtXOpPdYKq+/LXksKrGJQIPZmrO3dmqDV7gHckp2ve89XUro
         /+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6KbiBBZ7ZM7RTV80AP0G7wsgbLZR8pTJS1Q99/v7I3c=;
        b=iNlBKa477LRtntWTAYm/eTdT5mN3a38wdp3LSRz8XUewDOD09BGsA6rSJBj7dOZOKW
         KJ3ai7Ui4OiSzFF1d6DTl7rBDU0++6cKbeqj9BgIr2YamQbVy9s6n0soGNgVJD6CgC7a
         VWcxdnGHDtgetEDzuyvgl2RxywADs6LY31opzZ2BC/DEQFjSTvFurLj9ZQdQpPT8kQC0
         QkU0cMsn/vZ2VbX+rHw1y+XjiZG3FOWNngq9k18OvK21J8yfRDHr7S/A+sxk5QDqzKYy
         F6vq/PwFg16GaUeCjFOABMosfJNtojAOKmDFZFpkic1dSebjMqopWBK/cSHPWgpH3ihr
         b5xA==
X-Gm-Message-State: APjAAAX/8F465af4B0yzZMa5v4HNyvoh7QIAbLN1gZwSpSf9Q1vy8ssi
        jNuBzx7MmzheHoEw5YAjNeT95+QmLgbNRKQAvrA=
X-Google-Smtp-Source: APXvYqyxxwyRpiYBh7LCwkkFlT5qSG5MSgMk1wamfn42KUFJQ5czL/y4LAvKVOnkwa1fiOkFQOp7gasbXwXwK9Bad98=
X-Received: by 2002:a9d:6852:: with SMTP id c18mr7630064oto.174.1557500852799;
 Fri, 10 May 2019 08:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <20181120185814.13362-1-Kenny.Ho@amd.com> <20190509210410.5471-1-Kenny.Ho@amd.com>
 <00c14f11-4c25-2108-546e-04a2721d2cfa@gmail.com>
In-Reply-To: <00c14f11-4c25-2108-546e-04a2721d2cfa@gmail.com>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Fri, 10 May 2019 11:07:21 -0400
Message-ID: <CAOWid-dJZrnAifFYByh4p9x-jA1o_5YWkoNVAVbdRUaxzdPbGA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] new cgroup controller for gpu/drm subsystem
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Kenny Ho <Kenny.Ho@amd.com>, cgroups@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Tejun Heo <tj@kernel.org>, sunnanyong@huawei.com,
        Alex Deucher <alexander.deucher@amd.com>,
        Brian Welty <brian.welty@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 10, 2019 at 8:31 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> I think it is a good approach to try to add a global limit first and
> when that's working go ahead with limiting device specific resources.
What are some of the global drm resource limit/allocation that would
be useful to implement? I would be happy to dig into those.

Regards,
Kenny


> The only major issue I can see is on patch #4, see there for further
> details.
>
> Christian.
>
> Am 09.05.19 um 23:04 schrieb Kenny Ho:
> > This is a follow up to the RFC I made last november to introduce a cgro=
up controller for the GPU/DRM subsystem [a].  The goal is to be able to pro=
vide resource management to GPU resources using things like container.  The=
 cover letter from v1 is copied below for reference.
> >
> > Usage examples:
> > // set limit for card1 to 1GB
> > sed -i '2s/.*/1073741824/' /sys/fs/cgroup/<cgroup>/drm.buffer.total.max
> >
> > // set limit for card0 to 512MB
> > sed -i '1s/.*/536870912/' /sys/fs/cgroup/<cgroup>/drm.buffer.total.max
> >
> >
> > v2:
> > * Removed the vendoring concepts
> > * Add limit to total buffer allocation
> > * Add limit to the maximum size of a buffer allocation
> >
> > TODO: process migration
> > TODO: documentations
> >
> > [a]: https://lists.freedesktop.org/archives/dri-devel/2018-November/197=
106.html
> >
> > v1: cover letter
> >
> > The purpose of this patch series is to start a discussion for a generic=
 cgroup
> > controller for the drm subsystem.  The design proposed here is a very e=
arly one.
> > We are hoping to engage the community as we develop the idea.
> >
> >
> > Backgrounds
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Control Groups/cgroup provide a mechanism for aggregating/partitioning =
sets of
> > tasks, and all their future children, into hierarchical groups with spe=
cialized
> > behaviour, such as accounting/limiting the resources which processes in=
 a cgroup
> > can access[1].  Weights, limits, protections, allocations are the main =
resource
> > distribution models.  Existing cgroup controllers includes cpu, memory,=
 io,
> > rdma, and more.  cgroup is one of the foundational technologies that en=
ables the
> > popular container application deployment and management method.
> >
> > Direct Rendering Manager/drm contains code intended to support the need=
s of
> > complex graphics devices. Graphics drivers in the kernel may make use o=
f DRM
> > functions to make tasks like memory management, interrupt handling and =
DMA
> > easier, and provide a uniform interface to applications.  The DRM has a=
lso
> > developed beyond traditional graphics applications to support compute/G=
PGPU
> > applications.
> >
> >
> > Motivations
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > As GPU grow beyond the realm of desktop/workstation graphics into areas=
 like
> > data center clusters and IoT, there are increasing needs to monitor and=
 regulate
> > GPU as a resource like cpu, memory and io.
> >
> > Matt Roper from Intel began working on similar idea in early 2018 [2] f=
or the
> > purpose of managing GPU priority using the cgroup hierarchy.  While tha=
t
> > particular use case may not warrant a standalone drm cgroup controller,=
 there
> > are other use cases where having one can be useful [3].  Monitoring GPU
> > resources such as VRAM and buffers, CU (compute unit [AMD's nomenclatur=
e])/EU
> > (execution unit [Intel's nomenclature]), GPU job scheduling [4] can hel=
p
> > sysadmins get a better understanding of the applications usage profile.=
  Further
> > usage regulations of the aforementioned resources can also help sysadmi=
ns
> > optimize workload deployment on limited GPU resources.
> >
> > With the increased importance of machine learning, data science and oth=
er
> > cloud-based applications, GPUs are already in production use in data ce=
nters
> > today [5,6,7].  Existing GPU resource management is very course grain, =
however,
> > as sysadmins are only able to distribute workload on a per-GPU basis [8=
].  An
> > alternative is to use GPU virtualization (with or without SRIOV) but it
> > generally acts on the entire GPU instead of the specific resources in a=
 GPU.
> > With a drm cgroup controller, we can enable alternate, fine-grain, sub-=
GPU
> > resource management (in addition to what may be available via GPU
> > virtualization.)
> >
> > In addition to production use, the DRM cgroup can also help with testin=
g
> > graphics application robustness by providing a mean to artificially lim=
it DRM
> > resources availble to the applications.
> >
> > Challenges
> > =3D=3D=3D=3D=3D=3D=3D=3D
> > While there are common infrastructure in DRM that is shared across many=
 vendors
> > (the scheduler [4] for example), there are also aspects of DRM that are=
 vendor
> > specific.  To accommodate this, we borrowed the mechanism used by the c=
group to
> > handle different kinds of cgroup controller.
> >
> > Resources for DRM are also often device (GPU) specific instead of syste=
m
> > specific and a system may contain more than one GPU.  For this, we borr=
owed some
> > of the ideas from RDMA cgroup controller.
> >
> > Approach
> > =3D=3D=3D=3D=3D=3D=3D
> > To experiment with the idea of a DRM cgroup, we would like to start wit=
h basic
> > accounting and statistics, then continue to iterate and add regulating
> > mechanisms into the driver.
> >
> > [1] https://www.kernel.org/doc/Documentation/cgroup-v1/cgroups.txt
> > [2] https://lists.freedesktop.org/archives/intel-gfx/2018-January/15315=
6.html
> > [3] https://www.spinics.net/lists/cgroups/msg20720.html
> > [4] https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/sche=
duler
> > [5] https://kubernetes.io/docs/tasks/manage-gpus/scheduling-gpus/
> > [6] https://blog.openshift.com/gpu-accelerated-sql-queries-with-postgre=
sql-pg-strom-in-openshift-3-10/
> > [7] https://github.com/RadeonOpenCompute/k8s-device-plugin
> > [8] https://github.com/kubernetes/kubernetes/issues/52757
> >
> > Kenny Ho (5):
> >    cgroup: Introduce cgroup for drm subsystem
> >    cgroup: Add mechanism to register DRM devices
> >    drm/amdgpu: Register AMD devices for DRM cgroup
> >    drm, cgroup: Add total GEM buffer allocation limit
> >    drm, cgroup: Add peak GEM buffer allocation limit
> >
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |   4 +
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |   4 +
> >   drivers/gpu/drm/drm_gem.c                  |   7 +
> >   drivers/gpu/drm/drm_prime.c                |   9 +
> >   include/drm/drm_cgroup.h                   |  54 +++
> >   include/drm/drm_gem.h                      |  11 +
> >   include/linux/cgroup_drm.h                 |  47 ++
> >   include/linux/cgroup_subsys.h              |   4 +
> >   init/Kconfig                               |   5 +
> >   kernel/cgroup/Makefile                     |   1 +
> >   kernel/cgroup/drm.c                        | 497 ++++++++++++++++++++=
+
> >   11 files changed, 643 insertions(+)
> >   create mode 100644 include/drm/drm_cgroup.h
> >   create mode 100644 include/linux/cgroup_drm.h
> >   create mode 100644 kernel/cgroup/drm.c
> >
>

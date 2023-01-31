Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310A46836CF
	for <lists+cgroups@lfdr.de>; Tue, 31 Jan 2023 20:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjAaTuE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 Jan 2023 14:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjAaTuD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 Jan 2023 14:50:03 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A711018B0A
        for <cgroups@vger.kernel.org>; Tue, 31 Jan 2023 11:50:00 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id bk15so44875054ejb.9
        for <cgroups@vger.kernel.org>; Tue, 31 Jan 2023 11:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gBGYSHhxIz39bWAegoggfzJ6ks2CGggvwHv6lw1lI78=;
        b=j+D8hqiIH8+0MHEgypl/+feUSt1xb9I4p44epkjKOGrtZCbmzJpfq0vEEe9dimZZau
         kceU273RfoWQlTCrCqXG3zlBYya9fH3W5qskHtSh1WsHIWMEwvrR8OCQCIC/OzRpzbHz
         qijkEebgtWzYDmlwg4BtVyfwpNWhTAx6qkmVu2Oo0JwVPwZJKTCCsBB+s+hUi0ihKmCq
         Ios8NnaF3PeUQNEYLrm03TZw2T/lel7fUC0TAyU7sDgeAmnIQYuxWpqgFvF0EG1MBXj8
         TU8NhYgga/8N758Tk/jmeirtaqmG4gbyaK8lmyb2SA/5dtq3HV6DOUHDX91VqroXe0qA
         eF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gBGYSHhxIz39bWAegoggfzJ6ks2CGggvwHv6lw1lI78=;
        b=RniNfxU1RGXvfw8ti8jKugnQ+tY71UkGOeKoiuzKGBppfsXYCMlcTeDh31iQDAG9sG
         DZOGzsOqTimB12S7uAesQxwHhoZL99NOqgfBG5EulRJ2v2Ey/hnLB31MdqhgFjsnJsHz
         7JHratlIhnwkcv935YvmzOSjyiXdWTpB5yK7xv/CAMiSCUyvFIgFChay22mt7FmK9KaO
         QeVjtMxXT7wUV53i3HcogLegcVUs+e+mfUseJI9+jPQ8U1TIz0K1NXJcV1IMEZbY20a3
         Vz7XdBSrTW6w+2Py1AsLLdhtbKidaWCKeyWW15RvztTo6DN9f5J/x44NowVxfRAnoEK3
         hDyw==
X-Gm-Message-State: AFqh2krd/tSffLpP0mMwlr+2EA/al46Yv+PNukbAST5gEwZs2t5kxDBy
        qxYQLA32JLycGXmS0pAsvGGS9UZvgKN4C+DBtO5Uy0+rDfau0VuR
X-Google-Smtp-Source: AMrXdXtlD2H62LuEgeMz9hIErCWgvd2CYQ+BQJFo3dbnKHljO0E+6b0SAW0EkxZKbHKcQ+AjVM17kUdIdLR3DbZEBec=
X-Received: by 2002:a17:906:6049:b0:84d:457b:b987 with SMTP id
 p9-20020a170906604900b0084d457bb987mr8544970ejj.161.1675194598847; Tue, 31
 Jan 2023 11:49:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
 <CAJD7tkavoSu9WOnw4Nbxz41nq+Rm6Sq5EeOjh3CTyA=AT5=ujg@mail.gmail.com>
 <874js7zf38.fsf@nvidia.com> <CAJD7tkZTvXjoNZYC99yekbA0zHkD4iFj0J3+8dsOMht6rxrRcQ@mail.gmail.com>
 <87r0vblzf3.fsf@nvidia.com>
In-Reply-To: <87r0vblzf3.fsf@nvidia.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 31 Jan 2023 11:49:22 -0800
Message-ID: <CAJD7tkZcZ2mzEAv5x5TQk8of9A7w2p_fY3dGJAM29sXPvS7_RA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/19] mm: Introduce a cgroup to limit the amount of
 locked and pinned memory
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, jgg@nvidia.com, jhubbard@nvidia.com,
        tjmercier@google.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 31, 2023 at 3:24 AM Alistair Popple <apopple@nvidia.com> wrote:
>
>
> Yosry Ahmed <yosryahmed@google.com> writes:
>
> > On Mon, Jan 30, 2023 at 5:07 PM Alistair Popple <apopple@nvidia.com> wrote:
> >>
> >>
> >> Yosry Ahmed <yosryahmed@google.com> writes:
> >>
> >> > On Mon, Jan 23, 2023 at 9:43 PM Alistair Popple <apopple@nvidia.com> wrote:
> >> >>
> >> >> Having large amounts of unmovable or unreclaimable memory in a system
> >> >> can lead to system instability due to increasing the likelihood of
> >> >> encountering out-of-memory conditions. Therefore it is desirable to
> >> >> limit the amount of memory users can lock or pin.
> >> >>
> >> >> From userspace such limits can be enforced by setting
> >> >> RLIMIT_MEMLOCK. However there is no standard method that drivers and
> >> >> other in-kernel users can use to check and enforce this limit.
> >> >>
> >> >> This has lead to a large number of inconsistencies in how limits are
> >> >> enforced. For example some drivers will use mm->locked_mm while others
> >> >> will use mm->pinned_mm or user->locked_mm. It is therefore possible to
> >> >> have up to three times RLIMIT_MEMLOCKED pinned.
> >> >>
> >> >> Having pinned memory limited per-task also makes it easy for users to
> >> >> exceed the limit. For example drivers that pin memory with
> >> >> pin_user_pages() it tends to remain pinned after fork. To deal with
> >> >> this and other issues this series introduces a cgroup for tracking and
> >> >> limiting the number of pages pinned or locked by tasks in the group.
> >> >>
> >> >> However the existing behaviour with regards to the rlimit needs to be
> >> >> maintained. Therefore the lesser of the two limits is
> >> >> enforced. Furthermore having CAP_IPC_LOCK usually bypasses the rlimit,
> >> >> but this bypass is not allowed for the cgroup.
> >> >>
> >> >> The first part of this series converts existing drivers which
> >> >> open-code the use of locked_mm/pinned_mm over to a common interface
> >> >> which manages the refcounts of the associated task/mm/user
> >> >> structs. This ensures accounting of pages is consistent and makes it
> >> >> easier to add charging of the cgroup.
> >> >>
> >> >> The second part of the series adds the cgroup and converts core mm
> >> >> code such as mlock over to charging the cgroup before finally
> >> >> introducing some selftests.
> >> >
> >> >
> >> > I didn't go through the entire series, so apologies if this was
> >> > mentioned somewhere, but do you mind elaborating on why this is added
> >> > as a separate cgroup controller rather than an extension of the memory
> >> > cgroup controller?
> >>
> >> One of my early prototypes actually did add this to the memcg
> >> controller. However pinned pages fall under their own limit, and we
> >> wanted to always account pages to the cgroup of the task using the
> >> driver rather than say folio_memcg(). So adding it to memcg didn't seem
> >> to have much benefit as we didn't end up using any of the infrastructure
> >> provided by memcg. Hence I thought it was clearer to just add it as it's
> >> own controller.
> >
> > To clarify, you account and limit pinned memory based on the cgroup of
> > the process pinning the pages, not based on the cgroup that the pages
> > are actually charged to? Is my understanding correct?
>
> That's correct.

Interesting.

>
> > IOW, you limit the amount of memory that processes in a cgroup can
> > pin, not the amount of memory charged to a cgroup that can be pinned?
>
> Right, that's a good clarification which I might steal and add to the
> cover letter.

Feel free to :)

Please also clarify this in the code/docs. Glancing through the
patches I was asking myself multiple times why this is not
"memory.pinned.[current/max]" or similar.

>
> >>
> >>  - Alistair
> >>
> >> >>
> >> >>
> >> >> As I don't have access to systems with all the various devices I
> >> >> haven't been able to test all driver changes. Any help there would be
> >> >> appreciated.
> >> >>
> >> >> Alistair Popple (19):
> >> >>   mm: Introduce vm_account
> >> >>   drivers/vhost: Convert to use vm_account
> >> >>   drivers/vdpa: Convert vdpa to use the new vm_structure
> >> >>   infiniband/umem: Convert to use vm_account
> >> >>   RMDA/siw: Convert to use vm_account
> >> >>   RDMA/usnic: convert to use vm_account
> >> >>   vfio/type1: Charge pinned pages to pinned_vm instead of locked_vm
> >> >>   vfio/spapr_tce: Convert accounting to pinned_vm
> >> >>   io_uring: convert to use vm_account
> >> >>   net: skb: Switch to using vm_account
> >> >>   xdp: convert to use vm_account
> >> >>   kvm/book3s_64_vio: Convert account_locked_vm() to vm_account_pinned()
> >> >>   fpga: dfl: afu: convert to use vm_account
> >> >>   mm: Introduce a cgroup for pinned memory
> >> >>   mm/util: Extend vm_account to charge pages against the pin cgroup
> >> >>   mm/util: Refactor account_locked_vm
> >> >>   mm: Convert mmap and mlock to use account_locked_vm
> >> >>   mm/mmap: Charge locked memory to pins cgroup
> >> >>   selftests/vm: Add pins-cgroup selftest for mlock/mmap
> >> >>
> >> >>  MAINTAINERS                              |   8 +-
> >> >>  arch/powerpc/kvm/book3s_64_vio.c         |  10 +-
> >> >>  arch/powerpc/mm/book3s64/iommu_api.c     |  29 +--
> >> >>  drivers/fpga/dfl-afu-dma-region.c        |  11 +-
> >> >>  drivers/fpga/dfl-afu.h                   |   1 +-
> >> >>  drivers/infiniband/core/umem.c           |  16 +-
> >> >>  drivers/infiniband/core/umem_odp.c       |   6 +-
> >> >>  drivers/infiniband/hw/usnic/usnic_uiom.c |  13 +-
> >> >>  drivers/infiniband/hw/usnic/usnic_uiom.h |   1 +-
> >> >>  drivers/infiniband/sw/siw/siw.h          |   2 +-
> >> >>  drivers/infiniband/sw/siw/siw_mem.c      |  20 +--
> >> >>  drivers/infiniband/sw/siw/siw_verbs.c    |  15 +-
> >> >>  drivers/vdpa/vdpa_user/vduse_dev.c       |  20 +--
> >> >>  drivers/vfio/vfio_iommu_spapr_tce.c      |  15 +-
> >> >>  drivers/vfio/vfio_iommu_type1.c          |  59 +----
> >> >>  drivers/vhost/vdpa.c                     |   9 +-
> >> >>  drivers/vhost/vhost.c                    |   2 +-
> >> >>  drivers/vhost/vhost.h                    |   1 +-
> >> >>  include/linux/cgroup.h                   |  20 ++-
> >> >>  include/linux/cgroup_subsys.h            |   4 +-
> >> >>  include/linux/io_uring_types.h           |   3 +-
> >> >>  include/linux/kvm_host.h                 |   1 +-
> >> >>  include/linux/mm.h                       |   5 +-
> >> >>  include/linux/mm_types.h                 |  88 ++++++++-
> >> >>  include/linux/skbuff.h                   |   6 +-
> >> >>  include/net/sock.h                       |   2 +-
> >> >>  include/net/xdp_sock.h                   |   2 +-
> >> >>  include/rdma/ib_umem.h                   |   1 +-
> >> >>  io_uring/io_uring.c                      |  20 +--
> >> >>  io_uring/notif.c                         |   4 +-
> >> >>  io_uring/notif.h                         |  10 +-
> >> >>  io_uring/rsrc.c                          |  38 +---
> >> >>  io_uring/rsrc.h                          |   9 +-
> >> >>  mm/Kconfig                               |  11 +-
> >> >>  mm/Makefile                              |   1 +-
> >> >>  mm/internal.h                            |   2 +-
> >> >>  mm/mlock.c                               |  76 +------
> >> >>  mm/mmap.c                                |  76 +++----
> >> >>  mm/mremap.c                              |  54 +++--
> >> >>  mm/pins_cgroup.c                         | 273 ++++++++++++++++++++++++-
> >> >>  mm/secretmem.c                           |   6 +-
> >> >>  mm/util.c                                | 196 +++++++++++++++--
> >> >>  net/core/skbuff.c                        |  47 +---
> >> >>  net/rds/message.c                        |   9 +-
> >> >>  net/xdp/xdp_umem.c                       |  38 +--
> >> >>  tools/testing/selftests/vm/Makefile      |   1 +-
> >> >>  tools/testing/selftests/vm/pins-cgroup.c | 271 ++++++++++++++++++++++++-
> >> >>  virt/kvm/kvm_main.c                      |   3 +-
> >> >>  48 files changed, 1114 insertions(+), 401 deletions(-)
> >> >>  create mode 100644 mm/pins_cgroup.c
> >> >>  create mode 100644 tools/testing/selftests/vm/pins-cgroup.c
> >> >>
> >> >> base-commit: 2241ab53cbb5cdb08a6b2d4688feb13971058f65
> >> >> --
> >> >> git-series 0.9.1
> >> >>
> >>
>

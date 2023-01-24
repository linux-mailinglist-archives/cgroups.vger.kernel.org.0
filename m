Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F12667A11B
	for <lists+cgroups@lfdr.de>; Tue, 24 Jan 2023 19:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbjAXS1b (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Jan 2023 13:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjAXS1a (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Jan 2023 13:27:30 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F98142DD1
        for <cgroups@vger.kernel.org>; Tue, 24 Jan 2023 10:27:29 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id bk15so41335810ejb.9
        for <cgroups@vger.kernel.org>; Tue, 24 Jan 2023 10:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RIwygwRM9tzobh7QaVo0cnmbFvKeH50XulwOSqSD844=;
        b=cBbJb/Nx3OmOGYqdI8Yo1XttKVQwMvETRTZnmA/yBdPsHIR2qt4/Iv5TghMNeWcf7g
         3NwPmcWCiVrWVMIFPwvpqPx777Yo9B1ExCJfTWMFeKrUQllNjdvxr0DdCrlBzyrV0gov
         T7fZd0SmjzqKN8Jz/z4d6G+zYENz5OUYmVrXV2gxXpGfvL2OHf5b+orFKoR9hII5TC11
         uHTu8Shf5tqIRjjT4iaN2O23SRGB5uf9WaYPy4t4ihT2foBPhFAGS9TDdMbZxzUEywuo
         RGHCjr7/DDLcUoFp0xwsRRdmX81H2m/F8AKB5c/eM0Z+e0GoeLC9zauUJ/knC5ZVdtwt
         hM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RIwygwRM9tzobh7QaVo0cnmbFvKeH50XulwOSqSD844=;
        b=EMe5ku4KeyN+QJ0K6PEa9+T2dlodyXI3e0XaepqsdQa82Yirh57nwBcZlxHQEw8CGs
         j0TCjJroVAxvGQiqt3JWTwzLY2K9lHiwSEjDJ31QIXc79K7T9xq/4y2ktdPvMfPekpzZ
         1jawpJWdyehuJhe36PfSFBbCox7cUSTXP6rF1COOz+9dchMUm/kpfPnqkVlWK/FprAFk
         kJ2Sg825JfFGMVIMN72ECz39Rbbz6JO2+bSZS30vC36My5Dp1E1xVkGmi6CWDhVR1sui
         5HO72p/Aq0MhBcDkM6+odVRJn7Txp4Qjr7nrc8NBu294rBIT2gayPcxMjDqfFKCvL+Yu
         cpKA==
X-Gm-Message-State: AFqh2kpt0Y9YzMcbtLy9IDIBXqsR3aSY4pOsAKH5LnxULYw3pR1wkx1l
        e1JoCIXL+dsb2ZSOrg/JQzfwgh2HrrPcoKI52UTYRj6fXTPH+glR
X-Google-Smtp-Source: AMrXdXsu4OXpseg7nR0i1smFRE12hMtFwaOjRfzoI8Hv61dk6zz58TcLoy62SrgqOS77rNtGXfXSXi9UZI+OwNj5rx4=
X-Received: by 2002:a17:906:3487:b0:861:7caf:c252 with SMTP id
 g7-20020a170906348700b008617cafc252mr3272304ejb.212.1674584847639; Tue, 24
 Jan 2023 10:27:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
In-Reply-To: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 24 Jan 2023 10:26:49 -0800
Message-ID: <CAJD7tkavoSu9WOnw4Nbxz41nq+Rm6Sq5EeOjh3CTyA=AT5=ujg@mail.gmail.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jan 23, 2023 at 9:43 PM Alistair Popple <apopple@nvidia.com> wrote:
>
> Having large amounts of unmovable or unreclaimable memory in a system
> can lead to system instability due to increasing the likelihood of
> encountering out-of-memory conditions. Therefore it is desirable to
> limit the amount of memory users can lock or pin.
>
> From userspace such limits can be enforced by setting
> RLIMIT_MEMLOCK. However there is no standard method that drivers and
> other in-kernel users can use to check and enforce this limit.
>
> This has lead to a large number of inconsistencies in how limits are
> enforced. For example some drivers will use mm->locked_mm while others
> will use mm->pinned_mm or user->locked_mm. It is therefore possible to
> have up to three times RLIMIT_MEMLOCKED pinned.
>
> Having pinned memory limited per-task also makes it easy for users to
> exceed the limit. For example drivers that pin memory with
> pin_user_pages() it tends to remain pinned after fork. To deal with
> this and other issues this series introduces a cgroup for tracking and
> limiting the number of pages pinned or locked by tasks in the group.
>
> However the existing behaviour with regards to the rlimit needs to be
> maintained. Therefore the lesser of the two limits is
> enforced. Furthermore having CAP_IPC_LOCK usually bypasses the rlimit,
> but this bypass is not allowed for the cgroup.
>
> The first part of this series converts existing drivers which
> open-code the use of locked_mm/pinned_mm over to a common interface
> which manages the refcounts of the associated task/mm/user
> structs. This ensures accounting of pages is consistent and makes it
> easier to add charging of the cgroup.
>
> The second part of the series adds the cgroup and converts core mm
> code such as mlock over to charging the cgroup before finally
> introducing some selftests.


I didn't go through the entire series, so apologies if this was
mentioned somewhere, but do you mind elaborating on why this is added
as a separate cgroup controller rather than an extension of the memory
cgroup controller?

>
>
> As I don't have access to systems with all the various devices I
> haven't been able to test all driver changes. Any help there would be
> appreciated.
>
> Alistair Popple (19):
>   mm: Introduce vm_account
>   drivers/vhost: Convert to use vm_account
>   drivers/vdpa: Convert vdpa to use the new vm_structure
>   infiniband/umem: Convert to use vm_account
>   RMDA/siw: Convert to use vm_account
>   RDMA/usnic: convert to use vm_account
>   vfio/type1: Charge pinned pages to pinned_vm instead of locked_vm
>   vfio/spapr_tce: Convert accounting to pinned_vm
>   io_uring: convert to use vm_account
>   net: skb: Switch to using vm_account
>   xdp: convert to use vm_account
>   kvm/book3s_64_vio: Convert account_locked_vm() to vm_account_pinned()
>   fpga: dfl: afu: convert to use vm_account
>   mm: Introduce a cgroup for pinned memory
>   mm/util: Extend vm_account to charge pages against the pin cgroup
>   mm/util: Refactor account_locked_vm
>   mm: Convert mmap and mlock to use account_locked_vm
>   mm/mmap: Charge locked memory to pins cgroup
>   selftests/vm: Add pins-cgroup selftest for mlock/mmap
>
>  MAINTAINERS                              |   8 +-
>  arch/powerpc/kvm/book3s_64_vio.c         |  10 +-
>  arch/powerpc/mm/book3s64/iommu_api.c     |  29 +--
>  drivers/fpga/dfl-afu-dma-region.c        |  11 +-
>  drivers/fpga/dfl-afu.h                   |   1 +-
>  drivers/infiniband/core/umem.c           |  16 +-
>  drivers/infiniband/core/umem_odp.c       |   6 +-
>  drivers/infiniband/hw/usnic/usnic_uiom.c |  13 +-
>  drivers/infiniband/hw/usnic/usnic_uiom.h |   1 +-
>  drivers/infiniband/sw/siw/siw.h          |   2 +-
>  drivers/infiniband/sw/siw/siw_mem.c      |  20 +--
>  drivers/infiniband/sw/siw/siw_verbs.c    |  15 +-
>  drivers/vdpa/vdpa_user/vduse_dev.c       |  20 +--
>  drivers/vfio/vfio_iommu_spapr_tce.c      |  15 +-
>  drivers/vfio/vfio_iommu_type1.c          |  59 +----
>  drivers/vhost/vdpa.c                     |   9 +-
>  drivers/vhost/vhost.c                    |   2 +-
>  drivers/vhost/vhost.h                    |   1 +-
>  include/linux/cgroup.h                   |  20 ++-
>  include/linux/cgroup_subsys.h            |   4 +-
>  include/linux/io_uring_types.h           |   3 +-
>  include/linux/kvm_host.h                 |   1 +-
>  include/linux/mm.h                       |   5 +-
>  include/linux/mm_types.h                 |  88 ++++++++-
>  include/linux/skbuff.h                   |   6 +-
>  include/net/sock.h                       |   2 +-
>  include/net/xdp_sock.h                   |   2 +-
>  include/rdma/ib_umem.h                   |   1 +-
>  io_uring/io_uring.c                      |  20 +--
>  io_uring/notif.c                         |   4 +-
>  io_uring/notif.h                         |  10 +-
>  io_uring/rsrc.c                          |  38 +---
>  io_uring/rsrc.h                          |   9 +-
>  mm/Kconfig                               |  11 +-
>  mm/Makefile                              |   1 +-
>  mm/internal.h                            |   2 +-
>  mm/mlock.c                               |  76 +------
>  mm/mmap.c                                |  76 +++----
>  mm/mremap.c                              |  54 +++--
>  mm/pins_cgroup.c                         | 273 ++++++++++++++++++++++++-
>  mm/secretmem.c                           |   6 +-
>  mm/util.c                                | 196 +++++++++++++++--
>  net/core/skbuff.c                        |  47 +---
>  net/rds/message.c                        |   9 +-
>  net/xdp/xdp_umem.c                       |  38 +--
>  tools/testing/selftests/vm/Makefile      |   1 +-
>  tools/testing/selftests/vm/pins-cgroup.c | 271 ++++++++++++++++++++++++-
>  virt/kvm/kvm_main.c                      |   3 +-
>  48 files changed, 1114 insertions(+), 401 deletions(-)
>  create mode 100644 mm/pins_cgroup.c
>  create mode 100644 tools/testing/selftests/vm/pins-cgroup.c
>
> base-commit: 2241ab53cbb5cdb08a6b2d4688feb13971058f65
> --
> git-series 0.9.1
>

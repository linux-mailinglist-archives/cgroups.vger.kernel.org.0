Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C84B4BC024
	for <lists+cgroups@lfdr.de>; Fri, 18 Feb 2022 20:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236603AbiBRTNP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 18 Feb 2022 14:13:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235431AbiBRTNO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 18 Feb 2022 14:13:14 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886CB4CD7D
        for <cgroups@vger.kernel.org>; Fri, 18 Feb 2022 11:12:57 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id s24so10689248edr.5
        for <cgroups@vger.kernel.org>; Fri, 18 Feb 2022 11:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kFx5mVaEHwZpR1G+osdopjqc+OzJyT2vvM3+pSprCFk=;
        b=EQ+kstcsfvyoiVxpZH4DOveKWuo8ZLZzYUIop0Vlthf3r2DTADG1kDnjLZlmhEiEk+
         6G1pQYgdE0Nh9wv/F/mr614cojFdmQRp2bm+wGYz7pZOcacHQguC10UzY7EM+1ffc44f
         Wm1l5TaMSkrezOOuca+rkd439a22duxj7f/9y8nVcQJWPTcyz8zTDf/7iz5H+ApzRhTQ
         NbqGdRr/U/H9RUKkTlGKY86fsffbY3C0Y3yyKrxlpGI6ol/qaBZxmLnCbHD8+AclEyv0
         7/rPTsF6rq9ujxffbMlZt2i1zvBQfzL4TUlU49jq+ZYhmHm7rxl9MwWPEqQDFslXytJ8
         Gf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kFx5mVaEHwZpR1G+osdopjqc+OzJyT2vvM3+pSprCFk=;
        b=SraRyK5zWrEwYgxFpAGZO7EYV9XKD+BtSXqNrWEe5PxCEz3Xkj+FhSByLCbu9y0LP+
         o1PCEm6sV4pVcMwZ6FVqqKbuztWTbeQ2Z+U8+GFFG+GBRIkH/dsFO7ehGfZ1Z5YUHeTD
         +HcbkG4WK9a8hkhcr2qIvajzm5Mkpx0P1DHM6Wic9RQzAjcKoYBvSsAnMUzI2Dug6aQz
         +pfXKAhBkw2eYMyDHzDsqYXoy2i8uHCr+W62l7axEo9cdQ5fzN01tJrB8JcCgaS1gofy
         nHnqZdm958hlZBHNTTk//wroxmsj3ovFIdr1r240KDSdo2zdlHvkPqOX9FYqsFZGVKTu
         gilw==
X-Gm-Message-State: AOAM533MpHcbfRYdVkrzQekE16goTlxDDuTc25tOVINi1AkLyLqaj2y/
        pRBkmtf1DTagb8tXGnp1cD/fhWa9rwaHKEZlcAXrng==
X-Google-Smtp-Source: ABdhPJx3RFzhIbi2OeHNvwEo2c7s9U+9friyhOB0W2+wJsBDRyonLy4N3OFnI5CX3I+UAblAArNaJNvZqMIqINE8LuU=
X-Received: by 2002:aa7:c0d0:0:b0:410:d576:8808 with SMTP id
 j16-20020aa7c0d0000000b00410d5768808mr9831902edp.340.1645211575981; Fri, 18
 Feb 2022 11:12:55 -0800 (PST)
MIME-Version: 1.0
References: <20220211161831.3493782-1-tjmercier@google.com>
In-Reply-To: <20220211161831.3493782-1-tjmercier@google.com>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Fri, 18 Feb 2022 11:12:44 -0800
Message-ID: <CABdmKX3qO7UW-HGXMdZZdVi1P8FnKDh0H=TGT_ct=tHoAeVxbw@mail.gmail.com>
Subject: Re: [RFC v2 0/6] Proposal for a GPU cgroup controller
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Kalesh Singh <kaleshsingh@google.com>, Kenny.Ho@amd.com,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 11, 2022 at 8:18 AM T.J. Mercier <tjmercier@google.com> wrote:
>
> This patch series revisits the proposal for a GPU cgroup controller to
> track and limit memory allocations by various device/allocator
> subsystems. The patch series also contains a simple prototype to
> illustrate how Android intends to implement DMA-BUF allocator
> attribution using the GPU cgroup controller. The prototype does not
> include resource limit enforcements.
>
> Changelog:
>
> v2:
> See the previous revision of this change submitted by Hridya Valsaraju
> at: https://lore.kernel.org/all/20220115010622.3185921-1-hridya@google.co=
m/
>
> Move dma-buf cgroup charge transfer from a dma_buf_op defined by every
> heap to a single dma-buf function for all heaps per Daniel Vetter and
> Christian K=C3=B6nig. Pointers to struct gpucg and struct gpucg_device
> tracking the current associations were added to the dma_buf struct to
> achieve this.
>
> Fix incorrect Kconfig help section indentation per Randy Dunlap.
>
> History of the GPU cgroup controller
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> The GPU/DRM cgroup controller came into being when a consensus[1]
> was reached that the resources it tracked were unsuitable to be integrate=
d
> into memcg. Originally, the proposed controller was specific to the DRM
> subsystem and was intended to track GEM buffers and GPU-specific
> resources[2]. In order to help establish a unified memory accounting mode=
l
> for all GPU and all related subsystems, Daniel Vetter put forth a
> suggestion to move it out of the DRM subsystem so that it can be used by
> other DMA-BUF exporters as well[3]. This RFC proposes an interface that
> does the same.
>
> [1]: https://patchwork.kernel.org/project/dri-devel/cover/20190501140438.=
9506-1-brian.welty@intel.com/#22624705
> [2]: https://lore.kernel.org/amd-gfx/20210126214626.16260-1-brian.welty@i=
ntel.com/
> [3]: https://lore.kernel.org/amd-gfx/YCVOl8%2F87bqRSQei@phenom.ffwll.loca=
l/
>
> T.J. Mercier (6):
>   gpu: rfc: Proposal for a GPU cgroup controller
>   cgroup: gpu: Add a cgroup controller for allocator attribution of GPU
>     memory
>   dmabuf: Use the GPU cgroup charge/uncharge APIs
>   dmabuf: heaps: export system_heap buffers with GPU cgroup charging
>   dmabuf: Add gpu cgroup charge transfer function
>   android: binder: Add a buffer flag to relinquish ownership of fds
>
>  Documentation/gpu/rfc/gpu-cgroup.rst | 195 +++++++++++++++++
>  Documentation/gpu/rfc/index.rst      |   4 +
>  drivers/android/binder.c             |  26 +++
>  drivers/dma-buf/dma-buf.c            | 100 +++++++++
>  drivers/dma-buf/dma-heap.c           |  27 +++
>  drivers/dma-buf/heaps/system_heap.c  |   3 +
>  include/linux/cgroup_gpu.h           | 127 +++++++++++
>  include/linux/cgroup_subsys.h        |   4 +
>  include/linux/dma-buf.h              |  22 +-
>  include/linux/dma-heap.h             |  11 +
>  include/uapi/linux/android/binder.h  |   1 +
>  init/Kconfig                         |   7 +
>  kernel/cgroup/Makefile               |   1 +
>  kernel/cgroup/gpu.c                  | 304 +++++++++++++++++++++++++++
>  14 files changed, 830 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/gpu/rfc/gpu-cgroup.rst
>  create mode 100644 include/linux/cgroup_gpu.h
>  create mode 100644 kernel/cgroup/gpu.c
>
> --
> 2.35.1.265.g69c8d7142f-goog
>

Gentle nudge to GPU maintainers to please provide their feedback on
this RFC. Thanks!

